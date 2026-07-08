function ml_file_read(_file){
	var _str = ""
	if(file_exists(_file))
	{
		var _f = file_text_open_read(_file)
		while(!file_text_eof(_f))
		{
			_str+=file_text_read_string(_f)+"\n"
			file_text_readln(_f)
		}
		file_text_close(_f)
	}
	return _str
}