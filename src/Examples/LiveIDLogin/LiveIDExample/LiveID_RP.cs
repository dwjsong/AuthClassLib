namespace OpenIDConnectNameSpace
{
    using System;
    using System.Web;
    using System.Web.SessionState;
    using CST;
    using GenericAuthNameSpace;
    using System.Diagnostics;
    using System.IO;


    /***********************************************************/
    /*               Messages between parties                  */
    /***********************************************************/

    /***********************************************************/
    /*               Data structures on parties                */
    /***********************************************************/

    /***********************************************************/
    /*                          Parties                        */
    /***********************************************************/

    public class RelyingPartyImpl: RelyingParty 
    {
        public RelyingPartyImpl(string client_id, string return_uri, string client_secret, string TokenEndpointUrl)
            :base(client_id, return_uri, client_secret, TokenEndpointUrl) 
        {
            init();
        }

        public RelyingPartyImpl()
            : this(
                "000000004C108D95",
                "http://a.local.host:14022/login.aspx",
                "zMVS1BpoNHwtdTnSzazSt2JgLd1hxRA1",
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

            CST_Ops.recordme(new OpenIDConnectNameSpace.AuthorizationServerImpl(), req, tr, typeof(OpenIDProvider).GetMethod("TokenEndpoint"), "live.com", false, false);

            return tr;
        }
    }
}