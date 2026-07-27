if room != START {
	draw_sprite_ext(spr_save, multiplexer(global.archive_modified, 0, round(global.tick / 8) mod 2), 117, 33, 3, 3, 360 * animcurve_evaluate(UIAnim, "save", saveanim), c_white, multiplexer(global.archive_modified, 0.5, 1));
	if global.archive_modified and mouse_in_rectangle(117 - 24, 33 - 24, 117 + 24, 33 + 24) and mouse_check_button_pressed(mb_left) {
		ARCHIVE_SAVE();
		saveanim = 0;
	}
}