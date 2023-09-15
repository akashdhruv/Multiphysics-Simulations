## Tasks

- \[x\] Introduce performance log for unittests in BoxKit.

- \[ \] Performance of Navier-Stokes solvers, GPU vs CPU, AMR vs
  non-uniform grid.

- \[ \] Direct air capture simulations

- \[ \] `yt` support

- \[ \] Improve calculation of curvature, make it smoother. Current
  implementation leads to local fluctuations in pressure. Refs: 
  (1) https://arxiv.org/pdf/1407.7340.pdf (2) https://arxiv.org/pdf/2203.12558.pdf

- \[ \] Read about turbulence and develop statistical operators for Flash-X
  and post-processing.

- \[ \] Modelling microlayer and material properties in boiling.

- \[x\] Immersed boundary alogrithm with ANN - use normal vectors from stl
  file.

- \[ \] Take a stock of services needed from Grid for physics units

- \[x\] Mechanics of external simulation directory see simulation/ChannelFlow/FlashExternal

- \[ \] Flux correction for AMR grids
   ```fortran
   ! Enforce flux correction for velocities
   ! currently exclusively implmented for
   ! AMReX configuration
   #ifdef FLASH_GRID_AMREX
         !----------------------------------------------------------------
         call Grid_getMaxRefinement(maxLev, mode=1)

         !----------------------------------------------------------------
         do level = maxLev, 1, -1

            !----------------------------------------------------------------
            if (level < maxLev) then
               call Grid_communicateFluxes(ALLDIR, level)
            end if
            !----------------------------------------------------------------

            !----------------------------------------------------------------
            call Grid_getTileIterator(itor, LEAF, level=level, tiling=.FALSE.)
            do while (itor%isValid())
               !----------------------------------------------------------------
               call itor%currentTile(tileDesc)
               call tileDesc%getDataPtr(fluxBufX, FLUXX)
               call tileDesc%getDataPtr(fluxBufY, FLUXY)
               call tileDesc%getDataPtr(fluxBufZ, FLUXZ)
               !----------------------------------------------------------------
               fluxBufX = 0.
               fluxBufY = 0.
               fluxBufZ = 0.
               call IncompNS_fluxSet(tileDesc, fluxBufX, fluxBufY, fluxBufZ, tileDesc%limits(LOW, :))

               if (level < maxLev) then
                  call Grid_correctFluxData(tileDesc, fluxBufX, fluxBufY, fluxBufZ, tileDesc%limits(LOW, :))
               end if

               call IncompNS_fluxUpdate(tileDesc, fluxBufX, fluxBufY, fluxBufZ, tileDesc%limits(LOW, :))

               if (level > 1) then
                  call Grid_putFluxData(tileDesc, fluxBufX, fluxBufY, fluxBufZ, tileDesc%limits(LOW, :))
               end if

               !----------------------------------------------------------------
               call tileDesc%releaseDataPtr(fluxBufX, FLUXX)
               call tileDesc%releaseDataPtr(fluxBufY, FLUXY)
               call tileDesc%releaseDataPtr(fluxBufZ, FLUXZ)
               call itor%next()
            end do
            call Grid_releaseTileIterator(itor)
         end do 
   #endif
   ```
