# Math 180
# Matthew Bucci

# Utilities


	# Dec
	dec = function(x) {
		eval.parent(substitute(x <- x - 1))
	}

	# Inc
	inc = function(x) {
		eval.parent(substitute(x <- x + 1))
	}

	# Quantative or Qualitative
	quant_or_qual = function(x) {
		return (ifelse(x=="factor", "qualatative", "quantatative"))
	}

	# Pretty Print
	pp = function(x, type = c("normal","heading")) {
		# Defaults
			type = match.arg(type)
			if(length(type) > 1) {type = "normal"}
			top_padding = 0
			bottom_padding = 0

		# Adjust Formatting per type
			if(type == "normal") {
				# keep defaults
			}

			if(type == "heading") {
				top_padding = 1
				bottom_padding = 0
			}

		# Print it
			while(top_padding > 0) {
				cat("\n")
				dec(top_padding)
			}

			# cat can't handle these types
			if(class(x) == "data.frame" || class(x) == "matrix" ) {
				print(x)
			} else if(class(x) == "list") {
				print(as.data.frame(x))
			} else {
				cat(x, "\n")
			}

			while(bottom_padding > 0) {
				cat("\n")
				dec(bottom_padding)
			}
	}

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
