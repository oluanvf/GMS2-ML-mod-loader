function interpret_gml_ifs_try(_code, _temp={}, _configs={}, _args=[]){
	try{
		ml_next_line()
		_configs[$ "json"]=0;
		var _run = gml_run(_code, false, _temp, _configs, _args, ml_line())
		gml_run(_run, _args, _temp, _configs, _args)
	}catch(e)
	{
		if(ml_array_get(_code, ml_line()+2, {name:"a"}).name=="catch")
		{
			ml_next_line(3);
			var _name = _code[ml_line()].code[0].name;
			ml_next_line();
			_configs[$ "json"]=0;
			var _run = gml_run(_code, false, _temp, _configs, _args,ml_line())
			_temp[$ _name]=e;
			gml_run(_run, true,  _temp, _configs, _args)
		}
	}finally
	{
		var _apply = true
		for(var i = 0; _apply&&(i < 2); i++)
		{
			if(ml_array_get(_code, ml_line()+(i+1), {name:"a"}).name=="finally")
			{
				ml_next_line(i+2);
				_configs[$ "json"]=0;
				var _run = gml_run(_code, false, _temp, _configs, _args,ml_line())
				gml_run(_run, true,  _temp, _configs, _args)
				_apply=false
			}
		}
	}
}