using System.Diagnostics.Contracts;
using System.Text;
using CST;

partial class PoirotMain
{
     interface NondetVProgram : CST.Nondet_Base
      {
          CST.CST_Message CST_Message();
      }
      static NondetVProgram Nondet;
      static ABC.A A = new ABC.A(Nondet.Int());
      static ABC.B B = new ABC.B(Nondet.Int());
      static ABC.C C = new ABC.C(Nondet.Int());

      static void Main()
      {
		  Contract.Assert(false);
          call_SynthesizedSequence();
          check_Assertion();        
      }
}
