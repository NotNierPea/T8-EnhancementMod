BO4GetMap()
{
    if(level.script == "zm_towers") return "IX";//
    else if(level.script == "zm_escape") return "Blood";//
    else if(level.script == "zm_red") return "AE";//
    else if(level.script == "zm_white") return "AO";//
    else if(level.script == "zm_mansion") return "Dead";//
    else if(level.script == "zm_orange") return "Tag";
    else if(level.script == "zm_office") return "Classified";//
    else if(level.script == "zm_zodt8") return "Voyage";//
}

BO4ChaosMap()
{
    if(level.script == "zm_towers") return true;
    else if(level.script == "zm_red") return true;
    else if(level.script == "zm_mansion") return true;
    else if(level.script == "zm_zodt8") return true;

    return false;
}

BO4AetherMap()
{
    if(level.script == "zm_escape") return true;
    else if(level.script == "zm_white") return true;
    else if(level.script == "zm_orange") return true;
    else if(level.script == "zm_office") return true;

    return false;
}

BO4OriginPrint()
{
    current_origin = self.origin;
    current_angles = self.angles;

    self iPrintLnBold("Coords: "+current_origin);
    self iPrintLnBold("Angles: "+current_angles);
}

RotateAndBobItem(bobbingTime = 3.5, bobbingHeightMin = 6, bobbingHeightMax = 9, rotateSpeedMin = 5.5, rotateSpeedMax = 7.5)
{
    self endon("death", #"stop_bobbing");

    self bobbing((0,0,1), bobbingTime, RandomIntRange(bobbingHeightMin, bobbingHeightMax));

    while(true)
    {
        rotationSpeed = RandomFloatRange(rotateSpeedMin, rotateSpeedMax);
        self RotateYaw(360, rotationSpeed);
        wait rotationSpeed;
    }
}

OverrideQuest(quest_name, step_name, setup_func, cleanup_func = undefined, check_start = false, check_complete = false) // thanks to Scrappy (modifed it a little)
{
    while (!IsDefined(level._ee))
    {
        waitframe(1);
    }
    while (!isdefined(level._ee[quest_name]))
    {
        waitframe(1);
    }

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
    {
        return;
    }

    if (IsDefined(setup_func)) 
    {
        ee_step.setup_func = setup_func;
    }

    if (IsDefined(cleanup_func)) 
    {
        ee_step.cleanup_func = cleanup_func;
    }

    if(check_start)
    {
        while(true)
        {
            wait 3;
            if (ee_step.started)
            {
                level notify(step_name + "Started");
                break;
            }
        }
    }

    if(!check_complete) return;
    while(true)
    {
        wait 3;
        if (ee_step.completed)
        {
            level notify(step_name + "Completed");
            level notify(#"StopHinting");
            break;
        }
    }
}

GetXPMultiplier() 
{
    n_multiplier = zombie_utility::function_d2dfacfd(#"hash_1ab42b4d7db4cb3c");

    if (zm_utility::is_standard())
    {
        switch (level.players.size) 
        {
        case 1:
            n_multiplier = n_multiplier * 0.55;
            break;
        case 2:
            n_multiplier = n_multiplier * 0.75;
            break;
        case 3:
            n_multiplier = n_multiplier * 0.9;
            break;
        case 4:
            n_multiplier = n_multiplier * 1.1;
            break;
        }
    } 
    else
    {
        switch (level.players.size) 
        {
        case 1:
            n_multiplier = n_multiplier * 0.63;
            break;
        case 2:
            n_multiplier = n_multiplier * 0.75;
            break;
        case 3:
            n_multiplier = n_multiplier * 0.8;
            break;
        case 4:
            n_multiplier = n_multiplier * 0.95;
            break;
        }
    }
    return n_multiplier;
}

GetMapID()
{
    Map = 0;

    switch(BO4GetMap())
    {
        case "IX":
        Map = 1;
        break;

        case "Blood":
        Map = 2;
        break;

        case "AE":
        Map = 5;
        break;

        case "AO":
        Map = 6;
        break;

        case "Dead":
        Map = 4;
        break;

        case "Tag":
        Map = 7;
        break;

        case "Classified":
        Map = 3;
        break;

        case "Voyage":
        Map = 0;
        break;
    }

    return Map;
}

GetPAPState()
{
    switch(BO4GetMap())
    {
        case "IX":
        return level flag::get(#"zm_towers_pap_quest_completed");
        break;

        case "Blood":
        return level flag::get(#"pap_quest_completed");
        break;

        case "AE":
        return level flag::get(#"pap_quest_completed");
        break;

        case "AO":
        return level flag::get(#"pap_power_ready");
        break;

        case "Dead":
        return level flag::get(#"open_pap");
        break;

        case "Tag":
        return level flag::get(#"hash_5a3d0402a5557739");
        break;

        case "Classified":
        return level flag::get("pap_machine_active");
        break;

        case "Voyage":
        return level flag::get("pap_quest_complete");
        break;
    }

    return false;
}

FreeSkipClean(b_skipped, ended_early)
{
    level notify(#"free_skip_clean");
    ShieldLog("^6Skip Clean called...");
    return;
}

FreeSkipCleanWait(b_skipped, ended_early)
{
    level waittill(#"free_skip_clean_skipped");
    ShieldLog("^6Skip Clean called (wait)...");
    return;
}

BOTDPaP(power_on)
{
    ShieldLog("^6BOTD PaP");
    
    level flag::wait_till("start_zombie_round_logic");
    switch (zm_custom::function_901b751c(#"zmpapenabled")) {
    case 1:
        self zm_pack_a_punch::set_state_hidden();
        if (self.script_string == "roof") {
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

SkipBullsStep()
{
    level waittill(#"free_skip_clean");
    level.var_b80418e2 clientfield::set("ra_eyes_beam_fire", 1);
    wait 4;
    level.var_82234300 show();
    level.var_8c8485cf = 1;
    level.var_82234300 playsound(#"hash_708d124fb1b2203e");
    level.var_b42c7aba = level.var_82234300 zm_unitrigger::create(@zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_e59f6c8d, 64, @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_d3e4e438);
    wait 2;
    level.var_b80418e2 clientfield::set("ra_eyes_beam_fire", 0);
}

Save_IX_ActivateBoss()
{
    level flag::wait_till("all_players_spawned");
    wait 3;
    level flag::set(#"hash_37071af70fe7a9f2");
}

PlanetsStepFix()
{
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    wait 5;

    // loaded save
    level flag::set(#"hash_76dd603f61fa542d");
}

IceStepTeleportFix()
{
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    // loaded save
    spawn = struct::get_array("initial_spawn", "script_noteworthy");
    foreach(player in level.players)
    {
        player SetRandomOrigin(spawn[0].origin, spawn[0].angles);
    }

    level notify(#"free_skip_clean_skipped");
}

Step_1_Fix_BOTD()
{
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    wait 1;
    level notify(#"hash_4aedd2f50e5e307");
    wait 3;
    level notify(#"hash_703a48e58dfd43d6");
    wait 6;
    level flag::set(#"hash_61bba9aa86f61865");

    s_switch = struct::get("s_ch_sw");

    if (isdefined(s_switch))
        s_switch notify(#"trigger_activated");

    if (isdefined(s_switch.s_unitrigger_stub))
        s_switch.s_unitrigger_stub notify(#"trigger_activated");
}

Step_2_Fix_BOTD()
{
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    wait 3;

    level flag::set(#"hash_40e9ad323fe8402a");
    if (!isdefined(level.var_659daf1d)) {
        level.var_659daf1d = [];
    } else if (!isarray(level.var_659daf1d)) {
        level.var_659daf1d = array(level.var_659daf1d);
    }
    if (!isinarray(level.var_659daf1d, "tag_socket_f")) {
        level.var_659daf1d[level.var_659daf1d.size] = "tag_socket_f";
    }

    wait 3;

    // fix for step 3 (the sixth is triggered manually in the script)
    level.var_dd650b0e = array("tag_socket_a", "tag_socket_b", "tag_socket_c", "tag_socket_d", "tag_socket_e", "tag_socket_f");
}

SetMainQuestStep(step_id)
{
    level.MainQuest_Step = step_id;
    switch(BO4GetMap())
    {
        case "IX":
            a_steps = array(
                #"hash_616226b026783ca3",
                #"collect_ingredients",
                #"mix_fertilizer",
                #"place_fertilizer",
                #"hash_c165871a3fda034",
                #"activate_bulls",
                #"activate_puzzle",
                #"hash_1cf74a26bf73d769",
                #"hash_73c85b5a7924fcfb",
                #"activate_lightning_balls",
                #"gladiator_round",
                #"maelstrom_completed",
                #"light_runes",
                #"pressure_plate",
                #"trilane_defend"
            );

            // bad save spots
            if (step_id == 10 || step_id == 14)
                step_id-= 1;

            // final boss fight anyways
            if (step_id == 15)
                level thread Save_IX_ActivateBoss();

            foreach (i, step in a_steps) {
                if (step_id > i) {
                    level thread OverrideQuest(#"main_quest", step, &FreeSkipClean, &FreeSkipClean);
                }
            }

            if (step_id == 6)
                level thread SkipBullsStep();
            break;

        case "Blood":
            a_steps = array(
                    #"1",
                    #"2",
                    #"3",
                    #"4",
                    #"5",
                    #"6",
                    #"7"
                );

                if (step_id >= 1)
                {
                    level thread Step_1_Fix_BOTD();
                    level thread Step_2_Fix_BOTD();
                }

                foreach (i, step in a_steps) {

                    // bad steps
                    if (i == 0 || i == 4 || i == 5 || i == 6)
                        continue;
                    
                    if (step_id > i)
                        level thread OverrideQuest(#"paschal_quest", step, &FreeSkipClean, &FreeSkipClean);
                }
        break;

        case "AE":

        break;

        case "AO":

        break;

        case "Dead":

        break;

        case "Tag":

        break;

        case "Classified":
		
        break;

        case "Voyage":
            a_steps = array(
                #"step_1",
                #"step_2",
                #"step_3",
                #"step_4",
                #"step_5",
                #"step_6",
                #"step_7"
            );

            foreach (i, step in a_steps) {
                if (step_id == 5 && i == 4)
                {
                    level thread PlanetsStepFix();
                }

                if (step_id == 6 && i == 5)
                {
                    level thread OverrideQuest(#"main_quest", step, &FreeSkipClean, &FreeSkipCleanWait);
                    level thread IceStepTeleportFix();
                    continue;
                }

                if (step_id > i) {
                    level thread OverrideQuest(#"main_quest", step, &FreeSkipClean, &FreeSkipClean);
                }
            }
        break;
    }
}

ActivatePAP()
{
    level.saved_pap_done = true;

    SetGametypeSetting(#"zmpowerstate",2);

    ShieldLog("^2Activating PAP!!!");
    
    switch(BO4GetMap())
    {
        case "IX":

        level flag::wait_till("all_players_spawned");
        level flag::wait_till("initial_blackscreen_passed");

        wait 3;

        level thread [[ @zm_towers_pap_quest<scripts\zm\zm_towers_pap_quest.gsc>::function_a7faeaaf ]]();
        break;

        case "Blood":
        SetGametypeSetting(#"zmpowerstate", 1);
        //SetGametypeSetting(#"zmpapenabled", 2);

        while(!isDefined(level.pack_a_punch.custom_power_think))
        {
            waitFrame(1);
        }

        level.pack_a_punch.custom_power_think = &BOTDPaP;

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
        var_f7076542 = getentarray("catwalk_event_triggers", "script_noteworthy");

        var_40762d8a sethintstring(#"");
        t_catwalk_door sethintstring(#"");

        var_40762d8a setinvisibletoall();
        t_catwalk_door setinvisibletoall();

        if (isdefined(level.var_2ea46461)) {
            level.var_2ea46461 delete();
        }

        var_6fbf9624 = getentarray("use_elec_switch", "targetname");
        foreach (trig_elec_switch in var_6fbf9624) {
            trig_elec_switch trigger::use();
        }

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
        level flag::set(#"pap_quest_completed");
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

        level.SaveSkipped = true;

        zm_sq::start(#"zm_white_main_quest");
        break;

        case "Dead":

        level flag::wait_till("all_players_spawned");
        level flag::wait_till("initial_blackscreen_passed");

        wait 3;

        s_scene = struct::get(#"p8_fxanim_zm_man_ooze_clump_bundle", "scriptbundlename");
        s_scene thread scene::play(#"p8_fxanim_zm_man_ooze_clump_bundle", "clump01_rise");
        s_scene thread scene::play(#"p8_fxanim_zm_man_ooze_clump_bundle", "clump02_rise");
        s_scene thread scene::play(#"p8_fxanim_zm_man_ooze_clump_bundle", "clump03_rise");

        //level.var_a6583e6d = util::spawn_model(#"p8_zm_red_floatie_duck", (0, 0, 0));
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
        level flag::set("unlock_pap_gate");
        zm_power::turn_power_on_and_open_doors(666);

        break;

        case "Tag":
        level thread OverrideQuest(#"pap_rock", #"step_1", &FreeSkipClean);
        level thread OverrideQuest(#"pap_rock", #"step_2", &FreeSkipClean);

        level.SaveSkipped = true;

        level flag::wait_till("all_players_spawned");
        level flag::wait_till("initial_blackscreen_passed");

        wait 3;
        level flag::set(#"hash_3310bb35ce396e49");
        level flag::set(#"hash_5a3d0402a5557739");
        level flag::set(#"hash_3028604821838259");
        level flag::set(#"hash_78cf83ad057b4f1f");

        // ziplines
        //level flag::set(#"hash_7d9f8ec3cb9af87e");
        //level flag::set(#"facility_available");
        //level flag::set(#"hash_7d230fa8f283c105");
        //level flag::set(#"hash_7def3e555eba842c");
        //level flag::set(#"hash_e29d662bb90e4bc");
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

        level.var_2de08508 notify(#"trigger", {#activator:getplayers()[0]});

        wait 5;

        think = @zm_office_teleporters<scripts\zm\zm_office_teleporters.gsc>::portal_think;

        level.s_cage_portal zm_unitrigger::create("", 32, think, 0, 0);
        [[ @zm_office_teleporters<scripts\zm\zm_office_teleporters.gsc>::function_60abbae4 ]](1);
        level.var_a23b5c5 playsound(#"hash_123af2d6dc30025a");
        level.var_a23b5c5 movez(150, 1);
        break;

        case "Voyage":

        level flag::wait_till("all_players_spawned");
        level flag::wait_till("initial_blackscreen_passed");

        // wait then turn all elems
        wait 5;

        function_5c299a0f = @zodt8_pap_quest<scripts\zm\zm_zodt8_pap_quest.gsc>::function_5c299a0f; 

        foreach (s_loc in level.s_pap_quest.a_s_locations) 
        {
            s_loc.unitrigger_stub thread [[ function_5c299a0f ]]();

            wait 0.5;
        }

        break;
    }
}

GetSpecialistRechargeThing(var_14d0b7ab) {
    switch (level.players.size) {
    case 1:
        var_a7041269 = var_14d0b7ab * 1.4;
        break;
    case 2:
        var_a7041269 = var_14d0b7ab * 1.3;
        break;
    case 3:
        var_a7041269 = var_14d0b7ab * 1.2;
        break;
    case 4:
    default:
        var_a7041269 = var_14d0b7ab;
        break;
    }
    return var_a7041269;
}

GiveBGB(str_bgb, playanim = false) 
{
    self endon(#"death");

    if (playanim)
        self bgb::bgb_gumball_anim(str_bgb);
    
    if (level.bgb[str_bgb].limit_type == "activated") 
    {
        self notify(#"hash_27b238d082f65849", str_bgb);
        self bgb::activation_start();
        self thread bgb::run_activation_func(str_bgb);
    }
}

GetBGBModel_Weapon(bgb)
{
    var_ab8d8da3 = undefined;
    if (isdefined(level.bgb[bgb])) {
        n_rarity = level.bgb[bgb].rarity;
        if (isdefined(level.var_ddff6359) && isdefined(n_rarity)) {
            var_ab8d8da3 = level.var_ddff6359[n_rarity];
        }
    }
    return var_ab8d8da3;
}

IsBadElixir(bgb)
{
    switch(bgb)
    {
        // continue list later...
        case #"zm_bgb_respin_cycle": return true;
        case #"zm_bgb_danger_closest": return true;
        case #"zm_bgb_crawl_space": return true;
        case #"zm_bgb_board_games": return true;
    }

    return false;
}

GetGumNamePlease(bgb)
{
    bgbhash = /*ShieldHashLookup(bgb);*/ bgb;

    switch(bgbhash)
    {
        case #"zm_bgb_aftertaste": return "After Taste";
        case #"zm_bgb_alchemical_antithesis": return "Alchemical Antithesis";
        case #"zm_bgb_always_done_swiftly": return "Always Done Swiftly";
        case #"zm_bgb_anti_entrapment": return "Anti Entrapment";
        case #"zm_bgb_anywhere_but_here": return "Anywhere But Here";
        case #"zm_bgb_arsenal_accelerator": return "Arsenal Accelerator";
        case #"zm_bgb_board_games": return "Board Games";
        case #"zm_bgb_bullet_boost": return "Bullet Boost";
        case #"zm_bgb_burned_out": return "Burned Out";
        case #"zm_bgb_cache_back": return "Cache Back";
        case #"zm_bgb_conflagration_liquidation": return "Conflagration Liquidation";
        case #"zm_bgb_crawl_space": return "Crawl Space";
        case #"zm_bgb_ctrl_z": return "Ctrl-Z";
        case #"zm_bgb_danger_closest": return "Danger Closest";
        case #"zm_bgb_dead_of_nuclear_winter": return "Dead of Nuclear Winter";
        case #"zm_bgb_dividend_yield": return "Dividend Yield";
        case #"zm_bgb_equip_mint": return "Equip Mint";
        case #"zm_bgb_extra_credit": return "Extra Credit";
        case #"zm_bgb_free_fire": return "Free Fire";
        case #"zm_bgb_wall_to_wall_clearance": return "Wall To Wall Clearance";
        case #"zm_bgb_head_drama": return "Head Drama";
        case #"zm_bgb_head_scan": return "Head Scan";
        case #"zm_bgb_immolation_liquidation": return "Immolation Liquidation";
        case #"zm_bgb_in_plain_sight": return "In Plain Sight";
        case #"zm_bgb_join_the_party": return "Join the Party";
        case #"zm_bgb_kill_joy": return "Kill Joy";
        case #"zm_bgb_licensed_contractor": return "Licensed Contractor";
        case #"zm_bgb_near_death_experience": return "Near Death Experience";
        case #"zm_bgb_newtonian_negation": return "Newtonian Negation";
        case #"zm_bgb_now_you_see_me": return "Now You See Me";
        case #"zm_bgb_nowhere_but_there": return "Nowhere But There";
        case #"zm_bgb_perk_up": return "Perk Up";
        case #"zm_bgb_perkaholic": return "Perkaholic";
        case #"zm_bgb_phantom_reload": return "Phantom Reload";
        case #"zm_bgb_phoenix_up": return "Phoenix Up";
        case #"zm_bgb_point_drops": return "Point Drops";
        case #"zm_bgb_pop_shocks": return "Pop Shocks";
        case #"zm_bgb_power_keg": return "Power Keg";
        case #"zm_bgb_blood_debt": return "Blood Dept";
        case #"zm_bgb_power_vacuum": return "Power Vacuum";
        case #"zm_bgb_refresh_mint": return "Refresh Mint";
        case #"zm_bgb_reign_drops": return "Reign Drops";
        case #"zm_bgb_respin_cycle": return "Respin Cycle"; // THIS DOES NOT EXISTS ANYWAYS!!!
        case #"zm_bgb_secret_shopper": return "Secret Shopper";
        case #"zm_bgb_shields_up": return "Shields Up";
        case #"zm_bgb_shopping_free": return "Shopping Free";
        case #"zm_bgb_stock_option": return "Stock Option";
        case #"zm_bgb_suit_up": return "Suit Up";
        case #"zm_bgb_sword_flay": return "Sword Flay";
        case #"zm_bgb_talkin_bout_regeneration": return "Talkin' Bout Regeneration";
        case #"zm_bgb_temporal_gift": return "Temporal Gift";
        case #"zm_bgb_undead_man_walking": return "Undead Man Walking";
        case #"zm_bgb_wall_power": return "Wall Power";
        case #"zm_bgb_whos_keeping_score": return "Who's Keeping Score";
        case #"zm_bgb_quacknarok": return "Quacknarok";
    }

    return "WTF";
}

GiveClientWeapon(WeaponName, player)
{
    weapon = getweapon(WeaponName);
    wait .1;
    player zm_weapons::weapon_give(weapon);
}

get_perk_weapon(str_perk) 
{
    weapon = "";
    if (!isdefined(str_perk)) {
        return weapon;
    }
    if (!isdefined(level._custom_perks)) {
        return weapon;
    }
    if (level.var_c3e5c4cd == 1) {
        if (isdefined(level._custom_perks[str_perk]) && isdefined(level._custom_perks[str_perk].perk_bottle_weapon)) {
            weapon = level._custom_perks[str_perk].perk_bottle_weapon;
        }
    } else if (isdefined(level._custom_perks[str_perk]) && isdefined(level._custom_perks[str_perk].var_66de8d1c)) {
        weapon = level._custom_perks[str_perk].var_66de8d1c;
    }
    return weapon;
}

PlayPerkAnim(str_perk)
{
    weapon = get_perk_weapon(str_perk);
    self thread gestures::function_f3e2696f(self, weapon, undefined, 2.5, undefined, undefined, undefined);
}

IsPaPOrPowerOn()
{
    switch(BO4GetMap())
    {
        case "IX":
        return level flag::get(#"zm_towers_pap_quest_completed");
        break;

        case "Blood":
        b_bool = level flag::get(#"power_on1");

        return b_bool;
        break;

        case "AE":
        b_bool = level flag::get(#"power_on");

        return true;
        break;

        case "AO":
        b_bool = level flag::get(#"power_on1");

        return b_bool;
        break;

        case "Dead":
        b_bool = level flag::get(#"power_on1");

        return true;
        break;

        case "Tag":
        b_bool = level flag::get(#"power_on1");

        return b_bool;
        break;

        case "Classified":
        b_bool = level flag::get(#"power_on");

        return b_bool;
        break;

        case "Voyage":
        b_bool = level flag::get(#"power_on");

        return true;
        break;
    }
}

Spawn_EnhTrigger(origin, hintstring, angles, model, func, waitseconds, delete = true)
{
    model_m = util::spawn_model(model, origin, angles);
    model_m Solid();

    model_m.func = func;
    model_m.hintstring = hintstring;
    model_m.delete = delete;

    if(isdefined(waitseconds))
    {
        model_m.waitforblack = true;
        model_m.waitseconds = waitseconds;
    }

    model_m zm_unitrigger::create(&EnhTriggerSetUp, 120, &EnhTriggerChecking);

    return model_m;
}

EnhTriggerSetUp(e_player)
{
    return true;
}

EnhTriggerChecking()
{
    self endon(#"death");

    model = self.stub.related_parent;
    model endon(#"death");

    self setHintString(model.hintstring);
    self setcursorhint("HINT_NOICON");

    model clientfield::set("powerup_fx", 4);

    while(true)
    {
        waitresult = undefined;
        waitresult = self waittill(#"trigger");

        if (isplayer(waitresult.activator) && isalive(waitresult.activator)) {
            e_player = waitresult.activator;
                
            playfx(level._effect[#"hash_1eae5969d11a8b16"], model.origin);
            playfx(level._effect[#"teleport_splash"], model.origin);
            e_player thread [[ model.func ]](); // thread

            if (model.delete)
            {
                self DeleteTriggers(model);

                return;
            }
        }
    }
}

DeleteTriggers(model)
{
    model delete();
    self delete();
}

SetRandomOrigin(origin, angles) // used to avoid death barriers
{
    self endon(#"disconnect");
    //level endon(#"end_game", #"game_ended");
    EntNumber = self getentitynumber();

    switch(EntNumber)
    {
        case 0:
        RandomOrigin = origin + (50, 0, 0);
        break;
        case 1:
        RandomOrigin = origin + (-50, 0, 0);
        break;
        case 2:
        RandomOrigin = origin + (0, 50, 0);
        break;
        case 3:
        RandomOrigin = origin + (0, -50, 0);
        break;
    }

    self setorigin(RandomOrigin);

    if(isdefined(angles))
    {
        self setPlayerAngles(angles);
    }
}

GetWeaponFromID(id)
{
    switch(id)
    {
        // launcher + shotguns
        case 10: return "launcher_standard_t8";
        case 11: return "shotgun_pump_t8";
        case 12: return "shotgun_semiauto_t8";
        case 13: return "shotgun_trenchgun_t8";
        case 14: return "shotgun_fullauto_t8";
        case 15: return "shotgun_precision_t8";

        // assault rifles
        case 16: return "ar_accurate_t8";
        case 17: return "ar_fastfire_t8";
        case 18: return "ar_damage_t8";
        case 19: return "ar_stealth_t8";
        case 20: return "ar_modular_t8";
        case 21: return "ar_mg1909_t8";
        case 22: return "ar_standard_t8";
        case 23: return "ar_galil_t8";
        case 24: return "ar_peacekeeper_t8";
        case 25: return "ar_doublebarrel_t8";
        case 26: return "ar_an94_t8";

        // SMGs
        case 27: return "smg_folding_t8";
        case 28: return "smg_drum_pistol_t8";
        case 29: return "smg_accurate_t8";
        case 30: return "smg_fastfire_t8";
        case 31: return "smg_capacity_t8";
        case 32: return "smg_handling_t8";
        case 33: return "smg_standard_t8";
        case 34: return "smg_minigun_t8";
        case 35: return "smg_vmp_t8";
        case 36: return "smg_fastburst_t8";
        case 37: return "smg_mp40_t8";
        case 70: return "smg_thompson_t8"; // optional

        // Tactical rifles + LMGs + pistols
        case 38: return "tr_powersemi_t8";
        case 39: return "tr_longburst_t8";
        case 40: return "tr_midburst_t8";
        case 41: return "lmg_heavy_t8";
        case 42: return "lmg_spray_t8";
        case 43: return "lmg_standard_t8";
        case 44: return "pistol_standard_t8";
        case 45: return "pistol_topbreak_t8";
        case 46: return "tr_damageburst_t8";
        case 47: return "tr_leveraction_t8";
        case 48: return "tr_flechette_t8";

        // snipers + remaining pistols + lmgs
        case 49: return "sniper_fastrechamber_t8";
        case 50: return "sniper_powerbolt_t8";
        case 51: return "sniper_powersemi_t8";
        case 52: return "sniper_quickscope_t8";
        case 53: return "sniper_mini14_t8";
        case 54: return "sniper_locus_t8";
        case 55: return "sniper_damagesemi_t8";
        case 56: return "pistol_revolver_t8";
        case 57: return "pistol_burst_t8";
        case 58: return "pistol_fullauto_t8";
        case 59: return "lmg_double_t8";
        case 60: return "lmg_stealth_t8";

        // equipments
        case 61: return "homunculus";
        case 62: return "cymbal_monkey";
        case 63: return "eq_frag_grenade";
        case 64: return "eq_acid_bomb";
        case 65: return "claymore";
        case 66: return "eq_wraith_fire";
        case 67: return "mini_turret";

        // other
        case 68: return "special_ballisticknife_t8_dw";
        case 69: return "special_crossbow_t8";

        case 71: return "ray_gun";
        case 72: return "ray_gun_mk2";

        default:
        break;
    }

    // special weapons (60+)
    switch(BO4GetMap())
    {
        case "Voyage":
        switch(id)
        {
            case 90: return "ww_tricannon_t8";
            case 91: return "ww_tricannon_fire_t8";
            case 92: return "ww_tricannon_earth_t8";
            case 93: return "ww_tricannon_water_t8";
            case 94: return "ww_tricannon_air_t8";
            case 95: return "zhield_frost_dw";
            default: return "unknown_special_weapon";
        }
        break;

        case "AE":
        switch(id)
        {
            case 90: return "ww_hand_c";
            case 91: return "ww_hand_g";
            case 92: return "ww_hand_h";
            case 93: return "ww_hand_o";

            case 94: return "Thunderstorm";

            case 95: return "ww_hand_c_uncharged";
            case 96: return "ww_hand_g_uncharged";
            case 97: return "ww_hand_h_uncharged";
            case 98: return "ww_hand_o_uncharged";

            default: return "unknown_special_weapon";
        }

        case "Blood":
        switch(id)
        {
            case 90: return "ww_blundergat_t8";
            case 91: return "ww_blundergat_acid_t8";
            case 92: return "ww_blundergat_fire_t8";

            case 93: return "tomahawk_t8_upgraded";
            case 94: return "zhield_spectral_dw_upgraded";
            case 95: return "spknifeork";
        }

        case "AO":
        switch(id)
        {
            case 90: return "ray_gun_mk2v";
            case 91: return "ray_gun_mk2x";
            case 92: return "ray_gun_mk2y";
            case 93: return "ray_gun_mk2z";
        }

        case "Tag":
        switch(id)
        {
            case 90: return "thundergun";
            case 91: return "ww_tesla_gun_t8";
            case 92: return "ww_tesla_sniper_t8";
            case 93: return "tundragun";
            
            case 94: return "music_box";
            case 95: return #"hash_7a42b57be462143f"; // dolls
        }

        case "Dead":
        switch(id)
        {
            case 90: return "ww_random_ray_gun1";
            case 91: return "ww_random_ray_gun2";
            case 92: return "ww_random_ray_gun3";

            case 93: return "stake_knife";
        }

        case "IX":
        switch(id)
        {
            case 90: return "ww_crossbow_t8";
            case 91: return "ww_crossbow_charged_t8";
            
            case 92: return "hash_243cd42eb1bd6e10";
        }

        case "Classified":
        switch(id)
        {
            case 90: return "ww_freezegun_t8";
        }

        break;
    }
}

SendWeaponMagic(weapon_name, Object, AOrigin, ObjectDest, no_scale = false) // thanks to ate for this || self for killing the zombies
{
    tank_turret = getweapon(hash(weapon_name));
    if (!isdefined(tank_turret)) 
    {
        return;

    } 
    else 
    {
        if (no_scale)
        {
            rocket = magicbullet(tank_turret, Object.origin + AOrigin, ObjectDest.origin, self);
            if (!isdefined(rocket)) 
            {
                return;
            }
            return rocket;
        }
        else
        {
            // Offset the spawn position forward to avoid self-collision
            forward = AnglesToForward(Object.angles);
            safe_offset = 300; // distance in units to spawn in front of the shooter
            spawn_origin = Object.origin + AOrigin + (forward * safe_offset);
            rocket = magicbullet(tank_turret, spawn_origin, ObjectDest.origin, self);

            if (!isdefined(rocket)) 
            {
                return;
            }
            return rocket;
        }

    }
}

get_next_obj_id() {

}

// 0-19, unused, for now
/*
get_next_obj_id_vulture()
{
    if (!isDefined(level.numgametypereservedobjectives_vulture))
    {
        level.numgametypereservedobjectives_vulture = 0;
        level.releasedobjectives_vulture = [];
    }
    
    if (level.numgametypereservedobjectives_vulture < 19) {
        nextid = level.numgametypereservedobjectives_vulture;
        level.numgametypereservedobjectives_vulture++;
    } else if (level.releasedobjectives_vulture.size > 0) {
        nextid = array::pop_front(level.releasedobjectives_vulture, 0);
    }
    if (!isdefined(nextid)) {
        iprintln("limited vulture, returning 18");
        nextid = 18;
    }
    return nextid;
}

release_obj_id_vulture(objid)
{
    for (i = 0; i < level.releasedobjectives_vulture.size; i++) {
        if (objid == level.releasedobjectives_vulture[i] && objid == 18) {
            return;
        }
        assert(objid != level.releasedobjectives_vulture[i]);
    }
    level.releasedobjectives_vulture[level.releasedobjectives_vulture.size] = objid;
}
*/

// 0-8
get_next_obj_id_ping()
{
    if (!isDefined(level.numgametypereservedobjectives_ping))
    {
        level.numgametypereservedobjectives_ping = 0;
        level.releasedobjectives_ping = [];
    }

    if (level.numgametypereservedobjectives_ping < 8) {
        nextid = level.numgametypereservedobjectives_ping;
        level.numgametypereservedobjectives_ping++;
    } else if (level.releasedobjectives_ping.size > 0) {
        nextid = array::pop_front(level.releasedobjectives_ping, 0);
    }
    if (!isdefined(nextid)) {
        ShieldLog("limited ping, returning 7");
        nextid = 7;
    }
    return nextid;
}

release_obj_id_ping(objid)
{
    for (i = 0; i < level.releasedobjectives_ping.size; i++) {
        if (objid == level.releasedobjectives_ping[i] && objid == 7) {
            return;
        }
        //assert(objid != level.releasedobjectives_ping[i]);
    }
    level.releasedobjectives_ping[level.releasedobjectives_ping.size] = objid;
}

// 8-20
get_next_obj_id_directed()
{
    if (!isDefined(level.numgametypereservedobjectives_directed))
    {
        level.numgametypereservedobjectives_directed = 8;
        level.releasedobjectives_directed = [];
    }

    if (level.numgametypereservedobjectives_directed < 20) {
        nextid = level.numgametypereservedobjectives_directed;
        level.numgametypereservedobjectives_directed++;
    } else if (level.releasedobjectives_directed.size > 0) {
        nextid = array::pop_front(level.releasedobjectives_directed, 0);
    }
    if (!isdefined(nextid)) {
        ShieldLog("limited directed, returning 19");
        nextid = 19;
    }
    return nextid;
}

release_obj_id_directed(objid)
{
    for (i = 0; i < level.releasedobjectives_directed.size; i++) {
        if (objid == level.releasedobjectives_directed[i] && objid == 19) {
            return;
        }
        //assert(objid != level.releasedobjectives_directed[i]);
    }
    level.releasedobjectives_directed[level.releasedobjectives_directed.size] = objid;
}

// 20-64
get_next_obj_id_health()
{
    if (!isDefined(level.numgametypereservedobjectives_health))
    {
        level.numgametypereservedobjectives_health = 20;
        level.releasedobjectives_health = [];
    }

    if (level.numgametypereservedobjectives_health < 64) {
        nextid = level.numgametypereservedobjectives_health;
        level.numgametypereservedobjectives_health++;
    } else if (level.releasedobjectives_health.size > 0) {
        nextid = array::pop_front(level.releasedobjectives_health, 0);
    }
    if (!isdefined(nextid)) {
        ShieldLog("limited health, returning 63");
        nextid = 63;
    }
    return nextid;
}

release_obj_id_health(objid)
{
    for (i = 0; i < level.releasedobjectives_health.size; i++) {
        if (objid == level.releasedobjectives_health[i] && objid == 63) {
            return;
        }
        //assert(objid != level.releasedobjectives_health[i]);
    }
    level.releasedobjectives_health[level.releasedobjectives_health.size] = objid;
}

SpawnVoyageBlocker(origin, angles, scale = 1, effect = true)
{
    block_origin = origin;
    block_angles = angles;

    if (effect)
    {
        mdl_fx = util::spawn_model(#"p8_zm_power_door_symbol_01", block_origin + (0, 0, 35), block_angles);
        mdl_fx.objectid = "symbol_front_power";
        mdl_fx clientfield::set("" + #"blocker_fx", 1);
    }

    // get forward vector from angles
    forward = anglestoforward(block_angles);

    // move back
    back_offset = forward * -35;

    collision_pos = block_origin + back_offset;

    collision = spawn("script_model", collision_pos, 1);
    collision.angles = block_angles;
    collision setmodel(#"zm_collision_perks1");
    collision.script_noteworthy = "clip";
    collision disconnectpaths();

    collision SetScale(scale);
}

SpawnTagBlocker(origin, angles, scale = 1, effect = true)
{
    block_origin = origin;
    block_angles = angles;

    model_to_use = #"tag_origin";

    a_e_blockers = getentarray("lockdown_lighthouse", "targetname");
    foreach (e_blocker in a_e_blockers) {
        if (isDefined(e_blocker.model))
            model_to_use = e_blocker.model;
    }

    if (effect)
    {
        mdl_fx = util::spawn_model(model_to_use, block_origin + (0, 0, 35), block_angles);
        mdl_fx.objectid = "symbol_front_power";
    }

    // get forward vector from angles
    forward = anglestoforward(block_angles);

    // move back
    back_offset = forward * -35;

    collision_pos = block_origin + back_offset;

    collision = spawn("script_model", collision_pos, 1);
    collision.angles = block_angles;
    collision setmodel(#"zm_collision_perks1");
    collision.script_noteworthy = "clip";
    collision disconnectpaths();

    collision SetScale(scale);

    return collision;
}

ShieldPlay(music = false, loop = false, soundid = undefined, ignore_checks = false, player = undefined)
{
    if (!isDefined(player))
    {
        foreach(player in level.players)
        {
            player LUINotifyEvent(#"enh_music_manager", 4, soundid, music, loop, ignore_checks);
        }
    }
    else
    {
        player LUINotifyEvent(#"enh_music_manager", 4, soundid, music, loop, ignore_checks);
    }
}

ShieldPlayJingle(soundid, player)
{
    if (!isDefined(level.Jingle_Index))
        level.Jingle_Index = 99;
    
    self endon(#"death");
    player endon(#"death");

    level.Jingle_Index++;
    index_volume = level.Jingle_Index;
    
    max_distance = 600; // Maximum distance at which sound can be heard
    full_volume_distance = 50; // Distance within which volume stays at 1.0
    duration = 10; // Duration in seconds
    
    // Play initial sound
    player LUINotifyEvent(#"enh_music_manager", 7, soundid, true, false, false, true, ConvertNumToLUI(1.0), index_volume);

    self endon(#"death");
    player endon(#"disconnect");
    
    start_time = GetTime();
    while(GetTime() - start_time < duration * 1000) // Convert duration to milliseconds
    {
        distance = Distance(self.origin, player.origin);
        
        // Calculate volume - stays 1.0 within full_volume_distance
        if(distance <= full_volume_distance)
        {
            volume_calc = 1.0;
        }
        else
        {
            // Only start decreasing volume after full_volume_distance
            remaining_distance = distance - full_volume_distance;
            fade_distance = max_distance - full_volume_distance;
            volume_calc = 1.0 - (remaining_distance / fade_distance);
            volume_calc = math::clamp(volume_calc, 0.0, 1.0);
        }
        
        // Update volume
        player LUINotifyEvent(#"enh_music_manager", 7, soundid, true, false, false, true, ConvertNumToLUI(volume_calc), index_volume);
        
        wait 0.1;
    }

    wait 2;
    
    // Stop sound after duration
    player LUINotifyEvent(#"enh_music_manager", 2, 101, index_volume);
}

ShieldStopAllMusics(player = undefined)
{
    if (!isDefined(player))
    {
        foreach(player in level.players)
        {
            player LUINotifyEvent(#"enh_music_manager", 1, 99);
        }
    }
    else
    {
        player LUINotifyEvent(#"enh_music_manager", 1, 99);
    }
}

ShieldStopAllSfx(player = undefined)
{
    if (!isDefined(player))
    {
        foreach(player in level.players)
        {
            player LUINotifyEvent(#"enh_music_manager", 1, 100);
        }
    }
    else
    {
        player LUINotifyEvent(#"enh_music_manager", 1, 100);
    }
}

Save_OverrideChallenges(BOTD_Challenge_Left)
{
    while(!isdefined(level.var_85cc9fcc))
    {
        wait 0.1;
    }

    wait 1;

    level.var_85cc9fcc = BOTD_Challenge_Left;
}