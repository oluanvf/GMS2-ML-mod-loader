function ml_interpret(_code, _ler=true, _temp={}, _configs={}, _args=[]){
	if(ml_line()>=array_length(_code)){exit}
	var _tk		= _code[ml_line()];
	var _lanq	= ml_language();
	var _ret	= undefined;
	
	if(_configs[$ "stop"]){_configs[$ "stop"]=0; return _configs[$ "forceReturn"]}
	

	if(ds_map_exists(_lanq.interpret, _tk.token))
	{
		_ret = _lanq.interpret[? _tk.token](_code, _temp, _configs, _args);
	}
	if(_configs[$ "return_"]||_configs[$ "continue_"]){return _configs[$ "forceReturn"]}
	
	if(_ler&&ml_line()+1<array_length(_code))
	{	
		ml_next_line();
		_ret = ml_interpret(_code, _ler, _temp, _configs, _args);
	}
	return _ret;
}