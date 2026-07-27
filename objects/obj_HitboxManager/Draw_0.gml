set_cursor(cr_default);

if array_length(allhitboxes) == 0 {
	selected = -1; 
} else if selected == -1 {
	selected = 0;
}

var i = 0;
var _ypos;
for (i = 0; i < array_length(allhitboxes); i++) {
	var _hb = allhitboxes[i];
	initialize_struct_key(_hb, "HG_HITBOX_TYPE", 1);
	initialize_struct_key(_hb, "HG_PARENT_HITBOX", 0);
	_ypos = 74 + 74*i;
	var _col = multiplexer(i == selected, c_white, c_yellow);
	var _col2 = multiplexer(_hb.HG_HITBOX_TYPE - 1, c_red, c_lime);
	draw_sprite_ext(spr_UIbox, 0, 11, _ypos, 4.06, 1.14, 0, _col, 1);
	draw_sprite_ext(spr_hitboxes, 0, 15, _ypos + 4, 3.65, 3.65, 0, c_white, 1);
	draw_set_halign(fa_left);
	draw_text_ext_transformed(80, _ypos + 7, _hb.name, 999, 9999, 0.33, 0.33, 0);
	draw_text_ext_transformed_color(80, _ypos + 36, multiplexer(_col2 == c_red, "PROJECTILE", "PHYSICAL"), 999, 9999, 0.22, 0.22, 0, _col2, _col2, _col2, _col2, 1);
	draw_set_halign(fa_right);
	draw_text_ext_transformed_color(267, _ypos + 52, string("#{0}", i + 1), 999, 9999, 0.22, 0.22, 0, c_gray, c_gray, c_gray, c_gray, 1);
	
	if is_focused("hitboxes", -1, obj_EDITORattacks) and mouse_in_rectangle(11, _ypos, 11 + 64*4.06, _ypos + 64*1.14) {
		set_cursor(cr_handpoint);
		if mouse_check_button_pressed(mb_left) and is_focused("hitboxes", "", obj_EDITORattacks) {
			selected = i;
		}
	}
	
}
_ypos = 74 + 74*i;
draw_sprite_ext(spr_UIbox, 0, 11, _ypos, 4.06, 1.14, 0, c_white, 1);
draw_sprite_ext(spr_plus, 0, 141, _ypos + 36, 1, 1, 0, c_white, 1);
if is_focused("hitboxes", -1, obj_EDITORattacks) and mouse_in_rectangle(11, _ypos, 11 + 64*4.06, _ypos + 64*1.14) {
	set_cursor(cr_handpoint);
	if mouse_check_button_pressed(mb_left) and is_focused("hitboxes", "", obj_EDITORattacks) {
		newHitbox();
		selected = i;
	}
}


layer_set_visible(layer_get_id("HitboxesPage1"), false);
layer_set_visible(layer_get_id("HitboxesPage2"), false);
layer_set_visible(layer_get_id("HitboxesPage3"), false);
if selected != -1 {
	layer_text_text(get_ui_id("Hitboxes", "text_5528B478", false), allhitboxes[selected].name);
	layer_set_visible(layer_get_id("HitboxesPage" + string(page)), true);
	if is_focused("hitboxes", -1, obj_EDITORattacks) {
		manage_page(page, allhitboxes[selected]);
		rename_string_button("Hitboxes", "graphic_7849321F", "text_5528B478", allhitboxes[selected], "name", "hbname", obj_EDITORattacks, "hitboxes");
	}
	layer_sprite_alpha(get_ui_id("Hitboxes", "graphic_127BEF12", true), 1);
	layer_text_alpha(get_ui_id("Hitboxes", "text_5E03E9A7", false), 1);
	if is_focused("hitboxes", -1, obj_EDITORattacks) and mouse_in_uibox("Hitboxes", "graphic_127BEF12", cr_handpoint, true) {
		array_delete(allhitboxes, selected, 1);
		selected = multiplexer(array_length(allhitboxes) == 0, 0, -1);
	}
} else {
	layer_text_text(get_ui_id("Hitboxes", "text_5528B478", false), "NO HITBOX SELECTED");
	layer_sprite_alpha(get_ui_id("Hitboxes", "graphic_127BEF12", true), 0);
	layer_text_alpha(get_ui_id("Hitboxes", "text_5E03E9A7", false), 0);
}

if is_focused("hitboxes", -1, obj_EDITORattacks) and mouse_in_uibox("Hitboxes", "graphic_337A7BDD", cr_handpoint, true) {
	layer_set_visible(layer_get_id("Main"), true);
	layer_set_visible(layer_get_id("Hitboxes"), false);
	obj_EDITORattacks.focus = "nothing";
	obj_EDITORattacks.focus_secondary = "";
	layer_set_visible(layer_get_id("HitboxesPage1"), false);
	layer_set_visible(layer_get_id("HitboxesPage2"), false);
	layer_set_visible(layer_get_id("HitboxesPage3"), false);
	instance_deactivate_object(obj_HitboxManager);
}