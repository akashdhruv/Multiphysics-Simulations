# cache the value of current working directory

FlashOptions="incompFlow/PoolBoiling -auto -maxblocks=100 +amrex +parallelIO \
	      -site=$SiteHome -makefile=FlashX SimForceInOut=True SimLSDamping=False \
              IOWriteGridFiles=True -2d -nxb=16 -nyb=16"
