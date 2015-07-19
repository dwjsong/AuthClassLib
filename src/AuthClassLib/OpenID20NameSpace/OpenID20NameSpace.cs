using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GenericAuthNameSpace;
using System.Net;

namespace OpenID20NameSpace
{
    public class AuthenticationRequest : SignInIdP_Req
    {
        public string ns = "http://specs.openid.net/auth/2.0";
        public string mode;
        public string claimed_id;
        public string identity;
        public string assoc_handle;
        public string return_to;
        public string realm;

        public override string Realm
        {
            get
            {
                return realm;
            }
        }
    }




    public abstract class RelyingParty : RP
    {
        public string Normalize(string user_supplied_id)
        {
            string identifier = user_supplied_id;
            char[] xriStart = new char[] {'=', '@', '+', '$', '!', '('};

            if (identifier.StartsWith("xri://"))
            {
                identifier = identifier.Substring("xri://".Length);
            }
            if (xriStart.Any(x => x == identifier[0]))
            {
                return identifier;
            }
            else
            {
                if (!identifier.StartsWith("http://") && !identifier.StartsWith("https://"))
                {
                    identifier = String.Format("http://{0}", identifier);
                }

                return identifier;
            }
        }

        public string Discover(string identifier)
        {
            HttpWebRequest IDrequest = (HttpWebRequest)WebRequest.Create(identifier);
            HttpWebResponse IDresponse = (HttpWebResponse)IDrequest.GetResponse();

            string location = IDresponse.Headers.Get("X-XRDS-Location");



            return "";
            /*
            Stream resStream = response.GetResponseStream();

            StreamReader reader = new StreamReader(resStream);
            string text = reader.ReadToEnd();*/
        }

        
        public AuthenticationRequest RequestAuthentication()
        {
            return new AuthenticationRequest();
        }
        
    }

    public abstract class OpenIDProvider : IdP
    {

    }

    public abstract class AuthorizationRequest : SignInIdP_Req
    {

    }
}