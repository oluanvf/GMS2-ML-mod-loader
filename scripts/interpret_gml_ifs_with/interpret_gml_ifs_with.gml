function interpret_gml_ifs_with(_code, _temp={}, _configs={}, _args=[]){
	ml_next_line()
	var _obj					= gml_run(_code, false, _temp, _configs, _args, ml_line());
	ml_next_line()
	var _run					= gml_run(_code, false, _temp, _configs, _args, ml_line());
	var _savCode				= global.ml_ds[$ "privcode"];
	global.ml_ds[$ "privcode"]	= _run;
	with(_obj)
	{
		gml_run(global.ml_ds[$ "privcode"])	
	}
	global.ml_ds[$ "privcode"]	= _savCode;
}