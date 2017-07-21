program xhygrid

  use param
  use cdf
  use data
  use ocnfields
  use icefields
  use charstrings

  use mod_za    ! HYCOM array I/O interface
  use mod_xc

  implicit none
 
     real :: xmin, xmax
  integer :: i,j,ii,jj,jlast
  integer :: reclen

  integer(kind=4), dimension(0:ihycom,0:jhycom) :: xip

  integer(kind=4), dimension(ihycom,jhycom) :: i2d
     real(kind=4), dimension(ihycom,jhycom) :: a2d

  call xcspmd
  call zaiost
  lp=6

  if(idm .ne. ihycom .or. jdm .ne. jhycom)stop
  ip = 1

  print *,idm,jdm
  !print *,ihycom,jhycom
  !inquire(iolength=reclen)a2d
  !print *,reclen,19*(reclen+2752),19*(reclen+11616)
  ! size of regional.depth.a (single record) is 6602752; 
  ! reclen=6600000; offset of some sort 2752
  ! size of regional.grid.a (19 records) is 125452288
  ! ==>19*(reclen+2752)
  ! for the 1/12 degree grid, regional.depth.a is 59375616
  ! reclen=59364000; offset of some sort 11616
  ! size of regional.grid.a (19 records) is 1128136704
  ! ==>19*(59364000+11616) 

  !-----------------------------------------------------------------------------
  ! set up the variable attributes for netcdf file
  !-----------------------------------------------------------------------------

  call ocnfields_setup
  
  call icefields_setup

  !-----------------------------------------------------------------------------
  ! read hycom horizontal grid
  !-----------------------------------------------------------------------------

  call zaiopf(trim(dirsrc)//'regional.grid.a', 'OLD', 21)

  ! lat/lon at P,Q,U,V grids
  call zaiord(plon,ip,.false., xmin,xmax, 21)
  call zaiord(plat,ip,.false., xmin,xmax, 21)

  call zaiord(qlon,ip,.false., xmin,xmax, 21)
  call zaiord(qlat,ip,.false., xmin,xmax, 21)

  call zaiord(ulon,ip,.false., xmin,xmax, 21)
  call zaiord(ulat,ip,.false., xmin,xmax, 21)

  call zaiord(vlon,ip,.false., xmin,xmax, 21)
  call zaiord(vlat,ip,.false., xmin,xmax, 21)
  ! angle between p grid and geolat,geolon
  call zaiord(pang,ip,.false., xmin,xmax, 21)

  ! grid spacing in meters of all 4 grids
  call zaiord(pscx,ip,.false., xmin,xmax, 21)
  call zaiord(pscy,ip,.false., xmin,xmax, 21)

  call zaiord(qscx,ip,.false., xmin,xmax, 21)
  call zaiord(qscy,ip,.false., xmin,xmax, 21)

  call zaiord(uscx,ip,.false., xmin,xmax, 21)
  call zaiord(uscy,ip,.false., xmin,xmax, 21)

  call zaiord(vscx,ip,.false., xmin,xmax, 21)
  call zaiord(vscy,ip,.false., xmin,xmax, 21)

  ! coriolis
  call zaiord(cori,ip,.false., xmin,xmax, 21)

  call zaiocl(21)
  print *,'closing regional.grid.a'
#ifdef test
  !-----------------------------------------------------------------------------
  ! print some values
  !-----------------------------------------------------------------------------

   !do i = 370,380
   do i = 1120,1130
    print *,i,qlat(i,jdm),qlon(i,jdm)
   enddo
   print *
   !do i = 1120,1130
   do i = 3370,3380
    print *,i,qlat(i,jdm),qlon(i,jdm)
   enddo

   i = 376; j = 1100
   print *,vlon(i,j),vlat(i,j)
   i = 1126; j = 1100
   print *,vlon(i,j),vlat(i,j)
#endif
  !-----------------------------------------------------------------------------
  ! read hycom bathymetry
  !-----------------------------------------------------------------------------

   call zaiopf(trim(dirsrc)//'regional.depth.a', 'OLD', 22)
   call zaiord(depths,ip,.false., xmin,xmax, 22)
   call zaiocl(22)
   print *,'closing regional.depth.a'

   print *,xmin,xmax
                          land = 1
   where(depths .gt. xmax)land = 0
   where(depths .gt. xmax)depths = 0.0

   !do i = 1,ihycom
   ! write(20,*)j,pang(i,1099),pang(i,1100)
   !enddo

  !-----------------------------------------------------------------------------
  ! make the masks
  !
  ! Following code from bigrid.f ln 216
  !c --- u,v points are located halfway between any 2 adjoining mass points
  !c --- 'interior' q points require water on all 4 sides.
  !c --- 'promontory' q points require water on 3 (or at least 2
  !c --- diametrically opposed) sides
  !-----------------------------------------------------------------------------

      xip = 0
       ip = 0; iu = 0; iv = 0; iq = 0
     do j = 1,jhycom
      do i = 1,ihycom
       if(depths(i,j) .gt. 0.)then
         ip(i,j) = 1
        xip(i,j) = 1
       endif
      enddo
     enddo
     ! set xip consistent w/ closed southern boundary, periodic eastern
     xip(:,0) = xip(:,1)
     xip(0,:) = xip(1,:)    

      do j=1,jhycom
        do i=1,ihycom
          if (xip(i-1,j).gt.0.and.xip(i,j).gt.0) then
            iu(i,j)=1
          endif
          if (xip(i,j-1).gt.0.and.xip(i,j).gt.0) then
            iv(i,j)=1
          endif
          if (min(xip(i,j),xip(i-1,j),xip(i,j-1),xip(i-1,j-1)).gt.0) then
            iq(i,j)=1
          elseif ((xip(i  ,j).gt.0.and.xip(i-1,j-1).gt.0).or. &
                  (xip(i-1,j).gt.0.and.xip(i  ,j-1).gt.0)    ) then
            iq(i,j)=1
          endif
        enddo
      enddo

  !-----------------------------------------------------------------------------
  ! straight dump of values
  !-----------------------------------------------------------------------------

  print *,'Dumping Ocn grid to NetCDF'

  call ocn_dump2cdf

  print *,maxloc(qlat, mask= qlat >= 85.0)
  !-----------------------------------------------------------------------------
  ! make the cice grid too
  !-----------------------------------------------------------------------------
 
  print *,'now making CICE grid'

  call grid2cice(1,1,ihycom,jhycom-1)

  !-----------------------------------------------------------------------------
  ! straight dump of values
  !-----------------------------------------------------------------------------

  print *,'Dumping Ice grid to NetCDF'

  call ice_dump2cdf

  !-----------------------------------------------------------------------------
  ! now produce the KISS grid from the ocn file
  ! uses ofields defs but leverages stagger to write different numbers of jrows
  !-----------------------------------------------------------------------------

  print *,'Making KISS grid from Ocn grid file'
  
  call hycom2kiss

end program XHygrid
