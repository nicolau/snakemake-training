SAMPLES=["A", "B"] # Need fix it

mkdir -p results
for sample in ${SAMPLES[@]}; do
    cat input-files/${sample}.txt > results/output_${sample}.txt
    tr '[:lower:]' '[:upper:]' < results/output_${sample}.txt > results/uppercase_output_${sample}.txt
done

cat results/uppercase_output_*.txt > results/aggregate_files.txt
