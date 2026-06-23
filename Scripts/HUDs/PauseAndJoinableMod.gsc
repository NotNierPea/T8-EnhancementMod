PauseAlwaysJoinable()
{
    if(GetDvarInt(#"shield_enh_LobbyAlwaysJoinable", 0))
     thread SetLobbyAlwaysJoinable();

    if(GetDvarInt(#"shield_enh_ShieldPublicPause", 0))
     thread ShieldPublicPauseScript();
}

SetLobbyAlwaysJoinable()
{
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    ShieldLog("^2Always Joinable Lobby Loaded");

    while(true)
    {
        ChangeAdvertisedStatus(1);
        wait 1;
    }
}

ShieldPublicPauseScript()
{
    ShieldLog("^2Pause Mod Loaded");

    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    foreach(player in level.players) 
    {
        if(player isHost()) host_player = player;
    }

    wait 2.5;
    player iPrintLn("^0to Pause the Game, Hold Melee and Aim!");
    while(true)
    {
        if(host_player AdsButtonPressed() && host_player MeleeButtonPressed()) 
        {
            thread PauseMessage();
            level flag::set("world_is_paused");
            thread FreezeAllZombies();
            foreach(f_player in level.players)
            {
                f_player EnableInvulnerability();
                f_player freezecontrols(1);
                f_player.ignoreme = 1;
            }

            while(host_player AdsButtonPressed() && host_player MeleeButtonPressed()) 
             waitframe(1);

            while(true)
            {

                if(host_player AdsButtonPressed() && host_player MeleeButtonPressed()) 
                {
                    level notify("stop_pause_message");
                    foreach(player in level.players) player clientfield::set_to_player("" + #"shield_paused_hud", 0);
                    level flag::clear("world_is_paused");
                    thread FreezeAllZombies();
                    
                    foreach(f_player in level.players)
                    {
                        f_player DisableInvulnerability();
                        f_player freezecontrols(0);
                        f_player.ignoreme = 0;
                    }

                    while(host_player AdsButtonPressed() && host_player MeleeButtonPressed()) 
                     waitframe(1);
                    
                    break;
                }

                wait 0.01;
            }
        }
        wait 0.01;
    }
}

FreezeAllZombies()
{
    if(!isdefined( level.zombies_frozen ))
    {
        level.zombies_frozen = true;
        while(isDefined(level.zombies_frozen))
        {
            foreach(ai in GetAIArray())
            {
                if(isalive(ai) && !ai IsPaused())
                    FreezeZombie(ai);
            }
            wait .1;
        }
        foreach(ai in GetAIArray())
            UnFreezeZombie(ai);    
    }
    else 
        level.zombies_frozen = undefined;
}

FreezeZombie(ai)
{
    ai notify(#"hash_4e7f43fc");
    ai thread Freeze_Zombie_Death();
    ai SetEntityPaused(1);
    ai.var_70a58794 = ai.b_ignore_cleanup;
    ai.b_ignore_cleanup = 1;
    ai.var_7f7a0b19 = ai.is_inert;
    ai.is_inert = 1;
}

Freeze_Zombie_Death()
{
    self endon(#"hash_4e7f43fc");
    self waittill("death");
    if(isdefined(self) && self IsPaused())
    {
        self SetEntityPaused(0);
        if(!self IsRagdoll())
        {
            self StartRagdoll();
        }
    }
}

UnFreezeZombie(ai)
{
    ai notify(#"hash_4e7f43fc");
    ai SetEntityPaused(0);
    if(isdefined(ai.var_7f7a0b19))
        ai.is_inert = ai.var_7f7a0b19;
    if(isdefined(ai.var_70a58794))
        ai.b_ignore_cleanup = ai.var_70a58794;
    else
        ai.b_ignore_cleanup = 0;
}

PauseMessage()
{
    level endon(#"stop_pause_message");

    foreach(player in level.players) player clientfield::set_to_player("" + #"shield_paused_hud", 1);
}
