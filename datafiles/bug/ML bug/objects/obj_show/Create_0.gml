botoes = [
	{name : "REINICIAR",	func : function(){
		game_change("/../", $"-game \"{global.dados[$ "win"] ?? "data.win"}\"");}, scale:1},
	{name : "SAIR",			func : game_end, scale:1},
]