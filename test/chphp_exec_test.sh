. ./test/helper.sh

function test_chphp_exec_no_arguments()
{
	chphp-exec 2>/dev/null

	assertEquals "did not exit with 1" 1 $?
}

function test_chphp_exec_no_command()
{
	chphp-exec "$test_php_version" 2>/dev/null

	assertEquals "did not exit with 1" 1 $?
}

function test_chphp_exec()
{
	local command="php -r 'print PHP_VERSION;'"
	local php_version=$(chphp-exec "$test_php_version" -- $command)

	assertEquals "did change the php version" "$test_php_version" "$php_version"
}

SHUNIT_PARENT=$0 . $SHUNIT2
