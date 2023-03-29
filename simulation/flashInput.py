"""Script to create input files"""

import toml
import argparse
import numpy
import h5py
from scipy.stats import qmc


def createParfile(inputDict):
    """
    Create flash.par
    """
    with open("flash.par", "w") as parfile:

        # Add comment to the parfile
        parfile.write("# Programmatically generated parfile for flashx\n")

        # Loop over keys
        for key, value in inputDict["Parfile"].items():
            if type(value) == str and value not in [
                ".TRUE.",
                ".FALSE.",
                ".true.",
                ".false.",
            ]:
                parfile.write(f'{key} = "{value}"\n')
            else:
                parfile.write(f"{key} = {value}\n")

        if "Heater" in inputDict.keys():
            parfile.write(f'sim_heaterName = "{inputDict["Heater"]["name"]}"\n')
            parfile.write(
                f'sim_nucSeedRadius = {inputDict["Heater"]["nucSeedRadius"]}\n'
            )
            parfile.write(f"sim_numHeaters = 1")

    print(f"Wrote parameter information to file flash.par")


def createHeaterfile(inputDict):
    """
    Create heater file
    """
    heaterInfo = inputDict["Heater"]
    filename = h5py.File(heaterInfo["name"] + "_hdf5_htr_0001", "w")

    xsite = numpy.ndarray([heaterInfo["numSites"]], dtype=float)
    ysite = numpy.ndarray([heaterInfo["numSites"]], dtype=float)
    zsite = numpy.ndarray([heaterInfo["numSites"]], dtype=float)
    radii = numpy.ndarray([heaterInfo["numSites"]], dtype=float)

    if heaterInfo["numSites"] == 1:
        xsite[:] = 0.0
        ysite[:] = 1e-13
        zsite[:] = 0.0
        radii[:] = 0.2

    else:

        halton = qmc.Halton(d=2, seed=1)
        haltonSample = halton.random(heaterInfo["numSites"])

        xsite[:] = heaterInfo["xmin"] + haltonSample[:, 0] * (
            heaterInfo["xmax"] - heaterInfo["xmin"]
        )
        ysite[:] = 1e-13
        radii[:] = 0.2

        if heaterInfo["dim"] == 1:
            zsite[:] = 0.0
        elif heaterInfo["dim"] == 2:
            zsite[:] = heaterInfo["zmin"] + haltonSample[:, 1] * (
                heaterInfo["zmax"] - heaterInfo["zmin"]
            )
        else:
            raise ValueError("Error in Heater.dim")

    filename.create_dataset(
        "heater/xMin", data=heaterInfo["xmin"], shape=(1), dtype="float32"
    )
    filename.create_dataset(
        "heater/xMax", data=heaterInfo["xmax"], shape=(1), dtype="float32"
    )
    filename.create_dataset(
        "heater/zMin", data=heaterInfo["zmin"], shape=(1), dtype="float32"
    )
    filename.create_dataset(
        "heater/zMax", data=heaterInfo["zmax"], shape=(1), dtype="float32"
    )
    filename.create_dataset(
        "heater/yMin", data=heaterInfo["ymin"], shape=(1), dtype="float32"
    )
    filename.create_dataset(
        "heater/yMax", data=heaterInfo["ymax"], shape=(1), dtype="float32"
    )

    filename.create_dataset(
        "heater/wallTemp", data=heaterInfo["wallTemp"], shape=(1), dtype="float32"
    )

    filename.create_dataset(
        "heater/advAngle", data=heaterInfo["advAngle"], shape=(1), dtype="float32"
    )
    filename.create_dataset(
        "heater/rcdAngle", data=heaterInfo["rcdAngle"], shape=(1), dtype="float32"
    )
    filename.create_dataset(
        "heater/velContact", data=heaterInfo["velContact"], shape=(1), dtype="float32"
    )
    filename.create_dataset(
        "heater/nucWaitTime", data=heaterInfo["nucWaitTime"], shape=(1), dtype="float32"
    )

    filename.create_dataset(
        "site/num", data=heaterInfo["numSites"], shape=(1), dtype="int32"
    )
    filename.create_dataset(
        "site/x", data=xsite, shape=(heaterInfo["numSites"]), dtype="float32"
    )
    filename.create_dataset(
        "site/y", data=ysite, shape=(heaterInfo["numSites"]), dtype="float32"
    )
    filename.create_dataset(
        "site/z", data=zsite, shape=(heaterInfo["numSites"]), dtype="float32"
    )

    filename.create_dataset(
        "init/radii", data=radii, shape=(heaterInfo["numSites"]), dtype="float32"
    )

    filename.close()

    print(f"Wrote heater information to file {filename}")


if __name__ == "__main__":
    # Create an arg parser
    InputParser = argparse.ArgumentParser(description="Parser For Input File")
    InputParser.add_argument("-i", "--input", help="Input File", type=str)
    InputParser.set_defaults(input=None)

    # Load toml dictionary
    inputDict = toml.load(InputParser.parse_args().input)

    # Create input files
    createParfile(inputDict)

    if "Heater" in inputDict.keys():
        createHeaterfile(inputDict)
