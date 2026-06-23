ZombieCounterT8() 
{
    if(!GetDvarInt(#"shield_enh_Counter_Enabled", 0))
    {
        level flag::wait_till("all_players_spawned");
        level flag::wait_till("initial_blackscreen_passed");

        LUINotifyEvent(#"enhancement_zombie_counter", 1, 0);
        return;
    }

    level.TextHudColor = GetDvarInt(#"shield_enh_Counter_TextColor", 1);
    level.NumberHudColor = GetDvarInt(#"shield_enh_Counter_NumberColor", 5);
    
    //clientfield::register("toplayer", "" + #"zombies_counter_alive", 1, 10, "int");
    //clientfield::register("toplayer", "" + #"zombies_counter_remaining", 1, 10, "int");

    level flag::wait_till("all_players_spawned"); // wait for lua
    level flag::wait_till("initial_blackscreen_passed"); // waits for players

    // notify settings HERE!
    LUINotifyEvent(#"enhancement_zombie_counter", 5, 3, level.TextHudColor, level.NumberHudColor, GetDvarInt(#"shield_enh_Counter_Position", 1), GetDvarInt(#"shield_enh_Counter_OnlyRemainingZombies", 0));

    thread UpdateZombieCounter();
}

UpdateZombieCounter() 
{
    level endon(#"end_game", #"game_ended");

    // wait zombie team
    while (!isdefined(level.zombie_team)) waitframe(1);

    old_count = -1;
    old_remaining = -1;

    while (true) 
    {
        zombies = GetAITeamArray(level.zombie_team);
        count = 0;

        foreach (zmb in zombies) 
        {
            if (isdefined(zmb.ignore_enemy_count) && zmb.ignore_enemy_count) continue;
            count++;
        }

        old_remaining = level.zombie_total;

        // try to always load config
        ReloadCounterConfig();
         LUINotifyEvent(#"enhancement_zombie_counter", 5, 3, level.TextHudColor, level.NumberHudColor, GetDvarInt(#"shield_enh_Counter_Position", 1), GetDvarInt(#"shield_enh_Counter_OnlyRemainingZombies", 0));

        LUINotifyEvent(#"enhancement_zombie_counter", 3, 1, count, old_remaining);
        util::wait_network_frame(1);

        /#
        if (count != old_count) 
        {
            old_count = count;
            foreach (plt in getplayers()) 
            {
                plt clientfield::set_to_player("" + #"zombies_counter_alive", count);
            }
        }

        if (level.zombie_total != old_remaining) 
        {
            old_remaining = level.zombie_total;
            foreach (plt in getplayers()) 
            {
                plt clientfield::set_to_player("" + #"zombies_counter_remaining", old_remaining);
            }
        }
        #/
    }
}

ReloadCounterConfig()
{
    level.TextHudColor = GetDvarInt(#"shield_enh_Counter_TextColor", 5);
    level.NumberHudColor = GetDvarInt(#"shield_enh_Counter_NumberColor", 1);
}