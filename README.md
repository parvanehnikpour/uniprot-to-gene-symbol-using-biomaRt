# uniprot-to-gene-symbol-using-biomaRt
R script using biomaRt to convert protein UniProt accession numbers into gene symbols

Sometimes we need to convert protein UniProt accession numbers into gene symbols. A reliable way to do this is by using the biomaRt R package. You can find full documentation here:

[biomaRt in Bioconductor](https://bioconductor.org/packages/release/bioc/html/biomaRt.html)

In my case, I was working with phosphoproteomics data generated in our lab. To identify which kinases might be responsible for the differential abundance of phosphoproteins, I planned to use Kinase Enrichment Analysis 3 (KEA3) (https://maayanlab.cloud/kea3/). This tool infers upstream kinases whose putative substrates are overrepresented in a user-provided list of proteins or differentially phosphorylated proteins.

In the KEA3 interface, under the section **"Input a list of proteins"**, the help note specifies that KEA3 supports HGNC-approved gene symbols.

Here, I will guide you step-by-step how to accompolish this task in R:

  Setting and Verifying the Working Directory: By typing:
   
  ```R getwd()```
  
  You will check current working directory.
  
  Then if you need to change it, use: 
  
  ```R setwd(C:\\Users\\xnikpa\\biomaRt)```