# Std.Experimental

Defined in std-experimental@0.6.0

The module `Std.Experimental` contains additions to `Std` whose design is not settled yet.
Anything here may change or be removed in any version. When its design settles, it moves into
`Std`.

`String::format` fills the placeholders `{}` of a template with values of any types that
implement `Format`. `IO::printf` writes the same text to the standard output, and
`IO::write_format` writes it to any handle, such as a file. A wrapper such as
`with_precision` or `right_aligned_to` changes how a value is written, and one wrapper can wrap
another:

```fix
let name = "pi".left_aligned_to(4);
let value = 3.14159.with_precision(2_U8).right_aligned_to(6);
assert_eq(|_|"", "{}|{}".format((name, value)), "pi  |  3.14")
```

`Format` and `FormatArgs` are implemented for tuples of up to 12 elements.

`Slice` is a part of an array, and `StringSlice` is a part of a string. Taking one does not copy
the elements:

```fix
assert_eq(|_|"", [1, 2, 3, 4].get_slice(1, 3).to_array, [2, 3]);;
assert_eq(|_|"", "abc,def".get_slice(4, 7).to_string, "def")
```

## Values

### namespace Std.Experimental::Array

#### get_slice

Type: `Std::I64 -> Std::I64 -> Std::Array a -> Std.Experimental::Slice a`

A slice of the elements of `array` from index `begin` up to index `end`. It is like
`get_sub`, but does not copy the elements.

`begin` and `end` are clamped to `[0, array.@size]`. If `end <= begin`, the slice is empty.

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

A slice of all the elements of `array`.

##### Parameters

* `array` - The array.

### namespace Std.Experimental::Debug

#### debug_eprintf

Type: `[args : Std.Experimental::FormatArgs] args -> Std::String -> ()`

Same as `eprintf`, but runs outside `IO` and flushes the standard error, like `debug_eprint`.

NOTE: This function is not pure and should only be used for temporary debugging purposes.

##### Parameters

* `values` - The values to write, in order.
* `template` - The template.

#### debug_eprintfln

Type: `[args : Std.Experimental::FormatArgs] args -> Std::String -> ()`

Same as `eprintfln`, but runs outside `IO` and flushes the standard error, like
`debug_eprintln`.

NOTE: This function is not pure and should only be used for temporary debugging purposes.

##### Parameters

* `values` - The values to write, in order.
* `template` - The template.

#### debug_printf

Type: `[args : Std.Experimental::FormatArgs] args -> Std::String -> ()`

Same as `printf`, but runs outside `IO` and flushes the standard output, like `debug_print`.

NOTE: This function is not pure and should only be used for temporary debugging purposes.

##### Parameters

* `values` - The values to write, in order.
* `template` - The template.

#### debug_printfln

Type: `[args : Std.Experimental::FormatArgs] args -> Std::String -> ()`

Same as `printfln`, but runs outside `IO` and flushes the standard output, like
`debug_println`.

NOTE: This function is not pure and should only be used for temporary debugging purposes.

##### Parameters

* `values` - The values to write, in order.
* `template` - The template.

### namespace Std.Experimental::F32

#### with_exp_precision

Type: `Std::U8 -> Std::F32 -> Std.Experimental::Format::WithExpPrecision Std::F32`

Wraps `v` so that `format` writes it with one digit before the decimal point, `precision`
digits after it, and a power of ten, as `F32::to_string_exp_precision` does.

##### Examples

```fix
assert_eq(|_|"", "{}".format((123.456_F32.with_exp_precision(2_U8),)), "1.23e2")
```

##### Parameters

* `precision` - The number of digits after the decimal point.
* `v` - The number.

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

#### with_exp_precision

Type: `Std::U8 -> Std::F64 -> Std.Experimental::Format::WithExpPrecision Std::F64`

Wraps `v` so that `format` writes it with one digit before the decimal point, `precision`
digits after it, and a power of ten, as `F64::to_string_exp_precision` does.

##### Examples

```fix
assert_eq(|_|"", "{}".format((123.456.with_exp_precision(2_U8),)), "1.23e2")
```

##### Parameters

* `precision` - The number of digits after the decimal point.
* `v` - The number.

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

Type: `[a : Std.Experimental::Format, m : Std.Experimental::TextWriter, m : Std::Monad] a -> Std.Experimental::Format::TextOut -> m Std.Experimental::Format::TextOut`

Trait member of `Std.Experimental::Format`

Appends the text of `value` to `out`.

##### Parameters

* `value` - The value to write.
* `out` - The text written so far.

#### zero_padded_to

Type: `Std::I64 -> a -> Std.Experimental::Format::ZeroPadded a`

Wraps `value` so that `format` pads its text with `0` to `width` Unicode code points. The
zeros go after the `-` that the text starts with, if it starts with one, and before the text
otherwise. A text that already has `width` code points or more is written unchanged.

##### Examples

```fix
assert_eq(|_|"", "{}:{}".format((9.zero_padded_to(2), 5.zero_padded_to(2))), "09:05");;
assert_eq(|_|"", "{}".format(((-5).zero_padded_to(3),)), "-05")
```

##### Parameters

* `width` - The minimum width, in Unicode code points.
* `value` - The value to write.

### namespace Std.Experimental::FormatArgs

#### write_args

Type: `[args : Std.Experimental::FormatArgs, m : Std.Experimental::TextWriter, m : Std::Monad] args -> Std.Experimental::FormatArgs::TemplateCursor -> m Std.Experimental::FormatArgs::TemplateCursor`

Trait member of `Std.Experimental::FormatArgs`

Writes each value into the next placeholder of the template, after the template text before
that placeholder.

##### Parameters

* `values` - The values.
* `cursor` - The template and how much of it has been written.

### namespace Std.Experimental::IO

#### eprintf

Type: `[args : Std.Experimental::FormatArgs] args -> Std::String -> Std::IO ()`

Same as `printf`, but writes to the standard error.

##### Parameters

* `values` - The values to write, in order.
* `template` - The template.

#### eprintfln

Type: `[args : Std.Experimental::FormatArgs] args -> Std::String -> Std::IO ()`

Same as `printf`, but writes to the standard error and adds a newline at the end.

##### Parameters

* `values` - The values to write, in order.
* `template` - The template.

#### printf

Type: `[args : Std.Experimental::FormatArgs] args -> Std::String -> Std::IO ()`

Formats `values` into `template`, as `format` does, and writes the result to the standard
output.

##### Examples

```fix
main : IO () = "{} + {} = {}\n".printf((1, 2.5, "three"));
```

##### Parameters

* `values` - The values to write, in order.
* `template` - The template.

#### printfln

Type: `[args : Std.Experimental::FormatArgs] args -> Std::String -> Std::IO ()`

Same as `printf`, but adds a newline at the end.

##### Parameters

* `values` - The values to write, in order.
* `template` - The template.

#### write_format

Type: `[args : Std.Experimental::FormatArgs] Std::IO::IOHandle -> args -> Std::String -> Std::IO::IOFail ()`

Formats `values` into `template`, as `format` does, and writes the result to `handle`.

The text is written as `printf` writes it, so a long text is never held in memory as one
text. If a write fails, the rest of the text is not written, and the error is returned.

##### Examples

```fix
main : IO () = write_format(stdout, (1, 2.5), "{} + {}\n").try(eprintln);
```

##### Parameters

* `handle` - The handle to write to.
* `values` - The values to write, in order.
* `template` - The template.

### namespace Std.Experimental::Iterator

#### joined_with

Type: `Std::String -> it -> Std.Experimental::Format::Joined it`

Wraps `elements` so that `format` writes them with `separator` between them, as `String::join`
joins strings.

##### Examples

```fix
assert_eq(|_|"", "{}".format(([1, 2, 3].to_iter.joined_with(", "),)), "1, 2, 3")
```

##### Parameters

* `separator` - The text to write between two elements.
* `elements` - The elements.

### namespace Std.Experimental::Slice

#### @

Type: `Std::I64 -> Std.Experimental::Slice a -> a`

The element at index `i` of `slice`. Index 0 is the first element of the slice. The program
aborts if `i` is out of range.

##### Parameters

* `i` - The index.
* `slice` - The slice.

#### @array

Type: `Std.Experimental::Slice a -> Std::Array a`

The whole array that `slice` was taken from. The elements of `slice` are the elements of
this array from index `@begin` up to index `@end`.

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

A slice of the elements of `slice` from index `begin` up to index `end`. Index 0 is the first
element of `slice`.

`begin` and `end` are clamped to `[0, slice.@size]`. If `end <= begin`, the slice is empty.

##### Examples

```fix
let slice = [1, 2, 3, 4, 5].get_slice(1, 5);   // [2, 3, 4, 5]
assert_eq(|_|"", slice.get_slice(1, 3).to_array, [3, 4])
```

##### Parameters

* `begin` - The index of the first element.
* `end` - The index after the last element.
* `slice` - The slice.

#### to_array

Type: `Std.Experimental::Slice a -> Std::Array a`

Copies the elements of `slice` into a new array.

##### Parameters

* `slice` - The slice.

#### to_iter

Type: `[?it : Std::Iterator, Std::Iterator::Item ?it = a] Std.Experimental::Slice a -> ?it`

An iterator over the elements of `slice`.

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

#### get_slice

Type: `Std::I64 -> Std::I64 -> Std::String -> Std.Experimental::StringSlice`

A slice of the bytes of `str` from index `begin` up to index `end`. It is like `get_sub`, but
does not copy the bytes.

`begin` and `end` are clamped to `[0, str.@size]`. If `end <= begin`, the slice is empty.

##### Examples

```fix
assert_eq(|_|"", "abc,def".get_slice(4, 7).to_string, "def")
```

##### Parameters

* `begin` - The index of the first byte.
* `end` - The index after the last byte.
* `str` - The string.

#### to_slice

Type: `Std::String -> Std.Experimental::StringSlice`

A slice of all the bytes of `str`.

##### Parameters

* `str` - The string.

### namespace Std.Experimental::StringSlice

#### @size

Type: `Std.Experimental::StringSlice -> Std::I64`

The number of bytes of `slice`.

##### Parameters

* `slice` - The string slice.

#### get_bytes

Type: `Std.Experimental::StringSlice -> Std.Experimental::Slice Std::U8`

The bytes of `slice` as a `Slice U8`. It does not copy the bytes.

##### Examples

```fix
assert_eq(|_|"", "abc,def".get_slice(4, 7).get_bytes.to_array, ['d', 'e', 'f'])
```

##### Parameters

* `slice` - The string slice.

#### get_slice

Type: `Std::I64 -> Std::I64 -> Std.Experimental::StringSlice -> Std.Experimental::StringSlice`

A slice of the bytes of `slice` from index `begin` up to index `end`. Index 0 is the first
byte of `slice`.

`begin` and `end` are clamped to `[0, slice.@size]`. If `end <= begin`, the slice is empty.

##### Examples

```fix
let slice = "abc,def".get_slice(4, 7);   // def
assert_eq(|_|"", slice.get_slice(1, 3).to_string, "ef")
```

##### Parameters

* `begin` - The index of the first byte.
* `end` - The index after the last byte.
* `slice` - The string slice.

### namespace Std.Experimental::TextWriter

#### flush_if_full

Type: `[m : Std.Experimental::TextWriter] Std.Experimental::Format::TextOut -> m Std.Experimental::Format::TextOut`

Trait member of `Std.Experimental::TextWriter`

If `out` is longer than a threshold, writes it to the destination and returns an empty
`TextOut`. Otherwise returns `out` unchanged. Each implementation of this trait sets its own
threshold.

##### Parameters

* `out` - The text written so far.

## Types and aliases

### namespace Std.Experimental

#### Slice

Defined as: `type Slice a = unbox struct { ...fields... }`

A part of an array: the elements from one index up to another. Taking a slice does not copy the
elements.

Create a slice with `Array::to_slice` or `Array::get_slice`. For a part of a string, use
`StringSlice`.

`to_string` and `format` write a slice the same way as an array: `[1, 2, 3]`.

A slice keeps a reference to the array it was taken from. While the slice exists, modifying that array copies
it.

#### StringSlice

Defined as: `type StringSlice = unbox struct { ...fields... }`

A part of a string: the bytes from one index up to another. Taking a string slice does not copy
the bytes.

Create a string slice with `String::to_slice` or `String::get_slice`.

`to_string` and `format` write a string slice as its text:

```fix
let slice = "abc,def".get_slice(4, 7);
assert_eq(|_|"", slice.to_string, "def");;
assert_eq(|_|"", "[{}]".format((slice.right_aligned_to(5),)), "[  def]")
```

A string slice keeps a reference to the string it was taken from.

### namespace Std.Experimental::Format

#### Joined

Defined as: `type Joined it = unbox struct { ...fields... }`

The elements of an iterator, written with a separator between them. Created by
`Iterator::joined_with`.

#### LeftAligned

Defined as: `type LeftAligned a = unbox struct { ...fields... }`

A value padded with spaces on the right to a width. Created by `left_aligned_to`.

#### RightAligned

Defined as: `type RightAligned a = unbox struct { ...fields... }`

A value padded with spaces on the left to a width. Created by `right_aligned_to`.

#### TextOut

Defined as: `type TextOut = unbox struct { ...fields... }`

Text that has been written but not yet flushed. `Format::write_text` appends to it, and
`TextWriter::flush_if_full` flushes it.

#### WithExpPrecision

Defined as: `type WithExpPrecision a = unbox struct { ...fields... }`

A floating-point number written with one digit before the decimal point, a fixed number of
digits after it, and a power of ten. Created by `F32::with_exp_precision` or
`F64::with_exp_precision`.

#### WithPrecision

Defined as: `type WithPrecision a = unbox struct { ...fields... }`

A floating-point number written with a fixed number of digits after the decimal point. Created by
`F32::with_precision` or `F64::with_precision`.

#### ZeroPadded

Defined as: `type ZeroPadded a = unbox struct { ...fields... }`

A value padded with zeros on the left to a width, after its minus sign if it has one. Created
by `zero_padded_to`.

### namespace Std.Experimental::FormatArgs

#### TemplateCursor

Defined as: `type TemplateCursor = unbox struct { ...fields... }`

A template that `format` is filling in: the template, the position up to which it has been
written, and the text written so far.

## Traits and aliases

### namespace Std.Experimental

#### trait `a : Format`

A type whose values `format` and `printf` can write.

`write_text` appends the text of a value to `out` and returns the new `out` in the monad `m`. To
implement it, write the parts of the value one by one:

```fix
impl Point : Format {
    write_text = |p, out| (
        let out = *out.write_text("(");
        let out = *out.write_text(p.@x);
        let out = *out.write_text(", ");
        let out = *out.write_text(p.@y);
        out.write_text(")")
    );
}
```

Calling `TextWriter::flush_if_full` flushes `out` if it is longer than the threshold: the text is
written out, or moved to a lower-level buffer. So when writing a large value, call
`flush_if_full` at suitable points to keep memory use low. For reference, `printf` and the other
output functions use a threshold of 8192 bytes. For example, the implementation of `Format` for
`Joined`, which also writes arrays and slices, calls it after each element.

The implementations in this module write the same text as `to_string`.

##### method `write_text`

Type: `[m : Std::Monad, m : Std.Experimental::TextWriter] a -> Std.Experimental::Format::TextOut -> m Std.Experimental::Format::TextOut`

Appends the text of `value` to `out`.

###### Parameters

* `value` - The value to write.
* `out` - The text written so far.

#### trait `args : FormatArgs`

The values that `format` writes into a template: `()`, or a tuple of values whose types
implement `Format`.

##### method `write_args`

Type: `[m : Std::Monad, m : Std.Experimental::TextWriter] args -> Std.Experimental::FormatArgs::TemplateCursor -> m Std.Experimental::FormatArgs::TemplateCursor`

Writes each value into the next placeholder of the template, after the template text before
that placeholder.

###### Parameters

* `values` - The values.
* `cursor` - The template and how much of it has been written.

#### trait `[m : *->*] m : TextWriter`

A destination for text: the monad in which `Format::write_text` runs.

Writers append text to a `TextOut`, and may call `flush_if_full` to let the destination write it
out.

##### method `flush_if_full`

Type: `Std.Experimental::Format::TextOut -> m Std.Experimental::Format::TextOut`

If `out` is longer than a threshold, writes it to the destination and returns an empty
`TextOut`. Otherwise returns `out` unchanged. Each implementation of this trait sets its own
threshold.

###### Parameters

* `out` - The text written so far.

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

### impl `[it : Std::Iterator, a : Std.Experimental::Format] Std.Experimental::Format::Joined it : Std.Experimental::Format`

Writes each element with `write_text`, and calls `flush_if_full` after it.

### impl `[a : Std.Experimental::Format] Std.Experimental::Format::LeftAligned a : Std.Experimental::Format`

Writes the value in `Identity`, so that its whole text is in `out` when it is measured.

### impl `[a : Std.Experimental::Format] Std.Experimental::Format::RightAligned a : Std.Experimental::Format`

Writes the value in `Identity`, so that its whole text is in `out` when it is measured and moved.

### impl `Std.Experimental::Format::WithExpPrecision Std::F32 : Std.Experimental::Format`

### impl `Std.Experimental::Format::WithExpPrecision Std::F64 : Std.Experimental::Format`

### impl `Std.Experimental::Format::WithPrecision Std::F32 : Std.Experimental::Format`

### impl `Std.Experimental::Format::WithPrecision Std::F64 : Std.Experimental::Format`

### impl `[a : Std.Experimental::Format] Std.Experimental::Format::ZeroPadded a : Std.Experimental::Format`

Writes the value in `Identity`, so that its whole text is in `out` when it is measured and moved.

### impl `[a : Std.Experimental::Format] Std.Experimental::Slice a : Std.Experimental::Format`

Writes a slice the same way as an array: `[1, 2, 3]`.

### impl `[a : Std::Eq] Std.Experimental::Slice a : Std::Eq`

Two slices are equal if they have equal elements in the same order.

### impl `[a : Std::ToString] Std.Experimental::Slice a : Std::ToString`

Writes a slice the same way as an array: `[1, 2, 3]`.

### impl `Std.Experimental::StringSlice : Std.Experimental::Format`

Writes the text of the slice.

### impl `Std.Experimental::StringSlice : Std::Eq`

Two string slices are equal if they have the same bytes.

### impl `Std.Experimental::StringSlice : Std::ToString`

Returns the text of the slice as a string.

### impl `[a : Std.Experimental::Format] Std::Array a : Std.Experimental::Format`

Writes the elements between `[` and `]`, separated by `, `, as `to_string` does.

### impl `Std::Bool : Std.Experimental::Format`

Writes `true` or `false`, as `to_string` does.

### impl `Std::F32 : Std.Experimental::Format`

Writes the shortest decimal text that reads back as the same number, as `to_string` does.

### impl `Std::F64 : Std.Experimental::Format`

Writes the shortest decimal text that reads back as the same number, as `to_string` does.

### impl `Std::I128 : Std.Experimental::Format`

### impl `Std::I16 : Std.Experimental::Format`

### impl `Std::I32 : Std.Experimental::Format`

### impl `Std::I64 : Std.Experimental::Format`

### impl `Std::I8 : Std.Experimental::Format`

### impl `Std::Identity : Std.Experimental::TextWriter`

`format` runs in `Identity`, which keeps the whole text.

### impl `[a : Std.Experimental::Format] Std::Option a : Std.Experimental::Format`

Writes `some(x)` or `none()`, as `to_string` does.

### impl `Std::Ptr : Std.Experimental::Format`

Writes sixteen hexadecimal digits, as `to_string` does.

### impl `[e : Std.Experimental::Format, a : Std.Experimental::Format] Std::Result e a : Std.Experimental::Format`

Writes `ok(x)` or `err(e)`, as `to_string` does.

### impl `Std::String : Std.Experimental::Format`

### impl `Std::U128 : Std.Experimental::Format`

### impl `Std::U16 : Std.Experimental::Format`

### impl `Std::U32 : Std.Experimental::Format`

### impl `Std::U64 : Std.Experimental::Format`

### impl `Std::U8 : Std.Experimental::Format`