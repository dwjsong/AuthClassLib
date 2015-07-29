namespace GenericAuthNameSpace
{
    using System.Diagnostics.Contracts;
    using System.Web.SessionState;
    using CST;

    /***********************************************************/
    /*               Messages between parties                  */
    /***********************************************************/
    public abstract class SignInIdP_Req : CST_Struct
    {
        public string IdPSessionSecret;
        public abstract string Realm
        {
            get;
            set;
        }
    }

    public class SignInIdP_Resp_SignInRP_Req : CST_Struct
    {
    }

    public class SignInRP_Resp : CST_Struct
    {
    }
    
    
    /***********************************************************/
    /*               Data structures on parties                */
    /***********************************************************/
    
    public abstract class ID_Claim 
    {
        public abstract string UserID
        {
            get;
        }
        public abstract string Redir_dest
        {
            get;
        }
    }

    public interface IdPAuthRecords_Base
    {
        ID_Claim getEntry(string IdPSessionSecret, string Realm);
        bool setEntry(string IdPSessionSecret, string Realm, ID_Claim _ID_Claim);
    }


    /***********************************************************/
    /*                          Parties                        */
    /***********************************************************/
    public abstract class IdP 
    {
        public IdPAuthRecords_Base IdpAuthRecs;

        public virtual SignInIdP_Resp_SignInRP_Req SignInIdP(SignInIdP_Req req)
        {
            Contract.Assume(req == GlobalObjects_base.SignInIdP_Req);

            if (req == null) return null;
            ID_Claim _ID_Claim = Process_SignInIdP_req(req);
            if (IdpAuthRecs.setEntry(req.IdPSessionSecret, req.Realm, _ID_Claim) == false)
                return null;
            return Redir(_ID_Claim.Redir_dest, _ID_Claim);
        }

        public abstract ID_Claim Process_SignInIdP_req(SignInIdP_Req req);
        public abstract SignInIdP_Resp_SignInRP_Req Redir(string dest, ID_Claim _ID_Claim);
    }

    public abstract class RP
    {
        public HttpSessionState CurrentSession;
        public string Domain, Realm;
        public abstract SignInRP_Resp SignInRP(SignInIdP_Resp_SignInRP_Req req);
        public class AuthenticationConclusion: CST_Struct
        {
            public string SessionUID;
        }
        public virtual bool AuthenticationDone(AuthenticationConclusion conclusion)
        {
            bool CST_verified = CST_Ops.Certify(conclusion);
            CurrentSession["UserID"] = CST_verified?conclusion.SessionUID:"";
            return CST_verified;
        }       
    }


    /****************************************************************/
    /* The definition of the "Authentication/Authorization" problem */
    /****************************************************************/
    public class GlobalObjects_base
    {
        static public SignInIdP_Req SignInIdP_Req;
        static public IdP IdP;
        static public RP RP;

        static public void Assert_BadPersonCannotSignInAsGoodPerson(RP.AuthenticationConclusion conclusion)
        {
            ID_Claim ID_claim;
            ID_claim = IdP.IdpAuthRecs.getEntry(
                                 SignInIdP_Req.IdPSessionSecret,
                                 RP.Realm);
            Contract.Assert(ID_claim.Redir_dest == RP.Domain && ID_claim.UserID == conclusion.SessionUID);
        }

        //people can define other safety properties here ...
        //...
        //...

    }
}