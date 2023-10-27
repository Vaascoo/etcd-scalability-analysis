set terminal png
set output 'cores_graph.png'
set xlabel 'Number of Cores' font ',18'
set ylabel 'Throughput (Op/s)' font ',18'
set xtics font ",14"
set ytics font ",14"
 plot 'benchmarks-cores.csv' using 1:2 title "Experimental Data" with points pointtype 7 pointsize 2, \
      (26396.6332445704*x)/(1+0.6160867027*(x-1)+0.0013761883*x*(x-1)) title "Universal Scalability Law" with lines lw 4
#plot 'benchmarks-cores.csv' using 1:2 title "Experimental Data" with points pointtype 7 pointsize 2


#ambda: 26396.6332445704 Delta: 0.6160867027 Kappa: 0.0013761883