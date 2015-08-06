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

function T$GlobalObjectsForCST() : Ref;

const unique T$GlobalObjectsForCST: int;

var F$GlobalObjectsForCST.A: Ref;

var F$GlobalObjectsForCST.B: Ref;

var F$GlobalObjectsForCST.C: Ref;

procedure GlobalObjectsForCST.#ctor($this: Ref);



procedure {:extern} System.Object.#ctor($this: Ref);



procedure GlobalObjectsForCST.#cctor();
  modifies F$GlobalObjectsForCST.A, F$GlobalObjectsForCST.B, F$GlobalObjectsForCST.C, $Alloc, F$ABC.A.data, F$ABC.B.data, F$ABC.C.data, F$ABC.C.conclusion, F$CST.Message.value, F$CST.Message.largestParty, F$CST.Message.certified, F$CST.CST_Struct.SymT, F$CST.CST_Struct.SignedBy;



var F$PoirotMain.Nondet: Ref;

procedure {:extern} CST.Nondet_Base.Int($this: Ref) returns ($result: int);



procedure {:extern} ABC.A.#ctor$System.Int32($this: Ref, i1$in: int);
  modifies F$ABC.A.data;



function {:extern} T$ABC.A() : Ref;

const {:extern} unique T$ABC.A: int;

axiom $TypeConstructor(T$ABC.A()) == T$ABC.A;

procedure {:extern} ABC.B.#ctor$System.Int32($this: Ref, i1$in: int);
  modifies F$ABC.B.data;



function {:extern} T$ABC.B() : Ref;

const {:extern} unique T$ABC.B: int;

axiom $TypeConstructor(T$ABC.B()) == T$ABC.B;

procedure {:extern} ABC.C.#ctor$System.Int32($this: Ref, i1$in: int);
  modifies F$ABC.C.data, F$ABC.C.conclusion, $Alloc, F$CST.Message.value, F$CST.Message.largestParty, F$CST.Message.certified, F$CST.CST_Struct.SymT, F$CST.CST_Struct.SignedBy;



function {:extern} T$ABC.C() : Ref;

const {:extern} unique T$ABC.C: int;

axiom $TypeConstructor(T$ABC.C()) == T$ABC.C;

implementation GlobalObjectsForCST.#cctor()
{
  var $tmp0: Ref;
  var $tmp1: int;
  var $tmp2: Ref;
  var $tmp3: int;
  var $tmp4: Ref;
  var $tmp5: int;
  var inline$Alloc$0$x: Ref;
  var inline$Alloc$0$$Alloc: [Ref]bool;
  var inline$Alloc$1$x: Ref;
  var inline$Alloc$1$$Alloc: [Ref]bool;
  var inline$Alloc$2$x: Ref;
  var inline$Alloc$2$$Alloc: [Ref]bool;

  anon0:
    F$GlobalObjectsForCST.A := null;
    F$GlobalObjectsForCST.B := null;
    F$GlobalObjectsForCST.C := null;
    assume {:breadcrumb 1} true;
    goto corral_source_split_1;

  corral_source_split_1:
    goto corral_source_split_2;

  corral_source_split_2:
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
    call {:si_unique_call 0} $tmp1 := CST.Nondet_Base.Int(F$PoirotMain.Nondet);
    goto corral_source_split_4;

  corral_source_split_4:
    call {:si_unique_call 1} ABC.A.#ctor$System.Int32($tmp0, $tmp1);
    assume $DynamicType($tmp0) == T$ABC.A();
    assume $TypeConstructor($DynamicType($tmp0)) == T$ABC.A;
    F$GlobalObjectsForCST.A := $tmp0;
    goto corral_source_split_5;

  corral_source_split_5:
    goto corral_source_split_6;

  corral_source_split_6:
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
    call {:si_unique_call 2} $tmp3 := CST.Nondet_Base.Int(F$PoirotMain.Nondet);
    goto corral_source_split_8;

  corral_source_split_8:
    call {:si_unique_call 3} ABC.B.#ctor$System.Int32($tmp2, $tmp3);
    assume $DynamicType($tmp2) == T$ABC.B();
    assume $TypeConstructor($DynamicType($tmp2)) == T$ABC.B;
    F$GlobalObjectsForCST.B := $tmp2;
    goto corral_source_split_9;

  corral_source_split_9:
    goto corral_source_split_10;

  corral_source_split_10:
    goto inline$Alloc$2$Entry;

  inline$Alloc$2$Entry:
    havoc inline$Alloc$2$x;
    inline$Alloc$2$$Alloc := $Alloc;
    goto inline$Alloc$2$anon0;

  inline$Alloc$2$anon0:
    assume ($Alloc[inline$Alloc$2$x] <==> false) && inline$Alloc$2$x != null;
    $Alloc[inline$Alloc$2$x] := true;
    goto inline$Alloc$2$Return;

  inline$Alloc$2$Return:
    $tmp4 := inline$Alloc$2$x;
    goto anon0$3;

  anon0$3:
    call {:si_unique_call 4} $tmp5 := CST.Nondet_Base.Int(F$PoirotMain.Nondet);
    goto corral_source_split_12;

  corral_source_split_12:
    call {:si_unique_call 5} ABC.C.#ctor$System.Int32($tmp4, $tmp5);
    assume $DynamicType($tmp4) == T$ABC.C();
    assume $TypeConstructor($DynamicType($tmp4)) == T$ABC.C;
    F$GlobalObjectsForCST.C := $tmp4;
    return;
}



function T$SynthesizedPortion() : Ref;

const unique T$SynthesizedPortion: int;

procedure SynthesizedPortion.SynthesizedSequence();
  modifies F$CST.Message.value, F$CST.Message.largestParty, F$CST.CST_Struct.SignedBy, F$CST.Message.certified;



procedure NondetVProgram.Message($this: Ref) returns ($result: Ref);



procedure {:extern} ABC.C.invoke$CST.Message($this: Ref, in_msg$in: Ref) returns ($result: Ref);
  modifies F$CST.Message.value, F$CST.Message.largestParty, F$CST.CST_Struct.SignedBy, F$CST.Message.certified;



implementation SynthesizedPortion.SynthesizedSequence()
{
  var C1_Ref: Ref;
  var $tmp0: Ref;
  var C2_Ref: Ref;
  var $tmp1: Ref;

  anon0:
    assume {:breadcrumb 2} true;
    goto corral_source_split_14;

  corral_source_split_14:
    goto corral_source_split_15;

  corral_source_split_15:
    call {:si_unique_call 6} $tmp0 := NondetVProgram.Message(F$PoirotMain.Nondet);
    C1_Ref := $tmp0;
    goto corral_source_split_16;

  corral_source_split_16:
    goto corral_source_split_17;

  corral_source_split_17:
    call {:si_unique_call 7} $tmp1 := ABC.C.invoke$CST.Message(F$GlobalObjectsForCST.C, C1_Ref);
    C2_Ref := $tmp1;
    return;
}



procedure SynthesizedPortion.#ctor($this: Ref);



procedure T$SynthesizedPortion.#cctor();



implementation T$SynthesizedPortion.#cctor()
{

  anon0:
    return;
}



function T$NondetVProgram() : Ref;

const unique T$NondetVProgram: int;

function T$PoirotMain() : Ref;

const unique T$PoirotMain: int;

procedure PoirotMain.check_Assertion();



var {:extern} F$ABC.A.data: [Ref]int;

var {:extern} F$ABC.C.data: [Ref]int;

var {:extern} F$ABC.B.data: [Ref]int;

var {:extern} F$ABC.C.conclusion: [Ref]Ref;

var {:extern} F$CST.Message.largestParty: [Ref]Ref;

const {:value "Alice"} unique $string_literal_Alice_0: Ref;

implementation PoirotMain.check_Assertion()
{
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: Ref;
  var $tmp5: Ref;
  var $tmp6: bool;
  var inline$System.String.op_Equality$System.String$System.String$0$a$in: Ref;
  var inline$System.String.op_Equality$System.String$System.String$0$b$in: Ref;
  var inline$System.String.op_Equality$System.String$System.String$0$$result: bool;

  anon0:
    assume {:breadcrumb 4} true;
    goto corral_source_split_19;

  corral_source_split_19:
    $tmp4 := F$GlobalObjectsForCST.C;
    assume $tmp4 != null;
    $tmp5 := F$ABC.C.conclusion[$tmp4];
    assume $tmp5 != null;
    goto corral_source_split_20;

  corral_source_split_20:
    goto inline$System.String.op_Equality$System.String$System.String$0$Entry;

  inline$System.String.op_Equality$System.String$System.String$0$Entry:
    inline$System.String.op_Equality$System.String$System.String$0$a$in := F$CST.Message.largestParty[$tmp5];
    inline$System.String.op_Equality$System.String$System.String$0$b$in := $string_literal_Alice_0;
    havoc inline$System.String.op_Equality$System.String$System.String$0$$result;
    goto inline$System.String.op_Equality$System.String$System.String$0$anon0;

  inline$System.String.op_Equality$System.String$System.String$0$anon0:
    inline$System.String.op_Equality$System.String$System.String$0$$result := inline$System.String.op_Equality$System.String$System.String$0$a$in == inline$System.String.op_Equality$System.String$System.String$0$b$in;
    goto inline$System.String.op_Equality$System.String$System.String$0$Return;

  inline$System.String.op_Equality$System.String$System.String$0$Return:
    $tmp6 := inline$System.String.op_Equality$System.String$System.String$0$$result;
    goto anon0$1;

  anon0$1:
    goto anon6_Then, anon6_Else;

  anon6_Then:
    assume {:partition} !$tmp6;
    goto anon5;

  anon6_Else:
    assume {:partition} $tmp6;
    $tmp2 := F$GlobalObjectsForCST.A;
    assume $tmp2 != null;
    $tmp3 := F$GlobalObjectsForCST.B;
    assume $tmp3 != null;
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} F$ABC.A.data[$tmp2] < F$ABC.B.data[$tmp3];
    goto anon5;

  anon7_Else:
    assume {:partition} F$ABC.B.data[$tmp3] <= F$ABC.A.data[$tmp2];
    $tmp0 := F$GlobalObjectsForCST.A;
    assume $tmp0 != null;
    $tmp1 := F$GlobalObjectsForCST.C;
    assume $tmp1 != null;
    goto anon5;

  anon5:
    assert (if !$tmp6 then true else (if F$ABC.A.data[$tmp2] < F$ABC.B.data[$tmp3] then false else !(F$ABC.A.data[$tmp0] < F$ABC.C.data[$tmp1])));
    return;
}



procedure {:entrypoint} PoirotMain.Main();
  modifies F$GlobalObjectsForCST.A, F$GlobalObjectsForCST.B, F$GlobalObjectsForCST.C, $Alloc, $Exception, $GetMeHereTracker, F$ABC.A.data, F$ABC.B.data, F$ABC.C.data, F$ABC.C.conclusion, F$PoirotMain.Nondet, F$CST.Message.value, F$CST.Message.largestParty, F$CST.CST_Struct.SignedBy, F$CST.Message.certified, F$CST.CST_Struct.SymT;



implementation PoirotMain.Main()
{

  anon0:
    call {:si_unique_call 8} GlobalObjectsForCST.#cctor();
    call {:si_unique_call 9} T$SynthesizedPortion.#cctor();
    call {:si_unique_call 10} T$PoirotMain.#cctor();
    call {:si_unique_call 11} T$ABC.A.#cctor();
    call {:si_unique_call 12} T$Server_A.A_invoke.#cctor();
    call {:si_unique_call 13} T$ABC.B.#cctor();
    call {:si_unique_call 14} T$Server_B.B_invoke.#cctor();
    call {:si_unique_call 15} T$Server_C.C_invoke.#cctor();
    call {:si_unique_call 16} T$ABC.C.#cctor();
    call {:si_unique_call 17} T$CST.Message.#cctor();
    call {:si_unique_call 18} T$CST.CST_Struct.#cctor();
    call {:si_unique_call 19} T$CST.Debug.#cctor();
    $Exception := null;
    $GetMeHereTracker := 0;
    assume {:breadcrumb 5} true;
    goto corral_source_split_22;

  corral_source_split_22:
    goto corral_source_split_23;

  corral_source_split_23:
    call {:si_unique_call 20} SynthesizedPortion.SynthesizedSequence();
    goto corral_source_split_24;

  corral_source_split_24:
    goto corral_source_split_25;

  corral_source_split_25:
    call {:si_unique_call 21} PoirotMain.check_Assertion();
    return;
}



procedure PoirotMain.#ctor($this: Ref);



procedure T$PoirotMain.#cctor();
  modifies F$PoirotMain.Nondet;



implementation T$PoirotMain.#cctor()
{

  anon0:
    F$PoirotMain.Nondet := null;
    return;
}



procedure ABC.A.#ctor($this: Ref);



implementation ABC.A.#ctor$System.Int32($this: Ref, i1$in: int)
{
  var i1: int;

  anon0:
    i1 := i1$in;
    F$ABC.A.data[$this] := 0;
    assume {:breadcrumb 8} true;
    call {:si_unique_call 22} System.Object.#ctor($this);
    F$ABC.A.data[$this] := i1;
    return;
}



procedure ABC.A.invoke$CST.Message($this: Ref, in_msg$in: Ref) returns ($result: Ref);



procedure {:extern} CST.Message.#ctor($this: Ref);
  modifies F$CST.Message.value, F$CST.Message.largestParty, F$CST.Message.certified, F$CST.CST_Struct.SymT, F$CST.CST_Struct.SignedBy;



function {:extern} T$CST.Message() : Ref;

const {:extern} unique T$CST.Message: int;

axiom $TypeConstructor(T$CST.Message()) == T$CST.Message;

procedure {:extern} CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct(o$in: Ref, in_msg$in: Ref, out_msg$in: Ref);



var {:extern} F$CST.Message.value: [Ref]int;

var {:extern} F$CST.CST_Struct.SignedBy: [Ref]Ref;

procedure T$ABC.A.#cctor();



implementation T$ABC.A.#cctor()
{

  anon0:
    return;
}



function T$Server_A.A_invoke() : Ref;

const unique T$Server_A.A_invoke: int;

var F$Server_A.A_invoke.server_a: [Ref]Ref;

procedure Server_A.A_invoke.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



procedure {:extern} System.Web.UI.Page.get_Request($this: Ref) returns ($result: Ref);



procedure {:extern} CST.Message.parse$CST.Message$System.Web.HttpRequest(msg$in: Ref, request$in: Ref) returns ($result: bool);



procedure {:extern} System.Web.UI.Page.get_Response($this: Ref) returns ($result: Ref);



procedure {:extern} CST.Message.respond$CST.Message$System.Web.HttpResponse(msg$in: Ref, response$in: Ref);



procedure Server_A.A_invoke.#ctor($this: Ref);



procedure {:extern} System.Web.UI.Page.#ctor($this: Ref);



procedure T$Server_A.A_invoke.#cctor();



implementation T$Server_A.A_invoke.#cctor()
{

  anon0:
    return;
}



procedure ABC.B.#ctor($this: Ref);



implementation ABC.B.#ctor$System.Int32($this: Ref, i1$in: int)
{
  var i1: int;

  anon0:
    i1 := i1$in;
    F$ABC.B.data[$this] := 0;
    assume {:breadcrumb 15} true;
    call {:si_unique_call 23} System.Object.#ctor($this);
    F$ABC.B.data[$this] := i1;
    return;
}



procedure ABC.B.invoke$CST.Message($this: Ref, in_msg$in: Ref) returns ($result: Ref);



const {:value "Bob"} unique $string_literal_Bob_1: Ref;

procedure T$ABC.B.#cctor();



implementation T$ABC.B.#cctor()
{

  anon0:
    return;
}



function T$Server_B.B_invoke() : Ref;

const unique T$Server_B.B_invoke: int;

var F$Server_B.B_invoke.server_b: [Ref]Ref;

procedure Server_B.B_invoke.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



procedure Server_B.B_invoke.#ctor($this: Ref);



procedure T$Server_B.B_invoke.#cctor();



implementation T$Server_B.B_invoke.#cctor()
{

  anon0:
    return;
}



function T$Server_C.C_invoke() : Ref;

const unique T$Server_C.C_invoke: int;

var F$Server_C.C_invoke.server_c: [Ref]Ref;

procedure Server_C.C_invoke.Page_Load$System.Object$System.EventArgs($this: Ref, sender$in: Ref, e$in: Ref);



procedure Server_C.C_invoke.#ctor($this: Ref);



procedure T$Server_C.C_invoke.#cctor();



implementation T$Server_C.C_invoke.#cctor()
{

  anon0:
    return;
}



procedure ABC.C.#ctor($this: Ref);



implementation ABC.C.#ctor$System.Int32($this: Ref, i1$in: int)
{
  var i1: int;
  var $tmp0: Ref;
  var inline$Alloc$0$x: Ref;
  var inline$Alloc$0$$Alloc: [Ref]bool;

  anon0:
    i1 := i1$in;
    F$ABC.C.data[$this] := 0;
    F$ABC.C.conclusion[$this] := null;
    assume {:breadcrumb 28} true;
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
    call {:si_unique_call 24} CST.Message.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$CST.Message();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CST.Message;
    F$ABC.C.conclusion[$this] := $tmp0;
    call {:si_unique_call 25} System.Object.#ctor($this);
    F$ABC.C.data[$this] := i1;
    return;
}



const {:value "Charles"} unique $string_literal_Charles_2: Ref;

procedure ABC.C.conclude$CST.Message($this: Ref, msg$in: Ref) returns ($result: bool);



var {:extern} F$CST.Message.certified: [Ref]bool;

const {:value "The largest party is "} unique $string_literal_The$largest$party$is$_3: Ref;

const {:value "."} unique $string_literal_._4: Ref;

procedure {:extern} System.String.Concat$System.String$System.String$System.String(str0$in: Ref, str1$in: Ref, str2$in: Ref) returns ($result: Ref);



procedure {:extern} System.Console.WriteLine$System.String(value$in: Ref);



const {:value "Not verified."} unique $string_literal_Not$verified._5: Ref;

implementation ABC.C.invoke$CST.Message($this: Ref, in_msg$in: Ref) returns ($result: Ref)
{
  var in_msg: Ref;
  var $tmp0: Ref;
  var $tmp1: Ref;
  var $tmp2: Ref;
  var $tmp3: Ref;
  var $tmp4: bool;
  var $tmp5: Ref;
  var $tmp6: Ref;
  var local_0_Ref: Ref;

  anon0:
    in_msg := in_msg$in;
    assume {:breadcrumb 29} true;
    assume $this != null;
    call {:si_unique_call 26} CST.CST_Ops.recordme$System.Object$CST.CST_Struct$CST.CST_Struct($this, in_msg, F$ABC.C.conclusion[$this]);
    $tmp0 := in_msg;
    assume $tmp0 != null;
    assume $this != null;
    F$CST.Message.value[F$ABC.C.conclusion[$this]] := F$CST.Message.value[$tmp0];
    $tmp1 := in_msg;
    assume $tmp1 != null;
    assume $this != null;
    F$CST.Message.largestParty[F$ABC.C.conclusion[$this]] := F$CST.Message.largestParty[$tmp1];
    $tmp2 := in_msg;
    assume $tmp2 != null;
    assume $this != null;
    F$CST.CST_Struct.SignedBy[F$ABC.C.conclusion[$this]] := F$CST.CST_Struct.SignedBy[$tmp2];
    assume $this != null;
    $tmp3 := F$ABC.C.conclusion[$this];
    assume $tmp3 != null;
    assume $this != null;
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} F$CST.Message.value[$tmp3] < F$ABC.C.data[$this];
    assume {:breadcrumb 30} true;
    assume $this != null;
    F$CST.Message.largestParty[F$ABC.C.conclusion[$this]] := $string_literal_Charles_2;
    assume $this != null;
    assume $this != null;
    F$CST.Message.value[F$ABC.C.conclusion[$this]] := F$ABC.C.data[$this];
    goto anon3;

  anon7_Else:
    assume {:partition} F$ABC.C.data[$this] <= F$CST.Message.value[$tmp3];
    assume {:breadcrumb 31} true;
    goto anon3;

  anon3:
    assume $this != null;
    F$CST.CST_Struct.SignedBy[F$ABC.C.conclusion[$this]] := $string_literal_Charles_2;
    assume $this != null;
    call {:si_unique_call 27} $tmp4 := ABC.C.conclude$CST.Message($this, F$ABC.C.conclusion[$this]);
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} $tmp4;
    assume {:breadcrumb 32} true;
    assume $this != null;
    F$CST.Message.certified[F$ABC.C.conclusion[$this]] := true;
    assume $this != null;
    $tmp5 := F$ABC.C.conclusion[$this];
    assume $tmp5 != null;
    call {:si_unique_call 28} $tmp6 := System.String.Concat$System.String$System.String$System.String($string_literal_The$largest$party$is$_3, F$CST.Message.largestParty[$tmp5], $string_literal_._4);
    call {:si_unique_call 29} System.Console.WriteLine$System.String($tmp6);
    goto anon6;

  anon8_Else:
    assume {:partition} !$tmp4;
    assume {:breadcrumb 33} true;
    assume $this != null;
    F$CST.Message.certified[F$ABC.C.conclusion[$this]] := false;
    call {:si_unique_call 30} System.Console.WriteLine$System.String($string_literal_Not$verified._5);
    goto anon6;

  anon6:
    assume $this != null;
    local_0_Ref := F$ABC.C.conclusion[$this];
    goto IL_00f4;

  IL_00f4:
    $result := local_0_Ref;
    return;
}



procedure {:extern} CST.CST_Ops.Certify$CST.CST_Struct(msg$in: Ref) returns ($result: bool);



implementation ABC.C.conclude$CST.Message($this: Ref, msg$in: Ref) returns ($result: bool)
{
  var msg: Ref;
  var local_0_bool: bool;
  var $tmp0: bool;

  anon0:
    msg := msg$in;
    assume {:breadcrumb 34} true;
    call {:si_unique_call 31} $tmp0 := CST.CST_Ops.Certify$CST.CST_Struct(msg);
    local_0_bool := $tmp0;
    goto IL_000a;

  IL_000a:
    $result := local_0_bool;
    return;
}



procedure T$ABC.C.#cctor();



implementation T$ABC.C.#cctor()
{

  anon0:
    return;
}



procedure {:extern} System.Web.HttpRequest.get_QueryString($this: Ref) returns ($result: Ref);



const {:value "SymT"} unique $string_literal_SymT_6: Ref;

procedure {:extern} System.Collections.Specialized.NameValueCollection.get_Item$System.String($this: Ref, name$in: Ref) returns ($result: Ref);



var {:extern} F$CST.CST_Struct.SymT: [Ref]Ref;

const {:value "SignedBy"} unique $string_literal_SignedBy_7: Ref;

const {:value "value"} unique $string_literal_value_8: Ref;

const {:value "Value"} unique $string_literal_Value_9: Ref;

procedure {:extern} System.Int32.Parse$System.String(s$in: Ref) returns ($result: int);



const {:value "LargestParty"} unique $string_literal_LargestParty_10: Ref;

procedure CST.Message.SignatureValid$System.Web.HttpRequest(request$in: Ref) returns ($result: bool);



procedure {:extern} System.String.get_Length($this: Ref) returns ($result: int);



procedure CST.Message.generateErrorResponse();



procedure {:extern} System.Collections.Generic.Dictionary`2.#ctor($this: Ref);



function {:extern} TKey$T$System.Collections.Generic.Dictionary`2(parent: Ref) : Ref;

function {:extern} TValue$T$System.Collections.Generic.Dictionary`2(parent: Ref) : Ref;

function {:extern} T$System.Collections.Generic.Dictionary`2(TKey: Ref, TValue: Ref) : Ref;

const {:extern} unique T$System.Collections.Generic.Dictionary`2: int;

function {:extern} T$System.String() : Ref;

const {:extern} unique T$System.String: int;

axiom $TypeConstructor(T$System.String()) == T$System.String;

procedure {:extern} System.Collections.Generic.Dictionary`2.Add$`0$`1($this: Ref, key$in: Ref, value$in: Ref);



procedure {:extern} System.Int32.ToString($this: int) returns ($result: Ref);



const {:value "Certified"} unique $string_literal_Certified_11: Ref;

procedure {:extern} System.Boolean.ToString($this: bool) returns ($result: Ref);



procedure {:extern} HTTP.HTTPComm.GenerateXML$System.Collections.Generic.Dictionary$System.String$System.String$(msgDict$in: Ref) returns ($result: Ref);



procedure {:extern} System.Web.HttpResponse.set_StatusCode$System.Int32($this: Ref, value$in: int);



const {:value "text/xml"} unique $string_literal_text$xml_12: Ref;

procedure {:extern} System.Web.HttpResponse.set_ContentType$System.String($this: Ref, value$in: Ref);



procedure {:extern} System.Text.Encoding.get_UTF8() returns ($result: Ref);



procedure {:extern} System.Web.HttpResponse.set_ContentEncoding$System.Text.Encoding($this: Ref, value$in: Ref);



procedure {:extern} System.Web.HttpResponse.get_Output($this: Ref) returns ($result: Ref);



procedure {:extern} System.Xml.XmlDocument.Save$System.IO.TextWriter($this: Ref, writer$in: Ref);



procedure {:extern} CST.CST_Struct.#ctor($this: Ref);
  modifies F$CST.CST_Struct.SymT, F$CST.CST_Struct.SignedBy;



implementation CST.Message.#ctor($this: Ref)
{

  anon0:
    F$CST.Message.value[$this] := 0;
    F$CST.Message.largestParty[$this] := null;
    F$CST.Message.certified[$this] := false;
    assume {:breadcrumb 43} true;
    call {:si_unique_call 32} CST.CST_Struct.#ctor($this);
    return;
}



procedure T$CST.Message.#cctor();



implementation T$CST.Message.#cctor()
{

  anon0:
    return;
}



function T$CST.Nondet_Base() : Ref;

const unique T$CST.Nondet_Base: int;

procedure CST.Nondet_Base.String($this: Ref) returns ($result: Ref);



procedure CST.Nondet_Base.Bool($this: Ref) returns ($result: bool);



function T$CST.CST_Struct() : Ref;

const unique T$CST.CST_Struct: int;

const {:value ""} unique $string_literal__13: Ref;

implementation CST.CST_Struct.#ctor($this: Ref)
{

  anon0:
    F$CST.CST_Struct.SymT[$this] := null;
    F$CST.CST_Struct.SignedBy[$this] := null;
    assume {:breadcrumb 44} true;
    F$CST.CST_Struct.SymT[$this] := $string_literal__13;
    F$CST.CST_Struct.SignedBy[$this] := $string_literal__13;
    call {:si_unique_call 33} System.Object.#ctor($this);
    return;
}



procedure T$CST.CST_Struct.#cctor();



implementation T$CST.CST_Struct.#cctor()
{

  anon0:
    return;
}



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



procedure corral_atomic_begin();



procedure corral_atomic_end();



procedure corral_getThreadID() returns (id: int);



var $GetMeHereTracker: int;
