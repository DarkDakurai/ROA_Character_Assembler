var _oal = draw_get_halign();
draw_set_font(fnt_maplemono_SDF);
draw_set_halign(fa_left);
surface_set_target(surf_scripts);
draw_clear_alpha(c_black, 0);
var px = scriptview[0]
var py = scriptview[1]
if select_id == 0{
	draw_rectangle_colour(px, py, px + string_width("|  attacks/"), py+20, c_white, c_white, c_white, c_white, 0)
	draw_text_colour(px, py, "|  attacks/", 0, 0, 0, 0, 1);
}else draw_text(px, py, "|  attacks/");
draw_sprite_ext(spr_directory, expanded_attacks, px + 10, py + 2, 1, 1, 0, (select_id == 0? 0: c_white), 1);
var _j = 1;
if expanded_attacks{
	var _i = 0;
	repeat array_length(attack_pickers){
		if select_id == _j{
			draw_rectangle_colour(px, py + 20*_j, px + string_width(attack_pickers[_i].full_string), py+20 + 20*_j, c_white, c_white, c_white, c_white, 0)
			draw_text_colour(px, py + 20*_j, attack_pickers[_i].full_string, 0, 0, 0, 0, 1);
		}else draw_text(px, py + 20*_j, attack_pickers[_i].full_string)
		draw_sprite_ext(spr_directory, 2, px + 15, py + 20*_j + 2, 1, 1, 0, (select_id == _j? 0: c_white), 1);
		_i++;
		_j++;
	}
}
var _i = 0;
repeat array_length(script_pickers){
	if select_id == _j{
		draw_rectangle_colour(px, py + 20*_j, px + string_width(script_pickers[_i].full_string), py+20 + 20*_j, c_white, c_white, c_white, c_white, 0)
		draw_text_colour(px, py + 20*_j, script_pickers[_i].full_string, 0, 0, 0, 0, 1);
	}else draw_text(px, py + 20*_j, script_pickers[_i].full_string)
	draw_sprite_ext(spr_directory, 2, px + 10, py + 20*_j + 2, 1, 1, 0, (select_id == _j? 0: c_white), 1);
	_i++;
	_j++;
}
surface_reset_target();
draw_surface(surf_scripts, 10, 70);

//draw tabs
surface_set_target(surf_tabs);
draw_clear_alpha(c_black, 0);
px = tab_view
_i = 0;
repeat array_length(tabs){
	var tabb = tabs[_i];
	if tab == tabb{
		draw_text_colour(px + 150*_i + 15, 30, string_delete(tabb.name, 12, 100), 0, 0, 0, 0, 1)
	}else draw_text(px + 150*_i + 15, 30, string_delete(tabb.name, 12, 100))
	_i++;
}
surface_reset_target();
draw_surface(surf_tabs, 314, 0);

draw_set_font(fnt_jersey20_SDF);
draw_set_halign(_oal);
