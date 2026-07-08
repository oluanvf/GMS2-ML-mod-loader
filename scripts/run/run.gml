/// @function                 run(function, params...);
function run(_func){
	var _arr = []
	for(var i = 1; i < argument_count; i++)
	{
		array_push(_arr, argument[i])	
	}
	if(file_exists(_func)){_func=gml_decode(ml_file_read(_func))}else
	if(is_string(_func)){_func=gml_decode(_func);}
	return gml_run(_func,,,,_arr)
}
