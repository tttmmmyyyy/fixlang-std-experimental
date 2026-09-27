# Std.Experimental

Defined in std-experimental@0.1.0

Module `Std.Experimental` holds additions to `Std` whose design is not settled yet. An entity here
can change or disappear in any release; one whose design settles moves into `Std`.

`Format` and `FormatArgs` are implemented for the tuples of up to 12 elements.

## Values

### namespace Std.Experimental

#### format

Type: `[args : Std.Experimental::FormatArgs] args -> Std::String -> Std::String`

Writes values into the placeholders of a template.

Each `{}` in the template is replaced by the text of the next value, as `Format` writes it. `{{`
and `}}` are written as `{` and `}`.

The values are given as a tuple, which may mix types: `(x,)` for one value, `()` for none.

If the template holds more or fewer placeholders than there are values, or holds a `{` or `}`
that is neither a placeholder nor an escape, this function aborts the program.

##### Examples

```
"{} + {} = {}".format((1, 2.5, "three"))   // "1 + 2.5 = three"
"x = {}".format((42,))                      // "x = 42"
"{{{}}}".format((1,))                       // "{1}"
```

##### Parameters

* `values` - The values written into the placeholders, in order.
* `template` - The template.

#### left_aligned_to

Type: `Std::I64 -> a -> Std.Experimental::LeftAligned a`

Makes `value` be written with spaces after it, so that the text takes `width` Unicode code points.
A text as wide as `width` or wider is written as it is.

##### Examples

```
"[{}]".format((42.left_aligned_to(5),))   // "[42   ]"
```

##### Parameters

* `width` - The number of Unicode code points the text takes at least.
* `value` - The value.

#### right_aligned_to

Type: `Std::I64 -> a -> Std.Experimental::RightAligned a`

Makes `value` be written with spaces in front of it, so that the text takes `width` Unicode code
points. A text as wide as `width` or wider is written as it is.

##### Examples

```
"[{}]".format((42.right_aligned_to(5),))   // "[   42]"
```

##### Parameters

* `width` - The number of Unicode code points the text takes at least.
* `value` - The value.

### namespace Std.Experimental::Array

#### with_separator

Type: `Std::String -> Std::Array a -> Std.Experimental::WithSeparator a`

Makes the elements of `elements` be written one after another, with `separator` between each
two.

##### Examples

```
"{}".format(([1, 2, 3].with_separator(", "),))   // "1, 2, 3"
```

##### Parameters

* `separator` - The text written between each two elements.
* `elements` - The elements.

### namespace Std.Experimental::F32

#### with_precision

Type: `Std::U8 -> Std::F32 -> Std.Experimental::WithPrecision Std::F32`

Makes `v` be written with `precision` digits after the decimal point, like
`F32::to_string_precision`.

##### Examples

```
"{}".format((3.14159_F32.with_precision(2_U8),))   // "3.14"
```

##### Parameters

* `precision` - The number of digits after the decimal point.
* `v` - The floating number.

### namespace Std.Experimental::F64

#### with_precision

Type: `Std::U8 -> Std::F64 -> Std.Experimental::WithPrecision Std::F64`

Makes `v` be written with `precision` digits after the decimal point, like
`F64::to_string_precision`.

##### Examples

```
"{}".format((3.14159.with_precision(2_U8),))   // "3.14"
```

##### Parameters

* `precision` - The number of digits after the decimal point.
* `v` - The floating number.

### namespace Std.Experimental::Format

#### write_text

Type: `[a : Std.Experimental::Format] a -> Std.Experimental::TextOut -> Std.Experimental::TextOut`

Trait member of `Std.Experimental::Format`

Writes the text of `value` at the end of `out`.

##### Parameters

* `value` - The value whose text is written.
* `out` - The text written so far.

### namespace Std.Experimental::FormatArgs

#### write_args

Type: `[args : Std.Experimental::FormatArgs] args -> Std.Experimental::TemplateCursor -> Std.Experimental::TemplateCursor`

Trait member of `Std.Experimental::FormatArgs`

Writes each value of `values` into the next placeholder of the template, after the text of the
template in front of that placeholder.

##### Parameters

* `values` - The values.
* `cursor` - The template, and how far it has been written.

## Types and aliases

### namespace Std.Experimental

#### LeftAligned

Defined as: `type LeftAligned a = unbox struct { ...fields... }`

A value written with spaces after it, up to a width.

A value is made by `left_aligned_to`.

#### RightAligned

Defined as: `type RightAligned a = unbox struct { ...fields... }`

A value written with spaces in front of it, up to a width.

A value is made by `right_aligned_to`.

#### TemplateCursor

Defined as: `type TemplateCursor = unbox struct { ...fields... }`

A template being written by `format`: the template, the byte up to which it has been written, and
the text written so far.

#### TextOut

Defined as: `type TextOut = unbox struct { ...fields... }`

The text written so far, to which a value's text is added by `Format::write_text`.

A `TextOut` only grows at its end, and holds no null byte: each of its bytes is a byte of the text
of a value, and no text holds one.

#### WithPrecision

Defined as: `type WithPrecision a = unbox struct { ...fields... }`

A floating number written with a fixed number of digits after the decimal point.

A value is made by `F32::with_precision` or `F64::with_precision`.

#### WithSeparator

Defined as: `type WithSeparator a = unbox struct { ...fields... }`

The elements of an array written one after another, with a separator between each two.

A value is made by `with_separator`.

## Traits and aliases

### namespace Std.Experimental

#### trait `a : Format`

A type whose values can write their text at the end of a `TextOut`.

A type that implements `ToString` as well writes the text `to_string` returns.

An implementation writes its parts by `write_text` in turn. For a type that has `ToString`, one
line does:

```
impl Point : Format {
    write_text = |p, out| out.write_text(p.to_string);
}
```

Writing the parts directly saves the intermediate string:

```
impl Point : Format {
    write_text = |p, out| out.write_text("(").write_text(p.@x).write_text(", ").write_text(p.@y).write_text(")");
}
```

##### method `write_text`

Type: `a -> Std.Experimental::TextOut -> Std.Experimental::TextOut`

Writes the text of `value` at the end of `out`.

###### Parameters

* `value` - The value whose text is written.
* `out` - The text written so far.

#### trait `args : FormatArgs`

A sequence of values `format` writes into the placeholders of a template: `()` and the tuples of
values whose types implement `Format`.

##### method `write_args`

Type: `args -> Std.Experimental::TemplateCursor -> Std.Experimental::TemplateCursor`

Writes each value of `values` into the next placeholder of the template, after the text of the
template in front of that placeholder.

###### Parameters

* `values` - The values.
* `cursor` - The template, and how far it has been written.

## Trait implementations

### impl `() : Std.Experimental::Format`

Writes the value like `ToString`: `()`.

### impl `() : Std.Experimental::FormatArgs`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format] (t0, t1) : Std.Experimental::Format`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format] (t0, t1) : Std.Experimental::FormatArgs`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format] (t0, t1, t2) : Std.Experimental::Format`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format] (t0, t1, t2) : Std.Experimental::FormatArgs`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format] (t0, t1, t2, t3) : Std.Experimental::Format`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format] (t0, t1, t2, t3) : Std.Experimental::FormatArgs`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format, t4 : Std.Experimental::Format] (t0, t1, t2, t3, t4) : Std.Experimental::Format`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format, t4 : Std.Experimental::Format] (t0, t1, t2, t3, t4) : Std.Experimental::FormatArgs`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format, t4 : Std.Experimental::Format, t5 : Std.Experimental::Format] (t0, t1, t2, t3, t4, t5) : Std.Experimental::Format`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format, t4 : Std.Experimental::Format, t5 : Std.Experimental::Format] (t0, t1, t2, t3, t4, t5) : Std.Experimental::FormatArgs`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format, t4 : Std.Experimental::Format, t5 : Std.Experimental::Format, t6 : Std.Experimental::Format] (t0, t1, t2, t3, t4, t5, t6) : Std.Experimental::Format`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format, t4 : Std.Experimental::Format, t5 : Std.Experimental::Format, t6 : Std.Experimental::Format] (t0, t1, t2, t3, t4, t5, t6) : Std.Experimental::FormatArgs`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format, t4 : Std.Experimental::Format, t5 : Std.Experimental::Format, t6 : Std.Experimental::Format, t7 : Std.Experimental::Format] (t0, t1, t2, t3, t4, t5, t6, t7) : Std.Experimental::Format`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format, t4 : Std.Experimental::Format, t5 : Std.Experimental::Format, t6 : Std.Experimental::Format, t7 : Std.Experimental::Format] (t0, t1, t2, t3, t4, t5, t6, t7) : Std.Experimental::FormatArgs`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format, t4 : Std.Experimental::Format, t5 : Std.Experimental::Format, t6 : Std.Experimental::Format, t7 : Std.Experimental::Format, t8 : Std.Experimental::Format] (t0, t1, t2, t3, t4, t5, t6, t7, t8) : Std.Experimental::Format`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format, t4 : Std.Experimental::Format, t5 : Std.Experimental::Format, t6 : Std.Experimental::Format, t7 : Std.Experimental::Format, t8 : Std.Experimental::Format] (t0, t1, t2, t3, t4, t5, t6, t7, t8) : Std.Experimental::FormatArgs`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format, t4 : Std.Experimental::Format, t5 : Std.Experimental::Format, t6 : Std.Experimental::Format, t7 : Std.Experimental::Format, t8 : Std.Experimental::Format, t9 : Std.Experimental::Format] (t0, t1, t2, t3, t4, t5, t6, t7, t8, t9) : Std.Experimental::Format`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format, t4 : Std.Experimental::Format, t5 : Std.Experimental::Format, t6 : Std.Experimental::Format, t7 : Std.Experimental::Format, t8 : Std.Experimental::Format, t9 : Std.Experimental::Format] (t0, t1, t2, t3, t4, t5, t6, t7, t8, t9) : Std.Experimental::FormatArgs`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format, t4 : Std.Experimental::Format, t5 : Std.Experimental::Format, t6 : Std.Experimental::Format, t7 : Std.Experimental::Format, t8 : Std.Experimental::Format, t9 : Std.Experimental::Format, t10 : Std.Experimental::Format] (t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10) : Std.Experimental::Format`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format, t4 : Std.Experimental::Format, t5 : Std.Experimental::Format, t6 : Std.Experimental::Format, t7 : Std.Experimental::Format, t8 : Std.Experimental::Format, t9 : Std.Experimental::Format, t10 : Std.Experimental::Format] (t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10) : Std.Experimental::FormatArgs`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format, t4 : Std.Experimental::Format, t5 : Std.Experimental::Format, t6 : Std.Experimental::Format, t7 : Std.Experimental::Format, t8 : Std.Experimental::Format, t9 : Std.Experimental::Format, t10 : Std.Experimental::Format, t11 : Std.Experimental::Format] (t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11) : Std.Experimental::Format`

### impl `[t0 : Std.Experimental::Format, t1 : Std.Experimental::Format, t2 : Std.Experimental::Format, t3 : Std.Experimental::Format, t4 : Std.Experimental::Format, t5 : Std.Experimental::Format, t6 : Std.Experimental::Format, t7 : Std.Experimental::Format, t8 : Std.Experimental::Format, t9 : Std.Experimental::Format, t10 : Std.Experimental::Format, t11 : Std.Experimental::Format] (t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11) : Std.Experimental::FormatArgs`

### impl `[t0 : Std.Experimental::Format] (t0,) : Std.Experimental::Format`

### impl `[t0 : Std.Experimental::Format] (t0,) : Std.Experimental::FormatArgs`

### impl `[a : Std.Experimental::Format] Std.Experimental::LeftAligned a : Std.Experimental::Format`

### impl `[a : Std.Experimental::Format] Std.Experimental::RightAligned a : Std.Experimental::Format`

### impl `Std.Experimental::WithPrecision Std::F32 : Std.Experimental::Format`

### impl `Std.Experimental::WithPrecision Std::F64 : Std.Experimental::Format`

### impl `[a : Std.Experimental::Format] Std.Experimental::WithSeparator a : Std.Experimental::Format`

### impl `[a : Std.Experimental::Format] Std::Array a : Std.Experimental::Format`

Writes the value like `ToString`: the elements between `[` and `]`, separated by `, `.

### impl `Std::Bool : Std.Experimental::Format`

Writes the value like `ToString`: `true` or `false`.

### impl `Std::F32 : Std.Experimental::Format`

Writes the value like `ToString`: in its shortest round-trip decimal form.

### impl `Std::F64 : Std.Experimental::Format`

Writes the value like `ToString`: in its shortest round-trip decimal form.

### impl `Std::I16 : Std.Experimental::Format`

### impl `Std::I32 : Std.Experimental::Format`

### impl `Std::I64 : Std.Experimental::Format`

### impl `Std::I8 : Std.Experimental::Format`

### impl `[a : Std.Experimental::Format] Std::Option a : Std.Experimental::Format`

Writes the value like `ToString`: `some(x)` or `none()`.

### impl `Std::Ptr : Std.Experimental::Format`

Writes the value like `ToString`: sixteen hexadecimal digits.

### impl `[e : Std.Experimental::Format, a : Std.Experimental::Format] Std::Result e a : Std.Experimental::Format`

Writes the value like `ToString`: `ok(x)` or `err(e)`.

### impl `Std::String : Std.Experimental::Format`

### impl `Std::U16 : Std.Experimental::Format`

### impl `Std::U32 : Std.Experimental::Format`

### impl `Std::U64 : Std.Experimental::Format`

### impl `Std::U8 : Std.Experimental::Format`