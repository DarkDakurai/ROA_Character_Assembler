layer_text_blend(layer_text_get_id("Assets_1", "BackArrow1_3_1"), c_white);
layer_text_blend(layer_text_get_id("Assets_1", "CloseButton1_3_1"), c_white);


if mouse_in_rectangle(1305, 0, 1365, 60) {
	layer_text_blend(layer_text_get_id("Assets_1", "CloseButton1_3_1"), c_red);
	if mouse_check_button_pressed(mb_left) and show_question("Are you sure you want to quit? \nAll unsaved changes will be lost!") {game_end()}
}

if mouse_in_rectangle(0, 0, 90, 60) {
	layer_text_blend(layer_text_get_id("Assets_1", "BackArrow1_3_1"), c_yellow);
	if mouse_check_button_pressed(mb_left) and show_question("Are you sure you want to return to main menu? \nAll unsaved changes will be lost!") {room_goto(CharEdit_Main)}
}