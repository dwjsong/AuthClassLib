using OpenID20NameSpace;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CST;
using GenericAuthNameSpace;

namespace OpenIDExample
{
    public partial class LogIn : System.Web.UI.Page
    {
        Yahoo_RP RP = new Yahoo_RP("http://localhost:32928/LogIn.aspx", "https://open.login.yahooapis.com/openid/op/auth");

        protected void Page_Load(object sender, EventArgs e)
        {            
            //AuthenticationRequest m = new AuthenticationRequest();
            string mode = Request.Params["openid.mode"];

            if (!String.IsNullOrEmpty(mode))
            {
                RP.CurrentSession = Session;
                RP.AuthenticationConclusion d = new RP.AuthenticationConclusion();
                AuthenticationResponse resp = RP.parseAuthenticationResponse(Request);
                RP.SignInRP(resp);

                notLoggedIn.Visible = false;
                LoggedIn.Visible = true;

                logged_id.InnerHtml = String.Format("Your ID is {0}", Request.Params["openid.identity"]);

            }
            else
            {
                notLoggedIn.Visible = true;
                LoggedIn.Visible = false;

            }
        }

        /*
         * OnLoginButtonClick
         * {
         *  doDiscover() {
         *      constructDiscoverRequest() { recordMe(); } ;
         *      Respond = sendDiscoverRequest();
         *      
         *      parse(m, Respond);
         *      m2 = RP.RequestAuthentication(m) { recordMe(); };
         *      
         *      CST_Message.Redir(m2, Response);
         *      
         *  }
         * }
         * 
         * SignIn(HTTPResponse)
         * {
         *      constructDiscoverRequest() { recordMe(); } ;
         *      Respond = sendDiscoverRequest();
         *      
         *      parse(m, Respond);
         *      m2 = RP.RequestAuthentication(m) { recordMe(); };
         *      Response = HTTPResponse.Redir(m2, Response);
         *      
         * }
         * 
         * 
         * AuthenticationDone()
         * {
         *      certify();
         * }
         * 
         */

        protected void LoginBtn_Click(Object sender, EventArgs e)
        {
            AuthenticationResponse req = new AuthenticationResponse();

            var resp = RP.RequestAuthentication(req);

            /* HACK for Yahoo IdP */
            AuthenticationRequest new_resq = new AuthenticationRequest();
            new_resq.claimed_id = resp.claimed_id;
            new_resq.identity = resp.identity;
            new_resq.return_to = resp.return_to;
            new_resq.realm = resp.realm;
            new_resq.ns = resp.ns;
            new_resq.mode = resp.mode;

            CST_Ops.recordme(new OpenID20NameSpace.Yahoo_IdP(), resp, new_resq, typeof(Yahoo_IdP).GetMethod("SignInIdP"));

            string final_url = RP.GenerateURL(new_resq);

            Response.Redirect(final_url);
        }

        protected void LogoutBtn_Click(Object sender, EventArgs e)
        {
            notLoggedIn.Visible = true;
            LoggedIn.Visible = false;
        }
    }

}