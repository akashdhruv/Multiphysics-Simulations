# Run the actualy job using this target script
cd $JobWorkDir && mpirun -n 10 $JobWorkDir/job.target
