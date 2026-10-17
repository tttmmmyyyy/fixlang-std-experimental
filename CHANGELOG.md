# Change Log

## [0.5.0] - 2026-10-17

### Added

- #11, #12: `IO::printf`, `IO::printfln`, `IO::eprintf` and `IO::eprintfln` write the text that `format` makes to the standard output or the standard error. They write it out as they go, so the text of a long array is not held in memory as a whole. `Debug::debug_printf`, `Debug::debug_printfln`, `Debug::debug_eprintf` and `Debug::debug_eprintfln` write it and flush, as `debug_print` does.
- #11, #12: The trait `TextWriter`, the monad that `Format::write_text` writes in. Its method `flush_if_full` writes the text out once enough of it is waiting.

### Changed

- #11, #12: `Format::write_text` writes in a monad, so that the same implementation serves `format` and `printf`. Its type is now `[m : Monad, m : TextWriter] a -> TextOut -> m TextOut`. Rewrite `|p, out| out.write_text("(").write_text(p.@x).write_text(")")` as `|p, out| (let out = *out.write_text("("); let out = *out.write_text(p.@x); out.write_text(")"))`.

## [0.4.0] - 2026-10-13

### Added

- #10: The type `StringSlice`: a part of a string, taken without copying the bytes. `to_string` gives its text, `format` writes that text with no intermediate string, and `==` compares the bytes. `StringSlice::get_bytes` gives its bytes as a `Slice U8`.
- #10: `Slice a` now implements `ToString`, `Format` and `Eq`. `to_string` and `format` write a slice as an array is written, `[1, 2, 3]`.
- #10: `Slice::with_separator` writes the elements of a slice with a separator between them, as `Array::with_separator` does for an array.

### Changed

- #10: `String::to_slice` and `String::get_slice` now return a `StringSlice`, where they returned a `Slice U8`. For the bytes, write `str.get_slice(begin, end).get_bytes`.
- #10: `String::from_slice` is removed. Write `slice.to_string` for a `StringSlice`. For a `Slice U8` taken of an array of bytes, write `from_bytes(slice.to_array.push_back('\0'))`, which is a `Result ErrMsg String`; `to_string` of a `Slice U8` writes it as an array, `[97, 98]`.
