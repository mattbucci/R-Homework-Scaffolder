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
