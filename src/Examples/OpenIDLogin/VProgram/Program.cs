using System.Diagnostics.Contracts;
using GenericAuthNameSpace;
using LiveIDNameSpace;
using OpenIDExample;
using CST;
using OpenID20NameSpace;
class GlobalObjectsForCST : GlobalObjects_base
{
    static public void init()
    {
        SignInIdP_Req = PoirotMain.Nondet.AuthenticationRequest();
        IdP = new YahooIdP();
        RP = new Yahoo_RP_For_vProgram();
    }
}
class PoirotMain
{
    public static NondetOpenID20 Nondet;

    static void Main() 
    {
        GlobalObjectsForCST.init();
        SynthesizedPortion.SynthesizedSequence();       
    }
}