var _id = ds_map_find_value(async_load, "id");
	
if (_id == my_popup_id) { // i hate ds maps
	freeze = false;
	if (ds_map_find_value(async_load, "status")) {
		var _result = ds_map_find_value(async_load, "result");
		if is_valid_filename(_result) {
			if is_workshop_name_taken(_result) {
				if show_question("A character folder with that name already exists, do you want to overwrite it?") {
					export(_result);
				}
			} else {
				export(_result);
			}
		} else {
			show_message("Invalid folder name! Try not to include any spaces nor any of the following characters: <>:\"/\\|?*.");
		}
	}
}