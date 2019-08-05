# Aout 2019
# Julie Blasquiz
# Creation des fichiers.txt des profiles (het, cov et miss) des contig

############################# Missingness F M : #############################
# Male :
while IFS= read -r file; do
vcftools --vcf $file --remove excluded_femelle_vcftools.txt --remove-filtered-all --min-alleles 2 --max-alleles 2 --missing-site --out $file >> all_contig.sh
sed '1d' $file.lmiss > $file.txt
done < "Y.txt"

for file in Contig*.noINDELs.ID.vcf.noRep.recode.vcf.txt
do
echo $file
awk -F' ' '{sum+=$6;} END{if(sum > 0)print $1,sum/NR,"M";}' $file >> Y_miss_male.txt
done

# Femelle :
while IFS= read -r file; do
vcftools --vcf $file --remove excluded_male_vcftools.txt --remove-filtered-all --min-alleles 2 --max-alleles 2 --missing-site --out $file >> all_contig.sh
sed '1d' $file.lmiss > $file.txt
done < "Y.txt"

for file in Contig*.noINDELs.ID.vcf.noRep.recode.vcf.txt
do
echo $file
awk -F' ' '{sum+=$6;} END{if(sum > 0)print $1,sum/NR,"F";}' $file >> Y_miss_femelle.txt
done

############################ Coverage M F : ############################
# Male :
while IFS= read -r file; do
vcftools --gzvcf $file --remove-filtered-all --remove excluded_femelle_vcftools.txt --min-alleles 2 --max-alleles 2 --recode --recode-INFO-all --out $file
done < "Y.txt"

for file in Contig*.noINDELs.ID.vcf.noRep.recode.vcf.recode.vcf
do
bcftools query -f '[\n%NR]' $file > $file.table
done

for file in Contig*.noINDELs.ID.vcf.noRep.recode.vcf.recode.vcf.table
do
awk -F' ' '{sum+=$1;} END{print FILENAME,sum/(NR-1),"M";}' $file >> coverage_norep_PASS_Y_male.txt
done

# Femelle :
while IFS= read -r file; do
vcftools --gzvcf $file --remove-filtered-all --remove excluded_male_vcftools.txt --min-alleles 2 --max-alleles 2 --recode --recode-INFO-all --out $file
done < "Y.txt"

for file in Contig*.noINDELs.ID.vcf.noRep.recode.vcf.recode.vcf
do
bcftools query -f '[\n%NR]' $file > $file.table
done

for file in Contig*.noINDELs.ID.vcf.noRep.recode.vcf.recode.vcf.table
do
awk -F' ' '{sum+=$1;} END{print FILENAME,sum/(NR-1),"F";}' $file >> coverage_norep_PASS_Y_femelle.txt
done

############################# het M F : #############################
# Male :
while IFS= read -r file; do
vcftools --gzvcf $file --remove-filtered-all --remove excluded_femelle_vcftools.txt --min-alleles 2 --max-alleles 2 --het --out $file >> all_contig.sh
sed '1d' $file.het > $file.txt
done < "Y.txt"

for file in Contig*.noINDELs.ID.vcf.noRep.recode.vcf.txt
do
awk -F' ' '{print ($4-$2)/$4 }' $file > $file.txt
done

for file in Contig*.noINDELs.ID.vcf.noRep.recode.vcf.txt.txt
do
awk -F' ' '{sum+=$1;} END{if(sum > 0) print FILENAME,sum/NR,"M"; else print FILENAME,0,"M"}' $file >> Y_het_male.txt
done

# Femelle :
while IFS= read -r file; do
vcftools --gzvcf $file --remove-filtered-all --remove excluded_male_vcftools.txt --min-alleles 2 --max-alleles 2 --het --out $file >> all_contig.sh
sed '1d' $file.het > $file.txt
done < "Y.txt"

for file in Contig*.noINDELs.ID.vcf.noRep.recode.vcf.txt
do
awk -F' ' '{print ($4-$2)/$4 }' $file > $file.txt
done

for file in Contig*.noINDELs.ID.vcf.noRep.recode.vcf.txt.txt
do
awk -F' ' '{sum+=$1;} END{if(sum > 0) print FILENAME,sum/NR,"F"; else print FILENAME,0,"F"}' $file >> Y_het_femelle.txt
done