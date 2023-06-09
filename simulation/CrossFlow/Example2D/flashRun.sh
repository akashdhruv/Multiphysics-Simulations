# chdir into working directory
cd $JobWorkDir

if [[ $SiteName == "summit" ]]; then

	echo Calculating resources for $SiteName

	# this sets up some variables to run jsrun,
	# with 6 resource sets per node,
	# and 7 MPI ranks per resource set.
	#
	export NNODES=$(($(cat $LSB_DJOB_HOSTFILE | uniq | wc -l) - 1))
	export NCORES_PER_NODE=42
	export NGPU_PER_NODE=6
	export NRS_PER_NODE=6
	export NMPI_PER_RS=7
	export NCORES_PER_RS=$(($NCORES_PER_NODE / $NRS_PER_NODE))
	export NCORES_PER_MPI=$(($NCORES_PER_RS / $NMPI_PER_RS))
	export NRS=$(($NNODES * $NRS_PER_NODE))
	export OMP_NUM_THREADS=1

	echo Running on $SiteName

	stdbuf -o0 jsrun -n ${NRS} \
		-r ${NRS_PER_NODE} \
		-a ${NMPI_PER_RS} \
		-c ${NCORES_PER_RS} \
		-b packed:${NCORES_PER_MPI} \
		-d packed \
		$JobWorkDir/job.target
else

	echo Running on $SiteName
	mpirun job.target
fi
