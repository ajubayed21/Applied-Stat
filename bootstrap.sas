data a;
  infile 'c:\temp\movies.csv' delimiter=',' firstobs=2;
  input budget usbox rrating;  
  lnbox = log(usbox);
  lnbudget = log(budget);
run;



/* proc means */

proc means data=a n mean std stderr;
  var lnbox;
run;



/* bootstrap standard error of mean */

proc surveyselect data=a seed=10101 noprint
  out = bootsamples
  method = urs
  samprate = 1
  reps = 1000;
run;

proc means data=bootsamples noprint;
  by replicate;
  var lnbox;
  output out=allmeans mean=lnboxmean;
run;

proc means data=allmeans;
run;



/* bootstrap standard error of median */

proc means data=a median;
  var lnbox;
run;

proc surveyselect data=a seed=10101 noprint
  out = bootsamples
  method = urs
  samprate = 1
  reps = 1000;
run;

proc means data=bootsamples noprint;
  by replicate;
  var lnbox;
  output out=allmedians median=lnboxmedian;
run;

proc means data=allmedians;
run;



/* bootstrap standard errors for regression */

proc reg data=a plots=none;
  model lnbox = lnbudget rrating;
run;

proc surveyselect data=a seed=10101 noprint
  out = bootsamples
  method = urs
  samprate = 1
  reps = 1000;
run;

proc reg data=bootsamples plot=none outest=myestimates noprint;
  by replicate;
  model lnbox = lnbudget rrating;
run;

proc means data=myestimates;
run;



/* block bootstrap */

data a;
  infile 'c:\temp\fathers.csv' delimiter=',' firstobs=2;
  input id year steal female age black hisp msa work student dadgone;  
run;

proc sort;
  by id year;
run;

proc panel data=a plot=none;
id id year;
model steal = dadgone age female black hisp msa work student / fixone;
run;

proc surveyselect data=a seed=10101 noprint
  out = bootsamples
  method = urs
  samprate = 1
  reps = 1000;
  samplingunit id;
run;

proc panel data=bootsamples plot=none outest=myestimates noprint;
  by replicate;
  id id year;
  model steal = dadgone age female black hisp msa work student / fixone;
run;

proc means data=myestimates;
run;
