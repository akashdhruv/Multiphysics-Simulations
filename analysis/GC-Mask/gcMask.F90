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

subroutine getContiguousChunks(numVars, mask, maxChunks, chunks, chunkSize)

   implicit none

   ! Arguments
   integer, intent(in) :: numVars
   logical, dimension(numVars), intent(in) :: mask
   integer, intent(in) :: maxChunks
   integer, dimension(maxChunks, 2), intent(out) :: chunks
   integer, intent(out) :: chunkSize

   ! Local Variables
   integer :: prevVarIndex, varIndex
   logical :: prevVarMask

   prevVarIndex = 0
   prevVarMask = .FALSE.
   chunks = 0
   chunkSize = 0

   do varIndex = 1, size(mask)

      if (mask(varIndex) .and. (.not. prevVarMask)) then
         chunkSize = chunkSize + 1
         chunks(chunkSize, 1) = varIndex
         chunks(chunkSize, 2) = varIndex

      else if (mask(varIndex) .and. prevVarMask) then
         chunks(chunkSize, 2) = varIndex

      end if

      prevVarIndex = varIndex
      prevVarMask = mask(varIndex)

   end do

end subroutine getContiguousChunks

program main

   implicit none

   integer :: numVars = 20, maskVars = 10, maxChunks = 10, chunkSize = 0
   logical, dimension(:), allocatable :: gcMask(:)
   integer, dimension(:, :), allocatable :: gcChunks

   allocate (gcMask(numVars), gcChunks(maxChunks, 2))

   call initRandomMask(numVars, maskVars, gcMask)
   call getContiguousChunks(numVars, gcMask, maxChunks, gcChunks, chunkSize)

   print *, gcMask
   print *, gcChunks

   deallocate (gcMask, gcChunks)

end program main
