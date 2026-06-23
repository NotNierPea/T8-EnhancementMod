// this is a pretty bad hardcore boss fight, needs to be done more.

detour mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_5c5680f5(b_skipped)
{
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_5c5680f5 ]](b_skipped);

    //iPrintLnBold("hardcore init..");

    while(zm_round_logic::get_round_number() < 255 && !GetDvarInt(#"shield_enh_DirectedMode", 0)) {
        ShieldLog("switch round");

        level thread zm_utility::zombie_goto_round(255);
        level thread zm_game_module::zombie_goto_round(255);

        wait 0.15;
    }

    level notify(#"rampage_off");

    level.zombie_vars["zombie_max_ai"] = 30;
    level.zombie_ai_limit = 30;
    level.zombie_actor_limit = 30;

    level.disable_nuke_delay_spawning = 1;
    level.zombie_round_start_delay = 0;

    level.zombie_vars["zombie_spawn_delay"] = 0; // zombies delay remove 0
    level.zombie_vars["zombie_between_round_time"] = 0; // 3enh_achv_hardcore_tag

    zombie_utility::set_zombie_var(#"zombie_spawn_delay", 0);
    zombie_utility::set_zombie_var(#"zombie_between_round_time", 0);

    // super sprint mode
    level.var_43fb4347 = "super_sprint";

    level endon(#"end_game", #"intermission");
    level flag::set("spawn_zombies");
    level flag::set("zombie_drop_powerups");
    level flag::clear(#"disable_fast_travel");
    level flag::clear("pause_round_timeout");
    level flag::set(#"boss_fight_started");

    zm_zonemgr::enable_zone("zone_arena");

    level zm_bgb_anywhere_but_here::function_886fce8f(0);

    if (!(isdefined(level.var_ef54ff59) && level.var_ef54ff59)) {
        level.var_ef54ff59 = 1;
        [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::init_traps ]]();
        [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::init_boss ]]();
        [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::init_spawns ]]();
    }

    callback::on_spawned(@mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_92a12286);
    level.var_eeb98313 = @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_714f8756;
    level.custom_spawnplayer = @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_9bc4f8cb;
    level.disable_nuke_delay_spawning = 1;
    level notify(#"disable_nuke_delay_spawning");
    level.var_d6f059f7 = 255;
    zm_transform::function_e95ec8df();
    level.var_c9f5947d = 1;
    level notify(#"force_transformations");
    level [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_ae76e58d ]]();
    level thread [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_482a7a01 ]]();
    level.var_b106cd7a = @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_de5e2c78;
    //level.var_7e40409b = @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_83275bc3;
    clientfield::set("" + #"hash_2709d50a7b0a2b01", 1);
    level thread scene::init_streamer(#"aib_t8_zm_mnsn_hallion_intro", #"allies", 0, 0);
    level boss_teleport_players_dotn();

    level thread OverrideQuest(#"zm_mansion_ww", #"step_1", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"zm_mansion_ww", #"step_2", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"zm_mansion_ww", #"step_3", &FreeSkipClean, &FreeSkipClean);

    level waittill(#"end_boss_call");

    wait 5;

    // ? continue as normal to get stats...

    // disable teleporting back to boss arena shit
    //a_players = util::get_active_players();
    //foreach (player in a_players) {
        //player thread [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_92a12286 ]]();
    //}

    //if (!b_skipped) {
    //    [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::boss_intro ]](1);
    //    level [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_bb612e31 ]](1, 16000);
    //}
}

boss_teleport_players_dotn()
{
    level endon(#"end_game", #"intermission");

    foreach (player in util::get_active_players()) {
        if (isdefined(player) && isdefined(player.playernum)) {
            player thread teleport_player_dotn();
        }
    }

    zm_utility::function_9ad5aeb1(0, 1, 0, 0);

    level zm_vo::function_3c173d37();
    level zm_audio::sndvoxoverride(1);
    wait 1.3;
    level util::delay(5.9, undefined, &intro_dotn);
    var_45e1b44b = level.s_boss.var_dcaafc8e[3];
    var_45e1b44b thread scene::play(#"aib_t8_zm_mnsn_hallion_intro");
    level thread [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_52818528 ]]();
    level notify(#"hash_4b195fabca6f5aaf");
    util::wait_network_frame();
    var_45e1b44b.scene_ents[#"fakeactor 1"] thread [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_8d29523e ]](#"boss_visible");
    var_45e1b44b.scene_ents[#"fakeactor 1"] thread [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_8d29523e ]](#"boss_invisible");
    var_45e1b44b.scene_ents[#"fakeactor 1"] [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_d84758c ]]();
    wait 0.2;
    level notify(#"hash_1b248026aeb05066");
    level.var_b88cf121 = 1;
    level zm_audio::sndvoxoverride(0);
    
    // uis..
    LUINotifyEvent(#"notify_boss_name", 1, 18);
    LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(100 / 100));
}

intro_dotn()
{
    level.musicsystemoverride = 1;
    music::setmusicstate("boss");

    foreach(player in level.players)
    {
        player bgb::take();
        player bgb_pack::function_ac9cb612(1);
        player bgb::suspend_weapon_cycling();
        player.bgb_disabled = 1;
    }

    // spawn wolf
    ai_wolf = undefined;
    while(true)
    {
        ai_wolf = [[ @zombie_werewolf_util<scripts\zm_common\util\ai_werewolf_util.gsc>::function_47a88a0c ]](1, undefined, 1, undefined, 254);
        if (isalive(ai_wolf)) {
            ai_wolf.no_powerups = 1;
            ai_wolf zm_score::function_acaab828();
            ai_wolf.script_noteworthy = "angry_werewolf";
            ai_wolf.var_126d7bef = 1;
            ai_wolf.ignore_round_spawn_failsafe = 1;
            ai_wolf.ignore_enemy_count = 1;
            ai_wolf.b_ignore_cleanup = 1;
            ai_wolf thread [[ @namespace_a8113e97<scripts\zm\zm_mansion_ley_line.gsc>::function_d89f5961 ]](); // speak
            break;
        }

        util::wait_network_frame(1);
    }

    wait 0.25;
    for (i = 0; i < 30; i++)
    {
        ai_wolf ForceTeleport((-66.8849, 2634.59, -283.663), (0, 0, 0));
        wait 0.1;
    }

    // model, effects
    ai_wolf setModel(#"hash_3df2c3496c6a62fd"); // invisible lol?
    ai_wolf thread HintLocation_Wolf();

    // speed up
    ai_wolf thread FasterWolf();

    // damage
    aiutility::addaioverridedamagecallback(ai_wolf, &wolf_callback_damage);
    ai_wolf thread MonitorHealth_Wolf();

    // debug
    level.e_wolf = ai_wolf;

    // spawns
    level thread SpawnWolfNShit();
}

FasterWolf()
{
    self endon(#"death");

    while(true)
    {
        // faster if true
        self asmsetanimationrate((isDefined(self.phase_trigger) && self.phase_trigger) ? 1.40 : 1.25);
        wait 0.5;
    }
}

HintLocation_Wolf()
{
    self endon(#"death");

    //self thread scene::play(#"aib_t8_zm_mnsn_hallion_stun", "init");
    self animation::stop(0);

    str_clientfield = "" + #"hash_87483ed44cb2791";
    self clientfield::set(str_clientfield, 1);
    str_clientfield = "" + #"hash_69c1868b7a8a7beb";
    self clientfield::set(str_clientfield, 1);
    self clientfield::set("" + #"hash_1bf2c2f62ad1bf56", 1);
    self show();
    
    while(true)
    {
        self clientfield::set("zm_aat_brain_decay", randomIntRange(0, 2));
        wait randomFloatRange(15, 35);
    }
}

SpawnWolfNShit()
{
    level endon(#"end_boss_call");

    while(true)
    {
        ai_wolf = [[ @zombie_werewolf_util<scripts\zm_common\util\ai_werewolf_util.gsc>::function_47a88a0c ]](1, undefined, 1, undefined, 254);
        if (isalive(ai_wolf)) {
            ai_wolf.no_powerups = 1;
            ai_wolf zm_score::function_acaab828();
            ai_wolf.script_noteworthy = "angry_werewolf";
            ai_wolf.var_126d7bef = 1;
            ai_wolf.ignore_round_spawn_failsafe = 1;
            ai_wolf.ignore_enemy_count = 1;
            ai_wolf.b_ignore_cleanup = 1;
        }
        
        for(i = 0; i < 3; i++)
        {
            ai_nosferatu = [[ @zm_ai_nosferatu<scripts\zm\ai\zm_ai_nosferatu.gsc>::function_74f25f8a ]](1, undefined, 1, 254);
            if (isalive(ai_nosferatu)) 
            {
                ai_nosferatu.var_85480576 = 1;
            }
        }

        wait randomFloatRange(15, 55);
    }
}

MonitorHealth_Wolf()
{
    self endon(#"death");

    // avoid dying normally
    self.maxhealth = 999999999 + 1;
    self.health = 999999999;

    // balance health depending on players size
    players_size = (GetPlayers().size - 1);
    balance_health = 1280000 + (players_size * 250000);

    // balanced health with players
    self.health_phase_max = balance_health;
    self.health_phase = balance_health;

    // phase trigger
    self.phase_trigger = false;
    self.max_given = false;

    // Track last damage time
    self.last_damage_time = GetTime();
    self.white_bar_update_delay = 2.2; // seconds to wait after last damage

    // Only one white bar update thread at a time
    if (!isdefined(self.monitor_white_bar_thread))
        self.monitor_white_bar_thread = self thread MonitorWhiteBarUpdate();

    LUINotifyEvent(#"notify_boss_name", 1, 18);
    LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(self.health_phase / self.health_phase_max));
    
    while(true)
    {
        level waittill(#"wolf_damaged");

        // Update last damage time
        self.last_damage_time = GetTime();

        // Reset the white bar update thread if it's waiting
        if (isdefined(self.monitor_white_bar_thread))
        {
            self notify(#"reset_white_bar_timer");
        }

        // free max ig
        if (!self.max_given && (self.health_phase < (self.health_phase_max / 2)))
        {
            level lui::screen_fade_out(0.5);
            level zm_powerup_full_ammo::grab_full_ammo(getplayers()[0]);
            level lui::screen_fade_in(0.1);
            
            self.max_given = true;
            self.phase_trigger = true;

            level.zombie_vars["zombie_max_ai"] = 36;
            level.zombie_ai_limit = 36;
            level.zombie_actor_limit = 36;
        }

        if (self.health_phase < 0)
        {
            level thread lui::screen_flash(0.4, 2, 0.8, 1, "white");
            playsoundatposition(#"evt_nuke_flash", (0, 0, 0));
            
            // end boss fight..
            level flag::set(#"hash_25d8c88ff3f91ee5");

            music::setmusicstate("none");
            level.musicsystemoverride = 0;

            level flag::clear("spawn_zombies");
            level flag::clear("zombie_drop_powerups");
            level flag::clear(#"disable_fast_travel");
            level flag::set("pause_round_timeout");

            LUINotifyEvent(#"notify_boss_name", 1, 0);
            LUINotifyEvent(#"notify_boss_health_meter", 1, 0);

            ai_team = getaiteamarray(level.zombie_team);
            foreach (ai in ai_team) {
                if (isalive(ai) && !(isdefined(ai.var_d45ca662) && ai.var_d45ca662) && !(isdefined(ai.marked_for_death) && ai.marked_for_death) && !(isdefined(ai.b_ignore_cleanup) && ai.b_ignore_cleanup)) {
                    if (zm_utility::is_magic_bullet_shield_enabled(ai)) {
                        ai util::stop_magic_bullet_shield();
                    }
                    ai.allowdeath = 1;
                    ai.no_powerups = 1;
                    ai.deathpoints_already_given = 1;
                    ai.marked_for_death = 1;
                    ai dodamage(ai.health + 666, ai.origin);
                }
            }

            level.var_eeb98313 = undefined;
            level.custom_spawnplayer = undefined;
            level.disable_nuke_delay_spawning = 0;

            level thread [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_50aa79cf ]]();
            level thread [[ @mansion_boss_ww<scripts\zm\zm_mansion_boss_ww.gsc>::function_c11a9d59 ]]();

            level notify(#"end_boss_call");

            self animation::stop(0);
            self ai::stun();
            self scene::play(#"aib_t8_zm_mnsn_hallion_death");
            self dodamage(self.health + 666, self.origin);
            return;
        }
    }
}

wolf_callback_damage(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    damage_retr = 0;

    if ((isDefined(damage) && isDefined(attacker)) && self.health_phase > 0)
    {
        // health bar logic
        if (damage > 15000)
            damage = 15000;

        if ((isDefined(weapon) && weapon.weapclass === "rocketlauncher") || zm_loadout::is_hero_weapon(weapon))
            damage *= 0.15;
        
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

        LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(self.health_phase / self.health_phase_max));
        level notify(#"wolf_damaged");
    }

    return damage_retr;
}

teleport_player_dotn()
{
    level endon(#"intermission", #"end_game");
    self endon(#"disconnect", #"death");
    self.dontspeak = 1;
    self lui::screen_fade_out(1);

    if (zm_utility::is_player_valid(self, 0, 0)) {
        self setorigin((4.48003, 2140.72, -304.875));
        self setplayerangles((0, 90, -0));
    }

    self val::set("bossfight_intro", "freezecontrols", 1);
    self val::set("bossfight_intro", "disable_weapons", 1);
    level waittill(#"hash_4b195fabca6f5aaf");
    self thread lui::screen_fade_in(0.1);
    level waittill(#"hash_1b248026aeb05066");
    self val::reset("bossfight_intro", "freezecontrols");
    self val::reset("bossfight_intro", "disable_weapons");

    self.dontspeak = 0;
}