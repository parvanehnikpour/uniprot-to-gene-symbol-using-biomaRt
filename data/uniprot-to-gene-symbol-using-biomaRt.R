#Aim: convert protein UniProt accession numbers into gene symbols

#####################################################################
##########Step 1: Set and verify your working directory##############
#####################################################################

#checking working directory
getwd()

#Changing working directory (replace the path with your own)
setwd("C:\\Users\\xnikpa\\biomaRt")

#Re-checking working directory
getwd()

#####################################################################
#########Step 2: Install and load necessary R packages###############
#####################################################################

#Install packages (only once per computer)
install.packages("readxl")
install.packages("biomaRt")

#Load packages (every time you start R):
library(readxl)
library(biomaRt)

#####################################################################
#####################Step 3: Load your data file#####################
#####################################################################

# Load an Excel file (here: "your_file.xlsx") and specify the sheet containing your data (here:"Sheet1")
my_data <- read_excel("your_file.xlsx", sheet = "Sheet1")

# View the data
View(my_data)

# Load a csv file (example)-I have put a # at the beginning of next line, in case your file is csv, remove this #
#my_data <- read.csv("your_file.csv")

# View the data
View(my_data)

#####################################################################
##########################Step 4: Using biomaRt######################
#####################################################################

#First Connect to Ensembl using biomaRt
ensembl <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")

#Get HGNC gene symbols for your proteins.
# my_data: your data frame
# protein_ID: column containing UniProt protein IDs
converted_output <- getBM(
  filters = "uniprotswissprot",
  attributes = c("uniprotswissprot", "hgnc_symbol"),
  values = unique(my_data$protein_ID),
  mart = ensembl
)

# View the converted data
View(converted_output)

#Save outputs in csv format
write.csv(converted_output, "converted_output.csv", row.names = FALSE)
