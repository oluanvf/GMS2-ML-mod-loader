function interpret_gml_ifs_while(_code, _temp={}, _configs={}, _args=[]){
	ml_next_line();
	var _loop = _code[ml_line()];
	ml_next_line();
	_configs[$ "json"]=0;
	var _step = gml_run(_code, false, _temp, _configs, _args, ml_line())
	interpret_gml_loop(_args, _temp, _configs, true, _loop,[],_step)
}