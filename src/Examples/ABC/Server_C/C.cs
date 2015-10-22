using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CST;
using ABC;
using System.Diagnostics.Contracts;
using System.Diagnostics;
using System.IO;
using CST_Message;

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

        public Message invoke(Message in_msg)
        {
            Stopwatch stopWatch = new Stopwatch();
            stopWatch.Start();
            CST_Ops.recordme(this, in_msg, conclusion);
            stopWatch.Stop();

            string path = @"C:\Users\Daniel Song\Desktop\Charlie.txt";
            if (!File.Exists(path))
            {
                using (StreamWriter sw = File.CreateText(path))
                {
                    sw.WriteLine(stopWatch.ElapsedMilliseconds);
                }
            }
            else
            {
                using (StreamWriter sw = File.AppendText(path))
                {
                    sw.WriteLine(stopWatch.ElapsedMilliseconds);
                }

            }

            conclusion.value = in_msg.value;
            conclusion.largestParty = in_msg.largestParty;
            conclusion.SignedBy = in_msg.SignedBy;

            if (conclusion.value < data)
            {
                conclusion.largestParty = "Charles";
                conclusion.value = data;
            }
            conclusion.SignedBy = "Charles";

            if (conclude(conclusion))
            {
                conclusion.certified = true;
                Console.WriteLine("The largest party is " + conclusion.largestParty + ".");
            }
            else
            {
                conclusion.certified = false;
                Console.WriteLine("Not verified.");
            }

            return conclusion;
        }

        public bool conclude(Message msg)
        {
            Stopwatch stopWatch = new Stopwatch();
            stopWatch.Start();
            bool result = CST_Ops.CertifyLocally(msg);
            string path = @"C:\Users\Daniel Song\Desktop\ABC_Certify.txt";
            if (!File.Exists(path))
            {
                using (StreamWriter sw = File.CreateText(path))
                {
                    sw.WriteLine(stopWatch.ElapsedMilliseconds);
                }
            }
            else
            {
                using (StreamWriter sw = File.AppendText(path))
                {
                    sw.WriteLine(stopWatch.ElapsedMilliseconds);
                }

            }
            return result;
        }

    }
}
