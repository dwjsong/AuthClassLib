namespace LiveIDNameSpace
{
    using GenericAuthNameSpace;
    using OpenID20NameSpace;
    using OpenIDExample;

    public class Yahoo_RP_For_vProgram : Yahoo_RP
    {
        public override bool AuthenticationDone(AuthenticationConclusion conclusion)
        {
            GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson(conclusion);
            return true;
        }
    }
}
