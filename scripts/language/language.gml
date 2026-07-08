function language(defaultStr="var", defaultReal="int") constructor{
	self.defaultStr		= defaultStr;
	self.defaultReal	= defaultReal;
	self.interpret		= ml_ds_map_create();
	self.chars			= ml_ds_map_create();
	self.word			= ml_ds_map_create();
	self.token			= ml_ds_map_create();
	self.repeats		= 3;
	
	static add_char = function(_char, _setmode=0, _inMode=0, _nReal=-1, _add=1, _breakLast=1, _breakNext=1, _replace=0, _enaAdd=1){
		//Loop caso seja um array
		if(is_array(_char)){for(var i = 0; i < array_length(_char); i++){self.add_char(_char[i], _setmode, _inMode, _nReal, _add, _breakLast, _breakNext, _replace, _enaAdd)}; return 1;}
		//criar mapa caso não exista modo
		if(!ds_map_exists(self.chars, _inMode)){self.chars[? _inMode]=ml_ds_map_create();}
		
		self.chars[? _inMode][? _char] = {
			setmode		: _setmode, 
			nReal		: _nReal, 
			add			: _add,
			breakLast	: _breakLast,
			breakNext	: _breakNext,
			replace		: _replace,
			enaAdd		: _enaAdd
		}
	}
	static add_token = function(_token, _word){
		if(is_array(_word)){for(var i = 0; i < array_length(_word); i++){self.add_token(_token, _word[i])}; return 1}
		self.token[? _word] = _token;
	}
	
	static add_word = function(_word, _func){
		self.word[? _word] = _func;
	}
	
	static add_interpret = function(_token, _interpret){
		self.interpret[? _token] = _interpret;
	}
	
	static isReal = function(_str){
		return ml_isReal(_str)
	}
	
	static step0_div = function(_text){
		var _len	= string_length(_text)+1;
		var _index	= 1;
		var _isReal = true,
		var _line	= 0;
		var _code	= [""];
		var _lines	= [0];
		var _mode	= 0;
		var _add	= true;
	
		for(_index=1; _index < _len; _index++)
		{
			var _char = "";
			var _existMode = ds_map_exists(self.chars, _mode);
			
			for(var i = 0; _index+i<_len&&(i==0||(_existMode&&ds_map_exists(self.chars[? _mode], _char+string_char_at(_text, _index+i)))); i++)
			{
				var _nchar = string_char_at(_text, _index+i);
				_char+=_nchar;
				if(_isReal&&string_pos(_nchar, "0123456789.-")==0){_isReal=false;}
				if(_nchar=="\n"){_line+=1}
			}
			_index+=i-1;
		
			if(_existMode&&ds_map_exists(self.chars[? _mode], _char))
			{
				var _ichar = self.chars[? _mode][? _char];
				var _enable = true;
				
				//se o tipo não corresponder n vou avançar
				if(_ichar.nReal>=0&&_ichar.nReal!=_isReal){_enable=false;}
				
				if(_enable)
				{
					_char = is_string(_ichar.replace) ? _ichar.replace : _char;
					
					if(_ichar.breakLast&&ml_array_get(_code, array_length(_code)-1, "")!="")
					{
						array_push(_code, "");
						array_push(_lines, _line);
					}
					if(_ichar.add)
					{
						_code[array_length(_code)-1]+=_char;
					}
					if(_ichar.breakNext)
					{
						array_push(_code, "");
						array_push(_lines, _line);
					}
					_add	= _ichar.enaAdd;
					_mode	= _ichar.setmode;
					continue
				}
			}
			if(_add!=0)
			{
				_code[array_length(_code)-1]+=_char;
			}
		}
		for(var i = 0; i< array_length(_code);i++)
		{
			if(_code[i]=="")
			{
				array_delete(_code, i, 1);
				array_delete(_lines, i, 1);
				i-=1;
			}
		}
		return [_code, _lines]	
	}
		
	static step1_lexer = function(_div){
		var _arr = []
		
		for(var i =0; i < array_length(_div[0]); i++)
		{	
			var _tk = new language_token(_div[0][i], self.defaultStr, _div[1][i]);
		
			//atribui o token de acordo de onde se encontra
			//se existir no ds, pegará o token correspondente
			
			
			if(ds_map_exists(self.token, _tk.name)){_tk.token=self.token[? _tk.name];}else
		
			//caso contrario verifica se é um numero
			if(self.isReal(_tk.name)){_tk.token=self.defaultReal; _tk.name = real(_tk.name);}
		
			array_push(_arr, _tk);
		}
		return _arr;
	}
}