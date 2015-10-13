using System.Diagnostics.Contracts;
using GenericAuthNameSpace;
using FBNameSpace;
using OAuth20NameSpace;
using CST;

class GlobalObjectsForCST : GlobalObjects_base
{
    static public void init()
    {
        ValidateTicket_Req = PoirotMain.Nondet.ValidateTicket_Req();
        AS = new Facebook_AP(); ((Facebook_AP)AS).init();
        RS = new Facebook_RS_For_vProgram();
    }
}
class PoirotMain
{
    public static NondetOAuth20 Nondet;

    static void Main() 
    {
        GlobalObjectsForCST.init();
        SynthesizedPortion.SynthesizedSequence();
    }
}