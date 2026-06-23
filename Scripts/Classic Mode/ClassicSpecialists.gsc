ClassicMode_RemoveSpecialists_Rework()
{
	//setGametypeSetting(#"zmspecweaponisenabled", 0);

	// set up powerups
	zm_powerups::register_powerup("custom_random_specialists", &CustomRandomSpecialists);
    zm_powerups::add_zombie_powerup("custom_random_specialists", "zombie_pickup_minigun", #"zombie/powerup_minigun", &func_should_drop_custom, 1, 0, 0);

	// setup random array
	switch(BO4GetMap()) // depending on maps, some hero weapons won't load
    {
        case "IX":
		level.RandomClassicSpecials = #"hero_scepter_lv3";
		break;

        case "Dead":
		level.RandomClassicSpecials = #"hero_chakram_lv3";
		break;

        case "Voyage":
		level.RandomClassicSpecials = #"hero_sword_pistol_lv3";
		break;

        case "AE":
		level.RandomClassicSpecials = #"hero_hammer_lv3";
        break;
        
        case "Classified":
		level.RandomClassicSpecials = #"hero_minigun_t8_lv3";
		break;

        case "AO":
		level.RandomClassicSpecials = #"hero_flamethrower_t8_lv3";
		break;

        case "Tag":
		level.RandomClassicSpecials = #"hero_gravityspikes_t8_lv3";
		break;

        case "Blood":
		level.RandomClassicSpecials = #"hero_katana_t8_lv3";
        break;
    }
}

func_should_drop_custom()
{
	return 1;
}

CheckDownedWeapon()
{
    self endon(#"death", #"replace_weapon_powerup", #"custom_random_specialists_stopped");

    self waittill(#"player_downed");

    wait 0.5;

    self takeWeapon(GetWeapon(level.RandomClassicSpecials));
    self.zombie_vars[#"custom_random_specialists_on"] = false;
	self notify(#"custom_random_specialists_stopped");
}

CustomRandomSpecialists(player)
{
    if(GetDvarInt(#"shield_enh_TeamCranked", 0))
	{
		PlayCrankedPowerUp("full_power");
	}

    // bug fix
    player thread CheckDownedWeapon();

	player endon(#"death", #"player_downed");

	if (player.zombie_vars[#"custom_random_specialists_on"])
	{
		//player iPrintLnBold("i didn't poop");
		return;
	}

	//player iPrintLnBold("i pooped");

	player thread GiveWeaponTimer(player, 45, level.RandomClassicSpecials);
	player thread zm_powerups::powerup_vo("minigun");
}

GiveWeaponTimer(player, timer, str_weapon)
{
	player endon(#"death", #"player_downed");

	player.zombie_vars[#"custom_random_specialists_on"] = true;

	player zm_hero_weapon::hero_give_weapon(GetWeapon(str_weapon), 1);
    player switchtoweapon(GetWeapon(str_weapon));

	player thread [[ @zm_powerup_hero_weapon_power<scripts\zm\powerup\zm_powerup_hero_weapon_power.gsc>::hero_weapon_power ]](player);
	player thread CheckWeaponChange(player, str_weapon);
	player thread CheckIfSwappedTooFast(player, str_weapon);
	
	player waittilltimeout(timer, #"custom_random_specialists_changed");

	player takeWeapon(GetWeapon(str_weapon));

	player.zombie_vars[#"custom_random_specialists_on"] = false;
	player notify(#"custom_random_specialists_stopped");
}

CheckIfSwappedTooFast(player, str_weapon)
{
	player endon(#"death", #"player_downed", #"replace_weapon_powerup", #"custom_random_specialists_stopped");

	wait 1.25;

	if (player getCurrentWeapon() != getweapon(str_weapon))
		player notify(#"custom_random_specialists_changed");
}

CheckWeaponChange(player, str_weapon)
{
	player endon(#"death", #"player_downed", #"replace_weapon_powerup", #"custom_random_specialists_stopped");

	// diff logic for some
	if (str_weapon == #"hero_scepter_lv3")
	{
		while (true) {
			waitresult = player waittill(#"weapon_change");

			if (player.var_d6fe2916)
				thread CheckScepterBacon(player);

			if (waitresult.weapon != level.weaponnone && waitresult.weapon != GetWeapon(str_weapon) && !player.var_d6fe2916) {
				break;
			}
    	}
	}
	else if (str_weapon == #"hero_minigun_t8_lv3")
	{
		while (true) {
			waitresult = player waittill(#"weapon_change");
			if (waitresult.weapon != level.weaponnone && waitresult.weapon != GetWeapon(str_weapon)) {
				wait 5;
				break;
			}
    	}
	}
	else
	{
		while (true) {
			waitresult = player waittill(#"weapon_change");
			if (waitresult.weapon != level.weaponnone && waitresult.weapon != GetWeapon(str_weapon)) {
				break;
			}
    	}
	}

	player notify(#"custom_random_specialists_changed");
}

CheckScepterBacon(player)
{
	player endon(#"death", #"player_downed", #"replace_weapon_powerup", #"custom_random_specialists_stopped");

	while (player.var_d6fe2916)
	{
		wait 1;
	}

	player notify(#"custom_random_specialists_changed");
}