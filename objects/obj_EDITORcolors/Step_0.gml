set_cursor(cr_default);

layer_text_blend(layer_text_get_id("Assets_1", "BackArrow1"), c_white);
layer_text_blend(layer_text_get_id("Assets_1", "CloseButton1"), c_white);
layer_text_blend(layer_text_get_id("Assets_1", "CopyClipboard"), c_white);
layer_text_blend(layer_text_get_id("Assets_1", "ImportClipboard"), c_white);
tick_dragging_layer("Overlay");

if mouse_in_rectangle(1305, 0, 1365, 60) {
	layer_text_blend(layer_text_get_id("Assets_1", "CloseButton1"), c_red);
	if mouse_check_button_pressed(mb_left) {game_end()}
}

if mouse_in_rectangle(0, 0, 90, 60) {
	layer_text_blend(layer_text_get_id("Assets_1", "BackArrow1"), c_yellow);
	if mouse_check_button_pressed(mb_left) {room_goto(CharEdit_Main)}
	set_cursor(cr_handpoint);
}

if mouse_in_rectangle(27, 158, 727, 204) {
	if mouse_check_button_pressed(mb_left) {url_open("https://cl-9a.github.io/RoAColorsGmlHelper/")}
	set_cursor(cr_handpoint);
}

if mouse_in_rectangle(139, 512, 139 + 448, 512 + 192) {
	if mouse_check_button_pressed(mb_left) {copy_palettes_to_clipboard(string("{0}/scripts/colors.gml", global.selected_path))}
	layer_text_blend(layer_text_get_id("Assets_1", "CopyClipboard"), c_aqua);
	set_cursor(cr_handpoint);
}

if mouse_in_rectangle(768, 512, 768 + 448, 512 + 192) {
	if mouse_check_button_pressed(mb_left) {import_palettes_from_clipboard(string("{0}/scripts/colors.gml", global.selected_path))}
	layer_text_blend(layer_text_get_id("Assets_1", "ImportClipboard"), c_lime);
	set_cursor(cr_handpoint);
}