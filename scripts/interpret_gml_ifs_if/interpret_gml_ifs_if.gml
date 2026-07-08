function interpret_gml_ifs_if(_code, _temp={}, _configs={}, _args=[]){
	if(ml_array_get(_code, ml_line()-1, {name:""}).name=="else")
	{
		if(ml_struct_get(_configs, "ifRun", true))
		{
			return undefined;
		}
	}
	ml_next_line();
	var _cond = gml_run(_code, false, _temp, {}, _args, ml_line());
	ml_next_line();
	_configs[$ "json"]=0;
	var _run = gml_run(_code, false, _temp, _configs, _args,ml_line());
	if(_cond){
		gml_run(_run, true, _temp, _configs, _args)
		_configs[$ "ifRun"]=true;
		return true;
	}
	_configs[$ "ifRun"]=false;
}