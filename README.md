# uniprot-to-gene-symbol-using-biomaRt
R script using biomaRt to convert protein UniProt accession numbers into gene symbols

Sometimes we need to convert protein UniProt accession numbers into gene symbols. A reliable way to do this is by using the biomaRt R package. You can find full documentation here:

[biomaRt in Bioconductor](https://bioconductor.org/packages/release/bioc/html/biomaRt.html)

In my case, I was working with phosphoproteomics data generated in our lab. To identify which kinases might be responsible for the differential abundance of phosphoproteins, I planned to use Kinase Enrichment Analysis 3 (KEA3) (https://maayanlab.cloud/kea3/). This tool infers upstream kinases whose putative substrates are overrepresented in a user-provided list of proteins or differentially phosphorylated proteins.

In the KEA3 interface, under the section **"Input a list of proteins"**, the help note specifies that KEA3 supports HGNC-approved gene symbols.

Here, I will guide you step-by-step how to accompolish this task in R:

**Step 1: Set and verify your working directory**

  - Check your current working directory:

    `getwd()`

- Change it (replace the path with your own). On Windows you can use forward slashes or double backslashes:

    `setwd(C:\\Users\\xnikpa\\biomaRt)`

    or 

    `setwd("C:/Users/xnikpa/biomaRt")`

- Verify the change:
  
     `getwd()`

**Step 2: Install and Load Necessary Packages**

For this task, we need two R packages: readxl (to read Excel files) and biomaRt (to convert UniProt IDs to gene symbols).

- Install packages (only once per computer):
  
    `install.packages("readxl")`

    `install.packages("biomaRt")`

- Load packages (every time you start R):
  
    `library(readxl)`
    
    `library(biomaRt)`