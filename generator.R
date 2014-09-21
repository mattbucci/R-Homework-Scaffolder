# Magic - There be Dragons Here

	# Set Working Directory to current file location
	this.dir <- dirname(parent.frame(2)$ofile) 
	setwd(this.dir) 


# Depedendencies - This File Will include it's own depedencies in order to make it extremely portable

	###  HWUtility.R  ###

	## This is a set of utility functions that assist in manipulating the namespace of R functions

	## Gets all functions in global environment that have the word "problem" in their name
	## If you are reading this source code: the ability to change the pattern was intentionally left undocumented in hwhelp()
	## Use this feature at your own risk.
	getNamedFunctions <- function(pattern="problem",check=TRUE) {

		has_target_string <- function(x) grepl(pattern, x)

		list_of_names <- Filter(has_target_string, ls(envir=.GlobalEnv)) #get list of function names that match pattern

		function_list = lapply(list_of_names, FUN=get) #get function args and place into a list

		#Check to make sure the no-arguments requirement is met
		if(check){
			## Check to make sure the functions in the list match our expectations
			has_args <- function(x) if (length(as.list(formals(x))) == 0) FALSE else TRUE
			function_has_args <- sapply(function_list, has_args) #A boolean vector

			if(any(function_has_args)){
			  problemfuncs <- list_of_names[which(function_has_args)]
			  stop("Some functions do not satisfy the zero-args requirement. See TODO: WHERE THE FUCK DO I LOOK FOR HELP? for more details.\n \
					Problem functions are:  ", problemfuncs )
			}
		}

		return(function_list)
	}





# Scaffolder 

	generateDirectory <- function(mainDir, subDir) {
		dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
	}


	generateSection <- function(mainDir, subDir) {
		dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
	}

	generateSummary <- function(mainDir, subDir) {
		dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
	}

	# This is the main generation function, given a correctly formatted config.txt file it can scaffold your entire project
	generateFromFile <- function(fileName = "config.txt") {

		config <- read.csv(fileName, sep="\t")

	}