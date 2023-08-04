!! adhruv - Added comment from object directory to see where it is being linked.
!!
!!****if* source/Simulation/SimulationMain/incompFlow/ChannelFlow/Simulation_initBlock
!! NOTICE
!!  Copyright 2022 UChicago Argonne, LLC and contributors
!!
!!  Licensed under the Apache License, Version 2.0 (the "License");
!!  you may not use this file except in compliance with the License.
!!
!!  Unless required by applicable law or agreed to in writing, software
!!  distributed under the License is distributed on an "AS IS" BASIS,
!!  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
!!  See the License for the specific language governing permissions and
!!  limitations under the License.
!!
!! NAME
!!
!!  Simulation_initBlock
!!
!!
!! SYNOPSIS
!!
!!  Simulation_initBlock(integer(in) :: blockID)
!!
!!
!!
!!
!! DESCRIPTION
!!
!!  Initializes fluid data (density, pressure, velocity, etc.) for
!!  a specified tile.
!!
!!  Reference:
!!
!!
!! ARGUMENTS
!!
!!  tile -          the tile to update
!!
!!
!!
!!
!!***
!!REORDER(4): solnData, face[xyz]Data

#include "constants.h"
#include "Simulation.h"

subroutine Simulation_initBlock(solnData, tileDesc)

   use Simulation_data
   use Grid_tile, ONLY: Grid_tile_t

#ifdef SIMULATION_FORCE_INLET
   use sim_outletInterface, ONLY: sim_outletInit
#endif

#ifdef SIMULATION_FORCE_OUTLET
   use sim_inletInterface, ONLY: sim_inletInit
#endif

   implicit none

   !---Arguments ------------------------------------------------------------------------
   real, dimension(:, :, :, :), pointer :: solnData
   type(Grid_tile_t), intent(in)   :: tileDesc
   integer :: tileDescID

   !-------------------------------------------------------------------------------------
   real, pointer, dimension(:, :, :, :) :: facexData, faceyData, facezData

   nullify (facexData, faceyData, facezData)

   call tileDesc%getDataPtr(facexData, FACEX)

   facexData(VELC_FACE_VAR, :, :, :) = 1.0

   call tileDesc%releaseDataPtr(facexData, FACEX)

   return

end subroutine Simulation_initBlock
