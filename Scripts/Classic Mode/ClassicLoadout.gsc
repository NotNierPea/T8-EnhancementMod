ClassicMode_PerksSystem_WeaponsSystem()
{
	if (!getDvarInt(#"shield_enh_ClassicMode_Loadouts", 1))
		return;
	
	level flag::wait_till("all_players_connected");
	
	//foreach(player in level.players)
	 //player thread Starting_PerksOverride();
	
	foreach(player in level.players)
	 player thread Starting_WeaponsOverride();
}

GetPerkClassicMode(PerkIndex)
{
	level.defaultPerkMap = array(
		#"specialty_extraammo",
		#"specialty_camper",
		#"specialty_staminup",
		#"specialty_additionalprimaryweapon"
	);

	level.mapPerkOverrides = array();
	level.mapPerkOverrides["Classified"] = array(
		#"specialty_staminup",
		#"specialty_cooldown",
		#"specialty_wolf_protector",
		#"specialty_electriccherry"
	);
	level.mapPerkOverrides["IX"] = array(
		#"specialty_phdflopper",
		#"specialty_widowswine",
		#"specialty_camper",
		#"specialty_wolf_protector"
	);
	level.mapPerkOverrides["Voyage"] = array(
		#"specialty_extraammo",
		#"specialty_deadshot",
		#"specialty_quickrevive",
		#"specialty_shield"
	);
	level.mapPerkOverrides["Blood"] = array(
		#"specialty_quickrevive",
		#"specialty_camper",
		#"specialty_phdflopper",
		#"specialty_staminup"
	);
	level.mapPerkOverrides["Dead"] = array(
		#"specialty_widowswine",
		#"specialty_phdflopper",
		#"specialty_camper",
		#"specialty_wolf_protector"
	);
	level.mapPerkOverrides["AE"] = array(
		#"specialty_phdflopper",
		#"specialty_widowswine",
		#"specialty_shield",
		#"specialty_cooldown"
	);
	level.mapPerkOverrides["AO"] = array(
		#"specialty_electriccherry",
		#"specialty_cooldown",
		#"specialty_camper",
		#"specialty_deadshot"
	);
	level.mapPerkOverrides["Tag"] = array(
		#"specialty_camper",
		#"specialty_wolf_protector",
		#"specialty_staminup",
		#"specialty_cooldown"
	);

	map = BO4GetMap();

	// Use override if defined
	if (isDefined(level.mapPerkOverrides[map]) && isDefined(level.mapPerkOverrides[map][PerkIndex]))
	{
		return level.mapPerkOverrides[map][PerkIndex];
	}

	// Use default if defined
	if (isDefined(level.defaultPerkMap[PerkIndex]))
	{
		return level.defaultPerkMap[PerkIndex];
	}

	// Fallback
	return #"specialty_mystery";
}

Starting_WeaponsOverride()
{
	ShieldLog("^5Override Weapons Classic");

	// specialty_fastreload, fast reload

	switch(BO4GetMap())
    {
        case "IX":
		self OverrideStartingWeapon(#"pistol_topbreak_t8");
        break;

        case "Blood":
		self OverrideStartingWeapon(#"pistol_standard_t8");
        break;

        case "AE":
		self OverrideStartingWeapon(#"pistol_topbreak_t8");
        break;

        case "AO":
		self OverrideStartingWeapon(#"pistol_standard_t8");
        break;

        case "Dead":
		self OverrideStartingWeapon(#"pistol_topbreak_t8");
        break;

        case "Tag":
		self OverrideStartingWeapon(#"pistol_standard_t8");
        break;

        case "Classified":
		self OverrideStartingWeapon(#"pistol_standard_t8");
        break;

        case "Voyage":
		self OverrideStartingWeapon(#"pistol_topbreak_t8");
        break;
    }

	if(GetDvarInt("shield_enh_SaveGame_Load", 0))
	 return;

	// oops
	self giveweapon(level.weaponbasemelee);

	self zm_weapons::weapon_give(getweapon(#"eq_frag_grenade"));
	self zm_loadout::set_player_lethal_grenade(getweapon(#"eq_frag_grenade"));
}

OverridePerkSlot(PerkName, Index)
{
	// got it from zm tut
	self.var_c27f1e90[Index] = PerkName;
	self.var_47654123[Index] = 0;

	self zm_perks::function_4acf7b43(Index, PerkName);
}

OverrideStartingWeapon(WeaponName)
{
	if(GetDvarInt("shield_enh_SaveGame_Load", 0))
	 return;
	
	self takeallweapons();
	self zm_weapons::weapon_give(GetWeapon(WeaponName));
}