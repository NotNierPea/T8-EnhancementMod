// ee detours
detour zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::init() {
    if(!GetDvarInt(#"shield_enh_Practice_Bosses", 0) || GetDvarInt("shield_enh_SaveGame_Load", 0))
        return [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::init ]]();

    ShieldLog("^2Overriding IX Steps....");

    link_scene1 = @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_5a2db619;
    link_scene2 = @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_fc8b8d1d;
    link_scene3 = @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_fc8b8d1d;
    link_scene4 = @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_fcff05cf;

    scene::add_scene_func(#"hash_18b88682c325ad3d", link_scene1, "play");
    scene::add_scene_func(#"hash_18b88682c325ad3d", link_scene2, "done");
    scene::add_scene_func(#"hash_18b88682c325ad3d", link_scene3, "stop");
    scene::add_scene_func(#"hash_18b88682c325ad3d", link_scene4, "Shot170");

    [[ @zm_towers_crowd<scripts\zm\zm_towers_crowd.gsc>::function_696a8df0 ]](0);
    [[ @zm_towers_crowd<scripts\zm\zm_towers_crowd.gsc>::function_aec5ec5a ]](0);
    [[ @zm_towers_crowd<scripts\zm\zm_towers_crowd.gsc>::function_8237489a ]](0);

    level [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_64c8ff91 ]]();
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_4802e02e ]]();
    linkblock = @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_954d42e2;
    level._zm_blocker_trigger_think_return_override = linkblock;
    [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_24479f38 ]]();
    [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_777126b7 ]]();
    [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_391f28bc ]]();
    [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::init_defend ]]();
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_a2e1777c ]]();
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::key_glint ]]();

    zm_sq::register(#"main_quest", #"hash_616226b026783ca3", #"hash_616226b026783ca3", &Empty, &EmptyClean);
    zm_sq::register(#"hash_7848e22b4305215c", #"collect_charcoal", #"collect_charcoal", &Empty, &EmptyClean);
    zm_sq::register(#"hash_39d41ab4004ca686", #"hash_1c34d1cbe7a35ae1", #"hash_1c34d1cbe7a35ae1", &Empty, &EmptyClean);
    zm_sq::register(#"hash_1da6434ce50c3713", #"collect_dung", #"collect_dung", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"collect_ingredients", #"collect_ingredients", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"mix_fertilizer", #"mix_fertilizer", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"place_fertilizer", #"place_fertilizer", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"hash_c165871a3fda034", #"hash_c165871a3fda034", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"activate_bulls", #"activate_bulls", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"activate_puzzle", #"activate_puzzle", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"hash_1cf74a26bf73d769", #"hash_1cf74a26bf73d769", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"hash_73c85b5a7924fcfb", #"hash_73c85b5a7924fcfb", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"activate_lightning_balls", #"activate_lightning_balls", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"gladiator_round", #"gladiator_round", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"maelstrom_completed", #"maelstrom_completed", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"light_runes", #"light_runes", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"pressure_plate", #"pressure_plate", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"trilane_defend", #"trilane_defend", &Empty, &EmptyClean);

    start_ee = @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_bd321d77;
    end_ee = @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_138874e8;

    zm_sq::register(#"main_quest", #"boss_battle", #"boss_battle", start_ee, end_ee, 1, @zm_towers_achievements<scripts\zm\zm_towers_achievements.gsc>::function_a24ba4fc);
    zm_sq::start(#"main_quest", 1);

    waitframe(1);

    level clientfield::set("" + #"hash_16b9e3d69cb7a017", 0);
    t_zm_towers_boss_teleport = getent("t_zm_towers_boss_teleport", "targetname");
    t_zm_towers_boss_teleport sethintstring("");
    if (zm_utility::is_ee_enabled() && zm_custom::function_901b751c(#"hash_3c5363541b97ca3e")) {
        level flag::wait_till("all_players_spawned");
        t_zm_towers_boss_teleport setinvisibletoall();
        level thread function_6378f02b(t_zm_towers_boss_teleport);
        return;
    }
    t_zm_towers_boss_teleport delete();
}

detour zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::init_steps() {
    if(!GetDvarInt(#"shield_enh_Practice_Bosses", 0) || GetDvarInt("shield_enh_SaveGame_Load", 0))
     return [[ @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::init_steps ]]();

    ShieldLog("^1Overriding zodt8_sentinel init_steps");

    Step_9_Clean = @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_b4d0381e;

    Outro_Start = @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_594ebc75;
    warzonecompassnorth = @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::warzonecompassnorth;
    Outro_Clean = @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_48837477;

    zm_sq::register(#"main_quest", #"step_1", #"main_quest_step_1", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"step_2", #"main_quest_step_2", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"step_3", #"main_quest_step_3", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"step_4", #"main_quest_step_4", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"step_5", #"main_quest_step_5", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"step_6", #"main_quest_step_6", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"step_7", #"main_quest_step_7", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"step_8", #"main_quest_step_8", &Empty, &EmptyClean);
    zm_sq::register(#"main_quest", #"step_9", #"main_quest_step_9", &StartBossLogic, Step_9_Clean);

    zm_sq::register(#"main_quest", #"outro_igc", #"main_quest_step_10", Outro_Start, warzonecompassnorth, 1, Outro_Clean);
}

// skip avog intro and hardcore boss fight hook
detour zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_ca3759b1()
{
    if(GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
    {
        // harcore's
        level.musicsystemoverride = 1;
        
        Hardcore_AO_Init();
        return;
    }

    if(!GetDvarInt(#"shield_enh_Practice_Bosses", 0) || GetDvarInt("shield_enh_SaveGame_Load", 0))
     return [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_ca3759b1 ]]();

    
    level endon(#"boss_fight_complete", #"end_game");

    // disable pap thingy, in savegame's detour gsc
    level.SaveSkipped = true;
    level.musicsystemoverride = 1;

    level flag::set("world_is_paused");
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_2ba419ee ]](0);
    wait 0.5;
    foreach (canister in level.a_e_canister) {
        if (canister.script_int == 1) {
            canister thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_8c2bda65 ]](3, 1);
        }
    }
    
    //music::setmusicstate("boss_battle_avogadro_intro");
    exploder::exploder("fxexp_pyramid_open");
    var_1c91a56e = struct::get("apd_door_scene", "targetname");
    var_1c91a56e thread scene::play("open");
    [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::spawn_boss ]]();
    exploder::exploder("fxexp_avo_elec_floor");
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_3c173d37 ]]();
    //level.e_avogadro [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"vox_boss_release", 0, 0, 1);
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_3c173d37 ]]();
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_fd24e47f ]]("vox_boss_release", 1, 0, 1);
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_3c173d37 ]]();
    //level.var_5dd0d3ff [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"vox_boss_release", 2, 0, 1);
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_3c173d37 ]]();
    //level.e_avogadro [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"vox_boss_release", 3, 0, 1);
    [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_5ef0416 ]]();
    [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_6f635c39 ]]("boss_lockdown");
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_3c173d37 ]]();
    //level.var_8200dc81 [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"vox_boss_release", 4, 0);
    //playsoundatposition(#"hash_274493fd61d94d73", (0, 0, 0));
    //playsoundatposition(#"hash_1fc67d7ad7445bbf", (-521, -1972, -82));
    //playsoundatposition(#"hash_1fc67c7ad7445a0c", (-1146, -1956, -92));
    //level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_ncom_0");
    //level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_ten_ncom_0");
    //level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_nine_ncom_0");
    //level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_eight_ncom_0");
    //level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_seven_ncom_0");
    //playsoundatposition(#"hash_5dddf55133ac4bcf", (-576, -1992, -87));
    //level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_six_ncom_0");
    //level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_five_ncom_0");
    //level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_four_ncom_0");
    //level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_three_ncom_0");
    //level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_two_ncom_0");
    //level [[ @zm_white_util<scripts\zm\zm_white_util.gsc>::function_ec34b5ee ]]("vox_boss_nuke_count_one_ncom_0");
    //foreach (player in getplayers()) {
        //player thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_a29438da ]]();
    //}
    level thread lui::screen_flash(0.1, 0.6, 1.5, 0.8, "white");
    //playsoundatposition(#"hash_782025025ec70d68", (0, 0, 0));
    exploder::exploder("fxexp_nuke_event");
    wait 2;
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_3c173d37 ]]();
    wait 2;
    //level.e_avogadro [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"hash_5233a87eed32231a", 0, 0);
    if (isdefined(level.e_avogadro)) {
        level.e_avogadro notify(#"intro_done");
    }
    exploder::stop_exploder("fxexp_avo_elec_floor");
    vol_intro_blocker = getent("intro_blocker", "targetname");
    vol_intro_blocker notsolid();
    music::setmusicstate("boss_battle_stage_1");
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
    var_46db9038 = array("cp_toast_lounge", "cp_toast_diner", "cp_toast_storage");
    foreach (str in var_46db9038) {
        var_49cec412 = struct::get(str, "script_noteworthy");
        var_49cec412 zm_unitrigger::create(@zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_80a202c1, (72, 72, 128), undefined, 1, 1);
        var_49cec412 thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_dbbdda4c ]]();
        if (!isdefined(var_3942c56)) {
            var_3942c56 = [];
        } else if (!isarray(var_3942c56)) {
            var_3942c56 = array(var_3942c56);
        }
        var_3942c56[var_3942c56.size] = var_49cec412;
    }
    while ([[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_875983ad ]](var_3942c56)) {
        wait 1;
    }
    var_88c6a045 = struct::get("cp_toast_beds", "script_noteworthy");
    var_88c6a045 zm_unitrigger::create(@zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_80a202c1, (72, 72, 128), undefined, 1, 1);
    var_88c6a045 thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_dbbdda4c ]]();
    level flag::wait_till("toast_final_charge");
    level thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_26739c84 ]]();
    exploder::exploder("fxexp_pyramid_capture");
    level.vol_toast_trap = getent("vol_toast_trap", "targetname");
    while (isdefined(level.e_avogadro) && !level.e_avogadro istouching(level.vol_toast_trap)) {
        wait 0.1;
    }
    level notify(#"avog_captured");
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_3c173d37 ]]();
    level.e_shard.name = "avog";
    level.e_shard thread [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"hash_1617ecba0bd3c76c", 3, 0);
    music::setmusicstate("none");
    while (isdefined(level.e_avogadro)) {
        wait 0.1;
    }
    level thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_3418b6f6 ]]();
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::pause_zombies ]](1, 0);
    wait 2;
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_3c173d37 ]]();
    level.var_8200dc81 [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"hash_1617ecba0bd3c76c", 1, 0, 1);
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_3c173d37 ]]();
    level.var_5dd0d3ff [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"hash_1617ecba0bd3c76c", 2, 0, 1);
    level.var_f8fdb172 [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_43124a8f ]]();
    [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_3b0da1a8 ]](#"hash_17f86af9c5a89e4e");
    level.var_f8fdb172 [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_2a8ad7ea ]]();
    exploder::exploder("fxexp_pyramid_transmit");
    playsoundatposition(#"hash_5c68b001a4e41ad3", (0, 0, 0));
    var_94db4a2f = struct::get("cp_toast_apd_diner", "script_noteworthy");
    var_94db4a2f thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_8c2bda65 ]](3, 1);
    var_59c92575 = struct::get("cp_toast_apd_lounge", "script_noteworthy");
    var_59c92575 thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_8c2bda65 ]](3, 1);
    var_e2649117 = struct::get("cp_toast_apd", "script_noteworthy");
    var_e2649117 thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_8c2bda65 ]](3, 1);
    var_6bff6faa = struct::get("cp_toast_apd_beds", "script_noteworthy");
    var_6bff6faa thread [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_8c2bda65 ]](3, 1);
    [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_3c173d37 ]]();
    level.e_shard [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::function_6a0d675d ]](#"vox_boss_success", 0, 0, 1);
    level [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_45b60e0e ]]();
    level [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_976e7caa ]]();
    level [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_2cdb9672 ]]();
    level [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_54f91945 ]]();
    wait 1.5;
    level notify(#"boss_teleported");
    level.musicsystemoverride = 0;
    exploder::exploder_stop("fxexp_elec_lounge");
    exploder::exploder_stop("fxexp_elec_diner");
    exploder::exploder_stop("fxexp_elec_storage");
    exploder::exploder_stop("fxexp_elec_beds");
    level.pack_a_punch.trigger_stubs[0] [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_cf62f3c7 ]]();
    foreach (var_5baafbb2 in level.var_76a7ad28) {
        var_5baafbb2 [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_cf62f3c7 ]]();
    }
    foreach (s_wallbuy in level._spawned_wallbuys) {
        s_wallbuy.trigger_stub [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::function_cf62f3c7 ]]();
    }
    level [[ @zm_white_toast<scripts\zm\zm_white_toast.gsc>::s_construction_push_point_a_markets ]]();
    level flag::set(#"boss_fight_complete");
}

PracticeMode()
{
    if(GetDvarInt(#"shield_enh_Practice_Bosses", 0) && !GetDvarInt("shield_enh_SaveGame_Load", 0))
     thread Setup_PracticeMode();
}

Setup_PracticeMode()
{
    ShieldLog("^6Practice Mode Enabled!");

    switch(BO4GetMap())
    {
        case "IX":
		level.PracticeModeActive = true;
        
        thread IX_Practice();
            
        thread SetupRound();
        thread SetupLoadoutMenu();
        thread OpenDoors();
        break;

        case "Blood":
		level.PracticeModeActive = true;

		thread BOTD_Practice();

        thread SetupRound();
        thread SetupLoadoutMenu();
        thread OpenDoors();

        level flag::wait_till("all_players_spawned");

        new_item = zm_crafting::get_component(#"hash_1e5657f6a6f09389");
        foreach(player in level.players)
        {
            if (isDefined(new_item))
            {
                zm_items::player_pick_up(player, new_item);
            }
        }
        break;

        case "AE":
        level.PracticeModeActive = true;

		thread AE_Practice();

        thread SetupRound();
        thread SetupLoadoutMenu();
        thread OpenDoors();
        break;

        case "AO":
		level.PracticeModeActive = true;

        thread AO_Practice();

		thread SetupRound();
        thread SetupLoadoutMenu();
        thread OpenDoors();
        break;

        case "Dead":
		level.PracticeModeActive = true;

        thread DOTN_Practice();

		thread SetupRound();
        thread SetupLoadoutMenu();
        thread OpenDoors();
        break;

        case "Tag":
        level.PracticeModeActive = true;

        thread Tag_Practice();

		thread SetupRound();
        thread SetupLoadoutMenu();
        thread OpenDoors();
        break;

        case "Classified":
		
        break;

        case "Voyage":
        level.PracticeModeActive = true;
        
        thread Voyage_Practice();
            
        thread SetupRound();
        thread SetupLoadoutMenu();
        thread OpenDoors();
        break;
    }

    level.zm_disable_recording_stats = true;
    level waittill(#"enh_start_boss");
    level.PracticeModeActive = undefined;
}

DOTN_Practice()
{
    foreach(spawn in struct::get_array("initial_spawn_points", "targetname"))
    {
        spawn.origin = (125,-26510,-5530);
        spawn.angles = (0,90,0);
    }  

    wol =  Spawn_EnhTrigger((35 , -26218, -5530), "shield/enh_start_boss", (0, 0, 0), #"p7_zm_vending_nuke", &DOTNBossSkip, 5);
    loadout = Spawn_EnhTrigger((220, -26211, -5530), "shield/enh_choose_menu", (0, 0, 0), #"p7_zm_vending_packapunch", &LoadoutMenu, 5, false);

    level flag::wait_till("all_players_spawned");
    foreach(player in level.players)
    {       
        player dontinterpolate();
        player SetRandomOrigin((125,-26510,-5530), (0, 90, 0));
    }

    // setup the area
    ShowMiscModels("end_igc");
    level clientfield::set("" + #"hash_7fcdc47572bdbafa", 1);
    level clientfield::set("" + #"hash_2709d50a7b0a2b01", 1);
    setdvar(#"hash_44340be18f159be3", 0);
    level.var_ea32773 = &DOTNDvar;

    level flag::wait_till("initial_blackscreen_passed");
    zm_sq::start(#"zm_mansion_a_skeet_fink", 1);

    level thread DOTN_PaP();

    level waittill(#"enh_start_boss");

    wait 1.5;   

    if (isDefined(wol))
        wol delete();
    
    if (isDefined(loadout))
        loadout delete();
}

DOTN_PaP()
{
    wait 3;

    s_scene = struct::get(#"p8_fxanim_zm_man_ooze_clump_bundle", "scriptbundlename");
    s_scene thread scene::play(#"p8_fxanim_zm_man_ooze_clump_bundle", "clump01_rise");
    s_scene thread scene::play(#"p8_fxanim_zm_man_ooze_clump_bundle", "clump02_rise");
    s_scene thread scene::play(#"p8_fxanim_zm_man_ooze_clump_bundle", "clump03_rise");

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
}

DOTNDvar()
{
    setdvar(#"hash_44340be18f159be3", 1);
}

DOTNBossSkip()
{
    playsoundatposition(#"evt_nuke_flash", (0, 0, 0));

    level notify(#"enh_start_boss");

    zm_sq::start(#"zm_mansion_ww");
}

AO_Practice()
{
    foreach(spawn in struct::get_array("initial_spawn", "script_noteworthy"))
    {
        spawn.origin = (42,-6315,-73);
        spawn.angles = (0, 90, 0);
    }

    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    avoc =  Spawn_EnhTrigger((-71, -5900, -60), "shield/enh_start_boss", (0, -90, 0), #"c_t8_c_zom_avagadro_fb", &AOBossSkip, 5);
    loadout = Spawn_EnhTrigger((137, -5900, -70), "shield/enh_choose_menu", (0, 0, 0), #"p7_zm_vending_packapunch", &LoadoutMenu, 5, false);

    level waittill(#"enh_start_boss");

    wait 1.5;   

    if (isDefined(avoc))
        avoc delete();
    
    if (isDefined(loadout))
        loadout delete();
}

// welp
FixAOBossZombies()
{
    level endon(#"avog_captured");

    while (true)
    {
        level flag::set(#"infinite_round_spawning");
        level flag::clear(#"pause_round_timeout");
        level flag::clear("world_is_paused");
        wait 10;
    }
}

AOBossSkip()
{
    level notify(#"enh_start_boss");

    level zm_ui_inventory::function_7df6bb60(#"zm_white_breakfast_trial", 8);

    level thread OverrideQuest(#"zm_white_main_quest", #"hash_482ab5c3c8c111fc", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"zm_white_main_quest", #"mq2_cv1", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"zm_white_main_quest", #"mq3_cv2", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"zm_white_main_quest", #"mq4_cv3", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"zm_white_main_quest", #"mq5_cv4", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"zm_white_main_quest", #"mq6_cv5", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"zm_white_main_quest", #"hash_3a3d5f6df2a45005", &FreeSkipClean, &FreeSkipClean);

    level thread lui::screen_flash(0.4, 2, 0.8, 1, "white");
    playsoundatposition(#"hash_83b85ca3e963765", (0, 0, 0));
    wait .5;
    foreach(player in level.players)
    {
        player dontinterpolate();
        player SetRandomOrigin((-160.155, -2061.96, -231.875));
    }

    wait 1;
    zm_sq::start(#"zm_white_main_quest");

    while(!isdefined(level.e_avogadro)) { util::wait_network_frame(1); }

    level.e_avogadro waittill(#"intro_done"); // i guess it works?
    FixAOBossZombies();
}

Tag_Practice()
{
    foreach(spawn in struct::get_array("initial_spawn", "script_noteworthy"))
    {
        spawn.origin =  (-6002, 4823, 1430);
        spawn.angles = (0, 50, 0);
    }

    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    ice =  Spawn_EnhTrigger((-5831.65, 4876.3, 1430.13), "shield/enh_start_boss", (0, -35, 0), #"p7_zm_vending_sleight", &TagSkipLockdown, 5);
    loadout = Spawn_EnhTrigger((-5961, 4956.55, 1430.13), "shield/enh_choose_menu", (0, -35, 0), #"p7_zm_vending_packapunch", &LoadoutMenu, 5, false);

    level waittill(#"enh_start_boss");

    wait 1.5;   

    if (isDefined(ice))
        ice delete();
    
    if (isDefined(loadout))
        loadout delete();
}

TagSkipLockdown()
{
    level notify(#"enh_start_boss");

    level thread lui::screen_flash(0.4, 2, 0.8, 1, "white");
    playsoundatposition(#"evt_nuke_flash", (0, 0, 0));
    wait .5;
    foreach(player in level.players)
    {
        player dontinterpolate();
        player SetRandomOrigin((2320,-2799,303));
    }

    wait 1;

    level thread OverrideQuest(#"main_quest", #"hash_86e283359f19a5f", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"main_quest", #"hash_467104204a4803ad", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"main_quest", #"hash_7c16d3a3e4250b9a", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"main_quest", #"hash_2dfcd4264b2c2340", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"main_quest", #"hash_c2e45a40a675911", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"main_quest", #"hash_72bc0ec65f4afcca", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"main_quest", #"hash_28c88f40ace27a7b", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"main_quest", #"hash_382d731d4de07ed3", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"main_quest", #"hash_2c00866b95e17ff5", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"main_quest", #"hash_ebca448700872b8", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"main_quest", #"hash_810019231f11ea1", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"main_quest", #"hash_11c4f1ecb0dd5a34", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"main_quest", #"hash_d0bf3cf30a07a84", &FreeSkipClean, &FreeSkipClean);
    level thread OverrideQuest(#"main_quest", #"hash_13b9abe1bd17294c", &FreeSkipClean); // main here

    wait 3;

    level.var_a43a746d = 4; // how many challenges

    // activate ziplines
    level flag::set(#"hash_7d9f8ec3cb9af87e");
    level flag::set(#"facility_available");
    level flag::set(#"hash_7d230fa8f283c105");
    level flag::set(#"hash_7def3e555eba842c");
    level flag::set(#"hash_e29d662bb90e4bc");
}

IXBossSkipWithoutPortal()
{
    if (!isDefined(level.var_ced6f061))
        level.var_ced6f061 = [];
    
    setDvar(#"hash_3065419bcba97739", 1);

    wait 1;

    function_6378f02b = &function_6378f02b;

    if (!isdefined(function_6378f02b))
    {
        self iPrintLnBold("^1Can't find function_6378f02b! ");
        return;
    }

    level thread [[ function_6378f02b ]]();

    wait 0.01;

    setDvar(#"hash_3065419bcba97739", 0); // no skip elephant

    level notify(#"enh_start_boss");
}

IX_Practice()
{
    level flag::wait_till("all_players_spawned"); // waits for players 
    foreach(player in level.players)
    {       
        player dontinterpolate();
        player SetRandomOrigin((4125, -22, 0.125), (0, 180, 0));
    }

    level flag::wait_till("initial_blackscreen_passed"); // waits for players
    foreach(player in level.players)
    {       
        player dontinterpolate();
        player SetRandomOrigin((4125, -22, 0.125), (0, 180, 0));
    }

    eleph_head = util::spawn_model(#"c_t8_zmb_dlc0_elephant_body1", (3641,-6,100), (0, 0, 0));

    // wait for level.ai[#"axis"] to load
    wait 5;

    eleph = Spawn_EnhTrigger((3822, 90, 60.5), "shield/enh_start_boss", (0, 90, 0), #"p7_zm_power_up_insta_kill", &IXBossSkipWithoutPortal, 5);
    loadout = Spawn_EnhTrigger((3822, -70, 0), "shield/enh_choose_menu", (0, 90, 0), #"p7_zm_vending_packapunch", &LoadoutMenu, 5, false);

    level waittill(#"enh_start_boss");

    wait 1.5;

    if (isDefined(eleph))
        eleph delete();
    
    if (isDefined(loadout))
        loadout delete();

    if (isDefined(eleph_head))
        eleph_head delete();  
}

BOTD_Practice()
{
    level thread OverrideQuest(#"paschal_quest", #"1", &BOTDFirstStepLogic);

    foreach(spawn in struct::get_array("initial_spawn", "script_noteworthy"))
    {
        spawn.origin = (2208,8706,1144);
        spawn.angles = (0,-180,0);
    }

    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    nuke = Spawn_EnhTrigger((1848,8706,1144), "shield/enh_start_boss", (0, 90, 0), #"p7_zm_vending_nuke", &BossSkipBOTD, 5);
    loadout = Spawn_EnhTrigger((1848,8506,1144), "shield/enh_choose_menu", (0, 90, 0), #"p7_zm_vending_packapunch", &LoadoutMenu, 5, false);

    level waittill(#"enh_start_boss");

    wait 1.5;

    if (isDefined(nuke))
        nuke delete();
    
    if (isDefined(loadout))
        loadout delete();
}

BOTDFirstStepLogic(b_skipped)
{
    ShieldLog("^1BOTDFirstStepLogic called");
    
    level waittill(#"enh_start_boss");

    wait 1;

    return;
}

BossSkipBOTD()
{
    level thread lui::screen_flash(0.4, 4, 0.8, 1, "white");

    level notify(#"enh_start_boss");

    level.var_d9b730f3 = 1; // for step 5 > 6
    level.BloodFullSkipped = true;

    level thread OverrideQuest(#"paschal_quest", #"2", &OverrideBirdStep, &OverrideBirdStepClean);
    level thread OverrideQuest(#"paschal_quest", #"3", &OverrideCutsceneStep, &OverrideCutsceneStepClean);
    level thread OverrideQuest(#"paschal_quest", #"4", &OverrideCutsceneStep, &OverrideCutsceneStepClean);
    level thread OverrideQuest(#"paschal_quest", #"5", &OverrideStep5, &OverrideStep5Clean);
}

SkipWall()
{
    wait 10;
    level notify(#"hash_4aedd2f50e5e307");
    wait 2;
    level notify(#"hash_703a48e58dfd43d6");

    Walls = struct::get(#"hash_1fb558842bdc2690");
    Wall = Walls.scene_ents[#"prop 1"];
    Wall clientfield::set("" + #"hash_376c030aee1d6ccb", 1);
}

OverrideStep5(skipped)
{
    //foreach(player in level.players) player iPrintLnBold("^2 Skipped Step 5! ");
    mdl_door = getent("jar_1", "targetname");

    s_map = struct::get(#"hash_137eedd5080e585d");
    s_map thread scene::play("Shot 2");
    mdl_door thread scene::play(#"p8_fxanim_zm_esc_lab_door_map_bundle", mdl_door);
    
    jar_2 = getent("jar_2", "targetname");
    jar_2_fx = getent("jar_2_fxanim", "targetname");
    jar_2_fx thread scene::play(#"p8_fxanim_zm_esc_door_lab_double_bundle", "OPENED", jar_2_fx);

    jar_2 delete();
    wait(1.6);
    return;
}

OverrideStep5Clean(skipped, something)
{
    wait 0.5;
    level flag::set(#"activate_west_side_exterior_stairs");
    mdl_door = getent("c29_door", "targetname");
    playsoundatposition("zmb_c29_door_open", mdl_door.origin);
    mdl_door movez(96, 1.6);
    wait 0.1;

    s_portal = struct::get(#"hash_4f3ae1de39c4b3e3");
    for (i = 1; i <= util::get_active_players().size; i++)
    {
        v_facing = s_portal.origin - util::get_active_players()[i - 1].origin;
        v_angle = vectortoangles(v_facing);
        s_teleport = struct::get(#"c29_teleport_" + i);
        util::get_active_players()[i - 1] setorigin(s_teleport.origin);
        util::get_active_players()[i - 1] setplayerangles(v_angle);
    }

    level flag::set(#"activate_west_side_exterior_stairs");
    [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::step_5_cleanup ]](0, 0); // continue zm_sq
    return;
}

OverrideBirdStep(skipped)
{
    return;
}

OverrideBirdStepClean(skipped, something)
{
    return;
}

OverrideCutsceneStep(skipped)
{
    return;
}

OverrideCutsceneStepClean(skipped, something)
{
    return;
}

AE_Practice()
{
    spawn_points = array(
        (-3563, 748, 224),
        (-3553, 748, 224),
        (-3543, 748, 224),
        (-3573, 748, 224),
        (-3583, 748, 224),
        (-3593, 748, 224),
        (-3513, 748, 224),
        (-3523, 748, 224)
    );

    spawn = struct::get_array("initial_spawn", "script_noteworthy");

    for(i = 0; i < spawn_points.size; i++)
    {
        if(i >= spawn.size)
            break;

        spawn[i].origin = spawn_points[i];
        spawn[i].angles = (0, -90, 0);
    }

    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    peag = Spawn_EnhTrigger((-3590, 507, 225), "shield/enh_start_boss", (0, 90, 0), #"c_t8_zmb_dlc2_pegasus_fb", &BossSkipAE, 5);
    loadout = Spawn_EnhTrigger((-3445, 507, 224), "shield/enh_choose_menu", (0, 180, 0), #"p7_zm_vending_packapunch", &LoadoutMenu, 5, false);

    level waittill(#"enh_start_boss");

    wait 1.5;

    if (isDefined(peag))
        peag delete();
    
    if (isDefined(loadout))
        loadout delete();
}

OpenDoors()
{
    SetGametypeSetting(#"zmpowerstate",2);
    SetGametypeSetting(#"zmpowerdoorstate",2);
    SetGametypeSetting(#"zmdoorstate", 2);
}

SetupLoadoutMenu()
{
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    foreach(player in level.players)
		player callback::function_d8abfc3d(#"menu_response", &TryGiveOptionLoadout);
}

TryGiveOptionLoadout(params) {
    if (!isalive(self)) {
        return;
    }

	menu = params.menu;

	if (menu != #"shield_enh_loadout")
		return;

    response = params.response;
    intpayload = params.intpayload;

    request_id = intpayload;

    // 10-100 weapon ids ig
    // 0, unpack weapon, 1, pack weapon
    // 2-5, how many packs
    // 6-9, perk stuff?
    // 10+ are just weapons i guess

    ShieldLog("^2Proccessing request from lui -> " + request_id);

    // weapons
    if (request_id >= 10 && request_id <= 99)
    {
        weapon = getweapon(GetWeaponFromID(request_id));

        // custom logics
        if (GetWeaponFromID(request_id) == "stake_knife")
        {
            stakefunction = @mansion_a_skeet_fink<scripts\zm\zm_mansion_a_skeet_fink.gsc>::function_db526700;
            self [[ stakefunction ]]();

            return;
        }

        if (isDefined(weapon))
            self zm_weapons::weapon_give(weapon);

        // upgrade logic
        if (GetWeaponFromID(request_id) == "zhield_frost_dw")
        {
            self aat::acquire(getweapon(#"zhield_frost_dw"), "zm_aat_frostbite");
            self zm_pap_util::repack_weapon(getweapon(#"zhield_frost_dw"), 4);
        }
        return;
    }

    // normal requests
    switch(request_id)
    {
        // unpack
        case 0:
        weapon = self GetCurrentWeapon();

        if (zm_weapons::can_upgrade_weapon(weapon))
            return;

        self TakeWeapon(weapon);

        self zm_weapons::weapon_give(self zm_weapons::get_base_weapon(weapon));
        break;

        // pack
        case 1:
        weapon = self GetCurrentWeapon();

        if (!zm_weapons::can_upgrade_weapon(weapon))
        {
            if (zm_weapons::is_wonder_weapon(weapon))
            {
                return;
            }

            self zm_pap_util::repack_weapon(weapon);
            return;
        }

        self TakeWeapon(weapon);
        self zm_weapons::weapon_give(self zm_weapons::get_upgrade_weapon(weapon, zm_weapons::weapon_supports_aat(weapon)));
        break;

        // give perks
        case 2:
        self zm_perks::function_cc24f525();
        break;

        // remove perks
        case 3:
        foreach (n_slot, perk in self.var_c27f1e90) {
            perk_str = perk + "_stop";
            
            var_ac32c1b8 = 0;
            self perks::perk_unsetperk(perk);
            if (isdefined(self.var_47654123[n_slot]) && self.var_47654123[n_slot] && self.var_c27f1e90[n_slot] == perk) {
                self.var_c27f1e90[n_slot] = #"specialty_mystery";
                self.var_c4193958[n_slot] = "";
                var_ac32c1b8 = 1;
            }
            if (isdefined(level._custom_perks[perk].var_658e2856)) {
                if (isarray(level._custom_perks[perk].var_658e2856)) {
                    foreach (specialty in level._custom_perks[perk].var_658e2856) {
                        perks::perk_unsetperk(specialty);
                    }
                } else {
                    perks::perk_unsetperk(level._custom_perks[perk].var_658e2856);
                }
            }
            self.num_perks--;
            if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_take)) {
                self thread [[ level._custom_perks[perk].player_thread_take ]](0, perk_str, "player_downed", n_slot);
            }
            self zm_perks::set_perk_clientfield(perk, 0);
            if (n_slot < 4) {
                self zm_perks::function_2ac7579(n_slot, 0);
                if (self.var_47654123[n_slot]) {
                    if (var_ac32c1b8) {
                        self zm_perks::function_81bc6765(n_slot, level._custom_perks[#"specialty_mystery"].alias);
                    }
                } else {
                    self zm_perks::function_fb633f9d(n_slot, 0);
                }
            }
            if (isdefined(level.var_a903ab55)) {
                self [[ level.var_a903ab55 ]](perk);
            }
            arrayremovevalue(self.var_466b927f, perk, 0);
            self notify(#"perk_vapor_lost");
            var_5fe29258 = self.var_c27f1e90[4];
            if (isdefined(var_5fe29258) && isinarray(self.var_466b927f, var_5fe29258)) {
                if (isdefined(self.talisman_perk_mod_single) && self.talisman_perk_mod_single && n_slot < 3) {
                    return;
                }
                self notify(var_5fe29258 + "_stop");
                self zm_perks::function_b8c12b0f(3, 0);
                self zm_perks::function_528f82a9();
            }
        }

        foreach (n_slot, perk in self.var_67ba1237) {
            perk_str = perk + "_stop";

            self perks::perk_unsetperk(perk);
            if (isdefined(level._custom_perks[perk].var_658e2856)) {
                if (isarray(level._custom_perks[perk].var_658e2856)) {
                    foreach (specialty in level._custom_perks[perk].var_658e2856) {
                        perks::perk_unsetperk(specialty);
                    }
                } else {
                    perks::perk_unsetperk(level._custom_perks[perk].var_658e2856);
                }
            }
            self.num_perks--;
            if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_take)) {
                self thread [[ level._custom_perks[perk].player_thread_take ]](0, perk_str, "player_downed", -1);
            }
            self zm_perks::set_perk_clientfield(perk, 0);
            self.perk_purchased = undefined;
            if (isdefined(level.var_a903ab55)) {
                self [[ level.var_a903ab55 ]](perk);
            }
            self zm_perks::function_2ac7579(-1, 0, level._custom_perks[hash(perk)].alias);
            if (isinarray(self.var_67ba1237, perk)) {
                arrayremovevalue(self.var_67ba1237, perk, 1);
                arrayremoveindex(self.var_eabca645, level._custom_perks[hash(perk)].alias, 1);
                self.var_ab375b18--;
            }
            self notify(#"hash_648c7603829277a1");
        }
        break;

        case 4:
        self zm_bgb_perkaholic::activation();
        break;

        // shield
        case 100:
        self zm_bgb_shields_up::activation();
        break;

        // remove shield
        case 101:
        if (isdefined(self.weaponriotshield)) {
            weapon = self.weaponriotshield;
        } else {
            weapon = level.weaponriotshield;
        }

        // for ui bug
        self switchToWeapon(weapon);

        wait 1.5;

        if (isdefined(self.var_27aeb716)) {
            self thread [[ self.var_27aeb716 ]](weapon);
        }
        self clientfield::increment_to_player("zm_shield_break_rumble");
        self thread zm_audio::create_and_play_dialog(#"shield", #"destroy");
        self thread riotshield::player_take_riotshield();

        self takeweapon(weapon);
        self notify(#"destroy_riotshield");
        self.hasriotshield = 0;
        self.hasriotshieldequipped = 0;
        self.var_d3345483 = undefined;
        self zm_weapons::clear_stowed_weapon();
        break;

        // perks
        case 102:
        case 103:
        case 104:
        case 105:
        slot = request_id - 102;

        // give perk for that slot only
        if (slot >= 0 && slot < self.var_c27f1e90.size)
        {
            perk = self.var_c27f1e90[slot];
            if (!isinarray(self.var_466b927f, perk))
            {
                if (perk == #"specialty_mystery")
                {
                    perk = self zm_perks::function_5ea0c6cf();
                    self.var_47654123[slot] = 1;
                    self zm_perks::function_f9385a02(perk, slot);
                }
                else
                {
                    self.var_47654123[slot] = 0;
                }
                self thread zm_perks::function_9bdf581f(perk, slot);
            }
        }

        break;

        // aats
        case 106:
        self thread aat::acquire(self getCurrentWeapon(), #"zm_aat_frostbite");
        break;

        case 107:
        self thread aat::acquire(self getCurrentWeapon(), #"zm_aat_kill_o_watt");
        break;

        case 108:
        self thread aat::acquire(self getCurrentWeapon(), #"zm_aat_plasmatic_burst");
        break;

        case 109:
        self thread aat::acquire(self getCurrentWeapon(), #"zm_aat_brain_decay");
        break;

        // classic perks
        case 110:
        perks_classic = array(#"HasJugg", #"specialty_doubletap2", #"specialty_whoswho", #"HasElemental", #"specialty_vultureaid", #"specialty_fastreload");

        foreach(perk in perks_classic)
        {
            self GiveClassicPerk(perk, self, true);
            wait 0.1;
        }
        break;

        case 111:
        GiveClassicPerk(#"HasJugg", self, true);
        break;

        case 112:
        GiveClassicPerk(#"specialty_doubletap2", self, true);
        break;

        case 113:
        GiveClassicPerk(#"specialty_whoswho", self, true);
        break;

        case 114:
        GiveClassicPerk(#"HasElemental", self, true);
        break;

        case 115:
        GiveClassicPerk(#"specialty_vultureaid", self, true);
        break;

        case 116:
        GiveClassicPerk(#"specialty_fastreload", self, true);

        case 117:
        perks_classic = array(#"HasJugg", #"specialty_doubletap2", #"specialty_whoswho", #"HasElemental", #"specialty_vultureaid", #"specialty_fastreload");

        foreach(perk in perks_classic)
        {
            self RemoveClassicPerk(perk);
        }
        break;
    }
}

SetupRound()
{
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    level thread zm_utility::zombie_goto_round(25);
    level thread zm_game_module::zombie_goto_round(25);
}

BossSkipAE()
{
    playsoundatposition(#"hash_489109cc61ab6258", (0, 0, 0));
    level thread lui::screen_flash(0.4, 4, 0.8, 1, "white");

    wait 0.5;

    function_3a2efd4e = &function_3a2efd4e; // boss fight ae start
    level thread [[ function_3a2efd4e ]](true); // b_cheated

    level notify("enh_start_boss");

    // for stat tracker
    level flag::set(#"hash_5a7f1f9adac6dc8c");
}

BossSkipVOD()
{
    level thread lui::screen_flash(0.4, 2, 0.8, 1, "white");
    playsoundatposition(#"hash_e0f3575083de01b", (0, 0, 0));
    wait .5;
    foreach(player in level.players) 
    {
        player dontinterpolate();
        player SetRandomOrigin((2,5196,1088));
    }

    wait 3;

    // start boss fight
    level notify(#"enh_start_boss");
}

LoadoutMenu()
{
    //self iPrintLnBold("Loadout Menu");

    self LUINotifyEvent(#"shield_enh_loadout_request", 1, 1);
}

Voyage_Practice()
{
    // spawn point setup
    spawn_points = array(
        (-6815, -738, -1663),
        (-6765, -738, -1663),
        (-6715, -738, -1663),
        (-6815, -698, -1663),
        (-6815, -798, -1663),
        (-6890, -788, -1663),
        (-6890, -700, -1663),
        (-6890, -600, -1663)
    );

    spawn = struct::get_array("initial_spawn", "script_noteworthy");

    for(i = 0; i < spawn_points.size; i++)
    {
        if(i >= spawn.size)
            break;

        spawn[i].origin = spawn_points[i];
        spawn[i].angles = (0, 90, 0);
    }

    // floors
    Floor = util::spawn_model("collision_nosight_wall_512x512x10", (-6815,-738,-1663), (90, 0, 0));
    Floor1 = util::spawn_model("collision_nosight_wall_512x512x10", (-6815,-1170,-1663), (90, 0, 0));
    Floor2 = util::spawn_model("collision_nosight_wall_512x512x10", (-6815,-1400,-1663), (90, 0, 0));
    Floor3 = util::spawn_model("collision_nosight_wall_512x512x10", (-7300,-738,-1663), (90, 0, 0));
    Floor4 = util::spawn_model("collision_nosight_wall_512x512x10", (-6340,-738,-1663), (90, 0, 0));
    Wall = util::spawn_model("collision_nosight_wall_512x512x10", (-6825,-477,-1750), (0, 90, 0));

    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    ice =  Spawn_EnhTrigger((-6670, -568, -1663), "shield/enh_start_boss", (0, 0, 0), #"hash_55657a69ddb2f287" + "full", &BossSkipVOD, 5);
    loadout = Spawn_EnhTrigger((-6950, -568, -1663), "shield/enh_choose_menu", (0, 0, 0), #"p7_zm_vending_packapunch", &LoadoutMenu, 5, false);

    music::setmusicstate("none");

    level waittill(#"enh_start_boss");

    wait 1.5;

    if (isDefined(ice))
        ice delete();
    
    if (isDefined(loadout))
        loadout delete();

    if (isDefined(Floor))
        Floor delete();
    
    if (isDefined(Floor1))
        Floor1 delete();

    if (isDefined(Floor2))
        Floor2 delete();

    if (isDefined(Floor3))  
        Floor3 delete();

    if (isDefined(Floor4))
        Floor4 delete();

    if (isDefined(Wall))
        Wall delete();
}

Empty(s_skipped)
{
    ShieldLog("^2Skipping quest step: " + s_skipped);
}

EmptyClean(s_skipped, early_end)
{
    ShieldLog("^2Skipping quest step: " + s_skipped);
}

return_false(player)
{
    return false;
}

StartBossLogic(skipped)
{
    level waittill(#"enh_start_boss");
    
    level zm_ui_inventory::function_7df6bb60(#"zm_zodt8_sentinel_trial", 9);
    foreach (s_magic_box in level.chests) {
        if (isdefined(s_magic_box.pandora_light)) {
            s_magic_box.pandora_light delete();
        }
        for (i = 0; i < s_magic_box.zbarrier getnumzbarrierpieces(); i++) {
            s_magic_box.zbarrier hidezbarrierpiece(i);
        }
        if (isdefined(s_magic_box.zbarrier.var_8cab0622)) {
            s_magic_box.zbarrier.var_8cab0622 thread scene::stop(1);
        }
    }
    if (!skipped) {
        foreach (player in util::get_players()) {
            if (player util::is_spectating()) {
                player thread zm_player::spectator_respawn_player();
            }
        }
        level.zm_bgb_anywhere_but_here_validation_override = &return_false;
        level.var_88de5053 = 3;
        zm_sq::start(#"boss_fight");

        // boss fight end flag here
        level flag::wait_till(#"hash_25d8c88ff3f91ee5");
    }
}