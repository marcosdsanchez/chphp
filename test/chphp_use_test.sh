. ./test/helper.sh

function setUp()
{
	chphp_use $test_php_root >/dev/null
}

function test_chphp_use()
{
	assertEquals "invalid PHP_ROOT"    "$test_php_root" "$PHP_ROOT"
	assertEquals "invalid PHP_VERSION" "$test_php_version" "$PHP_VERSION"
	assertEquals "invalid PATH"        "$test_php_root/bin:$__shunit_tmpDir:$test_path" "$PATH"

	assertEquals "could not find php in $PATH" \
		     "$test_php_root/bin/php" \
		     "$(command -v php)"
}

function tearDown()
{
	chphp_reset
}

SHUNIT_PARENT=$0 . $SHUNIT2
