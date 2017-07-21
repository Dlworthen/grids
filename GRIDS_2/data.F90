module data

 use param

 implicit none

  integer(kind=4), dimension(ihycom,jhycom) :: land
  ! masks on p grid
  integer(kind=4), dimension(ihycom,jhycom) :: ip
  ! masks on other grids
  integer(kind=4), dimension(ihycom,jhycom) :: iq
  integer(kind=4), dimension(ihycom,jhycom) :: iu
  integer(kind=4), dimension(ihycom,jhycom) :: iv

     real(kind=4), dimension(ihycom,jhycom) :: depths

     real(kind=4), dimension(ihycom,jhycom) :: plon, plat, &
                                               qlon, qlat, &
                                               ulon, ulat, &
                                               vlon, vlat, &
                                               pscx, pscy, &
                                               qscx, qscy, &
                                               uscx, uscy, &
                                               vscx, vscy, &
                                               pang, cori

end module data
