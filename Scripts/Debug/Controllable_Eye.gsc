// What the hell is the point of this shit?

SpawnEyeLooking(Cords, Angles) // move already "spawned" eye
{
    level.e_boss.origin = Cords;
    level.e_boss.angles = Angles;

    level.e_boss [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_500cb0be ]](#"hash_678aaf8e37498e9a", #"p8_fxanim_zm_zod_eye_01_bundle");
    level.e_boss [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_arrive ]]();

    level.e_boss animation::stop(0);
    level.e_boss thread scene::play(level.e_boss.str_scene, level.e_boss.str_idle, level.e_boss); // idle anim

	return level.e_boss;
}

SpawnEyeCustom(Cords, Angles) // custom one
{
    CustomEye = util::spawn_model(#"tag_origin", Cords, Angles);
    CustomEye enablelinkto();
    CustomEye notsolid();
    CustomEye hide();

    CustomEye.e_damage = util::spawn_model(#"tag_origin", Cords, Angles);
    CustomEye.e_damage.takedamage = 1;
    CustomEye.e_damage function_2baad8fc(); // engine func hashed
    CustomEye.e_damage.var_6f84b820 = #"boss";
    CustomEye.e_damage enablelinkto();
    CustomEye.e_damage linkto(CustomEye);
    CustomEye.e_damage notsolid();

    CustomEye.var_451ab1a6 = 0;

    CustomEye.origin = Cords;
    CustomEye.angles = Angles;

	if (!isdefined(level.Custom_Eyes))
		level.Custom_Eyes = [];
    	level.Custom_Eyes[level.Custom_Eyes.size] = CustomEye;

    // unmatching types if not!
    CustomEye.str_scene = #"p8_fxanim_zm_zod_eye_01_bundle"; // for the debug func
    CustomEye.var_6efcc8c1 = 0;
    CustomEye.var_18acfe18 = 0;
    CustomEye.var_57badb98 = 0;
    CustomEye.var_914750d = 0; // causes issues with bm attack..
    CustomEye.var_c962047c = -1;
    CustomEye.var_59cdb7b9 = 49000; // normal att
    CustomEye.var_f881e30f = 52000; // wipe
    CustomEye.var_ba36376c = 5 * 16500;
    CustomEye.var_7954bf70 = 5 * 19000;
    CustomEye.var_6a30a892 = 8 * 40000 / 4;

    // setmodel and clientfields here
    CustomEye [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_500cb0be ]](#"hash_678aaf8e37498e9a", #"p8_fxanim_zm_zod_eye_01_bundle");

    // this func is used for defining messing vars, probably debug
    CustomEye thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_5e792125 ]]();

    CustomEye thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_71f63a19 ]]("pd"); // first phase areas for attack
    CustomEye thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_1b11b43 ]]("pd"); // other ones needed (array of locations)
    CustomEye thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_a55a0339 ]]("pd");

    array_nothing = [];
    CustomEye thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_bb612e31 ]](array_nothing, 0, -1);

    CustomEye [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_arrive ]]();
    CustomEye show();
    CustomEye animation::stop(0);
    CustomEye thread scene::play(CustomEye.str_scene, CustomEye.str_idle, CustomEye); // idle anim
}

ControlTrackLaserBeam(player)
{
	player endon(#"death");
    self endon(#"death", #"stop_track_beam");

    while (true) {
        v_source = self gettagorigin("tag_fx_beam");
        v_target = level.var_90bda347.origin;
        a_beamtrace = beamtrace(v_source, v_target, 0, self, 1, 1);
        distance = distance(v_source, a_beamtrace[#"position"]);
        tag_array = [];
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_helmet";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_head";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_neck";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_spine_upper";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_spine_lower";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_shoulder_le";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_shoulder_ri";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_spine4";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "tag_aim";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_elbow_le";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_elbow_ri";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_wrist_le";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_wrist_ri";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_hiptwist_le";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_hiptwist_ri";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_knee_bulge_le";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_knee_bulge_ri";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_ankle_le";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_ankle_ri";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_ball_le";
        if (!isdefined(tag_array)) {
            tag_array = [];
        } else if (!isarray(tag_array)) {
            tag_array = array(tag_array);
        }
        tag_array[tag_array.size] = "j_ball_ri";
        zombies_array = [];
		active_zombies = zombie_utility::get_zombie_array();
        foreach (zombie in active_zombies) {
			var_7cb315bb = zombie getcentroid();
			v_zombie_origin = zombie getorigin();
			var_67b0f6b1 = distancesquared(v_source, var_7cb315bb);
			var_cf64e11c = distancesquared(v_source, v_zombie_origin);
			var_3c71dedb = pointonsegmentnearesttopoint(v_source, v_target, var_7cb315bb);
			var_c526df5a = pointonsegmentnearesttopoint(v_source, v_target, v_zombie_origin);
			b_is_valid_target = 0;
			if (distancesquared(var_7cb315bb, var_3c71dedb) <= 324 || distancesquared(v_zombie_origin, var_c526df5a) <= 324) {
				b_is_valid_target = 1;
			} else {
				foreach (str_tag in tag_array) {
					v_hitloc = zombie gettagorigin(str_tag);
					if (isdefined(v_hitloc)) {
						var_4d9e2def = pointonsegmentnearesttopoint(v_source, v_target, v_hitloc);
						temp_dist = distancesquared(v_hitloc, var_4d9e2def);
						if (distancesquared(v_hitloc, var_4d9e2def) <= 324) {
							b_is_valid_target = 1;
							break;
						}
					}
				}
			}
            if (isdefined(b_is_valid_target) && b_is_valid_target) {
                if (!isdefined(zombies_array)) {
                    zombies_array = [];
                } else if (!isarray(zombies_array)) {
                    zombies_array = array(zombies_array);
                }
                zombies_array[zombies_array.size] = zombie;
            }
        }
        if (zombies_array.size > 0) {
            foreach (zombie in zombies_array) {
                if (isdefined(zombie)) {
                    zombie doDamage(85, zombie.origin, player);
                }
            }
        }
        util::wait_network_frame();
    }
}

ControlCheckStop(player)
{
	player endon(#"death");
	self endon(#"death", #"stop_track_beam");
	
	while(true)
	{
		if (player AttackButtonPressed())
		{
			self.stop_attack = true;
			self notify(#"stop_track_beam");
			break;
		}

		waitframe(1);
	}
}

ControlEyeEffectLogic(idx_effect, player)
{
	self endon(#"death");
	player iPrintLn("going for effect " + idx_effect);

	switch(idx_effect)
	{
		case 0:
		self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_500cb0be ]](#"hash_678aaf8e37498e9a", #"p8_fxanim_zm_zod_eye_01_bundle");
		break;

		case 1:
		self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_500cb0be ]](#"hash_32a51dafb1c7344f", #"p8_fxanim_zm_zod_eye_02_bundle");
		break;

		case 2:
		self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_500cb0be ]](#"hash_597bdc83a7c9e8c", #"p8_fxanim_zm_zod_eye_03_bundle");
		break;
	}

	// re-apply crack effects
	ControlEyeEffectCrackLogic(self.idx_crack_effect, player);
}

ControlEyeEffectCrackLogic(idx_crack_effect, player)
{
	self endon(#"death");
	player iPrintLn("going for crack effect " + idx_crack_effect);

	switch(idx_crack_effect)
	{
		case 0:
		self.var_914750d = 0;
		self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_500cb0be ]](self.mdl_base, self.str_scene);
		break;

		case 1:
		self.var_914750d = 1;
		self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_3d8879d7 ]]("crack");
		break;

		case 2:
		self.var_914750d = 2;
		self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_3d8879d7 ]]("break");
		break;
	}
}

ControlEyeAttackLogic(attack_id, player)
{
	// TODO: add more attacks maybe?
	self endon(#"death");
	player iPrintLn("going for attack " + attack_id);

	switch(attack_id)
	{
		case 0:
		self playSound(#"hash_1b108a99d8b8a77e");

		// beam laser logic
		v_loc = player.origin + anglestoforward(player getplayerangles()) * 20000;
		tag = self gettagorigin("tag_fx_beam");
		tagangles = vectortoangles(v_loc - self.origin);
		v_forward = anglestoforward(tagangles);
		a_trace = beamtrace(tag, tag + v_forward * 20000, 0, self, 1, 1);
		pos = a_trace[#"position"];

		level [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_3413fdf9 ]](pos);

		wait 0.15;

		self thread scene::play(self.str_scene, "charge", self);

		self clientfield::set("bs_att_bm_cf", 1);
		wait(1);
		self clientfield::set("bs_att_bm_tell_cf", 1);
		wait(0.4);
		self clientfield::set("bs_att_bm_tell_fx_cf", 1);
		wait(0.1);
		self clientfield::set("bs_att_bm_tell_cf", 2);

		self thread ControlTrackLaserBeam(player);
		self thread ControlCheckStop(player);

		// set cam
		SetDvar(#"shield_enh_eye_camera_height", 100.0);
		SetDvar(#"shield_enh_eye_camera_range", -100.0);

		n_time = randomIntRange(60, 90);
		//n_time = 99999999; // debug
		for (i = 1; i < n_time; i++) {
			if (isdefined(player) && isdefined(player.angles) && !isdefined(self.stop_attack)) {
				forward = player.origin + anglestoforward(player getplayerangles()) * 20000;
				level [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_3413fdf9 ]](forward, 0.25);
			} else {
				self.stop_attack = undefined;
				break;
			}
		}

		// stop anim
		self clientfield::set("bs_att_bm_tell_fx_cf", 0);
		self clientfield::set("bs_att_bm_cf", 0);
		self clientfield::set("bs_att_mst_tell_cf", 0);
		self animation::stop(0);

		self notify(#"stop_track_beam");
		self.stop_attack = undefined;

		// set cam back
		SetDvar(#"shield_enh_eye_camera_height", -50.0);
		SetDvar(#"shield_enh_eye_camera_range", 350.0);

		wait 0.25;
		level.var_90bda347 delete(); // beam in csc
		break;

		case 1:
		// wipe logic
		self clientfield::set("bs_att_blst_tll", 1);
		self playsound("zmb_eyeball_swrath_charge");
		self thread scene::play(self.str_scene, "charge_blast", self);

		n_time_started = gettime() / 1000;
		n_time_elapsed = 0;
		while (n_time_elapsed < 9)
		{
			n_time_current = gettime() / 1000;
			n_time_elapsed = n_time_current - n_time_started;
			util::wait_network_frame();
			n_time_left = 15 - n_time_elapsed;
			
			if (n_time_left <= 3)
			{
				// VO
				//function_abbfbdff( level.var_c7daa370 );
				continue;
			}
		}

		self clientfield::set("bs_att_blst", 1);
		level thread lui::screen_flash(0.1, 0.3, 0.7, 0.5, "white");
		self clientfield::set("bs_att_blst_tll", 0);
		self playsound("zmb_eyeball_swrath_burst");

		b_bool_vo = false;
		foreach (player_a in level.players)
		{
			if ((!(isdefined(player_a.hasriotshieldequipped) && player_a.hasriotshieldequipped)) && player_a != player) // eye controller check !!
			{
				player_a dodamage(player_a.health + 666, player_a.origin);
				continue;
			}
			
			if (!b_bool_vo)
			{
				if (isdefined(player_a))
				{
					// VO
					//player_a function_abbfbdff(level.var_ad9b527b);
					b_bool_vo = true;
				}
			}
		}

		zm_powerup_nuke::grab_nuke(getplayers()[0]);

		wait 1;
		self clientfield::set("bs_att_blst", 0);
		break;
	}
}

ControlEyeHideShowLogic(player)
{
	self endon(#"death");

	if (self.hidden)
	{
		self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_arrive ]]();
		player iPrintLn("show");
		self.hidden = false;
	}
	else
	{
		self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_leave ]]();
		player iPrintLn("hide");
		self.hidden = true;
	}
}

ControlEyeLogic(player)
{
	// self -> eye
	level endon(#"end_game");

	player LUINotifyEvent(#"notify_custom_portrait", 1, 1);
	player disableWeapons();
	player SetClientThirdPerson(true);

	n_target = 500;
	player.var_66cb03ad = n_target;
	player setmaxhealth(player.var_66cb03ad);
	player zm_utility::set_max_health();

	// camera (IN CSC!)
	SetDvar(#"shield_enh_eye_camera_height", -50.0);
	SetDvar(#"shield_enh_eye_camera_range", 350.0);
	self.idx_effect = 0;
	self.idx_crack_effect = 0;
	self.hidden = false;
	self.anim_stopped = true;
	
	player.originObj = spawn("script_origin", player.origin, 1);
    player.originObj.angles = player.angles;
	player playerLinkTo(player.originObj);
	player hide();
	player setclientuivisibilityflag("weapon_hud_visible", 0);
	while(true)
	{
		if (player AdsButtonPressed() && !self.hidden)
		{
			if (self.anim_stopped)
			{
				self thread scene::play(level.e_boss.str_scene, level.e_boss.str_idle, level.e_boss);
				self.anim_stopped = false;
			}

			wait 0.25;
			continue;
		}

		if (player AttackButtonPressed() && !self.hidden)
		{
			self animation::stop(0);
			self ControlEyeAttackLogic(0, player);
		}

		if (player ChangeseatButtonPressed() && !self.hidden)
		{
			self animation::stop(0);
			self ControlEyeAttackLogic(1, player);
		}

		if (player fragButtonPressed() && !self.hidden)
		{
			self.idx_effect++;
			if (self.idx_effect >= 3)
				self.idx_effect = 0;

			self animation::stop(0);
			self ControlEyeEffectLogic(self.idx_effect, player);
		}

		if (player OffhandSpecialButtonPressed() && !self.hidden)
		{
			self.idx_crack_effect++;
			if (self.idx_crack_effect >= 3)
				self.idx_crack_effect = 0;

			self animation::stop(0);
			self ControlEyeEffectCrackLogic(self.idx_crack_effect, player);
		}

		if (player MeleeButtonPressed())
		{
			self animation::stop(0);
			self ControlEyeHideShowLogic(player);
			self animation::stop(0);
		}

		self animation::stop(0);
		self.anim_stopped = true;

		// this is mostly ate's noclip code
		if(player sprintbuttonpressed()) {
			fly_speed = 60;
		} else {
			fly_speed = 20;
		}

		player_angles = player getPlayerAngles();

		// vector courses!
		front_vector = AnglesToForward(player_angles);
		left_vector = AnglesToForward(player_angles - (0, 90, 0));
		top_vector = AnglesToForward(player_angles - (90, 0, 0));

		v_movement = player getNormalizedMovement();

		if (player jumpbuttonpressed()) {
			z_movement = 1;
		} else if (player stancebuttonpressed()) {
			z_movement = -1;
		} else {
			z_movement = 0;
		}

		move_vector = 
			// add z angle
				z_movement * top_vector 
			// add front movement
			+ front_vector * v_movement[0] 
			// remove left/right z vector part because it was weird
			+ (left_vector[0], left_vector[1], 0) * v_movement[1];
		
		move_vector_scaled = vectorScale(move_vector, fly_speed);
		originpos = player.origin + move_vector_scaled;
		self.origin = originpos;
		self.angles = player_angles;
		player.originObj.origin = originpos;
		waitframe(1);
	}

	if (isdefined(player))
		player LUINotifyEvent(#"notify_custom_portrait", 1, 0);
}

InitControllableEye()
{
	iPrintLn("eye control init");

	player = GetPlayers()[0];
	origin_to_use = player.origin + (0, 0, 500);
	Eye = SpawnEyeLooking(origin_to_use, player.angles);
	player setOrigin(origin_to_use);
	Eye ControlEyeLogic(player);
}