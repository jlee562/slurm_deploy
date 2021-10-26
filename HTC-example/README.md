HTC Example d3zslat
===================

Static-compiled computational fluid dynamic code that was run on OSG for over
one million hours of compute time. Publication is under review.

The HTC example provided here is relatively simple: there are no job
dependencies and when the submitted simulation is complete the various runs are
assumed to be converged. The runs are fully independent and are parameterized
by a number of nondimensional parameters, i.e. 

  Parameter         | alias | values
  -----------------:|:-----:|:--------------------------------------
  Aspect Ratio      |  NONE | set to "short-aspect" for this example
  Prandtl  Number   |   Pr  | set to 7
  Buoyancy Number   |   Rn  | ranges from 10 to 100,000 here
  Forcing Frequency |   o   | ranges from 0.5 to 0.9 here
  Forcing Amplitude |   a   | ranges from 0.01 to 0.05 here

These values taken together create a simulation directory and simulation
prefix. For example, consider Pr=7e0, Rn=1e1, o=5e-1, and a=1e-2, then the
simulation would be done in directory

    runs0/short-aspect/Pr7e0/Rn1e1/o5e-1/a1e-2/

with prefix (m,n,r, and np describe spatial x,y,z and temporary discretization):

    Rn1e1_Pr7e0_o5e-1_a1e-2_m80_n80_r80_np400

generating files:

    runs0/short-aspect/Pr7e0/Rn1e1/o5e-1/a1e-2/
     |- Rn1e1_Pr7e0_o5e-1_a1e-2_m80_n80_r80_np400_00000
     |- Rn1e1_Pr7e0_o5e-1_a1e-2_m80_n80_r80_np400_00001
     |- Rn1e1_Pr7e0_o5e-1_a1e-2_m80_n80_r80_np400_00002
     |- Rn1e1_Pr7e0_o5e-1_a1e-2_m80_n80_r80_np400_00003
     |- Rn1e1_Pr7e0_o5e-1_a1e-2_m80_n80_r80_np400_00004
     |- Rn1e1_Pr7e0_o5e-1_a1e-2_m80_n80_r80_np400_00005
     |- Rn1e1_Pr7e0_o5e-1_a1e-2_m80_n80_r80_np400_00006
     |- Rn1e1_Pr7e0_o5e-1_a1e-2_m80_n80_r80_np400_00007
     |- Rn1e1_Pr7e0_o5e-1_a1e-2_m80_n80_r80_np400_00008
     |- Rn1e1_Pr7e0_o5e-1_a1e-2_m80_n80_r80_np400_00009   # These are restart/checkpoint files
     |- timing_Rn1e1_Pr7e0_o5e-1_a1e-2_m80_n80_r80_np400  # This is a timing file
     |- ts_Rn1e1_Pr7e0_o5e-1_a1e-2_m80_n80_r80_np400      # This is a binary time-series file
 
Timing information
------------------

When a run completes (or the simulation buffer "buffs"), timing information
will be printed to a run's `timing_<prefix>` file, where `<prefix>` is a string
tokenizing the simulations parameters. 

For example, consider Pr=7e0, Rn=1e1, o=5e-1, and a=1e-2, then the simulation
timing file has relative path

    runs0/short-aspect/Pr7e0/Rn1e1/o5e-1/a1e-2/timing_Rn1e1_Pr7e0_o5e-1_a1e-2_m80_n80_r80_np400

This timing file has three columns. The first column describes the number of
time steps between the timing calculation. The second column provides the total
time since the last timing calculation. The final column proves the average time 
per time step.

### Benchmarking ###

Use the final column in the timing file to gauge the average time per time step.

Run this example
----------------

    ./sbin/generate-cases-to-run
    sbatch -a 1-$(wc -l < cases/cases-to-run) short-aspect-htc-job.sh runs1




