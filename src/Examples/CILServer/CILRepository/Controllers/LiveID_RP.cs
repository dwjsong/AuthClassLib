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
        public RelyingPartyImpl( string client_id, string return_uri, string client_secret, string TokenEndpointUrl)
            :base(client_id, return_uri, client_secret, TokenEndpointUrl) 
        {
        }
        public RelyingPartyImpl()
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

            Stopwatch stopWatch = new Stopwatch();
            stopWatch.Start();

            CST_Ops.recordme(new OpenIDConnectNameSpace.AuthorizationServerImpl(), req, tr, typeof(OpenIDProvider).GetMethod("TokenEndpoint"), "live.com", false, false);
            stopWatch.Stop();
            string path = @"C:\Users\Daniel Song\Desktop\IdP_TokenRequest.txt";
            if (!File.Exists(path))
            {
                using (StreamWriter sw = File.CreateText(path))
                {
                    sw.WriteLine(stopWatch.ElapsedMilliseconds);
                }
            }
            else
            {
                using (StreamWriter sw = File.AppendText(path))
                {
                    sw.WriteLine(stopWatch.ElapsedMilliseconds);
                }

            }

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