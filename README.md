# std-experimental

The module `Std.Experimental` for the [Fix programming language](https://github.com/tttmmmyyyy/fixlang). It contains additions to `Std` whose design is not settled yet. Anything here may change or be removed in any version. When its design settles, it moves into `Std`.

## Contents

- The types `Slice a` and `StringSlice`: a part of an array and a part of a string. `Array::get_slice` and `String::get_slice` take one without copying the elements, where `get_sub` copies them. `to_string` and `format` write a `Slice a` the same way as an array, and a `StringSlice` as its text.

  ```
  [1, 2, 3, 4].get_slice(1, 3).to_array        // [2, 3]
  [1, 2, 3, 4].get_slice(1, 3).to_string       // "[2, 3]"
  "abc,def".get_slice(4, 7).to_string          // "def"
  "<{}>".format(("abc,def".get_slice(4, 7),))  // "<def>"
  ```

`String::format`, `IO::printf` and the trait `Format`, which versions before 0.7.0 had, are now in `Std`.

The full list is in [docs/Std.Experimental.md](docs/Std.Experimental.md).

## Usage

Add the dependency to your project:

```toml
[[dependencies]]
name = "std-experimental"
version = "0.7.0"
git = { url = "https://github.com/tttmmmyyyy/fixlang-std-experimental.git" }
```

Then import the module:

```
module Main;
import Std.Experimental;

main : IO () = println([1, 2, 3, 4].get_slice(1, 3).to_string);
```

## Dependence on the compiler

This library calls functions of the Fix runtime and private values of `Std`, which are not part of the public API. So each version of this library works only with the Fix versions it was tested with. A new Fix version may need a new version of this library.

## Development

- `fix test` runs the tests.
- In `tools`, `fix run -- test-aborts` checks that `Slice::@` aborts the program for an index outside the slice. The first run needs `--allow-preliminary-commands`, because the dependency `subprocess` runs `make` before it is built.
- `fix docs -m Std.Experimental -o docs` generates the documentation.
