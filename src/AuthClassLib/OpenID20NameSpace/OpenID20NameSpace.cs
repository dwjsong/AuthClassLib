using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GenericAuthNameSpace;
using System.Net;
using CST;

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
            set
            {
                realm = value;
            }
        }

        public string endpointURL;
    }

    public class AuthenticationResponse : SignInRP_Resp
    {
        public string ns = "http://specs.openid.net/auth/2.0";
        public string mode;
        public string claimed_id;
        public string identity;
        public string assoc_handle;
        public string return_to;
        public string realm;


        public string endpointURL;
    }

    //data structures
    public class IDAssertionEntry : ID_Claim
    {
        public string openid_return_to;
        public string openid_identity;
        public string openid_claimed_id;
        public string openid_assoc_handle;
        public string openid_op_endpoint;
        public override string Redir_dest
        {
            get { return openid_return_to; }
        }
        public override string UserID
        {
            get { return openid_claimed_id; }
        }
    }
    //=====================================================
    public abstract class RelyingParty : RP
    {
        public string return_uri
        {
            get { return Domain; }
            set { Domain = value; }
        }
        public string assoc_handle;
        public string endpointUrl;

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
        }


        public AuthenticationRequest RequestAuthentication(AuthenticationRequest resp)
        {
            var req = new AuthenticationRequest();

            req.realm = this.Domain;
            req.SymT = resp.SymT;
            req.identity = "http://specs.openid.net/auth/2.0/identifier_select";
            req.ns = "http://specs.openid.net/auth/2.0";
            req.claimed_id = "http://specs.openid.net/auth/2.0/identifier_select";
            req.mode = "checkid_setup";
            req.return_to = this.Domain;

            CST_Ops.recordme(req);

            return req;
        }
        
    }
    public interface IDAssertionRecs : IdPAuthRecords_Base
    {
       // string findISSByClientIDAndCode(string client_id, string authorization_code);
    }

    public abstract class OpenIDProvider : IdP
    {
        protected IDAssertionRecs IDAssertionRecs
        {
            get { return (IDAssertionRecs)IdpAuthRecs; }
            set { IdpAuthRecs = value; }
        }

        protected override ID_Claim Process_SignInIdP_req(SignInIdP_Req req1)
        {
            AuthenticationRequest req = (AuthenticationRequest)req1;

            return null;
        }
        protected override SignInIdP_Resp_SignInRP_Req Redir(string dest, ID_Claim _ID_Claim)
        {
            return null;
        }

        public AuthenticationResponse ProcessAuthenticationRequest(AuthenticationRequest req)
        {
            AuthenticationResponse resp = new AuthenticationResponse();

            switch (req.mode)
            {
                case "checkid_setup" :
                    IDAssertionEntry entry = (IDAssertionEntry)IDAssertionRecs.getEntry(req.IdPSessionSecret, req.realm);
                    resp.claimed_id = entry.openid_claimed_id;
                    resp.return_to = entry.openid_return_to;
                    //...

                    break;
            }

            return resp;
        }

    }

    public abstract class AuthorizationRequest : SignInIdP_Req
    {

    }

    public interface NondetOpenID20 : Nondet_Base
    {
        AuthenticationRequest AuthenticationRequest();
        AuthenticationResponse AuthenticationResponse();
    }
}