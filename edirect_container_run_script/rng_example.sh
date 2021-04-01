# echo "PATH=$PATH:/mnt/HA/groups/eces436sp14Grp/edirect; export PATH" >> ~/.bash_profile; source ~/.bash_profile
# run this file by executing the name and piping out to file, e.g.: ./get_16S_from_pyogenes.sh > rRNAs_v2.fna

#Assign the Accession ID of the genome to a variable
acc_id=`esearch -db nuccore -query "16S rRNA[gene] AND streptococcus[ORGN] AND Manfredo AND genome" | efetch -format acc`

# Get the features from this genome
esearch -db nuccore -query "16S rRNA[gene] AND streptococcus[ORGN] AND Manfredo AND genome"| efetch -format ft | \

# print the gene feature line and the line after that, which will give what type of gene and the indices
grep -A 1 --no-group-separator gene | \

# Is this a 16S rRNA gene? If yes, just print the indice line 
awk '/16S rRNA/{x = NR + 1}NR == x' | \

# If the order of the indices is backwards, then get the minus strand, otherwise stay forward and print the indices and strand orientation
awk '{if ($1>$2) thestrand=2; else thestrand=1; print $1 "\t" $2 "\t" thestrand}' | \

# This will get the sequence using each of the indices and strand orientation and output it to rRNAs_v2.fna file
xargs -n 3 sh -c 'efetch -db nucleotide -format fasta -id '"$acc_id"' -strand "$2" -seq_start "$0" -seq_stop "$1"'

