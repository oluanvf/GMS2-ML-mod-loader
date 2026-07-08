function interpret_gml_ifs_else(_code, _temp={}, _configs={}, _args=[]){
	if(ml_array_get(_code, ml_line()+1, {name:""}).name=="if"||ml_struct_get(_configs, "ifRun", true)){return 1}
	
	ml_next_line()
	_configs[$ "json"]=0;
	var _run = gml_run(_code, false, _temp, _configs, _args,  ml_line());
	gml_run(_run, true, _temp, _configs);
	_configs[$ "ifRun"]=true;
	return true;
}