GameSettingsPostInit()
{
    if(GetDvarInt(#"shield_enh_ShowTimer", 0)) 
        SetGametypeSetting("zmshowtimer", true); // Timer

    //SetGametypeSetting(#"zmpowerstate",2); // power on for all maps 
    //SetGametypeSetting(#"zmpapenabled",2);

    //level flag::wait_till("all_players_spawned");
    //level flag::wait_till("initial_blackscreen_passed");
    //level flag::set("zm_towers_pap_quest_completed");
}

GameSettingsInit()
{
    SetGametypeSetting(#"zmcraftingkeyline", true); // Highlight Items
    zombie_utility::set_zombie_var(#"highlight_craftables", 1);

    if(GetDvarInt(#"shield_enh_SuperRealistic", 0)) 
        setgametypesetting(#"zmdifficulty", 3);
}