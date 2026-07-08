function ml_start(){
	global.ml_ds = {
		"mods"		: [],
		"mod"		: {},
		"languages"		: {},
		"language"		: {},
		"line"			: 0,
		"handle"		: undefined,
		"handleC"		: {
			winFile		: (GM_build_type=="run") ? game_display_name+".win" : "data.win",
			enable		: (GM_build_type=="run") ? 1 : 1,
			support		: -1,
		},
		"structures"	: {
			size:0
		},
		"current" : {
			"view" : undefined,
			"section" : undefined
		},
		"views" : [],
		"hud" : {
			"surface" : 0,
		}
	};

	global.ml_gds = ml_fill_global();
	
	
	hl_view("CONSOLE", 0,0, 0.4, 0.2)
	hl_section("output");
	global.ml_ds.printer = hl_text();
	
	gml_init()
	shader_init()
}
