%let n = 1;

data die;
    do roll = 1 to &n;
    	x = floor(rand("Uniform")*6 + 1);
        output;
    end;
run;

proc means data=die;
    var x;
    output out=simout mean=xbar;
run;


proc print data=simout;
run;