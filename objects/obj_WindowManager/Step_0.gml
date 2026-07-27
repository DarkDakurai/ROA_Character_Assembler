if !is_focused("winedit", -1, obj_EDITORattacks) {exit}

set_cursor(cr_default);

layer_text_text(get_ui_id("Window", "text_17F56960", false), selected.name);
layer_text_text(get_ui_id("Window", "text_6BA4075B", false), string("#{0}", selid + 1));
var _focused = is_focused("winedit", "", obj_EDITORattacks);
var _halfocused = is_focused("winedit", -1, obj_EDITORattacks);

// WINDOW TYPE
initialize_struct_key(selected, "AG_WINDOW_TYPE", 0);
correct_value_between(selected, "AG_WINDOW_TYPE", 0, 10);
text_button_color("Window", "text_2E6C393B", real(selected.AG_WINDOW_TYPE) == 0, c_white, c_aqua);
text_button_color("Window", "text_4C757BE4", real(selected.AG_WINDOW_TYPE) == 7, c_white, c_aqua);
text_button_color("Window", "text_42EE9B20", real(selected.AG_WINDOW_TYPE) == 8, c_white, c_aqua);
text_button_color("Window", "text_5231454E", real(selected.AG_WINDOW_TYPE) == 9, c_white, c_aqua);
text_button_color("Window", "text_1C2BE6B1", real(selected.AG_WINDOW_TYPE) == 10, c_white, c_aqua);
if _focused {
	button_change_var(selected, "AG_WINDOW_TYPE", 0, "Window", "graphic_51691211");
	button_change_var(selected, "AG_WINDOW_TYPE", 7, "Window", "graphic_661D0531");
	button_change_var(selected, "AG_WINDOW_TYPE", 8, "Window", "graphic_4D9115E6");
	button_change_var(selected, "AG_WINDOW_TYPE", 9, "Window", "graphic_3951D0B9");
	button_change_var(selected, "AG_WINDOW_TYPE", 10, "Window", "graphic_52F16883");
}

// WINDOW LENGTH ANIMFRAMES AND LENGTH
initialize_struct_key(selected, "AG_WINDOW_LENGTH", 1);
correct_value_between(selected, "AG_WINDOW_LENGTH", 1, infinity);
if _halfocused {
	rename_int_button("Window", "graphic_3F3A7AD8", "text_62F8D800", selected, "AG_WINDOW_ANIM_FRAMES", "winaniframes", obj_EDITORattacks, "winedit");
	rename_int_button("Window", "graphic_33298AB4", "text_6FA3D8AF", selected, "AG_WINDOW_LENGTH", "winlengrt", obj_EDITORattacks, "winedit");
}

// HORIZONTAL SPEED
initialize_struct_key(selected, "AG_WINDOW_HSPEED", 0);
initialize_struct_key(selected, "AG_WINDOW_HSPEED_TYPE", 0);
correct_value_between(selected, "AG_WINDOW_HSPEED_TYPE", 0, 2);
if _halfocused {
	rename_float_button("Window", "graphic_26A44177", "text_546AD14D", selected, "AG_WINDOW_HSPEED", "winhspeed", obj_EDITORattacks, "winedit");
}
text_button_color("Window", "text_57B2FE11", real(selected.AG_WINDOW_HSPEED_TYPE) == 0, c_white, c_aqua);
text_button_color("Window", "text_5478D8B1", real(selected.AG_WINDOW_HSPEED_TYPE) == 1, c_white, c_aqua);
text_button_color("Window", "text_1F509931", real(selected.AG_WINDOW_HSPEED_TYPE) == 2, c_white, c_aqua);
if _focused {
	button_change_var(selected, "AG_WINDOW_HSPEED_TYPE", 0, "Window", "graphic_6581699B");
	button_change_var(selected, "AG_WINDOW_HSPEED_TYPE", 1, "Window", "graphic_65B8C9A5");
	button_change_var(selected, "AG_WINDOW_HSPEED_TYPE", 2, "Window", "graphic_A971D1A");
}

// VERTICAL SPEED
initialize_struct_key(selected, "AG_WINDOW_VSPEED", 0);
initialize_struct_key(selected, "AG_WINDOW_VSPEED_TYPE", 0);
correct_value_between(selected, "AG_WINDOW_VSPEED_TYPE", 0, 2);
if _halfocused {
	rename_float_button("Window", "graphic_13CB1E7", "text_156B13B8", selected, "AG_WINDOW_VSPEED", "winvspeed", obj_EDITORattacks, "winedit");
}
text_button_color("Window", "text_504B3C33", real(selected.AG_WINDOW_VSPEED_TYPE) == 0, c_white, c_aqua);
text_button_color("Window", "text_1DCB6840", real(selected.AG_WINDOW_VSPEED_TYPE) == 1, c_white, c_aqua);
text_button_color("Window", "text_6556720B", real(selected.AG_WINDOW_VSPEED_TYPE) == 2, c_white, c_aqua);
if _focused {
	button_change_var(selected, "AG_WINDOW_VSPEED_TYPE", 0, "Window", "graphic_4986D349");
	button_change_var(selected, "AG_WINDOW_VSPEED_TYPE", 1, "Window", "graphic_12F8FE8F");
	button_change_var(selected, "AG_WINDOW_VSPEED_TYPE", 2, "Window", "graphic_61A789EE");
}

// C. FRICTION
initialize_struct_key(selected, "AG_WINDOW_HAS_CUSTOM_FRICTION", false);
correct_value_bool(selected, "AG_WINDOW_HAS_CUSTOM_FRICTION");
button_boolean("Window", "graphic_785516AF", "text_5F146F4B", selected, "AG_WINDOW_HAS_CUSTOM_FRICTION");

// AIR FRICTION
initialize_struct_key(selected, "AG_WINDOW_CUSTOM_AIR_FRICTION", 0);
if _halfocused {
	rename_float_button("Window", "graphic_4FCCCA7F", "text_3E33B10D", selected, "AG_WINDOW_CUSTOM_AIR_FRICTION", "winairfric", obj_EDITORattacks, "winedit");
}

// GROUND FRICTION
initialize_struct_key(selected, "AG_WINDOW_CUSTOM_GROUND_FRICTION", 0);
if _halfocused {
	rename_float_button("Window", "graphic_24174979", "text_413C55A2", selected, "AG_WINDOW_CUSTOM_GROUND_FRICTION", "wingroundfric", obj_EDITORattacks, "winedit");
}

// C GRAVITY
initialize_struct_key(selected, "AG_WINDOW_CUSTOM_GRAVITY", 0);
if _halfocused {
	rename_float_button("Window", "graphic_4FCCCA7F", "text_3E33B10D", selected, "AG_WINDOW_CUSTOM_GRAVITY", "winairfric", obj_EDITORattacks, "winedit");
}

// WHIFFLAG
initialize_struct_key(selected, "AG_WINDOW_HAS_WHIFFLAG", false);
correct_value_bool(selected, "AG_WINDOW_HAS_WHIFFLAG");
button_boolean("Window", "graphic_3BC28347", "text_60B07A7F", selected, "AG_WINDOW_HAS_WHIFFLAG");

// INVINCIBILITY
initialize_struct_key(selected, "AG_WINDOW_INVINCIBILITY", 0);
correct_value_between(selected, "AG_WINDOW_INVINCIBILITY", 0, 2);
text_button_color("Window", "text_2AA8C70", real(selected.AG_WINDOW_INVINCIBILITY) == 0, c_white, c_aqua);
text_button_color("Window", "text_4833A08B", real(selected.AG_WINDOW_INVINCIBILITY) == 1, c_white, c_aqua);
text_button_color("Window", "text_57A2E5D6", real(selected.AG_WINDOW_INVINCIBILITY) == 2, c_white, c_aqua);
if _focused {
	button_change_var(selected, "AG_WINDOW_INVINCIBILITY", 0, "Window", "graphic_428DF153");
	button_change_var(selected, "AG_WINDOW_INVINCIBILITY", 1, "Window", "graphic_2074BA24");
	button_change_var(selected, "AG_WINDOW_INVINCIBILITY", 2, "Window", "graphic_7214CBDB");
}

// HITP FRAME
initialize_struct_key(selected, "AG_WINDOW_HITPAUSE_FRAME", 0);
correct_value_between(selected, "AG_WINDOW_HITPAUSE_FRAME", 0, infinity);
if _halfocused {
	rename_int_button("Window", "graphic_3D0ACD6E", "text_61DDC95F", selected, "AG_WINDOW_HITPAUSE_FRAME", "hitpauseframe", obj_EDITORattacks, "winedit");
}

// MOVE CANCEL
initialize_struct_key(selected, "AG_WINDOW_CANCEL_TYPE", 0);
correct_value_between(selected, "AG_WINDOW_CANCEL_TYPE", 0, 2);
text_button_color("Window", "text_168AD13B", real(selected.AG_WINDOW_CANCEL_TYPE) == 0, c_white, c_aqua);
text_button_color("Window", "text_7D897D8A", real(selected.AG_WINDOW_CANCEL_TYPE) == 1, c_white, c_aqua);
text_button_color("Window", "text_610CAD0B", real(selected.AG_WINDOW_CANCEL_TYPE) == 2, c_white, c_aqua);
if _focused {
	button_change_var(selected, "AG_WINDOW_CANCEL_TYPE", 0, "Window", "graphic_23306C5F");
	button_change_var(selected, "AG_WINDOW_CANCEL_TYPE", 1, "Window", "graphic_1714115F");
	button_change_var(selected, "AG_WINDOW_CANCEL_TYPE", 2, "Window", "graphic_65BDEB82");
}
initialize_struct_key(selected, "AG_WINDOW_CANCEL_FRAME", 0);
correct_value_between(selected, "AG_WINDOW_CANCEL_FRAME", 0, infinity);
if _halfocused {
	rename_int_button("Window", "graphic_297404B4", "text_41FA1B6B", selected, "AG_WINDOW_CANCEL_FRAME", "movecancelframe", obj_EDITORattacks, "winedit");
}

// SOUND EFFECT
initialize_struct_key(selected, "AG_WINDOW_HAS_SFX", false);
correct_value_bool(selected, "AG_WINDOW_HAS_SFX");
button_boolean("Window", "graphic_16197EF", "text_BAEECAD", selected, "AG_WINDOW_HAS_SFX");
initialize_struct_key(selected, "AG_WINDOW_SFX_FRAME", 0);
correct_value_between(selected, "AG_WINDOW_SFX_FRAME", 0, infinity);
if _halfocused {
	rename_int_button("Window", "graphic_2AE55586", "text_13578E32", selected, "AG_WINDOW_SFX_FRAME", "sfxframe", obj_EDITORattacks, "winedit");
}
initialize_struct_key(selected, "AG_WINDOW_SFX", string("asset_get(\"punch_sfx\")"));
if mouse_in_uibox("Window", "graphic_4B0AC892", cr_handpoint, true) {
	initialize_sound_selector(false, "", "SndSoundEff", obj_EDITORattacks);
}
layer_text_text(get_ui_id("Window", "text_70B05D7", false), get_quoted_text(selected.AG_WINDOW_SFX));

// WIN NAME
if _halfocused {
	rename_string_button("Window", "graphic_73AE85C6", "text_17F56960", selected, "name", "winname", obj_EDITORattacks, "winedit");
}

//RETURN
if mouse_in_uibox("Window", "graphic_4FA73DF3", cr_handpoint, true) {
	obj_EDITORattacks.focus = "windows";
	obj_EDITORattacks.focus_secondary = "";
	layer_set_visible(layer_get_id("Window"), false);
}