## [facebook/mbart-large-50-many-to-many-mmt](https://huggingface.co/facebook/mbart-large-50-many-to-many-mmt)

||`max_position_embeddings`|`max_length`
|-|-:|-:|
|mbart-large-50-many-to-many-mmt|`1024`|`200`
|mbart-large-50-many-to-one-mmt|`1024`|`200`
|mbart-large-50-one-to-many-mmt|`1024`|`200`

## one to many

```
curl -X POST http://127.0.0.1:8080/v1/chat/completions \
     -H "Content-Type: application/json" \
     -d '{
  "input": [
    "The weather is beautiful today.",
    "The weather is very bad today." 
  ],
  "max_length": 128,
  "beam_size": 4,
  "to": "fr_XX",
  "stream": false
}'
```

## many to one / many to many

```
curl -X POST http://127.0.0.1:8080/v1/chat/completions \
     -H "Content-Type: application/json" \
     -d '{
  "input": [
    "Le temps est beau aujourd\u0027hui.",
    "Le temps est tr\u00e8s mauvais aujourd\u0027hui."
  ],
  "max_length": 128,
  "beam_size": 4,
  "from": "fr_XX",
  "to": "en_XX",
  "stream": false
}'
```
