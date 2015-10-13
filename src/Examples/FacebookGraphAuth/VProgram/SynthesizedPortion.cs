public class SynthesizedPortion
{
    public static void SynthesizedSequence()
    {
        OAuth20NameSpace.ResourceRequest O1 = PoirotMain.Nondet.ResourceRequest();
        OAuth20NameSpace.ValidateTokenRequest O2 = ((FBNameSpace.Facebook_RS)GlobalObjectsForCST.RS).createValidateTokenRequest(O1);
        GenericAuthNameSpace.ValidateTicket_Req G2 = (GenericAuthNameSpace.ValidateTicket_Req)O2;
        GenericAuthNameSpace.ValidateTicket_Resp_ValidateTicket_Req G3 = ((FBNameSpace.Facebook_AP)GlobalObjectsForCST.AS).ValidateTicket(G2);
        OAuth20NameSpace.ValidateTokenResponse O3 = (OAuth20NameSpace.ValidateTokenResponse)G3;
        System.Boolean S4 = ((FBNameSpace.Facebook_RS)GlobalObjectsForCST.RS).conclude(O3);
    }
}