"""A script to test new masking strategies for Flash-X"""

import numpy


def initRandomMask(numVars=0, maskVars=0):
    """
    Initialize mask with given number of variables

    Arguments
    ---------
    numVars : type integer

    Returns
    -------
    mask    : numpy array of type bool
    """
    mask = numpy.zeros(numVars, dtype=bool)
    mask[numpy.random.randint(low=0, high=numVars, size=maskVars)] = True
    return mask


def getContiguousChunks(mask):
    """
    Get contiguous chunks to allow separate masked variables
    for subiterations. The logic is intentionally non-pythonic
    to keep it as close to Fortran as possible

    Arguments
    ---------
    mask : numpy array of type bool

    Returns
    -------
    chunks : list of chunks with high and low values
    """
    maxChunks = 10
    chunks = numpy.zeros([maxChunks, 2], dtype=int)

    chunkSize = -1
    prevVarIndex = 0
    prevVarMask = False

    for varIndex in range(len(mask)):

        if mask[varIndex] and not prevVarMask:

            chunkSize += 1
            chunks[chunkSize, 0] = varIndex
            chunks[chunkSize, 1] = varIndex

        elif mask[varIndex] and prevVarMask:
            chunks[chunkSize, 1] = varIndex

        prevVarIndex = varIndex
        prevVarMask = mask[varIndex]

    return chunks[0 : chunkSize + 1, :]


if __name__ == "__main__":
    """
    Main function
    """
    gcMask = initRandomMask(numVars=20, maskVars=10)
    gcChunks = getContiguousChunks(gcMask)

    print(gcMask)
    print(gcChunks)
