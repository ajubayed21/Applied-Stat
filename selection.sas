data a;
infile 'c:\temp\selection.csv' delimiter=',' dsd firstobs=2;
input age educ kid06 hearprob lnwage anywage;
run;

proc print data=a(obs=15);
run;

proc means data=a;
run;

proc reg data=a plots=none;
model lnwage = age educ hearprob;
run;

/* heckman selection model, estimated by MLE */

proc qlim data=a plots=none;
model anywage = age educ hearprob kid06;
model lnwage  = age educ hearprob /select(anywage=1);
run;

/* heckman selection model, estimated by two-step regression */

proc qlim data=a plots=none heckit;
model anywage = age educ hearprob kid06;
model lnwage  = age educ hearprob / select(anywage=1);
run;
