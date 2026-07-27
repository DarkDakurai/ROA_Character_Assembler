load_all();
focus = "nothing";
selected = -1;
forbidden = ["charselect.png", "hud.png", "hurt.png", "icon.png", "offscreen.png", "portrait.png", "preview.png", "result_small.png"];
pivot_x = 0;
pivot_y = 0;
graph_cam_x = 0;
graph_cam_y = 0;
img_timer = 0;
img_timer_paused = true;
img_zoom = 5;
show_hurtbox = false;
renaming = 0;
origname = "";
hurttwin = -1;
notouch = false;
global.scroll_y = 0;

function load_all() {
	all_loaded_sprites = [];
	var _allbasic = ["charselect.png", "hud.png", "hurt.png", "icon.png", "offscreen.png", "portrait.png", "preview.png", "result_small.png"];
	
	for (var i = 0; i < array_length(_allbasic); i++) {
		if archive_fetch_file(AP.MAIN, get_full_path(_allbasic[i])) == undefined {
			if !archive_create(AP.MAIN, get_full_path(_allbasic[i]), FT.SPRITE) {
				show_message("The sprite editor failed to create missing mandatory sprites, for this reason it cannot be utilized.");
				room_goto(CharEdit_Main);
				exit;
			}
		}
		var _fstr = archive_fetch_filestruct(AP.MAIN, get_full_path(_allbasic[i]));
		array_push(all_loaded_sprites, [_fstr.file, filename_name(_fstr.path), 0, _fstr.path]);
	}

	var _allcustom = archive_fetch(AP.SPRITES);
	
	for (var i = 0; i < array_length(_allcustom); i++) {
		var _fstr = _allcustom[i];
		if !string_starts_with(filename_name(_fstr.path), "_") {
			if string_pos("_strip", filename_name(_fstr.path)) == 0 {
				array_push(all_loaded_sprites, [_fstr.file, filename_name(_fstr.path), 3, _fstr.path]);
			} else {
				array_push(all_loaded_sprites, [_fstr.file, filename_name(_fstr.path), 1, _fstr.path]);
			}
		}
	}
	
}

function initialize_spriteditor(_spritepath, _type, _sprite, _name) {
	graph_cam_x = 0;
	graph_cam_y = 0;
	img_timer = 0;
	notouch = true;
	img_timer_paused = true;
	origname = _name;
	var _hurtpath = string("{0}/sprites/{1}_hurt_strip{2}.png", global.selected_path, origname, sprite_get_number(_sprite));
	hurttwin = find_path_in_sprites(_hurtpath);
	
	layer_sprite_blend(layer_sprite_get_id("Assets_3", "sprites_graphbox"), multiplexer(_type, c_orange, c_aqua, c_lime, c_yellow))
	
	var _fstr = archive_fetch_filestruct(AP.SCRIPTS, get_full_path("scripts/load.gml"));
	if _fstr == undefined {
		show_debug_message("load.gml file missing, an empty substitute has been created");
		archive_create(AP.SCRIPTS, get_full_path("scripts/load.gml"), FT.GML);
		_fstr = archive_fetch_filestruct(AP.SCRIPTS, get_full_path("scripts/load.gml"));
		if _fstr == undefined {
			show_message("Could not create load.gml file, the editor cannot be used.");
			room_restart();
		}
	}


	if _type == 0 or _type == 2 {
		pivot_x = -1;
		pivot_y = -1;
		return;
	}
	var _file = _fstr.file;
	
	var _nametocheck = filename_name(_spritepath);
	_nametocheck = string_copy(_nametocheck, 1, string_pos(".", _nametocheck) - 1);
	if string_pos("_strip", _nametocheck) != 0 {
		_nametocheck = string_copy(_nametocheck, 1, string_pos("_strip", _nametocheck) - 1);
	}
	
	for (var i = 0; i < array_length(_file); i++) {
		var _stringline = _file[i];
		if string_pos(string("sprite_change_offset(\"{0}\"", _nametocheck), _stringline) != 0 {
			read_pivot_gml(_stringline, _nametocheck);
			return;
		}
	}

	pivot_x = floor(sprite_get_width(_sprite) / 2);
	pivot_y = sprite_get_height(_sprite) - 1;
	archive_edit_gml_newline(AP.SCRIPTS, get_full_path("scripts/load.gml"), string("sprite_change_offset(\"{0}\", {1}, {2});", _nametocheck, pivot_x, pivot_y));
}

function read_pivot_gml(_string, _name) {
	//sprite_change_offset("idle", 32, 62);
	var _foundpos = string_pos(string("\"{0}\"", _name), _string);
	var _readstart_pos1 = _foundpos + 1 + string_length(_name) + 3;
	pivot_x = floor(real(string_copy(_string, _readstart_pos1, string_pos_ext(",", _string, _readstart_pos1))));
	var _readstart_pos2 = _readstart_pos1 + string_length(string(pivot_x)) + 2;
	pivot_y = floor(real(string_copy(_string, _readstart_pos2, string_pos_ext(")", _string, _readstart_pos2))));
}

function is_taken(_name) {
	for (var i = 0; i < array_length(all_loaded_sprites); i++) {
		if all_loaded_sprites[i][1] == _name {
			return true;
		}
	}
	return false;
}

function save_pivot(_name) {
	show_debug_message("peep");
	if pivot_x != -1 and pivot_y != -1 {
		
		if string_pos(".", _name) != 0 {
			_name = string_copy(_name, 1, string_pos(".", _name) - 1);
		}
		if string_pos("_strip", _name) {
			_name = string_copy(_name, 1, string_pos("_strip", _name) - 1);
		}
		var _path = get_full_path("scripts/load.gml");
		var _string = string("sprite_change_offset(\"{0}\"", _name);
		var _pos = archive_fetch_gml_string_pos(AP.SCRIPTS, _path, _string, false);
		if _pos >= 0 {
			archive_edit_gml_line(AP.SCRIPTS, get_full_path("scripts/load.gml"), _pos, string("sprite_change_offset(\"{0}\", {1}, {2});", _name, pivot_x, pivot_y));
		}
	}
}

function find_path_in_sprites(_path) {
	for (var i = 0; i < array_length(all_loaded_sprites); i++) {
		if all_loaded_sprites[i][3] == _path {
			return i;
		}
	}
	return -1;
}

function sprite_save_green_animated(_sprite) {
	var _frames = sprite_get_number(_sprite);
	var _width = sprite_get_width(_sprite);
	var _height = sprite_get_height(_sprite);
	var _xorig = sprite_get_xoffset(_sprite);
	var _yorig = sprite_get_yoffset(_sprite);
	var _surf = surface_create(_width, _height);
	var _new_sprite = -1;
	shader_set(shd_green);
	
	for (var i = 0; i < _frames; i++) {
		surface_set_target(_surf);
		draw_clear_alpha(c_black, 0.0);
		draw_sprite(_sprite, i, _xorig, _yorig);
		surface_reset_target();
		
		if i == 0 {
			_new_sprite = sprite_create_from_surface(_surf, 0, 0, _width, _height, false, false, _xorig, _yorig);
		} else {
			sprite_add_from_surface(_new_sprite, _surf, 0, 0, _width, _height, false, false);
		}
	}
	
	shader_reset();
	surface_free(_surf);
	return _new_sprite;
}

























