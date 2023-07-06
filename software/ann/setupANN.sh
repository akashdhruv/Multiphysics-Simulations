# Bash script for `jobrunner` to install AMReX

# Setup AMReX
if [ ! -d "ANN" ]; then
	git clone git@github.com:Box-Tools/ANN.git && cd ANN

	# checkout desired branch
	git checkout main
fi

# configure and install ANN
make linux-g++
make install
