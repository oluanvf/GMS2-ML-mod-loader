function gml_get_arguments(_code, _temp={}, _configs={}, _args=[]){
	var _ret = [];
	var _sav = ml_savData();
	ml_reset_line();
	var _add = 1;
	while(ml_line()<array_length(_code))
	{
		if(_add&&_code[ml_line()].token!="sep"){
			array_push(_ret, gml_run(_code, false, _temp, _configs, _args, ml_line()));
			_add=0;
		}else
		if(_code[ml_line()].token=="sep"){
			if(_add){
				array_push(_ret, undefined);
			}
			_add=1;
		}
		ml_next_line()
	}
	ml_loadData(_sav);
	return _ret;
}