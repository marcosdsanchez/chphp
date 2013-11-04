[[ -z "$SHUNIT2"     ]] && SHUNIT2=/usr/share/shunit2/shunit2
[[ -n "$ZSH_VERSION" ]] && setopt shwordsplit

export PREFIX="$PWD/test"
export HOME="$PREFIX/home"
export PATH="$PWD/bin:$PATH"

. ./share/chphp/chphp.sh
chphp_reset

test_php_engine="php"
test_php_version="5.5.5"
test_php_root="$PWD/test/opt/php_versions/$test_php_engine-$test_php_version"

test_path="$PATH"

test_project_dir="$PWD/test/project"

setUp() { return; }
tearDown() { return; }
oneTimeTearDown() { return; }
