public class SynthesizedPortion
{
    public static void SynthesizedSequence()
    {
          GenericAuthNameSpace.SignInIdP_Req G1 = PoirotMain.Nondet.SignInIdP_Req();
          GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req G2 = ((OpenID20NameSpace.Yahoo_IdP)GlobalObjectsForCST.IdP).SignInIdP(G1);
          GenericAuthNameSpace.SignInRP_Resp G3 = ((OpenID20NameSpace.Yahoo_RP)GlobalObjectsForCST.RP).SignInRP(G2);
    }
}