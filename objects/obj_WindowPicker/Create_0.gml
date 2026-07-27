default_value = undefined;
allow_empty = undefined;
firstframe = true;
scroll_y = 0;
function trigger() {
	atarray = [];
	firstframe = true;
	scroll_y = 0;
    atarray = obj_EDITORattacks.MEGARAM[$ obj_EDITORattacks.selected_attack].windows;
}

function click_event(_selected) {
	if _selected == undefined {
		obj_EDITORattacks.selection_return = default_value;
	} else {
		obj_EDITORattacks.selection_return = _selected;
	}
	obj_EDITORattacks.selection_end("window");
	obj_EDITORattacks.focus_secondary = "";
	layer_set_visible(layer_get_id("SelectWindow"), false);
	layer_set_visible(layer_get_id("Exploit"), false);
	default_value = undefined;
	allow_empty = undefined;
	firstframe = true;
	scroll_y = 0;
	instance_deactivate_object(obj_WindowPicker);
}