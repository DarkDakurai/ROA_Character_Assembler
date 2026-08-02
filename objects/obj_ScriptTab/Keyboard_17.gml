/*ctrl c
ctrl v
ctrl x
ctrl f*/

var _num = 0;
if keyboard_check(ord("Z")){
	ctrl_cooldown[_num]--;
	if ctrl_cooldown[_num] == ctrl_cd_max-1 || !ctrl_cooldown[_num]{
		var _idx = array_length(changes_buffer)-2-undos;
		if _idx < 0 return;
		data = array_clone(changes_buffer[_idx])
		cursors = array_clone(cursors_buffer[_idx])
		trigger_modifications_nobuf(filestruct);
		undos++;
		ctrl_cooldown[_num] = max(ctrl_cooldown[_num], 2);
	}
}else ctrl_cooldown[_num] = ctrl_cd_max;

_num++;
if keyboard_check(ord("Y")){
	ctrl_cooldown[_num]--;
	if ctrl_cooldown[_num] == ctrl_cd_max-1 || !ctrl_cooldown[_num]{
		if !undos return;
		cursors = array_clone(cursors_buffer[array_length(changes_buffer)-undos])
		data = array_clone(changes_buffer[array_length(changes_buffer)-undos])
		trigger_modifications_nobuf(filestruct);
		undos--;
		ctrl_cooldown[_num] = max(ctrl_cooldown[_num], 2);
	}
}else ctrl_cooldown[_num] = ctrl_cd_max;

_num++;
if keyboard_check(ord("A")){
	ctrl_cooldown[_num]--;
	if ctrl_cooldown[_num] == ctrl_cd_max-1 || !ctrl_cooldown[_num]{
		var _ln = array_length(data)-1;
		var _ps = string_length(data[array_length(data)-1]);
		cursors = [{line: _ln, pos: _ps, qolpos: _ps, selection: [0, 0]}];
		ctrl_cooldown[_num] = max(ctrl_cooldown[_num], 2);
		cursor_check(cursors, data, self);
	}
}else ctrl_cooldown[_num] = ctrl_cd_max;

_num++;
if keyboard_check(vk_backspace){
	ctrl_cooldown[_num]--;
	if ctrl_cooldown[_num] == ctrl_cd_max-1 || !ctrl_cooldown[_num]{
		cursor_delete_char_cont(cursors, data, false);
		ctrl_cooldown[_num] = max(ctrl_cooldown[_num], 2);
	}
}else ctrl_cooldown[_num] = ctrl_cd_max;


_num++;
if keyboard_check(vk_delete){
	ctrl_cooldown[_num]--;
	if ctrl_cooldown[_num] == ctrl_cd_max-1 || !ctrl_cooldown[_num]{
		cursor_delete_char_cont(cursors, data, true);
		ctrl_cooldown[_num] = max(ctrl_cooldown[_num], 2);
	}
}else ctrl_cooldown[_num] = ctrl_cd_max;

_num++;
if keyboard_check(ord("A")){
	ctrl_cooldown[_num]--;
	if ctrl_cooldown[_num] == ctrl_cd_max-1 || !ctrl_cooldown[_num]{
		
		ctrl_cooldown[_num] = max(ctrl_cooldown[_num], 2);
	}
}else ctrl_cooldown[_num] = ctrl_cd_max;