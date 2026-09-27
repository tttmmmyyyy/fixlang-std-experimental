#!/bin/sh
# Checks that `format` stops the program, with the report it names, on each kind of template that
# does not match its values. `fix test` cannot check this, since the program under test is the one
# that stops. Run it from the directory it is in; `FIX` names the compiler (default: `fix`).
set -u
FIX=${FIX:-fix}
dir=$(mktemp -d)
trap 'rm -rf "$dir"' EXIT
failures=0

# expect_abort <expression> <report>
expect_abort() {
    printf 'module Main;\nimport Std.Experimental;\nmain : IO () = println(%s);\n' "$1" > "$dir/main.fix"
    if output=$("$FIX" run -f std_experimental.fix -f "$dir/main.fix" 2>&1); then
        echo "FAIL: $1 ran to the end"
        failures=$((failures + 1))
    elif ! printf '%s' "$output" | grep -qF -- "$2"; then
        echo "FAIL: $1 stopped without the report \"$2\":"
        echo "$output"
        failures=$((failures + 1))
    else
        echo "ok: $1"
    fi
}

expect_abort '"{} and".format((1, 2))' 'The template has fewer placeholders than the values: "{} and"'
expect_abort '"{} and {}".format((1,))' 'The template has more placeholders than the values: "{} and {}"'
expect_abort '"a } b".format(())' 'The template has a "}" that is neither a placeholder nor an escape: "a } b"'
expect_abort '"a {".format(())' 'The template has a "{" that is neither a placeholder nor an escape: "a {"'

exit $((failures > 0))
