ui();
if !sprite_exists(sprite) {exit;}
var _mid_x = room_width / 2;
var _mid_y = multiplexer(real(hitb.HG_HITBOX_TYPE) == 1, room_height / 2, room_height / 1.3);

draw_line_colour(_mid_x, 0, _mid_x, room_height, c_gray, c_gray);
draw_line_colour(0, _mid_y, room_width, _mid_y, c_gray, c_gray);

var _frame = abs(frame) mod sprite_get_number(sprite);
zoom = clamp(zoom, 1, 5);
var _zoom = zoom;

draw_sprite_ext(sprite, _frame, _mid_x - (origin[0] * _zoom), _mid_y - (origin[1] * _zoom), _zoom, _zoom, 0, c_white, 1);

var _xpos = _mid_x + (real(hitb.HG_HITBOX_X) * _zoom);
var _ypos = _mid_y + (real(hitb.HG_HITBOX_Y) * _zoom);
var _wid = (real(hitb.HG_WIDTH) * (1/200)) * _zoom;
var _hei = (real(hitb.HG_HEIGHT) * (1/200)) * _zoom;
var _spr = multiplexer(real(hitb.HG_SHAPE), spr_hitbox_circle, spr_hitbox_square, spr_hitbox_rounded);
draw_sprite_ext(_spr, 0, _xpos,  _ypos, _wid, _hei, 0, c_red, 0.5);

draw_sprite_ext(spr_arrow_nice, 0, _xpos, _ypos, _zoom, _zoom, real(hitb.HG_ANGLE), c_white, 0.5);


if !mouse_check_button(mb_left) {
	stop_dragging();
}


var _hit_top_left = [floor(_xpos - (real(hitb.HG_WIDTH) * _zoom)/2), floor(_ypos - (real(hitb.HG_HEIGHT) * _zoom)/2)];
var _hit_top_right = [floor(_xpos + (real(hitb.HG_WIDTH) * _zoom)/2), floor(_ypos - (real(hitb.HG_HEIGHT) * _zoom)/2)];
var _hit_mid_left = [floor(_xpos - (real(hitb.HG_WIDTH) * _zoom)/2), floor(_ypos)];
var _hit_mid_right = [floor(_xpos + (real(hitb.HG_WIDTH) * _zoom)/2), floor(_ypos)];
var _hit_bottom_left = [floor(_xpos - (real(hitb.HG_WIDTH) * _zoom)/2), floor(_ypos + (real(hitb.HG_HEIGHT) * _zoom)/2)];
var _hit_bottom_right = [floor(_xpos + (real(hitb.HG_WIDTH) * _zoom)/2), floor(_ypos + (real(hitb.HG_HEIGHT) * _zoom)/2)];
var _hit_top_mid = [floor(_xpos), floor(_ypos - (real(hitb.HG_HEIGHT) * _zoom)/2)];
var _hit_bottom_mid = [floor(_xpos), floor(_ypos + (real(hitb.HG_HEIGHT) * _zoom)/2)];

set_cursor(cr_default)

if not_dragging() and mouse_in_rectangle(_hit_top_left[0] - (4 * _zoom), _hit_top_left[1] - (4 * _zoom), _hit_top_left[0] + (4 * _zoom), _hit_top_left[1] + (4 * _zoom), keyboard_check(vk_shift)) {
	if global.cursor == cr_default {set_cursor(cr_size_nwse)}
	if mouse_check_button_pressed(mb_left) {
		set_dragging("resize_top_left");
		click_offset_x = floor((_hit_top_left[0] - mouse_x) / _zoom);
		click_offset_y = floor((_hit_top_left[1] - mouse_y) / _zoom);
		drag_anchor_x = real(hitb.HG_HITBOX_X) + (real(hitb.HG_WIDTH) / 2);
		drag_anchor_y = real(hitb.HG_HITBOX_Y) + (real(hitb.HG_HEIGHT) / 2);
	}
}

if not_dragging() and mouse_in_rectangle(_hit_top_right[0] - (4 * _zoom), _hit_top_right[1] - (4 * _zoom), _hit_top_right[0] + (4 * _zoom), _hit_top_right[1] + (4 * _zoom), keyboard_check(vk_shift)) {
	if global.cursor == cr_default {set_cursor(cr_size_nesw)}
	if mouse_check_button_pressed(mb_left) {
		set_dragging("resize_top_right");
		click_offset_x = floor((_hit_top_right[0] - mouse_x) / _zoom);
		click_offset_y = floor((_hit_top_right[1] - mouse_y) / _zoom);
		drag_anchor_x = real(hitb.HG_HITBOX_X) - (real(hitb.HG_WIDTH) / 2);
		drag_anchor_y = real(hitb.HG_HITBOX_Y) + (real(hitb.HG_HEIGHT) / 2);
	}
}

if not_dragging() and mouse_in_rectangle(_hit_bottom_left[0] - (4 * _zoom), _hit_bottom_left[1] - (4 * _zoom), _hit_bottom_left[0] + (4 * _zoom), _hit_bottom_left[1] + (4 * _zoom), keyboard_check(vk_shift)) {
	if global.cursor == cr_default {set_cursor(cr_size_nesw)}
	if mouse_check_button_pressed(mb_left) {
		set_dragging("resize_bottom_left");
		click_offset_x = floor((_hit_bottom_left[0] - mouse_x) / _zoom);
		click_offset_y = floor((_hit_bottom_left[1] - mouse_y) / _zoom);
		drag_anchor_x = real(hitb.HG_HITBOX_X) + (real(hitb.HG_WIDTH) / 2);
		drag_anchor_y = real(hitb.HG_HITBOX_Y) - (real(hitb.HG_HEIGHT) / 2);
	}
}

if not_dragging() and mouse_in_rectangle(_hit_bottom_right[0] - (4 * _zoom), _hit_bottom_right[1] - (4 * _zoom), _hit_bottom_right[0] + (4 * _zoom), _hit_bottom_right[1] + (4 * _zoom), keyboard_check(vk_shift)) {
	if global.cursor == cr_default {set_cursor(cr_size_nwse)}
	if mouse_check_button_pressed(mb_left) {
		set_dragging("resize_bottom_right");
		click_offset_x = floor((_hit_bottom_right[0] - mouse_x) / _zoom);
		click_offset_y = floor((_hit_bottom_right[1] - mouse_y) / _zoom);
		drag_anchor_x = real(hitb.HG_HITBOX_X) - (real(hitb.HG_WIDTH) / 2);
		drag_anchor_y = real(hitb.HG_HITBOX_Y) - (real(hitb.HG_HEIGHT) / 2);
	}
}


if not_dragging() and mouse_in_rectangle(_hit_top_mid[0] - (4 * _zoom), _hit_top_mid[1] - (4 * _zoom), _hit_top_mid[0] + (4 * _zoom), _hit_top_mid[1] + (4 * _zoom), keyboard_check(vk_shift)) {
	if global.cursor == cr_default {set_cursor(cr_size_ns)}
	if mouse_check_button_pressed(mb_left) {
		set_dragging("resize_top_mid");
		click_offset_y = floor((_hit_top_mid[1] - mouse_y) / _zoom);
		drag_anchor_y = real(hitb.HG_HITBOX_Y) + (real(hitb.HG_HEIGHT) / 2);
	}
}

if not_dragging() and mouse_in_rectangle(_hit_bottom_mid[0] - (4 * _zoom), _hit_bottom_mid[1] - (4 * _zoom), _hit_bottom_mid[0] + (4 * _zoom), _hit_bottom_mid[1] + (4 * _zoom), keyboard_check(vk_shift)) {
	if global.cursor == cr_default {set_cursor(cr_size_ns)}
	if mouse_check_button_pressed(mb_left) {
		set_dragging("resize_bottom_mid");
		click_offset_y = floor((_hit_bottom_mid[1] - mouse_y) / _zoom);
		drag_anchor_y = real(hitb.HG_HITBOX_Y) - (real(hitb.HG_HEIGHT) / 2);
	}
}

if not_dragging() and mouse_in_rectangle(_hit_mid_left[0] - (4 * _zoom), _hit_mid_left[1] - (4 * _zoom), _hit_mid_left[0] + (4 * _zoom), _hit_mid_left[1] + (4 * _zoom), keyboard_check(vk_shift)) {
	if global.cursor == cr_default {set_cursor(cr_size_we)}
	if mouse_check_button_pressed(mb_left) {
		set_dragging("resize_mid_left");
		click_offset_x = floor((_hit_mid_left[0] - mouse_x) / _zoom);
		drag_anchor_x = real(hitb.HG_HITBOX_X) + (real(hitb.HG_WIDTH) / 2);
	}
}

if not_dragging() and mouse_in_rectangle(_hit_mid_right[0] - (4 * _zoom), _hit_mid_right[1] - (4 * _zoom), _hit_mid_right[0] + (4 * _zoom), _hit_mid_right[1] + (4 * _zoom), keyboard_check(vk_shift)) {
	if global.cursor == cr_default {set_cursor(cr_size_we)}
	if mouse_check_button_pressed(mb_left) {
		set_dragging("resize_mid_right");
		click_offset_x = floor((_hit_mid_right[0] - mouse_x) / _zoom);
		drag_anchor_x = real(hitb.HG_HITBOX_X) - (real(hitb.HG_WIDTH) / 2);
	}
}

var _arrow_x = _xpos + lengthdir_x(36 * _zoom, real(hitb.HG_ANGLE));
var _arrow_y = _ypos + lengthdir_y(36 * _zoom, real(hitb.HG_ANGLE));
if not_dragging() and mouse_in_rectangle(_arrow_x - (4 * _zoom), _arrow_y - (4 * _zoom), _arrow_x + (4 * _zoom), _arrow_y + (4 * _zoom), keyboard_check(vk_shift)) {
	if global.cursor == cr_default {set_cursor(cr_handpoint)}
	if mouse_check_button_pressed(mb_left) {
		set_dragging("move_arrow");
	}
}

if not_dragging() and mouse_in_rectangle(_hit_top_left[0], _hit_top_left[1], _hit_bottom_right[0], _hit_bottom_right[1], keyboard_check(vk_shift)) {
	if global.cursor == cr_default {set_cursor(cr_size_all)}
	if mouse_check_button_pressed(mb_left) {
		set_dragging("move_hitbox");
		click_offset_x = floor((_xpos - mouse_x) / _zoom);
		click_offset_y = floor((_ypos - mouse_y) / _zoom);
	}
}




var _mouse_x = floor((mouse_x - _mid_x) / _zoom);
var _mouse_y = floor((mouse_y - _mid_y) / _zoom);
if is_dragging("move_hitbox") {
	set_cursor(cr_size_all);
	hitb.HG_HITBOX_X = _mouse_x + click_offset_x;
	hitb.HG_HITBOX_Y = _mouse_y + click_offset_y;
}

if is_dragging("resize_top_left") {
	set_cursor(cr_size_nwse);
	var _new_width = max(2, drag_anchor_x - (_mouse_x + click_offset_x));
	var _new_height = max(2, drag_anchor_y - (_mouse_y + click_offset_y));
	hitb.HG_WIDTH = _new_width;
	hitb.HG_HEIGHT = _new_height;
	hitb.HG_HITBOX_X = drag_anchor_x - (_new_width / 2);
	hitb.HG_HITBOX_Y = drag_anchor_y - (_new_height / 2);
}

if is_dragging("resize_top_right") {
	set_cursor(cr_size_nesw);
	var _new_width = max(2, (_mouse_x + click_offset_x) - drag_anchor_x);
	var _new_height = max(2, drag_anchor_y - (_mouse_y + click_offset_y));
	hitb.HG_WIDTH = _new_width;
	hitb.HG_HEIGHT = _new_height;
	hitb.HG_HITBOX_X = drag_anchor_x + (_new_width / 2);
	hitb.HG_HITBOX_Y = drag_anchor_y - (_new_height / 2);
}

if is_dragging("resize_bottom_left") {
	set_cursor(cr_size_nesw);
	var _new_width = max(2, drag_anchor_x - (_mouse_x + click_offset_x));
	var _new_height = max(2, (_mouse_y + click_offset_y) - drag_anchor_y);
	hitb.HG_WIDTH = _new_width;
	hitb.HG_HEIGHT = _new_height;
	hitb.HG_HITBOX_X = drag_anchor_x - (_new_width / 2);
	hitb.HG_HITBOX_Y = drag_anchor_y + (_new_height / 2);
}

if is_dragging("resize_bottom_right") {
	set_cursor(cr_size_nwse);
	var _new_width = max(2, (_mouse_x + click_offset_x) - drag_anchor_x);
	var _new_height = max(2, (_mouse_y + click_offset_y) - drag_anchor_y);
	hitb.HG_WIDTH = _new_width;
	hitb.HG_HEIGHT = _new_height;
	hitb.HG_HITBOX_X = drag_anchor_x + (_new_width / 2);
	hitb.HG_HITBOX_Y = drag_anchor_y + (_new_height / 2);
}

if is_dragging("resize_top_mid") {
	set_cursor(cr_size_ns);
	var _new_height = max(2, drag_anchor_y - (_mouse_y + click_offset_y));
	hitb.HG_HEIGHT = _new_height;
	hitb.HG_HITBOX_Y = drag_anchor_y - (_new_height / 2);
}

if is_dragging("resize_bottom_mid") {
	set_cursor(cr_size_ns);
	var _new_height = max(2, (_mouse_y + click_offset_y) - drag_anchor_y);
	hitb.HG_HEIGHT = _new_height;
	hitb.HG_HITBOX_Y = drag_anchor_y + (_new_height / 2);
}

if is_dragging("resize_mid_left") {
	set_cursor(cr_size_we);
	var _new_width = max(2, drag_anchor_x - (_mouse_x + click_offset_x));
	hitb.HG_WIDTH = _new_width;
	hitb.HG_HITBOX_X = drag_anchor_x - (_new_width / 2);
}

if is_dragging("resize_mid_right") {
	set_cursor(cr_size_we);
	var _new_width = max(2, (_mouse_x + click_offset_x) - drag_anchor_x);
	hitb.HG_WIDTH = _new_width;
	hitb.HG_HITBOX_X = drag_anchor_x + (_new_width / 2);
}

if is_dragging("move_arrow") {
	set_cursor(cr_cross);
	hitb.HG_ANGLE = floor(point_direction(_xpos, _ypos, mouse_x, mouse_y));
}