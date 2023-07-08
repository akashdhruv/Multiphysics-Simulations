# Bash script for `jobrunner` to install HYPRE

# Setup HYPRE
if [ ! -d "HYPRE" ]; then
	git clone git@github.com:hypre-space/hypre.git --branch master HYPRE && cd HYPRE

	# checkout desired branch
	git checkout v2.22.0
else
	cd HYPRE
fi

# configure and install
cd src && ./configure --enable-shared --enable-fortran --with-MPI --prefix=$HYPRE_HOME

make -j && make install
