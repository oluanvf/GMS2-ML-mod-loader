function interpret_gml_ifs(_code, _temp={}, _configs={}, _args=[]){
	var _script = ml_language().word[? _code[ml_line()].name];
	if(_script){return _script(_code, _temp, _configs, _args)};
	return 0
};