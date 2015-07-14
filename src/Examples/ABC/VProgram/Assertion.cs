using System.Diagnostics.Contracts;
partial class PoirotMain
{
    static void check_Assertion()
    {
        Contract.Assert(
                 (!(C.conclusion.largestParty == "Alice") ||
                 ((A.data >= B.data) && (A.data >= C.data)))
                 );
    }
}