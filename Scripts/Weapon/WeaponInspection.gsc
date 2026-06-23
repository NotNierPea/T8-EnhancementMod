EnableWeaponInspection()
{
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");
    
    // done in client...
}