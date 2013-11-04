. ./share/chphp/auto.sh
. ./test/helper.sh

function setUp()
{
	chphp_reset
	unset PHP_AUTO_VERSION
}

function test_chphp_auto_loaded_in_zsh()
{
	[[ -n "$ZSH_VERSION" ]] || return

	assertEquals "did not add chphp_auto to preexec_functions" \
		     "chphp_auto" \
		     "$preexec_functions"
}

function test_chphp_auto_loaded_in_bash()
{
	[[ -n "$BASH_VERSION" ]] || return

	local command=". $PWD/share/chphp/auto.sh && trap -p DEBUG"
	local output="$("$SHELL" -c "$command")"

	assertTrue "did not add a trap hook for chphp_auto" \
		   '[[ "$output" == *chphp_auto* ]]'
}

function test_chphp_auto_loaded_twice_in_zsh()
{
	[[ -n "$ZSH_VERSION" ]] || return

	. ./share/chphp/auto.sh

	assertNotEquals "should not add chphp_auto twice" \
		        "$preexec_functions" \
			"chphp_auto chphp_auto"
}

function test_chphp_auto_loaded_twice()
{
	PHP_AUTO_VERSION="dirty"
	PROMPT_COMMAND="chphp_auto"

	. ./share/chphp/auto.sh

	assertNull "PHP_AUTO_VERSION was not unset" "$PHP_AUTO_VERSION"
}

function test_chphp_auto_enter_project_dir()
{
	cd "$test_project_dir" && chphp_auto

	assertEquals "did not switch PHP when entering a versioned directory" \
		     "$test_php_root" "$PHP_ROOT"
}

function test_chphp_auto_enter_subdir_directly()
{
	cd "$test_project_dir/sub_dir" && chphp_auto

	assertEquals "did not switch PHP when directly entering a sub-directory of a versioned directory" \
		     "$test_php_root" "$PHP_ROOT"
}

function test_chphp_auto_enter_subdir()
{
	cd "$test_project_dir" && chphp_auto
	cd sub_dir             && chphp_auto

	assertEquals "did not keep the current PHP when entering a sub-dir" \
		     "$test_php_root" "$PHP_ROOT"
}

function test_chphp_auto_enter_subdir_with_php_version()
{
	cd "$test_project_dir"    && chphp_auto
	cd sub_versioned/         && chphp_auto

	assertNull "did not switch PHP when leaving a sub-versioned directory" \
		   "$PHP_ROOT"
}

function test_chphp_auto_modified_php_version()
{
	cd "$test_project_dir/modified_version" && chphp_auto
	echo "5.5.5" > .php-version            && chphp_auto

	assertEquals "did not detect the modified .php-version file" \
		     "$test_php_root" "$PHP_ROOT"
}

function test_chphp_auto_overriding_php_version()
{
	cd "$test_project_dir" && chphp_auto
	chphp system          && chphp_auto

	assertNull "did not override the php set in .php-version" "$PHP_ROOT"
}

function test_chphp_auto_leave_project_dir()
{
	cd "$test_project_dir"    && chphp_auto
	cd "$test_project_dir/.." && chphp_auto

	assertNull "did not reset the PHP version when leaving a versioned directory" \
		   "$PHP_ROOT"
}

function test_chphp_auto_invalid_phhp_version()
{
	local expected_auto_version="$(cat $test_project_dir/bad/.php-version)"

	cd "$test_project_dir" && chphp_auto
	cd bad/                && chphp_auto 2>/dev/null

	assertEquals "did not keep the current PHP when loading an unknown version" \
		     "$test_php_root" "$PHP_ROOT"
	assertEquals "did not set PHP_AUTO_VERSION" \
		     "$expected_auto_version" "$PHP_AUTO_VERSION"
}

function tearDown()
{
	cd "$PWD"
}

SHUNIT_PARENT=$0 . $SHUNIT2
