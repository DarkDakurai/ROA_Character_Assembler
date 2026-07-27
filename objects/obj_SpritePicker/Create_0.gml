default_value = undefined;
allow_empty = undefined;
firstframe = true;
scroll_y = 0;
function trigger() {
	atarray = [];
	firstframe = true;
	scroll_y = 0;
    var _path = string("{0}/sprites/", global.selected_path);
	atarray = array_filter(get_all_files(_path), function(_v, _i) {
		return !string_starts_with(_v, "_");
	})
	
	array_foreach(atarray, function(_v, _i) {
		if string_pos("_strip", _v) != 0 {
			atarray[_i] = string_copy(_v, 1, string_pos("_strip", _v) - 1);
		}
	});
}

function click_event(_selected) {
	if _selected == undefined {
		obj_EDITORattacks.selection_return = default_value;
	} else {
		obj_EDITORattacks.selection_return = _selected;
	}
	obj_EDITORattacks.selection_end("sprite");
	obj_EDITORattacks.focus_secondary = "";
	layer_set_visible(layer_get_id("SelectSprite"), false);
	layer_set_visible(layer_get_id("Exploit"), false);
	default_value = undefined;
	allow_empty = undefined;
	firstframe = true;
	scroll_y = 0;
	instance_deactivate_object(obj_SpritePicker);
}