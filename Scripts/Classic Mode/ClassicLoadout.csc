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