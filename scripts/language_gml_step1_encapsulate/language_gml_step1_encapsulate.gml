function language_gml_step1_encapsulate(_arr, d={i:0}){
	
	var _narr = []
	for(d.i=d.i; d.i<array_length(_arr); d.i++)
	{
		var _tk = _arr[d.i];
		if(string_starts_with(_tk.token,"o."))
		{
			d.i+=1;
			var _result = language_gml_step1_encapsulate(_arr, d);
			_tk.code	= _result
			array_push(_narr, _tk);
			continue
		}else
		if(string_starts_with(_tk.token, "c.")==1)
		{
			break;
		}
		array_push(_narr, _tk);
	}
	return language_gml_step2_math(_narr);
}