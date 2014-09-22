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

	All <- function() {
		pp("Running All Problems", type = "heading")

		problems = getNamedFunctions(pattern="Problem",check=TRUE)
		print(problems)
		for(i in 1:length(problems)) {
			pp(paste("Running ",problems[i],sep=""), type= "heading")
			graphics.off()
			eval(parse(text = paste(problems[i], "()",sep="")))
			readline(prompt="Press [enter] to continue")
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

		return(list_of_names)
	}

