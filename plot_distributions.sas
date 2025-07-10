data mydata;
  do x = -4 to 4 by .001;
    y = pdf("Normal", x, 0, 1);
    output;
  end;
run;

title 'Standard normal pdf';
proc sgplot data=mydata;
  series x = x y = y;
run;

******
******
******;

data mydata;
  do x = -4 to 4 by .001;
    y = cdf("Normal", x, 0, 1);
    output;
  end;
run;

title 'Standard normal cdf';
proc sgplot data=mydata;
  series x = x y = y;
run;

******
******
******;

data mydata;
  do x = 0 to 4 by .001;
    y = pdf("Exponential", x, 1);
    output;
  end;
run;

title 'Exponential pdf';
proc sgplot data=mydata;
  series x = x y = y;
run;

******
******
******;

data mydata;
  do x = 0 to 4 by .001;
    y = cdf("Exponential", x, 1);
    output;
  end;
run;

title 'Exponential cdf';
proc sgplot data=mydata;
  series x = x y = y;
run;

