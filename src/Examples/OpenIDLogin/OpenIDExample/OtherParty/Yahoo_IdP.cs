using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OpenID20NameSpace;
using GenericAuthNameSpace;

namespace OpenIDExample
{
    public class Yahoo_IdP : OpenIDProvider
    {

    }

    public class IDTokenAndAccessTokenDictionary_def : IDAssertionRecs
    {
        Dictionary<string, Dictionary<string, IDTokenAndAccessTokenEntry>> Dictionary = new Dictionary<string, Dictionary<string, IDTokenAndAccessTokenEntry>>();
        public ID_Claim getEntry(string IdPSessionSecret, string client_id)
        {
            return Dictionary[IdPSessionSecret][client_id];
        }
        public bool setEntry(string IdPSessionSecret, string client_id, ID_Claim Entry)
        {
            IDTokenAndAccessTokenEntry IDTokenAndAccessTokenEntry = (IDTokenAndAccessTokenEntry)Entry;
            if (IDTokenAndAccessTokenEntry == null)
                return false;
            Dictionary[IdPSessionSecret] = new Dictionary<string, IDTokenAndAccessTokenEntry>();
            Dictionary[IdPSessionSecret][client_id] = IDTokenAndAccessTokenEntry;
            return true;
        }
    }
}