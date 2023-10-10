set terminal pdf
set output 'data.pdf'
plot 'benchmarks-diogo.csv' using 1:2 title "data", \
	(8778.0448187353*x)/(1+0.6898779236*(x-1)+0.0398526279*x*(x-1))
