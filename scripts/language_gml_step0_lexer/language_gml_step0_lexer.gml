function language_gml_step0_lexer(_lex){
	var _lanq = global.ml_ds.languages.gml;
	
	for(var i = 0; i < array_length(_lex); i++)
	{
		var _tk = _lex[i];
		if(_tk.token=="var")
		{
			//no caso de ser uma cor
			if(string_starts_with(_tk.name,"#")){_tk.name=hex_to_color(_tk.name)[3]; _tk.token=_lanq.defaultReal;}
			//caso de string
			if(string_starts_and_ends_with(_tk.name, "'")){_tk.token="str";}
		}
	}
	return language_gml_step1_encapsulate(_lex)
}
