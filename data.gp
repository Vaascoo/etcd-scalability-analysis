set terminal pdf
set output 'data.pdf'
plot 'data.csv' using 1:2 title "data", \
	(995*x)/(1+0.0267*(x-1)+0.000769*x*(x-1))
