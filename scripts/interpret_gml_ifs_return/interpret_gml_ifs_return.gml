function interpret_gml_ifs_return(_code, _temp={}, _configs={}, _args=[]){
	ml_next_line();
	_configs[$ "forceReturn"] = gml_run(_code, false, _temp, _configs, _args, ml_line());
	_configs[$ "return_"]		= 1;
	return _configs[$ "forceReturn"];
}