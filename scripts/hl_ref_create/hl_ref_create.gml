function hl_ref_create(_struct, _name, _index=0){
	return {
		struct : _struct,
		name : _name,
		index : _index,
		set : function(_value){
			var _ret = self.get();
			if(is_array(_ret))
			{
				self.struct[$ self.name][self.index]=_value
				return 1
			}
			self.struct[$ self.name]=_value;
		},
		get : function(){
			var _ret = self.struct[$ self.name]
			if(is_array(_ret)){_ret=_ret[self.index]}
			return _ret
		}
	}
}