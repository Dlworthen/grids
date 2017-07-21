  subroutine ocn_dump2cdf

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

            integer :: i
  character(len=12) :: vname, vunit, stggr
  character(len=60) :: vlong
  character(len=60) :: outcdf

  ! force single precision, 008 grid is too big for all variables
#ifdef hycom_008
  integer, parameter :: itype=4
#else
  integer, parameter :: itype=8
#endif
  !-----------------------------------------------------------------------------
  !
  !-----------------------------------------------------------------------------

  outcdf = trim(dirout)//trim(ocngridcdf)
  print *,'dumping values to ',trim(outcdf)

  rc = nf90_create(trim(outcdf), nf90_clobber, ncid)

  rc = nf90_def_dim(ncid, 'ni',   ihycom,    xdim)
  rc = nf90_def_dim(ncid, 'nj',   jhycom,    ydim)

  ! land+masks (ip,iq,iu,iv,land)
  do i = 1,5
   vname = trim(ofields(i)%varname)
   vunit = trim(ofields(i)%varunit)
   vlong = trim(ofields(i)%varlong)

    dim2(2) = ydim
    dim2(1) = xdim
   rc = nf90_def_var(ncid, vname,    nf90_int,  dim2,  datid)
   rc = nf90_put_att(ncid, datid,            'units',  vunit)
   rc = nf90_put_att(ncid, datid,        'long_name',  vlong)
  enddo

  do i = 6,nvars_ocn
   vname = trim(ofields(i)%varname)
   vunit = trim(ofields(i)%varunit)
   vlong = trim(ofields(i)%varlong)

    dim2(2) = ydim
    dim2(1) = xdim
#ifdef hycom_008
    rc = nf90_def_var(ncid, vname, nf90_float,  dim2,  datid)
    if(trim(vname) .eq. 'bathy')rc = nf90_put_att(ncid, datid, 'missing_value',  0.00)
    if(trim(vname) .eq. 'bathy')rc = nf90_put_att(ncid, datid, '_FillValue',     0.00)
#else
    rc = nf90_def_var(ncid, vname, nf90_double,  dim2,  datid)
    if(trim(vname) .eq. 'bathy')rc = nf90_put_att(ncid, datid, 'missing_value',  0.0d0)
    if(trim(vname) .eq. 'bathy')rc = nf90_put_att(ncid, datid, '_FillValue',     0.0d0)
#endif
    rc = nf90_put_att(ncid, datid,           'units',  vunit)
    rc = nf90_put_att(ncid, datid,       'long_name',  vlong)
  enddo
    rc = nf90_enddef(ncid)

    rc = nf90_inq_varid(ncid, trim('land'),        datid)
    rc = nf90_put_var(ncid,      datid,      int(land,4))

    rc = nf90_inq_varid(ncid,   trim('ip'),        datid)
    rc = nf90_put_var(ncid,      datid,        int(ip,4))
    rc = nf90_inq_varid(ncid,   trim('iq'),        datid)
    rc = nf90_put_var(ncid,      datid,        int(iq,4))
    rc = nf90_inq_varid(ncid,   trim('iu'),        datid)
    rc = nf90_put_var(ncid,      datid,        int(iu,4))
    rc = nf90_inq_varid(ncid,   trim('iv'),        datid)
    rc = nf90_put_var(ncid,      datid,        int(iv,4))

    rc = nf90_inq_varid(ncid,  trim('bathy'),        datid)
    rc = nf90_put_var(ncid,      datid, real(depths,itype))

    rc = nf90_inq_varid(ncid,   trim('plon'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(plon,itype))
    rc = nf90_inq_varid(ncid,   trim('plat'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(plat,itype))

    rc = nf90_inq_varid(ncid,   trim('qlon'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(qlon,itype))
    rc = nf90_inq_varid(ncid,   trim('qlat'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(qlat,itype))

    rc = nf90_inq_varid(ncid,   trim('ulon'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(ulon,itype))
    rc = nf90_inq_varid(ncid,   trim('ulat'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(ulat,itype))

    rc = nf90_inq_varid(ncid,   trim('vlon'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(vlon,itype))
    rc = nf90_inq_varid(ncid,   trim('vlat'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(vlat,itype))

    rc = nf90_inq_varid(ncid,   trim('pscx'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(pscx,itype))
    rc = nf90_inq_varid(ncid,   trim('pscy'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(pscy,itype))

    rc = nf90_inq_varid(ncid,   trim('qscx'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(qscx,itype))
    rc = nf90_inq_varid(ncid,   trim('qscy'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(qscy,itype))

    rc = nf90_inq_varid(ncid,   trim('uscx'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(uscx,itype))
    rc = nf90_inq_varid(ncid,   trim('uscy'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(uscy,itype))

    rc = nf90_inq_varid(ncid,   trim('vscx'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(vscx,itype))
    rc = nf90_inq_varid(ncid,   trim('vscy'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(vscy,itype))

    rc = nf90_inq_varid(ncid,   trim('pang'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(pang,itype))
    rc = nf90_inq_varid(ncid,   trim('cori'),        datid)
    rc = nf90_put_var(ncid,      datid,   real(cori,itype))
    rc = nf90_close(ncid)

  end subroutine ocn_dump2cdf
