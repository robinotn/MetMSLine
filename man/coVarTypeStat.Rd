% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/coVarTypeStat.R
\name{coVarTypeStat}
\alias{coVarTypeStat}
\title{automatic covariate (y-variable) type based univariate statistical test selection.}
\usage{
coVarTypeStat(peakTable = NULL, obsNames = NULL, coVariate = NULL,
  continuous = T, nMaxClasses = 3, minSampPerClass = 3, Logged = T,
  base = 2, MTC = "none")
}
\arguments{
\item{peakTable}{either a data.frame, full file path as a character string to a  .csv file of a peak table in the form observation (samples) in columns and
variables (Mass spectral signals) in rows. If argument is not supplied a GUI file selection window will open and a .csv file can be selected.}

\item{obsNames}{character vector of observation (i.e. sample/ QC/ Blank) names to identify appropriate observation (sample) columns.}

\item{coVariate}{numeric, character or factor vector of covariates (y-variables).}

\item{continuous}{default = TRUE, if TRUE continuous variables are treated as
such and correlation analysis is selected (spearman or pearson is selected
based on whether the data is log-transformed or not see Logged argument).
if FALSE continuous variables are split into a two sample variable.}

\item{minSampPerClass}{default =3, minimum number of samples for a unique class 
 else multiple class samples will be considered as continuous variables.
(N.B. at least 5 for Mann-Whitney-U)}

\item{Logged}{default = TRUE, has the data already been log transformed, if TRUE
parametric methods will be selected (i.e. t-test (two sample), ANOVA 
(three or more sample), pearson correlation) if FALSE then non-parametric methods 
will be selected (i.e. t-test (two sample), ANOVA (three or more sample), pearson 
correlation). NB. if residuals from \code{\link{batchAdj}} contain negative
values then the negatives will be shifted to the right with a constant value
 with the smallest lowest value equal to one prior to fold change calculation.}

\item{base}{numeric this will be used to exponentiate log transformed data
for mean/ median fold change calculation.}

\item{MTC}{Multiple Testing Correction default is "none", see \code{\link{p.adjust.methods}} for
details of options. ("holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr", "none")}
}
\value{
a named list (according to stat method selected) containing the 5 followning
    named elements :
    
    varType = type of variable identified.
    
    method = statistical method applied (either parametric or non-parametric 
    according to whether data log transformed).
    
    MTC = multiple testing correction method applied
    
    coVariate = the co-variate supplied, if continuous is False the high/low two sample
    variable created for any continuous variables will appear here.
     
    result = depending on type of variable supplied the result element will contain
    the following:
    
      1. "Continuous" 4 column data frame of:
       
                     i. adjusted/ multiple testing corrected p-/q-values 
                        (dependent on MTC method) 
                        
                     ii. raw p.value (from cor.test function) 
                     
                     iii. estimated correlation coefficient (from cor.test function) 
                     
                     iv. mean or median fold change value (dependent on whether
                         parametric or non-parametric method used). In the case
                         of continuous variables a two sample high-/low- variable 
                         is created (using the cut function) 
                         
      2. "two sample" 3 column data frame of:
       
                    i. adjusted/ multiple testing corrected p-/q-values 
                       (dependent on MTC method) 
                       
                    ii. raw p.value (from either t.test or wilcox.test function) 
                    
                    iii. mean or median fold change value (dependent on whether
                        parametric or non-parametric method used). 
                        
      3. "three or more sample" variable column (dependent on number of comparisons) 
           data frame of: 
                       
                    i. adjusted/ multiple testing corrected p-/q-values 
                    (dependent on MTC method).
                     
                    ii. raw p.value (from either ANOVA or wilcox.test function).
                     
                    iii - number pairwise class comparisons. 
                          mean or median fold change columns. 
                          All pairwise class comparisons of fold change are carried out. 
                          (dependent on whether parametric or non-parametric method used).  
                    
  raw p.values/ multiple testing corrected p-/q-values (dependent on method)
  and fold changes (if applicable).
  
  A class must contain a minimum number of samples to be considered.
  if continuous equals true continuous variables
}
\description{
function determines whether a co-variate is two sample, continuous or up to
n distinct classes (three or more sample) and selects the statistical method to apply accordingly.
}

