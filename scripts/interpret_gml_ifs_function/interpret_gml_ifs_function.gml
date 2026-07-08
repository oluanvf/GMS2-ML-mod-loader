function interpret_gml_ifs_function(_code, _temp={}, _configs={}, _args=[]){
	var _tk				= _code[ml_line()];
	var _ret = _tk.code
	_configs[$ "json"]	= 0;
	if(!is_undefined(_tk[$ "fname"]))
	{
		ml_struct_set(global.ml_gds, _tk.fname, _ret)
	}
	if(ml_struct_get(_configs, "forceStatic", 0))
	{
		var _self = self;
		_ret = {type : 0, data : _self, func : _ret}
		_configs.forceStatic=0;
	}
	
	return _ret;
}