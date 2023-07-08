# Bash script for `jobrunner` to install HDF5

if [[ "$BuildHDF5" = true ]]; then
	# Setup HDF5
	if [ ! -d "HDF5" ]; then
		git clone git@github.com:HDFGroup/hdf5.git --branch develop HDF5 && cd HDF5

		# checkout desired branch
		git checkout 93754ca
	else
		cd HDF5
	fi

	# configure HDF5
	./autogen.sh
	./configure --enable-parallel --enable-fortran CC=mpicc CXX=mpicxx \
		FC=mpif90 FF=mpif90 F77=mpif90 --prefix=$HDF5_HOME

	# compile and install
	make -j && make install
fi
