﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GenericAuthNameSpace;
using System.Net;
using CST;
using System.Web;
using System.Diagnostics.Contracts;
using HTTP;

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
            get { return realm;  }
            set { realm = value; }
        }

        public string endpointURL;
    }

    public class AuthenticationResponse : SignInIdP_Resp_SignInRP_Req
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

        static public IDAssertionEntry AssumeType(IDAssertionEntry in_obj)
        {
            IDAssertionEntry out_obj = new IDAssertionEntry();
            out_obj.openid_return_to = in_obj.openid_return_to;
            out_obj.openid_claimed_id = in_obj.openid_claimed_id;

            return out_obj;
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

        public AuthenticationRequest RequestAuthentication(AuthenticationResponse resp)
        {
            var req = new AuthenticationRequest();

            req.realm = this.Domain;
            req.identity = "http://specs.openid.net/auth/2.0/identifier_select";
            req.ns = "http://specs.openid.net/auth/2.0";
            req.claimed_id = "http://specs.openid.net/auth/2.0/identifier_select";
            req.mode = "checkid_setup";
            req.return_to = this.Domain;
            CST_Ops.recordme(this, resp, req);

            return req;
        }

        public bool ValidateSignature(HttpRequest request)
        {
            StringBuilder sb = new StringBuilder();

            string[] keys = request.Params.AllKeys;
            bool not_first = false;

            for (int i = 0; i < keys.Length; i++)
            {
                if (not_first) sb.Append("&");
                if (keys[i].StartsWith("openid."))
                {
                    if (keys[i] == "openid.mode")
                        sb.Append(keys[i] + "=check_authentication");
                    else
                        sb.Append(keys[i] + "=" + request.Params[keys[i]]);
                    not_first = true;
                }
            }

            HttpWebResponse response = HTTPComm.HttpReq(endpointUrl, sb.ToString(), "POST");
            string result = HTTPComm.HttpPost(endpointUrl, sb.ToString());

            if (result.Contains("is_valid:true\n")) return true;

            return false;
        }

        public AuthenticationResponse ParseAuthenticationResponse(HttpRequest rawRequest)
        {
            AuthenticationResponse r = new AuthenticationResponse();
            HttpContext context = HttpContext.Current;
            r.claimed_id = rawRequest.QueryString["openid.claimed_id"];
            r.SymT = rawRequest.QueryString["SymT"];
            string return_url = rawRequest.QueryString["openid.return_to"];

            /* Since we have added SymT in the return_uri, we need to strip them */
            if (return_url.StartsWith(this.Domain)) {
                string[] urls = return_url.Split('?');
                r.return_to = urls[0];
            }
            if (string.IsNullOrEmpty(r.claimed_id))
                return null;
            else
                return r;
        }

        public override SignInRP_Resp SignInRP(SignInIdP_Resp_SignInRP_Req req1)
        {
            AuthenticationResponse req = (AuthenticationResponse)req1;
            if (req == null) return null;
            if (this.Domain != req.return_to) return null;
            AuthenticationConclusion conclusion = new AuthenticationConclusion();

            conclusion.SessionUID = req.claimed_id;
            CST_Ops.recordme(this, req, conclusion, true);

            if (AuthenticationDone(conclusion))
                return new SignInRP_Resp();
            else
                return null;
        }
    }

    public interface IDAssertionRecs : IdPAuthRecords_Base
    {
    }

    public abstract class OpenIDProvider : IdP
    {
        public void init(IDAssertionRecs recs)
        {
            IDAssertionRecs = recs;
        }

        protected IDAssertionRecs IDAssertionRecs
        {
            get { return (IDAssertionRecs)IdpAuthRecs; }
            set { IdpAuthRecs = value; }
        }

        public override SignInIdP_Resp_SignInRP_Req SignInIdP(SignInIdP_Req req1)
        {
            AuthenticationRequest req = (AuthenticationRequest)req1;
            Contract.Assume(GlobalObjects_base.SignInIdP_Req.IdPSessionSecret == req.IdPSessionSecret);

            if (req == null) return null;
            ID_Claim _ID_Claim = Process_SignInIdP_req(req);
            if (_ID_Claim == null) return null;

            return Redir(_ID_Claim.Redir_dest, _ID_Claim);
        }

        public override ID_Claim Process_SignInIdP_req(SignInIdP_Req req1)
        {
            AuthenticationRequest req = (AuthenticationRequest)req1;

            switch (req.mode)
            {
                case "checkid_setup":
                    IDAssertionEntry entry = (IDAssertionEntry)IDAssertionRecs.getEntry(req.IdPSessionSecret, req.realm);
                    if (req.realm == entry.Redir_dest)
                        return entry;
                    return null;
            }

            return null;
        }

        public override SignInIdP_Resp_SignInRP_Req Redir(string dest, ID_Claim _ID_Claim)
        {
            AuthenticationResponse req = new AuthenticationResponse();

            req.claimed_id = _ID_Claim.UserID;
            req.return_to = _ID_Claim.Redir_dest;

            /*
             * Redir should happen here.
             */

            return req;
        }
    }

    public interface NondetOpenID20 : Nondet_Base
    {
        SignInIdP_Req SignInIdP_Req();
        SignInIdP_Resp_SignInRP_Req SignInIdP_Resp_SignInRP_Req();
        AuthenticationRequest AuthenticationRequest();
        AuthenticationResponse AuthenticationResponse();
        IDAssertionEntry IDAssertionEntry();
        Dictionary<string, Dictionary<string, IDAssertionEntry>> IDAssertionRecsDictionary();
    }
}