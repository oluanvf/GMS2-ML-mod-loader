var _w = room_width;
var _h = room_height;

draw_set_font(Font1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _len = array_length(botoes)
var _xsp = _w/(_len+1);
for(var i = 0; i < _len; i++)
{
	var _bt		= botoes[i]
	var _name	= _bt.name
	var _sw		= string_width(_name)*_bt.scale
	var _sh		= string_height(_name)*_bt.scale
	var _x		= _xsp*(i+1);
	var _y		= _h*0.85;
	var _c		= [_x-_sw/2,_y-_sh/2, _x+_sw/2, _y+_sh/2];
	draw_set_color(c_dkgray)
	draw_rectangle(_c[0], _c[1], _c[2], _c[3], false);
	draw_set_color(c_white)
	draw_text_transformed(_x, _y, _name, _bt.scale,_bt.scale,0);
	var  _pt =point_in_rectangle(mouse_x, mouse_y,_c[0], _c[1], _c[2], _c[3])
	if(_pt&&mouse_check_button_pressed(mb_left))
	{
		_bt.func();
		_bt.scale=1.5;
	}
	_bt.scale=lerp(_bt.scale, 1+(_pt*0.2), 0.1);
}