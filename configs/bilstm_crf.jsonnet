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
                    "embedding_dim": 300
                }
            }
        },
        "encoder": {
            "type": "stacked_bidirectional_lstm",
            "input_size": 300,
            "hidden_size": 300,
            "num_layers": 2,
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
        "num_epochs": 50,
        "patience": 5,
        "num_serialized_models_to_keep": 5,
        "cuda_device": -1
    }
}
