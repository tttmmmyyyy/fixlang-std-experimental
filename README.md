# std-experimental

The module `Std.Experimental` for the [Fix programming language](https://github.com/tttmmmyyyy/fixlang): additions to `Std` whose design is not settled yet. An entity here can change or disappear in any version. One whose design settles moves into `Std`.

## Contents

- `format` writes values of mixed types into the `{}` placeholders of a template. Each value writes its text straight into the result, so `format` builds no string per value.

  ```
  "{} + {} = {}".format((1, 2.5, "three"))   // "1 + 2.5 = three"
  ```

- The trait `Format`, which a type implements to be written by `format`.
- Wrappers that choose how a value is written: `F32::with_precision`, `F64::with_precision`, `Array::with_separator`, `right_aligned_to` and `left_aligned_to`.

  ```
  "[{}]".format((3.14159.with_precision(2_U8).right_aligned_to(6),))   // "[  3.14]"
  ```

The full list is in [docs/Std.Experimental.md](docs/Std.Experimental.md).

## Usage

Add the dependency to your project:

```toml
[[dependencies]]
name = "std-experimental"
version = "0.1.0"
git = { url = "https://github.com/tttmmmyyyy/fixlang-std-experimental.git" }
```

Then import the module:

```
module Main;
import Std.Experimental;

main : IO () = println("x = {}".format((42,)));
```

## Dependence on the compiler

This library calls functions of the Fix runtime and private values of `Std`, which are not part of the public API. A version of this library therefore works with the Fix versions it is tested with, and a new Fix version can require a new version of this library.

## Development

- `fix test` runs the tests.
- `./test_aborts.sh` checks that `format` stops the program on a template that does not match its values.
- `./gen_tuples.py` writes the implementations for tuples into `std_experimental.fix`.
- `fix docs -m Std.Experimental -o docs` writes the document.
