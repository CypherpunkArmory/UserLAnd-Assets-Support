#!/data/data/tech.ula/files/support/busybox sh

dokill() {
    for cpid in $(../support/busybox ps -o ppid,pid | ../support/busybox awk -v pid="$1" '$1 == pid { print $2 }') 
    do
        dokill $cpid
    done
    echo "killing $1 $(../support/busybox ps -o pid,comm | ../support/busybox awk -v pid="$1" '$1 == pid { print $2 }')"
    kill -9 $1 > /dev/null 2>&1
}

if [[ $# == 0 ]]; then
    echo "usage: $(basename $0) <top pid to kill>"
    exit 1
fi

for pid in $*
do
    dokill $pid
done
