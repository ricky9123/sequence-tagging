local bert = "/path/to/bert";
local bert_size = 768;
local max_pieces = 128;

local token_size = 300;


{
    "dataset_reader": {
        "type": "data_grand",
        "token_indexers": {
            "tokens": {
                "type": "single_id"
            },
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
                "tokens": {
                    "type": "embedding",
                    "embedding_dim": token_size
                },
                "bert": {
                    "type": "common-bert-pretrained",
                    "pretrained_model": bert,
                    "requires_grad": false,
                    "top_layer_only": true,
                    "max_pieces": max_pieces
                }
            },
            "allow_unmatched_keys": true,
            "embedder_to_indexer_map": {
                "bert": ["bert", "bert-offsets"],
                "tokens": ["tokens"]
            },
        },
        "encoder": {
            "type": "stacked_bidirectional_lstm",
            "input_size": bert_size + token_size,
            "hidden_size": 300,
            "num_layers": 3,
            "recurrent_dropout_probability": 0.5,
            "layer_dropout_probability": 0.5
        },
        "calculate_span_f1": true,
        "label_encoding": "BIO",
        "dropout": 0.5
    },
    "iterator": {
        "type": "bucket",
        "sorting_keys": [
            [
                "tokens",
                "num_tokens"
            ]
        ],
        "batch_size": 32
    },
    "trainer": {
        "optimizer": {
            "type": "adam",
            "weight_decay": 0.00005
        },
        "learning_rate_scheduler": {
            "type": "step",
            "step_size": 1,
            "gamma": 0.95
        },
        "validation_metric": "+f1-measure-overall",
        "num_epochs": 100,
        "patience": 10,
        "num_serialized_models_to_keep": 0,
        "cuda_device": -1
    }
}
