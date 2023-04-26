import os
import sys
import json
import itertools
#from scipy import signal
import numpy
#import matplotlib.pyplot as pyplot
import boxkit


def getWallHflux(dataset):
    """
    Get heat flux profile
    """
    hflux = numpy.array([])
    xloc = numpy.array([])
    iliq = numpy.array([])

    yloc = 0.0

    dataSlice = boxkit.create_slice(dataset, ymin=yloc, ymax=yloc, xmin=-5, xmax=5)

    for block in dataSlice.blocklist:
        yindex = (numpy.abs(block.yrange("center") - yloc)).argmin()
        zindex = 0
        xloc = numpy.append(xloc, block.xrange("center"))
        hflux = numpy.append(
            hflux,
            (block["dfun"][zindex, yindex, :] < 0)
            * (1 - block["temp"][zindex, yindex, :])
            / block.dy,
        )
        iliq = numpy.append(iliq, block["dfun"][zindex, yindex, :] < 0)

    hfluxProfile = {"xloc": xloc, "hflux": hflux, "iliq": iliq}

    return hfluxProfile


if __name__ == "__main__":

    PROJECT_HOME = "/gpfs/alpine/ast136/proj-shared/adhruv/Multiphase-Simulations"

    datasetLoc = {
        r"Buffer = 4.0": PROJECT_HOME
        + os.sep
        #+ "simulation/PoolBoiling/Gravity-FC72-2D/gravY-1.0/jobnode.archive/2023-04-13",
        + "simulation/PoolBoiling/Gravity-FC72-2D/gravY-0.01",
    }

    fileNumList = [*range(60, 108)]

    datasetDict = {}
    for datasetKey in datasetLoc.keys():
        datasetList = []
        for fileNum in fileNumList:
            dataset = boxkit.read_dataset(
                datasetLoc[datasetKey]
                + os.sep
                + "INS_Pool_Boiling_hdf5_plt_cnt_"
                + str(fileNum).zfill(4),
                source="flash",
            )
            datasetList.append(dataset)
        datasetDict[datasetKey] = datasetList

    # refKey = r"Reference"
    # datasetLoc[refKey] = PROJECT_HOME + os.sep + "jobnode.archive/reference_long"
    # fileNumListRef = [*range(1, 105)]
    # datasetList = []
    # for fileNum in fileNumListRef:
    #    dataset = boxkit.read_dataset(
    #        datasetLoc[refKey]
    #        + os.sep
    #        + "INS_Pool_Boiling_hdf5_plt_cnt_"
    #        + str(fileNum).zfill(4),
    #        source="flash",
    #    )
    #    datasetList.append(dataset)
    #    datasetDict[refKey] = datasetList

    heatFluxDict = {}
    for datasetKey in datasetDict.keys():
        heatFluxList = []
        for dataset in datasetDict[datasetKey]:
            hfluxProfile = getWallHflux(dataset)
            heatFlux = numpy.mean(hfluxProfile["hflux"][:]) #/ numpy.mean(
                #hfluxProfile["iliq"][:]
            #)
            heatFluxList.append(heatFlux)
        heatFluxDict[datasetKey] = {"qliq": heatFluxList, "time": fileNumList}

    with open("PoolBoiling-HeatFlux-0.01.json", "w") as heatFluxFile:
        heatFluxFile.write(json.dumps(heatFluxDict))

    #pyplot.rc("font", family="serif", size=10, weight="bold")
    #pyplot.rc("axes", labelweight="bold", titleweight="bold")
    #pyplot.rc("text", usetex=True)
    #pyplot.figure(figsize=(3, 2), dpi=200)
    # pyplot.plot(
    #    heatFluxDict["Reference"]["time"],
    #    signal.savgol_filter(heatFluxDict["Reference"]["qliq"], 4, 3),
    # )
    #pyplot.plot(
    #    heatFluxDict["Buffer = 4.0"]["time"],
    #    heatFluxDict["Buffer = 4.0"]["qliq"],
    #    #signal.savgol_filter(heatFluxDict["Buffer = 4.0"]["qliq"], 20, 5),
    #)
    #pyplot.ylabel(r"$q_L$")
    #pyplot.xlabel(r"$t$")
    #pyplot.savefig("poolboiling.png")
