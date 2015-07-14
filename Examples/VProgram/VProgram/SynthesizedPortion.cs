public class SynthesizedPortion
{
    public static void SynthesizedSequence()
    {
          OpenIDConnectNameSpace.AuthenticationResponse O1 = PoirotMain.Nondet.AuthenticationResponse();
          OpenIDConnectNameSpace.TokenRequest O2 = ((OpenIDConnectNameSpace.RelyingParty)GlobalObjectsForCST.RP).constructTokenRequest(O1);
          OpenIDConnectNameSpace.TokenResponse O3 = ((OpenIDConnectNameSpace.OpenIDProvider)GlobalObjectsForCST.IdP).TokenEndpoint(O2);
          GenericAuthNameSpace.RP.AuthenticationConclusion G4 = ((OpenIDConnectNameSpace.RelyingParty)GlobalObjectsForCST.RP).conclude(O3);
    }
}