default_value = undefined;
allow_empty = undefined;
firstframe = true;
scroll_y = 0;
function trigger() {
	atarray = [];
	firstframe = true;
	scroll_y = 0;
	for (var i = 0; i < array_length(global.allmoves); i++) {
		if !variable_struct_exists(obj_EDITORattacks.MEGARAM, global.allmoves[i]) {
			array_push(atarray, global.allmoves[i]);
		}
	}
}

function click_event(_selected) {
	if _selected == undefined {
		obj_EDITORattacks.selection_return = default_value;
	} else {
		obj_EDITORattacks.selection_return = _selected;
	}
	obj_EDITORattacks.selection_end("attack");
	obj_EDITORattacks.focus_secondary = "";
	layer_set_visible(layer_get_id("SelectAttack"), false);
	layer_set_visible(layer_get_id("Exploit"), false);
	default_value = undefined;
	allow_empty = undefined;
	firstframe = true;
	scroll_y = 0;
	instance_deactivate_object(obj_AttackPicker);
}