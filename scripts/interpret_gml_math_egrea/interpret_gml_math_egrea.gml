function interpret_gml_math_egrea(code,  temp={}, configs={}, args=[]){
	var _tk		= code[ml_line()];
	var _val	= gml_run(_tk.more, false, temp, {}, args);
	var _val2	= gml_run(_tk.code, false, temp, {}, args);
	return _val>=_val2;
}