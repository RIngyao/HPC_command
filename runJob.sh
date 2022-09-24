#!/bin/sh
#PBS -q srlabq
#PBS -e err.out
#PBS -o out.out
#PBS -m abe
cd $PBS_O_WORKDIR
###double checking the parameters: not really required
if [ -n "$module" ]
##user has provided module and command to run
then
    ####convert to lowercase
    module_l=$(echo $module | awk '{print tolower($0)}')
    ####cheking the input module and loading
    case $module_l in
    ####start of case 
        multiqc | python | anaconda| anaconda-2022)  module load Anaconda-2022;;
        bedtools) module load bedtools;;
        bemtools | bemtools-2.5.2) module load bemtools-2.5.2;;
        bismark | bismark-0.22.3) module load Bismark-0.22.3;;
        bowtie | bowtie-1.3.1) module load bowtie-1.3.1;;
        bowtie2 | bowtie2-2.2.4) module load bowtie2-2.2.4;;
        bsmap |bsmap-2.4) module load bsmap-2.4;;
        bwa | bwa-0.75) module load Bwa-0.75;;
        bwamem2 | bwa-mem2) module load bwa-mem2;;
        cleaveland | cleaveland4) module load CleaveLand4;;
        fastqc) module load fastqc;;
        featurecounts) module load featurecounts;;
        gatk | gatk-4.2.6.1) module load gatk-4.2.6.1;;
        hisat2-2.2.1 | hisat2) module load hist2-2.2.1;;
        maq | maq-0.7.0) module load Maq-0.7.0;;
        methyldackel | methydackel) module load MethyDackel;;
        methylextract | methylextract_1.8.1) module load MethylExtract_1.8.1;;
        mirprefer | mir-prefer) module load miR-PREFeR;;
        mirtrace) module load mirtrace;;
        perga) module load perga;;
        picard) module load picard;;
        qualimap | qualimap_v2.2.1) module load qualimap_v2.2.1;;
        rsem | rsem-1.2.19) module load Rsem-1.2.19;;
        samtools | samtools-1.1) module load Samtools-1.1;;
        seqmonk) export DISPLAY=:0.0
                module load SeqMonk;;
        shortstack) module load shortstack;;
        snpeff | snpeff-5.1) module load SnpEff-5.1;;
        star) module load star;;
        trimgalore | trimgalore-0.67) module load TrimGalore-0.67;;
        trimmomatic) module load Trimmomatic;;
        r | r-4.2.1) module load R-4.2.1;;
        *) echo Module not found. Check the available module and retry again.
            exit;;
    esac
    ###end of case
else 
    ##no module provided
    exit
fi ##end of if-else statment

if [ -n "$command" ]
 then
    #run the command
    $command
    
    #executed correctly?
    if [ $? -eq 1 ];then
        echo
        echo
        echo ........... Execution failed!...........
    fi
else
    echo
    echo
    echo No commands to run
    echo .........Terminated.............
    exit
fi
