function interpret_gml_math_or(code,  temp={}, configs={}, args=[]){
	var _tk		= code[ml_line()];
	var _val	= gml_run(_tk.more, false, temp, {}, args);
	if(_val){return true;}
	var _val2	= gml_run(_tk.code, false, temp, {}, args);
	if(_val2){return true;}
	return false;	
}