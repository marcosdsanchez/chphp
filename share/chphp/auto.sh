unset PHP_AUTO_VERSION

function chphp_auto() {
	local dir="$PWD" version

	until [[ -z "$dir" ]]; do
		if { read -r version <"$dir/.php-version"; } 2>/dev/null || [[ -n "$version" ]]; then
			if [[ "$version" == "$PHP_AUTO_VERSION" ]]; then return
			else
				PHP_AUTO_VERSION="$version"
				chphp "$version"
				return $?
			fi
		fi

		dir="${dir%/*}"
	done

	if [[ -n "$PHP_AUTO_VERSION" ]]; then
		chphp_reset
		unset PHP_AUTO_VERSION
	fi
}

if [[ -n "$ZSH_VERSION" ]]; then
	if [[ ! "$preexec_functions" == *chphp_auto* ]]; then
		preexec_functions+=("chphp_auto")
	fi
elif [[ -n "$BASH_VERSION" ]]; then
	trap '[[ "$BASH_COMMAND" != "$PROMPT_COMMAND" ]] && chphp_auto' DEBUG
fi
