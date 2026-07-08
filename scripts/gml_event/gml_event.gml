function gml_event(_event){
	if(is_undefined(self[$ "events"])){
		if(_event==ev_draw){
			draw_self();
		}	
		return 0
	}
	var _ev = self.events[$ _event];
	if(!is_undefined(_ev)){
		return gml_run(_ev);
	}
	
}