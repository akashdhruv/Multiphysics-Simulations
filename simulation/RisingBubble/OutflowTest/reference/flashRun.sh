# Run the actualy job using this target script
cd $JobWorkDir && mpirun -n 5 $JobWorkDir/job.target
