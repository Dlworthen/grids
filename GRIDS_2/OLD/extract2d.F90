subroutine extract2d(name,jdim,ain,iin)

  use param
  use cdf

  implicit none
 
           integer, intent( in) :: jdim
  character(len=*), intent( in) :: name
      real(kind=4), intent( in) :: ain(ihycom,jhycom)
   integer(kind=4), intent( in) :: iin(ihycom,jhycom)
#ifdef hycom_008
      real(kind=4) :: a2d(ihycom,jdim)
#else
      real(kind=8) :: a2d(ihycom,jdim)
#endif
   integer(kind=4) :: i2d(ihycom,jdim)

  integer :: i,j,ii,jj

  a2d = 0.0
  i2d = 0.0
  print *,
  print *,'starting values ',trim(name),' ',minval(ain),maxval(ain),&
                                        ' ',minval(iin),maxval(iin)

  a2d(1:ihycom,1:jdim) = ain(1:ihycom,1:jdim)
  i2d(1:ihycom,1:jdim) = iin(1:ihycom,1:jdim)
  print *,'ending   values ',trim(name),' ',minval(real(a2d,4)),maxval(real(a2d,4)),&
                                        ' ',minval(i2d),maxval(i2d)

  call putcdf(trim(name),jdim,a2d,i2d)

end subroutine extract2d
