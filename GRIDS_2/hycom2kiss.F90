subroutine hycom2kiss

  use param
  use ocnfields
  use netcdf
  use charstrings
  use data
  use cdf

  implicit none

  !-----------------------------------------------------------------------------
  ! local variables
  !-----------------------------------------------------------------------------

            integer :: ii
  character(len=12) :: vname, vunit, stggr
  character(len=60) :: vlong
  character(len=60) :: outcdf

            integer :: xtype

  integer(kind=4), dimension(ihycom,jhycom)   ::  i2d
  integer(kind=4), dimension(ihycom,jhycom-1) :: xi2d

  ! force single precision, 008 grid is too big for all variables
#ifdef hycom_008
          integer, parameter :: itype=4
     real(kind=4), parameter :: bathymiss = 0.0

     real(kind=4), dimension(ihycom,jhycom)   ::  m2d
     real(kind=4), dimension(ihycom,jhycom-1) :: xm2d
#else
          integer, parameter :: itype=8
     real(kind=8), parameter :: bathymiss = 0.0d0

     real(kind=8), dimension(ihycom,jhycom)   ::  m2d
     real(kind=8), dimension(ihycom,jhycom-1) :: xm2d
#endif
  !-----------------------------------------------------------------------------
  !
  !-----------------------------------------------------------------------------

  outcdf = trim(dirout)//trim(kissgridcdf)
  print *,'dumping ocean values to ',trim(outcdf)

  rc = nf90_create(trim(outcdf), nf90_clobber, ncid)

  rc = nf90_def_dim(ncid, 'ni',   ihycom,    xdim)
  rc = nf90_def_dim(ncid, 'nj',   jhycom,    ydim)
  rc = nf90_def_dim(ncid, 'njm1', jhycom-1, ymdim)

  ! land+masks (ip,iq,iu,iv,land)
  do ii = 1,5
   vname = trim(ofields(ii)%varname)
   vunit = trim(ofields(ii)%varunit)
   vlong = trim(ofields(ii)%varlong)
   stggr = trim(ofields(ii)%stagger)

                                                      dim2(2) = ydim
   if((stggr .eq. 'center') .or. (stggr .eq. 'edge1'))dim2(2) = ymdim
                                                      dim2(1) = xdim
   rc = nf90_def_var(ncid, vname,    nf90_int,  dim2,  datid)
   rc = nf90_put_att(ncid, datid,            'units',  vunit)
   rc = nf90_put_att(ncid, datid,        'long_name',  vlong)
  enddo

  do ii = 6,nvars_ocn
   vname = trim(ofields(ii)%varname)
   vunit = trim(ofields(ii)%varunit)
   vlong = trim(ofields(ii)%varlong)
   stggr = trim(ofields(ii)%stagger)

                                                      dim2(2) = ydim
   if((stggr .eq. 'center') .or. (stggr .eq. 'edge1'))dim2(2) = ymdim
                                                      dim2(1) = xdim
#ifdef hycom_008
    rc = nf90_def_var(ncid, vname, nf90_float,  dim2,  datid)
#else
    rc = nf90_def_var(ncid, vname, nf90_double,  dim2,  datid)
#endif
    rc = nf90_put_att(ncid, datid,            'units',  vunit)
    rc = nf90_put_att(ncid, datid,        'long_name',  vlong)
    if(trim(vname) .eq. 'bathy')rc = nf90_put_att(ncid, datid, 'missing_value',  bathymiss)
    if(trim(vname) .eq. 'bathy')rc = nf90_put_att(ncid, datid, '_FillValue',     bathymiss)
  enddo !ii
   rc = nf90_enddef(ncid)
   rc = nf90_close(ncid)

  !-----------------------------------------------------------------------------
  ! now read from ocean grid file and write to the kiss grid file
  !-----------------------------------------------------------------------------

  do ii = 1,nvars_ocn
   vname = trim(ofields(ii)%varname)
   stggr = trim(ofields(ii)%stagger)

      m2d = 0.0;  i2d = 0.0
     xm2d = 0.0; xi2d = 0.0

   ! read from ocean grid
   rc = nf90_open(trim(dirout)//trim(ocngridcdf), nf90_nowrite, ncid)

   rc = nf90_inq_varid(ncid, trim(vname),        datid)
   rc = nf90_inquire_variable(ncid, datid, xtype=xtype)

   ! integer
   if(xtype .eq. 4)then
     rc = nf90_get_var(ncid,      datid,       i2d)
   else
     rc = nf90_get_var(ncid,      datid,       m2d)
   endif
   rc = nf90_close(ncid)

   ! write to kiss grid
   rc = nf90_open(trim(dirout)//trim(kissgridcdf), nf90_write, ncid)

   rc = nf90_inq_varid(ncid, trim(vname),        datid)
   rc = nf90_inquire_variable(ncid, datid, xtype=xtype)

   if((stggr .eq. 'center') .or. (stggr .eq. 'edge1'))then
     xm2d(:,1:jhycom-1) = m2d(:,1:jhycom-1)
     xi2d(:,1:jhycom-1) = i2d(:,1:jhycom-1)
    ! integer
    if(xtype .eq. 4)then
      rc = nf90_put_var(ncid,      datid,      xi2d)
    else
      rc = nf90_put_var(ncid,      datid,      xm2d)
    endif
   else
    ! integer
    if(xtype .eq. 4)then
      rc = nf90_put_var(ncid,      datid,       i2d)
    else
      rc = nf90_put_var(ncid,      datid,       m2d)
    endif
   endif
   rc = nf90_close(ncid)

  enddo

end subroutine hycom2kiss
