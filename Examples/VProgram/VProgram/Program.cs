using System.Diagnostics.Contracts;
using GenericAuthNameSpace;
using LiveIDNameSpace;
using OpenIDConnectNameSpace;
using CST;
class GlobalObjectsForCST : GlobalObjects_base
{
    static public void init()
    {
        SignInIdP_Req = PoirotMain.Nondet.AuthenticationRequest();
        IdP = new LiveID_IdP(); ((LiveID_IdP)IdP).init();
        RP=new LiveID_RP_For_vProgram();
    }
}
class PoirotMain
{
    public static NondetOpenIDConnect Nondet;
    static void Main() 
    {
        GlobalObjectsForCST.init();
        SynthesizedPortion.SynthesizedSequence();       
    }
}