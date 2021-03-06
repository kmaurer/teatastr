#' Lady tasting tea p-values
#'
#' Function for looking up ltt probabilities
#'
#' @param M is the number of plot pairs in a line-up
#' @param x the number of incorrect choices
#'
#' @return lady tasting tea p-value
#' @export
#'
#' @examples
ltt=function(M,x) {
  pvalue=0
  for(i in 0:x){
    pvalue=pvalue+choose(M,(M-i))*choose(M,i)/choose(M*2,M)
  }
  pvalue
}

#' Organize lady tasting tea p-values into TeX table
#'
#' @param M_range numeric vector with the range of possible plot pairs in a line-up
#' @param x_range numeric vector with the range for number of incorrect choices
#'
#' @return TeX table
#' @export
#'
#' @examples
#' tea_pval_table(5:10,0:2)
tea_pval_table = function(M_range=5:10,x_range=0:3){
  tab = expand.grid(M=M_range,x=x_range)
  tab$pvals = sapply(1:nrow(tab), function(i) ltt(tab$M[i], tab$x[i]))
  tab_wide = spread(tab, key=x, value=pvals)
  names(tab_wide)[1] = "number of pairs / number incorrect"
  print(xtable(tab_wide, digits=5), include.rownames=FALSE)
}


#' Generate data from quadratic curve
#'
#' Function to simulate from quadratic curve
#'
#' @param n sample size
#' @param b0 intercept of curve
#' @param b1 first order poly term
#' @param b2 second order poly term
#' @param sd standard deviation for random noise around curve
#' @param range range of x values over which to generate data
#'
#' @return dataframe of simulated x,y pairs
#' @export
#'
#' @examples
#' curve_dat <- sim_curve(n=100, b0=0, b1=0, b2=.3, sd=2.6, range=c(-3,3))
#' plot(curve_dat)
#' summary(lm(y ~ I(x^2), data=curve_dat))
sim_curve <- function(n, b0, b1, b2, sd=1, range=c(-3,3)){
  x = runif(n, range[1], range[2])
  y = b0 + x*b1 + x^2*b2 + rnorm(n, 0, sd)
  return(data.frame(x,y))
}


