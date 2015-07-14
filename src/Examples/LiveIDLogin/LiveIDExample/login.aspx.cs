using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using OpenIDConnectNameSpace;
using LiveIDNameSpace;

partial class login : System.Web.UI.Page 
{
    LiveID_RP RP=new LiveID_RP();

    protected void Page_Load(object sender, EventArgs e)
    {
        RP.CurrentSession = Session;
        AuthenticationResponse codeResp = RP.parseAuthenticationResponse(HttpContext.Current.Request);
        if (codeResp == null) return;
        RP.SignInRP(codeResp);
    }
}
