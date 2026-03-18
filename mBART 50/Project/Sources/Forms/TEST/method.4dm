var $event : Object
$event:=FORM Event:C1606

Case of 
	: ($event.code=On Load:K2:1)
		
		var $homeFolder : 4D:C1709.Folder
		$homeFolder:=Folder:C1567(fk home folder:K87:24).folder(".CTranslate2")
		
		var $LLM : cs:C1710.LLM
		$LLM:=cs:C1710.LLM.new(\
			$homeFolder.folder("mbart-large-50-many-to-many-mmt"); \
			"mbart-large-50-many-to-many-mmt-ct2-int8"; \
			"keisuke-miyako/mbart-large-50-many-to-many-mmt-ct2-int8"; $homeFolder; \
			Current form window:C827; Formula:C1597(OnLLM))
		
		var $files : Collection
		$files:=Folder:C1567(fk resources folder:K87:11).files(fk ignore invisible:K87:22 | fk recursive:K87:7).query("extension == :1"; ".docx")
		
		var $documents : Object
		$documents:={values: []; currentValue: Null:C1517; files: $files}
		$documents.values:=$files.extract("fullName")
		$documents.index:=$documents.values.length#0 ? 0 : -1
		Form:C1466.documents:=$documents
		
		var $path : Text
		If ($documents.index#-1)
			$path:=$documents.files[$documents.index].platformPath
			var $document : 4D:C1709.WriteDocument
			$document:=WP Import document:C1318($path)
			OBJECT SET VALUE:C1742("wp.document"; $document)
		End if 
		
		OBJECT SET VISIBLE:C603(*; "progress"; Not:C34($LLM.available))
		OBJECT SET VISIBLE:C603(*; "btn.@"; $LLM.available)
		
End case 