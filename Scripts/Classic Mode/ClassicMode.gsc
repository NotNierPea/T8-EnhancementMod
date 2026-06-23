ClassicMode()
{
	if(GetDvarInt(#"shield_enh_ClassicMode", 0))
	{
		ShieldLog("^2Classic Mode On...");
		
		// loadout if on
		if (getDvarInt(#"shield_enh_ClassicMode_Loadouts", 1))
		{
			setgametypesetting(#"zmelixirsenabled", 0);
			setgametypesetting(#"zmtalismansenabled", 0);
		}

		thread ClassicMode_Setup();
		callback::on_connect(&init_player_zombie_vars);
		callback::on_spawned(&init_player_zombie_vars_spawn);
	}
}

ClassicMode_Setup()
{
	level.whoswho_laststand_func = &WhosWhoDownLogic;

	thread ClassicMode_RemoveSpecialists_Rework();
	thread ClassicMode_OldPointsSystem();
	thread ClassicMode_PlayerHealth();
	thread ClassicMode_PerksSystem_WeaponsSystem();
	thread ClassicMode_CustomPerks();
	thread Vulture_AddObjectives();

	callback::on_ai_killed(&on_ai_kill_vulture);

	//thread PrintTesting();
}

init_player_zombie_vars()
{
	ShieldLog("^2Classic Mode vars..");

	self.zombie_vars[#"custom_random_specialists_on"] = 0;

	self.HasJugg = false;
    self.HasElemental = false;

    self.perk_limit_classic = 0;
    self.perk_limit_classic_only = 0;
	//self.HasSpeedCola = false;

	self LUINotifyEvent(#"notify_speed_image", 1, 0);
	self LUINotifyEvent(#"notify_jugg_image", 1, 0);
    self LUINotifyEvent(#"notify_vulture_image", 1, 0);
	self LUINotifyEvent(#"notify_elem_image", 1, 0);
    self LUINotifyEvent(#"notify_whos_who_image", 1, 0);
	self LUINotifyEvent(#"notify_double_image", 1, 0);

    self LUINotifyEvent(#"enhancement_weapon_name_color", 1, 0);
}

init_player_zombie_vars_spawn()
{
	ShieldLog("^2Classic Mode vars spawned..");

	//if(GetDvarInt("shield_enh_SaveGame_Load", 0))
	 //return;

	level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

	setgametypesetting(#"scoreEquipmentPowerTimeFactor", 0);

    self thread WatcherPerk();
    self thread ClassicAchievementsWatcher();
}

ClassicMode_OldPointsSystem()
{
	level endon(#"end_game", #"game_ended");

	// thanks to GerardS0406!

	level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

	while (true)
	{
		level.a_func_score_events[#"damage_points"] = &damage_points;
		level.a_func_score_events[#"death"] = &death_points;

		wait 1.5;
	}
}

damage_points(event, mod, hit_location, zombie_team, damage_weapon)
{
    return 10;
}

death_points(event, mod, hit_location, zombie_team, damage_weapon)
{
    points = 50;
    if(mod == "MOD_MELEE" && (!isdefined(damage_weapon) || (!damage_weapon.isriotshield && !zm_loadout::is_hero_weapon(damage_weapon))))
    {
        scoreevents::processscoreevent("melee_kill", self, undefined, damage_weapon);
        points += 70;
    }
    else if(hit_location == "head" || hit_location == "helmet" || hit_location == "neck")
    {
        scoreevents::processscoreevent("headshot", self, undefined, damage_weapon);
        points += 40;
    }
    else
    {
        scoreevents::processscoreevent("kill", self, undefined, damage_weapon);
    }
    return points;
}

ClassicMode_PlayerHealth()
{
	level flagsys::wait_till(#"zombie_vars_init");
    zombie_utility::set_zombie_var(#"player_base_health", 150);
}