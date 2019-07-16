# -*- coding:utf-8 -*-

from allennlp.modules.token_embedders.token_embedder import TokenEmbedder
from allennlp.modules.token_embedders.bert_token_embedder import BertEmbedder, PretrainedBertModel


@TokenEmbedder.register("common-bert-pretrained")
class PretrainedBertEmbedder(BertEmbedder):
    def __init__(self, pretrained_model: str, max_pieces: int = 512, requires_grad: bool = False, top_layer_only: bool = False) -> None:
        model = PretrainedBertModel.load(pretrained_model)

        for param in model.parameters():
            param.requires_grad = requires_grad

        super().__init__(bert_model=model, max_pieces=max_pieces, top_layer_only=top_layer_only)
