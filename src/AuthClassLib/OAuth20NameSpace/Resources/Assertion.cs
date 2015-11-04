namespace OAuth20NameSpace
{
    using GenericAuthNameSpace;
    using OAuth20NameSpace;
    using System.Diagnostics.Contracts;

    public class For_vProgram : ResourceServerImpl
    {
        public override bool RequestResourceDone(AuthorizationConclusion conclusion)
        {
            GlobalObjects_base.PermissionsHaveBeenGrantedByOwner(conclusion);
            
            return true;
        }
    }
}
