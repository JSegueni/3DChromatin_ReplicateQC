#!/bin/bash

usage(){
cat <<EOF
usage: `basename $0` options
Installs GenomeDISCO, HiCRep, HiC-Spector, QuASAR-Rep and QuASAR-QC.
OPTIONS
   -h               Show this message and exit
   --pathtopython   Path to python. DEFAULT: python
   --pathtor        Path to R. DEFAULT: R
   --rlib           Path to R libraries. DEFAULT=''
   --modules        Names of modules to be loaded. Comma-delimited. This can be used on computing clusters with shared installations, and will be loaded as 'module load modulename'. DEFAULT=''

EOF
}

ARGS=`getopt -o "h" -l "pathtopython:,pathtor:,rlib:,pathtobedtools:,modules:" -- "$@"`
#eval set -- "$ARGS"

#DEFAULTS
PATHTOPYTHON="python"
PATHTOR="R"
RLIB=""
MODULES=""

while [ $# -gt 0 ]; do
    case $1 in
    -h) usage; exit 1;;
    --pathtopython) PATHTOPYTHON=$2; shift 2;;
    --pathtor) PATHTOR=$2; shift 2;;
    --rlib) RLIB=$2; shift 2;;
    --modules) MODULES=$2; shift 2;;
    *) usage; exit 1;;
    esac          
done

#============================
# install location
#============================
dir_of_script="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
repo_dir=$(dirname ${dir_of_script})

#============================
# install different software
#============================
mkdir -p ${repo_dir}/software

#if any modules should be loaded, load them now
for modulename in $(echo ${MODULES} | sed 's/,/ /g');
do
    module load ${modulename}
done

pythondir=$(dirname ${PATHTOPYTHON} | sed 's/\/bin\/$//g' | sed 's/\/bin$//g' )
pythondir=${pythondir}/bin

#get genomedisco
#===================
git clone https://github.com/kundajelab/genomedisco.git ${repo_dir}/software/genomedisco
cd ${repo_dir}/software
${pythondir}/pip install --editable genomedisco

rlibtext=""
if [[ ${RLIB} != "" ]];
then
    rlibtext="--rlib ${RLIB}"
fi

modulestext=""
if [[ ${MODULES} != "" ]];
then
    modulestext="--modules ${MODULES}"
fi

#hicrep
#======
export R_LIBS="$(echo ${RLIB})"
export R_LIBS_USER=${R_LIBS}
if [[ ${RLIB} == "" ]];
then
    libtext=""
else
    libtext=",lib=\"${RLIB}\""
fi

#download hicrep from the paper
cd ${repo_dir}/software/
wget --no-check-certificate http://genome.cshlp.org/content/suppl/2017/10/06/gr.220640.117.DC1/Supplemental_hicrep_1.0.1.tar.gz 
cmd="${PATHTOR}script ${dir_of_script}/install_R_packages.R"
eval "${cmd}"

#HiC-Spector
#===========
git clone https://github.com/gersteinlab/HiC-spector ${repo_dir}/software/HiC-spector

#QuASAR
#======
${pythondir}/pip install h5py
${pythondir}/conda install -c anaconda mpi4py
${pythondir}/pip install hifive==1.5.6
#latest version is 1.5.6
#git clone https://github.com/bxlab/hifive ${repo_dir}/software/hifive
#cd ${repo_dir}/software/hifive
#git checkout v1.5.4
#${pythondir}/python setup.py clean
#${pythondir}/python setup.py install

#==================
#make a bashrc file
#==================
mkdir -p ${repo_dir}/configuration_files
bashrc_file=${repo_dir}/configuration_files/bashrc.configuration

#add any module load commands
for modulename in $(echo ${MODULES} | sed 's/,/ /g');
do
    echo "module load ${modulename}" >> ${bashrc_file}
done

#point to R libraries
if [[ ${RLIB} != "" ]];
then
    echo "export R_LIBS=\"$(echo ${RLIB})\"" >> ${bashrc_file}
    echo "export R_LIBS_USER="'$'"{R_LIBS}" >> ${bashrc_file}
fi

echo "pathtor=${PATHTOR}" >> ${bashrc_file}