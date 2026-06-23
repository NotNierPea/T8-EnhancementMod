detour zm_stats<scripts\zm_common\zm_stats.gsc>::set_match_stat(stat_name, value) {
    ShieldLog("zm_stats:::set_match_stat");

    // our logic
    if (isDefined(level.IsUsingDebugLUI))
        return match_record::set_stat(stat_name, value);

    wait 2;

    if (stat_name == #"main_quest_completed")
    {
        foreach(player in level.players)
        {
            player thread CheckAchivs(player);
        }
    }

    if (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) {
        return;
    }

    match_record::set_stat(stat_name, value);
}

CheckAchivs(player)
{
    ShieldLog("^2achiv watcher now checking out..");
    
    if(GetDvarInt(#"shield_enh_ClassicMode", 0) && !GetDvarInt(#"shield_enh_Practice_Bosses", 0))
    {
        player LUINotifyEvent(#"enh_achv_manager", 2, 5, true);
        wait 5;
    }

    if(GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
    {
        player LUINotifyEvent(#"enh_achv_manager", 2, 1, true);
        wait 5;

        achiv_id = -1;

        switch(BO4GetMap())
        {
            case "IX":
            achiv_id = 2;
            break;

            case "AE":
            achiv_id = 3;
            break;

            case "Voyage":
            achiv_id = 4;
            break;

            case "Blood":
            achiv_id = 11;
            break;

            case "Tag":
            achiv_id = 12;
            break;

            case "AO":
            achiv_id = 13;
            break;

            case "Dead":
            achiv_id = 14;
            break;
        }

        if (achiv_id != -1)
        {        
            player LUINotifyEvent(#"enh_achv_manager", 2, achiv_id, true);
            wait 5;
        }

        // all hardcore bosses check
        player LUINotifyEvent(#"enh_achv_manager", 2, 6, true);
        wait 5;
    }

    if(GetDvarInt(#"shield_enh_TeamCranked", 0) && !GetDvarInt(#"shield_enh_Practice_Bosses", 0))
    {   
        wait 5;
        player LUINotifyEvent(#"enh_achv_manager", 2, 7, true);
    }
}

CustomAchivWaits()
{
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    if (isDefined(level.IsUsingDebugLUI))
        return;
}

ClassicAchievementsWatcher()
{
    self endon(#"death");
    
    if (isDefined(level.IsUsingDebugLUI))
        return;

    round_50_done = false;
    round_100_done = false;

    while(true)
    {
        round_num = undefined;
        
        round_num = zm_round_logic::get_round_number();

        if (round_num >= 50 && !round_50_done)
        {
            self LUINotifyEvent(#"enh_achv_manager", 2, 8, true);

            round_50_done = true;
        }

        if (round_num >= 100 && !round_100_done)
        {
            self LUINotifyEvent(#"enh_achv_manager", 2, 9, true);

            round_100_done = true;
        }

        // no need to check anymore ig
        if (round_50_done && round_100_done)
            break;

        wait 3;
    }
}