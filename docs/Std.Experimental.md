# Std.Experimental

Defined in std-experimental@0.1.0

The module `Std.Experimental` contains additions to `Std` whose design is not settled yet.
Anything here may change or be removed in any version. When its design settles, it moves into
`Std`.

`Format` and `FormatArgs` are implemented for tuples of up to 12 elements.

## Values

### namespace Std.Experimental

#### format

Type: `[args : Std.Experimental::FormatArgs] args -> Std::String -> Std::String`

Replaces the placeholders `{}` in a template with values.

Each `{}` is replaced with the text of the next value, as `Format` writes it. `{{` and `}}` are
written as `{` and `}`.

Pass the values as a tuple. The values may have different types. Write `(x,)` for one value and
`()` for none.

The program aborts if the number of placeholders differs from the number of values, or if the
template has a `{` or `}` that is not part of a placeholder or an escape.

##### Examples

```
"{} + {} = {}".format((1, 2.5, "three"))   // "1 + 2.5 = three"
"x = {}".format((42,))                      // "x = 42"
"{{{}}}".format((1,))                       // "{1}"
```

##### Parameters

* `values` - The values to write, in order.
* `template` - The template.

#### left_aligned_to

Type: `Std::I64 -> a -> Std.Experimental::LeftAligned a`

Wraps `value` so that `format` pads its text with spaces on the right to `width` Unicode code
points. A text that already has `width` code points or more is written unchanged.

##### Examples

```
"[{}]".format((42.left_aligned_to(5),))   // "[42   ]"
```

##### Parameters

* `width` - The minimum width, in Unicode code points.
* `value` - The value to write.

#### right_aligned_to

Type: `Std::I64 -> a -> Std.Experimental::RightAligned a`

Wraps `value` so that `format` pads its text with spaces on the left to `width` Unicode code
points. A text that already has `width` code points or more is written unchanged.

##### Examples

```
"[{}]".format((42.right_aligned_to(5),))   // "[   42]"
```

##### Parameters

* `width` - The minimum width, in Unicode code points.
* `value` - The value to write.

### namespace Std.Experimental::Array

#### with_separator

Type: `Std::String -> Std::Array a -> Std.Experimental::WithSeparator a`

Wraps `elements` so that `format` writes them with `separator` between them.

##### Examples

```
"{}".format(([1, 2, 3].with_separator(", "),))   // "1, 2, 3"
```

##### Parameters

* `separator` - The text to write between two elements.
* `elements` - The elements.

### namespace Std.Experimental::F32

#### with_precision

Type: `Std::U8 -> Std::F32 -> Std.Experimental::WithPrecision Std::F32`

Wraps `v` so that `format` writes it with `precision` digits after the decimal point, as
`F32::to_string_precision` does.

##### Examples

```
"{}".format((3.14159_F32.with_precision(2_U8),))   // "3.14"
```

##### Parameters

* `precision` - The number of digits after the decimal point.
* `v` - The number.

### namespace Std.Experimental::F64

#### with_precision

Type: `Std::U8 -> Std::F64 -> Std.Experimental::WithPrecision Std::F64`

Wraps `v` so that `format` writes it with `precision` digits after the decimal point, as
`F64::to_string_precision` does.

##### Examples

```
"{}".format((3.14159.with_precision(2_U8),))   // "3.14"
```

##### Parameters

* `precision` - The number of digits after the decimal point.
* `v` - The number.

### namespace Std.Experimental::Format

#### write_text

Type: `[a : Std.Experimental::Format] a -> Std.Experimental::TextOut -> Std.Experimental::TextOut`

Trait member of `Std.Experimental::Format`

Appends the text of `value` to `out`.

##### Parameters

* `value` - The value to write.
* `out` - The text written so far.

### namespace Std.Experimental::FormatArgs

#### write_args

Type: `[args : Std.Experimental::FormatArgs] args -> Std.Experimental::TemplateCursor -> Std.Experimental::TemplateCursor`

Trait member of `Std.Experimental::FormatArgs`

Writes each value into the next placeholder of the template, after the template text before
that placeholder.

##### Parameters

* `values` - The values.
* `cursor` - The template and how much of it has been written.

## Types and aliases

### namespace Std.Experimental

#### LeftAligned

Defined as: `type LeftAligned a = unbox struct { ...fields... }`

A value padded with spaces on the right to a width. Created by `left_aligned_to`.

#### RightAligned

Defined as: `type RightAligned a = unbox struct { ...fields... }`

A value padded with spaces on the left to a width. Created by `right_aligned_to`.

#### TemplateCursor

Defined as: `type TemplateCursor = unbox struct { ...fields... }`

A template that `format` is filling in: the template, the position up to which it has been
written, and the text written so far.

#### TextOut

Defined as: `type TextOut = unbox struct { ...fields... }`

The text written so far. `Format::write_text` appends the text of a value to it.

Text is only appended at the end. It never contains a null byte, because the text of a value
never does.

#### WithPrecision

Defined as: `type WithPrecision a = unbox struct { ...fields... }`

A floating-point number written with a fixed number of digits after the decimal point. Created by
`F32::with_precision` or `F64::with_precision`.

#### WithSeparator

Defined as: `type WithSeparator a = unbox struct { ...fields... }`

The elements of an array, written with a separator between them. Created by `with_separator`.

## Traits and aliases

### namespace Std.Experimental

#### trait `a : Format`

A type whose values `format` can write.

If the type also implements `ToString`, `write_text` must write the same text as `to_string`.

A type that implements `ToString` can implement `Format` in one line:

```
impl Point : Format {
    write_text = |p, out| out.write_text(p.to_string);
}
```

Writing each part directly is faster, because it creates no intermediate string:

```
impl Point : Format {
    write_text = |p, out| out.write_text("(").write_text(p.@x).write_text(", ").write_text(p.@y).write_text(")");
}
```

##### method `write_text`

Type: `a -> Std.Experimental::TextOut -> Std.Experimental::TextOut`

Appends the text of `value` to `out`.

###### Parameters

* `value` - The value to write.
* `out` - The text written so far.

#### trait `args : FormatArgs`

The values that `format` writes into a template: `()`, or a tuple of values whose types
implement `Format`.

##### method `write_args`

Type: `args -> Std.Experimental::TemplateCursor -> Std.Experimental::TemplateCursor`

Writes each value into the next placeholder of the template, after the template text before
that placeholder.

###### Parameters

* `values` - The values.
* `cursor` - The template and how much of it has been written.

## Trait implementations

### impl `() : Std.Experimental::Format`

Writes `()`, as `to_string` does.

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

Writes the elements between `[` and `]`, separated by `, `, as `to_string` does.

### impl `Std::Bool : Std.Experimental::Format`

Writes `true` or `false`, as `to_string` does.

### impl `Std::F32 : Std.Experimental::Format`

Writes the shortest decimal text that reads back as the same number, as `to_string` does.

### impl `Std::F64 : Std.Experimental::Format`

Writes the shortest decimal text that reads back as the same number, as `to_string` does.

### impl `Std::I16 : Std.Experimental::Format`

### impl `Std::I32 : Std.Experimental::Format`

### impl `Std::I64 : Std.Experimental::Format`

### impl `Std::I8 : Std.Experimental::Format`

### impl `[a : Std.Experimental::Format] Std::Option a : Std.Experimental::Format`

Writes `some(x)` or `none()`, as `to_string` does.

### impl `Std::Ptr : Std.Experimental::Format`

Writes sixteen hexadecimal digits, as `to_string` does.

### impl `[e : Std.Experimental::Format, a : Std.Experimental::Format] Std::Result e a : Std.Experimental::Format`

Writes `ok(x)` or `err(e)`, as `to_string` does.

### impl `Std::String : Std.Experimental::Format`

### impl `Std::U16 : Std.Experimental::Format`

### impl `Std::U32 : Std.Experimental::Format`

### impl `Std::U64 : Std.Experimental::Format`

### impl `Std::U8 : Std.Experimental::Format`