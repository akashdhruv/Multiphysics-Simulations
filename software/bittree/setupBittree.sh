# Bash script for `jobrunner` to install AMReX

# Setup AMReX
if [ ! -d "Bittree" ]; then
	git clone git@github.com:Flash-X/Bittree.git && cd Bittree

	# checkout desired branch
	git checkout ci-cd
else
	cd Bittree
fi

# configure and install
python3 setup.py library --dim 2 --prefix $BITTREE_2D_HOME
cd build && make && make install && cd ..

python3 setup.py library --dim 3 --prefix $BITTREE_3D_HOME
cd build && make && make install && cd ..
