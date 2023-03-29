import os
import sys
import itertools
from scipy import signal
import numpy
import matplotlib.pyplot as pyplot
import boxkit

def getWallHflux(dataset):
    """
    Get heat flux profile
    """   
    hflux = numpy.array([])
    xloc = numpy.array([])
    yloc = 0.
 
    dataSlice = boxkit.create_slice(dataset, ymin=yloc, ymax=yloc)       

    for block in dataSlice.blocklist:
        yindex = (numpy.abs(block.yrange("center") - yloc)).argmin()
        zindex = 0
        xloc = numpy.append(xloc, block.xrange("center"))
        hflux = numpy.append(hflux, (1-block["temp"][zindex, yindex, :])/block.dy)
       
    hfluxProfile = {'xloc' : xloc, 'hflux' : hflux}

    return hfluxProfile


if __name__ == "__main__":

    PROJECT_HOME="/home/akash/jobs/boiling-simulations/simulation/PoolBoiling/SingleBubble"

    datasetLoc = {
        r"Buffer = 0.5" : PROJECT_HOME + os.sep + "jobnode.archive/buffer_0.5_long",
        r"Buffer = 1.0" : PROJECT_HOME + os.sep + "jobnode.archive/buffer_1.0_long",
    }

    fileNumList = [*range(1,401)]

    datasetDict = {}
    for datasetKey in datasetLoc.keys():
        datasetList = []
        for fileNum in fileNumList:
            dataset = boxkit.read_dataset(datasetLoc[datasetKey] 
                                          + os.sep 
                                          + "INS_Pool_Boiling_hdf5_plt_cnt_"
                                          + str(fileNum).zfill(4), source="flash")
            datasetList.append(dataset)
        datasetDict[datasetKey]=datasetList


    heatFluxDict = {}
    for datasetKey in datasetDict.keys():
        heatFluxList = []
        for dataset in datasetDict[datasetKey]:
            hfluxProfile = getWallHflux(dataset)
            heatFlux = numpy.mean(hfluxProfile['hflux'][:])
            heatFluxList.append(heatFlux)
        heatFluxDict[datasetKey] = heatFluxList

pyplot.figure(figsize=(12,8))
pyplot.plot(fileNumList, signal.savgol_filter(heatFluxDict["Buffer = 0.5"],20,3))
pyplot.plot(fileNumList, signal.savgol_filter(heatFluxDict["Buffer = 1.0"],20,3))
pyplot.ylim([3.5,5])
pyplot.savefig('singlebubble.png')
