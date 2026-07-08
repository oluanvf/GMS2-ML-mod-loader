function ml_file_find(_dir, _ext="", _attr=fa_archive, _data=[]){
	if(is_array(_dir))
	{
		for(var i = 0; i < array_length(_dir); i++)
		{
			ml_file_find(_dir[i], _ext, _attr, _data);
		}
		return _data;
	}
	if(!string_ends_with(_dir,"/")&&!string_ends_with(_dir,@"\")){_dir+="/"}
	for(var _f = file_find_first(_dir+"*", _attr); _f!=""; _f=file_find_next())
	{
		if((_attr == fa_directory&&directory_exists(_dir+_f))||(_attr!=fa_directory&&string_pos(filename_ext(_f), _ext)!=0))
		{
			array_push(_data,_dir+_f);
		}
	}
	file_find_close()
	return _data;
}