using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ABC;
using CST;

namespace Server_B
{
    public partial class B_invoke : System.Web.UI.Page
    {
        B server_b = new B(45);
        protected void Page_Load(object sender, EventArgs e)
        {
            CST_Message m = new CST_Message();
            if (CST_Message.parse(m, Request))
            {
                CST_Message m2 = server_b.invoke(m);

                CST_Message.respond(m2, Response);
            }
        }
    }
}