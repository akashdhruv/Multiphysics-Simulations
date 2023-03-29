# Setup Flash-X
if [ "$FlashX_Enable" = true ]; then
	if [ ! -d "Flash-X" ]; then
		git clone git@github.com:Flash-X/Flash-X --branch main Flash-X && cd Flash-X
	else
		cd Flash-X && git checkout main && git pull
	fi

	# checkout desired SHA
	git checkout $FlashX_TAG
fi
