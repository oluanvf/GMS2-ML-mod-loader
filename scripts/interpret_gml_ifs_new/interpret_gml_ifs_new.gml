function interpret_gml_ifs_new(_code, _temp={}, _configs={}, _args=[]){
	var _new			= _configs[$ "new_"];
	var _tk				=  _code[ml_line()];
	_configs[$ "new_"]	= 1;
	var _val			= gml_run(_tk.code, 0, _temp, _configs);
	_configs[$ "new_"]	= _new;
	
	return _val
}