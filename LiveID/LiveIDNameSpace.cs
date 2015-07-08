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
            CST.CST_Ops.myPartyName = new Uri(return_uri).Host;
            CST.CST_Ops.trustedParties = new string[] { CST.CST_Ops.myPartyName, new Uri(TokenEndpointUrl).Host };
        }
        public LiveID_RP(): this(
                      "000000004C108D95",
                      "http://a.local.host:54432/Website/login.aspx",
                      "zMVS1BpoNHwtdTnSzazSt2JgLd1hxRA1",
                      "https://login.live.com/oauth20_token.srf"
                      )
        {            
        }
        public override _SignInRP_Resp SignInRP(_SignInIdP_Resp_SignInRP_Req req)
        {
            AuthenticationResponse codeResp = (AuthenticationResponse)req;
            AuthenticationUsingAuthorizationCodeFlow(codeResp);
            return null;
        }
    }
}