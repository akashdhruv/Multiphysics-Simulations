import numpy
import h5py


def CreateFlashH5(filepath, mesh):
    imboundFile = h5py.File(filepath, "w")

    imboundFile.create_dataset("numElems", data=[len(mesh.centroids)])
    imboundFile.create_dataset("dims", data=[3])

    imboundFile.create_dataset("elems/xA", data=[mesh.v0[:, 0]])
    imboundFile.create_dataset("elems/yA", data=[mesh.v0[:, 1]])
    imboundFile.create_dataset("elems/zA", data=[mesh.v0[:, 2]])

    imboundFile.create_dataset("elems/xB", data=[mesh.v1[:, 0]])
    imboundFile.create_dataset("elems/yB", data=[mesh.v1[:, 1]])
    imboundFile.create_dataset("elems/zB", data=[mesh.v1[:, 2]])

    imboundFile.create_dataset("elems/xC", data=[mesh.v2[:, 0]])
    imboundFile.create_dataset("elems/yC", data=[mesh.v2[:, 1]])
    imboundFile.create_dataset("elems/zC", data=[mesh.v2[:, 2]])

    imboundFile.create_dataset("elems/xCenter", data=[mesh.centroids[:, 0]])
    imboundFile.create_dataset("elems/yCenter", data=[mesh.centroids[:, 1]])
    imboundFile.create_dataset("elems/zCenter", data=[mesh.centroids[:, 2]])

    imboundFile.create_dataset("elems/xNorm", data=[mesh.normals[:, 0]])
    imboundFile.create_dataset("elems/yNorm", data=[mesh.normals[:, 1]])
    imboundFile.create_dataset("elems/zNorm", data=[mesh.normals[:, 2]])

    imboundFile.close()
