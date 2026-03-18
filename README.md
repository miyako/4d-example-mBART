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

## Languages

```
{"ar", "ar_AR"}, {"cs", "cs_CZ"}, {"de", "de_DE"}, {"en", "en_XX"},
{"es", "es_XX"}, {"et", "et_EE"}, {"fi", "fi_FI"}, {"fr", "fr_XX"},
{"gu", "gu_IN"}, {"hi", "hi_IN"}, {"it", "it_IT"}, {"ja", "ja_XX"},
{"kk", "kk_KZ"}, {"ko", "ko_KR"}, {"lt", "lt_LT"}, {"lv", "lv_LV"},
{"my", "my_MM"}, {"ne", "ne_NP"}, {"nl", "nl_XX"}, {"ro", "ro_RO"},
{"ru", "ru_RU"}, {"si", "si_LK"}, {"tr", "tr_TR"}, {"vi", "vi_VN"},
{"zh", "zh_CN"}, {"af", "af_ZA"}, {"az", "az_AZ"}, {"bn", "bn_IN"},
{"fa", "fa_IR"}, {"he", "he_IL"}, {"hr", "hr_HR"}, {"id", "id_ID"},
{"ka", "ka_GE"}, {"km", "km_KH"}, {"mk", "mk_MK"}, {"ml", "ml_IN"},
{"mn", "mn_MN"}, {"mr", "mr_IN"}, {"pl", "pl_PL"}, {"ps", "ps_AF"},
{"pt", "pt_XX"}, {"sl", "sl_SI"}, {"sq", "sq_AL"}, {"sv", "sv_SE"},
{"sw", "sw_KE"}, {"ta", "ta_IN"}, {"te", "te_IN"}, {"th", "th_TH"},
{"tl", "tl_XX"}, {"uk", "uk_UA"}, {"ur", "ur_PK"}, {"xh", "xh_ZA"},
{"gl", "gl_ES"}, {"ms", "ms_MY"}
```
