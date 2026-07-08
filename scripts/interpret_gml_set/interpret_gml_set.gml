function interpret_gml_set(_code, _temp={}, _configs={}, _args=[]){
	var _tk		= _code[ml_line()];
	var _val	= undefined;
	
	if(ml_array_get(_code, ml_line()-1, {name:"a"}).name=="var"){_configs[$ "forceVar"]=1; }
	gml_run(_tk.more, false, _temp, _configs, _args);
	
	//novas configurações
	if(_tk.name!="++"&&_tk.name!="--"){
		_val=gml_run(_tk.code, false, _temp, {"forceStatic" : ml_array_get(_code, ml_line()-1, {name:"a"}).name=="static"}, _args);}
	if(_configs.mode=="$"||_configs.mode==""){_configs.name=_configs.name[0];}
	
	ml_language().word[? _tk.name+_configs.mode](_configs.tds, _configs.name, _val);
};