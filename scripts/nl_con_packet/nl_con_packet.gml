function nl_con_packet() constructor
{
	self.buffer = buffer_create(1, buffer_grow, 1);
	
	static load = function(_buff){
		if(is_undefined(_buff))
		{
			return self;	
		}
		if(buffer_exists(self.buffer)){buffer_delete(self.buffer)}
		self.buffer=_buff;
		buffer_seek(self.buffer, buffer_seek_start, 0);
		return self;
	}
	
	static clear = function(){
		buffer_seek(self.buffer, buffer_seek_start, 0);
		buffer_resize(self.buffer, 1);
	}
	
	static write = function(_value){
		var _type = buffer_f64;
		if(is_string(_value))
		{
			_type = buffer_string;
		}else
		if(!is_numeric(_value))
		{
			_type		= -1;
			var isS		= is_struct(_value);
			var _arr	= _value
			var _func	= array_get;
			if(isS){
				_type	= -2; 
				_arr	= struct_get_names(_value);
				_func	= struct_get;
			}
			var _len = array_length(_arr);
			
			buffer_write(self.buffer, buffer_s16, _type);
			buffer_write(self.buffer, buffer_s16, _len);
			for(var i = 0; i < _len; i++)
			{
				var _ind = i;
				if(isS){
					_ind = _arr[i]
					buffer_write(self.buffer, buffer_string, _ind);
				}
				
				self.write(_func(_value, _ind))
			}
		}
		
		
		if(_type>=0)
		{
			buffer_write(self.buffer, buffer_s16, _type);
			buffer_write(self.buffer, _type, _value);
			return _value
		}
	}
	
	
	static read = function(){
		var _type = buffer_read(self.buffer, buffer_s16)
		if(_type>=0)
		{
			return buffer_read(self.buffer, _type);
		}
		
		var _len	= buffer_read(self.buffer, buffer_s16);
		var _arr	= [];
		var _f		= array_set;
		var _isS	= _type==-2
		if(_isS){_f = struct_set; _arr={}; }
			
		for(var i = 0; i<_len; i++){
			var _index = i
			if(_isS){
				_index = buffer_read(self.buffer, buffer_string)
			}
			_f(_arr, _index, self.read())
		}
		return _arr;
	}
	
	static send = function(_net, _exclude=[]){
		var _sockets = [_net.socket];
		if(_net.type=="server")
		{
			
		}
		for(var i = 0; i < array_length(_sockets); i++)
		{
			var _socket = _sockets[i];
			network_send_packet(_socket, self.buffer, buffer_tell(self.buffer))
		}
	}
}