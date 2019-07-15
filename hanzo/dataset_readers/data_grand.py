# -*- coding:utf-8 -*-

from typing import Dict, Iterable, List

from allennlp.data import Instance
from allennlp.data.dataset_readers import DatasetReader
from allennlp.data.fields import SequenceLabelField, TextField
from allennlp.data.token_indexers import SingleIdTokenIndexer, TokenIndexer
from allennlp.data.tokenizers import Token


@DatasetReader.register('data_grand')
class DataGrandReader(DatasetReader):
    def __init__(self, token_indexers: Dict[str, TokenIndexer] = None):
        super(DataGrandReader, self).__init__(lazy=False)

        self.token_indexers = token_indexers if token_indexers else {'tokens': SingleIdTokenIndexer()}

    def _read(self, file_path: str) -> Iterable[Instance]:
        with open(file_path, encoding='utf-8') as f:
            for line in f:
                instance_words = []
                instance_labels = []
                for seq in line.strip().split():
                    seq = seq.split('/')

                    if len(seq) == 2:
                        words, label = seq
                    elif len(seq) == 1:
                        words, label = seq[0], None
                    else:
                        raise RuntimeError(f'Unknown Error in Dataset {file_path} at {seq}')

                    words = words.split('_')
                    instance_words.extend(words)
                    if label is None:
                        instance_labels = None
                    else:
                        instance_labels.extend(self.bio(label, len(words)))

                yield self.text_to_instance(instance_words, instance_labels)

    def text_to_instance(self, words: List[str], labels: List[str] = None) -> Instance:
        fields = dict()

        fields['tokens'] = TextField([Token(word) for word in words], self.token_indexers)
        if labels:
            fields['tags'] = SequenceLabelField(labels=labels,
                                                sequence_field=fields['tokens'])

        return Instance(fields)

    @staticmethod
    def bio(label, length):
        if label == 'o':
            return ['O'] * length
        else:
            return [f'B-{label}'] + [f'I-{label}' for _ in range(length - 1)]
