set_cursor(cr_default);

if mouse_in_rectangle(0, 0, 90, 60) {
	set_cursor(cr_handpoint);
}

if is_focused("nothing") {
	draw_attack_list();
	add_attack_click();
	tick_right_side();
}
tick_information();