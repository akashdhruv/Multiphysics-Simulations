import re
import os
import json

outflowVelDict = { "time" : [], "liq" : [], "gas" : []}
outdir = "/home/akash/Desktop/Akash/Workbench/Multiphase-Simulations/simulation/PoolBoiling/Gravity-FC72-2D/gravY-1.0/jobnode.archive/2023-04-13"
outfiles = ["slurm-1931.out","slurm-1938.out"]

for outfile in outfiles:
    with open(os.path.join(outdir,outfile),"r") as ofile:
        for line in ofile:

            if re.search("SimTime", line):
                outflowVelDict["time"].append(float(line.split()[-1]))

            if re.search("Outlet Gas Velocity HIGH", line):
                outflowVelDict["gas"].append(float(line.split()[5]))

            if re.search("Outlet Liq Velocity HIGH", line):
                outflowVelDict["liq"].append(float(line.split()[5]))

    print(len(outflowVelDict["time"]),len(outflowVelDict["gas"]))


skip = 4000
outflowVelDict["time"] = outflowVelDict["time"][::skip]
outflowVelDict["gas"] = outflowVelDict["gas"][::skip]
outflowVelDict["liq"] = outflowVelDict["liq"][::skip]
print(len(outflowVelDict["time"]),len(outflowVelDict["gas"]))

with open("PoolBoiling-Velocity.json", "w") as velFile:
    velFile.write(json.dumps(outflowVelDict))
