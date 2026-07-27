global.tick++;

saveanim = min(1, saveanim + (1/60));

if room != START {
	if global.archive_modified and keyboard_check(vk_control) and keyboard_check_pressed(ord("S")) {
		ARCHIVE_SAVE();
		saveanim = 0;
	}
}