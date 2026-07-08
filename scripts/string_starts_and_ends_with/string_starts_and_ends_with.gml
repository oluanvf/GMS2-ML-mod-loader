function string_starts_and_ends_with(_str, _starts, _ends=_starts){
	return string_starts_with(_str, _starts)&&string_ends_with(_str, _ends)
}