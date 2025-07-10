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

xnames = {"Intercept"} || xvars;
parnames = xnames;

startval = j(1,npar,0);
opt = {1 3};
tc = {. . . 1e-8 . . 1e-15};
stg=1;
call nlpqn(rc,parm,"poisson",startval,opt,,tc);
call nlpfdd(mlik,grad,hessian,"poisson",parm);
stg=2;
call nlpfdd(f,deriv,crosspr,"poisson",parm,nobs);
covar = inv(hessian)*(crosspr)*inv(hessian);
stderr = sqrt((vecdiag(covar))<>1e-30);
tstat = parm`/ stderr;
coeff = parm` || stderr || tstat;
info = nobs // npar // mlik;
rowinfo={'# OBSERVATIONS' '# PARAMETERS' 'LOG LIKELIHOOD'};
estcol ={'ESTIMATE' 'STD ERR' 'T-STAT'};
probname=concat("P(",yvars,")");
mattrib info rowname=rowinfo label={" "};
mattrib coeff rowname=parnames colname=estcol label={" "};
print / "POISSON MODEL";
print info;
print coeff;



finish main;


start poisson(parm) global(y,x,nobs,npar,stg);
	theta=exp((x*parm`)><100);
	liki = y#log(theta<>1e-30) - lgamma(y+1) - theta;
	lik = sum(liki);
	if stg=1 then return(lik); else return(liki);
finish poisson;


run main;
quit;

