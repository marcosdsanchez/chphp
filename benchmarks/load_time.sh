root="${0%/*}/.."
n=1000

for i in {1..3}; do
	echo "Loading chphp $n times..."

	time (
		for ((i=0; i<$n; i+=1)); do
			source "$root/share/chphp/chphp.sh"
		done
	)
done
