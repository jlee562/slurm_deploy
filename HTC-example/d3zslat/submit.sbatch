#!/bin/bash
#SBATCH -t 0-4
#SBATCH -c 4
#SBATCH -o log/slurm.%A.%a.%j.out
#SBATCH --export=NONE

set -x

case_file="cases/cases-to-run"


taskid="$SLURM_ARRAY_TASK_ID"

[[ -n "$taskid" ]] || {
  echo No taskid passed, be sure to run this job as a slurm array
  exit 1
}
[[ -f "$case_file" ]] || {
  echo Case file passed: $case_file
  echo ... was not found
  exit 1
}

params=( $(sed -n ${taskid}p "$case_file" ) )

Rn="${params[0]}"
om="${params[1]}"
al="${params[2]}"

wd="runs/short-aspect/Pr7e0/Rn${Rn}/o${om}/a${al}"

mkdir -pv "$wd"

cp -v skel/* "$wd"
cd $wd

bash run.sh "${params[@]}"
