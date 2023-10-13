set terminal png
set output 'linearizable_no_graph.png'
set xlabel 'Number of Nodes' font ',18'
set ylabel 'Throughput (Op/s)' font ',18'
set xtics font ",14"
set ytics font ",14"
plot 'benchmarks-l.csv' using 1:2 title "Experimental Data" with points pointtype 7 pointsize 2, \
     (8546.8264573398*x)/(1+0.5621701595*(x-1)+0.0435818099*x*(x-1)) title "Universal Scalability Law" with lines lw 4
# plot 'benchmarks-l.csv' using 1:2 title "Experimental Data" with points pointtype 7 pointsize 2
