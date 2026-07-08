function gml_add_event(_event, _code, _obj=self){
	if(!struct_exists(_obj, "events")){_obj.events={};}
	if(is_string(_code)){_code=gml_decode(_code)}
	_obj.events[$ _event] = _code;
}