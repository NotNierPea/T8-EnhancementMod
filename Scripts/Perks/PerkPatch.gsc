// perk stuff
detour zm_bgb_perkaholic<scripts\zm_common\bgbs\zm_bgb_perkaholic.gsc>::activation()
{
	ShieldLog("^5Perka Called!!!");
	if (!GetDvarInt("shield_enh_Perka", 0))
	  return [[ @zm_bgb_perkaholic<scripts\zm_common\bgbs\zm_bgb_perkaholic.gsc>::activation ]]();

	// remove perk limit (6)
	self endon(#"fake_death", #"death", #"player_downed");
    if (!self laststand::player_is_in_laststand() && self.sessionstate != "spectator") {
        self [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::function_cc24f525 ]]();
        self thread [[ @zm_bgb_perkaholic<scripts\zm_common\bgbs\zm_bgb_perkaholic.gsc>::function_cd55a662 ]]();
        for (i = 0; i < 13; i++) {
            var_16c042b8 = self GetPerk();
            if (isdefined(var_16c042b8)) {
                self.var_1eba264f = 1;
                continue;
            }
            return;
        }
    }
}

detour zm_perks<scripts\zm_common\zm_perks.gsc>::function_80cb4982()
{
	if (!GetDvarInt("shield_enh_Perka", 0))
	 return [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::function_80cb4982 ]]();
	// -> return self.var_67ba1237.size >= 6;
	return false;
}

detour zm_perks<scripts\zm_common\zm_perks.gsc>::perks_register_clientfield()
{
    //if (!GetDvarInt("shield_enh_Perka", 0))
	// return [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::perks_register_clientfield ]]();
    
    if (isdefined(level.zombiemode_using_perk_intro_fx) && level.zombiemode_using_perk_intro_fx) {
        clientfield::register("scriptmover", "clientfield_perk_intro_fx", 1, 1, "int");
    }

    if (isdefined(level._custom_perks)) {
        a_keys = getarraykeys(level._custom_perks);
        for (i = 0; i < a_keys.size; i++) {
            if (isdefined(level._custom_perks[a_keys[i]].clientfield_register)) {
                level [[ level._custom_perks[a_keys[i]].clientfield_register ]]();
            }
        }
    }

    for (i = 0; i < 4; i++) {
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".itemIndex", 1, 5, "int", 0);
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".state", 1, 2, "int", 0);
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".progress", 1, 5, "float", 0);
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".chargeCount", 1, 3, "int", 0);
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".timerActive", 1, 1, "int", 0);
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".bleedoutOrderIndex", 1, 2, "int", 0);
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".bleedoutActive", 1, 1, "int", 0);
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".specialEffectActive", 1, 1, "int", 0);
        clientfield::register_clientuimodel("hudItems.perkVapor." + i + ".modifierActive", 6000, 1, "int", 0);
    }

    clientfield::register_clientuimodel("hudItems.perkVapor.bleedoutProgress", 9000, 8, "float", 0);
    
    for (i = 0; i < 13; i++) {
        n_version = 1;
        if (i >= 4) {
            n_version = 8000;
        }
        clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".itemIndex", n_version, 5, "int", 0);
        clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".state", n_version, 2, "int", 0);
        clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".progress", n_version, 2, "float", 0);
        clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".chargeCount", n_version, 2, "int", 0);
        clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".timerActive", n_version, 1, "int", 0);
        clientfield::register_clientuimodel("hudItems.extraPerkVapor." + i + ".specialEffectActive", n_version, 1, "int", 0);
    }

    clientfield::register("scriptmover", "" + #"hash_cf74c35ecc5a49", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_35fe26fc5cb223b3", 1, 3, "int");
    clientfield::register("toplayer", "" + #"hash_6fb426c48a4877e0", 1, 3, "int");
    clientfield::register("toplayer", "" + #"hash_345845080e40675d", 1, 3, "int");
    clientfield::register("toplayer", "" + #"hash_1da6660f0414562", 1, 3, "int");
    
    if (level.var_c3e5c4cd == 2) {
        clientfield::register("world", "" + #"hash_46334db9e3c76275", 1, 1, "int");
        clientfield::register("scriptmover", "" + #"hash_50eb488e58f66198", 1, 1, "int");
        clientfield::register("allplayers", "" + #"hash_222c3403d2641ea6", 1, 3, "int");
        clientfield::register("toplayer", "" + #"hash_17283692696da23b", 1, 1, "counter");
    }
}

detour zm_perks<scripts\zm_common\zm_perks.gsc>::function_ad1814a1(n_index, var_b0ab4cec)
{
    if (!GetDvarInt("shield_enh_Perka", 0))
	 return [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::function_ad1814a1 ]](n_index, var_b0ab4cec);

    if (isdefined(n_index) && n_index >= 0 && n_index < 13) {
        return true;
    }

    return false;
    //println("<unknown string>" + function_9e72a96(var_b0ab4cec) + "<unknown string>");
    //return false;
}

GetPerk(var_9bf8fb5c)
{
    if (self.var_67ba1237.size >= 6) {
        //return undefined; fuck off
    }
    var_16c042b8 = self [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::function_5ea0c6cf ]](var_9bf8fb5c);
    if (isdefined(var_16c042b8)) {
        self [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::function_a7ae070c ]](var_16c042b8);
        return var_16c042b8;
    }
    self playsoundtoplayer(level.zmb_laugh_alias, self);
    return undefined;
}

SuperPerksMode()
{
    level endon(#"end_game", #"game_ended");

    if (!GetDvarInt("shield_enh_SuperPerkMode", 0))
        return;

    level flag::wait_till("all_players_spawned"); // waits for players 
    level flag::wait_till("initial_blackscreen_passed"); // waits for players

    while(true)
    {
        foreach(player in level.players)
        {
            player SuperPerks();
        }

        wait 10;
    }
}

SuperPerks()
{
    // THIS IS OP!!!! (mods all perks)
    self endon(#"death");

    for (i = 0; i < self.var_c27f1e90.size; i++)
    {
        perk = self.var_c27f1e90[i];
        ActiveModTry = level.var_5355c665[perk];
        if (self hasperk(perk) && isDefined(ActiveModTry) && !self hasperk(ActiveModTry))
        {
            self notify(#"hash_13948ef3726b968f", {#ActiveModTry:ActiveModTry});
            self zm_perks::function_df87281a(ActiveModTry);

            //if (i != 4) 
                //self clientfield::set_player_uimodel("hudItems.perkVapor." + i + ".modifierActive", 1);
        }
    }
    
    for (i = 0; i < self.var_67ba1237.size; i++)
    {
        perk = self.var_67ba1237[i];
        ActiveModTry = level.var_5355c665[perk];
        if (self hasperk(perk) && isDefined(ActiveModTry) && !self hasperk(ActiveModTry))
        {
            self notify(#"hash_13948ef3726b968f", {#ActiveModTry:ActiveModTry});
            self zm_perks::function_df87281a(ActiveModTry);
        }
    }

    // give fast reload ffs
    self zm_perks::function_4d342a8f();

    // Toggle Ui's Extra Perks? probably not
}