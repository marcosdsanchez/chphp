root="${0%/*}/.."
n=100

PHP_VERSIONS=("$root/test/opt/php_versions/php-5.5.5")

. "$root/share/chphp/chphp.sh"
. "$root/share/chphp/auto.sh"

for i in {1..3}; do
	echo "Auto-switching $n times..."

	time (
		for ((i=0; i<$n; i+=1)); do
			cd "$root/test/project"
			chphp_auto
			cd ../../
			chphp_auto
		done
	)
done
