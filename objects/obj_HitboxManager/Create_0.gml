selected = 0;
page = 1;
function trigger() {
	page = 1;
	triggerframe = true;
}

function newHitbox() {
	array_push(allhitboxes, {name: string("HITBOX {0}", array_length(allhitboxes) + 1)});
}

function manage_page(_page, _hb) {
	var _focused = is_focused("hitboxes", "", obj_EDITORattacks);
	var _halfocused = is_focused("hitboxes", -1, obj_EDITORattacks);
	if _page == 1 {
		
		// PARENT
		initialize_struct_key(_hb, "HG_PARENT_HITBOX", 0);
		if _halfocused {
			rename_int_button("HitboxesPage1", "graphic_61BE58AE", "text_293285AB", _hb, "HG_PARENT_HITBOX", "hitbparent", obj_EDITORattacks, "hitboxes");
		}
		correct_value_between(_hb, "HG_PARENT_HITBOX", 0, array_length(allhitboxes));
		
		
		// TYPE
		initialize_struct_key(_hb, "HG_HITBOX_TYPE", 1);
		text_button_color("HitboxesPage1", "text_FADE024", real(_hb.HG_HITBOX_TYPE) == 1, c_white, c_aqua);
		text_button_color("HitboxesPage1", "text_583ED4BD", real(_hb.HG_HITBOX_TYPE) == 2, c_white, c_aqua);
		if _focused {
			button_change_var(_hb, "HG_HITBOX_TYPE", 1, "HitboxesPage1", "graphic_1D109E3E");
			button_change_var(_hb, "HG_HITBOX_TYPE", 2, "HitboxesPage1", "graphic_4D3394A7");
		}
		
		// WINDOW CREATION FRAME
		initialize_struct_key(_hb, "HG_WINDOW_CREATION_FRAME", 0);
		if _halfocused {
			rename_int_button("HitboxesPage1", "graphic_75147380", "text_479A2EE3", _hb, "HG_WINDOW_CREATION_FRAME", "hitcreatframe", obj_EDITORattacks, "hitboxes");
		}
		
		// SPAWN WINDOW SELECTOR
		initialize_struct_key(_hb, "HG_WINDOW", 1);
		correct_value_between(_hb, "HG_WINDOW", 1, array_length(obj_EDITORattacks.MEGARAM[$ obj_EDITORattacks.selected_attack].windows));
		var _strutto = obj_EDITORattacks.MEGARAM[$ obj_EDITORattacks.selected_attack].windows[_hb.HG_WINDOW - 1];
		initialize_struct_key(_strutto, "AG_WINDOW_LENGTH", 1);
		var _cece = _strutto.AG_WINDOW_LENGTH;
		correct_value_between(_hb, "HG_WINDOW_CREATION_FRAME", 0, real(_cece));
		if _focused and mouse_in_uibox("HitboxesPage1", "graphic_482CF27", cr_handpoint, true) {
			initialize_window_selector(false, -1, "SpawnWin", obj_EDITORattacks);
		}
		layer_text_text(get_ui_id("HitboxesPage1", "text_72C0FE7D", false), get_window_name(_hb.HG_WINDOW - 1, obj_EDITORattacks));
		
		// DURATION
		initialize_struct_key(_hb, "HG_LIFETIME", 1);
		if _halfocused {
			rename_int_button("HitboxesPage1", "graphic_2295D596", "text_25DE5AFB", _hb, "HG_LIFETIME", "hblifetime", obj_EDITORattacks, "hitboxes");
		}
		
		// VISUAL EDITOR
		initialize_struct_key(_hb, "HG_HITBOX_X", 0);
		initialize_struct_key(_hb, "HG_HITBOX_Y", 0);
		initialize_struct_key(_hb, "HG_WIDTH", 0);
		initialize_struct_key(_hb, "HG_HEIGHT", 0);
		initialize_struct_key(_hb, "HG_SHAPE", 0);
		initialize_struct_key(_hb, "HG_ANGLE", 0);
		initialize_struct_key(_hb, "HG_HITBOX_GROUP", -1);
		if _focused and mouse_in_uibox("HitboxesPage1", "graphic_207F5265", cr_handpoint, true) {
			obj_EDITORattacks.focus = "viseditor";
			obj_EDITORattacks.focus_secondary = "";
			layer_set_visible(layer_get_id("VISUALEDITOR"), true);
			instance_activate_object(obj_visualEditor);
			obj_visualEditor.trigger(_hb);
		}
		
		// PRIORITY
		initialize_struct_key(_hb, "HG_PRIORITY", 1);
		correct_value_between(_hb, "HG_PRIORITY", 1, 10);
		if _halfocused {
			rename_int_button("HitboxesPage1", "graphic_3F5544F4", "text_522EF1C5", _hb, "HG_PRIORITY", "hbpruio", obj_EDITORattacks, "hitboxes");
		}
		
		// DAMAGE
		initialize_struct_key(_hb, "HG_DAMAGE", 5);
		if _halfocused {
			rename_float_button("HitboxesPage1", "graphic_34E136CA", "text_21457D0A", _hb, "HG_DAMAGE", "hbdamage", obj_EDITORattacks, "hitboxes");
		}
		
		// KNOCKBACK
		initialize_struct_key(_hb, "HG_BASE_KNOCKBACK", 5);
		if _halfocused {
			rename_float_button("HitboxesPage1", "graphic_6AE487B2", "text_3811AE9C", _hb, "HG_BASE_KNOCKBACK", "hbknocks", obj_EDITORattacks, "hitboxes");
		}
		initialize_struct_key(_hb, "HG_KNOCKBACK_SCALING", 0.1);
		if _halfocused {
			rename_float_button("HitboxesPage1", "graphic_7530084C", "text_5435BD77", _hb, "HG_KNOCKBACK_SCALING", "hbknockscale", obj_EDITORattacks, "hitboxes");
		}
		
		// TYPE
		initialize_struct_key(_hb, "HG_EFFECT", 0);
		correct_value_between(_hb, "HG_EFFECT", 0, 12);
		text_button_color("HitboxesPage1", "text_1868C934", real(_hb.HG_EFFECT) == 0, c_white, c_aqua);
		text_button_color("HitboxesPage1", "text_3662BC9D", real(_hb.HG_EFFECT) == 1, c_white, c_aqua);
		text_button_color("HitboxesPage1", "text_643C8418", real(_hb.HG_EFFECT) == 2, c_white, c_aqua);
		text_button_color("HitboxesPage1", "text_7F279728", real(_hb.HG_EFFECT) == 3, c_white, c_aqua);
		text_button_color("HitboxesPage1", "text_46A58902", real(_hb.HG_EFFECT) == 4, c_white, c_aqua);
		text_button_color("HitboxesPage1", "text_15138D50", real(_hb.HG_EFFECT) == 5, c_white, c_aqua);
		text_button_color("HitboxesPage1", "text_137FE6C4", real(_hb.HG_EFFECT) == 6, c_white, c_aqua);
		text_button_color("HitboxesPage1", "text_5E73DC94", real(_hb.HG_EFFECT) == 8, c_white, c_aqua);
		text_button_color("HitboxesPage1", "text_36E786EE", real(_hb.HG_EFFECT) == 9, c_white, c_aqua);
		text_button_color("HitboxesPage1", "text_5B220707", real(_hb.HG_EFFECT) == 10, c_white, c_aqua);
		text_button_color("HitboxesPage1", "text_76833540", real(_hb.HG_EFFECT) == 11, c_white, c_aqua);
		text_button_color("HitboxesPage1", "text_6E7C8968", real(_hb.HG_EFFECT) == 12, c_white, c_aqua);
		if _focused {
			button_change_var(_hb, "HG_EFFECT", 0, "HitboxesPage1", "graphic_4AC6E1B");
			button_change_var(_hb, "HG_EFFECT", 1, "HitboxesPage1", "graphic_21F5AD50");
			button_change_var(_hb, "HG_EFFECT", 2, "HitboxesPage1", "graphic_5D61B61E");
			button_change_var(_hb, "HG_EFFECT", 3, "HitboxesPage1", "graphic_307A29AF");
			button_change_var(_hb, "HG_EFFECT", 4, "HitboxesPage1", "graphic_161931A3");
			button_change_var(_hb, "HG_EFFECT", 5, "HitboxesPage1", "graphic_1F14545E");
			button_change_var(_hb, "HG_EFFECT", 6, "HitboxesPage1", "graphic_7F77A58C");
			button_change_var(_hb, "HG_EFFECT", 8, "HitboxesPage1", "graphic_66234815");
			button_change_var(_hb, "HG_EFFECT", 9, "HitboxesPage1", "graphic_7F99C6B2");
			button_change_var(_hb, "HG_EFFECT", 10, "HitboxesPage1", "graphic_527693EB");
			button_change_var(_hb, "HG_EFFECT", 11, "HitboxesPage1", "graphic_572574FE");
			button_change_var(_hb, "HG_EFFECT", 12, "HitboxesPage1", "graphic_7A0D266F");
		}
		
		// HITPAUSE
		initialize_struct_key(_hb, "HG_BASE_HITPAUSE", 0);
		correct_value_between(_hb, "HG_BASE_HITPAUSE", 0, infinity);
		if _halfocused {
			rename_int_button("HitboxesPage1", "graphic_C11C7F4", "text_4652EFAB", _hb, "HG_BASE_HITPAUSE", "hbhp", obj_EDITORattacks, "hitboxes");
		}
		initialize_struct_key(_hb, "HG_HITPAUSE_SCALING", 0);
		correct_value_between(_hb, "HG_HITPAUSE_SCALING", 0, infinity);
		if _halfocused {
			rename_int_button("HitboxesPage1", "graphic_77D774B5", "text_73BC99D4", _hb, "HG_HITPAUSE_SCALING", "hbhpsc", obj_EDITORattacks, "hitboxes");
		}
		
		// HIT VFX
		initialize_struct_key(_hb, "HG_VISUAL_EFFECT_X_OFFSET", 0);
		if _halfocused {
			rename_float_button("HitboxesPage1", "graphic_38F054F8", "text_46A7D566", _hb, "HG_VISUAL_EFFECT_X_OFFSET", "hbhitvfxx", obj_EDITORattacks, "hitboxes");
		}
		initialize_struct_key(_hb, "HG_VISUAL_EFFECT_Y_OFFSET", 0);
		if _halfocused {
			rename_float_button("HitboxesPage1", "graphic_5F2DCC62", "text_BF43AF8", _hb, "HG_VISUAL_EFFECT_Y_OFFSET", "hbhitvfxy", obj_EDITORattacks, "hitboxes");
		}
		initialize_struct_key(_hb, "HG_VISUAL_EFFECT", 1);
		if _focused and mouse_in_uibox("HitboxesPage1", "graphic_308CB06B", cr_handpoint, true) {
			initialize_vfx_selector(true, 1, "VFX", obj_EDITORattacks);
		}
		layer_text_text(get_ui_id("HitboxesPage1", "text_31B61C06", false), _hb.HG_VISUAL_EFFECT);
		
		// NEXT PAGE
		if !triggerframe and _focused and mouse_in_uibox("HitboxesPage1", "graphic_7D44F923", cr_handpoint, true) {
			page = 2;
		}
		
		// PROJ SETTINGS
		if !triggerframe and _focused and _hb.HG_HITBOX_TYPE == 2 and mouse_in_uibox("HitboxesPage1", "graphic_594C90D1", cr_handpoint, true) {
			page = 3;
		}
		triggerframe = false;
		text_obscure("HitboxesPage1", "text_31FC41D2", _hb.HG_HITBOX_TYPE == 2);
	} else if _page == 2 {
		
		// PARTICLE SLOT
		initialize_struct_key(_hb, "HG_HIT_PARTICLE_NUM", 1);
		correct_value_between(_hb, "HG_HIT_PARTICLE_NUM", 1, 6);
		if _halfocused {
			rename_int_button("HitboxesPage2", "graphic_55E70943", "text_731ACA02", _hb, "HG_HIT_PARTICLE_NUM", "hbparslot", obj_EDITORattacks, "hitboxes");
		}
		
		// SOUND EFFECT
		initialize_struct_key(_hb, "HG_HIT_SFX", string("asset_get(\"punch_sfx\")"));
		if _focused and mouse_in_uibox("HitboxesPage2", "graphic_56B082CB", cr_handpoint, true) {
			initialize_sound_selector(false, "", "HbSfx", obj_EDITORattacks);
		}
		layer_text_text(get_ui_id("HitboxesPage2", "text_5DE78FD9", false), get_quoted_text(_hb.HG_HIT_SFX));
		
		// ANGLE FLIPPER  HG_ANGLE_FLIPPER
		initialize_struct_key(_hb, "HG_ANGLE_FLIPPER", 0);
		correct_value_between(_hb, "HG_ANGLE_FLIPPER", 0, 9);
		if _halfocused {
			rename_int_button("HitboxesPage2", "graphic_7DD9BE9D", "text_8C8FC16", _hb, "HG_ANGLE_FLIPPER", "hbangleflip", obj_EDITORattacks, "hitboxes");
		}
		
		// EXTRA HITPAUSE
		initialize_struct_key(_hb, "HG_ANGLE_FLIPPER", 0);
		if _halfocused {
			rename_float_button("HitboxesPage2", "graphic_64F8D8F7", "text_404F66E6", _hb, "HG_ANGLE_FLIPPER", "hbextrahp", obj_EDITORattacks, "hitboxes");
		}
		_hb.HG_ANGLE_FLIPPER = floor(_hb.HG_ANGLE_FLIPPER);
		
		//GROUNDEDNESS
		initialize_struct_key(_hb, "HG_GROUNDEDNESS", 0);
		text_button_color("HitboxesPage2", "text_455B3219", real(_hb.HG_GROUNDEDNESS) == 0, c_white, c_aqua);
		text_button_color("HitboxesPage2", "text_7C403AE1", real(_hb.HG_GROUNDEDNESS) == 1, c_white, c_aqua);
		text_button_color("HitboxesPage2", "text_35B3FCC5", real(_hb.HG_GROUNDEDNESS) == 2, c_white, c_aqua);
		if _focused {
			button_change_var(_hb, "HG_GROUNDEDNESS", 0, "HitboxesPage2", "graphic_1166D4CE");
			button_change_var(_hb, "HG_GROUNDEDNESS", 1, "HitboxesPage2", "graphic_2F39FA1D");
			button_change_var(_hb, "HG_GROUNDEDNESS", 2, "HitboxesPage2", "graphic_782DD332");
		}
		
		// EXTRA CAM SHAKE
		initialize_struct_key(_hb, "HG_EXTRA_CAMERA_SHAKE", 0);
		text_button_color("HitboxesPage2", "text_7670CB5D", real(_hb.HG_EXTRA_CAMERA_SHAKE) == -1, c_white, c_aqua);
		text_button_color("HitboxesPage2", "text_138B9512", real(_hb.HG_EXTRA_CAMERA_SHAKE) == 0, c_white, c_aqua);
		text_button_color("HitboxesPage2", "text_37DAA22B", real(_hb.HG_EXTRA_CAMERA_SHAKE) == 1, c_white, c_aqua);
		if _focused {
			button_change_var(_hb, "HG_EXTRA_CAMERA_SHAKE", -1, "HitboxesPage2", "graphic_7F924F5C");
			button_change_var(_hb, "HG_EXTRA_CAMERA_SHAKE", 0, "HitboxesPage2", "graphic_46CB7BEC");
			button_change_var(_hb, "HG_EXTRA_CAMERA_SHAKE", 1, "HitboxesPage2", "graphic_7C2FE02E");
		}
		
		// BREAK PROJECTILES
		initialize_struct_key(_hb, "HG_IGNORES_PROJECTILES", 0);
		correct_value_bool(_hb, "HG_IGNORES_PROJECTILES");
		if _focused {
			button_boolean("HitboxesPage2", "graphic_3DD6C057", "text_39D019A3", _hb, "HG_IGNORES_PROJECTILES");
		}
		
		// HIT LOCKOUT
		initialize_struct_key(_hb, "HG_HIT_LOCKOUT", 0);
		correct_value_between(_hb, "HG_HIT_LOCKOUT", 0, infinity);
		if _halfocused {
			rename_int_button("HitboxesPage2", "graphic_13433922", "text_37016C5A", _hb, "HG_HIT_LOCKOUT", "hbhitlockout", obj_EDITORattacks, "hitboxes");
		}
		
		// PARRY STUN
		initialize_struct_key(_hb, "HG_EXTENDED_PARRY_STUN", 0);
		correct_value_between(_hb, "HG_EXTENDED_PARRY_STUN", 0, infinity);
		if _halfocused {
			rename_int_button("HitboxesPage2", "graphic_6DD49971", "text_8D25891", _hb, "HG_EXTENDED_PARRY_STUN", "hbparrystun", obj_EDITORattacks, "hitboxes");
		}
		
		// MULTIPLIERS
		initialize_struct_key(_hb, "HG_HITSTUN_MULTIPLIER", 0);
		initialize_struct_key(_hb, "HG_DRIFT_MULTIPLIER", 0);
		initialize_struct_key(_hb, "HG_SDI_MULTIPLIER", 0);
		if _halfocused {
			rename_float_button("HitboxesPage2", "graphic_7DABBCDA", "text_1B1638B9", _hb, "HG_HITSTUN_MULTIPLIER", "hbhsmult", obj_EDITORattacks, "hitboxes");
			rename_float_button("HitboxesPage2", "graphic_757F87D8", "text_427B4D9D", _hb, "HG_DRIFT_MULTIPLIER", "hbdriftmult", obj_EDITORattacks, "hitboxes");
			rename_float_button("HitboxesPage2", "graphic_680B803", "text_472DBBAF", _hb, "HG_SDI_MULTIPLIER", "hbsdimult", obj_EDITORattacks, "hitboxes");
		}
		
		// TECHABLE
		initialize_struct_key(_hb, "HG_TECHABLE", 0);
		text_button_color("HitboxesPage2", "text_799D3A69", real(_hb.HG_TECHABLE) == 0, c_white, c_aqua);
		text_button_color("HitboxesPage2", "text_54BB62C9", real(_hb.HG_TECHABLE) == 1, c_white, c_aqua);
		text_button_color("HitboxesPage2", "text_158F0CD6", real(_hb.HG_TECHABLE) == 2, c_white, c_aqua);
		text_button_color("HitboxesPage2", "text_5B30F30D", real(_hb.HG_TECHABLE) == 3, c_white, c_aqua);
		if _focused {
			button_change_var(_hb, "HG_TECHABLE", 0, "HitboxesPage2", "graphic_1CE290F1");
			button_change_var(_hb, "HG_TECHABLE", 1, "HitboxesPage2", "graphic_2AFC97B9");
			button_change_var(_hb, "HG_TECHABLE", 2, "HitboxesPage2", "graphic_3D6FBA5C");
			button_change_var(_hb, "HG_TECHABLE", 3, "HitboxesPage2", "graphic_29553A05");
		}
		
		// FORCE FLINCH
		initialize_struct_key(_hb, "HG_FORCE_FLINCH", 0);
		text_button_color("HitboxesPage2", "text_5D8D8493", real(_hb.HG_FORCE_FLINCH) == 0, c_white, c_aqua);
		text_button_color("HitboxesPage2", "text_70FA6E19", real(_hb.HG_FORCE_FLINCH) == 1, c_white, c_aqua);
		text_button_color("HitboxesPage2", "text_6D26E4D3", real(_hb.HG_FORCE_FLINCH) == 2, c_white, c_aqua);
		text_button_color("HitboxesPage2", "text_612EB804", real(_hb.HG_FORCE_FLINCH) == 3, c_white, c_aqua);
		if _focused {
			button_change_var(_hb, "HG_FORCE_FLINCH", 0, "HitboxesPage2", "graphic_62B90116");
			button_change_var(_hb, "HG_FORCE_FLINCH", 1, "HitboxesPage2", "graphic_4436662B");
			button_change_var(_hb, "HG_FORCE_FLINCH", 2, "HitboxesPage2", "graphic_24ED26C3");
			button_change_var(_hb, "HG_FORCE_FLINCH", 3, "HitboxesPage2", "graphic_64EBC1E5");
		}
		
		// FINAL KNOCKBACK  
		initialize_struct_key(_hb, "HG_FINAL_BASE_KNOCKBACK", 0);
		correct_value_between(_hb, "HG_FINAL_BASE_KNOCKBACK", 0, infinity);
		if _halfocused {
			rename_float_button("HitboxesPage2", "graphic_7DCEC3BD", "text_7930088E", _hb, "HG_FINAL_BASE_KNOCKBACK", "hbfinakb", obj_EDITORattacks, "hitboxes");
		}
		
		// ROCK INTERACTION
		initialize_struct_key(_hb, "HG_THROWS_ROCK", 0);
		text_button_color("HitboxesPage2", "text_7982D694", real(_hb.HG_THROWS_ROCK) == 0, c_white, c_aqua);
		text_button_color("HitboxesPage2", "text_2CC39069", real(_hb.HG_THROWS_ROCK) == 1, c_white, c_aqua);
		text_button_color("HitboxesPage2", "text_7A90BEAE", real(_hb.HG_THROWS_ROCK) == 2, c_white, c_aqua);
		if _focused {
			button_change_var(_hb, "HG_THROWS_ROCK", 0, "HitboxesPage2", "graphic_417D54DF");
			button_change_var(_hb, "HG_THROWS_ROCK", 1, "HitboxesPage2", "graphic_7A8DD4F4");
			button_change_var(_hb, "HG_THROWS_ROCK", 2, "HitboxesPage2", "graphic_5DD83F4F");
		}
		
		// PAGE BACKWARDS
		if mouse_in_uibox("HitboxesPage2", "graphic_703DCD32", cr_handpoint, true) {
			page = 1;
		}
	} else if _page = 3 {
		
		// PROJ. SPRITE
		initialize_struct_key(_hb, "HG_PROJECTILE_SPRITE", 0);
		if _focused and mouse_in_uibox("HitboxesPage3", "graphic_31A13EC5", cr_handpoint, true) {
			initialize_sprite_selector(false, "", "HbProjSpr", obj_EDITORattacks);
		}
		layer_text_text(get_ui_id("HitboxesPage3", "text_7FDE7B3B", false), get_quoted_text(_hb.HG_PROJECTILE_SPRITE));
		
		// PROJ. COLLISION SPRITE
		initialize_struct_key(_hb, "HG_PROJECTILE_MASK", -1);
		if _focused and mouse_in_uibox("HitboxesPage3", "graphic_3090658F", cr_handpoint, true) {
			initialize_sprite_selector(true, "", "HbProjMask", obj_EDITORattacks);
		}
		layer_text_text(get_ui_id("HitboxesPage3", "text_41A60406", false), get_quoted_text(_hb.HG_PROJECTILE_MASK));
		
		// PROJ. COLLISION TERRAIN SPRITE
		initialize_struct_key(_hb, "HG_PROJECTILE_COLLISION_SPRITE", 0);
		if _focused and mouse_in_uibox("HitboxesPage3", "graphic_301AE38E", cr_handpoint, true) {
			initialize_sprite_selector(true, "", "HbProjTerr", obj_EDITORattacks);
		}
		layer_text_text(get_ui_id("HitboxesPage3", "text_48BB6B00", false), get_quoted_text(_hb.HG_PROJECTILE_COLLISION_SPRITE));
		
		// ANIM SPEED
		initialize_struct_key(_hb, "HG_PROJECTILE_ANIM_SPEED", 0);
		correct_value_between(_hb, "HG_PROJECTILE_ANIM_SPEED", 0, infinity);
		if _halfocused {
			rename_float_button("HitboxesPage3", "graphic_7790F534", "text_5F273190", _hb, "HG_PROJECTILE_ANIM_SPEED", "hbanispeed", obj_EDITORattacks, "hitboxes");
		}
		
		// INITIAL SPEED
		initialize_struct_key(_hb, "HG_PROJECTILE_HSPEED", 0);
		initialize_struct_key(_hb, "HG_PROJECTILE_VSPEED", 0);
		initialize_struct_key(_hb, "HG_PROJECTILE_GRAVITY", 0);
		if _halfocused {
			rename_float_button("HitboxesPage3", "graphic_254AEA4F", "text_11BF7F5C", _hb, "HG_PROJECTILE_HSPEED", "hbhspeed", obj_EDITORattacks, "hitboxes");
			rename_float_button("HitboxesPage3", "graphic_3ED33F15", "text_44FAF391", _hb, "HG_PROJECTILE_VSPEED", "hbvspeed", obj_EDITORattacks, "hitboxes");
			rename_float_button("HitboxesPage3", "graphic_78EABF01", "text_5D834189", _hb, "HG_PROJECTILE_GRAVITY", "hbgspeed", obj_EDITORattacks, "hitboxes");
		}
		
		// FRICTION
		initialize_struct_key(_hb, "HG_PROJECTILE_GROUND_FRICTION", 0);
		initialize_struct_key(_hb, "HG_PROJECTILE_AIR_FRICTION", 0);
		if _halfocused {
			rename_float_button("HitboxesPage3", "graphic_4C8EF80A", "text_76BD5743", _hb, "HG_PROJECTILE_GROUND_FRICTION", "hbFRICTG", obj_EDITORattacks, "hitboxes");
			rename_float_button("HitboxesPage3", "graphic_48E4D709", "text_28265F5D", _hb, "HG_PROJECTILE_AIR_FRICTION", "hbfricta", obj_EDITORattacks, "hitboxes");
		}
		
		// PROJ HIT WALL
		initialize_struct_key(_hb, "HG_PROJECTILE_WALL_BEHAVIOR", 0);
		text_button_color("HitboxesPage3", "text_1D55086E", real(_hb.HG_PROJECTILE_WALL_BEHAVIOR) == 0, c_white, c_aqua);
		text_button_color("HitboxesPage3", "text_694E1279", real(_hb.HG_PROJECTILE_WALL_BEHAVIOR) == 1, c_white, c_aqua);
		text_button_color("HitboxesPage3", "text_36153D7B", real(_hb.HG_PROJECTILE_WALL_BEHAVIOR) == 2, c_white, c_aqua);
		if _focused {
			button_change_var(_hb, "HG_PROJECTILE_WALL_BEHAVIOR", 0, "HitboxesPage3", "graphic_4B407C9B");
			button_change_var(_hb, "HG_PROJECTILE_WALL_BEHAVIOR", 1, "HitboxesPage3", "graphic_39860F1B");
			button_change_var(_hb, "HG_PROJECTILE_WALL_BEHAVIOR", 2, "HitboxesPage3", "graphic_2BD2D4B4");
		}
		
		// PROJ HIT GROUND
		initialize_struct_key(_hb, "HG_PROJECTILE_GROUND_BEHAVIOR", 0);
		text_button_color("HitboxesPage3", "text_90EAC89", real(_hb.HG_PROJECTILE_GROUND_BEHAVIOR) == 0, c_white, c_aqua);
		text_button_color("HitboxesPage3", "text_5E4A06E0", real(_hb.HG_PROJECTILE_GROUND_BEHAVIOR) == 1, c_white, c_aqua);
		text_button_color("HitboxesPage3", "text_77124EFC", real(_hb.HG_PROJECTILE_GROUND_BEHAVIOR) == 2, c_white, c_aqua);
		if _focused {
			button_change_var(_hb, "HG_PROJECTILE_GROUND_BEHAVIOR", 0, "HitboxesPage3", "graphic_1AC98708");
			button_change_var(_hb, "HG_PROJECTILE_GROUND_BEHAVIOR", 1, "HitboxesPage3", "graphic_4FAB166F");
			button_change_var(_hb, "HG_PROJECTILE_GROUND_BEHAVIOR", 2, "HitboxesPage3", "graphic_756D3A0B");
		}
		
		// PIERCING ENEMIES
		initialize_struct_key(_hb, "HG_PROJECTILE_ENEMY_BEHAVIOR", 0);
		correct_value_bool(_hb, "HG_PROJECTILE_ENEMY_BEHAVIOR");
		if _focused {
			button_boolean("HitboxesPage3", "graphic_A8C149B", "text_761E504", _hb, "HG_PROJECTILE_ENEMY_BEHAVIOR");
		}
		
		// UNBASHABLE
		initialize_struct_key(_hb, "HG_PROJECTILE_UNBASHABLE", 0);
		correct_value_bool(_hb, "HG_PROJECTILE_UNBASHABLE");
		if _focused {
			button_boolean("HitboxesPage3", "graphic_25B19287", "text_50A8F29D", _hb, "HG_PROJECTILE_UNBASHABLE");
		}
		
		// PARRY STUN
		initialize_struct_key(_hb, "HG_PROJECTILE_PARRY_STUN", 0);
		initialize_struct_key(_hb, "HG_PROJECTILE_DOES_NOT_REFLECT", 0);
		correct_value_bool(_hb, "HG_PROJECTILE_PARRY_STUN");
		correct_value_bool(_hb, "HG_PROJECTILE_DOES_NOT_REFLECT");
		if _focused {
			button_boolean("HitboxesPage3", "graphic_102C335", "text_748A9645", _hb, "HG_PROJECTILE_PARRY_STUN");
			button_boolean("HitboxesPage3", "graphic_6BA92F2A", "text_1077688A", _hb, "HG_PROJECTILE_DOES_NOT_REFLECT");
		}
		
		// TRANS(RIGHTS)CENDENT																			h..what about their lefts?
		initialize_struct_key(_hb, "HG_PROJECTILE_IS_TRANSCENDENT", 0);
		correct_value_bool(_hb, "HG_PROJECTILE_IS_TRANSCENDENT");
		if _focused {
			button_boolean("HitboxesPage3", "graphic_7AF676BE", "text_D8B10E1", _hb, "HG_PROJECTILE_IS_TRANSCENDENT");
		}
		
		// DESTROY EFFECTS
		initialize_struct_key(_hb, "HG_PROJECTILE_DESTROY_EFFECT", 1);
		if _focused and mouse_in_uibox("HitboxesPage3", "graphic_7902CEF6", cr_handpoint, true) {
			initialize_vfx_selector(true, 1, "VFXdestroy", obj_EDITORattacks);
		}
		layer_text_text(get_ui_id("HitboxesPage3", "text_751594AE", false), _hb.HG_PROJECTILE_DESTROY_EFFECT);
		
		// PLASMA SAFE
		initialize_struct_key(_hb, "HG_PROJECTILE_PLASMA_SAFE", 0);
		correct_value_bool(_hb, "HG_PROJECTILE_PLASMA_SAFE");
		if _focused {
			button_boolean("HitboxesPage3", "graphic_25509142", "text_7B0EE61E", _hb, "HG_PROJECTILE_PLASMA_SAFE");
		}
		
		// PAGE BACK
		if mouse_in_uibox("HitboxesPage3", "graphic_37296141", cr_handpoint, true) {
			page = 1;
		}
	}
}

function inherit_stat(_stat, _son, _dad, _default) {
	initialize_struct_key(_son, _stat, _default);
	initialize_struct_key(_dad, _stat, _default);
	_son[$ _stat] = _dad[$ _stat];
}