Pr='7e0'
Rn="$1"
omega="$2"
alpha="$3"
fpnum="$4"
tmesh="400"
xmesh=80
rstrt="REST"
prfix="Rn${Rn}_Pr${Pr}_o${omega}_a${alpha}_m${xmesh}_n${xmesh}_r${xmesh}_np${tmesh}"
pmode=2
rsnum=0
params=(
$Rn       # Rn
$Pr       # Prandtl
$omega    # omega
$alpha    # alpha
$xmesh    # xmesh m
$xmesh    # xmesh n
$xmesh    # xmesh r
$tmesh    # tmesh 
6e0       # doubled aspect ratio z 2*h/l 
$fpnum    # number of forcing periods
$pmode    # program mode 
$rsnum    # initial index for new restart 
$rstrt    # restart 
$prfix    # prefix
.         # results directory 
)

. sim_srun_lib.sh

ulimit -s unlimited
export OMP_NUM_THREADS=$(nproc)
export MKL_NUM_THREADS=$(nproc)

set -euo pipefail

"$exe" < <(main_in_gen "${params[@]}")
