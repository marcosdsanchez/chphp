CHPHP_VERSION="0.0.1"
PHP_VERSIONS=()

for dir in "$PREFIX/opt/php_versions" "$HOME/.php_versions"; do
	[[ -d "$dir" && -n "$(ls -A "$dir")" ]] && PHP_VERSIONS+=("$dir"/*)
done
unset dir

function chphp_reset()
{
	[[ -z "$PHP_ROOT" ]] && return

	PATH=":$PATH:"; PATH="${PATH//:$PHP_ROOT\/bin:/:}"
	PATH="${PATH#:}"; PATH="${PATH%:}"
	unset PHP_ROOT PHP_ENGINE PHP_VERSION PHPOPT
	hash -r
}

function chphp_use()
{
	if [[ ! -x "$1/bin/php" ]]; then
		echo "chphp: $1/bin/php not executable" >&2
		return 1
	fi

	[[ -n "$PHP_ROOT" ]] && chphp_reset

	export PHP_ROOT="$1"
	export PHPOPT="$2"
	export PATH="$PHP_ROOT/bin:$PATH"
	export PHP_VERSION=$($PHP_ROOT/bin/php -r 'echo phpversion();')
}

function chphp()
{
	case "$1" in
		-h|--help)
			echo "usage: chphp [PHP|VERSION|system] [PHP_OPTS]"
			;;
		-V|--version)
			echo "chphp: $CHPHP_VERSION"
			;;
		"")
			local dir star
			for dir in "${PHP_VERSIONS[@]}"; do
				dir="${dir%%/}"
				if [[ "$dir" == "$PHP_ROOT" ]]; then star="*"
				else                                 star=" "
				fi

				echo " $star ${dir##*/}"
			done
			;;
		system) chphp_reset ;;
		*)
			local dir match
			for dir in "${PHP_VERSIONS[@]}"; do
				dir="${dir%%/}"
				[[ "${dir##*/}" == *"$1"* ]] && match="$dir"
			done

			if [[ -z "$match" ]]; then
				echo "chphp: unknown PHP: $1" >&2
				return 1
			fi

			shift
			chphp_use "$match" "$*"
			;;
	esac
}
