module cdf

  implicit none

  integer, parameter :: ndim1 = 1, ndim2 = 2, ndim3 = 3, ndim4 = 4

  integer, dimension(ndim1) :: dim1, corner1, edge1
  integer, dimension(ndim2) :: dim2, corner2, edge2
  integer, dimension(ndim3) :: dim3, corner3, edge3
  integer, dimension(ndim4) :: dim4, corner4, edge4

  real(kind=8) :: mval = -9999.

  integer :: rc,ncid
  integer :: xdim, ydim, ymdim, datid

end module cdf
