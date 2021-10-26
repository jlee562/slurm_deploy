#alpha='1e-4'
#alpha='1e-3'
#alpha='1e-2'
alpha='2e-2'
omega='87e-2'
tmesh=100
xmesh=100
rstrt="Rn3e5_o87e-2_a2e-2_m100_n100_r100_np100_00039"
prfix=Rn3e5_o${omega}_a${alpha}_m${xmesh}_n${xmesh}_r${xmesh}_np${tmesh}_Kx
pmode=2
params=(
3e5       # Rn
$omega    # omega
$alpha    # alpha
$xmesh    # xmesh m
$xmesh    # xmesh n
$xmesh    # xmesh r
$tmesh    # tmesh 
6e0       # doubled aspect ratio z 2*h/l 
1000      # number of forcing periods
$pmode    # program mode 
0         # initial index for new restart 
$rstrt    # restart 
$prfix    # prefix
.         # results directory 
)

. sim_srun_lib.sh

ulimit -s unlimited
export OMP_NUM_THREADS=8
export MKL_NUM_THREADS=4

#sleep 1h
#cp ts_Rn3e5_o87e-2_a2e-2_m100_n100_r100_np100 bak/
"$exe" < <(sym_in_gen "${params[@]}")
