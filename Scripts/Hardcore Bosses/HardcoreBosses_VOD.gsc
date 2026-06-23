// voyage detours
/*
detour zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::() {
    
}
*/

detour zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_51e51897(var_5ea5c94d) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_51e51897 ]](var_5ea5c94d);

    ShieldLog("^1function_51e51897");

    while(zm_round_logic::get_round_number() < 255 && !GetDvarInt(#"shield_enh_DirectedMode", 0)) {
        ShieldLog("switch round");

        level thread zm_utility::zombie_goto_round(255);
        level thread zm_game_module::zombie_goto_round(255);

        wait 0.15;
    }

    // play music
    //music::setmusicstate("rem_eye");
    
    level thread EyeHardcore_Intro_Beems();

    wait 9.85;

    level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_901c5ffe ]]("eng", 1);
    level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_901c5ffe ]]("st", 1);
    level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_901c5ffe ]]("pro", 1);
    level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_901c5ffe ]]("pd", 1);

    level flag::clear("spawn_zombies");
    level flag::clear("zombie_drop_powerups");
    level flag::clear(#"hash_21921ed511559aa3");
    level flag::set(#"disable_fast_travel");
    level flag::set("pause_round_timeout");
    level flag::set(#"boss_fight_started");
    level zm_bgb_anywhere_but_here::function_886fce8f(0);
    level.var_923e8cb4 = struct::get_array("pd", "script_teleport");

    var_eeb98313 = @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_714f8756;
    custom_spawnplayer = @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_9bc4f8cb;

    level.var_eeb98313 = var_eeb98313;
    level.custom_spawnplayer = custom_spawnplayer;

    level.disable_nuke_delay_spawning = 1;

    level notify(#"disable_nuke_delay_spawning");
    level [[ @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_77a859a8 ]](1);

    level.var_d6f059f7 = 255;
    level.var_43fb4347 = "super_sprint";

    spawn_callback = @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_e9b8eaff;

    zm_spawner::register_zombie_death_event_callback(spawn_callback);
    level.var_c9f5947d = 1;
    level notify(#"force_transformations");
    /#
        util::wait_network_frame();
        level notify(#"hash_fbdf766a8b47229");
    #/
    level.e_boss [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_500cb0be ]](#"hash_678aaf8e37498e9a", #"p8_fxanim_zm_zod_eye_01_bundle");
    level thread [[ @zm_zodt8<scripts\zm\zm_zodt8.gsc>::change_water_height_aft ]](1);

    if (!var_5ea5c94d) {
        level.e_boss.StopShit = false;

        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_482a7a01 ]]();
        level.musicsystemoverride = 1;
        //music::setmusicstate("boss_1");
        level notify(#"intro_blast_eye");
        level.e_boss [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_8f3497ee ]](1, "pd");
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_de60e752 ]]();
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_f6e1e56f ]](10, 3);
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_776c95e2 ]](50, 1);
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_ee223250 ]](2);

        var_23cac703 = [];

        level.e_boss thread EyeMoveAround();
        level.e_boss thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_bb612e31 ]](var_23cac703, 0, -1);

        // snow in boss fight
        showmiscmodels("bridge_controls");

        level waittill(#"enh_end_phase_1");

        // kill old zombies
        level thread zm_utility::zombie_goto_round(255);
        level thread zm_game_module::zombie_goto_round(255);

        level.e_boss.StopShit = true;

        wait 7.5;

        zm_powerup_full_ammo::grab_full_ammo(getplayers()[0]);

        // spawn blockers for phase 2, avoid player running out of the area
        // both stairs
        SpawnVoyageBlocker((495, -3970, 1088), (0, -90, 0));
        SpawnVoyageBlocker((-495, -3970, 1088), (0, -90, 0));

        // both doors
        SpawnVoyageBlocker((-192, -3970, 937), (0, -90, 0));
        SpawnVoyageBlocker((192, -3970, 937), (0, -90, 0));

        // engine level door
        SpawnVoyageBlocker((416, -4735, 938), (0, 90, 0));

        // big hole
        SpawnVoyageBlocker((109, -4557, 924), (0, 46, 0));
        SpawnVoyageBlocker((44, -4558, 922), (0, 46, 0), 1, false);
        SpawnVoyageBlocker((109, -4613, 926), (0, 46, 0), 1, false);

        // phase 2...
        // re-enable elixirs
        foreach (player in getplayers()) {
            player bgb_pack::function_ac9cb612(0);
            player bgb::resume_weapon_cycling();
            player.bgb_disabled = 0;
        }

        // midpoint for boss: (-0, -4612, 979)
        // player's: (5, -4090, 928), (0, -90, 0)
        foreach(player in level.players)
        {
            player dontinterpolate();
            player SetRandomOrigin((5, -4090, 928));
        }

        level.e_boss.StopShit = false;

        // phase 2 zombie soul box, artifact as a model?
        mdl_artifact = util::spawn_model(#"hash_12eedcc89df28c41", (10, -4100, 1000), (0, 0, 0));
        mdl_artifact notsolid();
        mdl_artifact setscale(3);
        mdl_artifact playloopsound(#"hash_5c7e9911ac98f633");
        mdl_artifact clientfield::set("" + #"hash_53c7d27cc9130e8f", 2);

        // fire
        mdl_artifact setmodel(#"hash_2b14d34cb1bc161a");
        mdl_artifact playloopsound(#"hash_66df9cab2c64f968");

        mdl_artifact thread RotateAndBobItem();

        // set-up soulbox?
        mdl_artifact thread MonitorSoulBox();
        mdl_artifact thread FollowRandomPlayer();

        level.mdl_artifact_souls = mdl_artifact;

        callback::on_ai_killed(&on_ai_killed_souls);

        level waittill(#"forever");
    }
}

EyeHardcore_Intro_Beems()
{
    beam = spawn_beam_eye((-5.09103, 5202.13, 1225.03));

    tag = util::spawn_model(#"hash_32a51dafb1c7344f", (-5.09103, 5202.13, 1225.03), (0, 0, 0));
    tag SetScale(0.01);

    tag clientfield::set("winters_wail_slow_field_eye", 1);
    tag clientfield::set("bs_att_bm_cf", 1);
    wait(1);
    tag clientfield::set("bs_att_bm_tell_cf", 1);
    wait(0.4);
    tag clientfield::set("bs_att_bm_tell_fx_cf", 1);
    wait(0.1);
    tag clientfield::set("bs_att_bm_tell_cf", 2);

    wait 1.5;

    // play music eye
    ShieldPlay(true, true, 1);

    level waittill(#"intro_blast_eye");
    
    tag playsound("zmb_eyeball_vox_intro_s4");
    tag clientfield::set("bs_att_bm_tell_fx_cf", 0);
    tag clientfield::set("bs_att_bm_cf", 0);
    tag clientfield::set("bs_att_mst_tell_cf", 0);
    
    wait 0.5;
    beam delete();
    util::wait_network_frame();
    tag delete();
}

spawn_beam_eye(v_loc, n_time) 
{
    level endon(#"hash_14400d2bff068132", #"intermission");

    beam_o = util::spawn_model("tag_origin", v_loc);
    util::wait_network_frame(4);
    beam_o clientfield::set("bs_att_bm_targ_ini_cf", 1);
    util::wait_network_frame(4);

    if (isdefined(n_time)) {
        beam_o moveto(v_loc, n_time);
        wait n_time;
        return beam_o;
    }

    beam_o.origin = v_loc;

    return beam_o;
}

FollowRandomPlayer()
{
    self endon(#"death");

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

filter_alive(val)
{
    b_bool = (isdefined(val) && isAlive(val));
    
    if (b_bool)
    {
        return !(val util::is_spectating());
    }
    else
        return false;
}

MonitorSoulBox()
{
	self endon(#"death");

	self clientfield::set("winters_wail_slow_field_eye", 1);
	self.Souls = 0;
	self.Overpowering = false;

	while(true)
	{
		self waittill(#"kill_artifact");

		self.Souls++;
		self playsound(#"hash_2333d58ae8bcec49");

		if (self.Souls >= 30 && !self.Overpowering)
		{
			self.Overpowering = true;

            // better?
            zm_powerup_nuke::grab_nuke(getplayers()[0]);

            self playsound(#"hash_58d1c989a1ea4137");

			// spawn instakill
			for(i = 0; i < 3; i++)
			{
				e_powerup = zm_powerups::specific_powerup_drop("insta_kill", self.origin, undefined, 0.1, undefined, 0, 1, 1);
				if (isdefined(e_powerup)) {
					e_powerup setscale(0.85);
				}

				e_powerup physicslaunch(e_powerup.origin, vectorscale((0, 0, RandomFloatRange(0.35, 0.65)), 64));
				wait 0.35;
			}

			self playsound(#"hash_58d1c989a1ea4137");

			time = randomIntRange(40, 65);

			self clientfield::set("winters_wail_slow_field_eye", 0);
			self clientfield::set("" + #"hash_53c7d27cc9130e8f", 4);

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

						a_player.has_artifact_buff = true;
					}
					else
					{
						a_player playsound(#"zmb_bgb_plainsight_end");
						//a_player iPrintLnBold("test unoverpower");
						a_player clientfield::set_to_player("" + #"hash_321b58d22755af74", 0);

                        a_player val::set(#"zm_bgb_talkin_bout_regeneration", "ignore_health_regen_delay", 0);
				        a_player clientfield::set_to_player("zm_bgb_near_death_experience_1p_fx", 0);

						a_player.has_artifact_buff = false;
					}
				}

				wait 0.5;
			}

			self.Overpowering = false;
			self.Souls = 0;

			self clientfield::set("" + #"hash_53c7d27cc9130e8f", 2);

			foreach(a_player in ReturnValidPlayers())
			{
				a_player playsound(#"zmb_bgb_plainsight_end");
				//a_player iPrintLnBold("test unoverpower");
				a_player clientfield::set_to_player("" + #"hash_321b58d22755af74", 0);
                a_player val::set(#"zm_bgb_talkin_bout_regeneration", "ignore_health_regen_delay", 0);
				a_player clientfield::set_to_player("zm_bgb_near_death_experience_1p_fx", 0);
				a_player.has_artifact_buff = false;
			}
		}
	}
}

on_ai_killed_souls(params)
{
	e_attacker = params.eattacker;
	e_victim = self;

    if (!isplayer(e_attacker)) {
        return;
    }

	// distance check
	if (isdefined(level.mdl_artifact_souls) && isdefined(level.mdl_artifact_souls.origin) && !level.mdl_artifact_souls.Overpowering) {
		distance = distance(level.mdl_artifact_souls.origin, e_attacker.origin);
		if (distance > 250) {
			return;
		}

		// spawn soul FX at zombie death position
        if (isdefined(e_victim) && isdefined(e_victim.origin))
        {
            start_pos = e_victim.origin + (0, 0, 40); // just above body
			soul_fx = util::spawn_model("tag_origin", start_pos, (0, 0, 0));
            soul_fx clientfield::set("powerup_fx", 1); // soul/energy fx
			soul_fx playSound(#"zmb_sq_souls_release");
            soul_fx playloopsound(#"zmb_sq_souls_lp");

            // thread to fly toward artifact
            soul_fx fly_to_artifact(level.mdl_artifact_souls);
        }
		
		level.mdl_artifact_souls notify(#"kill_artifact");
	}
}

fly_to_artifact(target_pos)
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

    // end with a little impact sound at artifact
    self playSound(#"zmb_sq_souls_impact");
    self delete();
}

detour zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_8f3497ee(n_stage, str_loc) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_8f3497ee ]](n_stage, str_loc);

    ShieldLog("boss init intro");

    level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_c8f90603 ]]("bs_blkr_stg_" + str_loc, 1);
    util::wait_network_frame(2);
    self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_141c7d46 ]]();
    self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_a55a0339 ]](str_loc);
    self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_26e02ac9 ]](0);
    [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_732f7da0 ]]();
    self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_71f63a19 ]](str_loc);
    self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_1b11b43 ]](str_loc);

    //zm_audio::sndvoxoverride(1);
    //level.powerup_vo_available = &zodt8_sentinel::return_false;
    switch (n_stage) {
    case 1:
        // hardcore intro
        [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_d21f5b58 ]](1);
        wait 3;
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_1122d832 ]]("event_low_impact", "pd");
        self playsound("zmb_eyeball_vox_intro_s1");
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_f74b38da ]]("zm_power_on_rumble");
        self scene::play(self.str_scene, "roar2", self);
        self animation::stop(0);
        self thread scene::play(self.str_scene, self.str_idle, self);

        link_func = @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_a2170913;
        level util::delay(#"hash_5286b6160d468570", undefined, link_func, n_stage, 3);


        level thread [[ @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_53802e89 ]](#"hash_696f2e5fafff5614", undefined, array(2, 1, 4, 3));
        wait 1.5;
        //self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_671e8d37 ]]();

        //self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_move ]](0, 0);

        util::wait_network_frame(4);

        wait 2.5;

        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_leave ]]();
        self.var_451ab1a6 = 0;
        var_d1c757d1 = struct::get("bs_pth_pd_s1_hold", "targetname");
        self.origin = var_d1c757d1.origin;
        self.angles = var_d1c757d1.angles;
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_arrive ]]();
        [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_d21f5b58 ]](0);

        wait 1.5;
        break;
    case 2:
        [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_d21f5b58 ]](1);
        wait 3;
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_1122d832 ]]("event_low_impact", "eng", 2);
        self playsound("zmb_eyeball_vox_intro_s2");
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_f74b38da ]]("zm_power_on_rumble");
        self scene::play(self.str_scene, "roar", self);
        self animation::stop(0);
        self thread scene::play(self.str_scene, self.str_idle, self);
        [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_901c5ffe ]]("eng", 1);
        wait 1;
        self clientfield::set("bs_att_mst_tell_cf", 1);
        level thread scene::play("p8_fxanim_zm_zod_engine_pistons_idle_01_bundle", "stop");
        level thread scene::play("p8_fxanim_zm_zod_engine_pistons_idle_02_bundle", "stop");
        wait 1;
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_a2170913 ]](n_stage);
        [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_d21f5b58 ]](1);
        break;
    case 3:
        [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_d21f5b58 ]](1);
        wait 3;
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_1122d832 ]]("event_impact", "st");
        [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_901c5ffe ]]("st", 1);
        self playsound("zmb_eyeball_vox_intro_s3");
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_f74b38da ]]("zm_power_on_rumble");
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_671e8d37 ]]();
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_a6f08a79 ]](#"p8_fxanim_zm_zod_state_lft_hall_bundle");
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_c7c928e9 ]](0, 1, 0);
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_a6f08a79 ]](#"p8_fxanim_zm_zod_state_rt_hall_bundle");
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_c7c928e9 ]](0, 1, 1);
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_a8a76e18 ]](0);
        wait 0.5;
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_a2170913 ]](n_stage);
        [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_d21f5b58 ]](0);
        break;
    case 4:
        [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_d21f5b58 ]](1);
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_500cb0be ]](#"hash_32a51dafb1c7344f", #"p8_fxanim_zm_zod_eye_02_bundle");
        wait 3;
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_1122d832 ]]("event_impact", "pro", 4);
        self playsound("zmb_eyeball_vox_intro_s4");
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_f74b38da ]]("zm_power_on_rumble");
        self.var_914750d = 1;
        self clientfield::set("bs_bdy_dmg_fx_cf", self.var_914750d);
        wait 0.5;
        [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_901c5ffe ]](#"pro", 1);
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_3681a3ac ]](#"p8_fxanim_zm_zod_prom_icicles_01_bundle");
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_3681a3ac ]](#"p8_fxanim_zm_zod_prom_icicles_02_bundle");
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_3681a3ac ]](#"p8_fxanim_zm_zod_prom_icicles_03_bundle");
        self scene::play(self.str_scene, "roar1", self);
        self.str_idle = "idle1";
        self animation::stop(0);
        self thread scene::play(self.str_scene, self.str_idle, self);
        self clientfield::set("bs_att_mst_tell_cf", 0);
        wait 0.5;
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_a2170913 ]](n_stage);
        [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_d21f5b58 ]](0);
        break;
    case 5:
        [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_d21f5b58 ]](1);
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_500cb0be ]](#"hash_597bdc83a7c9e8c", #"p8_fxanim_zm_zod_eye_03_bundle");
        wait 2;
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_1122d832 ]]("event_high_impact", "pd", 5);
        self playsound("zmb_eyeball_vox_intro_s5");
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_f74b38da ]]("zm_power_on_rumble");
        self scene::play(self.str_scene, "roar2", self);
        self.str_idle = "idle2";
        self animation::stop(0);
        self thread scene::play(self.str_scene, self.str_idle, self);
        self.var_914750d = 1;
        self clientfield::set("bs_bdy_dmg_fx_cf", self.var_914750d);
        a_iceberg = getentarray("forget_what_you_know", "targetname");
        foreach (mdl in a_iceberg) {
            mdl.origin -= (0, 0, 13800);
            mdl show();
            mdl.origin += (0, 0, 13800);
            mdl clientfield::set("" + #"hash_15b23de7589e61a", 1);
        }
        [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_901c5ffe ]](#"pd", 1);
        wait 0.5;
        level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_a2170913 ]](n_stage);
        wait 1;
        [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_d21f5b58 ]](0);
        break;
    }
}

detour zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_ee223250(flags_num) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_ee223250 ]](flags_num);

    ShieldLog("watcher for flags");

    level waittill(#"forever");
    //level notify(#"hash_38f29f9cb03586ea");
}

detour zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_776c95e2(var_61e1a92c, var_dbb23c7) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_776c95e2 ]](var_61e1a92c, var_dbb23c7);

    ShieldLog("blight spawner");

    level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"intermission", #"enh_end_boss_fight");
    var_2208179c = struct::get_array(#"blightfather_spawn");
    var_7bb1ca00 = level.var_f3c4bd00;
    ai_blightfather = undefined;
    var_24b27265 = 0;

    var_8c9010a4 = 15;
    var_dde52a4d = 20;

    a_ai_blightfather = getaiarchetypearray(#"blight_father");

    while (true) {
        wait randomfloatrange(20, 25);
        zm_transform::function_bdd8aba6(#"hash_9ecf8085fb7a68f");
        wait randomfloatrange(var_8c9010a4, var_dde52a4d);
    }
    //[[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_98198f98 ]](#"blight_father");
}

// zombie spawner
detour zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_de60e752(var_533ac894) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_de60e752 ]](var_533ac894);

    ShieldLog("zombie spawner");

    level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"intermission", #"enh_end_boss_fight");
    n_round = level.var_d6f059f7;

    var_d166a3c6 = 9;
    var_6d55be0e = 0.25;

    n_max_active_ai = 33;
    level.var_9eaf1031 = 0;
    level.var_83c0592c = 0;
    level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_f5b2d086 ]]();
    
    n_index = 0;

    while(true)
    {
        a_players = util::get_active_players();
        if (a_players.size > 0) {
            s_zone = a_players[0] zm_utility::get_current_zone(1);
        }
        if (!isdefined(s_zone)) {
            s_zone = level.zones[#"zone_poop_deck"];
        }
        a_s_spawnpoints = struct::get_array(s_zone.name + "_spawns");
        a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(s_zone.name + "_spawner"), 0, 0);
        var_e6217dda = getarraykeys(s_zone.adjacent_zones);
        foreach (str_zone in var_e6217dda) {
            if (isdefined(s_zone.adjacent_zones[str_zone]) && s_zone.adjacent_zones[str_zone].is_connected) {
                a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(str_zone + "_spawns"), 0, 0);
                a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(str_zone + "_spawner"), 0, 0);
            }
        }
        if (isdefined(var_533ac894)) {
            foreach (str_zone in var_533ac894) {
                a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(str_zone + "_spawns"), 0, 0);
                a_s_spawnpoints = arraycombine(a_s_spawnpoints, struct::get_array(str_zone + "_spawner"), 0, 0);
            }
        }

        link = @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_62b1d725;

        a_s_spawnpoints = array::filter(a_s_spawnpoints, 0, link);
        RZones = array::randomize(a_s_spawnpoints);

        while (getaiteamarray(level.zombie_team).size >= 33) // if very high, no transformers or blights....
            util::wait_network_frame();

        spawner = array::random(level.zombie_spawners);
        s_spawnpoint = RZones[n_index];

        if (n_index + 1 >= RZones.size)
            n_index = 0;
        else 
            n_index++;

        e_zombie = zombie_utility::spawn_zombie(spawner, spawner.targetname, s_spawnpoint, 255);
        wait(0.15);
    }
}

detour zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_f5b2d086() {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_f5b2d086 ]]();

    level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"hash_71fd67248b9a37ca", #"intermission");

    ShieldLog("catalyst spawner");

    wait 6;
    forms = array(#"hash_7c89b1397a38e3ad", #"hash_7c89ae397a38de94", #"hash_7c89af397a38e047", #"hash_7c89ac397a38db2e", #"enh_end_boss_fight");
    level.var_8a64ef3a = 0;
    while(true) 
    {
        c_forms = array::random(forms);
        if (![[ @zm_transform<scripts\zm_common\zm_transformation.gsc>::function_abf1dcb4 ]](c_forms))
        {
            [[ @zm_transform<scripts\zm_common\zm_transformation.gsc>::function_bdd8aba6 ]](c_forms);
            level.var_9eaf1031--;
        }
        wait 5;
    }
}

detour zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_f6e1e56f(var_238eb6ec, var_b5a033fe = 0, var_533ac894) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_f6e1e56f ]](var_238eb6ec, var_b5a033fe, var_533ac894);

    ShieldLog("special stoker spawner");

    level endon(#"hash_38f29f9cb03586ea", #"spawn_zombies", #"intermission", #"enh_end_boss_fight");

    times = 0;

    while(true)
    {
        StokerChecks = @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_6c4ef5c9;
        a_players = util::get_active_players();

        if (a_players.size > 0) 
        {
            s_zone = a_players[0] zm_utility::get_current_zone(1);
        }
        if (!isdefined(s_zone))
        {
            s_zone = level.zones[#"zone_poop_deck"];
        }

        zones = struct::get_array(s_zone.name + "_spawns");
        zones = arraycombine(zones, struct::get_array(s_zone.name + "_spawner"), 0, 0);
        c_zones = getarraykeys(s_zone.adjacent_zones);
        foreach (str_zone in c_zones) 
        {
            if (isdefined(s_zone.adjacent_zones[str_zone]) && s_zone.adjacent_zones[str_zone].is_connected) 
            {
                zones = arraycombine(zones, struct::get_array(str_zone + "_spawns"), 0, 0);
                zones = arraycombine(zones, struct::get_array(str_zone + "_spawner"), 0, 0);
            }
        }

        if (isdefined(var_533ac894)) 
        {
            foreach (str_zone in var_533ac894) 
            {
                zones = arraycombine(zones, struct::get_array(str_zone + "_spawns"), 0, 0);
                zones = arraycombine(zones, struct::get_array(str_zone + "_spawner"), 0, 0);
            }
        }

        zones = array::filter(zones, 0, StokerChecks);
        zones = array::randomize(zones);

        ai_stoker = [[ @zm_ai_stoker<scripts\zm\ai\zm_ai_stoker.gsc>::spawn_single ]](1, zones[times], 255);
        times++;

        if (times + 1 >= zones.size)
            times = 0;
        else 
            times++;

        wait(randomfloatrange(10, 20));
    }
}

SpawnEyeFreezes()
{
    self endon(#"death");

    level endon(#"hash_14400d2bff068132", #"intermission", #"enh_end_boss_fight", #"enh_end_phase_1");

    while(true)
    {
        freezes = array::random(self.var_48b3f539);
        foreach (freeze in freezes) {
            self thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_47073904 ]](freeze.origin);
            util::wait_network_frame();
        }
        wait 10;
    }
}

SpawnEyeFreezesPhase2()
{
    self endon(#"death");

    level endon(#"hash_14400d2bff068132", #"intermission", #"enh_end_boss_fight");

    // 6 of them
    random_points = array((-400.677, -4363.16, 928.125), (12.5577, -4101.22, 928.125), 
    (396.911, -4410.22, 928.125), (206.221, -4951.64, 1099.44), (-258.495, -4953.76, 1099.55), (7.54192, -4780.6, 928.125));

    while(true)
    {
        freezes = array::randomize(random_points);
        foreach (orig_freeze in freezes) {
            self thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_47073904 ]](orig_freeze);
            wait 3;
        }
    }
}

GetAttackTime()
{
    if (self.broken)
        return 3.35;

    if (self.cracked)
        return 4.5;

    return 6.0;
}

GetSwitchTime()
{
    if (self.broken)
        return 6.5;

    if (self.cracked)
        return 8.5;

    return 10.0;
}

ReturnValidPlayers()
{
    players = getplayers();
    valid_players = array();

    foreach (player in players) {
        if (isdefined(player) && isAlive(player) && !player util::is_spectating()) {
            valid_players[valid_players.size] = player;
        }
    }

    return valid_players;
}

EyeMoveAround()
{
    level endon(#"end_game");
    self endon(#"death", #"stop_attack");

    ShieldLog("^1eyeMove");

    self.DoingAnimation = false;
    self.IsAttacking = false;
    self.var_914750d = 0;
    
    self.PhaseTrigger = false;

    self thread SpawnEyeFreezes();

    // player uis
    LUINotifyEvent(#"notify_boss_ui", 1, 2);

    wait 3.5;

    // disable elixirs
    foreach (player in getplayers()) {
        player bgb::take();
        player bgb_pack::function_ac9cb612(1);
        player bgb::suspend_weapon_cycling();
        player.bgb_disabled = 1;
    }

    LUINotifyEvent(#"notify_boss_ui", 1, 3);
    
    self.e_damage solid();
    target_set(self);

    self thread MonitorDamage();
    self thread PlayersUnderEye();

    // Remove the old bobbing thread, we'll do bobbing inline with movement
    // self bobbing((0,0,1), 3.5, 9);

    // effects around it
    self clientfield::set("winters_wail_slow_field_eye", 1);
    playFXOnTag(#"zm_weapons/fx8_equip_mltv_fire_human_torso_loop_zm", self, "tag_fx_beam");

    while(true)
    {
        self animation::stop(0);

        // Pick a random player
        players = ReturnValidPlayers();
        if(players.size > 0)
        {
            target_player = players[randomint(players.size)];

            // Set parameters for the orbit
            orbit_radius = 1200; // very far
            orbit_height = 400; // base height above ground
            orbit_speed = 50.0; // degrees per frame

            // Bobbing parameters
            bob_amplitude = 150; // how much to bob up/down
            bob_speed = 120.0; // how fast to bob

            // Pick a random starting angle
            angle = randomfloat(360);

            // Time to next player switch
            switch_time = randomfloatrange(1, 5);
            switch_timer = 0;

            attack_time_max = self GetAttackTime();
            attack_time = randomfloatrange(1, attack_time_max);
            attack_timer = 0;

            bob_time = 0;

            orbit_dir = 1; // 1 = counterclockwise, -1 = clockwise
            switch_dir_time_max = self GetSwitchTime();
            switch_dir_time = randomfloatrange(5, switch_dir_time_max); // how often it may switch
            switch_dir_timer = 0;

            // Orbit logic
            while(isdefined(target_player) && isdefined(self))
            {
                if (isDefined(self.DoingAnimation) && self.DoingAnimation)
                {
                    wait 0.01;
                    continue;
                }
                
                // Update player origin in case they move
                player_origin = target_player.origin;
                orbit_pos_init = self.PhaseTrigger ? (-0, -4612, 979) : (0, 4610, 1090); // dont use player's, just mid-point

                if (self.StopShit)
                {
                    self.angles = vectortoangles(player_origin - self.origin);
                    self.PhaseTrigger = true;

                    wait 0.01;
                    continue;
                }

                // Calculate new position around the player in a circle
                radians = angle * (3.14159265 / 180);
                offset_vec = (cos(radians) * orbit_radius, sin(radians) * orbit_radius, orbit_height);

                // Bobbing calculation
                bob_offset = bob_amplitude * sin(bob_time * bob_speed);
                orbit_pos = orbit_pos_init + offset_vec + (0, 0, bob_offset);

                // Move the boss eye to the new position
                self.origin = orbit_pos;

                // Look at the player
                self.angles = vectortoangles(player_origin - self.origin);

                // Increment angle for next frame
                angle += orbit_speed * orbit_dir;

                // Increment timers
                switch_timer += 0.01;
                attack_timer += 0.01;
                bob_time += 0.01;

                // Switch player if needed
                if(switch_timer >= switch_time)
                {
                    players = ReturnValidPlayers();
                    if(players.size > 0)
                        target_player = players[randomint(players.size)];
                    switch_time = randomfloatrange(1, 5);
                    switch_timer = 0;
                }

                // Attack if needed
                if(attack_timer >= attack_time)
                {
                    // Perform attack on the player, no threading
                    self PerformAttack(target_player, randomIntRange(0, 10));

                    attack_time_max = self GetAttackTime();
                    attack_time = randomfloatrange(1, attack_time_max);
                    attack_timer = 0;
                }

                switch_dir_timer += 0.01;
                if(switch_dir_timer >= switch_dir_time)
                {
                    orbit_dir *= -1; // flip direction
                    switch_dir_timer = 0;
                    switch_dir_time_max = self GetSwitchTime();
                    switch_dir_time = randomfloatrange(5, switch_dir_time_max); // randomize next flip
                }

                wait 0.01;
            }
        }

        wait 1;
    }
}

MonitorDamage()
{
    self endon(#"death");

    // balance health depending on players size
    players_size = (GetPlayers().size - 1);
    balance_health = 500000 + (players_size * 250000);

    // this is only used for damage trigger
    self.health = balance_health + 999999;

    // balanced health with players
    self.health_phase_max = balance_health;
    self.health_phase = balance_health;

    self.broken = false;
    self.cracked = false;

    self.PhaseFinished = false;

    LUINotifyEvent(#"notify_boss_name", 1, 1);
    LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(self.health_phase / self.health_phase_max));

    // Track last damage time
    self.last_damage_time = GetTime();
    self.white_bar_update_delay = 2.2; // seconds to wait after last damage

    // Only one white bar update thread at a time
    if (!isdefined(self.monitor_white_bar_thread))
        self.monitor_white_bar_thread = self thread MonitorWhiteBarUpdate();

    while(true)
    {
        s_notify = self.e_damage waittill(#"damage");
        n_damage = s_notify.amount;
        w_weapon = s_notify.weapon;
        a_attacker = s_notify.attacker;

        if (!isalive(s_notify.attacker) || !isplayer(s_notify.attacker))
        {
            continue;
        }

        if (isdefined(w_weapon) && zm_weapons::is_wonder_weapon(w_weapon)) {
            n_damage *= 0.45;
        }

        s_notify.attacker util::show_hit_marker();

        if (!self.PhaseFinished)
        {
            self.health_phase -= n_damage;

            // debug
            //self.health_phase -= n_damage + 35000;
        }
        else if (isDefined(a_attacker.has_artifact_buff) && a_attacker.has_artifact_buff)
        {
            n_damage *= 5.5;
            
            // debug
            //n_damage *= 11.5;

            self.health_phase -= n_damage;
        }
        else
            n_damage = 0;
            // no damage for phase 2 if neither, maybe notify an immune damage?

        params = spawnstruct();
        params.einflictor = self;
        params.idamage = n_damage;
        params.idflags = 0;
        params.smeansofdeath = undefined;
        params.weapon = w_weapon;
        params.vpoint = self.origin;
        params.vdir = self.origin;
        params.shitloc = self.origin;
        params.vdamageorigin = self.origin;
        params.psoffsettime = undefined;

        foreach(player in level.players)
        {
            params.eattacker = player;

            player callback::callback(#"on_ai_damage", params);
        }

        // break check, when its cracked, it should enrage the attacks, broken will also do the same but a lot more
        if (!self.IsAttacking)
        {
            if (self.health_phase < (350000 + (players_size * 150000)) && !self.cracked)
            {
                level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_abbfbdff ]](level.var_73f9d759, 0.5);

                self.DoingAnimation = true;

                self BreakEye(1);
                self.cracked = true;

                self scene::play(self.str_scene, "roar", self);

                self animation::stop(0);

                self.DoingAnimation = false;
            }
            else if (self.health_phase < (200000 + (players_size * 100000)) && !self.broken)
            {
                level thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_abbfbdff ]](level.var_ad9b527b);

                self.DoingAnimation = true;

                self BreakEye(2);
                self.broken = true;

                self scene::play(self.str_scene, "roar1", self);

                self animation::stop(0);

                self.DoingAnimation = false;
            }
        }

        LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(self.health_phase / self.health_phase_max));

        // Update last damage time
        self.last_damage_time = GetTime();

        // Reset the white bar update thread if it's waiting
        if (isdefined(self.monitor_white_bar_thread))
        {
            self notify(#"reset_white_bar_timer");
        }

        if (self.health_phase < 0 && !self.IsAttacking && !self.PhaseFinished)
        {
            // sounds or anything?
            level thread lui::screen_flash(0.33, 0.88, 0.33, 0.8, "white");

            playsoundatposition(#"hash_6040f3b85932670c", self.origin);

            // its more like a fake death i guess, maybe re-use it for phase 2.
            //self clientfield::set("bs_bdy_fx_cf", 2);
            //self clientfield::increment("bs_dth_fx_cf", 1);

            level notify(#"enh_end_phase_1");
            self thread scene::play(self.str_scene, "roar2", self);

            self thread SpawnEyeFreezesPhase2();

            wait 2.85;

            self thread [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_leave ]](0);

            ShieldStopAllMusics();

            // red fade
            LUINotifyEvent(#"notify_boss_ui", 1, 4);

            wait 4;

            ShieldPlay(true, true, 2);

            wait 3;

            LUINotifyEvent(#"notify_boss_ui", 1, 5);

            self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_arrive ]](0);

            // hello? can you fucking stop the animation of boss_arrive?
            self animation::stop(0);
            self animation::stop(0);
            self animation::stop(0);
            
            // reset boss health for phase 2
            if (!self.PhaseFinished)
            {
                self.health_phase_max = balance_health;
                self.health_phase = balance_health;

                LUINotifyEvent(#"notify_boss_name", 1, 2);
                LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(self.health_phase / self.health_phase_max));

                self.PhaseFinished = true;

                self animation::stop(0);
                self animation::stop(0);
                self animation::stop(0);

                wait 3;

                // please stop it
                self animation::stop(0);
            }
        }
        else if (self.health_phase < 0 && !self.IsAttacking && self.PhaseFinished)
        {
            self notify(#"stop_attack");
            level notify(#"enh_end_boss_fight");

            level thread zm_utility::zombie_goto_round(255);
            level thread zm_game_module::zombie_goto_round(255);
            
            // sounds or anything?
            playsoundatposition(#"hash_6040f3b85932670c", self.origin);

            scene_init = "zmb_eyeball_vox_outro_s5";
            scene_play = "event_high_impact";

            level thread scene::init_streamer(#"cin_zm_zod_outro", level.teams[#"allies"]);
            level thread lui::screen_flash(0.33, 0.33, 0.33, 0.8, "white");
            level thread scene::stop(#"p8_fxanim_zm_zod_skybox_bundle");
            level util::delay(0.2, undefined, &scene::play, #"p8_fxanim_zm_zod_skybox_bundle", scene_play);

            n_wait = 0.6 * getanimlength(#"hash_24f221de31f87832");
            wait n_wait;

            self.str_scene = #"p8_fxanim_zm_zod_eye_03_bundle";
            
            self clientfield::set("bs_bdy_fx_cf", 2);
            self clientfield::increment("bs_dth_fx_cf", 1);
            self scene::play(self.str_scene, "death", self);

            wait 1.5;

            ShieldStopAllMusics();

            level thread lui::screen_flash(0.88, 5, 0.88, 1, "white");

            wait 3.5;

            LUINotifyEvent(#"notify_boss_name", 1, 0);
            LUINotifyEvent(#"notify_boss_health_meter", 1, 0);

            self.e_damage hide();
            self hide();

            wait 14;

            LUINotifyEvent(#"notify_boss_name", 1, 0);
            LUINotifyEvent(#"notify_boss_health_meter", 1, 0);

            // play outro, from main quest waitings.
            //foreach(player in level.players) player iPrintLnBold("notify flag hash_25d8c88ff3f91ee5");
            level flag::set(#"hash_25d8c88ff3f91ee5");

            wait 0.15;
            
            self.e_damage delete();
            self delete();
            return;
        }
    }
}

BreakEye(eye_break_level)
{
    self endon(#"death");

    if (eye_break_level == 1)
    {
        // level 1
        ShieldLog("eye crack");

        self.var_914750d = 3;
        self clientfield::set("bs_bdy_str_cf", 1);
        util::wait_network_frame(8);
        self clientfield::set("bs_bdy_dmg_fx_cf", 3);
        self scene::play(self.str_scene, "crack", self);
        self animation::stop(0);
        self.str_arrive = "crack_arrive";
        self.str_depart = "crack_leave";
    }
    else
    {
        // level 2
        ShieldLog("eye break");

        self.var_914750d = 2;
        self clientfield::set("bs_bdy_str_cf", 1);
        util::wait_network_frame(8);
        self clientfield::set("bs_bdy_dmg_fx_cf", 2);
        self scene::play(self.str_scene, "break", self);
        self animation::stop(0);
        self.str_arrive = "break_arrive";
        self.str_depart = "break_leave";
    }
}

PlayersUnderEye()
{
    self endon(#"death");

    while(true)
    {
        players = ReturnValidPlayers();
        if(players.size > 0)
        {
            foreach(player in players)
            {
                if(isdefined(player) && isalive(player) && isplayer(player))
                {
                    // Check if player is under the eye
                    if(distance2d(player.origin, self.origin) < 200)
                    {
                        player doDamage(50, self.origin, undefined);
                        player clientfield::set("bs_att_bm_targ_hit_cf", 1);
                        player clientfield::set_to_player("bs_att_bm_targ_frz_fx_cf", 1);
                        player.Freeze_effect = true;
                        player thread FreezeDelay();
                    }
                    else
                    {
                        player.Freeze_effect = false;
                        player thread FreezeDelay();
                    }
                }
            }
        }

        wait 0.50;
    }
}

MonitorWhiteBarUpdate()
{
    self endon(#"death");

    while(true)
    {
        // Wait for reset or timeout
        self waittilltimeout(self.white_bar_update_delay, #"reset_white_bar_timer");

        // If timeout, update white bar
        if (GetTime() - self.last_damage_time >= self.white_bar_update_delay)
        {
            UpdateHealthBarWhiteBoss();
        }
        // Otherwise, loop and wait again
    }
}

UpdateHealthBarWhiteBoss()
{
    self endon(#"death");

    LUINotifyEvent(#"notify_boss_health_meter", 3, 1, ConvertNumToLUI(self.health_phase / self.health_phase_max), ConvertNumToLUI(self.health_phase / self.health_phase_max));
}

CheckMistDamage()
{
    self endon(#"death");

    while(true)
    {
        players = ReturnValidPlayers();
        if(players.size > 0)
        {
            foreach(player in players)
            {
                if(isdefined(player) && isalive(player) && isplayer(player))
                {
                    // Check if player is under the eye
                    if(distance2d(player.origin, self.origin) < 100)
                    {
                        player doDamage(35, self.origin, undefined);
                        player clientfield::set("bs_att_bm_targ_hit_cf", 1);
                        player clientfield::set_to_player("bs_att_bm_targ_frz_fx_cf", 1);
                        player.Freeze_effect = true;
                        player thread FreezeDelay();
                    }
                    else
                    {
                        player.Freeze_effect = false;
                        player thread FreezeDelay();
                    }
                }
            }
        }

        wait 0.1;
    }
}

MoveMistsToPlayer(time, player)
{
    wait randomFloatRange(0.5, 4);
    self thread CheckMistDamage();

    for (i = 0; i < time; i++)
    {
        if (isdefined(player) && zm_utility::is_player_valid(player)) 
        {
            v_moveto = player.origin;
        }
        else
            break;

        self moveto(v_moveto, 0.50);
        self waittill(#"movedone");
    }

    self clientfield::set("winters_wail_slow_field_eye", 0);
    self clientfield::set("" + #"zombshell_aoe", 0);
    playfx(level._effect[#"hash_1eae5969d11a8b16"], self.origin);
    playfx(level._effect[#"teleport_splash"], self.origin);
    util::wait_network_frame(2);
    self delete();
    level notify(#"stop_mist_attack");
}

PerformAttack(player, attack_id)
{
    self endon(#"death", #"stop_attack");

    if(!isdefined(player) || !isdefined(attack_id))
        return;

    //player endon(#"death");
    
    // vo
    if (randomint(100) > 30) {
        [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_abbfbdff ]](array(level.var_d748689e, level.var_99d2b056));
    }

    ShieldLog("going for attack " + attack_id);

    // debug
    //attack_id = 8;

    self.IsAttacking = true;

    switch(attack_id)
    {
        case 0:
            // shoot rockets at player
            wait 0.5;
            
            self playSound(#"hash_1b108a99d8b8a77e");

            self thread scene::play(self.str_scene, "charge", self);

            self clientfield::set("bs_att_bm_cf", 1);
            wait(1);
            self clientfield::set("bs_att_bm_tell_cf", 1);
            wait(0.4);
            self clientfield::set("bs_att_bm_tell_fx_cf", 1);
            wait(0.1);
            self clientfield::set("bs_att_bm_tell_cf", 2);

            n_times = 3;

            if (self.cracked)
            {
                n_times = 5;
            }
            
            if (self.broken)
            {
                n_times = 7;
            }

            for (i = 0; i < n_times && isdefined(player); i++) {
                self SendWeaponMagic("launcher_standard_t8", self, (0, 0, 0), player);
                wait 0.25;
            }

            self clientfield::set("bs_att_bm_tell_fx_cf", 0);
            self clientfield::set("bs_att_bm_cf", 0);
            self clientfield::set("bs_att_mst_tell_cf", 0);

            // need to make it move again sooo
            if (isDefined(self.DoingAnimation) && !self.DoingAnimation)
            {
                self animation::stop(0);
            }
            break;

        case 1:
            // laser attack: spawn a beam that tracks the player and damages if touched
            ShieldLog("starting laser attack");
            
            self playSound(#"hash_1b108a99d8b8a77e");

            // attack logic
            v_loc = player.origin;
            tag = self gettagorigin("tag_fx_beam");
            tagangles = vectortoangles(v_loc - self.origin);
            v_forward = anglestoforward(tagangles);
            a_trace = beamtrace(tag, tag + v_forward * 20000, 0, self, 1, 1);
            pos = a_trace[#"position"];

            [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_3413fdf9 ]](pos);

            wait 0.15;

            self thread scene::play(self.str_scene, "charge", self);

            self clientfield::set("bs_att_bm_cf", 1);
            wait(1);
            self clientfield::set("bs_att_bm_tell_cf", 1);
            wait(0.4);
            self clientfield::set("bs_att_bm_tell_fx_cf", 1);
            wait(0.1);
            self clientfield::set("bs_att_bm_tell_cf", 2);

            self thread TrackLaserBeam();

            n_time = randomIntRange(60, 90);

            if (self.cracked)
            {
                n_time = randomIntRange(80, 110);
            }
            
            if (self.broken)
            {
                n_time = randomIntRange(100, 130);
            }

            for (i = 1; i < n_time; i++) {
                if (isdefined(player) && isdefined(player.angles)) {
                    forward = anglestoforward(player.angles);
                    // Move 50 behind the player
                    behind_origin = player.origin - (forward * 50);
                    level [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_3413fdf9 ]](behind_origin, 0.25);
                } else {
                    break;
                }
            }

            // stop anim
            self clientfield::set("bs_att_bm_tell_fx_cf", 0);
            self clientfield::set("bs_att_bm_cf", 0);
            self clientfield::set("bs_att_mst_tell_cf", 0);

            // need to make it move again sooo
            if (isDefined(self.DoingAnimation) && !self.DoingAnimation)
            {
                self animation::stop(0);
            }

            self notify(#"stop_track_beam");

            thread BeamDelayDelete();
            break;

        case 2:
            // spin attack: go to the middle, spin, then dash to random points near the middle while spinning, throwing stuff too
            ShieldLog("starting spin attack");

            self SetScale(0.01);

            self playSound(#"hash_1b108a99d8b8a77e");

            // Move to the middle point
            middle_point = self.PhaseTrigger ? (-0, -4612, 1600) : (0, 4610, 1600);
            //self.origin = middle_point;
            self.old_origin = self.origin;
            self moveTo(middle_point, 0.75);

            wait 0.75;

            self.angles = (0, randomfloat(360), 0);
            //self thread scene::play(self.str_scene, "charge", self);

            spin_time = randomfloatrange(1.0, 2.0);
            spin_speed = 720; // degrees per second
            elapsed = 0;

            time_grenade = 0.0;
            time_grenade_throw = 0.10;

            if (self.cracked)
            {
                time_grenade_throw = 0.07;
            }
            
            if (self.broken)
            {
                time_grenade_throw = 0.06;
            }

            while (elapsed < spin_time)
            {
                self.angles = (0, self.angles[1] + spin_speed * 0.01, 0);

                if (time_grenade < time_grenade_throw)
                {
                    time_grenade += 0.01;
                }
                else
                {
                    // throw something
                    self thread SpawnBombProjectile(self.origin, randomFloatRange(1, 2.45));
                    time_grenade = 0.0;
                }

                elapsed += 0.01;
                wait 0.01;
            }

            num_dashes = randomIntRange(3, 6);
            for (i = 0; i < num_dashes; i++)
            {
                offset = (randomfloatrange(-600, 600), randomfloatrange(-600, 600), randomfloatrange(-200, 200));
                target_point = middle_point + offset;

                dash_dir = vectortoangles(target_point - self.origin);
                self.angles = (0, dash_dir[1], 0);

                dash_time = 0.5;
                dash_steps = int(dash_time / 0.01);
                start_pos = self.origin;
                for (j = 0; j < dash_steps; j++)
                {
                    frac = j / float(dash_steps);
                    self.origin = start_pos + (target_point - start_pos) * frac;
                    self.angles = (0, self.angles[1] + spin_speed * 0.01, 0);

                    if (time_grenade < time_grenade_throw)
                    {
                        time_grenade += 0.01;
                    }
                    else
                    {
                        // throw something
                        self thread SpawnBombProjectile(self.origin, randomFloatRange(1, 2.45));
                        time_grenade = 0.0;
                    }

                    wait 0.01;
                }
                self.origin = target_point;

                //playFXOnTag(#"zm_weapons/fx8_equip_mltv_fire_human_torso_loop_zm", self, "tag_fx_beam");
                wait 0.05;
            }

            // Return to the middle and stop spinning
            self moveTo(self.old_origin, 0.75);
            wait 0.75;

            self.angles = (0, randomfloat(360), 0);

            self SetScale(1);

            if (isDefined(self.DoingAnimation) && !self.DoingAnimation)
            {
                self animation::stop(0);
            }
            break;

        case 3:
            // follow a target player to damage him if its near
            wait 0.50;

            self.old_origin = self.origin;

            self thread scene::play(self.str_scene, "charge", self);

            self clientfield::set("bs_att_bm_cf", 1);
            wait(1);
            self clientfield::set("bs_att_bm_tell_cf", 1);
            wait(0.4);
            self clientfield::set("bs_att_bm_tell_fx_cf", 1);
            wait(0.1);
            self clientfield::set("bs_att_bm_tell_cf", 2);

            self SetScale(0.01);
            self playSound(#"hash_1b108a99d8b8a77e");

            //self clientfield::set("bs_bdy_dmg_fx_cf", 3);
            self playloopsound(#"hash_3d5a33369bbe2308");

            self.FollowPlayer = player;

            if (isDefined(self.DoingAnimation) && !self.DoingAnimation)
            {
                self animation::stop(0);
            }

            n_times_to_move = randomIntRange(7, 14);
            n_time_to_move = 2;

            if (self.cracked)
            {
                n_times_to_move = randomIntRange(6, 12);
                n_time_to_move = 1.5;
            }
            
            if (self.broken)
            {
                n_times_to_move = randomIntRange(5, 10);
                n_time_to_move = 1;
            }

            for (i = 0; i < n_times_to_move; i++)
            {
                if (isdefined(self.FollowPlayer) && zm_utility::is_player_valid(self.FollowPlayer)) 
                {
                    v_moveto = self.FollowPlayer.origin;
                }
                else
                    break;

                self moveto(v_moveto, n_time_to_move);
                self waittill(#"movedone");
            }

            self stoploopsound(0.5);
            self clientfield::set("bs_bdy_dmg_fx_cf", self.var_914750d);

            self clientfield::set("bs_att_bm_tell_fx_cf", 0);
            self clientfield::set("bs_att_bm_cf", 0);
            self clientfield::set("bs_att_mst_tell_cf", 0);

            self moveTo(self.old_origin, 0.75);
            wait 0.75;

            self SetScale(1);

            if (isDefined(self.DoingAnimation) && !self.DoingAnimation)
            {
                self animation::stop(0);
            }
            break;

        case 4:
        self.old_origin = self.origin;

        self playSound(#"hash_1b108a99d8b8a77e");

        if (isdefined(player) && zm_utility::is_player_valid(player))
        {
            // dash direction: from boss to player (flattened XY)
            dir = player.origin - self.origin;
            dir = (dir[0], dir[1], 0);
            dir = VectorNormalize(dir);

            // entry and exit positions for the dash
            dash_entry = player.origin - dir * 600; // start farther away
            dash_exit  = player.origin + dir * 600; // end farther past player

            // add more height so it flies way above
            dash_entry += (0, 0, 700);
            dash_exit  += (0, 0, 700);

            // move to entry point first
            self moveTo(dash_entry, 0.4);
            wait 0.4;

            // dash across player
            dash_time = 2.0; // total dash duration
            step = 0.05;     // update every 0.05s
            steps = int(dash_time / step);

            for(i = 0; i < steps && isdefined(player); i++)
            {
                frac = i / (steps - 1.0);
                pos = VectorLerp(dash_entry, dash_exit, frac);
                self.origin = pos;

                // always face the player while dashing
                self.angles = vectortoangles(player.origin - self.origin);

                // drop bombs during dash
                if(i % 3 == 0)
                {
                    // drop bomb slightly under current boss position
                    bomb_target = self.origin - (0, 0, -75);
                    self thread SpawnBombProjectile(bomb_target, 0.01);
                }

                wait step;
            }

            // pause a moment then return to old position
            wait 0.15;

            self clientfield::set("bs_bdy_dmg_fx_cf", self.var_914750d);
            self clientfield::set("bs_att_bm_tell_fx_cf", 0);
            self clientfield::set("bs_att_bm_cf", 0);
            self clientfield::set("bs_att_mst_tell_cf", 0);

            self moveTo(self.old_origin, 0.75);

            // look at the player while its moving back
            for (i = 0; i < 15; i++)
            {
                if (isdefined(player) && zm_utility::is_player_valid(player))
                {
                    self.angles = vectortoangles(player.origin - self.origin);
                }
                wait 0.05;
            }
        }

        if (isDefined(self.DoingAnimation) && !self.DoingAnimation)
        {
            self animation::stop(0);
        }
        break;

        case 5:
        // idea, eye shoots a laser beam to the middle_point, where the nuke is and its gonna charge, if you don't damage in-time, then wipe attack?
        ShieldLog("starting wipe small attack");
        
        self playSound(#"hash_1b108a99d8b8a77e");

        // attack logic
        middle_point = self.PhaseTrigger ? (-0, -4612, 1600) : (0, 4610, 1600);

        v_loc = middle_point;

        [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_3413fdf9 ]](v_loc);

        wait 0.15;

        self thread scene::play(self.str_scene, "charge", self);

        self clientfield::set("bs_att_bm_cf", 1);
        wait(1);
        self clientfield::set("bs_att_bm_tell_cf", 1);
        wait(0.4);
        self clientfield::set("bs_att_bm_tell_fx_cf", 1);
        wait(0.1);
        self clientfield::set("bs_att_bm_tell_cf", 2);

        ticking_bomb = util::spawn_model(#"p7_zm_power_up_nuke", middle_point, (0, 0, 0));
        ticking_bomb clientfield::set("winters_wail_slow_field_eye", 1);
        ticking_bomb SetScale(2);
        ticking_bomb solid();
        ticking_bomb thread RotateAndBobItem();

        // use a diff model for tracking damage.
        ticking_bomb_hitbox = util::spawn_model(#"hash_55657a69ddb2f287" + "full", middle_point - (0, 0, 75), (0, 0, 0));
        ticking_bomb_hitbox hide();
        ticking_bomb_hitbox function_2baad8fc();
        ticking_bomb_hitbox.var_6f84b820 = #"boss";
        ticking_bomb_hitbox solid();
        ticking_bomb_hitbox.script_noteworthy = "clip";
        ticking_bomb_hitbox disconnectpaths();
        ticking_bomb_hitbox SetScale(1.4);
        ticking_bomb_hitbox setCanDamage(1);
        ticking_bomb_hitbox.takedamage = 1;

        target_set(ticking_bomb_hitbox);

        n_time_to_wipe = randomIntRange(80, 120);
        health_damage_need = 30000;

        if (self.cracked)
        {
            n_time_to_wipe = randomIntRange(60, 80);
            health_damage_need = 30000 + 8500;
        }
        
        if (self.broken)
        {
            n_time_to_wipe = randomIntRange(40, 60);
            health_damage_need = 30000 + 13500;
        }

        ticking_bomb_hitbox thread MonitorDamageTicking(health_damage_need);

        scale_value = 2;
        b_success = false;

        for (i = 1; i < n_time_to_wipe; i++) {
            level [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_3413fdf9 ]](middle_point, 0.25);

            if (isDefined(ticking_bomb) && isDefined(ticking_bomb_hitbox) && scale_value < 10.0) {
                scale_value += 0.07;

                ticking_bomb SetScale(scale_value);
                //ticking_bomb_hitbox SetScale(scale_value);
            }

            if (!isDefined(ticking_bomb) || !isDefined(ticking_bomb_hitbox))
            {
                b_success = true;
                break;
            }
        }

        if (!b_success)
        {
            self playsound("zmb_eyeball_swrath_burst");
            zm_powerup_nuke::grab_nuke(getplayers()[0]);

            foreach (player in ReturnValidPlayers()) {
                if (!(isdefined(player.hasriotshieldequipped) && player.hasriotshieldequipped)) {
                    player dodamage(player.health + 666, player.origin);
                    continue;
                }
            }

            ticking_bomb delete();
            ticking_bomb_hitbox delete();
        }
        else
        {
            self playsound("zmb_eyeball_swrath_burst");
            self playsound(#"hash_2af120dbf3e870e8");

            ticking_bomb delete();
        }

        // stop anim
        self clientfield::set("bs_att_bm_tell_fx_cf", 0);
        self clientfield::set("bs_att_bm_cf", 0);
        self clientfield::set("bs_att_mst_tell_cf", 0);

        // need to make it move again sooo
        if (isDefined(self.DoingAnimation) && !self.DoingAnimation)
        {
            self animation::stop(0);
        }

        thread BeamDelayDelete();
        break;

        case 6:
        // stun all players?
        self scene::play(self.str_scene, "charge", self);
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_leave ]]();
        
        // electric stun
        foreach(player in level.players)
        {
            player thread EyeStunPlayer(1000, 2);
            player setMoveSpeedScale(0.4);
        }

        wait 2.5;

        // time stun
        foreach(player in level.players)
        {
            player clientfield::set_to_player("" + #"main_flash", 1);
        }

        wait 1.5;

        // time stun
        foreach(player in level.players)
        {
            player clientfield::set_to_player("" + #"main_flash", 1);
        }

        wait 1.5;

        // remove time stun
        foreach(player in level.players)
        {
            player clientfield::set_to_player("" + #"main_flash", 0);
            player setMoveSpeedScale(1);
        }

        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_arrive ]]();
        wait 0.1;

        // need to make it move again sooo
        if (isDefined(self.DoingAnimation) && !self.DoingAnimation)
        {
            self animation::stop(0);
        }
        break;

        case 7:
        // laser attack, but go into random points in circle and shoot and hide, repeat..
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_leave ]]();
        n_times = 3;

        if (self.cracked)
        {
            n_times = 5;
        }
        
        if (self.broken)
        {
            n_times = 8;
        }

        self.old_origin = self.origin;

        wait 2;
        for (i = 0; i < n_times; i++)
        {
            ShieldLog("laser sneak: " + i);
            
            // need to make it move again sooo
            if (isDefined(self.DoingAnimation) && !self.DoingAnimation)
            {
                self animation::stop(0);
            }

            self playSound(#"hash_1b108a99d8b8a77e");

            // choose a random point in PI circle
            orbit_radius = 1200;
            orbit_height = 400;

            player_origin = player.origin;
            orbit_pos_init = self.PhaseTrigger ? (-0, -4612, 979) : (0, 4610, 1090);

            angle = randomfloat(360);
            offset_vec = (cos(angle) * orbit_radius, sin(angle) * orbit_radius, orbit_height);
            orbit_pos = orbit_pos_init + offset_vec;

            self.origin = orbit_pos;
            self.angles = vectortoangles(player_origin - self.origin);

            ShieldLog("laser sneak: " + i + " | origin: " + self.origin);

            self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_arrive ]]();

            // attack logic
            v_loc = player.origin;
            tag = self gettagorigin("tag_fx_beam");
            tagangles = vectortoangles(v_loc - self.origin);
            v_forward = anglestoforward(tagangles);
            a_trace = beamtrace(tag, tag + v_forward * 20000, 0, self, 1, 1);
            pos = a_trace[#"position"];

            [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_3413fdf9 ]](pos);

            self thread scene::play(self.str_scene, "charge", self);

            self clientfield::set("bs_att_bm_cf", 1);
            wait(0.5);
            self clientfield::set("bs_att_bm_tell_cf", 1);
            wait(0.3);
            self clientfield::set("bs_att_bm_tell_fx_cf", 1);
            wait(0.1);
            self clientfield::set("bs_att_bm_tell_cf", 2);

            self thread TrackLaserBeam();

            n_time = 20;
            for (j = 1; j < n_time; j++) {
                if (isdefined(player) && isdefined(player.angles)) {
                    forward = anglestoforward(player.angles);
                    // Move 50 behind the player
                    behind_origin = player.origin - (forward * 50);
                    level [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_3413fdf9 ]](behind_origin, 0.25);
                } else {
                    break;
                }
            }

            // stop anim
            self clientfield::set("bs_att_bm_tell_fx_cf", 0);
            self clientfield::set("bs_att_bm_cf", 0);
            self clientfield::set("bs_att_mst_tell_cf", 0);

            self notify(#"stop_track_beam");
            thread BeamDelayDelete();

            self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_leave ]]();
            wait 1.5;
        }
        
        self.origin = self.old_origin;
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_arrive ]]();
        wait 0.1;

        if (isDefined(self.DoingAnimation) && !self.DoingAnimation)
        {
            self animation::stop(0);
        }
        break;

        case 8:
        // spawns a bunch of mists that follow players and freeze/damage them? look in function_47073904 for ref.
        self thread scene::play(self.str_scene, "charge", self);

        self clientfield::set("bs_att_bm_cf", 1);
        wait(1);
        self clientfield::set("bs_att_bm_tell_cf", 1);
        wait(0.4);
        self clientfield::set("bs_att_bm_tell_fx_cf", 1);
        wait(0.1);
        self clientfield::set("bs_att_bm_tell_cf", 2);

        self.FollowPlayer = player;

        // spawn mists
        mists_spawned = array();
        for (i = 0; i < 3; i++)
        {
            mist = util::spawn_model(#"hash_55657a69ddb2f287" + "dmg_02", self.origin);
            mist clientfield::set("powerup_fx", 2);
            mist clientfield::set("" + #"hash_3400ccffbd3d73b3", 3);
            mist clientfield::set("winters_wail_slow_field_eye", 1);
            mist clientfield::set("highlight_shit", 1);
            mist clientfield::set("" + #"zombshell_aoe", 1);
            mists_spawned[mists_spawned.size] = mist;
        }

        n_time = 14;

        if (self.cracked)
        {
            n_time = 23;
        }
        
        if (self.broken)
        {
            n_time = 29;
        }

        foreach(mist in mists_spawned)
        {
            mist thread MoveMistsToPlayer(n_time, self.FollowPlayer);
        }

        // stop anim
        self clientfield::set("bs_att_bm_tell_fx_cf", 0);
        self clientfield::set("bs_att_bm_cf", 0);
        self clientfield::set("bs_att_mst_tell_cf", 0);

        wait 0.5;

        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_leave ]]();
        level waittill(#"stop_mist_attack");
        self notify(#"stop_looking");
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_arrive ]]();

        wait 0.5;
        if (isDefined(self.DoingAnimation) && !self.DoingAnimation)
        {
            self animation::stop(0);
        }
        break;

        case 9:
        // troll attack, just go invis and appear second after secs
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_leave ]]();

        n_wait_time = 8;

        if (self.cracked)
        {
            n_wait_time = 11;
        }
        
        if (self.broken)
        {
            n_wait_time = 15;
        }

        wait n_wait_time;
        self [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::boss_arrive ]]();
        wait 0.5;

        if (isDefined(self.DoingAnimation) && !self.DoingAnimation)
        {
            self animation::stop(0);
        }
        break;

        default:
        ShieldLog("no attack for " + attack_id);
        break;
    }

    self.IsAttacking = false;
}

EyeStunPlayer(time, times)
{
    player = self;
    for (i = 0; i < times; i++)
    {
        blind_status_effect = getstatuseffect("blind_zm_catalyst");
        player status_effect::status_effect_apply(blind_status_effect, undefined, player, 0, time);
        player util::delay(1.3, undefined, &zm_audio::create_and_play_dialog, #"catalyst_radiant_scream", #"react");
        wait float(time) / 1000;
        if (player status_effect::function_4617032e(blind_status_effect.setype)) {
            player status_effect::function_408158ef(blind_status_effect.setype, blind_status_effect.var_18d16a6b);
        }
        util::wait_network_frame();
        player status_effect::status_effect_apply(getstatuseffect("deaf_electricity_catalyst"), undefined, player, 0, time);
        wait float(time) / 1000;
        player [[ @zm_ai_catalyst<scripts\zm\ai\zm_ai_catalyst.gsc>::function_73961a38 ]]();
    }
}

BeamDelayDelete()
{
    wait 1;

    level.var_90bda347 delete();
}

MonitorDamageTicking(health_needed)
{
    self endon(#"death");

    self.health = health_needed + 999999;
    self.health_tick = health_needed;

    while (true) {
        s_notify = self waittill(#"damage");
        n_damage = s_notify.amount;
        w_weapon = s_notify.weapon;
        a_attacker = s_notify.attacker;

        if (isPlayer(a_attacker))
        {
            a_attacker util::show_hit_marker();
        }
        else
            continue;

        self.health_tick -= n_damage;
    
        params = spawnstruct();
        params.einflictor = self;
        params.idamage = n_damage;
        params.idflags = 0;
        params.smeansofdeath = undefined;
        params.weapon = w_weapon;
        params.vpoint = self.origin;
        params.vdir = self.origin;
        params.shitloc = self.origin;
        params.vdamageorigin = self.origin;
        params.psoffsettime = undefined;

        foreach(player in level.players)
        {
            params.eattacker = player;

            player callback::callback(#"on_ai_damage", params);
        }

        if (self.health_tick <= 0) {
            self delete();
        }
    }
}

SpawnBombProjectile(origin, throw_power)
{
    if (!isdefined(origin) || !isdefined(throw_power)) {
        return;
    }

    ticking_bomb = util::spawn_model(#"p7_zm_power_up_nuke", origin, (0, 0, 0));
    ticking_bomb clientfield::set("powerup_fx", 2);
    
    ticking_bomb physicslaunch
    (
        ticking_bomb.origin, 
        vectorscale((randomFloatRange(0.15, 0.45) * throw_power, randomFloatRange(0.15, 0.45) * throw_power, randomFloatRange(0.15, 0.45) * throw_power),
        64)
    );

    ticking_bomb thread StartTicking();
}

StartTicking()
{
    self endon(#"death");

    wait 2;

    // explode
    for (i = 0; i < 4; i++)
    {
        self SendWeaponMagic("launcher_standard_t8", self, (0, 0, 0), self, true);

        wait 0.15;
    }

    self delete();
}

TrackLaserBeam()
{
    self endon(#"death", #"stop_track_beam");

    while (true) {
        v_source = self gettagorigin("tag_fx_beam");
        v_target = level.var_90bda347.origin;
        a_beamtrace = beamtrace(v_source, v_target, 0, self, 1, 1);
        distance = distance(v_source, a_beamtrace[#"position"]);
        //var_78d7b8bf = distance * distance;
        a_players = array::get_all_closest(v_source, ReturnValidPlayers(), undefined, undefined, distance);
        if (a_players.size <= 0) {
            foreach (player in ReturnValidPlayers()) {
                player notify(#"hash_27a44c71de4b4cb8");
                player.var_39ef0b7f = 0;
            }
            util::wait_network_frame();
            continue;
        }
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
        players_array = [];
        foreach (player in a_players) {
            if (zm_utility::is_player_valid(player) && !player issliding()) {
                var_7cb315bb = player getcentroid();
                v_player_origin = player getorigin();
                var_67b0f6b1 = distancesquared(v_source, var_7cb315bb);
                var_cf64e11c = distancesquared(v_source, v_player_origin);
                var_3c71dedb = pointonsegmentnearesttopoint(v_source, v_target, var_7cb315bb);
                var_c526df5a = pointonsegmentnearesttopoint(v_source, v_target, v_player_origin);
                b_is_valid_target = 0;
                if (distancesquared(var_7cb315bb, var_3c71dedb) <= 324 || distancesquared(v_player_origin, var_c526df5a) <= 324) {
                    b_is_valid_target = 1;
                } else {
                    foreach (str_tag in tag_array) {
                        v_hitloc = player gettagorigin(str_tag);
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
            }
            if (isdefined(b_is_valid_target) && b_is_valid_target) {
                if (!isdefined(players_array)) {
                    players_array = [];
                } else if (!isarray(players_array)) {
                    players_array = array(players_array);
                }
                players_array[players_array.size] = player;
            }
            else
            {
                player.Freeze_effect = false;
                player thread FreezeDelay();
            }
        }
        if (players_array.size > 0) {
            foreach (player in players_array) {
                if (!zm_utility::is_player_valid(player)) {
                    continue;
                }
                if (isdefined(player)) {
                    player doDamage(85, player.origin, undefined);
                    player clientfield::set("bs_att_bm_targ_hit_cf", 1);
                    player clientfield::set_to_player("bs_att_bm_targ_frz_fx_cf", 1);
                    player.Freeze_effect = true;
                    player thread FreezeDelay();
                }
            }
        }
        util::wait_network_frame();
    }
}

FreezeDelay()
{
    self endon(#"death");

    wait 0.5;

    if (!self.Freeze_effect)
    {
        self clientfield::set("bs_att_bm_targ_hit_cf", 0);
        self clientfield::set_to_player("bs_att_bm_targ_frz_fx_cf", 0);
    }
}