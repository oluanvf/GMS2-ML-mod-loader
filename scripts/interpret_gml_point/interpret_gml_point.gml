function interpret_gml_point(_code, _temp={}, _configs={}, _args=[]){
	var _tk			= _code[ml_line()];
	_configs.mode	= ".";
	_configs.tds	= gml_run(_tk.code, false, _temp, _configs, _args);
	_configs.name	= _tk.code[array_length(_tk.code)-1].name;
	_configs.mode	= ".";
	return ml_struct_get(_configs.tds, _configs.name);
};