#!/bin/bash

export EVALUTION_ROOT=$(pwd)
export CUDA_VISIBLE_DEVICES=3,4,6,7
export PYTHONPATH=$(pwd):$PYTHONPATH
# Install dependency for calvin
# sudo apt-get -y install libegl1-mesa libegl1
# sudo apt-get -y install libgl1

# sudo apt-get update -y -qq
# sudo apt-get install -y -qq libegl1-mesa libegl1-mesa-dev

# sudo apt install -y mesa-utils libosmesa6-dev llvm
# sudo apt-get -y install meso
# sudo apt-get -y build-dep mesa


# !!! Set for your own path
calvin_dataset_path='/home/yzb/calvin/dataset/task_ABCD_D'
# calvin_conf_path
calvin_conf_path="/home/yzb/calvin/calvin_models/conf"
# language model path
lm_path='mpt_dolly_3b'
# lm_path='mpt_9b'
# tokenizer path
tokenizer_path='mpt_dolly_3b'
# tokenizer_path='mpt_9b'


evaluate_from_checkpoint=$1
log_file=$2
use_gripper=$3
use_state=$4
fusion_mode=$5
window_size=$6
export MESA_GL_VERSION_OVERRIDE=4.1
echo logging to ${log_file}
node_num=$7
log_file=${log_file}

if [ ${use_gripper} -eq 1 ] && [ ${use_state} -eq 1 ]
then
torchrun --nnodes=1 --nproc_per_node=${node_num}  --master_port=6067 robot_flamingo/eval/eval_calvin.py \
    --precision fp32 \
    --use_gripper \
    --use_state \
    --window_size ${window_size} \
    --fusion_mode ${fusion_mode} \
    --run_name RobotFlamingoDBG \
    --calvin_dataset ${calvin_dataset_path} \
    --lm_path ${lm_path} \
    --tokenizer_path ${tokenizer_path} \
    --cross_attn_every_n_layers 4 \
    --evaluate_from_checkpoint ${evaluate_from_checkpoint} \
    --calvin_conf_path ${calvin_conf_path} \
    --workers 1 > ${log_file} 2>&1
fi

if [ ${use_gripper} -eq 1 ] && [ ${use_state} -eq 0 ]
then
torchrun --nnodes=1 --nproc_per_node=${node_num}  --master_port=7077 robot_flamingo/eval/eval_calvin.py \
    --precision fp16 \
    --use_gripper \
    --window_size ${window_size} \
    --fusion_mode ${fusion_mode} \
    --run_name RobotFlamingoDBG \
    --calvin_dataset ${calvin_dataset_path} \
    --lm_path ${lm_path} \
    --tokenizer_path ${tokenizer_path} \
    --cross_attn_every_n_layers 4 \
    --evaluate_from_checkpoint ${evaluate_from_checkpoint} \
    --calvin_conf_path ${calvin_conf_path} \
    --workers 1 > ${log_file} 2>&1
fi

if [ ${use_gripper} -eq 0 ] && [ ${use_state} -eq 0 ]
then
torchrun --nnodes=1 --nproc_per_node=${node_num}  --master_port=6066 robot_flamingo/eval/eval_calvin.py \
    --precision fp32 \
    --run_name RobotFlamingoDBG \
    --window_size ${window_size} \
    --fusion_mode ${fusion_mode} \
    --calvin_dataset ${calvin_dataset_path} \
    --lm_path ${lm_path} \
    --tokenizer_path ${tokenizer_path} \
    --cross_attn_every_n_layers 4 \
    --evaluate_from_checkpoint ${evaluate_from_checkpoint} \
    --calvin_conf_path ${calvin_conf_path} \
    --workers 1 > ${log_file} 2>&1
fi