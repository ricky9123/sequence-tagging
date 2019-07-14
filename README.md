# Sequence-Tagging

## Run

Train:

```bash
allennlp train configs/baseline.jsonnet -s outputs/baseline -f --include-package hanzo
```

Predict:
```bash
allennlp predict outputs/baseline/model.tar.gz resources/datagrand/test.txt \
                 --include-package hanzo \
                 --predictor data_grand \
                 --use-dataset-reader \
                 --silent \
                 --output-file result.txt
```
