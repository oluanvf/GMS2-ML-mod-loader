function interpret_gml_ifs_for(_code, _temp={}, _configs={}, _args=[]){
	ml_next_line();
	var _comps	= _code[ml_line()].code;
	var _rulers	= [];
	var _dp	= 0
	for(var i =0 ; i <array_length(_comps); i++)
	{
		if(array_length(_rulers)==_dp){array_push(_rulers, [])}
		if(_comps[i].name==";")
		{
			_dp+=1;
		}else
		{
			array_push(_rulers[_dp], _comps[i])
		}
	}
	ml_next_line();
	_configs[$ "json"]=0;
	var _step = gml_run(_code, false, _temp, _configs, _args, ml_line())
	
	return interpret_gml_loop(_args, _temp, _configs,true, _rulers[1], _rulers[0], _step, _rulers[2])
}