function gml_exception_handle(){
	var _zip = working_directory+@"bug\ML bug.zip"
	if(file_exists(_zip))
	{
		zip_unzip(_zip, working_directory+@"bug\");
	}
	if(file_exists(working_directory+@"bug\data.win"))
	{
		game_change("/bug",$"-game {working_directory+@"bug\data.win"} -win \"{global.ml_ds.handleC.winFile}\"") 
	}
}