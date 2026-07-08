function interpret_gml_math_neg(code,  temp={}, configs={}, args=[]){
	var _tk		= code[ml_line()];
	var _val	= gml_run(_tk.code, false, temp, {}, args);
	return !_val;
}