detour zm_powerups<scripts\zm_common\zm_powerups.gsc>::show_on_hud(player_team, str_powerup) {
    if(!GetDvarInt(#"shield_enh_PowerUpsTimer", 0))
        return [[ @zm_powerups<scripts\zm_common\zm_powerups.gsc>::show_on_hud ]](player_team, str_powerup);

    if(isdefined(str_powerup))
    {
        level thread StartTimer(GetPowerUpTimerID(str_powerup));
    }

    return [[ @zm_powerups<scripts\zm_common\zm_powerups.gsc>::show_on_hud ]](player_team, str_powerup);
}

GetPowerUpTimerID(str_powerup)
{
    switch(str_powerup)
    {
        case "insta_kill":
            return 1;
        case "double_points":
            return 2;
        case "fire_sale":
            return 3;
        case "zombie_blood":
            return 4;
        case "bonfire":
            return 5;
        default:
            return 0;
    }
}

PowerUpsTimer()
{
    if(!GetDvarInt(#"shield_enh_PowerUpsTimer", 0))
        return;

    level.timers = [];

    while(true)
    {
        wait_str = level waittill(#"player_zombie_blood", #"powerup_fire_sale", #"powerup bonfire sale");

        if (wait_str._notify === #"player_zombie_blood")
            level thread  StartTimer(4);
        else if (wait_str._notify === #"powerup_fire_sale")
            level thread StartTimer(3);
        else if (wait_str._notify === #"powerup bonfire sale")
            level thread StartTimer(5);
    }
}

StartTimer(id)
{
    level notify("timer_started");
    level notify("timer_started_" + id);
    level endon("timer_started_" + id);

    ShieldLog("Starting PowerUp Timer with ID: " + id);
    
    if (id == 0)
        return;

    time = 30;
    if (bgb::is_team_enabled(#"zm_bgb_temporal_gift"))
        time += 30;

    level.timers[id] = time;

    wait 0.1;
    level thread FixTimersPowerUps(id);
    for (i = time; i > 0; i--)
    {
        level.timers[id] = i;
        LUINotifyEvent(#"shield_enh_powerup_timer", 2, id, i);
        wait 1;
    }

    level notify("timer_ended");
    level notify("timer_ended_" + id);
}

FixTimersPowerUps(id)
{
    level endon("timer_started_" + id);
    level endon("timer_ended_" + id);

    while(true)
    {
        level waittill("timer_ended", "timer_started");
        wait 0.05;
        LUINotifyEvent(#"shield_enh_powerup_timer", 2, id, level.timers[id]);
    }
}