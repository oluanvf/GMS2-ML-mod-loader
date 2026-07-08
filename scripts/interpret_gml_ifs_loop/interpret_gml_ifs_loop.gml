function interpret_gml_loop(_args=[], _temp={}, _configs={}, _isLoop=false, _loopC=[], _inicio=[],_meio=[], _fim=[], _repeater=false, _number=0){
	if(!is_array(_loopC)){_loopC=[_loopC]}
	if(!is_array(_inicio)){_inicio=[_inicio]}
	if(!is_array(_meio)){_meio=[_meio]}
	if(!is_array(_fim)){_fim=[_fim]}
	
	gml_run(_inicio,true,_temp,_configs,_args)
	var _index = 0
	while((_repeater&&_index<_number)||!_isLoop||(_isLoop&&gml_run(_loopC, true, _temp, _configs, _args)))
	{
		gml_run(_meio, true, _temp, _configs, _args);
		if(ml_struct_get(_configs, "continue_", 0)){_configs[$ "continue_"]=0;}
		if(ml_struct_get(_configs, "stop", 0)){_configs[$ "stop"]=1; break}
		if(ml_struct_get(_configs, "return_", 0)){return _configs[$ "forceReturn"]}
		gml_run(_fim, true, _temp, _configs, _args);
		_index++
	}
}