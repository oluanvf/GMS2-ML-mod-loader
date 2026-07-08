function hl_mouse_in_rectangle(_x, _y, _x2, _y2){
	var _msx = device_mouse_x_to_gui(0);
	var _msy = device_mouse_y_to_gui(0); 
	return point_in_rectangle(_msx, _msy, _x, _y, _x2, _y2);
}