if main_obj.tab != id exit;
if direction_buffer[6]{
	direction_buffer[@6]--;
	exit;
}else direction_buffer[@6] = cursor_hold_delay;

if keyboard_check(vk_shift) cursor_remove_tabs(cursors, data);
else cursor_write_tabs(cursors, data);
cursor_reset_qolpos(cursors)
cursor_check(cursors, data, self);