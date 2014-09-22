# Magic - There be Dragons Here

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

	# Take Problem in the config format and apply proper formatting
	problemToText <- function(problem) {
		if (problem$Part == "_") {
			return(paste("pp(\"", problem$Question, "\", \"heading\")", sep=""))
		} else {
			return(paste("pp(paste(\"Part \",\"", problem$Part, "\", \") \",\"", problem$Question,"\",sep=\"\"))", sep=""))
		}
	}

	generateSection <- function(sectionName, Problems) {
		
		fileName = paste("Section_", sectionName, ".R", sep="")
		fileConn = file(fileName)


		text = list()
		# Assumes Section Problems are pre sorted, if you enter the problems backwards, that's your issue
		for (i in 1:length(Problems[,1])) {
			problemtext = problemToText(Problems[i,])
			text[[i]] = problemtext
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
		lapply(Sections, function(x){generateSection(x,config[which(config$Section==x),-1])})


		generateSummary(config)
		


	}