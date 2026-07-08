function hl_text_write(_s){
	if(keyboard_check(vk_nokey)||keyboard_lastkey!=keyboard_key){_s.addConst=0;}
		
	if(keyboard_check_pressed(vk_anykey)||keyboard_string!=""||(keyboard_lastkey==keyboard_key&&_s.addConst))
	{
		if(keyboard_check(vk_backspace)&&string_length(_s.value)>0){
			_s.value = string_delete(_s.value, string_length(_s.value), 1)
		}else
		if(!keyboard_check(vk_nokey))
		{
			_s.value+=keyboard_string
		}
		keyboard_string = ""
		_s.add = 0.4;
	}else
	{
		if(keyboard_lastkey==keyboard_key&&keyboard_check(vk_anykey))
		{
			_s.add-=1/room_speed;
		}
	}
	if(_s.add<0){_s.addConst=1; }
}