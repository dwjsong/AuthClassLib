using System.Diagnostics.Contracts;
public class SynthesizedPortion
{
    public static void SynthesizedSequence()
    {
 /*       string x = "aaa";
        GlobalObjectsForCST.SignInIdP_Req.Realm = x;
        Contract.Assert(GlobalObjectsForCST.SignInIdP_Req.Realm == x);
        Contract.Assert(false);
*/
          OpenIDConnectNameSpace.AuthenticationResponse O1 = PoirotMain.Nondet.AuthenticationResponse();
          OpenIDConnectNameSpace.TokenRequest O2 = ((LiveIDNameSpace.LiveID_RP)GlobalObjectsForCST.RP).constructTokenRequest(O1);
          OpenIDConnectNameSpace.TokenResponse O3 = ((LiveIDNameSpace.LiveID_IdP)GlobalObjectsForCST.IdP).TokenEndpoint(O2);
          GenericAuthNameSpace.RP.AuthenticationConclusion G4 = ((LiveIDNameSpace.LiveID_RP)GlobalObjectsForCST.RP).conclude(O3);
//          Contract.Assert(false);
    }
}