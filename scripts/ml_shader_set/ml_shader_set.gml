function ml_shader_set(shader, dataModify={})
{
	if(is_struct(shader))
	{
		var array = shader.array
		var arri  = 0
		var arrayModify = struct_get_names(dataModify)
		for(var i =0;i<array_length(arrayModify);i++)
		{
			var _name = arrayModify[i]
			if(ds_map_exists(shader.vars, _name))
			{
				var _pos = shader.vars[? _name]
				var _value = dataModify[$ _name]
				if(!is_array(_value)){_value=[_value]}
				for(var o = 0; o < array_length(_value); o++)
				{
					array[arri]=_pos+o
					array[arri+1]=_value[o]
					arri+=2
				}
			}
		}
		if(arri<100){array[arri]=-200;}
		var _sha = ml_shader
		shader_set(_sha)
		shader_set_uniform_f_array(shader_get_uniform(_sha, "FshVarsU"), array);
		shader_set_uniform_f_array(shader_get_uniform(_sha, "FshCode"), shader.fsh);
		return 1
	}
	shader_set(shader)
	var arrayModify = struct_get_names(dataModify)
	for(var i =0;i<array_length(arrayModify);i++)
	{
		var _name = arrayModify[i]
		var _value = dataModify[$ _name]
		if(is_array(_value)){
			shader_set_uniform_f_array(shader_get_uniform(shader, _name), _value)
		}else
		if(is_struct(_value))
		{
			shader_set_uniform_i(shader_get_uniform(shader, _name), _value.value)
		
		}else
		{
			shader_set_uniform_f(shader_get_uniform(shader, _name), _value)
		}
	}
	
}