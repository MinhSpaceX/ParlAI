#!/bin/bash

# CHANGE ME #####################
export TRUNCATE=1000
export LABEL_TRUNCATE=1000
export TEXT_TRUNCATE=1000
export LR=1e-6
export MAX_TRAIN_STEPS=2200000
#######################################
######################################
export OPTIMIZER=adamw
export BATCHSIZE=8
export EVAL_BATCHSIZE=8
export LOG_EVERY_N_STEPS=50
export SVAL=True
export WANDB_PROJECT=dialogue
export WANDB_ENTITY=drewhouston
export MODEL=bart
export WARMUP_UPDATES=100
export DROPOUT=0
export WANDB_LOG=True
export DROPOUT=0
################################

export TASK=fb:taskmaster1:SystemTeacher,fb:taskmaster2:SystemTeacher,fb:taskmaster3:SystemTeacher,fb:msr_e2e:SystemTeacher,fb:metalwoz_internal:SystemTeacher,fb:multidogo:SystemTeacher
export DATA_PATH=/fsx-labs/prajj/tasks/

JOB_NAME='bart_prefinetune_multi'
mkdir -p /fsx-labs/prajj/tasks/pre_finetune/${JOB_NAME}
export MODEL_FILE=/fsx-labs/prajj/tasks/pre_finetune/${JOB_NAME}/$JOB_NAME

#!/bin/bash
python3 parlai/scripts/multiprocessing_train.py \
        --task $TASK  \
        --batchsize $BATCHSIZE \
        --model $MODEL \
        --model_file $MODEL_FILE \
        --eval_batchsize $EVAL_BATCHSIZE \
        --log_every_n_steps $LOG_EVERY_N_STEPS \
        --max_train_steps $MAX_TRAIN_STEPS \
        --datapath $DATA_PATH \
        --truncate $TRUNCATE \
        --text_truncate $TEXT_TRUNCATE \
        --save_every_n_secs 3600 \
        --label_truncate $LABEL_TRUNCATE \
        --optimizer $OPTIMIZER \
        --lr $LR \
        --warmup_updates $WARMUP_UPDATES \
        --dropout $DROPOUT \
        --sval $SVAL \
        --wandb_log $WANDB_LOG \
        --wandb_project $WANDB_PROJECT \
        --wandb_entity $WANDB_ENTITY \
        --wandb_name $JOB_NAME \
"
