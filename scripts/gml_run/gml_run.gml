function gml_run(_code, _ler=1, _temp={}, _configs={}, _args=[], _line=0){
	
	if(is_array(_code))
	{
		var _sav = ml_savData();
		ml_set_language(global.ml_ds.languages.gml);
		ml_set_line(_line);
		ml_set_handle(gml_exception_handle);
		var _ret = ml_interpret(_code, _ler, _temp, _configs, _args);
		ml_loadData(_sav);
		return _ret;
	}
	if(is_struct(_code))
	{
		if(_code.type==0)
		{
			var _savCode					= global.ml_ds[$ "privcode"];
			var _savArgs					= global.ml_ds[$ "privargs"];
			var _savRet						= global.ml_ds[$ "privreturn"];
			var _savLer						= global.ml_ds[$ "privler"];
			var _savTemp					= global.ml_ds[$ "privtemp"];
			var _savConfig					= global.ml_ds[$ "privconfig"];
			global.ml_ds[$ "privcode"]		= _code.func;
			global.ml_ds[$ "privreturn"]	= undefined;
			global.ml_ds[$ "privargs"]		= _args;
			with(_code.data)
			{
				global.ml_ds[$ "privreturn"]=gml_run(global.ml_ds[$ "privcode"], global.ml_ds[$ "privler"], global.ml_ds[$ "privtemp"], global.ml_ds[$ "privconfig"],global.ml_ds[$ "privargs"])	
			}
			var _ret = global.ml_ds[$ "privreturn"];
		
			global.ml_ds[$ "privcode"]		= _savCode;	
			global.ml_ds[$ "privreturn"]	= _savRet;
			global.ml_ds[$ "privargs"]		= _savArgs;
			global.ml_ds[$ "privler"]		= _savLer;
			global.ml_ds[$ "privtemp"]		= _savTemp;
			global.ml_ds[$ "privconfig"]	= _savConfig;
			return _ret;
		}else
		if(_code.type==1)
		{
			var _build = [_code.func];
			for(var i = 0; i < array_length(_code.def);i++)
			{
				array_push(_build, i>=array_length(_args) ? _code.def[i] : _args[i]);
			}
			return script_execute_ext(external_call, _build);
		}
	}
	
	return script_execute_ext(_code, _args);
}
