!
!  Copyright 2016 ARTED developers
!
!  Licensed under the Apache License, Version 2.0 (the "License");
!  you may not use this file except in compliance with the License.
!  You may obtain a copy of the License at
!
!      http://www.apache.org/licenses/LICENSE-2.0
!
!  Unless required by applicable law or agreed to in writing, software
!  distributed under the License is distributed on an "AS IS" BASIS,
!  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
!  See the License for the specific language governing permissions and
!  limitations under the License.
!

! Copyright (C) 2013 Shunsuke A. Sato.
! Device number 10-99: temporary files, 100: permanent files
! 102:trim(SYSname)//'_jac.out'
! 103:trim(SYSname)//'_nex.out'

program main
  use global_variables
  implicit none

  call preparation

  select case(calc_mode)
  case('RT')
    call PSE_ground_state_calculation
    call PSE_real_time_propagation
  case('BD')
    call PSE_ground_state_calculation
    call PSE_band_calculation
  case('GS')
    call PSE_ground_state_calculation
    if(myrank == 0)then
      open(99,file="Vloc_gs.out",form='unformatted')
      write(99)Vloc
      close(99)
    end if
  case default
    err_message='invalid calc_mode'
    call err_finalize
  end select

  call MPI_FINALIZE(ierr)
end program main

