# Bash script for `jobrunner` to install AMReX

# Setup AMReX
if [ "$AMReX_Enable" = true ]; then

	if [ ! -d "AMReX" ]; then
		git clone git@github.com:AMReX-Codes/amrex --branch development AMReX && cd AMReX
	else
		cd AMReX && git checkout development && git pull
	fi

	# checkout desired branch
	git checkout $AMReX_TAG

	# configure and install amrex in 2D
	make clean
	./configure --dim=2 --prefix=$AMREX2D_HOME
	make -j
	make install

	# configure and install amrex in 3D
	make clean
	./configure --dim=3 --prefix=$AMREX3D_HOME
	make -j
	make install
fi
