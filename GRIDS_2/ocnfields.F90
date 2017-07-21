module ocnfields

  use param

  implicit none

  type OcnFieldsDefs
    character(len=12)                           :: varname
    character(len=12)                           :: varunit
    character(len=60)                           :: varlong
    character(len=12)                           :: stagger
  end type OcnFieldsDefs

  type(OcnFieldsDefs) :: ofields(nvars_ocn)

  contains

  subroutine ocnfields_setup

  integer :: i
  integer :: ii = 0

  ii = ii + 1
  ofields(ii)%varname     = 'land'
  ofields(ii)%varunit     = ' '
  ofields(ii)%varlong     = 'land mask on p grid'
  ofields(ii)%stagger     = 'center'

  ii = ii + 1
  ofields(ii)%varname     = 'ip'
  ofields(ii)%varunit     = ' '
  ofields(ii)%varlong     = 'land mask on p grid'
  ofields(ii)%stagger     = 'center'

  ii = ii + 1
  ofields(ii)%varname     = 'iu'
  ofields(ii)%varunit     = ' '
  ofields(ii)%varlong     = 'land mask on u grid'
  ofields(ii)%stagger     = 'edge1'

  ii = ii + 1
  ofields(ii)%varname     = 'iv'
  ofields(ii)%varunit     = ' '
  ofields(ii)%varlong     = 'land mask on v grid'
  ofields(ii)%stagger     = 'edge2'

  ii = ii + 1
  ofields(ii)%varname     = 'iq'
  ofields(ii)%varunit     = ' '
  ofields(ii)%varlong     = 'land mask on q grid'
  ofields(ii)%stagger     = 'corner'

  ii = ii + 1
  ofields(ii)%varname     = 'bathy'
  ofields(ii)%varunit     = 'm'
  ofields(ii)%varlong     = 'bathymetry on p grid'
  ofields(ii)%stagger     = 'center'

  ii = ii + 1
  ofields(ii)%varname     = 'plat'
  ofields(ii)%varunit     = 'degree_north'
  ofields(ii)%varlong     = 'latitude of p grid'
  ofields(ii)%stagger     = 'center'

  ii = ii + 1
  ofields(ii)%varname     = 'plon'
  ofields(ii)%varunit     = 'degree_east'
  ofields(ii)%varlong     = 'longitude of p grid'
  ofields(ii)%stagger     = 'center'

  ii = ii + 1
  ofields(ii)%varname     = 'qlat'
  ofields(ii)%varunit     = 'degree_north'
  ofields(ii)%varlong     = 'latitude of q grid'
  ofields(ii)%stagger     = 'corner'

  ii = ii + 1
  ofields(ii)%varname     = 'qlon'
  ofields(ii)%varunit     = 'degree_east'
  ofields(ii)%varlong     = 'longitude of q grid'
  ofields(ii)%stagger     = 'corner'

  ii = ii + 1
  ofields(ii)%varname     = 'ulat'
  ofields(ii)%varunit     = 'degree_north'
  ofields(ii)%varlong     = 'latitude of u grid'
  ofields(ii)%stagger     = 'edge1'

  ii = ii + 1
  ofields(ii)%varname     = 'ulon'
  ofields(ii)%varunit     = 'degree_east'
  ofields(ii)%varlong     = 'longitude of u grid'
  ofields(ii)%stagger     = 'edge1'

  ii = ii + 1
  ofields(ii)%varname     = 'vlat'
  ofields(ii)%varunit     = 'degree_north'
  ofields(ii)%varlong     = 'latitude of v grid'
  ofields(ii)%stagger     = 'edge2'

  ii = ii + 1
  ofields(ii)%varname     = 'vlon'
  ofields(ii)%varunit     = 'degree_east'
  ofields(ii)%varlong     = 'longitude of v grid'
  ofields(ii)%stagger     = 'edge2'

  ii = ii + 1
  ofields(ii)%varname     = 'pscx'
  ofields(ii)%varunit     = 'm'
  ofields(ii)%varlong     = 'grid spacing x-direction on p grid'
  ofields(ii)%stagger     = 'center'

  ii = ii + 1
  ofields(ii)%varname     = 'pscy'
  ofields(ii)%varunit     = 'm'
  ofields(ii)%varlong     = 'grid spacing y-direction on p grid'
  ofields(ii)%stagger     = 'center'

  ii = ii + 1
  ofields(ii)%varname     = 'qscx'
  ofields(ii)%varunit     = 'm'
  ofields(ii)%varlong     = 'grid spacing x-direction on q grid'
  ofields(ii)%stagger     = 'corner'

  ii = ii + 1
  ofields(ii)%varname     = 'qscy'
  ofields(ii)%varunit     = 'm'
  ofields(ii)%varlong     = 'grid spacing y-direction on q grid'
  ofields(ii)%stagger     = 'corner'

  ii = ii + 1
  ofields(ii)%varname     = 'uscx'
  ofields(ii)%varunit     = 'm'
  ofields(ii)%varlong     = 'grid spacing x-direction on u grid'
  ofields(ii)%stagger     = 'edge1'

  ii = ii + 1
  ofields(ii)%varname     = 'uscy'
  ofields(ii)%varunit     = 'm'
  ofields(ii)%varlong     = 'grid spacing y-direction on u grid'
  ofields(ii)%stagger     = 'edge1'

  ii = ii + 1
  ofields(ii)%varname     = 'vscx'
  ofields(ii)%varunit     = 'm'
  ofields(ii)%varlong     = 'grid spacing x-direction on v grid'
  ofields(ii)%stagger     = 'edge2'

  ii = ii + 1
  ofields(ii)%varname     = 'vscy'
  ofields(ii)%varunit     = 'm'
  ofields(ii)%varlong     = 'grid spacing y-direction on v grid'
  ofields(ii)%stagger     = 'edge2'

  ii = ii + 1
  ofields(ii)%varname     = 'pang'
  ofields(ii)%varunit     = 'radians'
  ofields(ii)%varlong     = 'angle of p grid w/rt standard lat/lon'
  ofields(ii)%stagger     = 'center'

  ii = ii + 1
  ofields(ii)%varname     = 'cori'
  ofields(ii)%varunit     = 's-1'
  ofields(ii)%varlong     = 'coriolis parameter on q grid'
  ofields(ii)%stagger     = 'center'

  if(ii .ne. nvars_ocn)stop

 end subroutine ocnfields_setup
end module ocnfields
