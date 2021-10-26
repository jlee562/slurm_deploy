#!/bin/bash
main_in_gen() {
  local Rn="${1:?'ERROR -- main_in_gen -- Rn missing'}"
  local Pr="${2:?'ERROR -- main_in_gen -- Pr missing'}"
  local om="${3:?'ERROR -- main_in_gen -- omega missing'}"
  local al="${4:?'ERROR -- main_in_gen -- alpha missing'}"
  local xm="${5:?'ERROR -- main_in_gen -- xmesh m missing'}"
  local xn="${6:?'ERROR -- main_in_gen -- xmesh n missing'}"
  local xr="${7:?'ERROR -- main_in_gen -- xmesh r missing'}"
  local tm="${8:?'ERROR -- main_in_gen -- tmesh missing'}"
  local az="${9:?'ERROR -- main_in_gen -- aspect ratio z missing'}"
  local np="${10:?'ERROR -- main_in_gen -- number of forcing periods missing'}"
  local md="${11:?'ERROR -- main_in_gen -- program mode missing'}"
  local rc="${12:?'ERROR -- main_in_gen -- initial index for new restart missing'}"
  local rf="${13:?'ERROR -- main_in_gen -- restart missing'}"
  local nf="${14:?'ERROR -- main_in_gen -- prefix missing'}"
  local rd="${15:?'ERROR -- main_in_gen -- results directory missing'}"

  local tM=$(python -c "print('{:d}'.format(int($tm)))")
  local nP=$(python -c "print('{:d}'.format(int($np)))")
  local iG=$(python -c "print('{:d}'.format(int($tm*$np/10.)))")
  local it=$(python -c "print('{:d}'.format(int($tm/1e2)))")

  mode=$md
  if [[ "${rf,,}" == "rest" ]]; then
    mode=0
  fi

  cat << __EOF
'${nf}'   ! prefix                                      (prefix)
'${rf}'   ! name of restart file                        (restart)
${xm}     ! x Cheb Degree                               (M)
${xn}     ! y Cheb Degree                               (N)
${xr}     ! z Cheb Degree                               (R)
${Rn/e/d} ! Buoyancy number                             (Rn)
${om/e/d} ! Nondimensional Forcing Frequency            (omega)
${al/e/d} ! Nondimensional Forcing Amplitude            (alpha)
2d-2      ! Regularization parameter                    (delta)
${Pr/e/d} ! Prandlt number                              (Pr)
2d0       ! inv aspect ratio h/l * 2d0                  (aspx)
${az/e/d} ! inv aspect ratio h/w * 2d0                  (aspz)
5d-7      ! timestep under rest                         (dt)
${tM}     ! number of timesteps per forcing period      (npm)
${nP}     ! number of forcing periods                   (nperiods)
${iG}     ! igraph-save solution every igraph timesteps (igraph)
${it}     ! write to ts_file every its timesteps        (its)
${rc}     ! init_file initial file number               (initfile)
0         ! 0:F,1-3:Kx-Kz,4:Rxy,5:Ryz,6:Rxz,7:Rxyz,8:G  (symspace)
${mode}   ! controls program state                      (pstate)
! ... pstate = 0 from rest
! ...        = 1 continue restart solution, keep t  (use input params)
! ...        = 2 continue restart solution, set t=0 (use input params)
! ...        = 3 continue restart solution, keep t  (use restart params)
__EOF
}


sym_in_gen() {
  local Rn="${1:?'ERROR -- main_in_gen -- Rn missing'}"
  local Pr="${2:?'ERROR -- main_in_gen -- Pr missing'}"
  local om="${3:?'ERROR -- main_in_gen -- omega missing'}"
  local al="${4:?'ERROR -- main_in_gen -- alpha missing'}"
  local xm="${5:?'ERROR -- main_in_gen -- xmesh m missing'}"
  local xn="${6:?'ERROR -- main_in_gen -- xmesh n missing'}"
  local xr="${7:?'ERROR -- main_in_gen -- xmesh r missing'}"
  local tm="${8:?'ERROR -- main_in_gen -- tmesh missing'}"
  local az="${9:?'ERROR -- main_in_gen -- aspect ratio z missing'}"
  local np="${10:?'ERROR -- main_in_gen -- number of forcing periods missing'}"
  local md="${11:?'ERROR -- main_in_gen -- program mode missing'}"
  local rc="${12:?'ERROR -- main_in_gen -- initial index for new restart missing'}"
  local rf="${13:?'ERROR -- main_in_gen -- restart missing'}"
  local nf="${14:?'ERROR -- main_in_gen -- prefix missing'}"
  local rd="${15:?'ERROR -- main_in_gen -- results directory missing'}"

  local tM=$(python -c "print('{:d}'.format(int($tm)))")
  local nP=$(python -c "print('{:d}'.format(int($np)))")
  local iG=$(python -c "print('{:d}'.format(int($tm*$np/10.)))")
  local it=$(python -c "print('{:d}'.format(int($tm/1e2)))")

  mode=$md
  if [[ "$rf" == "rest" ]]; then
    mode=0
  fi

  cat << __EOF
'${nf}'   ! prefix                                      (prefix)
'${rf}'   ! name of restart file                        (restart)
${xm}     ! x Cheb Degree                               (M)
${xn}     ! y Cheb Degree                               (N)
${xr}     ! z Cheb Degree                               (R)
${Rn/e/d} ! Buoyancy number                             (Rn)
${om/e/d} ! Nondimensional Forcing Frequency            (omega)
${al/e/d} ! Nondimensional Forcing Amplitude            (alpha)
2d-2      ! Regularization parameter                    (delta)
${Pr/e/d} ! Prandlt number                              (Pr)
2d0       ! inv aspect ratio h/l * 2d0                  (aspx)
${az/e/d} ! inv aspect ratio h/w * 2d0                  (aspz)
5d-7      ! timestep under rest                         (dt)
${tM}     ! number of timesteps per forcing period      (npm)
${nP}     ! number of forcing periods                   (nperiods)
${iG}     ! igraph-save solution every igraph timesteps (igraph)
${it}     ! write to ts_file every its timesteps        (its)
${rc}     ! init_file initial file number               (initfile)
1         ! 0:F,1-3:Kx-Kz,4:Rxy,5:Ryz,6:Rxz,7:Rxyz,8:G  (symspace)
${mode}   ! controls program state                      (pstate)
! ... pstate = 0 from rest
! ...        = 1 continue restart solution, keep t  (use input params)
! ...        = 2 continue restart solution, set t=0 (use input params)
! ...        = 3 continue restart solution, keep t  (use restart params)
__EOF
}

anim_in_gen() {
  local Rn="${1:?'ERROR -- anim_in_gen -- Rn missing'}"
  local Pr="${2:?'ERROR -- anim_in_gen -- Pr missing'}"
  local om="${3:?'ERROR -- anim_in_gen -- omega missing'}"
  local al="${4:?'ERROR -- anim_in_gen -- alpha missing'}"
  local xm="${5:?'ERROR -- anim_in_gen -- xmesh m missing'}"
  local xn="${6:?'ERROR -- anim_in_gen -- xmesh n missing'}"
  local xr="${7:?'ERROR -- anim_in_gen -- xmesh r missing'}"
  local tm="${8:?'ERROR -- anim_in_gen -- tmesh missing'}"
  local az="${9:?'ERROR -- anim_in_gen -- aspect ratio z missing'}"
  local np="${10:?'ERROR -- anim_in_gen -- number of forcing periods missing'}"
  local md="${11:?'ERROR -- anim_in_gen -- program mode missing'}"
  local rc="${12:?'ERROR -- anim_in_gen -- initial index for new restart missing'}"
  local rf="${13:?'ERROR -- anim_in_gen -- restart missing'}"
  local nf="${14:?'ERROR -- anim_in_gen -- prefix missing'}"
  local rd="${15:?'ERROR -- anim_in_gen -- results directory missing'}"

  local npn=1
  local iGn=$(python -c "print('{:d}'.format(int($tm/1e2)))")
  local it=$(python -c "print('{:d}'.format(int($tm/1e2)))")

  nfn="${nf}_anim"
# rfn=$(/bin/ls -1tr ${nf}*[0-9] |  tail -1)
  rfn=$rf

  mode=$md
  cat << __EOF
'${nfn}'  ! prefix                                      (prefix)
'${rfn}'  ! name of restart file                        (restart)
${xm}     ! x Cheb Degree                               (M)
${xn}     ! y Cheb Degree                               (N)
${xr}     ! z Cheb Degree                               (R)
${Rn/e/d} ! Buoyancy number                             (Rn)
${om/e/d} ! Nondimensional Forcing Frequency            (omega)
${al/e/d} ! Nondimensional Forcing Amplitude            (alpha)
2d-2      ! Regularization parameter                    (delta)
${Pr/e/d} ! Prandlt number                              (Pr)
2d0       ! inv aspect ratio h/l * 2d0                  (aspx)
${az/e/d} ! inv aspect ratio h/w * 2d0                  (aspz)
5d-7      ! timestep under rest                         (dt)
${tm}     ! number of timesteps per forcing period      (npm)
${npn}    ! number of forcing periods                   (nperiods)
${iGn}    ! igraph-save solution every igraph timesteps (igraph)
${it}     ! write to ts_file every its timesteps        (its)
0         ! init_file initial file number               (initfile)
0         ! 0:F,1-3:Kx-Kz,4:Rxy,5:Ryz,6:Rxz,7:Rxyz,8:G  (symspace)
${mode}   ! controls program state                      (pstate)
! ... pstate = 0 from rest
! ...        = 1 continue restart solution, keep t  (use input params)
! ...        = 2 continue restart solution, set t=0 (use input params)
! ...        = 3 continue restart solution, keep t  (use restart params)
__EOF
}

echodate() {
  date "+[%FT%T] ${@}"
}

exe="${HOME}/HTC-example/d3zslat/bin/d3zslat"


