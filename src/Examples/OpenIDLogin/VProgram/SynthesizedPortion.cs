public class SynthesizedPortion
{
    public static void SynthesizedSequence()
    {
          OpenID20NameSpace.AuthenticationRequest O1 = PoirotMain.Nondet.AuthenticationRequest();
          OpenID20NameSpace.AuthenticationRequest O2 = ((OpenID20NameSpace.RelyingParty)GlobalObjectsForCST.RP).RequestAuthentication(O1);
          OpenID20NameSpace.AuthenticationResponse O3 = ((OpenID20NameSpace.OpenIDProvider)GlobalObjectsForCST.IdP).ProcessAuthenticationRequest(O2);
          GenericAuthNameSpace.RP.AuthenticationConclusion G4 = ((OpenIDExample.Yahoo_RP)GlobalObjectsForCST.RP).conclude(O3);
    }
}