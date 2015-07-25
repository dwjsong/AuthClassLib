namespace LiveIDNameSpace
{
    using GenericAuthNameSpace;
    using OpenID20NameSpace;
    using System.Diagnostics.Contracts;

    public class Yahoo_RP_For_vProgram : Yahoo_RP
    {
        public override bool AuthenticationDone(AuthenticationConclusion conclusion)
        {
            ID_Claim ID_claim;
            ID_claim = GlobalObjectsForCST.IdP.IdpAuthRecs.getEntry(
                                 GlobalObjectsForCST.SignInIdP_Req.IdPSessionSecret,
                // GlobalObjectsForCST.RP.Realm);
                                GlobalObjectsForCST.SignInIdP_Req.Realm);

           Contract.Assert(ID_claim.UserID == conclusion.SessionUID);
           // Contract.Assert(GlobalObjectsForCST.RP.Realm == GlobalObjectsForCST.SignInIdP_Req.Realm);

            return true;
        }
    }
}
