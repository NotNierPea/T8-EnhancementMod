Hardcore_BOTD_Init()
{
    level thread OverrideQuest(#"paschal_quest", #"6", &hardcore_step_6);
    level thread OverrideQuest(#"paschal_quest", #"7", &hardcore_step_7);
}

hardcore_step_6(b_skipped)
{
    ShieldLog("^1hardcore_step_6");

    while(zm_round_logic::get_round_number() < 255 && !GetDvarInt(#"shield_enh_DirectedMode", 0)) {
        ShieldLog("switch round");

        level thread zm_utility::zombie_goto_round(255);
        level thread zm_game_module::zombie_goto_round(255);

        wait 0.15;
    }

    showmiscmodels("mechanical_chair");
    mdl_chair = getent("mechanical_chair", "targetname");
    mdl_chair show();
    level thread scene::play(#"p8_zm_esc_dark_machine_bundle", "IDLE");
    exploder::kill_exploder("fxexp_poison_ambient");
    exploder::exploder("lgtexp_bossArena_on");
    zm_bgb_anywhere_but_here::function_886fce8f(0);
    
    [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::boss_fight_setup ]]();

    level zm_ui_inventory::function_7df6bb60(#"zm_escape_paschal", 6);
    level thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_fd915ab5 ]]();
    level.var_8b4ac110 = 256;
    if (!b_skipped) {
        var_3ded86ce = [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_708bfb60 ]]();
        scene::add_scene_func(#"aib_vign_zm_mob_brutus_boss_ghost_intro", @paschal<scripts\zm\zm_escape_paschal.gsc>::boss_intro, "play");
        scene::add_scene_func(#"aib_vign_zm_mob_brutus_boss_ghost_intro", @paschal<scripts\zm\zm_escape_paschal.gsc>::_cover_challenge_reward_timeout, "done");
        level scene::play(#"aib_vign_zm_mob_brutus_boss_ghost_intro", var_3ded86ce);
    }
    level.musicsystemoverride = 1;

    // remove later, replace with custom music.
    //music::setmusicstate("boss");
    ShieldPlay(true, true, 90);

    LUINotifyEvent(#"notify_boss_ui", 1, 4);

    wait 1.5;

    foreach(player in level.players)
    {
        player bgb::take();
        player bgb_pack::function_ac9cb612(1);
        player bgb::suspend_weapon_cycling();
        player.bgb_disabled = 1;
    }

    //ShieldPlay(true, true, 3);

    LUINotifyEvent(#"notify_boss_ui", 1, 5);

    LUINotifyEvent(#"notify_boss_name", 2, 11, 1);
    LUINotifyEvent(#"notify_boss_health_meter", 2, 1, 100);

    level.var_5816975b = @paschal<scripts\zm\zm_escape_paschal.gsc>::function_ea25ff10;
    changeadvertisedstatus(0);
    [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_5022ff9d ]]();

    level thread ExtendBOTDPhases();

    // spawn fake special brutus
    level thread SpawnSpecialBrutus(true);

    if (!b_skipped) {
        BrutusSpawningInsanity(2, 4);
        while (!isdefined(level.var_b1312d49)) {
            wait 1.6;
            BrutusDoSpecialAttack();
            if (!isdefined(level.var_b1312d49)) {
                wait 6.1;
                BrutusSpawningInsanity(2, 8, 3);
            }
        }
    }

    foreach (player in getplayers()) {
        player bgb_pack::function_ac9cb612(0);
        player bgb::resume_weapon_cycling();
        player.bgb_disabled = 0;
    }
}

hardcore_step_7(b_skipped)
{
    ShieldLog("^1hardcore_step_7");

    level zm_ui_inventory::function_7df6bb60(#"zm_escape_paschal", 7);
    level thread scene::init_streamer(#"hash_641ed02ad1d85897", #"allies", 0, 0);

    ShieldStopAllMusics();
    //music::setmusicstate("none");

    level.musicsystemoverride = 0;
    if (!b_skipped) {
        level thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_77cf4d4a ]]();
        level flag::wait_till(#"dm_ready");
        level waittilltimeout(6.1, #"hash_1b4b6ce05cb62d56");
        
        level.musicsystemoverride = 1;
        ShieldPlay(true, true, 90);
        //music::setmusicstate("boss");

        level thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_108ff870 ]]();
        level thread BrutusSpawningInsanity(2, -1, 3, 1);
        level flag::wait_till(#"main_quest_completed");

        ShieldStopAllMusics();
    }
}

SpawnSpecialBrutus(is_clone = true)
{
    if (!is_clone && isDefined(level.Clone_Brutus))
    {
        level.Clone_Brutus delete();
    }

    wait 0.1;

    target_spawner = getent("spawner_zm_brutus_special", "targetname");
    brutus_special = zombie_utility::spawn_zombie(target_spawner);

    while (!isdefined(brutus_special)) {
        brutus_special = zombie_utility::spawn_zombie(target_spawner);
        waitframe(1);
    }

    if (!is_clone)
    {
        // update ui
        LUINotifyEvent(#"notify_boss_name", 1, 12);
        brutus_special thread UpdateBrutusHealthBar();
    }
    else
    {
        level.Clone_Brutus = brutus_special;
    }

    brutus_special.health = int(ceil(2961 / (4 - util::get_active_players().size - 1)));
    brutus_special.b_ignore_cleanup = 1;
    brutus_special thread [[ @zombie_brutus_util<script_7c62f55ce3a557ff.gsc>::brutus_spawn ]](undefined, undefined, undefined, undefined, "zone_west_side_exterior_upper_03");
    brutus_special.var_ece4a895 = @paschal<scripts\zm\zm_escape_paschal.gsc>::function_bba62242;
    brutus_special ai::set_behavior_attribute("can_ground_slam", 1);
    brutus_special.var_db8b3627 = 1;
    brutus_special.script_noteworthy = "spawner_zm_brutus_special_ai";
    brutus_special clientfield::set("" + #"hash_df589cc30f4c7dd", 1);
    brutus_special val::set(#"boss_special", "takedamage", 0);
    level notify(#"hash_7fbbfdf42f9d741");
    brutus_special thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_81771803 ]]();
    level waittill(#"raise_fire");

    if (isDefined(brutus_special))
    {
        brutus_special clientfield::set("" + #"hash_df589cc30f4c7dd", 0);
        brutus_special ai::stun(2.9);
        level.var_b491030 = 1;
        brutus_special val::reset(#"boss_special", "takedamage");
    }
    else
        return;

    if (!is_clone)
    {
        // buff health
        brutus_special.health *= 700;
        brutus_special.maxhealth *= 700;

        brutus_special waittill(#"death");
        level.var_dcff743c = 0;

        // finish everything else
        level flag::set(#"main_quest_completed");
    }
}

UpdateBrutusHealthBar()
{
    level notify(#"stop_orb_healthbar");

    self endon(#"death");

    MainTimeRed = getTime();
    MainTimeWhite = getTime();

    while(true)
    {
        LUINotifyEvent(#"notify_boss_name", 1, 12);

        Health = self.health;
        if(MainTimeRed < getTime() - 225) // 264,000 -> 22 orbs and everyone of those has 12,000 health...
        {
            LUINotifyEvent(#"notify_boss_health_meter", 2, 1, int(100 * Health / self.maxhealth)); // 3 * 12000 -> 3000 * 4 -> max health
            MainTimeRed = GetTime();
        }

        // white one
        if(MainTimeWhite < getTime() - 425)     
        {
            LUINotifyEvent(#"notify_boss_health_meter", 3, 1, int(100 * Health / self.maxhealth), int(100 * Health / self.maxhealth));
            MainTimeWhite = GetTime();
        }

        util::wait_network_frame(1);
    }
}

Return1(e_powerup) // delay timeout
{
    return 1;
}

ExtendBOTDPhases()
{
    level.var_43fb4347 = "super_sprint";
    level.brutus_round_count = 9;
    level.zombie_vars["zombie_max_ai"] = 40;
    level.zombie_ai_limit = 40;
    level.zombie_actor_limit = 40;
    level.var_977f68ea = &Return1; // powerups delay remove

    Times = 1;
    level thread OrbsHealthLogic();

    while(Times < 3)
    {
        if (level.var_a36cbfaf == 1)
        {
            wait 0.1;
            level.var_a36cbfaf = 0;
            Times++;

            LUINotifyEvent(#"notify_boss_name", 2, 11, Times);

            wait 5;
            level flag::set("zombie_drop_powerups");
        }
        wait 2;
    }
    wait 1;
    
    while(level.var_a36cbfaf != 1)
    {
        wait 1;
    }

    LUINotifyEvent(#"notify_boss_name", 2, 11, 4);

    wait 5;

    level flag::set("zombie_drop_powerups");

    while(level.var_a36cbfaf != 2)
    {
        wait 1;
    }

    LUINotifyEvent(#"notify_boss_name", 2, 11, 5);

    wait 5;
    level flag::set("zombie_drop_powerups");
}

OrbsHealthLogic() // display orbs health bar? not really for now ig
{
    level endon(#"stop_orb_healthbar");

    if(!isDefined(level.s_orbs)) level.s_orbs = [];
    for (i = 0; i <= 21; i++)
     level.BloodOrbMainH[i] = 0;
    
    MainTimeWhite = GetTime();
    MainTimeRed = GetTime();

    while(true)
    {
        for (i = 0; i <= 21; i++)
        {
            if(isDefined(level.s_orbs[i]) && !level.s_orbs[i].done_h)
                level.BloodOrbMainH[i] = level.s_orbs[i].health;
            else
                level.BloodOrbMainH[i] = 0;
        }

        level.BloodOrbsHealth = 0; // reset it
        for (i = 0; i <= 21; i++)
         level.BloodOrbsHealth += level.BloodOrbMainH[i];

        OrbsHealthBox = level.BloodOrbsHealth;
        if(MainTimeRed < getTime() - 225) // 264,000 -> 22 orbs and everyone of those has 12,000 health...
        {
            LUINotifyEvent(#"notify_boss_health_meter", 2, 1, int(100 * OrbsHealthBox / 264000)); // 3 * 12000 -> 3000 * 4 -> max health
            MainTimeRed = GetTime();
        }

        // white one
        if(MainTimeWhite < getTime() - 425)     
        {
            LUINotifyEvent(#"notify_boss_health_meter", 3, 1, int(100 * OrbsHealthBox / 264000), int(100 * OrbsHealthBox / 264000));
            MainTimeWhite = GetTime();
        }
 
        util::wait_network_frame(1);
    }
}

BrutusSpawningInsanity(hash, n_brutus = 0, hash3 = 0, hash4 = 0, n_zombies_max)
{
    level endon(#"end_game", #"game_ended", #"main_quest_completed");

    hash3A = isdefined(hash3) ? hash3 : "undefined..";
    hash4A = isdefined(hash4) ? hash4 : "undefined..";
    n_zombies_maxA = isdefined(n_zombies_max) ? n_zombies_max : "undefined..";

    ShieldLog("^BrutusSpawningInsanity Called -> " + hash + " -> " + n_brutus + " -> " + hash3A + " -> " + hash4A + " -> " + n_zombies_maxA);

    times = 40;
    level.var_dcff743c = 1;
    level.n_brutus_spawned = 0;

    level thread StartCirclingRed(19);

    if (hash4) 
        level thread SpawnSpecialBrutus(false);

    if (n_brutus != 0) 
        level thread BrutusSpawnLogicMain(20, hash4);

    wait_time = 0.15;
    checks = 0;
    stime = 0;
    
    Spawns_S = struct::get_array(#"hash_12b8ce4101a20d47");
    Spawns_S = array::randomize(Spawns_S);

    if (isdefined(n_zombies_max)) 
    {
        for (i = 0; i < Spawns_S.size; i++) 
        {
            if (Spawns_S[i].script_noteworthy == "riser_location")
                Spawns_S[i] = undefined;
        }
        Spawns_S = array::remove_undefined(Spawns_S);
        wait(1.6);
    }

    while(level.var_dcff743c) 
    {
        counts = getaiteamarray(level.zombie_team).size;
        if (util::get_active_players().size == 1 && level flag::get(#"richtofen_sacrifice") && !level flag::get(#"hash_68a1656980e771da"))
        {
            if (counts >= 31)
            {
                wait(wait_time);
                continue;
            }
        }
        if (isdefined(n_zombies_max) && counts >= n_zombies_max)
        {
            wait(wait_time);
            continue;
        }
        if (stime == Spawns_S.size)
        {
            stime = 0;
            Spawns_S = array::randomize(Spawns_S);
        }
        s_spawn_loc = Spawns_S[stime];
        if (isdefined(s_spawn_loc) && isdefined(s_spawn_loc.script_noteworthy) && counts < 31) // had to nerf it lol
        {
            if (s_spawn_loc.script_noteworthy == "riser_location") 
                ai_zombie = zombie_utility::spawn_zombie(level.zombie_spawners[0], undefined, s_spawn_loc);
                //ai_zombie thread function_8d744628();
            else if (s_spawn_loc.script_noteworthy == "dog_location" && !isdefined(level.var_e3522ee)) 
            {
                ai_zombie = zombie_utility::spawn_zombie(level.dog_spawners[0]);
                ai_zombie thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_23bd9529 ]](s_spawn_loc);
            }
        }

        if (isdefined(ai_zombie))
            checks++;

        stime++;
        if (n_brutus == 0)
        {
            if (checks > times) 
                level.var_dcff743c = 0;
        }

        wait(wait_time);
    }
    if (!isdefined(n_zombies_max))
    {
        counts = getaiteamarray(level.zombie_team).size;
        while (counts > 1) // include level.Clone_Brutus
        {
            wait 1.6;
            counts = getaiteamarray(level.zombie_team).size;
        }
        powerL = struct::get_array(#"hash_3ea8e97c5c09e1a5", "variantname");
        s_location = array::random(powerL);
        level.var_ebd424be = s_location.script_int;
        if (!hash4)
        {
            if ([[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_efbccd91 ]]())
                e_powerup = zm_powerups::specific_powerup_drop("carpenter", s_location.origin + vectorscale((1, 0, 0), 31));
            else
            {
                shieldA = util::spawn_model(#"hash_5892f7f4c9a9720e", s_location.origin + (31, 0, 61));
                shieldA notsolid();
                t_shield = spawn("trigger_radius_new", s_location.origin + (31, 0, 61), 0, 16);
                t_shield thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::give_player_shield ]](shieldA);
            }
            e_powerup = zm_powerups::specific_powerup_drop("full_ammo", s_location.origin + vectorscale((-1, 0, 0), 31));
        }
    }

}

StartCirclingRed(hash)
{
    level endon(#"end_game", #"game_ended", #"main_quest_completed");

    wait(2.6);
    while (level.var_dcff743c) 
    {
        circle_area = struct::get_array(#"hash_238da2de7cf910d9", "variantname");
        circle_area = array::randomize(circle_area);
        for (i = 0; i < hash; i++) 
        {
            s_cloud = circle_area[i];
            thread SpawnCircleRed(s_cloud);
            wait(randomfloatrange(2.5, 5));
        }
        wait 6;
    }
}

SpawnCircleRed(s_cloud)
{
    level endon(#"end_game", #"game_ended");

    circle = util::spawn_model("tag_origin", s_cloud.origin, s_cloud.angles + vectorscale((1, 0, 0), 270));
    circle clientfield::set("" + #"ritual_gobo", 1);
    circle thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_a67f95bd ]](); // this waits 6s to set it
    wait 7.6;

    foreach (player in util::get_active_players()) 
    {
        if (distance2dsquared(circle.origin, player.origin) < 5041) 
         player dodamage(player.health + 16, player.origin);
    }

    circle delete();
}

BrutusSpawnLogicMain(n_brutus, hash = 0)
{
    level endon(#"end_game", #"game_ended", #"main_quest_completed");
    ShieldLog("^1Brutus Spawning Called -> " + n_brutus + " -> " + hash);

    if (hash)
        level flag::wait_till_timeout(61, #"hash_68a1656980e771da");

    wait 1.6;

    done_flag = false;
    spawns_a = array("brutus_spawned", "brutus_spawn_failed");
    func = @paschal<scripts\zm\zm_escape_paschal.gsc>::function_bba62242;

    while (level.var_dcff743c) 
    {
        [[ @zombie_brutus_util<script_7c62f55ce3a557ff.gsc>::attempt_brutus_spawn ]](1, "zone_west_side_exterior_upper_03", 1);
        s_waittill = undefined;
        s_waittill = level waittill(spawns_a);

        if (isdefined(s_waittill.ai_brutus))
        {
            level.n_brutus_spawned++;
            s_waittill.ai_brutus.var_ece4a895 = func;
            s_waittill.ai_brutus ai::set_behavior_attribute("can_ground_slam", 1);
            s_waittill.ai_brutus.var_db8b3627 = 1;

            if (n_brutus != -1 && level.n_brutus_spawned >= n_brutus)
             level.var_dcff743c = 0;
            else
             wait 6;

            if(level.n_brutus_spawned > 10 && !done_flag)
            {
                level thread BrutusDoSpecialAttack(false);
                done_flag = true;
            }
        }
    }
}

BrutusDoSpecialAttack(StopSpawn = true)
{
    ShieldLog("^2Brutus Special Attack -> Called");

    struct_arrays = array("energy_location_up", "energy_location_right", "energy_location_left", "energy_location_bottom");
    if (!isdefined(level.var_ebd424be))
        level.var_ebd424be = randomintrange(1, 5);
    
    random_int_l = randomintrange(1, 5);
    while (random_int_l == level.var_ebd424be)
    {
        waitframe(1);
        random_int_l = randomintrange(1, 5);
    }

    attack_struct = struct::get("sbrutus_attack_" + random_int_l);
    shieldfx = util::spawn_model(#"p8_fxp_cylinder_shield", attack_struct.origin + vectorscale((0, 0, -1), 61), attack_struct.angles);
    level.var_7fe331bf = 0;
    level.var_f493ed9d = 0;
    level.var_e22ef7ff = 0;
    level.var_e7184999 = 0;

    spawner_brutus = level.Clone_Brutus;
    scene_func = @paschal<scripts\zm\zm_escape_paschal.gsc>::function_6546242b;
    scene_func2 = @paschal<scripts\zm\zm_escape_paschal.gsc>::function_9c59bce1;

    scene::add_scene_func(#"hash_5d4bfbee934372eb", scene_func, "init");
    attack_struct thread scene::play(spawner_brutus);
    spawner_brutus thread OrbsLogic(struct_arrays[random_int_l - 1], attack_struct.origin);
    wait(1.6);

    exploder::exploder("fxexp_poison_0" + random_int_l);
    foreach (e_player in util::get_players())
        e_player thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_4e2f5d87 ]](attack_struct.origin);
    
    level waittilltimeout(31.5, #"boss_loses");
    if(StopSpawn) level.var_dcff743c = 0;
    level.var_e7184999 = 1;
    shieldfx delete();

    if (level.var_7fe331bf) 
    {
        scene::add_scene_func(#"aib_vign_zm_mob_brutus_grand_attack_fail", scene_func2, "play");
        spawner_brutus scene::play(#"aib_vign_zm_mob_brutus_grand_attack_fail", spawner_brutus);
        level thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_17b00ca4 ]](1);
        level waittilltimeout(6.1, #"hash_6721db7073dcfe48");
        level notify(#"hash_77922c6d618e505a");

        if (level.var_e22ef7ff) 
        {
            playsoundatposition(#"hash_b04b76e47de1e9d", (9915, 10161, 617));
            level.var_a36cbfaf++;
            level thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_7cfcac59 ]]();
        }

        level thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_17b00ca4 ]](0);
    } 
    else 
    {
        level.var_a36cbfaf--;
        level thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_6f05bd7c ]]();
        scene::add_scene_func(#"hash_dc3b3b48b040137", scene_func2, "play");
        level notify(#"hash_430c557748eea7b8");
        spawner_brutus thread scene::play(#"hash_dc3b3b48b040137", spawner_brutus);

        wait(1);
        level notify(#"hash_7dc902a6d75721a1");
    }

    exploder::kill_exploder("fxexp_poison_0" + random_int_l);
    [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_360daff1 ]]();

    wait 3;

    // there is already a non clone special brutus spawned at this point
    if (level.var_a36cbfaf != 2)
        level thread SpawnSpecialBrutus(true);
}

OrbsLogic(hash, var_1f61bd3e)
{
    level endon(#"hash_77922c6d618e505a");
    level.var_ed0d6c7d = 0;
    level.s_orbs = [];
    damagecheck = @paschal<scripts\zm\zm_escape_paschal.gsc>::function_2ffe7896;
    for (i = 1; i <= 22; i++) 
    {
        s_orb = struct::get(hash + "_" + randomIntRange(1, 4));
        s_orbEnd = util::spawn_model(#"hash_6d68fe0dc773635f", s_orb.origin, s_orb.angles);
        s_orbEnd setcandamage(1);
        s_orbEnd.health = 3000 * util::get_active_players().size;
        s_orbEnd.var_1f61bd3e = var_1f61bd3e;
        s_orbEnd.done_h = false;
        //s_orbEnd thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_bceb2f4c ]]();
        //s_orbEnd thread OrbMoveAround();
        s_orbEnd thread OrbsLogicDestroyed(); // custom
        s_orbEnd thread OrbsSetDamageCallback_Delay(damagecheck); // custom
        self thread scene::play(#"hash_4b825982d02adb40" + randomIntRange(1, 4), "Shot 1", s_orbEnd);

        if (!isdefined(level.s_orbs))
            level.s_orbs = [];
        else if (!isarray(level.s_orbs))
            level.s_orbs = array(level.s_orbs);

        level.s_orbs[level.s_orbs.size] = s_orbEnd;
        s_orbEnd thread [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::function_5d55d8d0 ]](self, randomIntRange(1, 4));
        s_orbEnd.indexs = i;

        wait 0.70; // till another orb comes
    }
}

OrbMoveAround()
{
    self endon(#"death", #"delete_me");

    self.up = true;

    wait 0.5;

    self animation::stop(0); // causes it to dissappear

    while(true)
    {
        // move orb up and down slow
        if (self.up)
            self moveTo(self.origin + (0, 0, 200), 0.5);
        else
            self moveTo(self.origin + (0, 0, -200), 0.5);

        self waittill(#"movedone");
    }
}

OrbsSetDamageCallback_Delay(damagecheck)
{
    wait 3;
    callback::function_9d78f548(damagecheck, self);
}

OrbsLogicDestroyed()
{
    self waittill(#"delete_me");
    self.done_h = true; // for health logic

    self clientfield::set("" + #"orb_explosion", 1);
    self ghost();
    level.var_ed0d6c7d++;
    if (level.var_ed0d6c7d == 22)
    {
        level notify(#"boss_loses");
        if (!level.var_f493ed9d)
            level.var_7fe331bf = 1;
    }

    playsoundatposition(#"hash_14e38e92efca6db0", self.origin);
    wait(1.6);
    self delete();
}