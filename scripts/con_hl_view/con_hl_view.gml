function con_hl_view(_name, _x=0, _y=0, _width=0.5, _height=0.5, _visible=1) constructor{
	global.ml_ds.current.view	= self;
	self.x						= _x;
	self.y						= _y;
	self.visible				= _visible;
	self.width					= _width;
	self.height					= _height;
	self.name					= _name;
	self.surface				= surface_create(1, 1);
	self.section				= [];
	self.line					= 0;
	self.tempT					= {enable:0};
	array_push(global.ml_ds.views, self);
	
	
	static draw = function(){
		if(!self.visible){exit}
		var _gw		= display_get_gui_width();		
		var _gh		= display_get_gui_height();
		var _x		= self.x*_gw;
		var _y		= self.y*_gh;
		var _w		= self.width*_gw;
		var _h		= self.height*_gh;
		var _ed		= hl_edge();
		var _su		= global.ml_ds.hud.surface;
		self.line	= hl_line_height();
		
		if(_su){
			self.surface = surface_exists(self.surface) ? self.surface : surface_create(1,1)
			surface_resize(self.surface, clamp(_w, 1,infinity) , clamp(_h,1,infinity));
			surface_set_target(self.surface);
			draw_clear_alpha(c_white, 0);
		}
		
		var _se	= surface_get_target()!=-1;
		var _rd = !_se&&_h<self.line*2;
		var _sh = string_height(self.name)
		var _sw = string_width(self.name+"_")
		var _sc = _rd ? min(_h/_sh, _w/_sw)			: (self.line*2)/_sh;
		var _st = _rd ?  self.name					: hl_text_in_rectangle(self.name, _w-_ed*2, infinity, _sc)
		var _rs = _rd ? _sc							: 1;
		
		draw_set_alpha(0.4);
		draw_set_colour(c_dkgray);
		draw_rectangle(_x*!_se, _y*!_se, _x*!_se+_w, _y*!_se+_h, 0);
		draw_set_alpha(1);
		draw_set_colour(c_white);
		draw_set_valign(fa_middle);
		
		draw_text_transformed(_x*!_se+_ed*_rs, _y*!_se+self.line*_rs, _st, _sc, _sc, 0);
		
		//desenhar secções
		for(var i =0; i <array_length(self.section); i++){self.section[i].draw()}
		
		if(_se){
			surface_reset_target();
			draw_surface(self.surface, _x, _y);
		}
		
		draw_set_colour(c_white)
		draw_rectangle(_x, _y, _x+_w, _y+_h, 1)
		
		#region
		var _msx		= device_mouse_x_to_gui(0);
		var _msy		= device_mouse_y_to_gui(0); 
		var _press		= mouse_check_button(mb_left);
		var _pressed	= mouse_check_button_pressed(mb_left);
		if(!self.tempT.enable&&_pressed)
		{
			if(hl_mouse_in_rectangle(_x-_ed/2, _y-_ed/2, _x+_w+_ed/2, _y+_h+_ed/2))
			{
				draw_set_color(c_white);
				if(hl_mouse_in_rectangle(_x-_ed, _y+_h-_ed, _x+_ed,_y+_h+_ed))
				{
					self.tempT.i		= [_msx, _msy]
					self.tempT.v		= [_x, _h]
					self.tempT.n		= ["x", "height"]
					self.tempT.o		= "width"
					self.tempT.p		= _w
					self.tempT.m		= 2
					self.tempT.enable	= 1;
				}else
				if(hl_mouse_in_rectangle(_x+_w-_ed, _y+_h-_ed, _x+_w+_ed,_y+_h+_ed))
				{
					self.tempT.i		= [_msx, _msy]
					self.tempT.v		= [_w, _h]
					self.tempT.n		= ["width", "height"]
					self.tempT.o		= undefined;
					self.tempT.m		= 2
					self.tempT.enable	= 1;
				}else
				if(!hl_mouse_in_rectangle(_x+_ed, _y+_ed*0.5, _x+_w-_ed, _y+_h-_ed))
				{
						var _dx1 = point_distance(_msx,0,_x,0); 
						var _dy1 = point_distance(_msy,0,_y,0); 
						var _dx2 = point_distance(_msx,0,_x+_w,0); 
						var _dy2 = point_distance(_msy,0,_y+_h,0);
						if(min(_dx1, _dy1, _dx2, _dy2)==_dx1){
							self.tempT.v = _x;
							self.tempT.n = "x";
							self.tempT.u = 0;
							self.tempT.f = display_get_gui_width;
							self.tempT.o = "width";
							self.tempT.p = _w;
						}else
						if(min(_dx1, _dy1, _dx2, _dy2)==_dy1){
							self.tempT.v = _y;
							self.tempT.n = "y";
							self.tempT.u = 1;
							self.tempT.f = display_get_gui_height;
							self.tempT.o = "height";
							self.tempT.p = _h;
						}else
						if(min(_dx1, _dy1, _dx2, _dy2)==_dx2){
							self.tempT.v = _w;
							self.tempT.n = "width";
							self.tempT.u = 0;
							self.tempT.f = display_get_gui_width;
							self.tempT.o = undefined;
						}else{
							self.tempT.v = _h;
							self.tempT.n = "height";
							self.tempT.u = 1;
							self.tempT.f = display_get_gui_height;
							self.tempT.o = undefined;
						}
						self.tempT.i = [_msx, _msy]
						self.tempT.m = 0
						self.tempT.enable = 1;
				}else
				if(_msy<_y+_ed+hl_line_height())
				{
					self.tempT.enable = 1;
					self.tempT.v = [_x, _y];
					self.tempT.i = [_msx, _msy]
					self.tempT.m = 1;
				}
			}
		}
		if(self.tempT.enable)
		{
			self.tempT.enable		=_press;
			var _mss				= [_msx, _msy]
			if(self.tempT.m==0)
			{
				var _md					= (_mss[self.tempT.u]-self.tempT.i[self.tempT.u])
				var _v					= (self.tempT.v+_md)/self.tempT.f()
				self[$ self.tempT.n]	= _v
				if(!is_undefined(self.tempT.o))
				{
					var _v					= (self.tempT.p-_md)/self.tempT.f()
					self[$ self.tempT.o]	= _v
				}
			}else
			if(self.tempT.m==1)
			{
				self.x		= (self.tempT.v[0]+(_mss[0]-self.tempT.i[0]))/_gw;
				self.y		= (self.tempT.v[1]+(_mss[1]-self.tempT.i[1]))/_gh;
				
			}else
			{
				self[$ self.tempT.n[0]]		= (self.tempT.v[0]+(_mss[0]-self.tempT.i[0]))/_gw;
				self[$ self.tempT.n[1]]		= (self.tempT.v[1]+(_mss[1]-self.tempT.i[1]))/_gh;
				if(!is_undefined(self.tempT.o))
				{
					self[$ self.tempT.o]		= (self.tempT.p-(_mss[0]-self.tempT.i[0]))/_gw;
				}
			}
			self.x=clamp(self.x, 0, infinity)
			self.y=clamp(self.y, 0, infinity)
			self.width=clamp(self.width, 1/_gw, infinity)
			self.height=clamp(self.height, 1/_gh, infinity)
		}
		#endregion
	}
}