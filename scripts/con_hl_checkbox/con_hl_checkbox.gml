function con_hl_checkbox(_name, _ref) constructor{
	self.view	= global.ml_ds.current.view;
	self.select = global.ml_ds.current.section;
	self.name	= _name;
	self.ref	= _ref;
	array_push(self.select.elements, self)
	
	static draw = function(){
		hl_next_line(self.view);
		
		var _se = surface_get_target()!=-1;
		var _dw = display_get_gui_width();			//display width
		var _dh = display_get_gui_height();			//display height
		var _gx = self.view.x*_dw;					//global x
		var _gy = self.view.y*_dh;					//global y
		var _gw = self.view.width*_dw;				//global width
		var _gh = self.view.height*_dh;				//global height
		var _ed = hl_edge();
		var _lh = hl_line_height();
		var _lx = _gx*!_se+_ed+_lh
		var _ly = _gy*!_se+self.view.line;
		var _sc = _lh/string_height(self.name)
		var _ah = (_gy*!_se+_gh)-_ly-_lh-_ed;
		var _en = string_height(hl_text_in_rectangle("|", string_width("A")*_sc, _ah, _sc))*_sc; //enable
		
		if(!_en){return 0}
		draw_set_halign(-1);
		draw_set_valign(-1);
		draw_text_transformed(_lx, _ly, hl_text_in_rectangle(self.name, _gx*!_se+_gw*0.55-_lx-_ed, _lh, _sc), _sc, _sc,0);
		draw_set_alpha(0.4)
		draw_line_width(_gx*!_se+_gw/2, _ly,_gx*!_se+_gw/2, _ly+_lh, _ed*0.3*!(_gx*!_se+_gw/2<_lx));
		draw_set_alpha(1)
		
		var _val	= self.ref.get();
		var _x		= _gx*!_se+_gw*0.54
		var _ben	= !(_x<_lx||_x+_lh>(_gx*!_se+_gw-_ed)) 
		var _bdb	= [_x, _ly, _x+_lh, _ly+_lh]
		var _bcb	= [_gx*_se+_bdb[0], _gy*_se+_bdb[1], _gx*_se+_bdb[2],_gy*_se+_bdb[3]]
		if(_ben)
		{
		draw_rectangle(_bdb[0], _bdb[1], _bdb[2],_bdb[3], !_val)
		if(mouse_check_button_pressed(mb_left)&&hl_mouse_in_rectangle(_bcb[0], _bcb[1], _bcb[2],_bcb[3]))
		{
			self.ref.set(!_val);
		}
		return 1
		}
	}
}
