# Std.Experimental

Defined in std-experimental@0.7.0

The module `Std.Experimental` contains additions to `Std` whose design is not settled yet.
Anything here may change or be removed in any version. When its design settles, it moves into
`Std`.

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

## Traits and aliases

## Trait implementations

### impl `[a : Std::Eq] Std.Experimental::Slice a : Std::Eq`

Two slices are equal if they have equal elements in the same order.

### impl `[a : Std::Format] Std.Experimental::Slice a : Std::Format`

Writes a slice the same way as an array: `[1, 2, 3]`.

### impl `[a : Std::ToString] Std.Experimental::Slice a : Std::ToString`

Writes a slice the same way as an array: `[1, 2, 3]`.

### impl `Std.Experimental::StringSlice : Std::Eq`

Two string slices are equal if they have the same bytes.

### impl `Std.Experimental::StringSlice : Std::Format`

Writes the text of the slice.

### impl `Std.Experimental::StringSlice : Std::ToString`

Returns the text of the slice as a string.