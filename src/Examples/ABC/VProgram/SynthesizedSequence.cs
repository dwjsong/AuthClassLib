partial class PoirotMain
{
    static void call_SynthesizedSequence()
    {
          CST.CST_Message C1 = Nondet.CST_Message();
          CST.CST_Message C2 = A.invoke(C1);
          CST.CST_Message C3 = B.invoke(C2);
          CST.CST_Message C4 = C.invoke(C3);
    }
}