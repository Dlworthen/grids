module charstrings

  implicit none

  character(len=20) :: dirout = '/data1/GRIDS/'
  !character(len=20) :: dirout = '/data1/TEST/'
#ifdef hycom_024
  character(len=60) :: dirsrc = '/data1/GRIDS/DATA/input_024/'
  character(len=60) ::  ocngridcdf = 'hycom_grid_024.nc'
  character(len=60) ::  icegridcdf =  'cice_grid_024.nc'
  character(len=60) :: kissgridcdf =  'kiss_grid_024.nc'
#endif
#ifdef hycom_008
  character(len=60) :: dirsrc = '/data1/GRIDS/DATA/input_008/'
  character(len=60) ::  ocngridcdf = 'hycom_grid_008.nc'
  character(len=60) ::  icegridcdf =  'cice_grid_008.nc'
  character(len=60) :: kissgridcdf =  'kiss_grid_008.nc'
#endif
#ifdef hycom_072
  character(len=60) :: dirsrc = '/data1/GRIDS/DATA/input_072/'
  character(len=60) ::  ocngridcdf = 'hycom_grid_072.nc'
  character(len=60) ::  icegridcdf =  'cice_grid_072.nc'
  character(len=60) :: kissgridcdf =  'kiss_grid_072.nc'
#endif
end module charstrings
