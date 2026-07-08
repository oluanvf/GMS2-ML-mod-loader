function gml_init(){ 
	var _lanq = new language();
	global.ml_ds.languages.gml = _lanq;

	var _spaces = string_split(" ,	,\r,\n", ",");
		
	#region caracteres
	_lanq.add_char(_spaces, 0, 0, -1, 0);
	_lanq.add_char(string_split(", . { } ( ) [ ] == = <= >= /= *= += -= ++ -- ?? + - / * != ! || && : ? ! $ | ; , > <", " "));
	
	#region hex			1
	_lanq.add_char("#", 1, 0, -1, 1, 1, 0);													//iniciar
	_lanq.add_char(_spaces, 0, -1, -1, 0, 1);												//sair
	_lanq.add_char(string_split("} ) ] > >= < <= == != || && ; ,", " "), 0, 1, -1, 1, 1, 1);//sair em caso de comparação
	#endregion
	
	#region string com @	2,3,4
	_lanq.add_char("@", 2, 0, -1, 0, 0, 0);
	_lanq.add_char("\"", 3, 2, -1, 1, 1, 0);
	_lanq.add_char("'", 4, 2, -1, 1, 1, 0);
	_lanq.add_char("\"", 0, 3, -1, 1, 1, 0);
	_lanq.add_char("'", 0, 4, -1, 1, 1, 0);
	_lanq.add_char(_spaces, 0, 2, -1, 1, 1, 0);
	#endregion
	
	#region string normal 5,6
	_lanq.add_char("'", 5, 0, -1, 1, 1, 0, "'");
	_lanq.add_char("'", 0, 5, -1, 1, 0, 1, "'");
	_lanq.add_char(@"\n", 5, 5, -1, 1, 0, 0, "\n");
	_lanq.add_char(@"\r", 5, 5, -1, 1, 0, 0, "\r");
	_lanq.add_char(@"\b", 5, 5, -1, 1, 0, 0, "\b");
	_lanq.add_char(@"\f", 5, 5, -1, 1, 0, 0, "\f");
	_lanq.add_char(@"\t", 5, 5, -1, 1, 0, 0, "\t");
	_lanq.add_char(@"\v", 5, 5, -1, 1, 0, 0, "\v");
	_lanq.add_char(@"\a", 5, 5, -1, 1, 0, 0, "\a");
	_lanq.add_char(@"\", 5, 5, -1, 1, 0, 0, @"\");
	_lanq.add_char(@"\'", 5, 5, -1, 1, 0, 0, "'");
	
	_lanq.add_char("\"", 6, 0, -1, 1, 1, 0, "'");
	_lanq.add_char("\"", 0, 6, -1, 1, 0, 1, "'");
	_lanq.add_char(@"\n", 6, 6, -1, 1, 0, 0, "\n");
	_lanq.add_char(@"\r", 6, 6, -1, 1, 0, 0, "\r");
	_lanq.add_char(@"\b", 6, 6, -1, 1, 0, 0, "\b");
	_lanq.add_char(@"\f", 6, 6, -1, 1, 0, 0, "\f");
	_lanq.add_char(@"\t", 6, 6, -1, 1, 0, 0, "\t");
	_lanq.add_char(@"\v", 6, 6, -1, 1, 0, 0, "\v");
	_lanq.add_char(@"\a", 6, 6, -1, 1, 0, 0, "\a");
	_lanq.add_char(@"\", 6, 6, -1, 1, 0, 0, @"\");
	_lanq.add_char(@"\"+"\"", 6, 6, -1, 1, 0, 0, "\"");
	#endregion
	
	#region notas 7,8
	_lanq.add_char("//", 7, 0, -1, 0, 0, 1, 0, 0);
	_lanq.add_char(["\n","\r"], 0, 7, -1, 0, 1, 1, 0, 1);
	_lanq.add_char("/*", 8, 0, -1, 0, 0, 1, 0, 0);
	_lanq.add_char("*/", 0, 8, -1, 0, 1, 1, 0, 1);
	#endregion
	#endregion
	
	#region tokens
	_lanq.add_token("o.[",	"[");
	_lanq.add_token("c.]",	"]");
	_lanq.add_token("o.(",	"(");
	_lanq.add_token("c.)",	")");
	_lanq.add_token("o.{",	"{");
	_lanq.add_token("c.}",	"}");
	_lanq.add_token(".",	".");
	_lanq.add_token("sep",	string_split(", ;", " "));
	_lanq.add_token("set",	string_split("= += -= /= ++ --", " "));
	_lanq.add_token("mathP",string_split("* / div ! ^", " "));
	_lanq.add_token("math",	string_split("== ?? != >= < > + - mod || && and or xor", " "));
	_lanq.add_token("find",	string_split("? # $ |", " "));
	_lanq.add_token("ifs",	string_split("constructor if for with new while function switch else return try catch break continue repeat finally", " "));
	_lanq.add_token("word",	string_split("static room argument self other room_width room_height", " "));
	
	_lanq.add_word("get",	ml_array_get);
	_lanq.add_word("get#",	ml_grid_get);
	_lanq.add_word("get.",	ml_struct_get);
	_lanq.add_word("get$",	ml_struct_get);
	_lanq.add_word("get?",	ml_map_get);
	_lanq.add_word("get|",	ml_list_get);
	_lanq.add_word("=.",	ml_struct_set);
	_lanq.add_word("+=.",	ml_struct_add);
	_lanq.add_word("-=.",	ml_struct_sub);
	_lanq.add_word("--.",	ml_struct_sub2);
	_lanq.add_word("++.",	ml_struct_add2);
	_lanq.add_word("*=.",	ml_struct_mul);
	_lanq.add_word("/=.",	ml_struct_div);
	_lanq.add_word("=$",	ml_struct_set);
	_lanq.add_word("+=$",	ml_struct_add);
	_lanq.add_word("-=$",	ml_struct_sub);
	_lanq.add_word("--$",	ml_struct_sub2);
	_lanq.add_word("++$",	ml_struct_add2);
	_lanq.add_word("*=$",	ml_struct_mul);
	_lanq.add_word("/=$",	ml_struct_div);
	_lanq.add_word("=?",	ml_map_set);
	_lanq.add_word("+=?",	ml_map_add);
	_lanq.add_word("-=?",	ml_map_sub);
	_lanq.add_word("--?",	ml_map_sub2);
	_lanq.add_word("++?",	ml_map_add2);
	_lanq.add_word("*=?",	ml_map_mul);
	_lanq.add_word("/=?",	ml_map_div);
	_lanq.add_word("=|",	ml_list_set);
	_lanq.add_word("+=|",	ml_list_add);
	_lanq.add_word("-=|",	ml_list_sub);
	_lanq.add_word("--|",	ml_list_sub2);
	_lanq.add_word("++|",	ml_list_add2);
	_lanq.add_word("*=|",	ml_list_mul);
	_lanq.add_word("/=|",	ml_list_div);
	_lanq.add_word("=",		ml_array_set);
	_lanq.add_word("+=",	ml_array_add);
	_lanq.add_word("-=",	ml_array_sub);
	_lanq.add_word("--",	ml_array_sub2);
	_lanq.add_word("++",	ml_array_add2);
	_lanq.add_word("*=",	ml_array_mul);
	_lanq.add_word("/=",	ml_array_div);
	_lanq.add_word("=#",	ml_grid_set);
	_lanq.add_word("+=#",	ml_grid_add);
	_lanq.add_word("-=#",	ml_grid_sub);
	_lanq.add_word("--#",	ml_grid_sub2);
	_lanq.add_word("++#",	ml_grid_add2);
	_lanq.add_word("*=#",	ml_grid_mul);
	_lanq.add_word("/=#",	ml_grid_div);
		
	_lanq.add_word("*",			interpret_gml_math_mul);
	_lanq.add_word("/",			interpret_gml_math_div);
	_lanq.add_word("div",		interpret_gml_math_idiv);
	_lanq.add_word("!",			interpret_gml_math_neg);
	_lanq.add_word("^",			interpret_gml_math_chap);
	_lanq.add_word("==",		interpret_gml_math_equal);
	_lanq.add_word("??",		interpret_gml_math_null);
	_lanq.add_word("!=",		interpret_gml_math_nequal);
	_lanq.add_word("<=",		interpret_gml_math_eless);
	_lanq.add_word(">=",		interpret_gml_math_egrea);
	_lanq.add_word("<",			interpret_gml_math_less);
	_lanq.add_word(">",			interpret_gml_math_grea);
	_lanq.add_word("+",			interpret_gml_math_add);
	_lanq.add_word("-",			interpret_gml_math_sub);
	_lanq.add_word("mod",		interpret_gml_math_mod);
	_lanq.add_word("||",		interpret_gml_math_or);
	_lanq.add_word("&&",		interpret_gml_math_and);
	_lanq.add_word("and",		interpret_gml_math_and);
	_lanq.add_word("or",		interpret_gml_math_or);
	_lanq.add_word("xor",		interpret_gml_math_xor);
	
	_lanq.add_word("break",		interpret_gml_ifs_break);
	_lanq.add_word("continue",	interpret_gml_ifs_continue);
	_lanq.add_word("else",		interpret_gml_ifs_else);
	_lanq.add_word("for",		interpret_gml_ifs_for);
	_lanq.add_word("function",	interpret_gml_ifs_function);
	_lanq.add_word("if",		interpret_gml_ifs_if);
	_lanq.add_word("return",	interpret_gml_ifs_return);
	_lanq.add_word("try",		interpret_gml_ifs_try);
	_lanq.add_word("while",		interpret_gml_ifs_while);
	_lanq.add_word("with",		interpret_gml_ifs_with);
	_lanq.add_word("repeat",	interpret_gml_ifs_repeat);
	_lanq.add_word("new",		interpret_gml_ifs_new);
	
	_lanq.add_word("room",			interpret_gml_word_room);
	_lanq.add_word("room_width",	interpret_gml_word_room_width);
	_lanq.add_word("room_height",	interpret_gml_word_room_height);
	_lanq.add_word("argument",		interpret_gml_word_argument);
	_lanq.add_word("static",		interpret_gml_word_none);
	_lanq.add_word("self",			interpret_gml_word_self);
	_lanq.add_word("other",			interpret_gml_word_other);
	//_code, _temp={}, _configs={}, _args=[]
	
	
	
	#endregion
	
	#region interpreters
	_lanq.add_interpret(".",		interpret_gml_point);
	_lanq.add_interpret("str",		interpret_gml_string);
	_lanq.add_interpret("int",		interpret_gml_value);
	_lanq.add_interpret("real",		interpret_gml_value);
	_lanq.add_interpret("var",		interpret_gml_var);
	_lanq.add_interpret("set",		interpret_gml_set);
	_lanq.add_interpret("o.(",		interpret_gml_parenteses);
	_lanq.add_interpret("run.o.(",	interpret_gml_run_parenteses);
	_lanq.add_interpret("o.[",		interpret_gml_colchetes);
	_lanq.add_interpret("run.o.[",	interpret_gml_run_colchetes);
	_lanq.add_interpret("math",		interpret_gml_math);
	_lanq.add_interpret("mathP",	interpret_gml_math);
	_lanq.add_interpret("ifs",		interpret_gml_ifs);
	_lanq.add_interpret("o.{",		interpret_gml_chaves);
	_lanq.add_interpret("word",		interpret_gml_word);
	#endregion
	
	
}