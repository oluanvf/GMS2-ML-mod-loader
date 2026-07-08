function ml_mod() constructor{
	self.name			= 0;
	self.dependencies	= [];
	self.version		= 0;
	self.description	= "";
	self.enable			= false;
	
	self.assets			=	[];
	self.objects		=	{};
	self.sprites		=	{};
	self.sounds			=	{};
	self.rooms			=	{};
	self.tiles			=	{};
	self.scripts		=	{};
	self.fonts			=	{};
	self.shaders		=	{};
	self.others			=	{};
	
	static check_dependencies = function(){
		if(ml_mod_exist(dependencies))
		{
			return 1
		}
		return 0
	}
	
	static status = function(){
		if(self.enable)
		{
			return "on"	
		}
		return "off"
	}
	
	static import = function(){
		self.enable					  = true;
		global.ml_ds.mod[$ self.name] = self;
		array_push(global.ml_ds.mods, self);
		
		
	}
	
	
}