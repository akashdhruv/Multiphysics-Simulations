!! A script to test new masking strategies for Flash-X

subroutine initRandomMask(numVars, maskVars, mask)

   implicit none

   ! Arguments
   integer, intent(in) :: numVars, maskVars
   logical, dimension(numVars), intent(inout) :: mask

   ! Local Variables
   real, dimension(maskVars) :: maskIndices
   integer :: i

   call RANDOM_NUMBER(maskIndices)
   do i = 1, maskVars
      mask(FLOOR(maskIndices(i)*numVars)) = .TRUE.
   end do

end subroutine initRandomMask

subroutine getContiguousChunks(mask, chunkSize, chunks)

   implicit none

   ! Arguments
   logical, dimension(:), intent(in) :: mask
   integer, intent(inout) :: chunkSize
   logical, dimension(chunkSize, 2), intent(inout) :: chunks

    !!maxChunks = 10
    !!chunks = numpy.zeros([maxChunks, 2], dtype=int)

    !!chunkSize = -1
    !!prevVarIndex = 0
    !!prevVarMask = False

    !!for varIndex in range(len(mask)):
    !!
    !!    if mask[varIndex] and not prevVarMask:
    !!
    !!        chunkSize += 1
    !!        chunks[chunkSize, 0] = varIndex
    !!        chunks[chunkSize, 1] = varIndex
    !!
    !!    elif mask[varIndex] and prevVarMask:
    !!        chunks[chunkSize, 1] = varIndex
    !!
    !!    prevVarIndex = varIndex
    !!    prevVarMask = mask[varIndex]
end subroutine getContiguousChunks

program main

   implicit none

   integer :: numVars = 20, maskVars = 10
   logical, dimension(:), allocatable :: gcMask

   allocate (gcMask(numVars))

   call initRandomMask(numVars, maskVars, gcMask)

   print *, gcMask

   deallocate (gcMask)

end program main
