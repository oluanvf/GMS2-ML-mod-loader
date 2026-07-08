function con_hl_section(_name, _open=1) constructor{
	self.view						= global.ml_ds.current.view;
	global.ml_ds.current.section	= self;
	self.name						= _name;
	self.open						= _open;
	self.elements					= [];
	self.botoes						= ["COPY", "PASTE"];
	self.funcs						= [function(){show_message(self)}]
	array_push(self.view.section, self);
	
	static draw = function(){
		hl_next_line(self.view, 1.1);
		var _se = surface_get_target()!=-1;
		var _dw = display_get_gui_width();			//display width
		var _dh = display_get_gui_height();			//display height
		var _gx = self.view.x*_dw;					//global x
		var _gy = self.view.y*_dh;					//global y
		var _gw = self.view.width*_dw;				//global width
		var _gh = self.view.height*_dh;				//global height
		var _lh = hl_line_height();					//line height
		var _ed = hl_edge();						//edge (bordas)
		var _sc = _lh/string_height(self.name);		//escala
		var _lx = (_gx*!_se) + _lh+_ed;				//local x
		var _ly = (_gy*!_se) + self.view.line;		//local y
		var _ah = (_gy*!_se+_gh)-_ly-_lh-_ed;					//area height
		var _en = string_height(hl_text_in_rectangle("|", string_width("A")*_sc, _ah, _sc))*_sc; //enable
		
		
		//box draw line background
		var _bdlb = [_gx*!_se+_ed, _gy*!_se+self.view.line, _gx*!_se+clamp((_gw-_ed)*sign(abs(_en)), _ed, infinity), _gy*!_se+self.view.line+_en];
		var _bclb = [_gx*_se+_bdlb[0], _gy*_se+_bdlb[1], _gx*_se+_bdlb[2], _gy*_se+_bdlb[3]];
		var _clb  = hl_mouse_in_rectangle(_bclb[0], _bclb[1], _bclb[2], _bclb[3]);
		
		draw_set_colour(c_blue)
		draw_set_alpha(_clb ? 0.3 : 0.1)
		draw_rectangle(_bdlb[0], _bdlb[1], _bdlb[2], _bdlb[3], 0);
		draw_set_alpha(1)
		
		draw_set_valign(fa_middle);
		draw_set_halign(fa_right);
		
		var _bs = self.botoes;
		var _y	= _ly+_lh/2;
		var _xi	= (_gx*!_se)+_gw-string_width(string_join_ext("_", _bs)+"_")*_sc;
		for(var i = 0; i < array_length(_bs); i++)
		{
			var _x		= _xi+string_width(string_join_ext("_", _bs, 0, i)+string_repeat("_",i))*_sc
			var _nm		= _bs[i];
			var _sw		= string_width(_nm)*_sc;
			var _rn		= hl_text_in_rectangle(_nm,(_gx*!_se+_gw)-_x,_ah,_sc,_lx-_x);
			var _bdsb	= [_x+_sw-string_width(_rn)*_sc-string_width(".")/2*_sc,_y-_lh/2,_x+_sw+string_width(".")/2*_sc,_y+_lh/2]
			var _bcsb	= [_gx*_se+_bdsb[0],_gy*_se+_bdsb[1],_gx*_se+_bdsb[2],_gy*_se+_bdsb[3]]
			if(string_height(_rn)==0){continue}
			draw_set_color(c_blue)
			draw_rectangle(_bdsb[0],_bdsb[1],_bdsb[2],_bdsb[3],0)
			draw_set_color(c_white)
			draw_text_transformed(_x+_sw, _y, _rn, _sc, _sc, 0);
			if(mouse_check_button_pressed(mb_left)&&hl_mouse_in_rectangle(_bcsb[0],_bcsb[1],_bcsb[2],_bcsb[3]))
			{
				self.funcs[i]()
			}
			
		}
		
		var _bw = string_width(string_join_ext("_", _bs))*_sc
		
		draw_set_color(c_white)
		draw_set_halign(fa_center)
		draw_text_transformed((_gx*!_se)+_ed+_lh/2, _y, hl_text_in_rectangle("►", _gw-_lh/2-_ed-_bw, _ah, _sc), _sc, _sc, self.open*-90)
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		draw_text_transformed(_lx, _ly, hl_text_in_rectangle(self.name, (_gx*!_se+_gw)-_lx-_ed-_bw,_ah, _sc), _sc, _sc, 0);
		
		
		//desenhar os outros elementos se estiver aberto
		for(var i = 0; i < array_length(self.elements)*self.open; i++){self.elements[i].draw();}
		
		//abrir ou fechar secção
		if(_en&&mouse_check_button_pressed(mb_left)&&_clb){self.open=!self.open;}
	}
	
}