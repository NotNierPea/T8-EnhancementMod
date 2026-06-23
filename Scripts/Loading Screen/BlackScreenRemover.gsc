detour zm<scripts\zm_common\zm.gsc>::initialblack()
{
    if(!GetDvarInt(#"shield_enh_RemoveBlackScreen", 0)) 
    {
        return [[ @zm<scripts\zm_common\zm.gsc>::initialblack ]]();
    }
    else
    {
        ShieldLog("^6Removed BlackScreen");
        return;
    }
}

detour zm<scripts\zm_common\zm.gsc>::onallplayersready()
{
    if(!GetDvarInt(#"shield_enh_RemoveBlackScreen", 0)) 
    {
        return [[ @zm<scripts\zm_common\zm.gsc>::onallplayersready ]]();
    }

    level endon(#"game_ended");
    changeadvertisedstatus(0);
    while (isloadingcinematicplaying()) {
        waitframe(1);
    }
    if ("zclassic" == util::get_game_type()) {
        changeadvertisedstatus(1);
    }
    while (!getnumexpectedplayers(1)) {
        waitframe(1);
    }
    player_count_actual = 0;
    while (player_count_actual < getnumexpectedplayers(1)) {
        players = getplayers();
        player_count_actual = 0;
        for (i = 0; i < players.size; i++) {
            if (players[i].sessionstate == "playing" && !isbot(players[i])) {
                player_count_actual++;
            }
        }
        waitframe(1);
    }

    setinitialplayersconnected();

    a_e_players = getplayers();
    if (a_e_players.size == 1) {
        level flag::set("solo_game");
        level.solo_lives_given = 0;
    }

    level flag::set("all_players_connected");

    zm::function_9a8ab40f();

    while (!aretexturesloaded()) {
        waitframe(1);
    }

    function_5fad41b5();
    n_start_delay = 3;
    level util::delay(n_start_delay, "game_ended", &flag::set, "start_zombie_round_logic");
    level thread zm::function_d797f41f(n_start_delay - 0.1);
    zm::set_intermission_point();
    n_black_screen = n_start_delay + 2;
    wait n_black_screen;
    level.n_gameplay_start_time = gettime();
    clientfield::set("game_start_time", level.n_gameplay_start_time);

    level notify(#"initial_fade_in_complete");
    level thread zm::fade_out_intro_screen_zm(4);
    wait n_start_delay;

    wait 5;
    luinotifyevent(#"hash_3aef0da8363893b6");
}

// Fix DOTN Start Error
detour zm_mansion_zones<scripts\zm\zm_mansion_zones.gsc>::function_d274c574()
{
    if(GetDvarInt(#"shield_enh_Practice_Bosses", 0))
     return;
    
    else
        [[ @zm_mansion_zones<scripts\zm\zm_mansion_zones.gsc>::function_d274c574 ]]();
}

RemoveBlackScreen()
{

}