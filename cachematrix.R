## cachematrix.R
## Matrix inversion is very costly computation. It should have advantages if ithe inverse
## matrix is stored rather than compute it repeatedly.
## The following two functions are for storing the calucated value of an inverse matrix
## in a cache to avoid recalcuating it repeatedly.

###########################################################################################
## makecacheMatrix function creates a special "matrix" object, which is a list containing 
##   four clousure functions that are for: setting the value of the matrix; getting the value 
##   of the matrix; set the value of the inverse matrix and getting the value of the mean
##
makeCacheMatrix <- function(x = matrix()) {
     ##definitions of  local variables
     ## invM: the inverse matrix that is stored in the cache
     ## x, y: input matrix
  
     invM <- NULL    # define and initiate invM
     
     set <- function(y) { #set function for setting value of input matrix
         x <<- y          ## store the input matrix into the cache
         invM <<- NULL    ## initiate invM 
     } ##end of set function
     
     get <- function(){ #get function for getting value of input matrix
         x              ## get the stored matrix 
     }    
     
     setinvMatrix <- function(invMatrix){  #setinvMatrix function
         invM <<- invMatrix    #store the calculated inverse matrix into cache
     }
     
     getinvMatrix <- function() {   #getinvMatrix fucntion
       invM                    # get the stored inverse matrix from cache
     }
     
     ##return a list of closure functions
     list(set = set, get = get, setinvMatrix = setinvMatrix, getinvMatrix = getinvMatrix)
  
} ## end of makeCacheMatrix function

###########################################################################################
## The cacheSolve function calculates the inverse matrix of the special "matrix" created 
## from the makeCacheMatrix function. 
## However, the cacheSolve function first checks whether the inverse matrix has already been 
## calculated. If so, it gets the stored value of inverse matrix from the cache via the 
## getinvMatrix function and skips the calculation. 
## Otherwise, it calculates the inverse matrix and then sets the value of the inverse matrix
##   into the cache via the setinvMatrix function.
##
cacheSolve <- function(x, ...) {
        ## definition of local variables:
        ## invM: the inverse matrix that is stored in the cache
        ## data: value of the given matrix
  
        invM <- x$getinvMatrix()   
        if(!is.null(invM)) {  # check whether inverse matrix has been caculated and stored in cache 
              # the value of the inverse matrix is in cache
              message("Getting cached data")  # print a message 
              return(invM)                    # return its value that is stored from cache,
        }                                     # skip the caculation
        
        ## the following is for the case: the inverse matrix has NOT been caculated
        data <- x$get()            ## to get the value of given matrix  
        message("Calculating the inverse matrix")
        invM <- solve(data, ...)   ## to calculate the inverse matrix via solve function
        x$setinvMatrix(invM)       ## to store the calculated value into cache
        invM                       ## return the calculated value
        
} ## end of cachesolve function

