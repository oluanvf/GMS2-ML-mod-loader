function nl_con_server(_limit,_type,_port,_mod={}) constructor
{
	self.type	= _type;
	self.port	= _port;
	self.limit	= _limit;
	self.socket = -1;
	self.tag	= "server";
	ml_struct_copy(_mod,self);
	
	static init = function(){
		self.socket = network_create_server(self.type, self.port, self.limit)
		global.ds_network.id[$ self.socket] = self;
	}
	static close = function(){
		network_destroy(self.socket);
	}
}
