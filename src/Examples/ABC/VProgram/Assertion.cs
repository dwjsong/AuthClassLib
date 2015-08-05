using System.Diagnostics.Contracts;
using ABC;
partial class PoirotMain
{
    static void check_Assertion()
    {
        Contract.Assert(
                 (!(GlobalObjectsForCST.C.conclusion.largestParty == "Alice") ||
                 ((GlobalObjectsForCST.A.data >= GlobalObjectsForCST.B.data) && (GlobalObjectsForCST.A.data >= GlobalObjectsForCST.C.data)))
                 );
    }
}