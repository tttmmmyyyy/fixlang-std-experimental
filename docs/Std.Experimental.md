# Std.Experimental

Defined in std-experimental@0.2.1

The module `Std.Experimental` contains additions to `Std` whose design is not settled yet.
Anything here may change or be removed in any version. When its design settles, it moves into
`Std`.

`Format` and `FormatArgs` are implemented for tuples of up to 12 elements.

## Values

### namespace Std.Experimental::Array

#### get_slice

Type: `Std::I64 -> Std::I64 -> Std::Array a -> Std.Experimental::Slice a`

The elements of `array` from `begin` up to `end`, as a slice. This is `get_sub` without the
copy.

`begin` and `end` are clamped to `[0, array.@size]`, as `get_sub` clamps them, and an `end`
at or before `begin` gives an empty slice.

##### Examples

```fix
assert_eq(|_|"", [1, 2, 3, 4].get_slice(1, 3).to_array, [2, 3])
```

##### Parameters

* `begin` - The index of the first element.
* `end` - The index after the last element.
* `array` - The array.

#### to_slice

Type: `Std::Array a -> Std.Experimental::Slice a`

The whole of `array` as a slice.

##### Parameters

* `array` - The array.

#### with_separator

Type: `Std::String -> Std::Array a -> Std.Experimental::Format::WithSeparator a`

Wraps `elements` so that `format` writes them with `separator` between them.

##### Examples

```fix
assert_eq(|_|"", "{}".format(([1, 2, 3].with_separator(", "),)), "1, 2, 3")
```

##### Parameters

* `separator` - The text to write between two elements.
* `elements` - The elements.

### namespace Std.Experimental::F32

#### with_precision

Type: `Std::U8 -> Std::F32 -> Std.Experimental::Format::WithPrecision Std::F32`

Wraps `v` so that `format` writes it with `precision` digits after the decimal point, as
`F32::to_string_precision` does.

##### Examples

```fix
assert_eq(|_|"", "{}".format((3.14159_F32.with_precision(2_U8),)), "3.14")
```

##### Parameters

* `precision` - The number of digits after the decimal point.
* `v` - The number.

### namespace Std.Experimental::F64

#### with_precision

Type: `Std::U8 -> Std::F64 -> Std.Experimental::Format::WithPrecision Std::F64`

Wraps `v` so that `format` writes it with `precision` digits after the decimal point, as
`F64::to_string_precision` does.

##### Examples

```fix
assert_eq(|_|"", "{}".format((3.14159.with_precision(2_U8),)), "3.14")
```

##### Parameters

* `precision` - The number of digits after the decimal point.
* `v` - The number.

### namespace Std.Experimental::Format

#### left_aligned_to

Type: `Std::I64 -> a -> Std.Experimental::Format::LeftAligned a`

Wraps `value` so that `format` pads its text with spaces on the right to `width` Unicode code
points. A text that already has `width` code points or more is written unchanged.

##### Examples

```fix
assert_eq(|_|"", "[{}]".format((42.left_aligned_to(5),)), "[42   ]")
```

##### Parameters

* `width` - The minimum width, in Unicode code points.
* `value` - The value to write.

#### right_aligned_to

Type: `Std::I64 -> a -> Std.Experimental::Format::RightAligned a`

Wraps `value` so that `format` pads its text with spaces on the left to `width` Unicode code
points. A text that already has `width` code points or more is written unchanged.

##### Examples

```fix
assert_eq(|_|"", "[{}]".format((42.right_aligned_to(5),)), "[   42]")
```

##### Parameters

* `width` - The minimum width, in Unicode code points.
* `value` - The value to write.

#### write_text

Type: `[a : Std.Experimental::Format] a -> Std.Experimental::Format::TextOut -> Std.Experimental::Format::TextOut`

Trait member of `Std.Experimental::Format`

Appends the text of `value` to `out`.

##### Parameters

* `value` - The value to write.
* `out` - The text written so far.

### namespace Std.Experimental::FormatArgs

#### write_args

Type: `[args : Std.Experimental::FormatArgs] args -> Std.Experimental::FormatArgs::TemplateCursor -> Std.Experimental::FormatArgs::TemplateCursor`

Trait member of `Std.Experimental::FormatArgs`

Writes each value into the next placeholder of the template, after the template text before
that placeholder.

##### Parameters

* `values` - The values.
* `cursor` - The template and how much of it has been written.

### namespace Std.Experimental::Slice

#### @

Type: `Std::I64 -> Std.Experimental::Slice a -> a`

The element at index `i` of `slice`, counted from the beginning of the slice. The program
aborts if `i` is outside `[0, slice.@size)`.

##### Parameters

* `i` - The index.
* `slice` - The slice.

#### @array

Type: `Std.Experimental::Slice a -> Std::Array a`

The array `slice` was taken from, whole.

A slice's elements are those of this array from `@begin` up to `@end`, so a program that
reads the array directly, handing positions in it to a C function for one, reads the slice
there.

##### Parameters

* `slice` - The slice.

#### @begin

Type: `Std.Experimental::Slice a -> Std::I64`

The index in `@array` of the first element of `slice`.

##### Parameters

* `slice` - The slice.

#### @end

Type: `Std.Experimental::Slice a -> Std::I64`

The index in `@array` after the last element of `slice`.

##### Parameters

* `slice` - The slice.

#### @size

Type: `Std.Experimental::Slice a -> Std::I64`

The number of elements of `slice`.

##### Parameters

* `slice` - The slice.

#### get_slice

Type: `Std::I64 -> Std::I64 -> Std.Experimental::Slice a -> Std.Experimental::Slice a`

The elements of `slice` from `begin` up to `end`, counted from the beginning of `slice`, as a
slice of the same array.

`begin` and `end` are clamped to `[0, slice.@size]`, and an `end` at or before `begin` gives
an empty slice.

##### Parameters

* `begin` - The index of the first element.
* `end` - The index after the last element.
* `slice` - The slice.

#### to_array

Type: `Std.Experimental::Slice a -> Std::Array a`

The elements of `slice`, copied into an array of their own.

##### Parameters

* `slice` - The slice.

#### to_iter

Type: `[?it : Std::Iterator, Std::Iterator::Item ?it = a] Std.Experimental::Slice a -> ?it`

The elements of `slice`, in order.

##### Parameters

* `slice` - The slice.

### namespace Std.Experimental::String

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

```fix
assert_eq(|_|"", "{} + {} = {}".format((1, 2.5, "three")), "1 + 2.5 = three");;
assert_eq(|_|"", "x = {}".format((42,)), "x = 42");;
assert_eq(|_|"", "{{{}}}".format((1,)), "{1}")
```

##### Parameters

* `values` - The values to write, in order.
* `template` - The template.

#### from_slice

Type: `Std.Experimental::Slice Std::U8 -> Std::String`

A string holding the bytes of `slice`, copied. Where `slice` holds a null byte, the string
ends before it, since a string holds no null byte.

##### Examples

```fix
assert_eq(|_|"", String::from_slice("abc,def".get_slice(4, 7)), "def")
```

##### Parameters

* `slice` - The bytes.

#### get_slice

Type: `Std::I64 -> Std::I64 -> Std::String -> Std.Experimental::Slice Std::U8`

The bytes of `str` from `begin` up to `end`, as a slice. This is `get_sub` without the copy.

`begin` and `end` are clamped to `[0, str.@size]`, and an `end` at or before `begin` gives an
empty slice.

##### Examples

```fix
assert_eq(|_|"", "abc,def".get_slice(4, 7).@(0), 'd')
```

##### Parameters

* `begin` - The index of the first byte.
* `end` - The index after the last byte.
* `str` - The string.

#### to_slice

Type: `Std::String -> Std.Experimental::Slice Std::U8`

The bytes of `str` as a slice, without the null byte that ends them and without a copy.

##### Parameters

* `str` - The string.

## Types and aliases

### namespace Std.Experimental

#### Slice

Defined as: `type Slice a = unbox struct { ...fields... }`

A stretch of an array, held without copying it: the elements of `_array` from `_begin` up to
`_end`. A string's bytes are a `Slice U8`.

A slice holds the whole array it was taken from, so the array is shared while the slice lives:
changing either copies it.

Invariant: `0 <= _begin <= _end <= _array.@size`.

### namespace Std.Experimental::Format

#### LeftAligned

Defined as: `type LeftAligned a = unbox struct { ...fields... }`

A value padded with spaces on the right to a width. Created by `left_aligned_to`.

#### RightAligned

Defined as: `type RightAligned a = unbox struct { ...fields... }`

A value padded with spaces on the left to a width. Created by `right_aligned_to`.

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

### namespace Std.Experimental::FormatArgs

#### TemplateCursor

Defined as: `type TemplateCursor = unbox struct { ...fields... }`

A template that `format` is filling in: the template, the position up to which it has been
written, and the text written so far.

## Traits and aliases

### namespace Std.Experimental

#### trait `a : Format`

A type whose values `format` can write.

If the type also implements `ToString`, `write_text` must write the same text as `to_string`.

A type that implements `ToString` can implement `Format` in one line:

```fix
impl Point : Format {
    write_text = |p, out| out.write_text(p.to_string);
}
```

Writing each part directly is faster, because it creates no intermediate string:

```fix
impl Point : Format {
    write_text = |p, out| out.write_text("(").write_text(p.@x).write_text(", ").write_text(p.@y).write_text(")");
}
```

##### method `write_text`

Type: `a -> Std.Experimental::Format::TextOut -> Std.Experimental::Format::TextOut`

Appends the text of `value` to `out`.

###### Parameters

* `value` - The value to write.
* `out` - The text written so far.

#### trait `args : FormatArgs`

The values that `format` writes into a template: `()`, or a tuple of values whose types
implement `Format`.

##### method `write_args`

Type: `args -> Std.Experimental::FormatArgs::TemplateCursor -> Std.Experimental::FormatArgs::TemplateCursor`

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

### impl `[a : Std.Experimental::Format] Std.Experimental::Format::LeftAligned a : Std.Experimental::Format`

### impl `[a : Std.Experimental::Format] Std.Experimental::Format::RightAligned a : Std.Experimental::Format`

### impl `Std.Experimental::Format::WithPrecision Std::F32 : Std.Experimental::Format`

### impl `Std.Experimental::Format::WithPrecision Std::F64 : Std.Experimental::Format`

### impl `[a : Std.Experimental::Format] Std.Experimental::Format::WithSeparator a : Std.Experimental::Format`

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