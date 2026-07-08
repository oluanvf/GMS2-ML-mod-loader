function ml_shader_compile(_shader, array=[], retArray = [], _dat={i:0},read=true, type="v"){
	var _replace = global.ml_ds.shader.replace;
	while(_dat.i<array_length(array)){
		var _word = array[_dat.i];
		if(struct_exists(_replace, _word))
		{
			var _info = ml_struct_get(_replace, _word)
			array_push(retArray, _info[0])
			for(var i = 1; i < array_length(_info); i++)
			{
				_dat.i+=1;
				ml_shader_compile(_shader, array, retArray, _dat, false, _info[i])
			}
		}else
		if(ml_isReal(_word)){
			var _val = real(_word)
			if(_val < 0){array_push(retArray, -4)}
			array_push(retArray, abs(_val))
		}else
		if(_word!="")
		{
			var _find = _shader.vars[? _word]
			if(!ds_map_exists(_shader.vars, _word)){show_message(_word + string(_shader.vars[? _word]))}
			if(type=="v"){array_push(retArray, -2)}
			array_push(retArray, _find)	
		}
		if(!read){break}
		_dat.i+=1;
	}
	return retArray;
}
	
	
