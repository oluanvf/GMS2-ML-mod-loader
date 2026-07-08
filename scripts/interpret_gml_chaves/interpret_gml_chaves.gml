function interpret_gml_chaves(_code, _temp={}, _configs={}, _args=[]){
	var _tk = _code[ml_line()]
	var _ret = _tk.code;
	if(ml_struct_get(_configs, "json", true))
	{
		_ret = {}
		var _last = {name:"", token:"str"}
		var _sav = ml_savData();
		
		for(var i = 0; i < array_length(_tk.code);i++)
		{
			var _ntk = 	_tk.code[i]
			if(_ntk.name==":")
			{
				
				ml_set_line(i+1);
				var _name = _last.name
				if(_last.token=="str"){_name=string_copy(_name, 2, string_length(_name)-2)}
				_ret[$ _name]=gml_run(_tk.code, false, _temp, _configs, _args,ml_line());
			}
			_last=_ntk
		}
		ml_loadData(_sav); //cr
	}
	_configs[$ "json"]=1;
	return _ret
};