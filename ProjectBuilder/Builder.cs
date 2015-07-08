using CST;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Linq;
using System.Text.RegularExpressions;
using System.Reflection;

namespace ProjectBuilder
{
    class Builder
    {
        public static string builder_path = @"C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe";
        public static string projNameTag = "AssemblyName";
        public static string sha_default = "0000000000000000000000000000000000000000";
        private static XNamespace msbuild = "http://schemas.microsoft.com/developer/msbuild/2003";

        public static void Build(string build_file)
        {
            string build_cmd = builder_path + " \"" + build_file + "\"";

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/c " + build_cmd;
            process.StartInfo = startInfo;
            process.Start();
            process.WaitForExit();
        }

        public static void CreateDep(string name, List<string> dependsList)
        {
            StringBuilder sb = new StringBuilder();

            sb.Append("<References>\n");
            foreach (string dependency in dependsList) 
            {
                sb.Append("\t<Reference>\n");
                sb.Append("\t\t" + dependency + "\n");
                sb.Append("\t</Reference>\n");
            }

            sb.Append("</References>\n");

            string output = sb.ToString();
            string depFileName = name.Substring(0,name.Length-4) + ".dep";
            File.WriteAllText(depFileName, output);

        }

        public static List<string> GetReferenceFromCSPROJ(string build_file)
        {
            List<string> refList = new List<string>();

            XDocument projDefinition = XDocument.Load(build_file);
            IEnumerable<XElement> references = projDefinition
                .Element(msbuild + "Project")
                .Elements(msbuild + "ItemGroup")
                .Elements(msbuild + "Reference");

            foreach (XElement reference in references)
            {
                if (reference.Element(msbuild + "HintPath") != null)
                {
                    refList.Add(reference.Element(msbuild + "HintPath").Value);
                }
            }

            return refList;
        }

        public static string CreateDepForProj(string build_file, string output_path, string prj_name)
        {
            string[] fileEntries = Directory.GetFiles(output_path, "*.dll");
            string project_d = "";
            List<string> depDLLList = GetReferenceFromCSPROJ(build_file);
            IEnumerable<string> depPrjList = GetDependentPrjList(build_file);

            foreach (string fileEnt in fileEntries)
            {
                string name = Path.GetFileName(fileEnt);

                if (name.StartsWith(prj_name))
                {
                    project_d = fileEnt;
                    break;
                }
            }

            if (project_d.Length > 0) {
                foreach (string s in depPrjList)
                {
                    string depAssm = GetAssemblyName(Path.GetDirectoryName(build_file) + @"\" + s);

                    foreach (string fileEnt in fileEntries)
                    {
                        string shaFromDLL = GetSHAFromDLL(fileEnt);
                        string generatedSHA = DLLHasher.GenerateHashInHexStr(output_path, depAssm);

                        if (shaFromDLL.Equals(generatedSHA))
                        {
                            depDLLList.Add(@"C:\CST\dlls\" + shaFromDLL + @"\" + Path.GetFileName(fileEnt));
                        }
                    }
                }
                CreateDep(project_d, depDLLList);
                string proj_n = Path.GetFileName(project_d);
                string sha = DLLHasher.GenerateHashInHexStr(output_path, proj_n.Substring(0, proj_n.Length - 4));

                EditDLLASM(sha, project_d);
                DLLHasher.CopyDLL(sha, output_path, proj_n.Substring(0, proj_n.Length - 4));

                DLLServerConnector.uploadDllDep(project_d, project_d.Substring(0, project_d.Length - 4) + ".dep", sha);

                return sha;
            }
            return "";
        }

        public static string GetAssemblyName(string build_file)
        {
            XDocument projDefinition = XDocument.Load(build_file);
            IEnumerable<XElement> references = projDefinition
                .Element(msbuild + "Project")
                .Elements(msbuild + "PropertyGroup")
                .Elements(msbuild + "AssemblyName");
            
            foreach (XElement reference in references)
            {
                string assembly_name = reference.Value;

                return assembly_name;
            }
            return "";
        }

        public static void EditDllPath(string build_path, string parent_project, string sha)
        {
            string build_file = Directory.GetFiles(build_path, "*.csproj")[0];

            XDocument projDefinition = XDocument.Load(build_file);
            XElement reference = projDefinition
                .Element(msbuild + "Project")
                .Elements(msbuild + "ItemGroup")
                .Elements(msbuild + "Reference")
                .Where(x => x.Attribute("Include").Value.Split(',')[0].Equals(parent_project))
                .SingleOrDefault();

           if (reference != null)
           {
               XElement path = reference.Element(msbuild + "HintPath");
               path.SetValue("C:\\CST\\dlls\\" + sha + "\\" + parent_project + ".dll");
           }
           projDefinition.Save(build_file);
        }

        public static void ChangeAssemblyInfo(string path)
        {
            string asmInfo = "";
            string asm0Description = "[assembly: AssemblyDescription(\"0000000000000000000000000000000000000000\")]";
            string asmStart = "[assembly: AssemblyDescription(";

            if (File.Exists(path))
                asmInfo = File.ReadAllText(path);


            if (asmInfo.IndexOf(asmStart) >= 0 && asmInfo.IndexOf(asm0Description) == -1)
            {
                File.WriteAllText(path,
                    Regex.Replace(
                        asmInfo,
                        @"(\[assembly: AssemblyDescription\(""[0-9]*""\)\])",
                        @"[assembly: AssemblyDescription(""0000000000000000000000000000000000000000"")]"
                    )
                );
            }
        }

        class MyBoundaryObject : MarshalByRefObject
        {
            public void SomeMethod(AppDomainArgs ada)
            {
                Assembly assembly = Assembly.ReflectionOnlyLoadFrom(ada.dll_path);

                IList<CustomAttributeData> descriptionAttrList = assembly.GetCustomAttributesData();

                foreach (CustomAttributeData attribute in descriptionAttrList)
                {
                    if (attribute.AttributeType.Equals(typeof(AssemblyDescriptionAttribute)))
                    {
                        string typeVal = attribute.ToString();
                        ada.sha = typeVal.Substring(typeof(AssemblyDescriptionAttribute).ToString().Length + 3, 40);
                        break;
                    }
                }
            }
        }
        private class AppDomainArgs : MarshalByRefObject
        {
            public string dll_path { get; set; }
            public string sha { get; set; }
        }


        public static string GetSHAFromDLL(string dll_file_path)
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
            boundary.SomeMethod(ada);

            AppDomain.Unload(tempDomain);

            return ada.sha;
        }


        public static void EditDLLASM(string sha, string dll_file)
        {
            if (File.Exists(dll_file))
            {
                string currentSHA = GetSHAFromDLL(dll_file);


                byte[] file = File.ReadAllBytes(dll_file);
                byte[] curSHA = Encoding.Default.GetBytes(currentSHA);

                for (int i = 0; i < file.Length; i++)
                {
                    int j = i;

                    for (; j - i < curSHA.Length && file[j] == currentSHA[j - i]; j++) ;

                    if (j == i + 40)
                    {
                        byte[] shaBytes = Encoding.Default.GetBytes(sha);
                        for (int k = i; k < j; k++)
                            file[k] = shaBytes[k - i];
                        break;
                    }
                }
                File.WriteAllBytes(dll_file, file);
            }
        }

        public static string GetBuildPath(string csproj)
        {
            string path = @"bin\Debug\";

            XDocument projDefinition = XDocument.Load(csproj);
            string compileMode = projDefinition
                .Element(msbuild + "Project")
                .Elements(msbuild + "PropertyGroup")
                .Elements(msbuild + "Configuration")
                .Select(st => st.Value)
                .SingleOrDefault();

            IEnumerable<XElement> modeList = projDefinition
                .Element(msbuild + "Project")
                .Elements(msbuild + "PropertyGroup")
                .Where(x => (x.Attribute("Condition") != null && x.Attribute("Condition").Value.Contains(compileMode)));

            foreach (XElement mode in modeList)
            {
                return mode.Element(msbuild + "OutputPath").Value;
            }

            return path;
        }

        public static IEnumerable<string> GetDependentPrjList(string csproj)
        {
            XDocument projDefinition = XDocument.Load(csproj);
            IEnumerable<string> referenceList = projDefinition
                .Element(msbuild + "Project")
                .Elements(msbuild + "ItemGroup")
                .Elements(msbuild + "ProjectReference")
                .Select(st => st.Attribute("Include").Value);

            return referenceList;
        }

        public static void GatherDependentsDep(string csproj)
        {
            IEnumerable<string> DependentPrjList = GetDependentPrjList(csproj);

            string buildPath = Path.GetDirectoryName(csproj) + @"\" + GetBuildPath(csproj);

            foreach (string dependentPrj in DependentPrjList)
            {
                string depCsproj = Path.GetDirectoryName(csproj) + @"\" + dependentPrj;

                string depBuildPath = Path.GetDirectoryName(Path.GetDirectoryName(csproj) + @"\" + dependentPrj) + @"\" + GetBuildPath(depCsproj);

                string[] files = Directory.GetFiles(depBuildPath, "*.dep");

                foreach (string file in files) {
                    File.Copy(file, buildPath + Path.GetFileName(file), true);
                }
            }
        }

        public static string GenerateDep(string build_file, string outputPath, string prj_name)
        {
            GatherDependentsDep(build_file);
            string sha = CreateDepForProj(build_file, outputPath, prj_name);

            return sha;
        }

        static void Main(string[] args)
        {
            if (args.Length == 1)
            {
                Console.WriteLine("Not enough Arguments!");
            }
            else if (args.Length > 1)
            {
                if (args[1].EndsWith("\""))
                    args[1] = args[1].Substring(0, args[1].Length - 1);

                switch (args[0])
                {
                    case "-a":
                        string a_info = args[1] + @"\Properties\AssemblyInfo.cs";
                        Builder.ChangeAssemblyInfo(a_info);

                        break;
                    case "-dep":
                    case "-d":

                        Builder.GenerateDep(args[1], args[2], args[3]);
                        
                        break;
                    case "-c":
                        Console.WriteLine(args[1]);
                        Builder.EditDllPath(args[1], args[2], args[3]);
                        break;

                    case "-g":
                        break;
                }
            }
            else
            {
                //"Command TO build "$(ProjectDir)..\ProjectBuilder\bin\Debug\ProjectBuilder.exe" -a "$(ProjectDir)"
                string a = @"C:\Users\t-das\Documents\Visual Studio 2012\Projects\CST_Example\Server_C\Server_C.csproj";
                string b = @"C:\Users\t-das\Documents\Visual Studio 2012\Projects\CST_Example\Server_C\bin";
                string c = "Server_C";
                Builder.GenerateDep(a, b, c);
                Console.ReadKey();

            }
        }
    }
}