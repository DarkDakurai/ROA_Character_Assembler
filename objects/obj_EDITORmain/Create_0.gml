focus = "nothing";
freeze = false;

global.config_data = archive_fetch_file(AP.MAIN, get_full_path("config.ini"));	
if global.config_data == undefined {
	show_message(string("Missing config.ini: \nDue to this error, you will be taken to the starting menu.\nTIP: If config.ini is missing, try copying it from another character's directory"));
	room_goto(START);
	exit;
}

var _spr = archive_fetch_file(AP.MAIN, get_full_path("portrait.png"));
if _spr == undefined {
	if !archive_create(AP.MAIN, get_full_path("portrait.png"), FT.SPRITE) {
		show_message("Failed to find portrait AND failed to create protrait sprite");
		room_goto(START);
		exit;
	}
	_spr = archive_fetch_file(AP.MAIN, get_full_path("portrait.png"))
}

layer_sprite_change(layer_sprite_get_id("Assets_1", "graphic_156F9130"), _spr);

layer_text_text(layer_text_get_id("Assets_2", "CharName"), global.config_data.name);
layer_text_text(layer_text_get_id("Assets_2", "CharAuthor"), string("BY {0}", global.config_data.author));
layer_text_text(layer_text_get_id("Assets_2", "CharVersion"), string("v{0}.{1}", global.config_data[$ "major_version"], global.config_data[$ "minor_version"]));
layer_text_text(layer_text_get_id("Assets_2", "CharDesc"), global.config_data.description);
layer_text_text(layer_text_get_id("Assets_2", "CharInfo1"), global.config_data.info1);
layer_text_text(layer_text_get_id("Assets_2", "CharInfo2"), global.config_data.info2);
layer_text_text(layer_text_get_id("Assets_2", "CharInfo3"), global.config_data.info3);


function export(_result) { // forgive me for my sins
	var _thispath = global.selected_path;
	var _targetpath = string("{0}/{1}", get_workshop_path(), _result);
	
	if (directory_exists(_targetpath)) {
		var _existing_files = get_files_recursive(_targetpath);
		for (var i = 0; i < array_length(_existing_files); i++) {
			file_delete(string("{0}/{1}", _targetpath, _existing_files[i]));
		}
	} else {
		directory_create(_targetpath);
	}
	var _files = get_files_recursive(_thispath);
	for (var i = 0; i < array_length(_files); i++) {
		var _rel_path = _files[i];
		var _dest_file = string("{0}/{1}", _targetpath, _rel_path);
		var _dest_dir = filename_dir(_dest_file);
		if (!directory_exists(_dest_dir)) {
			directory_create(_dest_dir);
		}
		file_copy(string("{0}/{1}", _thispath, _rel_path), _dest_file);
	}
	
	show_message("Successfully exported to the Rivals of Aether workshop folder!\nYou should be able to see your character in game now");
}

function is_workshop_name_taken(_name) {
	return directory_exists(string("{0}/{1}", get_workshop_path(), _name));
}