function hl_draw_hud(){
	for(var i = 0; i < array_length(global.ml_ds.views); i++)
	{
		global.ml_ds.views[i].draw()	
	}
}