!!****if* source/Simulation/SimulationMain/incompFlow/ChannelFlow/Simulation_init
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
!!  Simulation_init
!!
!!
!! SYNOPSIS
!!
!!  call Simulation_init()
!!
!! ARGUMENTS
!!
!!   none
!!
!! DESCRIPTION
!!
!!  Initializes all the data specified in Simulation_data.
!!  It calls RuntimeParameters_get rotuine for initialization.
!!  Initializes initial conditions for INS-isotropic turbulence problem.
!!
!!***

#include "constants.h"
#include "Simulation.h"

subroutine Simulation_init()

   use Driver_interface, ONLY: Driver_getMype
   use Simulation_data, ONLY: sim_xMin, sim_yMin, &
                              sim_xMax, sim_yMax, &
                              sim_zMin, sim_zMax, &
                              sim_meshMe

   use RuntimeParameters_interface, ONLY: RuntimeParameters_get

#ifdef SIMULATION_FORCE_INLET
   use sim_outletInterface, ONLY: sim_outletInit
#endif

#ifdef SIMULATION_FORCE_OUTLET
   use sim_inletInterface, ONLY: sim_inletInit
#endif

   implicit none

   call Driver_getMype(MESH_COMM, sim_meshMe)

   call RuntimeParameters_get('xmin', sim_xMin)
   call RuntimeParameters_get('ymin', sim_yMin)
   call RuntimeParameters_get('xmax', sim_xMax)
   call RuntimeParameters_get('ymax', sim_yMax)
   call RuntimeParameters_get('zmin', sim_zMin)
   call RuntimeParameters_get('zmax', sim_zMax)

#ifdef SIMULATION_FORCE_INLET
   call sim_inletInit()
#endif

#ifdef SIMULATION_FORCE_OUTLET
   call sim_outletInit()
#endif

end subroutine Simulation_init
