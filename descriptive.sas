libname in "c:\temp";

data a;
set in.health_insurance;
run;

proc freq data=a;
table health;
table insured;
run;

proc sgplot data=a;
histogram health /binwidth=1;
density health;
run;

proc sgplot data=a;
scatter x=age y=income;
run;

proc means data=a maxdec=3;
class insured;
var health;
run;

proc means data=a maxdec=3;
class insured;
var health;
where female=1;
run;

proc means data=a maxdec=3;
class insured;
var health age female nonwhite educ employed income;
run;
