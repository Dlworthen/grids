module param

  implicit none
#ifdef hycom_024
  !Hycom 0.25 grid (tripole)
  integer, parameter ::  ihycom = 1500,  jhycom = 1100
#endif
#ifdef hycom_008
  !Hycom 1/12 grid (tripole)
  integer, parameter ::  ihycom = 4500,  jhycom = 3298
#endif
#ifdef hycom_072
  !Hycom 1/12 grid (tripole)
  integer, parameter ::  ihycom = 500,  jhycom = 382
#endif

  integer, parameter :: nvars_ocn =  1 &  !land
                                  +  4 &  !ip,iu,iv,iq
                                  +  1 &  !bathy
                                  + 18   

  integer, parameter :: nvars_ice =  4 &  !tlat,tlon,ulat,ulon
                                  +  2 &  !htn,hte
                                  +  1 &  !angle
                                  +  2    !land,tarea,from kmtu...

end module param
