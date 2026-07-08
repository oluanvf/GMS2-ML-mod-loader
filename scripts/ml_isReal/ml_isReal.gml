function ml_isReal(_str){
	var existNumber = 0;
		//loop
		for(var ch = 1; ch < string_length(_str)+1; ch++)
		{
			var char = string_char_at(_str, ch);
			//caso não exista o caractere numerico, ou seja, é uma letra, retorna false
			if(string_pos(char, "0123456789.-")==0){
				return 0;
			}else
			//se existir numero, retorna verdadeiro
			if(string_pos(char, "0123456789")!=0){
				existNumber = 1
			}
		}
		return existNumber
}