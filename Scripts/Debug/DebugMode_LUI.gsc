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

Debug_OpenDoors()
{
	player = getplayers()[0];
	if (!isdefined(player))
		return;

	doors = getentarray("zombie_door", "targetname");
	doors = arraycombine(doors, getentarray("zombie_debris", "targetname"), 0, 0);
	doors = arraycombine(doors, getentarray("zombie_airlock_buy", "targetname"), 0, 0);
	foreach (door in doors)
		door notify(#"trigger", {#activator:player, #is_forced:1});

	ShieldLog("^2Debug: opened doors");
	player iPrintLnBold("^2Doors opened");
}

Debug_PowerOn()
{
	level flag::set("power_on");
	level flag::set("power_on1");
	level flag::set("power_on2");
	level flag::set("power_on3");
	level flag::set("pap_machine_active");
	level flag::set("pap_power_ready");
	level flag::set(#"pap_quest_completed");
	level flag::set(#"zm_towers_pap_quest_completed");
	ShieldLog("^2Debug: power/PAP flags set");
	if (isdefined(getplayers()[0]))
		getplayers()[0] iPrintLnBold("^2Power on");
}

Debug_FreeSkipClean(b_skipped, ended_early)
{
	level notify(#"free_skip_clean");
	return;
}

Debug_OverrideQuest(quest_name, step_name, setup_func, cleanup_func = undefined)
{
	while (!IsDefined(level._ee))
		waitframe(1);
	while (!isdefined(level._ee[quest_name]))
		waitframe(1);

	ee = level._ee[quest_name];
	foreach (step in ee.steps)
	{
		if (step.name == step_name)
		{
			ee_step = step;
			break;
		}
	}

	if (!IsDefined(ee_step))
		return;

	ee_step.setup_func = setup_func;
	if (isdefined(cleanup_func))
		ee_step.cleanup_func = cleanup_func;
}

Debug_BOTDPaP(power_on)
{
	level flag::wait_till("start_zombie_round_logic");
	switch (zm_custom::function_901b751c(#"zmpapenabled"))
	{
		case 1:
			self zm_pack_a_punch::set_state_hidden();
			if (self.script_string == "roof")
			{
				level flag::wait_till("power_on1");
				var_a8d69fbd = getent("pap_shock_box", "script_string");
				var_a8d69fbd playsound(#"hash_3a18ced95ae72103");
				var_a8d69fbd playloopsound(#"hash_3a1bb2d95ae92746");
				var_a8d69fbd notify(#"hash_7f8e7011812dff48");
				wait 2;
				e_player = zm_utility::get_closest_player(var_a8d69fbd.origin);
				e_player thread zm_audio::create_and_play_dialog(#"pap", #"build", undefined, 1);
				scene::play(#"aib_vign_zm_mob_pap_ghosts");
				self zm_pack_a_punch::function_bb629351(1);
				self thread [[ @pap_quest<scripts\zm\zm_escape_pap_quest.gsc>::function_c0bc0375 ]]();
				level zm_ui_inventory::function_7df6bb60(#"zm_escape_paschal", 1);
				level flag::set(#"pap_quest_completed");
				link = @pap_quest<scripts\zm\zm_escape_pap_quest.gsc>::function_3357bedc;
				util::delay(30, "game_over", link);
			}
			break;
	}
}

Debug_ActivatePAP()
{
	SetGametypeSetting(#"zmpowerstate", 2);
	ShieldLog("^2Debug: Activating PAP");

	switch (BO4GetMap())
	{
		case "IX":
			level flag::wait_till("all_players_spawned");
			level flag::wait_till("initial_blackscreen_passed");
			wait 3;
			level thread [[ @zm_towers_pap_quest<scripts\zm\zm_towers_pap_quest.gsc>::function_a7faeaaf ]]();
			break;

		case "Blood":
			SetGametypeSetting(#"zmpowerstate", 1);
			while (!isDefined(level.pack_a_punch.custom_power_think))
				waitFrame(1);
			level.pack_a_punch.custom_power_think = &Debug_BOTDPaP;

			level flag::wait_till("all_players_spawned");
			level flag::wait_till("initial_blackscreen_passed");

			zm_zonemgr::enable_zone("zone_cellblock_jail_1");
			zm_zonemgr::enable_zone("zone_cellblock_jail_2");
			zm_zonemgr::enable_zone("zone_cellblock_jail_3");
			zm_zonemgr::enable_zone("zone_cellblock_jail_4");
			zm_zonemgr::enable_zone("zone_cellblock_west_barber");
			zm_zonemgr::enable_zone("zone_broadway_floor_2");
			zm_zonemgr::enable_zone("zone_cellblock_west");
			zm_zonemgr::enable_zone("zone_start");
			zm_zonemgr::enable_zone("zone_library");

			level flag::set("pap_machine_active");
			level flag::set(#"hash_3e80d503318a5674");
			level flag::set(#"hash_537cc10c9deca9da");
			level flag::set("power_on");
			level flag::set("power_on1");
			level flag::set("power_on2");
			level flag::set("power_on3");
			level flag::set("pap_power_ready");
			level flag::set(#"pap_quest_completed");
			level flag::set("fasttravel_enabled");
			level flag::set(#"mq_computer_activated");
			level flag::set(#"catwalk_event_completed");
			level flag::set("activate_catwalk");
			level notify(#"hash_7a04a7fb98fa4e4d");

			wait 5;

			var_40762d8a = getent("t_catwalk_door_open", "targetname");
			t_catwalk_door = getent("door_model_west_side_exterior_to_catwalk", "target");
			if (isdefined(var_40762d8a))
			{
				var_40762d8a sethintstring(#"");
				var_40762d8a setinvisibletoall();
			}
			if (isdefined(t_catwalk_door))
			{
				t_catwalk_door sethintstring(#"");
				t_catwalk_door setinvisibletoall();
			}
			if (isdefined(level.var_2ea46461))
				level.var_2ea46461 delete();

			foreach (trig_elec_switch in getentarray("use_elec_switch", "targetname"))
				trig_elec_switch trigger::use();
			break;

		case "AE":
			SetGametypeSetting(#"zmpapenabled", 2);
			level flag::wait_till("all_players_spawned");
			level flag::wait_till("initial_blackscreen_passed");
			wait 1;
			level flag::set("pap_machine_active");
			level flag::set(#"hash_3e80d503318a5674");
			level flag::set(#"hash_537cc10c9deca9da");
			level flag::set("power_on");
			level flag::set("power_on1");
			level flag::set("power_on2");
			level flag::set("power_on3");
			level flag::set("pap_power_ready");
			level flag::set(#"pap_quest_completed");
			level flag::set("fasttravel_enabled");
			level flag::set(#"mq_computer_activated");
			level flag::set(#"zm_red_fasttravel_open");
			level flag::set(#"hash_3764b0cb106568ec");
			level flag::set(#"hash_3dba794053dea40e");
			level flag::set(#"hash_32ff7a456732ef09");
			level flag::set(#"hash_4083e9da0ba41dec");
			level flag::set(#"cage_dropped");
			level flag::set(#"hash_67695ee69c57c0b2");
			level flag::set(#"hash_61de3b8fe6f6a35");
			level flag::set(#"hash_7943879f3be8ccc6");
			level flag::set(#"eagle_attack");
			level flag::set(#"egg_free");
			level flag::set(#"fl_oracle_unlocked");
			level flag::set(#"hash_1b6616e730b1235b");
			break;

		case "AO":
			SetGametypeSetting(#"zmpapenabled", 2);
			level flag::wait_till("all_players_spawned");
			level flag::wait_till("initial_blackscreen_passed");
			wait 3;
			zm_sq::start(#"zm_white_main_quest");
			break;

		case "Dead":
			level flag::wait_till("all_players_spawned");
			level flag::wait_till("initial_blackscreen_passed");
			wait 3;
			s_scene = struct::get(#"p8_fxanim_zm_man_ooze_clump_bundle", "scriptbundlename");
			if (isdefined(s_scene))
			{
				s_scene thread scene::play(#"p8_fxanim_zm_man_ooze_clump_bundle", "clump01_rise");
				s_scene thread scene::play(#"p8_fxanim_zm_man_ooze_clump_bundle", "clump02_rise");
				s_scene thread scene::play(#"p8_fxanim_zm_man_ooze_clump_bundle", "clump03_rise");
			}
			wait 5;
			level flag::set("crystal_main_hall");
			level flag::set("crystal_library");
			level flag::set("crystal_greenhouse");
			level flag::set("crystal_main_hall_key");
			level flag::set("crystal_library_key");
			level flag::set("crystal_greenhouse_key");
			level flag::set("power_on666");
			level flag::set("unlock_pap_gate");
			level flag::set("open_pap");
			zm_power::turn_power_on_and_open_doors(666);
			break;

		case "Tag":
			level thread Debug_OverrideQuest(#"pap_rock", #"step_1", &Debug_FreeSkipClean);
			level thread Debug_OverrideQuest(#"pap_rock", #"step_2", &Debug_FreeSkipClean);
			level flag::wait_till("all_players_spawned");
			level flag::wait_till("initial_blackscreen_passed");
			wait 3;
			level flag::set(#"hash_3310bb35ce396e49");
			level flag::set(#"hash_5a3d0402a5557739");
			level flag::set(#"hash_3028604821838259");
			level flag::set(#"hash_78cf83ad057b4f1f");
			break;

		case "Classified":
			SetGametypeSetting(#"zmpapenabled", 2);
			level flag::wait_till("all_players_spawned");
			level flag::set("pap_machine_active");
			level flag::set(#"hash_3e80d503318a5674");
			level flag::set(#"hash_537cc10c9deca9da");
			level flag::set("power_on");
			level flag::set("power_on1");
			level flag::set("power_on2");
			level flag::set("power_on3");
			level flag::set("pap_power_ready");
			level flag::set(#"pap_quest_completed");
			level flag::set("fasttravel_enabled");
			level flag::set(#"mq_computer_activated");
			level flag::wait_till("initial_blackscreen_passed");
			level notify(#"modifier_acquired");
			wait 3;
			if (isdefined(level.var_2de08508))
				level.var_2de08508 notify(#"trigger", {#activator:getplayers()[0]});
			wait 5;
			think = @zm_office_teleporters<scripts\zm\zm_office_teleporters.gsc>::portal_think;
			if (isdefined(level.s_cage_portal))
				level.s_cage_portal zm_unitrigger::create("", 32, think, 0, 0);
			[[ @zm_office_teleporters<scripts\zm\zm_office_teleporters.gsc>::function_60abbae4 ]](1);
			if (isdefined(level.var_a23b5c5))
			{
				level.var_a23b5c5 playsound(#"hash_123af2d6dc30025a");
				level.var_a23b5c5 movez(150, 1);
			}
			break;

		case "Voyage":
			level flag::wait_till("all_players_spawned");
			level flag::wait_till("initial_blackscreen_passed");
			wait 5;
			function_5c299a0f = @zodt8_pap_quest<scripts\zm\zm_zodt8_pap_quest.gsc>::function_5c299a0f;
			if (isdefined(level.s_pap_quest) && isdefined(level.s_pap_quest.a_s_locations))
			{
				foreach (s_loc in level.s_pap_quest.a_s_locations)
				{
					s_loc.unitrigger_stub thread [[ function_5c299a0f ]]();
					wait 0.5;
				}
			}
			break;
	}

	if (isdefined(getplayers()[0]))
		getplayers()[0] iPrintLnBold("^2PAP activated");
}

Debug_OpenMapSetup()
{
	level thread Debug_ActivatePAP();
	Debug_OpenDoors();
	Debug_PowerOn();

	foreach (guy in getplayers())
	{
		guy zm_score::add_to_player_score(50000);
		setDvar(#"enh_godmode", 1);
	}

	ShieldLog("^2Debug: open map setup (doors/power/PAP/50k/god)");
	if (isdefined(getplayers()[0]))
		getplayers()[0] iPrintLnBold("^2Map setup ready");
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
	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/score/+50000\" \"set enh_score_player 50000\"\n");

	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/test_func/on\" \"set enh_test 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/test_func/off\" \"set enh_test 0\"\n");

	adddebugcommand("devgui_cmd \"enh_dev_gsc/game/timescale_speed/1x\" \"set enh_timescale_speed 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/game/timescale_speed/2x\" \"set enh_timescale_speed 2\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/game/timescale_speed/5x\" \"set enh_timescale_speed 5\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/game/timescale_speed/10x\" \"set enh_timescale_speed 10\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/game/timescale_speed/0x\" \"set enh_timescale_speed 0\"\n");

	// LocalTest map helpers (were a separate mod; F9 menu only now)
	adddebugcommand("devgui_cmd \"enh_dev_gsc/map/open_doors\" \"set enh_open_doors 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/map/power_on\" \"set enh_power_on 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/map/activate_pap\" \"set enh_activate_pap 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/map/open_map_setup\" \"set enh_open_map_setup 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/game/aat_always_proc/on\" \"set shield_enh_LocalTest 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/game/aat_always_proc/off\" \"set shield_enh_LocalTest 0\"\n");

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

			if (getDvarInt(#"enh_open_doors", 0))
			{
				setDvar(#"enh_open_doors", 0);
				level thread Debug_OpenDoors();
			}

			if (getDvarInt(#"enh_power_on", 0))
			{
				setDvar(#"enh_power_on", 0);
				Debug_PowerOn();
			}

			if (getDvarInt(#"enh_activate_pap", 0))
			{
				setDvar(#"enh_activate_pap", 0);
				level thread Debug_ActivatePAP();
			}

			if (getDvarInt(#"enh_open_map_setup", 0))
			{
				setDvar(#"enh_open_map_setup", 0);
				level thread Debug_OpenMapSetup();
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