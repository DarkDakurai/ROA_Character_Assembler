layer_text_blend(layer_text_get_id("Assets_1", "BackArrow1_3_1"), c_white);
layer_text_blend(layer_text_get_id("Assets_1", "CloseButton1_3_1"), c_white);


if mouse_in_rectangle(1305, 0, 1365, 60) {
	layer_text_blend(layer_text_get_id("Assets_1", "CloseButton1_3_1"), c_red);
	if mouse_check_button_pressed(mb_left) and show_question("Are you sure you want to quit? \nAll unsaved changes will be lost!") {game_end()}
}

if mouse_in_rectangle(0, 0, 90, 60) {
	layer_text_blend(layer_text_get_id("Assets_1", "BackArrow1_3_1"), c_yellow);
	if mouse_check_button_pressed(mb_left) {
		if focus == "nothing" {
			if show_question("Are you sure you want to return to main menu? \nAll unsaved changes will be lost!") {room_goto(CharEdit_Main)}
		}
		show_debug_message(focus);
		if focus == "windows" or focus == "hitboxes" {
			room_restart();
		}
		
		if focus == "winedit" {
			focus = "windows";
			focus_secondary = "";
			layer_set_visible(layer_get_id("Window"), false);
		}
		
		if focus == "viseditor" {
			focus = "hitboxes";
			focus_secondary = "";
			layer_set_visible(layer_get_id("VISUALEDITOR"), false);
			if sprite_exists(obj_visualEditor.sprite) {
				sprite_delete(obj_visualEditor.sprite);
			}
			instance_deactivate_object(obj_visualEditor);
		}
	}
}