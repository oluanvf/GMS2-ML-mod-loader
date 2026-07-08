function nl_event(){
	var _dat = json_parse(json_encode(async_load))
	
	if(struct_exists(global.ds_network.id, _dat.id))
	{
		var _net = global.ds_network.id[$ _dat.id];
		switch(_dat.type)
		{
			case network_type_connect :
				global.ds_network.client[$ _dat.socket]=_net;
				
			break
			
			case network_type_disconnect :
				struct_remove(global.ds_network.client, _dat.socket);
			break
			
			case network_type_non_blocking_connect :
				if(_dat.succeeded){
					if(struct_exists(_net, "onConnect"))
					{
						_net.onConnect(_net, _dat);	
					}
					return 1
				}
				_net.close()
			break
			
		}
	}else
	if(struct_exists(global.ds_network.client, _dat.id))
	{
		var _net = global.ds_network.client[$ _dat.id];
		if(struct_exists(_net, "onData"))
		{
			_net.onData(_net, _dat);
		}
	}
}