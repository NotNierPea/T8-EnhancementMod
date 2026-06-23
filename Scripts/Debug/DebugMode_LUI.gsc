ConvertNumToLUI(num)
{
    return Int(num * 100);
}

add_new_objective(objective, str_waittill)
{
	self endon(#"death");

	self.n_obj_id = gameobjects::get_next_obj_id();
	if (Objective_State(self.n_obj_id) == "empty") {
		//ShieldLog("Registering Objective ID: " + self.n_obj_id);
		Objective_Add(self.n_obj_id, "active", self, objective);
	}
	else {
		//ShieldLog("Re-configuring Objective ID: " + self.n_obj_id);
		Objective_OnEntity(self.n_obj_id, self);
		Objective_SetState(self.n_obj_id, "active");
	}
	function_da7940a3(self.n_obj_id, 1);
	self thread release_obj_on_death_v(str_waittill);
}

release_obj_on_death_v(str_waittill = #"nothing")
{
    self util::waittill_any_ents(self, "death", level, "release_objs", self, str_waittill);

	if (isDefined(self))
	{
		n_obj_id = self.n_obj_id;

		//ShieldLog("Releasing Objective ID: " + n_obj_id);
		gameobjects::release_obj_id(n_obj_id);
		Objective_SetState(n_obj_id, "invisible");

		arrayremovevalue(level.VultureObjects, self);

		self.n_obj_id = undefined;
	}
}

CustomObjectiveTest()
{
    level.GumMachine add_new_objective(#"enh_objective", "death");
}

TestShit()
{
	e_powerup = zm_powerups::specific_powerup_drop("bonfire_sale", self.origin, undefined, 0.1, self, 0, 1, 1);
}

RocketGun()
{
	self endon(#"death", #"stop_rocket_gun");

	self.rocket_gun = true;

	self iPrintLnBold("rocket_gun ^2on");

	while(getDvarInt(#"enh_rocket_gun", 0))
	{
		self waittill(#"weapon_fired");
		MagicBullet(getWeapon("launcher_standard_t8_upgraded"), self getPlayerCameraPos(), BulletTrace(self getPlayerCameraPos(), self getPlayerCameraPos() + anglesToForward(self getPlayerAngles())  * 100000, false, self)["position"], self);
		wait 0.001;
	}

	self.rocket_gun = undefined;
}

GodModePlayer()
{
	self endon(#"death");

	self iPrintLnBold("godmode ^2on");

	while(isDefined(self.godmode_s))
	{
		self enableInvulnerability();
		wait 0.15;
	}

	self iPrintLnBold("godmode ^1off");

	self disableInvulnerability();
}

// ate's
ANoclipBind() {
    self endon(#"spawned_player", #"disconnect", #"bled_out");
    level endon(#"end_game", #"game_ended");
    self notify(#"stop_player_out_of_playable_area_monitor");
	self unlink();
    if(isdefined(self.originObj)) self.originObj delete();
    ts = 0;

    self.noclip_s = false;

	while(true) {
		if(self.noclip_s) {
			self.originObj = spawn("script_origin", self.origin, 1);
    		self.originObj.angles = self.angles;
			self PlayerLinkTo(self.originObj, undefined);
			self enableweapons();

			while(true) {
				if(!self.noclip_s) {
					self iPrintLnBold("^6Fly mode ^1disabled");
					break;
				}
				if (isdefined(self.originObj.future_tp)) {
					self.originObj.origin = self.originObj.future_tp;
					self.originObj.future_tp = undefined;
					waitframe(1);
					continue;
				}
				
                nts = GetTime();
                if (nts > ts) {
                    ts = nts + 25000; // add 25s
                    self iPrintLnBold("^6Fly mode ^2enabled");
                    self iPrintLnBold("^5" + "[{+sprint}]" + "^6: fly, ^5" + "[{+gostand}]" + "^6: up, ^5" + "[{+stance}]" + "^6: down");
                }

				if(self sprintbuttonpressed()) {
					fly_speed = 60;
				} else {
					fly_speed = 20;
				}

				player_angles = self getPlayerAngles();

				// I'm too tired to remember my vector courses
				front_vector = AnglesToForward(player_angles);
				left_vector = AnglesToForward(player_angles - (0, 90, 0));
				top_vector = AnglesToForward(player_angles - (90, 0, 0));

				v_movement = self getNormalizedMovement();

				if (self jumpbuttonpressed()) {
					z_movement = 1;
				} else if (self stancebuttonpressed()) {
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
				originpos = self.origin + move_vector_scaled;
				self.originObj.origin = originpos;
				waitframe(1);
			}
			self unlink();
			if(isdefined(self.originObj)) self.originObj delete();
			waitframe(1);
		}
		waitframe(1);
	}
}

RegisterDebugCmds()
{
	// for achivs
	level.IsUsingDebugLUI = true;

	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/godmode/on\" \"set enh_godmode 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/godmode/off\" \"set enh_godmode 0\"\n");

	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/godmode_all/on\" \"set enh_godmode_all 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/godmode_all/off\" \"set enh_godmode_all 0\"\n");

	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/rocket_gun/on\" \"set enh_rocket_gun 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/rocket_gun/off\" \"set enh_rocket_gun 0\"\n");

	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/noclip/on\" \"set enh_noclip 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/noclip/off\" \"set enh_noclip 0\"\n");

	for (i = 1; i <= 150; i++)
		adddebugcommand("devgui_cmd \"enh_dev_gsc/round/skip/" + i + "\" \"set enh_skip_round " + i + "\"\n");

	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/score/+500\" \"set enh_score_player 500\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/score/-500\" \"set enh_score_player -500\"\n");

	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/test_func/on\" \"set enh_test 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/test_func/off\" \"set enh_test 0\"\n");

	adddebugcommand("devgui_cmd \"enh_dev_gsc/game/timescale_speed/1x\" \"set enh_timescale_speed 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/game/timescale_speed/2x\" \"set enh_timescale_speed 2\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/game/timescale_speed/5x\" \"set enh_timescale_speed 5\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/game/timescale_speed/10x\" \"set enh_timescale_speed 10\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/game/timescale_speed/0x\" \"set enh_timescale_speed 0\"\n");

	thread LoopDvars();
}

LoopDvars()
{
	while(true)
	{
		godmode_all = undefined;
		godmode = undefined;
		rocket_gun = undefined;
		noclip = undefined;
		test = undefined;
		skip_round = undefined;
		score_player = undefined;
		Host_Player = undefined;

		Host_Player = GetPlayers()[0];

		if (isDefined(Host_Player))
		{
			if (!isDefined(Host_Player.noclip_s))
			{
				Host_Player thread ANoclipBind();
			}

			godmode = getDvarInt(#"enh_godmode", 0);

			if (godmode && !isDefined(Host_Player.godmode_s))
			{
				Host_Player.godmode_s = true;
				Host_Player thread GodModePlayer();
			}
			else if (!godmode)
			{
				Host_Player.godmode_s = undefined;
			}

			godmode_all = getDvarInt(#"enh_godmode_all", 0);

			if (godmode_all)
			{
				foreach(player in level.players)
				{
					if (!isDefined(player.godmode_s) && player != Host_Player)
					{
						player.godmode_s = true;
						player thread GodModePlayer();
					}
				}
			}
			else if (!godmode_all)
			{
				foreach(player in level.players)
					if (isDefined(player.godmode_s) && player != Host_Player)
						player.godmode_s = undefined;
			}

			rocket_gun = getDvarInt(#"enh_rocket_gun", 0);

			if (rocket_gun && !isDefined(Host_Player.rocket_gun))
			{
				Host_Player thread RocketGun();
			}
			else if (!rocket_gun)
			{
				Host_Player notify(#"stop_rocket_gun");
				Host_Player.rocket_gun = undefined;
			}

			noclip = getDvarInt(#"enh_noclip", 0);

			if (noclip)
			{
				Host_Player.noclip_s = true;
			}
			else
			{
				Host_Player.noclip_s = false;
			}

			test = getDvarInt(#"enh_test", 0);

			if (test)
			{
				Host_Player thread TestShit();
				setDvar(#"enh_test", 0);
			}

			speed_game = getDvarInt(#"enh_timescale_speed", 1);
			setslowmotion(1, speed_game, 0);

			skip_round = getDvarInt(#"enh_skip_round", 0);

			if (skip_round > 0)
			{
				level thread zm_utility::zombie_goto_round(skip_round);
        		level thread zm_game_module::zombie_goto_round(skip_round);

				setDvar(#"enh_skip_round", 0);
			}

			score_player = getDvarInt(#"enh_score_player", 0);

			if (score_player != 0)
			{
				foreach(player in level.players) player zm_score::add_to_player_score(score_player);

				setDvar(#"enh_score_player", 0);
			}
		}

		wait 0.15;
	}
}

DebugMode()
{
    level endon(#"end_game", #"game_ended");
    
    if (!GetDvarInt(#"shield_enh_lui_debug", 0))
        return;

    ShieldLog("^6Debug LUI Init");

    // if you dont wait for black screen loading and start luinotify early, you fucking crash the server.
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

	thread RegisterDebugCmds();
    wait 10;

	Host_Player = GetPlayers()[0];

	Host_Player endon(#"death");

    while(true)
    {
		pos = undefined;
		vel = undefined;
		angles = undefined;
		health = undefined;
		isGrounded = undefined;

        if (!isDefined(Host_Player))
        {
            wait 1;
        
            Host_Player = GetPlayers()[0];
            continue;
        }

        // position, args -> isfloat (2 if vector), type, args
        pos = Host_Player.origin;
        Host_Player LUINotifyEvent(#"enhancement_debug_info", 5, 2, 0, ConvertNumToLUI(pos[0]), ConvertNumToLUI(pos[1]), ConvertNumToLUI(pos[2]));

        // velocity
        vel = Host_Player GetVelocity();
        Host_Player LUINotifyEvent(#"enhancement_debug_info", 5, 2, 1, ConvertNumToLUI(vel[0]), ConvertNumToLUI(vel[1]), ConvertNumToLUI(vel[2]));

        // angles (FIXED for player)
        angles = Host_Player.angles;
        Host_Player LUINotifyEvent(#"enhancement_debug_info", 5, 2, 2, ConvertNumToLUI(angles[0]), ConvertNumToLUI(angles[1]), ConvertNumToLUI(angles[2]));

        // health
        health = Host_Player.health;
        Host_Player LUINotifyEvent(#"enhancement_debug_info", 5, 1, 3, ConvertNumToLUI(health), 0, 0);

        // grounded
        isGrounded = Host_Player IsOnGround() ? 1 : 0;
        Host_Player LUINotifyEvent(#"enhancement_debug_info", 5, 1, 4, ConvertNumToLUI(isGrounded), 0, 0);

        if(Host_Player AdsButtonPressed() && Host_Player useButtonPressed())
		{
            ShieldLog("-------------------------");
			ShieldLog("Debug Info:\nPOS: " + pos + "\nVEL: " + vel + "\nANG: " + angles + "\nHP: " + health + "\nGP: " + isGrounded);
            ShieldLog("-------------------------");

            Host_Player LUINotifyEvent(#"enhancement_debug_info", 1, 4);
		}
        else
            Host_Player LUINotifyEvent(#"enhancement_debug_info", 1, 3);

        util::wait_network_frame(1);
    }
}