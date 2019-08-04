# Sequence-Tagging

## Dataset

The introduction to dataset: [README.md](./resources/datagrand).

## Pre-trained Word Embedding & Language Model

 - Convert your BERT from tensorflow to pytorch: `scripts/bert_convert.sh`.
 - Train your GloVe using [stanfordnlp/GloVe](https://github.com/stanfordnlp/GloVe): `scripts/glove_train.sh`.

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
