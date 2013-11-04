. ./test/helper.sh

function tearDown()
{
	chphp_reset
}

function test_chphp_default_PHP_VERSIONS()
{
	assertEquals "did not correctly populate PHP_VERSIONS" \
		     "$test_php_root" \
		     "${PHP_VERSIONS[*]}"
}

function test_chphp_5_5()
{
	chphp "5.5" >/dev/null

	assertEquals "did not match 5.5" "$test_php_root" "$PHP_ROOT"
}

function test_chphp_multiple_matches()
{
	PHP_VERSIONS=(/path/to/php-5.5.0 "$test_php_root")

	chphp "5.5" >/dev/null

	assertEquals "did not use the last match" "$test_php_root" "$PHP_ROOT"
}

function test_chphp_system()
{
	chphp "$test_php_version" >/dev/null
	chphp system

	assertNull "did not reset the PHP" "$PHP_ROOT"
}

function test_chphp_unknown()
{
	chphp "does_not_exist" 2>/dev/null

	assertEquals "did not return 1" 1 $?
}

function test_chphp_invalid_php()
{
	PHP_VERSIONS=(/does/not/exist/php)

	chphp "php" 2>/dev/null

	assertEquals "did not return 1" 1 $?
}

SHUNIT_PARENT=$0 . $SHUNIT2
