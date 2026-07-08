function cons_discord_webhook(_hook) constructor{
	self.hook	 = _hook;
	self.message = {}
	

	static init_message = function(){
		self.message={
			content		: "",
			embeds		: [],
			attachments	: []
		}	
	}
	static set_content = function(_str)
	{
		self.message.content=_str;
	}
	static set_username = function(_name){
		self.message.username = _name;
	}
	static set_avatar = function(_url){
		self.message.avatar_url = _url;
	}
	static add_embed = function(_titulo="", _description="", _url="", _color = c_red, _footer="", _ico="", _image="", _thumbnail=""){
		array_push(self.message.embeds, {
			title : _titulo,
			description : _description,
			url		: _url,
			color	: _color,
			fields : [],
			author : {name : "", url:""},
			footer : {text: _footer, icon_url: _ico},
			image : {url : _image},
			thumbnail : {url: _thumbnail},
		})
	}
	
	
	static get_embed=function(_i=1)
	{
		return self.message.embeds[array_length(self.message.embeds)-_i];
	}
	
	static embed_set_description = function(_description){
		self.get_embed().description=_description;
	}
	static embed_set_author = function(_name,_url=-1){
		self.get_embed().name=_name;
		self.get_embed().url =_url;
	}
	
	static embed_add_field = function(_name="", _val=""){
		array_push(self.get_embed().fields, {name : _name, value : _val})
	}
	
	static embed_set_color = function(_color){
		self.get_embed().color = _color
	}
	
	static embed_set_image = function(_image)
	{
		self.get_embed().image.url = _image
	}
	
	static send_message=function(){
		var _head = ds_map_create();
		ds_map_add(_head, "Content-Type", "application/json");
		http_request(self.hook,"POST", _head, json_stringify(self.message))
		ds_map_destroy(_head);
		ds_map_destroy(_head)
	}
}