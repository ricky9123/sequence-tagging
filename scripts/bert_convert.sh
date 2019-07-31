#!/usr/bin/env bash

export BERT_BASE_DIR=.
pytorch_pretrained_bert convert_tf_checkpoint_to_pytorch   $BERT_BASE_DIR/bert_model.ckpt  $BERT_BASE_DIR/bert_config.json   $BERT_BASE_DIR/pytorch_model.bin
