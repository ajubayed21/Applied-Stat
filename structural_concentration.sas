/* set sample size */

%let markets = 5000;

/* demand in each market: P = a - bQ */
/* costs in each market: TFC = 300 and MC = 10 */

%let a = 140;
%let b = 2;
%let tfc = 300;
%let mc = 10;


/* generate simulated data */

data sim(drop=i);
call streaminit(10101);
	do i = 1 to &markets;

		dshock = 15*rand("Normal");
		ashock = &a + dshock;
		
		sshock = abs(5*rand("Normal"));
		mcshock = &mc + sshock;
		n = (ashock-mcshock)/sqrt(&tfc*&b) - 1;
		n = floor(n);
		
		p = (&a+n*mcshock)/(n+1);

		output;
	end;
run;

proc means data=sim;
var p n;
run;

proc reg data=sim plots=none;
model p = n;
run;

proc syslim data=sim 2sls plots=none;
endogenous n;
instruments sshock;
model p = n;
run;






