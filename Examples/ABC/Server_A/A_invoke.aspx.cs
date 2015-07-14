using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ABC;
using CST;

namespace Server_A
{
    public partial class A_invoke : System.Web.UI.Page
    {
        A server_a = new A(40);
        protected void Page_Load(object sender, EventArgs e)
        {
            CST_Message m = new CST_Message();
            if (CST_Message.parse(m, Request))
            {
                CST_Message m2 = server_a.invoke(m);

                CST_Message.respond(m2, Response);
            }
        }
    }
}