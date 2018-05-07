#!/bin/bash
#SBATCH --job-name=pointnet2    # Job name
#SBATCH --mail-type=FAIL,END               # Mail events (NONE, BEGIN, END, FAIL, AL$
#SBATCH --mail-user=benweinstein2010@gmail.com   # Where to send mail
#SBATCH --account=ewhite

#SBATCH --ntasks=1                 # Number of MPI ranks
#SBATCH --cpus-per-task=1            # Number of cores per MPI rank
#SBATCH --time=24:00:00       #Time limit hrs:min:sec
#SBATCH --output=/home/b.weinstein/logs/pointnet2.out   # Standard output and error log
#SBATCH --error=/home/b.weinstein/logs/pointnet2.err
#SBATCH --mem-per-cpu=1000
#SBATCH --partition=gpu
#SBATCH --gres=gpu:tesla:1

#activate conda environment
source activate pointnet

ml cuda

#python -c "import tensorflow;print(tensorflow.__version__)"

python /home/b.weinstein/pointnet2/hpc/test_gpu.py

date
