function ml_simpleView(arr, jump="", str=""){
	for(var i = 0; i < array_length(arr); i++)
	{
		if(!string_ends_with(str,"\n")){str+="\n"}
		str += jump+string(arr[i].token)+" "+string(arr[i].name)//+" "+string(arr[i].separated);
		if(struct_exists(arr[i], "fname"))
		{
			if(!string_ends_with(str,"\n")){str+="\n"}
			str+=jump+"fname :"+arr[i].fname
		}
		if(struct_exists(arr[i], "constructor"))
		{
			if(!string_ends_with(str,"\n")){str+="\n"}
			str+=jump+"+constructor\n"
		}
		if(struct_exists(arr[i], "new"))
		{
			if(!string_ends_with(str,"\n")){str+="\n"}
			str+=jump+"+new\n"
		}
		if(struct_exists(arr[i], "more"))
		{
			if(!string_ends_with(str,"\n")){str+="\n"}
			str+=jump+"more :"
			if(!string_ends_with(str,"\n")){str+="\n"}
			str=ml_simpleView(arr[i].more, jump+" - ", str)
		}
		if(struct_exists(arr[i], "code"))
		{
			if(!string_ends_with(str,"\n")){str+="\n"}
			str+=jump+"code :"
			if(!string_ends_with(str,"\n")){str+="\n"}
			str=ml_simpleView(arr[i].code, jump+"  - ", str)
		}
		
	}
	return str;
}