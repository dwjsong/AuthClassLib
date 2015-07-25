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

function T$PoirotMain() : Ref;

const unique T$PoirotMain: int;

var F$PoirotMain.Nondet: Ref;

procedure {:entrypoint} PoirotMain.Main();



procedure GlobalObjectsForCST.init();



procedure SynthesizedPortion.SynthesizedSequence();



implementation PoirotMain.Main()
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 0} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 21} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 21} true;
    call GlobalObjectsForCST.init();
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 22} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 22} true;
    call SynthesizedPortion.SynthesizedSequence();
}



procedure PoirotMain.#ctor($this: Ref);



procedure {:extern} System.Object.#ctor($this: Ref);



implementation PoirotMain.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 1} true;
    call System.Object.#ctor($this);
}



procedure T$PoirotMain.#cctor();



implementation T$PoirotMain.#cctor()
{
    F$PoirotMain.Nondet := null;
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
  var $localExc: Ref;
  var $label: int;

    conclusion := conclusion$in;
    assume {:breadcrumb 2} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Assertion.cs"} {:sourceLine 12} true;
    $tmp12 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
    assume $tmp12 != null;
    if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp12])) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def)
    {
        $tmp0 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
        assume $tmp0 != null;
        $tmp1 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp0];
        $tmp2 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
        assume $tmp2 != null;
        if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenID20NameSpace.AuthenticationRequest)
        {
            call $tmp3 := OpenID20NameSpace.AuthenticationRequest.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
        }
        else
        {
            call $tmp4 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
        }

        call $tmp5 := OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.getEntry$System.String$System.String($tmp1, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp2], (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenID20NameSpace.AuthenticationRequest then $tmp3 else $tmp4));
    }
    else
    {
        $tmp6 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
        assume $tmp6 != null;
        $tmp7 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp6];
        $tmp8 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
        assume $tmp8 != null;
        if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenID20NameSpace.AuthenticationRequest)
        {
            call $tmp9 := OpenID20NameSpace.AuthenticationRequest.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
        }
        else
        {
            call $tmp10 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
        }

        call $tmp11 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp7, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp8], (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenID20NameSpace.AuthenticationRequest then $tmp9 else $tmp10));
    }

    ID_claim_Ref := (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp12])) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def then $tmp5 else $tmp11);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Assertion.cs"} {:sourceLine 17} true;
    if ($TypeConstructor($DynamicType(ID_claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
    {
        call $tmp13 := OpenID20NameSpace.IDAssertionEntry.get_UserID(ID_claim_Ref);
    }
    else
    {
        call $tmp14 := GenericAuthNameSpace.ID_Claim.get_UserID(ID_claim_Ref);
    }

    $tmp15 := conclusion;
    assume $tmp15 != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Assertion.cs"} {:sourceLine 17} true;
    call $tmp16 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(ID_claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp13 else $tmp14), F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp15]);
    assert $tmp16;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Assertion.cs"} {:sourceLine 20} true;
    $result := true;
    return;
}



procedure LiveIDNameSpace.Yahoo_RP_For_vProgram.#ctor($this: Ref);



procedure {:extern} OpenID20NameSpace.Yahoo_RP.#ctor($this: Ref);



implementation LiveIDNameSpace.Yahoo_RP_For_vProgram.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 3} true;
    call OpenID20NameSpace.Yahoo_RP.#ctor($this);
}



procedure T$LiveIDNameSpace.Yahoo_RP_For_vProgram.#cctor();



implementation T$LiveIDNameSpace.Yahoo_RP_For_vProgram.#cctor()
{
}



function T$SynthesizedPortion() : Ref;

const unique T$SynthesizedPortion: int;

var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.RP: Ref;

var {:extern} F$GenericAuthNameSpace.RP.Realm: [Ref]Ref;

procedure {:extern} OpenID20NameSpace.AuthenticationRequest.set_Realm$System.String($this: Ref, value$in: Ref);



procedure {:extern} GenericAuthNameSpace.SignInIdP_Req.set_Realm$System.String($this: Ref, value$in: Ref);



procedure {:extern} OpenID20NameSpace.OpenIDProvider.ProcessAuthenticationRequest$OpenID20NameSpace.AuthenticationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



var {:extern} F$OpenID20NameSpace.AuthenticationResponse.return_to: [Ref]Ref;

procedure {:extern} OpenID20NameSpace.RelyingParty.conclude$OpenID20NameSpace.AuthenticationResponse($this: Ref, resp$in: Ref) returns ($result: Ref);



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
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 4} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 6} true;
    if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenID20NameSpace.AuthenticationRequest)
    {
        assume {:breadcrumb 5} true;
        $tmp0 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
        assume $tmp0 != null;
        call OpenID20NameSpace.AuthenticationRequest.set_Realm$System.String(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req, F$GenericAuthNameSpace.RP.Realm[$tmp0]);
    }
    else
    {
        assume {:breadcrumb 6} true;
        $tmp1 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
        assume $tmp1 != null;
        call GenericAuthNameSpace.SignInIdP_Req.set_Realm$System.String(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req, F$GenericAuthNameSpace.RP.Realm[$tmp1]);
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 7} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 7} true;
    call $tmp2 := OpenID20NameSpace.OpenIDProvider.ProcessAuthenticationRequest$OpenID20NameSpace.AuthenticationRequest(F$GenericAuthNameSpace.GlobalObjects_base.IdP, F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req);
    O2_Ref := $tmp2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 9} true;
    $tmp3 := O2_Ref;
    assume $tmp3 != null;
    $tmp4 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp4 != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 9} true;
    call $tmp5 := System.String.op_Inequality$System.String$System.String(F$OpenID20NameSpace.AuthenticationResponse.return_to[$tmp3], F$GenericAuthNameSpace.RP.Realm[$tmp4]);
    if ($tmp5)
    {
        assume {:breadcrumb 7} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 10} true;
        return;
    }
    else
    {
        assume {:breadcrumb 8} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 11} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 11} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 11} true;
    call $tmp6 := OpenID20NameSpace.RelyingParty.conclude$OpenID20NameSpace.AuthenticationResponse(F$GenericAuthNameSpace.GlobalObjects_base.RP, O2_Ref);
    G3_Ref := $tmp6;
}



procedure SynthesizedPortion.#ctor($this: Ref);



implementation SynthesizedPortion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 9} true;
    call System.Object.#ctor($this);
}



procedure T$SynthesizedPortion.#cctor();



implementation T$SynthesizedPortion.#cctor()
{
}



function T$GlobalObjectsForCST() : Ref;

const unique T$GlobalObjectsForCST: int;

procedure {:extern} OpenID20NameSpace.NondetOpenID20.AuthenticationRequest($this: Ref) returns ($result: Ref);



procedure {:extern} OpenID20NameSpace.Yahoo_IdP.#ctor($this: Ref);



function {:extern} T$OpenID20NameSpace.Yahoo_IdP() : Ref;

const {:extern} unique T$OpenID20NameSpace.Yahoo_IdP: int;

axiom $TypeConstructor(T$OpenID20NameSpace.Yahoo_IdP()) == T$OpenID20NameSpace.Yahoo_IdP;

procedure {:extern} OpenID20NameSpace.Yahoo_IdP.init($this: Ref);



implementation GlobalObjectsForCST.init()
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 10} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 10} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 10} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 10} true;
    call $tmp0 := OpenID20NameSpace.NondetOpenID20.AuthenticationRequest(F$PoirotMain.Nondet);
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 11} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 11} true;
    call $tmp1 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 11} true;
    call OpenID20NameSpace.Yahoo_IdP.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$OpenID20NameSpace.Yahoo_IdP();
    assume $TypeConstructor($DynamicType($tmp1)) == T$OpenID20NameSpace.Yahoo_IdP;
    F$GenericAuthNameSpace.GlobalObjects_base.IdP := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 11} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 11} true;
    call OpenID20NameSpace.Yahoo_IdP.init(F$GenericAuthNameSpace.GlobalObjects_base.IdP);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 12} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 12} true;
    call $tmp2 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 12} true;
    call LiveIDNameSpace.Yahoo_RP_For_vProgram.#ctor($tmp2);
    assume $DynamicType($tmp2) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram();
    assume $TypeConstructor($DynamicType($tmp2)) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram;
    F$GenericAuthNameSpace.GlobalObjects_base.RP := $tmp2;
}



procedure GlobalObjectsForCST.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.GlobalObjects_base.#ctor($this: Ref);



implementation GlobalObjectsForCST.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 11} true;
    call GenericAuthNameSpace.GlobalObjects_base.#ctor($this);
}



procedure T$GlobalObjectsForCST.#cctor();



implementation T$GlobalObjectsForCST.#cctor()
{
}



var F$OpenID20NameSpace.IDAssertionEntry.openid_return_to: [Ref]Ref;

var F$OpenID20NameSpace.IDAssertionEntry.openid_identity: [Ref]Ref;

var F$OpenID20NameSpace.IDAssertionEntry.openid_claimed_id: [Ref]Ref;

var F$OpenID20NameSpace.IDAssertionEntry.openid_assoc_handle: [Ref]Ref;

var F$OpenID20NameSpace.IDAssertionEntry.openid_op_endpoint: [Ref]Ref;

procedure OpenID20NameSpace.IDAssertionEntry.get_Redir_dest($this: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.IDAssertionEntry.get_Redir_dest($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 12} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 62} true;
    assume $this != null;
    $result := F$OpenID20NameSpace.IDAssertionEntry.openid_return_to[$this];
    return;
}



implementation OpenID20NameSpace.IDAssertionEntry.get_UserID($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 13} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 66} true;
    assume $this != null;
    $result := F$OpenID20NameSpace.IDAssertionEntry.openid_claimed_id[$this];
    return;
}



procedure OpenID20NameSpace.IDAssertionEntry.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.ID_Claim.#ctor($this: Ref);



implementation OpenID20NameSpace.IDAssertionEntry.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenID20NameSpace.IDAssertionEntry.openid_return_to[$this] := null;
    F$OpenID20NameSpace.IDAssertionEntry.openid_identity[$this] := null;
    F$OpenID20NameSpace.IDAssertionEntry.openid_claimed_id[$this] := null;
    F$OpenID20NameSpace.IDAssertionEntry.openid_assoc_handle[$this] := null;
    F$OpenID20NameSpace.IDAssertionEntry.openid_op_endpoint[$this] := null;
    assume {:breadcrumb 14} true;
    call GenericAuthNameSpace.ID_Claim.#ctor($this);
}



procedure T$OpenID20NameSpace.IDAssertionEntry.#cctor();



implementation T$OpenID20NameSpace.IDAssertionEntry.#cctor()
{
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
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 15} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 27} true;
    assume $this != null;
    $result := F$OpenID20NameSpace.AuthenticationRequest.realm[$this];
    return;
}



implementation OpenID20NameSpace.AuthenticationRequest.set_Realm$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 16} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 31} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 31} true;
    F$OpenID20NameSpace.AuthenticationRequest.realm[$this] := value;
}



procedure OpenID20NameSpace.AuthenticationRequest.#ctor($this: Ref);



const {:value "http://specs.openid.net/auth/2.0"} unique $string_literal_http$$$specs.openid.net$auth$2.0_0: Ref;

procedure {:extern} GenericAuthNameSpace.SignInIdP_Req.#ctor($this: Ref);



implementation OpenID20NameSpace.AuthenticationRequest.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenID20NameSpace.AuthenticationRequest.ns[$this] := null;
    F$OpenID20NameSpace.AuthenticationRequest.mode[$this] := null;
    F$OpenID20NameSpace.AuthenticationRequest.claimed_id[$this] := null;
    F$OpenID20NameSpace.AuthenticationRequest.identity[$this] := null;
    F$OpenID20NameSpace.AuthenticationRequest.assoc_handle[$this] := null;
    F$OpenID20NameSpace.AuthenticationRequest.return_to[$this] := null;
    F$OpenID20NameSpace.AuthenticationRequest.realm[$this] := null;
    F$OpenID20NameSpace.AuthenticationRequest.endpointURL[$this] := null;
    assume {:breadcrumb 17} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 15} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 15} true;
    F$OpenID20NameSpace.AuthenticationRequest.ns[$this] := $string_literal_http$$$specs.openid.net$auth$2.0_0;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 15} true;
    call GenericAuthNameSpace.SignInIdP_Req.#ctor($this);
}



procedure T$OpenID20NameSpace.AuthenticationRequest.#cctor();



implementation T$OpenID20NameSpace.AuthenticationRequest.#cctor()
{
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

implementation OpenID20NameSpace.RelyingParty.get_return_uri($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 18} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 74} true;
    assume $this != null;
    $result := F$GenericAuthNameSpace.RP.Domain[$this];
    return;
}



procedure OpenID20NameSpace.RelyingParty.set_return_uri$System.String($this: Ref, value$in: Ref);



implementation OpenID20NameSpace.RelyingParty.set_return_uri$System.String($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 19} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 75} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 75} true;
    F$GenericAuthNameSpace.RP.Domain[$this] := value;
}



procedure OpenID20NameSpace.RelyingParty.RequestAuthentication$OpenID20NameSpace.AuthenticationResponse($this: Ref, resp$in: Ref) returns ($result: Ref);



var {:extern} F$CST.CST_Struct.SymT: [Ref]Ref;

const {:value "http://specs.openid.net/auth/2.0/identifier_select"} unique $string_literal_http$$$specs.openid.net$auth$2.0$identifier_select_1: Ref;

const {:value "checkid_setup"} unique $string_literal_checkid_setup_2: Ref;

implementation OpenID20NameSpace.RelyingParty.RequestAuthentication$OpenID20NameSpace.AuthenticationResponse($this: Ref, resp$in: Ref) returns ($result: Ref)
{
  var resp: Ref;
  var req_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $localExc: Ref;
  var $label: int;

    resp := resp$in;
    assume {:breadcrumb 20} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 82} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 82} true;
    call OpenID20NameSpace.AuthenticationRequest.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.AuthenticationRequest();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.AuthenticationRequest;
    req_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 84} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 84} true;
    assume $this != null;
    F$OpenID20NameSpace.AuthenticationRequest.realm[req_Ref] := F$GenericAuthNameSpace.RP.Domain[$this];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 85} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 85} true;
    $tmp1 := resp;
    assume $tmp1 != null;
    F$CST.CST_Struct.SymT[req_Ref] := F$CST.CST_Struct.SymT[$tmp1];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 86} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 86} true;
    F$OpenID20NameSpace.AuthenticationRequest.identity[req_Ref] := $string_literal_http$$$specs.openid.net$auth$2.0$identifier_select_1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 87} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 87} true;
    F$OpenID20NameSpace.AuthenticationRequest.ns[req_Ref] := $string_literal_http$$$specs.openid.net$auth$2.0_0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 88} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 88} true;
    F$OpenID20NameSpace.AuthenticationRequest.claimed_id[req_Ref] := $string_literal_http$$$specs.openid.net$auth$2.0$identifier_select_1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 89} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 89} true;
    F$OpenID20NameSpace.AuthenticationRequest.mode[req_Ref] := $string_literal_checkid_setup_2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 90} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 90} true;
    assume $this != null;
    F$OpenID20NameSpace.AuthenticationRequest.return_to[req_Ref] := F$GenericAuthNameSpace.RP.Domain[$this];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 92} true;
    $result := req_Ref;
    return;
}



procedure {:extern} GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($this: Ref);



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
  var $localExc: Ref;
  var $label: int;

    resp := resp$in;
    assume {:breadcrumb 21} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 97} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 97} true;
    call GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$GenericAuthNameSpace.RP.AuthenticationConclusion();
    assume $TypeConstructor($DynamicType($tmp0)) == T$GenericAuthNameSpace.RP.AuthenticationConclusion;
    conclusion_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 98} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 98} true;
    $tmp1 := resp;
    assume $tmp1 != null;
    F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[conclusion_Ref] := F$OpenID20NameSpace.AuthenticationResponse.claimed_id[$tmp1];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 99} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 99} true;
    $tmp2 := resp;
    assume $tmp2 != null;
    F$CST.CST_Struct.SymT[conclusion_Ref] := F$CST.CST_Struct.SymT[$tmp2];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 100} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 100} true;
    call CST.CST_Ops.recordme$System.Object$CST.CST_Struct($this, conclusion_Ref);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 102} true;
    if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram)
    {
        call $tmp3 := LiveIDNameSpace.Yahoo_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, conclusion_Ref);
    }
    else
    {
        if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_RP)
        {
            call $tmp4 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, conclusion_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.RelyingParty)
            {
                call $tmp5 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, conclusion_Ref);
            }
            else
            {
                call $tmp6 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, conclusion_Ref);
            }
        }
    }

    if ((if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram then $tmp3 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_RP then $tmp4 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.RelyingParty then $tmp5 else $tmp6))))
    {
        assume {:breadcrumb 22} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 103} true;
        $result := conclusion_Ref;
        return;
    }
    else
    {
        assume {:breadcrumb 23} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 105} true;
    $result := null;
    return;
}



procedure OpenID20NameSpace.RelyingParty.callProcessAuthenticationRequest$OpenID20NameSpace.AuthenticationRequest($this: Ref, authReq$in: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.AuthenticationResponse.#ctor($this: Ref);



function T$OpenID20NameSpace.AuthenticationResponse() : Ref;

const unique T$OpenID20NameSpace.AuthenticationResponse: int;

implementation OpenID20NameSpace.RelyingParty.callProcessAuthenticationRequest$OpenID20NameSpace.AuthenticationRequest($this: Ref, authReq$in: Ref) returns ($result: Ref)
{
  var authReq: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    authReq := authReq$in;
    assume {:breadcrumb 24} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 110} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 110} true;
    call OpenID20NameSpace.AuthenticationResponse.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.AuthenticationResponse();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.AuthenticationResponse;
    $result := $tmp0;
    return;
}



procedure OpenID20NameSpace.RelyingParty.parseAuthenticationResponse$System.Web.HttpRequest($this: Ref, rawRequest$in: Ref) returns ($result: Ref);



procedure {:extern} System.Web.HttpContext.get_Current() returns ($result: Ref);



procedure {:extern} System.Web.HttpRequest.get_QueryString($this: Ref) returns ($result: Ref);



const {:value "openid.claimed_id"} unique $string_literal_openid.claimed_id_3: Ref;

procedure {:extern} System.Collections.Specialized.NameValueCollection.get_Item$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



const {:value "SymT"} unique $string_literal_SymT_4: Ref;

procedure {:extern} System.String.IsNullOrEmpty$System.String(value$in: Ref) returns ($result: bool);



implementation OpenID20NameSpace.RelyingParty.parseAuthenticationResponse$System.Web.HttpRequest($this: Ref, rawRequest$in: Ref) returns ($result: Ref)
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
    assume {:breadcrumb 25} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 115} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 115} true;
    call OpenID20NameSpace.AuthenticationResponse.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.AuthenticationResponse();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.AuthenticationResponse;
    r_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 116} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 116} true;
    call $tmp1 := System.Web.HttpContext.get_Current();
    context_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 117} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 117} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 117} true;
    call $tmp2 := System.Web.HttpRequest.get_QueryString(rawRequest);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 117} true;
    call $tmp3 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp2, $string_literal_openid.claimed_id_3);
    F$OpenID20NameSpace.AuthenticationResponse.claimed_id[r_Ref] := $tmp3;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 118} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 118} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 118} true;
    call $tmp4 := System.Web.HttpRequest.get_QueryString(rawRequest);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 118} true;
    call $tmp5 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp4, $string_literal_SymT_4);
    F$CST.CST_Struct.SymT[r_Ref] := $tmp5;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 119} true;
    $tmp6 := r_Ref;
    assume $tmp6 != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 119} true;
    call $tmp7 := System.String.IsNullOrEmpty$System.String(F$OpenID20NameSpace.AuthenticationResponse.claimed_id[$tmp6]);
    if ($tmp7)
    {
        assume {:breadcrumb 26} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 120} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 27} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 122} true;
    $result := r_Ref;
    return;
}



procedure OpenID20NameSpace.RelyingParty.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.RP.#ctor($this: Ref);



implementation OpenID20NameSpace.RelyingParty.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenID20NameSpace.RelyingParty.assoc_handle[$this] := null;
    F$OpenID20NameSpace.RelyingParty.endpointUrl[$this] := null;
    assume {:breadcrumb 28} true;
    call GenericAuthNameSpace.RP.#ctor($this);
}



procedure T$OpenID20NameSpace.RelyingParty.#cctor();



implementation T$OpenID20NameSpace.RelyingParty.#cctor()
{
}



var F$OpenID20NameSpace.AuthenticationResponse.ns: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationResponse.mode: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationResponse.identity: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationResponse.assoc_handle: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationResponse.realm: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationResponse.endpointURL: [Ref]Ref;

procedure {:extern} GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this: Ref);



implementation OpenID20NameSpace.AuthenticationResponse.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$OpenID20NameSpace.AuthenticationResponse.ns[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.mode[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.claimed_id[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.identity[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.assoc_handle[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.return_to[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.realm[$this] := null;
    F$OpenID20NameSpace.AuthenticationResponse.endpointURL[$this] := null;
    assume {:breadcrumb 29} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 40} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 40} true;
    F$OpenID20NameSpace.AuthenticationResponse.ns[$this] := $string_literal_http$$$specs.openid.net$auth$2.0_0;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 40} true;
    call GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this);
}



procedure T$OpenID20NameSpace.AuthenticationResponse.#cctor();



implementation T$OpenID20NameSpace.AuthenticationResponse.#cctor()
{
}



function T$OpenID20NameSpace.IDAssertionRecs() : Ref;

const unique T$OpenID20NameSpace.IDAssertionRecs: int;

function T$OpenID20NameSpace.OpenIDProvider() : Ref;

const unique T$OpenID20NameSpace.OpenIDProvider: int;

procedure OpenID20NameSpace.OpenIDProvider.init$OpenID20NameSpace.IDAssertionRecs($this: Ref, recs$in: Ref);



procedure OpenID20NameSpace.OpenIDProvider.set_IDAssertionRecs$OpenID20NameSpace.IDAssertionRecs($this: Ref, value$in: Ref);



implementation OpenID20NameSpace.OpenIDProvider.init$OpenID20NameSpace.IDAssertionRecs($this: Ref, recs$in: Ref)
{
  var recs: Ref;
  var $localExc: Ref;
  var $label: int;

    recs := recs$in;
    assume {:breadcrumb 30} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 134} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 134} true;
    call OpenID20NameSpace.OpenIDProvider.set_IDAssertionRecs$OpenID20NameSpace.IDAssertionRecs($this, recs);
}



procedure OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 31} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 139} true;
    assume $this != null;
    $result := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this];
    return;
}



implementation OpenID20NameSpace.OpenIDProvider.set_IDAssertionRecs$OpenID20NameSpace.IDAssertionRecs($this: Ref, value$in: Ref)
{
  var value: Ref;
  var $localExc: Ref;
  var $label: int;

    value := value$in;
    assume {:breadcrumb 32} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 140} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 140} true;
    F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this] := value;
}



procedure OpenID20NameSpace.OpenIDProvider.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req1$in: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.OpenIDProvider.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req1$in: Ref) returns ($result: Ref)
{
  var req1: Ref;
  var req_Ref: Ref;
  var resp_Ref: Ref;
  var $tmp0: Ref;
  var CS$4$0001_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var $localExc: Ref;
  var $label: int;

    req1 := req1$in;
    assume {:breadcrumb 33} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 145} true;
    req_Ref := req1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 146} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 146} true;
    call OpenID20NameSpace.AuthenticationResponse.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.AuthenticationResponse();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.AuthenticationResponse;
    resp_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 148} true;
    $tmp1 := req_Ref;
    assume $tmp1 != null;
    CS$4$0001_Ref := F$OpenID20NameSpace.AuthenticationRequest.mode[$tmp1];
    if (CS$4$0001_Ref != null)
    {
        assume {:breadcrumb 34} true;
        call $tmp2 := System.String.op_Equality$System.String$System.String(CS$4$0001_Ref, $string_literal_checkid_setup_2);
        if (!$tmp2)
        {
            assume {:breadcrumb 36} true;
            goto IL_0029;
        }
        else
        {
            assume {:breadcrumb 37} true;
        }
    }
    else
    {
        assume {:breadcrumb 35} true;
    }

  IL_0029:
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 157} true;
    $result := null;
    return;
}



procedure OpenID20NameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, _ID_Claim$in: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, _ID_Claim$in: Ref) returns ($result: Ref)
{
  var dest: Ref;
  var _ID_Claim: Ref;
  var $localExc: Ref;
  var $label: int;

    dest := dest$in;
    _ID_Claim := _ID_Claim$in;
    assume {:breadcrumb 38} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 161} true;
    $result := null;
    return;
}



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
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 39} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 166} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 166} true;
    call OpenID20NameSpace.AuthenticationResponse.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.AuthenticationResponse();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.AuthenticationResponse;
    resp_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 167} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 167} true;
    $tmp1 := req;
    assume $tmp1 != null;
    F$CST.CST_Struct.SymT[resp_Ref] := F$CST.CST_Struct.SymT[$tmp1];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 169} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 169} true;
    call CST.CST_Ops.recordme$System.Object$CST.CST_Struct($this, resp_Ref);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 171} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 171} true;
    call $tmp10 := OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this);
    if ($TypeConstructor($DynamicType($tmp10)) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def)
    {
        call $tmp2 := OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this);
        $tmp3 := req;
        assume $tmp3 != null;
        $tmp4 := req;
        assume $tmp4 != null;
        call $tmp5 := OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.getEntry$System.String$System.String($tmp2, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp3], F$OpenID20NameSpace.AuthenticationRequest.realm[$tmp4]);
    }
    else
    {
        call $tmp6 := OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this);
        $tmp7 := req;
        assume $tmp7 != null;
        $tmp8 := req;
        assume $tmp8 != null;
        call $tmp9 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp6, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp7], F$OpenID20NameSpace.AuthenticationRequest.realm[$tmp8]);
    }

    entry_Ref := (if $TypeConstructor($DynamicType($tmp10)) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def then $tmp5 else $tmp9);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 173} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 173} true;
    if ($TypeConstructor($DynamicType(entry_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
    {
        call $tmp11 := OpenID20NameSpace.IDAssertionEntry.get_UserID(entry_Ref);
    }
    else
    {
        call $tmp12 := GenericAuthNameSpace.ID_Claim.get_UserID(entry_Ref);
    }

    F$OpenID20NameSpace.AuthenticationResponse.claimed_id[resp_Ref] := (if $TypeConstructor($DynamicType(entry_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp11 else $tmp12);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 174} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 174} true;
    if ($TypeConstructor($DynamicType(entry_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
    {
        call $tmp13 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(entry_Ref);
    }
    else
    {
        call $tmp14 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(entry_Ref);
    }

    F$OpenID20NameSpace.AuthenticationResponse.return_to[resp_Ref] := (if $TypeConstructor($DynamicType(entry_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp13 else $tmp14);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 176} true;
    $result := resp_Ref;
    return;
}



procedure OpenID20NameSpace.OpenIDProvider.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.IdP.#ctor($this: Ref);



implementation OpenID20NameSpace.OpenIDProvider.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 40} true;
    call GenericAuthNameSpace.IdP.#ctor($this);
}



procedure T$OpenID20NameSpace.OpenIDProvider.#cctor();



implementation T$OpenID20NameSpace.OpenIDProvider.#cctor()
{
}



function T$GenericAuthNameSpace.GlobalObjects_base() : Ref;

const unique T$GenericAuthNameSpace.GlobalObjects_base: int;

procedure GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson$GenericAuthNameSpace.RP.AuthenticationConclusion(conclusion$in: Ref);



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
  var $tmp14: bool;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: bool;
  var $localExc: Ref;
  var $label: int;

    conclusion := conclusion$in;
    assume {:breadcrumb 41} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 102} true;
    $tmp10 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
    assume $tmp10 != null;
    if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp10])) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def)
    {
        $tmp0 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
        assume $tmp0 != null;
        $tmp1 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp0];
        $tmp2 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
        assume $tmp2 != null;
        $tmp3 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
        assume $tmp3 != null;
        call $tmp4 := OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.getEntry$System.String$System.String($tmp1, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp2], F$GenericAuthNameSpace.RP.Realm[$tmp3]);
    }
    else
    {
        $tmp5 := F$GenericAuthNameSpace.GlobalObjects_base.IdP;
        assume $tmp5 != null;
        $tmp6 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp5];
        $tmp7 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
        assume $tmp7 != null;
        $tmp8 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
        assume $tmp8 != null;
        call $tmp9 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp6, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp7], F$GenericAuthNameSpace.RP.Realm[$tmp8]);
    }

    ID_claim_Ref := (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$tmp10])) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def then $tmp4 else $tmp9);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 105} true;
    if ($TypeConstructor($DynamicType(ID_claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
    {
        call $tmp15 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(ID_claim_Ref);
    }
    else
    {
        call $tmp16 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(ID_claim_Ref);
    }

    $tmp17 := F$GenericAuthNameSpace.GlobalObjects_base.RP;
    assume $tmp17 != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 105} true;
    call $tmp18 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(ID_claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp15 else $tmp16), F$GenericAuthNameSpace.RP.Domain[$tmp17]);
    if ($tmp18)
    {
        if ($TypeConstructor($DynamicType(ID_claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
        {
            call $tmp11 := OpenID20NameSpace.IDAssertionEntry.get_UserID(ID_claim_Ref);
        }
        else
        {
            call $tmp12 := GenericAuthNameSpace.ID_Claim.get_UserID(ID_claim_Ref);
        }

        $tmp13 := conclusion;
        assume $tmp13 != null;
        call $tmp14 := System.String.op_Equality$System.String$System.String((if $TypeConstructor($DynamicType(ID_claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp11 else $tmp12), F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp13]);
    }
    else
    {
    }

    assert (if $tmp18 then $tmp14 else false);
}



implementation GenericAuthNameSpace.GlobalObjects_base.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 42} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.GlobalObjects_base.#cctor();



implementation T$GenericAuthNameSpace.GlobalObjects_base.#cctor()
{
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := null;
    F$GenericAuthNameSpace.GlobalObjects_base.IdP := null;
    F$GenericAuthNameSpace.GlobalObjects_base.RP := null;
}



function T$GenericAuthNameSpace.IdP() : Ref;

const unique T$GenericAuthNameSpace.IdP: int;

procedure GenericAuthNameSpace.IdP.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



procedure GenericAuthNameSpace.IdP.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref, Entry$in: Ref) returns ($result: bool);



procedure GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, Realm$in: Ref, _ID_Claim$in: Ref) returns ($result: bool);



procedure GenericAuthNameSpace.IdP.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, _ID_Claim$in: Ref) returns ($result: Ref);



implementation GenericAuthNameSpace.IdP.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var _ID_Claim_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: bool;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: bool;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $tmp17: Ref;
  var $tmp18: Ref;
  var $tmp19: Ref;
  var $tmp20: Ref;
  var $tmp21: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 43} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 61} true;
    if (req == null)
    {
        assume {:breadcrumb 44} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 61} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 45} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 62} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 62} true;
    if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_IdP)
    {
        call $tmp0 := OpenID20NameSpace.OpenIDProvider.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
    }
    else
    {
        if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.OpenIDProvider)
        {
            call $tmp1 := OpenID20NameSpace.OpenIDProvider.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
        }
        else
        {
            call $tmp2 := GenericAuthNameSpace.IdP.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req);
        }
    }

    _ID_Claim_Ref := (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_IdP then $tmp0 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.OpenIDProvider then $tmp1 else $tmp2));
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 63} true;
    assume $this != null;
    if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this])) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def)
    {
        assume $this != null;
        $tmp3 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this];
        $tmp4 := req;
        assume $tmp4 != null;
        if ($TypeConstructor($DynamicType(req)) == T$OpenID20NameSpace.AuthenticationRequest)
        {
            call $tmp5 := OpenID20NameSpace.AuthenticationRequest.get_Realm(req);
        }
        else
        {
            call $tmp6 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(req);
        }

        call $tmp7 := OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp3, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp4], (if $TypeConstructor($DynamicType(req)) == T$OpenID20NameSpace.AuthenticationRequest then $tmp5 else $tmp6), _ID_Claim_Ref);
    }
    else
    {
        assume $this != null;
        $tmp8 := F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this];
        $tmp9 := req;
        assume $tmp9 != null;
        if ($TypeConstructor($DynamicType(req)) == T$OpenID20NameSpace.AuthenticationRequest)
        {
            call $tmp10 := OpenID20NameSpace.AuthenticationRequest.get_Realm(req);
        }
        else
        {
            call $tmp11 := GenericAuthNameSpace.SignInIdP_Req.get_Realm(req);
        }

        call $tmp12 := GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($tmp8, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp9], (if $TypeConstructor($DynamicType(req)) == T$OpenID20NameSpace.AuthenticationRequest then $tmp10 else $tmp11), _ID_Claim_Ref);
    }

    if (!(if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this])) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def then $tmp7 else $tmp12))
    {
        assume {:breadcrumb 46} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 64} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 47} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 65} true;
    if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_IdP)
    {
        if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
        {
            call $tmp13 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(_ID_Claim_Ref);
        }
        else
        {
            call $tmp14 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(_ID_Claim_Ref);
        }

        call $tmp15 := OpenID20NameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp13 else $tmp14), _ID_Claim_Ref);
    }
    else
    {
        if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.OpenIDProvider)
        {
            if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
            {
                call $tmp16 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(_ID_Claim_Ref);
            }
            else
            {
                call $tmp17 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(_ID_Claim_Ref);
            }

            call $tmp18 := OpenID20NameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp16 else $tmp17), _ID_Claim_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
            {
                call $tmp19 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(_ID_Claim_Ref);
            }
            else
            {
                call $tmp20 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(_ID_Claim_Ref);
            }

            call $tmp21 := GenericAuthNameSpace.IdP.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp19 else $tmp20), _ID_Claim_Ref);
        }
    }

    $result := (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_IdP then $tmp15 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.OpenIDProvider then $tmp18 else $tmp21));
    return;
}



implementation GenericAuthNameSpace.IdP.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this] := null;
    assume {:breadcrumb 48} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.IdP.#cctor();



implementation T$GenericAuthNameSpace.IdP.#cctor()
{
}



function T$GenericAuthNameSpace.ID_Claim() : Ref;

const unique T$GenericAuthNameSpace.ID_Claim: int;

implementation GenericAuthNameSpace.ID_Claim.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 49} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.ID_Claim.#cctor();



implementation T$GenericAuthNameSpace.ID_Claim.#cctor()
{
}



function T$GenericAuthNameSpace.SignInRP_Resp() : Ref;

const unique T$GenericAuthNameSpace.SignInRP_Resp: int;

procedure GenericAuthNameSpace.SignInRP_Resp.#ctor($this: Ref);



procedure {:extern} CST.CST_Struct.#ctor($this: Ref);



implementation GenericAuthNameSpace.SignInRP_Resp.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 50} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.SignInRP_Resp.#cctor();



implementation T$GenericAuthNameSpace.SignInRP_Resp.#cctor()
{
}



function T$GenericAuthNameSpace.IdPAuthRecords_Base() : Ref;

const unique T$GenericAuthNameSpace.IdPAuthRecords_Base: int;

function T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req() : Ref;

const unique T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req: int;

implementation GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 51} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor();



implementation T$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#cctor()
{
}



function T$GenericAuthNameSpace.SignInIdP_Req() : Ref;

const unique T$GenericAuthNameSpace.SignInIdP_Req: int;

implementation GenericAuthNameSpace.SignInIdP_Req.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$this] := null;
    assume {:breadcrumb 52} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.SignInIdP_Req.#cctor();



implementation T$GenericAuthNameSpace.SignInIdP_Req.#cctor()
{
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
  var $localExc: Ref;
  var $label: int;

    conclusion := conclusion$in;
    assume {:breadcrumb 53} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 83} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 83} true;
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

    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 83} true;
    call System.Web.SessionState.HttpSessionState.set_Item$System.String$System.Object($tmp1, $string_literal_UserID_5, (if CST_verified_bool then F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp2] else $string_literal__6));
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 85} true;
    $result := CST_verified_bool;
    return;
}



implementation GenericAuthNameSpace.RP.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.RP.CurrentSession[$this] := null;
    F$GenericAuthNameSpace.RP.Domain[$this] := null;
    F$GenericAuthNameSpace.RP.Realm[$this] := null;
    assume {:breadcrumb 54} true;
    call System.Object.#ctor($this);
}



implementation GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$this] := null;
    assume {:breadcrumb 55} true;
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



implementation OpenIDExample.LogIn.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref)
{
  var sender: Ref;
  var e: Ref;
  var mode_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: bool;
  var d_Ref: Ref;
  var $tmp4: Ref;
  var resp_Ref: Ref;
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
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 56} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 20} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 20} true;
    call $tmp0 := System.Web.UI.Page.get_Request($this);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 20} true;
    call $tmp1 := System.Web.HttpRequest.get_Params($tmp0);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 20} true;
    call $tmp2 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp1, $string_literal_openid.mode_7);
    mode_Ref := $tmp2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 22} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 22} true;
    call $tmp3 := System.String.IsNullOrEmpty$System.String(mode_Ref);
    if (!$tmp3)
    {
        assume {:breadcrumb 57} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 24} true;
        call $tmp4 := Alloc();
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 24} true;
        call GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($tmp4);
        assume $DynamicType($tmp4) == T$GenericAuthNameSpace.RP.AuthenticationConclusion();
        assume $TypeConstructor($DynamicType($tmp4)) == T$GenericAuthNameSpace.RP.AuthenticationConclusion;
        d_Ref := $tmp4;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 26} true;
        assume $this != null;
        $tmp5 := F$OpenIDExample.LogIn.RP[$this];
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 26} true;
        call $tmp6 := System.Web.UI.Page.get_Request($this);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 26} true;
        call $tmp7 := OpenID20NameSpace.RelyingParty.parseAuthenticationResponse$System.Web.HttpRequest($tmp5, $tmp6);
        resp_Ref := $tmp7;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 27} true;
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 27} true;
        assume $this != null;
        $tmp8 := F$OpenIDExample.LogIn.RP[$this];
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 27} true;
        call $tmp9 := OpenID20NameSpace.RelyingParty.conclude$OpenID20NameSpace.AuthenticationResponse($tmp8, resp_Ref);
        d_Ref := $tmp9;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 29} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$OpenIDExample.LogIn)
        {
            assume {:breadcrumb 59} true;
            assume $this != null;
            $tmp10 := F$OpenIDExample.LogIn.notLoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp10, false);
        }
        else
        {
            assume {:breadcrumb 60} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.Page)
            {
                assume {:breadcrumb 61} true;
                assume $this != null;
                $tmp11 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                call System.Web.UI.Page.set_Visible$System.Boolean($tmp11, false);
            }
            else
            {
                assume {:breadcrumb 62} true;
                assume $this != null;
                if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.TemplateControl)
                {
                    assume {:breadcrumb 63} true;
                    assume $this != null;
                    $tmp12 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                    call System.Web.UI.Control.set_Visible$System.Boolean($tmp12, false);
                }
                else
                {
                    assume {:breadcrumb 64} true;
                    assume $this != null;
                    $tmp13 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                    call System.Web.UI.Control.set_Visible$System.Boolean($tmp13, false);
                }
            }
        }

        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 30} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$OpenIDExample.LogIn)
        {
            assume {:breadcrumb 65} true;
            assume $this != null;
            $tmp14 := F$OpenIDExample.LogIn.LoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp14, true);
        }
        else
        {
            assume {:breadcrumb 66} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.Page)
            {
                assume {:breadcrumb 67} true;
                assume $this != null;
                $tmp15 := F$OpenIDExample.LogIn.LoggedIn[$this];
                call System.Web.UI.Page.set_Visible$System.Boolean($tmp15, true);
            }
            else
            {
                assume {:breadcrumb 68} true;
                assume $this != null;
                if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.TemplateControl)
                {
                    assume {:breadcrumb 69} true;
                    assume $this != null;
                    $tmp16 := F$OpenIDExample.LogIn.LoggedIn[$this];
                    call System.Web.UI.Control.set_Visible$System.Boolean($tmp16, true);
                }
                else
                {
                    assume {:breadcrumb 70} true;
                    assume $this != null;
                    $tmp17 := F$OpenIDExample.LogIn.LoggedIn[$this];
                    call System.Web.UI.Control.set_Visible$System.Boolean($tmp17, true);
                }
            }
        }

        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 32} true;
        assume $this != null;
        $tmp18 := F$OpenIDExample.LogIn.logged_id[$this];
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 32} true;
        call $tmp19 := System.Web.UI.Page.get_Request($this);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 32} true;
        call $tmp20 := System.Web.HttpRequest.get_Params($tmp19);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 32} true;
        call $tmp21 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp20, $string_literal_openid.identity_9);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 32} true;
        call $tmp22 := System.Web.UI.Page.get_Request($this);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 32} true;
        call $tmp23 := System.Web.HttpRequest.get_Params($tmp22);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 32} true;
        call $tmp24 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp23, $string_literal_SymT_4);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 32} true;
        call $tmp25 := System.String.Format$System.String$System.Object$System.Object($string_literal_Your$ID$is$$0$$and$SymT$is$$1$_8, $tmp21, $tmp24);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 32} true;
        call System.Web.UI.HtmlControls.HtmlContainerControl.set_InnerHtml$System.String($tmp18, $tmp25);
        return;
    }
    else
    {
        assume {:breadcrumb 58} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 39} true;
    assume $this != null;
    if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$OpenIDExample.LogIn)
    {
        assume {:breadcrumb 71} true;
        assume $this != null;
        $tmp26 := F$OpenIDExample.LogIn.notLoggedIn[$this];
        call System.Web.UI.Page.set_Visible$System.Boolean($tmp26, true);
    }
    else
    {
        assume {:breadcrumb 72} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.Page)
        {
            assume {:breadcrumb 73} true;
            assume $this != null;
            $tmp27 := F$OpenIDExample.LogIn.notLoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp27, true);
        }
        else
        {
            assume {:breadcrumb 74} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.TemplateControl)
            {
                assume {:breadcrumb 75} true;
                assume $this != null;
                $tmp28 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp28, true);
            }
            else
            {
                assume {:breadcrumb 76} true;
                assume $this != null;
                $tmp29 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp29, true);
            }
        }
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 40} true;
    assume $this != null;
    if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$OpenIDExample.LogIn)
    {
        assume {:breadcrumb 77} true;
        assume $this != null;
        $tmp30 := F$OpenIDExample.LogIn.LoggedIn[$this];
        call System.Web.UI.Page.set_Visible$System.Boolean($tmp30, false);
    }
    else
    {
        assume {:breadcrumb 78} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.Page)
        {
            assume {:breadcrumb 79} true;
            assume $this != null;
            $tmp31 := F$OpenIDExample.LogIn.LoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp31, false);
        }
        else
        {
            assume {:breadcrumb 80} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.TemplateControl)
            {
                assume {:breadcrumb 81} true;
                assume $this != null;
                $tmp32 := F$OpenIDExample.LogIn.LoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp32, false);
            }
            else
            {
                assume {:breadcrumb 82} true;
                assume $this != null;
                $tmp33 := F$OpenIDExample.LogIn.LoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp33, false);
            }
        }
    }
}



procedure OpenIDExample.LogIn.LoginBtn_Click$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



const {:value "ProcessAuthenticationRequest"} unique $string_literal_ProcessAuthenticationRequest_10: Ref;

procedure {:extern} System.Type.GetMethod$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



procedure {:extern} CST.CST_Ops.recordme$System.Object$CST.CST_Struct$System.Reflection.MethodInfo(o$in: Ref, msg$in: Ref, mi$in: Ref);



procedure OpenID20NameSpace.Yahoo_RP.GenerateURL$OpenID20NameSpace.AuthenticationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} System.Web.UI.Page.get_Response($this: Ref) returns ($result: Ref);



procedure {:extern} System.Web.HttpResponse.Redirect$System.String($this: Ref, url$in: Ref);



implementation OpenIDExample.LogIn.LoginBtn_Click$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref)
{
  var sender: Ref;
  var e: Ref;
  var req_Ref: Ref;
  var $tmp0: Ref;
  var resp_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var new_resq_Ref: Ref;
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
  var final_url_Ref: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $tmp16: Ref;
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 83} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 81} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 81} true;
    call OpenID20NameSpace.AuthenticationResponse.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.AuthenticationResponse();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.AuthenticationResponse;
    req_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 83} true;
    assume $this != null;
    $tmp1 := F$OpenIDExample.LogIn.RP[$this];
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 83} true;
    call $tmp2 := OpenID20NameSpace.RelyingParty.RequestAuthentication$OpenID20NameSpace.AuthenticationResponse($tmp1, req_Ref);
    resp_Ref := $tmp2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 86} true;
    call $tmp3 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 86} true;
    call OpenID20NameSpace.AuthenticationRequest.#ctor($tmp3);
    assume $DynamicType($tmp3) == T$OpenID20NameSpace.AuthenticationRequest();
    assume $TypeConstructor($DynamicType($tmp3)) == T$OpenID20NameSpace.AuthenticationRequest;
    new_resq_Ref := $tmp3;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 87} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 87} true;
    $tmp4 := resp_Ref;
    assume $tmp4 != null;
    F$CST.CST_Struct.SymT[new_resq_Ref] := F$CST.CST_Struct.SymT[$tmp4];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 88} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 88} true;
    $tmp5 := resp_Ref;
    assume $tmp5 != null;
    F$OpenID20NameSpace.AuthenticationRequest.claimed_id[new_resq_Ref] := F$OpenID20NameSpace.AuthenticationRequest.claimed_id[$tmp5];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 89} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 89} true;
    $tmp6 := resp_Ref;
    assume $tmp6 != null;
    F$OpenID20NameSpace.AuthenticationRequest.identity[new_resq_Ref] := F$OpenID20NameSpace.AuthenticationRequest.identity[$tmp6];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 90} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 90} true;
    $tmp7 := resp_Ref;
    assume $tmp7 != null;
    F$OpenID20NameSpace.AuthenticationRequest.return_to[new_resq_Ref] := F$OpenID20NameSpace.AuthenticationRequest.return_to[$tmp7];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 91} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 91} true;
    $tmp8 := resp_Ref;
    assume $tmp8 != null;
    F$OpenID20NameSpace.AuthenticationRequest.realm[new_resq_Ref] := F$OpenID20NameSpace.AuthenticationRequest.realm[$tmp8];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 92} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 92} true;
    $tmp9 := resp_Ref;
    assume $tmp9 != null;
    F$OpenID20NameSpace.AuthenticationRequest.ns[new_resq_Ref] := F$OpenID20NameSpace.AuthenticationRequest.ns[$tmp9];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 93} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 93} true;
    $tmp10 := resp_Ref;
    assume $tmp10 != null;
    F$OpenID20NameSpace.AuthenticationRequest.mode[new_resq_Ref] := F$OpenID20NameSpace.AuthenticationRequest.mode[$tmp10];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 94} true;
    call $tmp11 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 94} true;
    call OpenID20NameSpace.Yahoo_IdP.#ctor($tmp11);
    assume $DynamicType($tmp11) == T$OpenID20NameSpace.Yahoo_IdP();
    assume $TypeConstructor($DynamicType($tmp11)) == T$OpenID20NameSpace.Yahoo_IdP;
    $tmp12 := T$OpenID20NameSpace.Yahoo_IdP();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 94} true;
    call $tmp13 := System.Type.GetMethod$System.String($tmp12, $string_literal_ProcessAuthenticationRequest_10);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 94} true;
    call CST.CST_Ops.recordme$System.Object$CST.CST_Struct$System.Reflection.MethodInfo($tmp11, new_resq_Ref, $tmp13);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 96} true;
    assume $this != null;
    $tmp14 := F$OpenIDExample.LogIn.RP[$this];
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 96} true;
    call $tmp15 := OpenID20NameSpace.Yahoo_RP.GenerateURL$OpenID20NameSpace.AuthenticationRequest($tmp14, new_resq_Ref);
    final_url_Ref := $tmp15;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 98} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 98} true;
    call $tmp16 := System.Web.UI.Page.get_Response($this);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 98} true;
    call System.Web.HttpResponse.Redirect$System.String($tmp16, final_url_Ref);
}



procedure OpenIDExample.LogIn.LogoutBtn_Click$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



implementation OpenIDExample.LogIn.LogoutBtn_Click$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref)
{
  var sender: Ref;
  var e: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 84} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 103} true;
    assume $this != null;
    if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$OpenIDExample.LogIn)
    {
        assume {:breadcrumb 85} true;
        assume $this != null;
        $tmp0 := F$OpenIDExample.LogIn.notLoggedIn[$this];
        call System.Web.UI.Page.set_Visible$System.Boolean($tmp0, true);
    }
    else
    {
        assume {:breadcrumb 86} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.Page)
        {
            assume {:breadcrumb 87} true;
            assume $this != null;
            $tmp1 := F$OpenIDExample.LogIn.notLoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp1, true);
        }
        else
        {
            assume {:breadcrumb 88} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.TemplateControl)
            {
                assume {:breadcrumb 89} true;
                assume $this != null;
                $tmp2 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp2, true);
            }
            else
            {
                assume {:breadcrumb 90} true;
                assume $this != null;
                $tmp3 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp3, true);
            }
        }
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 104} true;
    assume $this != null;
    if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$OpenIDExample.LogIn)
    {
        assume {:breadcrumb 91} true;
        assume $this != null;
        $tmp4 := F$OpenIDExample.LogIn.LoggedIn[$this];
        call System.Web.UI.Page.set_Visible$System.Boolean($tmp4, false);
    }
    else
    {
        assume {:breadcrumb 92} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.Page)
        {
            assume {:breadcrumb 93} true;
            assume $this != null;
            $tmp5 := F$OpenIDExample.LogIn.LoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp5, false);
        }
        else
        {
            assume {:breadcrumb 94} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.TemplateControl)
            {
                assume {:breadcrumb 95} true;
                assume $this != null;
                $tmp6 := F$OpenIDExample.LogIn.LoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp6, false);
            }
            else
            {
                assume {:breadcrumb 96} true;
                assume $this != null;
                $tmp7 := F$OpenIDExample.LogIn.LoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp7, false);
            }
        }
    }
}



procedure OpenIDExample.LogIn.#ctor($this: Ref);



const {:value "http://localhost:32928/LogIn.aspx"} unique $string_literal_http$$$localhost$32928$LogIn.aspx_11: Ref;

const {:value "https://open.login.yahooapis.com/openid/op/auth"} unique $string_literal_https$$$open.login.yahooapis.com$openid$op$auth_12: Ref;

procedure OpenID20NameSpace.Yahoo_RP.#ctor$System.String$System.String($this: Ref, return_uri$in: Ref, endpointUrl$in: Ref);



procedure {:extern} System.Web.UI.Page.#ctor($this: Ref);



implementation OpenIDExample.LogIn.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$OpenIDExample.LogIn.RP[$this] := null;
    F$OpenIDExample.LogIn.form1[$this] := null;
    F$OpenIDExample.LogIn.notLoggedIn[$this] := null;
    F$OpenIDExample.LogIn.Login[$this] := null;
    F$OpenIDExample.LogIn.LoggedIn[$this] := null;
    F$OpenIDExample.LogIn.logged_id[$this] := null;
    F$OpenIDExample.LogIn.Logout[$this] := null;
    assume {:breadcrumb 97} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 15} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 15} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 15} true;
    call OpenID20NameSpace.Yahoo_RP.#ctor$System.String$System.String($tmp0, $string_literal_http$$$localhost$32928$LogIn.aspx_11, $string_literal_https$$$open.login.yahooapis.com$openid$op$auth_12);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.Yahoo_RP();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.Yahoo_RP;
    F$OpenIDExample.LogIn.RP[$this] := $tmp0;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 15} true;
    call System.Web.UI.Page.#ctor($this);
}



procedure T$OpenIDExample.LogIn.#cctor();



implementation T$OpenIDExample.LogIn.#cctor()
{
}



implementation OpenID20NameSpace.Yahoo_RP.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 98} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 14} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 14} true;
    call OpenID20NameSpace.RelyingParty.#ctor($this);
}



implementation OpenID20NameSpace.Yahoo_RP.#ctor$System.String$System.String($this: Ref, return_uri$in: Ref, endpointUrl$in: Ref)
{
  var return_uri: Ref;
  var endpointUrl: Ref;
  var $localExc: Ref;
  var $label: int;

    return_uri := return_uri$in;
    endpointUrl := endpointUrl$in;
    assume {:breadcrumb 99} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 19} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 19} true;
    call OpenID20NameSpace.RelyingParty.#ctor($this);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 21} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 21} true;
    call OpenID20NameSpace.RelyingParty.set_return_uri$System.String($this, return_uri);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 22} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 22} true;
    F$OpenID20NameSpace.RelyingParty.endpointUrl[$this] := endpointUrl;
}



procedure OpenID20NameSpace.Yahoo_RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.Yahoo_RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 100} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 27} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 27} true;
    call GenericAuthNameSpace.SignInRP_Resp.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$GenericAuthNameSpace.SignInRP_Resp();
    assume $TypeConstructor($DynamicType($tmp0)) == T$GenericAuthNameSpace.SignInRP_Resp;
    $result := $tmp0;
    return;
}



procedure OpenID20NameSpace.Yahoo_RP.SignIn($this: Ref);



implementation OpenID20NameSpace.Yahoo_RP.SignIn($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 101} true;
}



procedure {:extern} System.Text.StringBuilder.#ctor$System.String($this: Ref, value$in: Ref);



function {:extern} T$System.Text.StringBuilder() : Ref;

const {:extern} unique T$System.Text.StringBuilder: int;

axiom $TypeConstructor(T$System.Text.StringBuilder()) == T$System.Text.StringBuilder;

const {:value "?openid.claimed_id={0}&openid.identity={1}&openid.return_to={2}?SymT={6}&openid.realm={5}&openid.mode={3}&openid.ns={4}"} unique $string_literal_?openid.claimed_id$$0$$openid.identity$$1$$openid.return_to$$2$?SymT$$6$$openid.realm$$5$$openid.mode$$3$$openid.ns$$4$_13: Ref;

procedure {:extern} System.Text.StringBuilder.AppendFormat$System.String$System.Objectarray($this: Ref, format$in: Ref, args$in: Ref) returns ($result: Ref);



procedure {:extern} System.Object.ToString($this: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.Yahoo_RP.GenerateURL$OpenID20NameSpace.AuthenticationRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var sb_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 102} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 36} true;
    call $tmp0 := Alloc();
    assume $this != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 36} true;
    call System.Text.StringBuilder.#ctor$System.String($tmp0, F$OpenID20NameSpace.RelyingParty.endpointUrl[$this]);
    assume $DynamicType($tmp0) == T$System.Text.StringBuilder();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Text.StringBuilder;
    sb_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 38} true;
    call $tmp1 := Alloc();
    assume $ArrayLength($tmp1) == 1 * 7;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 38} true;
    call $tmp2 := System.Text.StringBuilder.AppendFormat$System.String$System.Objectarray(sb_Ref, $string_literal_?openid.claimed_id$$0$$openid.identity$$1$$openid.return_to$$2$?SymT$$6$$openid.realm$$5$$openid.mode$$3$$openid.ns$$4$_13, $tmp1);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 40} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 40} true;
    call $tmp3 := System.Object.ToString(sb_Ref);
    $result := $tmp3;
    return;
}



procedure OpenID20NameSpace.Yahoo_RP.GenerateURL$OpenID20NameSpace.AuthenticationResponse($this: Ref, req$in: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.Yahoo_RP.GenerateURL$OpenID20NameSpace.AuthenticationResponse($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var sb_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 103} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 44} true;
    call $tmp0 := Alloc();
    assume $this != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 44} true;
    call System.Text.StringBuilder.#ctor$System.String($tmp0, F$OpenID20NameSpace.RelyingParty.endpointUrl[$this]);
    assume $DynamicType($tmp0) == T$System.Text.StringBuilder();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Text.StringBuilder;
    sb_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 46} true;
    call $tmp1 := Alloc();
    assume $ArrayLength($tmp1) == 1 * 7;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 46} true;
    call $tmp2 := System.Text.StringBuilder.AppendFormat$System.String$System.Objectarray(sb_Ref, $string_literal_?openid.claimed_id$$0$$openid.identity$$1$$openid.return_to$$2$?SymT$$6$$openid.realm$$5$$openid.mode$$3$$openid.ns$$4$_13, $tmp1);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 48} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 48} true;
    call $tmp3 := System.Object.ToString(sb_Ref);
    $result := $tmp3;
    return;
}



procedure OpenID20NameSpace.Yahoo_RP.callProcessAuthenticationRequest$OpenID20NameSpace.AuthenticationRequest($this: Ref, req$in: Ref) returns ($result: Ref);



const {:value "ProcessAuthenticationRequestS"} unique $string_literal_ProcessAuthenticationRequestS_14: Ref;

implementation OpenID20NameSpace.Yahoo_RP.callProcessAuthenticationRequest$OpenID20NameSpace.AuthenticationRequest($this: Ref, req$in: Ref) returns ($result: Ref)
{
  var req: Ref;
  var tr_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

    req := req$in;
    assume {:breadcrumb 104} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 53} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 53} true;
    call $tmp0 := OpenID20NameSpace.RelyingParty.callProcessAuthenticationRequest$OpenID20NameSpace.AuthenticationRequest($this, req);
    tr_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 55} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 55} true;
    $tmp1 := req;
    assume $tmp1 != null;
    F$CST.CST_Struct.SymT[tr_Ref] := F$CST.CST_Struct.SymT[$tmp1];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 56} true;
    call $tmp2 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 56} true;
    call OpenID20NameSpace.Yahoo_IdP.#ctor($tmp2);
    assume $DynamicType($tmp2) == T$OpenID20NameSpace.Yahoo_IdP();
    assume $TypeConstructor($DynamicType($tmp2)) == T$OpenID20NameSpace.Yahoo_IdP;
    $tmp3 := T$OpenID20NameSpace.OpenIDProvider();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 56} true;
    call $tmp4 := System.Type.GetMethod$System.String($tmp3, $string_literal_ProcessAuthenticationRequestS_14);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 56} true;
    call CST.CST_Ops.recordme$System.Object$CST.CST_Struct$System.Reflection.MethodInfo($tmp2, tr_Ref, $tmp4);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 58} true;
    $result := tr_Ref;
    return;
}



procedure T$OpenID20NameSpace.Yahoo_RP.#cctor();



implementation T$OpenID20NameSpace.Yahoo_RP.#cctor()
{
}



function T$CST.Nondet_Base() : Ref;

const unique T$CST.Nondet_Base: int;

procedure CST.Nondet_Base.Int($this: Ref) returns ($result: int);



procedure CST.Nondet_Base.String($this: Ref) returns ($result: Ref);



procedure CST.Nondet_Base.Bool($this: Ref) returns ($result: bool);



function T$CST.Debug() : Ref;

const unique T$CST.Debug: int;

procedure CST.Debug.reached();



implementation CST.Debug.reached()
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 105} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 22} true;
    assert false;
}



procedure CST.Debug.#ctor($this: Ref);



implementation CST.Debug.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 106} true;
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
    assume {:breadcrumb 107} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 15} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 15} true;
    F$CST.CST_Struct.SymT[$this] := $string_literal__6;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 16} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 16} true;
    F$CST.CST_Struct.SignedBy[$this] := $string_literal__6;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 16} true;
    call System.Object.#ctor($this);
}



procedure T$CST.CST_Struct.#cctor();



implementation T$CST.CST_Struct.#cctor()
{
}



var F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary: [Ref]Ref;

implementation OpenID20NameSpace.Yahoo_IdP.init($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 108} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 15} true;
    assume $this != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 15} true;
    call OpenID20NameSpace.OpenIDProvider.init$OpenID20NameSpace.IDAssertionRecs($this, F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary[$this]);
}



procedure OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#ctor($this: Ref);



implementation OpenID20NameSpace.Yahoo_IdP.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary[$this] := null;
    assume {:breadcrumb 109} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 18} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 18} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 18} true;
    call OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def;
    F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary[$this] := $tmp0;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 18} true;
    call OpenID20NameSpace.OpenIDProvider.#ctor($this);
}



var F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary: [Ref]Ref;

procedure {:extern} System.Collections.Generic.Dictionary`2.get_Item$`0($this: Ref, key$in: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref) returns ($result: Ref)
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
    assume {:breadcrumb 110} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 25} true;
    assume $this != null;
    $tmp0 := F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$this];
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 25} true;
    call $tmp2 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp0, IdPSessionSecret);
    $tmp1 := $tmp2;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 25} true;
    call $tmp4 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp1, client_id);
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

procedure {:extern} System.Collections.Generic.Dictionary`2.set_Item$`0$`1($this: Ref, key$in: Ref, value$in: Ref);



implementation OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref, Entry$in: Ref) returns ($result: bool)
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
    assume {:breadcrumb 111} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 29} true;
    IDTokenAndAccessTokenEntry_Ref := Entry;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 30} true;
    if (IDTokenAndAccessTokenEntry_Ref == null)
    {
        assume {:breadcrumb 112} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 31} true;
        $result := false;
        return;
    }
    else
    {
        assume {:breadcrumb 113} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 32} true;
    assume $this != null;
    $tmp0 := F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$this];
    call $tmp1 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 32} true;
    call System.Collections.Generic.Dictionary`2.#ctor($tmp1);
    assume $DynamicType($tmp1) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OpenID20NameSpace.IDAssertionEntry());
    assume $TypeConstructor($DynamicType($tmp1)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp1)) == T$System.String();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp1)) == T$OpenID20NameSpace.IDAssertionEntry();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 32} true;
    call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp0, IdPSessionSecret, $tmp1);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 33} true;
    assume $this != null;
    $tmp2 := F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$this];
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 33} true;
    call $tmp4 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp2, IdPSessionSecret);
    $tmp3 := $tmp4;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 33} true;
    call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp3, client_id, IDTokenAndAccessTokenEntry_Ref);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 34} true;
    $result := true;
    return;
}



implementation OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$this] := null;
    assume {:breadcrumb 114} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 22} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 22} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 22} true;
    call System.Collections.Generic.Dictionary`2.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OpenID20NameSpace.IDAssertionEntry()));
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.String();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OpenID20NameSpace.IDAssertionEntry());
    F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$this] := $tmp0;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 22} true;
    call System.Object.#ctor($this);
}



procedure T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#cctor();



implementation T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#cctor()
{
}



procedure T$OpenID20NameSpace.Yahoo_IdP.#cctor();



implementation T$OpenID20NameSpace.Yahoo_IdP.#cctor()
{
}


