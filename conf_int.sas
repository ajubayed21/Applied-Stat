libname in "c:\temp";

data a;
set in.health_insurance;
run;

proc print data=a(obs=15);
run;


/* confidence interval */
proc means data=a clm;
var health;
run;


/* one sample hypothesis test */
proc ttest data=a H0=3.75 alpha=.05 plots=none;
var health;
run;


/* two sample hypothesis test */
proc ttest data=a alpha=.05 plots=none;
class insured;
var health;
run;


/* two sample hypothesis test */
proc ttest data=a alpha=.05 plots=none;
paired famsize*health;
run;
