# Bash script for `jobrunner` to install AMReX

# Setup AMReX
if [ ! -d "ANN" ]; then
	git clone git@github.com:Box-Tools/ANN.git && cd ANN

	# checkout desired branch
	git checkout main

else
	cd ANN
fi

# configure and install ANN
make realclean
make linux-g++
make install
