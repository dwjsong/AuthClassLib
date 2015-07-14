const hashsetEmpty : [Union]bool;
axiom (forall x: Union :: {hashsetEmpty[x]} !hashsetEmpty[x]);

var hashsets: [Ref][Union]bool;
var hashsetSize: [Ref]int;

procedure {:extern} System.Collections.Generic.HashSet`1.#ctor($this: Ref) 
{
  hashsets[$this] := hashsetEmpty;
  hashsetSize[$this] := 0;
}

procedure {:extern} System.Collections.Generic.HashSet`1.Add$`0($this: Ref, item$in: Union) returns ($result: bool)
{
  $result := !hashsets[$this][item$in];
  hashsets[$this][item$in] := true;
  if ($result) {
    hashsetSize[$this] := hashsetSize[$this] + 1;
  }
}

procedure {:extern} System.Collections.Generic.HashSet`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool)
{
  $result := hashsets[$this][item$in];
}

procedure {:extern} System.Collections.Generic.HashSet`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool)
{
  $result := hashsets[$this][item$in];
  hashsets[$this][item$in] := false;
  if ($result) {
    hashsetSize[$this] := hashsetSize[$this] - 1;
  }
}

procedure {:extern} System.Collections.Generic.HashSet`1.get_Count($this: Ref) returns ($result: int)
{
    $result := hashsetSize[$this];
}

procedure {:extern} System.Collections.Generic.HashSet`1.New($this: Ref) returns ($result: Ref)
{
    call $result := Alloc();
    call System.Collections.Generic.HashSet`1.#ctor($result);
    assume $DynamicType($result) == $DynamicType($this);
}

var stacks: [Ref][int]Union;
var stackPtr: [Ref]int;

procedure {:extern} System.Collections.Generic.Stack`1.#ctor($this: Ref)
{
  stackPtr[$this] := 0;
}

procedure {:extern} System.Collections.Generic.Stack`1.Push$`0($this: Ref, item$in: Union)
{
  stacks[$this][stackPtr[$this]] := item$in;
  stackPtr[$this] := stackPtr[$this] + 1;
}

procedure {:extern} System.Collections.Generic.Stack`1.Pop($this: Ref) returns ($result: Union)
{
  stackPtr[$this] := stackPtr[$this] - 1;
  $result := stacks[$this][stackPtr[$this]];
}

procedure {:extern} System.Collections.Generic.Stack`1.get_Count($this: Ref) returns ($result: int)
{
  $result := stackPtr[$this];
}

procedure {:extern} System.Collections.Generic.Stack`1.Peek($this: Ref) returns ($result: Union)
{
  $result := stacks[$this][stackPtr[$this] - 1];
}

var listContents: [Ref][int]Union;
var listSize: [Ref]int;

procedure {:extern} System.Collections.Generic.List`1.#ctor($this: Ref)
{
    listSize[$this] := 0;
}

procedure {:extern} System.Collections.Generic.List`1.Add$`0($this: Ref, item$in: Union)
{
    var size: int;

    size := listSize[$this];
    listContents[$this][size] := item$in;
    listSize[$this] := size + 1;
}

procedure {:extern} System.Collections.Generic.List`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool)
{
    var iter: int;

    $result := false;
    iter := 0;
    while (iter < listSize[$this] && !$result) {
        $result := (item$in == listContents[$this][iter]);
	iter := iter + 1;
    }

    while (iter < listSize[$this]) {
        listContents[$this][iter-1] := listContents[$this][iter];
	iter := iter + 1;
    }

    if ($result) {
        listSize[$this] := listSize[$this] - 1;
    }
}

procedure {:extern} System.Collections.Generic.List`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool)
{
    var iter: int;

    $result := false;
    iter := 0;
    while (iter < listSize[$this] && !$result) {
        $result := (item$in == listContents[$this][iter]);
	iter := iter + 1;
    }
}

procedure {:extern} System.Collections.Generic.List`1.get_Count($this: Ref) returns ($result: int)
{
    $result := listSize[$this];
}

procedure {:extern} System.Collections.Generic.List`1.Clear($this: Ref)
{
    listSize[$this] := 0;
}

procedure {:extern} System.Collections.Generic.List`1.get_Item$System.Int32($this: Ref, index$in: int) returns ($result: Union)
{
    $result := listContents[$this][index$in];
}

procedure {:extern} System.Collections.Generic.List`1.set_Item$System.Int32$`0($this: Ref, index$in: int, value$in: Union)
{
    listContents[$this][index$in] := value$in;
}

var AllMaps: [Ref][Union]Union;

procedure {:extern} System.Collections.Generic.Dictionary`2.get_Item$`0(this: Ref, key$in: Union) returns ($result: Union)
{
    $result := AllMaps[this][key$in];
    return;
}


procedure {:extern} System.Collections.Generic.Dictionary`2.set_Item$`0$`1(this: Ref, key$in: Union, value$in: Union)
{
    AllMaps[this][key$in] := value$in;
    return;
}

// Copyright (c) 2010, Microsoft Corp.
// Bytecode Translator prelude

procedure {:inline 1} Alloc() returns (x: Ref);
  modifies $Alloc;



implementation {:inline 1} Alloc() returns (x: Ref)
{
    assume $Alloc[x] == false && x != null;
    $Alloc[x] := true;
}



procedure {:inline 1} System.Object.GetType(this: Ref) returns ($result: Ref);



implementation {:inline 1} System.Object.GetType(this: Ref) returns ($result: Ref)
{
    $result := $DynamicType(this);
}



axiom Union2Int(null) == 0;

axiom Union2Bool(null) == false;

function $ThreadDelegate(Ref) : Ref;

procedure {:inline 1} System.Threading.Thread.#ctor$System.Threading.ParameterizedThreadStart(this: Ref, start$in: Ref);



implementation {:inline 1} System.Threading.Thread.#ctor$System.Threading.ParameterizedThreadStart(this: Ref, start$in: Ref)
{
    assume $ThreadDelegate(this) == start$in;
}



procedure {:inline 1} System.Threading.Thread.Start$System.Object(this: Ref, parameter$in: Ref);



implementation {:inline 1} System.Threading.Thread.Start$System.Object(this: Ref, parameter$in: Ref)
{
    async call Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object($ThreadDelegate(this), parameter$in);
}



procedure Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref);



implementation Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref)
{
    $Exception := null;
    call System.Threading.ParameterizedThreadStart.Invoke$System.Object(this, obj$in);
}



procedure {:extern} System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref);



procedure {:inline 1} System.Threading.Thread.#ctor$System.Threading.ThreadStart(this: Ref, start$in: Ref);



implementation {:inline 1} System.Threading.Thread.#ctor$System.Threading.ThreadStart(this: Ref, start$in: Ref)
{
    assume $ThreadDelegate(this) == start$in;
}



procedure {:inline 1} System.Threading.Thread.Start(this: Ref);



implementation {:inline 1} System.Threading.Thread.Start(this: Ref)
{
    async call Wrapper_System.Threading.ThreadStart.Invoke($ThreadDelegate(this));
}



procedure Wrapper_System.Threading.ThreadStart.Invoke(this: Ref);



implementation Wrapper_System.Threading.ThreadStart.Invoke(this: Ref)
{
    $Exception := null;
    call System.Threading.ThreadStart.Invoke(this);
}



procedure {:extern} System.Threading.ThreadStart.Invoke(this: Ref);



procedure {:inline 1} System.String.op_Equality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool);



procedure {:inline 1} System.String.op_Inequality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool);



implementation System.String.op_Equality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool)
{
    $result := a$in == b$in;
}



implementation System.String.op_Inequality$System.String$System.String(a$in: Ref, b$in: Ref) returns ($result: bool)
{
    $result := a$in != b$in;
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



implementation {:inline 1} $BoxFromBool(b: bool) returns (r: Ref)
{
    call r := Alloc();
    assume $TypeConstructor($DynamicType(r)) == $BoolValueType;
    assume Union2Bool(r) == b;
}



procedure {:inline 1} $BoxFromInt(i: int) returns (r: Ref);



implementation {:inline 1} $BoxFromInt(i: int) returns (r: Ref)
{
    call r := Alloc();
    assume $TypeConstructor($DynamicType(r)) == $IntValueType;
    assume Union2Int(r) == i;
}



procedure {:inline 1} $BoxFromReal(r: Real) returns (rf: Ref);



implementation {:inline 1} $BoxFromReal(r: Real) returns (rf: Ref)
{
    call rf := Alloc();
    assume $TypeConstructor($DynamicType(rf)) == $RealValueType;
    assume Union2Real(rf) == r;
}



procedure {:inline 1} $BoxFromUnion(u: Union) returns (r: Ref);



implementation {:inline 1} $BoxFromUnion(u: Union) returns (r: Ref)
{
    r := u;
}



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

function T$LiveIDNameSpace.LiveID_RP_For_vProgram() : Ref;

const unique T$LiveIDNameSpace.LiveID_RP_For_vProgram: int;

procedure LiveIDNameSpace.LiveID_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool);



procedure {:extern} GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson$GenericAuthNameSpace.RP.AuthenticationConclusion(conclusion$in: Ref);



implementation LiveIDNameSpace.LiveID_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool)
{
  var conclusion: Ref;
  var $localExc: Ref;
  var $label: int;

    conclusion := conclusion$in;
    assume {:breadcrumb 0} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Assertion.cs"} {:sourceLine 9} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Assertion.cs"} {:sourceLine 9} true;
    call GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson$GenericAuthNameSpace.RP.AuthenticationConclusion(conclusion);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Assertion.cs"} {:sourceLine 10} true;
    $result := true;
    return;
}



procedure LiveIDNameSpace.LiveID_RP_For_vProgram.#ctor($this: Ref);



procedure {:extern} LiveIDNameSpace.LiveID_RP.#ctor($this: Ref);



implementation LiveIDNameSpace.LiveID_RP_For_vProgram.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 1} true;
    call LiveIDNameSpace.LiveID_RP.#ctor($this);
}



procedure T$LiveIDNameSpace.LiveID_RP_For_vProgram.#cctor();



implementation T$LiveIDNameSpace.LiveID_RP_For_vProgram.#cctor()
{
}



function T$LiveIDNameSpace.LiveID_IdP() : Ref;

const unique T$LiveIDNameSpace.LiveID_IdP: int;

var F$LiveIDNameSpace.LiveID_IdP.Nondet: Ref;

var F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary: [Ref]Ref;

var F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary: [Ref]Ref;

procedure LiveIDNameSpace.LiveID_IdP.init($this: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AuthorizationCodeRecs$OAuth20NameSpace.AccessTokenRecs($this: Ref, AuthorizationCodeRecs1$in: Ref, AccessTokenRecs1$in: Ref);



implementation LiveIDNameSpace.LiveID_IdP.init($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 2} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 29} true;
    assume $this != null;
    assume $this != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 29} true;
    call OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AuthorizationCodeRecs$OAuth20NameSpace.AccessTokenRecs($this, F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary[$this], F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary[$this]);
}



procedure LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this: Ref, redirect_uri$in: Ref, scope$in: Ref, state$in: Ref) returns ($result: Ref);



procedure {:extern} OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.#ctor($this: Ref);



function {:extern} T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry() : Ref;

const {:extern} unique T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry: int;

axiom $TypeConstructor(T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry()) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;

var {:extern} F$OAuth20NameSpace.AccessTokenEntry.redirect_uri: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AccessTokenEntry.scope: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AccessTokenEntry.state: [Ref]Ref;

procedure {:extern} OpenIDConnectNameSpace.NondetOpenIDConnect.JsonWebToken($this: Ref) returns ($result: Ref);



var {:extern} F$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.id_token: [Ref]Ref;

implementation LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this: Ref, redirect_uri$in: Ref, scope$in: Ref, state$in: Ref) returns ($result: Ref)
{
  var redirect_uri: Ref;
  var scope: Ref;
  var state: Ref;
  var entry_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

    redirect_uri := redirect_uri$in;
    scope := scope$in;
    state := state$in;
    assume {:breadcrumb 3} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 104} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 104} true;
    call OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    entry_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 105} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 105} true;
    F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[entry_Ref] := redirect_uri;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 106} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 106} true;
    F$OAuth20NameSpace.AccessTokenEntry.scope[entry_Ref] := scope;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 107} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 107} true;
    F$OAuth20NameSpace.AccessTokenEntry.state[entry_Ref] := state;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 108} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 108} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 108} true;
    call $tmp1 := OpenIDConnectNameSpace.NondetOpenIDConnect.JsonWebToken(F$LiveIDNameSpace.LiveID_IdP.Nondet);
    F$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.id_token[entry_Ref] := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 110} true;
    $result := entry_Ref;
    return;
}



procedure LiveIDNameSpace.LiveID_IdP.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} OpenIDConnectNameSpace.NondetOpenIDConnect.AuthorizationCodeEntry($this: Ref) returns ($result: Ref);



var {:extern} F$OAuth20NameSpace.AuthorizationRequest.redirect_uri: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AuthorizationRequest.scope: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AuthorizationCodeEntry.scope: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AuthorizationRequest.state: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AuthorizationCodeEntry.state: [Ref]Ref;

implementation LiveIDNameSpace.LiveID_IdP.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var entry_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 4} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 114} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 114} true;
    call $tmp0 := OpenIDConnectNameSpace.NondetOpenIDConnect.AuthorizationCodeEntry(F$LiveIDNameSpace.LiveID_IdP.Nondet);
    entry_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 115} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 115} true;
    $tmp1 := req;
    assume $tmp1 != null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[entry_Ref] := F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$tmp1];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 116} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 116} true;
    $tmp2 := req;
    assume $tmp2 != null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.scope[entry_Ref] := F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp2];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 117} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 117} true;
    $tmp3 := req;
    assume $tmp3 != null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.state[entry_Ref] := F$OAuth20NameSpace.AuthorizationRequest.state[$tmp3];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 118} true;
    $result := entry_Ref;
    return;
}



procedure LiveIDNameSpace.LiveID_IdP.#ctor($this: Ref);



procedure LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.#ctor($this: Ref);



function T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def() : Ref;

const unique T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def: int;

procedure LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.#ctor($this: Ref);



function T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def() : Ref;

const unique T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def: int;

procedure {:extern} OpenIDConnectNameSpace.OpenIDProvider.#ctor($this: Ref);



implementation LiveIDNameSpace.LiveID_IdP.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

    F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary[$this] := null;
    F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary[$this] := null;
    assume {:breadcrumb 5} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 99} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 99} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 99} true;
    call LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def();
    assume $TypeConstructor($DynamicType($tmp0)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary[$this] := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 100} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 100} true;
    call $tmp1 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 100} true;
    call LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def();
    assume $TypeConstructor($DynamicType($tmp1)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary[$this] := $tmp1;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 100} true;
    call OpenIDConnectNameSpace.OpenIDProvider.#ctor($this);
}



var F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.Dictionary: [Ref]Ref;

procedure LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref) returns ($result: Ref);



procedure {:extern} System.Collections.Generic.Dictionary`2.get_Item$`0($this: Ref, key$in: Ref) returns ($result: Ref);



implementation LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref) returns ($result: Ref)
{
  var IdPSessionSecret: Ref;
  var client_id: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

    IdPSessionSecret := IdPSessionSecret$in;
    client_id := client_id$in;
    assume {:breadcrumb 6} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 40} true;
    assume $this != null;
    $tmp0 := F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.Dictionary[$this];
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 40} true;
    call $tmp2 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp0, IdPSessionSecret);
    $tmp1 := $tmp2;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 40} true;
    call $tmp4 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp1, client_id);
    $tmp3 := $tmp4;
    $result := $tmp3;
    return;
}



procedure LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref, Entry$in: Ref) returns ($result: bool);



procedure {:extern} System.Collections.Generic.Dictionary`2.#ctor($this: Ref);



function {:extern} TKey$T$System.Collections.Generic.Dictionary`2(parent: Ref) : Ref;

function {:extern} TValue$T$System.Collections.Generic.Dictionary`2(parent: Ref) : Ref;

function {:extern} T$System.Collections.Generic.Dictionary`2(TKey: Ref, TValue: Ref) : Ref;

const {:extern} unique T$System.Collections.Generic.Dictionary`2: int;

function {:extern} T$System.String() : Ref;

const {:extern} unique T$System.String: int;

axiom $TypeConstructor(T$System.String()) == T$System.String;

function {:extern} T$OAuth20NameSpace.AuthorizationCodeEntry() : Ref;

const {:extern} unique T$OAuth20NameSpace.AuthorizationCodeEntry: int;

axiom $TypeConstructor(T$OAuth20NameSpace.AuthorizationCodeEntry()) == T$OAuth20NameSpace.AuthorizationCodeEntry;

procedure {:extern} System.Collections.Generic.Dictionary`2.set_Item$`0$`1($this: Ref, key$in: Ref, value$in: Ref);



implementation LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref, Entry$in: Ref) returns ($result: bool)
{
  var IdPSessionSecret: Ref;
  var client_id: Ref;
  var Entry: Ref;
  var AuthorizationCodeEntry_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

    IdPSessionSecret := IdPSessionSecret$in;
    client_id := client_id$in;
    Entry := Entry$in;
    assume {:breadcrumb 7} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 44} true;
    AuthorizationCodeEntry_Ref := Entry;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 45} true;
    if (AuthorizationCodeEntry_Ref == null)
    {
        assume {:breadcrumb 8} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 46} true;
        $result := false;
        return;
    }
    else
    {
        assume {:breadcrumb 9} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 47} true;
    assume $this != null;
    $tmp0 := F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.Dictionary[$this];
    call $tmp1 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 47} true;
    call System.Collections.Generic.Dictionary`2.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OAuth20NameSpace.AuthorizationCodeEntry());
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp1)) == T$System.String();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp1)) == T$OAuth20NameSpace.AuthorizationCodeEntry();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 47} true;
    call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp0, IdPSessionSecret, $tmp1);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 48} true;
    assume $this != null;
    $tmp2 := F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.Dictionary[$this];
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 48} true;
    call $tmp4 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp2, IdPSessionSecret);
    $tmp3 := $tmp4;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 48} true;
    call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp3, client_id, AuthorizationCodeEntry_Ref);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 49} true;
    $result := true;
    return;
}



procedure LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.findISSByClientIDAndCode$System.String$System.String($this: Ref, client_id$in: Ref, authorization_code$in: Ref) returns ($result: Ref);



procedure {:extern} CST.Nondet_Base.String($this: Ref) returns ($result: Ref);



var {:extern} F$OAuth20NameSpace.AuthorizationCodeEntry.code: [Ref]Ref;

var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req: Ref;

var {:extern} F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret: [Ref]Ref;

procedure {:extern} OAuth20NameSpace.AuthorizationRequest.get_Realm($this: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.SignInIdP_Req.get_Realm($this: Ref) returns ($result: Ref);



function {:extern} T$OAuth20NameSpace.AuthorizationRequest() : Ref;

const {:extern} unique T$OAuth20NameSpace.AuthorizationRequest: int;

axiom $TypeConstructor(T$OAuth20NameSpace.AuthorizationRequest()) == T$OAuth20NameSpace.AuthorizationRequest;

function {:extern} T$OpenIDConnectNameSpace.AuthenticationRequest() : Ref;

const {:extern} unique T$OpenIDConnectNameSpace.AuthenticationRequest: int;

axiom $TypeConstructor(T$OpenIDConnectNameSpace.AuthenticationRequest()) == T$OpenIDConnectNameSpace.AuthenticationRequest;

var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.RP: Ref;

var {:extern} F$GenericAuthNameSpace.RP.Realm: [Ref]Ref;

implementation LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.findISSByClientIDAndCode$System.String$System.String($this: Ref, client_id$in: Ref, authorization_code$in: Ref) returns ($result: Ref)
{
  var client_id: Ref;
  var authorization_code: Ref;
  var IdPSessinSecret_Ref: Ref;
  var $tmp0: Ref;
  var entry_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: bool;
  var $tmp4: Ref;
  var $tmp5: bool;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: bool;
  var $tmp10: Ref;
  var $tmp11: bool;
  var stack_0_System_Boolean_bool: bool;
  var $localExc: Ref;
  var $label: int;

    client_id := client_id$in;
    authorization_code := authorization_code$in;
    assume {:breadcrumb 10} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 53} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 53} true;
    call $tmp0 := CST.Nondet_Base.String(F$LiveIDNameSpace.LiveID_IdP.Nondet);
    IdPSessinSecret_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 54} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 54} true;
    call $tmp1 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($this, IdPSessinSecret_Ref, client_id);
    entry_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 55} true;
    $tmp2 := entry_Ref;
    assume $tmp2 != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 55} true;
    call $tmp3 := System.String.op_Equality$System.String$System.String(F$OAuth20NameSpace.AuthorizationCodeEntry.code[$tmp2], authorization_code);
    assume $tmp3;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 58} true;
    $tmp4 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
    assume $tmp4 != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 58} true;
    call $tmp5 := System.String.op_Equality$System.String$System.String(IdPSessinSecret_Ref, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp4]);
    if ($tmp5)
    {
        assume {:breadcrumb 11} true;
        if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenIDConnectNameSpace.AuthenticationRequest)
        {
            call $tmp6 := OAuth20NameSpace.AuthorizationRequest.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
        }
        else
        {
            if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OAuth20NameSpace.AuthorizationRequest)
            {
                call $tmp7 := OAuth20NameSpace.AuthorizationRequest.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
            }
            else
            {
                call $tmp8 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
            }
        }

        call $tmp9 := System.String.op_Equality$System.String$System.String(client_id, (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp6 else (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp7 else $tmp8)));
        if ($tmp9)
        {
            assume {:breadcrumb 13} true;
        }
        else
        {
            assume {:breadcrumb 14} true;
            goto IL_0062;
        }

        $tmp10 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
        assume $tmp10 != null;
        call $tmp11 := System.String.op_Equality$System.String$System.String(client_id, F$GenericAuthNameSpace.RP.Realm[$tmp10]);
        stack_0_System_Boolean_bool := $tmp11;
    }
    else
    {
        assume {:breadcrumb 12} true;

      IL_0062:
        stack_0_System_Boolean_bool := false;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 58} true;
    assume stack_0_System_Boolean_bool != false;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 63} true;
    $result := IdPSessinSecret_Ref;
    return;
}



procedure {:extern} System.Object.#ctor($this: Ref);



implementation LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.Dictionary[$this] := null;
    assume {:breadcrumb 15} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 36} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 36} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 36} true;
    call System.Collections.Generic.Dictionary`2.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OAuth20NameSpace.AuthorizationCodeEntry()));
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.String();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OAuth20NameSpace.AuthorizationCodeEntry());
    F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.Dictionary[$this] := $tmp0;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 36} true;
    call System.Object.#ctor($this);
}



procedure T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.#cctor();



implementation T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.#cctor()
{
}



var F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.Dictionary: [Ref]Ref;

procedure LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref) returns ($result: Ref);



implementation LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref) returns ($result: Ref)
{
  var IdPSessionSecret: Ref;
  var client_id: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

    IdPSessionSecret := IdPSessionSecret$in;
    client_id := client_id$in;
    assume {:breadcrumb 16} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 72} true;
    assume $this != null;
    $tmp0 := F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.Dictionary[$this];
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 72} true;
    call $tmp2 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp0, IdPSessionSecret);
    $tmp1 := $tmp2;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 72} true;
    call $tmp4 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp1, client_id);
    $tmp3 := $tmp4;
    $result := $tmp3;
    return;
}



procedure LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref, Entry$in: Ref) returns ($result: bool);



implementation LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref, Entry$in: Ref) returns ($result: bool)
{
  var IdPSessionSecret: Ref;
  var client_id: Ref;
  var Entry: Ref;
  var IDTokenAndAccessTokenEntry_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

    IdPSessionSecret := IdPSessionSecret$in;
    client_id := client_id$in;
    Entry := Entry$in;
    assume {:breadcrumb 17} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 76} true;
    IDTokenAndAccessTokenEntry_Ref := Entry;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 77} true;
    if (IDTokenAndAccessTokenEntry_Ref == null)
    {
        assume {:breadcrumb 18} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 78} true;
        $result := false;
        return;
    }
    else
    {
        assume {:breadcrumb 19} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 79} true;
    assume $this != null;
    $tmp0 := F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.Dictionary[$this];
    call $tmp1 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 79} true;
    call System.Collections.Generic.Dictionary`2.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry());
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp1)) == T$System.String();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp1)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 79} true;
    call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp0, IdPSessionSecret, $tmp1);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 80} true;
    assume $this != null;
    $tmp2 := F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.Dictionary[$this];
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 80} true;
    call $tmp4 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp2, IdPSessionSecret);
    $tmp3 := $tmp4;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 80} true;
    call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp3, client_id, IDTokenAndAccessTokenEntry_Ref);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 81} true;
    $result := true;
    return;
}



procedure LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.findISSByClientIDAndAccessToken$System.String$System.String($this: Ref, client_id$in: Ref, access_token$in: Ref) returns ($result: Ref);



var {:extern} F$OAuth20NameSpace.AccessTokenEntry.access_token: [Ref]Ref;

implementation LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.findISSByClientIDAndAccessToken$System.String$System.String($this: Ref, client_id$in: Ref, access_token$in: Ref) returns ($result: Ref)
{
  var client_id: Ref;
  var access_token: Ref;
  var IdPSessinSecret_Ref: Ref;
  var $tmp0: Ref;
  var entry_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: bool;
  var $localExc: Ref;
  var $label: int;

    client_id := client_id$in;
    access_token := access_token$in;
    assume {:breadcrumb 20} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 85} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 85} true;
    call $tmp0 := CST.Nondet_Base.String(F$LiveIDNameSpace.LiveID_IdP.Nondet);
    IdPSessinSecret_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 86} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 86} true;
    call $tmp1 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$System.String$System.String($this, IdPSessinSecret_Ref, client_id);
    entry_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 87} true;
    $tmp2 := entry_Ref;
    assume $tmp2 != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 87} true;
    call $tmp3 := System.String.op_Equality$System.String$System.String(F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp2], access_token);
    assume $tmp3;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 88} true;
    $result := IdPSessinSecret_Ref;
    return;
}



procedure LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.findISSByClientIDAndRefreshToken$System.String$System.String($this: Ref, client_id$in: Ref, refresh_token$in: Ref) returns ($result: Ref);



var {:extern} F$OAuth20NameSpace.AccessTokenEntry.refresh_token: [Ref]Ref;

implementation LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.findISSByClientIDAndRefreshToken$System.String$System.String($this: Ref, client_id$in: Ref, refresh_token$in: Ref) returns ($result: Ref)
{
  var client_id: Ref;
  var refresh_token: Ref;
  var IdPSessinSecret_Ref: Ref;
  var $tmp0: Ref;
  var entry_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: bool;
  var $localExc: Ref;
  var $label: int;

    client_id := client_id$in;
    refresh_token := refresh_token$in;
    assume {:breadcrumb 21} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 92} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 92} true;
    call $tmp0 := CST.Nondet_Base.String(F$LiveIDNameSpace.LiveID_IdP.Nondet);
    IdPSessinSecret_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 93} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 93} true;
    call $tmp1 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$System.String$System.String($this, IdPSessinSecret_Ref, client_id);
    entry_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 94} true;
    $tmp2 := entry_Ref;
    assume $tmp2 != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 94} true;
    call $tmp3 := System.String.op_Equality$System.String$System.String(F$OAuth20NameSpace.AccessTokenEntry.refresh_token[$tmp2], refresh_token);
    assume $tmp3;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 95} true;
    $result := IdPSessinSecret_Ref;
    return;
}



implementation LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.Dictionary[$this] := null;
    assume {:breadcrumb 22} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 69} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 69} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 69} true;
    call System.Collections.Generic.Dictionary`2.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry()));
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.String();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry());
    F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.Dictionary[$this] := $tmp0;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 69} true;
    call System.Object.#ctor($this);
}



procedure T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.#cctor();



implementation T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.#cctor()
{
}



procedure T$LiveIDNameSpace.LiveID_IdP.#cctor();



implementation T$LiveIDNameSpace.LiveID_IdP.#cctor()
{
    F$LiveIDNameSpace.LiveID_IdP.Nondet := null;
}



function T$SynthesizedPortion() : Ref;

const unique T$SynthesizedPortion: int;

procedure SynthesizedPortion.SynthesizedSequence();



var F$PoirotMain.Nondet: Ref;

procedure {:extern} OpenIDConnectNameSpace.NondetOpenIDConnect.AuthenticationResponse($this: Ref) returns ($result: Ref);



procedure {:extern} OpenIDConnectNameSpace.RelyingParty.constructTokenRequest$OpenIDConnectNameSpace.AuthenticationResponse($this: Ref, codeResp$in: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.IdP: Ref;

procedure {:extern} OpenIDConnectNameSpace.OpenIDProvider.TokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} OpenIDConnectNameSpace.RelyingParty.conclude$OpenIDConnectNameSpace.TokenResponse($this: Ref, tokenResp$in: Ref) returns ($result: Ref);



implementation SynthesizedPortion.SynthesizedSequence()
{
  var O1_Ref: Ref;
  var $tmp0: Ref;
  var O2_Ref: Ref;
  var $tmp1: Ref;
  var O3_Ref: Ref;
  var $tmp2: Ref;
  var G4_Ref: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 23} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\SynthesizedPortion.cs"} {:sourceLine 5} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\SynthesizedPortion.cs"} {:sourceLine 5} true;
    call $tmp0 := OpenIDConnectNameSpace.NondetOpenIDConnect.AuthenticationResponse(F$PoirotMain.Nondet);
    O1_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\SynthesizedPortion.cs"} {:sourceLine 6} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\SynthesizedPortion.cs"} {:sourceLine 6} true;
    call $tmp1 := OpenIDConnectNameSpace.RelyingParty.constructTokenRequest$OpenIDConnectNameSpace.AuthenticationResponse(F$GenericAuthNameSpace.GlobalObjects_base.RP, O1_Ref);
    O2_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\SynthesizedPortion.cs"} {:sourceLine 7} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\SynthesizedPortion.cs"} {:sourceLine 7} true;
    call $tmp2 := OpenIDConnectNameSpace.OpenIDProvider.TokenEndpoint$OpenIDConnectNameSpace.TokenRequest(F$GenericAuthNameSpace.GlobalObjects_base.IdP, O2_Ref);
    O3_Ref := $tmp2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\SynthesizedPortion.cs"} {:sourceLine 8} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\SynthesizedPortion.cs"} {:sourceLine 8} true;
    call $tmp3 := OpenIDConnectNameSpace.RelyingParty.conclude$OpenIDConnectNameSpace.TokenResponse(F$GenericAuthNameSpace.GlobalObjects_base.RP, O3_Ref);
    G4_Ref := $tmp3;
}



procedure SynthesizedPortion.#ctor($this: Ref);



implementation SynthesizedPortion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 24} true;
    call System.Object.#ctor($this);
}



procedure T$SynthesizedPortion.#cctor();



implementation T$SynthesizedPortion.#cctor()
{
}



function T$GlobalObjectsForCST() : Ref;

const unique T$GlobalObjectsForCST: int;

procedure GlobalObjectsForCST.init();



procedure {:extern} OpenIDConnectNameSpace.NondetOpenIDConnect.AuthenticationRequest($this: Ref) returns ($result: Ref);



implementation GlobalObjectsForCST.init()
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 25} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 10} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 10} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 10} true;
    call $tmp0 := OpenIDConnectNameSpace.NondetOpenIDConnect.AuthenticationRequest(F$PoirotMain.Nondet);
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 11} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 11} true;
    call $tmp1 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 11} true;
    call LiveIDNameSpace.LiveID_IdP.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$LiveIDNameSpace.LiveID_IdP();
    assume $TypeConstructor($DynamicType($tmp1)) == T$LiveIDNameSpace.LiveID_IdP;
    F$GenericAuthNameSpace.GlobalObjects_base.IdP := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 11} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 11} true;
    call LiveIDNameSpace.LiveID_IdP.init(F$GenericAuthNameSpace.GlobalObjects_base.IdP);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 12} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 12} true;
    call $tmp2 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 12} true;
    call LiveIDNameSpace.LiveID_RP_For_vProgram.#ctor($tmp2);
    assume $DynamicType($tmp2) == T$LiveIDNameSpace.LiveID_RP_For_vProgram();
    assume $TypeConstructor($DynamicType($tmp2)) == T$LiveIDNameSpace.LiveID_RP_For_vProgram;
    F$GenericAuthNameSpace.GlobalObjects_base.RP := $tmp2;
}



procedure GlobalObjectsForCST.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.GlobalObjects_base.#ctor($this: Ref);



implementation GlobalObjectsForCST.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 26} true;
    call GenericAuthNameSpace.GlobalObjects_base.#ctor($this);
}



procedure T$GlobalObjectsForCST.#cctor();



implementation T$GlobalObjectsForCST.#cctor()
{
}



function T$PoirotMain() : Ref;

const unique T$PoirotMain: int;

procedure {:entrypoint} PoirotMain.Main();



implementation PoirotMain.Main()
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 27} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 20} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 20} true;
    call GlobalObjectsForCST.init();
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 21} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 21} true;
    call SynthesizedPortion.SynthesizedSequence();
}



procedure PoirotMain.#ctor($this: Ref);



implementation PoirotMain.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 28} true;
    call System.Object.#ctor($this);
}



procedure T$PoirotMain.#cctor();



implementation T$PoirotMain.#cctor()
{
    F$PoirotMain.Nondet := null;
}



var F$OpenIDConnectNameSpace.AuthenticationRequest.response_mode: [Ref]Ref;

var F$OpenIDConnectNameSpace.AuthenticationRequest.nonce: [Ref]Ref;

var F$OpenIDConnectNameSpace.AuthenticationRequest.display: [Ref]Ref;

var F$OpenIDConnectNameSpace.AuthenticationRequest.prompt: [Ref]Ref;

var F$OpenIDConnectNameSpace.AuthenticationRequest.max_age: [Ref]Ref;

var F$OpenIDConnectNameSpace.AuthenticationRequest.ui_locales: [Ref]Ref;

var F$OpenIDConnectNameSpace.AuthenticationRequest.id_token_hint: [Ref]Ref;

var F$OpenIDConnectNameSpace.AuthenticationRequest.login_hint: [Ref]Ref;

var F$OpenIDConnectNameSpace.AuthenticationRequest.acr_values: [Ref]Ref;

procedure OpenIDConnectNameSpace.AuthenticationRequest.#ctor($this: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationRequest.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.AuthenticationRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenIDConnectNameSpace.AuthenticationRequest.response_mode[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.nonce[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.display[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.prompt[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.max_age[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.ui_locales[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.id_token_hint[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.login_hint[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.acr_values[$this] := null;
    assume {:breadcrumb 29} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 20} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 20} true;
    F$OpenIDConnectNameSpace.AuthenticationRequest.response_mode[$this] := null;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 21} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 21} true;
    F$OpenIDConnectNameSpace.AuthenticationRequest.nonce[$this] := null;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 22} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 22} true;
    F$OpenIDConnectNameSpace.AuthenticationRequest.display[$this] := null;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 23} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 23} true;
    F$OpenIDConnectNameSpace.AuthenticationRequest.prompt[$this] := null;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 24} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 24} true;
    F$OpenIDConnectNameSpace.AuthenticationRequest.max_age[$this] := null;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 25} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 25} true;
    F$OpenIDConnectNameSpace.AuthenticationRequest.ui_locales[$this] := null;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 26} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 26} true;
    F$OpenIDConnectNameSpace.AuthenticationRequest.id_token_hint[$this] := null;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 27} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 27} true;
    F$OpenIDConnectNameSpace.AuthenticationRequest.login_hint[$this] := null;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 28} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 28} true;
    F$OpenIDConnectNameSpace.AuthenticationRequest.acr_values[$this] := null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 28} true;
    call OAuth20NameSpace.AuthorizationRequest.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.AuthenticationRequest.#cctor();



implementation T$OpenIDConnectNameSpace.AuthenticationRequest.#cctor()
{
}



function T$OpenIDConnectNameSpace.OpenIDProvider() : Ref;

const unique T$OpenIDConnectNameSpace.OpenIDProvider: int;

procedure OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this: Ref) returns ($result: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 30} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 222} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 222} true;
    call $tmp0 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $result := $tmp0;
    return;
}



procedure OpenIDConnectNameSpace.OpenIDProvider.set_IDTokenAndAccessTokenRecs$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs($this: Ref, value$in: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.set_IDTokenAndAccessTokenRecs$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 31} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 223} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 223} true;
    call OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this, value);
}



procedure OpenIDConnectNameSpace.OpenIDProvider.init$OAuth20NameSpace.AuthorizationCodeRecs$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs($this: Ref, AuthorizationCodeRecs1$in: Ref, IDTokenAndAccessTokenRecs1$in: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.init$OAuth20NameSpace.AuthorizationCodeRecs$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs($this: Ref, AuthorizationCodeRecs1$in: Ref, IDTokenAndAccessTokenRecs1$in: Ref)
{
  var AuthorizationCodeRecs1: Ref;
  var IDTokenAndAccessTokenRecs1: Ref;
  var $localExc: Ref;
  var $label: int;

    AuthorizationCodeRecs1 := AuthorizationCodeRecs1$in;
    IDTokenAndAccessTokenRecs1 := IDTokenAndAccessTokenRecs1$in;
    assume {:breadcrumb 32} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 227} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 227} true;
    call OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AuthorizationCodeRecs$OAuth20NameSpace.AccessTokenRecs($this, AuthorizationCodeRecs1, IDTokenAndAccessTokenRecs1);
}



procedure OpenIDConnectNameSpace.OpenIDProvider.AuthorizationEndpoint$OpenIDConnectNameSpace.AuthenticationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



const {:value "openid"} unique $string_literal_openid_0: Ref;

procedure {:extern} System.Collections.Generic.HashSet`1.Contains$`0($this: Ref, item$in: Ref) returns ($result: bool);



procedure {:extern} GenericAuthNameSpace.IdP.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.AuthorizationEndpoint$OpenIDConnectNameSpace.AuthenticationRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 33} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 231} true;
    $tmp0 := req;
    assume $tmp0 != null;
    $tmp1 := F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp0];
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 231} true;
    call $tmp2 := System.Collections.Generic.HashSet`1.Contains$`0($tmp1, $string_literal_openid_0);
    if (!$tmp2)
    {
        assume {:breadcrumb 34} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 232} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 35} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 234} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 234} true;
    call $tmp3 := GenericAuthNameSpace.IdP.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
    $result := $tmp3;
    return;
}



procedure OpenIDConnectNameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, claim$in: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.AuthenticationResponse.#ctor($this: Ref);



function T$OpenIDConnectNameSpace.AuthenticationResponse() : Ref;

const unique T$OpenIDConnectNameSpace.AuthenticationResponse: int;

var {:extern} F$OAuth20NameSpace.AuthorizationResponse.code: [Ref]Ref;

const {:value "code="} unique $string_literal_code$_1: Ref;

procedure {:extern} System.String.Concat$System.String$System.String(str0$in: Ref, str1$in: Ref) returns ($result: Ref);



procedure {:extern} HTTP.HTTPComm.HttpPost$System.String$System.String(url$in: Ref, post$in: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, claim$in: Ref) returns ($result: Ref)
{
  var dest: Ref;
  var claim: Ref;
  var AuthCode_Ref: Ref;
  var $tmp0: Ref;
  var resp_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

    dest := dest$in;
    claim := claim$in;
    assume {:breadcrumb 36} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 238} true;
    AuthCode_Ref := $As(claim, T$OAuth20NameSpace.AuthorizationCodeEntry());
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 239} true;
    if (AuthCode_Ref == null)
    {
        assume {:breadcrumb 37} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 240} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 38} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 241} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 241} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 241} true;
    call OpenIDConnectNameSpace.AuthenticationResponse.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenIDConnectNameSpace.AuthenticationResponse();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenIDConnectNameSpace.AuthenticationResponse;
    resp_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 242} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 242} true;
    $tmp1 := AuthCode_Ref;
    assume $tmp1 != null;
    F$OAuth20NameSpace.AuthorizationResponse.code[resp_Ref] := F$OAuth20NameSpace.AuthorizationCodeEntry.code[$tmp1];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 243} true;
    $tmp2 := resp_Ref;
    assume $tmp2 != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 243} true;
    call $tmp3 := System.String.Concat$System.String$System.String($string_literal_code$_1, F$OAuth20NameSpace.AuthorizationResponse.code[$tmp2]);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 243} true;
    call $tmp4 := HTTP.HTTPComm.HttpPost$System.String$System.String(dest, $tmp3);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 244} true;
    $result := resp_Ref;
    return;
}



var {:extern} F$OAuth20NameSpace.AccessTokenRequest.grant_type: [Ref]Ref;

const {:value "authorization_code"} unique $string_literal_authorization_code_2: Ref;

var {:extern} F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AccessTokenRequest.client_id: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AccessTokenRequest.code: [Ref]Ref;

procedure {:extern} OAuth20NameSpace.AuthorizationCodeRecs.findISSByClientIDAndCode$System.String$System.String($this: Ref, client_id$in: Ref, authorization_code$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, Realm$in: Ref) returns ($result: Ref);



var {:extern} F$OAuth20NameSpace.AccessTokenRequest.redirect_uri: [Ref]Ref;

procedure {:extern} OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this: Ref, redirect_uri$in: Ref, scope$in: Ref, state$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, Realm$in: Ref, _ID_Claim$in: Ref) returns ($result: bool);



procedure OpenIDConnectNameSpace.TokenResponse.#ctor($this: Ref);



function T$OpenIDConnectNameSpace.TokenResponse() : Ref;

const unique T$OpenIDConnectNameSpace.TokenResponse: int;

var {:extern} F$OAuth20NameSpace.AccessTokenResponse.access_token: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AccessTokenResponse.refresh_token: [Ref]Ref;

var {:extern} F$OAuth20NameSpace.AccessTokenResponse.scope: [Ref]Ref;

var F$OpenIDConnectNameSpace.TokenResponse.id_token: [Ref]Ref;

implementation OpenIDConnectNameSpace.OpenIDProvider.TokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var $tmp0: Ref;
  var CS$4$0002_Ref: Ref;
  var $tmp1: bool;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var IdPSessionSecret_Ref: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: Ref;
  var AuthCodeEntry_Ref: Ref;
  var $tmp19: Ref;
  var $tmp20: Ref;
  var $tmp21: bool;
  var $tmp22: Ref;
  var $tmp23: Ref;
  var $tmp24: Ref;
  var $tmp25: Ref;
  var $tmp26: Ref;
  var $tmp27: Ref;
  var $tmp28: Ref;
  var $tmp29: Ref;
  var $tmp30: Ref;
  var $tmp31: Ref;
  var $tmp32: Ref;
  var $tmp33: Ref;
  var IDTokenAndAccessTokenEntry_Ref: Ref;
  var $tmp34: Ref;
  var $tmp35: Ref;
  var $tmp36: bool;
  var $tmp37: Ref;
  var $tmp38: Ref;
  var $tmp39: bool;
  var $tmp40: Ref;
  var $tmp41: Ref;
  var $tmp42: bool;
  var $tmp43: Ref;
  var $tmp44: Ref;
  var $tmp45: Ref;
  var resp_Ref: Ref;
  var $tmp46: Ref;
  var $tmp47: Ref;
  var $tmp48: Ref;
  var $tmp49: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 39} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 252} true;
    if (req == null)
    {
        assume {:breadcrumb 40} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 252} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 41} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 253} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 253} true;
    $tmp0 := req;
    assume $tmp0 != null;
    CS$4$0002_Ref := F$OAuth20NameSpace.AccessTokenRequest.grant_type[$tmp0];
    if (CS$4$0002_Ref != null)
    {
        assume {:breadcrumb 42} true;
        call $tmp1 := System.String.op_Equality$System.String$System.String(CS$4$0002_Ref, $string_literal_authorization_code_2);
        if (!$tmp1)
        {
            assume {:breadcrumb 44} true;
        }
        else
        {
            assume {:breadcrumb 45} true;
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 256} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 256} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
            {
                assume $this != null;
                $tmp2 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
                $tmp3 := req;
                assume $tmp3 != null;
                $tmp4 := req;
                assume $tmp4 != null;
                call $tmp5 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.findISSByClientIDAndCode$System.String$System.String($tmp2, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp3], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp4]);
            }
            else
            {
                assume $this != null;
                $tmp6 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
                $tmp7 := req;
                assume $tmp7 != null;
                $tmp8 := req;
                assume $tmp8 != null;
                call $tmp9 := OAuth20NameSpace.AuthorizationCodeRecs.findISSByClientIDAndCode$System.String$System.String($tmp6, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp7], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp8]);
            }

            IdPSessionSecret_Ref := (if $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp5 else $tmp9);
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 257} true;
            if (IdPSessionSecret_Ref == null)
            {
                assume {:breadcrumb 46} true;
                assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 258} true;
                $result := null;
                return;
            }
            else
            {
                assume {:breadcrumb 47} true;
            }

            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 259} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 259} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def)
            {
                assume $this != null;
                $tmp10 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
                $tmp11 := req;
                assume $tmp11 != null;
                call $tmp12 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$System.String$System.String($tmp10, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp11]);
            }
            else
            {
                assume $this != null;
                if ($TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
                {
                    assume $this != null;
                    $tmp13 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
                    $tmp14 := req;
                    assume $tmp14 != null;
                    call $tmp15 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($tmp13, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp14]);
                }
                else
                {
                    assume $this != null;
                    $tmp16 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
                    $tmp17 := req;
                    assume $tmp17 != null;
                    call $tmp18 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp16, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp17]);
                }
            }

            AuthCodeEntry_Ref := (if $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp12 else (if $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp15 else $tmp18));
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 260} true;
            $tmp19 := AuthCodeEntry_Ref;
            assume $tmp19 != null;
            $tmp20 := req;
            assume $tmp20 != null;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 260} true;
            call $tmp21 := System.String.op_Inequality$System.String$System.String(F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp19], F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[$tmp20]);
            if ($tmp21)
            {
                assume {:breadcrumb 48} true;
                assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 261} true;
                $result := null;
                return;
            }
            else
            {
                assume {:breadcrumb 49} true;
            }

            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 262} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 262} true;
            if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
            {
                $tmp22 := AuthCodeEntry_Ref;
                assume $tmp22 != null;
                $tmp23 := AuthCodeEntry_Ref;
                assume $tmp23 != null;
                $tmp24 := AuthCodeEntry_Ref;
                assume $tmp24 != null;
                call $tmp25 := LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp22], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp23], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp24]);
            }
            else
            {
                if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
                {
                    $tmp26 := AuthCodeEntry_Ref;
                    assume $tmp26 != null;
                    $tmp27 := AuthCodeEntry_Ref;
                    assume $tmp27 != null;
                    $tmp28 := AuthCodeEntry_Ref;
                    assume $tmp28 != null;
                    call $tmp29 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp26], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp27], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp28]);
                }
                else
                {
                    $tmp30 := AuthCodeEntry_Ref;
                    assume $tmp30 != null;
                    $tmp31 := AuthCodeEntry_Ref;
                    assume $tmp31 != null;
                    $tmp32 := AuthCodeEntry_Ref;
                    assume $tmp32 != null;
                    call $tmp33 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp30], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp31], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp32]);
                }
            }

            IDTokenAndAccessTokenEntry_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp25 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp29 else $tmp33));
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 263} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 263} true;
            call $tmp44 := OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this);
            if ($TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def)
            {
                call $tmp34 := OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this);
                $tmp35 := req;
                assume $tmp35 != null;
                call $tmp36 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp34, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp35], IDTokenAndAccessTokenEntry_Ref);
            }
            else
            {
                call $tmp43 := OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this);
                if ($TypeConstructor($DynamicType($tmp43)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
                {
                    call $tmp37 := OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this);
                    $tmp38 := req;
                    assume $tmp38 != null;
                    call $tmp39 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp37, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp38], IDTokenAndAccessTokenEntry_Ref);
                }
                else
                {
                    call $tmp40 := OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this);
                    $tmp41 := req;
                    assume $tmp41 != null;
                    call $tmp42 := GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp40, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp41], IDTokenAndAccessTokenEntry_Ref);
                }
            }

            if (!(if $TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp36 else (if $TypeConstructor($DynamicType($tmp43)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp39 else $tmp42)))
            {
                assume {:breadcrumb 50} true;
                assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 264} true;
                $result := null;
                return;
            }
            else
            {
                assume {:breadcrumb 51} true;
            }

            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 266} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 266} true;
            call $tmp45 := Alloc();
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 266} true;
            call OpenIDConnectNameSpace.TokenResponse.#ctor($tmp45);
            assume $DynamicType($tmp45) == T$OpenIDConnectNameSpace.TokenResponse();
            assume $TypeConstructor($DynamicType($tmp45)) == T$OpenIDConnectNameSpace.TokenResponse;
            resp_Ref := $tmp45;
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 267} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 267} true;
            $tmp46 := IDTokenAndAccessTokenEntry_Ref;
            assume $tmp46 != null;
            F$OAuth20NameSpace.AccessTokenResponse.access_token[resp_Ref] := F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp46];
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 268} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 268} true;
            $tmp47 := IDTokenAndAccessTokenEntry_Ref;
            assume $tmp47 != null;
            F$OAuth20NameSpace.AccessTokenResponse.refresh_token[resp_Ref] := F$OAuth20NameSpace.AccessTokenEntry.refresh_token[$tmp47];
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 269} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 269} true;
            $tmp48 := IDTokenAndAccessTokenEntry_Ref;
            assume $tmp48 != null;
            F$OAuth20NameSpace.AccessTokenResponse.scope[resp_Ref] := F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp48];
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 270} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 270} true;
            $tmp49 := IDTokenAndAccessTokenEntry_Ref;
            assume $tmp49 != null;
            F$OpenIDConnectNameSpace.TokenResponse.id_token[resp_Ref] := F$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.id_token[$tmp49];
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 271} true;
            $result := resp_Ref;
            return;
        }
    }
    else
    {
        assume {:breadcrumb 43} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 273} true;
    $result := null;
    return;
}



procedure {:extern} OAuth20NameSpace.AuthorizationServer.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 52} true;
    call OAuth20NameSpace.AuthorizationServer.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.OpenIDProvider.#cctor();



implementation T$OpenIDConnectNameSpace.OpenIDProvider.#cctor()
{
}



function T$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs() : Ref;

const unique T$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs: int;

function T$OpenIDConnectNameSpace.JsonDataStrcuture() : Ref;

const unique T$OpenIDConnectNameSpace.JsonDataStrcuture: int;

var F$OpenIDConnectNameSpace.JsonDataStrcuture.$AccessToken$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonDataStrcuture.$AuthenticationToken$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonDataStrcuture.$RefreshToken$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonDataStrcuture.$ExpiresIn$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonDataStrcuture.$Scope$k__BackingField: [Ref]Ref;

procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_AccessToken($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_AccessToken($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 53} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonDataStrcuture.$AccessToken$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.set_AccessToken$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.set_AccessToken$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 54} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$AccessToken$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_AuthenticationToken($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_AuthenticationToken($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 55} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonDataStrcuture.$AuthenticationToken$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.set_AuthenticationToken$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.set_AuthenticationToken$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 56} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$AuthenticationToken$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_RefreshToken($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_RefreshToken($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 57} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonDataStrcuture.$RefreshToken$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.set_RefreshToken$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.set_RefreshToken$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 58} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$RefreshToken$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_ExpiresIn($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_ExpiresIn($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 59} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonDataStrcuture.$ExpiresIn$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.set_ExpiresIn$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.set_ExpiresIn$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 60} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$ExpiresIn$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_Scope($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_Scope($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 61} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonDataStrcuture.$Scope$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.set_Scope$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.set_Scope$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 62} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$Scope$k__BackingField[$this] := value;
}



procedure OpenIDConnectNameSpace.JsonDataStrcuture.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenIDConnectNameSpace.JsonDataStrcuture.$AccessToken$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$AuthenticationToken$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$RefreshToken$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$ExpiresIn$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$Scope$k__BackingField[$this] := null;
    assume {:breadcrumb 63} true;
    call System.Object.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.JsonDataStrcuture.#cctor();



implementation T$OpenIDConnectNameSpace.JsonDataStrcuture.#cctor()
{
}



function T$OpenIDConnectNameSpace.JsonWebToken() : Ref;

const unique T$OpenIDConnectNameSpace.JsonWebToken: int;

var F$OpenIDConnectNameSpace.JsonWebToken.ClaimsJsonSerializer: Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.EnvelopeJsonSerializer: Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.UTF8Encoder: Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.SHA256Provider: Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.$Claims$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.$Envelope$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.$Signature$k__BackingField: [Ref]Ref;

procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.get_Claims($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.get_Claims($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 64} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonWebToken.$Claims$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.set_Claims$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.set_Claims$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 65} true;
    F$OpenIDConnectNameSpace.JsonWebToken.$Claims$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 66} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonWebToken.$Envelope$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.set_Envelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.set_Envelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 67} true;
    F$OpenIDConnectNameSpace.JsonWebToken.$Envelope$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.get_Signature($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.get_Signature($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 68} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonWebToken.$Signature$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.set_Signature$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.set_Signature$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 69} true;
    F$OpenIDConnectNameSpace.JsonWebToken.$Signature$k__BackingField[$this] := value;
}



procedure OpenIDConnectNameSpace.JsonWebToken.get_IsExpired($this: Ref) returns ($result: bool);



procedure OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Expiration($this: Ref) returns ($result: Ref);



procedure System.DateTime.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



procedure {:extern} System.DateTime.get_Now() returns ($result: Ref);



procedure {:extern} System.DateTime.op_LessThan$System.DateTime$System.DateTime(t1$in: Ref, t2$in: Ref) returns ($result: bool);
  free requires t1$in != t2$in;



implementation OpenIDConnectNameSpace.JsonWebToken.get_IsExpired($this: Ref) returns ($result: bool)
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: bool;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 70} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 154} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 154} true;
    call $tmp0 := OpenIDConnectNameSpace.JsonWebToken.get_Claims($this);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 154} true;
    call $tmp1 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Expiration($tmp0);
    call $tmp2 := System.DateTime.#copy_ctor($tmp1);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 154} true;
    call $tmp3 := System.DateTime.get_Now();
    call $tmp4 := System.DateTime.#copy_ctor($tmp3);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 154} true;
    call $tmp5 := System.DateTime.op_LessThan$System.DateTime$System.DateTime($tmp2, $tmp4);
    $result := $tmp5;
    return;
}



procedure OpenIDConnectNameSpace.JsonWebToken.#ctor$System.String$System.Collections.Generic.Dictionary$System.Int32$System.String$($this: Ref, token$in: Ref, keyIdsKeys$in: Ref);



procedure OpenIDConnectNameSpace.JsonWebToken.SplitToken$System.String($this: Ref, token$in: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.JsonWebToken.GetClaimsFromTokenSegment$System.String($this: Ref, claimsTokenSegment$in: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.JsonWebToken.GetEnvelopeFromTokenSegment$System.String($this: Ref, envelopeTokenSegment$in: Ref) returns ($result: Ref);



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_KeyId($this: Ref) returns ($result: int);



procedure {:extern} System.Collections.Generic.Dictionary`2.ContainsKey$`0($this: Ref, key$in: Ref) returns ($result: bool);



const {:value "Could not find key with id {0}"} unique $string_literal_Could$not$find$key$with$id$$0$_3: Ref;

procedure {:extern} System.String.Format$System.String$System.Object(format$in: Ref, arg0$in: Ref) returns ($result: Ref);



procedure {:extern} System.Exception.#ctor$System.String($this: Ref, message$in: Ref);



function {:extern} T$System.Exception() : Ref;

const {:extern} unique T$System.Exception: int;

axiom $TypeConstructor(T$System.Exception()) == T$System.Exception;

procedure OpenIDConnectNameSpace.JsonWebToken.ValidateEnvelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this: Ref, envelope$in: Ref);



procedure OpenIDConnectNameSpace.JsonWebToken.ValidateSignature$System.String($this: Ref, key$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.#ctor$System.String$System.Collections.Generic.Dictionary$System.Int32$System.String$($this: Ref, token$in: Ref, keyIdsKeys$in: Ref)
{
  var token: Ref;
  var keyIdsKeys: Ref;
  var tokenSegments_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: int;
  var $tmp5: bool;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: int;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: int;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $localExc: Ref;
  var $label: int;

    token := token$in;
    keyIdsKeys := keyIdsKeys$in;
    F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Claims$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Envelope$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Signature$k__BackingField[$this] := null;
    assume {:breadcrumb 71} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 161} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 161} true;
    call System.Object.#ctor($this);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 164} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 164} true;
    call $tmp0 := OpenIDConnectNameSpace.JsonWebToken.SplitToken$System.String($this, token);
    if ($Exception != null)
    {
        return;
    }

    tokenSegments_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 167} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 167} true;
    assume tokenSegments_Ref != null;
    F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this] := $ArrayContents[tokenSegments_Ref][1];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 168} true;
    assume $this != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 168} true;
    call $tmp1 := OpenIDConnectNameSpace.JsonWebToken.GetClaimsFromTokenSegment$System.String($this, F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this]);
    if ($Exception != null)
    {
        return;
    }

    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 168} true;
    call OpenIDConnectNameSpace.JsonWebToken.set_Claims$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims($this, $tmp1);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 171} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 171} true;
    assume tokenSegments_Ref != null;
    F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this] := $ArrayContents[tokenSegments_Ref][0];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 172} true;
    assume $this != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 172} true;
    call $tmp2 := OpenIDConnectNameSpace.JsonWebToken.GetEnvelopeFromTokenSegment$System.String($this, F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this]);
    if ($Exception != null)
    {
        return;
    }

    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 172} true;
    call OpenIDConnectNameSpace.JsonWebToken.set_Envelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this, $tmp2);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 175} true;
    assume tokenSegments_Ref != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 175} true;
    call OpenIDConnectNameSpace.JsonWebToken.set_Signature$System.String($this, $ArrayContents[tokenSegments_Ref][2]);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 178} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 178} true;
    call $tmp3 := OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 178} true;
    call $tmp4 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_KeyId($tmp3);
    assume Union2Int(Int2Union($tmp4)) == $tmp4;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 178} true;
    call $tmp5 := System.Collections.Generic.Dictionary`2.ContainsKey$`0(keyIdsKeys, Int2Union($tmp4));
    if (!$tmp5)
    {
        assume {:breadcrumb 72} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 180} true;
        call $tmp6 := Alloc();
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 180} true;
        call $tmp7 := OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 180} true;
        call $tmp8 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_KeyId($tmp7);
        call $tmp9 := $BoxFromInt($tmp8);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 180} true;
        call $tmp10 := System.String.Format$System.String$System.Object($string_literal_Could$not$find$key$with$id$$0$_3, $tmp9);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 180} true;
        call System.Exception.#ctor$System.String($tmp6, $tmp10);
        assume $DynamicType($tmp6) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp6)) == T$System.Exception;
        $Exception := $tmp6;
        return;
    }
    else
    {
        assume {:breadcrumb 73} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 184} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 184} true;
    call $tmp11 := OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 184} true;
    call OpenIDConnectNameSpace.JsonWebToken.ValidateEnvelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this, $tmp11);
    if ($Exception != null)
    {
        return;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 185} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 185} true;
    call $tmp12 := OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 185} true;
    call $tmp13 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_KeyId($tmp12);
    assume Union2Int(Int2Union($tmp13)) == $tmp13;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 185} true;
    call $tmp15 := System.Collections.Generic.Dictionary`2.get_Item$`0(keyIdsKeys, Int2Union($tmp13));
    $tmp14 := $tmp15;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 185} true;
    call OpenIDConnectNameSpace.JsonWebToken.ValidateSignature$System.String($this, $tmp14);
    if ($Exception != null)
    {
        return;
    }
}



procedure OpenIDConnectNameSpace.JsonWebToken.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Claims$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Envelope$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Signature$k__BackingField[$this] := null;
    assume {:breadcrumb 74} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 188} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 188} true;
    call System.Object.#ctor($this);
}



procedure OpenIDConnectNameSpace.JsonWebToken.Base64UrlDecode$System.String($this: Ref, encodedSegment$in: Ref) returns ($result: Ref);



procedure {:extern} System.IO.MemoryStream.#ctor$System.Bytearray($this: Ref, buffer$in: Ref);



function {:extern} T$System.IO.MemoryStream() : Ref;

const {:extern} unique T$System.IO.MemoryStream: int;

axiom $TypeConstructor(T$System.IO.MemoryStream()) == T$System.IO.MemoryStream;

procedure {:extern} System.Runtime.Serialization.XmlObjectSerializer.ReadObject$System.IO.Stream($this: Ref, stream$in: Ref) returns ($result: Ref);



function T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims() : Ref;

const unique T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims: int;

procedure {:extern} System.IDisposable.Dispose($this: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.GetClaimsFromTokenSegment$System.String($this: Ref, claimsTokenSegment$in: Ref) returns ($result: Ref)
{
  var claimsTokenSegment: Ref;
  var claimsData_Ref: Ref;
  var $tmp0: Ref;
  var memoryStream_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: int;
  var $localExc: Ref;
  var $label: int;

    claimsTokenSegment := claimsTokenSegment$in;
    assume {:breadcrumb 75} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 197} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 197} true;
    call $tmp0 := OpenIDConnectNameSpace.JsonWebToken.Base64UrlDecode$System.String($this, claimsTokenSegment);
    if ($Exception != null)
    {
        return;
    }

    claimsData_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 198} true;
    call $tmp1 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 198} true;
    call System.IO.MemoryStream.#ctor$System.Bytearray($tmp1, claimsData_Ref);
    assume $DynamicType($tmp1) == T$System.IO.MemoryStream();
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.IO.MemoryStream;
    memoryStream_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 200} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 200} true;
    call $tmp2 := System.Runtime.Serialization.XmlObjectSerializer.ReadObject$System.IO.Stream(F$OpenIDConnectNameSpace.JsonWebToken.ClaimsJsonSerializer, memoryStream_Ref);
    $result := $As($tmp2, T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims());
    return;

    $label := -1;
    goto finally0;

  catch0:
    $localExc := $Exception;
    $Exception := null;
    if (false)
    {
        return;
    }

    $Exception := $localExc;
    $label := -1;
    goto finally0;

  finally0:
    $tmp3 := $Exception;
    $tmp4 := $label;
    if (memoryStream_Ref != null)
    {
        assume {:breadcrumb 76} true;
        call System.IDisposable.Dispose(memoryStream_Ref);
    }
    else
    {
        assume {:breadcrumb 77} true;
    }

    $Exception := $tmp3;
    $label := $tmp4;
    if (true)
    {
        goto continuation0;
    }

  continuation0:
    if ($Exception != null)
    {
        return;
    }
}



function T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope() : Ref;

const unique T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope: int;

implementation OpenIDConnectNameSpace.JsonWebToken.GetEnvelopeFromTokenSegment$System.String($this: Ref, envelopeTokenSegment$in: Ref) returns ($result: Ref)
{
  var envelopeTokenSegment: Ref;
  var envelopeData_Ref: Ref;
  var $tmp0: Ref;
  var memoryStream_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: int;
  var $localExc: Ref;
  var $label: int;

    envelopeTokenSegment := envelopeTokenSegment$in;
    assume {:breadcrumb 78} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 206} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 206} true;
    call $tmp0 := OpenIDConnectNameSpace.JsonWebToken.Base64UrlDecode$System.String($this, envelopeTokenSegment);
    if ($Exception != null)
    {
        return;
    }

    envelopeData_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 207} true;
    call $tmp1 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 207} true;
    call System.IO.MemoryStream.#ctor$System.Bytearray($tmp1, envelopeData_Ref);
    assume $DynamicType($tmp1) == T$System.IO.MemoryStream();
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.IO.MemoryStream;
    memoryStream_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 209} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 209} true;
    call $tmp2 := System.Runtime.Serialization.XmlObjectSerializer.ReadObject$System.IO.Stream(F$OpenIDConnectNameSpace.JsonWebToken.EnvelopeJsonSerializer, memoryStream_Ref);
    $result := $As($tmp2, T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope());
    return;

    $label := -1;
    goto finally0;

  catch0:
    $localExc := $Exception;
    $Exception := null;
    if (false)
    {
        return;
    }

    $Exception := $localExc;
    $label := -1;
    goto finally0;

  finally0:
    $tmp3 := $Exception;
    $tmp4 := $label;
    if (memoryStream_Ref != null)
    {
        assume {:breadcrumb 79} true;
        call System.IDisposable.Dispose(memoryStream_Ref);
    }
    else
    {
        assume {:breadcrumb 80} true;
    }

    $Exception := $tmp3;
    $label := $tmp4;
    if (true)
    {
        goto continuation0;
    }

  continuation0:
    if ($Exception != null)
    {
        return;
    }
}



procedure {:extern} System.String.IsNullOrEmpty$System.String(value$in: Ref) returns ($result: bool);



const {:value "Token is empty or null."} unique $string_literal_Token$is$empty$or$null._4: Ref;

procedure {:extern} System.String.Split$System.Chararray($this: Ref, separator$in: Ref) returns ($result: Ref);



const {:value "Invalid token format. Expected Envelope.Claims.Signature"} unique $string_literal_Invalid$token$format.$Expected$Envelope.Claims.Signature_5: Ref;

const {:value "Invalid token format. Envelope must not be empty"} unique $string_literal_Invalid$token$format.$Envelope$must$not$be$empty_6: Ref;

const {:value "Invalid token format. Claims must not be empty"} unique $string_literal_Invalid$token$format.$Claims$must$not$be$empty_7: Ref;

const {:value "Invalid token format. Signature must not be empty"} unique $string_literal_Invalid$token$format.$Signature$must$not$be$empty_8: Ref;

implementation OpenIDConnectNameSpace.JsonWebToken.SplitToken$System.String($this: Ref, token$in: Ref) returns ($result: Ref)
{
  var token: Ref;
  var $tmp0: bool;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var segments_Ref: Ref;
  var $tmp4: Ref;
  var $tmp5: bool;
  var $tmp6: Ref;
  var $tmp7: bool;
  var $tmp8: Ref;
  var $tmp9: bool;
  var $tmp10: Ref;
  var $localExc: Ref;
  var $label: int;

    token := token$in;
    assume {:breadcrumb 81} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 217} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 217} true;
    call $tmp0 := System.String.IsNullOrEmpty$System.String(token);
    if ($tmp0)
    {
        assume {:breadcrumb 82} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 219} true;
        call $tmp1 := Alloc();
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 219} true;
        call System.Exception.#ctor$System.String($tmp1, $string_literal_Token$is$empty$or$null._4);
        assume $DynamicType($tmp1) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp1)) == T$System.Exception;
        $Exception := $tmp1;
        return;
    }
    else
    {
        assume {:breadcrumb 83} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 222} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 222} true;
    call $tmp2 := Alloc();
    assume $ArrayLength($tmp2) == 1 * 1;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 222} true;
    call $tmp3 := System.String.Split$System.Chararray(token, $tmp2);
    segments_Ref := $tmp3;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 224} true;
    if ($ArrayLength(segments_Ref) != 3)
    {
        assume {:breadcrumb 84} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 226} true;
        call $tmp4 := Alloc();
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 226} true;
        call System.Exception.#ctor$System.String($tmp4, $string_literal_Invalid$token$format.$Expected$Envelope.Claims.Signature_5);
        assume $DynamicType($tmp4) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp4)) == T$System.Exception;
        $Exception := $tmp4;
        return;
    }
    else
    {
        assume {:breadcrumb 85} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 229} true;
    assume segments_Ref != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 229} true;
    call $tmp5 := System.String.IsNullOrEmpty$System.String($ArrayContents[segments_Ref][0]);
    if ($tmp5)
    {
        assume {:breadcrumb 86} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 231} true;
        call $tmp6 := Alloc();
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 231} true;
        call System.Exception.#ctor$System.String($tmp6, $string_literal_Invalid$token$format.$Envelope$must$not$be$empty_6);
        assume $DynamicType($tmp6) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp6)) == T$System.Exception;
        $Exception := $tmp6;
        return;
    }
    else
    {
        assume {:breadcrumb 87} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 234} true;
    assume segments_Ref != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 234} true;
    call $tmp7 := System.String.IsNullOrEmpty$System.String($ArrayContents[segments_Ref][1]);
    if ($tmp7)
    {
        assume {:breadcrumb 88} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 236} true;
        call $tmp8 := Alloc();
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 236} true;
        call System.Exception.#ctor$System.String($tmp8, $string_literal_Invalid$token$format.$Claims$must$not$be$empty_7);
        assume $DynamicType($tmp8) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp8)) == T$System.Exception;
        $Exception := $tmp8;
        return;
    }
    else
    {
        assume {:breadcrumb 89} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 239} true;
    assume segments_Ref != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 239} true;
    call $tmp9 := System.String.IsNullOrEmpty$System.String($ArrayContents[segments_Ref][2]);
    if ($tmp9)
    {
        assume {:breadcrumb 90} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 241} true;
        call $tmp10 := Alloc();
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 241} true;
        call System.Exception.#ctor$System.String($tmp10, $string_literal_Invalid$token$format.$Signature$must$not$be$empty_8);
        assume $DynamicType($tmp10) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp10)) == T$System.Exception;
        $Exception := $tmp10;
        return;
    }
    else
    {
        assume {:breadcrumb 91} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 244} true;
    $result := segments_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Type($this: Ref) returns ($result: Ref);



const {:value "JWT"} unique $string_literal_JWT_9: Ref;

const {:value "Unsupported token type"} unique $string_literal_Unsupported$token$type_10: Ref;

procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Algorithm($this: Ref) returns ($result: Ref);



const {:value "HS256"} unique $string_literal_HS256_11: Ref;

const {:value "Unsupported crypto algorithm"} unique $string_literal_Unsupported$crypto$algorithm_12: Ref;

implementation OpenIDConnectNameSpace.JsonWebToken.ValidateEnvelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this: Ref, envelope$in: Ref)
{
  var envelope: Ref;
  var $tmp0: Ref;
  var $tmp1: bool;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: bool;
  var $tmp5: Ref;
  var $localExc: Ref;
  var $label: int;

    envelope := envelope$in;
    assume {:breadcrumb 92} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 253} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 253} true;
    call $tmp0 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Type(envelope);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 253} true;
    call $tmp1 := System.String.op_Inequality$System.String$System.String($tmp0, $string_literal_JWT_9);
    if ($tmp1)
    {
        assume {:breadcrumb 93} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 255} true;
        call $tmp2 := Alloc();
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 255} true;
        call System.Exception.#ctor$System.String($tmp2, $string_literal_Unsupported$token$type_10);
        assume $DynamicType($tmp2) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp2)) == T$System.Exception;
        $Exception := $tmp2;
        return;
    }
    else
    {
        assume {:breadcrumb 94} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 258} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 258} true;
    call $tmp3 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Algorithm(envelope);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 258} true;
    call $tmp4 := System.String.op_Inequality$System.String$System.String($tmp3, $string_literal_HS256_11);
    if ($tmp4)
    {
        assume {:breadcrumb 95} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 260} true;
        call $tmp5 := Alloc();
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 260} true;
        call System.Exception.#ctor$System.String($tmp5, $string_literal_Unsupported$crypto$algorithm_12);
        assume $DynamicType($tmp5) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp5)) == T$System.Exception;
        $Exception := $tmp5;
        return;
    }
    else
    {
        assume {:breadcrumb 96} true;
    }
}



const {:value "JWTSig"} unique $string_literal_JWTSig_13: Ref;

procedure {:extern} System.Text.Encoding.GetBytes$System.String($this: Ref, s$in: Ref) returns ($result: Ref);



procedure {:extern} System.Security.Cryptography.HashAlgorithm.ComputeHash$System.Bytearray($this: Ref, buffer$in: Ref) returns ($result: Ref);



const {:value "."} unique $string_literal_._14: Ref;

procedure {:extern} System.String.Concat$System.String$System.String$System.String(str0$in: Ref, str1$in: Ref, str2$in: Ref) returns ($result: Ref);



procedure {:extern} System.Security.Cryptography.HMACSHA256.#ctor$System.Bytearray($this: Ref, key$in: Ref);



function {:extern} T$System.Security.Cryptography.HMACSHA256() : Ref;

const {:extern} unique T$System.Security.Cryptography.HMACSHA256: int;

axiom $TypeConstructor(T$System.Security.Cryptography.HMACSHA256()) == T$System.Security.Cryptography.HMACSHA256;

procedure OpenIDConnectNameSpace.JsonWebToken.Base64UrlEncode$System.Bytearray($this: Ref, arg$in: Ref) returns ($result: Ref);



const {:value "Signature does not match."} unique $string_literal_Signature$does$not$match._15: Ref;

implementation OpenIDConnectNameSpace.JsonWebToken.ValidateSignature$System.String($this: Ref, key$in: Ref)
{
  var key: Ref;
  var bytes_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var signingKey_Ref: Ref;
  var $tmp2: Ref;
  var input_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var hashProvider_Ref: Ref;
  var $tmp5: Ref;
  var myHashValue_Ref: Ref;
  var $tmp6: Ref;
  var base64urlEncodedHash_Ref: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: bool;
  var $tmp10: Ref;
  var $localExc: Ref;
  var $label: int;

    key := key$in;
    assume {:breadcrumb 97} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 267} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 267} true;
    call $tmp0 := System.String.Concat$System.String$System.String(key, $string_literal_JWTSig_13);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 267} true;
    call $tmp1 := System.Text.Encoding.GetBytes$System.String(F$OpenIDConnectNameSpace.JsonWebToken.UTF8Encoder, $tmp0);
    bytes_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 268} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 268} true;
    call $tmp2 := System.Security.Cryptography.HashAlgorithm.ComputeHash$System.Bytearray(F$OpenIDConnectNameSpace.JsonWebToken.SHA256Provider, bytes_Ref);
    signingKey_Ref := $tmp2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 288} true;
    assume $this != null;
    assume $this != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 288} true;
    call $tmp3 := System.String.Concat$System.String$System.String$System.String(F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this], $string_literal_._14, F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this]);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 288} true;
    call $tmp4 := System.Text.Encoding.GetBytes$System.String(F$OpenIDConnectNameSpace.JsonWebToken.UTF8Encoder, $tmp3);
    input_Ref := $tmp4;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 291} true;
    call $tmp5 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 291} true;
    call System.Security.Cryptography.HMACSHA256.#ctor$System.Bytearray($tmp5, signingKey_Ref);
    assume $DynamicType($tmp5) == T$System.Security.Cryptography.HMACSHA256();
    assume $TypeConstructor($DynamicType($tmp5)) == T$System.Security.Cryptography.HMACSHA256;
    hashProvider_Ref := $tmp5;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 293} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 293} true;
    call $tmp6 := System.Security.Cryptography.HashAlgorithm.ComputeHash$System.Bytearray(hashProvider_Ref, input_Ref);
    myHashValue_Ref := $tmp6;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 296} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 296} true;
    call $tmp7 := OpenIDConnectNameSpace.JsonWebToken.Base64UrlEncode$System.Bytearray($this, myHashValue_Ref);
    base64urlEncodedHash_Ref := $tmp7;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 299} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 299} true;
    call $tmp8 := OpenIDConnectNameSpace.JsonWebToken.get_Signature($this);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 299} true;
    call $tmp9 := System.String.op_Inequality$System.String$System.String(base64urlEncodedHash_Ref, $tmp8);
    if ($tmp9)
    {
        assume {:breadcrumb 98} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 301} true;
        call $tmp10 := Alloc();
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 301} true;
        call System.Exception.#ctor$System.String($tmp10, $string_literal_Signature$does$not$match._15);
        assume $DynamicType($tmp10) == T$System.Exception();
        assume $TypeConstructor($DynamicType($tmp10)) == T$System.Exception;
        $Exception := $tmp10;
        return;
    }
    else
    {
        assume {:breadcrumb 99} true;
    }
}



procedure {:extern} System.String.Replace$System.Char$System.Char($this: Ref, oldChar$in: int, newChar$in: int) returns ($result: Ref);



procedure {:extern} System.String.get_Length($this: Ref) returns ($result: int);



const {:value "=="} unique $string_literal_$$_16: Ref;

const {:value "="} unique $string_literal_$_17: Ref;

const {:value "Illegal base64url string"} unique $string_literal_Illegal$base64url$string_18: Ref;

procedure {:extern} System.Convert.FromBase64String$System.String(s$in: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.Base64UrlDecode$System.String($this: Ref, encodedSegment$in: Ref) returns ($result: Ref)
{
  var encodedSegment: Ref;
  var s_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: int;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $localExc: Ref;
  var $label: int;

    encodedSegment := encodedSegment$in;
    assume {:breadcrumb 100} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 313} true;
    s_Ref := encodedSegment;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 314} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 314} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 314} true;
    call $tmp0 := System.String.Replace$System.Char$System.Char(s_Ref, 45, 43);
    s_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 315} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 315} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 315} true;
    call $tmp1 := System.String.Replace$System.Char$System.Char(s_Ref, 95, 47);
    s_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 316} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 316} true;
    call $tmp2 := System.String.get_Length(s_Ref);
    if ($tmp2 mod 4 == 0)
    {
        goto IL_003a;
    }
    else if ($tmp2 mod 4 == 1)
    {
        goto IL_0058;
    }
    else if ($tmp2 mod 4 == 2)
    {
        goto IL_003c;
    }
    else if ($tmp2 mod 4 == 3)
    {
        goto IL_004a;
    }

    goto IL_0058;

  IL_003a:
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 318} true;
    goto IL_0063;

  IL_003c:
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 319} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 319} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 319} true;
    call $tmp3 := System.String.Concat$System.String$System.String(s_Ref, $string_literal_$$_16);
    s_Ref := $tmp3;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 319} true;
    goto IL_0063;

  IL_004a:
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 320} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 320} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 320} true;
    call $tmp4 := System.String.Concat$System.String$System.String(s_Ref, $string_literal_$_17);
    s_Ref := $tmp4;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 320} true;
    goto IL_0063;

  IL_0058:
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 321} true;
    call $tmp5 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 321} true;
    call System.Exception.#ctor$System.String($tmp5, $string_literal_Illegal$base64url$string_18);
    assume $DynamicType($tmp5) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp5)) == T$System.Exception;
    $Exception := $tmp5;
    return;

  IL_0063:
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 323} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 323} true;
    call $tmp6 := System.Convert.FromBase64String$System.String(s_Ref);
    $result := $tmp6;
    return;
}



procedure {:extern} System.Convert.ToBase64String$System.Bytearray(inArray$in: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.Base64UrlEncode$System.Bytearray($this: Ref, arg$in: Ref) returns ($result: Ref)
{
  var arg: Ref;
  var s_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

    arg := arg$in;
    assume {:breadcrumb 101} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 328} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 328} true;
    call $tmp0 := System.Convert.ToBase64String$System.Bytearray(arg);
    s_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 329} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 329} true;
    call $tmp1 := Alloc();
    assume $ArrayLength($tmp1) == 1 * 1;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 329} true;
    call $tmp2 := System.String.Split$System.Chararray(s_Ref, $tmp1);
    assume $tmp2 != null;
    s_Ref := $ArrayContents[$tmp2][0];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 330} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 330} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 330} true;
    call $tmp3 := System.String.Replace$System.Char$System.Char(s_Ref, 43, 45);
    s_Ref := $tmp3;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 331} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 331} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 331} true;
    call $tmp4 := System.String.Replace$System.Char$System.Char(s_Ref, 47, 95);
    s_Ref := $tmp4;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 332} true;
    $result := s_Ref;
    return;
}



procedure OpenIDConnectNameSpace.JsonWebToken.#cctor();



procedure {:extern} System.Runtime.Serialization.Json.DataContractJsonSerializer.#ctor$System.Type($this: Ref, type$in: Ref);



function {:extern} T$System.Runtime.Serialization.Json.DataContractJsonSerializer() : Ref;

const {:extern} unique T$System.Runtime.Serialization.Json.DataContractJsonSerializer: int;

axiom $TypeConstructor(T$System.Runtime.Serialization.Json.DataContractJsonSerializer()) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer;

procedure {:extern} System.Text.UTF8Encoding.#ctor$System.Boolean$System.Boolean($this: Ref, encoderShouldEmitUTF8Identifier$in: bool, throwOnInvalidBytes$in: bool);



function {:extern} T$System.Text.UTF8Encoding() : Ref;

const {:extern} unique T$System.Text.UTF8Encoding: int;

axiom $TypeConstructor(T$System.Text.UTF8Encoding()) == T$System.Text.UTF8Encoding;

procedure {:extern} System.Security.Cryptography.SHA256Managed.#ctor($this: Ref);



function {:extern} T$System.Security.Cryptography.SHA256Managed() : Ref;

const {:extern} unique T$System.Security.Cryptography.SHA256Managed: int;

axiom $TypeConstructor(T$System.Security.Cryptography.SHA256Managed()) == T$System.Security.Cryptography.SHA256Managed;

implementation OpenIDConnectNameSpace.JsonWebToken.#cctor()
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    F$OpenIDConnectNameSpace.JsonWebToken.ClaimsJsonSerializer := null;
    F$OpenIDConnectNameSpace.JsonWebToken.EnvelopeJsonSerializer := null;
    F$OpenIDConnectNameSpace.JsonWebToken.UTF8Encoder := null;
    F$OpenIDConnectNameSpace.JsonWebToken.SHA256Provider := null;
    assume {:breadcrumb 102} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 125} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 125} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 125} true;
    call System.Runtime.Serialization.Json.DataContractJsonSerializer.#ctor$System.Type($tmp0, T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims());
    assume $DynamicType($tmp0) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer;
    F$OpenIDConnectNameSpace.JsonWebToken.ClaimsJsonSerializer := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 126} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 126} true;
    call $tmp1 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 126} true;
    call System.Runtime.Serialization.Json.DataContractJsonSerializer.#ctor$System.Type($tmp1, T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope());
    assume $DynamicType($tmp1) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer();
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer;
    F$OpenIDConnectNameSpace.JsonWebToken.EnvelopeJsonSerializer := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 127} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 127} true;
    call $tmp2 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 127} true;
    call System.Text.UTF8Encoding.#ctor$System.Boolean$System.Boolean($tmp2, true, true);
    assume $DynamicType($tmp2) == T$System.Text.UTF8Encoding();
    assume $TypeConstructor($DynamicType($tmp2)) == T$System.Text.UTF8Encoding;
    F$OpenIDConnectNameSpace.JsonWebToken.UTF8Encoder := $tmp2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 128} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 128} true;
    call $tmp3 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 128} true;
    call System.Security.Cryptography.SHA256Managed.#ctor($tmp3);
    assume $DynamicType($tmp3) == T$System.Security.Cryptography.SHA256Managed();
    assume $TypeConstructor($DynamicType($tmp3)) == T$System.Security.Cryptography.SHA256Managed;
    F$OpenIDConnectNameSpace.JsonWebToken.SHA256Provider := $tmp3;
}



var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.expiration: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$expUnixTime$k__BackingField: [Ref]int;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Issuer$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Audience$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$UserId$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Version$k__BackingField: [Ref]int;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$ClientIdentifier$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$AppId$k__BackingField: [Ref]Ref;

procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_expUnixTime($this: Ref) returns ($result: int);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_expUnixTime($this: Ref) returns ($result: int)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 103} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$expUnixTime$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_expUnixTime$System.Int32($this: Ref, value$in: int);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_expUnixTime$System.Int32($this: Ref, value$in: int)
{
  var value: int;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 104} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$expUnixTime$k__BackingField[$this] := value;
}



procedure {:extern} System.Nullable`1.get_HasValue($this: Ref) returns ($result: bool);



procedure System.Nullable.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



procedure {:extern} System.DateTime.#ctor$System.Int32$System.Int32$System.Int32$System.Int32$System.Int32$System.Int32($this: Ref, year$in: int, month$in: int, day$in: int, hour$in: int, minute$in: int, second$in: int);



function {:extern} T$System.DateTime() : Ref;

const {:extern} unique T$System.DateTime: int;

axiom $TypeConstructor(T$System.DateTime()) == T$System.DateTime;

procedure {:extern} System.DateTime.AddSeconds$System.Double($this: Ref, value$in: Real) returns ($result: Ref);



procedure {:extern} System.Nullable`1.#ctor$`0($this: Ref, value$in: Ref);



function {:extern} T$T$System.Nullable`1(parent: Ref) : Ref;

function {:extern} T$System.Nullable`1(T: Ref) : Ref;

const {:extern} unique T$System.Nullable`1: int;

procedure {:extern} System.Nullable`1.get_Value($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Expiration($this: Ref) returns ($result: Ref)
{
  var $tmp0: Ref;
  var $tmp1: bool;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: int;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 105} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 45} true;
    assume $this != null;
    $tmp0 := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.expiration[$this];
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 45} true;
    call $tmp1 := System.Nullable`1.get_HasValue($tmp0);
    if (!$tmp1)
    {
        assume {:breadcrumb 106} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 47} true;
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 47} true;
        call $tmp2 := Alloc();
        call $tmp3 := Alloc();
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 47} true;
        call System.DateTime.#ctor$System.Int32$System.Int32$System.Int32$System.Int32$System.Int32$System.Int32($tmp3, 1970, 1, 1, 0, 0, 0);
        assume $DynamicType($tmp3) == T$System.DateTime();
        assume $TypeConstructor($DynamicType($tmp3)) == T$System.DateTime;
        $tmp4 := $tmp3;
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 47} true;
        call $tmp5 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_expUnixTime($this);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 47} true;
        call $tmp6 := System.DateTime.AddSeconds$System.Double($tmp4, Int2Real($tmp5));
        call $tmp7 := System.DateTime.#copy_ctor($tmp6);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 47} true;
        call System.Nullable`1.#ctor$`0($tmp2, $tmp7);
        assume $DynamicType($tmp2) == T$System.Nullable`1(T$System.DateTime());
        assume $TypeConstructor($DynamicType($tmp2)) == T$System.Nullable`1;
        assume T$T$System.Nullable`1($DynamicType($tmp2)) == T$System.DateTime();
        F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.expiration[$this] := $tmp2;
    }
    else
    {
        assume {:breadcrumb 107} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 50} true;
    assume $this != null;
    $tmp8 := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.expiration[$this];
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 50} true;
    call $tmp10 := System.Nullable`1.get_Value($tmp8);
    $tmp9 := $tmp10;
    $result := $tmp9;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Issuer($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Issuer($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 108} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Issuer$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Issuer$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Issuer$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 109} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Issuer$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Audience($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Audience($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 110} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Audience$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Audience$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Audience$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 111} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Audience$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_UserId($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_UserId($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 112} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$UserId$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_UserId$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_UserId$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 113} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$UserId$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Version($this: Ref) returns ($result: int);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Version($this: Ref) returns ($result: int)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 114} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Version$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Version$System.Int32($this: Ref, value$in: int);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Version$System.Int32($this: Ref, value$in: int)
{
  var value: int;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 115} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Version$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_ClientIdentifier($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_ClientIdentifier($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 116} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$ClientIdentifier$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_ClientIdentifier$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_ClientIdentifier$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 117} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$ClientIdentifier$k__BackingField[$this] := value;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_AppId($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_AppId($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 118} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$AppId$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_AppId$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_AppId$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 119} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$AppId$k__BackingField[$this] := value;
}



procedure OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#ctor($this: Ref);



procedure System.Nullable$System.DateTime$.#default_ctor($this: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

    call $tmp0 := Alloc();
    call System.Nullable$System.DateTime$.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Nullable`1(T$System.DateTime());
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Nullable`1;
    assume T$T$System.Nullable`1($DynamicType($tmp0)) == T$System.DateTime();
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.expiration[$this] := $tmp0;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$expUnixTime$k__BackingField[$this] := 0;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Issuer$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Audience$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$UserId$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Version$k__BackingField[$this] := 0;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$ClientIdentifier$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$AppId$k__BackingField[$this] := null;
    assume {:breadcrumb 120} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 40} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 40} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 40} true;
    call $tmp1 := Alloc();
    call System.Nullable$System.DateTime$.#default_ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Nullable`1(T$System.DateTime());
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Nullable`1;
    assume T$T$System.Nullable`1($DynamicType($tmp1)) == T$System.DateTime();
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.expiration[$this] := $tmp1;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\JsonWebToken.cs"} {:sourceLine 40} true;
    call System.Object.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#cctor();



implementation T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#cctor()
{
}



var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Type$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Algorithm$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$KeyId$k__BackingField: [Ref]int;

implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Type($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 121} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Type$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_Type$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_Type$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 122} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Type$k__BackingField[$this] := value;
}



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Algorithm($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 123} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Algorithm$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_Algorithm$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_Algorithm$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 124} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Algorithm$k__BackingField[$this] := value;
}



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_KeyId($this: Ref) returns ($result: int)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 125} true;
    assume $this != null;
    $result := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$KeyId$k__BackingField[$this];
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_KeyId$System.Int32($this: Ref, value$in: int);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_KeyId$System.Int32($this: Ref, value$in: int)
{
  var value: int;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 126} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$KeyId$k__BackingField[$this] := value;
}



procedure OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Type$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Algorithm$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$KeyId$k__BackingField[$this] := 0;
    assume {:breadcrumb 127} true;
    call System.Object.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#cctor();



implementation T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#cctor()
{
}



procedure OpenIDConnectNameSpace.TokenResponse.parseJasonDataStructure$OpenIDConnectNameSpace.JsonDataStrcuture$System.String($this: Ref, JsonDataStrcuture$in: Ref, clientSecret$in: Ref) returns ($result: bool);



var {:extern} F$OAuth20NameSpace.AccessTokenResponse.expires_in: [Ref]Ref;

function {:extern} T$System.Int32() : Ref;

const {:extern} unique T$System.Int32: int;

axiom $TypeConstructor(T$System.Int32()) == T$System.Int32;

procedure {:extern} System.Collections.Generic.Dictionary`2.Add$`0$`1($this: Ref, key$in: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.TokenResponse.parseJasonDataStructure$OpenIDConnectNameSpace.JsonDataStrcuture$System.String($this: Ref, JsonDataStrcuture$in: Ref, clientSecret$in: Ref) returns ($result: bool)
{
  var JsonDataStrcuture: Ref;
  var clientSecret: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var keys_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var e_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    JsonDataStrcuture := JsonDataStrcuture$in;
    clientSecret := clientSecret$in;
    assume {:breadcrumb 128} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 44} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 44} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 44} true;
    call $tmp0 := OpenIDConnectNameSpace.JsonDataStrcuture.get_AccessToken(JsonDataStrcuture);
    F$OAuth20NameSpace.AccessTokenResponse.access_token[$this] := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 45} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 45} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 45} true;
    call $tmp1 := OpenIDConnectNameSpace.JsonDataStrcuture.get_RefreshToken(JsonDataStrcuture);
    F$OAuth20NameSpace.AccessTokenResponse.refresh_token[$this] := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 46} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 46} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 46} true;
    call $tmp2 := OpenIDConnectNameSpace.JsonDataStrcuture.get_ExpiresIn(JsonDataStrcuture);
    F$OAuth20NameSpace.AccessTokenResponse.expires_in[$this] := $tmp2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 49} true;
    call $tmp3 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 49} true;
    call System.Collections.Generic.Dictionary`2.#ctor($tmp3);
    assume $DynamicType($tmp3) == T$System.Collections.Generic.Dictionary`2(T$System.Int32(), T$System.String());
    assume $TypeConstructor($DynamicType($tmp3)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp3)) == T$System.Int32();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp3)) == T$System.String();
    keys_Ref := $tmp3;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 50} true;
    assume Union2Int(Int2Union(1)) == 1;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 50} true;
    call System.Collections.Generic.Dictionary`2.Add$`0$`1(keys_Ref, Int2Union(1), clientSecret);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 53} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 53} true;
    call $tmp4 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 53} true;
    call $tmp5 := OpenIDConnectNameSpace.JsonDataStrcuture.get_AuthenticationToken(JsonDataStrcuture);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 53} true;
    call OpenIDConnectNameSpace.JsonWebToken.#ctor$System.String$System.Collections.Generic.Dictionary$System.Int32$System.String$($tmp4, $tmp5, keys_Ref);
    assume $DynamicType($tmp4) == T$OpenIDConnectNameSpace.JsonWebToken();
    assume $TypeConstructor($DynamicType($tmp4)) == T$OpenIDConnectNameSpace.JsonWebToken;
    F$OpenIDConnectNameSpace.TokenResponse.id_token[$this] := $tmp4;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 54} true;
    assume $this != null;
    if (F$OpenIDConnectNameSpace.TokenResponse.id_token[$this] != null)
    {
        assume {:breadcrumb 129} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 55} true;
        $result := true;
        return;
    }
    else
    {
        assume {:breadcrumb 130} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 57} true;
    $result := false;
    return;

    $label := -1;
    goto finally0;

  catch0:
    $localExc := $Exception;
    $Exception := null;
    if ($Subtype($DynamicType($localExc), T$System.Exception()))
    {
        e_Ref := $localExc;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 61} true;
        $result := false;
        return;

        $label := -1;
        goto finally0;
    }
    else if (false)
    {
        return;
    }

    $Exception := $localExc;
    $label := -1;
    goto finally0;

  finally0:
    if (true)
    {
        goto continuation0;
    }

  continuation0:
    if ($Exception != null)
    {
        return;
    }
}



procedure {:extern} OAuth20NameSpace.AccessTokenResponse.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.TokenResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenIDConnectNameSpace.TokenResponse.id_token[$this] := null;
    assume {:breadcrumb 131} true;
    call OAuth20NameSpace.AccessTokenResponse.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.TokenResponse.#cctor();



implementation T$OpenIDConnectNameSpace.TokenResponse.#cctor()
{
}



procedure OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_Redir_dest($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_Redir_dest($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 132} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 95} true;
    assume $this != null;
    $result := F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$this];
    return;
}



procedure OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_UserID($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_UserID($this: Ref) returns ($result: Ref)
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 133} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 99} true;
    assume $this != null;
    $tmp0 := F$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.id_token[$this];
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 99} true;
    call $tmp1 := OpenIDConnectNameSpace.JsonWebToken.get_Claims($tmp0);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 99} true;
    call $tmp2 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_UserId($tmp1);
    $result := $tmp2;
    return;
}



procedure {:extern} OAuth20NameSpace.AccessTokenEntry.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.id_token[$this] := null;
    assume {:breadcrumb 134} true;
    call OAuth20NameSpace.AccessTokenEntry.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.#cctor();



implementation T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.#cctor()
{
}



function T$OpenIDConnectNameSpace.TokenRequest() : Ref;

const unique T$OpenIDConnectNameSpace.TokenRequest: int;

procedure OpenIDConnectNameSpace.TokenRequest.#ctor($this: Ref);



procedure {:extern} OAuth20NameSpace.AccessTokenRequest.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.TokenRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 135} true;
    call OAuth20NameSpace.AccessTokenRequest.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.TokenRequest.#cctor();



implementation T$OpenIDConnectNameSpace.TokenRequest.#cctor()
{
}



function T$OpenIDConnectNameSpace.NondetOpenIDConnect() : Ref;

const unique T$OpenIDConnectNameSpace.NondetOpenIDConnect: int;

procedure OpenIDConnectNameSpace.NondetOpenIDConnect.IDTokenAndAccessTokenEntry($this: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.NondetOpenIDConnect.AuthorizationCodeDictionary($this: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.NondetOpenIDConnect.IDTokenAndAccessTokenDictionary($this: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationResponse.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.AuthenticationResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 136} true;
    call OAuth20NameSpace.AuthorizationResponse.#ctor($this);
}



procedure T$OpenIDConnectNameSpace.AuthenticationResponse.#cctor();



implementation T$OpenIDConnectNameSpace.AuthenticationResponse.#cctor()
{
}



function T$OpenIDConnectNameSpace.RelyingParty() : Ref;

const unique T$OpenIDConnectNameSpace.RelyingParty: int;

procedure OpenIDConnectNameSpace.RelyingParty.#ctor$System.String$System.String$System.String$System.String($this: Ref, client_id1$in: Ref, return_uri1$in: Ref, client_secret1$in: Ref, TokenEndpointUrl1$in: Ref);



procedure {:extern} OAuth20NameSpace.Client.#ctor$System.String$System.String$System.String$System.String($this: Ref, client_id1$in: Ref, return_uri1$in: Ref, client_secret1$in: Ref, TokenEndpointUrl1$in: Ref);



implementation OpenIDConnectNameSpace.RelyingParty.#ctor$System.String$System.String$System.String$System.String($this: Ref, client_id1$in: Ref, return_uri1$in: Ref, client_secret1$in: Ref, TokenEndpointUrl1$in: Ref)
{
  var client_id1: Ref;
  var return_uri1: Ref;
  var client_secret1: Ref;
  var TokenEndpointUrl1: Ref;
  var $localExc: Ref;
  var $label: int;

    client_id1 := client_id1$in;
    return_uri1 := return_uri1$in;
    client_secret1 := client_secret1$in;
    TokenEndpointUrl1 := TokenEndpointUrl1$in;
    assume {:breadcrumb 137} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 114} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 114} true;
    call OAuth20NameSpace.Client.#ctor$System.String$System.String$System.String$System.String($this, client_id1, return_uri1, client_secret1, TokenEndpointUrl1);
}



procedure OpenIDConnectNameSpace.RelyingParty.parseAuthenticationResponse$System.Web.HttpRequest($this: Ref, rawRequest$in: Ref) returns ($result: Ref);



procedure {:extern} System.Web.HttpContext.get_Current() returns ($result: Ref);



procedure {:extern} System.Web.HttpRequest.get_QueryString($this: Ref) returns ($result: Ref);



const {:value "code"} unique $string_literal_code_19: Ref;

procedure {:extern} System.Collections.Specialized.NameValueCollection.get_Item$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



const {:value "state"} unique $string_literal_state_20: Ref;

var {:extern} F$OAuth20NameSpace.AuthorizationResponse.state: [Ref]Ref;

implementation OpenIDConnectNameSpace.RelyingParty.parseAuthenticationResponse$System.Web.HttpRequest($this: Ref, rawRequest$in: Ref) returns ($result: Ref)
{
  var rawRequest: Ref;
  var r_Ref: Ref;
  var $tmp0: Ref;
  var context_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: bool;
  var $localExc: Ref;
  var $label: int;

    rawRequest := rawRequest$in;
    assume {:breadcrumb 138} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 118} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 118} true;
    call OpenIDConnectNameSpace.AuthenticationResponse.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenIDConnectNameSpace.AuthenticationResponse();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenIDConnectNameSpace.AuthenticationResponse;
    r_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 119} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 119} true;
    call $tmp1 := System.Web.HttpContext.get_Current();
    context_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 120} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 120} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 120} true;
    call $tmp2 := System.Web.HttpRequest.get_QueryString(rawRequest);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 120} true;
    call $tmp3 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp2, $string_literal_code_19);
    F$OAuth20NameSpace.AuthorizationResponse.code[r_Ref] := $tmp3;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 121} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 121} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 121} true;
    call $tmp4 := System.Web.HttpRequest.get_QueryString(rawRequest);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 121} true;
    call $tmp5 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp4, $string_literal_state_20);
    F$OAuth20NameSpace.AuthorizationResponse.state[r_Ref] := $tmp5;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 122} true;
    $tmp6 := r_Ref;
    assume $tmp6 != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 122} true;
    call $tmp7 := System.String.IsNullOrEmpty$System.String(F$OAuth20NameSpace.AuthorizationResponse.code[$tmp6]);
    if ($tmp7)
    {
        assume {:breadcrumb 139} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 123} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 140} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 125} true;
    $result := r_Ref;
    return;
}



procedure OpenIDConnectNameSpace.RelyingParty.AuthenticationUsingAuthorizationCodeFlow$OpenIDConnectNameSpace.AuthenticationResponse($this: Ref, codeResp$in: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.RelyingParty.callTokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this: Ref, req$in: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.RelyingParty.AuthenticationUsingAuthorizationCodeFlow$OpenIDConnectNameSpace.AuthenticationResponse($this: Ref, codeResp$in: Ref) returns ($result: Ref)
{
  var codeResp: Ref;
  var tokenReq_Ref: Ref;
  var $tmp0: Ref;
  var tokenResp_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

    codeResp := codeResp$in;
    assume {:breadcrumb 141} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 129} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 129} true;
    call $tmp0 := OpenIDConnectNameSpace.RelyingParty.constructTokenRequest$OpenIDConnectNameSpace.AuthenticationResponse($this, codeResp);
    tokenReq_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 130} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 130} true;
    call $tmp1 := OpenIDConnectNameSpace.RelyingParty.callTokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this, tokenReq_Ref);
    tokenResp_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 131} true;
    if (tokenResp_Ref == null)
    {
        assume {:breadcrumb 142} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 132} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 143} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 139} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 139} true;
    call $tmp2 := OpenIDConnectNameSpace.RelyingParty.conclude$OpenIDConnectNameSpace.TokenResponse($this, tokenResp_Ref);
    $result := $tmp2;
    return;
}



procedure {:extern} OAuth20NameSpace.Client.get_return_uri($this: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.Client.get_client_id($this: Ref) returns ($result: Ref);



var {:extern} F$CST.CST_Struct.SymT: [Ref]Ref;

procedure {:extern} CST.CST_Ops.recordme$CST.CST_Struct(msg$in: Ref);



implementation OpenIDConnectNameSpace.RelyingParty.constructTokenRequest$OpenIDConnectNameSpace.AuthenticationResponse($this: Ref, codeResp$in: Ref) returns ($result: Ref)
{
  var codeResp: Ref;
  var tokenReq_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

    codeResp := codeResp$in;
    assume {:breadcrumb 144} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 143} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 143} true;
    call OpenIDConnectNameSpace.TokenRequest.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenIDConnectNameSpace.TokenRequest();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenIDConnectNameSpace.TokenRequest;
    tokenReq_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 144} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 144} true;
    $tmp1 := codeResp;
    assume $tmp1 != null;
    F$OAuth20NameSpace.AccessTokenRequest.code[tokenReq_Ref] := F$OAuth20NameSpace.AuthorizationResponse.code[$tmp1];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 145} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 145} true;
    F$OAuth20NameSpace.AccessTokenRequest.grant_type[tokenReq_Ref] := $string_literal_authorization_code_2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 146} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 146} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 146} true;
    call $tmp2 := OAuth20NameSpace.Client.get_return_uri($this);
    F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[tokenReq_Ref] := $tmp2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 147} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 147} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 147} true;
    call $tmp3 := OAuth20NameSpace.Client.get_client_id($this);
    F$OAuth20NameSpace.AccessTokenRequest.client_id[tokenReq_Ref] := $tmp3;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 148} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 148} true;
    $tmp4 := codeResp;
    assume $tmp4 != null;
    F$CST.CST_Struct.SymT[tokenReq_Ref] := F$CST.CST_Struct.SymT[$tmp4];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 149} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 149} true;
    call CST.CST_Ops.recordme$CST.CST_Struct(tokenReq_Ref);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 156} true;
    $result := tokenReq_Ref;
    return;
}



const {:value "client_id={0}&redirect_uri={1}&client_secret={2}&code={3}&grant_type=authorization_code"} unique $string_literal_client_id$$0$$redirect_uri$$1$$client_secret$$2$$code$$3$$grant_type$authorization_code_21: Ref;

procedure {:extern} System.String.Format$System.String$System.Objectarray(format$in: Ref, args$in: Ref) returns ($result: Ref);



var {:extern} F$OAuth20NameSpace.Client.TokenEndpointUrl: [Ref]Ref;

const {:value "POST"} unique $string_literal_POST_22: Ref;

procedure {:extern} HTTP.HTTPComm.HttpReq$System.String$System.String$System.String(url$in: Ref, post$in: Ref, method$in: Ref) returns ($result: Ref);



procedure {:extern} System.Net.WebResponse.GetResponseStream($this: Ref) returns ($result: Ref);



var {:extern} F$OAuth20NameSpace.Client.client_secret: [Ref]Ref;

const {:value "TokenEndpoint"} unique $string_literal_TokenEndpoint_23: Ref;

procedure {:extern} System.Type.GetMethod$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



procedure {:extern} CST.CST_Ops.recordme$CST.CST_Struct$System.Reflection.MethodInfo(msg$in: Ref, mi$in: Ref);



implementation OpenIDConnectNameSpace.RelyingParty.callTokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var JsonDataStrcuture_Ref: Ref;
  var $tmp0: Ref;
  var postContent_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var response_Ref: Ref;
  var $tmp3: Ref;
  var serializer_Ref: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var TokenResponse_Ref: Ref;
  var $tmp7: Ref;
  var $tmp8: bool;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 145} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 160} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 160} true;
    call OpenIDConnectNameSpace.JsonDataStrcuture.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenIDConnectNameSpace.JsonDataStrcuture();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenIDConnectNameSpace.JsonDataStrcuture;
    JsonDataStrcuture_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 162} true;
    call $tmp1 := Alloc();
    assume $ArrayLength($tmp1) == 1 * 5;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 162} true;
    call $tmp2 := System.String.Format$System.String$System.Objectarray($string_literal_client_id$$0$$redirect_uri$$1$$client_secret$$2$$code$$3$$grant_type$authorization_code_21, $tmp1);
    postContent_Ref := $tmp2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 169} true;
    assume $this != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 169} true;
    call $tmp3 := HTTP.HTTPComm.HttpReq$System.String$System.String$System.String(F$OAuth20NameSpace.Client.TokenEndpointUrl[$this], postContent_Ref, $string_literal_POST_22);
    response_Ref := $tmp3;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 170} true;
    if (response_Ref != null)
    {
        assume {:breadcrumb 146} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 172} true;
        call $tmp4 := Alloc();
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 172} true;
        call System.Runtime.Serialization.Json.DataContractJsonSerializer.#ctor$System.Type($tmp4, T$OpenIDConnectNameSpace.JsonDataStrcuture());
        assume $DynamicType($tmp4) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer();
        assume $TypeConstructor($DynamicType($tmp4)) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer;
        serializer_Ref := $tmp4;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 173} true;
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 173} true;
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 173} true;
        call $tmp5 := System.Net.WebResponse.GetResponseStream(response_Ref);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 173} true;
        call $tmp6 := System.Runtime.Serialization.XmlObjectSerializer.ReadObject$System.IO.Stream(serializer_Ref, $tmp5);
        JsonDataStrcuture_Ref := $As($tmp6, T$OpenIDConnectNameSpace.JsonDataStrcuture());
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 174} true;
        if (JsonDataStrcuture_Ref != null)
        {
            assume {:breadcrumb 148} true;
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 176} true;
            call $tmp7 := Alloc();
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 176} true;
            call OpenIDConnectNameSpace.TokenResponse.#ctor($tmp7);
            assume $DynamicType($tmp7) == T$OpenIDConnectNameSpace.TokenResponse();
            assume $TypeConstructor($DynamicType($tmp7)) == T$OpenIDConnectNameSpace.TokenResponse;
            TokenResponse_Ref := $tmp7;
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 177} true;
            assume $this != null;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 177} true;
            call $tmp8 := OpenIDConnectNameSpace.TokenResponse.parseJasonDataStructure$OpenIDConnectNameSpace.JsonDataStrcuture$System.String(TokenResponse_Ref, JsonDataStrcuture_Ref, F$OAuth20NameSpace.Client.client_secret[$this]);
            if ($tmp8)
            {
                assume {:breadcrumb 150} true;
                assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 179} true;
                assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 179} true;
                $tmp9 := req;
                assume $tmp9 != null;
                F$CST.CST_Struct.SymT[TokenResponse_Ref] := F$CST.CST_Struct.SymT[$tmp9];
                assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 181} true;
                $tmp10 := T$OpenIDConnectNameSpace.OpenIDProvider();
                assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 181} true;
                call $tmp11 := System.Type.GetMethod$System.String($tmp10, $string_literal_TokenEndpoint_23);
                assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 181} true;
                call CST.CST_Ops.recordme$CST.CST_Struct$System.Reflection.MethodInfo(TokenResponse_Ref, $tmp11);
                assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 191} true;
                $result := TokenResponse_Ref;
                return;
            }
            else
            {
                assume {:breadcrumb 151} true;
            }

            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 194} true;
            $result := null;
            return;
        }
        else
        {
            assume {:breadcrumb 149} true;
        }
    }
    else
    {
        assume {:breadcrumb 147} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 197} true;
    $result := null;
    return;
}



procedure {:extern} GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($this: Ref);



function {:extern} T$GenericAuthNameSpace.RP.AuthenticationConclusion() : Ref;

const {:extern} unique T$GenericAuthNameSpace.RP.AuthenticationConclusion: int;

axiom $TypeConstructor(T$GenericAuthNameSpace.RP.AuthenticationConclusion()) == T$GenericAuthNameSpace.RP.AuthenticationConclusion;

var {:extern} F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID: [Ref]Ref;

procedure {:extern} GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool);



function {:extern} T$OAuth20NameSpace.Client() : Ref;

const {:extern} unique T$OAuth20NameSpace.Client: int;

axiom $TypeConstructor(T$OAuth20NameSpace.Client()) == T$OAuth20NameSpace.Client;

function {:extern} T$LiveIDNameSpace.LiveID_RP() : Ref;

const {:extern} unique T$LiveIDNameSpace.LiveID_RP: int;

axiom $TypeConstructor(T$LiveIDNameSpace.LiveID_RP()) == T$LiveIDNameSpace.LiveID_RP;

implementation OpenIDConnectNameSpace.RelyingParty.conclude$OpenIDConnectNameSpace.TokenResponse($this: Ref, tokenResp$in: Ref) returns ($result: Ref)
{
  var tokenResp: Ref;
  var conclusion_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: bool;
  var $tmp7: bool;
  var $tmp8: bool;
  var $tmp9: bool;
  var $tmp10: bool;
  var $localExc: Ref;
  var $label: int;

    tokenResp := tokenResp$in;
    assume {:breadcrumb 152} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 201} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 201} true;
    call GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$GenericAuthNameSpace.RP.AuthenticationConclusion();
    assume $TypeConstructor($DynamicType($tmp0)) == T$GenericAuthNameSpace.RP.AuthenticationConclusion;
    conclusion_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 202} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 202} true;
    $tmp1 := tokenResp;
    assume $tmp1 != null;
    $tmp2 := F$OpenIDConnectNameSpace.TokenResponse.id_token[$tmp1];
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 202} true;
    call $tmp3 := OpenIDConnectNameSpace.JsonWebToken.get_Claims($tmp2);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 202} true;
    call $tmp4 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_UserId($tmp3);
    F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[conclusion_Ref] := $tmp4;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 203} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 203} true;
    $tmp5 := tokenResp;
    assume $tmp5 != null;
    F$CST.CST_Struct.SymT[conclusion_Ref] := F$CST.CST_Struct.SymT[$tmp5];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 209} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 209} true;
    call CST.CST_Ops.recordme$CST.CST_Struct(conclusion_Ref);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 210} true;
    if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP_For_vProgram)
    {
        call $tmp6 := LiveIDNameSpace.LiveID_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, conclusion_Ref);
    }
    else
    {
        if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP)
        {
            call $tmp7 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, conclusion_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.RelyingParty)
            {
                call $tmp8 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, conclusion_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.Client)
                {
                    call $tmp9 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, conclusion_Ref);
                }
                else
                {
                    call $tmp10 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, conclusion_Ref);
                }
            }
        }
    }

    if ((if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP_For_vProgram then $tmp6 else (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP then $tmp7 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.RelyingParty then $tmp8 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.Client then $tmp9 else $tmp10)))))
    {
        assume {:breadcrumb 153} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 211} true;
        $result := conclusion_Ref;
        return;
    }
    else
    {
        assume {:breadcrumb 154} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OpenIDConnectNameSpace\OpenIDConnectNameSpace.cs"} {:sourceLine 213} true;
    $result := null;
    return;
}



procedure T$OpenIDConnectNameSpace.RelyingParty.#cctor();



implementation T$OpenIDConnectNameSpace.RelyingParty.#cctor()
{
}



function T$GenericAuthNameSpace.ID_Claim() : Ref;

const unique T$GenericAuthNameSpace.ID_Claim: int;

procedure GenericAuthNameSpace.ID_Claim.get_UserID($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ID_Claim.get_Redir_dest($this: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.ID_Claim.#ctor($this: Ref);



implementation GenericAuthNameSpace.ID_Claim.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 155} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.ID_Claim.#cctor();



implementation T$GenericAuthNameSpace.ID_Claim.#cctor()
{
}



function T$GenericAuthNameSpace.IdP() : Ref;

const unique T$GenericAuthNameSpace.IdP: int;

var F$GenericAuthNameSpace.IdP.IdpAuthRecs: [Ref]Ref;

procedure {:extern} OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req1$in: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.IdP.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



function {:extern} T$OAuth20NameSpace.AuthorizationServer() : Ref;

const {:extern} unique T$OAuth20NameSpace.AuthorizationServer: int;

axiom $TypeConstructor(T$OAuth20NameSpace.AuthorizationServer()) == T$OAuth20NameSpace.AuthorizationServer;

procedure {:extern} OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest($this: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.AccessTokenEntry.get_Redir_dest($this: Ref) returns ($result: Ref);



function {:extern} T$OAuth20NameSpace.AccessTokenEntry() : Ref;

const {:extern} unique T$OAuth20NameSpace.AccessTokenEntry: int;

axiom $TypeConstructor(T$OAuth20NameSpace.AccessTokenEntry()) == T$OAuth20NameSpace.AccessTokenEntry;

procedure GenericAuthNameSpace.IdP.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, _ID_Claim$in: Ref) returns ($result: Ref);



implementation GenericAuthNameSpace.IdP.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var _ID_Claim_Ref: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: bool;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: bool;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: Ref;
  var $tmp19: Ref;
  var $tmp20: Ref;
  var $tmp21: bool;
  var $tmp22: Ref;
  var $tmp23: Ref;
  var $tmp24: Ref;
  var $tmp25: Ref;
  var $tmp26: Ref;
  var $tmp27: Ref;
  var $tmp28: Ref;
  var $tmp29: Ref;
  var $tmp30: Ref;
  var $tmp31: Ref;
  var $tmp32: Ref;
  var $tmp33: Ref;
  var $tmp34: Ref;
  var $tmp35: Ref;
  var $tmp36: Ref;
  var $tmp37: Ref;
  var $tmp38: Ref;
  var $tmp39: Ref;
  var $tmp40: Ref;
  var $tmp41: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 156} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 60} true;
    if (req == null)
    {
        assume {:breadcrumb 157} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 60} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 158} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 61} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 61} true;
    if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
    {
        call $tmp0 := OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
    }
    else
    {
        if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
        {
            call $tmp1 := OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
        }
        else
        {
            if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer)
            {
                call $tmp2 := OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
            }
            else
            {
                call $tmp3 := GenericAuthNameSpace.IdP.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
            }
        }
    }

    _ID_Claim_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp0 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp1 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer then $tmp2 else $tmp3)));
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 62} true;
    assume $this != null;
    if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def)
    {
        assume $this != null;
        $tmp4 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this];
        $tmp5 := req;
        assume $tmp5 != null;
        if ($TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest)
        {
            call $tmp6 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
        }
        else
        {
            if ($TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest)
            {
                call $tmp7 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
            }
            else
            {
                call $tmp8 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(req);
            }
        }

        call $tmp9 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp4, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp5], (if $TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp6 else (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp7 else $tmp8)), _ID_Claim_Ref);
    }
    else
    {
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
        {
            assume $this != null;
            $tmp10 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this];
            $tmp11 := req;
            assume $tmp11 != null;
            if ($TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest)
            {
                call $tmp12 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
            }
            else
            {
                if ($TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest)
                {
                    call $tmp13 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
                }
                else
                {
                    call $tmp14 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(req);
                }
            }

            call $tmp15 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp10, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp11], (if $TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp12 else (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp13 else $tmp14)), _ID_Claim_Ref);
        }
        else
        {
            assume $this != null;
            $tmp16 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this];
            $tmp17 := req;
            assume $tmp17 != null;
            if ($TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest)
            {
                call $tmp18 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
            }
            else
            {
                if ($TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest)
                {
                    call $tmp19 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
                }
                else
                {
                    call $tmp20 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(req);
                }
            }

            call $tmp21 := GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp16, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp17], (if $TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp18 else (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp19 else $tmp20)), _ID_Claim_Ref);
        }
    }

    if (!(if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp9 else (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp15 else $tmp21)))
    {
        assume {:breadcrumb 159} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 63} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 160} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 64} true;
    if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
    {
        if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
        {
            call $tmp22 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(_ID_Claim_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
            {
                call $tmp23 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_Redir_dest(_ID_Claim_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
                {
                    call $tmp24 := OAuth20NameSpace.AccessTokenEntry.get_Redir_dest(_ID_Claim_Ref);
                }
                else
                {
                    call $tmp25 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(_ID_Claim_Ref);
                }
            }
        }

        call $tmp26 := OpenIDConnectNameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp22 else (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp23 else (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp24 else $tmp25))), _ID_Claim_Ref);
    }
    else
    {
        if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
        {
            if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
            {
                call $tmp27 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(_ID_Claim_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
                {
                    call $tmp28 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_Redir_dest(_ID_Claim_Ref);
                }
                else
                {
                    if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
                    {
                        call $tmp29 := OAuth20NameSpace.AccessTokenEntry.get_Redir_dest(_ID_Claim_Ref);
                    }
                    else
                    {
                        call $tmp30 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(_ID_Claim_Ref);
                    }
                }
            }

            call $tmp31 := OpenIDConnectNameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp27 else (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp28 else (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp29 else $tmp30))), _ID_Claim_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer)
            {
                if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
                {
                    call $tmp32 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(_ID_Claim_Ref);
                }
                else
                {
                    if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
                    {
                        call $tmp33 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_Redir_dest(_ID_Claim_Ref);
                    }
                    else
                    {
                        if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
                        {
                            call $tmp34 := OAuth20NameSpace.AccessTokenEntry.get_Redir_dest(_ID_Claim_Ref);
                        }
                        else
                        {
                            call $tmp35 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(_ID_Claim_Ref);
                        }
                    }
                }

                call $tmp36 := GenericAuthNameSpace.IdP.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp32 else (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp33 else (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp34 else $tmp35))), _ID_Claim_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
                {
                    call $tmp37 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(_ID_Claim_Ref);
                }
                else
                {
                    if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
                    {
                        call $tmp38 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_Redir_dest(_ID_Claim_Ref);
                    }
                    else
                    {
                        if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
                        {
                            call $tmp39 := OAuth20NameSpace.AccessTokenEntry.get_Redir_dest(_ID_Claim_Ref);
                        }
                        else
                        {
                            call $tmp40 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(_ID_Claim_Ref);
                        }
                    }
                }

                call $tmp41 := GenericAuthNameSpace.IdP.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp37 else (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp38 else (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp39 else $tmp40))), _ID_Claim_Ref);
            }
        }
    }

    $result := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp26 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp31 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer then $tmp36 else $tmp41)));
    return;
}



procedure GenericAuthNameSpace.IdP.#ctor($this: Ref);



implementation GenericAuthNameSpace.IdP.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this] := null;
    assume {:breadcrumb 161} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.IdP.#cctor();



implementation T$GenericAuthNameSpace.IdP.#cctor()
{
}



function T$GenericAuthNameSpace.SignInIdP_Req() : Ref;

const unique T$GenericAuthNameSpace.SignInIdP_Req: int;

procedure GenericAuthNameSpace.SignInIdP_Req.#ctor($this: Ref);



procedure {:extern} CST.CST_Struct.#ctor($this: Ref);



implementation GenericAuthNameSpace.SignInIdP_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$this] := null;
    assume {:breadcrumb 162} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.SignInIdP_Req.#cctor();



implementation T$GenericAuthNameSpace.SignInIdP_Req.#cctor()
{
}



function T$GenericAuthNameSpace.SignInRP_Resp() : Ref;

const unique T$GenericAuthNameSpace.SignInRP_Resp: int;

procedure GenericAuthNameSpace.SignInRP_Resp.#ctor($this: Ref);



implementation GenericAuthNameSpace.SignInRP_Resp.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 163} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.SignInRP_Resp.#cctor();



implementation T$GenericAuthNameSpace.SignInRP_Resp.#cctor()
{
}



function T$GenericAuthNameSpace.GlobalObjects_base() : Ref;

const unique T$GenericAuthNameSpace.GlobalObjects_base: int;

procedure {:extern} OAuth20NameSpace.AuthorizationCodeEntry.get_UserID($this: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.AccessTokenEntry.get_UserID($this: Ref) returns ($result: Ref);



var F$GenericAuthNameSpace.RP.Domain: [Ref]Ref;

implementation GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson$GenericAuthNameSpace.RP.AuthenticationConclusion(conclusion$in: Ref)
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
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: Ref;
  var $tmp19: Ref;
  var $tmp20: Ref;
  var $tmp21: Ref;
  var $tmp22: bool;
  var $tmp23: Ref;
  var $tmp24: Ref;
  var $tmp25: Ref;
  var $tmp26: Ref;
  var $tmp27: Ref;
  var $tmp28: bool;
  var $localExc: Ref;
  var $label: int;

    conclusion := conclusion$in;
    assume {:breadcrumb 164} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 102} true;
    $tmp16 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
    assume $tmp16 != null;
    if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp16])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def)
    {
        $tmp0 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
        assume $tmp0 != null;
        $tmp1 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp0];
        $tmp2 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
        assume $tmp2 != null;
        $tmp3 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
        assume $tmp3 != null;
        call $tmp4 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$System.String$System.String($tmp1, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp2], F$GenericAuthNameSpace.RP.Realm[$tmp3]);
    }
    else
    {
        $tmp15 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
        assume $tmp15 != null;
        if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp15])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
        {
            $tmp5 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
            assume $tmp5 != null;
            $tmp6 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp5];
            $tmp7 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
            assume $tmp7 != null;
            $tmp8 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
            assume $tmp8 != null;
            call $tmp9 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($tmp6, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp7], F$GenericAuthNameSpace.RP.Realm[$tmp8]);
        }
        else
        {
            $tmp10 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
            assume $tmp10 != null;
            $tmp11 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp10];
            $tmp12 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
            assume $tmp12 != null;
            $tmp13 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
            assume $tmp13 != null;
            call $tmp14 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp11, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp12], F$GenericAuthNameSpace.RP.Realm[$tmp13]);
        }
    }

    ID_claim_Ref := (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp16])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp4 else (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp15])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp9 else $tmp14));
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 105} true;
    if ($TypeConstructor($DynamicType(ID_claim_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
    {
        call $tmp23 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(ID_claim_Ref);
    }
    else
    {
        if ($TypeConstructor($DynamicType(ID_claim_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
        {
            call $tmp24 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_Redir_dest(ID_claim_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType(ID_claim_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
            {
                call $tmp25 := OAuth20NameSpace.AccessTokenEntry.get_Redir_dest(ID_claim_Ref);
            }
            else
            {
                call $tmp26 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(ID_claim_Ref);
            }
        }
    }

    $tmp27 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp27 != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 105} true;
    call $tmp28 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(ID_claim_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp23 else (if $TypeConstructor($DynamicType(ID_claim_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp24 else (if $TypeConstructor($DynamicType(ID_claim_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp25 else $tmp26))), F$GenericAuthNameSpace.RP.Domain[$tmp27]);
    if ($tmp28)
    {
        if ($TypeConstructor($DynamicType(ID_claim_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry)
        {
            call $tmp17 := OAuth20NameSpace.AuthorizationCodeEntry.get_UserID(ID_claim_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType(ID_claim_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry)
            {
                call $tmp18 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_UserID(ID_claim_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType(ID_claim_Ref)) == T$OAuth20NameSpace.AccessTokenEntry)
                {
                    call $tmp19 := OAuth20NameSpace.AccessTokenEntry.get_UserID(ID_claim_Ref);
                }
                else
                {
                    call $tmp20 := GenericAuthNameSpace.ID_Claim.get_UserID(ID_claim_Ref);
                }
            }
        }

        $tmp21 := conclusion;
        assume $tmp21 != null;
        call $tmp22 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(ID_claim_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp17 else (if $TypeConstructor($DynamicType(ID_claim_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp18 else (if $TypeConstructor($DynamicType(ID_claim_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp19 else $tmp20))), F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp21]);
    }
    else
    {
    }

    assert (if $tmp28 then $tmp22 else false);
}



implementation GenericAuthNameSpace.GlobalObjects_base.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 165} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.GlobalObjects_base.#cctor();



implementation T$GenericAuthNameSpace.GlobalObjects_base.#cctor()
{
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := null;
    F$GenericAuthNameSpace.GlobalObjects_base.IdP := null;
    F$GenericAuthNameSpace.GlobalObjects_base.RP := null;
}



function T$GenericAuthNameSpace.RP() : Ref;

const unique T$GenericAuthNameSpace.RP: int;

var F$GenericAuthNameSpace.RP.CurrentSession: [Ref]Ref;

procedure GenericAuthNameSpace.RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} CST.CST_Ops.Certify$CST.CST_Struct(msg$in: Ref) returns ($result: bool);



const {:value "UserID"} unique $string_literal_UserID_24: Ref;

const {:value ""} unique $string_literal__25: Ref;

procedure {:extern} System.Web.SessionState.HttpSessionState.set_Item$System.String$System.Object($this: Ref, name$in: Ref, value$in: Ref);



implementation GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool)
{
  var conclusion: Ref;
  var CST_verified_bool: bool;
  var $tmp0: bool;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

    conclusion := conclusion$in;
    assume {:breadcrumb 166} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 83} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 83} true;
    call $tmp0 := CST.CST_Ops.Certify$CST.CST_Struct(conclusion);
    CST_verified_bool := $tmp0;
    assume $this != null;
    $tmp1 := F$GenericAuthNameSpace.RP.CurrentSession[$this];
    if (CST_verified_bool)
    {
        $tmp2 := conclusion;
        assume $tmp2 != null;
    }
    else
    {
    }

    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 83} true;
    call System.Web.SessionState.HttpSessionState.set_Item$System.String$System.Object($tmp1, $string_literal_UserID_24, (if CST_verified_bool then F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp2] else $string_literal__25));
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 85} true;
    $result := CST_verified_bool;
    return;
}



procedure GenericAuthNameSpace.RP.#ctor($this: Ref);



implementation GenericAuthNameSpace.RP.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.RP.CurrentSession[$this] := null;
    F$GenericAuthNameSpace.RP.Domain[$this] := null;
    F$GenericAuthNameSpace.RP.Realm[$this] := null;
    assume {:breadcrumb 167} true;
    call System.Object.#ctor($this);
}



implementation GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$this] := null;
    assume {:breadcrumb 168} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.RP.AuthenticationConclusion.#cctor();



implementation T$GenericAuthNameSpace.RP.AuthenticationConclusion.#cctor()
{
}



procedure T$GenericAuthNameSpace.RP.#cctor();



implementation T$GenericAuthNameSpace.RP.#cctor()
{
}



function T$GenericAuthNameSpace.IdPAuthRecords_Base() : Ref;

const unique T$GenericAuthNameSpace.IdPAuthRecords_Base: int;

function T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req() : Ref;

const unique T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req: int;

procedure GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this: Ref);



implementation GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 169} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor();



implementation T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor()
{
}



procedure LiveIDNameSpace.LiveID_RP.#ctor$System.String$System.String$System.String$System.String($this: Ref, client_id$in: Ref, return_uri$in: Ref, client_secret$in: Ref, TokenEndpointUrl$in: Ref);



procedure {:extern} System.Uri.#ctor$System.String($this: Ref, uriString$in: Ref);



function {:extern} T$System.Uri() : Ref;

const {:extern} unique T$System.Uri: int;

axiom $TypeConstructor(T$System.Uri()) == T$System.Uri;

procedure {:extern} System.Uri.get_Host($this: Ref) returns ($result: Ref);



var {:extern} F$CST.CST_Ops.myPartyName: Ref;

var {:extern} F$CST.CST_Ops.trustedParties: Ref;

implementation LiveIDNameSpace.LiveID_RP.#ctor$System.String$System.String$System.String$System.String($this: Ref, client_id$in: Ref, return_uri$in: Ref, client_secret$in: Ref, TokenEndpointUrl$in: Ref)
{
  var client_id: Ref;
  var return_uri: Ref;
  var client_secret: Ref;
  var TokenEndpointUrl: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

    client_id := client_id$in;
    return_uri := return_uri$in;
    client_secret := client_secret$in;
    TokenEndpointUrl := TokenEndpointUrl$in;
    assume {:breadcrumb 170} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\LiveID\LiveIDNameSpace.cs"} {:sourceLine 25} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\LiveID\LiveIDNameSpace.cs"} {:sourceLine 25} true;
    call OpenIDConnectNameSpace.RelyingParty.#ctor$System.String$System.String$System.String$System.String($this, client_id, return_uri, client_secret, TokenEndpointUrl);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\LiveID\LiveIDNameSpace.cs"} {:sourceLine 28} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\LiveID\LiveIDNameSpace.cs"} {:sourceLine 28} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\LiveID\LiveIDNameSpace.cs"} {:sourceLine 28} true;
    call System.Uri.#ctor$System.String($tmp0, return_uri);
    assume $DynamicType($tmp0) == T$System.Uri();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Uri;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\LiveID\LiveIDNameSpace.cs"} {:sourceLine 28} true;
    call $tmp1 := System.Uri.get_Host($tmp0);
    F$CST.CST_Ops.myPartyName := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\LiveID\LiveIDNameSpace.cs"} {:sourceLine 29} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\LiveID\LiveIDNameSpace.cs"} {:sourceLine 29} true;
    call $tmp2 := Alloc();
    assume $ArrayLength($tmp2) == 1 * 2;
    F$CST.CST_Ops.trustedParties := $tmp2;
}



const {:value "000000004C108D95"} unique $string_literal_000000004C108D95_26: Ref;

const {:value "http://a.local.host:14022/login.aspx"} unique $string_literal_http$$$a.local.host$14022$login.aspx_27: Ref;

const {:value "zMVS1BpoNHwtdTnSzazSt2JgLd1hxRA1"} unique $string_literal_zMVS1BpoNHwtdTnSzazSt2JgLd1hxRA1_28: Ref;

const {:value "https://login.live.com/oauth20_token.srf"} unique $string_literal_https$$$login.live.com$oauth20_token.srf_29: Ref;

implementation LiveIDNameSpace.LiveID_RP.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 171} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\LiveID\LiveIDNameSpace.cs"} {:sourceLine 31} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\LiveID\LiveIDNameSpace.cs"} {:sourceLine 31} true;
    call LiveIDNameSpace.LiveID_RP.#ctor$System.String$System.String$System.String$System.String($this, $string_literal_000000004C108D95_26, $string_literal_http$$$a.local.host$14022$login.aspx_27, $string_literal_zMVS1BpoNHwtdTnSzazSt2JgLd1hxRA1_28, $string_literal_https$$$login.live.com$oauth20_token.srf_29);
}



procedure LiveIDNameSpace.LiveID_RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



implementation LiveIDNameSpace.LiveID_RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var codeResp_Ref: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 172} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\LiveID\LiveIDNameSpace.cs"} {:sourceLine 42} true;
    codeResp_Ref := req;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\LiveID\LiveIDNameSpace.cs"} {:sourceLine 43} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\LiveID\LiveIDNameSpace.cs"} {:sourceLine 43} true;
    call $tmp0 := OpenIDConnectNameSpace.RelyingParty.AuthenticationUsingAuthorizationCodeFlow$OpenIDConnectNameSpace.AuthenticationResponse($this, codeResp_Ref);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\LiveID\LiveIDNameSpace.cs"} {:sourceLine 44} true;
    $result := null;
    return;
}



procedure T$LiveIDNameSpace.LiveID_RP.#cctor();



implementation T$LiveIDNameSpace.LiveID_RP.#cctor()
{
}



function T$OAuth20NameSpace.AccessTokenRequest() : Ref;

const unique T$OAuth20NameSpace.AccessTokenRequest: int;

var F$OAuth20NameSpace.AccessTokenRequest.refresh_token: [Ref]Ref;

implementation OAuth20NameSpace.AccessTokenRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AccessTokenRequest.grant_type[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.code[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.client_id[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.refresh_token[$this] := null;
    assume {:breadcrumb 173} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 44} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 44} true;
    F$OAuth20NameSpace.AccessTokenRequest.refresh_token[$this] := null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 44} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$OAuth20NameSpace.AccessTokenRequest.#cctor();



implementation T$OAuth20NameSpace.AccessTokenRequest.#cctor()
{
}



function T$OAuth20NameSpace.AccessTokenRecs() : Ref;

const unique T$OAuth20NameSpace.AccessTokenRecs: int;

procedure OAuth20NameSpace.AccessTokenRecs.findISSByClientIDAndAccessToken$System.String$System.String($this: Ref, client_id$in: Ref, access_token$in: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.AccessTokenRecs.findISSByClientIDAndRefreshToken$System.String$System.String($this: Ref, client_id$in: Ref, refresh_token$in: Ref) returns ($result: Ref);



var F$OAuth20NameSpace.AuthorizationRequest.response_type: [Ref]Ref;

var F$OAuth20NameSpace.AuthorizationRequest.client_id: [Ref]Ref;

implementation OAuth20NameSpace.AuthorizationRequest.get_Realm($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 174} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 18} true;
    assume $this != null;
    $result := F$OAuth20NameSpace.AuthorizationRequest.client_id[$this];
    return;
}



implementation OAuth20NameSpace.AuthorizationRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AuthorizationRequest.response_type[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.client_id[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.scope[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.state[$this] := null;
    assume {:breadcrumb 175} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 20} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 20} true;
    F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$this] := null;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 22} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 22} true;
    F$OAuth20NameSpace.AuthorizationRequest.state[$this] := null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 22} true;
    call GenericAuthNameSpace.SignInIdP_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.AuthorizationRequest.#cctor();



implementation T$OAuth20NameSpace.AuthorizationRequest.#cctor()
{
}



function T$OAuth20NameSpace.AuthorizationCodeRecs() : Ref;

const unique T$OAuth20NameSpace.AuthorizationCodeRecs: int;

implementation OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 176} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 151} true;
    assume $this != null;
    $result := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this];
    return;
}



implementation OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 177} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 152} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 152} true;
    F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this] := value;
}



implementation OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AuthorizationCodeRecs$OAuth20NameSpace.AccessTokenRecs($this: Ref, AuthorizationCodeRecs1$in: Ref, AccessTokenRecs1$in: Ref)
{
  var AuthorizationCodeRecs1: Ref;
  var AccessTokenRecs1: Ref;
  var $localExc: Ref;
  var $label: int;

    AuthorizationCodeRecs1 := AuthorizationCodeRecs1$in;
    AccessTokenRecs1 := AccessTokenRecs1$in;
    assume {:breadcrumb 178} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 156} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 156} true;
    F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this] := AuthorizationCodeRecs1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 157} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 157} true;
    call OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this, AccessTokenRecs1);
}



const {:value "token"} unique $string_literal_token_30: Ref;

procedure OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req1$in: Ref) returns ($result: Ref)
{
  var req1: Ref;
  var req_Ref: Ref;
  var CS$4$0001_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: bool;
  var $tmp2: bool;
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
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $localExc: Ref;
  var $label: int;

    req1 := req1$in;
    assume {:breadcrumb 179} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 161} true;
    req_Ref := req1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 162} true;
    $tmp0 := req_Ref;
    assume $tmp0 != null;
    CS$4$0001_Ref := F$OAuth20NameSpace.AuthorizationRequest.response_type[$tmp0];
    if (CS$4$0001_Ref != null)
    {
        assume {:breadcrumb 180} true;
        call $tmp1 := System.String.op_Equality$System.String$System.String(CS$4$0001_Ref, $string_literal_code_19);
        if (!$tmp1)
        {
            assume {:breadcrumb 182} true;
            call $tmp2 := System.String.op_Equality$System.String$System.String(CS$4$0001_Ref, $string_literal_token_30);
            if ($tmp2)
            {
                assume {:breadcrumb 184} true;
                goto IL_0038;
            }
            else
            {
                assume {:breadcrumb 185} true;
            }
        }
        else
        {
            assume {:breadcrumb 183} true;
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 165} true;
            if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
            {
                call $tmp3 := LiveIDNameSpace.LiveID_IdP.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, req_Ref);
            }
            else
            {
                if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
                {
                    call $tmp4 := OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, req_Ref);
                }
                else
                {
                    call $tmp5 := OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, req_Ref);
                }
            }

            $result := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp3 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp4 else $tmp5));
            return;

          IL_0038:
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 167} true;
            if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
            {
                $tmp6 := req_Ref;
                assume $tmp6 != null;
                $tmp7 := req_Ref;
                assume $tmp7 != null;
                $tmp8 := req_Ref;
                assume $tmp8 != null;
                call $tmp9 := LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$tmp6], F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp7], F$OAuth20NameSpace.AuthorizationRequest.state[$tmp8]);
            }
            else
            {
                if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
                {
                    $tmp10 := req_Ref;
                    assume $tmp10 != null;
                    $tmp11 := req_Ref;
                    assume $tmp11 != null;
                    $tmp12 := req_Ref;
                    assume $tmp12 != null;
                    call $tmp13 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$tmp10], F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp11], F$OAuth20NameSpace.AuthorizationRequest.state[$tmp12]);
                }
                else
                {
                    $tmp14 := req_Ref;
                    assume $tmp14 != null;
                    $tmp15 := req_Ref;
                    assume $tmp15 != null;
                    $tmp16 := req_Ref;
                    assume $tmp16 != null;
                    call $tmp17 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$tmp14], F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp15], F$OAuth20NameSpace.AuthorizationRequest.state[$tmp16]);
                }
            }

            $result := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp9 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp13 else $tmp17));
            return;
        }
    }
    else
    {
        assume {:breadcrumb 181} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 169} true;
    $result := null;
    return;
}



procedure OAuth20NameSpace.AuthorizationServer.AuthorizationEndpoint$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AuthorizationServer.AuthorizationEndpoint$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 186} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 174} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 174} true;
    call $tmp0 := GenericAuthNameSpace.IdP.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
    $result := $tmp0;
    return;
}



procedure OAuth20NameSpace.AuthorizationServer.TokenEndpoint$OAuth20NameSpace.AccessTokenRequest($this: Ref, req$in: Ref) returns ($result: Ref);



const {:value "refresh_token"} unique $string_literal_refresh_token_31: Ref;

function T$OAuth20NameSpace.AccessTokenResponse() : Ref;

const unique T$OAuth20NameSpace.AccessTokenResponse: int;

implementation OAuth20NameSpace.AuthorizationServer.TokenEndpoint$OAuth20NameSpace.AccessTokenRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var $tmp0: Ref;
  var CS$4$0002_Ref: Ref;
  var $tmp1: bool;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var IdPSessionSecret_Ref: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: Ref;
  var $tmp19: Ref;
  var AuthCodeEntry_Ref: Ref;
  var $tmp20: Ref;
  var $tmp21: Ref;
  var $tmp22: bool;
  var $tmp23: Ref;
  var $tmp24: Ref;
  var $tmp25: Ref;
  var $tmp26: Ref;
  var $tmp27: Ref;
  var $tmp28: Ref;
  var $tmp29: Ref;
  var $tmp30: Ref;
  var $tmp31: Ref;
  var $tmp32: Ref;
  var $tmp33: Ref;
  var $tmp34: Ref;
  var AccessTokenEntry_Ref: Ref;
  var $tmp35: Ref;
  var $tmp36: Ref;
  var $tmp37: bool;
  var $tmp38: Ref;
  var $tmp39: Ref;
  var $tmp40: bool;
  var $tmp41: Ref;
  var $tmp42: Ref;
  var $tmp43: bool;
  var $tmp44: Ref;
  var $tmp45: Ref;
  var $tmp46: Ref;
  var resp_Ref: Ref;
  var $tmp47: Ref;
  var $tmp48: Ref;
  var $tmp49: Ref;
  var $tmp50: Ref;
  var $tmp51: Ref;
  var $tmp52: Ref;
  var $tmp53: Ref;
  var $tmp54: Ref;
  var $tmp55: Ref;
  var $tmp56: Ref;
  var $tmp57: Ref;
  var $tmp58: Ref;
  var $tmp59: Ref;
  var $tmp60: Ref;
  var $tmp61: Ref;
  var $tmp62: Ref;
  var $tmp63: Ref;
  var $tmp64: Ref;
  var $tmp65: Ref;
  var $tmp66: Ref;
  var $tmp67: Ref;
  var $tmp68: Ref;
  var $tmp69: Ref;
  var $tmp70: Ref;
  var $tmp71: Ref;
  var $tmp72: Ref;
  var $tmp73: Ref;
  var $tmp74: Ref;
  var $tmp75: Ref;
  var $tmp76: Ref;
  var $tmp77: Ref;
  var $tmp78: Ref;
  var $tmp79: Ref;
  var $tmp80: Ref;
  var $tmp81: Ref;
  var newAccessTokenEntry_Ref: Ref;
  var $tmp82: Ref;
  var $tmp83: Ref;
  var $tmp84: bool;
  var $tmp85: Ref;
  var $tmp86: Ref;
  var $tmp87: bool;
  var $tmp88: Ref;
  var $tmp89: Ref;
  var $tmp90: bool;
  var $tmp91: Ref;
  var $tmp92: Ref;
  var $tmp93: Ref;
  var $tmp94: Ref;
  var $tmp95: Ref;
  var $tmp96: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 187} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 181} true;
    if (req == null)
    {
        assume {:breadcrumb 188} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 181} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 189} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 182} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 182} true;
    $tmp0 := req;
    assume $tmp0 != null;
    CS$4$0002_Ref := F$OAuth20NameSpace.AccessTokenRequest.grant_type[$tmp0];
    if (CS$4$0002_Ref != null)
    {
        assume {:breadcrumb 190} true;
        call $tmp1 := System.String.op_Equality$System.String$System.String(CS$4$0002_Ref, $string_literal_authorization_code_2);
        if (!$tmp1)
        {
            assume {:breadcrumb 192} true;
            call $tmp2 := System.String.op_Equality$System.String$System.String(CS$4$0002_Ref, $string_literal_refresh_token_31);
            if ($tmp2)
            {
                assume {:breadcrumb 194} true;
                goto IL_011c;
            }
            else
            {
                assume {:breadcrumb 195} true;
            }
        }
        else
        {
            assume {:breadcrumb 193} true;
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 185} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 185} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
            {
                assume $this != null;
                $tmp3 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
                $tmp4 := req;
                assume $tmp4 != null;
                $tmp5 := req;
                assume $tmp5 != null;
                call $tmp6 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.findISSByClientIDAndCode$System.String$System.String($tmp3, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp4], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp5]);
            }
            else
            {
                assume $this != null;
                $tmp7 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
                $tmp8 := req;
                assume $tmp8 != null;
                $tmp9 := req;
                assume $tmp9 != null;
                call $tmp10 := OAuth20NameSpace.AuthorizationCodeRecs.findISSByClientIDAndCode$System.String$System.String($tmp7, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp8], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp9]);
            }

            IdPSessionSecret_Ref := (if $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp6 else $tmp10);
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 186} true;
            if (IdPSessionSecret_Ref == null)
            {
                assume {:breadcrumb 196} true;
                assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 187} true;
                $result := null;
                return;
            }
            else
            {
                assume {:breadcrumb 197} true;
            }

            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 188} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 188} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def)
            {
                assume $this != null;
                $tmp11 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
                $tmp12 := req;
                assume $tmp12 != null;
                call $tmp13 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$System.String$System.String($tmp11, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp12]);
            }
            else
            {
                assume $this != null;
                if ($TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
                {
                    assume $this != null;
                    $tmp14 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
                    $tmp15 := req;
                    assume $tmp15 != null;
                    call $tmp16 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($tmp14, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp15]);
                }
                else
                {
                    assume $this != null;
                    $tmp17 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
                    $tmp18 := req;
                    assume $tmp18 != null;
                    call $tmp19 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp17, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp18]);
                }
            }

            AuthCodeEntry_Ref := (if $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp13 else (if $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp16 else $tmp19));
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 189} true;
            $tmp20 := AuthCodeEntry_Ref;
            assume $tmp20 != null;
            $tmp21 := req;
            assume $tmp21 != null;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 189} true;
            call $tmp22 := System.String.op_Inequality$System.String$System.String(F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp20], F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[$tmp21]);
            if ($tmp22)
            {
                assume {:breadcrumb 198} true;
                assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 190} true;
                $result := null;
                return;
            }
            else
            {
                assume {:breadcrumb 199} true;
            }

            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 191} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 191} true;
            if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
            {
                $tmp23 := AuthCodeEntry_Ref;
                assume $tmp23 != null;
                $tmp24 := AuthCodeEntry_Ref;
                assume $tmp24 != null;
                $tmp25 := AuthCodeEntry_Ref;
                assume $tmp25 != null;
                call $tmp26 := LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp23], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp24], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp25]);
            }
            else
            {
                if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
                {
                    $tmp27 := AuthCodeEntry_Ref;
                    assume $tmp27 != null;
                    $tmp28 := AuthCodeEntry_Ref;
                    assume $tmp28 != null;
                    $tmp29 := AuthCodeEntry_Ref;
                    assume $tmp29 != null;
                    call $tmp30 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp27], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp28], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp29]);
                }
                else
                {
                    $tmp31 := AuthCodeEntry_Ref;
                    assume $tmp31 != null;
                    $tmp32 := AuthCodeEntry_Ref;
                    assume $tmp32 != null;
                    $tmp33 := AuthCodeEntry_Ref;
                    assume $tmp33 != null;
                    call $tmp34 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp31], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp32], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp33]);
                }
            }

            AccessTokenEntry_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp26 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp30 else $tmp34));
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 192} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 192} true;
            call $tmp45 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
            if ($TypeConstructor($DynamicType($tmp45)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def)
            {
                call $tmp35 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                $tmp36 := req;
                assume $tmp36 != null;
                call $tmp37 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp35, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp36], AccessTokenEntry_Ref);
            }
            else
            {
                call $tmp44 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                if ($TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
                {
                    call $tmp38 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                    $tmp39 := req;
                    assume $tmp39 != null;
                    call $tmp40 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp38, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp39], AccessTokenEntry_Ref);
                }
                else
                {
                    call $tmp41 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                    $tmp42 := req;
                    assume $tmp42 != null;
                    call $tmp43 := GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp41, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp42], AccessTokenEntry_Ref);
                }
            }

            if (!(if $TypeConstructor($DynamicType($tmp45)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp37 else (if $TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp40 else $tmp43)))
            {
                assume {:breadcrumb 200} true;
                assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 193} true;
                $result := null;
                return;
            }
            else
            {
                assume {:breadcrumb 201} true;
            }

            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 194} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 194} true;
            call $tmp46 := Alloc();
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 194} true;
            call OAuth20NameSpace.AccessTokenResponse.#ctor($tmp46);
            assume $DynamicType($tmp46) == T$OAuth20NameSpace.AccessTokenResponse();
            assume $TypeConstructor($DynamicType($tmp46)) == T$OAuth20NameSpace.AccessTokenResponse;
            resp_Ref := $tmp46;
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 195} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 195} true;
            $tmp47 := AccessTokenEntry_Ref;
            assume $tmp47 != null;
            F$OAuth20NameSpace.AccessTokenResponse.access_token[resp_Ref] := F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp47];
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 196} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 196} true;
            $tmp48 := AccessTokenEntry_Ref;
            assume $tmp48 != null;
            F$OAuth20NameSpace.AccessTokenResponse.refresh_token[resp_Ref] := F$OAuth20NameSpace.AccessTokenEntry.refresh_token[$tmp48];
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 197} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 197} true;
            $tmp49 := AccessTokenEntry_Ref;
            assume $tmp49 != null;
            F$OAuth20NameSpace.AccessTokenResponse.scope[resp_Ref] := F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp49];
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 198} true;
            $result := resp_Ref;
            return;

          IL_011c:
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 200} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 200} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 200} true;
            call $tmp58 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
            if ($TypeConstructor($DynamicType($tmp58)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def)
            {
                call $tmp50 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                $tmp51 := req;
                assume $tmp51 != null;
                $tmp52 := req;
                assume $tmp52 != null;
                call $tmp53 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.findISSByClientIDAndRefreshToken$System.String$System.String($tmp50, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp51], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp52]);
            }
            else
            {
                call $tmp54 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                $tmp55 := req;
                assume $tmp55 != null;
                $tmp56 := req;
                assume $tmp56 != null;
                call $tmp57 := OAuth20NameSpace.AccessTokenRecs.findISSByClientIDAndRefreshToken$System.String$System.String($tmp54, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp55], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp56]);
            }

            IdPSessionSecret_Ref := (if $TypeConstructor($DynamicType($tmp58)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp53 else $tmp57);
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 201} true;
            if (IdPSessionSecret_Ref == null)
            {
                assume {:breadcrumb 202} true;
                assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 202} true;
                $result := null;
                return;
            }
            else
            {
                assume {:breadcrumb 203} true;
            }

            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 203} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 203} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 203} true;
            call $tmp69 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
            if ($TypeConstructor($DynamicType($tmp69)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def)
            {
                call $tmp59 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                $tmp60 := req;
                assume $tmp60 != null;
                call $tmp61 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$System.String$System.String($tmp59, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp60]);
            }
            else
            {
                call $tmp68 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                if ($TypeConstructor($DynamicType($tmp68)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
                {
                    call $tmp62 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                    $tmp63 := req;
                    assume $tmp63 != null;
                    call $tmp64 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($tmp62, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp63]);
                }
                else
                {
                    call $tmp65 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                    $tmp66 := req;
                    assume $tmp66 != null;
                    call $tmp67 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp65, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp66]);
                }
            }

            AccessTokenEntry_Ref := (if $TypeConstructor($DynamicType($tmp69)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp61 else (if $TypeConstructor($DynamicType($tmp68)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp64 else $tmp67));
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 204} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 204} true;
            if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP)
            {
                $tmp70 := AccessTokenEntry_Ref;
                assume $tmp70 != null;
                $tmp71 := AccessTokenEntry_Ref;
                assume $tmp71 != null;
                $tmp72 := AccessTokenEntry_Ref;
                assume $tmp72 != null;
                call $tmp73 := LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$tmp70], F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp71], F$OAuth20NameSpace.AccessTokenEntry.state[$tmp72]);
            }
            else
            {
                if ($TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider)
                {
                    $tmp74 := AccessTokenEntry_Ref;
                    assume $tmp74 != null;
                    $tmp75 := AccessTokenEntry_Ref;
                    assume $tmp75 != null;
                    $tmp76 := AccessTokenEntry_Ref;
                    assume $tmp76 != null;
                    call $tmp77 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$tmp74], F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp75], F$OAuth20NameSpace.AccessTokenEntry.state[$tmp76]);
                }
                else
                {
                    $tmp78 := AccessTokenEntry_Ref;
                    assume $tmp78 != null;
                    $tmp79 := AccessTokenEntry_Ref;
                    assume $tmp79 != null;
                    $tmp80 := AccessTokenEntry_Ref;
                    assume $tmp80 != null;
                    call $tmp81 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$tmp78], F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp79], F$OAuth20NameSpace.AccessTokenEntry.state[$tmp80]);
                }
            }

            newAccessTokenEntry_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp73 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp77 else $tmp81));
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 205} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 205} true;
            call $tmp92 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
            if ($TypeConstructor($DynamicType($tmp92)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def)
            {
                call $tmp82 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                $tmp83 := req;
                assume $tmp83 != null;
                call $tmp84 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp82, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp83], newAccessTokenEntry_Ref);
            }
            else
            {
                call $tmp91 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                if ($TypeConstructor($DynamicType($tmp91)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def)
                {
                    call $tmp85 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                    $tmp86 := req;
                    assume $tmp86 != null;
                    call $tmp87 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp85, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp86], newAccessTokenEntry_Ref);
                }
                else
                {
                    call $tmp88 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
                    $tmp89 := req;
                    assume $tmp89 != null;
                    call $tmp90 := GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp88, IdPSessionSecret_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp89], newAccessTokenEntry_Ref);
                }
            }

            if (!(if $TypeConstructor($DynamicType($tmp92)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp84 else (if $TypeConstructor($DynamicType($tmp91)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp87 else $tmp90)))
            {
                assume {:breadcrumb 204} true;
                assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 206} true;
                $result := null;
                return;
            }
            else
            {
                assume {:breadcrumb 205} true;
            }

            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 207} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 207} true;
            call $tmp93 := Alloc();
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 207} true;
            call OAuth20NameSpace.AccessTokenResponse.#ctor($tmp93);
            assume $DynamicType($tmp93) == T$OAuth20NameSpace.AccessTokenResponse();
            assume $TypeConstructor($DynamicType($tmp93)) == T$OAuth20NameSpace.AccessTokenResponse;
            resp_Ref := $tmp93;
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 208} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 208} true;
            $tmp94 := AccessTokenEntry_Ref;
            assume $tmp94 != null;
            F$OAuth20NameSpace.AccessTokenResponse.access_token[resp_Ref] := F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp94];
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 209} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 209} true;
            $tmp95 := AccessTokenEntry_Ref;
            assume $tmp95 != null;
            F$OAuth20NameSpace.AccessTokenResponse.refresh_token[resp_Ref] := F$OAuth20NameSpace.AccessTokenEntry.refresh_token[$tmp95];
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 210} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 210} true;
            $tmp96 := AccessTokenEntry_Ref;
            assume $tmp96 != null;
            F$OAuth20NameSpace.AccessTokenResponse.scope[resp_Ref] := F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp96];
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 211} true;
            $result := resp_Ref;
            return;
        }
    }
    else
    {
        assume {:breadcrumb 191} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 213} true;
    $result := null;
    return;
}



implementation OAuth20NameSpace.AuthorizationServer.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this] := null;
    assume {:breadcrumb 206} true;
    call GenericAuthNameSpace.IdP.#ctor($this);
}



procedure T$OAuth20NameSpace.AuthorizationServer.#cctor();



implementation T$OAuth20NameSpace.AuthorizationServer.#cctor()
{
}



var F$OAuth20NameSpace.AccessTokenResponse.token_type: [Ref]Ref;

implementation OAuth20NameSpace.AccessTokenResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AccessTokenResponse.access_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.token_type[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.expires_in[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.refresh_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.scope[$this] := null;
    assume {:breadcrumb 207} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 52} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 52} true;
    F$OAuth20NameSpace.AccessTokenResponse.refresh_token[$this] := null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 52} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$OAuth20NameSpace.AccessTokenResponse.#cctor();



implementation T$OAuth20NameSpace.AccessTokenResponse.#cctor()
{
}



implementation OAuth20NameSpace.AuthorizationCodeEntry.get_UserID($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 208} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 66} true;
    assume $this != null;
    $result := F$OAuth20NameSpace.AuthorizationCodeEntry.code[$this];
    return;
}



implementation OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 209} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 71} true;
    assume $this != null;
    $result := F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$this];
    return;
}



procedure OAuth20NameSpace.AuthorizationCodeEntry.#ctor($this: Ref);



implementation OAuth20NameSpace.AuthorizationCodeEntry.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AuthorizationCodeEntry.code[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.state[$this] := null;
    assume {:breadcrumb 210} true;
    call GenericAuthNameSpace.ID_Claim.#ctor($this);
}



procedure T$OAuth20NameSpace.AuthorizationCodeEntry.#cctor();



implementation T$OAuth20NameSpace.AuthorizationCodeEntry.#cctor()
{
}



implementation OAuth20NameSpace.Client.get_client_id($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 211} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 113} true;
    assume $this != null;
    $result := F$GenericAuthNameSpace.RP.Realm[$this];
    return;
}



procedure OAuth20NameSpace.Client.set_client_id$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.Client.set_client_id$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 212} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 114} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 114} true;
    F$GenericAuthNameSpace.RP.Realm[$this] := value;
}



implementation OAuth20NameSpace.Client.get_return_uri($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 213} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 118} true;
    assume $this != null;
    $result := F$GenericAuthNameSpace.RP.Domain[$this];
    return;
}



procedure OAuth20NameSpace.Client.set_return_uri$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.Client.set_return_uri$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 214} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 119} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 119} true;
    F$GenericAuthNameSpace.RP.Domain[$this] := value;
}



implementation OAuth20NameSpace.Client.#ctor$System.String$System.String$System.String$System.String($this: Ref, client_id1$in: Ref, return_uri1$in: Ref, client_secret1$in: Ref, TokenEndpointUrl1$in: Ref)
{
  var client_id1: Ref;
  var return_uri1: Ref;
  var client_secret1: Ref;
  var TokenEndpointUrl1: Ref;
  var $localExc: Ref;
  var $label: int;

    client_id1 := client_id1$in;
    return_uri1 := return_uri1$in;
    client_secret1 := client_secret1$in;
    TokenEndpointUrl1 := TokenEndpointUrl1$in;
    F$OAuth20NameSpace.Client.client_secret[$this] := null;
    F$OAuth20NameSpace.Client.TokenEndpointUrl[$this] := null;
    assume {:breadcrumb 215} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 123} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 123} true;
    call GenericAuthNameSpace.RP.#ctor($this);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 125} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 125} true;
    call OAuth20NameSpace.Client.set_client_id$System.String($this, client_id1);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 126} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 126} true;
    call OAuth20NameSpace.Client.set_return_uri$System.String($this, return_uri1);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 127} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 127} true;
    F$OAuth20NameSpace.Client.client_secret[$this] := client_secret1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 128} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 128} true;
    F$OAuth20NameSpace.Client.TokenEndpointUrl[$this] := TokenEndpointUrl1;
}



procedure OAuth20NameSpace.Client.AuthorizationCodeGrant$OAuth20NameSpace.AuthorizationResponse($this: Ref, codeResp$in: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.Client.AuthorizationCodeGrant$OAuth20NameSpace.AuthorizationResponse($this: Ref, codeResp$in: Ref) returns ($result: Ref)
{
  var codeResp: Ref;
  var tokenReq_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    codeResp := codeResp$in;
    assume {:breadcrumb 216} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 132} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 132} true;
    call OAuth20NameSpace.AccessTokenRequest.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OAuth20NameSpace.AccessTokenRequest();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OAuth20NameSpace.AccessTokenRequest;
    tokenReq_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 133} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 133} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 133} true;
    call $tmp1 := OAuth20NameSpace.Client.get_client_id($this);
    F$OAuth20NameSpace.AccessTokenRequest.client_id[tokenReq_Ref] := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 134} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 134} true;
    $tmp2 := codeResp;
    assume $tmp2 != null;
    F$OAuth20NameSpace.AccessTokenRequest.code[tokenReq_Ref] := F$OAuth20NameSpace.AuthorizationResponse.code[$tmp2];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 135} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 135} true;
    F$OAuth20NameSpace.AccessTokenRequest.grant_type[tokenReq_Ref] := $string_literal_authorization_code_2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 136} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 136} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 136} true;
    call $tmp3 := OAuth20NameSpace.Client.get_return_uri($this);
    F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[tokenReq_Ref] := $tmp3;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 137} true;
    $result := tokenReq_Ref;
    return;
}



procedure T$OAuth20NameSpace.Client.#cctor();



implementation T$OAuth20NameSpace.Client.#cctor()
{
}



function T$OAuth20NameSpace.AuthorizationErrorResponse() : Ref;

const unique T$OAuth20NameSpace.AuthorizationErrorResponse: int;

var F$OAuth20NameSpace.AuthorizationErrorResponse.error: [Ref]Ref;

var F$OAuth20NameSpace.AuthorizationErrorResponse.error_description: [Ref]Ref;

var F$OAuth20NameSpace.AuthorizationErrorResponse.error_uri: [Ref]Ref;

var F$OAuth20NameSpace.AuthorizationErrorResponse.state: [Ref]Ref;

procedure OAuth20NameSpace.AuthorizationErrorResponse.#ctor($this: Ref);



implementation OAuth20NameSpace.AuthorizationErrorResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AuthorizationErrorResponse.error[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_description[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.state[$this] := null;
    assume {:breadcrumb 217} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 34} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 34} true;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_description[$this] := null;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 34} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 34} true;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_uri[$this] := null;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 35} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 35} true;
    F$OAuth20NameSpace.AuthorizationErrorResponse.state[$this] := null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 35} true;
    call GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.AuthorizationErrorResponse.#cctor();



implementation T$OAuth20NameSpace.AuthorizationErrorResponse.#cctor()
{
}



function T$OAuth20NameSpace.AuthorizationResponse() : Ref;

const unique T$OAuth20NameSpace.AuthorizationResponse: int;

implementation OAuth20NameSpace.AuthorizationResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AuthorizationResponse.code[$this] := null;
    F$OAuth20NameSpace.AuthorizationResponse.state[$this] := null;
    assume {:breadcrumb 218} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 28} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 28} true;
    F$OAuth20NameSpace.AuthorizationResponse.state[$this] := null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 28} true;
    call GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this);
}



procedure T$OAuth20NameSpace.AuthorizationResponse.#cctor();



implementation T$OAuth20NameSpace.AuthorizationResponse.#cctor()
{
}



function T$OAuth20NameSpace.resource_server() : Ref;

const unique T$OAuth20NameSpace.resource_server: int;

procedure OAuth20NameSpace.resource_server.#ctor($this: Ref);



implementation OAuth20NameSpace.resource_server.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 219} true;
    call System.Object.#ctor($this);
}



procedure T$OAuth20NameSpace.resource_server.#cctor();



implementation T$OAuth20NameSpace.resource_server.#cctor()
{
}



implementation OAuth20NameSpace.AccessTokenEntry.get_UserID($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 220} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 82} true;
    assume $this != null;
    $result := F$OAuth20NameSpace.AccessTokenEntry.access_token[$this];
    return;
}



implementation OAuth20NameSpace.AccessTokenEntry.get_Redir_dest($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 221} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\OAuth20NameSpace\OAuth20NameSpace.cs"} {:sourceLine 87} true;
    assume $this != null;
    $result := F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$this];
    return;
}



implementation OAuth20NameSpace.AccessTokenEntry.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OAuth20NameSpace.AccessTokenEntry.access_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.scope[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.refresh_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.state[$this] := null;
    assume {:breadcrumb 222} true;
    call GenericAuthNameSpace.ID_Claim.#ctor($this);
}



procedure T$OAuth20NameSpace.AccessTokenEntry.#cctor();



implementation T$OAuth20NameSpace.AccessTokenEntry.#cctor()
{
}



function T$CST.Debug() : Ref;

const unique T$CST.Debug: int;

procedure CST.Debug.reached();



implementation CST.Debug.reached()
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 223} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 22} true;
    assert false;
}



procedure CST.Debug.#ctor($this: Ref);



implementation CST.Debug.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 224} true;
    call System.Object.#ctor($this);
}



procedure T$CST.Debug.#cctor();



implementation T$CST.Debug.#cctor()
{
}



function T$CST.CST_Struct() : Ref;

const unique T$CST.CST_Struct: int;

var F$CST.CST_Struct.SignedBy: [Ref]Ref;

implementation CST.CST_Struct.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$CST.CST_Struct.SymT[$this] := null;
    F$CST.CST_Struct.SignedBy[$this] := null;
    assume {:breadcrumb 225} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 15} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 15} true;
    F$CST.CST_Struct.SymT[$this] := $string_literal__25;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 16} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 16} true;
    F$CST.CST_Struct.SignedBy[$this] := $string_literal__25;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 16} true;
    call System.Object.#ctor($this);
}



procedure T$CST.CST_Struct.#cctor();



implementation T$CST.CST_Struct.#cctor()
{
}



function T$CST.Nondet_Base() : Ref;

const unique T$CST.Nondet_Base: int;

procedure CST.Nondet_Base.Int($this: Ref) returns ($result: int);



procedure CST.Nondet_Base.Bool($this: Ref) returns ($result: bool);



