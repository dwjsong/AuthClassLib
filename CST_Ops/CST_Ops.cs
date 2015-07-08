﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Xml;
using System.Collections.Immutable;
using System.Collections.Concurrent;

namespace CST
{
    public class CST_Ops
    {
        private static ConcurrentDictionary<string, MethodRecord> methodSHADict = new ConcurrentDictionary<string, MethodRecord>();
        private static ConcurrentDictionary<string, MethodRecord> methodSHADictKEYSHA = new ConcurrentDictionary<string, MethodRecord>();
 
        static public void recordme(_CST_Struct msg)
        {
            StackTrace st = new StackTrace();
            StackFrame sf = st.GetFrame(1);
            MethodBase mi = sf.GetMethod();

            string classNS = mi.ReflectedType.Namespace;
            string className = mi.ReflectedType.Name;
            string methodName = mi.Name;

            ParameterInfo[] pi = mi.GetParameters();
            string[] args = new string[pi.Length];
            string argType = "";
            string argTypeNS = "";

            if (pi.Length > 0)
            {
                argType = pi[0].ParameterType.Name;
                argTypeNS = pi[0].ParameterType.Namespace;
            }

            MethodInfo mb = (MethodInfo)mi;

            string returnTypeNS = mb.ReturnType.Namespace;
            string returnType = mb.ReturnType.Name;

            string methodkey = returnTypeNS + "." + returnType + " " + classNS + "." + className + "." + methodName + "(" + argTypeNS + "." + argType + ")";
            string sha = "0000000000000000000000000000000000000000";

            if (!methodSHADict.ContainsKey(methodkey))
            {
                string dllName = mi.Module.FullyQualifiedName;
                
                string path = Path.GetDirectoryName(dllName);
                string name = Path.GetFileNameWithoutExtension(dllName);

                var descriptionAttribute = mi.Module.Assembly
                                                    .GetCustomAttributes(typeof(AssemblyDescriptionAttribute), false)
                                                    .OfType<AssemblyDescriptionAttribute>()
                                                    .FirstOrDefault();

                if (descriptionAttribute != null)
                    sha = descriptionAttribute.Description;

                MethodRecord mr = new MethodRecord(classNS, className, methodName, argTypeNS, argType, returnTypeNS, returnType, name + "." + sha);

                MethodHasher.saveMethod(mr);

                DLLServerConnector.uploadMethodRecord(MethodHasher.methodsFolder + "\\" + mr.getSHA() + ".txt", sha);

                methodSHADict.AddOrUpdate(methodkey, mr, (k, v) => v);
                methodSHADictKEYSHA.AddOrUpdate(mr.getSHA(), mr, (k, v) => v);

                sha = mr.getSHA();
            }
            else
            {
                sha = methodSHADict[methodkey].getSHA();
            }

            msg.SymT = sha + "(" + msg.SymT + ")";
        }


        public bool conclude(_CST_Struct msg)
        {
            /*make v program and verify*/
            return certify(msg);
        }

        public static List<MethodRecord> getDehashedRecords(_CST_Struct msg)
        {
            List<MethodRecord> mrList = new List<MethodRecord>();
            string[] sha_methods = msg.SymT.Split(new char[] { ' ', '(', ')' }, StringSplitOptions.RemoveEmptyEntries);

            foreach (string method in sha_methods)
            {
                MethodRecord mr = null;
                if (!methodSHADictKEYSHA.ContainsKey(method))
                {
                    if (!File.Exists(DLLServerConnector.methodsFolder + method + ".txt"))
                    {
                        DLLServerConnector.downloadMethodRecord(method);
                    }
                    mr = MethodHasher.getMRFromFile(method);
                }
                else
                {
                    mr = methodSHADictKEYSHA[method];
                }
                if (!Directory.Exists(DLLServerConnector.dllsFolder + mr.SHA_of_DLL))
                {

                    DLLServerConnector.downloadDLLandDep(mr.SHA_of_DLL);
                }

                mrList.Add(mr);
            }

            return mrList;
        }

        public static bool certify(_CST_Struct msg)
        {
            List<MethodRecord> methodList = getDehashedRecords(msg);

            VProgramGenerator.generateVProgram(methodList);

            VProgramGenerator.EditCSproj(methodList);

            return VProgramGenerator.verify();
        }

        /*
        public static bool SignatureValid(HttpRequest request)
        {
            return true;
        }

        public static bool parse(Message msg, HttpRequest request)
        {
            msg.SymT = request.QueryString["SymT"];
            msg.SignedBy = request.QueryString["SignedBy"];
            if (request.QueryString["value"] != null)
                msg.value = Int32.Parse(request.QueryString["Value"]);
            msg.largestParty = request.QueryString["LargestParty"];

            if ((msg.SignedBy == null || msg.SignedBy.Length == 0) && !SignatureValid(request))
            {
                generateErrorResponse();
                return false;
            }
            return true;
        }

        public static void respond(Message msg, HttpResponse response)
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();

            dict.Add("SymT", msg.SymT);
            dict.Add("SignedBy", msg.SignedBy);
            dict.Add("LargestParty", msg.largestParty);
            dict.Add("Value", msg.value.ToString());
            dict.Add("Certified", msg.certified.ToString());

            XmlDocument doc = HTTPComm.GenerateXML(dict);

            response.StatusCode = 200;
            response.ContentType = "text/xml"; //must be 'text/xml'
            response.ContentEncoding = System.Text.Encoding.UTF8; //we'd like UTF-8
            doc.Save(response.Output);
        }
        */

        public static void generateErrorResponse()
        {
        }










        static string dehash_server_host = "http://protoagnostic.cloudapp.net:8500/";
        static string upload_path = "Hash/CodeToHash";
        static string dehash_path = "Hash/HashToCode";
        static Dictionary<string, string> codeHashMap = new Dictionary<string, string>();

        static public string myPartyName;
        static public string[] trustedParties;

        //a.com:CALL1    -- colon controlled by bSelfSuppliedInput
        static public string ConstructSymT(string methodCall, bool bSigned)
        {
            return String.Format("{0}{1}{2}", myPartyName, bSigned ? "::" : ":", methodCall);
        }

        //hash1(Sym_T1)    -- parentheses controlled by bSelfSuppliedInput
        static public string ConstructSimpleCall(string srcHash, string SymT_in, bool bSelfSuppliedInput)
        {
            return String.Format("{0}{1}{2}{3}", srcHash,
                                bSelfSuppliedInput ? "((" : "(",
                                SymT_in,
                                bSelfSuppliedInput ? "))" : ")");
        }

        //input = a.com:hash1(...) and hash2
        //output= hash2((a.com:hash1((...))))
        static public string ConstructServerServerCall(string SymT_ServerServerCall, string srcHash_postCall)
        {
            SymT_ServerServerCall = ChangeToDoubleParentheses(SymT_ServerServerCall);
            return String.Format("{0}(({1}))", srcHash_postCall, SymT_ServerServerCall);
        }

        static string ChangeToDoubleParentheses(string SymT_ServerServerCall)
        {
            int pos = SymT_ServerServerCall.IndexOf(myPartyName);
            if (pos < 2) return SymT_ServerServerCall;
            if (SymT_ServerServerCall[pos - 1] == '(' && SymT_ServerServerCall[pos - 2] != '(')
                return String.Format("{0}({1})", SymT_ServerServerCall.Substring(0, pos - 1), SymT_ServerServerCall.Substring(pos - 1));
            else
                return SymT_ServerServerCall;
        }

        //this function converts a piece of code to a hash
        public static string code_to_hash(string code)
        {

            foreach (KeyValuePair<string, string> entry in codeHashMap)
            {
                if (entry.Value == code)
                {
                    return entry.Key;
                }
            }

            //resp is in the format of OK|HASH or Error: ERROR MESSAGE
            string resp = HTTP.HTTPComm.HttpPost(dehash_server_host + upload_path, code);
            string hash = "";

            if (resp.IndexOf("Error") != -1)
            {
                Console.WriteLine(resp);
            }
            else
            {
                string[] split = resp.Split(new char[] { '|' });
                hash = split[1];
            }

            return hash;
        }

    }
}