function ml_mod_exist(_name){
	var _s = global.ml_ds.mods;
	
	if(is_array(_name))
	{
		for(var i = 0; i < array_length(_name); i++)
		{
			if(!ml_mod_exist(_name[i])){return 0}	
		}
		return 1
	}
	
	for(var i = 0; i < array_length(_s); i++)
	{
		var _dat = _s[i];
		if(is_struct(_name))
		{
			if(_dat.name==_name.name&&_dat.version>=_name.version)
			{
				return 1;
			}
		}else
		if(_dat.name==_name){
			return 1;	
		}
	}
	return 0
}