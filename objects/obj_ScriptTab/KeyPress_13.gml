if main_obj.tab != id exit;
direction_buffer[4] = cursor_hold_pause;
var _am = array_length(cursors);
var _g = 0;
repeat _am{
	var c = cursors[_g];
	var _str = data[c.line];
	var _len = string_length(_str);
	var nlstring = string_delete(_str, 0, c.pos);
	data[@c.line] = string_delete(_str, c.pos+1, _len-c.pos+1);
	array_insert(data, c.line+1, nlstring);
	c.line++;
	c.pos = 0;
	c.qolpos = 0;
	_g++;
}
trigger_modifications(filestruct, self);