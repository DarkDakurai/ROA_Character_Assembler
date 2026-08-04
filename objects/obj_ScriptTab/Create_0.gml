name = "";
filepath = "";
filestruct = noone;
attack = false;
data = 0;
edited = 0;
textview = [0, 0];
textscroll_speed = [0, 0];
parsetabs = 1;
txtwidt = 0;

last_cursor = noone;
cursors = [];
showcursors = 0;
cursor_hold_pause = 20;
cursor_hold_delay = 1;

direction_buffer = array_create(7, 5);

main_obj = noone;

/*
cursor = {
	line: int,
	pos: int,
	qolpos: int,
	selection: int
}
*/

text_surf = surface_create(1052, 703)

changes_buffer = [];
cursors_buffer = [];
changes_buffer_max = 256;
undos = 0;
ctrl_cd_max = 20;
ctrl_cooldown = array_create(10, ctrl_cd_max);

//syntax highlight
highlight_parse = 0;