function ml_shader_create(_str){
	var _arr	= string_split(string_replace_all(_str,"\r", "\n"), "\n")
	var _shader = {vars : ds_map_create(), memory : 0}
	ds_map_add(_shader.vars, "color", 0);		_shader.memory+=4;
	ds_map_add(_shader.vars, "textcoord", 4);	_shader.memory+=2;
	
	var _tag = "fsh";
	for(var i = 0; i < array_length(_arr); i++){
		if(!struct_exists(_shader, _tag)){ml_struct_set(_shader, _tag, "")}
		
		_str = _arr[i];
		if(string_pos("func", _str)==1)
		{
			var _split = string_split(_str, " ");
			ds_map_add(_shader.vars, _split[1], _shader.memory);
			_shader.memory	+=1;
			_shader[$ _tag] += " "+_str;
		}else
		if(string_pos("#tag", _str)==1)
		{
			var _split = string_split(_str, " ")
			_tag=_split[1]
		}else
		if(string_pos("#gpu", _str)==1)
		{
			var _split = string_split(_str, " ");
			ds_map_add(_shader.vars, _split[2], _shader.memory);
			_shader.memory+=int64(_split[1]);
		}else
		if(string_pos("//", _str)==0){
			_shader[$ _tag] += " "+_str
		}
	}

	var	_tagsToConvert = ["fsh", "vsh"]


	for(var i = 0; i < array_length(_tagsToConvert); i++)
	{
		if(!struct_exists(_shader, _tagsToConvert[i])){continue}
		var _arr	= string_split(string_replace_all(string_replace_all(_shader[$ _tagsToConvert[i]], "\n", " "), "	", " " ), " ")
		_shader[$ _tagsToConvert[i]] = ml_shader_compile(_shader,_arr);
	}
	
	if(array_length(_shader.fsh)<global.ml_ds.shader.size){array_push(_shader.fsh, -200)}
	_shader.array=array_create(100, -1);
	return _shader

}