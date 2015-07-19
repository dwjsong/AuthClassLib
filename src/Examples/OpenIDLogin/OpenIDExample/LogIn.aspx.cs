using OpenID20NameSpace;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OpenIDExample
{
    public partial class LogIn : System.Web.UI.Page
    {
        OpenID20_RP RP = new OpenID20_RP();

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthenticationRequest m = new AuthenticationRequest();


            /*
            if (AuthenticationRequest.parse(m, Request))
            {
                m = RP.RequestAuthentication();


                //redir
                //CST_Message.Redir(m, Response);
            }*/

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
    }
}