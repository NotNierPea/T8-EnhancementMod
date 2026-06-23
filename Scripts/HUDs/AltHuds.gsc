AltHUD()
{
    callback::on_spawned(&init_althud_spawned);
}

init_althud_spawned()
{
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    if (!IsBot(self))
        self thread WeaponWatcher();
}

WeaponWatcher()
{
    self endon(#"death");

    wait 5;

    while(true)
    {
        weapon = zm_weapons::function_93cd8e76(self getCurrentWeapon());

        if (isDefined(self.var_2843d3cc) && isDefined(self.var_2843d3cc[weapon]) && self.var_2843d3cc[weapon] === 4)
        {
            self LUINotifyEvent(#"enhancement_weapon_name_color", 1, 1);
        }
        else
            self LUINotifyEvent(#"enhancement_weapon_name_color", 1, 0);

        wait 0.5;
    }
}