using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OpenID20NameSpace;
using GenericAuthNameSpace;

namespace OpenIDExample
{
    public class OpenID20_RP : RelyingParty
    {
        public override SignInRP_Resp SignInRP(SignInIdP_Resp_SignInRP_Req req)
        {
            return new SignInRP_Resp();
        }
        public void SignIn()
        {

        }
    }
}