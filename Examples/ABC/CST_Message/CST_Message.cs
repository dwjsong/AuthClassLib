﻿using HTTP;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Xml;

namespace CST
{
    public class CST_Message : CST_Struct
    {
        public int value;
        public string largestParty;
        public bool certified;

        public static bool parse(CST_Message msg, HttpRequest request)
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

        public static void respond(CST_Message msg, HttpResponse response)
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


        public static void generateErrorResponse()
        {
        }

        public static bool SignatureValid(HttpRequest request)
        {
            return true;
        }
    }
}
