## [facebook/mbart-large-50-many-to-many-mmt](https://huggingface.co/facebook/mbart-large-50-many-to-many-mmt)

```4d
var $OpenAI : cs.AIKit.OpenAI

var $customHeaders : Object
$customHeaders:={}

var $ChatCompletionsParameters : Object
$ChatCompletionsParameters:={}
$ChatCompletionsParameters.input:="The cat sat on the mat"
$ChatCompletionsParameters.from:="en_XX"
$ChatCompletionsParameters.to:="fr_XX"

/*
	
	over-ride AI Kit behaviour
	
*/

$ChatCompletionsParameters.body:=Formula from string("$0:={messages: Null; input: This.input; from: This.from; to: This.to}")

$OpenAI:=cs.AIKit.OpenAI.new({customHeaders: $customHeaders})
$OpenAI.baseURL:="http://127.0.0.1:8080/v1"
var $ChatCompletionsResult : cs.AIKit.OpenAIChatCompletionsResult
$ChatCompletionsResult:=$OpenAI.chat.completions.create(Null; $ChatCompletionsParameters)

var $translations : Collection
$translations:=$ChatCompletionsResult.request.response.body.translations

If ($translations#Null)
	var $text : Text
	$text:=$translations.at(0).text.at(0)
	ALERT($text)
End if 
```

<img width="480" height="159" alt="Screenshot 2026-03-18 at 23 03 52" src="https://github.com/user-attachments/assets/fb3e9481-6884-4ea2-a48d-e4a85690a82e" />

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
