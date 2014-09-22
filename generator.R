# Magic - There be Dragons Here

	# Clear all memory
	rm(list=ls())

	# Set Working Directory to current file location
	this.dir <- dirname(parent.frame(2)$ofile) 
	setwd(this.dir) 

	# Get all those great functions
	source("util.r")

# Scaffolder 

	# Create a Directory, if already created ignore
	generateDirectory <- function(mainDir, subDir) {
		dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
	}

	# Part to text
	partToText <- function(part) {
		print(part$Part)
		if (part$Part == "_") {
			return(paste("\tpp(\"", part$Question, "\", \"heading\")", sep=""))
		} else {
			return(paste("\t\tpp(\"Part ",part$Part,") ", part$Question,"\")", sep=""))
		}
	}

	# Take Problem in the config format and apply proper formatting
	problemToText <- function(problem) {
		
		output = list()

		for (i in 1:length(problem[,1])) {
			part = problem[i,]

			if (part$Part == "_") {
				output[[length(output)+1]] = paste("Section_",part$Section,"_Problem_",part$Problem," <- function() {",sep="")
			}

			output[[length(output)+1]] = partToText(part)
		}

		output[[length(output)+1]] = "}\n"

		return(output)
	}

	generateSection <- function(sectionName, Problems) {
		
		fileName = paste("Section_", sectionName, ".R", sep="")
		fileConn = file(fileName)

		text = list()

		# Add in our utils
		text[[length(text)+1]] = "source(\"util.r\")\n"

		# Assumes Section Problems are pre sorted, if you enter the problems backwards, that's your issue
		for (i in 1:length(unique(Problems$Problem))) {
			Problem = Problems[which(Problems$Problem == unique(Problems$Problem)[i]),]
			problemtext = problemToText(Problem)
			text[[length(text)+1]] = problemtext
		}

		writeLines(unlist(text),fileConn)
		close(fileConn)

	}

	generateSummary <- function(config) {
		
		# RunAll.R
		# Display All Sections
		# Run All Sections
	}

	# This is the main generation function, given a correctly formatted config.txt file it can scaffold your entire project
	generateFromFile <- function(fileName = "config.txt") {

		config <- read.csv(fileName, sep="\t")

		# We'll need a place for all those great data sets
		generateDirectory(this.dir,"data")

		Sections <- unique(config$Section)

		# Fuck yea, functional programming
		lapply(Sections, function(x){generateSection(x,config[which(config$Section==x),])})


		generateSummary(config)

	}