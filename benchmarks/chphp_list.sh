root="${0%/*}/.."
n=1000

. "$root/share/chphp/chphp.sh"

PHP_VERSIONS=(
	/~/.php_versions/php-5.3.27
	/opt/php_versions/php-5.5.5
)
PHP_ROOT="/opt/php_versions/php-5.5.5"

for i in {1..3}; do
	echo "Listing php versions $n times ..."

	time (
		for ((i=0; i<$n; i++)); do
			chphp >/dev/null
		done
	)
done
