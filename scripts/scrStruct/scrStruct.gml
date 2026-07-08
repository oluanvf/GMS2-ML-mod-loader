#region registro
function ml_register_struct(_ds, _type, _func){global.ml_ds.structures[$ global.ml_ds.structures.size] = [_ds, _type, _func]; global.ml_ds.structures.size+=1;}
function ml_ds_map_create(){var _ds = ds_map_create(); ml_register_struct(_ds, ds_type_map, ds_map_destroy); return _ds}
function ml_ds_list_create(){var _ds = ds_list_create(); ml_register_struct(_ds, ds_type_list, ds_list_destroy); return _ds}

function ml_destroy_structs(){
	var _struct = global.ml_ds.structures
	var _structs = struct_get_names(_struct);
	for(var i = 0; i < array_length(_structs); i++)
	{
		var _name	= _structs[i]
		if(_name=="size"){continue}
		var _val	= _struct[$ _name];
		var _ds		= _val[0];
		var _type	= _val[1];
		var _func	= _val[2];
		var _enable = ds_exists(_ds,_type);
		if(_enable){
			_func(_ds);
			show_debug_message($"apagando {_ds}")
		}
		struct_remove(_struct, _name);
	}
}
#endregion

#region DS
#region STRUCT
function ml_struct_copy(_struct, _struct2={}){
	var _names = struct_get_names(_struct)
	for(var i = 0; i < array_length(_struct); i++)
	{
		var _name = _names[i];
		var _val = _struct[i];
		if(is_struct(_val)){
			_val = ml_struct_copy(_val);
		}else
		if(is_array(_val))
		{
			var _arr = [];
			array_copy(_arr, 0, _val, 0, array_length(_val));
			_val = _arr
		}
		_struct2[$ _name] = _val;
	}
	return _struct2
}
function ml_struct_get(_struct, _name="", _def=undefined){return _struct[$ _name]??_def;}
function ml_struct_set(_struct, _name="", _val=0){_struct[$ _name] =_val;}
function ml_struct_add(_struct, _name="", _val=0){_struct[$ _name]+=_val;}
function ml_struct_sub(_struct, _name="", _val=0){_struct[$ _name]-=_val;}
function ml_struct_div(_struct, _name="", _val=1){_struct[$ _name]/=_val;}
function ml_struct_mul(_struct, _name="", _val=1){_struct[$ _name]*=_val;}
function ml_struct_add2(_struct, _name=""){_struct[$ _name]++}
function ml_struct_sub2(_struct, _name=""){_struct[$ _name]--}
#endregion

#region MAP
function ml_map_get(_map, _name=[""], _def=undefined){return _map[? _name[0]]??_def;}
function ml_map_set(_map, _name=[""], _val=0){_map[? _name[0]] =_val;}
function ml_map_add(_map, _name=[""], _val=0){_map[? _name[0]]+=_val;}
function ml_map_sub(_map, _name=[""], _val=0){_map[? _name[0]]-=_val;}
function ml_map_div(_map, _name=[""], _val=1){_map[? _name[0]]/=_val;}
function ml_map_mul(_map, _name=[""], _val=1){_map[? _name[0]]*=_val;}
function ml_map_add2(_map, _name=[""]){_map[? _name[0]]++}
function ml_map_sub2(_map, _name=[""]){_map[? _name[0]]--}
#endregion

#region LIST
function ml_list_get(_struct, _name=[0], _def=undefined){return _struct[| _name[0]]??_def;}
function ml_list_set(_list, _name=[0], _val=0){_list[| _name[0]] =_val;}
function ml_list_add(_list, _name=[0], _val=0){_list[| _name[0]]+=_val;}
function ml_list_sub(_list, _name=[0], _val=0){_list[| _name[0]]-=_val;}
function ml_list_div(_list, _name=[0], _val=1){_list[| _name[0]]/=_val;}
function ml_list_mul(_list, _name=[0], _val=1){_list[| _name[0]]*=_val;}
function ml_list_add2(_list, _name=[0]){_list[| _name[0]]++}
function ml_list_sub2(_list, _name=[0]){_list[| _name[0]]--}
#endregion

#region ARRAY
function ml_array_get(_arr, _index=0, _def=undefined){if(!is_array(_arr)){_arr=[_arr]}; if(_index>=0&&_index<array_length(_arr)&&_index!=array_length(_arr)){return _arr[_index]}return _def;}
function ml_array_set(_arr, _name=0, _val=0){_arr[_name] =_val;}
function ml_array_add(_arr, _name=0, _val=0){_arr[_name]+=_val;}
function ml_array_sub(_arr, _name=0, _val=0){_arr[_name]-=_val;}
function ml_array_div(_arr, _name=0, _val=1){_arr[_name]/=_val;}
function ml_array_mul(_arr, _name=0, _val=1){_arr[_name]*=_val;}
function ml_array_add2(_arr, _name=0){_arr[_name]++}
function ml_array_sub2(_arr, _name=0){_arr[_name]--}
function ml_array_find(_arr, _val, _def=-1){var ret = _def; for(var i = 0; i < array_length(_arr); i++){var _valf = _arr[i]; if(_valf==_val){return i}}return ret;}
#endregion

#region GRID
function ml_grid_get(_grid, _name=[0, 0], _def=undefined){return _grid[# _name[0], _name[1]] ?? _def}
function ml_grid_set(_grid, _name=[0, 0], _val=0){_grid[# _name[0], _name[1]] =_val;}
function ml_grid_add(_grid, _name=[0, 0], _val=0){_grid[# _name[0], _name[1]]+=_val;}
function ml_grid_sub(_grid, _name=[0, 0], _val=0){_grid[# _name[0], _name[1]]-=_val;}
function ml_grid_div(_grid, _name=[0, 0], _val=1){_grid[# _name[0], _name[1]]/=_val;}
function ml_grid_mul(_grid, _name=[0, 0], _val=1){_grid[# _name[0], _name[1]]*=_val;}
function ml_grid_add2(_grid, _name=[0, 0]){_grid[# _name[0], _name[1]]++}
function ml_grid_sub2(_grid, _name=[0, 0]){_grid[# _name[0], _name[1]]--}
#endregion
#endregion
