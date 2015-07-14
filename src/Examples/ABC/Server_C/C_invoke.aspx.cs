using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ABC;
using CST;

namespace Server_C
{
    public partial class C_invoke : System.Web.UI.Page
    {
        C server_c = new C(50);
        protected void Page_Load(object sender, EventArgs e)
        {
            CST_Message m = new CST_Message();
            if (CST_Message.parse(m, Request))
            {
                CST_Message m2 = server_c.invoke(m);

                CST_Message.respond(m2, Response);
            }
        }
    }
}