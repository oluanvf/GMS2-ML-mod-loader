var _ww = window_get_width();
var _wh = window_get_height();
display_set_gui_size(_ww, _wh)

draw_set_font(Font1)
hl_draw_hud();
if(keyboard_check(ord("T"))){run(get_string("OI", ""))}
//print(fps)