global.tick = 0;
global.ARCHIVE = {};
global.previews = [];
global.allmoves = [
	"jab",
	"dattack",
	"ftilt",
	"utilt",
	"dtilt",
	"nspecial",
	"fspecial",
	"uspecial",
	"dspecial",
	"nair",
	"fair",
	"bair",
	"dair",
	"uair",
	"fstrong",
	"ustrong",
	"dstrong",
	"taunt",
	"nspecial_2",
	"nspecial_air",
	"fspecial_2",
	"fspecial_air",
	"uspecial_2",
	"uspecial_ground",
	"dspecial_2",
	"dspecial_air",
	"fstrong_2",
	"ustrong_2",
	"dstrong_2",
	"fthrow",
	"uthrow",
	"dthrow",
	"nthrow",
	"taunt_2",
	"extra_1",
	"extra_2",
	"extra_3"
];

global.allmovesnames = [
	"JAB",
	"DASH ATTACK",
	"FORWARD TILT",
	"UP TILT",
	"DOWN TILT",
	"NEUTRAL SPECIAL",
	"FORWARD SPECIAL",
	"UP SPECIAL",
	"DOWN SPECIAL",
	"NEUTRAL AIR",
	"FORWARD AIR",
	"BACK AIR",
	"DOWN AIR",
	"UP AIR",
	"FORWARD STRONG",
	"UP STRONG",
	"DOWN STRONG",
	"TAUNT",
	"NEUTRAL SPECIAL 2",
	"NEUTRAL SPECIAL AIR",
	"FORWARD SPECIAL 2",
	"FORWARD SPECIAL AIR",
	"UP SPECIAL 2",
	"UP SPECIAL GROUND",
	"DOWN SPECIAL 2",
	"DOWN SPECIAL AIR",
	"FORWARD STRONG 2",
	"UP STRONG 2",
	"DOWN STRONG 2",
	"FORWARD THROW",
	"UP THROW",
	"DOWN THROW",
	"NEUTRAL THROW",
	"TAUNT 2",
	"EXTRA 1",
	"EXTRA 2",
	"EXTRA 3"
];

window_height = window_get_height();
window_width = window_get_width();
saveanim = 1;
draw_set_font(fnt_jersey20_SDF);
window_enable_borderless_fullscreen(true);
randomise();

if !directory_exists("saved") {
	directory_create("saved");
}



var _base_width = 480;
var _base_height = 270; 
var _scale = 5;

//window_set_size(_base_width * 3, _base_height * 3);
//surface_resize(application_surface, _base_width * _scale, _base_height * _scale);
//window_center();