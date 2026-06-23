ClassicMode_CustomPerks()
{
	level.CustomClassicPerks = [];
	
    level flag::wait_till("all_players_spawned");
    ShieldLog("^1Init Classic Mode Custom Perks!!");
    
    perk_data = GetPerkDataForMap();
    if (!isdefined(perk_data))
    {
        ShieldLog("^1ERROR: Unsupported map for Classic Mode Custom Perks");
        return;
    }
    
    SpawnCustomPerk("jugg", perk_data.jugg_pos, perk_data.jugg_angles, GetPerkModel("jugg"));
    SpawnCustomPerk("speed", perk_data.speed_pos, perk_data.speed_angles, GetPerkModel("speed"));
    SpawnCustomPerk("double", perk_data.double_pos, perk_data.double_angles, GetPerkModel("double"));
	SpawnCustomPerk("vulture", perk_data.vulture_pos, perk_data.vulture_angles, GetPerkModel("vulture"));
	SpawnCustomPerk("whos_who", perk_data.whos_who_pos, perk_data.whos_who_angles, GetPerkModel("whos_who"));
    SpawnCustomPerk("elemental", perk_data.elemental_pos, perk_data.elemental_angles, GetPerkModel("elemental"));

    SpawnCustomPerk("wonderfizz", perk_data.wonderfizz_pos, perk_data.wonderfizz_angles, GetPerkModel("wonderfizz"));
}

GetPerkDataForMap()
{
    map_name = BO4GetMap();
    data = spawnstruct();
    
    switch(map_name)
    {
        case "IX":
            data.jugg_pos = (68, -644, -247);
            data.jugg_angles = (0, 180, 0);
            data.speed_pos = (-76, 662, -247);
            data.speed_angles = (0, 0, 0);
            data.double_pos = (-1370, 790, -228);
            data.double_angles = (0, -90, 0);
			data.vulture_pos = (147, -653, 32);
            data.vulture_angles = (0, -164, 0);
			data.whos_who_pos = (1974, -380, -231);
            data.whos_who_angles = (0, -90, 0);
            data.elemental_pos = (-1578, -280, -231);
            data.elemental_angles = (0, 0, 0);
            data.wonderfizz_pos = (1427, 800, -231);
            data.wonderfizz_angles = (0, 90, 0);
            break;
            
        case "Blood":
            data.jugg_pos = (7262, 10752, 319);
            data.jugg_angles = (0, 70, 0);
            data.speed_pos = (1650, 9134, 1336);
            data.speed_angles = (0, 90, 0);
            data.double_pos = (939, 8899, 1544);
            data.double_angles = (0, -90, 0);
			data.vulture_pos = (8887, 11629, 448);
            data.vulture_angles = (0, 98, 0);
			data.whos_who_pos = (7901, 8415, 392);
            data.whos_who_angles = (0, 50, 0);
            data.elemental_pos =  (-1134, 6027, -71);
            data.elemental_angles = (0, 10, 0);
            data.wonderfizz_pos = (-2146, 7634, 1304);
            data.wonderfizz_angles = (0, -180, 0);
            break;
            
        case "AE":
            data.jugg_pos = (-1984, 41, 192);
            data.jugg_angles = (0, -180, 0);
            data.speed_pos = (-3077, -661, 0.125);
            data.speed_angles = (0, 0, 0);
            data.double_pos = (-3083, -2959, -223);
            data.double_angles = (0, 90, 0);
			data.vulture_pos = (-2136, -1396, 48);
            data.vulture_angles = (0, 100, 0);
			data.whos_who_pos =  (-190, 8828, 388);
            data.whos_who_angles = (0, -15, 0);
            data.elemental_pos = (147, -278, 0);
            data.elemental_angles = (0, 11, 0);
            data.wonderfizz_pos = (-307, -4199, -711);
            data.wonderfizz_angles = (0, -95, 0);
            break;
            
        case "AO":
            data.jugg_pos = (-1637, -1114, -64);
            data.jugg_angles = (0, 0, 0);
            data.speed_pos = (-1183, -91, -62);
            data.speed_angles = (0, 160, 0);
            data.double_pos = (850, 373, 79);
            data.double_angles = (0, 12, 0);
			data.vulture_pos = (-240, -2338, -57);
            data.vulture_angles = (0, 90, 0);
			data.whos_who_pos = (1377, 1283, -319);
            data.whos_who_angles = (0, 90, 0);
            data.elemental_pos =  (1246, -2096, -62);
            data.elemental_angles = (0, 90, 0);
            data.wonderfizz_pos = (-393, 494, -58);
            data.wonderfizz_angles = (0, 70, 0);
            break;
            
        case "Dead":
            data.jugg_pos = (1, 1398, -255);
            data.jugg_angles = (0, 0, 0);
            data.speed_pos = (1477, -464, -215);
            data.speed_angles = (0, -180, 0);
            data.double_pos = (-2038, -230, -7);
            data.double_angles = (0, 180, 0);
			data.vulture_pos = (462, -794, -7);
            data.vulture_angles = (0, 90, 0);
			data.whos_who_pos = (-617, -1296, -415);
            data.whos_who_angles = (0, -180, 0);
            data.elemental_pos = (-2887, 1419, 112);
            data.elemental_angles = (0, -90, 0);
            data.wonderfizz_pos = (-129, 3420, -420);
            data.wonderfizz_angles = (0, 10, 0);
            break;
            
        case "Tag":
            data.jugg_pos = (-338, 216, 7);
            data.jugg_angles = (0, 53, 0);
            data.speed_pos = (-2575, -74, 20);
            data.speed_angles = (0, 90, 0);
            data.double_pos = (636, -1090, 87);
            data.double_angles = (0, -40, 0);
			data.vulture_pos = (616, 3319, 26);
            data.vulture_angles = (0, 20, 0);
			data.whos_who_pos = (63, 3599, 20);
            data.whos_who_angles = (0, -70, 0);
            data.elemental_pos = (-813, 976, 495);
            data.elemental_angles = (0, 90, 0);
            data.wonderfizz_pos = (-1087, 1081, 375);
            data.wonderfizz_angles = (0, 90, 0);
            break;
            
        case "Classified":
            data.jugg_pos = (-62, 935, -511);
            data.jugg_angles = (0, 55, 0);
            data.speed_pos = (-1140, 1930, 16);
            data.speed_angles = (0, 180, 0);
            data.double_pos = (-865, 4997, -712);
            data.double_angles = (0, 90, 0);
			data.vulture_pos = (-972, 2865, 16);
            data.vulture_angles = (0, 180, 0);
			data.whos_who_pos = (686, 2400, 16);
            data.whos_who_angles = (0, 0, 0);
            data.elemental_pos = (-907, 5001, -712);
            data.elemental_angles = (0, -90, 0);
            data.wonderfizz_pos = (8390, 1084, -423);
            data.wonderfizz_angles = (0, 180, 0);
            break;
            
        case "Voyage":
            data.jugg_pos = (-620, -1990, 928);
            data.jugg_angles = (0, 90, 0);
            data.speed_pos = (248, 748, 1056);
            data.speed_angles = (0, 0, 0);
            data.double_pos = (645, -1219, 1216);
            data.double_angles = (0, -90, 0);
			data.vulture_pos = (-92, -3994, 928);
            data.vulture_angles = (0, -1, 0);
			data.whos_who_pos =  (-645, 792, 1216);
            data.whos_who_angles = (0, 89, 0);
            data.elemental_pos = (609, -2081, 928);
            data.elemental_angles = (0, -90, 0);
            data.wonderfizz_pos = (68, -316, 1376);
            data.wonderfizz_angles = (0, -1, 0);
            break;
            
        default:
            return undefined;
    }
    
    return data;
}

GetPerkModel(perk_type)
{
    is_chaos = BO4ChaosMap();
    
    switch(perk_type)
    {
        case "jugg":
            return is_chaos ? #"p7_zm_vending_widows_wine" : #"p8_zm_esc_perk_vending_cola";
        case "speed":
            return #"p7_zm_vending_sleight";
        case "double":
            return #"p7_zm_vending_ads";
		case "vulture":
			return #"p7_zm_vending_nuke";
		case "whos_who":
			return #"p7_zm_vending_revive";
		case "elemental":
			return #"p7_zm_vending_marathon";
        case "wonderfizz":
			return #"hash_36a819a6d297514e";
        default:
            return #"";
    }
}

RemoveMainPerk(n_slot, perk)
{
    perk_str = perk + "_stop";
            
    var_ac32c1b8 = 0;
    self perks::perk_unsetperk(perk);
    if (isdefined(self.var_47654123[n_slot]) && self.var_47654123[n_slot] && self.var_c27f1e90[n_slot] == perk) {
        self.var_c27f1e90[n_slot] = #"specialty_mystery";
        self.var_c4193958[n_slot] = "";
        var_ac32c1b8 = 1;
    }
    if (isdefined(level._custom_perks[perk].var_658e2856)) {
        if (isarray(level._custom_perks[perk].var_658e2856)) {
            foreach (specialty in level._custom_perks[perk].var_658e2856) {
                perks::perk_unsetperk(specialty);
            }
        } else {
            perks::perk_unsetperk(level._custom_perks[perk].var_658e2856);
        }
    }
    self.num_perks--;
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_take)) {
        self thread [[ level._custom_perks[perk].player_thread_take ]](0, perk_str, "player_downed", n_slot);
    }
    self zm_perks::set_perk_clientfield(perk, 0);
    if (n_slot < 4) {
        self zm_perks::function_2ac7579(n_slot, 0);
        if (self.var_47654123[n_slot]) {
            if (var_ac32c1b8) {
                self zm_perks::function_81bc6765(n_slot, level._custom_perks[#"specialty_mystery"].alias);
            }
        } else {
            self zm_perks::function_fb633f9d(n_slot, 0);
        }
    }
    if (isdefined(level.var_a903ab55)) {
        self [[ level.var_a903ab55 ]](perk);
    }
    arrayremovevalue(self.var_466b927f, perk, 0);
    self notify(#"perk_vapor_lost");
    var_5fe29258 = self.var_c27f1e90[4];
    if (isdefined(var_5fe29258) && isinarray(self.var_466b927f, var_5fe29258)) {
        if (isdefined(self.talisman_perk_mod_single) && self.talisman_perk_mod_single && n_slot < 3) {
            return;
        }
        self notify(var_5fe29258 + "_stop");
        self zm_perks::function_b8c12b0f(3, 0);
        self zm_perks::function_528f82a9();
    }
}

RefundLogic(price, perk_str, s_slot = 0)
{
    self endon(#"death");

    player_is_classic_perk = false;
    if (isDefined(perk_str)) {
        switch(perk_str)
        {
            case "HasJugg":
            case "specialty_doubletap2":
            case "specialty_rof":
            case "specialty_whoswho":
            case "HasElemental":
            case "specialty_vultureaid":
            case "specialty_fastreload":
                player_is_classic_perk = true;
            break;
        }
    }

    while (true)
	{
        if (!isdefined(self) || !isdefined(self.origin))
            return;
        
		player = arraygetclosest(self.origin, level.players);

        if (!isDefined(player))
        {
            wait 0.5;
            continue;
        }
  
		if (zombie_utility::is_player_valid(player) && player util::is_looking_at(self.origin, 0.9, false, player_is_classic_perk ? (0, 0, 50) : (0, 0, 0)) 
        && player meleebuttonpressed() && distancesquared(self.origin, player.origin) < 9216) {
            player_has_perk = false;

            if (isDefined(perk_str)) {
                if (perk_str == "HasJugg")
                {
                    player_has_perk = player.HasJugg;
                }
                else if (perk_str == "HasElemental")
                {
                    player_has_perk = player.HasElemental;
                }
                else
                {
                    player_has_perk = player hasPerk(perk_str);
                }
            }
            else
            {
                perk_str = player.var_47654123[s_slot] ? #"specialty_mystery" : player.var_c27f1e90[s_slot];
                player_has_perk = player hasPerk(perk_str);

                price = level [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::function_44915d1 ]](perk_str, s_slot);
            }

            if (!player_has_perk)
            {
                wait 0.5;
                continue;
            }

			player zm_score::add_to_player_score(price);

            if (player_is_classic_perk)
                player RemoveClassicPerk(perk_str);
            else
            {
                // other logic for main perks..
                player RemoveMainPerk(s_slot, perk_str);
            }

            player iPrintLn(#"shield/refund_get", zm_perk_translate(perk_str));
		}

		wait 0.15;
	}
}

SpawnCustomPerk(perk_type, position, angles, model)
{
    if (!isdefined(model) || model == #"")
    {
        ShieldLog("^1ERROR: Invalid model for perk type: " + perk_type);
        return;
    }
    
    perk_machine = util::spawn_model(model, position, angles);
    
    switch(perk_type)
    {
        case "jugg":
            perk_machine zm_unitrigger::create(&CheckStringJugg, 110);
            perk_machine thread WaitTriggerJugg();
			playfxontag(#"zombie/fx_perk_mule_kick_zmb", perk_machine, "tag_origin");
            perk_machine.perk_fx = 1;

            perk_machine thread RefundLogic(2500, "HasJugg");

            if (!BO4ChaosMap())
                CreateCollisionForPerk(position, angles);

            perk_machine.vulture_id = 10;
            break;
            
        case "speed":
            perk_machine zm_unitrigger::create(&CheckStringSpeedCola, 110);
            perk_machine thread WaitTriggerSpeedCola();
			playfxontag(#"zombie/fx_perk_mule_kick_zmb", perk_machine, "tag_origin");
            perk_machine.perk_fx = 1;

            perk_machine thread RefundLogic(3000, "specialty_fastreload");

            perk_machine.vulture_id = 11;
            break;
            
        case "double":
            perk_machine zm_unitrigger::create(&CheckStringDoubleTab, 110);
            perk_machine thread WaitTriggerDoubleTab();
			playfxontag(#"zombie/fx_perk_mule_kick_zmb", perk_machine, "tag_origin");
            perk_machine.perk_fx = 1;

            perk_machine thread RefundLogic(2000, getDvarInt("shield_enh_ClassicMode_DoubleTab2", 0) ? "specialty_doubletap2" : "specialty_rof");

            perk_machine.vulture_id = 12;
            break;

		case "vulture":
			perk_machine zm_unitrigger::create(&CheckStringVulture, 110);
            perk_machine thread WaitTriggerVulture();
			playfxontag(#"zombie/fx_perk_mule_kick_zmb", perk_machine, "tag_origin");
            perk_machine.perk_fx = 1;

            perk_machine thread RefundLogic(3000, "specialty_vultureaid");

            perk_machine.vulture_id = 13;
			break;

		case "whos_who":
			perk_machine zm_unitrigger::create(&CheckStringWhosWho, 110);
            perk_machine thread WaitTriggerWhosWho();
			playfxontag(#"zombie/fx_perk_mule_kick_zmb", perk_machine, "tag_origin");
            perk_machine.perk_fx = 1;
            
            perk_machine thread RefundLogic(2000, "specialty_whoswho");

            perk_machine.vulture_id = 14;
			break;

        case "elemental":
            perk_machine zm_unitrigger::create(&CheckStringElemental, 110);
            perk_machine thread WaitTriggerElemental();
            playfxontag(#"zombie/fx_perk_mule_kick_zmb", perk_machine, "tag_origin");
            perk_machine.perk_fx = 1;

            perk_machine thread RefundLogic(2500, "HasElemental");

            perk_machine.vulture_id = 15;

            level.debugperk = perk_machine;
            break;

        case "wonderfizz":
            perk_machine zm_unitrigger::create(&CheckStringWonderfizz, 110);
            perk_machine thread WaitTriggerWonderfizz();
            perk_machine.angles += (0, -90, 0);
            perk_machine.origin += (0, 0, 45);
            perk_machine SetScale(100);
            playfxontag(#"zombie/fx_perk_mule_kick_zmb", perk_machine, "tag_origin");
            perk_machine.perk_fx = 1;

            CreateCollisionForPerk(position, angles);

            perk_machine.vulture_id = 16;
            break;
    }
    
    perk_machine thread CheckMoneyShit();

	// for vulture..
	level.CustomClassicPerks[level.CustomClassicPerks.size] = perk_machine;
}

CreateCollisionForPerk(position, angles)
{
    // Spawn collision model for non-chaos maps
    collision_model = util::spawn_model(#"zm_collision_perks1", position, angles);
    
    collision = spawn("script_model", position, 1);
    collision.angles = angles;
    collision setmodel(#"zm_collision_perks1");
    collision.script_noteworthy = "clip";
    collision disconnectpaths();
}

CheckStringWonderfizz(e_player)
{
    if (isDefined(e_player.wonder_hint_string) && isDefined(e_player.wonder_hint_string_param))
    {
        self sethintstringforplayer(e_player, e_player.wonder_hint_string, e_player.wonder_hint_string_param);
        return true;
    }

    // prob broken...
    if (isDefined(level.Wonderfizz_IsBeingUsed))
    {
        self sethintstringforplayer(e_player, #"");
        return true;
    }

    if (e_player.perk_limit_classic >= 5)
    {
		self sethintstringforplayer(e_player, #"shield/perk_limit");
		return true;
    }

    calc_perks_player = 0;

    // main's
    for (i = 0; i < e_player.var_c27f1e90.size; i++)
    {
        perk = e_player.var_c27f1e90[i];
        if (e_player hasperk(perk))
        {
            calc_perks_player += 1;
        }
    }

    if (calc_perks_player >= 4 && ((!GetDvarInt("shield_enh_Perka", 0) && e_player.var_67ba1237.size == 6) || e_player.var_67ba1237.size >= 12) && e_player.perk_limit_classic_only == 6)
    {
		self sethintstringforplayer(e_player, #"shield/perk_limit");
		return true;
    }

	if (!IsPaPOrPowerOn())
	{
		self sethintstringforplayer(e_player, #"shield/power_need");
		return true;
	}
	
	self sethintstringforplayer(e_player, #"shield/wonderfizz_buy", GetDvarInt("shield_enh_Perka", 0) ? 3500 : 1500);
    return true;
}

zm_perk_translate(hash_name) {
    switch (hash_name) {
    case #"specialty_zombshell": return #"hash_21c31107d0b6a38d";
    case #"specialty_wolf_protector": return #"hash_30055ed20d2baf3d";
    case #"specialty_widowswine": return #"hash_5caecfedd16e95fe";
    case #"specialty_staminup": return #"hash_42fc56edc608703e";
    case #"specialty_shield": return #"hash_5158f60bef295a94";
    case #"specialty_quickrevive": return #"hash_67c5237bb928f6b5";
    case #"specialty_phdflopper": return #"hash_7ec0f84aeb42eb0a";
    case #"specialty_mystery": return #"hash_7be9f8f4a234865c";
    case #"specialty_extraammo": return #"hash_344b994775dc8a41";
    case #"specialty_etherealrazor": return #"hash_1dbbe0275b49d885";
    case #"specialty_electriccherry": return #"hash_71d6f93cb407a4d4";
    case #"specialty_death_dash": return #"hash_110410c820017785";
    case #"specialty_deadshot": return #"hash_77bff467c43496f";
    case #"specialty_cooldown": return #"hash_49f0aa4a7e9071c0";
    case #"specialty_camper": return #"hash_15b911614b3aa7f5";
    case #"specialty_berserker": return #"hash_6cf320ffccc0c0b9";
    case #"specialty_awareness": return #"hash_21a94127aad926ea";
    case #"specialty_additionalprimaryweapon": return #"hash_16662fc5fb0dce2";

    case #"specialty_fastreload": return #"shield/fastreload_string";
    case #"specialty_vultureaid": return #"shield/vulture_string";
    case #"HasElemental": return #"shield/elemental_string";
    case #"specialty_whoswho": return #"shield/whoswho_string";
    case #"specialty_doubletap2": return #"shield/doubletab_string";
    case #"specialty_rof": return #"shield/doubletab_string";
    case #"HasJugg": return #"shield/jugg_string";

    default: return #"hash_16662fc5fb0dce2";
    }
}

zm_perk_get_viewmodel(hash_name) {
    if (BO4ChaosMap())
    {
        switch (hash_name)   
        {
            case #"specialty_zombshell": return #"hash_7ec0e3d60c3ddf98";
            case #"specialty_wolf_protector": return #"hash_281d001c8d958aa6";
            case #"specialty_widowswine": return #"hash_36a819a6d297514e";
            case #"specialty_staminup": return #"hash_30c8ec276d5ec71c";
            case #"specialty_shield": return #"hash_4fe70b2de9830ba1";
            case #"specialty_quickrevive": return #"hash_5ab0c97c0495b86d";
            case #"specialty_phdflopper": return #"hash_3633fc1a804e25b0";
            case #"specialty_mystery": return #"wpn_t8_zm_perk_bottle_secretsauce_view";
            case #"specialty_extraammo": return #"hash_f92f97a9fe4a043";
            case #"specialty_etherealrazor": return #"hash_6a79c2a84e9e315d";
            case #"specialty_electriccherry": return #"hash_722f327941d2fb2e";
            case #"specialty_death_dash": return #"hash_4e2aba7d883146da";
            case #"specialty_deadshot": return #"hash_67aacc25f361b0e2";
            case #"specialty_cooldown": return #"hash_6ef3256b30b0b1fe";
            case #"specialty_camper": return #"hash_566aa9d5261924d1";
            case #"specialty_berserker": return #"hash_2ccf78f6eae36a2d";
            case #"specialty_awareness": return #"hash_6af9235d5ba511f7";
            case #"specialty_additionalprimaryweapon": return #"hash_1bb131e818b68032";

            // sauce does not exists for a totem....
            default: return #"wpn_t8_zm_perk_bottle_secretsauce_view";
        }
    }
    else
    {
        switch (hash_name)   
        {
            case #"specialty_zombshell": return #"wpn_t8_zm_perk_bottle_zombshell_view";
            case #"specialty_wolf_protector": return #"wpn_t8_zm_perk_bottle_bloodwolf_view";
            case #"specialty_widowswine": return #"wpn_t8_zm_perk_bottle_winterswail_view";
            case #"specialty_staminup": return #"wpn_t8_zm_perk_bottle_staminup_view";
            case #"specialty_shield": return #"wpn_t8_zm_perk_bottle_victorioustortoise_view";
            case #"specialty_quickrevive": return #"wpn_t8_zm_perk_bottle_quickrevive_view";
            case #"specialty_phdflopper": return #"wpn_t8_zm_perk_bottle_phdslider_view";
            case #"specialty_mystery": return #"wpn_t8_zm_perk_bottle_secretsauce_view";
            case #"specialty_extraammo": return #"wpn_t8_zm_perk_bottle_bandolier_view";
            case #"specialty_etherealrazor": return #"wpn_t8_zm_perk_bottle_etherealrazor_view";
            case #"specialty_electriccherry": return #"wpn_t8_zm_perk_bottle_electricburst_view";
            case #"specialty_death_dash": return #"wpn_t8_zm_perk_bottle_blaze_view";
            case #"specialty_deadshot": return #"wpn_t8_zm_perk_bottle_deadshot_view";
            case #"specialty_cooldown": return #"wpn_t8_zm_perk_bottle_timeslip_view";
            case #"specialty_camper": return #"wpn_t8_zm_perk_bottle_stronghold_view";
            case #"specialty_berserker": return #"wpn_t8_zm_perk_bottle_dyingwish_view";
            case #"specialty_awareness": return #"wpn_t8_zm_perk_bottle_deathperception_view";
            case #"specialty_additionalprimaryweapon": return #"wpn_t8_zm_perk_bottle_mulekick_view";

            default: return #"wpn_t8_zm_perk_bottle_secretsauce_view";
        }
    }
}

GiveClassicPerk(name, e_player, no_anim = undefined)
{
    // #"HasJugg", #"specialty_doubletap2", #"specialty_whoswho", #"HasElemental", #"specialty_vultureaid", #"specialty_fastreload"

    switch(name)
    {
        case #"HasJugg":
        n_target = 300;

        e_player.var_66cb03ad = n_target;
		e_player setmaxhealth(e_player.var_66cb03ad);
		e_player zm_utility::set_max_health();

		e_player.HasJugg = true;

		e_player thread CheckPerkDownJugg();

		// play anim
        if (!isDefined(no_anim))
        {
            e_player PlayPerkAnim(#"specialty_wolf_protector");

            // some sound
            self waittilltimeout(2.5, #"burp", #"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
            e_player zm_audio::create_and_play_dialog(#"perk", #"generic");
        }

		e_player LUINotifyEvent(#"notify_jugg_image", 1, e_player.HasJugg);
        break;

        case #"specialty_doubletap2":
        use_double_2_0 = GetDvarInt("shield_enh_ClassicMode_DoubleTab2", 0);

        if (use_double_2_0)
        {
            e_player perks::perk_setperk(#"specialty_doubletap2");
        }
        else
        {
            e_player perks::perk_setperk(#"specialty_rof");
        }

		e_player thread CheckPerkDownDouble();

		// play anim
        if (!isDefined(no_anim))
        {
            e_player PlayPerkAnim(#"specialty_camper");

            // some sound
            self waittilltimeout(2.5, #"burp", #"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
            e_player zm_audio::create_and_play_dialog(#"perk", #"generic");
        }

		e_player LUINotifyEvent(#"notify_double_image", 1, 1);

        if (use_double_2_0)
        {
            e_player LUINotifyEvent(#"notify_double_image", 1, 2);
        }
        break;

        case #"specialty_whoswho":
        e_player perks::perk_setperk(#"specialty_whoswho");

		// play anim
        if (!isDefined(no_anim))
        {
            e_player PlayPerkAnim(#"specialty_quickrevive");

            // some sound
            self waittilltimeout(2.5, #"burp", #"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
            e_player zm_audio::create_and_play_dialog(#"perk", #"generic");
        }

		e_player LUINotifyEvent(#"notify_whos_who_image", 1, 1);
        break;

        case #"HasElemental":
        e_player thread CheckPerkDownElemental();
        e_player.HasElemental = true;

		// play anim
        if (!isDefined(no_anim))
        {
            e_player PlayPerkAnim(#"specialty_zombshell");

            // some sound
            self waittilltimeout(2.5, #"burp", #"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
            e_player zm_audio::create_and_play_dialog(#"perk", #"generic");
        }

		e_player LUINotifyEvent(#"notify_elem_image", 1, 1);
        break;

        case #"specialty_vultureaid":
        e_player perks::perk_setperk(#"specialty_vultureaid");

		e_player thread CheckPerkDownVulture();

		// play anim
        if (!isDefined(no_anim))
        {
            e_player PlayPerkAnim(#"specialty_awareness");

            // some sound
            self waittilltimeout(2.5, #"burp", #"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
            e_player zm_audio::create_and_play_dialog(#"perk", #"generic");
        }

		e_player thread VultureAidLogic();

		e_player LUINotifyEvent(#"notify_vulture_image", 1, 1);
        break;

        case #"specialty_fastreload":
        e_player perks::perk_setperk(#"specialty_fastreload");

		e_player thread CheckPerkDownSpeed();

		// play anim
        if (!isDefined(no_anim))
        {
            e_player PlayPerkAnim(#"specialty_shield");

            // some sound
            self waittilltimeout(2.5, #"burp", #"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
            e_player zm_audio::create_and_play_dialog(#"perk", #"generic");
        }

		e_player LUINotifyEvent(#"notify_speed_image", 1, 1);
        break;
    }
}

RemoveClassicPerk(name, e_player)
{
    switch(name)
    {
        case #"HasJugg":
        self notify(#"remove_jugg");
        break;

        case #"specialty_doubletap2":
        case #"specialty_rof":
        self notify(#"remove_double");
        break;

        case #"specialty_whoswho":
        self perks::perk_unsetperk(#"specialty_whoswho");
	    self LUINotifyEvent(#"notify_whos_who_image", 1, 0);
        break;

        case #"HasElemental":
        self notify(#"remove_elemental");
        break;

        case #"specialty_vultureaid":
        self notify(#"remove_vulture");
        break;

        case #"specialty_fastreload":
        self notify(#"remove_speedcola");
        break;
    }
}

TimeoutWonderfizz()
{
    self endon(#"death", #"stop_timeout_wonder");

    wait 6;

    self notify(#"timeout_wonder");
    wait 0.1;
    self notify(#"timeout_wonder");
    wait 0.1;
    self notify(#"timeout_wonder");
}

WaitTriggerWonderfizz()
{
    self endon(#"death");

    while (true) {
        waitresult = undefined;
        waitresult = self waittill(#"trigger_activated");
        e_player = waitresult.e_who;

		if (!IsPaPOrPowerOn())
		{
			continue;
		}

        if (e_player.perk_limit_classic >= 5)
        {
            continue;
        }

        calc_perks_player = 0;

        // main's
        for (i = 0; i < e_player.var_c27f1e90.size; i++)
        {
            perk = e_player.var_c27f1e90[i];
            if (e_player hasperk(perk))
            {
                calc_perks_player += 1;
            }
        }

        if (calc_perks_player >= 4 && ((!GetDvarInt("shield_enh_Perka", 0) && e_player.var_67ba1237.size == 6) || e_player.var_67ba1237.size >= 12) && e_player.perk_limit_classic_only == 6)
        {
            continue;
        }

        use_classic_perk = false;
        use_main_perk = false;

        //e_player iPrintLnBold("test: " + calc_perks_player + " - " + e_player.var_67ba1237.size);

        if (!(calc_perks_player >= 4 && ((!GetDvarInt("shield_enh_Perka", 0) && e_player.var_67ba1237.size == 6) || e_player.var_67ba1237.size >= 12)))
        {
            //e_player iPrintLnBold("using main perk");

            use_main_perk = true;
        }

        if (e_player.perk_limit_classic_only != 6)
        {
            //e_player iPrintLnBold("using classic perk");

            use_classic_perk = true;
        }

		if (!e_player zm_score::can_player_purchase(GetDvarInt("shield_enh_Perka", 0) ? 3500 : 1500))
		{
			//e_player iPrintLnBold("no");
			zm_utility::play_sound_on_ent("no_purchase");
            e_player thread zm_audio::create_and_play_dialog("general", "outofmoney");
			continue;
		}

        if (!BO4ChaosMap())
        {

        }
        else
        {
            e_player thread zm_audio::create_and_play_dialog(#"altar", #"interact");
        }

        sound = "evt_bottle_dispense";
        playsoundatposition(sound, self.origin);

		e_player zm_score::minus_to_player_score(GetDvarInt("shield_enh_Perka", 0) ? 3500 : 1500);
		e_player zm_utility::play_sound_on_ent("purchase");

        random_perks = array(#"specialty_quickrevive", #"specialty_shield", #"specialty_staminup", #"specialty_widowswine", #"specialty_wolf_protector", #"specialty_zombshell", 
        #"specialty_phdflopper", #"specialty_additionalprimaryweapon", #"specialty_awareness" /#, #"specialty_berserker"#/, #"specialty_camper", #"specialty_cooldown", 
        #"specialty_deadshot", #"specialty_death_dash", #"specialty_electriccherry", #"specialty_extraammo", #"specialty_etherealrazor");

        random_perks_classic = array(#"HasJugg", #"specialty_doubletap2", #"specialty_whoswho", #"HasElemental", #"specialty_vultureaid", #"specialty_fastreload");

        level.Wonderfizz_IsBeingUsed = true;

        forward = anglestoforward(self.angles);

        // move 50 units up, 30 units forward
        spawn_pos = self.origin + (0, 0, 5) + forward * 40;

        mdl_reward = util::spawn_model(#"wpn_t8_zm_perk_bottle_bandolier_world", spawn_pos, self.angles);
        mdl_reward SetScale(1.35);
        mdl_reward clientfield::set("powerup_fx", 2);

        mdl_reward thread RotateAndBobItem();
        
        times_max = randomIntRange(10, 20);
        times = 0;

        while(true)
        {
            if (times > times_max)
                break;

            perk_model_x = array::random(random_perks);

            mdl_reward setModel(zm_perk_get_viewmodel(perk_model_x));
            
            if (e_player hasPerk(#"specialty_cooldown"))
                wait 0.10;
            else
                wait 0.25;

            times++;
        }

        // choose a random perk logic
        if (use_main_perk && use_classic_perk)
        {
            if (randomIntRange(0, 2) == 1)
            {
                random_perks_get = array::random(random_perks_classic);
                use_main_perk = false;
            }
            else
            {
                random_perks_get = array::random(random_perks);
                use_classic_perk = false;
            }
        }
        else if (use_classic_perk)
        {
            random_perks_get = array::random(random_perks_classic);
        }
        else if (use_main_perk)
        {
            random_perks_get = array::random(random_perks);
        }
        else
        {
            //e_player iPrintLnBold("what the fuck?");
            
            e_player_get.wonder_hint_string = undefined;
            e_player_get.wonder_hint_string_param = undefined;
            
            level.Wonderfizz_IsBeingUsed = undefined;
            
            mdl_reward delete();
            continue;
        }
        
        // re-roll if used
        while(true)
        {
            if (use_main_perk && use_classic_perk)
            {
                if (randomIntRange(0, 2) == 1)
                {
                    array_to_use = random_perks_classic;
                }
                else
                {
                    array_to_use = random_perks;
                }
            }
            else if (use_main_perk)
            {
                array_to_use = random_perks;
            }
            else if (use_classic_perk)
            {
                array_to_use = random_perks_classic;
            }
            else
                break; // wtf?

            if (random_perks_get != #"HasJugg" && random_perks_get != #"HasElemental" && e_player hasPerk(random_perks_get))
            {
                random_perks_get = array::random(array_to_use);
                continue;
            }
            else if (random_perks_get === #"HasJugg" && isDefined(e_player.HasJugg) && e_player.HasJugg)
            {
                random_perks_get = array::random(array_to_use);
                continue;
            }
            else if (random_perks_get === #"HasElemental" && isDefined(e_player.HasElemental) && e_player.HasElemental)
            {
                random_perks_get = array::random(array_to_use);
                continue;
            }

            wait 0.1;

            break;
        }

        e_player.wonder_hint_string = #"shield/wonderfizz_get";
        e_player.wonder_hint_string_param = zm_perk_translate(random_perks_get); // the random perk here

        mdl_reward setModel(zm_perk_get_viewmodel(random_perks_get));
        
        self thread TimeoutWonderfizz();
        timeout = false;

        while (true)
        {
            waitresult = self waittill(#"trigger_activated", #"timeout_wonder");

            if (waitresult._notify === #"timeout_wonder") {
                e_player.wonder_hint_string = undefined;
                e_player.wonder_hint_string_param = undefined;
                
                level.Wonderfizz_IsBeingUsed = undefined;

                mdl_reward delete();
                timeout = true;

                self notify(#"stop_timeout_wonder");

                break;
            }

            e_player_get = waitresult.e_who;

            if (e_player_get == e_player || timeout)
                break;
        }

        if (timeout)
            continue;

        self notify(#"stop_timeout_wonder");

        if (use_main_perk)
        {
            is_slot_perk = false;

            // play anim
            e_player PlayPerkAnim(random_perks_get);
            mdl_reward delete();

            e_player waittilltimeout(2.5, #"burp", #"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
            e_player zm_audio::create_and_play_dialog(#"perk", #"generic");

            foreach (n_slot, perk_name in e_player.var_c27f1e90) {
                if (perk_name === random_perks_get) {
                    e_player thread zm_perks::function_9bdf581f(random_perks_get, n_slot);

                    is_slot_perk = true;
                }
            }

            // extra perk prob
            if (!is_slot_perk)
            {
                e_player thread zm_perks::function_a7ae070c(random_perks_get);
            }
        }
        else if (use_classic_perk)
        {
            mdl_reward delete();
            e_player GiveClassicPerk(random_perks_get, e_player);
        }

        e_player_get.wonder_hint_string = undefined;
        e_player_get.wonder_hint_string_param = undefined;
        
        level.Wonderfizz_IsBeingUsed = undefined;

        wait 0.5;
    }
}

CheckStringElemental(e_player) 
{
	if (isDefined(e_player.HasElemental) && e_player.HasElemental)
	{
        self sethintstringforplayer(e_player, "");
        return true;
    }
	
    if (e_player.perk_limit_classic >= 5)
    {
		self sethintstringforplayer(e_player, #"shield/perk_limit");
		return true;
    }

	if (!IsPaPOrPowerOn())
	{
		self sethintstringforplayer(e_player, #"shield/power_need");
		return true;
	}
	
	self sethintstringforplayer(e_player, #"shield/elemental_buy", 2500);
    return true;
}

WaitTriggerElemental()
{
    self endon(#"death");

    while (true) {
        waitresult = undefined;
        waitresult = self waittill(#"trigger_activated");
        e_player = waitresult.e_who;

		if (!IsPaPOrPowerOn())
		{
			continue;
		}

        if (e_player.perk_limit_classic >= 5)
        {
            continue;
        }

		if (!e_player zm_score::can_player_purchase(2500) || isDefined(e_player.HasElemental) && e_player.HasElemental)
		{
			//e_player iPrintLnBold("no");
			zm_utility::play_sound_on_ent("no_purchase");
            e_player thread zm_audio::create_and_play_dialog("general", "outofmoney");
			continue;
		}

        if (!BO4ChaosMap())
        {

        }
        else
        {
            e_player thread zm_audio::create_and_play_dialog(#"altar", #"interact");
        }

        sound = "evt_bottle_dispense";
        playsoundatposition(sound, self.origin);

        self thread ShieldPlayJingle(75, e_player);

		e_player zm_score::minus_to_player_score(2500);
		e_player zm_utility::play_sound_on_ent("purchase");
        e_player thread CheckPerkDownElemental();
        e_player.HasElemental = true;

		// play anim
		e_player PlayPerkAnim(#"specialty_zombshell");

		// some sound
		self waittilltimeout(2.5, #"burp", #"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
		e_player zm_audio::create_and_play_dialog(#"perk", #"generic");

		e_player LUINotifyEvent(#"notify_elem_image", 1, 1);
    }
}

CheckStringWhosWho(e_player) 
{
	if (e_player hasperk(#"specialty_whoswho") || (isDefined(e_player.InWhosWhoLogic) && e_player.InWhosWhoLogic))
	{
        self sethintstringforplayer(e_player, "");
        return true;
    }

    if (e_player.perk_limit_classic >= 5)
    {
		self sethintstringforplayer(e_player, #"shield/perk_limit");
		return true;
    }
	
	if (!IsPaPOrPowerOn())
	{
		self sethintstringforplayer(e_player, #"shield/power_need");
		return true;
	}
	
	self sethintstringforplayer(e_player, #"shield/whos_who_buy", 2000);
    return true;
}

WaitTriggerWhosWho()
{
    self endon(#"death");

    while (true) {
        waitresult = undefined;
        waitresult = self waittill(#"trigger_activated");
        e_player = waitresult.e_who;

		if (!IsPaPOrPowerOn())
		{
			continue;
		}

        if (e_player.perk_limit_classic >= 5)
        {
            continue;
        }

		if (!e_player zm_score::can_player_purchase(2000) || e_player hasperk(#"specialty_whoswho") || (isDefined(e_player.InWhosWhoLogic) && e_player.InWhosWhoLogic))
		{
			//e_player iPrintLnBold("no");
			zm_utility::play_sound_on_ent("no_purchase");
            e_player thread zm_audio::create_and_play_dialog("general", "outofmoney");
			continue;
		}

        if (!BO4ChaosMap())
        {

        }
        else
        {
            e_player thread zm_audio::create_and_play_dialog(#"altar", #"interact");
        }

        sound = "evt_bottle_dispense";
        playsoundatposition(sound, self.origin);

        self thread ShieldPlayJingle(73, e_player);

		e_player zm_score::minus_to_player_score(2000);
		e_player zm_utility::play_sound_on_ent("purchase");
        e_player perks::perk_setperk(#"specialty_whoswho");

		// play anim
		e_player PlayPerkAnim(#"specialty_quickrevive");

		// some sound
		self waittilltimeout(2.5, #"burp", #"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
		e_player zm_audio::create_and_play_dialog(#"perk", #"generic");

		e_player LUINotifyEvent(#"notify_whos_who_image", 1, 1);
    }
}

CheckPerkDownElemental()
{
	self endon(#"death", #"disconnect");

	self waittill(#"player_downed", #"remove_elemental");

	self.HasElemental = false;

	self LUINotifyEvent(#"notify_elem_image", 1, 0);
}

GetWhosWhoSpawnLocation()
{
	switch(BO4GetMap())
    {
        case "IX":
		Cords = (-255, 578, 75);
		Angles = (0, 0, 0);
        break;

        case "Blood":
		Cords = (9943, 11525, 296);
		Angles = (0, 0, 0);
        break;

        case "AE":
		Cords = (-758.012, -734.014, 105);
		Angles = (0, 0, 0);
        break;

        case "AO":
		Cords = (256.464, -2283.56, -15);
		Angles = (0, 0, 0);
        break;

        case "Dead":
		Cords = (143.65, -1040.32, 40);
		Angles = (0, 0, 0);
        break;

        case "Tag":
		Cords = (582, 3731, 70);
		Angles = (0, 0, 0);
        break;

        case "Classified":
		Cords = (-967, 2499, 60);
		Angles = (0, 0, 0);
        break;

        case "Voyage":
		Cords = (238, -5059, 1155);
		Angles = (0, 0, 0);
        break;
    }

	return Cords;
}

WhosWhoDownLogic()
{
	self endon(#"death");
    
    // avoid dying in it
    self.health = self.maxhealth;
	
	self perks::perk_unsetperk(#"specialty_whoswho");
	self LUINotifyEvent(#"notify_whos_who_image", 1, 0);

	self.InWhosWhoLogic = true;

	//self iPrintLnBold("WHOS WHOOOOOOOOOO");

	m_player_fake = util::spawn_player_clone(self);
	m_player_fake thread scene::play(#"aib_t8_zm_zod_homunculus_dth_01", m_player_fake);
	m_player_fake clientfield::set("powerup_fx", 1);
	//m_player_fake setstance("prone");

	current_weapon = self getcurrentweapon();
    if (isdefined(current_weapon.name) && current_weapon.name != #"none") {
        m_weapon_fake = util::spawn_model(current_weapon.worldmodel, m_player_fake gettagorigin("tag_weapon_right"), m_player_fake gettagangles("tag_weapon_right"));
        m_weapon_fake linkto(m_player_fake, "tag_weapon_right");
        m_weapon_fake setowner(self);
    }

    // ui
    LUINotifyEvent(#"enhancement_whoswho_visibility", 6, 1, self getEntityNumber(), int(m_player_fake.origin[0]), int(m_player_fake.origin[1]), int(m_player_fake.origin[2] + 100), 1);

	teleport_loc = GetWhosWhoSpawnLocation();

    self val::set(#"initial_black", "ignoreme");
    self val::set(#"initial_black", "takedamage", 0);

	self thread lui::screen_flash(0.4, 2, 0.5, 1, "white");

	self thread zm_audio::create_and_play_dialog(#"general", #"exert_death");

	self playsound(#"zmb_bgb_plainsight_start");
    self playloopsound(#"zmb_bgb_plainsight_loop", 1);
	self clientfield::set_to_player("" + #"hash_321b58d22755af74", 1);

	self.saved_primary_weapons = self getweaponslistprimaries();
    self.saved_aats = [];
    self.saved_packs = [];

    self.had_riot_shield = self hasriotshield();

    // save weapon's packs and shit
    if(isDefined(self.var_2843d3cc) && isDefined(self.var_2843d3cc[zm_weapons::function_93cd8e76(self.saved_primary_weapons[0])]))
        self.saved_packs[self.saved_packs.size] = self.var_2843d3cc[zm_weapons::function_93cd8e76(self.saved_primary_weapons[0])];

    // atts
    TryAAT = self aat::getaatonweapon(self.saved_primary_weapons[0]);
    if (isDefined(TryAAT))
        self.saved_aats[self.saved_aats.size] = TryAAT.name;

    // IF more than one weapon
    if (isDefined(self.saved_primary_weapons[1]))
    {
        TryAAT = self aat::getaatonweapon(self.saved_primary_weapons[1]);
        if (isDefined(TryAAT))
            self.saved_aats[self.saved_aats.size] = TryAAT.name;
            
        if(isDefined(self.var_2843d3cc) && isDefined(self.var_2843d3cc[zm_weapons::function_93cd8e76(self.saved_primary_weapons[1])]))
            self.saved_packs[self.saved_packs.size] = self.var_2843d3cc[zm_weapons::function_93cd8e76(self.saved_primary_weapons[1])];
    }

    if (isDefined(self.saved_primary_weapons[2]))
    {
        TryAAT = self aat::getaatonweapon(self.saved_primary_weapons[2]);
        if (isDefined(TryAAT))
            self.saved_aats[self.saved_aats.size] = TryAAT.name;

        if(isDefined(self.var_2843d3cc) && isDefined(self.var_2843d3cc[zm_weapons::function_93cd8e76(self.saved_primary_weapons[2])]))
            self.saved_packs[self.saved_packs.size] = self.var_2843d3cc[zm_weapons::function_93cd8e76(self.saved_primary_weapons[2])];
    }

	self.saved_lethal = zm_loadout::get_player_lethal_grenade();
	self.saved_melee = zm_loadout::get_player_melee_weapon();

	self takeallweapons();

    // give player a weapon depending on current round
    round = zm_round_logic::get_round_number();

    if (round > 0 && round < 9) {
        self zm_weapons::weapon_give(zm_weapons::get_upgrade_weapon(getweapon(#"pistol_standard_t8")));
        self switchtoweapon(zm_weapons::get_upgrade_weapon(getweapon(#"pistol_standard_t8")));
    } else if (round >= 9 && round < 21) {
        self zm_weapons::weapon_give(zm_weapons::get_upgrade_weapon(getweapon(#"smg_minigun_t8")));
        self switchtoweapon(zm_weapons::get_upgrade_weapon(getweapon(#"smg_minigun_t8")));
    } else {
        self zm_weapons::weapon_give(zm_weapons::get_upgrade_weapon(getweapon(#"pistol_topbreak_t8")));
        self switchtoweapon(zm_weapons::get_upgrade_weapon(getweapon(#"pistol_topbreak_t8")));
    }

	wait 0.20;

    ShieldPlay(false, false, 5, false, self);

	self setorigin(teleport_loc);

    self val::set(#"initial_black", "ignoreme");
    self val::set(#"initial_black", "takedamage", 0);

	m_player_fake thread WaitForRevive();

    wait 2.5;

    self val::reset(#"initial_black", "ignoreme");
    self val::reset(#"initial_black", "takedamage");

	s_result = m_player_fake waittilltimeout(35, #"clone_revived", #"player_downed");

    self val::set(#"initial_black", "ignoreme");
    self val::set(#"initial_black", "takedamage", 0);

    self thread lui::screen_flash(0.4, 1, 0.5, 1, "white");

    self takeallweapons();

    wait 0.50;

    if (isdefined(self.saved_primary_weapons)) {
        foreach (w in self.saved_primary_weapons) {
            self zm_weapons::weapon_give(w);
        }
        self switchtoweapon(self.saved_primary_weapons[0]);
    }
    
    // give packs and aats back
    if (isdefined(self.saved_packs)) {
        for (i = 0; i < self.saved_packs.size; i++) {
            self zm_pap_util::repack_weapon(self.saved_primary_weapons[i], self.saved_packs[i]);
        }
    }

    if (isdefined(self.saved_aats)) {
        for (i = 0; i < self.saved_aats.size; i++) {
            self aat::acquire(self.saved_primary_weapons[i], self.saved_aats[i]);
        }
    }

    if (isdefined(self.saved_lethal)) {
        self zm_weapons::weapon_give(self.saved_lethal);
        self zm_loadout::set_player_lethal_grenade(self.saved_lethal);
    }

    if (isdefined(self.saved_melee)) {
        self zm_weapons::weapon_give(self.saved_melee);
        self zm_loadout::set_player_melee_weapon(self.saved_melee);
    }

    if (self.had_riot_shield)
    {
        self zm_bgb_shields_up::activation();
    }

    if (s_result._notify == "timeout") {
        self doDamage(self.health + 666, self.origin, undefined);
    }

	if (s_result._notify == "clone_revived") {
		wait 0.20;
        self setorigin(m_player_fake.origin);
    }

    LUINotifyEvent(#"enhancement_whoswho_visibility", 2, 0, self getEntityNumber());

    self zm_laststand::function_3a00302e(1);

	self playsound(#"zmb_bgb_plainsight_end");
    self stoploopsound(1);
	self clientfield::set_to_player("" + #"hash_321b58d22755af74", 0);

	self.InWhosWhoLogic = false;

	m_player_fake scene::stop(#"aib_t8_zm_zod_homunculus_dth_01", 1);
	m_player_fake clientfield::set("powerup_fx", 0);

	m_player_fake delete();
	m_weapon_fake delete();

	foreach(player in level.players) 
	 player LUINotifyEvent(#"notify_whos_who_meter", 1, 0);

    wait 1.3;

    self val::reset(#"initial_black", "ignoreme");
    self val::reset(#"initial_black", "takedamage");
}

WaitForRevive()
{
	self endon(#"death");

	revive_time = 4; // base revive time in seconds
	revive_progress = 0.0;
	revive_players = [];
	max_players = 4;

	while (true)
	{
		nearby_players = [];
		foreach (player in level.players)
		{
			if (!isAlive(player))
				continue;

			dist = distance(self.origin, player.origin);
			withinrange = dist <= 125;

			if (withinrange)
			{
				nearby_players[nearby_players.size] = player;
			}
			else
				player LUINotifyEvent(#"notify_whos_who_meter", 1, 0);
		}

		num_players = nearby_players.size;
		if (num_players > 0)
		{
			time_factor = revive_time / num_players;
			revive_progress += 0.1;

			foreach (player in nearby_players)
			{
				//player iPrintLnBold("Reviving... " + int((revive_progress / time_factor) * 100) + "%");
				player LUINotifyEvent(#"notify_whos_who_meter", 2, 1, ConvertNumToLUI((revive_progress / time_factor) * 100));
			}

			if (revive_progress >= time_factor)
			{
				// notify the clone instead
				self notify(#"clone_revived");
				break;
			}
		}
		else
		{
			revive_progress = 0.0;
		}

		wait 0.1;
	}
}

CheckStringDoubleTab(e_player) 
{
	if (e_player hasperk(#"specialty_doubletap2") || e_player hasperk(#"specialty_rof"))
	{
        self sethintstringforplayer(e_player, "");
        return true;
    }

    if (e_player.perk_limit_classic >= 5)
    {
		self sethintstringforplayer(e_player, #"shield/perk_limit");
		return true;
    }

	if (!IsPaPOrPowerOn())
	{
		self sethintstringforplayer(e_player, #"shield/power_need");
		return true;
	}
	
	self sethintstringforplayer(e_player, #"shield/double_buy", 2000);
    return true;
}

WaitTriggerDoubleTab()
{
    self endon(#"death");

    while (true) {
        waitresult = undefined;
        waitresult = self waittill(#"trigger_activated");
        e_player = waitresult.e_who;

		if (!IsPaPOrPowerOn())
		{
			continue;
		}

        if (e_player.perk_limit_classic >= 5)
        {
            continue;
        }

		if (!e_player zm_score::can_player_purchase(2000) || e_player hasperk(#"specialty_doubletap2") || e_player hasperk(#"specialty_rof"))
		{
			//e_player iPrintLnBold("no");
			zm_utility::play_sound_on_ent("no_purchase");
            e_player thread zm_audio::create_and_play_dialog("general", "outofmoney");
			continue;
		}

        if (!BO4ChaosMap())
        {

        }
        else
        {
            e_player thread zm_audio::create_and_play_dialog(#"altar", #"interact");
        }

        sound = "evt_bottle_dispense";
        playsoundatposition(sound, self.origin);

        self thread ShieldPlayJingle(74, e_player);

		e_player zm_score::minus_to_player_score(2000);
		e_player zm_utility::play_sound_on_ent("purchase");

        use_double_2_0 = GetDvarInt("shield_enh_ClassicMode_DoubleTab2", 0);
        
        if (use_double_2_0)
            e_player perks::perk_setperk(#"specialty_doubletap2");
        else
            e_player perks::perk_setperk(#"specialty_rof");

		e_player thread CheckPerkDownDouble();

		// play anim
		e_player PlayPerkAnim(#"specialty_camper");

		// some sound
		self waittilltimeout(2.5, #"burp", #"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
		e_player zm_audio::create_and_play_dialog(#"perk", #"generic");

		e_player LUINotifyEvent(#"notify_double_image", 1, 1);

        if (use_double_2_0)
        {
            // set to 2.0
            e_player LUINotifyEvent(#"notify_double_image", 1, 2);
        }
    }
}

CheckPerkDownDouble()
{
	self endon(#"death", #"disconnect");

	self waittill(#"player_downed", #"remove_double");

    if (GetDvarInt("shield_enh_ClassicMode_DoubleTab2", 0))
	    self perks::perk_unsetperk(#"specialty_doubletap2");
    else
        self perks::perk_unsetperk(#"specialty_rof");

	self LUINotifyEvent(#"notify_double_image", 1, 0);
}

CheckStringVulture(e_player) 
{
	if (e_player hasperk(#"specialty_vultureaid"))
    {
        self sethintstringforplayer(e_player, "");
        return true;
    }

    if (e_player.perk_limit_classic >= 5)
    {
		self sethintstringforplayer(e_player, #"shield/perk_limit");
		return true;
    }

	if (!IsPaPOrPowerOn())
	{
		self sethintstringforplayer(e_player, #"shield/power_need");
		return true;
	}
	
	self sethintstringforplayer(e_player, #"shield/vulture_buy", 3000);
    return true;
}

WaitTriggerVulture()
{
    self endon(#"death");

    while (true) {
        waitresult = undefined;
        waitresult = self waittill(#"trigger_activated");
        e_player = waitresult.e_who;

		if (!IsPaPOrPowerOn())
		{
			continue;
		}

        if (e_player.perk_limit_classic >= 5)
        {
            continue;
        }

		if (!e_player zm_score::can_player_purchase(3000) || e_player hasperk(#"specialty_vultureaid"))
		{
			//e_player iPrintLnBold("no");
			zm_utility::play_sound_on_ent("no_purchase");
            e_player thread zm_audio::create_and_play_dialog("general", "outofmoney");
			continue;
		}

        if (!BO4ChaosMap())
        {

        }
        else
        {
            e_player thread zm_audio::create_and_play_dialog(#"altar", #"interact");
        }

        sound = "evt_bottle_dispense";
        playsoundatposition(sound, self.origin);

        self thread ShieldPlayJingle(72, e_player);

		e_player zm_score::minus_to_player_score(3000);
		e_player zm_utility::play_sound_on_ent("purchase");
        e_player perks::perk_setperk(#"specialty_vultureaid");

		e_player thread CheckPerkDownVulture();

		// play anim
		e_player PlayPerkAnim(#"specialty_awareness");

		// some sound
		self waittilltimeout(2.5, #"burp", #"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
		e_player zm_audio::create_and_play_dialog(#"perk", #"generic");

		e_player thread VultureAidLogic();

		e_player LUINotifyEvent(#"notify_vulture_image", 1, 1);
    }
}

CheckPerkDownVulture()
{
	self endon(#"death", #"disconnect");

	self waittill(#"player_downed", #"remove_vulture");

	// wait for other func
	wait 0.1;

	self perks::perk_unsetperk(#"specialty_vultureaid");
    self notify(#"stop_updating_vulture");

	// remove objectives..
	foreach(obj in level.VultureObjects)
	{
		self LUINotifyEvent(#"enhancement_vulture_visibility", 2, 3, obj.n_obj_id);
	}

	self LUINotifyEvent(#"notify_vulture_image", 1, 0);
}

CheckStringSpeedCola(e_player) 
{
	if (e_player hasperk(#"specialty_fastreload"))
    {
        self sethintstringforplayer(e_player, "");
        return true;
    }

    if (e_player.perk_limit_classic >= 5)
    {
		self sethintstringforplayer(e_player, #"shield/perk_limit");
		return true;
    }

	if (!IsPaPOrPowerOn())
	{
		self sethintstringforplayer(e_player, #"shield/power_need");
		return true;
	}
	
	self sethintstringforplayer(e_player, #"shield/speed_buy", 3000);
    return true;
}

WaitTriggerSpeedCola()
{
    self endon(#"death");

    while (true) {
        waitresult = undefined;
        waitresult = self waittill(#"trigger_activated");
        e_player = waitresult.e_who;

		if (!IsPaPOrPowerOn())
		{
			continue;
		}

        if (e_player.perk_limit_classic >= 5)
        {
            continue;
        }

		if (!e_player zm_score::can_player_purchase(3000) || e_player hasperk(#"specialty_fastreload"))
		{
			//e_player iPrintLnBold("no");
			zm_utility::play_sound_on_ent("no_purchase");
            e_player thread zm_audio::create_and_play_dialog("general", "outofmoney");
			continue;
		}

        if (!BO4ChaosMap())
        {

        }
        else
        {
            e_player thread zm_audio::create_and_play_dialog(#"altar", #"interact");
        }

        sound = "evt_bottle_dispense";
        playsoundatposition(sound, self.origin);

        self thread ShieldPlayJingle(70, e_player);

		e_player zm_score::minus_to_player_score(3000);
		e_player zm_utility::play_sound_on_ent("purchase");
        e_player perks::perk_setperk(#"specialty_fastreload");

		e_player thread CheckPerkDownSpeed();

		// play anim
		e_player PlayPerkAnim(#"specialty_shield");

		// some sound
		self waittilltimeout(2.5, #"burp", #"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
		e_player zm_audio::create_and_play_dialog(#"perk", #"generic");

		e_player LUINotifyEvent(#"notify_speed_image", 1, 1);
    }
}

CheckPerkDownSpeed()
{
	self endon(#"death", #"disconnect");

	self waittill(#"player_downed", #"remove_speedcola");

	self perks::perk_unsetperk(#"specialty_fastreload");

	self LUINotifyEvent(#"notify_speed_image", 1, 0);
}

CheckStringJugg(e_player) 
{
	if (isDefined(e_player.HasJugg) && e_player.HasJugg)
    {
        self sethintstringforplayer(e_player, "");
        return true;
    }

    if (e_player.perk_limit_classic >= 5)
    {
		self sethintstringforplayer(e_player, #"shield/perk_limit");
		return true;
    }

	if (!IsPaPOrPowerOn())
	{
		self sethintstringforplayer(e_player, #"shield/power_need");
		return true;
	}
	
	self sethintstringforplayer(e_player, #"shield/jugg_buy", 2500);
    return true;
}

WaitTriggerJugg() 
{
    self endon(#"death");
    while (true) {
        waitresult = undefined;
        waitresult = self waittill(#"trigger_activated");
        e_player = waitresult.e_who;

		if (!IsPaPOrPowerOn())
		{
			continue;
		}

        if (e_player.perk_limit_classic >= 5)
        {
            continue;
        }

		if (!e_player zm_score::can_player_purchase(2500) || e_player.HasJugg)
		{
			//e_player iPrintLnBold("no");
			zm_utility::play_sound_on_ent("no_purchase");
            e_player thread zm_audio::create_and_play_dialog("general", "outofmoney");
			continue;
		}

        if (!BO4ChaosMap())
        {

        }
        else
        {
            e_player thread zm_audio::create_and_play_dialog(#"altar", #"interact");
        }

        sound = "evt_bottle_dispense";
        playsoundatposition(sound, self.origin);

        self thread ShieldPlayJingle(71, e_player);

		//e_player iPrintLnBold("before jug : " + e_player.maxhealth);

		n_target = 300;

		e_player zm_score::minus_to_player_score(2500);
		e_player zm_utility::play_sound_on_ent("purchase");
		e_player.var_66cb03ad = n_target;
		e_player setmaxhealth(e_player.var_66cb03ad);
		e_player zm_utility::set_max_health();

		e_player.HasJugg = true;

		e_player thread CheckPerkDownJugg();

		// play anim
		e_player PlayPerkAnim(#"specialty_wolf_protector");

		// some sound
		self waittilltimeout(2.5, #"burp", #"player_downed", #"disconnect", #"end_game", #"perk_abort_drinking");
		e_player zm_audio::create_and_play_dialog(#"perk", #"generic");

		e_player LUINotifyEvent(#"notify_jugg_image", 1, e_player.HasJugg);
		//e_player iPrintLnBold("after jug : " + e_player.maxhealth + " : " + e_player.var_66cb03ad);
    }
}

CheckPerkDownJugg()
{
	self endon(#"death", #"disconnect");

	self waittill(#"player_downed", #"remove_jugg");

	n_target = 150;

	self.var_66cb03ad = n_target;
	self setmaxhealth(self.var_66cb03ad);
	self zm_utility::set_max_health();

	self.HasJugg = false;

	self LUINotifyEvent(#"notify_jugg_image", 1, self.HasJugg);

	//self iPrintLnBold("remove jug : " + self.maxhealth + " : " + self.var_66cb03ad);
}

CheckMoneyShit()
{
    self endon(#"death");

	while (true)
	{	
		e_player = arraygetclosest(self.origin, level.players);

        if (!isdefined(e_player))
        {
            wait 0.5;
            continue;
        }

		if (e_player getstance() === "prone" && distancesquared(self.origin, e_player.origin) < 9216) {
			e_player zm_score::add_to_player_score(100);
			self playsoundtoplayer(#"hash_30fa33e2fb90b58f", e_player);

			break;
		}

		wait 0.5;
	}
}

WatcherPerk()
{
    self endon(#"death");

    wait 5;

    while(true)
    {
        // set player's perk limit for classic perks?
        if (GetDvarInt("shield_enh_Perka", 0))
        {
            self.perk_limit_classic = 0;
        }
        else
        {
            calc_perks_player = 0;

            // main's
            offset = 0;

            if (self.var_c27f1e90.size == 5)
            {
                offset = 1;
            }

            for (i = 0; i < self.var_c27f1e90.size - offset; i++)
            {
                perk = self.var_c27f1e90[i];
                if (self hasperk(perk))
                {
                    calc_perks_player += 1;
                }
            }

            // extra ones
            calc_perks_player += (self.var_67ba1237.size);

            if (self hasperk(#"specialty_fastreload"))
                calc_perks_player += 1;

            if (self hasperk(#"specialty_vultureaid"))
                calc_perks_player += 1;

            if (self.HasElemental)
                calc_perks_player += 1;

            if (self hasperk(#"specialty_whoswho"))
                calc_perks_player += 1;

            if (self hasperk(#"specialty_doubletap2") || self hasperk(#"specialty_rof"))
                calc_perks_player += 1;

            if (self.HasJugg)
                calc_perks_player += 1;

            self.perk_limit_classic = calc_perks_player;

            /# self iPrintLn("classic perk limit: " + self.perk_limit_classic); #/
        }

        calc_perks_player_only = 0;

        if (self hasperk(#"specialty_fastreload"))
            calc_perks_player_only += 1;

        if (self hasperk(#"specialty_vultureaid"))
            calc_perks_player_only += 1;

        if (self.HasElemental)
            calc_perks_player_only += 1;

        if (self hasperk(#"specialty_whoswho"))
            calc_perks_player_only += 1;

        if (self hasperk(#"specialty_doubletap2") || self hasperk(#"specialty_rof"))
            calc_perks_player_only += 1;

        if (self.HasJugg)
            calc_perks_player_only += 1;

        self.perk_limit_classic_only = calc_perks_player_only;

        wait 0.5;
    }
}

on_ai_kill_vulture(params)
{
    self endon(#"death");
    
	e_player = params.eattacker;

	// vulture logic
	if (isDefined(e_player) && isPlayer(e_player) && e_player hasPerk(#"specialty_vultureaid")) {
		// add into vulture check for later
		if (math::cointoss(8))
		{
			// mist logic
			self thread MistLogic(e_player);
		}

        if (level.active_powerups.size < 75) {
            if (math::cointoss(20)) {
                roll = randomintrangeinclusive(0, 100);

                if (roll <= 70) {
					e_powerup = zm_powerups::specific_powerup_drop("wolf_bonus_points", self.origin, undefined, 0.1, e_player, 0, 1, 1);
					if (isdefined(e_powerup)) {
						e_powerup setscale(0.3);
						e_powerup.var_258c5fbc = 15;

                        e_powerup clientfield::set("powerup_fx", 4);
                        e_powerup physicslaunch(e_powerup.origin, vectorscale((0, 0, RandomFloatRange(0.05, 0.15)), 64));
					}
                    return;
                }

                if (roll >= 85) {
                    e_powerup = zm_powerups::specific_powerup_drop("wolf_bonus_ammo", self.origin, undefined, 0.1, e_player, 0, 1, 1);
                    if (isdefined(e_powerup)) {
                        e_powerup setscale(0.3);

                        e_powerup clientfield::set("powerup_fx", 4);
                        e_powerup physicslaunch(e_powerup.origin, vectorscale((0, 0, RandomFloatRange(0.05, 0.15)), 64));
                    }
                    return;
                }

				// nope
            }
        }
    }
}

MistLogic(e_player)
{
	if (isDefined(e_player.has_mist) && e_player.has_mist)
		return;
	
	if (!isDefined(e_player.e_cooldown_mist))
	{
		e_player.e_cooldown_mist = getTime();
	}
	
	if (gettime() >= e_player.e_cooldown_mist)
	{
		e_player.has_mist = true;

		ShieldLog("^3spawning mist....");

		Mist = util::spawn_model("tag_origin", self.origin + (0, 0, 15), (0, 0, 0));

		for (i = 0; i < 50; i++)
		{
			Mist clientfield::set("powerup_fx", 4);

			foreach (player in level.players) {
				dist = distance(Mist.origin, player.origin);
				withinrange = dist <= 75;

				val = 0;
				if (withinrange)
					val = 1;
				else
					val = 0;

				player val::set(#"zm_bgb_talkin_bout_regeneration", "ignore_health_regen_delay", val);
				player clientfield::set_to_player("zm_bgb_near_death_experience_1p_fx", val);
        	}

			wait 0.25;
		}

		Mist clientfield::set("powerup_fx", 0);

		wait 0.5;

		Mist delete();

		e_player.e_cooldown_mist = gettime() + randomintrange(6000, 13000);

		e_player.has_mist = false;

		foreach (player in level.players) {
			player val::set(#"zm_bgb_talkin_bout_regeneration", "ignore_health_regen_delay", 0);
			player clientfield::set_to_player("zm_bgb_near_death_experience_1p_fx", 0);
		}
	}
}