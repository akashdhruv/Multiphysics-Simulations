# Bash script for `jobrunner` to install AMReX

# Setup AMReX
if [ ! -d "AMReX" ]; then
	git clone git@github.com:Box-Tools/amrex --branch bittree-sept-2023 AMReX && cd AMReX

	# checkout desired branch
	# git checkout cff96a9

else
	cd AMReX
fi

# configure and install amrex in 2D
make clean || true
./configure --dim=2 --prefix=$AMREX2D_HOME
make -j
make install

# configure and install amrex in 3D
make clean || true
./configure --dim=3 --prefix=$AMREX3D_HOME
make -j
make install
