set terminal png
set output "out.png"

set xdata time
set timefmt "%m/%d_%H:%M:%S"
set format x "%m/%d %H:%M"

set title "Disk usage during SONiC build"
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
set lmargin 12
set bmargin 6
set xlabel offset  0,-3
set ylabel offset 0,0
set xtics nomirror

# plot [][0:400] "summary.dat" using 1:2 with linespoints title "202205-barefoot"
plot [][0:300] "out.dat" using 1:($2-174) with linespoints title "202205-VS-b0c9013ea1"

pause -1