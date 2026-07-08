function interpret_gml_run_colchetes(_code, _temp={}, _configs={}, _args=[]){
	var _tk			= _code[ml_line()];
	var _mode		= _tk.mode;
	_configs.mode	= _mode;
	var _tds		= gml_run(_tk.more, false, _temp, _configs, _args);
	var _name		= gml_get_arguments(_tk.code, _temp, _configs, _args);
	if(_mode=="$"||_mode=""){_name=_name[0];}
	_configs.mode	= _mode;
	_configs.tds	= _tds;
	_configs.name	= _name;
	
	
	return ml_language().word[? "get"+_mode](_tds, _name);
};