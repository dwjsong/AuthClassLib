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

var F$PoirotMain.A: Ref;

var F$PoirotMain.B: Ref;

var F$PoirotMain.C: Ref;

procedure PoirotMain.check_Assertion();



implementation PoirotMain.check_Assertion()
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 0} true;
}



procedure PoirotMain.call_SynthesizedSequence();



procedure PoirotMain.NondetVProgram.CST_Message($this: Ref) returns ($result: Ref);



procedure {:extern} ABC.A.invoke$CST.CST_Message($this: Ref, msg$in: Ref) returns ($result: Ref);



procedure {:extern} ABC.B.invoke$CST.CST_Message($this: Ref, msg$in: Ref) returns ($result: Ref);



procedure {:extern} ABC.C.invoke$CST.CST_Message($this: Ref, msg$in: Ref) returns ($result: Ref);



implementation PoirotMain.call_SynthesizedSequence()
{
  var C1_Ref: Ref;
  var $tmp0: Ref;
  var C2_Ref: Ref;
  var $tmp1: Ref;
  var C3_Ref: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 1} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\SynthesizedSequence.cs"} {:sourceLine 5} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\SynthesizedSequence.cs"} {:sourceLine 5} true;
    call $tmp0 := PoirotMain.NondetVProgram.CST_Message(F$PoirotMain.Nondet);
    C1_Ref := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\SynthesizedSequence.cs"} {:sourceLine 6} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\SynthesizedSequence.cs"} {:sourceLine 6} true;
    call $tmp1 := ABC.A.invoke$CST.CST_Message(F$PoirotMain.A, C1_Ref);
    C2_Ref := $tmp1;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\SynthesizedSequence.cs"} {:sourceLine 7} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\SynthesizedSequence.cs"} {:sourceLine 7} true;
    call $tmp2 := ABC.B.invoke$CST.CST_Message(F$PoirotMain.B, C2_Ref);
    C3_Ref := $tmp2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\SynthesizedSequence.cs"} {:sourceLine 8} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\SynthesizedSequence.cs"} {:sourceLine 8} true;
    call $tmp3 := ABC.C.invoke$CST.CST_Message(F$PoirotMain.C, C3_Ref);
}



procedure {:entrypoint} PoirotMain.Main();



implementation PoirotMain.Main()
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 2} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 19} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 19} true;
    call PoirotMain.call_SynthesizedSequence();
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 20} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 20} true;
    call PoirotMain.check_Assertion();
}



procedure PoirotMain.#ctor($this: Ref);



procedure {:extern} System.Object.#ctor($this: Ref);



implementation PoirotMain.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    assume {:breadcrumb 3} true;
    call System.Object.#ctor($this);
}



procedure PoirotMain.#cctor();



procedure {:extern} CST.Nondet_Base.Int($this: Ref) returns ($result: int);



procedure {:extern} ABC.A.#ctor$System.Int32($this: Ref, i1$in: int);



function {:extern} T$ABC.A() : Ref;

const {:extern} unique T$ABC.A: int;

axiom $TypeConstructor(T$ABC.A()) == T$ABC.A;

procedure {:extern} ABC.B.#ctor$System.Int32($this: Ref, i1$in: int);



function {:extern} T$ABC.B() : Ref;

const {:extern} unique T$ABC.B: int;

axiom $TypeConstructor(T$ABC.B()) == T$ABC.B;

procedure {:extern} ABC.C.#ctor$System.Int32($this: Ref, i1$in: int);



function {:extern} T$ABC.C() : Ref;

const {:extern} unique T$ABC.C: int;

axiom $TypeConstructor(T$ABC.C()) == T$ABC.C;

implementation PoirotMain.#cctor()
{
  var $tmp0: Ref;
  var $tmp1: int;
  var $tmp2: Ref;
  var $tmp3: int;
  var $tmp4: Ref;
  var $tmp5: int;
  var $localExc: Ref;
  var $label: int;

    F$PoirotMain.Nondet := null;
    F$PoirotMain.A := null;
    F$PoirotMain.B := null;
    F$PoirotMain.C := null;
    assume {:breadcrumb 4} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 12} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 12} true;
    call $tmp0 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 12} true;
    call $tmp1 := CST.Nondet_Base.Int(F$PoirotMain.Nondet);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 12} true;
    call ABC.A.#ctor$System.Int32($tmp0, $tmp1);
    assume $DynamicType($tmp0) == T$ABC.A();
    assume $TypeConstructor($DynamicType($tmp0)) == T$ABC.A;
    F$PoirotMain.A := $tmp0;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 13} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 13} true;
    call $tmp2 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 13} true;
    call $tmp3 := CST.Nondet_Base.Int(F$PoirotMain.Nondet);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 13} true;
    call ABC.B.#ctor$System.Int32($tmp2, $tmp3);
    assume $DynamicType($tmp2) == T$ABC.B();
    assume $TypeConstructor($DynamicType($tmp2)) == T$ABC.B;
    F$PoirotMain.B := $tmp2;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 14} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 14} true;
    call $tmp4 := Alloc();
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 14} true;
    call $tmp5 := CST.Nondet_Base.Int(F$PoirotMain.Nondet);
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 14} true;
    call ABC.C.#ctor$System.Int32($tmp4, $tmp5);
    assume $DynamicType($tmp4) == T$ABC.C();
    assume $TypeConstructor($DynamicType($tmp4)) == T$ABC.C;
    F$PoirotMain.C := $tmp4;
}



function T$PoirotMain.NondetVProgram() : Ref;

const unique T$PoirotMain.NondetVProgram: int;

function T$Server_A.A_invoke() : Ref;

const unique T$Server_A.A_invoke: int;

var F$Server_A.A_invoke.server_a: [Ref]Ref;

procedure Server_A.A_invoke.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



procedure {:extern} CST.CST_Message.#ctor($this: Ref);



function {:extern} T$CST.CST_Message() : Ref;

const {:extern} unique T$CST.CST_Message: int;

axiom $TypeConstructor(T$CST.CST_Message()) == T$CST.CST_Message;

procedure {:extern} System.Web.UI.Page.get_Request($this: Ref) returns ($result: Ref);



procedure {:extern} CST.CST_Message.parse$CST.CST_Message$System.Web.HttpRequest(msg$in: Ref, request$in: Ref) returns ($result: bool);



procedure {:extern} System.Web.UI.Page.get_Response($this: Ref) returns ($result: Ref);



procedure {:extern} CST.CST_Message.respond$CST.CST_Message$System.Web.HttpResponse(msg$in: Ref, response$in: Ref);



implementation Server_A.A_invoke.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref)
{
  var sender: Ref;
  var e: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 5} true;
    call $tmp0 := Alloc();
    call CST.CST_Message.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$CST.CST_Message();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CST.CST_Message;
    local_0_Ref := $tmp0;
    call $tmp1 := System.Web.UI.Page.get_Request($this);
    call $tmp2 := CST.CST_Message.parse$CST.CST_Message$System.Web.HttpRequest(local_0_Ref, $tmp1);
    if ($tmp2)
    {
        assume {:breadcrumb 6} true;
        assume $this != null;
        $tmp3 := F$Server_A.A_invoke.server_a[$this];
        call $tmp4 := ABC.A.invoke$CST.CST_Message($tmp3, local_0_Ref);
        call $tmp5 := System.Web.UI.Page.get_Response($this);
        call CST.CST_Message.respond$CST.CST_Message$System.Web.HttpResponse($tmp4, $tmp5);
    }
    else
    {
        assume {:breadcrumb 7} true;
    }
}



procedure Server_A.A_invoke.#ctor($this: Ref);



procedure {:extern} System.Web.UI.Page.#ctor($this: Ref);



implementation Server_A.A_invoke.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$Server_A.A_invoke.server_a[$this] := null;
    assume {:breadcrumb 8} true;
    call $tmp0 := Alloc();
    call ABC.A.#ctor$System.Int32($tmp0, 40);
    assume $DynamicType($tmp0) == T$ABC.A();
    assume $TypeConstructor($DynamicType($tmp0)) == T$ABC.A;
    F$Server_A.A_invoke.server_a[$this] := $tmp0;
    call System.Web.UI.Page.#ctor($this);
}



procedure T$Server_A.A_invoke.#cctor();



implementation T$Server_A.A_invoke.#cctor()
{
}



var F$ABC.A.data: [Ref]int;

procedure ABC.A.#ctor($this: Ref);



implementation ABC.A.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$ABC.A.data[$this] := 0;
    assume {:breadcrumb 9} true;
    call System.Object.#ctor($this);
}



implementation ABC.A.#ctor$System.Int32($this: Ref, i1$in: int)
{
  var i1: int;
  var $localExc: Ref;
  var $label: int;

    i1 := i1$in;
    F$ABC.A.data[$this] := 0;
    assume {:breadcrumb 10} true;
    call System.Object.#ctor($this);
    F$ABC.A.data[$this] := i1;
}



procedure {:extern} CST.CST_Ops.recordme$CST.CST_Struct(msg$in: Ref);



var {:extern} F$CST.CST_Message.value: [Ref]int;

const {:value "Alice"} unique $string_literal_Alice_0: Ref;

var {:extern} F$CST.CST_Message.largestParty: [Ref]Ref;

var {:extern} F$CST.CST_Struct.SignedBy: [Ref]Ref;

implementation ABC.A.invoke$CST.CST_Message($this: Ref, msg$in: Ref) returns ($result: Ref)
{
  var msg: Ref;
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    msg := msg$in;
    assume {:breadcrumb 11} true;
    call CST.CST_Ops.recordme$CST.CST_Struct(msg);
    assume $this != null;
    F$CST.CST_Message.value[msg] := F$ABC.A.data[$this];
    F$CST.CST_Message.largestParty[msg] := $string_literal_Alice_0;
    F$CST.CST_Struct.SignedBy[msg] := $string_literal_Alice_0;
    local_0_Ref := msg;
    goto IL_002e;

  IL_002e:
    $result := local_0_Ref;
    return;
}



procedure T$ABC.A.#cctor();



implementation T$ABC.A.#cctor()
{
}



var F$ABC.B.data: [Ref]int;

procedure ABC.B.#ctor($this: Ref);



implementation ABC.B.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

    F$ABC.B.data[$this] := 0;
    assume {:breadcrumb 12} true;
    call System.Object.#ctor($this);
}



implementation ABC.B.#ctor$System.Int32($this: Ref, i1$in: int)
{
  var i1: int;
  var $localExc: Ref;
  var $label: int;

    i1 := i1$in;
    F$ABC.B.data[$this] := 0;
    assume {:breadcrumb 13} true;
    call System.Object.#ctor($this);
    F$ABC.B.data[$this] := i1;
}



const {:value "Bob"} unique $string_literal_Bob_1: Ref;

implementation ABC.B.invoke$CST.CST_Message($this: Ref, msg$in: Ref) returns ($result: Ref)
{
  var msg: Ref;
  var $tmp0: Ref;
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    msg := msg$in;
    assume {:breadcrumb 14} true;
    call CST.CST_Ops.recordme$CST.CST_Struct(msg);
    $tmp0 := msg;
    assume $tmp0 != null;
    assume $this != null;
    if (F$CST.CST_Message.value[$tmp0] < F$ABC.B.data[$this])
    {
        assume {:breadcrumb 15} true;
        assume $this != null;
        F$CST.CST_Message.value[msg] := F$ABC.B.data[$this];
        F$CST.CST_Message.largestParty[msg] := $string_literal_Bob_1;
    }
    else
    {
        assume {:breadcrumb 16} true;
    }

    F$CST.CST_Struct.SignedBy[msg] := $string_literal_Bob_1;
    local_0_Ref := msg;
    goto IL_0045;

  IL_0045:
    $result := local_0_Ref;
    return;
}



procedure T$ABC.B.#cctor();



implementation T$ABC.B.#cctor()
{
}



function T$Server_B.B_invoke() : Ref;

const unique T$Server_B.B_invoke: int;

var F$Server_B.B_invoke.server_b: [Ref]Ref;

procedure Server_B.B_invoke.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



implementation Server_B.B_invoke.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref)
{
  var sender: Ref;
  var e: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 17} true;
    call $tmp0 := Alloc();
    call CST.CST_Message.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$CST.CST_Message();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CST.CST_Message;
    local_0_Ref := $tmp0;
    call $tmp1 := System.Web.UI.Page.get_Request($this);
    call $tmp2 := CST.CST_Message.parse$CST.CST_Message$System.Web.HttpRequest(local_0_Ref, $tmp1);
    if ($tmp2)
    {
        assume {:breadcrumb 18} true;
        assume $this != null;
        $tmp3 := F$Server_B.B_invoke.server_b[$this];
        call $tmp4 := ABC.B.invoke$CST.CST_Message($tmp3, local_0_Ref);
        call $tmp5 := System.Web.UI.Page.get_Response($this);
        call CST.CST_Message.respond$CST.CST_Message$System.Web.HttpResponse($tmp4, $tmp5);
    }
    else
    {
        assume {:breadcrumb 19} true;
    }
}



procedure Server_B.B_invoke.#ctor($this: Ref);



implementation Server_B.B_invoke.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$Server_B.B_invoke.server_b[$this] := null;
    assume {:breadcrumb 20} true;
    call $tmp0 := Alloc();
    call ABC.B.#ctor$System.Int32($tmp0, 45);
    assume $DynamicType($tmp0) == T$ABC.B();
    assume $TypeConstructor($DynamicType($tmp0)) == T$ABC.B;
    F$Server_B.B_invoke.server_b[$this] := $tmp0;
    call System.Web.UI.Page.#ctor($this);
}



procedure T$Server_B.B_invoke.#cctor();



implementation T$Server_B.B_invoke.#cctor()
{
}



var F$ABC.C.data: [Ref]int;

var F$ABC.C.conclusion: [Ref]Ref;

procedure ABC.C.#ctor($this: Ref);



implementation ABC.C.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$ABC.C.data[$this] := 0;
    F$ABC.C.conclusion[$this] := null;
    assume {:breadcrumb 21} true;
    call $tmp0 := Alloc();
    call CST.CST_Message.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$CST.CST_Message();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CST.CST_Message;
    F$ABC.C.conclusion[$this] := $tmp0;
    call System.Object.#ctor($this);
}



implementation ABC.C.#ctor$System.Int32($this: Ref, i1$in: int)
{
  var i1: int;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    i1 := i1$in;
    F$ABC.C.data[$this] := 0;
    F$ABC.C.conclusion[$this] := null;
    assume {:breadcrumb 22} true;
    call $tmp0 := Alloc();
    call CST.CST_Message.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$CST.CST_Message();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CST.CST_Message;
    F$ABC.C.conclusion[$this] := $tmp0;
    call System.Object.#ctor($this);
    F$ABC.C.data[$this] := i1;
}



var {:extern} F$CST.CST_Struct.SymT: [Ref]Ref;

const {:value "Charles"} unique $string_literal_Charles_2: Ref;

procedure ABC.C.conclude$CST.CST_Message($this: Ref, msg$in: Ref) returns ($result: bool);



var {:extern} F$CST.CST_Message.certified: [Ref]bool;

const {:value "The largest party is "} unique $string_literal_The$largest$party$is$_3: Ref;

const {:value "."} unique $string_literal_._4: Ref;

procedure {:extern} System.String.Concat$System.String$System.String$System.String(str0$in: Ref, str1$in: Ref, str2$in: Ref) returns ($result: Ref);



procedure {:extern} System.Console.WriteLine$System.String(value$in: Ref);



const {:value "Not verified."} unique $string_literal_Not$verified._5: Ref;

implementation ABC.C.invoke$CST.CST_Message($this: Ref, msg$in: Ref) returns ($result: Ref)
{
  var msg: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: bool;
  var $tmp6: Ref;
  var $tmp7: Ref;
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

    msg := msg$in;
    assume {:breadcrumb 23} true;
    call CST.CST_Ops.recordme$CST.CST_Struct(msg);
    $tmp0 := msg;
    assume $tmp0 != null;
    assume $this != null;
    F$CST.CST_Message.value[F$ABC.C.conclusion[$this]] := F$CST.CST_Message.value[$tmp0];
    $tmp1 := msg;
    assume $tmp1 != null;
    assume $this != null;
    F$CST.CST_Message.largestParty[F$ABC.C.conclusion[$this]] := F$CST.CST_Message.largestParty[$tmp1];
    $tmp2 := msg;
    assume $tmp2 != null;
    assume $this != null;
    F$CST.CST_Struct.SignedBy[F$ABC.C.conclusion[$this]] := F$CST.CST_Struct.SignedBy[$tmp2];
    $tmp3 := msg;
    assume $tmp3 != null;
    assume $this != null;
    F$CST.CST_Struct.SymT[F$ABC.C.conclusion[$this]] := F$CST.CST_Struct.SymT[$tmp3];
    assume $this != null;
    $tmp4 := F$ABC.C.conclusion[$this];
    assume $tmp4 != null;
    assume $this != null;
    if (F$CST.CST_Message.value[$tmp4] < F$ABC.C.data[$this])
    {
        assume {:breadcrumb 24} true;
        assume $this != null;
        F$CST.CST_Message.largestParty[F$ABC.C.conclusion[$this]] := $string_literal_Charles_2;
        assume $this != null;
        assume $this != null;
        F$CST.CST_Message.value[F$ABC.C.conclusion[$this]] := F$ABC.C.data[$this];
    }
    else
    {
        assume {:breadcrumb 25} true;
    }

    assume $this != null;
    F$CST.CST_Struct.SignedBy[F$ABC.C.conclusion[$this]] := $string_literal_Charles_2;
    assume $this != null;
    call $tmp5 := ABC.C.conclude$CST.CST_Message($this, F$ABC.C.conclusion[$this]);
    if ($tmp5)
    {
        assume {:breadcrumb 26} true;
        F$CST.CST_Message.certified[msg] := true;
        assume $this != null;
        $tmp6 := F$ABC.C.conclusion[$this];
        assume $tmp6 != null;
        call $tmp7 := System.String.Concat$System.String$System.String$System.String($string_literal_The$largest$party$is$_3, F$CST.CST_Message.largestParty[$tmp6], $string_literal_._4);
        call System.Console.WriteLine$System.String($tmp7);
    }
    else
    {
        assume {:breadcrumb 27} true;
        F$CST.CST_Message.certified[msg] := false;
        call System.Console.WriteLine$System.String($string_literal_Not$verified._5);
    }

    local_0_Ref := msg;
    goto IL_00ef;

  IL_00ef:
    $result := local_0_Ref;
    return;
}



procedure {:extern} CST.CST_Ops.Certify$CST.CST_Struct(msg$in: Ref) returns ($result: bool);



implementation ABC.C.conclude$CST.CST_Message($this: Ref, msg$in: Ref) returns ($result: bool)
{
  var msg: Ref;
  var local_0_bool: bool;
  var $tmp0: bool;
  var $localExc: Ref;
  var $label: int;

    msg := msg$in;
    assume {:breadcrumb 28} true;
    call $tmp0 := CST.CST_Ops.Certify$CST.CST_Struct(msg);
    local_0_bool := $tmp0;
    goto IL_000a;

  IL_000a:
    $result := local_0_bool;
    return;
}



procedure T$ABC.C.#cctor();



implementation T$ABC.C.#cctor()
{
}



function T$Server_C.C_invoke() : Ref;

const unique T$Server_C.C_invoke: int;

var F$Server_C.C_invoke.server_c: [Ref]Ref;

procedure Server_C.C_invoke.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



implementation Server_C.C_invoke.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref)
{
  var sender: Ref;
  var e: Ref;
  var local_0_Ref: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: bool;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $localExc: Ref;
  var $label: int;

    sender := sender$in;
    e := e$in;
    assume {:breadcrumb 29} true;
    call $tmp0 := Alloc();
    call CST.CST_Message.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$CST.CST_Message();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CST.CST_Message;
    local_0_Ref := $tmp0;
    call $tmp1 := System.Web.UI.Page.get_Request($this);
    call $tmp2 := CST.CST_Message.parse$CST.CST_Message$System.Web.HttpRequest(local_0_Ref, $tmp1);
    if ($tmp2)
    {
        assume {:breadcrumb 30} true;
        assume $this != null;
        $tmp3 := F$Server_C.C_invoke.server_c[$this];
        call $tmp4 := ABC.C.invoke$CST.CST_Message($tmp3, local_0_Ref);
        call $tmp5 := System.Web.UI.Page.get_Response($this);
        call CST.CST_Message.respond$CST.CST_Message$System.Web.HttpResponse($tmp4, $tmp5);
    }
    else
    {
        assume {:breadcrumb 31} true;
    }
}



procedure Server_C.C_invoke.#ctor($this: Ref);



implementation Server_C.C_invoke.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

    F$Server_C.C_invoke.server_c[$this] := null;
    assume {:breadcrumb 32} true;
    call $tmp0 := Alloc();
    call ABC.C.#ctor$System.Int32($tmp0, 50);
    assume $DynamicType($tmp0) == T$ABC.C();
    assume $TypeConstructor($DynamicType($tmp0)) == T$ABC.C;
    F$Server_C.C_invoke.server_c[$this] := $tmp0;
    call System.Web.UI.Page.#ctor($this);
}



procedure T$Server_C.C_invoke.#cctor();



implementation T$Server_C.C_invoke.#cctor()
{
}


