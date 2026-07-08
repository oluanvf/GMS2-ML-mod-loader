function interpret_gml_var(_code, _temp={}, _configs={}, _args=[]){
	var _tds = self;
	var _tk = _code[ml_line()];
	var _name = _tk.name;
	
	if(ml_array_get(_code, ml_line()-1, {name:"a"}).name=="var"||ml_struct_get(_configs, "forceVar", 0)){_tds=_temp; _configs[$ "forceVar"]=0;}
	if(struct_exists(_temp, _name)){_tds=_temp;}else
	if(struct_exists(global.ml_gds, _name)){_tds=global.ml_gds;}
	
	_configs.mode	= ".";
	_configs.tds	= _tds;
	_configs.name	= _name;
	return ml_struct_get(_configs.tds, _configs.name);
};