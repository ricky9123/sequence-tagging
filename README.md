# Sequence-Tagging

## Run

Train:

```bash
allennlp train configs/bilstm_crf.jsonnet -s outputs/bilstm_crf -f --include-package hanzo
```

Predict:
```bash
allennlp predict outputs/bilstm_crf/model.tar.gz resources/datagrand/test.txt \
                 --include-package hanzo \
                 --predictor data_grand \
                 --use-dataset-reader \
                 --silent \
                 --output-file result.txt
```
