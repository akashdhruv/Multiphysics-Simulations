# Setup FlashKit
if [ ! -d "FlashKit" ]; then
	git clone git@github.com:akashdhruv/FlashKit --branch main FlashKit && cd FlashKit

	# checkout desired branch
	git checkout 364c99d
else
	cd FlashKit
fi

# install in development mode
python3 setup.py develop --user
