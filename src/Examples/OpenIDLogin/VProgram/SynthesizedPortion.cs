public class SynthesizedPortion
{
    public static void SynthesizedSequence()
    {
//          OpenID20NameSpace.AuthenticationRequest O1 = PoirotMain.Nondet.AuthenticationRequest();
        GlobalObjectsForCST.SignInIdP_Req.Realm = GlobalObjectsForCST.RP.Realm;
        OpenID20NameSpace.AuthenticationResponse O2 = ((OpenID20NameSpace.Yahoo_IdP)GlobalObjectsForCST.IdP).ProcessAuthenticationRequest((OpenID20NameSpace.AuthenticationRequest)GlobalObjectsForCST.SignInIdP_Req);

          if (O2.return_to != GlobalObjectsForCST.RP.Realm)
              return;
            GenericAuthNameSpace.RP.AuthenticationConclusion G3 = ((OpenID20NameSpace.Yahoo_RP)GlobalObjectsForCST.RP).conclude(O2);
    }
}