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

  anon0:
    assume {:breadcrumb 0} true;
    return;
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

  anon0:
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
    return;
}



procedure {:entrypoint} PoirotMain.Main();



implementation PoirotMain.Main()
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    call PoirotMain.#cctor();
    call T$Server_A.A_invoke.#cctor();
    call T$ABC.A.#cctor();
    call T$ABC.B.#cctor();
    call T$Server_B.B_invoke.#cctor();
    call T$ABC.C.#cctor();
    call T$Server_C.C_invoke.#cctor();
    $Exception := null;
    $GetMeHereTracker := 0;
    assume {:breadcrumb 2} true;
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 19} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 19} true;
    call PoirotMain.call_SynthesizedSequence();
    assert {:first} {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 20} true;
    assert {:sourceFile "c:\Users\t-das\Documents\Visual Studio 2013\Projects\AuthClassLib\src\Examples\ABC\VProgram\VProgram.cs"} {:sourceLine 20} true;
    call PoirotMain.check_Assertion();
    return;
}



procedure PoirotMain.#ctor($this: Ref);



procedure {:extern} System.Object.#ctor($this: Ref);



implementation PoirotMain.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    assume {:breadcrumb 3} true;
    call System.Object.#ctor($this);
    return;
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

  anon0:
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
    return;
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

  anon0:
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
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} $tmp2;
    assume {:breadcrumb 6} true;
    assume $this != null;
    $tmp3 := F$Server_A.A_invoke.server_a[$this];
    call $tmp4 := ABC.A.invoke$CST.CST_Message($tmp3, local_0_Ref);
    call $tmp5 := System.Web.UI.Page.get_Response($this);
    call CST.CST_Message.respond$CST.CST_Message$System.Web.HttpResponse($tmp4, $tmp5);
    return;

  anon3_Else:
    assume {:partition} !$tmp2;
    assume {:breadcrumb 7} true;
    return;
}



procedure Server_A.A_invoke.#ctor($this: Ref);



procedure {:extern} System.Web.UI.Page.#ctor($this: Ref);



implementation Server_A.A_invoke.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$Server_A.A_invoke.server_a[$this] := null;
    assume {:breadcrumb 8} true;
    call $tmp0 := Alloc();
    call ABC.A.#ctor$System.Int32($tmp0, 40);
    assume $DynamicType($tmp0) == T$ABC.A();
    assume $TypeConstructor($DynamicType($tmp0)) == T$ABC.A;
    F$Server_A.A_invoke.server_a[$this] := $tmp0;
    call System.Web.UI.Page.#ctor($this);
    return;
}



procedure T$Server_A.A_invoke.#cctor();



implementation T$Server_A.A_invoke.#cctor()
{

  anon0:
    return;
}



var F$ABC.A.data: [Ref]int;

procedure ABC.A.#ctor($this: Ref);



implementation ABC.A.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$ABC.A.data[$this] := 0;
    assume {:breadcrumb 9} true;
    call System.Object.#ctor($this);
    return;
}



implementation ABC.A.#ctor$System.Int32($this: Ref, i1$in: int)
{
  var i1: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    i1 := i1$in;
    F$ABC.A.data[$this] := 0;
    assume {:breadcrumb 10} true;
    call System.Object.#ctor($this);
    F$ABC.A.data[$this] := i1;
    return;
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

  anon0:
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

  anon0:
    return;
}



var F$ABC.B.data: [Ref]int;

procedure ABC.B.#ctor($this: Ref);



implementation ABC.B.#ctor($this: Ref)
{
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$ABC.B.data[$this] := 0;
    assume {:breadcrumb 12} true;
    call System.Object.#ctor($this);
    return;
}



implementation ABC.B.#ctor$System.Int32($this: Ref, i1$in: int)
{
  var i1: int;
  var $localExc: Ref;
  var $label: int;

  anon0:
    i1 := i1$in;
    F$ABC.B.data[$this] := 0;
    assume {:breadcrumb 13} true;
    call System.Object.#ctor($this);
    F$ABC.B.data[$this] := i1;
    return;
}



const {:value "Bob"} unique $string_literal_Bob_1: Ref;

implementation ABC.B.invoke$CST.CST_Message($this: Ref, msg$in: Ref) returns ($result: Ref)
{
  var msg: Ref;
  var $tmp0: Ref;
  var local_0_Ref: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    msg := msg$in;
    assume {:breadcrumb 14} true;
    call CST.CST_Ops.recordme$CST.CST_Struct(msg);
    $tmp0 := msg;
    assume $tmp0 != null;
    assume $this != null;
    goto anon4_Then, anon4_Else;

  anon4_Then:
    assume {:partition} F$CST.CST_Message.value[$tmp0] < F$ABC.B.data[$this];
    assume {:breadcrumb 15} true;
    assume $this != null;
    F$CST.CST_Message.value[msg] := F$ABC.B.data[$this];
    F$CST.CST_Message.largestParty[msg] := $string_literal_Bob_1;
    goto anon3;

  anon4_Else:
    assume {:partition} F$ABC.B.data[$this] <= F$CST.CST_Message.value[$tmp0];
    assume {:breadcrumb 16} true;
    goto anon3;

  anon3:
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

  anon0:
    return;
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

  anon0:
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
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} $tmp2;
    assume {:breadcrumb 18} true;
    assume $this != null;
    $tmp3 := F$Server_B.B_invoke.server_b[$this];
    call $tmp4 := ABC.B.invoke$CST.CST_Message($tmp3, local_0_Ref);
    call $tmp5 := System.Web.UI.Page.get_Response($this);
    call CST.CST_Message.respond$CST.CST_Message$System.Web.HttpResponse($tmp4, $tmp5);
    return;

  anon3_Else:
    assume {:partition} !$tmp2;
    assume {:breadcrumb 19} true;
    return;
}



procedure Server_B.B_invoke.#ctor($this: Ref);



implementation Server_B.B_invoke.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$Server_B.B_invoke.server_b[$this] := null;
    assume {:breadcrumb 20} true;
    call $tmp0 := Alloc();
    call ABC.B.#ctor$System.Int32($tmp0, 45);
    assume $DynamicType($tmp0) == T$ABC.B();
    assume $TypeConstructor($DynamicType($tmp0)) == T$ABC.B;
    F$Server_B.B_invoke.server_b[$this] := $tmp0;
    call System.Web.UI.Page.#ctor($this);
    return;
}



procedure T$Server_B.B_invoke.#cctor();



implementation T$Server_B.B_invoke.#cctor()
{

  anon0:
    return;
}



var F$ABC.C.data: [Ref]int;

var F$ABC.C.conclusion: [Ref]Ref;

procedure ABC.C.#ctor($this: Ref);



implementation ABC.C.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$ABC.C.data[$this] := 0;
    F$ABC.C.conclusion[$this] := null;
    assume {:breadcrumb 21} true;
    call $tmp0 := Alloc();
    call CST.CST_Message.#ctor($tmp0);
    assume $DynamicType($tmp0) == T$CST.CST_Message();
    assume $TypeConstructor($DynamicType($tmp0)) == T$CST.CST_Message;
    F$ABC.C.conclusion[$this] := $tmp0;
    call System.Object.#ctor($this);
    return;
}



implementation ABC.C.#ctor$System.Int32($this: Ref, i1$in: int)
{
  var i1: int;
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
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
    return;
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

  anon0:
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
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} F$CST.CST_Message.value[$tmp4] < F$ABC.C.data[$this];
    assume {:breadcrumb 24} true;
    assume $this != null;
    F$CST.CST_Message.largestParty[F$ABC.C.conclusion[$this]] := $string_literal_Charles_2;
    assume $this != null;
    assume $this != null;
    F$CST.CST_Message.value[F$ABC.C.conclusion[$this]] := F$ABC.C.data[$this];
    goto anon3;

  anon7_Else:
    assume {:partition} F$ABC.C.data[$this] <= F$CST.CST_Message.value[$tmp4];
    assume {:breadcrumb 25} true;
    goto anon3;

  anon3:
    assume $this != null;
    F$CST.CST_Struct.SignedBy[F$ABC.C.conclusion[$this]] := $string_literal_Charles_2;
    assume $this != null;
    call $tmp5 := ABC.C.conclude$CST.CST_Message($this, F$ABC.C.conclusion[$this]);
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} $tmp5;
    assume {:breadcrumb 26} true;
    F$CST.CST_Message.certified[msg] := true;
    assume $this != null;
    $tmp6 := F$ABC.C.conclusion[$this];
    assume $tmp6 != null;
    call $tmp7 := System.String.Concat$System.String$System.String$System.String($string_literal_The$largest$party$is$_3, F$CST.CST_Message.largestParty[$tmp6], $string_literal_._4);
    call System.Console.WriteLine$System.String($tmp7);
    goto anon6;

  anon8_Else:
    assume {:partition} !$tmp5;
    assume {:breadcrumb 27} true;
    F$CST.CST_Message.certified[msg] := false;
    call System.Console.WriteLine$System.String($string_literal_Not$verified._5);
    goto anon6;

  anon6:
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

  anon0:
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

  anon0:
    return;
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

  anon0:
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
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} $tmp2;
    assume {:breadcrumb 30} true;
    assume $this != null;
    $tmp3 := F$Server_C.C_invoke.server_c[$this];
    call $tmp4 := ABC.C.invoke$CST.CST_Message($tmp3, local_0_Ref);
    call $tmp5 := System.Web.UI.Page.get_Response($this);
    call CST.CST_Message.respond$CST.CST_Message$System.Web.HttpResponse($tmp4, $tmp5);
    return;

  anon3_Else:
    assume {:partition} !$tmp2;
    assume {:breadcrumb 31} true;
    return;
}



procedure Server_C.C_invoke.#ctor($this: Ref);



implementation Server_C.C_invoke.#ctor($this: Ref)
{
  var $tmp0: Ref;
  var $localExc: Ref;
  var $label: int;

  anon0:
    F$Server_C.C_invoke.server_c[$this] := null;
    assume {:breadcrumb 32} true;
    call $tmp0 := Alloc();
    call ABC.C.#ctor$System.Int32($tmp0, 50);
    assume $DynamicType($tmp0) == T$ABC.C();
    assume $TypeConstructor($DynamicType($tmp0)) == T$ABC.C;
    F$Server_C.C_invoke.server_c[$this] := $tmp0;
    call System.Web.UI.Page.#ctor($this);
    return;
}



procedure T$Server_C.C_invoke.#cctor();



implementation T$Server_C.C_invoke.#cctor()
{

  anon0:
    return;
}



procedure corral_atomic_begin();



procedure corral_atomic_end();



procedure corral_getThreadID() returns (id: int);



var $GetMeHereTracker: int;
