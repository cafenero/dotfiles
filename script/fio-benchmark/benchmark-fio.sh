#!/bin/bash -x

# Thanks! https://qiita.com/toshihirock/items/fa4d310115e6921ab0ac

DIR=./results/$1
mkdir -p $DIR

date > $DIR/date.txt

tmpDIR=$2


# bs=4KB, read/randread
fio -filename=$2/test10G -direct=1 -rw=read      -bs=4k -size=10G -numjobs=16 -runtime=10 -group_reporting -name=seqR-4KB  --output-format=json > $DIR/seqR-4KB.txt
sleep 1
fio -filename=$2/test10G -direct=1 -rw=randread  -bs=4k -size=10G -numjobs=16 -runtime=10 -group_reporting -name=randR-4KB  --output-format=json > $DIR/randR-4KB.txt
sleep 1

# bs=4KB, write/randwrite
fio -filename=$2/test10G -direct=1 -rw=write     -bs=4k -size=10G -numjobs=16 -runtime=10 -group_reporting -name=seqW-4KB  --output-format=json > $DIR/seqW-4KB.txt
sleep 1
fio -filename=$2/test10G -direct=1 -rw=randwrite -bs=4k -size=10G -numjobs=16 -runtime=10 -group_reporting -name=randW-4KB  --output-format=json > $DIR/randW-4KB.txt
sleep 1


# bs=32MB, read/randread
fio -filename=$2/test10G -direct=1 -rw=read      -bs=32m -size=10G -numjobs=16 -runtime=10 -group_reporting -name=seqR-32MB  --output-format=json > $DIR/seqR-32MB.txt
sleep 1
fio -filename=$2/test10G -direct=1 -rw=randread  -bs=32m -size=10G -numjobs=16 -runtime=10 -group_reporting -name=randR-32MB  --output-format=json > $DIR/randR-32MB.txt
sleep 1

# bs=32MB, write/randwrite
fio -filename=$2/test10G -direct=1 -rw=write     -bs=32m -size=10G -numjobs=16 -runtime=10 -group_reporting -name=seqW-32MB  --output-format=json > $DIR/seqW-32MB.txt
sleep 1
fio -filename=$2/test10G -direct=1 -rw=randwrite -bs=32m -size=10G -numjobs=16 -runtime=10 -group_reporting -name=randW-32MB  --output-format=json > $DIR/randW-32MB.txt
sleep 1
