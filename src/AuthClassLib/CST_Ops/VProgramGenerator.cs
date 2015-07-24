using CST;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;
using System.Xml;
using System.Xml.Linq;

namespace CST
{
    class VProgramGenerator
    {
        public static string vProPath = @"C:\CST\vProgram\";
        public static string poirotPath = @"C:\PoirotEnlistment";
        static string globalobjectText = "GlobalObjectsForCST";
        private static XNamespace msbuild = "http://schemas.microsoft.com/developer/msbuild/2003";

        public static string vSynFile = "SynthesizedPortion.cs";

        static string nondetStr = "Nondet";
        static string porirotMainStr = "PoirotMain";
        public static int variableC = 0;
        static string tabBuffer = "          ";
        static public string nondet = "Nondet";


        static public string syn_start = "public class SynthesizedPortion\n" +
                                         "{\n" +
                                          "    public static void SynthesizedSequence()\n" +
                                          "    {\n";

        static public string syn_end = "    }\n}";
        public static string CSTFolder = @"C:\CST\";
        public static string dllsFolder = @"C:\CST\dlls\";
        public static string projectFile = "";

        static VProgramGenerator()
        {
            if (HttpContext.Current == null) return;

            Configuration webConfig = WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);

            if (webConfig.AppSettings.Settings.Count > 0)
            {
                KeyValueConfigurationElement vProSetting =
                    webConfig.AppSettings.Settings["VProgramPath"];
                if (vProSetting != null)
                {
                    vProPath = vProSetting.Value;
                    try
                    {
                        string[] csproj = Directory.GetFiles(vProPath, "*.csproj");

                        if (csproj != null)
                        {
                            projectFile = csproj[0];
                        }

                    }
                    catch(Exception e)
                    {
                        Console.WriteLine(e.ToString());
                    }
                    
                }
                KeyValueConfigurationElement poirotSetting =
                    webConfig.AppSettings.Settings["POIROT_ROOT"];
                if (poirotSetting != null)
                {
                    poirotPath = poirotSetting.Value;
                }

                KeyValueConfigurationElement customSetting =
                    webConfig.AppSettings.Settings["CSTFolderPath"];
                if (customSetting != null)
                {
                    CSTFolder = customSetting.Value;
                }
                else
                {
                    CSTFolder = @"C:\CST";
                }
                dllsFolder = CSTFolder + @"dlls\";

            }

        }

        public static string GenDef(string type)
        {
            string[] typesplit = type.Split(new char[] { '.' }, StringSplitOptions.RemoveEmptyEntries);

            string typeWithoutNS = typesplit[typesplit.Length - 1];
            return type + " " + type[0] + variableC.ToString() + " = " + porirotMainStr + "." + nondetStr + "." + typeWithoutNS + "();"; 
        }

        public static string DefType(string type)
        {
            return type + " " + type[0] + variableC.ToString();
        }

        public static string generateVP(List<MethodRecord> records)
        {
            StringBuilder sb = new StringBuilder(syn_start);
            variableC = 0;

            if (records.Count > 0)
            {
                HashSet<string> definedClass = new HashSet<string>();

                variableC++;

                sb.Append(tabBuffer + GenDef(records[records.Count - 1].argType) + "\n");

                for (int i = records.Count - 1; i >= 0; i--)
                {
                    MethodRecord mr = records[i];
                    variableC++;
                    string fullClassN = mr.className;
                    string[] tClassN = fullClassN.Split(new char[] { '.' }, StringSplitOptions.RemoveEmptyEntries);
                    string ClassN = tClassN[tClassN.Length - 1];

                    if (mr.returnType != "Void")
                        sb.Append(tabBuffer + DefType(mr.returnType) + " = ((" + mr.className + ")" + globalobjectText + "." + mr.rootClassName + ")." + mr.methodName + "(" + mr.argType[0] + (variableC - 1).ToString() + ");\n");
                    else
                        sb.Append(tabBuffer + "((" + globalobjectText + "." + mr.rootClassName + ")." + "." + mr.methodName + "(" + mr.argType[0] + (variableC - 1).ToString() + ");\n");
                }
            }

            sb.Append(syn_end);

            return sb.ToString();
        }

        public static void generateVProgram(List<MethodRecord> methodList)
        {
            string program = generateVP(methodList);

            System.IO.StreamWriter file = new System.IO.StreamWriter(vProPath + @"\" + vSynFile);

            file.Write(program);

            file.Close();
        }

        public static HashSet<string> getDep(HashSet<string> dllSet, string fileName)
        {
            XmlTextReader reader = new XmlTextReader(fileName);
            HashSet<string> set_for_this_Dep = new HashSet<string>();

            while (reader.Read())
            {
                if (reader.NodeType == System.Xml.XmlNodeType.Element &&
                    reader.Name == "Reference")
                {
                    reader.Read();
                    string dllPath = reader.Value.Trim();

                    if (!dllSet.Contains(dllPath))
                    {
                        dllSet.Add(dllPath);
                        string depPath = dllPath.Substring(0, dllPath.Length-4) + ".dep";

                        set_for_this_Dep.Add(depPath);
                        //dllSet.UnionWith(getDep(dllSet, depPath));
                    }
                }
            }

            foreach (string dll in set_for_this_Dep)
            {
                getDep(dllSet, dll);
            }

            return dllSet;
        }

        public static void MakeRunBat()
        {
//            Directory.
        }

        public static void EditCSproj(List<MethodRecord> methodList)
        {
            Dictionary<string, string> dllPathDict = new Dictionary<string, string>();
            HashSet<string> dllNameSet = new HashSet<string>();

            foreach (MethodRecord mr in methodList)
            {
                string dllFolder = dllsFolder + mr.SHA_of_DLL;
                
                if (Directory.Exists(dllFolder))
                {
                    string[] fileES = Directory.GetFiles(dllFolder);

                    foreach (string fileName in fileES)
                    {
                        if (fileName.EndsWith(".dll") || fileName.EndsWith(".exe"))
                        {
                            string name = Path.GetFileNameWithoutExtension(fileName);
                            dllNameSet.Add(name);
                            dllPathDict[name] = fileName;
                        }
                        else
                        {
                            foreach (string dep_filename in getDep(new HashSet<String>(), fileName)) {
                                string name = Path.GetFileNameWithoutExtension(dep_filename);
                                dllNameSet.Add(name);
                                dllPathDict[name] = dep_filename;
                            }
                        }
                    }
                }
            }

            if (!File.Exists(projectFile)) return;

            XDocument projDefinition = XDocument.Load(projectFile);
            IEnumerable<XElement> referenceList = projDefinition
                .Element(msbuild + "Project")
                .Elements(msbuild + "ItemGroup")
                .Elements(msbuild + "Reference");

            XElement oneRef = null;

            foreach (XElement refEl in referenceList) 
            {
                XElement hintRef = refEl.Element(msbuild + "HintPath");
                if (hintRef != null) 
                {
                    string libName = refEl.Attribute("Include").Value;
                    if (dllNameSet.Contains(libName))
                    {
                        hintRef.SetValue(dllPathDict[libName]);
                        dllNameSet.Remove(libName);
                        dllPathDict.Remove(libName);
                    }
                }
                oneRef = refEl;
            }
            if (oneRef != null)
            {
                foreach (string libName in dllNameSet) 
                {
                    XElement newRefNode = new XElement(msbuild + "Reference",
                           new XAttribute("Include", libName),
                           new XElement(msbuild + "HintPath", dllPathDict[libName]));

                    oneRef.Parent.Add(newRefNode);
                }
            }
            projDefinition.Save(projectFile);
            

        }        
        public static bool verify()
        {
            string build_cmd = "cd " + vProPath + " & " /*+ vProPath*/ + "run.bat";

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.FileName = @"C:\Windows\System32\cmd.exe";
            startInfo.Arguments = "/c " + build_cmd;
            process.StartInfo = startInfo;
            process.Start();

            process.WaitForExit();

            if (File.Exists(vProPath + "corral_out_trace.txt"))
            {
                return false;
            }
            return true;
        }

    }
}