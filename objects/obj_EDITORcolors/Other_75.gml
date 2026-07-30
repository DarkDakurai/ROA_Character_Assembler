switch (async_load[?"event_type"]) {
	case "file_drag_enter_start":
		filedrag = true;
		break;
	case "file_drag_leave":
		reset_drag();
		break;
	case "file_drop":
		numdragfiles++;
		var _f = async_load[?"filename"];
		if filename_name(_f) == "colors.gml" and numdragfilessuccess == 0 {
			archive_create(AP.SCRIPTS, get_full_path("scripts/colors.gml"), FT.GML); // creates the colors gml file if it doesnt exist yet
			if archive_replace(AP.SCRIPTS, get_full_path("scripts/colors.gml"), _f) {
				numdragfilessuccess++;
			}
		}
		break;
	case "file_drop_end":
		if numdragfiles > 0 {
			if numdragfiles == numdragfilessuccess {
				show_message(string("Successfully imported {0} files", numdragfilessuccess));
			} else {
				show_message(string("Successfully imported {0} out of {1} files", numdragfilessuccess, numdragfiles));
			}
			room_restart();
		}
		reset_drag();
		break;
}