# std-experimental

The module `Std.Experimental` for the [Fix programming language](https://github.com/tttmmmyyyy/fixlang). It contains additions to `Std` whose design is not settled yet. Anything here may change or be removed in any version. When its design settles, it moves into `Std`.

## Contents

- `String::format` replaces the placeholders `{}` in a template with values, which may have different types. Each value is written directly into the result, so `format` creates no intermediate string for each value.

  ```
  "{} + {} = {}".format((1, 2.5, "three"))   // "1 + 2.5 = three"
  ```

- `IO::printf` and `IO::printfln` write the same text to the standard output. They write it out as they go, so the text of a long array is not held in memory as a whole. `IO::eprintf` and `IO::eprintfln` write to the standard error, and `Debug::debug_printf` and the others write and flush outside `IO`, as `debug_print` does.

  ```
  "x = {}, y = {}".printfln((1, [2, 3]))     // prints "x = 1, y = [2, 3]"
  ```

- The trait `Format`. Implement it for a type so that `format` and `printf` can write its values.
- Wrappers that change how a value is written: `F32::with_precision`, `F64::with_precision`, `Array::with_separator`, `Slice::with_separator`, `Format::right_aligned_to` and `Format::left_aligned_to`.

  ```
  "[{}]".format((3.14159.with_precision(2_U8).right_aligned_to(6),))   // "[  3.14]"
  ```

- The types `Slice a` and `StringSlice`: a part of an array and a part of a string. `Array::get_slice` and `String::get_slice` take one without copying the elements, where `get_sub` copies them. `to_string` and `format` write a `Slice a` the same way as an array, and a `StringSlice` as its text.

  ```
  [1, 2, 3, 4].get_slice(1, 3).to_array        // [2, 3]
  [1, 2, 3, 4].get_slice(1, 3).to_string       // "[2, 3]"
  "abc,def".get_slice(4, 7).to_string          // "def"
  "<{}>".format(("abc,def".get_slice(4, 7),))  // "<def>"
  ```

The full list is in [docs/Std.Experimental.md](docs/Std.Experimental.md).

## Usage

Add the dependency to your project:

```toml
[[dependencies]]
name = "std-experimental"
version = "0.5.0"
git = { url = "https://github.com/tttmmmyyyy/fixlang-std-experimental.git" }
```

Then import the module:

```
module Main;
import Std.Experimental;

main : IO () = println("x = {}".format((42,)));
```

## Dependence on the compiler

This library calls functions of the Fix runtime and private values of `Std`, which are not part of the public API. So each version of this library works only with the Fix versions it was tested with. A new Fix version may need a new version of this library.

## Development

- `fix test` runs the tests.
- In `tools`, `fix run -- test-aborts` checks that `format` aborts the program when the template does not match the values and that `Slice::@` aborts it for an index outside the slice, and `fix run -- gen-tuples` generates the implementations for tuples in `std_experimental.fix`. The first run needs `--allow-preliminary-commands`, because the dependency `subprocess` runs `make` before it is built.
- `fix docs -m Std.Experimental -o docs` generates the documentation.
