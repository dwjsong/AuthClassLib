namespace OAuth20NameSpace
{
    using System.Collections.Generic;
    using CST;
    using GenericAuthNameSpace;

    /***********************************************************/
    /*               Messages between parties                  */
    /***********************************************************/

    public class AuthorizationRequest : SignInIdP_Req
    {
        public string response_type;
        public string client_id;

        public override string Realm
        {
            get { return client_id; }
            set { client_id = value; }
        }
        public string redirect_uri = null;
        public HashSet<string> scope;
        public string state = null;
    }

    public class AuthorizationResponse : SignInIdP_Resp_SignInRP_Req
    {
        public string code;
        public string state = null;
    }

    class AuthorizationErrorResponse : SignInIdP_Resp_SignInRP_Req
    {
        protected string error;
        protected string error_description = null, error_uri = null;
        protected string state = null;
    }

    public class AccessTokenRequest : CST_Struct
    {
        public string grant_type;
        public string code;
        public string redirect_uri;
        public string client_id;
        public string refresh_token = null;
    }

    public class AccessTokenResponse : CST_Struct
    {
        public string access_token;
        public string token_type;
        public string expires_in;
        public string refresh_token = null;
        public HashSet<string> scope;
    }


    /***********************************************************/
    /*               Data structures on parties                */
    /***********************************************************/

    public class AuthorizationCodeEntry : ID_Claim
    {
        public string code;
        public override string UserID
        {
            get { return code; }
        }
        public string redirect_uri;
        public override string Redir_dest
        {
            get { return redirect_uri; }
        }
        public HashSet<string> scope;
        public string state;
    }

    public class AccessTokenEntry : ID_Claim
    {
        public string access_token;
        public override string UserID
        {
            get { return access_token; }
        }
        public string redirect_uri;
        public override string Redir_dest
        {
            get { return redirect_uri; }
        }
        public HashSet<string> scope;
        public string refresh_token;
        public string state;
    }

    public interface AuthorizationCodeRecs : IdPAuthRecords_Base
    {
        string findISSByClientIDAndCode(string client_id, string authorization_code);
    }

    public interface AccessTokenRecs : IdPAuthRecords_Base
    {
        string findISSByClientIDAndAccessToken(string client_id, string access_token);
        string findISSByClientIDAndRefreshToken(string client_id, string refresh_token);
    }


    /***********************************************************/
    /*                          Parties                        */
    /***********************************************************/
    public abstract class Client: RP
    {
        public string client_id
        {
            get { return Realm; }
            set { Realm = value; }
        }
        public string return_uri
        {
            get { return Domain; }
            set { Domain = value; }
        }
        public string client_secret;
        public string TokenEndpointUrl;
        public Client(string client_id1, string return_uri1, string client_secret1, string TokenEndpointUrl1)
        {
            client_id = client_id1;
            return_uri = return_uri1;
            client_secret = client_secret1;
            TokenEndpointUrl = TokenEndpointUrl1;
        }
        public AccessTokenRequest AuthorizationCodeGrant(AuthorizationResponse codeResp)
        {
            AccessTokenRequest tokenReq = new AccessTokenRequest();
            tokenReq.client_id = client_id;
            tokenReq.code = codeResp.code;
            tokenReq.grant_type = "authorization_code";
            tokenReq.redirect_uri = return_uri;
            return tokenReq;
        }

    }

    class resource_server
    {
    }

    public abstract class AuthorizationServer: IdP
    {
        public AuthorizationCodeRecs AuthorizationCodeRecs;
        protected AccessTokenRecs AccessTokenRecs
        {
            get { return (AccessTokenRecs)IdpAuthRecs; }
            set { IdpAuthRecs = value; }
        }
        public void init(AuthorizationCodeRecs AuthorizationCodeRecs1, AccessTokenRecs AccessTokenRecs1)
        {
            AuthorizationCodeRecs = AuthorizationCodeRecs1;
            AccessTokenRecs = AccessTokenRecs1;
        }
        public override ID_Claim Process_SignInIdP_req(SignInIdP_Req req1)
        {
            AuthorizationRequest req = (AuthorizationRequest)req1;
            switch (req.response_type)
            {
                case "code":
                    return createAuthorizationCodeEntry(req);                   
                case "token":
                    return createAccessTokenEntry(req.redirect_uri,req.scope,req.state);
                default:
                    return null;
            }
        }
        protected AuthorizationResponse AuthorizationEndpoint(AuthorizationRequest req)
        {
            return (AuthorizationResponse)SignInIdP(req);
        }
        protected AccessTokenResponse TokenEndpoint(AccessTokenRequest req)
        {
            AccessTokenEntry AccessTokenEntry;
            AccessTokenResponse resp;
            string IdPSessionSecret;
            if (req == null) return null;
            switch (req.grant_type)
            {
                case "authorization_code":
                    IdPSessionSecret = AuthorizationCodeRecs.findISSByClientIDAndCode(req.client_id, req.code);
                    if (IdPSessionSecret == null)
                        return null;
                    AuthorizationCodeEntry AuthCodeEntry =(AuthorizationCodeEntry)AuthorizationCodeRecs.getEntry(IdPSessionSecret,req.client_id);
                    if (AuthCodeEntry.redirect_uri != req.redirect_uri)
                        return null;
                    AccessTokenEntry = createAccessTokenEntry(AuthCodeEntry.redirect_uri, AuthCodeEntry.scope, AuthCodeEntry.state);
                    if (AccessTokenRecs.setEntry(IdPSessionSecret,req.client_id, AccessTokenEntry)==false)
                        return null;
                    resp = new AccessTokenResponse();
                    resp.access_token = AccessTokenEntry.access_token;
                    resp.refresh_token = AccessTokenEntry.refresh_token;
                    resp.scope = AccessTokenEntry.scope;
                    return resp;
                case "refresh_token":
                    IdPSessionSecret = AccessTokenRecs.findISSByClientIDAndRefreshToken(req.client_id, req.code);
                    if (IdPSessionSecret == null)
                        return null;
                    AccessTokenEntry = (AccessTokenEntry)AccessTokenRecs.getEntry(IdPSessionSecret, req.client_id);
                    AccessTokenEntry newAccessTokenEntry = createAccessTokenEntry(AccessTokenEntry.redirect_uri, AccessTokenEntry.scope, AccessTokenEntry.state);
                    if (AccessTokenRecs.setEntry(IdPSessionSecret, req.client_id, newAccessTokenEntry) == false)
                        return null;
                    resp = new AccessTokenResponse();
                    resp.access_token = AccessTokenEntry.access_token;
                    resp.refresh_token = AccessTokenEntry.refresh_token;
                    resp.scope = AccessTokenEntry.scope;
                    return resp;
                default:
                    return null;
            }
        }
        public abstract AuthorizationCodeEntry createAuthorizationCodeEntry(AuthorizationRequest req);
        public abstract AccessTokenEntry createAccessTokenEntry(string redirect_uri, HashSet<string> scope, string state);
    }
}