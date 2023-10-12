rm -f a.out

mpicxx -I${AMREX2D_HOME}/include dmap.cxx \
	-L${AMREX2D_HOME}/lib -lamrex -lpthread \
	-lgfortran

./a.out

mpicxx -I${AMREX2D_HOME}/include tree.cxx \
	-L${AMREX2D_HOME}/lib -lamrex -lpthread \
	-lgfortran


./a.out
