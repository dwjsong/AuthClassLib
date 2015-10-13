namespace FBNameSpace
{
    using GenericAuthNameSpace;
    using OAuth20NameSpace;
    using System.Diagnostics.Contracts;

    public class Facebook_RS_For_vProgram : Facebook_RS
    {
        public override bool RequestResourceDone(AuthorizationConclusion conclusion)
        {
            GlobalObjects_base.Assert_BadPersonCannotAccessGoodPersonsResource(conclusion);
            
            return true;
        }
    }
}
