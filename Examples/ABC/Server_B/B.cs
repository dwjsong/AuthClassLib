using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CST;
using ABC;

namespace ABC
{
    public class B
    {
        public B()
        {
        }
        public B(int i1)
        {
            data = i1;
        }
        public int data;
        public CST_Message invoke(CST_Message msg)
        {
            CST_Ops.recordme(msg);

            if (msg.value < data)
            {
                msg.value = data;
                msg.largestParty = "Bob";
            }
            msg.SignedBy= "Bob";
            return msg;
        }
    }
}
