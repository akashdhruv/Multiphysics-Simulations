# cache the value of current working directory

FlashOptions="incompFlow/PoolBoiling -auto -maxblocks=100 +amrex +parallelIO \
	      -site=$SiteHome -makefile=FlashX SimForceInOut=True \
              IOWriteGridFiles=True -3d -nxb=16 -nyb=16 -nzb=16"
