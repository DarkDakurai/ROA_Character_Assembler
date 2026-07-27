superstruct = {
	far_above: [],
	far_below: [],
	far_side: [],
	mid_side: [],
	close_above: [],
	close_below: [],
	close_side: [],
	neutrals: []
}
changes_made = false;
supernames = {
	far_above: "far_up_attacks",
	far_below: "far_down_attacks",
	far_side: "far_side_attacks",
	mid_side: "mid_side_attacks",
	close_above: "close_up_attacks",
	close_below: "close_down_attacks",
	close_side: "close_side_attacks",
	neutrals: "neutral_attacks"
}
selected = "";

if !file_parse_ai_attacks(get_full_path("scripts/ai_init.gml"), superstruct) {
	room_goto(CharEdit_Main);
	exit;
}


function array_stringify(_array) {
	var _string = "";
	for (var i = 0; i < array_length(_array); i++) {
		if _string == "" {
			_string = _array[i];
		} else {
			_string = string("{0}, {1}", _string, _array[i]);
		}
		
	}
	return _string;
}

function ready_up_array() {
	var _arr = [];
	var _keys = struct_get_names(superstruct);
	for (var i = 0; i < array_length(_keys); i++) {
		for (var j = 0; j < array_length(superstruct[$ _keys[i]]); j++) {
			array_push(_arr, string("{0}[{1}] = AT_{2};", supernames[$ _keys[i]], j, superstruct[$ _keys[i]][j]));
		}
		array_push(_arr, "");
	}
	return _arr;
}

function tick_orange_text(_x, _y, _x2, _moveid, _debug = false) {
	var _contains = array_contains(superstruct[$ selected], _moveid);
	layer_text_blend(layer_text_get_id("Assets_2", string("ai_{0}", string_lower(_moveid))), multiplexer(_contains, c_orange, c_yellow));
	if mouse_in_rectangle(_x, _y, _x2, _y + 35, _debug) {
		set_cursor(cr_handpoint);
		if mouse_check_button_pressed(mb_left) {
			if !_contains {
				array_push(superstruct[$ selected], _moveid);
				changes_made = true;
			} else {
				array_delete_value(superstruct[$ selected], _moveid);
				changes_made = true;
			}
		}
	}
}

function file_parse_ai_attacks(_file_path, _struct) {
	var _file = archive_fetch_file(AP.SCRIPTS, _file_path);
	if _file == undefined {
		archive_create(AP.SCRIPTS, _file_path, FT.GML);
		_file = archive_fetch_file(AP.SCRIPTS, _file_path);
		if _file == undefined {
			show_message("Failed to create ai_init.gml, due to this the ai editor is unaccessible");
			return false;
		}
	}

	for (var i = 0; i < array_length(_file); i++) {
		var _line = string_trim(_file[i]);
		if (_line != "" && string_pos("//", _line) != 1) {
			var _bracket_pos = string_pos("[", _line);
			var _equal_pos = string_pos("=", _line);
			if (_bracket_pos > 0 && _equal_pos > _bracket_pos) {
				var _array_name = string_trim(string_copy(_line, 1, _bracket_pos - 1));
				var _attack_name = string_trim(string_copy(_line, _equal_pos + 1, string_length(_line) - _equal_pos));
				_attack_name = string_replace(_attack_name, ";", "");
				_attack_name = string_replace(_attack_name, "AT_", "");
				_attack_name = string_trim(_attack_name);
				
				switch (_array_name) {
					case "far_up_attacks": array_push(_struct.far_above, _attack_name); break;
					case "far_down_attacks": array_push(_struct.far_below, _attack_name); break;
					case "far_side_attacks": array_push(_struct.far_side, _attack_name); break;
					case "mid_side_attacks": array_push(_struct.mid_side, _attack_name); break;
					case "close_up_attacks": array_push(_struct.close_above, _attack_name); break;
					case "close_down_attacks": array_push(_struct.close_below, _attack_name); break;
					case "close_side_attacks": array_push(_struct.close_side, _attack_name); break;
					case "neutral_attacks": array_push(_struct.neutrals, _attack_name); break;
				}
			}
		}	
	}
	return true;
}