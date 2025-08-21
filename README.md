# uniprot-to-gene-symbol-using-biomaRt
**Summary:**

R scripts using biomaRt to convert protein UniProt accession numbers into HGNC-approved gene symbols

**Introduction:**

Sometimes we need to convert protein UniProt accession numbers into gene symbols. A reliable way to do this, is by using the biomaRt R package. You can find full documentation here:

[biomaRt in Bioconductor](https://bioconductor.org/packages/release/bioc/html/biomaRt.html)

In my case, I was working with phosphoproteomics data generated in our lab. To identify which kinases might be responsible for the differential abundance of phosphoproteins, I planned to use Kinase Enrichment Analysis 3 (KEA3) (https://maayanlab.cloud/kea3/). This tool infers upstream kinases whose putative substrates are overrepresented in a user-provided list of proteins or differentially phosphorylated proteins.

In the KEA3 interface, under the section **"Input a list of proteins"**, the help note specifies that KEA3 supports HGNC-approved gene symbols. Since my data consisted of UniProt protein identifiers, I first converted them into HGNC-approved gene symbols before using KEA3.

Here, I will show you step-by-step how to accompolish this task in R:

**Step 1: Set and verify your working directory**

  - Check your current working directory:
```r
getwd()
```

- Change it (replace the path with your own). On Windows you can use forward slashes or double backslashes:
```r
setwd(C:\\Users\\xnikpa\\biomaRt)

# or 

setwd("C:/Users/xnikpa/biomaRt")
```

- Verify the change:
```r
getwd()
```

**Step 2: Install and load necessary R packages**

For this task, we need two R packages: readxl (to read Excel files) and biomaRt (to convert UniProt IDs to gene symbols).

- Install packages (only once per computer):
```r
install.packages("readxl")
install.packages("biomaRt")
```


- Load packages (every time you start R):
```r
library(readxl)
library(biomaRt)
```

**Step 3: Load your data file**

You can load either an Excel file or a CSV file depending on your dataset format. It is assumed that you have already copied your file into the current working directory set in the previous step.

- Loading an Excel file (.xlsx):

```r
# Load an Excel file (example)
my_data <- read_excel("your_file.xlsx", sheet = "Sheet1")

# View the data
View(my_data)
```

- Loading a CSV file (.csv):

```r
# Load a csv file (example)
my_data <- read.csv("your_file.csv")

# View the data
View(my_data)
```

**Step 4: Using biomaRt**

- Connecting to Ensembl using biomaRt:

```r
#First Connect to Ensembl using biomaRt
ensembl <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")
```

- Get HGNC gene symbols for your proteins:

```r
converted_output <- getBM(
  filters = "uniprotswissprot",
  attributes = c("uniprotswissprot", "hgnc_symbol"),
  values = unique(my_data$here you must write your column name),
  mart = ensembl
)
```
- Save outputs in csv format

```r
write.csv(converted_output, "converted_output.csv", row.names = FALSE)
```

**Step by step explanation of above codes:**

`filters = "uniprotswissprot"`

Tells biomaRt what kind of IDs you are providing. Here, you’re inputting UniProt IDs.

`attributes = c("uniprotswissprot", "hgnc_symbol")`

Specifies what you want returned from BioMart:

- uniprotswissprot → the original UniProt ID.

- hgnc_symbol → the corresponding gene symbol (HGNC-approved).

`values = unique(my_data$<your_column_name>)`

Provides the actual list of IDs to convert.

my_data is your data frame, and <your_column_name> should be replaced with the column containing UniProt IDs.

unique() ensures no duplicates are queried, which speeds up the request.

`mart = ensembl`

Specifies the BioMart database to use (usually useMart("ensembl", ...) assigned to ensembl).

`converted_output <- ...`

Saves the result as a data frame called converted_output.

The data frame will have two columns:

- uniprotswissprot → your input IDs

- hgnc_symbol → converted gene symbols

So, with these simple steps, we can convert UniProt protein IDs into HGNC gene symbols.

# Important note

For convenience, I have provided an example dataset in Excel **(your_file.xlsx)** along with ready-to-use R scripts **(uniprot-to-gene-symbol-using-biomaRt.R)** to perform the conversion. You can download these files and run the code directly. All these are in **data** folder in this repository.

I have also included the expected output file there **(converted_output.csv)** so you can compare your results.