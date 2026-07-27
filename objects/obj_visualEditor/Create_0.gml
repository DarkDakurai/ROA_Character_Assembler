function trigger(_hitbox) {
	hitb = _hitbox;
	sprite = fetch_attack_sprite(_hitbox);
	origin = fetch_sprite_origin(_hitbox);
	frame = 0;
	zoom = 2;
	dragging = false;
	dragID = "";
	click_offset_x = 0;
	click_offset_y = 0;
}

function fetch_attack_sprite(_hitbox) {
	if real(_hitbox.HG_HITBOX_TYPE) == 1 {
		var _sprpath = obj_EDITORattacks.MEGARAM[$ obj_EDITORattacks.selected_attack].data.AG_SPRITE;
		_sprpath = get_quoted_text(_sprpath);
		var _allfiles = get_all_files(string("{0}/sprites/", global.selected_path));
		var _found = "";
		for (var i = 0; i < array_length(_allfiles); i++) {
			if string_pos(string("{0}_strip", _sprpath), _allfiles[i]) != 0 {
				_found = _allfiles[i];
				break;
			}
		}
		if _found == "" {
			if file_exists(string("{0}/sprites/{1}.png", global.selected_path, _sprpath)) {
				return sprite_add(string("{0}/sprites/{1}.png", global.selected_path, _sprpath), 1, false, false, 0, 0);
			}
		}
		var _pos1 = string_pos("_strip", _found) + 6;
		var _pos2 = string_pos(".png", _found);
		var _frames = string_copy(_found, _pos1, _pos2 - _pos1);
		//show_debug_message(_found);
		//show_debug_message(_frames);
		return sprite_add(string("{0}/sprites/{1}", global.selected_path, _found), _frames, false, false, 0, 0);
	} else {
		var _sprpath = _hitbox.HG_PROJECTILE_SPRITE;
		_sprpath = get_quoted_text(_sprpath);
		var _allfiles = get_all_files(string("{0}/sprites/", global.selected_path));
		var _found = "";
		for (var i = 0; i < array_length(_allfiles); i++) {
			if string_pos(string("{0}_strip", _sprpath), _allfiles[i]) != 0 {
				_found = _allfiles[i];
				break;
			}
		}
		if _found == "" {
			if file_exists(string("{0}/sprites/{1}.png", global.selected_path, _sprpath)) {
				return sprite_add(string("{0}/sprites/{1}.png", global.selected_path, _sprpath), 1, false, false, 0, 0);
			}
		}
		var _pos1 = string_pos("_strip", _found) + 6;
		var _pos2 = string_pos(".png", _found);
		var _frames = string_copy(_found, _pos1, _pos2 - _pos1);
		//show_debug_message(_found);
		//show_debug_message(_frames);
		return sprite_add(string("{0}/sprites/{1}", global.selected_path, _found), _frames, false, false, 0, 0);
	}
}

function fetch_sprite_origin(_hitbox) {
	if real(_hitbox.HG_HITBOX_TYPE) == 1 {
		var _sprpath = obj_EDITORattacks.MEGARAM[$ obj_EDITORattacks.selected_attack].data.AG_SPRITE;
		_sprpath = get_quoted_text(_sprpath);
	
		if !file_exists(string("{0}/scripts/load.gml", global.selected_path)) {
			show_message("Error: Missing load.gml file in the scripts folder!");
			room_restart();
			exit;
		}
		var _file = file_text_open_read(string("{0}/scripts/load.gml", global.selected_path));
		var _found = undefined;
		while _found == undefined and !file_text_eof(_file) {
			var _line = string_replace_all(file_text_read_string(_file), " ", "");
			_line = string_replace_all(_line, "\t", "");
			if string_pos("//", _line) != 0 {
				_line = string_copy(_line, 1, string_pos("//", _line) - 1);
			}
			var _check = string("sprite_change_offset(\"{0}\",", _sprpath);
			if string_pos(_check, _line) != 0 {
				var _pos1 = string_pos(_check, _line) + string_length(_check);
				var _pos2 = string_pos_ext(",", _line, _pos1);

				if _pos2 == 0 {
					file_text_readln(_file);
					continue;
				}
			
				var _val1 = real(string_copy(_line, _pos1, _pos2 - _pos1));
	
				_pos1 = _pos2 + 1;
			
				if string_pos_ext(")", _line, _pos1) != 0 {
					_pos2 = string_pos_ext(")", _line, _pos1);
				} else {
					_pos2 = string_pos_ext(",", _line, _pos1);
				}
			

				if _pos2 == 0 {
					file_text_readln(_file);
					continue;
				}
			
				var _val2 = real(string_copy(_line, _pos1, _pos2 - _pos1));
				_found = [_val1, _val2];
			}
			file_text_readln(_file);
		}
		file_text_close(_file);
		if _found == undefined {
			return [0, 0];
		}
		return _found;
	} else {
		return [17, 80];
	}
}

function ui() {
	var _focused = is_focused("viseditor", "", obj_EDITORattacks);
	var _halfocused = is_focused("viseditor", -1, obj_EDITORattacks);
	
	// MUCH SHIT
	if _halfocused {
		rename_float_button("VISUALEDITOR", "graphic_752BC311", "text_7EB74EE4", hitb, "HG_HITBOX_X", "hbposx", obj_EDITORattacks, "viseditor");
		rename_float_button("VISUALEDITOR", "graphic_45DB990B", "text_67F10B97", hitb, "HG_HITBOX_Y", "hbposy", obj_EDITORattacks, "viseditor");
		rename_float_button("VISUALEDITOR", "graphic_CCFAF91", "text_7B6C9BD9", hitb, "HG_WIDTH", "hbwid", obj_EDITORattacks, "viseditor");
		rename_float_button("VISUALEDITOR", "graphic_344CA6CD", "text_59C8145F", hitb, "HG_HEIGHT", "hbhei", obj_EDITORattacks, "viseditor");
		rename_int_button("VISUALEDITOR", "graphic_B8F4D92", "text_236BCD7", hitb, "HG_ANGLE", "hbangle", obj_EDITORattacks, "viseditor");
		rename_float_button("VISUALEDITOR", "graphic_33496B60", "text_67BB0A8C", hitb, "HG_HITBOX_GROUP", "hbgroup", obj_EDITORattacks, "viseditor");
		hitb.HG_HITBOX_GROUP = floor(real(hitb.HG_HITBOX_GROUP));
		correct_value_between(hitb, "HG_HITBOX_GROUP", -1, infinity);
	}
	
	// HIT TYPE
	
	initialize_struct_key(hitb, "HG_SHAPE", 0);
	sprite_button_color("VISUALEDITOR", "graphic_62922794", real(hitb.HG_SHAPE) == 0, c_white, c_aqua);
	sprite_button_color("VISUALEDITOR", "graphic_3B733A7E", real(hitb.HG_SHAPE) == 1, c_white, c_aqua);
	sprite_button_color("VISUALEDITOR", "graphic_25D9CBC8", real(hitb.HG_SHAPE) == 2, c_white, c_aqua);
	if _focused {
		button_change_var(hitb, "HG_SHAPE", 0, "VISUALEDITOR", "graphic_44E46D6B");
		button_change_var(hitb, "HG_SHAPE", 1, "VISUALEDITOR", "graphic_2D271604");
		button_change_var(hitb, "HG_SHAPE", 2, "VISUALEDITOR", "graphic_62A09549");
	}
	
	// EXIT BUTTEN
	if _focused and mouse_in_uibox("VISUALEDITOR", "graphic_3A415DCB", cr_handpoint, true) {
		obj_EDITORattacks.focus = "hitboxes";
		obj_EDITORattacks.focus_secondary = "";
		layer_set_visible(layer_get_id("VISUALEDITOR"), false);
		instance_deactivate_object(obj_visualEditor);
		if sprite_exists(sprite) {
			sprite_delete(sprite);
		}
	}
}

function set_dragging(_drID) {
	dragging = true;
	dragID = _drID;
}

function not_dragging() {
	return !dragging;
}

function is_dragging(_drID) {
	return dragging and dragID == _drID;
}

function stop_dragging() {
	dragging = false;
	dragID = "";
}