# Bash file to load modules and set environment
# variables for compilers and external libraries

# Set project home using realpath
# of current directory
export PROJECT_HOME=$(realpath .)

# Set SiteHome to realpath of SiteName
SiteHome="$PROJECT_HOME/sites/$SiteName"

# Load modules from the site directory
source $SiteHome/environment.sh

# Path to parallel HDF5 installtion with fortran support
if [ $HDF5_HOME ]; then
	BuildHDF5=false
else
	export HDF5_HOME="$PROJECT_HOME/software/HDF5/install-$SiteName"
	BuildHDF5=true
fi

# Store path to amrex as environment variable
export AMREX2D_HOME="$PROJECT_HOME/software/AMReX/install-$SiteName/2D"
export AMREX3D_HOME="$PROJECT_HOME/software/AMReX/install-$SiteName/3D"

# Store path to Hypre
export HYPRE_HOME="$PROJECT_HOME/software/HYPRE/install-$SiteName"
export LD_LIBRARY_PATH="$HYPRE_HOME/lib"
export LIBRARY_PATH="$LD_LIBRARY_PATH"

# Path to Flash-X
export FLASHX_HOME="$PROJECT_HOME/software/Flash-X"

# Output information to stdout
echo "---------------------------------------------------------------------------------------"
echo "Execution Environment:"
echo "---------------------------------------------------------------------------------------"
echo "PROJECT_HOME=$PROJECT_HOME"
echo "SITE_HOME=$SiteHome"
echo "MPI_HOME=$MPI_HOME"
echo "HDF5_HOME=$HDF5_HOME"
echo "FLASHX_HOME=$FLASHX_HOME"
echo "AMREX2D_HOME=$AMREX2D_HOME"
echo "AMREX3D_HOME=$AMREX3D_HOME"
echo "NVHPC_HOME=$NVHPC_HOME"
echo "HYPRE_HOME=$HYPRE_HOME"
echo "FLASHTEST_MAIN_ARCHIVE=$FLASHTEST_MAIN_ARCHIVE"
echo "FLASHTEST_LOCAL_ARCHIVE=$FLASHTEST_LOCAL_ARCHIVE"
echo "---------------------------------------------------------------------------------------"
