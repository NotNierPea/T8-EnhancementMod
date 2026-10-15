// perk limit for main perks (check string + trigger for both stories)
// aether string
detour zm_perks<scripts\zm_common\zm_perks.gsc>::function_5296af32(player) {
    if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::function_5296af32 ]](player);

    perk = self.script_noteworthy;
    var_f2a92d5e = 0;
    if (isdefined(self.stub.machine)) {
        var_f2a92d5e = self.stub.machine.power_on;
    }
    if (isdefined(perk) && !player hasperk(perk) && self zm_perks::vending_trigger_can_player_use(player, 1) && !player zm_perks::has_perk_paused(perk) && !player zm_utility::in_revive_trigger() && !zm_equipment::is_equipment_that_blocks_purchase(player getcurrentweapon()) && !player zm_equipment::hacker_active()) {
        b_is_invis = 0;
        if (!var_f2a92d5e) {
            self.stub.hint_string = #"zombie/need_power";
            self.stub.hint_parm1 = undefined;
        } 
        else 
        {
            cost = zombie_utility::get_zombie_var(#"zombie_perk_cost");
            if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].cost)) {
                if (isint(level._custom_perks[perk].cost)) {
                    cost = level._custom_perks[perk].cost;
                } else {
                    cost = [[ level._custom_perks[perk].cost ]]();
                }
            }
            self.stub.hint_string = level._custom_perks[perk].hint_string;
            self.stub.hint_parm1 = cost;

            if (player.perk_limit_classic >= 5)
            {
                self.stub.hint_string = #"shield/perk_limit";
                self.stub.hint_parm1 = undefined;
            }
        }
        zm_unitrigger::function_d0676c62(self.stub, self, player);
    } else if (isdefined(perk) && player hasperk(perk) && GetDvarInt("shield_enh_ClassicMode_ReturnPerks", 0) && self zm_perks::vending_trigger_can_player_use(player, 1) && !player zm_utility::in_revive_trigger()) {
        cost = zombie_utility::get_zombie_var(#"zombie_perk_cost");
        if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].cost)) {
            if (isint(level._custom_perks[perk].cost)) {
                cost = level._custom_perks[perk].cost;
            } else {
                cost = [[ level._custom_perks[perk].cost ]]();
            }
        }
        self.stub.hint_string = #"shield/perk_return";
        self.stub.hint_parm1 = cost;
        zm_unitrigger::function_d0676c62(self.stub, self, player);
    } else {
        b_is_invis = 1;
    }
    return !b_is_invis;
}

// aether trigger
detour zm_perks<scripts\zm_common\zm_perks.gsc>::vending_trigger_think() {
    if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::vending_trigger_think ]]();
    
    self endon(#"death");
    perk = self.script_noteworthy;
    cost = self.stub.cost;
    n_slot = self.stub.script_int;
    self thread zm_audio::sndperksjingles_timer();

    self thread RefundLogic(cost, perk, n_slot);

    for (;;) {
        waitresult = self waittill(#"trigger");
        player = waitresult.activator;
        var_f2a92d5e = 0;
        if (isdefined(self.stub.machine)) {
            var_f2a92d5e = self.stub.machine.power_on;
        }
        if (!var_f2a92d5e) {
            wait 0.1;
            continue;
        }
        index = zm_utility::get_player_index(player);
        if (!zm_perks::vending_trigger_can_player_use(player, 1)) {
            wait 0.1;
            continue;
        }
        if (GetDvarInt("shield_enh_ClassicMode_ReturnPerks", 0) && player hasperk(perk)) {
            player zm_score::add_to_player_score(cost);
            player RemoveMainPerk(n_slot, perk);
            player iPrintLn(#"shield/refund_get", zm_perk_translate(perk));
            wait 0.1;
            continue;
        }
        if (player hasperk(perk) || player zm_perks::has_perk_paused(perk) || player.perk_limit_classic >= 5) {
            cheat = 0;
            /#
                if (getdvarint(#"zombie_cheat", 0) >= 5) {
                    cheat = 1;
                }
            #/
            if (cheat != 1) {
                zm_utility::play_sound_on_ent("no_purchase");
                continue;
            }
        }
        if (isdefined(level.custom_perk_validation)) {
            valid = self [[ level.custom_perk_validation ]](player);
            if (!valid) {
                continue;
            }
        }
        current_cost = cost;
        if (n_slot == 0 && isdefined(player.talisman_perk_reducecost_1) && player.talisman_perk_reducecost_1) {
            current_cost -= player.talisman_perk_reducecost_1;
        }
        if (n_slot == 1 && isdefined(player.talisman_perk_reducecost_2) && player.talisman_perk_reducecost_2) {
            current_cost -= player.talisman_perk_reducecost_2;
        }
        if (n_slot == 2 && isdefined(player.talisman_perk_reducecost_3) && player.talisman_perk_reducecost_3) {
            current_cost -= player.talisman_perk_reducecost_3;
        }
        if (n_slot == 3 && isdefined(player.talisman_perk_reducecost_4) && player.talisman_perk_reducecost_4) {
            current_cost -= player.talisman_perk_reducecost_4;
        }
        if (!player zm_score::can_player_purchase(current_cost)) {
            zm_utility::play_sound_on_ent("no_purchase");
            player zm_audio::create_and_play_dialog(#"general", #"outofmoney");
            continue;
        }
        if (!player zm_utility::can_player_purchase_perk()) {
            zm_utility::play_sound_on_ent("no_purchase");
            continue;
        }
        sound = #"evt_bottle_dispense";
        playsoundatposition(sound, self.origin);
        player zm_score::minus_to_player_score(current_cost);
        bb::logpurchaseevent(player, self, current_cost, perk, 0, "_perk", "_purchased");
        perkhash = -1;
        if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].alias)) {
            perkhash = level._custom_perks[perk].alias;
        }
        player recordmapevent(29, gettime(), self.origin, level.round_number, perkhash);
        player.perk_purchased = perk;
        player notify(#"perk_purchased", {#perk:perk});
        self thread zm_audio::sndperksjingles_player(1);
        self thread zm_perks::vending_trigger_post_think(player, perk);
    }
}

// chaos string
detour zm_perks<scripts\zm_common\zm_perks.gsc>::function_b7f2c635(player) {
    if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::function_b7f2c635 ]](player);

    n_slot = self.stub.script_int;
    perk = player.var_47654123[n_slot] ? #"specialty_mystery" : player.var_c27f1e90[n_slot];
    if (self.stub.var_36d60c16 !== 1 && player getstance() === "prone" && distancesquared(self.origin, player.origin) < 9216) {
        self.stub.var_36d60c16 = 1;
        player zm_score::add_to_player_score(100);
        self playsoundtoplayer(#"hash_30fa33e2fb90b58f", player);
    }

    if (player.perk_limit_classic >= 5)
    {
        self sethintstringforplayer(player, #"shield/perk_limit");  
        return true;
    }

    if (GetDvarInt("shield_enh_ClassicMode_ReturnPerks", 0) && isdefined(perk) && player hasperk(perk) && self zm_perks::vending_trigger_can_player_use(player, 1) && isdefined(level._custom_perks) && isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].cost)) {
        n_cost = level [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::function_44915d1 ]](perk, n_slot);
        self sethintstringforplayer(player, #"shield/perk_return", n_cost);
        return true;
    }

    if (player.var_47654123[n_slot] && !isdefined(player zm_perks::function_5ea0c6cf())) {
        return false;
    }
    if (isdefined(self.stub.var_e80aca0a) && self.stub.var_e80aca0a) {
        return false;
    }
    if (!isdefined(n_slot) || !isdefined(player.var_c27f1e90) || !isdefined(player.var_c27f1e90[n_slot]) || player.var_c27f1e90[n_slot] == "") {
        return false;
    }
    if (zm_custom::function_8b8fa6e5(player)) {
        return false;
    }
    if (isdefined(player.perk_purchased)) {
        return false;
    }
    var_99442276 = 0;
    if (self.stub.var_3468124.var_2977c27 == "off") {
        self sethintstringforplayer(player, #"zombie/need_power");
        return true;
    }
    if (zm_trial_disable_buys::is_active()) {
        self sethintstringforplayer(player, #"hash_55d25caf8f7bbb2f");
        return true;
    }
    if (zm_trial_disable_perks::is_active() || !zm_custom::function_901b751c(#"zmperksactive") || zm_trial_randomize_perks::is_active()) {
        self sethintstringforplayer(player, #"hash_77db65489366a43");
        return true;
    }
    if (self.stub.var_3468124.var_2977c27 == "on" && isdefined(perk) && !player hasperk(perk) && self zm_perks::vending_trigger_can_player_use(player, 1) && !player zm_perks::has_perk_paused(perk) && !player zm_utility::in_revive_trigger() && !zm_equipment::is_equipment_that_blocks_purchase(player getcurrentweapon()) && !player zm_equipment::hacker_active()) {
        var_99442276 = 1;
    }
    if (var_99442276) {
        b_is_invis = 0;
        if (isdefined(level._custom_perks)) {
            if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].cost) && isdefined(level._custom_perks[perk].hint_string)) {
                n_cost = level [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::function_44915d1 ]](perk, n_slot);
                if (isdefined(level.var_256aa316)) {
                    var_c591876d = [[ level.var_256aa316 ]](perk);
                } else {
                    var_c591876d = level._custom_perks[perk].hint_string;
                }
            }
        }
        if (n_slot == 0 && isdefined(player.talisman_perk_reducecost_1) && player.talisman_perk_reducecost_1) {
            n_cost -= player.talisman_perk_reducecost_1;
        }
        if (n_slot == 1 && isdefined(player.talisman_perk_reducecost_2) && player.talisman_perk_reducecost_2) {
            n_cost -= player.talisman_perk_reducecost_2;
        }
        if (n_slot == 2 && isdefined(player.talisman_perk_reducecost_3) && player.talisman_perk_reducecost_3) {
            n_cost -= player.talisman_perk_reducecost_3;
        }
        if (n_slot == 3 && isdefined(player.talisman_perk_reducecost_4) && player.talisman_perk_reducecost_4) {
            n_cost -= player.talisman_perk_reducecost_4;
        }
        n_cost = player namespace_e38c57c1::function_863dc0ef(n_cost);
        n_cost = int(max(n_cost, 0));
        if (isdefined(var_c591876d) && var_c591876d !== " ") {
            self sethintstringforplayer(player, var_c591876d, n_cost);
        }
    } else {
        b_is_invis = 1;
    }
    return !b_is_invis;
}

// chaos trigger
detour zm_perks<scripts\zm_common\zm_perks.gsc>::function_f5da744e() {
    if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::function_f5da744e ]]();

    self endon(#"death");
    n_slot = self.stub.script_int;
    n_cost = self.stub.cost;

    self thread RefundLogic(0, undefined, n_slot);

    if (level.var_c3e5c4cd == 1) {
        self thread zm_perks::function_9da4880b();
    }
    for (;;) {
        waitresult = self waittill(#"trigger");
        player = waitresult.activator;
        if (self.stub.var_3468124.var_2977c27 != "on") {
            continue;
        }
        if (!zm_perks::vending_trigger_can_player_use(player, 1) || zm_trial_disable_buys::is_active() || zm_trial_disable_perks::is_active() || !zm_custom::function_901b751c(#"zmperksactive")) {
            wait 0.1;
            continue;
        }
        perk = player.var_47654123[n_slot] ? #"specialty_mystery" : player.var_c27f1e90[n_slot];
        if (!isdefined(player.var_c27f1e90) || player.var_c27f1e90.size <= n_slot) {
            return;
        }
        if (player.var_47654123[n_slot] && !isdefined(player zm_perks::function_5ea0c6cf())) {
            return;
        }

        if (GetDvarInt("shield_enh_ClassicMode_ReturnPerks", 0) && player hasperk(perk)) {
            return_cost = n_cost;
            if (isdefined(level._custom_perks) && isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].cost)) {
                return_cost = level [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::function_44915d1 ]](perk, n_slot);
            }
            player zm_score::add_to_player_score(return_cost);
            player RemoveMainPerk(n_slot, perk);
            player iPrintLn(#"shield/refund_get", zm_perk_translate(perk));
            wait 0.1;
            continue;
        }
        
        if (player hasperk(perk) || player zm_perks::has_perk_paused(perk) || player.perk_limit_classic >= 5) {
            cheat = 0;
            /#
                if (getdvarint(#"zombie_cheat", 0) >= 5) {
                    cheat = 1;
                }
            #/
            if (cheat != 1) {
                zm_utility::play_sound_on_ent("no_purchase");
                continue;
            }
        }
        if (isdefined(level.custom_perk_validation)) {
            valid = self [[ level.custom_perk_validation ]](player);
            if (!valid) {
                continue;
            }
        }
        if (isdefined(level._custom_perks)) {
            if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].cost) && isdefined(level._custom_perks[perk].hint_string)) {
                n_cost = level [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::function_44915d1 ]](perk, n_slot);
            }
        }
        current_cost = n_cost;
        if (n_slot == 0 && isdefined(player.talisman_perk_reducecost_1) && player.talisman_perk_reducecost_1) {
            current_cost -= player.talisman_perk_reducecost_1;
        }
        if (n_slot == 1 && isdefined(player.talisman_perk_reducecost_2) && player.talisman_perk_reducecost_2) {
            current_cost -= player.talisman_perk_reducecost_2;
        }
        if (n_slot == 2 && isdefined(player.talisman_perk_reducecost_3) && player.talisman_perk_reducecost_3) {
            current_cost -= player.talisman_perk_reducecost_3;
        }
        if (n_slot == 3 && isdefined(player.talisman_perk_reducecost_4) && player.talisman_perk_reducecost_4) {
            current_cost -= player.talisman_perk_reducecost_4;
        }
        current_cost = player namespace_e38c57c1::function_863dc0ef(current_cost);
        current_cost = int(max(current_cost, 0));
        if (!player zm_score::can_player_purchase(current_cost)) {
            zm_utility::play_sound_on_ent("no_purchase");
            player zm_audio::create_and_play_dialog(#"general", #"outofmoney");
            continue;
        }
        player thread zm_audio::create_and_play_dialog(#"altar", #"interact");
        playsoundatposition(#"hash_489cdfeed1ac55bd", self.origin);
        if (level.var_c3e5c4cd == 1 && !self.var_3cfb2018) {
            playsoundatposition(#"hash_1e20f59360c2377e", self.origin);
        }
        player zm_score::minus_to_player_score(current_cost);
        bb::logpurchaseevent(player, self, current_cost, perk, 0, "_perk", "_purchased");
        if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].alias)) {
            perkhash = level._custom_perks[perk].alias;
        }
        if (!ishash(perkhash)) {
            //assertmsg("<dev string:x9a0>");
            perkhash = -1;
        }
        n_round_number = level.round_number;
        if (!isint(n_round_number)) {
            //assertmsg("<dev string:x9d7>");
            n_round_number = 0;
        }
        player recordmapevent(29, gettime(), self.origin, n_round_number, perkhash);
        player.perk_purchased = perk;
        player notify(#"perk_purchased", {#perk:perk});
        if (player.var_47654123[n_slot]) {
            perk = player zm_perks::function_5ea0c6cf();
        }
        self thread zm_perks::taking_cover_tanks_(player, perk, n_slot, self.stub.var_3468124);
    }
}

// ix's challenge for hero weapon
detour zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::function_1abdfaa6(e_player, e_trig, var_5f06d3f8) {
    if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::function_1abdfaa6 ]](e_player, e_trig, var_5f06d3f8);

    e_player endon(#"disconnect");
    if (var_5f06d3f8 === 1) {
        e_trig sethintstring(#"hash_9b98137ec7cd136");
        e_trig waittill(#"trigger");
    }
    e_trig.hint_string = #"hash_51397dc3d51e150c";
    e_trig sethintstringforplayer(e_player, e_trig.hint_string, 10);
    if (!isdefined(self.var_fa64a47b)) {
        self.var_fa64a47b = 0;
    }

    e_powerup = zm_powerups::specific_powerup_drop("custom_random_specialists", e_player.origin, undefined, 0.5, e_player);
    if (isdefined(e_powerup)) {
        e_powerup setscale(1.3);
    }

    self [[ @zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::function_bce7e59b ]](e_player, 2, self.var_fa64a47b);
    self waittill(#"hash_7731445a0fb80df");
    self [[ @zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::function_544b63c0 ]](10);
    playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
    self.var_fa64a47b = undefined;
    e_trig [[ @zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::function_d2103a80 ]](e_player, 10);
    self flag::clear(#"hash_5a7dfe069f4cbcec");
    if (!level flag::get(#"first_player_completed_3rd_challenge")) {
        level flag::set(#"first_player_completed_3rd_challenge");
    }
}

Bo3ClassicPapActive()
{
    return GetDvarInt(#"shield_enh_ClassicMode", 0) && GetDvarInt(#"shield_enh_ClassicMode_ClassicPaP", 0) == 2;
}

Bo3ClassicRepackCost(player)
{
    cost = 2500;
    if (isdefined(player) && isdefined(player.talisman_weapon_reducepapcost) && player.talisman_weapon_reducepapcost)
        cost = int(max(10, cost - player.talisman_weapon_reducepapcost));
    return cost;
}

// BO3 classic PaP: re-packs always cost 2500 (AAT only, no damage boost)
detour zm_pap_util<scripts\zm_common\zm_pack_a_punch_util.gsc>::function_aaf2d8(player, weapon, b_weapon_supports_aat, var_a86430cb)
{
    if (Bo3ClassicPapActive() && isdefined(var_a86430cb) && var_a86430cb && isdefined(b_weapon_supports_aat) && b_weapon_supports_aat)
    {
        if (zombie_utility::function_d2dfacfd(#"zombie_powerup_bonfire_sale_on"))
            return 500;
        return Bo3ClassicRepackCost(player);
    }
    return self [[ @zm_pap_util<scripts\zm_common\zm_pack_a_punch_util.gsc>::function_aaf2d8 ]](player, weapon, b_weapon_supports_aat, var_a86430cb);
}

// BO3 classic PaP: after the first pack, hide "Boost Damage" from the re-pack prompt
detour zm_pap_util<scripts\zm_common\zm_pack_a_punch_util.gsc>::update_hint_string(player)
{
    result = self [[ @zm_pap_util<scripts\zm_common\zm_pack_a_punch_util.gsc>::update_hint_string ]](player);

    if (!result)
        return result;
    if (!Bo3ClassicPapActive())
        return result;
    if (!isdefined(player) || !isdefined(self.stub) || !isdefined(self.stub.zbarrier))
        return result;

    pap_machine = self.stub.zbarrier;
    if (!pap_machine flag::get("pap_waiting_for_user"))
        return result;

    w_current = player getcurrentweapon();
    if (!isdefined(w_current) || w_current == level.weaponnone)
        return result;
    if (!zm_weapons::is_weapon_upgraded(w_current))
        return result;
    if (!zm_weapons::weapon_supports_aat(w_current))
        return result;

    self sethintstring(#"shield/bo3_repack", Bo3ClassicRepackCost(player));
    return true;
}

// element pop's
detour aat<scripts\core_common\aat_shared.gsc>::aat_response(death, inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
   	if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @aat<scripts\core_common\aat_shared.gsc>::aat_response ]](death, inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
 
    if (!isplayer(attacker) || !isdefined(attacker.aat) || !isdefined(weapon)) {
        return;
    }
    bullet = mod == "MOD_PISTOL_BULLET" || mod == "MOD_RIFLE_BULLET" || mod == "MOD_GRENADE" || mod == "MOD_PROJECTILE" || mod == "MOD_EXPLOSIVE" || mod == "MOD_IMPACT" || mod == #"mod_pistol_bullet" || mod == #"mod_rifle_bullet" || mod == #"mod_grenade" || mod == #"mod_projectile" || mod == #"mod_explosive" || mod == #"mod_impact";
    melee = (mod == "MOD_MELEE" || mod == #"mod_melee") && isdefined(level.var_9d1d502c) && level.var_9d1d502c;
    if (!bullet && !melee) {
        return;
    }

    // our logic
    if (isDefined(attacker.HasElemental) && attacker.HasElemental)
    {
        if (GetDvarInt(#"shield_enh_LocalTest", 0) || math::cointoss(2))
        {
            // random AAT name from the level.aat array
            keys = getarraykeys(level.aat);
            if (keys.size > 0)
            {
                name_random = array::random(keys);
            }
            else
            {
                return;
            }
            
            if (GetDvarInt(#"shield_enh_ClassicMode_Bo3Aat", 0))
            {
                pick = array::random(Bo3AatTypes());
                self thread Bo3AatEffect(attacker, pick);
                Bo3AatHitNotify(attacker, pick);
            }
            else if (isDefined(level.aat[name_random]) && isDefined(level.aat[name_random].result_func))
            {
                // ignore bosses and stuff
                if (isdefined(level.aat[name_random].immune_trigger[self.archetype]) && level.aat[name_random].immune_trigger[self.archetype]) {
                    return;
                }
            
                self thread [[ level.aat[name_random].result_func ]](death, attacker, mod, weapon);
                attacker thread damagefeedback::update_override(level.aat[name_random].damage_feedback_icon, level.aat[name_random].damage_feedback_sound, undefined);
            }
        }
    }

    name = attacker.aat[aat::function_702fb333(weapon)];
    if (!isdefined(name)) {
        return;
    }
    // LocalTest forces every shot; real chances are on the register calls
    // Dead Wire 20%, attacker 5s, global 2s. Blast Furnace 15%, attacker 15s.
    // Turned 15%, attacker 15s, global 8s, skipped on a killing blow.
    // Fire Works 10%, attacker 20s, global 10s. Thunder Wall 25%, attacker 10s.
    always = GetDvarInt(#"shield_enh_LocalTest", 0);
    if (isdefined(death) && death && !level.aat[name].occurs_on_death && !always) {
        return;
    }
    if (!isdefined(self.archetype)) {
        if (name != "zm_aat_dead_wire" && name != "zm_aat_blast_furnace" && name != "zm_aat_turned" && name != "zm_aat_fire_works" && name != "zm_aat_thunder_wall")
            return;
    } else if (isdefined(level.aat[name].immune_trigger) && isdefined(level.aat[name].immune_trigger[self.archetype]) && level.aat[name].immune_trigger[self.archetype]) {
        return;
    }
    if (isdefined(self.var_dd6fe31f) && self.var_dd6fe31f) {
        return;
    }
    if (isdefined(self.var_69a981e6) && self.var_69a981e6) {
        return;
    }
    if (isdefined(self.aat_turned) && self.aat_turned) {
        return;
    }
    now = float(gettime()) / 1000;
    if (!always)
    {
        if (isdefined(self.aat_cooldown_start) && now <= self.aat_cooldown_start[name] + level.aat[name].cooldown_time_entity) {
            return;
        }
        if (now <= attacker.aat_cooldown_start[name] + level.aat[name].cooldown_time_attacker) {
            return;
        }
        if (now <= level.aat[name].cooldown_time_global_start + level.aat[name].cooldown_time_global) {
            return;
        }
    }
    if (isdefined(level.aat[name].validation_func)) {
        if (![[ level.aat[name].validation_func ]]()) {
            return;
        }
    }
    success = 0;
    reroll_icon = undefined;
    percentage = level.aat[name].percentage;
    if (always)
        percentage = 1;

    if (!always && isdefined(level.var_bdba6ee8[weapon])) {
        if (level.var_bdba6ee8[weapon] < percentage) {
            percentage = level.var_bdba6ee8[weapon];
        }
    }

    if (percentage >= randomfloat(1)) {
        success = 1;
    }
    if (!success) {
        keys = getarraykeys(level.aat_reroll);
        keys = array::randomize(keys);
        foreach (key in keys) {
            if (attacker [[ level.aat_reroll[key].active_func ]]()) {
                for (i = 0; i < level.aat_reroll[key].count; i++) {
                    if (percentage >= randomfloat(1)) {
                        success = 1;
                        reroll_icon = level.aat_reroll[key].damage_feedback_icon;
                        break;
                    }
                }
            }
            if (success) {
                break;
            }
        }
    }
    if (!success) {
        return;
    }
    level.aat[name].cooldown_time_global_start = now;
    attacker.aat_cooldown_start[name] = now;
    self thread [[ level.aat[name].result_func ]](death, attacker, mod, weapon);
    if (isplayer(attacker)) {
        Bo3AatHitNotify(attacker, name);
        if (isdefined(level.aat[name].damage_feedback_sound))
            attacker playlocalsound(level.aat[name].damage_feedback_sound);
    }
}

detour zm_player<scripts\zm_common\zm_player.gsc>::player_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
	if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @zm_player<scripts\zm_common\zm_player.gsc>::player_damage_override ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);

    idamage = self zm_player::check_player_damage_callbacks(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    if (self.scene_takedamage === 0) {
        return 0;
    }
    if (isdefined(level.prevent_player_damage) && !level.friendlyfire) {
        if (self [[ level.prevent_player_damage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)) {
            return 0;
        }
    }
    if (isdefined(eattacker) && isdefined(eattacker.b_aat_fire_works_weapon) && eattacker.b_aat_fire_works_weapon) {
        return 0;
    }
    if (isdefined(eattacker) && isdefined(eattacker.aat_turned) && eattacker.aat_turned) {
        return 0;
    }
    if (isdefined(self.use_adjusted_grenade_damage) && self.use_adjusted_grenade_damage) {
        self.use_adjusted_grenade_damage = undefined;
        if (self.health > idamage) {
            return idamage;
        }
    }
    if (!idamage) {
        return 0;
    }
    if (self laststand::player_is_in_laststand()) {
        return 0;
    }
    if (isdefined(einflictor)) {
        if (isdefined(einflictor.water_damage) && einflictor.water_damage) {
            return 0;
        }
    }
    if (isdefined(eattacker)) {
        if (eattacker.owner === self) {
            return 0;
        }
        if (isdefined(self.ignoreattacker) && self.ignoreattacker == eattacker) {
            return 0;
        }
        if (isdefined(self.is_zombie) && self.is_zombie && isdefined(eattacker.is_zombie) && eattacker.is_zombie) {
            return 0;
        }
        if (isdefined(eattacker.is_zombie) && eattacker.is_zombie) {
            self.ignoreattacker = eattacker;
            self thread zm_player::remove_ignore_attacker();
            if (isdefined(eattacker.custom_damage_func)) {
                idamage = eattacker [[ eattacker.custom_damage_func ]](self);
            }
        }
        eattacker notify(#"hit_player");
        if (isdefined(eattacker) && isdefined(eattacker.func_mod_damage_override)) {
            smeansofdeath = eattacker [[ eattacker.func_mod_damage_override ]](einflictor, smeansofdeath, weapon);
        }
        if (smeansofdeath != "MOD_FALLING") {
            if (isdefined(eattacker.is_zombie) && eattacker.is_zombie || isplayer(eattacker)) {
                self playrumbleonentity("damage_heavy");
            }
            if (eattacker.archetype === #"zombie") {
                self zm_audio::create_and_play_dialog(#"general", #"attacked");
            }
            if (randomintrange(0, 1) == 0) {
                self thread zm_audio::playerexert("hitmed");
            } else {
                self thread zm_audio::playerexert("hitlrg");
            }
        }
    }
    if (isdefined(smeansofdeath) && smeansofdeath == "MOD_DROWN") {
        self thread zm_audio::playerexert("drowning", 1);
        self.voxdrowning = 1;
    }
    if (isdefined(level.perk_damage_override)) {
        foreach (func in level.perk_damage_override) {
            n_damage = self [[ func ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
            if (isdefined(n_damage)) {
                idamage = n_damage;
            }
        }
    }
    if (zm_loadout::is_placeable_mine(weapon)) {
        return 0;
    }
    if (isdefined(self.player_damage_override)) {
        self thread [[ self.player_damage_override ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    }
    if (isdefined(einflictor) && isdefined(einflictor.archetype) && einflictor.archetype == #"zombie_quad") {
        if (smeansofdeath == "MOD_EXPLOSIVE") {
            if (self.health > 75) {
                return 75;
            }
        }
    }
    if (smeansofdeath == "MOD_SUICIDE" && self bgb::is_enabled(#"zm_bgb_danger_closest")) {
        return 0;
    }
    if (zm_utility::is_explosive_damage(smeansofdeath)) {
        if (self bgb::is_enabled(#"zm_bgb_danger_closest")) {
            return 0;
        }
        if (!(isdefined(self.is_zombie) && self.is_zombie)) {
            if (!isdefined(eattacker) || !(isdefined(eattacker.is_zombie) && eattacker.is_zombie) && !(isdefined(eattacker.b_override_explosive_damage_cap) && eattacker.b_override_explosive_damage_cap)) {
                if (isdefined(weapon.name) && (weapon.name == #"ray_gun" || weapon.name == #"ray_gun_upgraded")) {
                    if (self.health > 25 && idamage > 25) {
                        return 25;
                    }
                } else if (self.health > 75 && idamage > 75) {
                    return 75;
                }
            }
        }
    }
    idamage = self zm_armor::damage(idamage, smeansofdeath, eattacker);
    if (isdefined(level.var_ccdc4ca6)) {
        for (i = 0; i < level.var_ccdc4ca6.size; i++) {
            var_36da0ddb = self [[ level.var_ccdc4ca6[i] ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
            if (isdefined(var_36da0ddb) && var_36da0ddb != -1) {
                idamage = var_36da0ddb;
            }
        }
    }
    finaldamage = idamage;
    if (idamage < self.health) {
        if (isdefined(eattacker)) {
            if (isdefined(level.custom_kill_damaged_vo)) {
                eattacker thread [[ level.custom_kill_damaged_vo ]](self);
            } else {
                eattacker.sound_damage_player = self;
            }
            if (isdefined(eattacker.missinglegs) && eattacker.missinglegs) {
                self zm_audio::create_and_play_dialog(#"general", #"crawl_hit");
            }
        }
        return idamage;
    }
    if (isdefined(level.player_death_override) && self [[ level.player_death_override ]]()) {
        return 0;
    }
    if (isdefined(eattacker)) {
        self zm_stats::handle_death(einflictor, eattacker, weapon, smeansofdeath);
    }
    self thread zm_player::clear_path_timers();
    if (level.intermission) {
        level waittill(#"forever");
    }
    if (level.scr_zm_ui_gametype == "zcleansed" && idamage > 0) {
        if (isdefined(eattacker) && isplayer(eattacker) && eattacker.team != self.team && (!(isdefined(self.laststand) && self.laststand) && !self laststand::player_is_in_laststand() || !isdefined(self.last_player_attacker))) {
            if (isdefined(eattacker.maxhealth) && isdefined(eattacker.is_zombie) && eattacker.is_zombie) {
                eattacker.health = eattacker.maxhealth;
            }
            if (isdefined(level.player_kills_player)) {
                self thread [[ level.player_kills_player ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
            }
        }
    }

	// remove extra check for coop...
    if (self hasperk(#"specialty_whoswho")) {
        self zm_laststand::function_409dc98e();
        self zm_laststand::function_3a00302e(-1);
        if (isdefined(level.whoswho_laststand_func)) {
            self thread [[ level.whoswho_laststand_func ]]();
            return 0;
        }
    }

    if (self zm_laststand::function_618fd37e() > 0) {
        var_228d944 = 1;
    } else {
        var_228d944 = zm_player::function_3799b373(self);
    }
    if (var_228d944 || zm_utility::function_91403f47()) {
        return finaldamage;
    }
    if (isdefined(level.var_57cc29f3) && [[ level.var_57cc29f3 ]](self)) {
        return finaldamage;
    }
    if (getplayers().size == 1 && level flag::get("solo_game")) {
        if (isdefined(level.var_fb697fca) && [[ level.var_fb697fca ]]()) {
            return finaldamage;
        } else {
            self.intermission = 1;
        }
    }
    level notify(#"stop_suicide_trigger");
    self allowprone(1);
    self thread zm_laststand::playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    if (!isdefined(vdir)) {
        vdir = (1, 0, 0);
    }
    self fakedamagefrom(vdir);
    level notify(#"last_player_died");
    if (isdefined(level.custom_player_fake_death)) {
        self thread [[ level.custom_player_fake_death ]](vdir, smeansofdeath);
    } else {
        self thread zm_player::player_fake_death();
    }
    level notify(#"pre_end_game");
    util::wait_network_frame();
    if (level flag::get("dog_round")) {
        zm::increment_dog_round_stat("lost");
    }
    level notify(#"end_game");
    return 0;
}

detour zm_laststand<scripts\zm_common\zm_laststand.gsc>::function_409dc98e(n_count = 1, b_revived = 1) {
	if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @zm_laststand<scripts\zm_common\zm_laststand.gsc>::function_409dc98e ]](n_count, b_revived);

	// whos who?
	if (self hasperk(#"specialty_whoswho")) {
		return;
	}

    if (b_revived) {
        self.var_308dc243 += n_count;
    }
    self zm_laststand::function_3d685b5f(self zm_laststand::function_618fd37e() - n_count);
}

detour riotshield<scripts\zm\weapons\zm_weap_riotshield.gsc>::player_init_shield_health(weapon, var_cd9d17e0 = 0) {
	if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @riotshield<scripts\zm\weapons\zm_weap_riotshield.gsc>::player_init_shield_health ]](weapon, var_cd9d17e0);

    self endon(#"disconnect");
    if (!isdefined(weapon)) {
        weapon = level.weaponriotshield;
        if (isdefined(self.weaponriotshield)) {
            weapon = self.weaponriotshield;
        }
    }

	/#
    switch (zm_custom::function_901b751c(#"zmshielddurability")) {
    case 0:
        level.var_7bcfc873 = 2;
        break;
    case 2:
        level.var_7bcfc873 = 0.5;
        break;
    case 1:
    default:
        level.var_7bcfc873 = 1;
        break;
    }
	#/

	level.var_7bcfc873 = 0.5;

    var_2aaf6cdb = zombie_utility::get_zombie_var(#"hash_cc85b961f25c2ff");
    if (isdefined(var_2aaf6cdb)) {
        level.var_7bcfc873 *= var_2aaf6cdb;
    }
    damagemax = int(weapon.weaponstarthitpoints);
    shieldhealth = self damageriotshield(0);
    shieldhealth = self damageriotshield(shieldhealth - damagemax);
    self [[ @riotshield<scripts\zm\weapons\zm_weap_riotshield.gsc>::updateriotshieldmodel ]]();
    self clientfield::set_player_uimodel("ZMInventoryPersonal.shield_health", 1);
    n_current_health = self damageriotshield(0);
    if (n_current_health < damagemax) {
        self.var_d3345483 = 1;
    } else {
        self.var_d3345483 = undefined;
    }
    if (var_cd9d17e0) {
        self givemaxammo(weapon);
    }
    return true;
}

detour zombie_utility<scripts\core_common\ai\zombie_utility.gsc>::ai_calculate_health(base_health, round_number) {
	if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @zombie_utility<scripts\core_common\ai\zombie_utility.gsc>::ai_calculate_health ]](base_health, round_number);

    if (isdefined(level.var_5d1805c4)) {
        var_d082c739 = [[ level.var_5d1805c4 ]](base_health, round_number);
        if (var_d082c739 >= 0) {
            return var_d082c739;
        }
    }
    if (util::get_game_type() == #"zclassic" && level.gamedifficulty < 2 && round_number > 35) {
        //round_number = 35;
    }
    var_d082c739 = base_health;
    for (i = 2; i <= round_number; i++) {
        if (i >= 10 && !(isdefined(level.var_50dd0ec5) && level.var_50dd0ec5)) {
            old_health = var_d082c739;
            var_d082c739 += int(var_d082c739 * zombie_utility::get_zombie_var(#"zombie_health_increase_multiplier"));
            if (var_d082c739 < old_health) {
                var_d082c739 = old_health;
                break;
            }
            continue;
        }
        var_d082c739 = int(var_d082c739 + zombie_utility::get_zombie_var(#"zombie_health_increase"));
    }
    return var_d082c739;
}

detour zm_powerups<scripts\zm_common\zm_powerups.gsc>::powerup_setup(powerup_override, powerup_team, powerup_location, powerup_player, shouldplaysound = 1, var_a6d11a96) {
	if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @zm_powerups<scripts\zm_common\zm_powerups.gsc>::powerup_setup ]](powerup_override, powerup_team, powerup_location, powerup_player, shouldplaysound, var_a6d11a96);

    powerup = undefined;
    if (!isdefined(powerup_override)) {
        powerup = [[ @zm_powerups<scripts\zm_common\zm_powerups.gsc>::get_valid_powerup ]]();
    } else {
        powerup = powerup_override;
        if ("tesla" == powerup && [[ @zm_powerups<scripts\zm_common\zm_powerups.gsc>::tesla_powerup_active ]]()) {
            powerup = "minigun";
        }
    }
    struct = level.zombie_powerups[powerup];
    if (isdefined(powerup_team)) {
        self.powerup_team = powerup_team;
    }
    if (isdefined(powerup_location)) {
        self.powerup_location = powerup_location;
    }
    if (isdefined(powerup_player)) {
        self.powerup_player = powerup_player;
    } else {
        //assert(!(isdefined(struct.player_specific) && struct.player_specific), "<dev string:x8d>");
    }
    self.powerup_name = struct.powerup_name;
    self.hint = struct.hint;
    self.only_affects_grabber = struct.only_affects_grabber;
    self.any_team = struct.any_team;
    self.zombie_grabbable = struct.zombie_grabbable;
    self.func_should_drop_with_regular_powerups = struct.func_should_drop_with_regular_powerups;
    if (isdefined(level._custom_powerups) && isdefined(level._custom_powerups[powerup]) && isdefined(level._custom_powerups[powerup].setup_powerup)) {
        self [[ level._custom_powerups[powerup].setup_powerup ]]();
    } else {
        self [[ @zm_powerups<scripts\zm_common\zm_powerups.gsc>::function_76678c8d ]](powerup_location, struct.model_name, var_a6d11a96);
    }
    if (powerup == "full_ammo") {
        level.zm_genesis_robot_pay_towardsreactswordstart = randomintrange(zombie_utility::get_zombie_var(#"hash_4d2cc817490bcca"), zombie_utility::get_zombie_var(#"hash_4edd68174a79580"));
    } else if (!isdefined(powerup_override)) {
        level.zm_genesis_robot_pay_towardsreactswordstart--;
    }
    demo::bookmark(#"zm_powerup_dropped", gettime(), undefined, undefined, 1);
    potm::bookmark(#"zm_powerup_dropped", gettime(), undefined, undefined, 1);
    if (isdefined(struct.fx)) {
        self.fx = struct.fx;
    }
    if (isdefined(struct.can_pick_up_in_last_stand)) {
        self.can_pick_up_in_last_stand = struct.can_pick_up_in_last_stand;
    }
    var_b9dc5e9 = isdefined(struct.var_184f74ef) ? struct.var_184f74ef : 0;
    if (!var_b9dc5e9) {
        if (isdefined(level.var_bec5bf67)) {
            var_b9dc5e9 = self [[ level.var_bec5bf67 ]](self.powerup_name);
        }
    }
    if (!(isdefined(var_b9dc5e9) && var_b9dc5e9)) {
		if (powerup == "wolf_bonus_ammo" || powerup == "wolf_bonus_points")
		{
			// nothing
		}
		else
		{
			if ((powerup == "bonus_points_player" || powerup == "bonus_points_player_shared") && zm_utility::is_standard()) {
				self playsound(#"hash_1229e9d60b3181ef");
				self playloopsound(#"hash_46b9bf1ae523021c");
			} else {
				self playsound(#"zmb_spawn_powerup");
				self playloopsound(#"zmb_spawn_powerup_loop");
			}
		}
    }
    level.active_powerups[level.active_powerups.size] = self;
    self thread [[ @zm_powerups<scripts\zm_common\zm_powerups.gsc>::function_14b7208c ]](powerup, powerup_team, powerup_location, powerup_player);
}

detour zm_powerups<scripts\zm_common\zm_powerups.gsc>::function_d5b6ce91() {
	if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return self [[ @zm_powerups<scripts\zm_common\zm_powerups.gsc>::function_d5b6ce91 ]]();

	if (self.powerup_name == "wolf_bonus_ammo" || self.powerup_name == "wolf_bonus_points")
		return 5;
    if (self.only_affects_grabber) {
        return 2;
    }
    if (self.any_team) {
        return 4;
    }
    if (self.zombie_grabbable) {
        return 3;
    }
	
    return 1;
}

detour zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::player_give_reward(e_trig) 
{
	if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::player_give_reward ]](e_trig);
	
    self endon(#"disconnect");
    self notify(#"hash_6e1565b413e5e0f4");
    self.challenge_struct [[ @zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::function_c6d050e9 ]](1);
    e_trig setinvisibletoall();
    var_aa4f9213 = level.var_5d1e28ac[self.challenge_struct.var_860b8f1e];
    switch (var_aa4f9213) {
    case #"self_revive":
        self zm_laststand::function_3a00302e();
        self clientfield::set("force_challenge_model", 0);
        break;
    case #"free_perk":
        if (isdefined(self.challenge_struct.var_62fef0f1)) {
            self flag::set(#"hash_5a74f9da0718c63d");
            if (!self zm_perks::function_80cb4982()) {
                self zm_perks::function_a7ae070c(self.challenge_struct.var_62fef0f1);
            }
        }
        break;
    case #"hero_weapon_power":
		level thread zm_powerups::specific_powerup_drop(#"custom_random_specialists", self.origin, undefined, undefined, undefined, undefined, 1, 1);
		break;
    case #"bonus_points_player":
    case #"full_ammo":
    case #"insta_kill":
    case #"double_points":
        level thread zm_powerups::specific_powerup_drop(var_aa4f9213, self.origin, undefined, undefined, undefined, undefined, 1, 1);
        break;
    case #"tr_midburst_t8":
    case #"pistol_standard_t8_upgraded":
    case #"lmg_spray_t8_upgraded":
    case #"ar_mg1909_t8":
    case #"lmg_standard_t8":
        if (isdefined(self.challenge_struct.mdl_reward.str_weapon_name)) {
            w_reward = getweapon(self.challenge_struct.mdl_reward.str_weapon_name);
        }
        self thread [[ @zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::swap_weapon ]](w_reward);
        break;
    }
    self [[ @zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::function_fd8a137e ]]();
    self flag::set(#"hash_6534297bbe7e180d");
    foreach (var_6bf81b9d in self.challenge_struct [[ @zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::function_876f93aa ]]()) {
        var_6bf81b9d flag::set(#"hash_6534297bbe7e180d");
    }
    self flag::clear(#"flag_player_initialized_reward");
    self.var_3e49c037 = undefined;
    self.challenge_struct.var_860b8f1e++;
    self thread [[ @zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::function_e2e90905 ]]();
}

detour zm_red_pap_quest<scripts\zm\zm_red_pap_quest.gsc>::function_c20c157a(str_loc)
{
	if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @zm_red_pap_quest<scripts\zm\zm_red_pap_quest.gsc>::function_c20c157a ]](str_loc);

	if (str_loc == "serpent_pass") {
        str_flag = #"hash_67695ee69c57c0b2";
    } else {
        str_flag = #"hash_61de3b8fe6f6a35";
    }
    level endon(str_flag);
    self endon(#"death");
    self val::set("cage_lock", "takedamage", 1);
    self.health = 99999;
    self thread [[ @zm_red_pap_quest<scripts\zm\zm_red_pap_quest.gsc>::function_8be22ba8 ]](str_flag);
    self thread [[ @zm_red_pap_quest<scripts\zm\zm_red_pap_quest.gsc>::function_ffabd9dd ]](str_flag);
    while (true) {
        s_notify = self waittill(#"damage");
        if (isdefined(s_notify.weapon) /*&& s_notify.weapon.isheroweapon === 1*/) {
            level notify(#"hash_4fb1eb2c137a7955", {#e_player:s_notify.attacker});
            if (str_flag == #"hash_61de3b8fe6f6a35") {
                level flag::set(#"defend_cage");
                s_notify.attacker thread zm_vo::function_a2bd5a0c(#"hash_172d8c7cc7123557", 0, 1, 9999, 1);
            } else {
                s_notify.attacker thread zm_vo::function_a2bd5a0c(#"hash_7d5dcd4efa48be79", 0, 1, 9999, 1);
            }
            level flag::set(str_flag);
        }
    }
}

detour zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_965e1613()
{
	if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_965e1613 ]]();

	level endon(#"end_game");

    var_d3dd963d = struct::get_array(#"hash_4617b99d3d90b7fc");
    s_skull = array::random(var_d3dd963d);
    var_7b9ef77a = getent("mdl_fertilizer_component_2", "targetname");

    if (!isdefined(s_skull.radius)) {
        s_skull.radius = 160;
    }
	
    var_7b9ef77a.origin = s_skull.origin;
    var_7b9ef77a.angles = s_skull.angles;
    var_7b9ef77a show();

    /#
        if (getdvarint(#"zm_debug_ee", 0)) {
            level thread function_8bcc049f(s_skull);
        }
    #/

    while (true) {
        player = arraygetclosest(var_7b9ef77a.origin, level.players);

        if (isDefined(player) && zombie_utility::is_player_valid(player) 
			&& distance(player.origin, s_skull.origin) < s_skull.radius 
			&& player util::is_looking_at(var_7b9ef77a) && player meleebuttonpressed()) {
            if (isdefined(s_skull.target)) {
                var_c038b69d = struct::get(s_skull.target);
                var_7b9ef77a playsound(#"hash_67ab50b44ebf94a7");
                var_7b9ef77a moveto(var_c038b69d.origin, 0.5);
                var_7b9ef77a rotateto(var_c038b69d.angles, 0.5);
                var_7b9ef77a waittill(#"movedone");
                var_7b9ef77a playsound(#"hash_f210344da062582");
            }
            e_player = var_7b9ef77a zm_unitrigger::function_fac87205("", 96, 1);
            if (isdefined(e_player)) {
                e_player playsound(#"hash_1c2e8e92fd97011f");
                e_player thread zm_vo::function_a2bd5a0c(#"hash_44a710040a5cf058", 0, 0, 9999, 1);
            }
            break;
        }

		wait 0.1;
    }

    level notify(#"hash_3da6bb0f657559c0");
    level.var_5cb7d214.var_952cc98d++;
    var_7b9ef77a delete();
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_9774bbc6 ]]();
}

detour red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_2858e671(var_c34665fc, e_boss) 
{
    if (GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return damage_logic_ae(var_c34665fc, e_boss);

	if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_2858e671 ]](var_c34665fc, e_boss);
	
    level endon(#"hash_4d25b32acbac5117", #"hash_7646638df88a3656");
    self endon(#"death");
    while (true) {
        s_waitresult = self waittill(var_c34665fc);
        self.health = 100000;
        if (var_c34665fc == #"damage") {
            e_attacker = s_waitresult.attacker;
            w_weapon = s_waitresult.weapon;
        } else if (var_c34665fc == #"hero_weapon_hit") {
            e_attacker = s_waitresult.player;
            w_weapon = s_waitresult.var_80e17549;
        }
        if (/*zm_loadout::is_hero_weapon(w_weapon)*/ true) {
			if (w_weapon == getweapon(#"launcher_standard_t8_upgraded"))
            	n_damage = randomIntRange(0, 850) + randomIntRange(0, 850);
			else
				n_damage = randomIntRange(0, 75) + randomIntRange(0, 75);
        } else {
            continue;
        }
        if (isdefined(n_damage) && n_damage > 0) {
            level.s_boss_battle.var_5dc26e42 += n_damage;
            if (level.s_boss_battle.n_stage == 1) {
                if (level.s_boss_battle.var_5dc26e42 >= level.s_boss_battle.var_7fc7f236 / 2) {
                    level flag::set(#"hash_15ba89b2357ff618");
                }
                var_391b5374 = level.s_boss_battle.var_7fc7f236;
            } else if (level.s_boss_battle.n_stage == 3) {
                var_391b5374 = level.s_boss_battle.var_407b6d64;
            }
            /#
                iprintlnbold("<dev string:x4d8>" + level.s_boss_battle.var_5dc26e42 + "<dev string:x4e9>" + var_391b5374);
            #/
            if (level.s_boss_battle.var_5dc26e42 >= var_391b5374) {
                level flag::set(#"hash_6dab61ca45a8eaea");
            }
            if (isdefined(e_attacker) && isplayer(e_attacker)) {
                self [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_4c17036d ]](e_attacker, 1);
            }
        }
    }
}

detour zm_powerups<scripts\zm_common\zm_powerups.gsc>::should_award_stat(powerup_name)
{
	if(!GetDvarInt(#"shield_enh_ClassicMode", 0) && !GetDvarInt(#"shield_enh_TeamCranked", 0))
		return [[ @zm_powerups<scripts\zm_common\zm_powerups.gsc>::should_award_stat ]](powerup_name);

	switch (powerup_name) {
    case #"blue_monkey":
    case #"bonus_points_player_shared":
    case #"teller_withdrawl":
    case #"wolf_bonus_hero_power":
    case #"wolf_bonus_ammo":
    case #"wolf_bonus_points":
	case #"custom_random_specialists":
    case #"custom_pizza":
        return false;
    }
	
    if (isdefined(level.zombie_statless_powerups) && isdefined(level.zombie_statless_powerups[powerup_name]) && level.zombie_statless_powerups[powerup_name]) {
        return false;
    }

    return true;
}

detour zm_bgb_reign_drops<scripts\zm_common\bgbs\zm_bgb_reign_drops.gsc>::activation()
{
	self endon(#"disconnect", #"bled_out");

    // cranked
    if(GetDvarInt(#"shield_enh_TeamCranked", 0))
		level thread bgb::function_c6cd71d5("custom_pizza", self [[ @zm_bgb_reign_drops<scripts\zm_common\bgbs\zm_bgb_reign_drops.gsc>::function_dfc73f65 ]](99), 96);
    
	// repalce hero with ours, cause its disabled (position 1)
	if(GetDvarInt(#"shield_enh_ClassicMode", 0))
		level thread bgb::function_c6cd71d5("custom_random_specialists", self [[ @zm_bgb_reign_drops<scripts\zm_common\bgbs\zm_bgb_reign_drops.gsc>::function_dfc73f65 ]](1), 96);
    else if (zm_custom::function_3ac936c6("zm_bgb_power_keg")) {
        level thread bgb::function_c6cd71d5("hero_weapon_power", self [[ @zm_bgb_reign_drops<scripts\zm_common\bgbs\zm_bgb_reign_drops.gsc>::function_dfc73f65 ]](1), 96);
    }
    if (zm_custom::function_3ac936c6("zm_bgb_extra_credit") || GetDvarInt(#"shield_enh_ClassicMode", 0)) {
        self thread [[ @zm_bgb_extra_credit<scripts\zm_common\bgbs\zm_bgb_extra_credit.gsc>::function_22f934e6 ]](self [[ @zm_bgb_reign_drops<scripts\zm_common\bgbs\zm_bgb_reign_drops.gsc>::function_dfc73f65 ]](2), 96);
    }
    if (zm_custom::function_3ac936c6("zm_bgb_dead_of_nuclear_winter") || GetDvarInt(#"shield_enh_ClassicMode", 0)) {
        level thread bgb::function_c6cd71d5("nuke", self [[ @zm_bgb_reign_drops<scripts\zm_common\bgbs\zm_bgb_reign_drops.gsc>::function_dfc73f65 ]](3), 96);
    }
    if (zm_custom::function_3ac936c6("zm_bgb_licensed_contractor") || GetDvarInt(#"shield_enh_ClassicMode", 0)) {
        level thread bgb::function_c6cd71d5("carpenter", self [[ @zm_bgb_reign_drops<scripts\zm_common\bgbs\zm_bgb_reign_drops.gsc>::function_dfc73f65 ]](4), 96);
    }
    if ((zm_custom::function_3ac936c6("zm_bgb_on_the_house") && zm_custom::function_901b751c(#"zmperksactive")) || GetDvarInt(#"shield_enh_ClassicMode", 0)) {
        level thread bgb::function_c6cd71d5("free_perk", self [[ @zm_bgb_reign_drops<scripts\zm_common\bgbs\zm_bgb_reign_drops.gsc>::function_dfc73f65 ]](5), 96);
    }
    if (zm_custom::function_3ac936c6("zm_bgb_immolation_liquidation") || GetDvarInt(#"shield_enh_ClassicMode", 0)) {
        level thread bgb::function_c6cd71d5("fire_sale", self [[ @zm_bgb_reign_drops<scripts\zm_common\bgbs\zm_bgb_reign_drops.gsc>::function_dfc73f65 ]](6), 96);
    }
    if (zm_custom::function_3ac936c6("zm_bgb_kill_joy") || GetDvarInt(#"shield_enh_ClassicMode", 0)) {
        level thread bgb::function_c6cd71d5("insta_kill", self [[ @zm_bgb_reign_drops<scripts\zm_common\bgbs\zm_bgb_reign_drops.gsc>::function_dfc73f65 ]](7), 96);
    }
    if (zm_custom::function_3ac936c6("zm_bgb_cache_back") || GetDvarInt(#"shield_enh_ClassicMode", 0)) {
        level thread bgb::function_c6cd71d5("full_ammo", self [[ @zm_bgb_reign_drops<scripts\zm_common\bgbs\zm_bgb_reign_drops.gsc>::function_dfc73f65 ]](8), 96);
    }
    if (zm_custom::function_3ac936c6("zm_bgb_whos_keeping_score") || GetDvarInt(#"shield_enh_ClassicMode", 0)) {
        level thread bgb::function_c6cd71d5("double_points", self [[ @zm_bgb_reign_drops<scripts\zm_common\bgbs\zm_bgb_reign_drops.gsc>::function_dfc73f65 ]](9), 96);
    }
    self.var_a825ccbb = 1;
    self thread [[ @zm_bgb_reign_drops<scripts\zm_common\bgbs\zm_bgb_reign_drops.gsc>::function_7f3b4877 ]]();
}

detour zm_bgb_power_keg<scripts\zm_common\bgbs\zm_bgb_power_keg.gsc>::activation()
{
	self endon(#"disconnect", #"bled_out");

	// repalce hero with ours, cause its disabled...
	if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @zm_bgb_power_keg<scripts\zm_common\bgbs\zm_bgb_power_keg.gsc>::activation ]]();

	self thread bgb::function_c6cd71d5("custom_random_specialists", undefined, 96);
}

detour namespace_f8f28e08<script_14af1fd264ffe8cc>::function_e08e4c9c(str_bgb, var_8b84b3ce)
{
    if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @namespace_f8f28e08<script_14af1fd264ffe8cc.gsc>::function_e08e4c9c ]](str_bgb, var_8b84b3ce);
    
	//if (!zm_custom::function_901b751c(#"zmelixirsenabled")) {
    //    return;
    //}
	
	var_78e5d9d1 = level.var_d5ba7324.origin + (0, 0, -8);
    v_angles = (0, 0, 0);
    switch (str_bgb) {
    case #"zm_bgb_shields_up":
        str_model = #"p8_zm_red_powerup_free_shield";
        n_scale = 0.3;
        break;
    case #"zm_bgb_equip_mint":
    default:
        str_model = #"p8_zm_red_powerup_free_equiptment";
        n_scale = 0.45;
        break;
    }
    mdl_reward = util::spawn_model(str_model, var_78e5d9d1, v_angles);
    mdl_reward setscale(n_scale);
    mdl_reward playsound(#"hash_e3e5f7c83015171");
    mdl_reward playloopsound(#"hash_2adfa98b79668366");
    if (!isdefined(level.var_d1c9bbc4)) {
        level.var_d1c9bbc4 = [];
    } else if (!isarray(level.var_d1c9bbc4)) {
        level.var_d1c9bbc4 = array(level.var_d1c9bbc4);
    }
    level.var_d1c9bbc4[level.var_d1c9bbc4.size] = mdl_reward;
    n_power = length(mdl_reward.origin - var_8b84b3ce);
    var_cef149e8 = mdl_reward zm_utility::fake_physicslaunch(var_8b84b3ce, n_power);
    wait(var_cef149e8);
    e_player = level [[ @namespace_f8f28e08<script_14af1fd264ffe8cc.gsc>::function_c45635c7 ]](mdl_reward, 1, 1, 1);
    if (isplayer(e_player)) {
        e_player thread [[ @namespace_f8f28e08<script_14af1fd264ffe8cc.gsc>::give_bgb ]](str_bgb);
        e_player playsound(#"hash_1c696244a9a3dbbf");
    }
}

detour zm_armor<scripts\zm_common\zm_armor.gsc>::add(var_7c8fcded, var_3ed63752, var_28066539, var_df7ee5d1 = #"hash_2082da6662372184")
{
	if(!GetDvarInt(#"shield_enh_ClassicMode", 0) || var_7c8fcded == #"stronghold_armor" || var_7c8fcded == #"hash_7bfec2f0ecb46104")
	 return [[ @zm_armor<scripts\zm_common\zm_armor.gsc>::add ]](var_7c8fcded, var_3ed63752, var_28066539, var_df7ee5d1);

	// remove armor
	return;
}

detour zm_powerup_hero_weapon_power<scripts\zm\powerup\zm_powerup_hero_weapon_power.gsc>::function_7e51ac0f()
{
	if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
	 return [[ @zm_powerup_hero_weapon_power<scripts\zm\powerup\zm_powerup_hero_weapon_power.gsc>::function_7e51ac0f ]]();
	
	return false;
}

detour zm_perks<scripts\zm_common\zm_perks.gsc>::function_4d342a8f()
{
	if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
	 return [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::function_4d342a8f ]]();

	ShieldLog("^2Returned Fast Reload...");

	return;
}

detour zm_perks<scripts\zm_common\zm_perks.gsc>::function_528f82a9()
{
	if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
	 return [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::function_528f82a9 ]]();

	ShieldLog("^2Returned Stop Fast Reload...");

	return;
}

detour zm_perks<scripts\zm_common\zm_perks.gsc>::on_player_connect()
{
	if(!GetDvarInt(#"shield_enh_ClassicMode", 0) || !getDvarInt(#"shield_enh_ClassicMode_Loadouts", 1))
	 return [[ @zm_perks<scripts\zm_common\zm_perks.gsc>::on_player_connect ]]();

	ShieldLog("^2Init Perks Connect..");

	if (!isdefined(self.var_c27f1e90)) {
        self.var_c27f1e90 = [];
    } else if (!isarray(self.var_c27f1e90)) {
        self.var_c27f1e90 = array(self.var_c27f1e90);
    }
    if (!isdefined(self.var_c4193958)) {
        self.var_c4193958 = [];
    } else if (!isarray(self.var_c4193958)) {
        self.var_c4193958 = array(self.var_c4193958);
    }
    if (!isdefined(self.var_47654123)) {
        self.var_47654123 = [];
    } else if (!isarray(self.var_47654123)) {
        self.var_47654123 = array(self.var_47654123);
    }
    if (!isdefined(self.var_774e0ad7)) {
        self.var_774e0ad7 = [];
    } else if (!isarray(self.var_774e0ad7)) {
        self.var_774e0ad7 = array(self.var_774e0ad7);
    }
    if (!isdefined(self.var_cd5d9345)) {
        self.var_cd5d9345 = [];
    } else if (!isarray(self.var_cd5d9345)) {
        self.var_cd5d9345 = array(self.var_cd5d9345);
    }
    if (!isdefined(self.var_67ba1237)) {
        self.var_67ba1237 = [];
    } else if (!isarray(self.var_67ba1237)) {
        self.var_67ba1237 = array(self.var_67ba1237);
    }
    if (!isdefined(self.var_eabca645)) {
        self.var_eabca645 = [];
    } else if (!isarray(self.var_eabca645)) {
        self.var_eabca645 = array(self.var_eabca645);
    }
    if (!isdefined(self.var_466b927f)) {
        self.var_466b927f = [];
    } else if (!isarray(self.var_466b927f)) {
        self.var_466b927f = array(self.var_466b927f);
    }
    self.var_ab375b18 = 0;
    j = 0;
    for (i = 1; i <= 4; i++) {
        str_perk = GetPerkClassicMode(j);
        self.var_c27f1e90[j] = str_perk;
        self.var_47654123[j] = str_perk == #"specialty_mystery" ? 1 : 0;
        self.var_c4193958[j] = "";
        j++;
    }
}

detour zm_hero_weapon<scripts\zm_common\zm_hero_weapon.gsc>::function_9a100883(weapon_level, enabled) {
    if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
	    return [[ @zm_hero_weapon<scripts\zm_common\zm_hero_weapon.gsc>::function_9a100883 ]](weapon_level, enabled);

    self notify(#"hash_6b01968912321cc5");
    self endon(#"hash_6b01968912321cc5", #"disconnect");
    self.var_39b77a76 = 1;
    self.var_c9279111 = 0;
    self.var_821c9bf3 = 0;
    self.var_dc37311e = 0;
    while (self gadgetisactive(level.var_a53a05b5) || isdefined(self.var_fbe120be) && self.var_fbe120be || isdefined(self.var_61950f95) && self.var_61950f95) {
        wait 1;
    }
    self waittilltimeout(2, #"weapon_change_complete");
    self playsound("zmb_weapon_upgrade_to_lvl_" + weapon_level + 1);
    self zm_hero_weapon::function_45b7d6c1(weapon_level);
    //self zm_hero_weapon::hero_give_weapon(level.hero_weapon[self.var_b708af7b][weapon_level], enabled, 1);
    self.var_da2f5f0b = 0;
    /#
        self zm_challenges::debug_print("<dev string:xfe>");
    #/
    self zm_stats::increment_challenge_stat(#"special_weapon_levels");
    self.var_39b77a76 = undefined;
}

Bo3AatTypes()
{
    // stock AAT slots remapped to classic names, plus Fire Works
    return array("zm_aat_kill_o_watt", "zm_aat_plasmatic_burst", "zm_aat_brain_decay", "zm_aat_fire_works", "zm_aat_frostbite");
}

Bo3AatServerInit()
{
    // aat system may not be up yet when called from Init, so wait a bit for it
    level thread Bo3AatServerInitThread();
}

Bo3AatServerInitThread()
{
    for (i = 0; i < 300; i++)
    {
        if (isdefined(level.aat_in_use) && level.aat_in_use)
            break;
        waitframe(1);
    }

    if (!(isdefined(level.aat_in_use) && level.aat_in_use))
        return;

    if (isdefined(level.aat_initializing) && level.aat_initializing)
        aat::register("zm_aat_fire_works", 0.1, 0, 20, 10, 1, &Bo3FireWorksResult, "t7_hud_zm_aat_fireworks", "wpn_aat_blast_furnace_plr", undefined, 1);
    callback::on_finalize_initialization(&Bo3AatOverrideStock);
}

Bo3AatOverrideStock()
{
    if (!isdefined(level.aat) || !isdefined(level.aat["zm_aat_kill_o_watt"]))
        return;

    level.aat["zm_aat_kill_o_watt"].result_func = &Bo3DeadWireResult;
    level.aat["zm_aat_kill_o_watt"].percentage = 0.2;
    level.aat["zm_aat_kill_o_watt"].cooldown_time_entity = 0;
    level.aat["zm_aat_kill_o_watt"].cooldown_time_attacker = 5;
    level.aat["zm_aat_kill_o_watt"].cooldown_time_global = 2;
    level.aat["zm_aat_kill_o_watt"].occurs_on_death = 1;
    level.aat["zm_aat_kill_o_watt"].damage_feedback_sound = "wpn_aat_dead_wire_plr";
    level.aat["zm_aat_kill_o_watt"].damage_feedback_icon = "t7_hud_zm_aat_deadwire";

    level.aat["zm_aat_plasmatic_burst"].result_func = &Bo3FurnaceResult;
    level.aat["zm_aat_plasmatic_burst"].percentage = 0.15;
    level.aat["zm_aat_plasmatic_burst"].cooldown_time_entity = 0;
    level.aat["zm_aat_plasmatic_burst"].cooldown_time_attacker = 15;
    level.aat["zm_aat_plasmatic_burst"].cooldown_time_global = 0;
    level.aat["zm_aat_plasmatic_burst"].occurs_on_death = 1;
    level.aat["zm_aat_plasmatic_burst"].damage_feedback_sound = "wpn_aat_blast_furnace_plr";
    level.aat["zm_aat_plasmatic_burst"].damage_feedback_icon = "t7_hud_zm_aat_blastfurnace";

    level.aat["zm_aat_brain_decay"].result_func = &Bo3TurnedResult;
    level.aat["zm_aat_brain_decay"].percentage = 0.15;
    level.aat["zm_aat_brain_decay"].cooldown_time_entity = 0;
    level.aat["zm_aat_brain_decay"].cooldown_time_attacker = 15;
    level.aat["zm_aat_brain_decay"].cooldown_time_global = 8;
    level.aat["zm_aat_brain_decay"].occurs_on_death = 0;
    level.aat["zm_aat_brain_decay"].damage_feedback_sound = "wpn_aat_turned_plr";
    level.aat["zm_aat_brain_decay"].damage_feedback_icon = "t7_hud_zm_aat_turned";

    level.aat["zm_aat_frostbite"].result_func = &Bo3ThunderResult;
    level.aat["zm_aat_frostbite"].percentage = 0.25;
    level.aat["zm_aat_frostbite"].cooldown_time_entity = 0;
    level.aat["zm_aat_frostbite"].cooldown_time_attacker = 10;
    level.aat["zm_aat_frostbite"].cooldown_time_global = 0;
    level.aat["zm_aat_frostbite"].occurs_on_death = 1;
    level.aat["zm_aat_frostbite"].damage_feedback_sound = "wpn_aat_thunder_wall_plr";
    level.aat["zm_aat_frostbite"].damage_feedback_icon = "t7_hud_zm_aat_thunderwall";

    // Same numbers the client uses for the weapon label.
    level.aat["zm_aat_kill_o_watt"].clientfield_index = 1;
    level.aat["zm_aat_plasmatic_burst"].clientfield_index = 2;
    level.aat["zm_aat_brain_decay"].clientfield_index = 3;
    level.aat["zm_aat_frostbite"].clientfield_index = 4;
    if (isdefined(level.aat["zm_aat_fire_works"]))
    {
        level.aat["zm_aat_fire_works"].clientfield_index = 5;
        level.aat["zm_aat_fire_works"].damage_feedback_icon = "t7_hud_zm_aat_fireworks";
    }
}

Bo3DeadWireResult(death, attacker, mod, weapon)
{
    self thread Bo3AatEffect(attacker, "zm_aat_dead_wire");
}

Bo3FurnaceResult(death, attacker, mod, weapon)
{
    self thread Bo3AatEffect(attacker, "zm_aat_blast_furnace");
}

Bo3TurnedResult(death, attacker, mod, weapon)
{
    self thread Bo3AatEffect(attacker, "zm_aat_turned");
}

Bo3FireWorksResult(death, attacker, mod, weapon)
{
    self thread Bo3AatEffect(attacker, "zm_aat_fire_works");
}

Bo3ThunderResult(death, attacker, mod, weapon)
{
    self thread Bo3AatEffect(attacker, "zm_aat_thunder_wall");
}

Bo3AatLabel(type)
{
    switch (type)
    {
        case "dead_wire":
        case "zm_aat_dead_wire":
        case "zm_aat_kill_o_watt": return "^5Dead Wire";
        case "blast_furnace":
        case "zm_aat_blast_furnace":
        case "zm_aat_plasmatic_burst": return "^1Blast Furnace";
        case "turned":
        case "zm_aat_turned":
        case "zm_aat_brain_decay": return "^2Turned";
        case "fire_works":
        case "zm_aat_fire_works": return "^3Fire Works";
        case "thunder_wall":
        case "zm_aat_thunder_wall":
        case "zm_aat_frostbite": return "^4Thunder Wall";
    }
    return "";
}

AssignBo3Aat(upgraded_weapon)
{
    self endon(#"death");
    weapon = upgraded_weapon;
    if (!isdefined(weapon))
        return;
    wait 0.2;
    if (!isdefined(level.aat["zm_aat_kill_o_watt"]))
        return;

    // BO3 style: first pack is damage only; AAT rolls start on the 2nd pack
    key = zm_weapons::function_93cd8e76(weapon);
    if (!isdefined(self.bo3_pap_count))
        self.bo3_pap_count = [];
    if (!isdefined(self.bo3_pap_count[key]))
        self.bo3_pap_count[key] = 0;
    self.bo3_pap_count[key]++;
    if (self.bo3_pap_count[key] < 2)
    {
        self aat::remove(weapon);
        self clientfield::set_to_player("aat_current", 0);
        return;
    }

    types = Bo3AatTypes();
    current = self.bo3_last_aat;
    pool = [];
    foreach (name in types)
    {
        if (isdefined(current) && name == current)
            continue;
        pool[pool.size] = name;
    }
    if (pool.size == 0)
        pool = types;
    pick = pool[randomint(pool.size)];
    self.bo3_last_aat = pick;
    self aat::acquire(weapon, pick);
    self thread Bo3AatShow(weapon, pick);
}

Bo3AatShow(weapon, pick)
{
    self endon(#"death");
    if (!isdefined(level.aat[pick]) || !isdefined(level.aat[pick].clientfield_index))
        return;
    index = level.aat[pick].clientfield_index;
    packed = aat::function_702fb333(weapon);
    for (i = 0; i < 8; i++)
    {
        if (!isdefined(self))
            return;
        held = self getcurrentweapon();
        if (isdefined(held) && aat::function_702fb333(held) == packed)
            self clientfield::set_to_player("aat_current", index);
        wait 0.25;
    }
}

Bo3AatHitNotify(attacker, name)
{
    if (!isplayer(attacker))
        return;
    id = 0;
    if (name == "zm_aat_kill_o_watt" || name == "zm_aat_dead_wire")
        id = 1;
    else if (name == "zm_aat_plasmatic_burst" || name == "zm_aat_blast_furnace")
        id = 2;
    else if (name == "zm_aat_brain_decay" || name == "zm_aat_turned")
        id = 3;
    else if (name == "zm_aat_frostbite" || name == "zm_aat_thunder_wall")
        id = 4;
    else if (name == "zm_aat_fire_works")
        id = 5;
    if (id == 0)
        return;
    attacker LUINotifyEvent(#"notify_bo3_aat_hit", 1, id);
}

Bo3AatMarker(type)
{
    icon = "t7_hud_zm_aat_deadwire";
    sound = "wpn_aat_dead_wire_plr";
    switch (type)
    {
        case "blast_furnace":
            icon = "t7_hud_zm_aat_blastfurnace";
            sound = "wpn_aat_blast_furnace_plr";
            break;
        case "turned":
            icon = "t7_hud_zm_aat_turned";
            sound = "wpn_aat_turned_plr";
            break;
        case "thunder_wall":
            icon = "t7_hud_zm_aat_thunderwall";
            sound = "wpn_aat_thunder_wall_plr";
            break;
        case "fire_works":
            icon = "t7_hud_zm_aat_fireworks";
            sound = "wpn_aat_fire_works_plr";
            break;
    }
    self thread damagefeedback::update_override(icon, sound, undefined);
}

Bo3AatIsNormal(zombie)
{
    if (!isdefined(zombie) || !isalive(zombie))
        return false;
    if (isplayer(zombie))
        return false;
    if (isdefined(zombie.aat_turned) && zombie.aat_turned)
        return false;
    // keep fireworks / splash off specials that break stock AAT / gib paths
    if (isdefined(zombie.archetype) && zombie.archetype != #"zombie")
        return false;
    if (isdefined(zombie.archetype) && isdefined(level.aat[#"zm_aat_kill_o_watt"]) && isdefined(level.aat[#"zm_aat_kill_o_watt"].immune_trigger) && isdefined(level.aat[#"zm_aat_kill_o_watt"].immune_trigger[zombie.archetype]) && level.aat[#"zm_aat_kill_o_watt"].immune_trigger[zombie.archetype])
        return false;
    return true;
}

Bo3AatNearby(origin, range)
{
    found = [];
    team = level.zombie_team;
    if (!isdefined(team))
        team = #"axis";
    zombies = getaiteamarray(team);
    if (!isdefined(zombies))
        return found;

    range_sq = range * range;
    foreach (zombie in zombies)
    {
        if (!Bo3AatIsNormal(zombie))
            continue;
        if (distancesquared(origin, zombie.origin) > range_sq)
            continue;
        found[found.size] = zombie;
    }
    return found;
}

Bo3AatCanGib(zombie)
{
    // whitelist only stock zombies — specials like tigers crash gibhead
    if (!isdefined(zombie) || !isalive(zombie) || !isactor(zombie))
        return false;
    if (!isdefined(zombie.archetype) || zombie.archetype != #"zombie")
        return false;
    if (isdefined(zombie.no_gib) && zombie.no_gib)
        return false;
    if (isdefined(zombie.can_gib) && !zombie.can_gib)
        return false;
    if (!isdefined(zombie.gibdef))
        return false;
    return true;
}

Bo3AatGib(zombie, attacker)
{
    if (!isdefined(zombie) || !isalive(zombie))
        return;
    if (Bo3AatCanGib(zombie))
    {
        gibserverutils::gibhead(zombie);
        if (isdefined(zombie) && isalive(zombie))
        {
            if (math::cointoss())
                gibserverutils::gibleftarm(zombie);
            else
                gibserverutils::gibrightarm(zombie);
        }
        if (isdefined(zombie) && isalive(zombie))
            gibserverutils::giblegs(zombie);
    }
    if (isdefined(zombie) && isalive(zombie))
        zombie dodamage(zombie.health + 666, zombie.origin, attacker);
}

Bo3FurnaceBurn(attacker, weapon)
{
    self endon(#"death");
    self clientfield::set("bo3_aat_furnace_burn", 1);
    self playloopsound(#"chr_burn_npc_loop1", 0.5);
    tick = int(self.health / 6);
    if (tick < 1)
        tick = 1;
    for (i = 0; i <= 6; i++)
    {
        if (!isalive(self))
            return;
        self dodamage(tick, self.origin, attacker, undefined, "none", "MOD_UNKNOWN", 0, weapon);
        wait 0.5;
    }
    if (isalive(self))
    {
        self stoploopsound(0.5);
        self clientfield::set("bo3_aat_furnace_burn", 0);
    }
}

Bo3TurnedKilled(params)
{
    if (!isdefined(params) || !isdefined(params.eattacker))
        return;
    killer = params.eattacker;
    if (isdefined(killer.aat_turned) && killer.aat_turned && isdefined(killer.n_aat_turned_zombie_kills))
        killer.n_aat_turned_zombie_kills++;
}

Bo3AatFlingFrom(zombie, attacker, from, scale, thunder)
{
    if (!isalive(zombie))
        return;
    spot = zombie.origin;
    if (isdefined(zombie getcentroid()))
        spot = zombie getcentroid();
    zombie dodamage(zombie.health + 666, spot, attacker, attacker, "none", "MOD_AAT");
    if (isalive(zombie))
        zombie zombie_utility::setup_zombie_knockdown(from);
    if (isdefined(thunder) && thunder && isdefined(zombie))
        zombie thread Bo3AatThunderFx();
}

Bo3AatThunderFx()
{
    self clientfield::increment("bo3_aat_thunder", 1);
}

Bo3AatEffect(attacker, type)
{
    if (type == "dead_wire" || type == "zm_aat_dead_wire" || type == "zm_aat_kill_o_watt")
    {
        self clientfield::set("zm_aat_kill_o_watt_zap", 1);
        self clientfield::increment("zm_aat_kill_o_watt_explosion", 1);
        playsoundatposition(#"zmb_aat_kilowatt_explode", self.origin);
        params = lightning_chain::create_lightning_chain_params(8, 9, 120);
        params.head_gib_chance = 100;
        params.network_death_choke = 4;
        params.weapon = attacker getcurrentweapon();
        attacker.tesla_enemies = undefined;
        attacker.tesla_enemies_hit = 1;
        attacker.tesla_arc_count = 0;
        self lightning_chain::arc_damage(self, attacker, 1, params);
        return;
    }

    if (type == "blast_furnace" || type == "zm_aat_blast_furnace" || type == "zm_aat_plasmatic_burst")
    {
        weapon = attacker getcurrentweapon();
        playsoundatposition(#"wpn_aat_blast_furnace_plr", self.origin);
        self clientfield::increment("bo3_aat_furnace_blast", 1);
        self clientfield::set("bo3_aat_furnace_burn", 1);
        zombies = array::get_all_closest(self.origin, getaiteamarray(#"axis"), undefined, undefined, 120);
        burning = [];
        if (isdefined(zombies))
        {
            foreach (zombie in zombies)
            {
                if (!isalive(zombie) || zombie == self)
                    continue;
                zombie clientfield::set("bo3_aat_furnace_burn", 1);
                burning[burning.size] = zombie;
            }
        }
        waitframe(1);
        self thread Bo3AatGib(self, attacker);
        wait 0.25;
        foreach (zombie in burning)
        {
            if (isalive(zombie))
                zombie thread Bo3FurnaceBurn(attacker, weapon);
        }
        return;
    }

    if (type == "fire_works" || type == "zm_aat_fire_works")
    {
        player = attacker;
        if (!isdefined(player))
            return;
        weapon = player getcurrentweapon();
        home = self.origin;
        Bo3AatGib(self, player);
        rise = home + (0, 0, 56);
        gun = zm_utility::spawn_weapon_model(weapon, undefined, home, (0, player.angles[1], 0), player GetWeaponOptions(weapon));
        if (!isdefined(gun))
            return;
        gun.owner = player;
        gun.b_aat_fire_works_weapon = 1;
        gun moveto(rise, 0.5);
        gun waittill(#"movedone");
        for (i = 0; i < 10; i++)
        {
            if (!isdefined(gun))
                return;
            target = undefined;
            checks = 0;
            foreach (zombie in array::randomize(getaiteamarray(#"axis")))
            {
                if (!isalive(zombie) || !Bo3AatIsNormal(zombie))
                    continue;
                centroid = zombie getcentroid();
                if (!isdefined(centroid))
                    continue;
                if (distancesquared(gun.origin, centroid) > 360000)
                    continue;
                if (checks < 3 && !zombie damageconetrace(gun.origin))
                {
                    checks++;
                    continue;
                }
                target = zombie;
                break;
            }
            aim = gun.origin + anglestoforward((0, randomint(360), 0)) * 40;
            if (isdefined(target))
            {
                centroid = target getcentroid();
                if (isdefined(centroid))
                    aim = centroid;
            }
            gun.angles = vectortoangles(aim - gun.origin);
            flash = gun gettagorigin("tag_flash");
            if (!isdefined(flash))
                flash = gun.origin;
            magicbullet(weapon, flash, aim, gun);
            if (isdefined(weapon.firesoundplayer))
                player playlocalsound(weapon.firesoundplayer);
            if (isdefined(weapon.firesound))
                playsoundatposition(weapon.firesound, flash);
            if (isdefined(target) && isalive(target))
                Bo3AatGib(target, player);
            util::wait_network_frame();
        }
        if (!isdefined(gun))
            return;
        gun moveto(home, 0.5);
        gun waittill(#"movedone");
        util::wait_network_frame();
        if (isdefined(gun))
            gun delete();
        return;
    }

    if (type == "thunder_wall" || type == "zm_aat_thunder_wall" || type == "zm_aat_frostbite")
    {
        blast = self.origin;
        facing = anglestoforward(attacker getplayerangles());
        end_pos = blast + vectorscale(facing, 180);
        playsoundatposition(#"wpn_aat_thunder_wall_plr", blast);
        playsoundatposition(#"evt_nuke_flash", blast);
        zombies = array::get_all_closest(blast, getaiteamarray(#"axis"), undefined, undefined, 360);
        if (!isdefined(zombies))
            return;
        flung = 0;
        foreach (zombie in zombies)
        {
            if (!isalive(zombie))
                continue;
            spot = zombie.origin;
            dist_sq = 0;
            if (zombie != self)
            {
                spot = zombie getcentroid();
                dist_sq = distancesquared(blast, spot);
                if (vectordot(facing, vectornormalize(spot - blast)) < 0)
                    continue;
                nearest = pointonsegmentnearesttopoint(blast, end_pos, spot);
                if (distancesquared(spot, nearest) > (540 * 540))
                    continue;
            }
            if (dist_sq < (180 * 180))
            {
                Bo3AatFlingFrom(zombie, attacker, blast, 100, 1);
                flung++;
            }
            if (flung >= 6)
                break;
        }
        return;
    }

    if (type == "turned" || type == "zm_aat_turned" || type == "zm_aat_brain_decay")
    {
        self.aat_turned = 1;
        self.n_aat_turned_zombie_kills = 0;
        playsoundatposition(#"wpn_aat_turned_plr", self.origin);
        self.allowdeath = 0;
        self.allowpain = 0;
        self.no_gib = 1;
        self.team = #"allies";
        self clientfield::set("zm_aat_brain_decay", 1);
        self zombie_utility::set_zombie_run_cycle("sprint");
        self thread Bo3TurnedBlast(attacker);
        self endon(#"death");
        end_time = gettime() + 20000;
        while (gettime() < end_time && self.n_aat_turned_zombie_kills < 12)
            wait 0.05;
        wait 0.5;
        self.allowdeath = 1;
        self clientfield::set("zm_aat_brain_decay", 0);
        Bo3AatGib(self, attacker);
    }
}

Bo3TurnedBlast(attacker)
{
    zombies = array::get_all_closest(self.origin, getaiteamarray(#"axis"), undefined, undefined, 90);
    if (!isdefined(zombies))
        return;
    flung = 0;
    foreach (zombie in zombies)
    {
        if (!isalive(zombie) || zombie == self)
            continue;
        if (distancesquared(self.origin, zombie getcentroid()) > (90 * 90))
            continue;
        Bo3AatFlingFrom(zombie, attacker, self.origin, 60);
        flung++;
        if (flung >= 3)
            break;
    }
}