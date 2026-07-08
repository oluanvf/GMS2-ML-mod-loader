function interpret_gml_run_parenteses(_code, _temp={}, _configs={}, _args=[]){
	var _tk = _code[ml_line()];
	_configs.mode = "(";
	_configs.tds	= gml_run(_tk.more, false, _temp, _configs, _args);
	_configs.name	= gml_get_arguments(_tk.code, _temp, {}, _args);
	
	if(ml_struct_get(_configs, "new_", 0))
	{
		var _dat					= {}
		var _savCode				= global.ml_ds[$ "privcode"];
		global.ml_ds[$ "privcode"]	=_configs.tds;
		
		with(_dat)
		{
			gml_run(global.ml_ds[$ "privcode"])	
		}
		global.ml_ds[$ "privcode"]	= _savCode;
		
		return _dat
	}
	return gml_run(_configs.tds, true, {}, {}, _configs.name);
};