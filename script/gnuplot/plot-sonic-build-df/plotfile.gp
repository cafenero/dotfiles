set xdata time
set timefmt "%H:%M:%S"
set format x "%H:%M"

set title "Time V.S. Disk usage during SONiC build"
set xlabel "TIME [%H:%M]"
set ylabel "Disk usage [GB]"

set title  font "Arial,20"
set xlabel font "Arial,18"
set ylabel font "Arial,18"
set key    font "Arial,16"
set tics   font "Arial,16"
set xtics  font "Arial,14"
set ytics  font "Arial,14"

set xtics rotate by 45 right
set lmargin 18
set bmargin 8
set xlabel offset  0,-3
set ylabel offset -6,0

# plot [][0:400] "summary.dat" using 1:2 with linespoints title "202205-barefoot"
plot [][0:700] filename using 1:2 with linespoints title "202205-vs-kvm"

pause -1