function gml_add_extension(_file, _name, _restype=ty_real, _args=[]){
	if(!is_array(_file)){_file=[_file]}
	var _build = [_file, _name, dll_cdecl, _restype, array_length(_args)]
	var _defs  = [] 
	for(var i = 0; i < array_length(_args); i++)
	{
		var _dat = _args[i]
		var _arg = ty_string;
		var _def = _dat;
		if(!is_string(_def)){
			_arg=ty_real;	
		}
		array_push(_build, _arg)
		array_push(_defs, _def)
	}
	var _func = undefined;
	for(var i = 0; i < array_length(_file); i++)
	{
		_build[0]=_file[i]
		try{
			if(file_exists(_file[i]))
			{
				_func = script_execute_ext(external_define, _build)
			}else
			{
				show_debug_message($"extension '{_file[i]}' not found")	
			}
		}catch(e)
		{
			show_debug_message($"extension '{_file[i]}' not supported")
			continue;	
		}
	}
	var _data = {type:1, def : _defs, func : _func}
	global.ml_ds[$ filename_name(_file)] = _data;
	return _data;
}