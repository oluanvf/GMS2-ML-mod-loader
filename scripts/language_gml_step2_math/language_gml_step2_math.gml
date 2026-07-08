function language_gml_step2_math(_arr,d={i:0}){
	var _narr	= [];
	d.i			= 0;
	
	while(d.i<array_length(_arr))
	{
		d.last = ml_array_get(_narr,array_length(_narr)-1, new language_token("", undefined, 0)) 
		var _val = language_gml_step3_resume(_arr,_narr, d);
		if(!is_undefined(_val)){
			array_push(_narr, _val);	
		}
		d.i++
	}
	
	for(var i = 0; i < array_length(_narr); i++)
	{
		var _tk = _narr[i]
		if(_tk.name=="!")
		{
			var _next = ml_array_get(_narr, i+1, new language_token(1, "int", _tk.line))
			_tk.code = [_next];
			if(i+1<array_length(_narr)){array_delete(_narr, i+1, 1)}
			
			if(ml_value_is_or(_next.token, ["real", "int"]))
			{
				_tk.name=!_next.name;
				_tk.token = "real"
				struct_remove(_tk, "code")
			}
		}
	}
	
	for(var i = 0; i < array_length(_narr); i++)
	{
		var _tk = _narr[i]
		if(_tk.token=="mathP"&&_tk.name!="!")
		{
			var _next = ml_array_get(_narr, i+1, new language_token(1, "int", _tk.line))
			_tk.code = [_next];
			if(i+1<array_length(_narr)){array_delete(_narr, i+1, 1)}
			
				
			var _last = ml_array_get(_narr, i-1, new language_token(1, "int", _tk.line))
			if(!ml_value_is_or(_last.token, ["ifs", "sep", "pv"]))
			{
				_tk.more=[_last]
				if(i-1>=0){array_delete(_narr, i-1, 1); i-=1}
				if(ml_value_is_or(_last.token, ["real", "int"]) && ml_value_is_or(_next.token, ["real", "int"]))
				{
					if(_tk.name=="*")
					{
						_tk.name=_next.name*_last.name;
					}else
					if(_tk.name=="^")
					{
						_tk.name=_next.name/_last.name;
					}else
					{
						_tk.name=_next.name^_last.name;
					}
					_tk.token = "real"
					struct_remove(_tk, "code")
					struct_remove(_tk, "more")
				}
			}
		}
	}
	
	for(var i = 0; i < array_length(_narr); i++)
	{
		var _tk = _narr[i]
		if(_tk.token=="math")
		{
			var _last = ml_array_get(_narr, i-1, new language_token(0,"int", _tk.line))
			_tk.more=[_last]
			var _pd = ml_value_is_or(_last.token, ["ifs", "sep", "pv"])
			if(_pd)
			{
				_tk.more=[new language_token(0, "real",_tk.line)]	
			}
			
			var _next = ml_array_get(_narr, i+1, new language_token(0, "int", _tk.line))
			_tk.code=[_next];
			if(i+1<array_length(_narr)){array_delete(_narr, i+1, 1)}
			if(!_pd&&i-1>=0){array_delete(_narr, i-1, 1); i-=1;}
			
			var _resume = false
			var _v1 = _last.name
			var _v2 = _next.name
			if(ml_value_is_or(_last.token, ["real", "int"])&&ml_value_is_or(_next.token, ["real", "int"])){_resume=true;}else
			if(_last.token==_next.token&&_last.token=="str"){
				_v1 = string_copy(_v1, 2, string_length(_v1)-2)
				_v2 = string_copy(_v2, 2, string_length(_v2)-2)
				_resume = true;
			}
			if(!_resume){continue}
			switch(_tk.name)
			{
				case "=="	: {_tk.name = _v1==_v2;}break	
				case "??"	: {_tk.name = _v1??_v2;}break	
				case "!="	: {_tk.name = _v1!=_v2;}break	
				case "<="	: {_tk.name = _v1<=_v2;}break	
				case ">="	: {_tk.name = _v1>=_v2;}break	
				case "<"	: {_tk.name = _v1<_v2;}break	
				case ">"	: {_tk.name = _v1>_v2;}break	
				case "+"	: {_tk.name = _v1 + _v2;}break	
				case "-"	: {_tk.name = _v1 - _v2;}break	
				case "mod"	: {_tk.name = _v1 mod _v2;}break	
				case "||"	: {_tk.name = _v1 || _v2;}break	
				case "&&"	: {_tk.name = _v1 && _v2;}break	
				case "and"	: {_tk.name = _v1 and _v2;}break	
				case "or"	: {_tk.name = _v1 or _v2;}break	
				case "xor"	: {_tk.name = _v1 xor _v2;}break	
				default		: {continue}break
			}
			if(is_string(_tk.name)){
				_tk.name = "'"+_tk.name+"'"
				_tk.token="str"
			}else
			{
				_tk.token="real"	
			}
			struct_remove(_tk, "more");
			struct_remove(_tk, "code");
		}else
		if(i!=0&&_narr[i-1].name=="new"&&_narr[i-1].token=="ifs"&&array_length(ml_struct_get(_narr[i-1], "code",[]))==0)
		{
			_narr[i-1].code=[_tk]
			array_delete(_narr, i, 1)
			i-=1;
		}
	}
	for(var i = 0; i < array_length(_narr); i++)
	{
		var _tk = _narr[i];
		if(_tk.token=="set")
		{
			var _last = ml_array_get(_narr, i-1, new language_token(0, "int", _tk.line))
			
			_tk.more = [_last];
			
			var _pd = ml_value_is_or(_last.token, ["ifs", "sep", "pv"]);
			if(_pd){_tk.more=[new language_token(0, "real", _tk.line)]}
			
			if(_tk.name!="++"||_tk.name!="--")
			{
				var _next = ml_array_get(_narr, i+1, new language_token(0, "int", _tk.line))
				_tk.code = [_next]
				if(i+1<array_length(_narr)){array_delete(_narr, i+1, 1);}
			}
			if(i-1>=0){array_delete(_narr, i-1, 1); i-=1}
		}
	}
	
	
	
	return _narr
}
