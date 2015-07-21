using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OpenID20NameSpace;
using GenericAuthNameSpace;
using System.Text;
using CST;

namespace OpenIDExample
{
    public class Yahoo_RP : RelyingParty
    {
        public Yahoo_RP(string return_uri, string endpointUrl)
        {
            this.return_uri = return_uri;
            this.endpointUrl = endpointUrl;
        }

        public override SignInRP_Resp SignInRP(SignInIdP_Resp_SignInRP_Req req)
        {
            return new SignInRP_Resp();
        }
        public void SignIn()
        {

        }

        public string GenerateURL(AuthenticationRequest req)
        {
            StringBuilder sb = new StringBuilder(endpointUrl);

            sb.AppendFormat("?openid.claimed_id={0}&openid.identity={1}&openid.return_to={2}?SymT={6}&openid.realm={5}&openid.mode={3}&openid.ns={4}", HttpUtility.UrlEncode(req.claimed_id), HttpUtility.UrlEncode(req.identity), HttpUtility.UrlEncode(req.return_to), req.mode, HttpUtility.UrlEncode(req.ns), HttpUtility.UrlEncode(req.realm), HttpUtility.UrlEncode(req.SymT));

            return sb.ToString();
        }
        public string GenerateURL(AuthenticationResponse req)
        {
            StringBuilder sb = new StringBuilder(endpointUrl);

            sb.AppendFormat("?openid.claimed_id={0}&openid.identity={1}&openid.return_to={2}?SymT={6}&openid.realm={5}&openid.mode={3}&openid.ns={4}", HttpUtility.UrlEncode(req.claimed_id), HttpUtility.UrlEncode(req.identity), HttpUtility.UrlEncode(req.return_to), req.mode, HttpUtility.UrlEncode(req.ns), HttpUtility.UrlEncode(req.realm), HttpUtility.UrlEncode(req.SymT));

            return sb.ToString();
        }

        public AuthenticationConclusion conclude(AuthenticationResponse req)
        {
            AuthenticationConclusion conclusion = new AuthenticationConclusion();
//            conclusion.SessionUID = req.UserId;
            conclusion.SymT = req.SymT;

            CST_Ops.recordme(conclusion);
            if (AuthenticationDone(conclusion))
                return conclusion;
            else
                return null;

        }

    }
}