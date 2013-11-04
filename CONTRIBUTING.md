# Contributing

## Code Style

* Tab indent code.
* Keep code within 80 columns.
* Global variables must be UPPERCASE. Temporary variables should be lowercase.
* Use the `function` keyword for functions.
* Quote all String variables.
* Use `(( ))` for arithmetic expressions and `[[ ]]` otherwise.
* Use `$(...)` instead of back-ticks.
* Use `${path##*/}` instead of `$(basename $path)`.
* Use `${path%/*}` instead of `$(dirname $path)`.
* Prefer single-line expressions where appropriate:

        [[ -n "$foo" ]] && other command

        if   [[ "$foo" == "bar" ]]; then command
        elif [[ "$foo" == "baz" ]]; then other_command
        fi

        case "$foo" in
        	bar) command ;;
        	baz) other_command ;;
        esac

## Pull Request Guidelines

* Additional features should go in separate files within `share/chphp/`.
* All new code must have [shunit2] unit-tests.
* If a feature is out of scope or does more than switches php versions,
  it should become its own project. Simply copy the generic [Makefile]
  for shell script projects.

### What Will Not Be Accepted

* Completion: tab completion is not necessary for fuzzy matching
  (ex: `chphp 1.9`).
* [Bash][bash] or [Zsh][zsh] only features: chphp must fully support both
  [bash] and [zsh].
* New `.files`: we should strive to prevent dotfile proliferation, and instead
  support common dotfiles which other Ruby Switchers could support.
* New environment variables: much like with dotfile proliferation,
  we should keep environment variable pollution to a minimum.
* PHP/OS specific workarounds: we should not tolerate the existence of bugs
  in specific php versions or Operating Systems. Instead we should strive to resolve
  these bugs, to the benefit of all users.

[shunit2]: http://code.google.com/p/shunit2/

[bash]: http://www.gnu.org/software/bash/
[zsh]: http://www.zsh.org/
