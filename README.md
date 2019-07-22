# Sequence-Tagging

## Run

Train:

```bash
allennlp train configs/bert_bilstm_crf.jsonnet -s outputs/bert/baseline_2.4 -f --include-package hanzo
```

Predict:
```bash
allennlp predict outputs/bert/baseline_2.31/model.tar.gz resources/datagrand/test.txt \
                 --include-package hanzo \
                 --predictor data_grand \
                 --use-dataset-reader \
                 --cuda-device 2 \
                 --weights-file outputs/bert/baseline_2.31/model_state_epoch_45.th \
                 --output-file result.txt
```
