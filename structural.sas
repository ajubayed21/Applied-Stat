/* set sample size */

%let n = 5000;


/* demand: P = a - b*Q */
/* supply: P = c + d*q */

%let a = 1000;
%let b = 2;
%let c = 5;
%let d = 7;

data sim(drop=i);
call streaminit(10101);
	do i = 1 to &n;
		dshock = 2*rand("Normal");
		sshock = 2*rand("Normal");
		ashock = &a + dshock;
		cshock = &c + sshock;
		q = (ashock - cshock)/(&b + &d);
		p = ashock - &b*q;
		output;
	end;
run;

proc means data=sim;
run;

proc sgplot data=sim;
scatter x=q y=p;
run;

proc reg data=sim plots=none;
model p = q;
run;

proc syslim data=sim 2sls plots=none;
endogenous q;
instruments sshock;
model p = q;
run;






