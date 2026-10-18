# Change Log

## [0.6.0] - 2026-10-18

### Added

- `IO::write_format` formats values into a template, as `format` does, and writes the result to any `IOHandle`, such as a file. It writes the text in parts, as `printf` does. If a write fails, the rest is not written, and the error is returned as an `IOFail`.
- `I128` and `U128` now implement `Format`.
- `F32::with_exp_precision` and `F64::with_exp_precision` make `format` write a number with a power of ten, as `to_string_exp_precision` does: `"{}".format((123.456.with_exp_precision(2_U8),))` is `"1.23e2"`.
- `Format::zero_padded_to` makes `format` pad the text of a value with `0` to a width, after a leading `-`: `"{}".format(((-5).zero_padded_to(3),))` is `"-05"`.

## [0.5.0] - 2026-10-17

### Added

- #11, #12: `IO::printf`, `IO::printfln`, `IO::eprintf` and `IO::eprintfln` format values into a template, as `format` does, and write the result to the standard output or the standard error. They write the text in parts, so a long array is never held in memory as one text. `Debug::debug_printf`, `Debug::debug_printfln`, `Debug::debug_eprintf` and `Debug::debug_eprintfln` do the same outside `IO` and flush, like `debug_print`.
- #11, #12: The trait `TextWriter`: the monad in which `Format::write_text` runs. Its method `flush_if_full` writes the text out once it is long enough.

### Changed

- #11, #12: `Format::write_text` now runs in a monad, so that one implementation serves both `format` and `printf`. Its type is now `[m : Monad, m : TextWriter] a -> TextOut -> m TextOut`. Rewrite `|p, out| out.write_text("(").write_text(p.@x).write_text(")")` as `|p, out| (let out = *out.write_text("("); let out = *out.write_text(p.@x); out.write_text(")"))`.
- #12: `Array::with_separator` and `Slice::with_separator` are replaced by `Iterator::joined_with`, named after `String::join`. Write `arr.to_iter.joined_with(", ")`. It takes any iterator, so the elements need not be in an array. The type it returns is `Format::Joined`.

## [0.4.0] - 2026-10-13

### Added

- #10: The type `StringSlice`: a part of a string, taken without copying the bytes. `to_string` gives its text, `format` writes that text with no intermediate string, and `==` compares the bytes. `StringSlice::get_bytes` gives its bytes as a `Slice U8`.
- #10: `Slice a` now implements `ToString`, `Format` and `Eq`. `to_string` and `format` write a slice as an array is written, `[1, 2, 3]`.
- #10: `Slice::with_separator` writes the elements of a slice with a separator between them, as `Array::with_separator` does for an array.

### Changed

- #10: `String::to_slice` and `String::get_slice` now return a `StringSlice`, where they returned a `Slice U8`. For the bytes, write `str.get_slice(begin, end).get_bytes`.
- #10: `String::from_slice` is removed. Write `slice.to_string` for a `StringSlice`. For a `Slice U8` taken of an array of bytes, write `from_bytes(slice.to_array.push_back('\0'))`, which is a `Result ErrMsg String`; `to_string` of a `Slice U8` writes it as an array, `[97, 98]`.
