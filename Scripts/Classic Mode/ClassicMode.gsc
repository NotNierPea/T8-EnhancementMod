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
		callback::on_spawned(&ApplyBo3PortFields);
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
	thread MachinePowerWatcher();
	// 0 is normal Pack-a-Punch. 1 is Black Ops 1: one damage pack and no ammo type.
	// 2 is Black Ops 3: one damage pack, and later packs only roll an ammo type.
	pap_mode = GetDvarInt(#"shield_enh_ClassicMode_ClassicPaP", 0);
	if (pap_mode == 1 || pap_mode == 2)
		callback::function_aebeafc0(&ClassicPackAPunch);
	if (pap_mode == 1)
		callback::function_aebeafc0(&ClassicPackNoAat);
	else if (GetDvarInt(#"shield_enh_ClassicMode_Bo3Aat", 1))
		callback::function_aebeafc0(&AssignBo3Aat);

	callback::on_ai_killed(&on_ai_kill_vulture);
	callback::on_ai_killed(&Bo3TurnedKilled);

	//thread PrintTesting();
}

// Machine lamp on/off for meshswap _on manifests: mirrors map power so the
// plugin can swap lamp materials (bo3port_machine_on 1 = lit). IsPaPOrPowerOn
// is sanitized centrally (never returns teardown garbage), so a plain if here
// cannot hit the "cannot cast to bool" crash. Sync fans the state out to every
// client via clientfield (raw setdvar alone is host-only in coop).
MachinePowerWatcher()
{
    level endon(#"end_game");
    last = -1;
    while (true)
    {
        on = 0;
        if (IsPaPOrPowerOn())
            on = 1;
        if (on != last)
        {
            SyncBo3PortMachineOn(on);
            ShieldLog("^5Machine lamps " + (on ? "on" : "off"));
            last = on;
            // Power came back: catch up any machine that spawned while it
            // was off (guarded, powered machines never double up).
            if (on)
                ClassicPerkPowerReplay();
        }
        wait 2;
    }
}

// classic PaP keeps the first pack boost and still rolls a new AAT
ClassicPackAPunch(upgraded_weapon)
{
	if (!isdefined(upgraded_weapon))
		return;

	key = zm_weapons::function_93cd8e76(upgraded_weapon);
	if (!isdefined(self.var_2843d3cc) || !isdefined(self.var_2843d3cc[key]))
		return;

	if (self.var_2843d3cc[key] > 0)
		self.var_2843d3cc[key] = 0;
}

ClassicPackNoAat(upgraded_weapon)
{
	self endon(#"death");
	if (!isdefined(upgraded_weapon))
		return;
	wait 0.2;
	self aat::remove(upgraded_weapon);
	self clientfield::set_to_player("aat_current", 0);
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