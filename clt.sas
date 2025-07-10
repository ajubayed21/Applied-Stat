%let numsamples = 100;
%let n = 5;

data sim;
	do sample = 1 to &numsamples;
		do i = 1 to &n;
			x = rand("Exponential", 1);
			output;
		end;
	end;
run;


proc means data=sim;
	by sample;
	var x;
	output out=simout mean=xbar;
run;


proc print data=simout;
run;


proc sgplot data=simout;
	density xbar/type=kernel;
run;
