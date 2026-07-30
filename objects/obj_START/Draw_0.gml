global.scroll_y = clamp(global.scroll_y, -116 * max(array_length(global.saved_paths) - 4, 0), 0)
global.scroll_y2 = clamp(global.scroll_y2, -25 * max(array_length(global.templates) - 18, 0), 0)

var _elev = 234;

var i;
for (i = 0; i < array_length(global.saved_paths); i++) {
	var _y_diff = global.scroll_y + _elev + i * 116;
	
	//										X		Y						OTHER
	draw_set_halign(fa_left);
	draw_sprite_ext(spr_UIbox, 0,			15,				_y_diff,		14.2, 1.75, 0, c_white, 1);
	draw_sprite_ext(spr_UIbox, 0,			15,				_y_diff,		2.46, 1.75, 0, c_white, 1);
	draw_sprite_ext(global.previews[i], 0,	17,		3 +		_y_diff,		1.5, 1.48, 0, c_white, 1);
	draw_text_transformed(					178,	1 +		_y_diff,		global.charconfs[i].name, 0.5, 0.5, 0);
	draw_text_transformed_color(			178,	38 +	_y_diff,		global.filenames[i], 0.29, 0.29, 0, c_gray, c_gray, c_gray, c_gray, 1);
	
	//edit button
	draw_sprite_ext(spr_UIbox, 0,			178,	66 +	_y_diff,		1.65, 0.57, 0, c_white, 1);
  var _col = multiplexer(mouse_in_rectangle(178,	66 +	_y_diff,		283, 102 + _y_diff, false), c_white, c_lime);
	draw_text_ext_transformed_colour(		201,	66 +	_y_diff,		"EDIT", 99, 1000, 0.44, 0.44, 0, _col, _col, _col, _col, 1);
	
	if _col == c_lime {set_cursor(cr_handpoint)}
	if _col == c_lime and mouse_check_button_pressed(mb_left) {
		global.selected_filename = global.filenames[i]; 
		global.selected_path = global.saved_paths[i];
		INITIALIZE_ARCHIVE(global.selected_path);
		room_goto(CharEdit_Main)
	}
	
	_col = multiplexer(mouse_in_rectangle(	873,	5 +		_y_diff,		919, 50 + _y_diff, false), c_white, c_red);
	draw_sprite_ext(spr_UIbox, 0,			873,	5 +		_y_diff,		0.71, 0.71, 0, _col, 1);
	draw_sprite_ext(spr_trash, 0,			896,	28 +	_y_diff,		2.375, 2.375, 0, _col, 1);
	if _col == c_red {
		set_cursor(cr_handpoint);
		if mouse_check_button_pressed(mb_left) and show_question("Are you sure you want to delete this character?") {
			directory_destroy(global.saved_paths[i]);
			room_restart();
		}
	}
}

tick_dragging_layer("Overlay");

for (i = 0; i < array_length(global.templates); i++) {
	var _val = "templates/" + global.templates[i];
	var _y_diff = global.scroll_y2 + 230 + i * 25;
	
	draw_set_halign(fa_left);
	draw_set_font(fnt_maplemono_SDF);
	if file_exists(_val) {
		var _col = multiplexer(global.selected_template == i, c_white, c_yellow)
		
		if mouse_in_rectangle(936, 7 + _y_diff, 959, 26 + _y_diff, false) {
			draw_sprite_ext(spr_trash, 1, 948, 17 + _y_diff, 1.3, 1.3, 0, c_red, 1);
			if mouse_check_button_pressed(mb_left) {
				if show_question("Are you sure you want to delete " + filename_name(_val) + "?") {
					file_delete(_val);
				}
			}
		} else {
			draw_sprite_ext(spr_directory, 1, 931, _y_diff, 2, 2, 0, c_white, 1);
		}
		
		draw_text_ext_transformed_colour(963, 6.5 + _y_diff, filename_name(_val), 999, 9999, 1, 1, 0, _col, _col, _col, _col, 1);
		
		if mouse_in_rectangle(934, 5 + _y_diff, 1310, 28 + _y_diff, false) {
			set_cursor(cr_handpoint);
			if mouse_check_button_pressed(mb_left) {
				global.selected_template = i;
			}
		}
		
	} else {
		array_delete(global.templates, i, 1);
		if global.selected_template == i {global.selected_template = 0}
		i--;
	}
	if global.selected_template > array_length(global.templates) {global.selected_template = 0}
	draw_set_font(fnt_jersey20_SDF);
}

var _col = multiplexer(mouse_in_uibox("Assets_1", "graphic_2D707A0B", cr_handpoint, false), c_white, c_aqua);
layer_sprite_blend(get_ui_id("Assets_1", "graphic_2D707A0B", true), _col);
layer_sprite_blend(get_ui_id("Assets_1", "graphic_17131E6A", true), _col);

if _col == c_aqua and mouse_check_button_pressed(mb_left) {
	show_message("Please select a .zip file including all the files for a character:\nThe zip file should look like this:\n templatecharacter.zip/...\nNOT LIKE THIS:\n templatecharacter.zip/character/...\n\nYou CAN drag multiple .zip files here to import them quickly as templates");
	var _newp = askfor_zip_path();
	if _newp == "" {
		show_message("Template import failed: Invalid file type or action was cancelled");
		exit;
	}
	file_copy(_newp, "templates/" + filename_name(_newp));
	room_restart();
}

layer_text_blend(get_ui_id("Assets_1", "text_5453ED1F", false), c_white);
if array_length(global.templates) > 0 {
	if mouse_in_uibox("Assets_1", "graphic_2B30B1FC", cr_handpoint, false) {
		layer_text_blend(get_ui_id("Assets_1", "text_5453ED1F", false), c_yellow);
		if mouse_check_button_pressed(mb_left) {
			var _filename = "NewCharacter";
			var _inc = "";
			var _string = multiplexer(global.selected_dest, global.superpath, global.superpath + "/")
			while directory_exists(string("{2}{0}{1}", _filename, _inc, _string)) {
				if _inc == "" {
					_inc = 1;
				} else {
					_inc++;
				}
			}
			zip_unzip("templates/" + global.templates[global.selected_template], string("{2}{0}{1}", _filename, _inc, _string));
			room_restart();
		}
	}
} else {
	layer_text_blend(get_ui_id("Assets_1", "text_5453ED1F", false), c_gray);
}


































