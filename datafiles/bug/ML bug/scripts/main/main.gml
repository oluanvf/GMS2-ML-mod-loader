global.dados = {}
for(var i = 0; i < parameter_count(); i++)
{
	var _title = parameter_string(i)
	if(string_starts_with(_title,"-")&&i+1<=parameter_count())
	{
		global.dados[$ string_replace(_title, "-", "")]=parameter_string(i+1)
	}
}
window_set_size(500, 300)
window_center()
