#
# chphp script to collect environment information for bug reports.
#

[[ -z "$PS1" ]] && exec "$SHELL" -i -l "$0"

function print_section()
{
	echo
	echo "## $1"
	echo
}

function indent()
{
	echo "$1" | sed 's/^/    /'
}

function print_variable()
{
	if [[ -n "$2" ]]; then echo "    $1=$2"
	else                   echo "    $1=$(eval "echo \$$1")"
	fi
}

function print_version()
{
	local path="$(command -v "$1")"

	if [[ -n "$path" ]]; then
		indent "$("$1" --version | head -n 1) ($path)"
	fi
}


print_section "System"

indent "$(uname -a)"
print_version "bash"
print_version "tmux"
print_version "zsh"
print_version "php"
print_version "bundle"

print_section "Environment"

print_variable "CHPHP_VERSION"
print_variable "SHELL"
print_variable "PATH"
print_variable "HOME"

print_variable "PHP_VERSIONS" "(${PHP_VERSIONS[@]})"
print_variable "PHP_ROOT"
print_variable "PHP_VERSION"
print_variable "PHP_ENGINE"
print_variable "PHP_AUTO_VERSION"

if [[ -n "$ZSH_VERSION" ]]; then
	print_section "Hooks"
	print_variable "preexec_functions" "(${preexec_functions[@]})"
	print_variable "precmd_functions" "(${precmd_functions[@]})"
elif [[ -n "$BASH_VERSION" ]]; then
	print_section "Hooks"
	indent "$(trap -p)"
fi

if [[ -f .php-version ]]; then
	print_section ".php-version"
	echo "    $(< .php-version)"
fi

print_section "Aliases"

indent "$(alias)"
