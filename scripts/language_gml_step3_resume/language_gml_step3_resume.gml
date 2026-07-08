function language_gml_step3_resume(_arr, _narr, d={i:0, last : new language_token("", "", 0)}){
	var _tk			= _arr[d.i];
	var _lastPode	= ml_value_is_or(d.last.token, ["real", "int", "word", "str", "var", "run.o.(", "o.(", "run.o.[", "i.[", "."]);
	var _ret		= _tk;
	
	
	if(_tk.token==".")
	{
		if(is_undefined(d.last.token)||!_lastPode)//para aqueles caso de ".9"				
		{
			_tk.token	 = "real";
			d.i			+= 1;
			var _result  = string( ml_array_get(_arr, d.i, {name : 0}).name )
			_tk.name	 = real("0."+_result);
			return _ret;
		}
		if(d.last.token=="int")//caso de "0.0" ou "1."-> "1.0"
		{
			d.last.token = "real";
			d.i+=1;
			var _result = ml_array_get(_arr, d.i);
			_ret = undefined;
			
			if(!is_undefined(_result)&&_result.token=="int")
			{
				d.last.name=real(string(d.last.name)+"."+string(_result.name))
				return _ret;
			}
			d.last.name = real(string(d.last.name)+".0")
			d.i-=1;
			return _ret;
		}
		d.i+=1;
		var _result = ml_array_get(_arr, d.i);
		var _index = ml_array_find(_narr, d.last);
		if(_index>=0){array_delete(_narr, _index,1)}
		if(!struct_exists(_tk, "code")){_tk.code=[]}
		array_push(_tk.code, d.last);
		array_push(_tk.code, _result);
		return _ret;
		
	}else
	if(string_starts_with(_tk.token, "o.")&&!string_pos("{", _tk.token)&&_lastPode&&d.last.name!=":")
	{
		var _index = ml_array_find(_narr, d.last);
		if(_index>=0){
			array_delete(_narr, _index,1)
		}
		
		_tk.more	= [];
		_tk.token	= "run."+_tk.token;
		_tk.mode	= "";
		array_push(_tk.more, d.last);
		
		if(ml_array_get(_tk.code, 0, new language_token("", "", 0)).token=="find")
		{
			_tk.mode = _tk.code[0].name;
			array_delete(_tk.code, 0, 1);
		}
	}
	if(d.last.name=="function"&&_tk.name=="constructor"&&_tk.token=="ifs")
	{
		
		d.last.constructor=1;
		return undefined;	
	}
	if(d.last.name=="function"&&(!struct_exists(d.last, "fname")||!struct_exists(d.last, "code")||!struct_exists(d.last, "more")))
	{
		if(_tk.token=="var"&&!struct_exists(d.last, "fname")&&!struct_exists(d.last, "more"))
		{
			d.last.fname=_tk.name;
			return undefined
		}else
		if(_tk.token=="o.("&&!struct_exists(d.last, "more"))
		{
			d.last.more=[];	
			var _ind = 0
			
			for(var i = 0; i < array_length(_tk.code);i++)
			{
				var _ndk = _tk.code[i]
				if(_ndk.token=="set")
				{
					
					var _addTk = gml_decode(string(_ndk.more[0].name)+" = argument["+string(_ind)+"] ?? 'AQUI POH'")[0]
					_addTk.code[0].code=_ndk.code;
					array_push(d.last.more, _addTk)
					_ind+=1;
				}else
				if(_ndk.token=="word"||_ndk.token=="var")
				{
					var _addTk=gml_decode(string(_ndk.name)+" = argument["+string(_ind)+"]")[0]
					array_push(d.last.more, _addTk)
					_ind+=1;
				}
			}
			return undefined
		}else
		if(_tk.token=="o.{"&&!struct_exists(d.last, "code"))
		{
			for(var n = array_length(d.last.more)-1; n>=0; n--)
			{
				array_insert(_tk.code, 0, d.last.more[n])
				array_insert(_tk.code, 0, new language_token("var","var",d.last.more[n].line))
			}
			
			d.last.code=_tk.code
			d.last.more=[]
			return undefined
		}
	}
	/*if(d.last.name=="new"&&d.last.token=="ifs")
	{
		show_message(_tk)
		d.last.code=_tk;
		return undefined
	}*/
	return _ret;
}