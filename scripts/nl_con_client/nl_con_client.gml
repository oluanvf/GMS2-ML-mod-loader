function nl_con_client(_url,_type, _port, _mod={}) constructor 
{
	self.type	= _type;
	self.port	= _port;
	self.url	= _url;
	self.socket = -1;
	self.tag	= "client";
	ml_struct_copy(_mod,self);
	
	static init = function()
	{
		self.socket							= network_create_socket(self.type);
		global.ds_network.id[$ self.socket] = self;
		network_connect_async(self.socket, self.url, self.port);	
	}
	static close = function()
	{
		network_destroy(self.socket);
		struct_remove(global.ds_network.id, self.socket);
		self.socket=-1;
	}
}