var _base_width = 480;
var _base_height = 270; 
var _scale = 5;
	
if window_get_fullscreen() {

	window_set_fullscreen(false);
		

	//window_set_size(_base_width * 3, _base_height * 3);
	//surface_resize(application_surface, _base_width * _scale, _base_height * _scale);
	//window_center();
} else {

	window_set_fullscreen(true);
		
}