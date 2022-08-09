#!/bin/bash -uex

DIR=./results/$1

### bw
# bs=4KB
jq '.jobs[0].read.bw' ./$DIR/seqR-4KB.txt
jq '.jobs[0].read.bw' ./$DIR/randR-4KB.txt
jq '.jobs[0].write.bw' ./$DIR/seqW-4KB.txt
jq '.jobs[0].write.bw' ./$DIR/randW-4KB.txt
# bs=32MB
jq '.jobs[0].read.bw' ./$DIR/seqR-32MB.txt
jq '.jobs[0].read.bw' ./$DIR/randR-32MB.txt
jq '.jobs[0].write.bw' ./$DIR/seqW-32MB.txt
jq '.jobs[0].write.bw' ./$DIR/randW-32MB.txt


### iops
# bs=4KB
jq '.jobs[0].read.iops' ./$DIR/seqR-4KB.txt
jq '.jobs[0].read.iops' ./$DIR/randR-4KB.txt
jq '.jobs[0].write.iops' ./$DIR/seqW-4KB.txt
jq '.jobs[0].write.iops' ./$DIR/randW-4KB.txt
# bs=32MB
jq '.jobs[0].read.iops' ./$DIR/seqR-32MB.txt
jq '.jobs[0].read.iops' ./$DIR/randR-32MB.txt
jq '.jobs[0].write.iops' ./$DIR/seqW-32MB.txt
jq '.jobs[0].write.iops' ./$DIR/randW-32MB.txt
