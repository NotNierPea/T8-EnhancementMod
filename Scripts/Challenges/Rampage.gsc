RampageMode()
{   
    thread Setup_RampageMode();    
}

UpdateRampageZombies()
{
    level endon(#"end_game", #"game_ended", #"rampage_off");

    a_ai_zombies = zombie_utility::get_zombie_array();
    foreach(zombie in a_ai_zombies)
    {
        if (!isdefined(zombie))
            continue;

        if (!level.RampageActive)
        {
            // revert to normal speed
            zombie thread zombie_utility::set_zombie_run_cycle_restore_from_override();
        }
        else
        {
            // set to super sprint
            zombie thread zombie_utility::set_zombie_run_cycle_override_value("sprint");
        }
    }
}

Setup_RampageMode()
{
    level endon(#"end_game", #"game_ended", #"rampage_off");

    level.RampageActive = false;

    if(GetDvarInt(#"shield_enh_RampageMode", 0)) 
        level.RampageActive = true;
    
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    if(GetDvarInt(#"shield_enh_TeamCranked", 0))
	{
		return;
	} 
    
    // stop overiding them
    while(true)
    {
        level waittill(#"rampage_toggle");
        if (level.RampageActive)
        {
            level.disable_nuke_delay_spawning = 1;
            level.zombie_round_start_delay = 0;

            zombie_utility::set_zombie_var(#"zombie_spawn_delay", 0);
            zombie_utility::set_zombie_var(#"zombie_between_round_time", 0);

            // super sprint mode
            if (zm_round_logic::get_round_number() < 31)
                level.var_43fb4347 = "sprint";
            else
                level.var_43fb4347 = undefined;
        }
        else
        {
            level.disable_nuke_delay_spawning = undefined;
            level.zombie_round_start_delay = undefined;

            level.var_43fb4347 = undefined;

            zombie_utility::set_zombie_var(#"zombie_spawn_delay", [[ level.func_get_zombie_spawn_delay ]](zm_round_logic::get_round_number()));
            zombie_utility::set_zombie_var(#"zombie_between_round_time", 15); // default
        }

        wait 1.5;
    }
}