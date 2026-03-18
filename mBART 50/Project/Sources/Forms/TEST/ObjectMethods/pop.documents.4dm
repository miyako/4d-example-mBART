If (FORM Event:C1606.code=On Data Change:K2:15)
	
	var $documents : Object
	$documents:=Form:C1466.documents
	var $path : Text
	$path:=$documents.files[$documents.index].platformPath
	var $document : 4D:C1709.WriteDocument
	$document:=WP Import document:C1318($path)
	OBJECT SET VALUE:C1742("wp.document"; $document)
	
End if 