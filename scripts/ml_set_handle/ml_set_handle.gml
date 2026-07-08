function ml_set_handle(_l){
	if(global.ml_ds.handleC.enable)
	{
		global.ml_ds.handle = _l;
		exception_unhandled_handler(_l);
	}
}