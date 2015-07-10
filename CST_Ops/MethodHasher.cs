using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;

namespace CST
{
    public class MethodRecord : IEquatable<MethodRecord>
    {
        public string namespaceN
        {
            get;
            set;
        }
        public string className
        {
            get;
            set;
        }
        public string methodName
        {
            get;
            set;
        }
        public string argTypeNS
        {
            get;
            set;
        }
        public string argType
        {
            get;
            set;
        }
        public string returnTypeNS
        {
            get;
            set;
        }
        public string returnType
        {
            get;
            set;
        }

        public string SHA_of_DLL
        {
            get;
            set;
        }
        
        private string SHA_of_record;
        private SHA1 sha = new SHA1CryptoServiceProvider();

        public MethodRecord(string nameSpaceN, string className, string methodName, string argTypeNS, string argType, string returnTypeNS, string returnType, string SHA_of_DLL)
        {
            this.namespaceN = nameSpaceN;
            this.className = className;
            this.methodName = methodName;
            this.argType = argType;
            this.returnType = returnType;
            this.SHA_of_DLL = SHA_of_DLL;
            this.returnTypeNS = returnTypeNS;
            this.argTypeNS = argTypeNS;
        }

        public override int GetHashCode()
        {
            return Convert.ToInt32(SHA_of_DLL);
        }

        public MethodRecord()
        { }

        public string getSHA()
        {
            if (SHA_of_record != null) return SHA_of_record;

            StringBuilder sb = new StringBuilder();

            sb.Append(SHA_of_DLL + "\n");
            sb.Append(returnTypeNS + "." + returnType + " " + namespaceN + "." + className + " " + methodName + "(");

            sb.Append(argTypeNS + "." + argType + "");

            sb.Append(")\n");

            byte[] recordBytes = new byte[sb.Length * sizeof(char)];

            System.Buffer.BlockCopy(sb.ToString().ToCharArray(), 0, recordBytes, 0, recordBytes.Length);

            byte[] result = sha.ComputeHash(recordBytes);

            SHA_of_record = BitConverter.ToString(result).Replace("-", string.Empty);

            SHA_of_record = className + "." + methodName + "." + SHA_of_record; 

            return SHA_of_record;
        }

        public override string ToString()
        {
            StringBuilder sb = new StringBuilder();

            sb.Append(SHA_of_record + "\n");
            sb.Append(SHA_of_DLL + "\n");
            sb.Append(returnTypeNS + "." + returnType + " " + namespaceN + "." + className + " " + methodName + "(");

            sb.Append(argTypeNS + "." + argType + "");

            sb.Append(")\n");

            return sb.ToString();
        }

        public string getMethod()
        {
            StringBuilder sb = new StringBuilder();

            sb.Append(returnType + " " + className + " " + methodName + "(");

            sb.Append(argType + "");

            sb.Append(")\n");
            return sb.ToString();
        }

        public override bool Equals(object obj)
        {
            if (obj == null) return false;
            MethodRecord mr = obj as MethodRecord;

            if (mr == null) return false;

            return Equals(mr);
        }

        public bool Equals(MethodRecord mr)
        {
            if (mr == null) return false;

            return (SHA_of_record == mr.getSHA());
        }
    }

    public class MethodHasher
    {
        public static string CSTFolder = @"C:\CST";
        private static string methodsFolderName = "methods";
        private static string dllFolderName = "dlls";
        public static string methodsFolder = CSTFolder + @"\" + methodsFolderName + @"\";
        public static string dllsFolder = CSTFolder + @"\" + dllFolderName;

        static MethodHasher()
        {
            Configuration webConfig = WebConfigurationManager.OpenWebConfiguration(System.Web.HttpContext.Current.Request.ApplicationPath);

            if (webConfig.AppSettings.Settings.Count > 0)
            {
                KeyValueConfigurationElement customSetting =
                    webConfig.AppSettings.Settings["CSTFolderPath"];
                if (customSetting != null) {
                    CSTFolder = customSetting.Value;
                }
                else
                {
                    CSTFolder = @"C:\CST";
                }
            }

            methodsFolder = CSTFolder + @"\" + methodsFolderName;
            dllsFolder = CSTFolder + @"\" + dllFolderName;
        }

        public static void saveMethod(MethodRecord mr) //string depPath, string dllPath)
        {
            if (!Directory.Exists(methodsFolder))
            {
                Directory.CreateDirectory(methodsFolder);
            }

            try
            {
                System.IO.StreamWriter file = new System.IO.StreamWriter(methodsFolder + @"\" + mr.getSHA() + ".txt");

                file.Write(mr.ToString());
                file.Close();
            }
            catch (IOException)
            {
            }
        }

        public static MethodRecord getMRFromFile(string mr_sha)
        {            
            DLLServerDownloader.downloadMethodRecord(mr_sha);

            string[] lines = System.IO.File.ReadAllLines(methodsFolder + "\\" + mr_sha + ".txt");
            string shaR = lines[0];
            string shaD = lines[1];

            string m = lines[2]; 

            string[] method = m.Split(new char[] { ' ', ')', '('});

            string[] tS = method[0].Split(new char[] { '.' }, StringSplitOptions.RemoveEmptyEntries);
  
            string returnN = tS[tS.Length - 1];
            string returnTypeNS = method[0].Substring(0, method[0].Length - returnN.Length - 1);

            string[] tS2 = method[1].Split(new char[] { '.' }, StringSplitOptions.RemoveEmptyEntries);

            string classN = tS2[tS2.Length - 1];
            string classNS = method[1].Substring(0, method[1].Length - classN.Length - 1);
            
            string methodN = method[2];

            string[] tS3 = method[3].Split(new char[] { '.' }, StringSplitOptions.RemoveEmptyEntries);

            string param = tS3[tS3.Length - 1];
            string paramNS = method[3].Substring(0, method[3].Length - param.Length - 1);


            MethodRecord mr = new MethodRecord(classNS, classN, methodN, paramNS, param, returnTypeNS, returnN, shaD);

            return mr;
        }

        public static List<MethodRecord> getDehashedRecords(ConcurrentDictionary<string, MethodRecord> methodSHADictKEYSHA, _CST_Struct msg)
        {
            List<MethodRecord> mrList = new List<MethodRecord>();
            string[] sha_methods = msg.SymT.Split(new char[] { ' ', '(', ')' }, StringSplitOptions.RemoveEmptyEntries);

            foreach (string method in sha_methods)
            {
                MethodRecord mr = null;
                if (!methodSHADictKEYSHA.ContainsKey(method))
                {
                    if (!File.Exists(methodsFolder + @"\" + method + ".txt"))
                    {
                        DLLServerDownloader.downloadMethodRecord(method);
                    }
                    mr = MethodHasher.getMRFromFile(method);
                }
                else
                {
                    mr = methodSHADictKEYSHA[method];
                }
                if (!Directory.Exists(dllsFolder + @"\" + mr.SHA_of_DLL))
                {

                    DLLServerDownloader.downloadDLLandDep(mr.SHA_of_DLL);
                }

                mrList.Add(mr);
            }

            return mrList;
        }

    }
}
