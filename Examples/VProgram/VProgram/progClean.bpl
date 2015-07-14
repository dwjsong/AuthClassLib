const hashsetEmpty: [Union]bool;

axiom (forall x: Union :: { hashsetEmpty[x] } !hashsetEmpty[x]);

var hashsets: [Ref][Union]bool;

var hashsetSize: [Ref]int;

procedure {:extern} System.Collections.Generic.HashSet`1.#ctor($this: Ref);



implementation {:extern} System.Collections.Generic.HashSet`1.#ctor($this: Ref)
{

  anon0:
    hashsets[$this] := hashsetEmpty;
    hashsetSize[$this] := 0;
    return;
}



procedure {:extern} System.Collections.Generic.HashSet`1.Add$`0($this: Ref, item$in: Union) returns ($result: bool);



implementation {:extern} System.Collections.Generic.HashSet`1.Add$`0($this: Ref, item$in: Union) returns ($result: bool)
{

  anon0:
    $result := !hashsets[$this][item$in];
    hashsets[$this][item$in] := true;
    goto anon2_Then, anon2_Else;

  anon2_Then:
    assume {:partition} $result;
    hashsetSize[$this] := hashsetSize[$this] + 1;
    return;

  anon2_Else:
    assume {:partition} !$result;
    return;
}



procedure {:extern} System.Collections.Generic.HashSet`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool);



implementation {:extern} System.Collections.Generic.HashSet`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool)
{

  anon0:
    $result := hashsets[$this][item$in];
    return;
}



procedure {:extern} System.Collections.Generic.HashSet`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool);



implementation {:extern} System.Collections.Generic.HashSet`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool)
{

  anon0:
    $result := hashsets[$this][item$in];
    hashsets[$this][item$in] := false;
    goto anon2_Then, anon2_Else;

  anon2_Then:
    assume {:partition} $result;
    hashsetSize[$this] := hashsetSize[$this] - 1;
    return;

  anon2_Else:
    assume {:partition} !$result;
    return;
}



procedure {:extern} System.Collections.Generic.HashSet`1.get_Count($this: Ref) returns ($result: int);



implementation {:extern} System.Collections.Generic.HashSet`1.get_Count($this: Ref) returns ($result: int)
{

  anon0:
    $result := hashsetSize[$this];
    return;
}



procedure {:extern} System.Collections.Generic.HashSet`1.New($this: Ref) returns ($result: Ref);



implementation {:extern} System.Collections.Generic.HashSet`1.New($this: Ref) returns ($result: Ref)
{

  anon0:
    call $result := Alloc();
    call System.Collections.Generic.HashSet`1.#ctor($result);
    assume $DynamicType($result) == $DynamicType($this);
    return;
}



var stacks: [Ref][int]Union;

var stackPtr: [Ref]int;

procedure {:extern} System.Collections.Generic.Stack`1.#ctor($this: Ref);



implementation {:extern} System.Collections.Generic.Stack`1.#ctor($this: Ref)
{

  anon0:
    stackPtr[$this] := 0;
    return;
}



procedure {:extern} System.Collections.Generic.Stack`1.Push$`0($this: Ref, item$in: Union);



implementation {:extern} System.Collections.Generic.Stack`1.Push$`0($this: Ref, item$in: Union)
{

  anon0:
    stacks[$this][stackPtr[$this]] := item$in;
    stackPtr[$this] := stackPtr[$this] + 1;
    return;
}



procedure {:extern} System.Collections.Generic.Stack`1.Pop($this: Ref) returns ($result: Union);



implementation {:extern} System.Collections.Generic.Stack`1.Pop($this: Ref) returns ($result: Union)
{

  anon0:
    stackPtr[$this] := stackPtr[$this] - 1;
    $result := stacks[$this][stackPtr[$this]];
    return;
}



procedure {:extern} System.Collections.Generic.Stack`1.get_Count($this: Ref) returns ($result: int);



implementation {:extern} System.Collections.Generic.Stack`1.get_Count($this: Ref) returns ($result: int)
{

  anon0:
    $result := stackPtr[$this];
    return;
}



procedure {:extern} System.Collections.Generic.Stack`1.Peek($this: Ref) returns ($result: Union);



implementation {:extern} System.Collections.Generic.Stack`1.Peek($this: Ref) returns ($result: Union)
{

  anon0:
    $result := stacks[$this][stackPtr[$this] - 1];
    return;
}



var listContents: [Ref][int]Union;

var listSize: [Ref]int;

procedure {:extern} System.Collections.Generic.List`1.#ctor($this: Ref);



implementation {:extern} System.Collections.Generic.List`1.#ctor($this: Ref)
{

  anon0:
    listSize[$this] := 0;
    return;
}



procedure {:extern} System.Collections.Generic.List`1.Add$`0($this: Ref, item$in: Union);



implementation {:extern} System.Collections.Generic.List`1.Add$`0($this: Ref, item$in: Union)
{
  var size: int;

  anon0:
    size := listSize[$this];
    listContents[$this][size] := item$in;
    listSize[$this] := size + 1;
    return;
}



procedure {:extern} System.Collections.Generic.List`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool);



implementation {:extern} System.Collections.Generic.List`1.Remove$`0($this: Ref, item$in: Union) returns ($result: bool)
{
  var iter: int;

  anon0:
    $result := false;
    iter := 0;
    goto anon6_LoopHead;

  anon6_LoopHead:
    goto anon6_LoopDone, anon6_LoopBody;

  anon6_LoopBody:
    assume {:partition} iter < listSize[$this] && !$result;
    $result := item$in == listContents[$this][iter];
    iter := iter + 1;
    goto anon6_LoopHead;

  anon6_LoopDone:
    assume {:partition} !(iter < listSize[$this] && !$result);
    goto anon2;

  anon2:
    goto anon7_LoopHead;

  anon7_LoopHead:
    goto anon7_LoopDone, anon7_LoopBody;

  anon7_LoopBody:
    assume {:partition} iter < listSize[$this];
    listContents[$this][iter - 1] := listContents[$this][iter];
    iter := iter + 1;
    goto anon7_LoopHead;

  anon7_LoopDone:
    assume {:partition} listSize[$this] <= iter;
    goto anon4;

  anon4:
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} $result;
    listSize[$this] := listSize[$this] - 1;
    return;

  anon8_Else:
    assume {:partition} !$result;
    return;
}



procedure {:extern} System.Collections.Generic.List`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool);



implementation {:extern} System.Collections.Generic.List`1.Contains$`0($this: Ref, item$in: Union) returns ($result: bool)
{
  var iter: int;

  anon0:
    $result := false;
    iter := 0;
    goto anon2_LoopHead;

  anon2_LoopHead:
    goto anon2_LoopDone, anon2_LoopBody;

  anon2_LoopBody:
    assume {:partition} iter < listSize[$this] && !$result;
    $result := item$in == listContents[$this][iter];
    iter := iter + 1;
    goto anon2_LoopHead;

  anon2_LoopDone:
    assume {:partition} !(iter < listSize[$this] && !$result);
    return;
}



procedure {:extern} System.Collections.Generic.List`1.get_Count($this: Ref) returns ($result: int);



implementation {:extern} System.Collections.Generic.List`1.get_Count($this: Ref) returns ($result: int)
{

  anon0:
    $result := listSize[$this];
    return;
}



procedure {:extern} System.Collections.Generic.List`1.Clear($this: Ref);



implementation {:extern} System.Collections.Generic.List`1.Clear($this: Ref)
{

  anon0:
    listSize[$this] := 0;
    return;
}



procedure {:extern} System.Collections.Generic.List`1.get_Item$System.Int32($this: Ref, index$in: int) returns ($result: Union);



implementation {:extern} System.Collections.Generic.List`1.get_Item$System.Int32($this: Ref, index$in: int) returns ($result: Union)
{

  anon0:
    $result := listContents[$this][index$in];
    return;
}



procedure {:extern} System.Collections.Generic.List`1.set_Item$System.Int32$`0($this: Ref, index$in: int, value$in: Union);



implementation {:extern} System.Collections.Generic.List`1.set_Item$System.Int32$`0($this: Ref, index$in: int, value$in: Union)
{

  anon0:
    listContents[$this][index$in] := value$in;
    return;
}



var AllMaps: [Ref][Union]Union;

procedure {:extern} System.Collections.Generic.Dictionary`2.get_Item$`0(this: Ref, key$in: Union) returns ($result: Union);



implementation {:extern} System.Collections.Generic.Dictionary`2.get_Item$`0(this: Ref, key$in: Union) returns ($result: Union)
{

  anon0:
    $result := AllMaps[this][key$in];
    return;
}



procedure {:extern} System.Collections.Generic.Dictionary`2.set_Item$`0$`1(this: Ref, key$in: Union, value$in: Union);



implementation {:extern} System.Collections.Generic.Dictionary`2.set_Item$`0$`1(this: Ref, key$in: Union, value$in: Union)
{

  anon0:
    AllMaps[this][key$in] := value$in;
    return;
}



procedure {:inline 1} Alloc() returns (x: Ref);
  modifies $Alloc;



implementation {:inline 1} Alloc() returns (x: Ref)
{

  anon0:
    assume $Alloc[x] == false && x != null;
    $Alloc[x] := true;
    return;
}



procedure {:inline 1} System.Object.GetType(this: Ref) returns ($result: Ref);



implementation {:inline 1} System.Object.GetType(this: Ref) returns ($result: Ref)
{

  anon0:
    $result := $DynamicType(this);
    return;
}



axiom Union2Int(null) == 0;

axiom Union2Bool(null) == false;

function $ThreadDelegate(Ref) : Ref;

procedure {:inline 1} System.Threading.Thread.#ctor$System.Threading.ParameterizedThreadStart(this: Ref, start$in: Ref);



implementation {:inline 1} System.Threading.Thread.#ctor$System.Threading.ParameterizedThreadStart(this: Ref, start$in: Ref)
{

  anon0:
    assume $ThreadDelegate(this) == start$in;
    return;
}



procedure {:inline 1} System.Threading.Thread.Start$System.Object(this: Ref, parameter$in: Ref);



implementation {:inline 1} System.Threading.Thread.Start$System.Object(this: Ref, parameter$in: Ref)
{

  anon0:
    async call Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object($ThreadDelegate(this), parameter$in);
    return;
}



procedure Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref);



implementation Wrapper_System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref)
{

  anon0:
    $Exception := null;
    call System.Threading.ParameterizedThreadStart.Invoke$System.Object(this, obj$in);
    return;
}



procedure {:extern} System.Threading.ParameterizedThreadStart.Invoke$System.Object(this: Ref, obj$in: Ref);



procedure {:inline 1} System.Threading.Thread.#ctor$System.Threading.ThreadStart(this: Ref, start$in: Ref);



implementation {:inline 1} System.Threading.Thread.#ctor$System.Threading.ThreadStart(this: Ref, start$in: Ref)
{

  anon0:
    assume $ThreadDelegate(this) == start$in;
    return;
}



procedure {:inline 1} System.Threading.Thread.Start(this: Ref);



implementation {:inline 1} System.Threading.Thread.Start(this: Ref)
{

  anon0:
    async call Wrapper_System.Threading.ThreadStart.Invoke($ThreadDelegate(this));
    return;
}



procedure Wrapper_System.Threading.ThreadStart.Invoke(this: Ref);



implementation Wrapper_System.Threading.ThreadStart.Invoke(this: Ref)
{

  anon0:
    $Exception := null;
    call System.Threading.ThreadStart.Invoke(this);
    return;
}



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



implementation {:inline 1} $BoxFromBool(b: bool) returns (r: Ref)
{

  anon0:
    call r := Alloc();
    assume $TypeConstructor($DynamicType(r)) == $BoolValueType;
    assume Union2Bool(r) == b;
    return;
}



procedure {:inline 1} $BoxFromInt(i: int) returns (r: Ref);



implementation {:inline 1} $BoxFromInt(i: int) returns (r: Ref)
{

  anon0:
    call r := Alloc();
    assume $TypeConstructor($DynamicType(r)) == $IntValueType;
    assume Union2Int(r) == i;
    return;
}



procedure {:inline 1} $BoxFromReal(r: Real) returns (rf: Ref);



implementation {:inline 1} $BoxFromReal(r: Real) returns (rf: Ref)
{

  anon0:
    call rf := Alloc();
    assume $TypeConstructor($DynamicType(rf)) == $RealValueType;
    assume Union2Real(rf) == r;
    return;
}



procedure {:inline 1} $BoxFromUnion(u: Union) returns (r: Ref);



implementation {:inline 1} $BoxFromUnion(u: Union) returns (r: Ref)
{

  anon0:
    r := u;
    return;
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

  anon0:
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

  anon0:
    assume {:breadcrumb 1} true;
    call LiveIDNameSpace.LiveID_RP.#ctor($this);
    return;
}



procedure T$LiveIDNameSpace.LiveID_RP_For_vProgram.#cctor();



implementation T$LiveIDNameSpace.LiveID_RP_For_vProgram.#cctor()
{

  anon0:
    return;
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

  anon0:
    assume {:breadcrumb 2} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 29} true;
    assume $this != null;
    assume $this != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 29} true;
    call OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AuthorizationCodeRecs$OAuth20NameSpace.AccessTokenRecs($this, F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary[$this], F$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary[$this]);
    return;
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

  anon0:
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

  anon0:
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

  anon0:
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
    return;
}



var F$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.Dictionary: [Ref]Ref;

procedure LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref) returns ($result: Ref);



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

  anon0:
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

  anon0:
    IdPSessionSecret := IdPSessionSecret$in;
    client_id := client_id$in;
    Entry := Entry$in;
    assume {:breadcrumb 7} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 44} true;
    AuthorizationCodeEntry_Ref := Entry;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 45} true;
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} AuthorizationCodeEntry_Ref == null;
    assume {:breadcrumb 8} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 46} true;
    $result := false;
    return;

  anon4_Else:
    assume {:partition} AuthorizationCodeEntry_Ref != null;
    assume {:breadcrumb 9} true;
    goto anon3;

  anon3:
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

  anon0:
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
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} $tmp5;
    assume {:breadcrumb 11} true;
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenIDConnectNameSpace.AuthenticationRequest;
    call $tmp6 := OAuth20NameSpace.AuthorizationRequest.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
    goto anon6;

  anon13_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) != T$OpenIDConnectNameSpace.AuthenticationRequest;
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp7 := OAuth20NameSpace.AuthorizationRequest.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
    goto anon6;

  anon14_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) != T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp8 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
    goto anon6;

  anon6:
    call $tmp9 := System.String.op_Equality$System.String$System.String(client_id, (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp6 else (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp7 else $tmp8)));
    goto anon15_Then, anon15_Else;

  anon15_Then:
    assume {:partition} $tmp9;
    assume {:breadcrumb 13} true;
    goto anon9;

  anon15_Else:
    assume {:partition} !$tmp9;
    assume {:breadcrumb 14} true;
    goto IL_0062;

  anon9:
    $tmp10 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp10 != null;
    call $tmp11 := System.String.op_Equality$System.String$System.String(client_id, F$GenericAuthNameSpace.RP.Realm[$tmp10]);
    stack_0_System_Boolean_bool := $tmp11;
    goto anon11;

  anon12_Else:
    assume {:partition} !$tmp5;
    assume {:breadcrumb 12} true;
    goto IL_0062;

  IL_0062:
    stack_0_System_Boolean_bool := false;
    goto anon11;

  anon11:
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

  anon0:
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
    return;
}



procedure T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.#cctor();



implementation T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.#cctor()
{

  anon0:
    return;
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

  anon0:
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

  anon0:
    IdPSessionSecret := IdPSessionSecret$in;
    client_id := client_id$in;
    Entry := Entry$in;
    assume {:breadcrumb 17} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 76} true;
    IDTokenAndAccessTokenEntry_Ref := Entry;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 77} true;
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} IDTokenAndAccessTokenEntry_Ref == null;
    assume {:breadcrumb 18} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\OtherParties\LiveID_IdP.cs"} {:sourceLine 78} true;
    $result := false;
    return;

  anon4_Else:
    assume {:partition} IDTokenAndAccessTokenEntry_Ref != null;
    assume {:breadcrumb 19} true;
    goto anon3;

  anon3:
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

  anon0:
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

  anon0:
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

  anon0:
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
    return;
}



procedure T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.#cctor();



implementation T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.#cctor()
{

  anon0:
    return;
}



procedure T$LiveIDNameSpace.LiveID_IdP.#cctor();



implementation T$LiveIDNameSpace.LiveID_IdP.#cctor()
{

  anon0:
    F$LiveIDNameSpace.LiveID_IdP.Nondet := null;
    return;
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

  anon0:
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
    return;
}



procedure SynthesizedPortion.#ctor($this: Ref);



implementation SynthesizedPortion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 24} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$SynthesizedPortion.#cctor();



implementation T$SynthesizedPortion.#cctor()
{

  anon0:
    return;
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

  anon0:
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
    return;
}



procedure GlobalObjectsForCST.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.GlobalObjects_base.#ctor($this: Ref);



implementation GlobalObjectsForCST.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 26} true;
    call GenericAuthNameSpace.GlobalObjects_base.#ctor($this);
    return;
}



procedure T$GlobalObjectsForCST.#cctor();



implementation T$GlobalObjectsForCST.#cctor()
{

  anon0:
    return;
}



function T$PoirotMain() : Ref;

const unique T$PoirotMain: int;

procedure {:entrypoint} PoirotMain.Main();



implementation PoirotMain.Main()
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    call T$LiveIDNameSpace.LiveID_RP_For_vProgram.#cctor();
    call T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.#cctor();
    call T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.#cctor();
    call T$LiveIDNameSpace.LiveID_IdP.#cctor();
    call T$SynthesizedPortion.#cctor();
    call T$GlobalObjectsForCST.#cctor();
    call T$PoirotMain.#cctor();
    call T$OpenIDConnectNameSpace.AuthenticationRequest.#cctor();
    call T$OpenIDConnectNameSpace.OpenIDProvider.#cctor();
    call T$OpenIDConnectNameSpace.JsonDataStrcuture.#cctor();
    call OpenIDConnectNameSpace.JsonWebToken.#cctor();
    call T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#cctor();
    call T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#cctor();
    call T$OpenIDConnectNameSpace.TokenResponse.#cctor();
    call T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.#cctor();
    call T$OpenIDConnectNameSpace.TokenRequest.#cctor();
    call T$OpenIDConnectNameSpace.AuthenticationResponse.#cctor();
    call T$OpenIDConnectNameSpace.RelyingParty.#cctor();
    call T$GenericAuthNameSpace.ID_Claim.#cctor();
    call T$GenericAuthNameSpace.IdP.#cctor();
    call T$GenericAuthNameSpace.SignInIdP_Req.#cctor();
    call T$GenericAuthNameSpace.SignInRP_Resp.#cctor();
    call T$GenericAuthNameSpace.GlobalObjects_base.#cctor();
    call T$GenericAuthNameSpace.RP.AuthenticationConclusion.#cctor();
    call T$GenericAuthNameSpace.RP.#cctor();
    call T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor();
    call T$LiveIDNameSpace.LiveID_RP.#cctor();
    call T$OAuth20NameSpace.AccessTokenRequest.#cctor();
    call T$OAuth20NameSpace.AuthorizationRequest.#cctor();
    call T$OAuth20NameSpace.AuthorizationServer.#cctor();
    call T$OAuth20NameSpace.AccessTokenResponse.#cctor();
    call T$OAuth20NameSpace.AuthorizationCodeEntry.#cctor();
    call T$OAuth20NameSpace.Client.#cctor();
    call T$OAuth20NameSpace.AuthorizationErrorResponse.#cctor();
    call T$OAuth20NameSpace.AuthorizationResponse.#cctor();
    call T$OAuth20NameSpace.resource_server.#cctor();
    call T$OAuth20NameSpace.AccessTokenEntry.#cctor();
    call T$CST.Debug.#cctor();
    call T$CST.CST_Struct.#cctor();
    $Exception := null;
    $GetMeHereTracker := 0;
    assume {:breadcrumb 27} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 20} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 20} true;
    call GlobalObjectsForCST.init();
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 21} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\Examples\VProgram\VProgram\Program.cs"} {:sourceLine 21} true;
    call SynthesizedPortion.SynthesizedSequence();
    return;
}



procedure PoirotMain.#ctor($this: Ref);



implementation PoirotMain.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 28} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$PoirotMain.#cctor();



implementation T$PoirotMain.#cctor()
{

  anon0:
    F$PoirotMain.Nondet := null;
    return;
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

  anon0:
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
    F$OpenIDConnectNameSpace.AuthenticationRequest.response_mode[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.nonce[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.display[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.prompt[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.max_age[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.ui_locales[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.id_token_hint[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.login_hint[$this] := null;
    F$OpenIDConnectNameSpace.AuthenticationRequest.acr_values[$this] := null;
    call OAuth20NameSpace.AuthorizationRequest.#ctor($this);
    return;
}



procedure T$OpenIDConnectNameSpace.AuthenticationRequest.#cctor();



implementation T$OpenIDConnectNameSpace.AuthenticationRequest.#cctor()
{

  anon0:
    return;
}



function T$OpenIDConnectNameSpace.OpenIDProvider() : Ref;

const unique T$OpenIDConnectNameSpace.OpenIDProvider: int;

procedure OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 30} true;
    call $tmp0 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    local_0_Ref := $tmp0;
    goto IL_000f;

  IL_000f:
    $result := local_0_Ref;
    return;
}



procedure OpenIDConnectNameSpace.OpenIDProvider.set_IDTokenAndAccessTokenRecs$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs($this: Ref, value$in: Ref);



procedure {:extern} OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.set_IDTokenAndAccessTokenRecs$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 31} true;
    call OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this, value);
    return;
}



procedure OpenIDConnectNameSpace.OpenIDProvider.init$OAuth20NameSpace.AuthorizationCodeRecs$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs($this: Ref, AuthorizationCodeRecs1$in: Ref, IDTokenAndAccessTokenRecs1$in: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.init$OAuth20NameSpace.AuthorizationCodeRecs$OpenIDConnectNameSpace.IDTokenAndAccessTokenRecs($this: Ref, AuthorizationCodeRecs1$in: Ref, IDTokenAndAccessTokenRecs1$in: Ref)
{
  var AuthorizationCodeRecs1: Ref;
  var IDTokenAndAccessTokenRecs1: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    AuthorizationCodeRecs1 := AuthorizationCodeRecs1$in;
    IDTokenAndAccessTokenRecs1 := IDTokenAndAccessTokenRecs1$in;
    assume {:breadcrumb 32} true;
    call OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AuthorizationCodeRecs$OAuth20NameSpace.AccessTokenRecs($this, AuthorizationCodeRecs1, IDTokenAndAccessTokenRecs1);
    return;
}



procedure OpenIDConnectNameSpace.OpenIDProvider.AuthorizationEndpoint$OpenIDConnectNameSpace.AuthenticationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



const {:value "openid"} unique $string_literal_openid_0: Ref;

procedure {:extern} GenericAuthNameSpace.IdP.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.AuthorizationEndpoint$OpenIDConnectNameSpace.AuthenticationRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var local_0_Ref: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    req := req$in;
    assume {:breadcrumb 33} true;
    $tmp0 := req;
    assume $tmp0 != null;
    $tmp1 := F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp0];
    call $tmp2 := System.Collections.Generic.HashSet`1.Contains$`0($tmp1, $string_literal_openid_0);
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} !$tmp2;
    assume {:breadcrumb 34} true;
    local_0_Ref := null;
    goto IL_0028;

  anon3_Else:
    assume {:partition} $tmp2;
    assume {:breadcrumb 35} true;
    call $tmp3 := GenericAuthNameSpace.IdP.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
    local_0_Ref := $tmp3;
    goto IL_0028;

  IL_0028:
    $result := local_0_Ref;
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
  var local_0_Ref: Ref;
  var local_2_Ref: Ref;
  var $tmp0: Ref;
  var local_1_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    dest := dest$in;
    claim := claim$in;
    assume {:breadcrumb 36} true;
    local_0_Ref := $As(claim, T$OAuth20NameSpace.AuthorizationCodeEntry());
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} local_0_Ref == null;
    assume {:breadcrumb 37} true;
    local_2_Ref := null;
    goto IL_0044;

  anon3_Else:
    assume {:partition} local_0_Ref != null;
    assume {:breadcrumb 38} true;
    call $tmp0 := Alloc();
    call OpenIDConnectNameSpace.AuthenticationResponse.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenIDConnectNameSpace.AuthenticationResponse();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenIDConnectNameSpace.AuthenticationResponse;
    local_1_Ref := $tmp0;
    $tmp1 := local_0_Ref;
    assume $tmp1 != null;
    F$OAuth20NameSpace.AuthorizationResponse.code[local_1_Ref] := F$OAuth20NameSpace.AuthorizationCodeEntry.code[$tmp1];
    $tmp2 := local_1_Ref;
    assume $tmp2 != null;
    call $tmp3 := System.String.Concat$System.String$System.String($string_literal_code$_1, F$OAuth20NameSpace.AuthorizationResponse.code[$tmp2]);
    call $tmp4 := HTTP.HTTPComm.HttpPost$System.String$System.String(dest, $tmp3);
    local_2_Ref := local_1_Ref;
    goto IL_0044;

  IL_0044:
    $result := local_2_Ref;
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
  var local_4_Ref: Ref;
  var $tmp0: Ref;
  var local_6_Ref: Ref;
  var $tmp1: bool;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var local_2_Ref: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: Ref;
  var local_3_Ref: Ref;
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
  var local_0_Ref: Ref;
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
  var local_1_prime_Ref: Ref;
  var $tmp45: Ref;
  var $tmp46: Ref;
  var $tmp47: Ref;
  var $tmp48: Ref;
  var $tmp49: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    req := req$in;
    assume {:breadcrumb 39} true;
    goto anon32_Then, anon32_Else;

  anon32_Then:
    assume {:partition} req == null;
    assume {:breadcrumb 40} true;
    local_4_Ref := null;
    goto IL_0118;

  anon32_Else:
    assume {:partition} req != null;
    assume {:breadcrumb 41} true;
    $tmp0 := req;
    assume $tmp0 != null;
    local_6_Ref := F$OAuth20NameSpace.AccessTokenRequest.grant_type[$tmp0];
    goto anon33_Then, anon33_Else;

  anon33_Then:
    assume {:partition} local_6_Ref != null;
    assume {:breadcrumb 42} true;
    call $tmp1 := System.String.op_Equality$System.String$System.String(local_6_Ref, $string_literal_authorization_code_2);
    goto anon34_Then, anon34_Else;

  anon34_Then:
    assume {:partition} !$tmp1;
    assume {:breadcrumb 44} true;
    goto IL_0113;

  anon34_Else:
    assume {:partition} $tmp1;
    assume {:breadcrumb 45} true;
    goto anon6;

  anon6:
    assume $this != null;
    goto anon35_Then, anon35_Else;

  anon35_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    assume $this != null;
    $tmp2 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
    $tmp3 := req;
    assume $tmp3 != null;
    $tmp4 := req;
    assume $tmp4 != null;
    call $tmp5 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.findISSByClientIDAndCode$System.String$System.String($tmp2, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp3], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp4]);
    goto anon9;

  anon35_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    assume $this != null;
    $tmp6 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
    $tmp7 := req;
    assume $tmp7 != null;
    $tmp8 := req;
    assume $tmp8 != null;
    call $tmp9 := OAuth20NameSpace.AuthorizationCodeRecs.findISSByClientIDAndCode$System.String$System.String($tmp6, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp7], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp8]);
    goto anon9;

  anon9:
    local_2_Ref := (if $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp5 else $tmp9);
    goto anon36_Then, anon36_Else;

  anon36_Then:
    assume {:partition} local_2_Ref == null;
    assume {:breadcrumb 46} true;
    local_4_Ref := null;
    goto IL_0118;

  anon36_Else:
    assume {:partition} local_2_Ref != null;
    assume {:breadcrumb 47} true;
    assume $this != null;
    goto anon37_Then, anon37_Else;

  anon37_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    assume $this != null;
    $tmp10 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
    $tmp11 := req;
    assume $tmp11 != null;
    call $tmp12 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$System.String$System.String($tmp10, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp11]);
    goto anon16;

  anon37_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) != T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    assume $this != null;
    goto anon38_Then, anon38_Else;

  anon38_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    assume $this != null;
    $tmp13 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
    $tmp14 := req;
    assume $tmp14 != null;
    call $tmp15 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($tmp13, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp14]);
    goto anon16;

  anon38_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    assume $this != null;
    $tmp16 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
    $tmp17 := req;
    assume $tmp17 != null;
    call $tmp18 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp16, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp17]);
    goto anon16;

  anon16:
    local_3_Ref := (if $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp12 else (if $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp15 else $tmp18));
    $tmp19 := local_3_Ref;
    assume $tmp19 != null;
    $tmp20 := req;
    assume $tmp20 != null;
    call $tmp21 := System.String.op_Inequality$System.String$System.String(F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp19], F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[$tmp20]);
    goto anon39_Then, anon39_Else;

  anon39_Then:
    assume {:partition} $tmp21;
    assume {:breadcrumb 48} true;
    local_4_Ref := null;
    goto IL_0118;

  anon39_Else:
    assume {:partition} !$tmp21;
    assume {:breadcrumb 49} true;
    goto anon40_Then, anon40_Else;

  anon40_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    $tmp22 := local_3_Ref;
    assume $tmp22 != null;
    $tmp23 := local_3_Ref;
    assume $tmp23 != null;
    $tmp24 := local_3_Ref;
    assume $tmp24 != null;
    call $tmp25 := LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp22], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp23], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp24]);
    goto anon23;

  anon40_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon41_Then, anon41_Else;

  anon41_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    $tmp26 := local_3_Ref;
    assume $tmp26 != null;
    $tmp27 := local_3_Ref;
    assume $tmp27 != null;
    $tmp28 := local_3_Ref;
    assume $tmp28 != null;
    call $tmp29 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp26], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp27], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp28]);
    goto anon23;

  anon41_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    $tmp30 := local_3_Ref;
    assume $tmp30 != null;
    $tmp31 := local_3_Ref;
    assume $tmp31 != null;
    $tmp32 := local_3_Ref;
    assume $tmp32 != null;
    call $tmp33 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp30], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp31], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp32]);
    goto anon23;

  anon23:
    local_0_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp25 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp29 else $tmp33));
    call $tmp44 := OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this);
    goto anon42_Then, anon42_Else;

  anon42_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp34 := OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this);
    $tmp35 := req;
    assume $tmp35 != null;
    call $tmp36 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp34, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp35], local_0_Ref);
    goto anon28;

  anon42_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp44)) != T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp43 := OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this);
    goto anon43_Then, anon43_Else;

  anon43_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp43)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    call $tmp37 := OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this);
    $tmp38 := req;
    assume $tmp38 != null;
    call $tmp39 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp37, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp38], local_0_Ref);
    goto anon28;

  anon43_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp43)) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    call $tmp40 := OpenIDConnectNameSpace.OpenIDProvider.get_IDTokenAndAccessTokenRecs($this);
    $tmp41 := req;
    assume $tmp41 != null;
    call $tmp42 := GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp40, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp41], local_0_Ref);
    goto anon28;

  anon28:
    goto anon44_Then, anon44_Else;

  anon44_Then:
    assume {:partition} !(if $TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp36 else (if $TypeConstructor($DynamicType($tmp43)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp39 else $tmp42));
    assume {:breadcrumb 50} true;
    local_4_Ref := null;
    goto IL_0118;

  anon44_Else:
    assume {:partition} (if $TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp36 else (if $TypeConstructor($DynamicType($tmp43)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp39 else $tmp42));
    assume {:breadcrumb 51} true;
    call $tmp45 := Alloc();
    call OpenIDConnectNameSpace.TokenResponse.#ctor($tmp45);
    assume $DynamicType($tmp45) == T$OpenIDConnectNameSpace.TokenResponse();
    assume $TypeConstructor($DynamicType($tmp45)) == T$OpenIDConnectNameSpace.TokenResponse;
    local_1_prime_Ref := $tmp45;
    $tmp46 := local_0_Ref;
    assume $tmp46 != null;
    F$OAuth20NameSpace.AccessTokenResponse.access_token[local_1_prime_Ref] := F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp46];
    $tmp47 := local_0_Ref;
    assume $tmp47 != null;
    F$OAuth20NameSpace.AccessTokenResponse.refresh_token[local_1_prime_Ref] := F$OAuth20NameSpace.AccessTokenEntry.refresh_token[$tmp47];
    $tmp48 := local_0_Ref;
    assume $tmp48 != null;
    F$OAuth20NameSpace.AccessTokenResponse.scope[local_1_prime_Ref] := F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp48];
    $tmp49 := local_0_Ref;
    assume $tmp49 != null;
    F$OpenIDConnectNameSpace.TokenResponse.id_token[local_1_prime_Ref] := F$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.id_token[$tmp49];
    local_4_Ref := local_1_prime_Ref;
    goto IL_0118;

  anon33_Else:
    assume {:partition} local_6_Ref == null;
    assume {:breadcrumb 43} true;
    goto IL_0113;

  IL_0113:
    local_4_Ref := null;
    goto IL_0118;

  IL_0118:
    $result := local_4_Ref;
    return;
}



procedure {:extern} OAuth20NameSpace.AuthorizationServer.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.OpenIDProvider.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 52} true;
    call OAuth20NameSpace.AuthorizationServer.#ctor($this);
    return;
}



procedure T$OpenIDConnectNameSpace.OpenIDProvider.#cctor();



implementation T$OpenIDConnectNameSpace.OpenIDProvider.#cctor()
{

  anon0:
    return;
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
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 53} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonDataStrcuture.$AccessToken$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.set_AccessToken$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.set_AccessToken$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 54} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$AccessToken$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_AuthenticationToken($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_AuthenticationToken($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 55} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonDataStrcuture.$AuthenticationToken$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.set_AuthenticationToken$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.set_AuthenticationToken$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 56} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$AuthenticationToken$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_RefreshToken($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_RefreshToken($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 57} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonDataStrcuture.$RefreshToken$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.set_RefreshToken$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.set_RefreshToken$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 58} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$RefreshToken$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_ExpiresIn($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_ExpiresIn($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 59} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonDataStrcuture.$ExpiresIn$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.set_ExpiresIn$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.set_ExpiresIn$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 60} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$ExpiresIn$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.get_Scope($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.get_Scope($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 61} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonDataStrcuture.$Scope$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonDataStrcuture.set_Scope$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.set_Scope$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 62} true;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$Scope$k__BackingField[$this] := value;
    return;
}



procedure OpenIDConnectNameSpace.JsonDataStrcuture.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.JsonDataStrcuture.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$AccessToken$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$AuthenticationToken$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$RefreshToken$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$ExpiresIn$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonDataStrcuture.$Scope$k__BackingField[$this] := null;
    assume {:breadcrumb 63} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$OpenIDConnectNameSpace.JsonDataStrcuture.#cctor();



implementation T$OpenIDConnectNameSpace.JsonDataStrcuture.#cctor()
{

  anon0:
    return;
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
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 64} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.$Claims$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.set_Claims$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.set_Claims$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 65} true;
    F$OpenIDConnectNameSpace.JsonWebToken.$Claims$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 66} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.$Envelope$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.set_Envelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.set_Envelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 67} true;
    F$OpenIDConnectNameSpace.JsonWebToken.$Envelope$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.get_Signature($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.get_Signature($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 68} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.$Signature$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.set_Signature$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.set_Signature$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 69} true;
    F$OpenIDConnectNameSpace.JsonWebToken.$Signature$k__BackingField[$this] := value;
    return;
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
  var local_0_bool: bool;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 70} true;
    call $tmp0 := OpenIDConnectNameSpace.JsonWebToken.get_Claims($this);
    call $tmp1 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Expiration($tmp0);
    call $tmp2 := System.DateTime.#copy_ctor($tmp1);
    call $tmp3 := System.DateTime.get_Now();
    call $tmp4 := System.DateTime.#copy_ctor($tmp3);
    call $tmp5 := System.DateTime.op_LessThan$System.DateTime$System.DateTime($tmp2, $tmp4);
    local_0_bool := $tmp5;
    goto IL_0019;

  IL_0019:
    $result := local_0_bool;
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
  var local_0_Ref: Ref;
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

  anon0:
    token := token$in;
    keyIdsKeys := keyIdsKeys$in;
    F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Claims$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Envelope$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Signature$k__BackingField[$this] := null;
    assume {:breadcrumb 71} true;
    call System.Object.#ctor($this);
    call $tmp0 := OpenIDConnectNameSpace.JsonWebToken.SplitToken$System.String($this, token);
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} $Exception != null;
    return;

  anon13_Else:
    assume {:partition} $Exception == null;
    goto anon2;

  anon2:
    local_0_Ref := $tmp0;
    assume local_0_Ref != null;
    F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this] := $ArrayContents[local_0_Ref][1];
    assume $this != null;
    call $tmp1 := OpenIDConnectNameSpace.JsonWebToken.GetClaimsFromTokenSegment$System.String($this, F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this]);
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} $Exception != null;
    return;

  anon14_Else:
    assume {:partition} $Exception == null;
    goto anon4;

  anon4:
    call OpenIDConnectNameSpace.JsonWebToken.set_Claims$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims($this, $tmp1);
    assume local_0_Ref != null;
    F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this] := $ArrayContents[local_0_Ref][0];
    assume $this != null;
    call $tmp2 := OpenIDConnectNameSpace.JsonWebToken.GetEnvelopeFromTokenSegment$System.String($this, F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this]);
    goto anon15_Then, anon15_Else;

  anon15_Then:
    assume {:partition} $Exception != null;
    return;

  anon15_Else:
    assume {:partition} $Exception == null;
    goto anon6;

  anon6:
    call OpenIDConnectNameSpace.JsonWebToken.set_Envelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this, $tmp2);
    assume local_0_Ref != null;
    call OpenIDConnectNameSpace.JsonWebToken.set_Signature$System.String($this, $ArrayContents[local_0_Ref][2]);
    call $tmp3 := OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this);
    call $tmp4 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_KeyId($tmp3);
    assume Union2Int(Int2Union($tmp4)) == $tmp4;
    call $tmp5 := System.Collections.Generic.Dictionary`2.ContainsKey$`0(keyIdsKeys, Int2Union($tmp4));
    goto anon16_Then, anon16_Else;

  anon16_Then:
    assume {:partition} !$tmp5;
    assume {:breadcrumb 72} true;
    call $tmp6 := Alloc();
    call $tmp7 := OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this);
    call $tmp8 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_KeyId($tmp7);
    call $tmp9 := $BoxFromInt($tmp8);
    call $tmp10 := System.String.Format$System.String$System.Object($string_literal_Could$not$find$key$with$id$$0$_3, $tmp9);
    call System.Exception.#ctor$System.String($tmp6, $tmp10);
    assume $DynamicType($tmp6) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp6)) == T$System.Exception;
    $Exception := $tmp6;
    return;

  anon16_Else:
    assume {:partition} $tmp5;
    assume {:breadcrumb 73} true;
    goto anon9;

  anon9:
    call $tmp11 := OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this);
    call OpenIDConnectNameSpace.JsonWebToken.ValidateEnvelope$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope($this, $tmp11);
    goto anon17_Then, anon17_Else;

  anon17_Then:
    assume {:partition} $Exception != null;
    return;

  anon17_Else:
    assume {:partition} $Exception == null;
    goto anon11;

  anon11:
    call $tmp12 := OpenIDConnectNameSpace.JsonWebToken.get_Envelope($this);
    call $tmp13 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_KeyId($tmp12);
    assume Union2Int(Int2Union($tmp13)) == $tmp13;
    call $tmp15 := System.Collections.Generic.Dictionary`2.get_Item$`0(keyIdsKeys, Int2Union($tmp13));
    $tmp14 := $tmp15;
    call OpenIDConnectNameSpace.JsonWebToken.ValidateSignature$System.String($this, $tmp14);
    goto anon18_Then, anon18_Else;

  anon18_Then:
    assume {:partition} $Exception != null;
    return;

  anon18_Else:
    assume {:partition} $Exception == null;
    return;
}



procedure OpenIDConnectNameSpace.JsonWebToken.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Claims$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Envelope$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.$Signature$k__BackingField[$this] := null;
    assume {:breadcrumb 74} true;
    call System.Object.#ctor($this);
    return;
}



procedure OpenIDConnectNameSpace.JsonWebToken.Base64UrlDecode$System.String($this: Ref, encodedSegment$in: Ref) returns ($result: Ref);



procedure {:extern} System.IO.MemoryStream.#ctor$System.Bytearray($this: Ref, buffer$in: Ref);



function {:extern} T$System.IO.MemoryStream() : Ref;

const {:extern} unique T$System.IO.MemoryStream: int;

axiom $TypeConstructor(T$System.IO.MemoryStream()) == T$System.IO.MemoryStream;

procedure {:extern} System.Runtime.Serialization.XmlObjectSerializer.ReadObject$System.IO.Stream($this: Ref, stream$in: Ref) returns ($result: Ref);



function T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims() : Ref;

const unique T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims: int;

implementation OpenIDConnectNameSpace.JsonWebToken.GetClaimsFromTokenSegment$System.String($this: Ref, claimsTokenSegment$in: Ref) returns ($result: Ref)
{
  var claimsTokenSegment: Ref;
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_2_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    claimsTokenSegment := claimsTokenSegment$in;
    assume {:breadcrumb 75} true;
    call $tmp0 := Alloc();
    call $tmp1 := OpenIDConnectNameSpace.JsonWebToken.Base64UrlDecode$System.String($this, claimsTokenSegment);
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} $Exception != null;
    return;

  anon3_Else:
    assume {:partition} $Exception == null;
    goto anon2;

  anon2:
    call System.IO.MemoryStream.#ctor$System.Bytearray($tmp0, $tmp1);
    assume $DynamicType($tmp0) == T$System.IO.MemoryStream();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.IO.MemoryStream;
    local_1_Ref := $tmp0;
    call $tmp2 := System.Runtime.Serialization.XmlObjectSerializer.ReadObject$System.IO.Stream(F$OpenIDConnectNameSpace.JsonWebToken.ClaimsJsonSerializer, local_1_Ref);
    local_2_Ref := $As($tmp2, T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims());
    $result := local_2_Ref;
    return;
}



function T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope() : Ref;

const unique T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope: int;

implementation OpenIDConnectNameSpace.JsonWebToken.GetEnvelopeFromTokenSegment$System.String($this: Ref, envelopeTokenSegment$in: Ref) returns ($result: Ref)
{
  var envelopeTokenSegment: Ref;
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_2_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    envelopeTokenSegment := envelopeTokenSegment$in;
    assume {:breadcrumb 76} true;
    call $tmp0 := Alloc();
    call $tmp1 := OpenIDConnectNameSpace.JsonWebToken.Base64UrlDecode$System.String($this, envelopeTokenSegment);
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} $Exception != null;
    return;

  anon3_Else:
    assume {:partition} $Exception == null;
    goto anon2;

  anon2:
    call System.IO.MemoryStream.#ctor$System.Bytearray($tmp0, $tmp1);
    assume $DynamicType($tmp0) == T$System.IO.MemoryStream();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.IO.MemoryStream;
    local_1_Ref := $tmp0;
    call $tmp2 := System.Runtime.Serialization.XmlObjectSerializer.ReadObject$System.IO.Stream(F$OpenIDConnectNameSpace.JsonWebToken.EnvelopeJsonSerializer, local_1_Ref);
    local_2_Ref := $As($tmp2, T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope());
    $result := local_2_Ref;
    return;
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
  var local_0_Ref: Ref;
  var $tmp4: Ref;
  var $tmp5: bool;
  var $tmp6: Ref;
  var $tmp7: bool;
  var $tmp8: Ref;
  var $tmp9: bool;
  var $tmp10: Ref;
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    token := token$in;
    assume {:breadcrumb 77} true;
    call $tmp0 := System.String.IsNullOrEmpty$System.String(token);
    goto anon16_Then, anon16_Else;

  anon16_Then:
    assume {:partition} $tmp0;
    assume {:breadcrumb 78} true;
    call $tmp1 := Alloc();
    call System.Exception.#ctor$System.String($tmp1, $string_literal_Token$is$empty$or$null._4);
    assume $DynamicType($tmp1) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Exception;
    $Exception := $tmp1;
    return;

  anon16_Else:
    assume {:partition} !$tmp0;
    assume {:breadcrumb 79} true;
    goto anon3;

  anon3:
    call $tmp2 := Alloc();
    assume $ArrayLength($tmp2) == 1 * 1;
    call $tmp3 := System.String.Split$System.Chararray(token, $tmp2);
    local_0_Ref := $tmp3;
    goto anon17_Then, anon17_Else;

  anon17_Then:
    assume {:partition} $ArrayLength(local_0_Ref) != 3;
    assume {:breadcrumb 80} true;
    call $tmp4 := Alloc();
    call System.Exception.#ctor$System.String($tmp4, $string_literal_Invalid$token$format.$Expected$Envelope.Claims.Signature_5);
    assume $DynamicType($tmp4) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp4)) == T$System.Exception;
    $Exception := $tmp4;
    return;

  anon17_Else:
    assume {:partition} $ArrayLength(local_0_Ref) == 3;
    assume {:breadcrumb 81} true;
    goto anon6;

  anon6:
    assume local_0_Ref != null;
    call $tmp5 := System.String.IsNullOrEmpty$System.String($ArrayContents[local_0_Ref][0]);
    goto anon18_Then, anon18_Else;

  anon18_Then:
    assume {:partition} $tmp5;
    assume {:breadcrumb 82} true;
    call $tmp6 := Alloc();
    call System.Exception.#ctor$System.String($tmp6, $string_literal_Invalid$token$format.$Envelope$must$not$be$empty_6);
    assume $DynamicType($tmp6) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp6)) == T$System.Exception;
    $Exception := $tmp6;
    return;

  anon18_Else:
    assume {:partition} !$tmp5;
    assume {:breadcrumb 83} true;
    goto anon9;

  anon9:
    assume local_0_Ref != null;
    call $tmp7 := System.String.IsNullOrEmpty$System.String($ArrayContents[local_0_Ref][1]);
    goto anon19_Then, anon19_Else;

  anon19_Then:
    assume {:partition} $tmp7;
    assume {:breadcrumb 84} true;
    call $tmp8 := Alloc();
    call System.Exception.#ctor$System.String($tmp8, $string_literal_Invalid$token$format.$Claims$must$not$be$empty_7);
    assume $DynamicType($tmp8) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp8)) == T$System.Exception;
    $Exception := $tmp8;
    return;

  anon19_Else:
    assume {:partition} !$tmp7;
    assume {:breadcrumb 85} true;
    goto anon12;

  anon12:
    assume local_0_Ref != null;
    call $tmp9 := System.String.IsNullOrEmpty$System.String($ArrayContents[local_0_Ref][2]);
    goto anon20_Then, anon20_Else;

  anon20_Then:
    assume {:partition} $tmp9;
    assume {:breadcrumb 86} true;
    call $tmp10 := Alloc();
    call System.Exception.#ctor$System.String($tmp10, $string_literal_Invalid$token$format.$Signature$must$not$be$empty_8);
    assume $DynamicType($tmp10) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp10)) == T$System.Exception;
    $Exception := $tmp10;
    return;

  anon20_Else:
    assume {:partition} !$tmp9;
    assume {:breadcrumb 87} true;
    goto anon15;

  anon15:
    local_1_Ref := local_0_Ref;
    goto IL_0099;

  IL_0099:
    $result := local_1_Ref;
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

  anon0:
    envelope := envelope$in;
    assume {:breadcrumb 88} true;
    call $tmp0 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Type(envelope);
    call $tmp1 := System.String.op_Inequality$System.String$System.String($tmp0, $string_literal_JWT_9);
    goto anon6_Then, anon6_Else;

  anon6_Then:
    assume {:partition} $tmp1;
    assume {:breadcrumb 89} true;
    call $tmp2 := Alloc();
    call System.Exception.#ctor$System.String($tmp2, $string_literal_Unsupported$token$type_10);
    assume $DynamicType($tmp2) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp2)) == T$System.Exception;
    $Exception := $tmp2;
    return;

  anon6_Else:
    assume {:partition} !$tmp1;
    assume {:breadcrumb 90} true;
    goto anon3;

  anon3:
    call $tmp3 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Algorithm(envelope);
    call $tmp4 := System.String.op_Inequality$System.String$System.String($tmp3, $string_literal_HS256_11);
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} $tmp4;
    assume {:breadcrumb 91} true;
    call $tmp5 := Alloc();
    call System.Exception.#ctor$System.String($tmp5, $string_literal_Unsupported$crypto$algorithm_12);
    assume $DynamicType($tmp5) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp5)) == T$System.Exception;
    $Exception := $tmp5;
    return;

  anon7_Else:
    assume {:partition} !$tmp4;
    assume {:breadcrumb 92} true;
    return;
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
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_2_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_3_Ref: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: bool;
  var $tmp10: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    key := key$in;
    assume {:breadcrumb 93} true;
    call $tmp0 := System.String.Concat$System.String$System.String(key, $string_literal_JWTSig_13);
    call $tmp1 := System.Text.Encoding.GetBytes$System.String(F$OpenIDConnectNameSpace.JsonWebToken.UTF8Encoder, $tmp0);
    call $tmp2 := System.Security.Cryptography.HashAlgorithm.ComputeHash$System.Bytearray(F$OpenIDConnectNameSpace.JsonWebToken.SHA256Provider, $tmp1);
    local_1_Ref := $tmp2;
    assume $this != null;
    assume $this != null;
    call $tmp3 := System.String.Concat$System.String$System.String$System.String(F$OpenIDConnectNameSpace.JsonWebToken.envelopeTokenSegment[$this], $string_literal_._14, F$OpenIDConnectNameSpace.JsonWebToken.claimsTokenSegment[$this]);
    call $tmp4 := System.Text.Encoding.GetBytes$System.String(F$OpenIDConnectNameSpace.JsonWebToken.UTF8Encoder, $tmp3);
    local_2_Ref := $tmp4;
    call $tmp5 := Alloc();
    call System.Security.Cryptography.HMACSHA256.#ctor$System.Bytearray($tmp5, local_1_Ref);
    assume $DynamicType($tmp5) == T$System.Security.Cryptography.HMACSHA256();
    assume $TypeConstructor($DynamicType($tmp5)) == T$System.Security.Cryptography.HMACSHA256;
    local_3_Ref := $tmp5;
    call $tmp6 := System.Security.Cryptography.HashAlgorithm.ComputeHash$System.Bytearray(local_3_Ref, local_2_Ref);
    call $tmp7 := OpenIDConnectNameSpace.JsonWebToken.Base64UrlEncode$System.Bytearray($this, $tmp6);
    call $tmp8 := OpenIDConnectNameSpace.JsonWebToken.get_Signature($this);
    call $tmp9 := System.String.op_Inequality$System.String$System.String($tmp7, $tmp8);
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} $tmp9;
    assume {:breadcrumb 94} true;
    call $tmp10 := Alloc();
    call System.Exception.#ctor$System.String($tmp10, $string_literal_Signature$does$not$match._15);
    assume $DynamicType($tmp10) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp10)) == T$System.Exception;
    $Exception := $tmp10;
    return;

  anon3_Else:
    assume {:partition} !$tmp9;
    assume {:breadcrumb 95} true;
    return;
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
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: int;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    encodedSegment := encodedSegment$in;
    assume {:breadcrumb 96} true;
    local_0_Ref := encodedSegment;
    call $tmp0 := System.String.Replace$System.Char$System.Char(local_0_Ref, 45, 43);
    local_0_Ref := $tmp0;
    call $tmp1 := System.String.Replace$System.Char$System.Char(local_0_Ref, 95, 47);
    local_0_Ref := $tmp1;
    call $tmp2 := System.String.get_Length(local_0_Ref);
    goto anon6_Then, anon6_Else;

  anon6_Then:
    assume {:partition} $tmp2 mod 4 == 0;
    goto IL_003a;

  anon6_Else:
    assume {:partition} $tmp2 mod 4 != 0;
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} $tmp2 mod 4 == 1;
    goto IL_0058;

  anon7_Else:
    assume {:partition} $tmp2 mod 4 != 1;
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} $tmp2 mod 4 == 2;
    goto IL_003c;

  anon8_Else:
    assume {:partition} $tmp2 mod 4 != 2;
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} $tmp2 mod 4 == 3;
    goto IL_004a;

  anon9_Else:
    assume {:partition} $tmp2 mod 4 != 3;
    goto anon5;

  anon5:
    goto IL_0058;

  IL_003a:
    goto IL_0063;

  IL_003c:
    call $tmp3 := System.String.Concat$System.String$System.String(local_0_Ref, $string_literal_$$_16);
    local_0_Ref := $tmp3;
    goto IL_0063;

  IL_004a:
    call $tmp4 := System.String.Concat$System.String$System.String(local_0_Ref, $string_literal_$_17);
    local_0_Ref := $tmp4;
    goto IL_0063;

  IL_0058:
    call $tmp5 := Alloc();
    call System.Exception.#ctor$System.String($tmp5, $string_literal_Illegal$base64url$string_18);
    assume $DynamicType($tmp5) == T$System.Exception();
    assume $TypeConstructor($DynamicType($tmp5)) == T$System.Exception;
    $Exception := $tmp5;
    return;

  IL_0063:
    call $tmp6 := System.Convert.FromBase64String$System.String(local_0_Ref);
    local_1_Ref := $tmp6;
    goto IL_006c;

  IL_006c:
    $result := local_1_Ref;
    return;
}



procedure {:extern} System.Convert.ToBase64String$System.Bytearray(inArray$in: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.Base64UrlEncode$System.Bytearray($this: Ref, arg$in: Ref) returns ($result: Ref)
{
  var arg: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    arg := arg$in;
    assume {:breadcrumb 97} true;
    call $tmp0 := System.Convert.ToBase64String$System.Bytearray(arg);
    call $tmp1 := Alloc();
    assume $ArrayLength($tmp1) == 1 * 1;
    call $tmp2 := System.String.Split$System.Chararray($tmp0, $tmp1);
    assume $tmp2 != null;
    local_0_Ref := $ArrayContents[$tmp2][0];
    call $tmp3 := System.String.Replace$System.Char$System.Char(local_0_Ref, 43, 45);
    local_0_Ref := $tmp3;
    call $tmp4 := System.String.Replace$System.Char$System.Char(local_0_Ref, 47, 95);
    local_0_Ref := $tmp4;
    local_1_Ref := local_0_Ref;
    goto IL_0038;

  IL_0038:
    $result := local_1_Ref;
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

  anon0:
    F$OpenIDConnectNameSpace.JsonWebToken.ClaimsJsonSerializer := null;
    F$OpenIDConnectNameSpace.JsonWebToken.EnvelopeJsonSerializer := null;
    F$OpenIDConnectNameSpace.JsonWebToken.UTF8Encoder := null;
    F$OpenIDConnectNameSpace.JsonWebToken.SHA256Provider := null;
    assume {:breadcrumb 98} true;
    call $tmp0 := Alloc();
    call System.Runtime.Serialization.Json.DataContractJsonSerializer.#ctor$System.Type($tmp0, T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims());
    assume $DynamicType($tmp0) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer;
    F$OpenIDConnectNameSpace.JsonWebToken.ClaimsJsonSerializer := $tmp0;
    call $tmp1 := Alloc();
    call System.Runtime.Serialization.Json.DataContractJsonSerializer.#ctor$System.Type($tmp1, T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope());
    assume $DynamicType($tmp1) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer();
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer;
    F$OpenIDConnectNameSpace.JsonWebToken.EnvelopeJsonSerializer := $tmp1;
    call $tmp2 := Alloc();
    call System.Text.UTF8Encoding.#ctor$System.Boolean$System.Boolean($tmp2, true, true);
    assume $DynamicType($tmp2) == T$System.Text.UTF8Encoding();
    assume $TypeConstructor($DynamicType($tmp2)) == T$System.Text.UTF8Encoding;
    F$OpenIDConnectNameSpace.JsonWebToken.UTF8Encoder := $tmp2;
    call $tmp3 := Alloc();
    call System.Security.Cryptography.SHA256Managed.#ctor($tmp3);
    assume $DynamicType($tmp3) == T$System.Security.Cryptography.SHA256Managed();
    assume $TypeConstructor($DynamicType($tmp3)) == T$System.Security.Cryptography.SHA256Managed;
    F$OpenIDConnectNameSpace.JsonWebToken.SHA256Provider := $tmp3;
    return;
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
  var local_0_int: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 99} true;
    assume $this != null;
    local_0_int := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$expUnixTime$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_int;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_expUnixTime$System.Int32($this: Ref, value$in: int);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_expUnixTime$System.Int32($this: Ref, value$in: int)
{
  var value: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 100} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$expUnixTime$k__BackingField[$this] := value;
    return;
}



procedure System.DateTime.#default_ctor($this: Ref);



function {:extern} T$System.DateTime() : Ref;

const {:extern} unique T$System.DateTime: int;

axiom $TypeConstructor(T$System.DateTime()) == T$System.DateTime;

procedure {:extern} System.Nullable`1.get_HasValue($this: Ref) returns ($result: bool);



procedure System.Nullable.#copy_ctor(this: Ref) returns (other: Ref);
  free ensures this != other;



procedure {:extern} System.DateTime.#ctor$System.Int32$System.Int32$System.Int32$System.Int32$System.Int32$System.Int32($this: Ref, year$in: int, month$in: int, day$in: int, hour$in: int, minute$in: int, second$in: int);



procedure {:extern} System.DateTime.AddSeconds$System.Double($this: Ref, value$in: Real) returns ($result: Ref);



procedure {:extern} System.Nullable`1.#ctor$`0($this: Ref, value$in: Ref);



function {:extern} T$T$System.Nullable`1(parent: Ref) : Ref;

function {:extern} T$System.Nullable`1(T: Ref) : Ref;

const {:extern} unique T$System.Nullable`1: int;

procedure {:extern} System.Nullable`1.get_Value($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Expiration($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: int;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 101} true;
    call $tmp0 := Alloc();
    call System.DateTime.#default_ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.DateTime();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.DateTime;
    local_0_Ref := $tmp0;
    assume $this != null;
    $tmp1 := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.expiration[$this];
    call $tmp2 := System.Nullable`1.get_HasValue($tmp1);
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} !$tmp2;
    assume {:breadcrumb 102} true;
    call $tmp3 := Alloc();
    call $tmp4 := Alloc();
    call System.DateTime.#ctor$System.Int32$System.Int32$System.Int32$System.Int32$System.Int32$System.Int32($tmp4, 1970, 1, 1, 0, 0, 0);
    assume $DynamicType($tmp4) == T$System.DateTime();
    assume $TypeConstructor($DynamicType($tmp4)) == T$System.DateTime;
    $tmp5 := $tmp4;
    call $tmp6 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_expUnixTime($this);
    call $tmp7 := System.DateTime.AddSeconds$System.Double($tmp5, Int2Real($tmp6));
    call $tmp8 := System.DateTime.#copy_ctor($tmp7);
    call System.Nullable`1.#ctor$`0($tmp3, $tmp8);
    assume $DynamicType($tmp3) == T$System.Nullable`1(T$System.DateTime());
    assume $TypeConstructor($DynamicType($tmp3)) == T$System.Nullable`1;
    assume T$T$System.Nullable`1($DynamicType($tmp3)) == T$System.DateTime();
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.expiration[$this] := $tmp3;
    goto anon3;

  anon4_Else:
    assume {:partition} $tmp2;
    assume {:breadcrumb 103} true;
    goto anon3;

  anon3:
    assume $this != null;
    $tmp9 := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.expiration[$this];
    call $tmp11 := System.Nullable`1.get_Value($tmp9);
    $tmp10 := $tmp11;
    call local_0_Ref := System.DateTime.#copy_ctor($tmp10);
    goto IL_0049;

  IL_0049:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Issuer($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Issuer($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 104} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Issuer$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Issuer$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Issuer$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 105} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Issuer$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Audience($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Audience($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 106} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Audience$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Audience$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Audience$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 107} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Audience$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_UserId($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_UserId($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 108} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$UserId$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_UserId$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_UserId$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 109} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$UserId$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Version($this: Ref) returns ($result: int);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_Version($this: Ref) returns ($result: int)
{
  var local_0_int: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 110} true;
    assume $this != null;
    local_0_int := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Version$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_int;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Version$System.Int32($this: Ref, value$in: int);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_Version$System.Int32($this: Ref, value$in: int)
{
  var value: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 111} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$Version$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_ClientIdentifier($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_ClientIdentifier($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 112} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$ClientIdentifier$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_ClientIdentifier$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_ClientIdentifier$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 113} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$ClientIdentifier$k__BackingField[$this] := value;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_AppId($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_AppId($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 114} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$AppId$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_AppId$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.set_AppId$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 115} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.$AppId$k__BackingField[$this] := value;
    return;
}



procedure OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#ctor($this: Ref);



procedure System.Nullable$System.DateTime$.#default_ctor($this: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
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
    assume {:breadcrumb 116} true;
    call $tmp1 := Alloc();
    call System.Nullable$System.DateTime$.#default_ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Nullable`1(T$System.DateTime());
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Nullable`1;
    assume T$T$System.Nullable`1($DynamicType($tmp1)) == T$System.DateTime();
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.expiration[$this] := $tmp1;
    call System.Object.#ctor($this);
    return;
}



procedure T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#cctor();



implementation T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.#cctor()
{

  anon0:
    return;
}



var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Type$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Algorithm$k__BackingField: [Ref]Ref;

var F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$KeyId$k__BackingField: [Ref]int;

implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Type($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 117} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Type$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_Type$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_Type$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 118} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Type$k__BackingField[$this] := value;
    return;
}



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_Algorithm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 119} true;
    assume $this != null;
    local_0_Ref := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Algorithm$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_Ref;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_Algorithm$System.String($this: Ref, value$in: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_Algorithm$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 120} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Algorithm$k__BackingField[$this] := value;
    return;
}



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.get_KeyId($this: Ref) returns ($result: int)
{
  var local_0_int: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 121} true;
    assume $this != null;
    local_0_int := F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$KeyId$k__BackingField[$this];
    goto IL_0009;

  IL_0009:
    $result := local_0_int;
    return;
}



procedure {:System.Runtime.CompilerServices.CompilerGenerated} OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_KeyId$System.Int32($this: Ref, value$in: int);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.set_KeyId$System.Int32($this: Ref, value$in: int)
{
  var value: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 122} true;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$KeyId$k__BackingField[$this] := value;
    return;
}



procedure OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Type$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$Algorithm$k__BackingField[$this] := null;
    F$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.$KeyId$k__BackingField[$this] := 0;
    assume {:breadcrumb 123} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#cctor();



implementation T$OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenEnvelope.#cctor()
{

  anon0:
    return;
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
  var local_0_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var local_2_bool: bool;
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    JsonDataStrcuture := JsonDataStrcuture$in;
    clientSecret := clientSecret$in;
    assume {:breadcrumb 124} true;
    call $tmp0 := OpenIDConnectNameSpace.JsonDataStrcuture.get_AccessToken(JsonDataStrcuture);
    F$OAuth20NameSpace.AccessTokenResponse.access_token[$this] := $tmp0;
    call $tmp1 := OpenIDConnectNameSpace.JsonDataStrcuture.get_RefreshToken(JsonDataStrcuture);
    F$OAuth20NameSpace.AccessTokenResponse.refresh_token[$this] := $tmp1;
    call $tmp2 := OpenIDConnectNameSpace.JsonDataStrcuture.get_ExpiresIn(JsonDataStrcuture);
    F$OAuth20NameSpace.AccessTokenResponse.expires_in[$this] := $tmp2;
    call $tmp3 := Alloc();
    call System.Collections.Generic.Dictionary`2.#ctor($tmp3);
    assume $DynamicType($tmp3) == T$System.Collections.Generic.Dictionary`2(T$System.Int32(), T$System.String());
    assume $TypeConstructor($DynamicType($tmp3)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp3)) == T$System.Int32();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp3)) == T$System.String();
    local_0_Ref := $tmp3;
    assume Union2Int(Int2Union(1)) == 1;
    call System.Collections.Generic.Dictionary`2.Add$`0$`1(local_0_Ref, Int2Union(1), clientSecret);
    call $tmp4 := Alloc();
    call $tmp5 := OpenIDConnectNameSpace.JsonDataStrcuture.get_AuthenticationToken(JsonDataStrcuture);
    call OpenIDConnectNameSpace.JsonWebToken.#ctor$System.String$System.Collections.Generic.Dictionary$System.Int32$System.String$($tmp4, $tmp5, local_0_Ref);
    assume $DynamicType($tmp4) == T$OpenIDConnectNameSpace.JsonWebToken();
    assume $TypeConstructor($DynamicType($tmp4)) == T$OpenIDConnectNameSpace.JsonWebToken;
    F$OpenIDConnectNameSpace.TokenResponse.id_token[$this] := $tmp4;
    assume $this != null;
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} F$OpenIDConnectNameSpace.TokenResponse.id_token[$this] != null;
    assume {:breadcrumb 125} true;
    local_2_bool := true;
    goto anon3;

  anon10_Else:
    assume {:partition} F$OpenIDConnectNameSpace.TokenResponse.id_token[$this] == null;
    assume {:breadcrumb 126} true;
    goto anon3;

  anon3:
    local_2_bool := false;
    $label := -1;
    goto finally0;

  catch0:
    $localExc := $Exception;
    $Exception := null;
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} $Subtype($DynamicType($localExc), T$System.Exception());
    local_1_Ref := $localExc;
    local_2_bool := false;
    $label := -1;
    goto finally0;

  anon11_Else:
    assume {:partition} !$Subtype($DynamicType($localExc), T$System.Exception());
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} false;
    return;

  anon12_Else:
    assume {:partition} !false;
    goto anon6;

  anon6:
    $Exception := $localExc;
    $label := -1;
    goto finally0;

  finally0:
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} true;
    goto continuation0;

  anon13_Else:
    assume {:partition} !true;
    goto continuation0;

  continuation0:
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} $Exception != null;
    return;

  anon14_Else:
    assume {:partition} $Exception == null;
    goto anon9;

  anon9:
    $result := local_2_bool;
    return;
}



procedure {:extern} OAuth20NameSpace.AccessTokenResponse.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.TokenResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OpenIDConnectNameSpace.TokenResponse.id_token[$this] := null;
    assume {:breadcrumb 127} true;
    call OAuth20NameSpace.AccessTokenResponse.#ctor($this);
    return;
}



procedure T$OpenIDConnectNameSpace.TokenResponse.#cctor();



implementation T$OpenIDConnectNameSpace.TokenResponse.#cctor()
{

  anon0:
    return;
}



procedure OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_Redir_dest($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_Redir_dest($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 128} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_UserID($this: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_UserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 129} true;
    assume $this != null;
    $tmp0 := F$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.id_token[$this];
    call $tmp1 := OpenIDConnectNameSpace.JsonWebToken.get_Claims($tmp0);
    call $tmp2 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_UserId($tmp1);
    local_0_Ref := $tmp2;
    goto IL_0014;

  IL_0014:
    $result := local_0_Ref;
    return;
}



procedure {:extern} OAuth20NameSpace.AccessTokenEntry.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.id_token[$this] := null;
    assume {:breadcrumb 130} true;
    call OAuth20NameSpace.AccessTokenEntry.#ctor($this);
    return;
}



procedure T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.#cctor();



implementation T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.#cctor()
{

  anon0:
    return;
}



function T$OpenIDConnectNameSpace.TokenRequest() : Ref;

const unique T$OpenIDConnectNameSpace.TokenRequest: int;

procedure OpenIDConnectNameSpace.TokenRequest.#ctor($this: Ref);



procedure {:extern} OAuth20NameSpace.AccessTokenRequest.#ctor($this: Ref);



implementation OpenIDConnectNameSpace.TokenRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 131} true;
    call OAuth20NameSpace.AccessTokenRequest.#ctor($this);
    return;
}



procedure T$OpenIDConnectNameSpace.TokenRequest.#cctor();



implementation T$OpenIDConnectNameSpace.TokenRequest.#cctor()
{

  anon0:
    return;
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

  anon0:
    assume {:breadcrumb 132} true;
    call OAuth20NameSpace.AuthorizationResponse.#ctor($this);
    return;
}



procedure T$OpenIDConnectNameSpace.AuthenticationResponse.#cctor();



implementation T$OpenIDConnectNameSpace.AuthenticationResponse.#cctor()
{

  anon0:
    return;
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

  anon0:
    client_id1 := client_id1$in;
    return_uri1 := return_uri1$in;
    client_secret1 := client_secret1$in;
    TokenEndpointUrl1 := TokenEndpointUrl1$in;
    assume {:breadcrumb 133} true;
    call OAuth20NameSpace.Client.#ctor$System.String$System.String$System.String$System.String($this, client_id1, return_uri1, client_secret1, TokenEndpointUrl1);
    return;
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
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var local_1_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: bool;
  var local_2_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    rawRequest := rawRequest$in;
    assume {:breadcrumb 134} true;
    call $tmp0 := Alloc();
    call OpenIDConnectNameSpace.AuthenticationResponse.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenIDConnectNameSpace.AuthenticationResponse();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenIDConnectNameSpace.AuthenticationResponse;
    local_0_Ref := $tmp0;
    call $tmp1 := System.Web.HttpContext.get_Current();
    local_1_Ref := $tmp1;
    call $tmp2 := System.Web.HttpRequest.get_QueryString(rawRequest);
    call $tmp3 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp2, $string_literal_code_19);
    F$OAuth20NameSpace.AuthorizationResponse.code[local_0_Ref] := $tmp3;
    call $tmp4 := System.Web.HttpRequest.get_QueryString(rawRequest);
    call $tmp5 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp4, $string_literal_state_20);
    F$OAuth20NameSpace.AuthorizationResponse.state[local_0_Ref] := $tmp5;
    $tmp6 := local_0_Ref;
    assume $tmp6 != null;
    call $tmp7 := System.String.IsNullOrEmpty$System.String(F$OAuth20NameSpace.AuthorizationResponse.code[$tmp6]);
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} $tmp7;
    assume {:breadcrumb 135} true;
    local_2_Ref := null;
    goto IL_0053;

  anon3_Else:
    assume {:partition} !$tmp7;
    assume {:breadcrumb 136} true;
    local_2_Ref := local_0_Ref;
    goto IL_0053;

  IL_0053:
    $result := local_2_Ref;
    return;
}



procedure OpenIDConnectNameSpace.RelyingParty.AuthenticationUsingAuthorizationCodeFlow$OpenIDConnectNameSpace.AuthenticationResponse($this: Ref, codeResp$in: Ref) returns ($result: Ref);



procedure OpenIDConnectNameSpace.RelyingParty.callTokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this: Ref, req$in: Ref) returns ($result: Ref);



implementation OpenIDConnectNameSpace.RelyingParty.AuthenticationUsingAuthorizationCodeFlow$OpenIDConnectNameSpace.AuthenticationResponse($this: Ref, codeResp$in: Ref) returns ($result: Ref)
{
  var codeResp: Ref;
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var local_2_Ref: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    codeResp := codeResp$in;
    assume {:breadcrumb 137} true;
    call $tmp0 := OpenIDConnectNameSpace.RelyingParty.constructTokenRequest$OpenIDConnectNameSpace.AuthenticationResponse($this, codeResp);
    call $tmp1 := OpenIDConnectNameSpace.RelyingParty.callTokenEndpoint$OpenIDConnectNameSpace.TokenRequest($this, $tmp0);
    local_1_Ref := $tmp1;
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} local_1_Ref == null;
    assume {:breadcrumb 138} true;
    local_2_Ref := null;
    goto IL_002a;

  anon3_Else:
    assume {:partition} local_1_Ref != null;
    assume {:breadcrumb 139} true;
    call $tmp2 := OpenIDConnectNameSpace.RelyingParty.conclude$OpenIDConnectNameSpace.TokenResponse($this, local_1_Ref);
    local_2_Ref := $tmp2;
    goto IL_002a;

  IL_002a:
    $result := local_2_Ref;
    return;
}



procedure {:extern} OAuth20NameSpace.Client.get_return_uri($this: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.Client.get_client_id($this: Ref) returns ($result: Ref);



var {:extern} F$CST.CST_Struct.SymT: [Ref]Ref;

procedure {:extern} CST.CST_Ops.recordme$CST.CST_Struct(msg$in: Ref);



implementation OpenIDConnectNameSpace.RelyingParty.constructTokenRequest$OpenIDConnectNameSpace.AuthenticationResponse($this: Ref, codeResp$in: Ref) returns ($result: Ref)
{
  var codeResp: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    codeResp := codeResp$in;
    assume {:breadcrumb 140} true;
    call $tmp0 := Alloc();
    call OpenIDConnectNameSpace.TokenRequest.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenIDConnectNameSpace.TokenRequest();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenIDConnectNameSpace.TokenRequest;
    local_0_Ref := $tmp0;
    $tmp1 := codeResp;
    assume $tmp1 != null;
    F$OAuth20NameSpace.AccessTokenRequest.code[local_0_Ref] := F$OAuth20NameSpace.AuthorizationResponse.code[$tmp1];
    F$OAuth20NameSpace.AccessTokenRequest.grant_type[local_0_Ref] := $string_literal_authorization_code_2;
    call $tmp2 := OAuth20NameSpace.Client.get_return_uri($this);
    F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[local_0_Ref] := $tmp2;
    call $tmp3 := OAuth20NameSpace.Client.get_client_id($this);
    F$OAuth20NameSpace.AccessTokenRequest.client_id[local_0_Ref] := $tmp3;
    $tmp4 := codeResp;
    assume $tmp4 != null;
    F$CST.CST_Struct.SymT[local_0_Ref] := F$CST.CST_Struct.SymT[$tmp4];
    call CST.CST_Ops.recordme$CST.CST_Struct(local_0_Ref);
    local_1_Ref := local_0_Ref;
    goto IL_004d;

  IL_004d:
    $result := local_1_Ref;
    return;
}



var {:extern} F$OAuth20NameSpace.Client.TokenEndpointUrl: [Ref]Ref;

const {:value "client_id={0}&redirect_uri={1}&client_secret={2}&code={3}&grant_type=authorization_code"} unique $string_literal_client_id$$0$$redirect_uri$$1$$client_secret$$2$$code$$3$$grant_type$authorization_code_21: Ref;

procedure {:extern} System.String.Format$System.String$System.Objectarray(format$in: Ref, args$in: Ref) returns ($result: Ref);



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
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var local_2_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var local_4_Ref: Ref;
  var $tmp8: bool;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var local_5_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    req := req$in;
    assume {:breadcrumb 141} true;
    call $tmp0 := Alloc();
    call OpenIDConnectNameSpace.JsonDataStrcuture.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenIDConnectNameSpace.JsonDataStrcuture();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenIDConnectNameSpace.JsonDataStrcuture;
    local_0_Ref := $tmp0;
    assume $this != null;
    call $tmp1 := Alloc();
    assume $ArrayLength($tmp1) == 1 * 5;
    call $tmp2 := System.String.Format$System.String$System.Objectarray($string_literal_client_id$$0$$redirect_uri$$1$$client_secret$$2$$code$$3$$grant_type$authorization_code_21, $tmp1);
    call $tmp3 := HTTP.HTTPComm.HttpReq$System.String$System.String$System.String(F$OAuth20NameSpace.Client.TokenEndpointUrl[$this], $tmp2, $string_literal_POST_22);
    local_2_Ref := $tmp3;
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} local_2_Ref != null;
    assume {:breadcrumb 142} true;
    call $tmp4 := Alloc();
    call System.Runtime.Serialization.Json.DataContractJsonSerializer.#ctor$System.Type($tmp4, T$OpenIDConnectNameSpace.JsonDataStrcuture());
    assume $DynamicType($tmp4) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer();
    assume $TypeConstructor($DynamicType($tmp4)) == T$System.Runtime.Serialization.Json.DataContractJsonSerializer;
    call $tmp5 := System.Net.WebResponse.GetResponseStream(local_2_Ref);
    call $tmp6 := System.Runtime.Serialization.XmlObjectSerializer.ReadObject$System.IO.Stream($tmp4, $tmp5);
    local_0_Ref := $As($tmp6, T$OpenIDConnectNameSpace.JsonDataStrcuture());
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} local_0_Ref != null;
    assume {:breadcrumb 144} true;
    call $tmp7 := Alloc();
    call OpenIDConnectNameSpace.TokenResponse.#ctor($tmp7);
    assume $DynamicType($tmp7) == T$OpenIDConnectNameSpace.TokenResponse();
    assume $TypeConstructor($DynamicType($tmp7)) == T$OpenIDConnectNameSpace.TokenResponse;
    local_4_Ref := $tmp7;
    assume $this != null;
    call $tmp8 := OpenIDConnectNameSpace.TokenResponse.parseJasonDataStructure$OpenIDConnectNameSpace.JsonDataStrcuture$System.String(local_4_Ref, local_0_Ref, F$OAuth20NameSpace.Client.client_secret[$this]);
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} $tmp8;
    assume {:breadcrumb 146} true;
    $tmp9 := req;
    assume $tmp9 != null;
    F$CST.CST_Struct.SymT[local_4_Ref] := F$CST.CST_Struct.SymT[$tmp9];
    $tmp10 := T$OpenIDConnectNameSpace.OpenIDProvider();
    call $tmp11 := System.Type.GetMethod$System.String($tmp10, $string_literal_TokenEndpoint_23);
    call CST.CST_Ops.recordme$CST.CST_Struct$System.Reflection.MethodInfo(local_4_Ref, $tmp11);
    local_5_Ref := local_4_Ref;
    goto IL_010d;

  anon11_Else:
    assume {:partition} !$tmp8;
    assume {:breadcrumb 147} true;
    goto anon5;

  anon5:
    local_5_Ref := null;
    goto IL_010d;

  anon10_Else:
    assume {:partition} local_0_Ref == null;
    assume {:breadcrumb 145} true;
    goto anon8;

  anon9_Else:
    assume {:partition} local_2_Ref == null;
    assume {:breadcrumb 143} true;
    goto anon8;

  anon8:
    local_5_Ref := null;
    goto IL_010d;

  IL_010d:
    $result := local_5_Ref;
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
  var local_0_Ref: Ref;
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
  var local_1_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    tokenResp := tokenResp$in;
    assume {:breadcrumb 148} true;
    call $tmp0 := Alloc();
    call GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$GenericAuthNameSpace.RP.AuthenticationConclusion();
    assume $TypeConstructor($DynamicType($tmp0)) == T$GenericAuthNameSpace.RP.AuthenticationConclusion;
    local_0_Ref := $tmp0;
    $tmp1 := tokenResp;
    assume $tmp1 != null;
    $tmp2 := F$OpenIDConnectNameSpace.TokenResponse.id_token[$tmp1];
    call $tmp3 := OpenIDConnectNameSpace.JsonWebToken.get_Claims($tmp2);
    call $tmp4 := OpenIDConnectNameSpace.JsonWebToken.JsonWebTokenClaims.get_UserId($tmp3);
    F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[local_0_Ref] := $tmp4;
    $tmp5 := tokenResp;
    assume $tmp5 != null;
    F$CST.CST_Struct.SymT[local_0_Ref] := F$CST.CST_Struct.SymT[$tmp5];
    call CST.CST_Ops.recordme$CST.CST_Struct(local_0_Ref);
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP_For_vProgram;
    call $tmp6 := LiveIDNameSpace.LiveID_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_0_Ref);
    goto anon9;

  anon12_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_RP_For_vProgram;
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP;
    call $tmp7 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_0_Ref);
    goto anon9;

  anon13_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_RP;
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.RelyingParty;
    call $tmp8 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_0_Ref);
    goto anon9;

  anon14_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.RelyingParty;
    goto anon15_Then, anon15_Else;

  anon15_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.Client;
    call $tmp9 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_0_Ref);
    goto anon9;

  anon15_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OAuth20NameSpace.Client;
    call $tmp10 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, local_0_Ref);
    goto anon9;

  anon9:
    goto anon16_Then, anon16_Else;

  anon16_Then:
    assume {:partition} (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP_For_vProgram then $tmp6 else (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP then $tmp7 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.RelyingParty then $tmp8 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.Client then $tmp9 else $tmp10))));
    assume {:breadcrumb 149} true;
    local_1_Ref := local_0_Ref;
    goto IL_0046;

  anon16_Else:
    assume {:partition} !(if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP_For_vProgram then $tmp6 else (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_RP then $tmp7 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.RelyingParty then $tmp8 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.Client then $tmp9 else $tmp10))));
    assume {:breadcrumb 150} true;
    local_1_Ref := null;
    goto IL_0046;

  IL_0046:
    $result := local_1_Ref;
    return;
}



procedure T$OpenIDConnectNameSpace.RelyingParty.#cctor();



implementation T$OpenIDConnectNameSpace.RelyingParty.#cctor()
{

  anon0:
    return;
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

  anon0:
    assume {:breadcrumb 151} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.ID_Claim.#cctor();



implementation T$GenericAuthNameSpace.ID_Claim.#cctor()
{

  anon0:
    return;
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
  var local_1_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var local_0_Ref: Ref;
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

  anon0:
    req := req$in;
    assume {:breadcrumb 152} true;
    goto anon67_Then, anon67_Else;

  anon67_Then:
    assume {:partition} req == null;
    assume {:breadcrumb 153} true;
    local_1_Ref := null;
    goto IL_0048;

  anon67_Else:
    assume {:partition} req != null;
    assume {:breadcrumb 154} true;
    goto anon68_Then, anon68_Else;

  anon68_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    call $tmp0 := OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
    goto anon9;

  anon68_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon69_Then, anon69_Else;

  anon69_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    call $tmp1 := OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
    goto anon9;

  anon69_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    goto anon70_Then, anon70_Else;

  anon70_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer;
    call $tmp2 := OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
    goto anon9;

  anon70_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OAuth20NameSpace.AuthorizationServer;
    call $tmp3 := GenericAuthNameSpace.IdP.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
    goto anon9;

  anon9:
    local_0_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp0 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp1 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer then $tmp2 else $tmp3)));
    assume $this != null;
    goto anon71_Then, anon71_Else;

  anon71_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    assume $this != null;
    $tmp4 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this];
    $tmp5 := req;
    assume $tmp5 != null;
    goto anon72_Then, anon72_Else;

  anon72_Then:
    assume {:partition} $TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest;
    call $tmp6 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
    goto anon15;

  anon72_Else:
    assume {:partition} $TypeConstructor($DynamicType(req)) != T$OpenIDConnectNameSpace.AuthenticationRequest;
    goto anon73_Then, anon73_Else;

  anon73_Then:
    assume {:partition} $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp7 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
    goto anon15;

  anon73_Else:
    assume {:partition} $TypeConstructor($DynamicType(req)) != T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp8 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(req);
    goto anon15;

  anon15:
    call $tmp9 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp4, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp5], (if $TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp6 else (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp7 else $tmp8)), local_0_Ref);
    goto anon29;

  anon71_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this])) != T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    assume $this != null;
    goto anon74_Then, anon74_Else;

  anon74_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    assume $this != null;
    $tmp10 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this];
    $tmp11 := req;
    assume $tmp11 != null;
    goto anon75_Then, anon75_Else;

  anon75_Then:
    assume {:partition} $TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest;
    call $tmp12 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
    goto anon22;

  anon75_Else:
    assume {:partition} $TypeConstructor($DynamicType(req)) != T$OpenIDConnectNameSpace.AuthenticationRequest;
    goto anon76_Then, anon76_Else;

  anon76_Then:
    assume {:partition} $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp13 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
    goto anon22;

  anon76_Else:
    assume {:partition} $TypeConstructor($DynamicType(req)) != T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp14 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(req);
    goto anon22;

  anon22:
    call $tmp15 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp10, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp11], (if $TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp12 else (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp13 else $tmp14)), local_0_Ref);
    goto anon29;

  anon74_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this])) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    assume $this != null;
    $tmp16 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this];
    $tmp17 := req;
    assume $tmp17 != null;
    goto anon77_Then, anon77_Else;

  anon77_Then:
    assume {:partition} $TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest;
    call $tmp18 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
    goto anon28;

  anon77_Else:
    assume {:partition} $TypeConstructor($DynamicType(req)) != T$OpenIDConnectNameSpace.AuthenticationRequest;
    goto anon78_Then, anon78_Else;

  anon78_Then:
    assume {:partition} $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp19 := OAuth20NameSpace.AuthorizationRequest.get_Realm(req);
    goto anon28;

  anon78_Else:
    assume {:partition} $TypeConstructor($DynamicType(req)) != T$OAuth20NameSpace.AuthorizationRequest;
    call $tmp20 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(req);
    goto anon28;

  anon28:
    call $tmp21 := GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp16, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp17], (if $TypeConstructor($DynamicType(req)) == T$OpenIDConnectNameSpace.AuthenticationRequest then $tmp18 else (if $TypeConstructor($DynamicType(req)) == T$OAuth20NameSpace.AuthorizationRequest then $tmp19 else $tmp20)), local_0_Ref);
    goto anon29;

  anon29:
    goto anon79_Then, anon79_Else;

  anon79_Then:
    assume {:partition} !(if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp9 else (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp15 else $tmp21));
    assume {:breadcrumb 155} true;
    local_1_Ref := null;
    goto IL_0048;

  anon79_Else:
    assume {:partition} (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp9 else (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp15 else $tmp21));
    assume {:breadcrumb 156} true;
    goto anon80_Then, anon80_Else;

  anon80_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    goto anon81_Then, anon81_Else;

  anon81_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp22 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
    goto anon39;

  anon81_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    goto anon82_Then, anon82_Else;

  anon82_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp23 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_Redir_dest(local_0_Ref);
    goto anon39;

  anon82_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon83_Then, anon83_Else;

  anon83_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp24 := OAuth20NameSpace.AccessTokenEntry.get_Redir_dest(local_0_Ref);
    goto anon39;

  anon83_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp25 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
    goto anon39;

  anon39:
    call $tmp26 := OpenIDConnectNameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp22 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp23 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp24 else $tmp25))), local_0_Ref);
    goto anon66;

  anon80_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon84_Then, anon84_Else;

  anon84_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    goto anon85_Then, anon85_Else;

  anon85_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp27 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
    goto anon48;

  anon85_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    goto anon86_Then, anon86_Else;

  anon86_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp28 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_Redir_dest(local_0_Ref);
    goto anon48;

  anon86_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon87_Then, anon87_Else;

  anon87_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp29 := OAuth20NameSpace.AccessTokenEntry.get_Redir_dest(local_0_Ref);
    goto anon48;

  anon87_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp30 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
    goto anon48;

  anon48:
    call $tmp31 := OpenIDConnectNameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp27 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp28 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp29 else $tmp30))), local_0_Ref);
    goto anon66;

  anon84_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    goto anon88_Then, anon88_Else;

  anon88_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer;
    goto anon89_Then, anon89_Else;

  anon89_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp32 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
    goto anon57;

  anon89_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    goto anon90_Then, anon90_Else;

  anon90_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp33 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_Redir_dest(local_0_Ref);
    goto anon57;

  anon90_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon91_Then, anon91_Else;

  anon91_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp34 := OAuth20NameSpace.AccessTokenEntry.get_Redir_dest(local_0_Ref);
    goto anon57;

  anon91_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp35 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
    goto anon57;

  anon57:
    call $tmp36 := GenericAuthNameSpace.IdP.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp32 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp33 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp34 else $tmp35))), local_0_Ref);
    goto anon66;

  anon88_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OAuth20NameSpace.AuthorizationServer;
    goto anon92_Then, anon92_Else;

  anon92_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp37 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
    goto anon65;

  anon92_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    goto anon93_Then, anon93_Else;

  anon93_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp38 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_Redir_dest(local_0_Ref);
    goto anon65;

  anon93_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon94_Then, anon94_Else;

  anon94_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp39 := OAuth20NameSpace.AccessTokenEntry.get_Redir_dest(local_0_Ref);
    goto anon65;

  anon94_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp40 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
    goto anon65;

  anon65:
    call $tmp41 := GenericAuthNameSpace.IdP.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp37 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp38 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp39 else $tmp40))), local_0_Ref);
    goto anon66;

  anon66:
    local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp26 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp31 else (if $TypeConstructor($DynamicType($this)) == T$OAuth20NameSpace.AuthorizationServer then $tmp36 else $tmp41)));
    goto IL_0048;

  IL_0048:
    $result := local_1_Ref;
    return;
}



procedure GenericAuthNameSpace.IdP.#ctor($this: Ref);



implementation GenericAuthNameSpace.IdP.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this] := null;
    assume {:breadcrumb 157} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.IdP.#cctor();



implementation T$GenericAuthNameSpace.IdP.#cctor()
{

  anon0:
    return;
}



function T$GenericAuthNameSpace.SignInIdP_Req() : Ref;

const unique T$GenericAuthNameSpace.SignInIdP_Req: int;

procedure GenericAuthNameSpace.SignInIdP_Req.#ctor($this: Ref);



procedure {:extern} CST.CST_Struct.#ctor($this: Ref);



implementation GenericAuthNameSpace.SignInIdP_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$this] := null;
    assume {:breadcrumb 158} true;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.SignInIdP_Req.#cctor();



implementation T$GenericAuthNameSpace.SignInIdP_Req.#cctor()
{

  anon0:
    return;
}



function T$GenericAuthNameSpace.SignInRP_Resp() : Ref;

const unique T$GenericAuthNameSpace.SignInRP_Resp: int;

procedure GenericAuthNameSpace.SignInRP_Resp.#ctor($this: Ref);



implementation GenericAuthNameSpace.SignInRP_Resp.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 159} true;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.SignInRP_Resp.#cctor();



implementation T$GenericAuthNameSpace.SignInRP_Resp.#cctor()
{

  anon0:
    return;
}



function T$GenericAuthNameSpace.GlobalObjects_base() : Ref;

const unique T$GenericAuthNameSpace.GlobalObjects_base: int;

procedure {:extern} OAuth20NameSpace.AuthorizationCodeEntry.get_UserID($this: Ref) returns ($result: Ref);



procedure {:extern} OAuth20NameSpace.AccessTokenEntry.get_UserID($this: Ref) returns ($result: Ref);



var F$GenericAuthNameSpace.RP.Domain: [Ref]Ref;

implementation GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson$GenericAuthNameSpace.RP.AuthenticationConclusion(conclusion$in: Ref)
{
  var conclusion: Ref;
  var local_0_Ref: Ref;
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

  anon0:
    conclusion := conclusion$in;
    assume {:breadcrumb 160} true;
    $tmp16 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
    assume $tmp16 != null;
    goto anon23_Then, anon23_Else;

  anon23_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp16])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    $tmp0 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
    assume $tmp0 != null;
    $tmp1 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp0];
    $tmp2 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
    assume $tmp2 != null;
    $tmp3 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp3 != null;
    call $tmp4 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$System.String$System.String($tmp1, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp2], F$GenericAuthNameSpace.RP.Realm[$tmp3]);
    goto anon5;

  anon23_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp16])) != T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    $tmp15 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
    assume $tmp15 != null;
    goto anon24_Then, anon24_Else;

  anon24_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp15])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    $tmp5 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
    assume $tmp5 != null;
    $tmp6 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp5];
    $tmp7 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
    assume $tmp7 != null;
    $tmp8 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp8 != null;
    call $tmp9 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($tmp6, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp7], F$GenericAuthNameSpace.RP.Realm[$tmp8]);
    goto anon5;

  anon24_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp15])) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    $tmp10 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
    assume $tmp10 != null;
    $tmp11 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp10];
    $tmp12 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
    assume $tmp12 != null;
    $tmp13 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp13 != null;
    call $tmp14 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp11, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp12], F$GenericAuthNameSpace.RP.Realm[$tmp13]);
    goto anon5;

  anon5:
    local_0_Ref := (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp16])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp4 else (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp15])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp9 else $tmp14));
    goto anon25_Then, anon25_Else;

  anon25_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp23 := OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest(local_0_Ref);
    goto anon12;

  anon25_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    goto anon26_Then, anon26_Else;

  anon26_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp24 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_Redir_dest(local_0_Ref);
    goto anon12;

  anon26_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon27_Then, anon27_Else;

  anon27_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp25 := OAuth20NameSpace.AccessTokenEntry.get_Redir_dest(local_0_Ref);
    goto anon12;

  anon27_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp26 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(local_0_Ref);
    goto anon12;

  anon12:
    $tmp27 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp27 != null;
    call $tmp28 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp23 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp24 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp25 else $tmp26))), F$GenericAuthNameSpace.RP.Domain[$tmp27]);
    goto anon28_Then, anon28_Else;

  anon28_Then:
    assume {:partition} $tmp28;
    goto anon29_Then, anon29_Else;

  anon29_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry;
    call $tmp17 := OAuth20NameSpace.AuthorizationCodeEntry.get_UserID(local_0_Ref);
    goto anon20;

  anon29_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AuthorizationCodeEntry;
    goto anon30_Then, anon30_Else;

  anon30_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    call $tmp18 := OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry.get_UserID(local_0_Ref);
    goto anon20;

  anon30_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry;
    goto anon31_Then, anon31_Else;

  anon31_Then:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp19 := OAuth20NameSpace.AccessTokenEntry.get_UserID(local_0_Ref);
    goto anon20;

  anon31_Else:
    assume {:partition} $TypeConstructor($DynamicType(local_0_Ref)) != T$OAuth20NameSpace.AccessTokenEntry;
    call $tmp20 := GenericAuthNameSpace.ID_Claim.get_UserID(local_0_Ref);
    goto anon20;

  anon20:
    $tmp21 := conclusion;
    assume $tmp21 != null;
    call $tmp22 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AuthorizationCodeEntry then $tmp17 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OpenIDConnectNameSpace.IDTokenAndAccessTokenEntry then $tmp18 else (if $TypeConstructor($DynamicType(local_0_Ref)) == T$OAuth20NameSpace.AccessTokenEntry then $tmp19 else $tmp20))), F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp21]);
    goto anon22;

  anon28_Else:
    assume {:partition} !$tmp28;
    goto anon22;

  anon22:
    assert (if $tmp28 then $tmp22 else false);
    return;
}



implementation GenericAuthNameSpace.GlobalObjects_base.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 161} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.GlobalObjects_base.#cctor();



implementation T$GenericAuthNameSpace.GlobalObjects_base.#cctor()
{

  anon0:
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := null;
    F$GenericAuthNameSpace.GlobalObjects_base.IdP := null;
    F$GenericAuthNameSpace.GlobalObjects_base.RP := null;
    return;
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
  var local_0_bool: bool;
  var $tmp0: bool;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var local_1_bool: bool;
  var $localExc: Ref;
  var $label: int;

  anon0:
    conclusion := conclusion$in;
    assume {:breadcrumb 162} true;
    call $tmp0 := CST.CST_Ops.Certify$CST.CST_Struct(conclusion);
    local_0_bool := $tmp0;
    assume $this != null;
    $tmp1 := F$GenericAuthNameSpace.RP.CurrentSession[$this];
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} local_0_bool;
    $tmp2 := conclusion;
    assume $tmp2 != null;
    goto anon3;

  anon4_Else:
    assume {:partition} !local_0_bool;
    goto anon3;

  anon3:
    call System.Web.SessionState.HttpSessionState.set_Item$System.String$System.Object($tmp1, $string_literal_UserID_24, (if local_0_bool then F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp2] else $string_literal__25));
    local_1_bool := local_0_bool;
    goto IL_002e;

  IL_002e:
    $result := local_1_bool;
    return;
}



procedure GenericAuthNameSpace.RP.#ctor($this: Ref);



implementation GenericAuthNameSpace.RP.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$GenericAuthNameSpace.RP.CurrentSession[$this] := null;
    F$GenericAuthNameSpace.RP.Domain[$this] := null;
    F$GenericAuthNameSpace.RP.Realm[$this] := null;
    assume {:breadcrumb 163} true;
    call System.Object.#ctor($this);
    return;
}



implementation GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$this] := null;
    assume {:breadcrumb 164} true;
    call CST.CST_Struct.#ctor($this);
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



function T$GenericAuthNameSpace.IdPAuthRecords_Base() : Ref;

const unique T$GenericAuthNameSpace.IdPAuthRecords_Base: int;

function T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req() : Ref;

const unique T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req: int;

procedure GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this: Ref);



implementation GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 165} true;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor();



implementation T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor()
{

  anon0:
    return;
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

  anon0:
    client_id := client_id$in;
    return_uri := return_uri$in;
    client_secret := client_secret$in;
    TokenEndpointUrl := TokenEndpointUrl$in;
    assume {:breadcrumb 166} true;
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
    return;
}



const {:value "000000004C108D95"} unique $string_literal_000000004C108D95_26: Ref;

const {:value "http://a.local.host:14022/login.aspx"} unique $string_literal_http$$$a.local.host$14022$login.aspx_27: Ref;

const {:value "zMVS1BpoNHwtdTnSzazSt2JgLd1hxRA1"} unique $string_literal_zMVS1BpoNHwtdTnSzazSt2JgLd1hxRA1_28: Ref;

const {:value "https://login.live.com/oauth20_token.srf"} unique $string_literal_https$$$login.live.com$oauth20_token.srf_29: Ref;

implementation LiveIDNameSpace.LiveID_RP.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 167} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\LiveID\LiveIDNameSpace.cs"} {:sourceLine 31} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\LiveID\LiveIDNameSpace.cs"} {:sourceLine 31} true;
    call LiveIDNameSpace.LiveID_RP.#ctor$System.String$System.String$System.String$System.String($this, $string_literal_000000004C108D95_26, $string_literal_http$$$a.local.host$14022$login.aspx_27, $string_literal_zMVS1BpoNHwtdTnSzazSt2JgLd1hxRA1_28, $string_literal_https$$$login.live.com$oauth20_token.srf_29);
    return;
}



procedure LiveIDNameSpace.LiveID_RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



implementation LiveIDNameSpace.LiveID_RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var codeResp_Ref: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    req := req$in;
    assume {:breadcrumb 168} true;
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

  anon0:
    return;
}



function T$OAuth20NameSpace.AccessTokenRequest() : Ref;

const unique T$OAuth20NameSpace.AccessTokenRequest: int;

var F$OAuth20NameSpace.AccessTokenRequest.refresh_token: [Ref]Ref;

implementation OAuth20NameSpace.AccessTokenRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OAuth20NameSpace.AccessTokenRequest.grant_type[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.code[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.client_id[$this] := null;
    F$OAuth20NameSpace.AccessTokenRequest.refresh_token[$this] := null;
    assume {:breadcrumb 169} true;
    F$OAuth20NameSpace.AccessTokenRequest.refresh_token[$this] := null;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.AccessTokenRequest.#cctor();



implementation T$OAuth20NameSpace.AccessTokenRequest.#cctor()
{

  anon0:
    return;
}



function T$OAuth20NameSpace.AccessTokenRecs() : Ref;

const unique T$OAuth20NameSpace.AccessTokenRecs: int;

procedure OAuth20NameSpace.AccessTokenRecs.findISSByClientIDAndAccessToken$System.String$System.String($this: Ref, client_id$in: Ref, access_token$in: Ref) returns ($result: Ref);



procedure OAuth20NameSpace.AccessTokenRecs.findISSByClientIDAndRefreshToken$System.String$System.String($this: Ref, client_id$in: Ref, refresh_token$in: Ref) returns ($result: Ref);



var F$OAuth20NameSpace.AuthorizationRequest.response_type: [Ref]Ref;

var F$OAuth20NameSpace.AuthorizationRequest.client_id: [Ref]Ref;

implementation OAuth20NameSpace.AuthorizationRequest.get_Realm($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 170} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AuthorizationRequest.client_id[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



implementation OAuth20NameSpace.AuthorizationRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OAuth20NameSpace.AuthorizationRequest.response_type[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.client_id[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.scope[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.state[$this] := null;
    assume {:breadcrumb 171} true;
    F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationRequest.state[$this] := null;
    call GenericAuthNameSpace.SignInIdP_Req.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.AuthorizationRequest.#cctor();



implementation T$OAuth20NameSpace.AuthorizationRequest.#cctor()
{

  anon0:
    return;
}



function T$OAuth20NameSpace.AuthorizationCodeRecs() : Ref;

const unique T$OAuth20NameSpace.AuthorizationCodeRecs: int;

implementation OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 172} true;
    assume $this != null;
    local_0_Ref := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this];
    goto IL_000f;

  IL_000f:
    $result := local_0_Ref;
    return;
}



implementation OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 173} true;
    F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this] := value;
    return;
}



implementation OAuth20NameSpace.AuthorizationServer.init$OAuth20NameSpace.AuthorizationCodeRecs$OAuth20NameSpace.AccessTokenRecs($this: Ref, AuthorizationCodeRecs1$in: Ref, AccessTokenRecs1$in: Ref)
{
  var AuthorizationCodeRecs1: Ref;
  var AccessTokenRecs1: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    AuthorizationCodeRecs1 := AuthorizationCodeRecs1$in;
    AccessTokenRecs1 := AccessTokenRecs1$in;
    assume {:breadcrumb 174} true;
    F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this] := AuthorizationCodeRecs1;
    call OAuth20NameSpace.AuthorizationServer.set_AccessTokenRecs$OAuth20NameSpace.AccessTokenRecs($this, AccessTokenRecs1);
    return;
}



const {:value "token"} unique $string_literal_token_30: Ref;

procedure OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AuthorizationServer.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req1$in: Ref) returns ($result: Ref)
{
  var req1: Ref;
  var local_0_Ref: Ref;
  var local_2_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: bool;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var local_1_Ref: Ref;
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

  anon0:
    req1 := req1$in;
    assume {:breadcrumb 175} true;
    local_0_Ref := req1;
    $tmp0 := local_0_Ref;
    assume $tmp0 != null;
    local_2_Ref := F$OAuth20NameSpace.AuthorizationRequest.response_type[$tmp0];
    goto anon19_Then, anon19_Else;

  anon19_Then:
    assume {:partition} local_2_Ref != null;
    assume {:breadcrumb 176} true;
    call $tmp1 := System.String.op_Equality$System.String$System.String(local_2_Ref, $string_literal_code_19);
    goto anon20_Then, anon20_Else;

  anon20_Then:
    assume {:partition} !$tmp1;
    assume {:breadcrumb 178} true;
    call $tmp2 := System.String.op_Equality$System.String$System.String(local_2_Ref, $string_literal_token_30);
    goto anon21_Then, anon21_Else;

  anon21_Then:
    assume {:partition} $tmp2;
    assume {:breadcrumb 180} true;
    goto IL_0038;

  anon21_Else:
    assume {:partition} !$tmp2;
    assume {:breadcrumb 181} true;
    goto anon5;

  anon5:
    goto IL_0053;

  anon20_Else:
    assume {:partition} $tmp1;
    assume {:breadcrumb 179} true;
    goto anon7;

  anon7:
    goto anon22_Then, anon22_Else;

  anon22_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    call $tmp3 := LiveIDNameSpace.LiveID_IdP.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
    goto anon12;

  anon22_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon23_Then, anon23_Else;

  anon23_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    call $tmp4 := OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
    goto anon12;

  anon23_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    call $tmp5 := OAuth20NameSpace.AuthorizationServer.createAuthorizationCodeEntry$OAuth20NameSpace.AuthorizationRequest($this, local_0_Ref);
    goto anon12;

  anon12:
    local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp3 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp4 else $tmp5));
    goto IL_0057;

  IL_0038:
    goto anon24_Then, anon24_Else;

  anon24_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    $tmp6 := local_0_Ref;
    assume $tmp6 != null;
    $tmp7 := local_0_Ref;
    assume $tmp7 != null;
    $tmp8 := local_0_Ref;
    assume $tmp8 != null;
    call $tmp9 := LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$tmp6], F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp7], F$OAuth20NameSpace.AuthorizationRequest.state[$tmp8]);
    goto anon17;

  anon24_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon25_Then, anon25_Else;

  anon25_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    $tmp10 := local_0_Ref;
    assume $tmp10 != null;
    $tmp11 := local_0_Ref;
    assume $tmp11 != null;
    $tmp12 := local_0_Ref;
    assume $tmp12 != null;
    call $tmp13 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$tmp10], F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp11], F$OAuth20NameSpace.AuthorizationRequest.state[$tmp12]);
    goto anon17;

  anon25_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    $tmp14 := local_0_Ref;
    assume $tmp14 != null;
    $tmp15 := local_0_Ref;
    assume $tmp15 != null;
    $tmp16 := local_0_Ref;
    assume $tmp16 != null;
    call $tmp17 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationRequest.redirect_uri[$tmp14], F$OAuth20NameSpace.AuthorizationRequest.scope[$tmp15], F$OAuth20NameSpace.AuthorizationRequest.state[$tmp16]);
    goto anon17;

  anon17:
    local_1_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp9 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp13 else $tmp17));
    goto IL_0057;

  anon19_Else:
    assume {:partition} local_2_Ref == null;
    assume {:breadcrumb 177} true;
    goto IL_0053;

  IL_0053:
    local_1_Ref := null;
    goto IL_0057;

  IL_0057:
    $result := local_1_Ref;
    return;
}



procedure OAuth20NameSpace.AuthorizationServer.AuthorizationEndpoint$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.AuthorizationServer.AuthorizationEndpoint$OAuth20NameSpace.AuthorizationRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    req := req$in;
    assume {:breadcrumb 182} true;
    call $tmp0 := GenericAuthNameSpace.IdP.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this, req);
    local_0_Ref := $tmp0;
    goto IL_0010;

  IL_0010:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.AuthorizationServer.TokenEndpoint$OAuth20NameSpace.AccessTokenRequest($this: Ref, req$in: Ref) returns ($result: Ref);



const {:value "refresh_token"} unique $string_literal_refresh_token_31: Ref;

function T$OAuth20NameSpace.AccessTokenResponse() : Ref;

const unique T$OAuth20NameSpace.AccessTokenResponse: int;

implementation OAuth20NameSpace.AuthorizationServer.TokenEndpoint$OAuth20NameSpace.AccessTokenRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var local_5_Ref: Ref;
  var $tmp0: Ref;
  var local_7_Ref: Ref;
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
  var local_2_Ref: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: Ref;
  var $tmp19: Ref;
  var local_3_Ref: Ref;
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
  var local_0_Ref: Ref;
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
  var local_1_Ref: Ref;
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
  var local_4_Ref: Ref;
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

  anon0:
    req := req$in;
    assume {:breadcrumb 183} true;
    goto anon57_Then, anon57_Else;

  anon57_Then:
    assume {:partition} req == null;
    assume {:breadcrumb 184} true;
    local_5_Ref := null;
    goto IL_01ce;

  anon57_Else:
    assume {:partition} req != null;
    assume {:breadcrumb 185} true;
    $tmp0 := req;
    assume $tmp0 != null;
    local_7_Ref := F$OAuth20NameSpace.AccessTokenRequest.grant_type[$tmp0];
    goto anon58_Then, anon58_Else;

  anon58_Then:
    assume {:partition} local_7_Ref != null;
    assume {:breadcrumb 186} true;
    call $tmp1 := System.String.op_Equality$System.String$System.String(local_7_Ref, $string_literal_authorization_code_2);
    goto anon59_Then, anon59_Else;

  anon59_Then:
    assume {:partition} !$tmp1;
    assume {:breadcrumb 188} true;
    call $tmp2 := System.String.op_Equality$System.String$System.String(local_7_Ref, $string_literal_refresh_token_31);
    goto anon60_Then, anon60_Else;

  anon60_Then:
    assume {:partition} $tmp2;
    assume {:breadcrumb 190} true;
    goto IL_011c;

  anon60_Else:
    assume {:partition} !$tmp2;
    assume {:breadcrumb 191} true;
    goto anon7;

  anon7:
    goto IL_01c9;

  anon59_Else:
    assume {:partition} $tmp1;
    assume {:breadcrumb 189} true;
    goto anon9;

  anon9:
    assume $this != null;
    goto anon61_Then, anon61_Else;

  anon61_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    assume $this != null;
    $tmp3 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
    $tmp4 := req;
    assume $tmp4 != null;
    $tmp5 := req;
    assume $tmp5 != null;
    call $tmp6 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.findISSByClientIDAndCode$System.String$System.String($tmp3, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp4], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp5]);
    goto anon12;

  anon61_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    assume $this != null;
    $tmp7 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
    $tmp8 := req;
    assume $tmp8 != null;
    $tmp9 := req;
    assume $tmp9 != null;
    call $tmp10 := OAuth20NameSpace.AuthorizationCodeRecs.findISSByClientIDAndCode$System.String$System.String($tmp7, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp8], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp9]);
    goto anon12;

  anon12:
    local_2_Ref := (if $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp6 else $tmp10);
    goto anon62_Then, anon62_Else;

  anon62_Then:
    assume {:partition} local_2_Ref == null;
    assume {:breadcrumb 192} true;
    local_5_Ref := null;
    goto IL_01ce;

  anon62_Else:
    assume {:partition} local_2_Ref != null;
    assume {:breadcrumb 193} true;
    assume $this != null;
    goto anon63_Then, anon63_Else;

  anon63_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    assume $this != null;
    $tmp11 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
    $tmp12 := req;
    assume $tmp12 != null;
    call $tmp13 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$System.String$System.String($tmp11, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp12]);
    goto anon19;

  anon63_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) != T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    assume $this != null;
    goto anon64_Then, anon64_Else;

  anon64_Then:
    assume {:partition} $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    assume $this != null;
    $tmp14 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
    $tmp15 := req;
    assume $tmp15 != null;
    call $tmp16 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($tmp14, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp15]);
    goto anon19;

  anon64_Else:
    assume {:partition} $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    assume $this != null;
    $tmp17 := F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this];
    $tmp18 := req;
    assume $tmp18 != null;
    call $tmp19 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp17, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp18]);
    goto anon19;

  anon19:
    local_3_Ref := (if $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp13 else (if $TypeConstructor($DynamicType(F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this])) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp16 else $tmp19));
    $tmp20 := local_3_Ref;
    assume $tmp20 != null;
    $tmp21 := req;
    assume $tmp21 != null;
    call $tmp22 := System.String.op_Inequality$System.String$System.String(F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp20], F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[$tmp21]);
    goto anon65_Then, anon65_Else;

  anon65_Then:
    assume {:partition} $tmp22;
    assume {:breadcrumb 194} true;
    local_5_Ref := null;
    goto IL_01ce;

  anon65_Else:
    assume {:partition} !$tmp22;
    assume {:breadcrumb 195} true;
    goto anon66_Then, anon66_Else;

  anon66_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    $tmp23 := local_3_Ref;
    assume $tmp23 != null;
    $tmp24 := local_3_Ref;
    assume $tmp24 != null;
    $tmp25 := local_3_Ref;
    assume $tmp25 != null;
    call $tmp26 := LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp23], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp24], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp25]);
    goto anon26;

  anon66_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon67_Then, anon67_Else;

  anon67_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    $tmp27 := local_3_Ref;
    assume $tmp27 != null;
    $tmp28 := local_3_Ref;
    assume $tmp28 != null;
    $tmp29 := local_3_Ref;
    assume $tmp29 != null;
    call $tmp30 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp27], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp28], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp29]);
    goto anon26;

  anon67_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    $tmp31 := local_3_Ref;
    assume $tmp31 != null;
    $tmp32 := local_3_Ref;
    assume $tmp32 != null;
    $tmp33 := local_3_Ref;
    assume $tmp33 != null;
    call $tmp34 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$tmp31], F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$tmp32], F$OAuth20NameSpace.AuthorizationCodeEntry.state[$tmp33]);
    goto anon26;

  anon26:
    local_0_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp26 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp30 else $tmp34));
    call $tmp45 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    goto anon68_Then, anon68_Else;

  anon68_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp45)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp35 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp36 := req;
    assume $tmp36 != null;
    call $tmp37 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp35, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp36], local_0_Ref);
    goto anon31;

  anon68_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp45)) != T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp44 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    goto anon69_Then, anon69_Else;

  anon69_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    call $tmp38 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp39 := req;
    assume $tmp39 != null;
    call $tmp40 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp38, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp39], local_0_Ref);
    goto anon31;

  anon69_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp44)) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    call $tmp41 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp42 := req;
    assume $tmp42 != null;
    call $tmp43 := GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp41, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp42], local_0_Ref);
    goto anon31;

  anon31:
    goto anon70_Then, anon70_Else;

  anon70_Then:
    assume {:partition} !(if $TypeConstructor($DynamicType($tmp45)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp37 else (if $TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp40 else $tmp43));
    assume {:breadcrumb 196} true;
    local_5_Ref := null;
    goto IL_01ce;

  anon70_Else:
    assume {:partition} (if $TypeConstructor($DynamicType($tmp45)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp37 else (if $TypeConstructor($DynamicType($tmp44)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp40 else $tmp43));
    assume {:breadcrumb 197} true;
    call $tmp46 := Alloc();
    call OAuth20NameSpace.AccessTokenResponse.#ctor($tmp46);
    assume $DynamicType($tmp46) == T$OAuth20NameSpace.AccessTokenResponse();
    assume $TypeConstructor($DynamicType($tmp46)) == T$OAuth20NameSpace.AccessTokenResponse;
    local_1_Ref := $tmp46;
    $tmp47 := local_0_Ref;
    assume $tmp47 != null;
    F$OAuth20NameSpace.AccessTokenResponse.access_token[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp47];
    $tmp48 := local_0_Ref;
    assume $tmp48 != null;
    F$OAuth20NameSpace.AccessTokenResponse.refresh_token[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.refresh_token[$tmp48];
    $tmp49 := local_0_Ref;
    assume $tmp49 != null;
    F$OAuth20NameSpace.AccessTokenResponse.scope[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp49];
    local_5_Ref := local_1_Ref;
    goto IL_01ce;

  IL_011c:
    call $tmp58 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    goto anon71_Then, anon71_Else;

  anon71_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp58)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp50 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp51 := req;
    assume $tmp51 != null;
    $tmp52 := req;
    assume $tmp52 != null;
    call $tmp53 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.findISSByClientIDAndRefreshToken$System.String$System.String($tmp50, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp51], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp52]);
    goto anon36;

  anon71_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp58)) != T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp54 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp55 := req;
    assume $tmp55 != null;
    $tmp56 := req;
    assume $tmp56 != null;
    call $tmp57 := OAuth20NameSpace.AccessTokenRecs.findISSByClientIDAndRefreshToken$System.String$System.String($tmp54, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp55], F$OAuth20NameSpace.AccessTokenRequest.code[$tmp56]);
    goto anon36;

  anon36:
    local_2_Ref := (if $TypeConstructor($DynamicType($tmp58)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp53 else $tmp57);
    goto anon72_Then, anon72_Else;

  anon72_Then:
    assume {:partition} local_2_Ref == null;
    assume {:breadcrumb 198} true;
    local_5_Ref := null;
    goto IL_01ce;

  anon72_Else:
    assume {:partition} local_2_Ref != null;
    assume {:breadcrumb 199} true;
    call $tmp69 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    goto anon73_Then, anon73_Else;

  anon73_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp69)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp59 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp60 := req;
    assume $tmp60 != null;
    call $tmp61 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.getEntry$System.String$System.String($tmp59, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp60]);
    goto anon43;

  anon73_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp69)) != T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp68 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    goto anon74_Then, anon74_Else;

  anon74_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp68)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    call $tmp62 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp63 := req;
    assume $tmp63 != null;
    call $tmp64 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.getEntry$System.String$System.String($tmp62, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp63]);
    goto anon43;

  anon74_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp68)) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    call $tmp65 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp66 := req;
    assume $tmp66 != null;
    call $tmp67 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp65, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp66]);
    goto anon43;

  anon43:
    local_0_Ref := (if $TypeConstructor($DynamicType($tmp69)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp61 else (if $TypeConstructor($DynamicType($tmp68)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp64 else $tmp67));
    goto anon75_Then, anon75_Else;

  anon75_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP;
    $tmp70 := local_0_Ref;
    assume $tmp70 != null;
    $tmp71 := local_0_Ref;
    assume $tmp71 != null;
    $tmp72 := local_0_Ref;
    assume $tmp72 != null;
    call $tmp73 := LiveIDNameSpace.LiveID_IdP.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$tmp70], F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp71], F$OAuth20NameSpace.AccessTokenEntry.state[$tmp72]);
    goto anon48;

  anon75_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$LiveIDNameSpace.LiveID_IdP;
    goto anon76_Then, anon76_Else;

  anon76_Then:
    assume {:partition} $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider;
    $tmp74 := local_0_Ref;
    assume $tmp74 != null;
    $tmp75 := local_0_Ref;
    assume $tmp75 != null;
    $tmp76 := local_0_Ref;
    assume $tmp76 != null;
    call $tmp77 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$tmp74], F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp75], F$OAuth20NameSpace.AccessTokenEntry.state[$tmp76]);
    goto anon48;

  anon76_Else:
    assume {:partition} $TypeConstructor($DynamicType($this)) != T$OpenIDConnectNameSpace.OpenIDProvider;
    $tmp78 := local_0_Ref;
    assume $tmp78 != null;
    $tmp79 := local_0_Ref;
    assume $tmp79 != null;
    $tmp80 := local_0_Ref;
    assume $tmp80 != null;
    call $tmp81 := OAuth20NameSpace.AuthorizationServer.createAccessTokenEntry$System.String$System.Collections.Generic.HashSet$System.String$$System.String($this, F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$tmp78], F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp79], F$OAuth20NameSpace.AccessTokenEntry.state[$tmp80]);
    goto anon48;

  anon48:
    local_4_Ref := (if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.LiveID_IdP then $tmp73 else (if $TypeConstructor($DynamicType($this)) == T$OpenIDConnectNameSpace.OpenIDProvider then $tmp77 else $tmp81));
    call $tmp92 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    goto anon77_Then, anon77_Else;

  anon77_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp92)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp82 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp83 := req;
    assume $tmp83 != null;
    call $tmp84 := LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp82, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp83], local_4_Ref);
    goto anon53;

  anon77_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp92)) != T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def;
    call $tmp91 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    goto anon78_Then, anon78_Else;

  anon78_Then:
    assume {:partition} $TypeConstructor($DynamicType($tmp91)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    call $tmp85 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp86 := req;
    assume $tmp86 != null;
    call $tmp87 := LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp85, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp86], local_4_Ref);
    goto anon53;

  anon78_Else:
    assume {:partition} $TypeConstructor($DynamicType($tmp91)) != T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def;
    call $tmp88 := OAuth20NameSpace.AuthorizationServer.get_AccessTokenRecs($this);
    $tmp89 := req;
    assume $tmp89 != null;
    call $tmp90 := GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp88, local_2_Ref, F$OAuth20NameSpace.AccessTokenRequest.client_id[$tmp89], local_4_Ref);
    goto anon53;

  anon53:
    goto anon79_Then, anon79_Else;

  anon79_Then:
    assume {:partition} !(if $TypeConstructor($DynamicType($tmp92)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp84 else (if $TypeConstructor($DynamicType($tmp91)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp87 else $tmp90));
    assume {:breadcrumb 200} true;
    local_5_Ref := null;
    goto IL_01ce;

  anon79_Else:
    assume {:partition} (if $TypeConstructor($DynamicType($tmp92)) == T$LiveIDNameSpace.LiveID_IdP.IDTokenAndAccessTokenDictionary_def then $tmp84 else (if $TypeConstructor($DynamicType($tmp91)) == T$LiveIDNameSpace.LiveID_IdP.AuthorizationCodeDictionary_def then $tmp87 else $tmp90));
    assume {:breadcrumb 201} true;
    call $tmp93 := Alloc();
    call OAuth20NameSpace.AccessTokenResponse.#ctor($tmp93);
    assume $DynamicType($tmp93) == T$OAuth20NameSpace.AccessTokenResponse();
    assume $TypeConstructor($DynamicType($tmp93)) == T$OAuth20NameSpace.AccessTokenResponse;
    local_1_Ref := $tmp93;
    $tmp94 := local_0_Ref;
    assume $tmp94 != null;
    F$OAuth20NameSpace.AccessTokenResponse.access_token[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.access_token[$tmp94];
    $tmp95 := local_0_Ref;
    assume $tmp95 != null;
    F$OAuth20NameSpace.AccessTokenResponse.refresh_token[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.refresh_token[$tmp95];
    $tmp96 := local_0_Ref;
    assume $tmp96 != null;
    F$OAuth20NameSpace.AccessTokenResponse.scope[local_1_Ref] := F$OAuth20NameSpace.AccessTokenEntry.scope[$tmp96];
    local_5_Ref := local_1_Ref;
    goto IL_01ce;

  anon58_Else:
    assume {:partition} local_7_Ref == null;
    assume {:breadcrumb 187} true;
    goto IL_01c9;

  IL_01c9:
    local_5_Ref := null;
    goto IL_01ce;

  IL_01ce:
    $result := local_5_Ref;
    return;
}



implementation OAuth20NameSpace.AuthorizationServer.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OAuth20NameSpace.AuthorizationServer.AuthorizationCodeRecs[$this] := null;
    assume {:breadcrumb 202} true;
    call GenericAuthNameSpace.IdP.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.AuthorizationServer.#cctor();



implementation T$OAuth20NameSpace.AuthorizationServer.#cctor()
{

  anon0:
    return;
}



var F$OAuth20NameSpace.AccessTokenResponse.token_type: [Ref]Ref;

implementation OAuth20NameSpace.AccessTokenResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OAuth20NameSpace.AccessTokenResponse.access_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.token_type[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.expires_in[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.refresh_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenResponse.scope[$this] := null;
    assume {:breadcrumb 203} true;
    F$OAuth20NameSpace.AccessTokenResponse.refresh_token[$this] := null;
    call CST.CST_Struct.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.AccessTokenResponse.#cctor();



implementation T$OAuth20NameSpace.AccessTokenResponse.#cctor()
{

  anon0:
    return;
}



implementation OAuth20NameSpace.AuthorizationCodeEntry.get_UserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 204} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AuthorizationCodeEntry.code[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



implementation OAuth20NameSpace.AuthorizationCodeEntry.get_Redir_dest($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 205} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.AuthorizationCodeEntry.#ctor($this: Ref);



implementation OAuth20NameSpace.AuthorizationCodeEntry.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OAuth20NameSpace.AuthorizationCodeEntry.code[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.scope[$this] := null;
    F$OAuth20NameSpace.AuthorizationCodeEntry.state[$this] := null;
    assume {:breadcrumb 206} true;
    call GenericAuthNameSpace.ID_Claim.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.AuthorizationCodeEntry.#cctor();



implementation T$OAuth20NameSpace.AuthorizationCodeEntry.#cctor()
{

  anon0:
    return;
}



implementation OAuth20NameSpace.Client.get_client_id($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 207} true;
    assume $this != null;
    local_0_Ref := F$GenericAuthNameSpace.RP.Realm[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.Client.set_client_id$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.Client.set_client_id$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 208} true;
    F$GenericAuthNameSpace.RP.Realm[$this] := value;
    return;
}



implementation OAuth20NameSpace.Client.get_return_uri($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 209} true;
    assume $this != null;
    local_0_Ref := F$GenericAuthNameSpace.RP.Domain[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



procedure OAuth20NameSpace.Client.set_return_uri$System.String($this: Ref, value$in: Ref);



implementation OAuth20NameSpace.Client.set_return_uri$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    value := value$in;
    assume {:breadcrumb 210} true;
    F$GenericAuthNameSpace.RP.Domain[$this] := value;
    return;
}



implementation OAuth20NameSpace.Client.#ctor$System.String$System.String$System.String$System.String($this: Ref, client_id1$in: Ref, return_uri1$in: Ref, client_secret1$in: Ref, TokenEndpointUrl1$in: Ref)
{
  var client_id1: Ref;
  var return_uri1: Ref;
  var client_secret1: Ref;
  var TokenEndpointUrl1: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    client_id1 := client_id1$in;
    return_uri1 := return_uri1$in;
    client_secret1 := client_secret1$in;
    TokenEndpointUrl1 := TokenEndpointUrl1$in;
    F$OAuth20NameSpace.Client.client_secret[$this] := null;
    F$OAuth20NameSpace.Client.TokenEndpointUrl[$this] := null;
    assume {:breadcrumb 211} true;
    call GenericAuthNameSpace.RP.#ctor($this);
    call OAuth20NameSpace.Client.set_client_id$System.String($this, client_id1);
    call OAuth20NameSpace.Client.set_return_uri$System.String($this, return_uri1);
    F$OAuth20NameSpace.Client.client_secret[$this] := client_secret1;
    F$OAuth20NameSpace.Client.TokenEndpointUrl[$this] := TokenEndpointUrl1;
    return;
}



procedure OAuth20NameSpace.Client.AuthorizationCodeGrant$OAuth20NameSpace.AuthorizationResponse($this: Ref, codeResp$in: Ref) returns ($result: Ref);



implementation OAuth20NameSpace.Client.AuthorizationCodeGrant$OAuth20NameSpace.AuthorizationResponse($this: Ref, codeResp$in: Ref) returns ($result: Ref)
{
  var codeResp: Ref;
  var local_1_Ref: Ref;
  var local_0_prime_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    codeResp := codeResp$in;
    assume {:breadcrumb 212} true;
    call $tmp0 := Alloc();
    call OAuth20NameSpace.AccessTokenRequest.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OAuth20NameSpace.AccessTokenRequest();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OAuth20NameSpace.AccessTokenRequest;
    local_0_prime_Ref := $tmp0;
    call $tmp1 := OAuth20NameSpace.Client.get_client_id($this);
    F$OAuth20NameSpace.AccessTokenRequest.client_id[local_0_prime_Ref] := $tmp1;
    $tmp2 := codeResp;
    assume $tmp2 != null;
    F$OAuth20NameSpace.AccessTokenRequest.code[local_0_prime_Ref] := F$OAuth20NameSpace.AuthorizationResponse.code[$tmp2];
    F$OAuth20NameSpace.AccessTokenRequest.grant_type[local_0_prime_Ref] := $string_literal_authorization_code_2;
    call $tmp3 := OAuth20NameSpace.Client.get_return_uri($this);
    F$OAuth20NameSpace.AccessTokenRequest.redirect_uri[local_0_prime_Ref] := $tmp3;
    local_1_Ref := local_0_prime_Ref;
    goto IL_003a;

  IL_003a:
    $result := local_1_Ref;
    return;
}



procedure T$OAuth20NameSpace.Client.#cctor();



implementation T$OAuth20NameSpace.Client.#cctor()
{

  anon0:
    return;
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

  anon0:
    F$OAuth20NameSpace.AuthorizationErrorResponse.error[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_description[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.state[$this] := null;
    assume {:breadcrumb 213} true;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_description[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.error_uri[$this] := null;
    F$OAuth20NameSpace.AuthorizationErrorResponse.state[$this] := null;
    call GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.AuthorizationErrorResponse.#cctor();



implementation T$OAuth20NameSpace.AuthorizationErrorResponse.#cctor()
{

  anon0:
    return;
}



function T$OAuth20NameSpace.AuthorizationResponse() : Ref;

const unique T$OAuth20NameSpace.AuthorizationResponse: int;

implementation OAuth20NameSpace.AuthorizationResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OAuth20NameSpace.AuthorizationResponse.code[$this] := null;
    F$OAuth20NameSpace.AuthorizationResponse.state[$this] := null;
    assume {:breadcrumb 214} true;
    F$OAuth20NameSpace.AuthorizationResponse.state[$this] := null;
    call GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.AuthorizationResponse.#cctor();



implementation T$OAuth20NameSpace.AuthorizationResponse.#cctor()
{

  anon0:
    return;
}



function T$OAuth20NameSpace.resource_server() : Ref;

const unique T$OAuth20NameSpace.resource_server: int;

procedure OAuth20NameSpace.resource_server.#ctor($this: Ref);



implementation OAuth20NameSpace.resource_server.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 215} true;
    call System.Object.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.resource_server.#cctor();



implementation T$OAuth20NameSpace.resource_server.#cctor()
{

  anon0:
    return;
}



implementation OAuth20NameSpace.AccessTokenEntry.get_UserID($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 216} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AccessTokenEntry.access_token[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



implementation OAuth20NameSpace.AccessTokenEntry.get_Redir_dest($this: Ref) returns ($result: Ref)
{
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 217} true;
    assume $this != null;
    local_0_Ref := F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$this];
    goto IL_000a;

  IL_000a:
    $result := local_0_Ref;
    return;
}



implementation OAuth20NameSpace.AccessTokenEntry.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$OAuth20NameSpace.AccessTokenEntry.access_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.redirect_uri[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.scope[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.refresh_token[$this] := null;
    F$OAuth20NameSpace.AccessTokenEntry.state[$this] := null;
    assume {:breadcrumb 218} true;
    call GenericAuthNameSpace.ID_Claim.#ctor($this);
    return;
}



procedure T$OAuth20NameSpace.AccessTokenEntry.#cctor();



implementation T$OAuth20NameSpace.AccessTokenEntry.#cctor()
{

  anon0:
    return;
}



function T$CST.Debug() : Ref;

const unique T$CST.Debug: int;

procedure CST.Debug.reached();



implementation CST.Debug.reached()
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 219} true;
    assert false;
    return;
}



procedure CST.Debug.#ctor($this: Ref);



implementation CST.Debug.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 220} true;
    call System.Object.#ctor($this);
    return;
}



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
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$CST.CST_Struct.SymT[$this] := null;
    F$CST.CST_Struct.SignedBy[$this] := null;
    assume {:breadcrumb 221} true;
    F$CST.CST_Struct.SymT[$this] := $string_literal__25;
    F$CST.CST_Struct.SignedBy[$this] := $string_literal__25;
    call System.Object.#ctor($this);
    return;
}



procedure T$CST.CST_Struct.#cctor();



implementation T$CST.CST_Struct.#cctor()
{

  anon0:
    return;
}



function T$CST.Nondet_Base() : Ref;

const unique T$CST.Nondet_Base: int;

procedure CST.Nondet_Base.Int($this: Ref) returns ($result: int);



procedure CST.Nondet_Base.Bool($this: Ref) returns ($result: bool);



procedure corral_atomic_begin();



procedure corral_atomic_end();



procedure corral_getThreadID() returns (id: int);



var $GetMeHereTracker: int;
