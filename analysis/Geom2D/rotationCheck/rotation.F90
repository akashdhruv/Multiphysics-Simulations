program rotation

implicit none

real, dimension (2) :: pA
real, dimension (2,2) :: rotate
real :: alpha = acos(-1.)

pA = (/0, 1/)

rotate(:,1) = (/cos(alpha), -sin(alpha)/)
rotate(:,2) = (/sin(alpha), cos(alpha)/)

pA = matmul(pA, rotate)

print*,pA

end program rotation
