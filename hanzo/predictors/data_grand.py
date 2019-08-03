# -*- coding:utf-8 -*-

from allennlp.data import DatasetReader, Instance
from allennlp.data.dataset_readers.dataset_utils.span_utils import bio_tags_to_spans
from allennlp.models import Model
from allennlp.predictors import Predictor


@Predictor.register('data_grand')
class DataGrandPredictor(Predictor):
    def __init__(self, model: Model, dataset_reader: DatasetReader) -> None:
        super().__init__(model, dataset_reader)

    def predict_instance(self, instance: Instance) -> str:
        outputs = self._model.forward_on_instance(instance)

        tokens = [str(token) for token in instance.fields['tokens']]

        if 'spans' in outputs:
            spans = outputs['spans']
        else:
            spans = bio_tags_to_spans(outputs['tags'])
        spans.sort(key=lambda t: t[1][0])

        o_start = 0
        res = []
        for c, (start, end) in spans:
            if start != o_start:
                res.append('{}/o'.format('_'.join(tokens[o_start: start])))
            o_start = end + 1
            res.append('{}/{}'.format('_'.join(tokens[start: end+1]), c))

        if o_start < len(tokens):
            res.append('{}/o'.format('_'.join(tokens[o_start: ])))

        return '  '.join(res)

    def dump_line(self, outputs: str) -> str:
        return outputs + '\n'
