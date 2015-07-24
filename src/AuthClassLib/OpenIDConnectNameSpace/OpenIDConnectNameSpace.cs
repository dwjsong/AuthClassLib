namespace OpenIDConnectNameSpace
{
    using System;
    using System.IO;
    using System.Web;
    using System.Net;
    using System.Runtime.Serialization;
    using System.Runtime.Serialization.Json;
    using System.Collections.Generic;
    using GenericAuthNameSpace;
    using OAuth20NameSpace;
    using CST;

    /***********************************************************/
    /*               Messages between parties                  */
    /***********************************************************/

    public class AuthenticationRequest : AuthorizationRequest
    {
        public string response_mode = null;
        public string nonce = null;
        public string display = null;
        public string prompt = null;
        public string max_age = null;
        public string ui_locales = null;
        public string id_token_hint = null;
        public string login_hint = null;
        public string acr_values = null;
    }

    public class AuthenticationResponse : AuthorizationResponse
    {
    }
    
    public class TokenRequest : AccessTokenRequest
    {
    }
    
    public class TokenResponse : AccessTokenResponse
    {
        internal JsonWebToken id_token;
        internal bool parseJasonDataStructure(JsonDataStrcuture JsonDataStrcuture, string clientSecret)
        {
            access_token = JsonDataStrcuture.AccessToken;
            refresh_token = JsonDataStrcuture.RefreshToken;
            expires_in = JsonDataStrcuture.ExpiresIn;
            //scope needs to be handled

            Dictionary<int, string> keys = new Dictionary<int, string>();
            keys.Add(1, clientSecret);
            try
            {
                id_token = new JsonWebToken(JsonDataStrcuture.AuthenticationToken, keys);
                if (id_token != null)    
                    return true;
                else
                    return false;
            }
            catch (Exception e)
            {
                return false;
            }
        }
    }


    [DataContract]
    public class JsonDataStrcuture
    {
        [DataMember(Name = "access_token")]
        public string AccessToken { get; set; }

        [DataMember(Name = "authentication_token")]
        public string AuthenticationToken { get; set; }

        [DataMember(Name = "refresh_token")]
        public string RefreshToken { get; set; }

        [DataMember(Name = "expires_in")]
        public string ExpiresIn { get; set; }

        [DataMember(Name = "scope")]
        public string Scope { get; set; }
    }

    /***********************************************************/
    /*               Data structures on parties                */
    /***********************************************************/
    
    public class IDTokenAndAccessTokenEntry : AccessTokenEntry
    {
        public JsonWebToken id_token;
        public override string Redir_dest
        {
            get { return redirect_uri; }
        }
        public override string UserID
        {
            get { return id_token.Claims.UserId; }
        }
    }

    public interface IDTokenAndAccessTokenRecs : AccessTokenRecs
    {
    }


    /***********************************************************/
    /*                          Parties                        */
    /***********************************************************/

    public abstract class RelyingParty : Client
    {
        public RelyingParty(string client_id1, string return_uri1, string client_secret1, string TokenEndpointUrl1)
            :base(client_id1, return_uri1, client_secret1, TokenEndpointUrl1){}
        public AuthenticationResponse parseAuthenticationResponse(HttpRequest rawRequest)
        {
            AuthenticationResponse r = new AuthenticationResponse();
            HttpContext context = HttpContext.Current;
            r.code = rawRequest.QueryString["code"];
            r.state = rawRequest.QueryString["state"];
            if (string.IsNullOrEmpty(r.code))
                return null;
            else
                return r;
        }
        public AuthenticationConclusion AuthenticationUsingAuthorizationCodeFlow(AuthenticationResponse codeResp)
        {
            TokenRequest tokenReq = constructTokenRequest(codeResp);
            TokenResponse tokenResp= callTokenEndpoint(tokenReq);
            if (tokenResp == null) 
                return null;

            return conclude(tokenResp);
        }
        public TokenRequest constructTokenRequest(AuthenticationResponse codeResp)
        {
            TokenRequest tokenReq = new TokenRequest();
            tokenReq.code = codeResp.code;
            tokenReq.grant_type = "authorization_code";
            tokenReq.redirect_uri = return_uri; 
            tokenReq.client_id =client_id;
            tokenReq.SymT = codeResp.SymT;
            CST_Ops.recordme(this, tokenReq);

            return tokenReq;
        } 
        public virtual TokenResponse callTokenEndpoint(TokenRequest req)
        {
            JsonDataStrcuture JsonDataStrcuture = new JsonDataStrcuture();

            string postContent = String.Format("client_id={0}&redirect_uri={1}&client_secret={2}&code={3}&grant_type=authorization_code",
                HttpUtility.UrlEncode(req.client_id),
                HttpUtility.UrlEncode(req.redirect_uri),
                HttpUtility.UrlEncode(client_secret),
                HttpUtility.UrlEncode(req.code),
                HttpUtility.UrlEncode(req.grant_type));

            HttpWebResponse response = HTTP.HTTPComm.HttpReq(TokenEndpointUrl, postContent, "POST");
            if (response != null)
            {
                DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(JsonDataStrcuture));
                JsonDataStrcuture = serializer.ReadObject(response.GetResponseStream()) as JsonDataStrcuture;
                if (JsonDataStrcuture != null)
                {
                    TokenResponse TokenResponse = new TokenResponse();
                    if (TokenResponse.parseJasonDataStructure(JsonDataStrcuture, client_secret))
                    {                       
                        return TokenResponse;
                    }
                    else
                        return null;
                }
            }          
            return null;
        }
        public AuthenticationConclusion conclude(TokenResponse tokenResp)
        {
            AuthenticationConclusion conclusion = new AuthenticationConclusion();
            conclusion.SessionUID = tokenResp.id_token.Claims.UserId;
            conclusion.SymT = tokenResp.SymT;
            CST_Ops.recordme(this, conclusion);

            if (AuthenticationDone(conclusion))
                return conclusion;
            else
                return null;
        }
    }


    abstract public class OpenIDProvider : AuthorizationServer
    {
        protected IDTokenAndAccessTokenRecs IDTokenAndAccessTokenRecs
        {
            get { return (IDTokenAndAccessTokenRecs)AccessTokenRecs; }
            set { AccessTokenRecs = value; }
        }
        internal void init(AuthorizationCodeRecs AuthorizationCodeRecs1, IDTokenAndAccessTokenRecs IDTokenAndAccessTokenRecs1)          
        {
            base.init(AuthorizationCodeRecs1, IDTokenAndAccessTokenRecs1);
        }
        protected AuthenticationResponse AuthorizationEndpoint(AuthenticationRequest req)
        {
            if (!req.scope.Contains("openid"))
                return null;
            else
                return (AuthenticationResponse)SignInIdP(req);
        }
        protected override SignInIdP_Resp_SignInRP_Req Redir(string dest, ID_Claim claim)
        {
            var AuthCode = claim as AuthorizationCodeEntry;
            if (AuthCode == null)
                return null;
            AuthenticationResponse resp = new AuthenticationResponse();
            resp.code = AuthCode.code;
            HTTP.HTTPComm.HttpPost(dest, "code=" + resp.code);
            return resp;
        }
       
        public TokenResponse TokenEndpoint(TokenRequest req)
        {
            IDTokenAndAccessTokenEntry IDTokenAndAccessTokenEntry;
            TokenResponse resp;
            string IdPSessionSecret;
            if (req == null) return null;
            switch (req.grant_type)
            {
                case "authorization_code":
                    IdPSessionSecret = AuthorizationCodeRecs.findISSByClientIDAndCode(req.client_id, req.code);
                    if (IdPSessionSecret == null)
                        return null;
                    AuthorizationCodeEntry AuthCodeEntry = (AuthorizationCodeEntry)AuthorizationCodeRecs.getEntry(IdPSessionSecret, req.client_id);
                    if (AuthCodeEntry.redirect_uri != req.redirect_uri )
                        return null;
                    IDTokenAndAccessTokenEntry = (IDTokenAndAccessTokenEntry)createAccessTokenEntry(AuthCodeEntry.redirect_uri, AuthCodeEntry.scope, AuthCodeEntry.state);
                    if (IDTokenAndAccessTokenRecs.setEntry(IdPSessionSecret, req.client_id, IDTokenAndAccessTokenEntry) == false)
                        return null;

                    resp = new TokenResponse();  //copy other fields from IDTokenAndAccessTokenEntry
                    resp.access_token = IDTokenAndAccessTokenEntry.access_token;
                    resp.refresh_token = IDTokenAndAccessTokenEntry.refresh_token;
                    resp.scope = IDTokenAndAccessTokenEntry.scope;
                    resp.id_token = IDTokenAndAccessTokenEntry.id_token;
                    return resp;
            }
            return null;
        }
    }
    public interface NondetOpenIDConnect : Nondet_Base
    {
        JsonWebToken JsonWebToken();
        IDTokenAndAccessTokenEntry IDTokenAndAccessTokenEntry();
        AuthorizationCodeEntry AuthorizationCodeEntry();
        Dictionary<string, Dictionary<string, AuthorizationCodeEntry>> AuthorizationCodeDictionary();
        Dictionary<string, Dictionary<string, IDTokenAndAccessTokenEntry>> IDTokenAndAccessTokenDictionary();
        AuthenticationRequest AuthenticationRequest();
        AuthenticationResponse AuthenticationResponse();
    }
}