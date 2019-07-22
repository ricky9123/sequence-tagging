local bert = "/path/to/bert";
local bert_size = 768;
local max_pieces = 128;


{
    "dataset_reader": {
        "type": "data_grand",
        "token_indexers": {
            "bert": {
                "type": "bert-pretrained",
                "pretrained_model": bert,
                "max_pieces": max_pieces,
                "truncate_long_sequences": false
            }
        },
    },
    "train_data_path": "resources/datagrand/train.txt",
    "validation_data_path": "resources/datagrand/val.txt",
    "test_data_path": "resources/datagrand/test.txt",
    "model": {
        "type": "crf_tagger",
        "text_field_embedder": {
            "type": "basic",
            "token_embedders": {
                "bert": {
                    "type": "common-bert-pretrained",
                    "pretrained_model": bert,
                    "requires_grad": true,
                    "top_layer_only": false,
                    "max_pieces": max_pieces
                }
            },
            "allow_unmatched_keys": true,
            "embedder_to_indexer_map": {
                "bert": ["bert", "bert-offsets"]
            },
        },
        "encoder": {
            "type": "pass_through",
            "input_dim": bert_size
        },
        "calculate_span_f1": true,
        "label_encoding": "BIO"
    },
    "iterator": {
        "type": "bucket",
        "sorting_keys": [
            [
                "tokens",
                "num_tokens"
            ]
        ],
        "batch_size": 8
    },
    "trainer": {
        "optimizer": {
            "type": "bert_adam",
            "lr": 5e-5,
            "t_total": -1,
            "max_grad_norm": 1.0,
            "weight_decay": 0.01
        },
        "validation_metric": "+f1-measure-overall",
        "num_epochs": 50,
        "patience": 5,
        "num_serialized_models_to_keep": 0,
        "cuda_device": -1
    }
}
