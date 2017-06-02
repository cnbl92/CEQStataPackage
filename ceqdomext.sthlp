{smcl}
{* 04mar2017}{...}
{cmd:help ceqdomext} (beta version; please report bugs) {right:Rodrigo Aranda}
{hline}

{title:Title}

{p 4 11 2}
{hi:ceqdomext} {hline 2} Computes dominance indicators for CEQ extended income concepts for the "E17. Dominance" sheets of the CEQ Master Workbook 2016

{title:Syntax}

{p 8 11 2}
    {cmd:ceqdomext} {ifin} {weight} [{cmd:using} {it:filename}] [{cmd:,} {it:options}]{break}

{synoptset 29 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Income concepts}
{synopt :{opth m:arket(varname)}}Market income{p_end}
{synopt :{opth mp:luspensions(varname)}}Market income plus pensions{p_end}
{synopt :{opth n:etmarket(varname)}}Net market income{p_end}
{synopt :{opth g:ross(varname)}}Gross income{p_end}
{synopt :{opth t:axable(varname)}}Taxable income{p_end}
{synopt :{opth d:isposable(varname)}}Disposable income{p_end}
{synopt :{opth c:onsumable(varname)}}Consumable income{p_end}
{synopt :{opth f:inal(varname)}}Final income{p_end}

{syntab:Fiscal Interventions}
{synopt :{opth p:ensions(varlist)}}Contributory pension variables{p_end}
{synopt :{opth dtr:ansfers(varlist)}}Direct transfer variables{p_end}
{synopt :{opth dtax:es(varlist)}}Direct tax variables{p_end}
{synopt :{opth cont:ribs(varlist)}}Contribution variables{p_end}
{synopt :{opth su:bsidies(varlist)}}Subsidy variables{p_end}
{synopt :{opth indtax:es(varlist)}}Indirect tax variables{p_end}
{synopt :{opth health(varlist)}}Health variables{p_end}
{synopt :{opth educ:ation(varlist)}}Education variables{p_end}
{synopt :{opth other:public(varlist)}}Other public in-kind transfers{p_end}

{syntab:Survey information}
{synopt :{opth hs:ize(varname)}}Number of members in the household
	(should be used when each observation in the data set is a household){p_end}
{synopt :{opth hh:id(varname)}}Unique household identifier variable
	(should be used when each observation in the data set is an individual){p_end}
{synopt :{opth psu(varname)}}Primary sampling unit; can also be set using {help svyset:svyset}{p_end}
{synopt :{opth s:trata(varname)}}Strata (used with complex sampling desings); can also be set using {help svyet:svyset}{p_end}

{syntab:Export directly to CEQ Master Workbook (requires Stata 13 or newer)}
{synopt :{opth coun:try(string)}}Country{p_end}
{synopt :{opth surv:eyyear(string)}}Year of survey{p_end}
{synopt :{opth auth:ors(string)}}Authors of study{p_end}
{synopt :{opth scen:ario(string)}}Scenario{p_end}
{synopt :{opth gr:oup(string)}}Group{p_end}
{synopt :{opth proj:ect(string)}}Project{p_end}
{synopt :{opt open}}Automatically open CEQ Master Workbook with new results added{p_end}
{synoptline}		
{p 4 6 2}
{cmd:pweight} allowed; see {help weights}. Alternatively, weights can be specified using {help svyset}. 

{title:Required commands}
{cmd:ceqdomext} uses  {cmd:ksmirnov}, {cmd:domineq} from DASP, and {cmd:glcurve}.    
{title:Description}

{pstd} 
{cmd:ceqdomext} calculates the CEQ dominance estimations for the CEQ extended income concepts. Indicators include 
number of crossings between lorenz/concentration curves for extended income concepts. If there is zero 
crossing, the program estimates a K-Smirnov test between the two distributions.

{pstd}
The CEQ core income concepts include market income, market income plus pensions, net 
market income, gross income, taxable income, disposable income, consumable income, and final 
income. The variables for these income concepts, which should be expressed in local currency 
units (preferably {bf:per year} for ease of comparison with totals from national accounts), are 
indicated using the {opth m:arket(varname)}, {opth mp:luspensions(varname)}, 
{opth n:etmarket(varname)}, {opth g:ross(varname)}, {opth t:axable(varname)}, 
{opth d:isposable(varname)}, {opth c:onsumable(varname)}, {opth c:onsumable(varname)}, 
and {opth f:inal(varname)} options. 

{pstd}
The extended income concepts are created from the CEQ core income concepts, specified with the options 
{opth m:arket(varname)}, {opth mp:luspensions(varname)}, {opth n:etmarket(varname)}, {opth g:ross(varname)}, 
{opth t:axable(varname)}, {opth d:isposable(varname)}, {opth c:onsumable(varname)},
{opth c:onsumable(varname)}, and {opth f:inal(varname)}, and the fiscal interventions. Note that each 
fiscal intervention option takes a {varlist} that can (and often should) have greater than one 
variable: the variables provided should be as disaggregated as possible. For example, there might be 
survey questions about ten different direct cash transfer programs; each of these would be a variable, 
and all ten variables would be included with the {opth dtr:ansfers(varlist)} option. Contributory 
pensions are specified by {opth p:ensions(varlist)}, direct transfers by {opth dtr:ansfers(varlist)}, 
direct taxes (not including contributions) by {opth dtax:es(varlist)}}, contributions (including 
variables for both employer and employee contributions if applicable) by {opth co:ntribs(varlist)}, 
indirect subsidies by  {opth su:bsidies(varlist)}, indirect taxes by {opth indtax:es(varlist)}, health 
benefits by {opth health(varlist)}, educaiton benefits by {opth educ:ation(varlist)}, other public 
in-kind benefits by {opth other:public(varlist)}, health user fees by {opth userfeesh:ealth(varlist)},
education user fees by {opth userfeese:duc(varlist)}, and other public user fees by
{opth userfeeso:ther(varlist)}. Tax and contribution variables may be saved as 
either positive or negative values, as long as one is used consistently for all tax and contribution 
variables. The same goes for user fees variables.

{pstd}
The income and fiscal intervention variables should be expressed in household per capita or per adult equivalent 
terms, regardless of whether the data set being used is at the household or individual level. Hence, they should 
have the same per-person amount for each member within a household when using individual-level data.

{pstd}
If the data set is at the individual level (each observation is an individual), the variable with the 
identification code of each household (i.e., it takes the same value for all members within a 
household) should be specified in the {opth hh:id(varname)} option; the {opth hs:ize(varname)} option 
should not be specified. If the data set is at the household level, the number of members in the 
household should be specified in {opth hs:ize(varname)}; the {opth hh:id(varname)} option should not be 
specified. In either case, the weight used should be the household sampling weight and should {it:not} 
be multiplied by the number of members in the household since the program will do this multiplication 
automatically in the case of household-level data.  

{pstd}
There are two options for including information about weights and survey sample design for accurate
estimates and statistical inference. The sampling weight can be entered using  
{weight} or {help svyset}. Information about complex stratified sample designs can also be entered 
using {help svyset} since {cmd:ceqdomext} automatically uses the information specified using {help svyset}. 
Alternatively, the primary sampling unit can be entered using the {opth psu(varname)} option and 
strata can be entered using the {opth s:trata(varname)} option. {cmd:domineq} requires that survey design is 
entered using {help svyset} or through the {cmd:ceqdomext}  program.  

{pstd}
Results are automatically exported to the CEQ Master Workbook Output Tables if {cmd:using} {it:filename} 
is specifed in the command, where {it:filename} is the Master Workbook. Exporting directly to the Master 
Workbook requires Stata 13 or newer. The Master Workbook populated with results from {cmd:ceqdomext} can be automatically opened if the {opt open} 
option is specified (in this case, {it:filename} cannot have spaces). Results are also saved in 
matrices available from {cmd:return list}. 

{title:Examples}

{pstd}Individual-level data (each observation is an individual){p_end}
{phang} {cmd:. ceqdomext [pw=w] using C:/Output_Tables.xlsx, hhid(hh_code) psu(psu_var) strata(stra_var) psu(psu_var) strata(stra_var) ///}{p_end}
{phang} {cmd:. m(ym) mplusp(ymplusp) n(yn) g(yg) t(yt) d(yd) c(yc) f(yf) pens(pensions) 	dtax(income_tax property_tax) 	///}{p_end}
{phang} {cmd:. cont(employee_contrib employer_contrib) 	dtransfer(cct noncontrip_pens unemployment scholarships food_transfers)  ///}{p_end}
{phang} {cmd:. indtax(vat excise) 	subsidies(energy_subs) 	health(net_basic_health net_preventative_health net_inpatient_health) 	///}{p_end}
{phang} {cmd:. education(net_daycare net_preschool net_primary net_secondary net_tertiary) reps(50) open}{p_end}

{pstd}Household-level data (each observation is a household){p_end}
{phang} {cmd:. ceqdomext [pw=w] using C:/Output_Tables.xlsx, hsize(members) psu(psu_var) strata(stra_var) psu(psu_var) strata(stra_var)  ///}{p_end}
{phang} {cmd:. m(ym) mplusp(ymplusp) n(yn) g(yg) t(yt) d(yd) c(yc) f(yf) pens(pensions) 	dtax(income_tax property_tax) 	///}{p_end}
{phang} {cmd:. cont(employee_contrib employer_contrib) 	dtransfer(cct noncontrip_pens unemployment scholarships food_transfers)   ///}{p_end}
{phang} {cmd:. indtax(vat excise) 	subsidies(energy_subs) 	health(net_basic_health net_preventative_health net_inpatient_health) 	///}{p_end}
{phang} {cmd:. education(net_daycare net_preschool net_primary net_secondary net_tertiary) reps(50) open}{p_end}

{title:Saved results}

Pending

{title:Authors}

{p 4 4 2}Rodrigo Aranda, Tulane University, raranda@tulane.edu


{title:References}

{pstd}Commitment to Equity (CEQ) {browse "http://www.commitmentoequity.org":website}.{p_end}

{phang}
Lustig, N. and S. Higgins. 2013. "Commitment to Equity Assessment (CEQ): Estimating the Incidence of Social Spending, Subsidies and Taxes Handbook." {browse "http://www.commitmentoequity.org/publications_files/Methodology/CEQWPNo1%20Handbook%20Edition%20Sept%202013.pdf":CEQ Working Paper 1.}{p_end}

