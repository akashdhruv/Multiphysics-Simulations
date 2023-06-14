# Bash file to load modules and set environment
# variables for compilers and external libraries

# Set project home using realpath
# of current directory
export PROJECT_HOME=$(realpath .)

# Set SiteHome to realpath of SiteName
SiteHome="$PROJECT_HOME/sites/$SiteName"

# Load modules from the site directory
source $SiteHome/modules.sh

# Set MPI_HOME by quering path loaded by site module
export MPI_HOME=$(which mpicc | sed s/'\/bin\/mpicc'//)

# Path to parallel HDF5 installtion with fortran support
if [ $(which h5pfc) ]; then
	export HDF5_HOME=$(which h5pfc | sed s/'\/bin\/h5pfc'//)
	BuildHDF5=false
else
	export HDF5_HOME="$PROJECT_HOME/software/HDF5/install-$SiteName"
	BuildHDF5=true
fi

# Path to nvhpc installation
if [ $(which nvcc) ]; then
	export NVHPC_HOME=$(which nvcc | sed s/'\/bin\/nvcc'//)
fi

# Store path to amrex as environment variable
export AMREX2D_HOME="$PROJECT_HOME/software/AMReX/install-$SiteName/2D"
export AMREX3D_HOME="$PROJECT_HOME/software/AMReX/install-$SiteName/3D"

# Path to Flash-X
export FLASHX_HOME="$PROJECT_HOME/software/Flash-X"

# Output information to stdout
echo "-------------------------------------------------------------"
echo "Boiling Simulations Environment:"
echo "PROJECT_HOME=$PROJECT_HOME"
echo "SITE_HOME=$SiteHome"
echo "MPI_HOME=$MPI_HOME"
echo "HDF5_HOME=$HDF5_HOME"
echo "FLASHX_HOME=$FLASHX_HOME"
echo "AMREX2D_HOME=$AMREX2D_HOME"
echo "AMREX3D_HOME=$AMREX3D_HOME"
echo "NVHPC_HOME=$NVHPC_HOME"
echo "-------------------------------------------------------------"
