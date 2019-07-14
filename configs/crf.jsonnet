{
    "dataset_reader": {
        "type": "data_grand"
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
                    "embedding_dim": 200
                }
            }
        },
        "encoder": {
            "type": "stacked_bidirectional_lstm",
            "input_size": 200,
            "hidden_size": 200,
            "num_layers": 1
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
        "batch_size": 32
    },
    "trainer": {
        "optimizer": {
            "type": "adam"
        },
        "validation_metric": "+f1-measure-overall",
        "num_epochs": 100,
        "patience": 10,
        "cuda_device": -1,
        "num_serialized_models_to_keep": 0
    }
}
