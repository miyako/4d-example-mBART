//%attributes = {"invisible":true}
var $OpenAI : cs:C1710.AIKit.OpenAI

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

$ChatCompletionsParameters.body:=Formula from string:C1601("$0:={messages: Null; input: This.input; from: This.from; to: This.to}")

$OpenAI:=cs:C1710.AIKit.OpenAI.new({customHeaders: $customHeaders})
$OpenAI.baseURL:="http://127.0.0.1:8080/v1"
var $ChatCompletionsResult : cs:C1710.AIKit.OpenAIChatCompletionsResult
$ChatCompletionsResult:=$OpenAI.chat.completions.create(Null:C1517; $ChatCompletionsParameters)

var $translations : Collection
$translations:=$ChatCompletionsResult.request.response.body.translations

If ($translations#Null:C1517)
	var $text : Text
	$text:=$translations.at(0).text.at(0)
	ALERT:C41($text)
End if 
