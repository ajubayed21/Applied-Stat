data a;
infile 'c:\temp\quantile.csv' delimiter=',' firstobs=2;
input educ lnwk year;
run;

proc means data=a;
run;

/* simple regressions, by year */

proc reg data=a plots=none;
model lnwk = educ;
where year=1990;
run;

proc reg data=a plots=none;
model lnwk = educ;
where year=2000;
run;

/* quantile regressions, by year */

proc quantreg data=a;
model lnwk= educ / quantile=.1 .2 .3 .4 .5 .6 .7 .8 .9 plot=quantplot;
where year=1990;
run;

proc quantreg data=a;
model lnwk= educ / quantile=.1 .2 .3 .4 .5 .6 .7 .8 .9 plot=quantplot;
where year=2000;
run;
