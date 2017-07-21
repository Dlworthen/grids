module icefields

  use param

  implicit none

  type IceFieldsDefs
    character(len=12)                           :: varname
    character(len=12)                           :: varunit
    character(len=60)                           :: varlong
    character(len=12)                           :: stagger
  end type IceFieldsDefs

  type(IceFieldsDefs) :: ifields(nvars_ice)

  contains

  subroutine icefields_setup

  integer :: i
  integer :: ii = 0

  ii = ii + 1
  ifields(ii)%varname     = 'tlat'
  ifields(ii)%varunit     = 'radians'
  ifields(ii)%varlong     = 'Latitude of T points'
  ifields(ii)%stagger     = 'center'

  ii = ii + 1
  ifields(ii)%varname     = 'tlon'
  ifields(ii)%varunit     = 'radians'
  ifields(ii)%varlong     = 'Longitude of T points'
  ifields(ii)%stagger     = 'center'

  ii = ii + 1
  ifields(ii)%varname     = 'ulat'
  ifields(ii)%varunit     = 'radians'
  ifields(ii)%varlong     = 'Latitude of U points'
  ifields(ii)%stagger     = 'corner'

  ii = ii + 1
  ifields(ii)%varname     = 'ulon'
  ifields(ii)%varunit     = 'radians'
  ifields(ii)%varlong     = 'Longitude of U points'
  ifields(ii)%stagger     = 'corner'

  ii = ii + 1
  ifields(ii)%varname     = 'htn'
  ifields(ii)%varunit     = 'cm'
  ifields(ii)%varlong     = 'Width of T cells on N side'
  ifields(ii)%stagger     = 'center'

  ii = ii + 1
  ifields(ii)%varname     = 'hte'
  ifields(ii)%varunit     = 'cm'
  ifields(ii)%varlong     = 'Width of T cells  on E side'
  ifields(ii)%stagger     = 'center'

  ii = ii + 1
  ifields(ii)%varname     = 'angle'
  ifields(ii)%varunit     = 'radians'
  ifields(ii)%varlong     = 'Rotation Angle  of U cells'
  ifields(ii)%stagger     = 'corner'

  ! fields that are now in kmt
  ii = ii + 1
  ifields(ii)%varname     = 'tarea'
  ifields(ii)%varunit     = 'm2'
  ifields(ii)%varlong     = 'area of T cells'
  ifields(ii)%stagger     = 'center'

  ii = ii + 1
  ifields(ii)%varname     = 'kmt'
  ifields(ii)%varunit     = 'nd'
  ifields(ii)%varlong     = 'Land Sea mask of T cells'
  ifields(ii)%stagger     = 'center'

  if(ii .ne. nvars_ice)stop

 end subroutine icefields_setup
end module icefields
