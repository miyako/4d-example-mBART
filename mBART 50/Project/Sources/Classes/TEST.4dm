property text : Text
property reasoning_content : Text
property tool_calls : Collection

Class constructor
	
Function response($ChatCompletionsResult : cs:C1710.AIKit.OpenAIChatCompletionsResult)
	
	If (Form:C1466=Null:C1517)
		return 
	End if 
	
	If ($ChatCompletionsResult.errors#Null:C1517) && ($ChatCompletionsResult.errors.length#0)
		Form:C1466.error:=$ChatCompletionsResult.errors.extract("message").join("\r")
		return 
	End if 
	
	OBJECT SET ENABLED:C1123(*; "btn.@"; False:C215)
	OBJECT SET ENABLED:C1123(*; "pop.@"; False:C215)
	
	var $wp : 4D:C1709.WriteDocument
	$wp:=OBJECT Get value:C1743("wp.document")
	
	If ($ChatCompletionsResult.success)
		var $ref : Object
		var $headers : Object
		$headers:=$ChatCompletionsResult.request.headers
		var $text; $elementId : Text
		$elementId:=$headers.elementId
		var $translations : Collection
		If ($ChatCompletionsResult.terminated)
			$translations:=$ChatCompletionsResult.request.response.body.translations
			If ($translations#Null:C1517)
				$text:=$translations.at(0).text.at(0)
			End if 
			$ref:=Form:C1466.elements.query("id == :1"; $elementId).first()
			If ($ref=Null:C1517)
				return 
			End if 
			var $element : 4D:C1709.WriteElement
			$ref.translated:=True:C214
			$element:=WP Get element by ID:C1549($wp; $elementId)
			var $r; $range : 4D:C1709.WriteRange
			If ($element#Null:C1517)
				$r:=WP Text range:C1341($element; wk start text:K81:165; wk end text:K81:164)
				WP SELECT:C1348($r)
				$range:=WP Text range:C1341($element; wk start text:K81:165; $r.end-$r.start)
				WP SET TEXT:C1574($range; $text; wk replace:K81:177; wk include in range:K81:180)
			Else 
				TRACE:C157  //accidentally deleted element
			End if 
			If (Form:C1466.elements.countValues(True:C214; "translated")=Form:C1466.elements.length)
				OBJECT SET ENABLED:C1123(*; "pop.@"; True:C214)
				OBJECT SET ENABLED:C1123(*; "btn.@"; True:C214)
				WP SELECT:C1348($wp; wk start text:K81:165; wk start text:K81:165)
			Else 
				Form:C1466.elements.shift()
				Form:C1466.requestOne()
			End if 
		Else 
			//stream
			//$translations:=$ChatCompletionsResult["data"].translations
			//$text:=$translations.at(0).delta
			//$elementId:=$elementIds.at(0)
			//$ref:=Form.elements.query("id == :1"; $elementId).first()
			//If ($ref=Null)
			//return 
			//End if 
			//$ref.translation+=$text
		End if 
	End if 
	
Function demo()
	
	Form:C1466.error:=""
	Form:C1466.elements:=[]
	
	var $wp : 4D:C1709.WriteDocument
	$wp:=OBJECT Get value:C1743("wp.document")
	var $elements : Collection
	$elements:=WP Get elements:C1550($wp; wk type paragraph:K81:191)
	
	var $element : 4D:C1709.WriteElement
	var $ID; $text : Text
	For each ($element; $elements)
		$ID:=Generate UUID:C1066(7)
		$text:=WP Get text:C1575($element)
		If (Match regex:C1019("\\s*"; $text))
			continue
		End if 
		$element.id:=$ID
		Form:C1466.elements.push({id: $ID; input: $text; translation: ""; translated: False:C215})
	End for each 
	
	Form:C1466.requestOne()
	
Function requestOne()
	
/*
	
over-ride AI Kit behaviour
	
*/
	
	var $paragraph : Object
	$paragraph:=Form:C1466.elements.first()
	
	If ($paragraph#Null:C1517)
		
		var $customHeaders : Object
		$customHeaders:={}
		$customHeaders.elementId:=$paragraph.id
		
		var $ChatCompletionsParameters : Object
		$ChatCompletionsParameters:={}
		$ChatCompletionsParameters.input:=$paragraph.input
		$ChatCompletionsParameters.from:="en_XX"
		$ChatCompletionsParameters.to:="fr_XX"
		$ChatCompletionsParameters.formula:=Form:C1466.response
		$ChatCompletionsParameters.stream:=False:C215
		$ChatCompletionsParameters.max_decoding_length:=128
		$ChatCompletionsParameters.beam_size:=4
		$ChatCompletionsParameters.body:=Formula:C1597(body)
		
		var $OpenAI : cs:C1710.AIKit.OpenAI
		$OpenAI:=cs:C1710.AIKit.OpenAI.new({customHeaders: $customHeaders})
		$OpenAI.baseURL:="http://127.0.0.1:8080/v1"
		$OpenAI.chat.completions.create(Null:C1517; $ChatCompletionsParameters)
		
	End if 