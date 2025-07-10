data a;
infile 'C:\temp\cobra_did.csv' delimiter=',' firstobs=2;
input famsize msa age dependent cobra female black hisp married educ_hs educ_sc educ_co invol subsidy;
run;

proc print data=a(obs=15);
run;

proc means data=a;
run;

data a;
set a;
notdep = 1-dependent;
elig = notdep*invol;
did = subsidy*elig;
run;

proc reg data=a plots=none;
model cobra = subsidy elig did age female black hisp msa married famsize educ_hs educ_sc educ_co;
run;

