# Setup FlashKit
if [ "$FlashKit_Enable" = true ]; then
	if [ ! -d "FlashKit" ]; then
		git clone git@github.com:akashdhruv/FlashKit --branch main FlashKit && cd FlashKit
	else
		cd FlashKit && git checkout main && git pull
	fi

	# checkout desired branch
	git checkout $FlashKit_TAG

	# install in development mode
	python3 setup.py develop --user
fi
