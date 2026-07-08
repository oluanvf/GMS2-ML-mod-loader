function hl_text_in_rectangle(_str, _width, _height, _scale=hl_line_height()/string_height(_str), _x=0){	
	var _arr	= string_split(_str, "\n")
	_str		= "";
	for(var i = 0; i < array_length(_arr);i++){
		var _st = _arr[i]
		if(string_height("|")*(array_length(_arr)-1)>_height){return _str}
		_str += string_copy(_st,(string_length(_st))*(_x/(string_width(_st)*_scale)), (string_length(_st))*(_width/(string_width(_st)*_scale)))
	}
	return _str
	
}