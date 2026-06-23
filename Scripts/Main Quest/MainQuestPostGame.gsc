LongFireSaleTimeout()
{
    wait 90;
    level notify(#"stop_firesale_long");
}

LongFireSaleDrop()
{
    level endon(#"stop_firesale_long");
    level thread LongFireSaleTimeout();

    while(true)
    {
        zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", 150);
        wait 0.1;
    }
}

GiveRewardsPostQuest()
{
    wait 1;

    host_player = GetPlayers()[0];
    origin_to_use = host_player.origin;

    // fire sale
    level thread LongFireSaleDrop();

    // perks and shield
    foreach(player in level.players)
    {
        player zm_bgb_shields_up::activation();
        player zm_bgb_perkaholic::activation();
        player zm_score::add_to_player_score(25000);
    }

    // power ups (for fire sale too) - spawn in circle around origin
    power_ups = array("hero_weapon_power", "extra_credit", "nuke", "carpenter", "free_perk", "fire_sale", "insta_kill", "full_ammo", "double_points");
    bgb_checks = array("zm_bgb_power_keg", "zm_bgb_extra_credit", "zm_bgb_dead_of_nuclear_winter", "zm_bgb_licensed_contractor", "zm_bgb_on_the_house", "zm_bgb_immolation_liquidation", "zm_bgb_kill_joy", "zm_bgb_cache_back", "zm_bgb_whos_keeping_score");
    special_check = array(0, 0, 0, 0, 1, 0, 0, 0, 0); // 1 if needs special check
    
    valid_ups = array();
    for (i = 0; i < bgb_checks.size; i++) {
        if (special_check[i] && !zm_custom::function_901b751c(#"zmperksactive"))
            continue;
        if (zm_custom::function_3ac936c6(bgb_checks[i]))
            valid_ups[valid_ups.size] = power_ups[i];
    }
    
    num_ups = valid_ups.size;
    if (num_ups > 0) {
        for (j = 0; j < num_ups; j++) {
            spawn_origin = origin_to_use + (randomFloatRange(-100, 100), randomFloatRange(-100, 100), origin_to_use[2] - 30.0);

            if (valid_ups[j] != "extra_credit")
                level thread bgb::function_c6cd71d5(valid_ups[j], spawn_origin, 96);
            else
                host_player thread [[ @zm_bgb_extra_credit<scripts\zm_common\bgbs\zm_bgb_extra_credit.gsc>::function_22f934e6 ]](spawn_origin, 96);

            wait 0.50;
        }
    }
}

ShowMainQuestContinueMenu()
{
    luinotifyevent(#"enhancement_mainquest_visibility", 2, 3, 0);
    wait 0.1;

    foreach(player in level.players)
    {
        if (player IsHost())
        {
            player luinotifyevent(#"enhancement_mainquest_visibility", 1, 1);
        }
        else
        {
            player luinotifyevent(#"enhancement_mainquest_visibility", 1, 2);
        }

        wait 0.1;
    }

    level thread MainQuestContinueTimeout();
}

MainQuestContinueTimeout()
{
    level endon(#"mainquest_continue", #"mainquest_end_match");

    counter_max = 3.0;
    for (counter = 0.0; counter <= counter_max; counter += 0.01)
    {
        luinotifyevent(#"enhancement_mainquest_visibility", 2, 3, ConvertNumToLUI((counter / counter_max) * 100));
        wait 0.01;
    }
    
    foreach(player in level.players)
        player luinotifyevent(#"enhancement_mainquest_visibility", 1, 0);
    
    level notify(#"mainquest_end_match");
}

RemoveDirectedMode()
{
    if(!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return;
    
    LUINotifyEvent(#"enhancement_directed_objective", 1, 1001);
}

detour zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::end_game() {
    if (!GetDvarInt(#"shield_enh_MainQuestContinue", 0) || GetDvarInt(#"shield_enh_Practice_Bosses", 0))
        return [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::end_game ]]();

    //level notify(#"end_game");
    level thread lui::screen_flash( 0.4, 0.5, 0.5, 1, "white" );

    ShowMainQuestContinueMenu();
    result = level waittill(#"mainquest_continue", #"mainquest_end_match");
    if (result._notify == #"mainquest_continue")
    {
        foreach(player in level.players)
        {
            // close menu for non-hosts clients
            if (!player IsHost())
                player luinotifyevent(#"enhancement_mainquest_visibility", 1, 0);
        }

        level thread lui::screen_flash( 0.4, 2, 0.5, 1, "white" );
        wait 1;

        origin_to_use = (-1.75599, 433.042, 34.0473);
        foreach(player in level.players)
        {
            player dontinterpolate();
            player SetRandomOrigin(origin_to_use, (0, -90, 0));
        }

        RemoveDirectedMode();
        wait 1;
        level flag::set("spawn_zombies");
        level flag::clear(#"pause_round_timeout");

        GiveRewardsPostQuest();
    }
    else
    {
        level notify(#"end_game");
    }
}

detour zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::end_game() {
    if (!GetDvarInt(#"shield_enh_MainQuestContinue", 0) || GetDvarInt(#"shield_enh_Practice_Bosses", 0))
        return [[ @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::end_game ]]();

    //level notify(#"end_game");
    // fix vod
    level thread lui::screen_flash( 0.4, 0.5, 0.5, 1, "white" );

    ShowMainQuestContinueMenu();
    result = level waittill(#"mainquest_continue", #"mainquest_end_match");
    if (result._notify == #"mainquest_continue")
    {
        foreach(player in level.players)
        {
            // close menu for non-hosts clients
            if (!player IsHost())
                player luinotifyevent(#"enhancement_mainquest_visibility", 1, 0);
        }

        RemoveDirectedMode();
        wait 1;
        level flag::set("spawn_zombies");
        level flag::clear(#"pause_round_timeout");

        a_blockers = getentarray("bs_scr_bkr", "targetname");
        foreach (e_blocker in a_blockers) {
            e_blocker hide();
            e_blocker notsolid();
            e_blocker delete();
        }

        a_blockers = getentarray("bs_att_bm_ai_blck", "targetname");
        foreach (e_blocker in a_blockers) {
            e_blocker hide();
            e_blocker notsolid();
            e_blocker delete();
        }

        GiveRewardsPostQuest();
    }
    else
    {
        level notify(#"end_game");
    }
}

detour paschal<scripts\zm\zm_escape_paschal.gsc>::play_outro() {
    if (!GetDvarInt(#"shield_enh_MainQuestContinue", 0) || GetDvarInt(#"shield_enh_Practice_Bosses", 0))
        return [[ @paschal<scripts\zm\zm_escape_paschal.gsc>::play_outro ]]();

    level zm_vo::function_3c173d37((0, 0, 0), 2147483647);
    level zm_audio::sndvoxoverride(1);
    level scene::play(#"hash_641ed02ad1d85897");

    foreach (e_player in util::get_players()) {
        e_player clientfield::set("" + #"hash_b8601726e1e4a6a", 0);
        level.var_7c7c6c35 zm_game_over::set_state(e_player, #"gatewayopened");
    }

    //level notify(#"end_game");
    level thread lui::screen_flash( 0.4, 0.5, 0.5, 1, "white" );

    ShowMainQuestContinueMenu();
    result = level waittill(#"mainquest_continue", #"mainquest_end_match");
    if (result._notify == #"mainquest_continue")
    {
        foreach(player in level.players)
        {
            // close menu for non-hosts clients
            if (!player IsHost())
                player luinotifyevent(#"enhancement_mainquest_visibility", 1, 0);
        }

        level thread lui::screen_flash( 0.4, 2, 0.5, 1, "white" );
        wait 1;

        origin_to_use = struct::get_array("initial_spawn", "script_noteworthy")[0].origin;
        angles_to_use = struct::get_array("initial_spawn", "script_noteworthy")[0].angles;
        foreach(player in level.players)
        {
            player dontinterpolate();
            player SetRandomOrigin(origin_to_use, angles_to_use);
        }

        RemoveDirectedMode();
        wait 1;
        level flag::set("spawn_zombies");
        level flag::clear(#"pause_round_timeout");

        foreach (e_player in util::get_active_players()) {
            e_player freezecontrols(0);
            e_player.var_16735873 = undefined;
        }

        GiveRewardsPostQuest();
    }
    else
    {
        level notify(#"end_game");
    }
}