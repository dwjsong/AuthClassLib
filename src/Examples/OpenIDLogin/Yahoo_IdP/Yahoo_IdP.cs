using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OpenID20NameSpace;
using GenericAuthNameSpace;
using System.Diagnostics.Contracts;

namespace OpenID20NameSpace
{
    public class Yahoo_IdP : OpenIDProvider
    {
        public void init()
        {
            base.init(IDAssertionRecsDictionary);
        }

        IDAssertionRecsDictionary_def IDAssertionRecsDictionary = new IDAssertionRecsDictionary_def();

        public class IDAssertionRecsDictionary_def : IDAssertionRecs
        {
            Dictionary<string, Dictionary<string, IDAssertionEntry>> Dictionary = new Dictionary<string, Dictionary<string, IDAssertionEntry>>();
            public ID_Claim getEntry(string IdPSessionSecret, string client_id)
            {
                return Dictionary[IdPSessionSecret][client_id];
            }
            public bool setEntry(string IdPSessionSecret, string client_id, ID_Claim Entry)
            {
                IDAssertionEntry IDTokenAndAccessTokenEntry = (IDAssertionEntry)Entry;
                if (IDTokenAndAccessTokenEntry == null)
                    return false;
                Dictionary[IdPSessionSecret] = new Dictionary<string, IDAssertionEntry>();
                Dictionary[IdPSessionSecret][client_id] = IDTokenAndAccessTokenEntry;
                return true;
            }
        }
    }
}