# cache the value of current working directory

# There are at total of 100 x 10 x 10 = 10000 blocks in the simulation with 
# maxblocks=10. Therefore, using around 1000 processes should be the target. 
# Previous runs used 25 nodes with 42 processes per node resulting in 1050
# processes.

FlashOptions="incompFlow/FlowBoiling -auto -maxblocks=10 +amrex +parallelIO \
   	      -site=$SiteHome SimForceInOut=True IOWriteGridFiles=True -3d -nxb=16 -nyb=16 -nzb=16"
