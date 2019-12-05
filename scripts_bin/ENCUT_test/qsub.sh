#!/bin/bash
for i in 400 450 500 550 600 
do
mkdir $i
#in $i
cd $i
cat > INCAR <<!
Global Parameters
  NCORE  =  4
  ISTART =  1            (Read existing wavefunction; if there)
  #ISPIN =  2           (Spin polarised DFT)
  ICHARG =  1         (Non-self-consistent: GGA/LDA band structures)
  LREAL  = Auto          (Projection operators: automatic)
  ENCUT  =  $i        (Cut-off energy for plane wave basis set, in eV)
  #PREC   =  Normal       (Precision level)
  #LWAVE  = .TRUE.        (Write WAVECAR or not)
  #LCHARG = .TRUE.        (Write CHGCAR or not)
  #ADDGRID= .TRUE.        (Increase grid; helps GGA convergence)
  # LVTOT  = .TRUE.      (Write total electrostatic potential into LOCPOT or not)
  # LVHAR  = .TRUE.      (Write ionic + Hartree electrostatic potential into LOCPOT or not)
  # NELECT =             (No. of electrons: charged cells; be careful)
  # LPLANE = .TRUE.      (Real space distribution; supercells)
  # NPAR   = 4           (Max is no. nodes; don't set for hybrids)
  # NWRITE = 2           (Medium-level output)
  # KPAR   = 2           (Divides k-grid into separate groups)
  # NGX    = 500         (FFT grid mesh density for nice charge/potential plots)
  # NGY    = 500         (FFT grid mesh density for nice charge/potential plots)
  # NGZ    = 500         (FFT grid mesh density for nice charge/potential plots)
 
Electronic Relaxation
  ISMEAR =  0            (Gaussian smearing; metals:1)
  SIGMA  =  0.05         (Smearing value in eV; metals:0.2)
  NELM   =  60           (Max electronic SCF steps)
  #NELMIN =  6            (Min electronic SCF steps)
  EDIFF  =  1E-06        (SCF energy convergence; in eV)
  # GGA  =  PS           (PBEsol exchange-correlation)
 
Ionic Relaxation
  NSW    =  100          (Max ionic steps)
  IBRION =  2            (Algorithm: 0-MD; 1-Quasi-New; 2-CG)
  ISIF   =  2            (Stress/relaxation: 2-Ions, 3-Shape/Ions/V, 4-Shape/Ions)
  EDIFFG = -2E-02        (Ionic convergence; eV/AA)
  # ISYM =  2            (Symmetry: 0=none; 2=GGA; 3=hybrids)
!
cp /home/node/rjh/work/ZrS2/ZrS2_0%/KPOINTS .
cp /home/node/rjh/work/ZrS2/ZrS2_0%/POSCAR .
cp /home/node/rjh/work/ZrS2/ZrS2_0%/POTCAR .
echo "ENCUT = $i eV"
nohup mpirun -np 12 vasp_std &
cd -
done

