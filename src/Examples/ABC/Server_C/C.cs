using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CST;
using ABC;
using System.Diagnostics.Contracts;
namespace ABC
{
    public class C
    {
        public C()
        {
        }

        public C(int i1)
        {
            data = i1;
        }

        public int data;
        public Message conclusion = new Message();

        public Message invoke(Message msg)
        {
            CST_Ops.recordme(msg);

            conclusion.value = msg.value;
            conclusion.largestParty = msg.largestParty;
            conclusion.SignedBy = msg.SignedBy;
            conclusion.SymT = msg.SymT;

            if (conclusion.value < data)
            {
                conclusion.largestParty = "Charles";
                conclusion.value = data;
            }
            conclusion.SignedBy = "Charles";

            if (conclude(conclusion))
            {
                msg.certified = true;
                Console.WriteLine("The largest party is " + conclusion.largestParty + ".");
            }
            else
            {
                msg.certified = false;
                Console.WriteLine("Not verified.");
            }

            return msg;
        }

        public bool conclude(Message msg)
        {
                        //return CST_Ops.certify(conclusion.SymT));
            // synthesize vProgram
            // verify it
            return CST_Ops.Certify(msg);
        }

    }
}
