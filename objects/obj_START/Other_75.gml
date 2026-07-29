show_debug_message(async_load[?"event_type"]);
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
		if filename_ext(_f) == ".zip" {
			numdragfilessuccess++;
			file_copy(_f, "templates/" + filename_name(_f));
		}
		break;
	case "file_drop_end":
		if numdragfiles > 0 {
			if numdragfiles == numdragfilessuccess {
				show_message(string("Successfully imported {0} templates", numdragfilessuccess));
			} else {
				show_message(string("Successfully imported {0} templates out of {1} files", numdragfilessuccess, numdragfiles));
			}
			room_restart();
		}
		reset_drag();
		break;
}