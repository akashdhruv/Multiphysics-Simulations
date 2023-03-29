# Bash script for `jobrunner` to install HDF5

if [ "$HDF5_Enable" = true ]; then
	if [[ "$BuildHDF5" = true ]]; then
		# Setup HDF5
		if [ ! -d "HDF5" ]; then
			git clone git@github.com:HDFGroup/hdf5.git --branch develop HDF5 && cd HDF5
		else
			cd HDF5 && git checkout develop && git pull
		fi

		# checkout desired branch
		git checkout $HDF5_TAG

		# configure HDF5
		./autogen.sh
		./configure --enable-parallel --enable-fortran CC=mpicc CXX=mpicxx \
			FC=mpif90 FF=mpif90 F77=mpif90 --prefix=$HDF5_HOME

		# compile and install
		make -j && make install
	fi
fi
