using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CST;
using ABC;

namespace ABC
{
    public class A
    {
        public A()
        {
        }
        public A(int i1)
        {
            data = i1;
        }
        public int data;

        public CST_Message invoke(CST_Message msg)
        {
            CST_Ops.recordme(msg);

            msg.value = data;
            msg.largestParty = "Alice";
            msg.SignedBy = "Alice";

            return msg;
        }
    }
}