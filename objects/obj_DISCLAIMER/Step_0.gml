// this will be always remembered as obj_pingas
if mouse_in_uibox("Assets_1", "graphic_6AB95216", cr_default, true) {
	url_open("https://github.com/dvdX4767/ROA_Character_Assembler/issues");
}

if keyboard_check(vk_anykey) or mouse_check_button(mb_any) {
	room_goto(START);
}