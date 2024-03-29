import numpy
import h5py


class Elem:
    def __init__(self, pA=[], pB=[]):
        self.pA = numpy.array(pA)
        self.pB = numpy.array(pB)
        self.center = (self.pA + self.pB) / 2.0
        self.normal = numpy.array([pA[1] - pB[1], pB[0] - pA[0]])
        self.tangent = numpy.array([pB[0] - pA[0], pB[1] - pA[1]])

        self.normal = self.normal / numpy.sqrt(
            (pB[0] - pA[0]) ** 2 + (pB[1] - pA[1]) ** 2
        )
        self.tangent = self.tangent / numpy.sqrt(
            (pB[0] - pA[0]) ** 2 + (pB[1] - pA[1]) ** 2
        )

    def move(self, offset):
        offset = numpy.array(offset)
        self.pA = self.pA + offset
        self.pB = self.pB + offset
        self.center = self.center + offset

    def rotate(self, alpha):
        rotate = numpy.zeros((2, 2))

        rotate[:, 0] = numpy.array(
            [numpy.cos(alpha * numpy.pi / 180), -numpy.sin(alpha * numpy.pi / 180)]
        )
        rotate[:, 1] = numpy.array(
            [numpy.sin(alpha * numpy.pi / 180), numpy.cos(alpha * numpy.pi / 180)]
        )

        self.pA = numpy.matmul(self.pA, rotate)
        self.pB = numpy.matmul(self.pB, rotate)
        self.center = numpy.matmul(self.center, rotate)
        self.normal = numpy.matmul(self.normal, rotate)
        self.tangent = numpy.matmul(self.tangent, rotate)


def CreateFlashH5(filepath, elems):
    imboundFile = h5py.File(filepath, 'w')

    imboundFile.create_dataset("numElems", data=[len(elems)])
    imboundFile.create_dataset("dims", data=[2])

    imboundFile.create_dataset("elems/xA", data=[elem.pA[0] for elem in elems])
    imboundFile.create_dataset("elems/yA", data=[elem.pA[1] for elem in elems])

    imboundFile.create_dataset("elems/xB", data=[elem.pB[0] for elem in elems])
    imboundFile.create_dataset("elems/yB", data=[elem.pB[1] for elem in elems])

    imboundFile.create_dataset("elems/xCenter", data=[elem.center[0] for elem in elems])
    imboundFile.create_dataset("elems/yCenter", data=[elem.center[1] for elem in elems])

    imboundFile.create_dataset("elems/xNorm", data=[elem.normal[0] for elem in elems])
    imboundFile.create_dataset("elems/yNorm", data=[elem.normal[1] for elem in elems])

    imboundFile.close()
