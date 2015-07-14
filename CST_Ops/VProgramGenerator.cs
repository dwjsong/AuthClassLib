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

namespace CST
{
    class VProgramGenerator
    {
        public static string vProPath = @"C:\CST\vProgram\";
        public static string poirotPath = @"C:\PoirotEnlistment";
        static string refStartText = "<Reference Include";
        static string refEndText = "</Reference>";
        static string globalobjectText = "GlobalObjectsForCST";

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

        public static List<string> getDep(string fileName)
        {
            List<string> dllList = new List<string>();

            XmlTextReader reader = new XmlTextReader(fileName);

            while (reader.Read())
            {
                if (reader.NodeType == System.Xml.XmlNodeType.Element &&
                    reader.Name == "Reference")
                {
                    reader.Read();
                    dllList.Add(reader.Value.Trim());
                }
            }

            return dllList;
        }

        public static void MakeRunBat()
        {
//            Directory.
        }

        public static void EditCSproj(List<MethodRecord> methodList)
        {
            HashSet<string> dllSet = new HashSet<string>();

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
                            dllSet.Add(fileName);
                        }
                        else
                        {
                            foreach (string st in getDep(fileName))
                                dllSet.Add(st);
                        }
                    }
                }
            }

            string buildFileText = File.ReadAllText(projectFile);
            int pos = 0, startPos;
            StringBuilder sb = new StringBuilder();
            int nowPos = buildFileText.IndexOf(refEndText, pos);

            startPos = nowPos;
            if (nowPos == -1)
            {
                int id = buildFileText.IndexOf(refStartText);

                if (id != -1)
                {
                    id--;
                    while (buildFileText[id] == ' ' || buildFileText[id] == '\t') id--;
                    sb.Append(buildFileText.Substring(0, id + 1));

                    foreach (string dl in dllSet)
                    {
                        string n = Path.GetFileName(dl);
                        sb.Append("    <Reference Include=\"" + n.Substring(0, n.Length - 4) + "\">\n");
                        sb.Append("      <HintPath>" + dl + "</HintPath>\n");
                        sb.Append("    </Reference>\n");
                    }
                    sb.Append(buildFileText.Substring(id + 1, buildFileText.Length-id - 1));
                }
            }
            else {
                while (nowPos != -1)
                {
                    int st = buildFileText.LastIndexOf(refStartText, nowPos);

                    if (buildFileText.Substring(st, nowPos - st).IndexOf(CSTFolder) != -1)
                    {
                        string text = buildFileText.Substring(pos, st - pos);

                        if (pos > 0)
                            sb.Append(text.Trim());
                        else
                        {
                            int id = text.Length - 1;
                            while (text[id] == ' ' || text[id] == '\t') id--;
                            sb.Append(text.Substring(0, id + 1));
                        }

                        if (pos == 0)
                        {
                            string last = dllSet.Last();
                            foreach (string dl in dllSet)
                            {
                                string n = Path.GetFileName(dl);
                                sb.Append("    <Reference Include=\"" + n.Substring(0, n.Length - 4) + "\">\n");
                                sb.Append("      <HintPath>" + dl + "</HintPath>\n");
                                sb.Append("    </Reference>");

                                if (dl != last) sb.Append("\n");
                            }
                        }

                        pos = nowPos + refEndText.Length;
                    }
                    nowPos = buildFileText.IndexOf(refEndText, pos);
                }
                sb.Append(buildFileText.Substring(pos, buildFileText.Length - pos));
            }

            File.WriteAllText(projectFile, sb.ToString().Trim());
        }        
        public static bool verify()
        {
            string build_cmd = "cd " + vProPath + " & " /*+ vProPath*/ + "run.bat";
            //string build_cmd = "cd " + vProPath +" & dir";

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.FileName = @"C:\Windows\System32\cmd.exe";
            startInfo.Arguments = "/c " + build_cmd;
            process.StartInfo = startInfo;
//            startInfo.RedirectStandardOutput = true;
//            startInfo.UseShellExecute = false;
            process.Start();

//            string output = process.StandardOutput.ReadToEnd();
            
//            var standardOutput = new StringBuilder();
            /*
            while (!process.HasExited)
            {
                standardOutput.Append(process.StandardOutput.ReadToEnd());
            }*/

            process.WaitForExit();
//            standardOutput.Append(process.StandardOutput.ReadToEnd());

            if (File.Exists(vProPath + "corral_out_trace.txt"))
            {
                return false;
            }
            return true;
        }

    }
}