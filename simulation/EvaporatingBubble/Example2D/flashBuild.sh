# cache the value of current working directory
NodeDir=$(realpath .)

# run Flash-X setup
cd $FLASHX_HOME && ./setup $FlashOptions

# compile the simulation and copy files
cd $FLASHX_HOME/object && make -j && cp flashx $NodeDir/

# copy AMReX configuration
cd $AMREX2D_HOME/lib/pkgconfig && cp amrex.pc $NodeDir/

# chdir into node directory and do clean up
cd $NodeDir #&& rm -rf $FLASHX_HOME/object
