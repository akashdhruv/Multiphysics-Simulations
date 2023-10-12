import numpy

tree = numpy.arange(16, 376, 1, dtype=int)

nprocs = 11
div = int(len(tree) / nprocs)
mod = len(tree) % nprocs

print(len(tree), nprocs, div, mod)

dmap_proc = numpy.array([-1] * len(tree))
for proc in range(nprocs):
    dmap_proc[proc * div + min(proc, mod) : (proc + 1) * div + min(proc + 1, mod)] = proc

dmap_tree = numpy.array([-1] * len(tree))
for block in range(len(tree)):
    dmap_tree[block] = 0
