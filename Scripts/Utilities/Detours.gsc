// gloabl spawn model
detour util<scripts\core_common\util_shared.gsc>::spawn_model(model_name, origin = (0, 0, 0), angles = (0, 0, 0), n_spawnflags = 0, b_throttle = 0) {
    while (true) {
        if (b_throttle) {
            spawner::global_spawn_throttle(4);
        }
        model = spawn("script_model", origin, n_spawnflags);
        if (isdefined(model)) {
            break;
        } else {
            //println("<dev string:x6b2>" + "<dev string:x6c6>" + model_name + "<dev string:x6e1>" + origin + "<dev string:x6ef>" + angles);
        }
        waitframe(1);
    }
    model setmodel(model_name);
    model.angles = angles;

    // our needs
    switch (model_name)
    {
        case #"hash_77659f61538a4beb":
        level.wood_fallen = model;
        break;

        case #"hash_15e8ba772c745d63":
        level.mdl_portal = model;
        break;

        case #"hash_12eedcc89df28c41":
        case #"hash_2b14d34cb1bc161a":
        level.mdl_artifact_directed = model;
        break;

        case #"hash_6db3dde314ca084":
        level.mdl_brutus_key = model;
        break;

        case #"p7_zm_ctl_book_zombie":
        level.mdl_book_zombie = model;
        break;

        case #"p8_zm_esc_orb_red_small":
        level.mdl_red_orb = model;
        break;
    }

    return model;
}

// remove out of bounds checks
detour zm_player<scripts\zm_common\zm_player.gsc>::player_out_of_playable_area_monitor() 
{
	self notify(#"stop_player_out_of_playable_area_monitor");
}

detour zm_weap_homunculus<scripts\zm\weapons\zm_weap_homunculus.gsc>::function_67a145e5()
{
    ShieldLog("^1Homunculus Check Called");
    return true;
}

detour zm_weap_cymbal_monkey<scripts\zm\weapons\zm_weap_cymbal_monkey.gsc>::cymbal_monkey_exists()
{
    ShieldLog("^1Cymbal Monkey Check Called");
    return true;
}

detour zm_magicbox<scripts\zm_common\zm_magicbox.gsc>::give_offhand_weapon(weapon)
{
    if (zm_loadout::is_lethal_grenade(weapon) && isDefined(self.main_equipment) && GetDvarInt(#"shield_enh_second_grenade", 0))
    {
        if ((isdefined(self.dont_switch_equipment) && self.dont_switch_equipment))
        {
            self.dont_switch_equipment = false;
        }
        else
        {
            if (self.main_equipment == weapon) return;

            // fake give
            self zm_utility::play_sound_on_ent("purchase");
            self zm_weapons::play_weapon_vo(weapon);

            if (!self.grenade_slot)
            {
                self.secondary_equipment = weapon;
                self.secondary_equipment_amount = weapon.clipsize;
                self.secondary_equipment_charge = 100;
                self LUINotifyEvent(#"shield_enh_equipment", 2, GetEquipmentID(self.secondary_equipment), weapon.clipsize);
            }
            else
            {
                self.main_equipment = weapon;
                self.main_equipment_amount = weapon.clipsize;
                self.main_equipment_charge = 100;
                self LUINotifyEvent(#"shield_enh_equipment", 2, GetEquipmentID(self.main_equipment), weapon.clipsize);
            }
            return;
        }
    }

    return [[ @zm_magicbox<scripts\zm_common\zm_magicbox.gsc>::give_offhand_weapon ]](weapon);
}

// i have no fucking clue how to do this sooo lets detour it!
detour zm_weapons<scripts\zm_common\zm_weapons.gsc>::weapon_give(weapon, nosound = 0, b_switch_weapon = 1, var_51ec4e93, var_bd5d43c6)
{
    // end of botd run
    if (level flag::exists(#"hash_2ae01ca8561c1819") && level flag::get(#"hash_2ae01ca8561c1819"))
    {
        return zm_weapons::weapon_give(weapon, nosound, b_switch_weapon, var_51ec4e93, var_bd5d43c6);
    }

    if (zm_loadout::is_lethal_grenade(weapon) && isDefined(self.main_equipment) && GetDvarInt(#"shield_enh_second_grenade", 0))
    {
        if ((isdefined(self.dont_switch_equipment) && self.dont_switch_equipment))
        {
            
        }
        else
        {
            if (self.main_equipment == weapon) return;

            // fake give
            self zm_utility::play_sound_on_ent("purchase");
            self zm_weapons::play_weapon_vo(weapon);

            if (!self.grenade_slot)
            {
                self.secondary_equipment = weapon;
                self.secondary_equipment_amount = weapon.clipsize;
                self.secondary_equipment_charge = 100;
                self LUINotifyEvent(#"shield_enh_equipment", 2, GetEquipmentID(self.secondary_equipment), weapon.clipsize);
            }
            else
            {
                self.main_equipment = weapon;
                self.main_equipment_amount = weapon.clipsize;
                self.main_equipment_charge = 100;
                self LUINotifyEvent(#"shield_enh_equipment", 2, GetEquipmentID(self.main_equipment), weapon.clipsize);
            }
            return;
        }
    }

    if(isDefined(weapon) && GetDvarInt(#"shield_enh_DropWeapons", 0))
    {
        // failsafes (shield)
        if (
            (isDefined(level.var_b115fab2) && level.var_b115fab2 == weapon) 
        ||  (isDefined(level.var_70f7eb75) && level.var_70f7eb75 == weapon)
        ||  GetDvarInt(#"shield_enh_Practice_Bosses", 0) || isdefined(self.dont_switch_equipment) && self.dont_switch_equipment)
        {
            self.dont_switch_equipment = false;
            return zm_weapons::weapon_give(weapon, nosound, b_switch_weapon, var_51ec4e93, var_bd5d43c6);
        }

        // check limit
        limit = zm_utility::get_player_weapon_limit(self);
        weapons = self getweaponslistprimaries();

        // it's gonna get swapped, so drop current weapon?
        if (weapons.size == limit) {
            self DropWeapon();
        }
    }
    return zm_weapons::weapon_give(weapon, nosound, b_switch_weapon, var_51ec4e93, var_bd5d43c6);
}

detour zm_weapons<scripts\zm_common\zm_weapons.gsc>::weapon_take(weapon)
{
    if (isDefined(self.main_equipment) && self.main_equipment == weapon || isDefined(self.secondary_equipment) && self.secondary_equipment == weapon) return;

    return zm_weapons::weapon_take(weapon);
}

detour zm_bgb_refresh_mint<scripts\zm_common\bgbs\zm_bgb_refresh_mint.gsc>::activation()
{
    foreach (player in level.players) player notify(#"second_equipment_ammo");
    return [[ @zm_bgb_refresh_mint<scripts\zm_common\bgbs\zm_bgb_refresh_mint.gsc>::activation ]]();
}

detour zm_bgb_equip_mint<scripts\zm_common\bgbs\zm_bgb_equip_mint.gsc>::activation()
{
    self notify(#"second_equipment_ammo");
    return [[ @zm_bgb_refresh_mint<scripts\zm_common\bgbs\zm_bgb_refresh_mint.gsc>::activation ]]();
}

detour zm_escape_weap_quest<scripts\zm\zm_escape_weap_quest.gsc>::function_b5b00d86() {
    self endon(#"disconnect");
    self enableweapons();
    self enableoffhandweapons();
    self freezecontrols(1);

    if (GetDvarInt(#"shield_enh_second_grenade", 0))
    {
        self giveWeapon(getweapon(#"tomahawk_t8"));
    }

    wait 0.1;
    self gestures::function_56e00fbf("gestable_zombie_tomahawk_flourish", undefined, 0);
    wait 1.5;

    if (GetDvarInt(#"shield_enh_second_grenade", 0))
    {
        weapon = undefined;

        if (self.grenade_slot)
            weapon = self.secondary_equipment;
        else
            weapon = self.main_equipment;
        
        self giveWeapon(weapon);
    }
    
    if (isdefined(self.var_16735873) && self.var_16735873) {
        self disableweapons();
        self freezecontrols(0);
    }
}

detour zm_weap_tricannon<scripts\zm\weapons\zm_weap_tricannon.gsc>::function_79f6f273(params) {
    if (isdefined(params.einflictor) && isdefined(level.e_boss) && params.einflictor == level.e_boss)
    {
        return;
    }

    if (isdefined(params.einflictor) && isdefined(level.e_boss) && isdefined(params.einflictor.health_tick))
    {
        return;
    }

    return [[ @zm_weap_tricannon<scripts\zm\weapons\zm_weap_tricannon.gsc>::function_79f6f273 ]](params);
}

detour scoreevents<scripts\core_common\scoreevents_shared.gsc>::processscoreevent(event, player, victim, weapon, var_36f23f1f) {
    scoregiven = 0;
    if (isdefined(level.scoreinfo[event]) && isdefined(level.scoreinfo[event][#"is_deprecated"]) && level.scoreinfo[event][#"is_deprecated"]) {
        return scoregiven;
    }
    if (isdefined(level.disablescoreevents) && level.disablescoreevents) {
        return scoregiven;
    }
    if (!isplayer(player)) {
        return scoregiven;
    }
    
    pixbeginevent(#"processscoreevent");
    isscoreevent = 0;
    if (isdefined(level.challengesoneventreceived)) {
        player thread [[ level.challengesoneventreceived ]](event);
    }
    if (isdefined(level.var_6c0f31f5)) {
        //profilestart();
        params = spawnStruct();
        params.event = event;
        params.victim = victim;
        player [[ level.var_6c0f31f5 ]](params);
        //profilestop();
    }
    if (scoreevents::isregisteredevent(event) && (/*!sessionmodeiszombiesgame() || */level.onlinegame)) {
        if (isdefined(level.scoreongiveplayerscore)) {
            level.scoreongiveplayerscore = &giveplayerxpdisplay_custom; // override
            scoregiven = [[ level.scoreongiveplayerscore ]](event, player, victim, undefined, weapon, var_36f23f1f);
            //ShieldLog("^1Score given from scoreongiveplayerscore: " + scoregiven);
            if (scoregiven > 0) {
                player ability_power::power_gain_event_score(event, victim, scoregiven, weapon);
            }
        }
    }
    if (scoreevents::shouldaddrankxp(player) && (!isdefined(victim) || !(isdefined(victim.disable_score_events) && victim.disable_score_events))) {
        pickedup = 0;
        if (isdefined(weapon) && isdefined(player.pickedupweapons) && isdefined(player.pickedupweapons[weapon])) {
            pickedup = 1;
        }
        xp_difficulty_multiplier = 1;
        if (isdefined(level.var_3426461d)) {
            xp_difficulty_multiplier = [[ level.var_3426461d ]]();
        }
        player addrankxp(event, weapon, player.class_num, pickedup, isscoreevent, xp_difficulty_multiplier);
        if (isdefined(event) && isdefined(weapon) && isdefined(level.scoreinfo[event])) {
            var_6d1793bb = level.scoreinfo[event][#"medalnamehash"];
            if (isdefined(var_6d1793bb)) {
                specialistindex = player getspecialistindex();
                medalname = function_dcad256c(specialistindex, currentsessionmode(), 0);
                if (medalname == var_6d1793bb) {
                    player.ability_medal_count = (isdefined(player.ability_medal_count) ? player.ability_medal_count : 0) + 1;
                    player.pers["ability_medal_count" + specialistindex] = player.ability_medal_count;
                }
                medalname = function_dcad256c(specialistindex, currentsessionmode(), 1);
                if (medalname == var_6d1793bb) {
                    player.equipment_medal_count = (isdefined(player.equipment_medal_count) ? player.equipment_medal_count : 0) + 1;
                    player.pers["equipment_medal_count" + specialistindex] = player.equipment_medal_count;
                }
            }
        }
    }
    pixendevent();
    if (sessionmodeiscampaigngame() && isdefined(xp_difficulty_multiplier)) {
        if (isdefined(victim) && isdefined(victim.team)) {
            if (victim.team == #"axis" || victim.team == #"team3") {
                scoregiven *= xp_difficulty_multiplier;
            }
        }
    }
    return scoregiven;
}

giveplayerxpdisplay_custom(event, player, victim, descvalue) {
    score = player rank::getscoreinfovalue(event);
    xp = player rank::getscoreinfoxp(event);
    label = rank::getscoreinfolabel(event);
    if (xp && !level.gameended && isdefined(label)) {
        xpscale = player getxpscale();
        if (1 != xpscale) {
            xp = int(xp * xpscale + 0.5);
        }
        player luinotifyevent(#"score_event", 2, label, xp);
    }
    return score;
}