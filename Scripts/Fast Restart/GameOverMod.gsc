GameOverFunctions()
{
    if(!GetDvarInt(#"shield_enh_GameOverOptions", 0)) 
     return;
    
    level.var_77805e8 = &GameOverRestart; // game over here
}

GameOverRestart()
{
    util::preload_frontend();
    wait 0.5;

    changeadvertisedstatus(1);
    players = getplayers();
    for (i = 0; i < players.size; i++)
    {
        players[i] setclientuivisibilityflag("weapon_hud_visible", 1);
        players[i] setclientminiscoreboardhide(0);
        players[i] val::reset(#"game_end", "freezecontrols");
        players[i] val::reset(#"game_end", "disablegadgets");
        players[i] val::reset(#"end_of_game", "freezecontrols");
    }

    foreach(player in level.players)
    {
        player val::set(#"end_game", "ignoreme", 1);
    }

    setmatchflag("game_ended", 0);
    setmatchflag("disableIngameMenu", 0);
    level clientfield::set("gameplay_started", 1);
    level clientfield::set("zesn", 0);
    level notify(#"stop_intermission");
    luinotifyevent(#"force_scoreboard", 0);

    Restart_Menu();
}

Restart_Menu() 
{
    players = getplayers();
    foreach (player in players) 
    {
        player thread CheckOptionClick();
    }
    level thread NotifyRestart();
    level waittill(#"resume_end_game");
    luinotifyevent(#"hash_3aa743d9ad6c8e19", 0);
    exitLevel(0);

    wait(666);
}

NotifyRestart() 
{
    level endon(#"resume_end_game");
    luinotifyevent(#"hash_1fc4832b89307895", 0);
}

CheckOptionClick() 
{
    level endon(#"resume_end_game");
    while (1) {
        waitresult = undefined;
        waitresult = self waittill(#"menuresponse");
        response = waitresult.response;
        if (response == "restart_level_zm") 
        {
            /#
            if (BO4GetMap() == "Tag") 
            {
                level notify(#"resume_end_game");
                return; // fast restart doesn't work for tag...
            }
            #/
            map_restart(0);
            wait(666);
        } 
        else if (response == "resume_end_game")
        {
            level notify(#"resume_end_game");
        }
    }
}