var _message = "Lord be my witness, this is about to go down as the most incredible project i've ever done thus far -Davi 2026";
// oh also dont bother trying to understand this shit only god knows how this works
instance_deactivate_object(obj_AttackPicker);
instance_deactivate_object(obj_SpritePicker);
instance_deactivate_object(obj_WindowPicker);
instance_deactivate_object(obj_SoundPicker);
instance_deactivate_object(obj_VFXPicker);

instance_deactivate_object(obj_WindowRender);
instance_deactivate_object(obj_HitboxManager);
instance_deactivate_object(obj_visualEditor);

layer_set_visible(layer_get_id("Main"), true);
layer_set_visible(layer_get_id("Windows"), false);
layer_set_visible(layer_get_id("Window"), false);
layer_set_visible(layer_get_id("Hitboxes"), false);
layer_set_visible(layer_get_id("HitboxesPage1"), false);
layer_set_visible(layer_get_id("HitboxesPage2"), false);
layer_set_visible(layer_get_id("HitboxesPage3"), false);
layer_set_visible(layer_get_id("SelectSprite"), false);
layer_set_visible(layer_get_id("SelectWindow"), false);
layer_set_visible(layer_get_id("SelectSound"), false);
layer_set_visible(layer_get_id("SelectVFX"), false);
layer_set_visible(layer_get_id("SelectAttack"), false);
layer_set_visible(layer_get_id("VISUALEDITOR"), false);
layer_set_visible(layer_get_id("Exploit"), false);
layer_set_visible(layer_get_id("Assets_1"), true);

swap_descbox_format(0);

problems = false;
if !INITIALIZE() {exit}

if problems {
	show_message("Some information failed to load, saving this character might cause problems or unwanted behaviour, continue with caution");
}

MEGARAM = variable_clone(MEGARAMORIG);

focus = "nothing";
focus_secondary = "";
selected_attack = "bair";
selection_return = undefined;
global.scroll_y = 0;

function selection_end(_seltype) {
	var _movestruct = MEGARAM[$ selected_attack];
	var _movedata = _movestruct.data;
	switch _seltype {
		case "attack":
			if selection_return != "" {
				MEGARAM[$ selection_return] = get_fresh_attack_struct(selection_return);
			}
			break;
		case "sprite":
			if focus_secondary == "SelectSpriteSpr" {
				if selection_return != "" {
					_movedata.AG_SPRITE = string("sprite_get(\"{0}\")", selection_return);
				}
			}
			if focus_secondary == "SelectSpriteSprAir" {
				if selection_return != "" {
					_movedata.AG_AIR_SPRITE = string("sprite_get(\"{0}\")", selection_return);
				}
			}
			if focus_secondary == "SelectSpriteSprHurt" {
				if selection_return != "" {
					_movedata.AG_HURTBOX_SPRITE = string("sprite_get(\"{0}\")", selection_return);
				}
			}
			if focus_secondary == "SelectSpriteSprAirHurt" {
				if selection_return != "" {
					_movedata.AG_HURTBOX_AIR_SPRITE = string("sprite_get(\"{0}\")", selection_return);
				}
			}
			if focus_secondary == "SelectSpriteHbProjSpr" {
				if selection_return != "" {
					obj_HitboxManager.allhitboxes[obj_HitboxManager.selected].HG_PROJECTILE_SPRITE = string("sprite_get(\"{0}\")", selection_return);
				} else {
					obj_HitboxManager.allhitboxes[obj_HitboxManager.selected].HG_PROJECTILE_SPRITE = 0;
				}
			}
			if focus_secondary == "SelectSpriteHbProjMask" {
				if selection_return != "" {
					obj_HitboxManager.allhitboxes[obj_HitboxManager.selected].HG_PROJECTILE_MASK = string("sprite_get(\"{0}\")", selection_return);
				} else {
					obj_HitboxManager.allhitboxes[obj_HitboxManager.selected].HG_PROJECTILE_MASK = -1;
				}
			}
			if focus_secondary == "SelectSpriteHbProjTerr" {
				if selection_return != "" {
					obj_HitboxManager.allhitboxes[obj_HitboxManager.selected].HG_PROJECTILE_COLLISION_SPRITE = string("sprite_get(\"{0}\")", selection_return);
				} else {
					obj_HitboxManager.allhitboxes[obj_HitboxManager.selected].HG_PROJECTILE_COLLISION_SPRITE = 0;
				}
			}
			break;
		case "window":
			if focus_secondary == "SelectWindowStrongChWin" {
				if selection_return != "" {
					_movedata.AG_STRONG_CHARGE_WINDOW = selection_return + 1;
				}
			}
			if focus_secondary == "SelectWindowSpawnWin" {
				if selection_return != "" {
					obj_HitboxManager.allhitboxes[obj_HitboxManager.selected].HG_WINDOW = selection_return + 1;
				}
			}
			break;
		case "sound":
			if focus_secondary == "SelectSoundSndSoundEff" {
				if selection_return != "" {
					obj_WindowManager.selected.AG_WINDOW_SFX = selection_return;
				}
			}
			if focus_secondary == "SelectSoundHbSfx" {
				if selection_return != "" {
					obj_HitboxManager.allhitboxes[obj_HitboxManager.selected].HG_HIT_SFX = selection_return;
				}
			}
			break;
		case "vfx":
			if focus_secondary == "SelectVFXVFX" {
				if selection_return != "" {
					obj_HitboxManager.allhitboxes[obj_HitboxManager.selected].HG_VISUAL_EFFECT = selection_return; 
				}
			}
			if focus_secondary == "SelectVFXVFXdestroy" { // yeah i really screwed this one up huh?
				if selection_return != "" {
					obj_HitboxManager.allhitboxes[obj_HitboxManager.selected].HG_PROJECTILE_DESTROY_EFFECT = selection_return; 
				}
			}
			break;
	}
}

function tick_right_side() {
	var _moveindex = array_get_index(global.allmoves, selected_attack);
	var _movestruct = MEGARAM[$ selected_attack];
	var _movedata = _movestruct.data;
	layer_text_text(get_ui_id("Main", "atks_atkname", false), global.allmovesnames[_moveindex]);
	
	// ATTACK CATEGORY
	initialize_struct_key(_movedata, "AG_CATEGORY", 0);
	correct_value_between(_movedata, "AG_CATEGORY", 0, 2);
	text_button_color("Main", "text_44993339", real(_movedata.AG_CATEGORY) == 0, c_white, c_aqua);
	text_button_color("Main", "text_715BC4C8", real(_movedata.AG_CATEGORY) == 1, c_white, c_aqua);
	text_button_color("Main", "text_32E7122F", real(_movedata.AG_CATEGORY) == 2, c_white, c_aqua);
	if is_focused("nothing", "") {
		button_change_var(_movedata, "AG_CATEGORY", 0, "Main", "graphic_2CCBEEC8");
		button_change_var(_movedata, "AG_CATEGORY", 1, "Main", "graphic_36CBC4BB");
		button_change_var(_movedata, "AG_CATEGORY", 2, "Main", "graphic_636355FD");
	}
	
	// SPRITE
	initialize_struct_key(_movedata, "AG_SPRITE", string("sprite_get(\"{0}\")", selected_attack));
	if is_focused("nothing", "") and mouse_in_uibox("Main", "graphic_43FEB0F3", cr_handpoint, true) {
		initialize_sprite_selector(false, "", "Spr");
	}
	layer_text_text(get_ui_id("Main", "text_7ECD34E", false), get_quoted_text(_movedata.AG_SPRITE));
	
	
	// AERIAL SPRITE AND HURTBOX
	initialize_struct_key(_movedata, "AG_AIR_SPRITE", string("sprite_get(\"{0}\")", selected_attack));
	if _movedata.AG_CATEGORY == 2 and is_focused("nothing", "") and mouse_in_uibox("Main", "graphic_636DC2F2", cr_handpoint, true) {
		initialize_sprite_selector(false, "", "SprAir");
	}
	
	layer_text_blend(get_ui_id("Main", "text_6C1BB858", false), multiplexer(_movedata.AG_CATEGORY == 2, c_gray, c_white));
	layer_text_blend(get_ui_id("Main", "text_4FC63C2B", false), multiplexer(_movedata.AG_CATEGORY == 2, c_gray, c_yellow));
	layer_text_alpha(get_ui_id("Main", "text_7D98F408", false), multiplexer(_movedata.AG_CATEGORY == 2, 0, 1));
	layer_text_text(get_ui_id("Main", "text_7D98F408", false), get_quoted_text(_movedata.AG_AIR_SPRITE));
	initialize_struct_key(_movedata, "AG_HURTBOX_AIR_SPRITE", string("sprite_get(\"{0}\")", selected_attack));
	if _movedata.AG_CATEGORY == 2 and is_focused("nothing", "") and mouse_in_uibox("Main", "graphic_29651568", cr_handpoint, true) {
		initialize_sprite_selector(false, "", "SprAirHurt");
	}
	
	layer_text_blend(get_ui_id("Main", "text_789F2A85", false), multiplexer(_movedata.AG_CATEGORY == 2, c_gray, c_yellow));
	layer_text_alpha(get_ui_id("Main", "text_6AF261D2", false), multiplexer(_movedata.AG_CATEGORY == 2, 0, 1));
	layer_text_text(get_ui_id("Main", "text_6AF261D2", false), get_quoted_text(_movedata.AG_HURTBOX_AIR_SPRITE));
	
	// HURTBOX SPRITE
	initialize_struct_key(_movedata, "AG_HURTBOX_SPRITE", string("sprite_get(\"{0}_hurt\")", selected_attack));
	if is_focused("nothing", "") and mouse_in_uibox("Main", "graphic_3C8AF031", cr_handpoint, true) {
		initialize_sprite_selector(false, "", "SprHurt");
	}
	layer_text_text(get_ui_id("Main", "text_2BBD5566", false), get_quoted_text(_movedata.AG_HURTBOX_SPRITE));
	
	// WINDOW NUMBER
	initialize_struct_key(_movedata, "AG_NUM_WINDOWS", array_length(_movestruct.windows));
	_movedata.AG_NUM_WINDOWS = array_length(_movestruct.windows);
	
	// HAS LANDING LAG
	initialize_struct_key(_movedata, "AG_HAS_LANDING_LAG", 0);
	correct_value_bool(_movedata, "AG_HAS_LANDING_LAG");
	if _movedata.AG_CATEGORY == 1 and is_focused("nothing", "") {
		button_boolean("Main", "graphic_317C3B50", "text_56FCC993", _movedata, "AG_HAS_LANDING_LAG");
	}
	text_obscure("Main", "text_1DAF98F0", _movedata.AG_CATEGORY == 1);
	
	// LANDING LAG FRAMES     
	initialize_struct_key(_movedata, "AG_LANDING_LAG", 0);
	if (_movedata.AG_HAS_LANDING_LAG and _movedata.AG_CATEGORY == 1) and is_focused("nothing") {
		rename_int_button("Main", "graphic_54D57FA2", "text_5D90DA59", _movedata, "AG_LANDING_LAG", "landlag");
	}
	text_obscure("Main", "text_5C2AC49A", _movedata.AG_HAS_LANDING_LAG and _movedata.AG_CATEGORY == 1);
	
	// STOPS AT LEDGE
	initialize_struct_key(_movedata, "AG_OFF_LEDGE", 0);
	correct_value_bool(_movedata, "AG_OFF_LEDGE");
	if is_focused("nothing", "") {
		button_boolean_reverse("Main", "graphic_7B7047D2", "text_765D42B1", _movedata, "AG_OFF_LEDGE");
	}
	
	// STRONG CHARGE WINDOW
	initialize_struct_key(_movedata, "AG_STRONG_CHARGE_WINDOW", 0);
	if is_focused("nothing", "") and mouse_in_uibox("Main", "graphic_765E3E88", cr_handpoint, true) {
		initialize_window_selector(true, -1, "StrongChWin");
	}
	layer_text_text(get_ui_id("Main", "text_3292B8CD", false), get_window_name(_movedata.AG_STRONG_CHARGE_WINDOW - 1));
	
	// CUSTOM GRAVITY
	initialize_struct_key(_movedata, "AG_USES_CUSTOM_GRAVITY", 0);
	correct_value_bool(_movedata, "AG_USES_CUSTOM_GRAVITY");
	if is_focused("nothing", "") {
		button_boolean("Main", "graphic_11B2E140", "text_59FE2222", _movedata, "AG_USES_CUSTOM_GRAVITY");
	}
	
	// WINDOW BUTTON
	if is_focused("nothing", "") and mouse_in_uibox("Main", "graphic_2B1963F5", cr_handpoint, true) {
		layer_set_visible(layer_get_id("Main"), false);
		layer_set_visible(layer_get_id("Windows"), true);
		focus = "windows";
		focus_secondary = "";
		instance_activate_object(obj_WindowRender);
		//obj_WindowRender.
		obj_WindowRender.trigger();
	}
	
	// HITBOX BUTTON
	if is_focused("nothing", "") and mouse_in_uibox("Main", "graphic_33E3B6A9", cr_handpoint, true) {
		layer_set_visible(layer_get_id("Main"), false);
		layer_set_visible(layer_get_id("Hitboxes"), true);
		focus = "hitboxes";
		focus_secondary = "";
		instance_activate_object(obj_HitboxManager);
		obj_HitboxManager.allhitboxes = _movestruct.hitboxes;
		obj_HitboxManager.trigger();
	}
	
	// DISCARD CHANGES
	if is_focused("nothing", "") and mouse_in_uibox("Main", "graphic_64CA8D0A", cr_handpoint, true) {
		if show_question("All unsaved changes will be lost!") {
			room_goto(CharEdit_Main);
		}
	}
	
	// DELETE BUTTON
	layer_sprite_alpha(get_ui_id("Main", "graphic_5577ECAB", true), multiplexer(_movestruct.mandatory, 1, 0));
	layer_text_alpha(get_ui_id("Main", "text_28301E29", false), multiplexer(_movestruct.mandatory, 1, 0));
	if !_movestruct.mandatory and is_focused("nothing", "") {
		if mouse_in_uibox("Main", "graphic_5577ECAB", cr_handpoint, true) {
			if show_question("Are you sure you want to delete this attack?") {
				struct_remove(MEGARAM, selected_attack);
				selected_attack = "bair";
			}
		}
	}
	
	// DISCARD CHANGES
	if is_focused("nothing", "") and mouse_in_uibox("Main", "graphic_63F17A2", cr_handpoint, true) {
		overwrite_files();
		room_goto(CharEdit_Main);
	}
}

// here we fffffffffffucking go
function overwrite_files() {
	var _allmoves = struct_get_names(MEGARAM);
	for (var i = 0; i < array_length(_allmoves); i++) {
		overwrite_file(_allmoves[i]);
	}
}


function overwrite_file(_move) {
	var _filearray = [];
	var _strutto = MEGARAM[$ _move].data;
	var _windows = MEGARAM[$ _move].windows;
	var _hitboxes = MEGARAM[$ _move].hitboxes;
	var _alldata = struct_get_names(MEGARAM[$ _move].data);
	
	for (var j = 0; j < array_length(_alldata); j++) {
		var _key = _alldata[j];
		if _key != "AG_NUM_WINDOWS" {
			array_push(_filearray, string("set_attack_value(AT_{0}, {1}, {2});", string_upper(_move), _key, _strutto[$ _key]));
		}
	}
	array_push(_filearray, "");
	array_push(_filearray, "");
	array_push(_filearray, string("set_attack_value(AT_{0}, {1}, {2});", string_upper(_move), "AG_NUM_WINDOWS", array_length(_windows)));
	array_push(_filearray, "");
	
	for (var i = 0; i < array_length(_windows); i++) {
		var _allwins = struct_get_names(_windows[i]);
		for (var j = 0; j < array_length(_allwins); j++) {
			var _key = _allwins[j];
			if _key != "name" {
				if _key != "AG_WINDOW_LENGTH" {
					array_push(_filearray, string("set_window_value(AT_{0}, {1}, {2}, {3});", string_upper(_move), i + 1, _key, _windows[i][$ _key]));
				} else {
					array_push(_filearray, string("set_window_value(AT_{0}, {1}, {2}, {3}); //{4}", string_upper(_move), i + 1, _key, _windows[i][$ _key], _windows[i].name));
				}
			}
		}
		array_push(_filearray, "");
	}
	array_push(_filearray, "");
	array_push(_filearray, string("set_num_hitboxes(AT_{0}, {1});", string_upper(_move), array_length(_hitboxes)));
	array_push(_filearray, "");
	
	for (var i = 0; i < array_length(_hitboxes); i++) {
		var _allhits = struct_get_names(_hitboxes[i]);
		for (var j = 0; j < array_length(_allhits); j++) {
			var _key = _allhits[j];
			if _key != "name" {
				if _key != "HG_HITBOX_TYPE" {
					array_push(_filearray, string("set_hitbox_value(AT_{0}, {1}, {2}, {3});", string_upper(_move), i + 1, _key, _hitboxes[i][$ _key]));
				} else {
					array_push(_filearray, string("set_hitbox_value(AT_{0}, {1}, {2}, {3}); //{4}", string_upper(_move), i + 1, _key, _hitboxes[i][$ _key], _hitboxes[i].name));
				}
			}
		}
	array_push(_filearray, "");
	}
	
	var _fstr = archive_fetch_filestruct(AP.ATTACKS, string("{0}/scripts/attacks/{1}.gml", global.selected_path, _move));
	if _fstr == undefined {
		archive_create(AP.ATTACKS, get_full_path("scripts/attacks/" + _move), FT.GML);
		_fstr = archive_fetch_filestruct(AP.ATTACKS, string("{0}/scripts/attacks/{1}.gml", global.selected_path, _move));
		if _fstr == undefined {
			show_message("If you see this, the world is a dystopia and humanity is doomed, also an attack didnt save");
			exit;
		}
	}
	_fstr.file = variable_clone(_filearray);
	_fstr.modified = true;
	global.archive_modified = true;
}

function swap_descbox_format(_format) {
	switch _format {
		case 0:
			layer_sprite_alpha(get_ui_id("Assets_1", "desc_bg", true), 0);
			layer_text_alpha(get_ui_id("Assets_1", "desc_text", false), 0);
			break;
		case 1:
			layer_sprite_x(get_ui_id("Assets_1", "desc_bg", true), 562);
			layer_sprite_y(get_ui_id("Assets_1", "desc_bg", true), 62);
			layer_sprite_xscale(get_ui_id("Assets_1", "desc_bg", true), 12.56);
			layer_sprite_yscale(get_ui_id("Assets_1", "desc_bg", true), 7.5);
			layer_sprite_alpha(get_ui_id("Assets_1", "desc_bg", true), 0.9);
		
			layer_text_x(get_ui_id("Assets_1", "desc_text", false), 574);
			layer_text_y(get_ui_id("Assets_1", "desc_text", false), 73);
			layer_text_framew(get_ui_id("Assets_1", "desc_text", false), 1593);
			layer_text_frameh(get_ui_id("Assets_1", "desc_text", false), 937);
			layer_text_alpha(get_ui_id("Assets_1", "desc_text", false), 0.9);
			break;
		case 2:
			layer_sprite_x(get_ui_id("Assets_1", "desc_bg", true), 369);
			layer_sprite_y(get_ui_id("Assets_1", "desc_bg", true), 176);
			layer_sprite_xscale(get_ui_id("Assets_1", "desc_bg", true), 15.57);
			layer_sprite_yscale(get_ui_id("Assets_1", "desc_bg", true), 9.25);
			layer_sprite_alpha(get_ui_id("Assets_1", "desc_bg", true), 0.9);
		
			layer_text_x(get_ui_id("Assets_1", "desc_text", false), 384);
			layer_text_y(get_ui_id("Assets_1", "desc_text", false), 192);
			layer_text_framew(get_ui_id("Assets_1", "desc_text", false), 1970);
			layer_text_frameh(get_ui_id("Assets_1", "desc_text", false), 1149);
			layer_text_alpha(get_ui_id("Assets_1", "desc_text", false), 0.9);
			break;
		case 3:
			layer_sprite_x(get_ui_id("Assets_1", "desc_bg", true), 634);
			layer_sprite_y(get_ui_id("Assets_1", "desc_bg", true), 62);
			layer_sprite_xscale(get_ui_id("Assets_1", "desc_bg", true), 11.43);
			layer_sprite_yscale(get_ui_id("Assets_1", "desc_bg", true), 10.9);
			layer_sprite_alpha(get_ui_id("Assets_1", "desc_bg", true), 0.9);
		
			layer_text_x(get_ui_id("Assets_1", "desc_text", false), 649);
			layer_text_y(get_ui_id("Assets_1", "desc_text", false), 75);
			layer_text_framew(get_ui_id("Assets_1", "desc_text", false), 1425);
			layer_text_frameh(get_ui_id("Assets_1", "desc_text", false), 1374);
			layer_text_alpha(get_ui_id("Assets_1", "desc_text", false), 0.9);
			break;
	}
}

function display_information(_fromx, _fromy, _tox, _toy, _format, _formatteddesc) {
	if mouse_in_rectangle(_fromx, _fromy, _tox, _toy) {
		swap_descbox_format(_format);
		layer_text_text(get_ui_id("Assets_1", "desc_text", false), _formatteddesc);
	}
}

function tick_information() {
	swap_descbox_format(0);
	if focus == "nothing" {
		display_information(260, 133, 562, 169, 1, "ATTACK CATEGORY\n\n Wether the attack can be performed only on the ground, only airborne or in both cases");
		display_information(260, 169, 562, 225, 1, "ATTACK SPRITE\n\n The sprite associated with this attack and the sprite used as a hitbox (usually called spritename_hurt)");
		display_information(260, 225, 562, 272, 1, "ATTACK AERIAL SPRITE\n\nThis parameter is enabled only if the attack is both aerial and grounded\n\n The sprite associated with this attack and the sprite used as a hitbox (usually called spritename_hurt)");
		display_information(260, 272, 562, 320, 1, "HAS LANDING LAG\n\nThis parameter is enabled only if the attack is only aerial\n\n Wether to apply landing lag or continue the aerial attack when touching the ground");
		display_information(260, 320, 562, 352, 1, "LANDING LAG\n\nThis parameter is enabled only if this attack has landing lag enabled\n\n The number of landing lag frames applied when landing. If you whiff the attack, this value is multiplied by 1.5.");
		display_information(260, 352, 562, 416, 1, "STOPS AT LEDGE\n\nWether this attack ends at a ledge or continues off ledge");
		display_information(260, 416, 562, 480, 1, "CHARGE WINDOW\n\nIf attack is held at the end of this window, the character will freeze and charge the attack before moving to the next window");
		display_information(260, 480, 562, 535, 1, "CUSTOM GRAVITY\n\nWether to use custom gravity or the default gravity. Custom gravity values must be set for every window of the attack individually");
	}
	if focus == "winedit" {
		display_information(9, 190, 343, 237, 2, "WINDOW TYPE\n\nThe type of window out of the following:\n\nNormal behaviour\nPuts into pratfall after\nSkips to the next window if it's on the ground, otherwise normal\nWindow loops indefinitely\nWindow loops until it's touching the ground");
		display_information(9, 237, 343, 280, 2, "WINDOW LENGTH\n\nThe duration of the window in frames:\n\n [X IN Y FRAMES]\nX: The number of animation frames to display over the duration of the window\nY: The duration of the window in game frames (60 = 1s)");
		display_information(9, 280, 343, 327, 2, "HORIZONTAL SPEED\n\nThe horizontal speed to apply during the window in pixels per frame.\n\n BOOST add the speed to your cureent speed\nCONSTANT keeps the speed at the given value for the whole window\nSET only sets the speed on the first frame of the window");
		display_information(9, 327, 343, 374, 2, "VERTICAL SPEED\n\nThe vertical speed to apply during the window in pixels per frame.\n\n BOOST add the speed to your cureent speed\nCONSTANT keeps the speed at the given value for the whole window\nSET only sets the speed on the first frame of the window");
		display_information(9, 374, 343, 422, 2, "CUSTOM FRICTION\n\nWether to enable custom friction, the value of air friction and the value of ground friction");
		display_information(9, 422, 343, 466, 2, "CUSTOM GRAVITY\n\nThe gravitational acceleration to apply every frame of the window.\nOnly effective if CUSTOM GRAVITY is enabled");
		display_information(9, 466, 343, 514, 2, "WHIFF LAG\n\nWether or not to extend the window length by x1.5 if the attack misses");
		display_information(9, 514, 343, 563, 2, "INVINCIBILITY\n\nThis dictates what the character is immune to during this window:\n\nOFF: vulnerable to everything\nALL: Completely invincible\n PROJECTILES: Immune to projectiles only");
		display_information(9, 563, 343, 611, 2, "HITPAUSE FRAME\n\nThe animation frame to show during hitpause.\n\n0 = No specific frame");
		display_information(9, 611, 343, 660, 2, "MOVE CANCEL\n\nWether the window doesnt cancel, cancels into next window if attack is pressed (when on a jab, this allows it to be tilt-cancelled) or cancels into next window if special is pressed\n\nDoes not work if WINDOW TYPE is set to GROUND");
		display_information(9, 660, 343, 705, 2, "SOUND EFFECT\n\nWether to play a sound effect, at what frame and which sound effect");
	}
	if focus = "hitboxes" {
		var _p = obj_HitboxManager.page;
		if _p == 1 {
			display_information(286, 134, 632, 175, 3, "PARENT HITBOX\n\nIf this is anything other than 0, then it will inherit ALL values from the hitbox with that index EXCEPT:\n\nHITBOX TYPE\nSPAWN WINDOW\nDURATION\nX POSITION\nY POSITION\nHITBOX GROUP");
			display_information(286, 175, 632, 218, 3, "TYPE\n\nWether this hitbox is a physical attack or a projectile, if projectile is chosen you will gain access to the PROJECTILE SETTINGS");
			display_information(286, 218, 632, 263, 3, "SPAWN WINDOW\n\nThe frame in which the hitbox is created, relative to the start of the given attack window.");
			display_information(286, 263, 632, 309, 3, "DURATION\n\nThe duration of the hitbox in game frames (60 = 1s)");
			display_information(286, 309, 632, 355, 3, "APPEARANCE\n\nOpens a sick visual editor that took too long to code that lets you adjust the hitbox's X and Y values, ANGLE, GROUP and SIZE");
			display_information(286, 355, 632, 403, 3, "PRIORITY\n\nRanges from 1 to 10, with a priority 10 hitbox taking priority over a priority 1 hitbox if both hit at the same time");
			display_information(286, 403, 632, 447, 3, "DAMAGE\n\nThe percent damage dealt by the hitbox");
			display_information(286, 447, 632, 490, 3, "KNOCKBACK\n\nThe base knockback value dealt by the hitbox and the amount of scaling depending on the enemy's percentage");
			display_information(286, 490, 632, 537, 3, "EFFECTS PAGE 1\n\nThe effect the hitbox applies to the enemy:\n\nNONE: No effect\nBURN: Applies fire\nBURN C: Extra damage to burning enemies and extinguishes\nBURN S: Extra hitpause on burning enemies\nWRAP: Immobilizes opponents if marked\nFREEZE: Stuns the enemy in ice");
			display_information(286, 537, 632, 578, 3, "EFFECTS PAGE 2\n\nThe effect the hitbox applies to the enemy:\n\nMARK: Marks the opponent, does nothing on it's own\nA WRAP: Wraps opponents immediately\nPOLITE: Applies hitstun only if already hitstun\nPOISON: Applies stacking poison\nP STUN: Plasma stuns enemies for a long time\nC ARMOR: The enemy won't be knocked back if they're crouching");
			display_information(286, 578, 632, 621, 3, "HITPAUSE\n\nThe amount of hitpause the move applies to an opponent regardless of their damage and the amount of hitpause to add to base hitpause relative to the opponent's damage");
			display_information(286, 621, 632, 662, 3, "HIT VISUAL\n\nThe X offset, the Y offset and the visual effect to display when the hitbox connects");
		}
		if _p == 2 {
			display_information(286, 136, 632, 180, 3, "HIT PARTICLE SLOT\n\nThe hit particle slot to use. Should be between 1 and 6 for custom particles. 0 will use normal hit particles.");
			display_information(286, 180, 632, 219, 3, "SOUND EFFECT\n\nThe sound effect to play when the attack hits");
			display_information(286, 219, 632, 264, 3, "0 = Sends at the exact knockback (KB) angle every time\n1 = Sends away from the center of the enemy\n2 = Sends toward the center of the enemy\n3 = Horizontal KB sends away from the center of the hitbox\n4 = Horizontal KB sends toward the center of the hitbox\n5 = Horizontal KB is reversed\n6 = Horizontal KB sends away from the enemy\n7 = Horizontal KB sends toward the enemy\n8 = Sends away from the center of the hitbox\n9 = Sends toward the center of the hitbox");
			display_information(286, 264, 632, 309, 3, "EXTRA HITPAUSE\n\nExtra hitpause to apply to the opponent only. Can be negative");
			display_information(286, 309, 632, 353, 3, "GROUNDEDNESS\n\nWether it can hit AERIAL opponents only, GROUNDED opponents only or BOTH");
			display_information(286, 353, 632, 394, 3, "EXTRA CAMERA SHAKE\n\nNO camera shake,  NORMAL camera shake: Only applied if knockback speed is above 1 or FORCE camera shake: even if knockback speed is lower than 1");
			display_information(286, 394, 632, 441, 3, "BREAK PROJECTILES\n\nWether the hitbox can break projectiles it comes in contact with");
			display_information(286, 441, 632, 484, 3, "HIT LOCKOUT\n\nThe number of frames after this hitbox connects where another hitbox belonging to the same player cannot hit the opponent");
			display_information(286, 484, 632, 527, 3, "PARRY STUN\n\nWhen this hitbox is parried, the amount of parry stun inflicted on the opponent will be relative to the distance between you");
			display_information(286, 527, 632, 571, 3, "MULTIPLIERS\n\n1- The value by which hitstun is multiplied after being calculated normally. A value of 0 results in default hitstun (the same as a value of 1)\n2- Causes the acceleration of the opponent's drift Directional Influence (DI) to be multiplied by this value\n3- Causes the distance of the opponent's Smash Directional Influence (SDI) to be multiplied by this value.");
			display_information(286, 571, 632, 614, 3, "TECHABLE\n\nWether it CAN tech, CANNOT tech, TECHS though platforms or CANNOT tech nor bounce");
			display_information(286, 614, 632, 660, 3, "FORCE FLINCH\n\nWether it DOESN'T force flinch, will force GROUNDED opponents, CANNOT force flinch or causes CROUCHING opponents to flinch");
			display_information(286, 660, 632, 705, 3, "FINAL KNOCKBACK\n\nIf this is greater than 0, the base knockback of the hitbox will progress linearly from BASE KNOCKBACK to FINAL KNOCKBACK over the span of the hitbox's lifetime");
			display_information(286, 705, 632, 750, 3, "ROCK INTERACTION\n\nWether the hitbox should BREAK, THROW or IGNORE Kragg's rock");
		}
		if _p == 3 {
			display_information(286, 127, 632, 167, 3, "PROJECTILE SPRITE\n\nThe sprite to loop for the projectile's animation");
			display_information(286, 167, 632, 216, 3, "COLLISION SPRITE\n\nThe sprite to use for the projectile's collision (uses precise collision). Set to -1 to use normal hitbox collision shape");
			display_information(286, 216, 632, 260, 3, "TERRAIN COLLISION SPRITE\n\nThe sprite used for colliding with terrain only. Defaults to 0, in which case it will use the PROJECTILE SPRITE instead.");
			display_information(286, 260, 632, 302, 3, "ANIMATION SPEED\n\nThe speed at which the projectile's sprite will animate");
			display_information(286, 302, 632, 346, 3, "INITIAL SPEED\n\nThe horizontal, vertical and gravity speed of the projectile");
			display_information(286, 346, 632, 389, 3, "FRICTION\n\nThe decrease in horizontal speed per frame when the projectile is grounded, and the decrease when aerial");
			display_information(286, 389, 632, 432, 3, "WALL BEHAVIOUR\n\nWether the projectile STOPs, PASSes through walls or BOUNCEs against them");
			display_information(286, 432, 632, 480, 3, "GROUND BEHAVIOUR\n\nWether the projectile STOPs, PASSes through the ground or BOUNCEs against it");
			display_information(286, 480, 632, 520, 3, "PIERCING ENEMIES\n\nWether the projectile pierces through enemies");
			display_information(286, 520, 632, 564, 3, "UNBASHABLE\n\nWether the projectile can be caught in Ori's bash");
			display_information(286, 564, 632, 610, 3, "PARRY STUN\n\nWhether parrying the projectile will cause the owner to go into parry stun or not and wether the projectile will NOT reflect or change ownership when parried (true) or will (false)");
			display_information(286, 610, 632, 652, 3, "TRANSCENDENT\n\nIf true, the projectile will not be breakable by other hitboxes");
			display_information(286, 652, 632, 698, 3, "DESTROY EFFECT\n\nThe visual effect to use when the projectile is destroyed");
			display_information(286, 698, 632, 744, 3, "PLASMA SAFE\n\nIf true, the projectile will not break when inside Clairen's plasma field.");
		}
	}
}