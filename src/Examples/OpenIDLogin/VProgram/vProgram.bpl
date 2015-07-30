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

function T$GlobalObjectsForCST() : Ref;

const unique T$GlobalObjectsForCST: int;

procedure GlobalObjectsForCST.init();



procedure {:extern} OpenID20NameSpace.AuthenticationRequest.#ctor($this: Ref);



function {:extern} T$OpenID20NameSpace.AuthenticationRequest() : Ref;

const {:extern} unique T$OpenID20NameSpace.AuthenticationRequest: int;

axiom $TypeConstructor(T$OpenID20NameSpace.AuthenticationRequest()) == T$OpenID20NameSpace.AuthenticationRequest;

var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req: Ref;

var F$PoirotMain.Nondet: Ref;

procedure {:extern} CST.Nondet_Base.String($this: Ref) returns ($result: Ref);



procedure {:extern} OpenID20NameSpace.AuthenticationRequest.set_Realm$System.String($this: Ref, value$in: Ref);



procedure {:extern} GenericAuthNameSpace.SignInIdP_Req.set_Realm$System.String($this: Ref, value$in: Ref);



var {:extern} F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret: [Ref]Ref;

var {:extern} F$OpenID20NameSpace.AuthenticationRequest.return_to: [Ref]Ref;

var {:extern} F$CST.CST_Struct.SymT: [Ref]Ref;

var {:extern} F$OpenID20NameSpace.AuthenticationRequest.identity: [Ref]Ref;

var {:extern} F$OpenID20NameSpace.AuthenticationRequest.realm: [Ref]Ref;

procedure {:extern} OpenID20NameSpace.Yahoo_IdP.#ctor($this: Ref);



function {:extern} T$OpenID20NameSpace.Yahoo_IdP() : Ref;

const {:extern} unique T$OpenID20NameSpace.Yahoo_IdP: int;

axiom $TypeConstructor(T$OpenID20NameSpace.Yahoo_IdP()) == T$OpenID20NameSpace.Yahoo_IdP;

var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.IdP: Ref;

procedure {:extern} OpenID20NameSpace.Yahoo_IdP.init($this: Ref);



procedure LiveIDNameSpace.Yahoo_RP_For_vProgram.#ctor($this: Ref);



function T$LiveIDNameSpace.Yahoo_RP_For_vProgram() : Ref;

const unique T$LiveIDNameSpace.Yahoo_RP_For_vProgram: int;

var {:extern} F$GenericAuthNameSpace.GlobalObjects_base.RP: Ref;

implementation GlobalObjectsForCST.init()
{
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
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 0} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 10} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 10} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 10} true;
    call OpenID20NameSpace.AuthenticationRequest.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.AuthenticationRequest();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.AuthenticationRequest;
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 11} true;
    if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req)) == T$OpenID20NameSpace.AuthenticationRequest)
    {
        assume {:breadcrumb 1} true;
        call $tmp1 := CST.Nondet_Base.String(F$PoirotMain.Nondet);
        call OpenID20NameSpace.AuthenticationRequest.set_Realm$System.String(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req, $tmp1);
    }
    else
    {
        assume {:breadcrumb 2} true;
        call $tmp2 := CST.Nondet_Base.String(F$PoirotMain.Nondet);
        call GenericAuthNameSpace.SignInIdP_Req.set_Realm$System.String(F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req, $tmp2);
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 12} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 12} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 12} true;
    call $tmp3 := CST.Nondet_Base.String(F$PoirotMain.Nondet);
    F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req] := $tmp3;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 13} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 13} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 13} true;
    call $tmp4 := CST.Nondet_Base.String(F$PoirotMain.Nondet);
    F$OpenID20NameSpace.AuthenticationRequest.return_to[F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req] := $tmp4;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 14} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 14} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 14} true;
    call $tmp5 := CST.Nondet_Base.String(F$PoirotMain.Nondet);
    F$CST.CST_Struct.SymT[F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req] := $tmp5;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 15} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 15} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 15} true;
    call $tmp6 := CST.Nondet_Base.String(F$PoirotMain.Nondet);
    F$OpenID20NameSpace.AuthenticationRequest.identity[F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req] := $tmp6;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 16} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 16} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 16} true;
    call $tmp7 := CST.Nondet_Base.String(F$PoirotMain.Nondet);
    F$OpenID20NameSpace.AuthenticationRequest.realm[F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req] := $tmp7;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 17} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 17} true;
    call $tmp8 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 17} true;
    call OpenID20NameSpace.Yahoo_IdP.#ctor($tmp8);
    assume $DynamicType($tmp8) == T$OpenID20NameSpace.Yahoo_IdP();
    assume $TypeConstructor($DynamicType($tmp8)) == T$OpenID20NameSpace.Yahoo_IdP;
    F$GenericAuthNameSpace.GlobalObjects_base.IdP := $tmp8;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 17} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 17} true;
    call OpenID20NameSpace.Yahoo_IdP.init(F$GenericAuthNameSpace.GlobalObjects_base.IdP);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 18} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 18} true;
    call $tmp9 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 18} true;
    call LiveIDNameSpace.Yahoo_RP_For_vProgram.#ctor($tmp9);
    assume $DynamicType($tmp9) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram();
    assume $TypeConstructor($DynamicType($tmp9)) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram;
    F$GenericAuthNameSpace.GlobalObjects_base.RP := $tmp9;
}



procedure GlobalObjectsForCST.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.GlobalObjects_base.#ctor($this: Ref);



implementation GlobalObjectsForCST.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 3} true;
    call GenericAuthNameSpace.GlobalObjects_base.#ctor($this);
}



procedure T$GlobalObjectsForCST.#cctor();



implementation T$GlobalObjectsForCST.#cctor()
{
}



function T$PoirotMain() : Ref;

const unique T$PoirotMain: int;

procedure {:entrypoint} PoirotMain.Main();



procedure SynthesizedPortion.SynthesizedSequence();



implementation PoirotMain.Main()
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 4} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 27} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 27} true;
    call GlobalObjectsForCST.init();
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 28} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Program.cs"} {:sourceLine 28} true;
    call SynthesizedPortion.SynthesizedSequence();
}



procedure PoirotMain.#ctor($this: Ref);



procedure {:extern} System.Object.#ctor($this: Ref);



implementation PoirotMain.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 5} true;
    call System.Object.#ctor($this);
}



procedure T$PoirotMain.#cctor();



implementation T$PoirotMain.#cctor()
{
    F$PoirotMain.Nondet := null;
}



function T$SynthesizedPortion() : Ref;

const unique T$SynthesizedPortion: int;

procedure {:extern} OpenID20NameSpace.NondetOpenID20.SignInIdP_Req($this: Ref) returns ($result: Ref);



procedure {:extern} OpenID20NameSpace.OpenIDProvider.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req1$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.IdP.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



function {:extern} T$OpenID20NameSpace.OpenIDProvider() : Ref;

const {:extern} unique T$OpenID20NameSpace.OpenIDProvider: int;

axiom $TypeConstructor(T$OpenID20NameSpace.OpenIDProvider()) == T$OpenID20NameSpace.OpenIDProvider;

procedure {:extern} OpenID20NameSpace.RelyingParty.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req1$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



function {:extern} T$OpenID20NameSpace.RelyingParty() : Ref;

const {:extern} unique T$OpenID20NameSpace.RelyingParty: int;

axiom $TypeConstructor(T$OpenID20NameSpace.RelyingParty()) == T$OpenID20NameSpace.RelyingParty;

function {:extern} T$OpenID20NameSpace.Yahoo_RP() : Ref;

const {:extern} unique T$OpenID20NameSpace.Yahoo_RP: int;

axiom $TypeConstructor(T$OpenID20NameSpace.Yahoo_RP()) == T$OpenID20NameSpace.Yahoo_RP;

implementation SynthesizedPortion.SynthesizedSequence()
{
  var G1_Ref: Ref;
  var $tmp0: Ref;
  var G2_Ref: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var G3_Ref: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 6} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 6} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 6} true;
    call $tmp0 := OpenID20NameSpace.NondetOpenID20.SignInIdP_Req(F$PoirotMain.Nondet);
    G1_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 7} true;
    if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.IdP)) == T$OpenID20NameSpace.Yahoo_IdP)
    {
        call $tmp1 := OpenID20NameSpace.OpenIDProvider.SignInIdP$GenericAuthNameSpace.SignInIdP_Req(F$GenericAuthNameSpace.GlobalObjects_base.IdP, G1_Ref);
    }
    else
    {
        if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.IdP)) == T$OpenID20NameSpace.OpenIDProvider)
        {
            call $tmp2 := OpenID20NameSpace.OpenIDProvider.SignInIdP$GenericAuthNameSpace.SignInIdP_Req(F$GenericAuthNameSpace.GlobalObjects_base.IdP, G1_Ref);
        }
        else
        {
            call $tmp3 := GenericAuthNameSpace.IdP.SignInIdP$GenericAuthNameSpace.SignInIdP_Req(F$GenericAuthNameSpace.GlobalObjects_base.IdP, G1_Ref);
        }
    }

    G2_Ref := (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.IdP)) == T$OpenID20NameSpace.Yahoo_IdP then $tmp1 else (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.IdP)) == T$OpenID20NameSpace.OpenIDProvider then $tmp2 else $tmp3));
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\SynthesizedPortion.cs"} {:sourceLine 8} true;
    if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.RP)) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram)
    {
        call $tmp4 := OpenID20NameSpace.RelyingParty.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req(F$GenericAuthNameSpace.GlobalObjects_base.RP, G2_Ref);
    }
    else
    {
        if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.RP)) == T$OpenID20NameSpace.Yahoo_RP)
        {
            call $tmp5 := OpenID20NameSpace.RelyingParty.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req(F$GenericAuthNameSpace.GlobalObjects_base.RP, G2_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.RP)) == T$OpenID20NameSpace.RelyingParty)
            {
                call $tmp6 := OpenID20NameSpace.RelyingParty.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req(F$GenericAuthNameSpace.GlobalObjects_base.RP, G2_Ref);
            }
            else
            {
                call $tmp7 := GenericAuthNameSpace.RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req(F$GenericAuthNameSpace.GlobalObjects_base.RP, G2_Ref);
            }
        }
    }

    G3_Ref := (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.RP)) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram then $tmp4 else (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.RP)) == T$OpenID20NameSpace.Yahoo_RP then $tmp5 else (if $TypeConstructor($DynamicType(F$GenericAuthNameSpace.GlobalObjects_base.RP)) == T$OpenID20NameSpace.RelyingParty then $tmp6 else $tmp7)));
}



procedure SynthesizedPortion.#ctor($this: Ref);



implementation SynthesizedPortion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 7} true;
    call System.Object.#ctor($this);
}



procedure T$SynthesizedPortion.#cctor();



implementation T$SynthesizedPortion.#cctor()
{
}



procedure LiveIDNameSpace.Yahoo_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool);



procedure {:extern} GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson$GenericAuthNameSpace.RP.AuthenticationConclusion(conclusion$in: Ref);



implementation LiveIDNameSpace.Yahoo_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool)
{
  var conclusion: Ref;
  var $localExc: Ref;
  var $label: int;

    conclusion := conclusion$in;
    assume {:breadcrumb 8} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Assertion.cs"} {:sourceLine 11} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Assertion.cs"} {:sourceLine 11} true;
    call GenericAuthNameSpace.GlobalObjects_base.Assert_BadPersonCannotSignInAsGoodPerson$GenericAuthNameSpace.RP.AuthenticationConclusion(conclusion);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\VProgram\Assertion.cs"} {:sourceLine 13} true;
    $result := true;
    return;
}



procedure {:extern} OpenID20NameSpace.Yahoo_RP.#ctor($this: Ref);



implementation LiveIDNameSpace.Yahoo_RP_For_vProgram.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 9} true;
    call OpenID20NameSpace.Yahoo_RP.#ctor($this);
}



procedure T$LiveIDNameSpace.Yahoo_RP_For_vProgram.#cctor();



implementation T$LiveIDNameSpace.Yahoo_RP_For_vProgram.#cctor()
{
}



function T$OpenID20NameSpace.IDAssertionEntry() : Ref;

const unique T$OpenID20NameSpace.IDAssertionEntry: int;

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

    assume {:breadcrumb 10} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 57} true;
    assume $this != null;
    $result := F$OpenID20NameSpace.IDAssertionEntry.openid_return_to[$this];
    return;
}



procedure OpenID20NameSpace.IDAssertionEntry.get_UserID($this: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.IDAssertionEntry.get_UserID($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 11} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 61} true;
    assume $this != null;
    $result := F$OpenID20NameSpace.IDAssertionEntry.openid_claimed_id[$this];
    return;
}



procedure OpenID20NameSpace.IDAssertionEntry.AssumeType$OpenID20NameSpace.IDAssertionEntry(in_obj$in: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.IDAssertionEntry.#ctor($this: Ref);



implementation OpenID20NameSpace.IDAssertionEntry.AssumeType$OpenID20NameSpace.IDAssertionEntry(in_obj$in: Ref) returns ($result: Ref)
{
  var in_obj: Ref;
  var out_obj_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $localExc: Ref;
  var $label: int;

    in_obj := in_obj$in;
    assume {:breadcrumb 12} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 66} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 66} true;
    call OpenID20NameSpace.IDAssertionEntry.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.IDAssertionEntry();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.IDAssertionEntry;
    out_obj_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 67} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 67} true;
    $tmp1 := in_obj;
    assume $tmp1 != null;
    F$OpenID20NameSpace.IDAssertionEntry.openid_return_to[out_obj_Ref] := F$OpenID20NameSpace.IDAssertionEntry.openid_return_to[$tmp1];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 68} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 68} true;
    $tmp2 := in_obj;
    assume $tmp2 != null;
    F$OpenID20NameSpace.IDAssertionEntry.openid_claimed_id[out_obj_Ref] := F$OpenID20NameSpace.IDAssertionEntry.openid_claimed_id[$tmp2];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 70} true;
    $result := out_obj_Ref;
    return;
}



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
    assume {:breadcrumb 13} true;
    call GenericAuthNameSpace.ID_Claim.#ctor($this);
}



procedure T$OpenID20NameSpace.IDAssertionEntry.#cctor();



implementation T$OpenID20NameSpace.IDAssertionEntry.#cctor()
{
}



var F$OpenID20NameSpace.AuthenticationRequest.ns: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationRequest.mode: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationRequest.claimed_id: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationRequest.assoc_handle: [Ref]Ref;

var F$OpenID20NameSpace.AuthenticationRequest.endpointURL: [Ref]Ref;

procedure OpenID20NameSpace.AuthenticationRequest.get_Realm($this: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.AuthenticationRequest.get_Realm($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 14} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 26} true;
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
    assume {:breadcrumb 15} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 27} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 27} true;
    F$OpenID20NameSpace.AuthenticationRequest.realm[$this] := value;
}



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
    assume {:breadcrumb 16} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 16} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 16} true;
    F$OpenID20NameSpace.AuthenticationRequest.ns[$this] := $string_literal_http$$$specs.openid.net$auth$2.0_0;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 16} true;
    call GenericAuthNameSpace.SignInIdP_Req.#ctor($this);
}



procedure T$OpenID20NameSpace.AuthenticationRequest.#cctor();



implementation T$OpenID20NameSpace.AuthenticationRequest.#cctor()
{
}



function T$OpenID20NameSpace.NondetOpenID20() : Ref;

const unique T$OpenID20NameSpace.NondetOpenID20: int;

procedure OpenID20NameSpace.NondetOpenID20.SignInIdP_Resp_SignInRP_Req($this: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.NondetOpenID20.AuthenticationRequest($this: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.NondetOpenID20.AuthenticationResponse($this: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.NondetOpenID20.IDAssertionEntry($this: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.NondetOpenID20.IDAssertionRecsDictionary($this: Ref) returns ($result: Ref);



var F$OpenID20NameSpace.RelyingParty.assoc_handle: [Ref]Ref;

var F$OpenID20NameSpace.RelyingParty.endpointUrl: [Ref]Ref;

procedure OpenID20NameSpace.RelyingParty.get_return_uri($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.RP.Domain: [Ref]Ref;

implementation OpenID20NameSpace.RelyingParty.get_return_uri($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 17} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 78} true;
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
    assume {:breadcrumb 18} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 79} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 79} true;
    F$GenericAuthNameSpace.RP.Domain[$this] := value;
}



procedure OpenID20NameSpace.RelyingParty.RequestAuthentication$OpenID20NameSpace.AuthenticationResponse($this: Ref, resp$in: Ref) returns ($result: Ref);



const {:value "http://specs.openid.net/auth/2.0/identifier_select"} unique $string_literal_http$$$specs.openid.net$auth$2.0$identifier_select_1: Ref;

const {:value "checkid_setup"} unique $string_literal_checkid_setup_2: Ref;

implementation OpenID20NameSpace.RelyingParty.RequestAuthentication$OpenID20NameSpace.AuthenticationResponse($this: Ref, resp$in: Ref) returns ($result: Ref)
{
  var resp: Ref;
  var req_Ref: Ref;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    resp := resp$in;
    assume {:breadcrumb 19} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 86} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 86} true;
    call OpenID20NameSpace.AuthenticationRequest.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.AuthenticationRequest();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.AuthenticationRequest;
    req_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 88} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 88} true;
    assume $this != null;
    F$OpenID20NameSpace.AuthenticationRequest.realm[req_Ref] := F$GenericAuthNameSpace.RP.Domain[$this];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 89} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 89} true;
    F$OpenID20NameSpace.AuthenticationRequest.identity[req_Ref] := $string_literal_http$$$specs.openid.net$auth$2.0$identifier_select_1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 90} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 90} true;
    F$OpenID20NameSpace.AuthenticationRequest.ns[req_Ref] := $string_literal_http$$$specs.openid.net$auth$2.0_0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 91} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 91} true;
    F$OpenID20NameSpace.AuthenticationRequest.claimed_id[req_Ref] := $string_literal_http$$$specs.openid.net$auth$2.0$identifier_select_1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 92} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 92} true;
    F$OpenID20NameSpace.AuthenticationRequest.mode[req_Ref] := $string_literal_checkid_setup_2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 93} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 93} true;
    assume $this != null;
    F$OpenID20NameSpace.AuthenticationRequest.return_to[req_Ref] := F$GenericAuthNameSpace.RP.Domain[$this];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 95} true;
    $result := req_Ref;
    return;
}



procedure OpenID20NameSpace.RelyingParty.parseAuthenticationResponse$System.Web.HttpRequest($this: Ref, rawRequest$in: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.AuthenticationResponse.#ctor($this: Ref);



function T$OpenID20NameSpace.AuthenticationResponse() : Ref;

const unique T$OpenID20NameSpace.AuthenticationResponse: int;

procedure {:extern} System.Web.HttpContext.get_Current() returns ($result: Ref);



procedure {:extern} System.Web.HttpRequest.get_QueryString($this: Ref) returns ($result: Ref);



const {:value "openid.claimed_id"} unique $string_literal_openid.claimed_id_3: Ref;

procedure {:extern} System.Collections.Specialized.NameValueCollection.get_Item$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



var F$OpenID20NameSpace.AuthenticationResponse.claimed_id: [Ref]Ref;

const {:value "SymT"} unique $string_literal_SymT_4: Ref;

const {:value "openid.return_to"} unique $string_literal_openid.return_to_5: Ref;

procedure {:extern} System.String.StartsWith$System.String($this: Ref, value$in: Ref) returns ($result: bool);



procedure {:extern} System.String.Split$System.Chararray($this: Ref, separator$in: Ref) returns ($result: Ref);



var F$OpenID20NameSpace.AuthenticationResponse.return_to: [Ref]Ref;

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
  var return_url_Ref: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: bool;
  var urls_Ref: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var $tmp11: Ref;
  var $tmp12: bool;
  var $localExc: Ref;
  var $label: int;

    rawRequest := rawRequest$in;
    assume {:breadcrumb 20} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 114} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 114} true;
    call OpenID20NameSpace.AuthenticationResponse.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.AuthenticationResponse();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.AuthenticationResponse;
    r_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 115} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 115} true;
    call $tmp1 := System.Web.HttpContext.get_Current();
    context_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 116} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 116} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 116} true;
    call $tmp2 := System.Web.HttpRequest.get_QueryString(rawRequest);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 116} true;
    call $tmp3 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp2, $string_literal_openid.claimed_id_3);
    F$OpenID20NameSpace.AuthenticationResponse.claimed_id[r_Ref] := $tmp3;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 117} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 117} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 117} true;
    call $tmp4 := System.Web.HttpRequest.get_QueryString(rawRequest);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 117} true;
    call $tmp5 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp4, $string_literal_SymT_4);
    F$CST.CST_Struct.SymT[r_Ref] := $tmp5;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 118} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 118} true;
    call $tmp6 := System.Web.HttpRequest.get_QueryString(rawRequest);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 118} true;
    call $tmp7 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp6, $string_literal_openid.return_to_5);
    return_url_Ref := $tmp7;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 121} true;
    assume $this != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 121} true;
    call $tmp8 := System.String.StartsWith$System.String(return_url_Ref, F$GenericAuthNameSpace.RP.Domain[$this]);
    if ($tmp8)
    {
        assume {:breadcrumb 21} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 122} true;
        call $tmp9 := Alloc();
        assume $ArrayLength($tmp9) == 1 * 1;
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 122} true;
        call $tmp10 := System.String.Split$System.Chararray(return_url_Ref, $tmp9);
        urls_Ref := $tmp10;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 123} true;
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 123} true;
        assume urls_Ref != null;
        F$OpenID20NameSpace.AuthenticationResponse.return_to[r_Ref] := $ArrayContents[urls_Ref][0];
    }
    else
    {
        assume {:breadcrumb 22} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 125} true;
    $tmp11 := r_Ref;
    assume $tmp11 != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 125} true;
    call $tmp12 := System.String.IsNullOrEmpty$System.String(F$OpenID20NameSpace.AuthenticationResponse.claimed_id[$tmp11]);
    if ($tmp12)
    {
        assume {:breadcrumb 23} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 126} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 24} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 128} true;
    $result := r_Ref;
    return;
}



procedure {:extern} GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($this: Ref);



function {:extern} T$GenericAuthNameSpace.RP.AuthenticationConclusion() : Ref;

const {:extern} unique T$GenericAuthNameSpace.RP.AuthenticationConclusion: int;

axiom $TypeConstructor(T$GenericAuthNameSpace.RP.AuthenticationConclusion()) == T$GenericAuthNameSpace.RP.AuthenticationConclusion;

var {:extern} F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID: [Ref]Ref;

procedure {:extern} CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct(o$in: Ref, in_msg$in: Ref, out_msg$in: Ref);



procedure {:extern} GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this: Ref, conclusion$in: Ref) returns ($result: bool);



procedure {:extern} GenericAuthNameSpace.SignInRP_Resp.#ctor($this: Ref);



function {:extern} T$GenericAuthNameSpace.SignInRP_Resp() : Ref;

const {:extern} unique T$GenericAuthNameSpace.SignInRP_Resp: int;

axiom $TypeConstructor(T$GenericAuthNameSpace.SignInRP_Resp()) == T$GenericAuthNameSpace.SignInRP_Resp;

implementation OpenID20NameSpace.RelyingParty.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($this: Ref, req1$in: Ref) returns ($result: Ref)
{
  var req1: Ref;
  var req_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: bool;
  var $tmp2: Ref;
  var conclusion_Ref: Ref;
  var $tmp3: Ref;
  var $tmp4: bool;
  var $tmp5: bool;
  var $tmp6: bool;
  var $tmp7: bool;
  var $tmp8: Ref;
  var $localExc: Ref;
  var $label: int;

    req1 := req1$in;
    assume {:breadcrumb 25} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 133} true;
    req_Ref := req1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 134} true;
    if (req_Ref == null)
    {
        assume {:breadcrumb 26} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 134} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 27} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 135} true;
    assume $this != null;
    $tmp0 := req_Ref;
    assume $tmp0 != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 135} true;
    call $tmp1 := System.String.op_Inequality$System.String$System.String(F$GenericAuthNameSpace.RP.Domain[$this], F$OpenID20NameSpace.AuthenticationResponse.return_to[$tmp0]);
    if ($tmp1)
    {
        assume {:breadcrumb 28} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 135} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 29} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 136} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 136} true;
    call $tmp2 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 136} true;
    call GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($tmp2);
    assume $DynamicType($tmp2) == T$GenericAuthNameSpace.RP.AuthenticationConclusion();
    assume $TypeConstructor($DynamicType($tmp2)) == T$GenericAuthNameSpace.RP.AuthenticationConclusion;
    conclusion_Ref := $tmp2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 138} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 138} true;
    $tmp3 := req_Ref;
    assume $tmp3 != null;
    F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[conclusion_Ref] := F$OpenID20NameSpace.AuthenticationResponse.claimed_id[$tmp3];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 139} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 139} true;
    call CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct($this, req_Ref, conclusion_Ref);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 141} true;
    if ($TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram)
    {
        call $tmp4 := LiveIDNameSpace.Yahoo_RP_For_vProgram.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, conclusion_Ref);
    }
    else
    {
        if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_RP)
        {
            call $tmp5 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, conclusion_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.RelyingParty)
            {
                call $tmp6 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, conclusion_Ref);
            }
            else
            {
                call $tmp7 := GenericAuthNameSpace.RP.AuthenticationDone$GenericAuthNameSpace.RP.AuthenticationConclusion($this, conclusion_Ref);
            }
        }
    }

    if ((if $TypeConstructor($DynamicType($this)) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram then $tmp4 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_RP then $tmp5 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.RelyingParty then $tmp6 else $tmp7))))
    {
        assume {:breadcrumb 30} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 142} true;
        call $tmp8 := Alloc();
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 142} true;
        call GenericAuthNameSpace.SignInRP_Resp.#ctor($tmp8);
        assume $DynamicType($tmp8) == T$GenericAuthNameSpace.SignInRP_Resp();
        assume $TypeConstructor($DynamicType($tmp8)) == T$GenericAuthNameSpace.SignInRP_Resp;
        $result := $tmp8;
        return;
    }
    else
    {
        assume {:breadcrumb 31} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 144} true;
    $result := null;
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
    assume {:breadcrumb 32} true;
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
    assume {:breadcrumb 33} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 35} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 35} true;
    F$OpenID20NameSpace.AuthenticationResponse.ns[$this] := $string_literal_http$$$specs.openid.net$auth$2.0_0;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 35} true;
    call GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req.#ctor($this);
}



procedure T$OpenID20NameSpace.AuthenticationResponse.#cctor();



implementation T$OpenID20NameSpace.AuthenticationResponse.#cctor()
{
}



function T$OpenID20NameSpace.IDAssertionRecs() : Ref;

const unique T$OpenID20NameSpace.IDAssertionRecs: int;

procedure OpenID20NameSpace.OpenIDProvider.init$OpenID20NameSpace.IDAssertionRecs($this: Ref, recs$in: Ref);



procedure OpenID20NameSpace.OpenIDProvider.set_IDAssertionRecs$OpenID20NameSpace.IDAssertionRecs($this: Ref, value$in: Ref);



implementation OpenID20NameSpace.OpenIDProvider.init$OpenID20NameSpace.IDAssertionRecs($this: Ref, recs$in: Ref)
{
  var recs: Ref;
  var $localExc: Ref;
  var $label: int;

    recs := recs$in;
    assume {:breadcrumb 34} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 156} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 156} true;
    call OpenID20NameSpace.OpenIDProvider.set_IDAssertionRecs$OpenID20NameSpace.IDAssertionRecs($this, recs);
}



procedure OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this: Ref) returns ($result: Ref);



var {:extern} F$GenericAuthNameSpace.IdP.IdpAuthRecs: [Ref]Ref;

implementation OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this: Ref) returns ($result: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 35} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 161} true;
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
    assume {:breadcrumb 36} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 162} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 162} true;
    F$GenericAuthNameSpace.IdP.IdpAuthRecs[$this] := value;
}



procedure OpenID20NameSpace.OpenIDProvider.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req1$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.IdP.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.ID_Claim.get_Redir_dest($this: Ref) returns ($result: Ref);



procedure OpenID20NameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, _ID_Claim$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.IdP.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, _ID_Claim$in: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.OpenIDProvider.SignInIdP$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req1$in: Ref) returns ($result: Ref)
{
  var req1: Ref;
  var req_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var _ID_Claim_Ref: Ref;
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

    req1 := req1$in;
    assume {:breadcrumb 37} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 167} true;
    req_Ref := req1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 168} true;
    $tmp0 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
    assume $tmp0 != null;
    $tmp1 := req_Ref;
    assume $tmp1 != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 168} true;
    call $tmp2 := System.String.op_Equality$System.String$System.String(F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp0], F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp1]);
    assume $tmp2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 170} true;
    if (req_Ref == null)
    {
        assume {:breadcrumb 38} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 170} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 39} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 171} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 171} true;
    if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_IdP)
    {
        call $tmp3 := OpenID20NameSpace.OpenIDProvider.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req_Ref);
    }
    else
    {
        if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.OpenIDProvider)
        {
            call $tmp4 := OpenID20NameSpace.OpenIDProvider.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req_Ref);
        }
        else
        {
            call $tmp5 := GenericAuthNameSpace.IdP.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this, req_Ref);
        }
    }

    _ID_Claim_Ref := (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_IdP then $tmp3 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.OpenIDProvider then $tmp4 else $tmp5));
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 172} true;
    if (_ID_Claim_Ref == null)
    {
        assume {:breadcrumb 40} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 172} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 41} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 174} true;
    if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_IdP)
    {
        if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
        {
            call $tmp6 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(_ID_Claim_Ref);
        }
        else
        {
            call $tmp7 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(_ID_Claim_Ref);
        }

        call $tmp8 := OpenID20NameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp6 else $tmp7), _ID_Claim_Ref);
    }
    else
    {
        if ($TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.OpenIDProvider)
        {
            if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
            {
                call $tmp9 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(_ID_Claim_Ref);
            }
            else
            {
                call $tmp10 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(_ID_Claim_Ref);
            }

            call $tmp11 := OpenID20NameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp9 else $tmp10), _ID_Claim_Ref);
        }
        else
        {
            if ($TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
            {
                call $tmp12 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(_ID_Claim_Ref);
            }
            else
            {
                call $tmp13 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(_ID_Claim_Ref);
            }

            call $tmp14 := GenericAuthNameSpace.IdP.Redir$System.String$GenericAuthNameSpace.ID_Claim($this, (if $TypeConstructor($DynamicType(_ID_Claim_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp12 else $tmp13), _ID_Claim_Ref);
        }
    }

    $result := (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.Yahoo_IdP then $tmp8 else (if $TypeConstructor($DynamicType($this)) == T$OpenID20NameSpace.OpenIDProvider then $tmp11 else $tmp14));
    return;
}



procedure {:extern} OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref) returns ($result: Ref);



procedure {:extern} GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, Realm$in: Ref) returns ($result: Ref);



function {:extern} T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def() : Ref;

const {:extern} unique T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def: int;

axiom $TypeConstructor(T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def()) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def;

implementation OpenID20NameSpace.OpenIDProvider.Process_SignInIdP_req$GenericAuthNameSpace.SignInIdP_Req($this: Ref, req1$in: Ref) returns ($result: Ref)
{
  var req1: Ref;
  var req_Ref: Ref;
  var $tmp0: Ref;
  var CS$4$0001_Ref: Ref;
  var $tmp1: bool;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var $tmp8: Ref;
  var $tmp9: Ref;
  var $tmp10: Ref;
  var entry_Ref: Ref;
  var $tmp11: Ref;
  var $tmp12: Ref;
  var $tmp13: Ref;
  var $tmp14: bool;
  var $localExc: Ref;
  var $label: int;

    req1 := req1$in;
    assume {:breadcrumb 42} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 179} true;
    req_Ref := req1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 181} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 181} true;
    $tmp0 := req_Ref;
    assume $tmp0 != null;
    CS$4$0001_Ref := F$OpenID20NameSpace.AuthenticationRequest.mode[$tmp0];
    if (CS$4$0001_Ref != null)
    {
        assume {:breadcrumb 43} true;
        call $tmp1 := System.String.op_Equality$System.String$System.String(CS$4$0001_Ref, $string_literal_checkid_setup_2);
        if (!$tmp1)
        {
            assume {:breadcrumb 45} true;
        }
        else
        {
            assume {:breadcrumb 46} true;
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 184} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 184} true;
            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 184} true;
            call $tmp10 := OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this);
            if ($TypeConstructor($DynamicType($tmp10)) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def)
            {
                call $tmp2 := OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this);
                $tmp3 := req_Ref;
                assume $tmp3 != null;
                $tmp4 := req_Ref;
                assume $tmp4 != null;
                call $tmp5 := OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.getEntry$System.String$System.String($tmp2, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp3], F$OpenID20NameSpace.AuthenticationRequest.realm[$tmp4]);
            }
            else
            {
                call $tmp6 := OpenID20NameSpace.OpenIDProvider.get_IDAssertionRecs($this);
                $tmp7 := req_Ref;
                assume $tmp7 != null;
                $tmp8 := req_Ref;
                assume $tmp8 != null;
                call $tmp9 := GenericAuthNameSpace.IdPAuthRecords_Base.getEntry$System.String$System.String($tmp6, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp7], F$OpenID20NameSpace.AuthenticationRequest.realm[$tmp8]);
            }

            entry_Ref := (if $TypeConstructor($DynamicType($tmp10)) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def then $tmp5 else $tmp9);
            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 185} true;
            $tmp11 := req_Ref;
            assume $tmp11 != null;
            if ($TypeConstructor($DynamicType(entry_Ref)) == T$OpenID20NameSpace.IDAssertionEntry)
            {
                call $tmp12 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(entry_Ref);
            }
            else
            {
                call $tmp13 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(entry_Ref);
            }

            assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 185} true;
            call $tmp14 := System.String.op_Equality$System.String$System.String(F$OpenID20NameSpace.AuthenticationRequest.realm[$tmp11], (if $TypeConstructor($DynamicType(entry_Ref)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp12 else $tmp13));
            if ($tmp14)
            {
                assume {:breadcrumb 47} true;
                assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 186} true;
                $result := entry_Ref;
                return;
            }
            else
            {
                assume {:breadcrumb 48} true;
            }

            assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 187} true;
            $result := null;
            return;
        }
    }
    else
    {
        assume {:breadcrumb 44} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 190} true;
    $result := null;
    return;
}



procedure {:extern} GenericAuthNameSpace.ID_Claim.get_UserID($this: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.OpenIDProvider.Redir$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, dest$in: Ref, _ID_Claim$in: Ref) returns ($result: Ref)
{
  var dest: Ref;
  var _ID_Claim: Ref;
  var req_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

    dest := dest$in;
    _ID_Claim := _ID_Claim$in;
    assume {:breadcrumb 49} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 195} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 195} true;
    call OpenID20NameSpace.AuthenticationResponse.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.AuthenticationResponse();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.AuthenticationResponse;
    req_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 197} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 197} true;
    if ($TypeConstructor($DynamicType(_ID_Claim)) == T$OpenID20NameSpace.IDAssertionEntry)
    {
        call $tmp1 := OpenID20NameSpace.IDAssertionEntry.get_UserID(_ID_Claim);
    }
    else
    {
        call $tmp2 := GenericAuthNameSpace.ID_Claim.get_UserID(_ID_Claim);
    }

    F$OpenID20NameSpace.AuthenticationResponse.claimed_id[req_Ref] := (if $TypeConstructor($DynamicType(_ID_Claim)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp1 else $tmp2);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 198} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 198} true;
    if ($TypeConstructor($DynamicType(_ID_Claim)) == T$OpenID20NameSpace.IDAssertionEntry)
    {
        call $tmp3 := OpenID20NameSpace.IDAssertionEntry.get_Redir_dest(_ID_Claim);
    }
    else
    {
        call $tmp4 := GenericAuthNameSpace.ID_Claim.get_Redir_dest(_ID_Claim);
    }

    F$OpenID20NameSpace.AuthenticationResponse.return_to[req_Ref] := (if $TypeConstructor($DynamicType(_ID_Claim)) == T$OpenID20NameSpace.IDAssertionEntry then $tmp3 else $tmp4);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\OpenID20NameSpace\OpenID20NameSpace.cs"} {:sourceLine 204} true;
    $result := req_Ref;
    return;
}



procedure OpenID20NameSpace.OpenIDProvider.#ctor($this: Ref);



procedure {:extern} GenericAuthNameSpace.IdP.#ctor($this: Ref);



implementation OpenID20NameSpace.OpenIDProvider.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 50} true;
    call GenericAuthNameSpace.IdP.#ctor($this);
}



procedure T$OpenID20NameSpace.OpenIDProvider.#cctor();



implementation T$OpenID20NameSpace.OpenIDProvider.#cctor()
{
}



function T$GenericAuthNameSpace.GlobalObjects_base() : Ref;

const unique T$GenericAuthNameSpace.GlobalObjects_base: int;

var F$GenericAuthNameSpace.RP.Realm: [Ref]Ref;

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
    assume {:breadcrumb 51} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 104} true;
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
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 107} true;
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
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 107} true;
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

    assume {:breadcrumb 52} true;
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

procedure GenericAuthNameSpace.SignInIdP_Req.get_Realm($this: Ref) returns ($result: Ref);



procedure {:extern} OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref, Entry$in: Ref) returns ($result: bool);



procedure GenericAuthNameSpace.IdPAuthRecords_Base.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, Realm$in: Ref, _ID_Claim$in: Ref) returns ($result: bool);



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
    assume {:breadcrumb 53} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 61} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 61} true;
    F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req := req;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 63} true;
    if (req == null)
    {
        assume {:breadcrumb 54} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 63} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 55} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 64} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 64} true;
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
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 65} true;
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
        assume {:breadcrumb 56} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 66} true;
        $result := null;
        return;
    }
    else
    {
        assume {:breadcrumb 57} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 67} true;
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
    assume {:breadcrumb 58} true;
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

    assume {:breadcrumb 59} true;
    call System.Object.#ctor($this);
}



procedure T$GenericAuthNameSpace.ID_Claim.#cctor();



implementation T$GenericAuthNameSpace.ID_Claim.#cctor()
{
}



procedure {:extern} CST.CST_Struct.#ctor($this: Ref);



implementation GenericAuthNameSpace.SignInRP_Resp.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 60} true;
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

    assume {:breadcrumb 61} true;
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
    assume {:breadcrumb 62} true;
    call CST.CST_Struct.#ctor($this);
}



procedure T$GenericAuthNameSpace.SignInIdP_Req.#cctor();



implementation T$GenericAuthNameSpace.SignInIdP_Req.#cctor()
{
}



function T$GenericAuthNameSpace.RP() : Ref;

const unique T$GenericAuthNameSpace.RP: int;

var F$GenericAuthNameSpace.RP.CurrentSession: [Ref]Ref;

procedure {:extern} CST.CST_Ops.Certify$CST.CST_Struct(msg$in: Ref) returns ($result: bool);



const {:value "UserID"} unique $string_literal_UserID_6: Ref;

const {:value ""} unique $string_literal__7: Ref;

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
    assume {:breadcrumb 63} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 85} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 85} true;
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

    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 85} true;
    call System.Web.SessionState.HttpSessionState.set_Item$System.String$System.Object($tmp1, $string_literal_UserID_6, (if CST_verified_bool then F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$tmp2] else $string_literal__7));
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\GenericAuthNameSpace\GenericAuthNameSpace.cs"} {:sourceLine 87} true;
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
    assume {:breadcrumb 64} true;
    call System.Object.#ctor($this);
}



implementation GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$GenericAuthNameSpace.RP.AuthenticationConclusion.SessionUID[$this] := null;
    assume {:breadcrumb 65} true;
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



const {:value "openid.mode"} unique $string_literal_openid.mode_8: Ref;

procedure {:extern} System.Web.UI.Page.get_Session($this: Ref) returns ($result: Ref);



procedure {:extern} System.Web.UI.Page.set_Visible$System.Boolean($this: Ref, value$in: bool);



function {:extern} T$System.Web.UI.Page() : Ref;

const {:extern} unique T$System.Web.UI.Page: int;

axiom $TypeConstructor(T$System.Web.UI.Page()) == T$System.Web.UI.Page;

function {:extern} T$System.Web.UI.TemplateControl() : Ref;

const {:extern} unique T$System.Web.UI.TemplateControl: int;

axiom $TypeConstructor(T$System.Web.UI.TemplateControl()) == T$System.Web.UI.TemplateControl;

procedure {:extern} System.Web.UI.Control.set_Visible$System.Boolean($this: Ref, value$in: bool);



const {:value "Your ID is {0}"} unique $string_literal_Your$ID$is$$0$_9: Ref;

const {:value "openid.identity"} unique $string_literal_openid.identity_10: Ref;

procedure {:extern} System.String.Format$System.String$System.Object(format$in: Ref, arg0$in: Ref) returns ($result: Ref);



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
  var $tmp4: Ref;
  var d_Ref: Ref;
  var $tmp5: Ref;
  var resp_Ref: Ref;
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
  var $tmp34: Ref;
  var $tmp35: Ref;
  var $tmp36: Ref;
  var $tmp37: Ref;
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 66} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 20} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 20} true;
    call $tmp0 := System.Web.UI.Page.get_Request($this);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 20} true;
    call $tmp1 := System.Web.HttpRequest.get_Params($tmp0);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 20} true;
    call $tmp2 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp1, $string_literal_openid.mode_8);
    mode_Ref := $tmp2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 22} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 22} true;
    call $tmp3 := System.String.IsNullOrEmpty$System.String(mode_Ref);
    if (!$tmp3)
    {
        assume {:breadcrumb 67} true;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 24} true;
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 24} true;
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 24} true;
        call $tmp4 := System.Web.UI.Page.get_Session($this);
        assume $this != null;
        F$GenericAuthNameSpace.RP.CurrentSession[F$OpenIDExample.LogIn.RP[$this]] := $tmp4;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 25} true;
        call $tmp5 := Alloc();
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 25} true;
        call GenericAuthNameSpace.RP.AuthenticationConclusion.#ctor($tmp5);
        assume $DynamicType($tmp5) == T$GenericAuthNameSpace.RP.AuthenticationConclusion();
        assume $TypeConstructor($DynamicType($tmp5)) == T$GenericAuthNameSpace.RP.AuthenticationConclusion;
        d_Ref := $tmp5;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 26} true;
        assume $this != null;
        $tmp6 := F$OpenIDExample.LogIn.RP[$this];
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 26} true;
        call $tmp7 := System.Web.UI.Page.get_Request($this);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 26} true;
        call $tmp8 := OpenID20NameSpace.RelyingParty.parseAuthenticationResponse$System.Web.HttpRequest($tmp6, $tmp7);
        resp_Ref := $tmp8;
        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 27} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.RP[$this])) == T$LiveIDNameSpace.Yahoo_RP_For_vProgram)
        {
            assume $this != null;
            $tmp9 := F$OpenIDExample.LogIn.RP[$this];
            call $tmp10 := OpenID20NameSpace.RelyingParty.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($tmp9, resp_Ref);
        }
        else
        {
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.RP[$this])) == T$OpenID20NameSpace.Yahoo_RP)
            {
                assume $this != null;
                $tmp11 := F$OpenIDExample.LogIn.RP[$this];
                call $tmp12 := OpenID20NameSpace.RelyingParty.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($tmp11, resp_Ref);
            }
            else
            {
                assume $this != null;
                if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.RP[$this])) == T$OpenID20NameSpace.RelyingParty)
                {
                    assume $this != null;
                    $tmp13 := F$OpenIDExample.LogIn.RP[$this];
                    call $tmp14 := OpenID20NameSpace.RelyingParty.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($tmp13, resp_Ref);
                }
                else
                {
                    assume $this != null;
                    $tmp15 := F$OpenIDExample.LogIn.RP[$this];
                    call $tmp16 := GenericAuthNameSpace.RP.SignInRP$GenericAuthNameSpace.SignInIdP_Resp_SignInRP_Req($tmp15, resp_Ref);
                }
            }
        }

        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 29} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$OpenIDExample.LogIn)
        {
            assume {:breadcrumb 69} true;
            assume $this != null;
            $tmp17 := F$OpenIDExample.LogIn.notLoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp17, false);
        }
        else
        {
            assume {:breadcrumb 70} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.Page)
            {
                assume {:breadcrumb 71} true;
                assume $this != null;
                $tmp18 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                call System.Web.UI.Page.set_Visible$System.Boolean($tmp18, false);
            }
            else
            {
                assume {:breadcrumb 72} true;
                assume $this != null;
                if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.TemplateControl)
                {
                    assume {:breadcrumb 73} true;
                    assume $this != null;
                    $tmp19 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                    call System.Web.UI.Control.set_Visible$System.Boolean($tmp19, false);
                }
                else
                {
                    assume {:breadcrumb 74} true;
                    assume $this != null;
                    $tmp20 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                    call System.Web.UI.Control.set_Visible$System.Boolean($tmp20, false);
                }
            }
        }

        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 30} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$OpenIDExample.LogIn)
        {
            assume {:breadcrumb 75} true;
            assume $this != null;
            $tmp21 := F$OpenIDExample.LogIn.LoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp21, true);
        }
        else
        {
            assume {:breadcrumb 76} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.Page)
            {
                assume {:breadcrumb 77} true;
                assume $this != null;
                $tmp22 := F$OpenIDExample.LogIn.LoggedIn[$this];
                call System.Web.UI.Page.set_Visible$System.Boolean($tmp22, true);
            }
            else
            {
                assume {:breadcrumb 78} true;
                assume $this != null;
                if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.TemplateControl)
                {
                    assume {:breadcrumb 79} true;
                    assume $this != null;
                    $tmp23 := F$OpenIDExample.LogIn.LoggedIn[$this];
                    call System.Web.UI.Control.set_Visible$System.Boolean($tmp23, true);
                }
                else
                {
                    assume {:breadcrumb 80} true;
                    assume $this != null;
                    $tmp24 := F$OpenIDExample.LogIn.LoggedIn[$this];
                    call System.Web.UI.Control.set_Visible$System.Boolean($tmp24, true);
                }
            }
        }

        assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 32} true;
        assume $this != null;
        $tmp25 := F$OpenIDExample.LogIn.logged_id[$this];
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 32} true;
        call $tmp26 := System.Web.UI.Page.get_Request($this);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 32} true;
        call $tmp27 := System.Web.HttpRequest.get_Params($tmp26);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 32} true;
        call $tmp28 := System.Collections.Specialized.NameValueCollection.get_Item$System.String($tmp27, $string_literal_openid.identity_10);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 32} true;
        call $tmp29 := System.String.Format$System.String$System.Object($string_literal_Your$ID$is$$0$_9, $tmp28);
        assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 32} true;
        call System.Web.UI.HtmlControls.HtmlContainerControl.set_InnerHtml$System.String($tmp25, $tmp29);
        return;
    }
    else
    {
        assume {:breadcrumb 68} true;
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 37} true;
    assume $this != null;
    if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$OpenIDExample.LogIn)
    {
        assume {:breadcrumb 81} true;
        assume $this != null;
        $tmp30 := F$OpenIDExample.LogIn.notLoggedIn[$this];
        call System.Web.UI.Page.set_Visible$System.Boolean($tmp30, true);
    }
    else
    {
        assume {:breadcrumb 82} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.Page)
        {
            assume {:breadcrumb 83} true;
            assume $this != null;
            $tmp31 := F$OpenIDExample.LogIn.notLoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp31, true);
        }
        else
        {
            assume {:breadcrumb 84} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.TemplateControl)
            {
                assume {:breadcrumb 85} true;
                assume $this != null;
                $tmp32 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp32, true);
            }
            else
            {
                assume {:breadcrumb 86} true;
                assume $this != null;
                $tmp33 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp33, true);
            }
        }
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 38} true;
    assume $this != null;
    if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$OpenIDExample.LogIn)
    {
        assume {:breadcrumb 87} true;
        assume $this != null;
        $tmp34 := F$OpenIDExample.LogIn.LoggedIn[$this];
        call System.Web.UI.Page.set_Visible$System.Boolean($tmp34, false);
    }
    else
    {
        assume {:breadcrumb 88} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.Page)
        {
            assume {:breadcrumb 89} true;
            assume $this != null;
            $tmp35 := F$OpenIDExample.LogIn.LoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp35, false);
        }
        else
        {
            assume {:breadcrumb 90} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.TemplateControl)
            {
                assume {:breadcrumb 91} true;
                assume $this != null;
                $tmp36 := F$OpenIDExample.LogIn.LoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp36, false);
            }
            else
            {
                assume {:breadcrumb 92} true;
                assume $this != null;
                $tmp37 := F$OpenIDExample.LogIn.LoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp37, false);
            }
        }
    }
}



procedure OpenIDExample.LogIn.LoginBtn_Click$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



const {:value "SignInIdP"} unique $string_literal_SignInIdP_11: Ref;

procedure {:extern} System.Type.GetMethod$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



procedure {:extern} CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct$System.Reflection.MethodInfo(o$in: Ref, in_msg$in: Ref, out_msg$in: Ref, mi$in: Ref);



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
  var final_url_Ref: Ref;
  var $tmp13: Ref;
  var $tmp14: Ref;
  var $tmp15: Ref;
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 93} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 79} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 79} true;
    call OpenID20NameSpace.AuthenticationResponse.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.AuthenticationResponse();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.AuthenticationResponse;
    req_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 81} true;
    assume $this != null;
    $tmp1 := F$OpenIDExample.LogIn.RP[$this];
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 81} true;
    call $tmp2 := OpenID20NameSpace.RelyingParty.RequestAuthentication$OpenID20NameSpace.AuthenticationResponse($tmp1, req_Ref);
    resp_Ref := $tmp2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 84} true;
    call $tmp3 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 84} true;
    call OpenID20NameSpace.AuthenticationRequest.#ctor($tmp3);
    assume $DynamicType($tmp3) == T$OpenID20NameSpace.AuthenticationRequest();
    assume $TypeConstructor($DynamicType($tmp3)) == T$OpenID20NameSpace.AuthenticationRequest;
    new_resq_Ref := $tmp3;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 85} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 85} true;
    $tmp4 := resp_Ref;
    assume $tmp4 != null;
    F$OpenID20NameSpace.AuthenticationRequest.claimed_id[new_resq_Ref] := F$OpenID20NameSpace.AuthenticationRequest.claimed_id[$tmp4];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 86} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 86} true;
    $tmp5 := resp_Ref;
    assume $tmp5 != null;
    F$OpenID20NameSpace.AuthenticationRequest.identity[new_resq_Ref] := F$OpenID20NameSpace.AuthenticationRequest.identity[$tmp5];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 87} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 87} true;
    $tmp6 := resp_Ref;
    assume $tmp6 != null;
    F$OpenID20NameSpace.AuthenticationRequest.return_to[new_resq_Ref] := F$OpenID20NameSpace.AuthenticationRequest.return_to[$tmp6];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 88} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 88} true;
    $tmp7 := resp_Ref;
    assume $tmp7 != null;
    F$OpenID20NameSpace.AuthenticationRequest.realm[new_resq_Ref] := F$OpenID20NameSpace.AuthenticationRequest.realm[$tmp7];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 89} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 89} true;
    $tmp8 := resp_Ref;
    assume $tmp8 != null;
    F$OpenID20NameSpace.AuthenticationRequest.ns[new_resq_Ref] := F$OpenID20NameSpace.AuthenticationRequest.ns[$tmp8];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 90} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 90} true;
    $tmp9 := resp_Ref;
    assume $tmp9 != null;
    F$OpenID20NameSpace.AuthenticationRequest.mode[new_resq_Ref] := F$OpenID20NameSpace.AuthenticationRequest.mode[$tmp9];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 92} true;
    call $tmp10 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 92} true;
    call OpenID20NameSpace.Yahoo_IdP.#ctor($tmp10);
    assume $DynamicType($tmp10) == T$OpenID20NameSpace.Yahoo_IdP();
    assume $TypeConstructor($DynamicType($tmp10)) == T$OpenID20NameSpace.Yahoo_IdP;
    $tmp11 := T$OpenID20NameSpace.Yahoo_IdP();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 92} true;
    call $tmp12 := System.Type.GetMethod$System.String($tmp11, $string_literal_SignInIdP_11);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 92} true;
    call CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct$System.Reflection.MethodInfo($tmp10, resp_Ref, new_resq_Ref, $tmp12);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 94} true;
    assume $this != null;
    $tmp13 := F$OpenIDExample.LogIn.RP[$this];
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 94} true;
    call $tmp14 := OpenID20NameSpace.Yahoo_RP.GenerateURL$OpenID20NameSpace.AuthenticationRequest($tmp13, new_resq_Ref);
    final_url_Ref := $tmp14;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 96} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 96} true;
    call $tmp15 := System.Web.UI.Page.get_Response($this);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 96} true;
    call System.Web.HttpResponse.Redirect$System.String($tmp15, final_url_Ref);
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
    assume {:breadcrumb 94} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 101} true;
    assume $this != null;
    if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$OpenIDExample.LogIn)
    {
        assume {:breadcrumb 95} true;
        assume $this != null;
        $tmp0 := F$OpenIDExample.LogIn.notLoggedIn[$this];
        call System.Web.UI.Page.set_Visible$System.Boolean($tmp0, true);
    }
    else
    {
        assume {:breadcrumb 96} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.Page)
        {
            assume {:breadcrumb 97} true;
            assume $this != null;
            $tmp1 := F$OpenIDExample.LogIn.notLoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp1, true);
        }
        else
        {
            assume {:breadcrumb 98} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.notLoggedIn[$this])) == T$System.Web.UI.TemplateControl)
            {
                assume {:breadcrumb 99} true;
                assume $this != null;
                $tmp2 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp2, true);
            }
            else
            {
                assume {:breadcrumb 100} true;
                assume $this != null;
                $tmp3 := F$OpenIDExample.LogIn.notLoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp3, true);
            }
        }
    }

    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 102} true;
    assume $this != null;
    if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$OpenIDExample.LogIn)
    {
        assume {:breadcrumb 101} true;
        assume $this != null;
        $tmp4 := F$OpenIDExample.LogIn.LoggedIn[$this];
        call System.Web.UI.Page.set_Visible$System.Boolean($tmp4, false);
    }
    else
    {
        assume {:breadcrumb 102} true;
        assume $this != null;
        if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.Page)
        {
            assume {:breadcrumb 103} true;
            assume $this != null;
            $tmp5 := F$OpenIDExample.LogIn.LoggedIn[$this];
            call System.Web.UI.Page.set_Visible$System.Boolean($tmp5, false);
        }
        else
        {
            assume {:breadcrumb 104} true;
            assume $this != null;
            if ($TypeConstructor($DynamicType(F$OpenIDExample.LogIn.LoggedIn[$this])) == T$System.Web.UI.TemplateControl)
            {
                assume {:breadcrumb 105} true;
                assume $this != null;
                $tmp6 := F$OpenIDExample.LogIn.LoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp6, false);
            }
            else
            {
                assume {:breadcrumb 106} true;
                assume $this != null;
                $tmp7 := F$OpenIDExample.LogIn.LoggedIn[$this];
                call System.Web.UI.Control.set_Visible$System.Boolean($tmp7, false);
            }
        }
    }
}



procedure OpenIDExample.LogIn.#ctor($this: Ref);



const {:value "http://localhost:32928/LogIn.aspx"} unique $string_literal_http$$$localhost$32928$LogIn.aspx_12: Ref;

const {:value "https://open.login.yahooapis.com/openid/op/auth"} unique $string_literal_https$$$open.login.yahooapis.com$openid$op$auth_13: Ref;

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
    assume {:breadcrumb 107} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 15} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 15} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\LogIn.aspx.cs"} {:sourceLine 15} true;
    call OpenID20NameSpace.Yahoo_RP.#ctor$System.String$System.String($tmp0, $string_literal_http$$$localhost$32928$LogIn.aspx_12, $string_literal_https$$$open.login.yahooapis.com$openid$op$auth_13);
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

    assume {:breadcrumb 108} true;
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
    assume {:breadcrumb 109} true;
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



procedure {:extern} System.Text.StringBuilder.#ctor$System.String($this: Ref, value$in: Ref);



function {:extern} T$System.Text.StringBuilder() : Ref;

const {:extern} unique T$System.Text.StringBuilder: int;

axiom $TypeConstructor(T$System.Text.StringBuilder()) == T$System.Text.StringBuilder;

const {:value "?openid.claimed_id={0}&openid.identity={1}&openid.return_to={2}?SymT={6}&openid.realm={5}&openid.mode={3}&openid.ns={4}"} unique $string_literal_?openid.claimed_id$$0$$openid.identity$$1$$openid.return_to$$2$?SymT$$6$$openid.realm$$5$$openid.mode$$3$$openid.ns$$4$_14: Ref;

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
    assume {:breadcrumb 110} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 27} true;
    call $tmp0 := Alloc();
    assume $this != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 27} true;
    call System.Text.StringBuilder.#ctor$System.String($tmp0, F$OpenID20NameSpace.RelyingParty.endpointUrl[$this]);
    assume $DynamicType($tmp0) == T$System.Text.StringBuilder();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Text.StringBuilder;
    sb_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 29} true;
    call $tmp1 := Alloc();
    assume $ArrayLength($tmp1) == 1 * 7;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 29} true;
    call $tmp2 := System.Text.StringBuilder.AppendFormat$System.String$System.Objectarray(sb_Ref, $string_literal_?openid.claimed_id$$0$$openid.identity$$1$$openid.return_to$$2$?SymT$$6$$openid.realm$$5$$openid.mode$$3$$openid.ns$$4$_14, $tmp1);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 31} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 31} true;
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
    assume {:breadcrumb 111} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 35} true;
    call $tmp0 := Alloc();
    assume $this != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 35} true;
    call System.Text.StringBuilder.#ctor$System.String($tmp0, F$OpenID20NameSpace.RelyingParty.endpointUrl[$this]);
    assume $DynamicType($tmp0) == T$System.Text.StringBuilder();
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Text.StringBuilder;
    sb_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 37} true;
    call $tmp1 := Alloc();
    assume $ArrayLength($tmp1) == 1 * 7;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 37} true;
    call $tmp2 := System.Text.StringBuilder.AppendFormat$System.String$System.Objectarray(sb_Ref, $string_literal_?openid.claimed_id$$0$$openid.identity$$1$$openid.return_to$$2$?SymT$$6$$openid.realm$$5$$openid.mode$$3$$openid.ns$$4$_14, $tmp1);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 39} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\OpenIDExample\Yahoo_RP.cs"} {:sourceLine 39} true;
    call $tmp3 := System.Object.ToString(sb_Ref);
    $result := $tmp3;
    return;
}



procedure T$OpenID20NameSpace.Yahoo_RP.#cctor();



implementation T$OpenID20NameSpace.Yahoo_RP.#cctor()
{
}



function T$CST.Nondet_Base() : Ref;

const unique T$CST.Nondet_Base: int;

procedure CST.Nondet_Base.Int($this: Ref) returns ($result: int);



procedure CST.Nondet_Base.Bool($this: Ref) returns ($result: bool);



function T$CST.Debug() : Ref;

const unique T$CST.Debug: int;

procedure CST.Debug.reached();



implementation CST.Debug.reached()
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 112} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 22} true;
    assert false;
}



procedure CST.Debug.#ctor($this: Ref);



implementation CST.Debug.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 113} true;
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
    assume {:breadcrumb 114} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 15} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 15} true;
    F$CST.CST_Struct.SymT[$this] := $string_literal__7;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 16} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 16} true;
    F$CST.CST_Struct.SignedBy[$this] := $string_literal__7;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\AuthClassLib\CST_Common\CST.cs"} {:sourceLine 16} true;
    call System.Object.#ctor($this);
}



procedure T$CST.CST_Struct.#cctor();



implementation T$CST.CST_Struct.#cctor()
{
}



var F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary: [Ref]Ref;

var F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary: [Ref]Ref;

procedure {:extern} System.Collections.Generic.Dictionary`2.#ctor($this: Ref);



function {:extern} TKey$T$System.Collections.Generic.Dictionary`2(parent: Ref) : Ref;

function {:extern} TValue$T$System.Collections.Generic.Dictionary`2(parent: Ref) : Ref;

function {:extern} T$System.Collections.Generic.Dictionary`2(TKey: Ref, TValue: Ref) : Ref;

const {:extern} unique T$System.Collections.Generic.Dictionary`2: int;

function {:extern} T$System.String() : Ref;

const {:extern} unique T$System.String: int;

axiom $TypeConstructor(T$System.String()) == T$System.String;

procedure {:extern} System.Collections.Generic.Dictionary`2.set_Item$`0$`1($this: Ref, key$in: Ref, value$in: Ref);



implementation OpenID20NameSpace.Yahoo_IdP.init($this: Ref)
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 115} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 15} true;
    assume $this != null;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 15} true;
    call OpenID20NameSpace.OpenIDProvider.init$OpenID20NameSpace.IDAssertionRecs($this, F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary[$this]);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 16} true;
    assume $this != null;
    $tmp0 := F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary[$this];
    assume $tmp0 != null;
    $tmp1 := F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$tmp0];
    $tmp2 := F$GenericAuthNameSpace.GlobalObjects_base.SignInIdP_Req;
    assume $tmp2 != null;
    call $tmp3 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 16} true;
    call System.Collections.Generic.Dictionary`2.#ctor($tmp3);
    assume $DynamicType($tmp3) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OpenID20NameSpace.IDAssertionEntry());
    assume $TypeConstructor($DynamicType($tmp3)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp3)) == T$System.String();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp3)) == T$OpenID20NameSpace.IDAssertionEntry();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 16} true;
    call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp1, F$GenericAuthNameSpace.SignInIdP_Req.IdPSessionSecret[$tmp2], $tmp3);
}



procedure OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#ctor($this: Ref);



implementation OpenID20NameSpace.Yahoo_IdP.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary[$this] := null;
    assume {:breadcrumb 116} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 19} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 19} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 19} true;
    call OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def;
    F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary[$this] := $tmp0;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 19} true;
    call OpenID20NameSpace.OpenIDProvider.#ctor($this);
}



procedure {:extern} System.Collections.Generic.Dictionary`2.get_Item$`0($this: Ref, key$in: Ref) returns ($result: Ref);



implementation OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.getEntry$System.String$System.String($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref) returns ($result: Ref)
{
  var IdPSessionSecret: Ref;
  var client_id: Ref;
  var entry_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $localExc: Ref;
  var $label: int;

    IdPSessionSecret := IdPSessionSecret$in;
    client_id := client_id$in;
    assume {:breadcrumb 117} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 27} true;
    assume $this != null;
    $tmp0 := F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$this];
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 27} true;
    call $tmp2 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp0, IdPSessionSecret);
    $tmp1 := $tmp2;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 27} true;
    call $tmp4 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp1, client_id);
    $tmp3 := $tmp4;
    entry_Ref := $tmp3;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 29} true;
    assume $TypeConstructor($DynamicType(entry_Ref)) == T$OpenID20NameSpace.IDAssertionEntry;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 31} true;
    $result := entry_Ref;
    return;
}



implementation OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.setEntry$System.String$System.String$GenericAuthNameSpace.ID_Claim($this: Ref, IdPSessionSecret$in: Ref, client_id$in: Ref, Entry$in: Ref) returns ($result: bool)
{
  var IdPSessionSecret: Ref;
  var client_id: Ref;
  var Entry: Ref;
  var IDAssertionEntry_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    IdPSessionSecret := IdPSessionSecret$in;
    client_id := client_id$in;
    Entry := Entry$in;
    assume {:breadcrumb 118} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 40} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 40} true;
    call OpenID20NameSpace.IDAssertionEntry.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$OpenID20NameSpace.IDAssertionEntry();
    assume $TypeConstructor($DynamicType($tmp0)) == T$OpenID20NameSpace.IDAssertionEntry;
    IDAssertionEntry_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 42} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 42} true;
    assume Entry != null;
    F$OpenID20NameSpace.IDAssertionEntry.openid_claimed_id[IDAssertionEntry_Ref] := F$OpenID20NameSpace.IDAssertionEntry.openid_claimed_id[Entry];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 43} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 43} true;
    assume Entry != null;
    F$OpenID20NameSpace.IDAssertionEntry.openid_return_to[IDAssertionEntry_Ref] := F$OpenID20NameSpace.IDAssertionEntry.openid_return_to[Entry];
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 44} true;
    assume $this != null;
    $tmp1 := F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$this];
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 44} true;
    call $tmp3 := System.Collections.Generic.Dictionary`2.get_Item$`0($tmp1, IdPSessionSecret);
    $tmp2 := $tmp3;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 44} true;
    call System.Collections.Generic.Dictionary`2.set_Item$`0$`1($tmp2, client_id, IDAssertionEntry_Ref);
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 46} true;
    $result := true;
    return;
}



implementation OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$this] := null;
    assume {:breadcrumb 119} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 23} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 23} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 23} true;
    call System.Collections.Generic.Dictionary`2.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OpenID20NameSpace.IDAssertionEntry()));
    assume $TypeConstructor($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2;
    assume TKey$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.String();
    assume TValue$T$System.Collections.Generic.Dictionary`2($DynamicType($tmp0)) == T$System.Collections.Generic.Dictionary`2(T$System.String(), T$OpenID20NameSpace.IDAssertionEntry());
    F$OpenID20NameSpace.Yahoo_IdP.IDAssertionRecsDictionary_def.Dictionary[$this] := $tmp0;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\OpenIDLogin\Yahoo_IdP\Yahoo_IdP.cs"} {:sourceLine 23} true;
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


