data a;
infile 'C:\temp\health_spending_2.csv' delimiter=',' firstobs=2;
input age health offer totspend female nonwhite insured;
lnspend = log(totspend+1);
run;

proc print data=a(obs=15);
run;

proc reg data=a plots=none;
model lnspend = insured;
run;

proc reg data=a plots=none;
model lnspend = insured age female nonwhite health;
run;

proc reg data=a plots=none;
model insured = offer age female nonwhite health;
run;

proc reg data=a plots=none;
model lnspend = insured offer age female nonwhite health;
run;

proc syslin data=a 2sls plots=none;
endogenous insured;
instruments offer age female nonwhite health;
model lnspend = insured age female nonwhite health;
run;

proc syslin data=a 2sls plots=none;
endogenous insured;
instruments offer;
model lnspend = insured;
run;
