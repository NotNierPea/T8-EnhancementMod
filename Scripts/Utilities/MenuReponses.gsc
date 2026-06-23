MenuResponseSystem()
{
	level endon(#"end_game", #"game_ended");

	level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

	foreach(player in level.players)
	{
		if (!IsBot(player))
		{
			player.IsPlayingGesture = false;

			player callback::function_d8abfc3d(#"menu_response", &TryMenuResponse);
			player callback::function_d8abfc3d(#"menu_response", &TryHotkeyResponse);
			player callback::function_d8abfc3d(#"menu_response", &TryGestureResponse);
			player callback::function_d8abfc3d(#"menu_response", &TryClassChange);
			player callback::function_d8abfc3d(#"menu_response", &TryMainQuestContinue);
			player callback::function_d8abfc3d(#"menu_response", &TryBoxPatchResponse);

			if(!GetDvarInt(#"shield_enh_ClassicMode", 0) || !getDvarInt(#"shield_enh_ClassicMode_Loadouts", 1))
			{
				// elixirs saved
				for (i = 0; i < 4; i++)
				{
					player LUINotifyEvent(#"shield_enh_saved_bgbs", 2, i, level.bgb[player.bgb_pack[i]].item_index);
					util::wait_network_frame(1);
				}

				// specials save
				player LUINotifyEvent(#"shield_enh_saved_special", 1, GetSpecialistWeaponFromString(player.var_b708af7b));
				util::wait_network_frame(1);
			}

			// character save
			if (isdefined(player.pers[#"characterindex"]))
				player LUINotifyEvent(#"shield_enh_saved_character", 1, player.pers[#"characterindex"]);
			util::wait_network_frame(1);

			player thread MonitorWeaponsSaving();
		}
	}
}

MonitorWeaponsSaving()
{
	self endon(#"death", #"disconnect");

	for (weapon_index = 0; weapon_index < 3; weapon_index++)
	{
		self LUINotifyEvent(#"shield_enh_saved_weapons", 2, weapon_index, 0);
		self LUINotifyEvent(#"shield_enh_saved_weapons_camos", 2, weapon_index, 0);
	}

	while(true)
	{
		for (weapon_index = 0; weapon_index < 3; weapon_index++)
		{
			weapon_get = self getweaponslistprimaries()[weapon_index];
			if (!isdefined(weapon_get))
				continue;
			
			weapon = weapons::getbaseweapon(weapon_get);
			weapon_id = getbaseweaponitemindex(weapons::getbaseweapon(weapon_get));
			camo_id = getcamoindex(self getweaponoptions(weapon_get));

			// specials (500+), they do not have id set to them!!
			if (weapon_id == 0 || weapon.name == #"ray_gun")
			{
				// unpgraded..
				weapon_name_to_use = zm_weapons::get_base_weapon(weapon_get).name;
				switch(weapon_name_to_use)
				{
					case #"ww_crossbow_t8":
					weapon_id = 500;
					break;
					case #"ww_crossbow_charged_t8":
					weapon_id = 501;
					break;

					case #"ww_tricannon_t8":
					weapon_id = 502;
					break;
					case #"ww_tricannon_fire_t8":
					weapon_id = 503;
					break;
					case #"ww_tricannon_earth_t8":
					weapon_id = 504;
					break;
					case #"ww_tricannon_water_t8":
					weapon_id = 505;
					break;
					case #"ww_tricannon_air_t8":
					weapon_id = 506;
					break;

					case #"ww_blundergat_t8":
					weapon_id = 507;
					break;
					case #"ww_blundergat_acid_t8":
					weapon_id = 508;
					break;
					case #"ww_blundergat_fire_t8":
					weapon_id = 509;
					break;

					case #"ww_random_ray_gun1":
					weapon_id = 510;
					break;
					case #"ww_random_ray_gun2":
					weapon_id = 511;
					break;
					case #"ww_random_ray_gun3":
					weapon_id = 512;
					break;

					case #"ww_hand_c":
					weapon_id = 513;
					break;
					case #"ww_hand_g":
					weapon_id = 514;
					break;
					case #"ww_hand_h":
					weapon_id = 515;
					break;
					case #"ww_hand_o":
					weapon_id = 516;
					break;
					case #"ww_hand_c_uncharged":
					weapon_id = 517;
					break;
					case #"ww_hand_g_uncharged":
					weapon_id = 518;
					break;
					case #"ww_hand_h_uncharged":
					weapon_id = 519;
					break;
					case #"ww_hand_o_uncharged":
					weapon_id = 520;
					break;

					case #"ray_gun":
					weapon_id = 530;
					break;
					case #"ray_gun_mk2":
					weapon_id = 531;
					break;

					case #"ray_gun_mk2v":
					weapon_id = 521;
					break;
					case #"ray_gun_mk2x":
					weapon_id = 522;
					break;
					case #"ray_gun_mk2y":
					weapon_id = 523;
					break;
					case #"ray_gun_mk2z":
					weapon_id = 524;
					break;

					case #"thundergun":
					weapon_id = 525;
					break;
					case #"tundragun":
					weapon_id = 530;
					break;
					case #"ww_tesla_gun_t8":
					weapon_id = 526;
					break;
					case #"ww_tesla_sniper_t8":
					weapon_id = 527;
					break;

					case #"ww_freezegun_t8":
					weapon_id = 528;
					break;
					case #"ww_freezegun_t8_upgraded":
					weapon_id = 529;
					break;

					default:
					weapon_id = 0;
					break;
				}
			}

			self LUINotifyEvent(#"shield_enh_saved_weapons", 2, weapon_index, weapon_id);
			self LUINotifyEvent(#"shield_enh_saved_weapons_camos", 2, weapon_index, camo_id);
		}

		self waittill(#"weapon_change_complete", #"camo_changed");
	}
}

GetSpecialistWeaponFromString(name)
{
	switch(name)
	{
		case #"katana":
		return 1;
		break;

		case #"gravityspikes":
		return 2;
		break;

		case #"flamethrower":
		return 3;
		break;

		case #"minigun":
		return 4;
		break;

		case #"sword_pistol":
		return 5;
		break;

		case #"hammer":
		return 6;
		break;

		case #"chakram":
		return 7;
		break;

		case #"scepter":
		return 8;
		break;
	}

	return 0;
}

GetSpecialistWeaponFromInt(index)
{
	switch(index)
	{
		case 1:
		return #"hero_katana_t8_lv1";
		break;

		case 2:
		return #"hero_gravityspikes_t8_lv1";
		break;

		case 3:
		return #"hero_flamethrower_t8_lv1";
		break;

		case 4:
		return #"hero_minigun_t8_lv1";
		break;

		case 5:
		return #"hero_hammer_lv1";
		break;

		case 6:
		return #"hero_sword_pistol_lv1";
		break;

		case 7:
		return #"hero_chakram_lv1";
		break;

		case 8:
		return #"hero_scepter_lv1";
		break;
	}

	return undefined;
}

GetBGBNameFromInt(index)
{
	switch(index)
	{
		case 1:
		return #"zm_bgb_cache_back";
		break;
		case 2:
		return #"zm_bgb_burned_out";
		break;
		case 3:
		return #"zm_bgb_blood_debt";
		break;
		case 4:
		return #"zm_bgb_aftertaste";
		break;
	}

	return undefined;
}

TryClassChange(params) {
    if (!isalive(self)) {
        return;
    }

	menu = params.menu;

	if (menu != #"shield_enh_class_changes")
		return;

    response = params.response;
    intpayload = params.intpayload;

	// 1-8 -> specialist change
	// 10-14 -> elixir change!

	if (intpayload <= 8 && response === #"blah")
	{
		if (GetDvarInt(#"shield_enh_ClassicMode", 0))
			return;
		
		// specialist
		weapon_name = GetSpecialistWeaponFromInt(intpayload);
		self.var_fd05e363 = getweapon(weapon_name);
        weapon_level = 0;
        self.var_72d6f15d = weapon_level;
		self clientfield::set_player_uimodel("zmhud.weaponProgression", 0);
		self clientfield::set_player_uimodel("zmhud.weaponLevel", 0);
        self zm_hero_weapon::function_23978edd();
        self zm_hero_weapon::hero_give_weapon(self.var_fd05e363, 0);
        self.var_c9279111 = 0;
        self.var_821c9bf3 = 0;
        self.var_1bcf6a9e = 0;
        self.var_dc37311e = 0;
        self.var_da2f5f0b = 0;
        switch (self.var_72d6f15d) {
        case 0:
            self.var_c09adff0 = 0;
            self.var_e77eadb7 = 0;
            self.var_ec334996 = 0;
            break;
        case 1:
            self.var_c09adff0 = 0;
            self.var_e77eadb7 = 1;
            self.var_ec334996 = GetSpecialistRechargeThing(2800);
            break;
        case 2:
            self.var_c09adff0 = 1;
            self.var_e77eadb7 = 1;
            self.var_ec334996 = GetSpecialistRechargeThing(8000);
            break;
        }
	}
	else
	{
		if (response === #"shield_enh_character_choose")
		{
			// character change
			ShieldLog("^1Changing character to index " + intpayload);
			self player_role::set(intpayload, true);
			return;
		}

		// camos
		if (response === #"weapon_1_enh" || response === #"weapon_2_enh" || response === #"weapon_3_enh")
		{
			weapon_index = 0;

			if (response === #"weapon_2_enh")
				weapon_index = 1;

			if (response === #"weapon_3_enh")
				weapon_index = 2;

			currentweapon = self getweaponslistprimaries()[weapon_index];
			if (isdefined(currentweapon) && intpayload >= 0) {
				self setcamo(currentweapon, intpayload);
				self notify(#"camo_changed");

				camo_index_gsc = getcamoindex(self getweaponoptions(currentweapon));
				ShieldLog("^1recived in gsc -> " + intpayload + " with camo index (gsc) " + camo_index_gsc);
			}

			return;
		}

		// elixirs
		if (GetDvarInt(#"shield_enh_ClassicMode", 0) && getDvarInt(#"shield_enh_ClassicMode_Loadouts", 1))
			return;
		
		bgb_index = 0;

		if (response === #"bgb_2_enh")
			bgb_index = 1;
		if (response === #"bgb_3_enh")
			bgb_index = 2;
		if (response === #"bgb_4_enh")
			bgb_index = 3;

		info_bgb = getunlockableiteminfofromindex(intpayload);
		self.bgb_pack[bgb_index] = info_bgb.namehash;
    	self bgb_pack::function_7b91e81c(bgb_index, level.bgb[info_bgb.name].item_index);
	}
}

TryMenuResponse(params) {
    if (!isalive(self)) {
        return;
    }

	menu = params.menu;

	if (menu != #"shield_enh_menu")
		return;

    response = params.response;
    intpayload = params.intpayload;

	// camo
	if (response === #"shield_enh_camo")
	{
		currentweapon = self getcurrentweapon();
		if (isdefined(currentweapon) && intpayload >= 0) {
			self setcamo(currentweapon, intpayload);
		}

		return;
	}

	// others
	if (intpayload == 3)
	{
		SendVariatorsToLUI();
		return;
	}

	if (intpayload == 4 && self IsHost() && !GetDvarInt(#"shield_enh_TeamCranked", 0))
	{
		level.RampageActive = !level.RampageActive;
		level notify(#"rampage_toggle");

		wait 0.1;

		foreach(player in level.players)
		{
			//player iPrintLn("^1Rampage Mode " + (level.RampageActive ? "^2Enabled!" : "^1Disabled!"));
			player LUINotifyEvent(#"shield_enh_rampage_mode", 1, level.RampageActive ? 1 : 0);
		}

		wait 2;
		level thread UpdateRampageZombies();
		return;
	}
    
	if (intpayload == 0 || intpayload == 1)
		self SetClientThirdPerson(intpayload);
}

TryHotkeyResponse(params) {
	if (!isalive(self)) {
        return;
    }

	menu = params.menu;

	if (menu != #"shield_enh_hotkey_mgr")
		return;

    response = params.response;
    intpayload = params.intpayload;

	self iPrintLnBold("got -> " + intpayload);
}

GetGestureFromIntload(id)
{
	// hash_560542c2d099837a
	switch(id)
	{
		case 0:
		return #"boast_gone_fishing";
		break;

		case 1:
		return #"boast_yawn";
		break;

		case 2:
		return #"hash_64ce761954436ffe";
		break;

		case 3:
		return #"hash_596a7f418ed8390b";
		break;

		case 4:
		return #"hash_5a1fca53de7144ff";
		break;

		case 5:
		return #"hash_256d36aa9aa7267";
		break;

		case 6:
		return #"hash_4eafabcb77497dda";
		break;

		case 7:
		return #"hash_6942eb7d1a4776dc";
		break;

		case 8:
		return #"hash_6a1b24b4797190fb";
		break;

		case 9:
		return #"hash_64defe85143ff889";
		break;

		case 10:
		return #"hash_64defd85143ff6d6";
		break;

		case 11:
		return #"hash_64defc85143ff523";
		break;

		case 12:
		return #"hash_64defb85143ff370";
		break;
	}

	return undefined;
}

TryGestureResponse(params) {
	if (!isalive(self)) {
        return;
    }

	menu = params.menu;

	if (menu != #"shield_enh_gesture")
		return;

    response = params.response;
    intpayload = params.intpayload;

	// Yorker 371 Aggressive Breakfast -> unloaded gesture
	gesture = GetGestureFromIntload(intpayload);
	if (isDefined(gesture) && zm_utility::is_player_valid(self) && !self.IsPlayingGesture)
	{
		self.IsPlayingGesture = true;
		self SetClientThirdPerson(1);
		wait 0.5;
		self gestures::play_gesture(gesture, undefined, 0);
		
		// there is no self notify flag, wow
		while(!self isFiring() && !self IsSwitchingWeapons() && !self SprintButtonPressed())
			util::wait_network_frame();

		wait 2.35;
		self SetClientThirdPerson(0);
		self.IsPlayingGesture = false;
	}
}

TryMainQuestContinue(params) {
    if (!isalive(self) || !GetDvarInt(#"shield_enh_MainQuestContinue", 0)) {
        return;
    }

	menu = params.menu;

	if (menu != #"shield_enh_mainquest_continue")
		return;

    response = params.response;
    intpayload = params.intpayload;

	if (intpayload == 2)
	{
		level notify(#"mainquest_continue");
	}
	else
	{
		level notify(#"mainquest_end_match");
	}
}

TryBoxPatchResponse(params) {
    if (!isalive(self)) {
        return;
    }

	menu = params.menu;

	if (menu != #"shield_enh_boxpatch")
		return;

    response = params.response;
    intpayload = params.intpayload;
	weapon = getweapon(GetWeaponFromID(intpayload));

	level notify(#"stop_forcing_boxes");
	
	if (response == #"boxpatch_1_enh")
	{
		level.first_box_to_patch = weapon.name;
	}

	if (response == #"boxpatch_2_enh")
	{
		level.second_box_to_patch = weapon.name;
	}

	if (response == #"boxpatch_3_enh")
	{
		level.third_box_to_patch = weapon.name;
	}

	level thread ForceBoxes();
}