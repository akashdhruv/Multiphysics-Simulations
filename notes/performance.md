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

  Update: AMReX allows for selective guardcell filling by passing lower
          and upper bound of variable indices. Either rename variables or
          adjust Grid_fillGuardCells to call fillpatch for single variable
          based on mask

  Update: https://github.com/Flash-X/Flash-X/issues/563


- \[ \] Neural Poisson.
