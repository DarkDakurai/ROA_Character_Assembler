set_cursor(cr_default);
layer_text_blend(layer_text_get_id("Assets_1", "saved_folder"), multiplexer(global.selected_dest, c_yellow, c_white));
layer_text_blend(layer_text_get_id("Assets_1", "workshop_folder"), multiplexer(1 - global.selected_dest, c_yellow, c_white));

if mouse_in_rectangle(85, 130, 545, 200) {
	set_cursor(cr_handpoint);
	if mouse_check_button_pressed(mb_left) {
		global.superpath = "saved/";
		room_restart();
	}
}

if mouse_in_rectangle(734, 130, 1320, 200) {
	set_cursor(cr_handpoint);
	if mouse_check_button_pressed(mb_left) {
		global.superpath = get_workshop_path();
		room_restart();
	}
}