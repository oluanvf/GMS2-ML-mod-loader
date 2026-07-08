function interpret_gml_ifs_continue(_code, _temp={}, _configs={}, _args=[]){
	_configs[$ "continue_"]=1;
	return _configs[$ "forceReturn"];
}