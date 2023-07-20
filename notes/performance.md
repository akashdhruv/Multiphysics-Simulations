## General notes about code performance, bugs, and improvements.

- [ ] Compile AMReX in GPU mode and measure performance of Poisson solver
  for boiling simulations.

- \[ \] Restart fails for simulation/PoolBoiling/SingleBubble. Needs
  investigation.

- \[ \] Look into IO and restarting. Running production simulations on
  coarser grid and then refining during restart. See file
  simulation/PoolBoiling/Gravity-FC72-2D/grav-1.0/interpChk.py for a
  hack.

- \[ \] Facevar updates to leverage divergence free interpolation in AMReX.
  Running simulations with higher refinement.

- \[ \] Bittree AMReX updates.

- \[ \] Guard cells filling time has increased after adding more grid
  variables in physics/Multiphase, physics/IncompNS, and bc fill
  calls to Driver_evolveAll.F90 Reduce this by adjusting algorithm.

- \[ \] Immersed boundary alogrithm with ANN - use normal vectors from stl
  file.

- \[ \] Neural Poisson.

- \[ \] Improve calculation of curvature, make it smoother. Current
  implementation leads to local fluctuations in pressure.

- \[ \] Read about turbulence and develop statistical operators for Flash-X
  and post-processing.

- \[ \] Modelling microlayer and material properties in boiling.

## FlowBoiling 3D simulation performance

There are at total of 100 x 10 x 10 = 10000 blocks in the simulation.
Performance run on summit used 25 nodes with 42 processes per node resulting 
in 1050 processes.

Scaling parameters:
- length scale: 1mm
- velocity scale: 0.1 m/s
- time scale: 10 milliseconds

Performance metrics:

- time per iteration: 1 second wall time
- simulation start time: 4. 
- simulation end time: 6.
- wall time: 2+2+2+2 = 8 hours
- node hours: 25*(wall time) = 200 node-hours 
- physical time: 20 milliseconds

Length scales:
- Domain: 50 mm x 5 mm x 5mm = 5 cm x 0.5 cm x 0.5 cm
- Grid spacing: 0.031 mm = 31 micrometers
- Nucleation radius: 0.1 mm = 100 micrometers
