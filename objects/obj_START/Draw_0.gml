global.scroll_y = clamp(global.scroll_y, -345 * (array_length(global.saved_paths) div 5), 0)

var _elev = 106;

var i;
for (i = 0; i < array_length(global.saved_paths); i++) {
	var _y_diff = 345 * (i div 5) + global.scroll_y + _elev;
	var _x_diff = 255 * (i mod 5);
	draw_sprite_ext(spr_UIbox, 0,			 45 + _x_diff, 158 + _y_diff, 3.25, 4.8, 0, c_white, 1);
	draw_sprite_ext(spr_UIbox, 0,			 45 + _x_diff, 158 + _y_diff, 3.25, 2.3125, 0, c_white, 1);
	draw_sprite_ext(global.previews[i],	0,	 47 + _x_diff, 160 + _y_diff, 2, 2, 0, c_white, 1);
	draw_text_ext_transformed(				 144 + _x_diff, 306 + _y_diff, global.charconfs[i].name, 10, 9999, 0.28, 0.28, 0);
	draw_text_ext_transformed_color(		 144 + _x_diff, 325 + _y_diff, global.filenames[i], 10, 9999, 0.2, 0.2, 0, c_gray, c_gray, c_gray, c_gray, 1);
	
	// EDIT CHARACTER BUTTON
	var _touched = mouse_in_rectangle(47 + _x_diff, 355 + _y_diff, 249 + _x_diff, 404 + _y_diff);
	var _col = multiplexer(_touched, c_white, c_aqua);
	if _touched and mouse_check_button_pressed(mb_left) {
		global.selected_filename = global.filenames[i]; 
		global.selected_path = global.saved_paths[i];
		INITIALIZE_ARCHIVE(global.selected_path);
		room_goto(CharEdit_Main)
	}
	draw_text_ext_transformed_colour(		 144 + _x_diff, 350 + _y_diff, "EDIT", 99, 9999, 0.7, 0.7, 0, _col, _col, _col, _col, 1);

	// ERASE CHARACTER BUTTON
	_touched = mouse_in_rectangle(47 + _x_diff, 405 + _y_diff, 250 + _x_diff, 462 + _y_diff);
	if _touched and mouse_check_button_pressed(mb_left) {
		if eraseid != i {
			eraseconfirm = 1;
			eraseid = i;
		} else {
			if eraseconfirm < 2 {eraseconfirm++}
			else {
				directory_destroy(global.saved_paths[i]);
				room_restart();
			}
		}
	}
	_col = multiplexer(_touched, c_white, c_red);
	if eraseid != i {
		draw_text_ext_transformed_colour(		 144 + _x_diff, 400 + _y_diff, "ERASE", 99, 9999, 0.7, 0.7, 0, _col, _col, _col, _col, 1);
	} else {
		draw_text_ext_transformed_colour(		 144 + _x_diff + irandom_range(-1, 1) * (eraseconfirm == 2), 400 + irandom_range(-1, 1) * (eraseconfirm == 2) + _y_diff, multiplexer(eraseconfirm, "ERASE", "ERASE!", "ERASE!!"), 99, 9999, 0.7, 0.7, 0, _col, _col, _col, _col, 1);
	}
}

// CREATE NEW CHARACTER BUTTON
draw_sprite_ext(spr_UIbox, 0, 45 + 255 * (i mod 5), global.scroll_y + 158 + 345 * (i div 5) + _elev, 3.25, 4.8, 0, c_white, 1);
var _touched = mouse_in_rectangle(45 + 255 * (i mod 5), global.scroll_y + 158 + 345 * (i div 5) + _elev, 252 + 255 * (i mod 5), global.scroll_y + 465 + 345 * (i div 5) + _elev);
if _touched and mouse_check_button_pressed(mb_left) {
	if file_exists("template.zip") {
		var _filename = "NewCharacter";
		var _inc = "";
		var _string = multiplexer(global.selected_dest, global.superpath, global.superpath + "/")
		while directory_exists(string("{2}{0}{1}", _filename, _inc, _string)) {
			if _inc == "" {
				_inc = 1;
			} else {
				_inc++;
			}
		}
		zip_unzip("template.zip", string("{2}{0}{1}", _filename, _inc, _string));
		room_restart();
	} else {
		show_message("Couldn't find template.zip in the program files, due to this it will be impossible to create new characters using this button until the template.zip file is restored. \n(template.zip is automtically included in the dowloaded files, if missing, try to redownload the program)")
	}
}
draw_sprite_ext(spr_plus, 0, 150 + 255 * (i mod 5), global.scroll_y + 305 + 345 * (i div 5) + _elev, 2, 2, 0, multiplexer(_touched, c_white, c_lime), 1);