root="${0%/*}/.."
n=100
php_dir="$root/test/opt/php_versions/php-5.5.5"

. "$root/share/chphp/chphp.sh"

for i in {1..3}; do
	echo "Loading $(basename "$php_dir") $n times..."

	time (
		for ((i=0; i<$n; i+=1)); do
			chphp_use "$php_dir"
		done
	)
done
