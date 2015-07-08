namespace GenericAuthNameSpace
{
    using System.Diagnostics.Contracts;
    using System.Web.SessionState;
    using CST;

    /***********************************************************/
    /*               Messages between parties                  */
    /***********************************************************/
    public abstract class _SignInIdP_Req : _CST_Struct
    {
        public string IdPSessionSecret;
        public abstract string Realm
        {
            get;
        }
    }

    public class _SignInIdP_Resp_SignInRP_Req : _CST_Struct
    {
    }

    public class _SignInRP_Resp : _CST_Struct
    {
    }
    
    
    /***********************************************************/
    /*               Data structures on parties                */
    /***********************************************************/
    
    public abstract class _ID_Claim 
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

    public interface _IdPAuthRecords_Base
    {
        _ID_Claim getEntry(string IdPSessionSecret, string Realm);
        bool setEntry(string IdPSessionSecret, string Realm, _ID_Claim _ID_Claim);
    }


    /***********************************************************/
    /*                          Parties                        */
    /***********************************************************/
    public abstract class _IdP 
    {
        public _IdPAuthRecords_Base IdpAuthRecs;

        protected _SignInIdP_Resp_SignInRP_Req SignInIdP(_SignInIdP_Req req)
        {
            if (req == null) return null;
            _ID_Claim _ID_Claim = Process_SignInIdP_req(req);
            if (IdpAuthRecs.setEntry(req.IdPSessionSecret, req.Realm, _ID_Claim) == false)
                return null;
            return Redir(_ID_Claim.Redir_dest, _ID_Claim);
        }
 
        protected abstract _ID_Claim Process_SignInIdP_req(_SignInIdP_Req req);
        protected abstract _SignInIdP_Resp_SignInRP_Req Redir(string dest,_ID_Claim _ID_Claim);
    }

    public abstract class _RP
    {
        public HttpSessionState CurrentSession;
        public string Domain, Realm;
        public abstract _SignInRP_Resp SignInRP(_SignInIdP_Resp_SignInRP_Req req);
        public class AuthenticationConclusion: _CST_Struct
        {
            public string SessionUID;
        }
        public virtual bool AuthenticationDone(AuthenticationConclusion conclusion)
        {
            bool CST_verified = true; // DSVHelper.DSV_Check(authResult.SymT);
            CurrentSession["UserID"] = CST_verified?conclusion.SessionUID:"";
            return CST_verified;
        }       
    }


    /****************************************************************/
    /* The definition of the "Authentication/Authorization" problem */
    /****************************************************************/
    public class GlobalObjects_base
    {
        static public _SignInIdP_Req SignInIdP_Req;
        static public _IdP IdP;
        static public _RP RP;

        static public void Assert_BadPersonCannotSignInAsGoodPerson(_RP.AuthenticationConclusion conclusion)
        {
            _ID_Claim ID_claim;
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