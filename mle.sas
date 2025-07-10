data a;
infile 'C:\temp\mle.csv' delimiter=',' firstobs=2;
input totchr docvis supp;
run;

proc print data=a(obs=15);
run;


PROC IML;
start main;


yvars = {docvis}; 
xvars = {totchr supp};

use _last_ var yvars;
read all into y;
use _last_ var xvars;
read all into x;

npar = ncol(xvars)+1; 
nobs = nrow(x);
x = j(nobs,1,1) || x;

startval = j(1,npar,0);
opt = {1};
call nlpqn(rc,parm,"poisson",startval,opt);
print parm;


finish main;


start poisson(parm) global(y,x,nobs,npar);
	theta = exp((x*parm`)><100);
	liki = y#log(theta<>1e-30) - lgamma(y+1) - theta;
	lik = sum(liki);
	return(lik);
finish poisson;



run main;
quit;

