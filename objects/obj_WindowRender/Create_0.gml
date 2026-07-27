sprite = spr_no;
selected = 0;
selected_window = 0;
select_start = 0;
select_end = 0;
scroll = 0;
windata = [];
function trigger() {
	var _path = string("{0}/sprites/", global.selected_path);
	var _allfiles = get_all_files(_path);
	var _movestruct = obj_EDITORattacks.MEGARAM[$ obj_EDITORattacks.selected_attack];
	var _movedata = _movestruct.data;
	windata = variable_clone(_movestruct.windows);
	selected = 0;
	select_start = 1;
	select_end = 5;
	scroll = 0;
	spritename = get_quoted_text(_movedata.AG_SPRITE);
	END = false;
	array_foreach(_allfiles, function(_v, _i) {
		if END {exit;}
		if string_pos(string("{0}_strip", spritename), _v) != 0 {
			var _pos1 = string_pos(string("{0}_strip", spritename), _v) + string_length(spritename) + 6;
			var _pos2 = string_pos(string(".png"), _v);
			var _frames = string_copy(_v, _pos1, _pos2 - _pos1);
			var _path = string("{0}/sprites/{1}", global.selected_path, _v);
			sprite = sprite_add(_path, _frames, false, false, 0, 0);
			END = true;
		}
	});
	
	array_foreach(_allfiles, function(_v, _i) {
		if END {exit;}
		if string_pos(string("{0}", spritename), _v) != 0 {
			var _path = string("{0}/sprites/{1}", global.selected_path, _v)
			sprite = sprite_add(_path, 1, false, false, 0, 0);
			END = true;
		}
	});
}

function draw_sprite_preview() {
	var _startW = sprite_get_width(sprite);
	var _startH = sprite_get_height(sprite);
	var _targetW = 64 * 3.42;
	var _targetH = 64 * 3.42;
	
	var _diffW = _targetW - _startW;
	var _diffH = _targetH - _startH;
	
	var _percW = 1 + (_diffW / _startW);
	var _percH = 1 + (_diffH / _startH);
	
	var _newScale = min(_percH, _percW) * 0.98;

	//var _drawXinc = ((_startW * _newScale) + 5);
	var _drawXinc = 220;
	show_debug_message(_drawXinc);
	scroll = clamp(scroll, -_drawXinc * max(0, sprite_get_number(sprite) - 6), 0);
	var _scrollMax =  -_drawXinc * max(0, sprite_get_number(sprite) - 6);
	var _scrollPercent = scroll / _scrollMax;

	var _selPos = 20 + _drawXinc * selected + scroll;
	var _selPosStart = 20 + _drawXinc * select_start + scroll;
	var _selPosEnd = 20 + _drawXinc * select_end + scroll;



	for (var i = 0; i < sprite_get_number(sprite); i++) {
		draw_sprite_ext(sprite, i, 20 + _drawXinc * i + scroll, 82, _newScale, _newScale, 0, c_white, 1);
		if mouse_in_rectangle(20 + _drawXinc * i + scroll, 82, 20 + _drawXinc * i + scroll + 64*3.42, 82 + 64*3.42, keyboard_check(vk_shift)) {
			set_cursor(cr_handpoint);
			if mouse_check_button_pressed(mb_left) {
				selected = i;
			}
		}
	}

	var _spanWidth = (_selPosEnd - _selPosStart) + (64 * 3.42);
	var _spanXScale = _spanWidth / 64;

	if array_length(windata) > 0 {
		draw_sprite_ext(spr_UIbox_clear, 0, _selPosStart, 82, _spanXScale, 3.42, 0, c_yellow, 1);
	}

	draw_sprite_ext(spr_UIbox_clear, 0, _selPos, 82, 3.42, 3.42, 0, c_aqua, 1);


	layer_sprite_x(get_ui_id("Windows", "graphic_4C3FEB8E", true), 54 + (1188 * _scrollPercent));

	if mouse_in_uibox("Windows", "graphic_1DCC0631", cr_size_we, false) {
		if mouse_check_button(mb_left) {
			_scrollPercent = clamp((mouse_x - 54) / 1188, 0, 1);
			scroll = _scrollMax * _scrollPercent;
			selected = floor(sprite_get_number(sprite) * _scrollPercent);
		}
	}

	layer_text_text(get_ui_id("Windows", "text_588810A", false), sprite_get_number(sprite));

	// corrections
	draw_sprite_ext(spr_UIbox, 0, 0, 73, 0.18, 3.68, 0, c_white, 1);
	draw_sprite_ext(spr_black, 0, 2, 69, 0.125, 3.83, 0, c_white, 1);
	draw_sprite_ext(spr_UIbox, 0, 1351, 73, 0.23, 4.23, 0, c_white, 1);
	draw_sprite_ext(spr_black, 0, 1353, 66, 0.17, 3.75, 0, c_white, 1);
}

function draw_windows() { // corrects shit if fucked up too
	var _framecount = 0;
	var _sel_index = 0;
	

	for (var i = 0; i < array_length(windata); i++) {
		var _window = windata[i];
		var _maxwin = sprite_get_number(sprite);
		
		initialize_struct_key(_window, "AG_WINDOW_LENGTH", 1);
		initialize_struct_key(_window, "AG_WINDOW_ANIM_FRAMES", 1);
		initialize_struct_key(_window, "AG_WINDOW_ANIM_FRAME_START", _framecount);
		correct_value_between(_window, "AG_WINDOW_LENGTH", 1, infinity);
		
		var _minwin = _framecount;
		if (_maxwin <= _minwin) {
			array_delete(windata, i, 1);
			i--;
			continue;
		}
		
		var _frames_left = _maxwin - _minwin;
		correct_value_between(_window, "AG_WINDOW_ANIM_FRAMES", 1, _frames_left);
		
		_window.AG_WINDOW_ANIM_FRAME_START = _minwin;
		_framecount += _window.AG_WINDOW_ANIM_FRAMES;
		
		if (selected >= _minwin and selected < _minwin + _window.AG_WINDOW_ANIM_FRAMES) {
			_sel_index = i;
			selected_window = i;
			select_start = _minwin;
			select_end = _minwin + _window.AG_WINDOW_ANIM_FRAMES - 1;
		}
	}

	var _total_windows = array_length(windata);
	
	var _start_index = min(_sel_index, max(0, _total_windows - 6));
	
	for (var j = 0; j < 6; j++) {
		var _curr = _start_index + j;
		
		if (_curr >= _total_windows) {
			break;
		}
		
		var _window = windata[_curr];
		var _minwin = _window.AG_WINDOW_ANIM_FRAME_START;
		
		var _col = (_curr == _sel_index) ? c_yellow : c_white;
		var _ypos = 352 + 66 * j;
		
		draw_sprite_ext(spr_UIbox, 0, 219, _ypos, 17.7, 1, 0, _col, 1);
		
		if mouse_in_rectangle(219, _ypos, 219 + 64 * 17.7, _ypos + 64) {
			set_cursor(cr_handpoint);
			if mouse_check_button_pressed(mb_left) {
				selected = _minwin;
			}
		}
		
		draw_sprite_ext(spr_UIbox, 0, 1257, _ypos, 1.5, 1, 0, c_white, 1);
		draw_text_ext_transformed(1278, _ypos + 14, "EDIT", 99, 9999, 0.43, 0.43, 0);
		if mouse_in_rectangle(1257, _ypos, 1257 + 64+32, _ypos + 64) {
			set_cursor(cr_handpoint);
			if mouse_check_button_pressed(mb_left) {
				select_window(_curr);
			}
		}
		
		draw_text_ext_transformed(226, _ypos, _window.name, 99, 9999, 0.8, 0.8, 0);
		draw_set_halign(fa_right);
		draw_text_ext_transformed_color(1253, _ypos + 10, string("FROM [{0}-{1}] IN {2} FRAMES", _minwin, _minwin + _window.AG_WINDOW_ANIM_FRAMES - 1, _window.AG_WINDOW_LENGTH), 99, 9999, 0.5, 0.5, 0, c_gray, c_gray, c_gray, c_gray, 1);
		draw_set_halign(fa_left);
	}
}

function select_window(_selected) {
	obj_EDITORattacks.focus = "winedit";
	obj_EDITORattacks.focus_secondary = "";
	obj_WindowManager.selected = windata[_selected];
	obj_WindowManager.selid = _selected;
	layer_set_visible(layer_get_id("Window"), true);
}

function handle_buttons() {
	if array_length(windata) > 0 {
		selected_window = clamp(selected_window, 0, array_length(windata) - 1);
	} else {
		selected_window = -1;
	}
	// ADD WINDOW
	if mouse_in_uibox("Windows", "graphic_32EC7F60", cr_handpoint, true) {
		array_push(windata, {name: string("WINDOW {0}", array_length(windata) + 1)});
	}
	// REMOVE WINDOW
	if array_length(windata) > 0 {
		layer_text_blend(get_ui_id("Windows", "text_186DDB0C", false), c_white)
		if mouse_in_uibox("Windows", "graphic_432F0A7D", cr_handpoint, true) {
			var _olddata = variable_clone(windata[selected_window]);
			array_delete(windata, selected_window, 1);
			for (var i = selected_window; i < array_length(windata); i++) {
				windata[i].AG_WINDOW_ANIM_FRAME_START -= _olddata.AG_WINDOW_ANIM_FRAMES;
			}
		}
	} else {
		layer_text_blend(get_ui_id("Windows", "text_186DDB0C", false), c_gray);
	}
	
	// SWAP UPWARDS
	if selected_window != 0 {
		layer_text_blend(get_ui_id("Windows", "text_208E5F75", false), c_white);
		if mouse_in_uibox("Windows", "graphic_A869F5", cr_handpoint, true) {
			var _olddata = windata[selected_window];
			windata[selected_window] = windata[selected_window - 1];
			windata[selected_window - 1] = _olddata;
			selected_window--;
		}
	} else {
		layer_text_blend(get_ui_id("Windows", "text_208E5F75", false), c_gray);
	}
	
	// SWAP DOWNWARDS
	if selected_window != array_length(windata) - 1 {
		layer_text_blend(get_ui_id("Windows", "text_7598F07D", false), c_white);
		if mouse_in_uibox("Windows", "graphic_28604495", cr_handpoint, true) {
			var _olddata = windata[selected_window];
			windata[selected_window] = windata[selected_window + 1];
			windata[selected_window + 1] = _olddata;
			selected_window++;
		}
	} else {
		layer_text_blend(get_ui_id("Windows", "text_7598F07D", false), c_gray);
	}
	
	// SAVE AND QUIT
	if mouse_in_uibox("Windows", "graphic_7D21242F", cr_handpoint, true) {
		var _movestruct = obj_EDITORattacks.MEGARAM[$ obj_EDITORattacks.selected_attack];
		_movestruct.windows = variable_clone(windata);
		windata = undefined;
		layer_set_visible(layer_get_id("Main"), true);
		layer_set_visible(layer_get_id("Windows"), false);
		instance_deactivate_object(obj_WindowRender);
		obj_EDITORattacks.focus = "nothing";
		obj_EDITORattacks.focus_secondary = "";
	}
	
	// DISCARD AND QUIT
	if mouse_in_uibox("Windows", "graphic_4EFA1A81", cr_handpoint, true) {
		windata = undefined;
		layer_set_visible(layer_get_id("Main"), true);
		layer_set_visible(layer_get_id("Windows"), false);
		instance_deactivate_object(obj_WindowRender);
		obj_EDITORattacks.focus = "nothing";
		obj_EDITORattacks.focus_secondary = "";
	}
}