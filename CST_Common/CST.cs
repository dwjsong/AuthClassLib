using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Diagnostics;
using System.Diagnostics.Contracts;
using System.Net;
using System.IO;

namespace CST
{
    public class CST_Struct
    {
        public string SymT = "";
        public string SignedBy = "";
    }
    public class Debug
    {
        static public void reached()
        {
            Contract.Assert(false);
        }
    }
    /*
    public class SymT_Ops
    {
        static string dehash_server_host = "http://protoagnostic.cloudapp.net:8500/";
        static string upload_path = "Hash/CodeToHash";
        static string dehash_path = "Hash/HashToCode";
        static Dictionary<string, string> codeHashMap = new Dictionary<string, string>();

        static public string myPartyName;
        static public string[] trustedParties;

        //a.com:CALL1    -- colon controlled by bSelfSuppliedInput
        static public string ConstructSymT(string methodCall,bool bSigned)
        {
            return String.Format("{0}{1}{2}", myPartyName, bSigned?"::":":", methodCall);
        } 
        
        //hash1(Sym_T1)    -- parentheses controlled by bSelfSuppliedInput
        static public string ConstructSimpleCall(string srcHash,string SymT_in,bool bSelfSuppliedInput)
        {
            return String.Format("{0}{1}{2}{3}",srcHash,
                                bSelfSuppliedInput?"((":"(",
                                SymT_in,
                                bSelfSuppliedInput?"))":")");
        }

        //input = a.com:hash1(...) and hash2
        //output= hash2((a.com:hash1((...))))
        static public string ConstructServerServerCall(string SymT_ServerServerCall, string srcHash_postCall)
        {
            SymT_ServerServerCall=ChangeToDoubleParentheses(SymT_ServerServerCall);
            return String.Format("{0}(({1}))",srcHash_postCall,SymT_ServerServerCall);
        }

        static string ChangeToDoubleParentheses(string SymT_ServerServerCall)
        {
            int pos = SymT_ServerServerCall.IndexOf(myPartyName);
            if (pos < 2) return SymT_ServerServerCall;
            if (SymT_ServerServerCall[pos - 1] == '(' && SymT_ServerServerCall[pos - 2] != '(')
                return String.Format("{0}({1})",SymT_ServerServerCall.Substring(0, pos - 1),SymT_ServerServerCall.Substring(pos - 1));
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
    }*/

    public interface Nondet_Base
    {
        int Int();
        string String();
        bool Bool();
    }
}
