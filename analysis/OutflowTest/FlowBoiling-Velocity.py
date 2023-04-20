import re
import os
import json

outflowVelDict = { "time" : [], "liq" : [], "gas" : []}
outdir = "/home/akash/Desktop/Akash/Workbench/Multiphase-Simulations/simulation/FlowBoiling/Example2D/inletVelScale-1.0/jobnode.archive/2023-04-13"
outfiles = ["slurm-1937.out"]

for outfile in outfiles:
    with open(os.path.join(outdir,outfile),"r") as ofile:
        for line in ofile:

            if re.search("SimTime", line):
                outflowVelDict["time"].append(float(line.split()[-1]))

            if re.search("Outlet Gas Velocity HIGH", line):
                outflowVelDict["gas"].append(float(line.split()[4]))

            if re.search("Outlet Liq Velocity HIGH", line):
                outflowVelDict["liq"].append(float(line.split()[4]))

    print(len(outflowVelDict["time"]),len(outflowVelDict["gas"]))


skip = 3000
outflowVelDict["time"] = outflowVelDict["time"][::skip]
outflowVelDict["gas"] = outflowVelDict["gas"][::skip]
outflowVelDict["liq"] = outflowVelDict["liq"][::skip]
print(len(outflowVelDict["time"]),len(outflowVelDict["gas"]))

with open("FlowBoiling-Velocity.json", "w") as velFile:
    velFile.write(json.dumps(outflowVelDict))
