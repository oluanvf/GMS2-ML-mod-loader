function interpret_gml_math_null(code,  temp={}, configs={}, args=[]){
	var _tk = code[ml_line()];
	var _tk		= code[ml_line()];
	var _val	= gml_run(_tk.more, false, temp, {}, args);
	if(is_undefined(_val)||is_ptr(_val))
	{
		var _val2	= gml_run(_tk.code, false, temp, {}, args);
		return _val2;
	}
	return _val;	
}