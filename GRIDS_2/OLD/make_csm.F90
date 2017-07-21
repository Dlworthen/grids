subroutine make_csm

  use param
  use data
  
  implicit none

  integer :: i,j,nr
     real :: rlat, rlon, rdp

  ! region mask
    csm = 0.0
  do nr = 1,nreg
   do j = 1,jhycom
    do i = 1,ihycom
     if(plat(i,j) .ge. 66.0)csm(i,j,nr) = land(i,j)
    enddo
   enddo
  enddo

  do j = 1,jhycom
   do i = 1,ihycom
    rlat =   plat(i,j)
    rlon =   plon(i,j)
     rdp = depths(i,j)
    if(rdp .lt. 1000.0)then

      ! Canadian Shelf
      nr = 1
      if(rlon .ge. 190.0)csm(i,j,nr) = 1.0

      ! Eurasian Shelf
      nr = 2
      if(rlon .ge. 110.0 .and. rlon .lt. 190.0)csm(i,j,nr) = 2.0

      ! Barents Shelf
       nr = 3
      if(rlon .ge. 15.0 .and. rlon .lt. 110.0)csm(i,j,nr) = 3.0
    endif
   enddo
  enddo

end subroutine make_csm

