import h5py

chkFile = h5py.File("INS_Pool_Boiling_hdf5_chk_0001", "r+")

for varKey in chkFile.keys():
    if "fc" in varKey:
        chkFile[varKey][:] = 0.

chkFile.close()
