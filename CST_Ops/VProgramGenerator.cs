using CST;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace CST
{
    class VProgramGenerator
    {
        public static string vProPath = @"C:\CST\vProgram\";
        public static string cstPath = @"C:\CST\";
        static string refText = "<Reference Include";

        public static string vProgFolder = cstPath + "vProgram\\";
        public static string vSynFile = "SynthesizedSequence.cs";

        static string nondetStr = "Nondet";
        public static int variableC = 0;
        static string tabBuffer = "          ";
        static public string nondet = "Nondet";


        static public string syn_start = "partial class PoirotMain\n" +
                                         "{\n" +
                                          "    static void call_SynthesizedSequence()\n" +
                                          "    {\n";

        static public string syn_end = "    }\n}";

        public static string GenDef(string typeNS, string type)
        {
            return typeNS + "." + type + " " + type[0] + variableC.ToString() + " = " + nondetStr + "." + type + "();"; 
        }

        public static string DefType(string typeNS, string type)
        {
            return typeNS + "." + type + " " + type[0] + variableC.ToString();
        }

        public static string generateVP(List<MethodRecord> records)
        {
            StringBuilder sb = new StringBuilder(syn_start);
            variableC = 0;

            if (records.Count > 0)
            {
                HashSet<string> definedClass = new HashSet<string>();

                variableC++;

                sb.Append(tabBuffer + GenDef(records[records.Count - 1].argTypeNS, records[records.Count - 1].argType) + "\n");

                for (int i = records.Count - 1; i >= 0; i--)
                {
                    MethodRecord mr = records[i];
                    variableC++;
                    string fullClassN = mr.className;
                    string[] tClassN = fullClassN.Split(new char[] { '.' }, StringSplitOptions.RemoveEmptyEntries);
                    string ClassN = tClassN[tClassN.Length - 1];

                    if (mr.returnType != "Void")
                        sb.Append(tabBuffer + DefType(mr.returnTypeNS, mr.returnType) + " = " + ClassN + "." + mr.methodName + "(" + mr.argType[0] + (variableC - 1).ToString() + ");\n");
                    else
                        sb.Append(tabBuffer + ClassN + "." + mr.methodName + "(" + mr.argType[0] + (variableC - 1).ToString() + ");\n");
                }
            }

            sb.Append(syn_end);

            return sb.ToString();
        }

        public static void generateVProgram(List<MethodRecord> methodList)
        {
            string program = generateVP(methodList);

            System.IO.StreamWriter file = new System.IO.StreamWriter(VProgramGenerator.vProgFolder + VProgramGenerator.vSynFile);

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

        public static void EditCSproj(List<MethodRecord> methodList)
        {
            HashSet<string> dllSet = new HashSet<string>();

            foreach (MethodRecord mr in methodList)
            {
                string dllFolder = DLLHasher.dllsFolder + mr.SHA_of_DLL;

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

            string buildFile = File.ReadAllText(cstPath + "vProgram.csproj");

            int refPos = buildFile.IndexOf(refText) - 4;

            StringBuilder sb = new StringBuilder();
            foreach (string dl in dllSet)
            {
                string n = Path.GetFileName(dl);
                sb.Append("    <Reference Include=\"" + n.Substring(0, n.Length - 4) + "\">\n");
                sb.Append("      <HintPath>" + dl + "</HintPath>\n");
                sb.Append("    </Reference>\n");
            }
            string newBuildFile = buildFile.Substring(0, refPos) + sb.ToString() + buildFile.Substring(refPos);


            File.WriteAllText(vProPath + "vProgram.csproj", newBuildFile);
        }        
        public static bool verify()
        {
            string build_cmd = "cd " + vProPath + " & " + vProPath + "run.bat";

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.FileName = "cmd.exe";
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