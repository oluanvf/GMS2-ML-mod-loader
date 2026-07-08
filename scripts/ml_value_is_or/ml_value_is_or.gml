function ml_value_is_or(_value, _values){
	for(var i =0; i < array_length(_values); i++)
	{
		if(_value==_values[i])
		{
			return 1;	
		}
	}
	return 0;
}