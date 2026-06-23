SuperRealistic()
{
    if(GetDvarInt(#"shield_enh_SuperRealistic", 0)) 
     thread Setup_SuperRealistic();
}

Setup_SuperRealistic()
{
    ShieldLog("^6Super Realistic Enabled!");

    SetGametypeSetting(#"zmzombieminspeed",2); // 2 > because it breaks for brutus/nova crawlers, etc
    SetGametypeSetting(#"zmzombiemaxspeed ",3);

    level flagsys::wait_till(#"zombie_vars_init");
    zombie_utility::set_zombie_var(#"player_base_health", 1);

    thread NoArmorFun();
}

NoArmorFun()
{
    level endon(#"end_game", #"game_ended");

    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");
    
    while(true)
    {
        foreach(player in level.players)
        {
            if(isAlive(player)) player.armor = 0; // oops forgot (isalive)
        }
        wait 0.5;
    }
}