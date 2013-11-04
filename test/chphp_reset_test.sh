. ./test/helper.sh

function setUp()
{
	chphp_use "$test_php_root" >/dev/null

	export PATH="$PHP_ROOT/bin:$test_path"
}

function test_chphp_reset()
{
	chphp_reset

	assertNull "PHP_ROOT was not unset"     "$PHP_ROOT"
	assertNull "PHP_ENGINE was not unset"   "$PHP_ENGINE"
	assertNull "PHP_VERSION was not unset"  "$PHP_VERSION"
	assertNull "PHPOPT was not unset"       "$PHPOPT"

	assertEquals "PATH was not sanitized"    "$test_path" "$PATH"
}

function test_chphp_reset_duplicate_path()
{
	export PATH="$PATH:$PHP_ROOT/bin"

	chphp_reset

	assertEquals "PATH was not sanitized"    "$test_path" "$PATH"
}

SHUNIT_PARENT=$0 . $SHUNIT2
