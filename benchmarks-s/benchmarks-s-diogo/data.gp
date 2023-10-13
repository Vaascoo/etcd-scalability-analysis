set terminal png
set output 'linearizable_no_graph.png'
set xlabel 'Number of Nodes' font ',18'
set ylabel 'Throughput (Op/s)' font ',18'
set xtics font ",14"
set ytics font ",14"
# plot 'new-benchmark-performance-power.csv' using 1:2 title "Experimental Data" with points pointtype 7 pointsize 2, \
# 	(9215.7459428250*x)/(1+0.5435290795*(x-1)+0.0465684475*x*(x-1)) title "Universal Scalability Law" with lines lw 4
plot 'new-benchmark-performance-power.csv' using 1:2 title "Experimental Data" with points pointtype 7 pointsize 2
