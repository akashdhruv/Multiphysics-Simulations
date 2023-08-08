from module.geom3D import CreateFlashH5
from stl import mesh

h5path = ("../../simulation/ImBound/Example3D/sphere_hdf5_ibd_0001")
stlpath = ("cadFiles/Sphere/Sphere.stl")

stlMesh = mesh.Mesh.from_file(stlpath)
CreateFlashH5(h5path, stlMesh)
