  subroutine ice_dump2cdf

  use param
  use icefields
  use netcdf
  use charstrings
  use cdf

  use mod_cice

  implicit none

  !-----------------------------------------------------------------------------
  ! local variables
  !-----------------------------------------------------------------------------

            integer :: i
  character(len=12) :: vname, vunit, stggr
  character(len=60) :: vlong
  character(len=60) :: outcdf

  !-----------------------------------------------------------------------------
  !
  !-----------------------------------------------------------------------------

  outcdf = trim(dirout)//trim(icegridcdf)
  print *,'dumping values to ',trim(outcdf)

  rc = nf90_create(trim(outcdf), nf90_clobber, ncid)

  rc = nf90_def_dim(ncid, 'ni',   ihycom,      xdim)
  rc = nf90_def_dim(ncid, 'nj',   jhycom-1,    ydim)

  ! all but land are r*8
  do i = 1,nvars_ice-1
   vname = trim(ifields(i)%varname)
   vunit = trim(ifields(i)%varunit)
   vlong = trim(ifields(i)%varlong)

    dim2(2) = ydim
    dim2(1) = xdim
    rc = nf90_def_var(ncid, vname, nf90_double,  dim2,  datid)
    rc = nf90_put_att(ncid, datid,           'units',  vunit)
    rc = nf90_put_att(ncid, datid,       'long_name',  vlong)
  enddo

  ! land (integer)
       i = nvars_ice
   vname = trim(ifields(i)%varname)
   vunit = trim(ifields(i)%varunit)
   vlong = trim(ifields(i)%varlong)

    dim2(2) = ydim
    dim2(1) = xdim
    rc = nf90_def_var(ncid, vname,   nf90_int,  dim2,  datid)
    rc = nf90_put_att(ncid, datid,           'units',  vunit)
    rc = nf90_put_att(ncid, datid,       'long_name',  vlong)

    rc = nf90_enddef(ncid)

  !-----------------------------------------------------------------------------
  !
  !-----------------------------------------------------------------------------

    rc = nf90_inq_varid(ncid,   trim('tlon'),    datid)
    rc = nf90_put_var(ncid,      datid,          tloni)
    rc = nf90_inq_varid(ncid,   trim('tlat'),    datid)
    rc = nf90_put_var(ncid,      datid,          tlati)

    rc = nf90_inq_varid(ncid,   trim('ulon'),    datid)
    rc = nf90_put_var(ncid,      datid,          uloni)
    rc = nf90_inq_varid(ncid,   trim('ulat'),    datid)
    rc = nf90_put_var(ncid,      datid,          ulati)

    rc = nf90_inq_varid(ncid,    trim('htn'),    datid)
    rc = nf90_put_var(ncid,      datid,          htn*100.0d0)
    rc = nf90_inq_varid(ncid,    trim('hte'),    datid)
    rc = nf90_put_var(ncid,      datid,          hte*100.0d0)

    rc = nf90_inq_varid(ncid,  trim('angle'),    datid)
    rc = nf90_put_var(ncid,      datid,  -1.0d0*anglet)

    rc = nf90_inq_varid(ncid,  trim('tarea'),    datid)
    rc = nf90_put_var(ncid,      datid,        htn*hte)
    rc = nf90_inq_varid(ncid,    trim('kmt'),    datid)
    rc = nf90_put_var(ncid,      datid,            kmt)

    rc = nf90_close(ncid)

  end subroutine ice_dump2cdf
