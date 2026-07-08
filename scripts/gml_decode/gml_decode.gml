function gml_decode(_text){
	var _lanq = global.ml_ds.languages.gml;
	return (language_gml_step0_lexer(_lanq.step1_lexer(_lanq.step0_div(_text))));
}