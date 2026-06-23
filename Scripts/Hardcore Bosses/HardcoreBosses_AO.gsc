Hardcore_AO_Init()
{
    //iPrintLnBold("hardcore init..");
    level endon(#"boss_fight_complete", #"end_game");

    while(zm_round_logic::get_round_number() < 255 && !GetDvarInt(#"shield_enh_DirectedMode", 0)) {
        ShieldLog("switch round");

        level thread zm_utility::zombie_goto_round(255);
        level thread zm_game_module::zombie_goto_round(255);

        wait 0.15;
    }

    // disable pap thingy, in savegame's detour gsc
    level.SaveSkipped = true;

    level flag::set("world_is_paused");
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_2ba419ee ]](0);
    wait 0.5;
    foreach (canister in level.a_e_canister) {
        if (canister.script_int == 1) {
            canister thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_8c2bda65 ]](3, 1);
        }
    }
    
    if(!GetDvarInt(#"shield_enh_Practice_Bosses", 0))
        music::setmusicstate("boss_battle_avogadro_intro");

    exploder::exploder("fxexp_pyramid_open");
    var_1c91a56e = struct::get("apd_door_scene", "targetname");
    var_1c91a56e thread scene::play("open");
    [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::spawn_boss ]]();
    exploder::exploder("fxexp_avo_elec_floor");
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_3c173d37 ]]();
    
    if(!GetDvarInt(#"shield_enh_Practice_Bosses", 0))
        level.e_avogadro [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"vox_boss_release", 0, 0, 1);
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_3c173d37 ]]();
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_fd24e47f ]]("vox_boss_release", 1, 0, 1);
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_3c173d37 ]]();
    if(!GetDvarInt(#"shield_enh_Practice_Bosses", 0))
        level.var_5dd0d3ff [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"vox_boss_release", 2, 0, 1);
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_3c173d37 ]]();
    if(!GetDvarInt(#"shield_enh_Practice_Bosses", 0))
        level.e_avogadro [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"vox_boss_release", 3, 0, 1);
    [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_5ef0416 ]]();
    [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_6f635c39 ]]("boss_lockdown");
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_3c173d37 ]]();

    if(!GetDvarInt(#"shield_enh_Practice_Bosses", 0))
    {
        level.var_8200dc81 [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"vox_boss_release", 4, 0);
        playsoundatposition(#"hash_274493fd61d94d73", (0, 0, 0));
        playsoundatposition(#"hash_1fc67d7ad7445bbf", (-521, -1972, -82));
        playsoundatposition(#"hash_1fc67c7ad7445a0c", (-1146, -1956, -92));
        level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_ncom_0");
        level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_ten_ncom_0");
        level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_nine_ncom_0");
        level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_eight_ncom_0");
        level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_seven_ncom_0");
        playsoundatposition(#"hash_5dddf55133ac4bcf", (-576, -1992, -87));
        level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_six_ncom_0");
        level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_five_ncom_0");
        level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_four_ncom_0");
        level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_three_ncom_0");
        level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_two_ncom_0");
        level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_one_ncom_0");
    }

    if(!GetDvarInt(#"shield_enh_Practice_Bosses", 0))
        foreach (player in getplayers()) {
            player thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_a29438da ]]();
        }

    level thread lui::screen_flash(0.1, 0.6, 1.5, 0.8, "white");

    if(!GetDvarInt(#"shield_enh_Practice_Bosses", 0))
        playsoundatposition(#"hash_782025025ec70d68", (0, 0, 0));

    exploder::exploder("fxexp_nuke_event");
    wait 2;
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_3c173d37 ]]();
    wait 2;
    if(!GetDvarInt(#"shield_enh_Practice_Bosses", 0))
        level.e_avogadro [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"hash_5233a87eed32231a", 0, 0);
    if (isdefined(level.e_avogadro)) {
        level.e_avogadro notify(#"intro_done");
    }

    level.e_avogadro thread FasterAvog();
    level.e_avogadro thread MonitroHeathAvog();

    // intro
    // player uis, same as vod's
    LUINotifyEvent(#"notify_boss_ui", 1, 2);

    wait 3.5;

    // disable elixirs
    foreach (player in getplayers()) {
        player bgb::take();
        player bgb_pack::function_ac9cb612(1);
        player bgb::suspend_weapon_cycling();
        player.bgb_disabled = 1;

        player dontinterpolate();
        player SetRandomOrigin((-287.465, 381.443, -58.9685));
    }

    LUINotifyEvent(#"notify_boss_ui", 1, 3);

    exploder::stop_exploder("fxexp_avo_elec_floor");
    vol_intro_blocker = getent("intro_blocker", "targetname");
    vol_intro_blocker notsolid();

    music::setmusicstate("boss_battle_stage_1");
    //ShieldPlay(true, true, 94);

    [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_f2fa71ce ]]();
    [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_364cd8c0 ]]("apd_lockdown");
    level flag::clear("world_is_paused");
    level.var_f8fdb172 [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_3ea7f25d ]]();
    level thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::canister_instruct ]]();
    level thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_abb0b62 ]]();
    level thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::downed_react ]]();
    level thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_927c0f2e ]]();
    level thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_8149ceff ]]();
    level thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_1fba7fc2 ]]();
    var_3942c56 = [];

    //iPrintLnBold("teleporting avoc");
    for (i = 0; i < 30; i++)
    {
        // can you fucking teleport alreadY??
        level.e_avogadro ForceTeleport((-504.637, -67.8809, -58.875), (0, 90, 0));
        wait 0.1;
    }

    level.var_43fb4347 = "super_sprint";
    level.zombie_vars["zombie_max_ai"] = 40;
    level.zombie_ai_limit = 40;
    level.zombie_actor_limit = 40;

    // TODO: use custom cans charge to damage him
    charger_can = util::spawn_model(#"p7_zm_power_up_nuke", (34.4131, -2268.79, -30), (0, 0, 0));
    charger_can setscale(1.5);
    charger_can thread RotateAndBobItem();
    charger_can thread MonitorSoulBoxNuke();
    charger_can thread PhaseWatcher();

    callback::on_ai_killed(&on_ai_killed_souls_nuke);

    level.mdl_nuke_souls = charger_can;

    music::setmusicstate("boss_battle_stage_1");
}

ChooseRandomSpot()
{
    self notify(#"stop_follow");

    wait 0.25;

    // remove obj
    LUINotifyEvent(#"enhancement_custom_visibility", 2, 0, 1);
    
    self playsound(#"hash_2f8c9575cb36a298");
    playfx(level._effect[#"hash_1eae5969d11a8b16"], self.origin);
    playfx(level._effect[#"teleport_splash"], self.origin);

    rnd_spots = array((34.4131, -2268.79, -30), (108.088, 959.095, -30.2904), (1862.76, 630.412, -30.5563), (-1510.88, -1165.46, -30.8919), (1362.17, -2251.95, -30.1521));
    self.origin = array::random(rnd_spots);

    // add obj
    LUINotifyEvent(#"enhancement_custom_visibility", 6, 1, 1, int(self.origin[0]), int(self.origin[1]), int(self.origin[2] + 30), 1);
}

PhaseWatcher()
{
    self endon(#"death");

    while(true)
    {
        if (isDefined(level.e_avogadro) && isDefined(level.e_avogadro.weak_avog) && level.e_avogadro.weak_avog)
        {
            wait 0.15;
            foreach(a_player in level.players)
            {
                a_player playsound(#"zmb_bgb_plainsight_end");
                a_player clientfield::set_to_player("" + #"hash_321b58d22755af74", 0);
                a_player val::set(#"zm_bgb_talkin_bout_regeneration", "ignore_health_regen_delay", 0);
                a_player clientfield::set_to_player("zm_bgb_near_death_experience_1p_fx", 0);
                a_player.has_nuke_buff = false;
            }

            LUINotifyEvent(#"notify_boss_name", 1, 17);
            LUINotifyEvent(#"enhancement_custom_visibility", 2, 0, 1);

            wait 0.3;

            LUINotifyEvent(#"enhancement_custom_visibility", 2, 0, 1);

            foreach(a_player in level.players)
            {
                a_player playsound(#"zmb_bgb_plainsight_end");
                a_player clientfield::set_to_player("" + #"hash_321b58d22755af74", 0);
                a_player val::set(#"zm_bgb_talkin_bout_regeneration", "ignore_health_regen_delay", 0);
                a_player clientfield::set_to_player("zm_bgb_near_death_experience_1p_fx", 0);
                a_player.has_nuke_buff = false;
            }

            self delete();
            return;
        }

        wait 0.5;
    }
}

FollowRandomPlayerNuke()
{
    self endon(#"death", #"stop_follow");

    while(true)
    {
        a_players = array::get_all_closest(self.origin, ReturnValidPlayers(), undefined, undefined, 750);

        if (isdefined(a_players) && a_players.size > 0)
        {
            target_player = a_players[0];

            // get forward and right vectors from player angles
            forward = anglestoforward(target_player.angles);
            right   = anglestoright(target_player.angles);

            // offset: 100 units in front, 50 units to the right, 0 up
            offset = forward * 100 + right * 50 + (0, 0, 50);

            move_pos = target_player.origin + offset;

            // move there
            self MoveTo(move_pos, 0.35);
        }

        wait 0.35;
    }
}

PlayVoiceLineAvog()
{
    playsoundatposition(#"hash_4a67e67e0a9d6df9", (0, 0, 0));

    switch(randomIntRange(0, 3))
    {
        case 0:
        level.var_5dd0d3ff [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"hash_52ef0df6d3730e90", 1, 0, 1);
        break;

        case 1:
        level.var_5dd0d3ff [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"hash_75fc60c1d10de4c2", 1, 0, 1);
        break;

        case 2:
        level.var_5dd0d3ff [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"hash_6e3f8bae61789524", 1, 0, 1);
        break;
    }
}

MonitorSoulBoxNuke()
{
	self endon(#"death");

	self.Souls = 0;
	self.Overpowering = false;

    self clientfield::set("powerup_fx", 2);

    self ChooseRandomSpot();

	while(true)
	{
		self waittill(#"kill_nuke");

		self.Souls++;
		self playsound(#"hash_2333d58ae8bcec49");

		if (self.Souls >= 50 && !self.Overpowering)
		{
            level thread PlayVoiceLineAvog();
            self thread FollowRandomPlayerNuke();
            
            self clientfield::set("powerup_fx", 1);
			self.Overpowering = true;

            // better?
            zm_powerup_nuke::grab_nuke(getplayers()[0]);

            self playsound(#"hash_58d1c989a1ea4137");

			// spawn instakill
			for(i = 0; i < 3; i++)
			{
				e_powerup = zm_powerups::specific_powerup_drop("nuke", self.origin, undefined, 0.1, undefined, 0, 1, 1);
				if (isdefined(e_powerup)) {
					e_powerup setscale(0.85);
				}

				e_powerup physicslaunch(e_powerup.origin, vectorscale((0, 0, RandomFloatRange(0.35, 0.65)), 64));
				wait 0.35;
			}

			self playsound(#"hash_58d1c989a1ea4137");

			time = randomIntRange(40, 65);

			for(i = 0; i < time; i++)
			{
				// get players near it and overpower them to the boss
				a_players = array::get_all_closest(self.origin, ReturnValidPlayers(), undefined, undefined, 300);

				foreach(a_player in ReturnValidPlayers())
				{
					if (IsInArray(a_players, a_player))
					{
						a_player playsound(#"zmb_bgb_plainsight_start");
						//a_player iPrintLnBold("test overpower");
						a_player clientfield::set_to_player("" + #"hash_321b58d22755af74", 1);
                        
                        a_player val::set(#"zm_bgb_talkin_bout_regeneration", "ignore_health_regen_delay", 1);
				        a_player clientfield::set_to_player("zm_bgb_near_death_experience_1p_fx", 1);

						a_player.has_nuke_buff = true;
					}
					else
					{
						a_player playsound(#"zmb_bgb_plainsight_end");
						//a_player iPrintLnBold("test unoverpower");
						a_player clientfield::set_to_player("" + #"hash_321b58d22755af74", 0);

                        a_player val::set(#"zm_bgb_talkin_bout_regeneration", "ignore_health_regen_delay", 0);
				        a_player clientfield::set_to_player("zm_bgb_near_death_experience_1p_fx", 0);

						a_player.has_nuke_buff = false;
					}
				}

				wait 0.5;
			}

			self.Overpowering = false;
			self.Souls = 0;

            self clientfield::set("powerup_fx", 2);

			foreach(a_player in ReturnValidPlayers())
			{
				a_player playsound(#"zmb_bgb_plainsight_end");
				//a_player iPrintLnBold("test unoverpower");
				a_player clientfield::set_to_player("" + #"hash_321b58d22755af74", 0);
                a_player val::set(#"zm_bgb_talkin_bout_regeneration", "ignore_health_regen_delay", 0);
				a_player clientfield::set_to_player("zm_bgb_near_death_experience_1p_fx", 0);
				a_player.has_nuke_buff = false;
			}

            self ChooseRandomSpot();
		}
	}
}

on_ai_killed_souls_nuke(params)
{
	e_attacker = params.eattacker;
	e_victim = self;

    if (!isplayer(e_attacker)) {
        return;
    }

	// distance check
	if (isdefined(level.mdl_nuke_souls) && isdefined(level.mdl_nuke_souls.origin) && !level.mdl_nuke_souls.Overpowering) {
		distance = distance(level.mdl_nuke_souls.origin, e_attacker.origin);
		if (distance > 250) {
			return;
		}

		// spawn soul FX at zombie death position
        if (isdefined(e_victim) && isdefined(e_victim.origin))
        {
            start_pos = e_victim.origin + (0, 0, 40); // just above body
			soul_fx = util::spawn_model("tag_origin", start_pos, (0, 0, 0));
            soul_fx clientfield::set("fx_shard_glow_clientfield", 1); // soul/energy fx
			soul_fx playSound(#"zmb_sq_souls_release");
            soul_fx playloopsound(#"zmb_sq_souls_lp");

            // thread to fly toward nuke
            soul_fx fly_to_nuke(level.mdl_nuke_souls);
        }
		
		level.mdl_nuke_souls notify(#"kill_nuke");
	}
}

fly_to_nuke(target_pos)
{
    self endon("death");

    time = 0.75; // how long to travel
    step = 0.05;
    steps = int(time / step);

    start = self.origin;

    for(i = 0; i < steps; i++)
    {
        frac = i / (steps * 1.0);
        self.origin = VectorLerp(start, target_pos.origin, frac);
        wait step;
    }

    // end with a little impact sound at nuke
    self playSound(#"zmb_sq_souls_impact");
    self delete();
}

FasterAvog()
{
    self endon(#"death");

    while(true)
    {
        self asmsetanimationrate(1.20);
        wait 0.5;
    }
}

MonitroHeathAvog()
{
    self endon(#"death");

    // avoid dying normally
    self.maxhealth = 999999999 + 1;
    self.health = 999999999;

    // balance health depending on players size
    players_size = (GetPlayers().size - 1);
    balance_health = 1080000 + (players_size * 250000);

    // balanced health with players
    self.health_phase_max = balance_health;
    self.health_phase = balance_health;

    // phase trigger
    self.weak_avog = false;
    self.max_given = false;

    // Track last damage time
    self.last_damage_time = GetTime();
    self.white_bar_update_delay = 2.2; // seconds to wait after last damage

    // Only one white bar update thread at a time
    if (!isdefined(self.monitor_white_bar_thread))
        self.monitor_white_bar_thread = self thread MonitorWhiteBarUpdate();

    LUINotifyEvent(#"notify_boss_name", 1, 16);
    LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(level.e_avogadro.health_phase / level.e_avogadro.health_phase_max));
    
    // ! only damage when player has (has_nuke_buff bool) !
    while(true)
    {
        level waittill(#"avog_damaged");

        // Update last damage time
        self.last_damage_time = GetTime();

        // Reset the white bar update thread if it's waiting
        if (isdefined(self.monitor_white_bar_thread))
        {
            self notify(#"reset_white_bar_timer");
        }

        if (self.health_phase < 0 && !self.weak_avog)
        {
            self.health_phase_max = balance_health;
            self.health_phase = balance_health;

            self.weak_avog = true;

            n_variant = randomintrangeinclusive(0, 9);
            level.e_avogadro thread [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"hash_7c662a0005eae5d4", n_variant, 0, 1);

            // allow exlixirs
            foreach (player in getplayers()) {
                player bgb_pack::function_ac9cb612(0);
                player bgb::resume_weapon_cycling();
                player.bgb_disabled = 0;
            }
        }

        if (self.health_phase < 0 && self.weak_avog)
        {
            // end boss fight..
            level thread [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::pause_zombies ]](1, 0);
            level thread lui::screen_flash(0.1, 3, 0.1, 0.8, "white");

            level.e_shard.name = "avog";

            level.e_shard.origin = self.origin + (0, 0, 30);
            level.e_shard show();
            level.e_shard clientfield::set("fx_shard_glow_clientfield", 1);

            // anything??
            level thread play_outro_dialog(self);
            return;
        }

        // free max ig
        if (!self.max_given && (self.health_phase < (self.health_phase_max / 2)))
        {
            level zm_powerup_full_ammo::grab_full_ammo(getplayers()[0]);
            self.max_given = true;   
        }
    }
}

play_outro_dialog(avog)
{
    level.e_shard thread [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"hash_1617ecba0bd3c76c", 3, 0);

    music::setmusicstate("none");
    //ShieldStopAllMusics();
    
    //iPrintLnBold("death intro");
    LUINotifyEvent(#"notify_boss_name", 1, 0);
    LUINotifyEvent(#"notify_boss_health_meter", 1, 0);

    playsoundatposition(#"hash_5c68b001a4e41ad3", (0, 0, 0));
    avog delete();

    wait 7.5;
    level.e_shard [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"vox_boss_success", 0, 0, 1);

    //iPrintLnBold("mid death intro");

    level [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::s_construction_push_point_a_markets ]]();
    level.var_5dd0d3ff [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"hash_53c2cc547088e4a2", 0, 0, 1);

    level.e_shard zm_unitrigger::create(&shard_hint, (72, 72, 128));
    level.e_shard thread wait_trigger_shard();

    //iPrintLnBold("end death intro");
}

wait_trigger_shard()
{
    s_waitresult = self waittill(#"trigger_activated");

    // for achiv..
    level flag::set(#"hash_5aa1c9627e8626e0");

    level.e_shard clientfield::set("fx_shard_glow_clientfield", 0);
    level.e_shard delete();
    if (isdefined(level.e_shard.s_unitrigger)) {
        zm_unitrigger::unregister_unitrigger(level.e_shard.s_unitrigger);
    }

    level [[ @zm_white_main_quest<scripts\zm\zm_white_main_quest.gsc>::play_outro ]]();
}

shard_hint(e_player) {
    if (function_8b1a219a()) {
        self sethintstring(#"hash_388479afabb2a89e");
    } else {
        self sethintstring(#"hash_7df1e511b6a42cda");
    }
    return true;
}

detour zm_ai_avogadro<scripts\zm\ai\zm_ai_avogadro.gsc>::function_8f7ba033(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @zm_ai_avogadro<scripts\zm\ai\zm_ai_avogadro.gsc>::function_8f7ba033 ]](inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);

    var_7aa37d9f = 0;
    if (self.var_b90a4dc9 == 4 && gettime() > self.var_adf3e655 && !isdefined(self.var_8c6c9045)) {
        self.var_8c6c9045 = dir * -1;
    } else if (gettime() > self.var_a8669c90 && [[ @zm_ai_avogadro<scripts\zm\ai\zm_ai_avogadro.gsc>::function_dbe3b78a ]](meansofdamage, weapon)) {
        self.var_fad7a0b8 = 1;
        level notify(#"avogadro_downed_react");
    } else if (![[ @zm_ai_avogadro<scripts\zm\ai\zm_ai_avogadro.gsc>::function_dbe3b78a ]](meansofdamage, weapon)) {
        level notify(#"avogadro_damage_react", {#e_player:attacker});
    }

    if (
        (isDefined(damage) && isDefined(attacker) && isDefined(attacker.has_nuke_buff) && attacker.has_nuke_buff) 
    ||  (isDefined(damage) && isDefined(attacker) && isDefined(self.weak_avog) && self.weak_avog))
    {
        if (damage < 15000)
            self.health_phase -= damage;

        params = spawnstruct();
        params.einflictor = self;
        params.idamage = damage;
        params.idflags = 0;
        params.smeansofdeath = ""; // what
        params.weapon = weapon;
        params.vpoint = self.origin;
        params.vdir = self.origin;
        params.shitloc = undefined;
        params.vdamageorigin = self.origin;
        params.psoffsettime = undefined;

        foreach(player in level.players)
        {
            params.eattacker = player;
            player callback::callback(#"on_ai_damage", params);
        }

        LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(level.e_avogadro.health_phase / level.e_avogadro.health_phase_max));
        level notify(#"avog_damaged");
    }

    return var_7aa37d9f;
}