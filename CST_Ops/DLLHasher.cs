using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Security.Cryptography;
using System.Reflection;

namespace CST
{
    public class DLLHasher
    {
        public static string cstPath = @"C:\CST\";
        public static string dllsFolder = cstPath + @"dlls\";

        public static byte[] GenerateHash(string path, string name) //string depPath, string dllPath)
        {
            string depPath = path + @"\" + name + ".dep";
            string dllPath = path + @"\" + name + ".dll";
            FileStream depFS = null;
            FileStream dllFS = null;
            try
           {
                depFS = File.OpenRead(depPath);
                dllFS = File.OpenRead(dllPath);
                byte[] fileInByte = new byte[depFS.Length + dllFS.Length];
                byte[] fileIndllBytes = new byte[dllFS.Length];

                depFS.Read(fileInByte, 0, Convert.ToInt32(depFS.Length));
                dllFS.Read(fileIndllBytes, 0, Convert.ToInt32(dllFS.Length));

                string shaAttr = GetSHAFromDLLAttribute(dllPath);

                RemoveHashInDLLByte(fileIndllBytes, shaAttr);

                Buffer.BlockCopy(fileIndllBytes, 0, fileInByte, Convert.ToInt32(depFS.Length), Convert.ToInt32(dllFS.Length));

                byte[] result = new SHA1CryptoServiceProvider().ComputeHash(fileInByte);

                return result;
            }
            finally
            {
                if (depFS != null)
                {
                    depFS.Close();
                    depFS.Dispose();
                }
                if (dllFS != null)
                {
                    dllFS.Close();
                    dllFS.Dispose();
                }
            }
        }

        private static void RemoveHashInDLLByte(byte[] dllBytes, string sha)
        {
            byte[] curSHA = Encoding.Default.GetBytes(sha);

            for (int i = 0; i < dllBytes.Length; i++)
            {
                int j = i;

                for (; j - i < curSHA.Length && dllBytes[j] == curSHA[j - i]; j++) ;

                if (j == i + 40)
                {
                    for (int k = i; k < j; k++)
                        dllBytes[k] = 0x30;
                    break;
                }
            }
        }

        public static byte[] GenerateHash(byte[] fileInByte, byte[] fileIndllBytes) //string depPath, string dllPath)
        {
            byte[] fileOutByte = new byte[fileInByte.Length + fileIndllBytes.Length];

            string shaAttr = GetSHAFromRawDLLAttrByte(fileIndllBytes);

            RemoveHashInDLLByte(fileIndllBytes, shaAttr);

            Buffer.BlockCopy(fileInByte, 0, fileOutByte, 0, fileInByte.Length);
            Buffer.BlockCopy(fileIndllBytes, 0, fileOutByte, fileInByte.Length, fileIndllBytes.Length);

            byte[] result = new SHA1CryptoServiceProvider().ComputeHash(fileOutByte);

            return result;
        }

        private static object SHA1CryptoServiceProvider()
        {
            throw new NotImplementedException();
        }

        public static string GenerateHashInHexStr(string path, string name)
        {
            return BitConverter.ToString(GenerateHash(path, name)).Replace("-", string.Empty);
        }

        public class MyBoundaryObject : MarshalByRefObject
        {
            public void GetShaFromDLL(AppDomainArgs ada)
            {
                Assembly assembly = Assembly.ReflectionOnlyLoadFrom(ada.dll_path);

                GetSHA(ada, assembly);
            }

            public void GetSHA(AppDomainArgs ada, Assembly assembly)
            {
                IList<CustomAttributeData> descriptionAttrList = assembly.GetCustomAttributesData();

                foreach (CustomAttributeData a in descriptionAttrList)
                {
                    if (a.AttributeType.Equals(typeof(AssemblyDescriptionAttribute)))
                    {
                        string typeVal = a.ToString();
                        ada.sha = typeVal.Substring(typeof(AssemblyDescriptionAttribute).ToString().Length + 3, 40);
                        break;
                    }
                }

            }

            public void GetShaFromDLLByte(AppDomainArgs ada)
            {
                Assembly assembly = Assembly.ReflectionOnlyLoad(ada.dllB);

                GetSHA(ada, assembly);
            }
        }

        public class AppDomainArgs : MarshalByRefObject
        {
            public string dll_path { get; set; }
            public string sha { get; set; }
            public byte[] dllB { get; set; }

        }

        public static string GetSHAFromRawDLLAttrByte(byte[] dll)
        {
            string SHA = "0000000000000000000000000000000000000000";

            var appdomainSetup = new AppDomainSetup();

            appdomainSetup.CachePath = AppDomain.CurrentDomain.SetupInformation.CachePath;
            appdomainSetup.ApplicationBase = AppDomain.CurrentDomain.SetupInformation.ApplicationBase;

            AppDomain tempDomain = AppDomain.CreateDomain("TemporaryAppDomain", AppDomain.CurrentDomain.Evidence, AppDomain.CurrentDomain.SetupInformation);
            MyBoundaryObject boundary = (MyBoundaryObject)
              tempDomain.CreateInstanceAndUnwrap(
                 typeof(MyBoundaryObject).Assembly.FullName,
                 typeof(MyBoundaryObject).FullName);

            AppDomainArgs ada = new AppDomainArgs();
            ada.sha = SHA;
            ada.dllB = dll;
            boundary.GetShaFromDLLByte(ada);

            AppDomain.Unload(tempDomain);

            return ada.sha;

        }

        public static string GetSHAFromDLLAttribute(string dll_file_path)
        {
            string SHA = "0000000000000000000000000000000000000000";

            AppDomain tempDomain = AppDomain.CreateDomain("TemporaryAppDomain");
            MyBoundaryObject boundary = (MyBoundaryObject)
              tempDomain.CreateInstanceAndUnwrap(
                 typeof(MyBoundaryObject).Assembly.FullName,
                 typeof(MyBoundaryObject).FullName);

            AppDomainArgs ada = new AppDomainArgs();
            ada.dll_path = dll_file_path;
            ada.sha = SHA;
            boundary.GetShaFromDLL(ada);

            AppDomain.Unload(tempDomain);

            return ada.sha;
        }

        public static void CopyDLL(string generated_SHA, string path, string name) //string depPath, string dllPath)
        {
            if (!Directory.Exists(dllsFolder + @"\" + name + "." + generated_SHA))
            {
                Directory.CreateDirectory(dllsFolder + @"\" + name + "." + generated_SHA);
            }

            try
            {
                string depPath = path + @"\" + name + ".dep";
                string dllPath = path + @"\" + name + ".dll";
                string depFile = Path.GetFileName(depPath);
                string dllFile = Path.GetFileName(dllPath);

                if (File.Exists(depPath))
                {
                    File.Copy(depPath, dllsFolder + @"\" + name + "." + generated_SHA + @"\" + depFile, true);
                }
                if (File.Exists(dllPath))
                {
                    File.Copy(dllPath, dllsFolder + @"\" + name + "." + generated_SHA + @"\" + dllFile, true);
                }

            }
            catch (IOException ex)
            {
                Console.WriteLine("\nMessage ---\n{0}", ex.Message);
                Console.WriteLine("\nStackTrace ---\n{0}", ex.StackTrace);
            }
        }

        public static bool verifySHA1(string path, string name, string sha1)
        {
            string generatedSHA1 = GenerateHashInHexStr(path, name);

            if (generatedSHA1.Equals(sha1)) return true;

            return false;
        }

        public static string GenerateHashInHexStr(byte[] depFileData, byte[] dllFileData)
        {
            return BitConverter.ToString(GenerateHash(depFileData, dllFileData)).Replace("-", string.Empty);
        }

        public static void saveToCSTFolder(string depFileName, byte[] depFileData, string dllFileName, byte[] dllFileData, string sha)
        {
            string name = Path.GetFileNameWithoutExtension(depFileName);

            if (!Directory.Exists(dllsFolder + @"\" + name + "." + sha))
            {
                Directory.CreateDirectory(dllsFolder + @"\" + name + "." + sha);
            }

            try
            {
                var depFile = File.Create(dllsFolder + @"\" + name + "." + sha + @"\" + depFileName);
                var dllFile = File.Create(dllsFolder + @"\" + name + "." + sha + @"\" + dllFileName);

                depFile.Write(depFileData, 0, depFileData.Length);
                dllFile.Write(dllFileData, 0, dllFileData.Length);

                depFile.Close();
                dllFile.Close();
            }
            catch
            {
            }

        }

        static void Main(string[] args)
        {
            if (args.Length == 1)
            {
                string path = Path.GetFullPath(args[0]);
                string name = Path.GetFileName(args[0]);
                string generated_sha = DLLHasher.GenerateHashInHexStr(path, name);
                Console.WriteLine(generated_sha);

            }
        }
    }
}
