data a;
infile 'C:\temp\fathers.csv' delimiter=',' firstobs=2;
input id year steal female age black hisp msa work student dadgone;
run;

proc print data=a(obs=15);
run;

proc means data=a;
var steal dadgone age female black hisp msa work student;
run;


/* a simple regression, ignoring panel structure */

proc reg data=a plots=none;
model steal = dadgone age female black hisp msa work student;
run;


/* fixed effects regression */

proc panel data=a plot=none;
id id year;
model steal = dadgone age female black hisp msa work student / fixone;
run;


/* random effects regression */

proc panel data=a plot=none;
id id year;
model steal = dadgone age female black hisp msa work student / ranone;
run;


/* check within-person time variation of steal and dadgone */

proc means data=a mean;
var steal dadgone;
by id;
output out=groupmeans mean=stealmeans dadgonemeans;
run;

proc print data=groupmeans(obs=15);
run;

proc sort data=a;
by id year;
run;

data merged;
merge a groupmeans;
by id;
drop _TYPE_ _FREQ_;
run;

proc print data=merged(obs=15);
run;

data within;
set merged;
stealwithin = steal - stealmeans;
dadgonewithin = dadgone - dadgonemeans;
run;

proc means data=within;
run;



/* lagged dependent variable regression */

data b;
set a;
lagsteal = lag(steal);
if year=1998 then delete;
run;

proc print data=b(obs=15);
run;

proc reg data=b plots=none;
model steal = lagsteal dadgone age female black hisp msa work student;
run;
