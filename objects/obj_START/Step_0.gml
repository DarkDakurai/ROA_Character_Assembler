set_cursor(cr_default);
layer_text_blend(layer_text_get_id("Assets_1", "saved_folder"), multiplexer(global.selected_dest, c_yellow, c_white));
layer_text_blend(layer_text_get_id("Assets_1", "workshop_folder"), multiplexer(1 - global.selected_dest, c_yellow, c_white));

if mouse_in_uibox("Assets_2", "graphic_40701980", cr_handpoint, true) { // SAVED FOLDER button
	global.superpath = "saved/";
	room_restart();
}

if mouse_in_uibox("Assets_2", "graphic_75E67147", cr_handpoint, true) { // WORKSHOP FOLDER button
	global.superpath = get_workshop_path();
	room_restart();
}