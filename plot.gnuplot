#!/usr/bin/gnuplot
isdumb=1
ispng=1
dhcptimedata="/tmp/makedhcptime"

if(isdumb==1) { 
   set terminal dumb; 
   set output "/install/dhcpperf.dumb";
   set title "the performance of <makedhcp> and <makedhcp -d>"
   set xlabel "The number of the nodes (no units)"
   plot dhcptimedata using 1:2 title 'the time of <makedhcp>(mili second)', dhcptimedata using 1:3 title 'the time of <makedhcp -d>(mili second)';
   print "dumb /install/dhcpperf.dumb generated!";
} 



timemkdhcp(x) = a*x + b
timermdhcp(x) = c*x + d
fit timemkdhcp(x) dhcptimedata using 1:2 via a,b
fit timermdhcp(x) dhcptimedata using 1:3 via c,d


if(ispng==1) { 
   set terminal png;
   set output "/install/dhcpperf.png";
   set title "the performance of <makedhcp> and <makedhcp -d>";
   set xlabel "The number of the nodes (no units)";
   
   plot dhcptimedata u 1:2 t 'the time of <makedhcp>(mili second)' w lp, timemkdhcp(x)  t "the fitted curve of  timemkdhcp(node)" w l , dhcptimedata u 1:3 t 'the time of <makedhcp -d>(mili second)' w lp, timermdhcp(x)  t "the fitted curve of  timermdhcp(node)" w l;
   print "image /install/dhcpperf.png generated!";
}
