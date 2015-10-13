namespace LiveIDNameSpace
{
    using GenericAuthNameSpace;
    using OpenIDConnectNameSpace;
    using System.Diagnostics.Contracts;
    public class LiveID_RP_For_vProgram : LiveID_RP
    {
        public override bool AuthenticationDone(AuthenticationConclusion conclusion)
        {
            GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson(conclusion);
            return true;
        }
    }
}
