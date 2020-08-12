#!/bin/bash
#$ -o qsub_output
#$ -S /bin/bash
#$ -j y
#$ -cwd
#$ -l gpu=1
#$ -l h_vmem=40G
#$ -q gpu.24h.q

source /scratch_net/unclemax/alexmir/anaconda3/etc/profile.d/conda.sh
conda activate pytorch101

DATA_ROOT=/scratch_net/unclemax/alexmir/train_dataKittyOdom
TRAIN_SET=$DATA_ROOT/
python train.py "$@" $TRAIN_SET \
--resnet-layers 18 \
--num-scales 1 \
-b2 -s0.1 -c0.5 --epoch-size 1000 --sequence-length 3 \
--with-ssim 1 \
--with-mask 1 \
--with-auto-mask 1 \
--with-pretrain 1 \
--log-output \
--name resnet18_pose_256_conventional