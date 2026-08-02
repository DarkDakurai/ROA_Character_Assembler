if main_obj.tab != id exit;
direction_buffer[6] = cursor_hold_pause;

if keyboard_check(vk_shift) cursor_remove_tabs(cursors, data);
else cursor_write_tabs(cursors, data);
cursor_reset_qolpos(cursors)
cursor_check(cursors, data, self);