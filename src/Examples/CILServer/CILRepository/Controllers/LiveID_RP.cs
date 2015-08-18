namespace LiveIDNameSpace
{
    using System;
    using System.Web;
    using System.Web.SessionState;
    using CST;
    using GenericAuthNameSpace;
    using OpenIDConnectNameSpace;


    /***********************************************************/
    /*               Messages between parties                  */
    /***********************************************************/

    /***********************************************************/
    /*               Data structures on parties                */
    /***********************************************************/

    /***********************************************************/
    /*                          Parties                        */
    /***********************************************************/

    public class LiveID_RP: RelyingParty 
    {
        public LiveID_RP( string client_id, string return_uri, string client_secret, string TokenEndpointUrl)
            :base(client_id, return_uri, client_secret, TokenEndpointUrl) 
        {
        }
        public LiveID_RP()
            : this(
                "0000000044159E9D",
//                "0000000044114C32",
                "http://mydomain2.com:8700/Account/MSLoginCallback",
                "pQZPJYxVuzaF7zk3-0cfuA6lWoW3GHkf",
//                "a09S5EtRiwXmg8CbASYFsQQ9QEIqb8yv",
                "https://login.live.com/oauth20_token.srf"
                )
        {
        }

        public override SignInRP_Resp SignInRP(SignInIdP_Resp_SignInRP_Req req)
        {
            AuthenticationResponse codeResp = (AuthenticationResponse)req;
            AuthenticationConclusion conclusion = AuthenticationUsingAuthorizationCodeFlow(codeResp);
            return null;
        }

        public override TokenResponse callTokenEndpoint(TokenRequest req)
        {
            TokenResponse tr = base.callTokenEndpoint(req);

            CST_Ops.recordme(new LiveIDNameSpace.LiveID_IdP(), req, tr, typeof(OpenIDProvider).GetMethod("TokenEndpoint"), "live.com", false, false);

            return tr;
        }

        public string GetUserID()
        {
            return (string)CurrentSession["UserID"];
        }

        public bool IsVerified()
        {
            return true;
        }

    }
}