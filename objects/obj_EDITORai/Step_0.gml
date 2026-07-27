layer_text_blend(layer_text_get_id("Assets_1", "BackArrow1_3"), c_white);
layer_text_blend(layer_text_get_id("Assets_1", "CloseButton1_3"), c_white);
layer_text_blend(layer_text_get_id("Assets_2", "ai_x"), c_white);
set_cursor(cr_default);

if mouse_in_rectangle(1305, 0, 1365, 60) {
	layer_text_blend(layer_text_get_id("Assets_1", "CloseButton1_3"), c_red);
	if mouse_check_button_pressed(mb_left) {game_end()}
}

if mouse_in_rectangle(0, 0, 90, 60) {
	layer_text_blend(layer_text_get_id("Assets_1", "BackArrow1_3"), c_yellow);
	if mouse_check_button_pressed(mb_left) {room_goto(CharEdit_Main)}
	set_cursor(cr_handpoint);
}


layer_text_text(layer_text_get_id("Assets_1", "ai_moveselect1"), array_stringify(superstruct.far_above));
layer_text_text(layer_text_get_id("Assets_1", "ai_moveselect2"), array_stringify(superstruct.far_below));
layer_text_text(layer_text_get_id("Assets_1", "ai_moveselect3"), array_stringify(superstruct.far_side));
layer_text_text(layer_text_get_id("Assets_1", "ai_moveselect4"), array_stringify(superstruct.mid_side));
layer_text_text(layer_text_get_id("Assets_1", "ai_moveselect5"), array_stringify(superstruct.close_above));
layer_text_text(layer_text_get_id("Assets_1", "ai_moveselect6"), array_stringify(superstruct.close_below));
layer_text_text(layer_text_get_id("Assets_1", "ai_moveselect7"), array_stringify(superstruct.close_side));
layer_text_text(layer_text_get_id("Assets_1", "ai_moveselect8"), array_stringify(superstruct.neutrals));

layer_sprite_blend(layer_sprite_get_id("Assets_1", "ai_plus1"), multiplexer(selected == "far_above", c_white, c_lime));
layer_sprite_blend(layer_sprite_get_id("Assets_1", "ai_plus2"), multiplexer(selected == "far_below", c_white, c_lime));
layer_sprite_blend(layer_sprite_get_id("Assets_1", "ai_plus3"), multiplexer(selected == "far_side", c_white, c_lime));
layer_sprite_blend(layer_sprite_get_id("Assets_1", "ai_plus4"), multiplexer(selected == "mid_side", c_white, c_lime));
layer_sprite_blend(layer_sprite_get_id("Assets_1", "ai_plus5"), multiplexer(selected == "close_above", c_white, c_lime));
layer_sprite_blend(layer_sprite_get_id("Assets_1", "ai_plus6"), multiplexer(selected == "close_below", c_white, c_lime));
layer_sprite_blend(layer_sprite_get_id("Assets_1", "ai_plus7"), multiplexer(selected == "close_side", c_white, c_lime));
layer_sprite_blend(layer_sprite_get_id("Assets_1", "ai_plus8"), multiplexer(selected == "neutrals", c_white, c_lime));

var _iscustom = file_exists(string("{0}/scripts/ai_update.gml", global.selected_path));
layer_text_alpha(layer_text_get_id("Assets_1", "ai_warning"), _iscustom);

if mouse_in_rectangle(1315, 110, 1354, 110 + 39) {
	set_cursor(cr_handpoint);
	if mouse_check_button_pressed(mb_left) {selected = "far_above"}
}
if mouse_in_rectangle(1315, 158, 1354, 158 + 39) {
	set_cursor(cr_handpoint);
	if mouse_check_button_pressed(mb_left) {selected = "far_below"}
}
if mouse_in_rectangle(1315, 210, 1354, 210 + 39) {
	set_cursor(cr_handpoint);
	if mouse_check_button_pressed(mb_left) {selected = "far_side"}
}
if mouse_in_rectangle(1315, 262, 1354, 262 + 39) {
	set_cursor(cr_handpoint);
	if mouse_check_button_pressed(mb_left) {selected = "mid_side"}
}
if mouse_in_rectangle(1315, 314, 1354, 314 + 39) {
	set_cursor(cr_handpoint);
	if mouse_check_button_pressed(mb_left) {selected = "close_above"}
}
if mouse_in_rectangle(1315, 366, 1354, 366 + 39) {
	set_cursor(cr_handpoint);
	if mouse_check_button_pressed(mb_left) {selected = "close_below"}
}
if mouse_in_rectangle(1315, 418, 1354, 418 + 39) {
	set_cursor(cr_handpoint);
	if mouse_check_button_pressed(mb_left) {selected = "close_side"}
}
if mouse_in_rectangle(1315, 471, 1354, 471 + 39) {
	set_cursor(cr_handpoint);
	if mouse_check_button_pressed(mb_left) {selected = "neutrals"}
}

layer_set_visible(layer_get_id("Assets_2"), selected != "");

if selected != "" {
	tick_orange_text(275, 200, 350, "JAB", true);
	tick_orange_text(275, 245, 520, "DATTACK", true);
	
	tick_orange_text(275, 323, 600, "NSPECIAL", true);
	tick_orange_text(275, 375, 605, "FSPECIAL", true);
	tick_orange_text(275, 428, 485, "USPECIAL", true);
	tick_orange_text(275, 479, 543, "DSPECIAL", true);
	
	tick_orange_text(275, 560, 606, "FSTRONG", true);
	tick_orange_text(275, 610, 480, "USTRONG", true);
	tick_orange_text(275, 658, 540, "DSTRONG", true);
	
	tick_orange_text(827, 196, 1089, "FTILT", true);
	tick_orange_text(827, 246, 969, "UTILT", true);
	tick_orange_text(827, 296, 1028, "DTILT", true);
	
	tick_orange_text(827, 380, 1065, "NAIR", true);
	tick_orange_text(827, 432, 1072, "FAIR", true);
	tick_orange_text(827, 480, 950, "UAIR", true);
	tick_orange_text(827, 533, 1008, "DAIR", true);
	tick_orange_text(827, 580, 995, "BAIR", true);
	
	tick_orange_text(827, 656, 956, "TAUNT", true);


	if mouse_in_rectangle(1054, 107, 1111, 170) {
		layer_text_blend(layer_text_get_id("Assets_2", "ai_x"), c_red);
		if mouse_check_button_pressed(mb_left) {
			selected = "";
			if changes_made {
				var _proceed = true;
	
				if _iscustom {
					_proceed = show_question("Warning: If you modify this character's AI through this interface, all it's custom AI code will be erased.\nDo you wish to proceed?");
					if _proceed {
						if chance_of(0.01) {audio_play_sound(snd_easteregg_1, 1225, false)} //omg deltarune ref?!?!?!?
						archive_delete(AP.SCRIPTS, string("{0}/scripts/ai_update.gml", global.selected_path));
					}
				}
	
				if _proceed {
					var _path = string("{0}/scripts/ai_init.gml", global.selected_path);
					var _fstr = archive_fetch_filestruct(AP.SCRIPTS, _path);
		
					_fstr.file = variable_clone(ready_up_array());
					_fstr.modified = true;
					global.archive_modified = true;
				}
			}
		}
	}
}