selected = clamp(selected, 0, sprite_get_number(sprite) - 1);

if is_focused("windows", -1, obj_EDITORattacks) {
	draw_sprite_preview();
	draw_windows();
	handle_buttons();
}