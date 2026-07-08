function con_hl_text(_lines=10, _scale=1) constructor{
	self.view	= global.ml_ds.current.view;
	self.select = global.ml_ds.current.section;
	self.split	= []
	self.lines	= _lines;
	self.scale	= _scale;
	array_push(self.select.elements, self);
	
	static print = function(_str){
		var _narr = string_split(string(_str), "\n")
		//var _l = array_length(self.split)
		
		//_narr = array_reverse(_narr, 0, array_length(_narr))
		for(var i = 0; i < array_length(_narr); i++)
		{
			//array_insert(self.split, 0, string_replace_all(_narr[i], "\n",""))	
			array_push(self.split, string_replace_all(_narr[i], "\n",""))	
		}
	}
	
	
	static draw = function(){
		hl_next_line(self.view,1.1)
		var _se = surface_get_target()!=-1;
		var _dw = display_get_gui_width();			//display width
		var _dh = display_get_gui_height();			//display height
		var _gx = self.view.x*_dw;					//global x
		var _gy = self.view.y*_dh;					//global y
		var _gw = self.view.width*_dw;				//global width
		var _gh = self.view.height*_dh;				//global height
		var _ed = hl_edge();
		var _ss = self.scale;
		var _lh = hl_line_height()*_ss;
		var _sc = _lh/string_height("I")
		var _len = array_length(self.split);
		var _le = min(_len, self.lines);
		//hl_next_line(self.view)
		//repeat(_le-1){hl_next_line(self.view, _ss);}
		if(_le==0){_le=1}
		var _lx = _gx*!_se+	_ed+_lh
		var _ly = _gy*!_se+	self.view.line+_lh*_le;
		hl_next_line(self.view, (_le-1)*_ss)
		
		draw_set_colour(c_black)
		
		
		var _bdx = _lx-_ed*0.1
		var _bdy = clamp(_ly-_lh*_le, _gy*!_se+_ed, _gy*!_se+_gh-_ed)
		draw_rectangle(
			_lx-_ed*0.1, 
			_bdy, 
			clamp(_gx*!_se+_gw-_ed, _bdx,infinity),
			clamp(_ly, _bdy, _gy*!_se+_gh-_ed), 
			0
		)
		
		draw_set_colour(c_white);
		draw_set_halign(-1);
		draw_set_valign(-1);
		var _start = _len-1
		for(var i = _start; i>=clamp(_len-_le,0,infinity); i--)
		{
			var _str	= self.split[i];
			var _ty		= _ly-_lh*(_start-i)-_lh;
			var _ah		= (_gy*!_se+_gh)-_ty-_lh-_ed
			if(_ly<_lh*(_len-i)>_gy*!_se+_gh){continue}
			draw_text_transformed(_lx, _ty, hl_text_in_rectangle(_str, _gx*!_se+_gw-_lx-_ed, _ah, _sc), _sc, _sc,0);
		}
		
		
	}
}
