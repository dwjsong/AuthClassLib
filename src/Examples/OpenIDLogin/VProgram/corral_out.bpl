const hashsetEmpty: [Union]bool;

axiom (forall x: Union :: { hashsetEmpty[x] } !hashsetEmpty[x]);

var hashsets: [Ref][Union]bool;

var hashsetSize: [Ref]int;

procedure {:extern} System.Collections.Generic.HashSet`1.#ctor($this: Ref);



procedure {:extern} System.Collections.Generic.HashSet`1.Add$`0($this: Ref, item$in: Union) returns ($result: bool);



procedure {:extern} System.Collections.Generic.HashSet`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool);



procedure {:extern} System.Collections.Generic.HashSet`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool);



procedure {:extern} System.Collections.Generic.HashSet`1.get_Count($this: Ref) returns ($result: int);



procedure {:extern} System.Collections.Generic.HashSet`1.New($this: Ref) returns ($result: Ref);



var stacks: [Ref][int]Union;

var stackPtr: [Ref]int;

procedure {:extern} System.Collections.Generic.Stack`1.#ctor($this: Ref);



procedure {:extern} System.Collections.Generic.Stack`1.Push$`0($this: Ref, item$in: Union);



procedure {:extern} System.Collections.Generic.Stack`1.Pop($this: Ref) returns ($result: Union);



procedure {:extern} System.Collections.Generic.Stack`1.get_Count($this: Ref) returns ($result: int);



procedure {:extern} System.Collections.Generic.Stack`1.Peek($this: Ref) returns ($result: Union);



var listContents: [Ref][int]Union;

var listSize: [Ref]int;

procedure {:extern} System.Collections.Generic.List`1.#ctor($this: Ref);



procedure {:extern} System.Collections.Generic.List`1.Add$`0($this: Ref, item$in: Union);



procedure {:extern} System.Collections.Generic.List`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool);



procedure {:extern} System.Collections.Generic.List`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool);



procedure {:extern} System.Collections.Generic.List`1.get_Count($this: Ref) returns ($result: int);



procedure {:extern} System.Collections.Generic.List`1.Clear($this: Ref);



procedure {:extern} System.Collections.Generic.List`1.get_Item$System.Int32($this: Ref, index$in: int) returns ($result: Union);



procedure {:extern} System.Collections.Generic.List`1.set_Item$System.Int32$`0($this: Ref, index$in: int, value$in: Union);



var AllMaps: [Ref][Union]Union;

procedure {:extern} System.Collections.Generic.Dictionary`2.get_Item$`0(this: Ref, key$in: Union) returns ($result: Union);



implementation {:extern} System.Collections.Generic.Dictionary`2.get_Item$`0(this: Ref, key$in: Union) returns ($result: Union)
{

  anon0:
    $result := AllMaps[this][key$in];
    return;
}



procedure {:extern} System.Collections.Generic.Dictionary`2.set_Item$`0$`1(this: Ref, key$in: Union, value$in: Union);



procedure {:inline 1} Alloc() returns (x: Ref);
  modifies $Alloc;



implementation {:inline 1} Alloc() returns (x: Ref)
{

  anon0:
    assume ($Alloc[x] <==> false) && x != null;
    $Alloc[x] := true;
    return;
}



procedure {:inline 1} System.Object.GetType(this: Ref) returns ($result: Ref);



axiom Union2Int(null) == 0;

axiom Union2Bool(null) <==> false;

function $ThreadDelegate(Ref) : Ref;

procedure {:inline 1} System.Threading.Thread.#ctor$System.Threading.ParameterizedThreadStart(this: Ref, start$in: Ref);



procedure {:inline 1} System.Threading.Thread.Start$System.Object(this: Ref, parameter$in: Ref);



procedure Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref);



procedure {:extern} System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref);



procedure {:inline 1} System.Threading.Thread.#ctor$System.Threading.ThreadStart(this: Ref, start$in: Ref);



procedure {:inline 1} System.Threading.Thread.Start(this: Ref);



procedure Wrapper_System.Threading.ThreadStart.Invoke(this: Ref);



procedure {:extern} System.Threading.ThreadStart.Invoke(this: Ref);



procedure {:inline 1} System.String.op_Equality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool);



procedure {:inline 1} System.String.op_Inequality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool);



implementation System.String.op_Equality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool)
{

  anon0:
    $result := a$in == b$in;
    return;
}



implementation System.String.op_Inequality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool)
{

  anon0:
    $result := a$in != b$in;
    return;
}



var $ArrayContents: [Ref][int]Union;

function $ArrayLength(Ref) : int;

type Field;

type Union = Ref;

type Ref;

const unique null: Ref;

type Type = Ref;

function $TypeConstructor(Ref) : int;

type Real;

const unique $DefaultReal: Real;

procedure {:inline 1} $BoxFromBool(b: bool) returns (r: Ref);



procedure {:inline 1} $BoxFromInt(i: int) returns (r: Ref);



procedure {:inline 1} $BoxFromReal(r: Real) returns (rf: Ref);



procedure {:inline 1} $BoxFromUnion(u: Union) returns (r: Ref);



const unique $BoolValueType: int;

const unique $IntValueType: int;

const unique $RealValueType: int;

function {:inline true} $Unbox2Bool(r: Ref) : bool
{
  Union2Bool(r)
}

function {:inline true} $Unbox2Int(r: Ref) : int
{
  Union2Int(r)
}

function {:inline true} $Unbox2Real(r: Ref) : Real
{
  Union2Real(r)
}

function {:inline true} $Unbox2Union(r: Ref) : Union
{
  r
}

function Union2Bool(u: Union) : bool;

function Union2Int(u: Union) : int;

function Union2Real(u: Union) : Real;

function Bool2Union(boolValue: bool) : Union;

function Int2Union(intValue: int) : Union;

function Real2Union(realValue: Real) : Union;

function Int2Real(int) : Real;

function Real2Int(Real) : int;

function RealPlus(Real, Real) : Real;

function RealMinus(Real, Real) : Real;

function RealTimes(Real, Real) : Real;

function RealDivide(Real, Real) : Real;

function RealModulus(Real, Real) : Real;

function RealLessThan(Real, Real) : bool;

function RealLessThanOrEqual(Real, Real) : bool;

function RealGreaterThan(Real, Real) : bool;

function RealGreaterThanOrEqual(Real, Real) : bool;

function BitwiseAnd(int, int) : int;

function BitwiseOr(int, int) : int;

function BitwiseExclusiveOr(int, int) : int;

function BitwiseNegation(int) : int;

function RightShift(int, int) : int;

function LeftShift(int, int) : int;

function $DynamicType(Ref) : Type;

function $As(a: Ref, b: Type) : Ref;

axiom (forall a: Ref, b: Type :: { $As(a, b): Ref } $As(a, b): Ref == (if $Subtype($DynamicType(a), b) then a else null));

function $Subtype(Type, Type) : bool;

function $DisjointSubtree(Type, Type) : bool;

var $Alloc: [Ref]bool;

function {:builtin "MapImp"} $allocImp([Ref]bool, [Ref]bool) : [Ref]bool;

function {:builtin "MapConst"} $allocConstBool(bool) : [Ref]bool;

function $RefToDelegateMethod(int, Ref) : bool;

function $RefToDelegateReceiver(int, Ref) : Ref;

function $RefToDelegateTypeParameters(int, Ref) : Type;

var {:thread_local} $Exception: Ref;

function T$PoirotMain() : Ref;

const unique T$PoirotMain: int;

var F$PoirotMain.Nondet: Ref;

procedure {:entrypoint} PoirotMain.Main();
  modifies $Exception, $GetMeHereTracker, F$PoirotMain.Nondet, F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req, F$GenericAuthNameSpace.GlobalObjects_base.IdP, F$GenericAuthNameSpace.GlobalObjects_base.RP, $Alloc, F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary, F$OpenID20NameSpace.RelyingParty.assoc_handle, F$OpenID20NameSpace.RelyingParty.endpointUrl, F$OpenID20NameSpace.AuthenticationRequest.realm, F$OpenID20NameSpace.AuthenticationResponse.ns, F$OpenID20NameSpace.AuthenticationResponse.mode, F$OpenID20NameSpace.AuthenticationResponse.claimed_id, F$OpenID20NameSpace.AuthenticationResponse.identity, F$OpenID20NameSpace.AuthenticationResponse.assoc_handle, F$OpenID20NameSpace.AuthenticationResponse.return_to, F$OpenID20NameSpace.AuthenticationResponse.realm, F$OpenID20NameSpace.AuthenticationResponse.endpointURL, F$CST.CST_Struct.SymT, F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID, F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary, F$GenericAuthNameSpace.IdP.IdpAuthRecs, F$GenericAuthNameSpace.RP.CurrentSession, F$GenericAuthNameSpace.RP.Domain, F$GenericAuthNameSpace.RP.Realm, F$CST.CST_Struct.SignedBy;



procedure GlobalObjectsForCST.init();
  modifies F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req, $Alloc, F$GenericAuthNameSpace.GlobalObjects_base.IdP, F$GenericAuthNameSpace.GlobalObjects_base.RP, F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary, F$OpenID20NameSpace.RelyingParty.assoc_handle, F$OpenID20NameSpace.RelyingParty.endpointUrl, F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary, F$GenericAuthNameSpace.IdP.IdpAuthRecs, F$GenericAuthNameSpace.RP.CurrentSession, F$GenericAuthNameSpace.RP.Domain, F$GenericAuthNameSpace.RP.Realm;



procedure SynthesizedPortion.SynthesizedSequence();
  modifies F$OpenID20NameSpace.AuthenticationRequest.realm, $Alloc, F$OpenID20NameSpace.AuthenticationResponse.ns, F$OpenID20NameSpace.AuthenticationResponse.mode, F$OpenID20NameSpace.AuthenticationResponse.claimed_id, F$OpenID20NameSpace.AuthenticationResponse.identity, F$OpenID20NameSpace.AuthenticationResponse.assoc_handle, F$OpenID20NameSpace.AuthenticationResponse.return_to, F$OpenID20NameSpace.AuthenticationResponse.realm, F$OpenID20NameSpace.AuthenticationResponse.endpointURL, F$CST.CST_Struct.SymT, F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID, F$CST.CST_Struct.SignedBy;



implementation PoirotMain.Main()
{

  anon0:
    call {:si_unique_call 0} T$PoirotMain.#cctor();
    call {:si_unique_call 1} T$LiveIDNameSpace.Yahoo_RP_For_vProgram.#cctor();
    call {:si_unique_call 2} T$SynthesizedPortion.#cctor();
    call {:si_unique_call 3} T$GlobalObjectsForCST.#cctor();
    call {:si_unique_call 4} T$OpenID20NameSpace.IDAssertionEntry.#cctor();
    call {:si_unique_call 5} T$OpenID20NameSpace.AuthenticationRequest.#cctor();
    call {:si_unique_call 6} T$OpenID20NameSpace.RelyingParty.#cctor();
    call {:si_unique_call 7} T$OpenID20NameSpace.AuthenticationResponse.#cctor();
    call {:si_unique_call 8} T$OpenID20NameSpace.OpenIDProvider.#cctor();
    call {:si_unique_call 9} T$GenericAuthNameSpace.GlobalObjects_base.#cctor();
    call {:si_unique_call 10} T$GenericAuthNameSpace.IdP.#cctor();
    call {:si_unique_call 11} T$GenericAuthNameSpace.ID_Claim.#cctor();
    call {:si_unique_call 12} T$GenericAuthNameSpace.SignInRP_Resp.#cctor();
    call {:si_unique_call 13} T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor();
    call {:si_unique_call 14} T$GenericAuthNameSpace.SignInIdP_Req.#cctor();
    call {:si_unique_call 15} T$GenericAuthNameSpace.RP.AuthenticationConclusion.#cctor();
    call {:si_unique_call 16} T$GenericAuthNameSpace.RP.#cctor();
    call {:si_unique_call 17} T$OpenIDExample.LogIn.#cctor();
    call {:si_unique_call 18} T$OpenID20NameSpace.Yahoo_RP.#cctor();
    call {:si_unique_call 19} T$CST.Debug.#cctor();
    call {:si_unique_call 20} T$CST.CST_Struct.#cctor();
    call {:si_unique_call 21} T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#cctor();
    call {:si_unique_call 22} T$OpenID20NameSpace.Yahoo_IdP.#cctor();
    $Exception := null;
    $GetMeHereTracker := 0;
    assume {:breadcrumb 0} true;
    goto corral_source_split_1;

  corral_source_split_1:
    goto corral_source_split_2;

  corral_source_split_2:
    call {:si_unique_call 23} GlobalObjectsForCST.init();
    goto corral_source_split_3;

  corral_source_split_3:
    goto corral_source_split_4;

  corral_source_split_4:
    call {:si_unique_call 24} SynthesizedPortion.SynthesizedSequence();
    return;
}



procedure PoirotMain.#ctor($this: Ref);



procedure {:extern} System.Object.#ctor($this: Ref);



procedure T$PoirotMain.#cctor();
  modifies F$PoirotMain.Nondet;



implementation T$PoirotMain.#cctor()
{

  anon0:
    F$PoirotMain.Nondet := null;
    return;
}



function T$LiveIDNameSpace.Yahoo_RP_For_vProgram() : Ref;

const unique T$LiveIDNameSpace.Yahoo_RP_For_vProgram: int;

procedure LiveIDNameSpace.Yahoo_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool);



var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.IdP: Ref;

var {:extern} F$GenericAuthNameSpace.IdP.IdpAuthRecs: [Ref]Ref;

var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req: Ref;

var {:extern} F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret: [Ref]Ref;

procedure {:extern} OpenID20NameSpace.AuthenticationRequest.get_Realm($this: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.SignInIdP_Req.get_Realm($this: Ref) returns ($result: Ref);



function {:extern} T$OpenID20NameSpace.AuthenticationRequest() : Ref;

const {:extern} unique T$OpenID20NameSpace.AuthenticationRequest: int;

axiom $TypeConstructor(T$OpenID20NameSpace.AuthenticationRequest()) == T$OpenID20NameSpace.AuthenticationRequest;

procedure {:extern} OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, Realm$in: Ref) returns ($result: Ref);



function {:extern} T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def() : Ref;

const {:extern} unique T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def: int;

axiom $TypeConstructor(T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def()) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def;

procedure {:extern} OpenID20NameSpace.IDAssertionEntry.get_UserID($this: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.ID_Claim.get_UserID($this: Ref) returns ($result: Ref);



function {:extern} T$OpenID20NameSpace.IDAssertionEntry() : Ref;

const {:extern} unique T$OpenID20NameSpace.IDAssertionEntry: int;

axiom $TypeConstructor(T$OpenID20NameSpace.IDAssertionEntry()) == T$OpenID20NameSpace.IDAssertionEntry;

var {:extern} F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID: [Ref]Ref;

implementation LiveIDNameSpace.Yahoo_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool)
{
  var conclusion: Ref;
  var ID_claim_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: bool;
  var inline$System.String.op_Equality$System.String$System.String$0$a$in: Ref;
  var inline$System.String.op_Equality$System.String$System.String$0$b$in: Ref;
  var inline$System.String.op_Equality$System.String$System.String$0$$result: bool;

  anon0:
    conclusion := conclusion$in;
    assume {:breadcrumb 2} true;
    goto corral_source_split_6;

  corral_source_split_6:
    $tmp12 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
    assume $tmp12 != null;
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp12])) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def;
    $tmp0 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
    assume $tmp0 != null;
    $tmp1 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp0];
    $tmp2 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
    assume $tmp2 != null;
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenID20NameSpace.AuthenticationRequest;
    call {:si_unique_call 25} $tmp3 := OpenID20NameSpace.AuthenticationRequest.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
    goto anon4;

  anon14_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) != T$OpenID20NameSpace.AuthenticationRequest;
    call {:si_unique_call 26} $tmp4 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
    goto anon4;

  anon4:
    call {:si_unique_call 27} $tmp5 := OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.getEntry$System.String$System.String($tmp1, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp2], (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenID20NameSpace.AuthenticationRequest then $tmp3 else $tmp4));
    goto anon9;

  anon13_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp12])) != T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def;
    $tmp6 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
    assume $tmp6 != null;
    $tmp7 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp6];
    $tmp8 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
    assume $tmp8 != null;
    goto anon15_Then, anon15_Else;

  anon15_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenID20NameSpace.AuthenticationRequest;
    call {:si_unique_call 28} $tmp9 := OpenID20NameSpace.AuthenticationRequest.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
    goto anon8;

  anon15_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) != T$OpenID20NameSpace.AuthenticationRequest;
    call {:si_unique_call 29} $tmp10 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
    goto anon8;

  anon8:
    call {:si_unique_call 30} $tmp11 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp7, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp8], (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenID20NameSpace.AuthenticationRequest then $tmp9 else $tmp10));
    goto anon9;

  anon9:
    ID_claim_Ref := (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp12])) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def then $tmp5 else $tmp11);
    goto corral_source_split_8;

  corral_source_split_8:
    goto anon16_Then, anon16_Else;

  anon16_Then:
    assume {:partition} $TypeConstructor($DynamicType(ID_claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry;
    call {:si_unique_call 31} $tmp13 := OpenID20NameSpace.IDAssertionEntry.get_UserID(ID_claim_Ref);
    goto anon12;

  anon16_Else:
    assume {:partition} $TypeConstructor($DynamicType(ID_claim_Ref)) != T$OpenID20NameSpace.IDAssertionEntry;
    call {:si_unique_call 32} $tmp14 := GenericAuthNameSpace.ID_Claim.get_UserID(ID_claim_Ref);
    goto anon12;

  anon12:
    $tmp15 := conclusion;
    assume $tmp15 != null;
    goto corral_source_split_10;

  corral_source_split_10:
    goto inline$System.String.op_Equality$System.String$System.String$0$Entry;

  inline$System.String.op_Equality$System.String$System.String$0$Entry:
    inline$System.String.op_Equality$System.String$System.String$0$a$in := (if $TypeConstructor($DynamicType(ID_claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp13 else $tmp14);
    inline$System.String.op_Equality$System.String$System.String$0$b$in := F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp15];
    havoc inline$System.String.op_Equality$System.String$System.String$0$$result;
    goto inline$System.String.op_Equality$System.String$System.String$0$anon0;

  inline$System.String.op_Equality$System.String$System.String$0$anon0:
    inline$System.String.op_Equality$System.String$System.String$0$$result := inline$System.String.op_Equality$System.String$System.String$0$a$in == inline$System.String.op_Equality$System.String$System.String$0$b$in;
    goto inline$System.String.op_Equality$System.String$System.String$0$Return;

  inline$System.String.op_Equality$System.String$System.String$0$Return:
    $tmp16 := inline$System.String.op_Equality$System.String$System.String$0$$result;
    goto anon12$1;

  anon12$1:
    assert $tmp16;
    goto corral_source_split_12;

  corral_source_split_12:
    $result := true;
    return;
}



procedure LiveIDNameSpace.Yahoo_RP_For_vProgram.#ctor($this: Ref);
  modifies F$OpenID20NameSpace.RelyingParty.assoc_handle, F$OpenID20NameSpace.RelyingParty.endpointUrl, F$GenericAuthNameSpace.RP.CurrentSession, F$GenericAuthNameSpace.RP.Domain, F$GenericAuthNameSpace.RP.Realm;



procedure {:extern} OpenID20NameSpace.Yahoo_RP.#ctor($this: Ref);
  modifies F$OpenID20NameSpace.RelyingParty.assoc_handle, F$OpenID20NameSpace.RelyingParty.endpointUrl, F$GenericAuthNameSpace.RP.CurrentSession, F$GenericAuthNameSpace.RP.Domain, F$GenericAuthNameSpace.RP.Realm;



implementation LiveIDNameSpace.Yahoo_RP_For_vProgram.#ctor($this: Ref)
{

  anon0:
    assume {:breadcrumb 3} true;
    call {:si_unique_call 33} OpenID20NameSpace.Yahoo_RP.#ctor($this);
    return;
}



procedure T$LiveIDNameSpace.Yahoo_RP_For_vProgram.#cctor();



implementation T$LiveIDNameSpace.Yahoo_RP_For_vProgram.#cctor()
{

  anon0:
    return;
}



function T$SynthesizedPortion() : Ref;

const unique T$SynthesizedPortion: int;

var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.RP: Ref;

var {:extern} F$GenericAuthNameSpace.RP.Realm: [Ref]Ref;

procedure {:extern} OpenID20NameSpace.AuthenticationRequest.set_Realm$System.String($this: Ref, value$in: Ref);
  modifies F$OpenID20NameSpace.AuthenticationRequest.realm;



procedure {:extern} GenericAuthNameSpace.SignInIdP_Req.set_Realm$System.String($this: Ref, value$in: Ref);



procedure {:extern} OpenID20NameSpace.OpenIDProvider.ProcessAuthenticationRequest$OpenID20NameSpace.AuthenticationRequest($this: Ref, req$in: Ref) returns ($result: Ref);
  modifies $Alloc, F$OpenID20NameSpace.AuthenticationResponse.ns, F$OpenID20NameSpace.AuthenticationResponse.mode, F$OpenID20NameSpace.AuthenticationResponse.claimed_id, F$OpenID20NameSpace.AuthenticationResponse.identity, F$OpenID20NameSpace.AuthenticationResponse.assoc_handle, F$OpenID20NameSpace.AuthenticationResponse.return_to, F$OpenID20NameSpace.AuthenticationResponse.realm, F$OpenID20NameSpace.AuthenticationResponse.endpointURL, F$CST.CST_Struct.SymT, F$CST.CST_Struct.SignedBy;



var {:extern} F$OpenID20NameSpace.AuthenticationResponse.return_to: [Ref]Ref;

procedure {:extern} OpenID20NameSpace.RelyingParty.conclude$OpenID20NameSpace.AuthenticationResponse($this: Ref, resp$in: Ref) returns ($result: Ref);
  modifies $Alloc, F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID, F$CST.CST_Struct.SymT, F$CST.CST_Struct.SignedBy;



implementation SynthesizedPortion.SynthesizedSequence()
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var O2_Ref: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: bool;
  var $tmp6: Ref;
  var G3_Ref: Ref;
  var inline$System.String.op_Inequality$System.String$System.String$0$a$in: Ref;
  var inline$System.String.op_Inequality$System.String$System.String$0$b$in: Ref;
  var inline$System.String.op_Inequality$System.String$System.String$0$$result: bool;

  anon0:
    assume {:breadcrumb 4} true;
    goto corral_source_split_14;

  corral_source_split_14:
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenID20NameSpace.AuthenticationRequest;
    assume {:breadcrumb 5} true;
    $tmp0 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp0 != null;
    call {:si_unique_call 34} OpenID20NameSpace.AuthenticationRequest.set_Realm$System.String(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req, F$GenericAuthNameSpace.RP.Realm[$tmp0]);
    goto anon3;

  anon7_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) != T$OpenID20NameSpace.AuthenticationRequest;
    assume {:breadcrumb 6} true;
    $tmp1 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp1 != null;
    call {:si_unique_call 35} GenericAuthNameSpace.SignInIdP_Req.set_Realm$System.String(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req, F$GenericAuthNameSpace.RP.Realm[$tmp1]);
    goto anon3;

  anon3:
    goto corral_source_split_16;

  corral_source_split_16:
    call {:si_unique_call 36} $tmp2 := OpenID20NameSpace.OpenIDProvider.ProcessAuthenticationRequest$OpenID20NameSpace.AuthenticationRequest(F$GenericAuthNameSpace.GlobalObjects_base.IdP, F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
    O2_Ref := $tmp2;
    goto corral_source_split_17;

  corral_source_split_17:
    $tmp3 := O2_Ref;
    assume $tmp3 != null;
    $tmp4 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp4 != null;
    goto corral_source_split_18;

  corral_source_split_18:
    goto inline$System.String.op_Inequality$System.String$System.String$0$Entry;

  inline$System.String.op_Inequality$System.String$System.String$0$Entry:
    inline$System.String.op_Inequality$System.String$System.String$0$a$in := F$OpenID20NameSpace.AuthenticationResponse.return_to[$tmp3];
    inline$System.String.op_Inequality$System.String$System.String$0$b$in := F$GenericAuthNameSpace.RP.Realm[$tmp4];
    havoc inline$System.String.op_Inequality$System.String$System.String$0$$result;
    goto inline$System.String.op_Inequality$System.String$System.String$0$anon0;

  inline$System.String.op_Inequality$System.String$System.String$0$anon0:
    inline$System.String.op_Inequality$System.String$System.String$0$$result := inline$System.String.op_Inequality$System.String$System.String$0$a$in != inline$System.String.op_Inequality$System.String$System.String$0$b$in;
    goto inline$System.String.op_Inequality$System.String$System.String$0$Return;

  inline$System.String.op_Inequality$System.String$System.String$0$Return:
    $tmp5 := inline$System.String.op_Inequality$System.String$System.String$0$$result;
    goto anon3$1;

  anon3$1:
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} $tmp5;
    assume {:breadcrumb 7} true;
    goto corral_source_split_20;

  corral_source_split_20:
    return;

  anon8_Else:
    assume {:partition} !$tmp5;
    assume {:breadcrumb 8} true;
    goto anon6;

  anon6:
    goto corral_source_split_22;

  corral_source_split_22:
    goto corral_source_split_23;

  corral_source_split_23:
    call {:si_unique_call 37} $tmp6 := OpenID20NameSpace.RelyingParty.conclude$OpenID20NameSpace.AuthenticationResponse(F$GenericAuthNameSpace.GlobalObjects_base.RP, O2_Ref);
    G3_Ref := $tmp6;
    return;
}



procedure SynthesizedPortion.#ctor($this: Ref);



procedure T$SynthesizedPortion.#cctor();



implementation T$SynthesizedPortion.#cctor()
{

  anon0:
    return;
}



function T$GlobalObjectsForCST() : Ref;

const unique T$GlobalObjectsForCST: int;

procedure {:extern} OpenID20NameSpace.NondetOpenID20.AuthenticationRequest($this: Ref) returns ($result: Ref);



procedure {:extern} OpenID20NameSpace.Yahoo_IdP.#ctor($this: Ref);
  modifies F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary, $Alloc, F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary, F$GenericAuthNameSpace.IdP.IdpAuthRecs;



function {:extern} T$OpenID20NameSpace.Yahoo_IdP() : Ref;

const {:extern} unique T$OpenID20NameSpace.Yahoo_IdP: int;

axiom $TypeConstructor(T$OpenID20NameSpace.Yahoo_IdP()) == T$OpenID20NameSpace.Yahoo_IdP;

procedure {:extern} OpenID20NameSpace.Yahoo_IdP.init($this: Ref);
  modifies F$GenericAuthNameSpace.IdP.IdpAuthRecs;



implementation GlobalObjectsForCST.init()
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var inline$Alloc$0$x: Ref;
  var inline$Alloc$0$$Alloc: [Ref]bool;
  var inline$Alloc$1$x: Ref;
  var inline$Alloc$1$$Alloc: [Ref]bool;

  anon0:
    assume {:breadcrumb 10} true;
    goto corral_source_split_25;

  corral_source_split_25:
    goto corral_source_split_26;

  corral_source_split_26:
    goto corral_source_split_27;

  corral_source_split_27:
    call {:si_unique_call 38} $tmp0 := OpenID20NameSpace.NondetOpenID20.AuthenticationRequest(F$PoirotMain.Nondet);
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := $tmp0;
    goto corral_source_split_28;

  corral_source_split_28:
    goto corral_source_split_29;

  corral_source_split_29:
    goto inline$Alloc$0$Entry;

  inline$Alloc$0$Entry:
    havoc inline$Alloc$0$x;
    inline$Alloc$0$$Alloc := $Alloc;
    goto inline$Alloc$0$anon0;

  inline$Alloc$0$anon0:
    assume ($Alloc[inline$Alloc$0$x] <==> false) && inline$Alloc$0$x != null;
    $Alloc[inline$Alloc$0$x] := true;
    goto inline$Alloc$0$Return;

  inline$Alloc$0$Return:
    $tmp1 := inline$Alloc$0$x;
    goto anon0$1;

  anon0$1:
    call {:si_unique_call 39} OpenID20NameSpace.Yahoo_IdP.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$OpenID20NameSpace.Yahoo_IdP();
    assume $TypeConstructor($DynamicType($tmp1)) == T$OpenID20NameSpace.Yahoo_IdP;
    F$GenericAuthNameSpace.GlobalObjects_base.IdP := $tmp1;
    goto corral_source_split_31;

  corral_source_split_31:
    goto corral_source_split_32;

  corral_source_split_32:
    call {:si_unique_call 40} OpenID20NameSpace.Yahoo_IdP.init(F$GenericAuthNameSpace.GlobalObjects_base.IdP);
    goto corral_source_split_33;

  corral_source_split_33:
    goto corral_source_split_34;

  corral_source_split_34:
    goto inline$Alloc$1$Entry;

  inline$Alloc$1$Entry:
    havoc inline$Alloc$1$x;
    inline$Alloc$1$$Alloc := $Alloc;
    goto inline$Alloc$1$anon0;

  inline$Alloc$1$anon0:
    assume ($Alloc[inline$Alloc$1$x] <==> false) && inline$Alloc$1$x != null;
    $Alloc[inline$Alloc$1$x] := true;
    goto inline$Alloc$1$Return;

  inline$Alloc$1$Return:
    $tmp2 := inline$Alloc$1$x;
    goto anon0$2;

  anon0$2:
    call {:si_unique_call 41} LiveIDNameSpace.Yahoo_RP_For_vProgram.#ctor($tmp2);
    assume $DynamicType($tmp2) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram();
    assume $TypeConstructor($DynamicType($tmp2)) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram;
    F$GenericAuthNameSpace.GlobalObjects_base.RP := $tmp2;
    return;
}



procedure GlobalObjectsForCST.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.GlobalObjects_base.#ctor($this: Ref);



procedure T$GlobalObjectsForCST.#cctor();



implementation T$GlobalObjectsForCST.#cctor()
{

  anon0:
    return;
}



var F$OpenID20NameSpace.IDAssertionEntry.openid_return_to: [Ref]Ref;

var F$OpenID20NameSpace.IDAssertionEntry.openid_identity: [Ref]Ref;

var F$OpenID20NameSpace.IDAssertionEntry.openid_claimed_id: [Ref]Ref;

var F$OpenID20NameSpace.IDAssertionEntry.openid_assoc_handle: [Ref]Ref;

var F$OpenID20NameSpace.IDAssertionEntry.openid_op_endpoint: [Ref]Ref;

procedure OpenID20NameSpace.IDAssertionEntry.get_Redir_dest($this: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.IDAssertionEntry.get_Redir_dest($this: Ref) returns ($result: Ref)
{

  anon0:
    assume {:breadcrumb 12} true;
    goto corral_source_split_36;

  corral_source_split_36:
    assume $this != null;
    $result := F$OpenID20NameSpace.IDAssertionEntry.openid_return_to[$this];
    return;
}



implementation OpenID20NameSpace.IDAssertionEntry.get_UserID($this: Ref) returns ($result: Ref)
{

  anon0:
    assume {:breadcrumb 13} true;
    goto corral_source_split_38;

  corral_source_split_38:
    assume $this != null;
    $result := F$OpenID20NameSpace.IDAssertionEntry.openid_claimed_id[$this];
    return;
}



procedure OpenID20NameSpace.IDAssertionEntry.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.ID_Claim.#ctor($this: Ref);



procedure T$OpenID20NameSpace.IDAssertionEntry.#cctor();



implementation T$OpenID20NameSpace.IDAssertionEntry.#cctor()
{

  anon0:
    return;
}



var F$OpenID20NameSpace.AuthenticationRequest.ns: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationRequest.mode: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationRequest.claimed_id: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationRequest.identity: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationRequest.assoc_handle: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationRequest.return_to: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationRequest.realm: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationRequest.endpointURL: [Ref]Ref;

implementation OpenID20NameSpace.AuthenticationRequest.get_Realm($this: Ref) returns ($result: Ref)
{

  anon0:
    assume {:breadcrumb 15} true;
    goto corral_source_split_40;

  corral_source_split_40:
    assume $this != null;
    $result := F$OpenID20NameSpace.AuthenticationRequest.realm[$this];
    return;
}



implementation OpenID20NameSpace.AuthenticationRequest.set_Realm$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;

  anon0:
    value := value$in;
    assume {:breadcrumb 16} true;
    goto corral_source_split_42;

  corral_source_split_42:
    goto corral_source_split_43;

  corral_source_split_43:
    F$OpenID20NameSpace.AuthenticationRequest.realm[$this] := value;
    return;
}



procedure OpenID20NameSpace.AuthenticationRequest.#ctor($this: Ref);



const {:value "http://specs.openid.net/auth/2.0"} unique $string_literal_http$$$specs.openid.net$auth$2.0_0: Ref;

procedure {:extern} GenericAuthNameSpace.SignInIdP_Req.#ctor($this: Ref);



procedure T$OpenID20NameSpace.AuthenticationRequest.#cctor();



implementation T$OpenID20NameSpace.AuthenticationRequest.#cctor()
{

  anon0:
    return;
}



function T$OpenID20NameSpace.NondetOpenID20() : Ref;

const unique T$OpenID20NameSpace.NondetOpenID20: int;

procedure OpenID20NameSpace.NondetOpenID20.AuthenticationResponse($this: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.NondetOpenID20.IDAssertionEntry($this: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.NondetOpenID20.IDAssertionRecsDictionary($this: Ref) returns ($result: Ref);



function T$OpenID20NameSpace.RelyingParty() : Ref;

const unique T$OpenID20NameSpace.RelyingParty: int;

var F$OpenID20NameSpace.RelyingParty.assoc_handle: [Ref]Ref;

var F$OpenID20NameSpace.RelyingParty.endpointUrl: [Ref]Ref;

procedure OpenID20NameSpace.RelyingParty.get_return_uri($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.RP.Domain: [Ref]Ref;

procedure OpenID20NameSpace.RelyingParty.set_return_uri$System.String($this: Ref, value$in: Ref);



procedure OpenID20NameSpace.RelyingParty.RequestAuthentication$OpenID20NameSpace.AuthenticationResponse($this: Ref, resp$in: Ref) returns ($result: Ref);



var {:extern} F$CST.CST_Struct.SymT: [Ref]Ref;

const {:value "http://specs.openid.net/auth/2.0/identifier_select"} unique $string_literal_http$$$specs.openid.net$auth$2.0$identifier_select_1: Ref;

const {:value "checkid_setup"} unique $string_literal_checkid_setup_2: Ref;

procedure {:extern} GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($this: Ref);
  modifies F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID, F$CST.CST_Struct.SymT, F$CST.CST_Struct.SignedBy;



function {:extern} T$GenericAuthNameSpace.RP.AuthenticationConclusion() : Ref;

const {:extern} unique T$GenericAuthNameSpace.RP.AuthenticationConclusion: int;

axiom $TypeConstructor(T$GenericAuthNameSpace.RP.AuthenticationConclusion()) == T$GenericAuthNameSpace.RP.AuthenticationConclusion;

var F$OpenID20NameSpace.AuthenticationResponse.claimed_id: [Ref]Ref;

procedure {:extern} CST.CST_Ops.recordme$System.Object$CST.CST_Struct(o$in: Ref, msg$in: Ref);



procedure {:extern} GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool);



function {:extern} T$OpenID20NameSpace.Yahoo_RP() : Ref;

const {:extern} unique T$OpenID20NameSpace.Yahoo_RP: int;

axiom $TypeConstructor(T$OpenID20NameSpace.Yahoo_RP()) == T$OpenID20NameSpace.Yahoo_RP;

implementation OpenID20NameSpace.RelyingParty.conclude$OpenID20NameSpace.AuthenticationResponse($this: Ref, resp$in: Ref) returns ($result: Ref)
{
  var resp: Ref;
  var conclusion_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: bool;
  var $tmp4: bool;
  var $tmp5: bool;
  var $tmp6: bool;
  var inline$Alloc$0$x: Ref;
  var inline$Alloc$0$$Alloc: [Ref]bool;

  anon0:
    resp := resp$in;
    assume {:breadcrumb 21} true;
    goto corral_source_split_45;

  corral_source_split_45:
    goto inline$Alloc$0$Entry;

  inline$Alloc$0$Entry:
    havoc inline$Alloc$0$x;
    inline$Alloc$0$$Alloc := $Alloc;
    goto inline$Alloc$0$anon0;

  inline$Alloc$0$anon0:
    assume ($Alloc[inline$Alloc$0$x] <==> false) && inline$Alloc$0$x != null;
    $Alloc[inline$Alloc$0$x] := true;
    goto inline$Alloc$0$Return;

  inline$Alloc$0$Return:
    $tmp0 := inline$Alloc$0$x;
    goto anon0$1;

  anon0$1:
    call {:si_unique_call 42} GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$GenericAuthNameSpace.RP.AuthenticationConclusion();
    assume $TypeConstructor($DynamicType($tmp0)) == T$GenericAuthNameSpace.RP.AuthenticationConclusion;
    conclusion_Ref := $tmp0;
    goto corral_source_split_47;

  corral_source_split_47:
    goto corral_source_split_48;

  corral_source_split_48:
    $tmp1 := resp;
    assume $tmp1 != null;
    F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[conclusion_Ref] := F$OpenID20NameSpace.AuthenticationResponse.claimed_id[$tmp1];
    goto corral_source_split_49;

  corral_source_split_49:
    goto corral_source_split_50;

  corral_source_split_50:
    $tmp2 := resp;
    assume $tmp2 != null;
    F$CST.CST_Struct.SymT[conclusion_Ref] := F$CST.CST_Struct.SymT[$tmp2];
    goto corral_source_split_51;

  corral_source_split_51:
    goto corral_source_split_52;

  corral_source_split_52:
    call {:si_unique_call 43} CST.CST_Ops.recordme$System.Object$CST.CST_Struct($this, conclusion_Ref);
    goto corral_source_split_53;

  corral_source_split_53:
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram;
    call {:si_unique_call 44} $tmp3 := LiveIDNameSpace.Yahoo_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, conclusion_Ref);
    goto anon7;

  anon11_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.Yahoo_RP_For_vProgram;
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_RP;
    call {:si_unique_call 45} $tmp4 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, conclusion_Ref);
    goto anon7;

  anon12_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenID20NameSpace.Yahoo_RP;
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.RelyingParty;
    call {:si_unique_call 46} $tmp5 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, conclusion_Ref);
    goto anon7;

  anon13_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenID20NameSpace.RelyingParty;
    call {:si_unique_call 47} $tmp6 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, conclusion_Ref);
    goto anon7;

  anon7:
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram then $tmp3 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_RP then $tmp4 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.RelyingParty then $tmp5 else $tmp6)));
    assume {:breadcrumb 22} true;
    goto corral_source_split_55;

  corral_source_split_55:
    $result := conclusion_Ref;
    return;

  anon14_Else:
    assume {:partition} !(if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram then $tmp3 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_RP then $tmp4 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.RelyingParty then $tmp5 else $tmp6)));
    assume {:breadcrumb 23} true;
    goto anon10;

  anon10:
    $result := null;
    return;
}



procedure OpenID20NameSpace.RelyingParty.callProcessAuthenticationRequest$OpenID20NameSpace.AuthenticationRequest($this: Ref, authReq$in: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.AuthenticationResponse.#ctor($this: Ref);
  modifies F$OpenID20NameSpace.AuthenticationResponse.ns, F$OpenID20NameSpace.AuthenticationResponse.mode, F$OpenID20NameSpace.AuthenticationResponse.claimed_id, F$OpenID20NameSpace.AuthenticationResponse.identity, F$OpenID20NameSpace.AuthenticationResponse.assoc_handle, F$OpenID20NameSpace.AuthenticationResponse.return_to, F$OpenID20NameSpace.AuthenticationResponse.realm, F$OpenID20NameSpace.AuthenticationResponse.endpointURL, F$CST.CST_Struct.SymT, F$CST.CST_Struct.SignedBy;



function T$OpenID20NameSpace.AuthenticationResponse() : Ref;

const unique T$OpenID20NameSpace.AuthenticationResponse: int;

procedure OpenID20NameSpace.RelyingParty.parseAuthenticationResponse$System.Web.HttpRequest($this: Ref, rawRequest$in: Ref) returns ($result: Ref);



procedure {:extern} System.Web.HttpContext.get_Current() returns ($result: Ref);



procedure {:extern} System.Web.HttpRequest.get_QueryString($this: Ref) returns ($result: Ref);



const {:value "openid.claimed_id"} unique $string_literal_openid.claimed_id_3: Ref;

procedure {:extern} System.Collections.Specialized.NameValueCollection.get_Item$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



const {:value "SymT"} unique $string_literal_SymT_4: Ref;

procedure {:extern} System.String.IsNullOrEmpty$System.String(value$in: Ref) returns ($result: bool);



procedure OpenID20NameSpace.RelyingParty.#ctor($this: Ref);
  modifies F$OpenID20NameSpace.RelyingParty.assoc_handle, F$OpenID20NameSpace.RelyingParty.endpointUrl, F$GenericAuthNameSpace.RP.CurrentSession, F$GenericAuthNameSpace.RP.Domain, F$GenericAuthNameSpace.RP.Realm;



procedure {:extern} GenericAuthNameSpace.RP.#ctor($this: Ref);
  modifies F$GenericAuthNameSpace.RP.CurrentSession, F$GenericAuthNameSpace.RP.Domain, F$GenericAuthNameSpace.RP.Realm;



implementation OpenID20NameSpace.RelyingParty.#ctor($this: Ref)
{

  anon0:
    F$OpenID20NameSpace.RelyingParty.assoc_handle[$this] := null;
    F$OpenID20NameSpace.RelyingParty.endpointUrl[$this] := null;
    assume {:breadcrumb 28} true;
    call {:si_unique_call 48} GenericAuthNameSpace.RP.#ctor($this);
    return;
}



procedure T$OpenID20NameSpace.RelyingParty.#cctor();



implementation T$OpenID20NameSpace.RelyingParty.#cctor()
{

  anon0:
    return;
}



var F$OpenID20NameSpace.AuthenticationResponse.ns: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationResponse.mode: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationResponse.identity: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationResponse.assoc_handle: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationResponse.realm: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationResponse.endpointURL: [Ref]Ref;

procedure {:extern} GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this: Ref);
  modifies F$CST.CST_Struct.SymT, F$CST.CST_Struct.SignedBy;



implementation OpenID20NameSpace.AuthenticationResponse.#ctor($this: Ref)
{

  anon0:
    F$OpenID20NameSpace.AuthenticationResponse.ns[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.mode[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.claimed_id[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.identity[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.assoc_handle[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.return_to[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.realm[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.endpointURL[$this] := null;
    assume {:breadcrumb 29} true;
    goto corral_source_split_57;

  corral_source_split_57:
    goto corral_source_split_58;

  corral_source_split_58:
    F$OpenID20NameSpace.AuthenticationResponse.ns[$this] := $string_literal_http$$$specs.openid.net$auth$2.0_0;
    goto corral_source_split_59;

  corral_source_split_59:
    call {:si_unique_call 49} GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this);
    return;
}



procedure T$OpenID20NameSpace.AuthenticationResponse.#cctor();



implementation T$OpenID20NameSpace.AuthenticationResponse.#cctor()
{

  anon0:
    return;
}



function T$OpenID20NameSpace.IDAssertionRecs() : Ref;

const unique T$OpenID20NameSpace.IDAssertionRecs: int;

function T$OpenID20NameSpace.OpenIDProvider() : Ref;

const unique T$OpenID20NameSpace.OpenIDProvider: int;

procedure OpenID20NameSpace.OpenIDProvider.init$OpenID20NameSpace.IDAssertionRecs($this: Ref, recs$in: Ref);
  modifies F$GenericAuthNameSpace.IdP.IdpAuthRecs;



procedure OpenID20NameSpace.OpenIDProvider.set_IDAssertionRecs$OpenID20NameSpace.IDAssertionRecs($this: Ref, value$in: Ref);
  modifies F$GenericAuthNameSpace.IdP.IdpAuthRecs;



implementation OpenID20NameSpace.OpenIDProvider.init$OpenID20NameSpace.IDAssertionRecs($this: Ref, recs$in: Ref)
{
  var recs: Ref;

  anon0:
    recs := recs$in;
    assume {:breadcrumb 30} true;
    goto corral_source_split_61;

  corral_source_split_61:
    goto corral_source_split_62;

  corral_source_split_62:
    call {:si_unique_call 50} OpenID20NameSpace.OpenIDProvider.set_IDAssertionRecs$OpenID20NameSpace.IDAssertionRecs($this, recs);
    return;
}



procedure OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this: Ref) returns ($result: Ref)
{

  anon0:
    assume {:breadcrumb 31} true;
    goto corral_source_split_64;

  corral_source_split_64:
    assume $this != null;
    $result := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this];
    return;
}



implementation OpenID20NameSpace.OpenIDProvider.set_IDAssertionRecs$OpenID20NameSpace.IDAssertionRecs($this: Ref, value$in: Ref)
{
  var value: Ref;

  anon0:
    value := value$in;
    assume {:breadcrumb 32} true;
    goto corral_source_split_66;

  corral_source_split_66:
    goto corral_source_split_67;

  corral_source_split_67:
    F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this] := value;
    return;
}



procedure OpenID20NameSpace.OpenIDProvider.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req1$in: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, _ID_Claim$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.ID_Claim.get_Redir_dest($this: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.OpenIDProvider.ProcessAuthenticationRequest$OpenID20NameSpace.AuthenticationRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var resp_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var entry_Ref: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var inline$Alloc$0$x: Ref;
  var inline$Alloc$0$$Alloc: [Ref]bool;

  anon0:
    req := req$in;
    assume {:breadcrumb 39} true;
    goto corral_source_split_69;

  corral_source_split_69:
    goto inline$Alloc$0$Entry;

  inline$Alloc$0$Entry:
    havoc inline$Alloc$0$x;
    inline$Alloc$0$$Alloc := $Alloc;
    goto inline$Alloc$0$anon0;

  inline$Alloc$0$anon0:
    assume ($Alloc[inline$Alloc$0$x] <==> false) && inline$Alloc$0$x != null;
    $Alloc[inline$Alloc$0$x] := true;
    goto inline$Alloc$0$Return;

  inline$Alloc$0$Return:
    $tmp0 := inline$Alloc$0$x;
    goto anon0$1;

  anon0$1:
    call {:si_unique_call 51} OpenID20NameSpace.AuthenticationResponse.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.AuthenticationResponse();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.AuthenticationResponse;
    resp_Ref := $tmp0;
    goto corral_source_split_71;

  corral_source_split_71:
    goto corral_source_split_72;

  corral_source_split_72:
    $tmp1 := req;
    assume $tmp1 != null;
    F$CST.CST_Struct.SymT[resp_Ref] := F$CST.CST_Struct.SymT[$tmp1];
    goto corral_source_split_73;

  corral_source_split_73:
    goto corral_source_split_74;

  corral_source_split_74:
    call {:si_unique_call 52} CST.CST_Ops.recordme$System.Object$CST.CST_Struct($this, resp_Ref);
    goto corral_source_split_75;

  corral_source_split_75:
    goto corral_source_split_76;

  corral_source_split_76:
    call {:si_unique_call 53} $tmp10 := OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this);
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp10)) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def;
    call {:si_unique_call 54} $tmp2 := OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this);
    $tmp3 := req;
    assume $tmp3 != null;
    $tmp4 := req;
    assume $tmp4 != null;
    call {:si_unique_call 55} $tmp5 := OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.getEntry$System.String$System.String($tmp2, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp3], F$OpenID20NameSpace.AuthenticationRequest.realm[$tmp4]);
    goto anon3;

  anon10_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp10)) != T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def;
    call {:si_unique_call 56} $tmp6 := OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this);
    $tmp7 := req;
    assume $tmp7 != null;
    $tmp8 := req;
    assume $tmp8 != null;
    call {:si_unique_call 57} $tmp9 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp6, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp7], F$OpenID20NameSpace.AuthenticationRequest.realm[$tmp8]);
    goto anon3;

  anon3:
    entry_Ref := (if $TypeConstructor($DynamicType($tmp10)) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def then $tmp5 else $tmp9);
    goto corral_source_split_78;

  corral_source_split_78:
    goto corral_source_split_79;

  corral_source_split_79:
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} $TypeConstructor($DynamicType(entry_Ref)) == T$OpenID20NameSpace.IDAssertionEntry;
    call {:si_unique_call 58} $tmp11 := OpenID20NameSpace.IDAssertionEntry.get_UserID(entry_Ref);
    goto anon6;

  anon11_Else:
    assume {:partition} $TypeConstructor($DynamicType(entry_Ref)) != T$OpenID20NameSpace.IDAssertionEntry;
    call {:si_unique_call 59} $tmp12 := GenericAuthNameSpace.ID_Claim.get_UserID(entry_Ref);
    goto anon6;

  anon6:
    F$OpenID20NameSpace.AuthenticationResponse.claimed_id[resp_Ref] := (if $TypeConstructor($DynamicType(entry_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp11 else $tmp12);
    goto corral_source_split_81;

  corral_source_split_81:
    goto corral_source_split_82;

  corral_source_split_82:
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} $TypeConstructor($DynamicType(entry_Ref)) == T$OpenID20NameSpace.IDAssertionEntry;
    call {:si_unique_call 60} $tmp13 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(entry_Ref);
    goto anon9;

  anon12_Else:
    assume {:partition} $TypeConstructor($DynamicType(entry_Ref)) != T$OpenID20NameSpace.IDAssertionEntry;
    call {:si_unique_call 61} $tmp14 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(entry_Ref);
    goto anon9;

  anon9:
    F$OpenID20NameSpace.AuthenticationResponse.return_to[resp_Ref] := (if $TypeConstructor($DynamicType(entry_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp13 else $tmp14);
    goto corral_source_split_84;

  corral_source_split_84:
    $result := resp_Ref;
    return;
}



procedure OpenID20NameSpace.OpenIDProvider.#ctor($this: Ref);
  modifies F$GenericAuthNameSpace.IdP.IdpAuthRecs;



procedure {:extern} GenericAuthNameSpace.IdP.#ctor($this: Ref);
  modifies F$GenericAuthNameSpace.IdP.IdpAuthRecs;



implementation OpenID20NameSpace.OpenIDProvider.#ctor($this: Ref)
{

  anon0:
    assume {:breadcrumb 40} true;
    call {:si_unique_call 62} GenericAuthNameSpace.IdP.#ctor($this);
    return;
}



procedure T$OpenID20NameSpace.OpenIDProvider.#cctor();



implementation T$OpenID20NameSpace.OpenIDProvider.#cctor()
{

  anon0:
    return;
}



function T$GenericAuthNameSpace.GlobalObjects_base() : Ref;

const unique T$GenericAuthNameSpace.GlobalObjects_base: int;

procedure GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson$GenericAuthNameSpace.RP.AuthenticationConclusion(conclusion$in: Ref);



procedure T$GenericAuthNameSpace.GlobalObjects_base.#cctor();
  modifies F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req, F$GenericAuthNameSpace.GlobalObjects_base.IdP, F$GenericAuthNameSpace.GlobalObjects_base.RP;



implementation T$GenericAuthNameSpace.GlobalObjects_base.#cctor()
{

  anon0:
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := null;
    F$GenericAuthNameSpace.GlobalObjects_base.IdP := null;
    F$GenericAuthNameSpace.GlobalObjects_base.RP := null;
    return;
}



function T$GenericAuthNameSpace.IdP() : Ref;

const unique T$GenericAuthNameSpace.IdP: int;

procedure GenericAuthNameSpace.IdP.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.IdP.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref, Entry$in: Ref) returns ($result: bool);



procedure GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, Realm$in: Ref, _ID_Claim$in: Ref) returns ($result: bool);



procedure GenericAuthNameSpace.IdP.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, _ID_Claim$in: Ref) returns ($result: Ref);



implementation GenericAuthNameSpace.IdP.#ctor($this: Ref)
{

  anon0:
    F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this] := null;
    assume {:breadcrumb 48} true;
    call {:si_unique_call 63} System.Object.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.IdP.#cctor();



implementation T$GenericAuthNameSpace.IdP.#cctor()
{

  anon0:
    return;
}



function T$GenericAuthNameSpace.ID_Claim() : Ref;

const unique T$GenericAuthNameSpace.ID_Claim: int;

procedure T$GenericAuthNameSpace.ID_Claim.#cctor();



implementation T$GenericAuthNameSpace.ID_Claim.#cctor()
{

  anon0:
    return;
}



function T$GenericAuthNameSpace.SignInRP_Resp() : Ref;

const unique T$GenericAuthNameSpace.SignInRP_Resp: int;

procedure GenericAuthNameSpace.SignInRP_Resp.#ctor($this: Ref);



procedure {:extern} CST.CST_Struct.#ctor($this: Ref);
  modifies F$CST.CST_Struct.SymT, F$CST.CST_Struct.SignedBy;



procedure T$GenericAuthNameSpace.SignInRP_Resp.#cctor();



implementation T$GenericAuthNameSpace.SignInRP_Resp.#cctor()
{

  anon0:
    return;
}



function T$GenericAuthNameSpace.IdPAuthRecords_Base() : Ref;

const unique T$GenericAuthNameSpace.IdPAuthRecords_Base: int;

function T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req() : Ref;

const unique T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req: int;

implementation GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this: Ref)
{

  anon0:
    assume {:breadcrumb 51} true;
    call {:si_unique_call 64} CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor();



implementation T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor()
{

  anon0:
    return;
}



function T$GenericAuthNameSpace.SignInIdP_Req() : Ref;

const unique T$GenericAuthNameSpace.SignInIdP_Req: int;

procedure T$GenericAuthNameSpace.SignInIdP_Req.#cctor();



implementation T$GenericAuthNameSpace.SignInIdP_Req.#cctor()
{

  anon0:
    return;
}



function T$GenericAuthNameSpace.RP() : Ref;

const unique T$GenericAuthNameSpace.RP: int;

var F$GenericAuthNameSpace.RP.CurrentSession: [Ref]Ref;

procedure GenericAuthNameSpace.RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} CST.CST_Ops.Certify$CST.CST_Struct(msg$in: Ref) returns ($result: bool);



const {:value "UserID"} unique $string_literal_UserID_5: Ref;

const {:value ""} unique $string_literal__6: Ref;

procedure {:extern} System.Web.SessionState.HttpSessionState.set_Item$System.String$System.Object($this: Ref, name$in: Ref, value$in: Ref);



implementation GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool)
{
  var conclusion: Ref;
  var CST_verified_bool: bool;
  var $tmp0: bool;
  var $tmp1: Ref;
  var $tmp2: Ref;

  anon0:
    conclusion := conclusion$in;
    assume {:breadcrumb 53} true;
    goto corral_source_split_86;

  corral_source_split_86:
    goto corral_source_split_87;

  corral_source_split_87:
    call {:si_unique_call 65} $tmp0 := CST.CST_Ops.Certify$CST.CST_Struct(conclusion);
    CST_verified_bool := $tmp0;
    assume $this != null;
    $tmp1 := F$GenericAuthNameSpace.RP.CurrentSession[$this];
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} CST_verified_bool;
    $tmp2 := conclusion;
    assume $tmp2 != null;
    goto anon3;

  anon4_Else:
    assume {:partition} !CST_verified_bool;
    goto anon3;

  anon3:
    call {:si_unique_call 66} System.Web.SessionState.HttpSessionState.set_Item$System.String$System.Object($tmp1, $string_literal_UserID_5, (if CST_verified_bool then F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp2] else $string_literal__6));
    goto corral_source_split_89;

  corral_source_split_89:
    $result := CST_verified_bool;
    return;
}



implementation GenericAuthNameSpace.RP.#ctor($this: Ref)
{

  anon0:
    F$GenericAuthNameSpace.RP.CurrentSession[$this] := null;
    F$GenericAuthNameSpace.RP.Domain[$this] := null;
    F$GenericAuthNameSpace.RP.Realm[$this] := null;
    assume {:breadcrumb 54} true;
    call {:si_unique_call 67} System.Object.#ctor($this);
    return;
}



implementation GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($this: Ref)
{

  anon0:
    F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$this] := null;
    assume {:breadcrumb 55} true;
    call {:si_unique_call 68} CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.RP.AuthenticationConclusion.#cctor();



implementation T$GenericAuthNameSpace.RP.AuthenticationConclusion.#cctor()
{

  anon0:
    return;
}



procedure T$GenericAuthNameSpace.RP.#cctor();



implementation T$GenericAuthNameSpace.RP.#cctor()
{

  anon0:
    return;
}



function T$OpenIDExample.LogIn() : Ref;

const unique T$OpenIDExample.LogIn: int;

var F$OpenIDExample.LogIn.RP: [Ref]Ref;

var F$OpenIDExample.LogIn.form1: [Ref]Ref;

var F$OpenIDExample.LogIn.notLoggedIn: [Ref]Ref;

var F$OpenIDExample.LogIn.Login: [Ref]Ref;

var F$OpenIDExample.LogIn.LoggedIn: [Ref]Ref;

var F$OpenIDExample.LogIn.logged_id: [Ref]Ref;

var F$OpenIDExample.LogIn.Logout: [Ref]Ref;

procedure OpenIDExample.LogIn.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



procedure {:extern} System.Web.UI.Page.get_Request($this: Ref) returns ($result: Ref);



procedure {:extern} System.Web.HttpRequest.get_Params($this: Ref) returns ($result: Ref);



const {:value "openid.mode"} unique $string_literal_openid.mode_7: Ref;

procedure {:extern} System.Web.UI.Page.set_Visible$System.Boolean($this: Ref, value$in: bool);



function {:extern} T$System.Web.UI.Page() : Ref;

const {:extern} unique T$System.Web.UI.Page: int;

axiom $TypeConstructor(T$System.Web.UI.Page()) == T$System.Web.UI.Page;

function {:extern} T$System.Web.UI.TemplateControl() : Ref;

const {:extern} unique T$System.Web.UI.TemplateControl: int;

axiom $TypeConstructor(T$System.Web.UI.TemplateControl()) == T$System.Web.UI.TemplateControl;

procedure {:extern} System.Web.UI.Control.set_Visible$System.Boolean($this: Ref, value$in: bool);



const {:value "Your ID is {0} and SymT is {1}"} unique $string_literal_Your$ID$is$$0$$and$SymT$is$$1$_8: Ref;

const {:value "openid.identity"} unique $string_literal_openid.identity_9: Ref;

procedure {:extern} System.String.Format$System.String$System.Object$System.Object(format$in: Ref, arg0$in: Ref, arg1$in: Ref) returns ($result: Ref);



procedure {:extern} System.Web.UI.HtmlControls.HtmlContainerControl.set_InnerHtml$System.String($this: Ref, value$in: Ref);



procedure OpenIDExample.LogIn.LoginBtn_Click$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



const {:value "ProcessAuthenticationRequest"} unique $string_literal_ProcessAuthenticationRequest_10: Ref;

procedure {:extern} System.Type.GetMethod$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



procedure {:extern} CST.CST_Ops.recordme$System.Object$CST.CST_Struct$System.Reflection.MethodInfo(o$in: Ref, msg$in: Ref, mi$in: Ref);



procedure OpenID20NameSpace.Yahoo_RP.GenerateURL$OpenID20NameSpace.AuthenticationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} System.Web.UI.Page.get_Response($this: Ref) returns ($result: Ref);



procedure {:extern} System.Web.HttpResponse.Redirect$System.String($this: Ref, url$in: Ref);



procedure OpenIDExample.LogIn.LogoutBtn_Click$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



procedure OpenIDExample.LogIn.#ctor($this: Ref);



const {:value "http://localhost:32928/LogIn.aspx"} unique $string_literal_http$$$localhost$32928$LogIn.aspx_11: Ref;

const {:value "https://open.login.yahooapis.com/openid/op/auth"} unique $string_literal_https$$$open.login.yahooapis.com$openid$op$auth_12: Ref;

procedure OpenID20NameSpace.Yahoo_RP.#ctor$System.String$System.String($this: Ref, return_uri$in: Ref, endpointUrl$in: Ref);



procedure {:extern} System.Web.UI.Page.#ctor($this: Ref);



procedure T$OpenIDExample.LogIn.#cctor();



implementation T$OpenIDExample.LogIn.#cctor()
{

  anon0:
    return;
}



implementation OpenID20NameSpace.Yahoo_RP.#ctor($this: Ref)
{

  anon0:
    assume {:breadcrumb 98} true;
    goto corral_source_split_91;

  corral_source_split_91:
    goto corral_source_split_92;

  corral_source_split_92:
    call {:si_unique_call 69} OpenID20NameSpace.RelyingParty.#ctor($this);
    return;
}



procedure OpenID20NameSpace.Yahoo_RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.Yahoo_RP.SignIn($this: Ref);



procedure {:extern} System.Text.StringBuilder.#ctor$System.String($this: Ref, value$in: Ref);



function {:extern} T$System.Text.StringBuilder() : Ref;

const {:extern} unique T$System.Text.StringBuilder: int;

axiom $TypeConstructor(T$System.Text.StringBuilder()) == T$System.Text.StringBuilder;

const {:value "?openid.claimed_id={0}&openid.identity={1}&openid.return_to={2}?SymT={6}&openid.realm={5}&openid.mode={3}&openid.ns={4}"} unique $string_literal_?openid.claimed_id$$0$$openid.identity$$1$$openid.return_to$$2$?SymT$$6$$openid.realm$$5$$openid.mode$$3$$openid.ns$$4$_13: Ref;

procedure {:extern} System.Text.StringBuilder.AppendFormat$System.String$System.Objectarray($this: Ref, format$in: Ref, args$in: Ref) returns ($result: Ref);



procedure {:extern} System.Object.ToString($this: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.Yahoo_RP.GenerateURL$OpenID20NameSpace.AuthenticationResponse($this: Ref, req$in: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.Yahoo_RP.callProcessAuthenticationRequest$OpenID20NameSpace.AuthenticationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



const {:value "ProcessAuthenticationRequestS"} unique $string_literal_ProcessAuthenticationRequestS_14: Ref;

procedure T$OpenID20NameSpace.Yahoo_RP.#cctor();



implementation T$OpenID20NameSpace.Yahoo_RP.#cctor()
{

  anon0:
    return;
}



function T$CST.Nondet_Base() : Ref;

const unique T$CST.Nondet_Base: int;

procedure CST.Nondet_Base.Int($this: Ref) returns ($result: int);



procedure CST.Nondet_Base.String($this: Ref) returns ($result: Ref);



procedure CST.Nondet_Base.Bool($this: Ref) returns ($result: bool);



function T$CST.Debug() : Ref;

const unique T$CST.Debug: int;

procedure CST.Debug.reached();



procedure CST.Debug.#ctor($this: Ref);



procedure T$CST.Debug.#cctor();



implementation T$CST.Debug.#cctor()
{

  anon0:
    return;
}



function T$CST.CST_Struct() : Ref;

const unique T$CST.CST_Struct: int;

var F$CST.CST_Struct.SignedBy: [Ref]Ref;

implementation CST.CST_Struct.#ctor($this: Ref)
{

  anon0:
    F$CST.CST_Struct.SymT[$this] := null;
    F$CST.CST_Struct.SignedBy[$this] := null;
    assume {:breadcrumb 107} true;
    goto corral_source_split_94;

  corral_source_split_94:
    goto corral_source_split_95;

  corral_source_split_95:
    F$CST.CST_Struct.SymT[$this] := $string_literal__6;
    goto corral_source_split_96;

  corral_source_split_96:
    goto corral_source_split_97;

  corral_source_split_97:
    F$CST.CST_Struct.SignedBy[$this] := $string_literal__6;
    goto corral_source_split_98;

  corral_source_split_98:
    call {:si_unique_call 70} System.Object.#ctor($this);
    return;
}



procedure T$CST.CST_Struct.#cctor();



implementation T$CST.CST_Struct.#cctor()
{

  anon0:
    return;
}



var F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary: [Ref]Ref;

implementation OpenID20NameSpace.Yahoo_IdP.init($this: Ref)
{

  anon0:
    assume {:breadcrumb 108} true;
    goto corral_source_split_100;

  corral_source_split_100:
    assume $this != null;
    goto corral_source_split_101;

  corral_source_split_101:
    call {:si_unique_call 71} OpenID20NameSpace.OpenIDProvider.init$OpenID20NameSpace.IDAssertionRecs($this, F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary[$this]);
    return;
}



procedure OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#ctor($this: Ref);
  modifies F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary, $Alloc;



implementation OpenID20NameSpace.Yahoo_IdP.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var inline$Alloc$0$x: Ref;
  var inline$Alloc$0$$Alloc: [Ref]bool;

  anon0:
    F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary[$this] := null;
    assume {:breadcrumb 109} true;
    goto corral_source_split_103;

  corral_source_split_103:
    goto corral_source_split_104;

  corral_source_split_104:
    goto inline$Alloc$0$Entry;

  inline$Alloc$0$Entry:
    havoc inline$Alloc$0$x;
    inline$Alloc$0$$Alloc := $Alloc;
    goto inline$Alloc$0$anon0;

  inline$Alloc$0$anon0:
    assume ($Alloc[inline$Alloc$0$x] <==> false) && inline$Alloc$0$x != null;
    $Alloc[inline$Alloc$0$x] := true;
    goto inline$Alloc$0$Return;

  inline$Alloc$0$Return:
    $tmp0 := inline$Alloc$0$x;
    goto anon0$1;

  anon0$1:
    call {:si_unique_call 72} OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def;
    F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary[$this] := $tmp0;
    goto corral_source_split_106;

  corral_source_split_106:
    call {:si_unique_call 73} OpenID20NameSpace.OpenIDProvider.#ctor($this);
    return;
}



var F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary: [Ref]Ref;

implementation OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref) returns ($result: Ref)
{
  var IdPSessionSecret: Ref;
  var client_id: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;

  anon0:
    IdPSessionSecret := IdPSessionSecret$in;
    client_id := client_id$in;
    assume {:breadcrumb 110} true;
    goto corral_source_split_108;

  corral_source_split_108:
    assume $this != null;
    $tmp0 := F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$this];
    goto corral_source_split_109;

  corral_source_split_109:
    call {:si_unique_call 74} $tmp2 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp0, IdPSessionSecret);
    $tmp1 := $tmp2;
    goto corral_source_split_110;

  corral_source_split_110:
    call {:si_unique_call 75} $tmp4 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp1, client_id);
    $tmp3 := $tmp4;
    $result := $tmp3;
    return;
}



procedure {:extern} System.Collections.Generic.Dictionary`2.#ctor($this: Ref);



function {:extern} TKey$T$System.Collections.Generic.Dictionary`2(parent: Ref) : Ref;

function {:extern} TValue$T$System.Collections.Generic.Dictionary`2(parent: Ref) : Ref;

function {:extern} T$System.Collections.Generic.Dictionary`2(TKey: Ref, TValue: Ref) : Ref;

const {:extern} unique T$System.Collections.Generic.Dictionary`2: int;

function {:extern} T$System.String() : Ref;

const {:extern} unique T$System.String: int;

axiom $TypeConstructor(T$System.String()) == T$System.String;

implementation OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var inline$Alloc$0$x: Ref;
  var inline$Alloc$0$$Alloc: [Ref]bool;

  anon0:
    F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$this] := null;
    assume {:breadcrumb 114} true;
    goto corral_source_split_112;

  corral_source_split_112:
    goto corral_source_split_113;

  corral_source_split_113:
    goto inline$Alloc$0$Entry;

  inline$Alloc$0$Entry:
    havoc inline$Alloc$0$x;
    inline$Alloc$0$$Alloc := $Alloc;
    goto inline$Alloc$0$anon0;

  inline$Alloc$0$anon0:
    assume ($Alloc[inline$Alloc$0$x] <==> false) && inline$Alloc$0$x != null;
    $Alloc[inline$Alloc$0$x] := true;
    goto inline$Alloc$0$Return;

  inline$Alloc$0$Return:
    $tmp0 := inline$Alloc$0$x;
    goto anon0$1;

  anon0$1:
    call {:si_unique_call 76} System.Collections.Generic.Dictionary`2.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OpenID20NameSpace.IDAssertionEntry()));
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.String();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OpenID20NameSpace.IDAssertionEntry());
    F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$this] := $tmp0;
    goto corral_source_split_115;

  corral_source_split_115:
    call {:si_unique_call 77} System.Object.#ctor($this);
    return;
}



procedure T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#cctor();



implementation T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#cctor()
{

  anon0:
    return;
}



procedure T$OpenID20NameSpace.Yahoo_IdP.#cctor();



implementation T$OpenID20NameSpace.Yahoo_IdP.#cctor()
{

  anon0:
    return;
}



procedure corral_atomic_begin();



procedure corral_atomic_end();



procedure corral_getThreadID() returns (id: int);



var $GetMeHereTracker: int;
