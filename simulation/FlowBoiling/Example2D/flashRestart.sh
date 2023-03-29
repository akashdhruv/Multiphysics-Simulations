# cache the value of current directory
NodeDir=$(realpath .)

cd $JobWorkDir && cp $NodeDir/INS_Flow_Boiling_hdf5_chk_0000 .
