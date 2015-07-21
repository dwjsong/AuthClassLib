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
                notLoggedIn.Visible = false;
                LoggedIn.Visible = true;

                logged_id.InnerHtml = String.Format("Your ID is {0} and SymT is {1}", Request.Params["openid.identity"], Request.Params["SymT"]);

                RP.AuthenticationConclusion d = new RP.AuthenticationConclusion();
                d.SymT = Request.Params["SymT"];

                AuthenticationResponse req = new AuthenticationResponse();
                req.SymT = Request.Params["SymT"];

                RP.conclude(req);


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
            AuthenticationRequest req = new AuthenticationRequest();

            var resp = RP.RequestAuthentication(req);

            /* HACK for Yahoo IdP */
            AuthenticationRequest new_resq = new AuthenticationRequest();
            new_resq.SymT = resp.SymT;
            new_resq.claimed_id = resp.claimed_id;
            new_resq.identity = resp.identity;
            new_resq.return_to = resp.return_to;
            new_resq.realm = resp.realm;
            new_resq.ns = resp.ns;
            new_resq.mode = resp.mode;
            CST_Ops.recordme(new_resq, typeof(OpenIDProvider).GetMethod("ProcessAuthenticationRequest"));

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