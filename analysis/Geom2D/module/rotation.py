import numpy

pA = numpy.array([0,1])

alpha = numpy.pi

rotate = numpy.zeros((2, 2))
rotate[:, 0] = numpy.array([numpy.cos(alpha), -numpy.sin(alpha)])
rotate[:, 1] = numpy.array([numpy.sin(alpha), numpy.cos(alpha)])

pA = numpy.matmul(pA, rotate)
print(pA)
