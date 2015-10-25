﻿namespace GenericAuthNameSpace
{
    using System.Diagnostics.Contracts;
    using System.Web.SessionState;
    using CST;
    using System.Web;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.IO;

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

    public abstract class Ticket : CST_Struct   //shuo:   this will become the access token in OAuth
    {
        public abstract string ticket
        {
            get;
            set;
        }
    }

    public class Permission : CST_Struct       //shuo : this will become an element in the "scope" list in OAuth
    {
        public string name;

        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;

            Permission p = obj as Permission;
            if (p == null)
                return false;

            return this.name == p.name;
        }

        public override int GetHashCode()
        {
            return name.GetHashCode();
        }
    }

    public class Permissions
    {
        public HashSet<Permission> permissionSet;
    }

    public abstract class Resource : CST_Struct
    {
        public string name;
        public abstract object value
        {
            get;
            set;
        }
    }

    public class Resources
    {
        public HashSet<Resource> resourceSet;
    }

    public abstract class AuthTicketAS_Req : CST_Struct  
    {
        public abstract Ticket ticket
        {
            get;
            set;
        }
        public abstract string Realm
        {
            get;
            set;
        }
    }

    public abstract class AuthTicketAS_Resp : CST_Struct
    {
        public abstract Ticket ticket
        {
            get;
            set;
        }
        public abstract string Realm
        {
            get;
            set;
        }
    }

    public abstract class ReqResourceRS_Req : CST_Struct
    {
        public abstract Ticket ticket
        {
            get;
            set;
        }
        public abstract string Realm
        {
            get;
            set;
        }

        public Resource resource;
        public string UserID;
    }

    public abstract class ReqResourceRS_Resp : CST_Struct
    {
        public abstract Ticket ticket
        {
            get;
            set;
        }
        public abstract string Realm
        {
            get;
            set;
        }

        public Resources resources;
        public string UserID;
    }

    public abstract class ValidateTicket_Req : CST_Struct
    {
        public abstract Ticket ticket
        {
            get;
            set;
        }
        public abstract string Realm
        {
            get;
            set;
        }
        public abstract string UserID
        {
            get;
            set;
        }
        public abstract Permissions permissions
        {
            get;
            set;
        }
    }

    public abstract class ValidateTicket_Resp : CST_Struct
    {
        public abstract Ticket ticket
        {
            get;
            set;
        }
        public abstract string Realm
        {
            get;
            set;
        }
        public abstract string UserID
        {
            get;
            set;
        }

        public abstract Permissions permissions
        {
            get;
            set;
        }
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

    public abstract class Permission_Claim
    {
        public abstract string UserID
        {
            get;
        }
        public abstract Permissions permissions
        {
            get;
        }
        public abstract string Realm
        {
            get;
        }
        public abstract string Redir_dest
        {
            get;
        }
    }

    public interface ASAuthTicketRecords_Base
    {
        bool setEntry(Ticket ticket, string Realm, string UserID, Permission_Claim claim);
        Permission_Claim getEntry(Ticket ticket, string Realm, string UserID);    
    }

     public interface RSResourceRecords_Base
     {
         bool setEntry(string UserID, Permission permission, Resource resource);
         Resource getEntry(string UserID, Permission permission);

     }


    /***********************************************************/
    /*                          Parties                        */
    /***********************************************************/

    /***********************************************************/
    /*         AS stands for Authority Server                  */
    /*         AS is both IdP and Authorizastion Server        */
    /***********************************************************/

    public abstract class AS                   //shuo: let's call it "Authority Server (AS)" rather than "Authority Provider (AP)"
    {
        public IdPAuthRecords_Base IdpAuthRecs;
        public ASAuthTicketRecords_Base ASAuthRecs;

        public virtual SignInIdP_Resp_SignInRP_Req SignInIdP(SignInIdP_Req req)
        {
            GlobalObjects_base.SignInIdP_Req = req;

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
        public HttpSessionStateBase CurrentSession;
        public string Domain, Realm;
        public abstract SignInRP_Resp SignInRP(SignInIdP_Resp_SignInRP_Req req);
        public class AuthenticationConclusion: CST_Struct
        {
            public string SessionUID;
        }
        public virtual bool AuthenticationDone(AuthenticationConclusion conclusion)
        {
            Stopwatch stopWatch = new Stopwatch();
            stopWatch.Start();

            bool CST_verified = CST_Ops.CertifyLocally(conclusion);
            stopWatch.Stop();
            string path = @"C:\Users\Daniel Song\Desktop\Certify.txt";
            if (!File.Exists(path))
            {
                using (StreamWriter sw = File.CreateText(path))
                {
                    sw.WriteLine(stopWatch.ElapsedMilliseconds);
                }
            }
            else
            {
                using (StreamWriter sw = File.AppendText(path))
                {
                    sw.WriteLine(stopWatch.ElapsedMilliseconds);
                }

            }

            if (CurrentSession["UserID"] != null)
                CurrentSession["UserID"] = CST_verified?conclusion.SessionUID:"";
            else
                CurrentSession.Add("UserID", CST_verified ? conclusion.SessionUID : "");
            return CST_verified;
        }

    }

    /***********************************************************/
    /*               Resource Server                           */
    /***********************************************************/

    public abstract class RS
    {
        public RSResourceRecords_Base RSResourceRecs;
        public string Domain, Realm;

        public class AuthorizationConclusion : CST_Struct
        {
            public Ticket ticket;
            public Permissions permissions;
            public string Realm;
            public string UserID;
        }

        public virtual bool RequestResourceDone(AuthorizationConclusion conclusion)
        {
            Stopwatch stopWatch = new Stopwatch();
            stopWatch.Start();

            bool CST_verified = CST_Ops.CertifyLocally(conclusion);
            stopWatch.Stop();
            string path = @"C:\Users\Daniel Song\Desktop\Certify.txt";
            if (!File.Exists(path))
            {
                using (StreamWriter sw = File.CreateText(path))
                {
                    sw.WriteLine(stopWatch.ElapsedMilliseconds);
                }
            }
            else
            {
                using (StreamWriter sw = File.AppendText(path))
                {
                    sw.WriteLine(stopWatch.ElapsedMilliseconds);
                }

            }
            return CST_verified;
        }
    }

    /****************************************************************/
    /* The definition of the "Authentication/Authorization" problem */
    /****************************************************************/
    public class GlobalObjects_base
    {
        static public SignInIdP_Req SignInIdP_Req;
        static public ValidateTicket_Req ValidateTicket_Req;
        static public AS AS;
        static public RP RP;
        static public RS RS;

        static public void Assert_BadPersonCannotSignInAsGoodPerson(RP.AuthenticationConclusion conclusion)
        {
            ID_Claim ID_claim;
            ID_claim = AS.IdpAuthRecs.getEntry(
                                 SignInIdP_Req.IdPSessionSecret,
                                 RP.Realm);
            Contract.Assert(ID_claim.Redir_dest == RP.Domain && ID_claim.UserID == conclusion.SessionUID);
        }

        static public void Assert_BadPersonCannotAccessGoodPersonsResource(RS.AuthorizationConclusion conclusion)
        {
            Permission_Claim _Permission_Claim;

            _Permission_Claim = AS.ASAuthRecs.getEntry(ValidateTicket_Req.ticket, RS.Realm, ValidateTicket_Req.UserID);
            Contract.Assert(_Permission_Claim.permissions.permissionSet == conclusion.permissions.permissionSet && 
                            _Permission_Claim.Realm == RS.Realm &&
                            _Permission_Claim.UserID == conclusion.UserID);
        }


        /*
        //shuo:
        I don't remember where is AuthenticationConclusion is defined. AuthorizationConclusion should be defined there too.
        
         * class AuthorizationConclusion {
         *    string grant, Resource, UserID;
         * }
         * 
         * The AuthorizationConclusion means that: because the request carries this "grant", the RS has decided to the release this kind of "resource" (e.g., photos) owned by this "UserID".
         * so the ambient predicate should be: if I use the grant to retrieve the Permission_Claim, then the Permission_Claim should matches the UserID and Realm, and the Permission (e.g., PhotoAccess) in the Permission_Claim should covers this kind of resource (e.g., Photo).



        */
        //people can define other safety properties here ...
        //...
        //...
    }
}