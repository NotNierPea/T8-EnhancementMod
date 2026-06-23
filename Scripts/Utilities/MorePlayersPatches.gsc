/#
detour globallogic_ui<scripts\zm_common\gametypes\globallogic_ui.gsc>::menuautoassign(menu)
{
    if (IsBot(self))
    {
        shieldlog("fuck off menu bot");
        return;
    }

    return [[ @globallogic_ui<scripts\zm_common\gametypes\globallogic_ui.gsc>::menuautoassign ]](menu);
}
#/

/#
detour bot<scripts\core_common\bots\bot.gsc>::on_player_connect() {
    return;
}

detour bot<scripts\core_common\bots\bot.gsc>::on_player_spawned() {
    return;
}
#/

/#
detour flag<scripts\core_common\flag_shared.gsc>::set(str_flag)
{
    ShieldLog(str_flag);

    if (str_flag !== "start_zombie_round_logic")
        return [[ @flag<scripts\core_common\flag_shared.gsc>::set ]](str_flag);

    wait 8;

    ShieldLog("^2setting start_zombie_round_logic");
    flag::set(#"start_zombie_round_logic");
}
#/

// TODO: CONFIG ERROR HERE, too many wallbuys, maybe check function_522794c2?
detour zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::function_28304f6a()
{
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::function_28304f6a ]]();

    ShieldLog("^2Entering zm_unitrigger::function_28304f6a");
    
    level flag::wait_till("start_zombie_round_logic");

    if (level._unitriggers._deferredinitlist.size) {
        for (i = 0; i < level._unitriggers._deferredinitlist.size; i++) {
            zm_unitrigger::register_static_unitrigger(level._unitriggers._deferredinitlist[i], level._unitriggers._deferredinitlist[i].trigger_func);
        }

        for (i = 0; i < level._unitriggers._deferredinitlist.size; i++) {
            level._unitriggers._deferredinitlist[i] = undefined;
        }

        level._unitriggers._deferredinitlist = undefined;
    }
}

detour zm_audio<scripts\zm_common\zm_audio.gsc>::can_speak(var_7faa9b94 = 0, var_7d84f04b = 0) {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_audio<scripts\zm_common\zm_audio.gsc>::can_speak ]](var_7faa9b94, var_7d84f04b);

    return true;
}

detour zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::function_522794c2(stub) {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::function_522794c2 ]](stub);

    //wait randomFloatRange(1.05, 3.25);

    player_num = self getentitynumber();
    player_to_use = self;

    // TODO: make triggers work with 4+ players without crashing the config strings, not sure how but try.
    if (player_num > 3) {
        //player_to_use = GetPlayers()[0];
        return;
    }

    function_ba39b142();
    if (isdefined(level.var_dc25ba05) && level.var_dc25ba05) {
        if (!isalive(player_to_use)) {
            return;
        }

        trigger = [[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::check_and_build_trigger_from_unitrigger_stub ]](stub, player_to_use);
        
        if (!isdefined(trigger)) {
            return;
        }

        trigger.parent_player = player_to_use;
        trigger.stub = stub;

        if (!isdefined(player_to_use.var_13a302d2)) {
            player_to_use.var_13a302d2 = [];
        }

        if (!isinarray(player_to_use.var_13a302d2, trigger)) {
            if (!isdefined(player_to_use.var_13a302d2)) {
                player_to_use.var_13a302d2 = [];
            } else if (!isarray(player_to_use.var_13a302d2)) {
                player_to_use.var_13a302d2 = array(player_to_use.var_13a302d2);
            }
            player_to_use.var_13a302d2[player_to_use.var_13a302d2.size] = trigger;
        }
            
        usable = [[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::assess_and_apply_visibility ]](trigger, stub, player_to_use, 1);
        trigger triggerenable(usable);
        [[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::function_71b67b2a ]](trigger);
    }
}

detour zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::function_bb454fe6()
{
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::function_bb454fe6 ]]();

    ShieldLog("^2Entering zm_unitrigger::function_bb454fe6 (from __main__)");
 
    level flag::wait_till("start_zombie_round_logic");
    valid_range = level._unitriggers.largest_radius + 15;
    valid_range_sq = valid_range * valid_range;
    while (!isdefined(level.active_zone_names)) {
        wait 0.25;
    }
    while (true) {
        if (isdefined(level.var_dc25ba05) && level.var_dc25ba05) {
            wait 2;
            continue;
        }
        waited = 0;
        active_zone_names = level.active_zone_names;
        candidate_list = [];
        for (j = 0; j < active_zone_names.size; j++) {
            if (isdefined(level.zones[active_zone_names[j]].unitrigger_stubs)) {
                candidate_list = arraycombine(candidate_list, level.zones[active_zone_names[j]].unitrigger_stubs, 1, 0);
            }
        }
        candidate_list = arraycombine(candidate_list, level._unitriggers.dynamic_stubs, 1, 0);
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!isdefined(player) || player getEntityNumber() > 3) {
                continue;
            }
            player_origin = player.origin + (0, 0, 35);
            trigger = level._unitriggers.trigger_pool[player getentitynumber()];
            old_trigger = undefined;
            closest = [];
            if (isdefined(trigger)) {
                dst = valid_range_sq;
                origin = trigger zm_unitrigger::unitrigger_origin();
                dst = trigger.stub.test_radius_sq;
                time_to_ressess = 0;
                trigger_still_valid = 0;
                if (distance2dsquared(player_origin, origin) < dst) {
                    if (isdefined(trigger.reassess_time)) {
                        trigger.reassess_time -= 0.05;
                        if (trigger.reassess_time > 0) {
                            continue;
                        }
                        time_to_ressess = 1;
                    }
                    trigger_still_valid = 1;
                }
                closest = [[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::get_closest_unitriggers ]](player_origin, candidate_list, valid_range);
                if (isdefined(trigger) && time_to_ressess && (closest.size < 2 || isdefined(trigger.thread_running) && trigger.thread_running)) {
                    if (zm_unitrigger::assess_and_apply_visibility(trigger, trigger.stub, player, 1)) {
                        continue;
                    }
                }
                if (trigger_still_valid && closest.size < 2) {
                    if (zm_unitrigger::assess_and_apply_visibility(trigger, trigger.stub, player, 1)) {
                        continue;
                    }
                }
                if (trigger_still_valid) {
                    old_trigger = trigger;
                    trigger = undefined;
                    level._unitriggers.trigger_pool[player getentitynumber()] = undefined;
                } else if (isdefined(trigger)) {
                    zm_unitrigger::cleanup_trigger(trigger, player);
                }
            } else {
                closest = [[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::get_closest_unitriggers ]](player_origin, candidate_list, valid_range);
            }
            index = 0;
            first_usable = undefined;
            first_visible = undefined;
            trigger_found = 0;
            while (index < closest.size) {
                if (!zm_utility::is_player_valid(player) && !(isdefined(closest[index].ignore_player_valid) && closest[index].ignore_player_valid)) {
                    index++;
                    continue;
                }
                if (!(isdefined(closest[index].registered) && closest[index].registered)) {
                    index++;
                    continue;
                }
                trigger = [[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::check_and_build_trigger_from_unitrigger_stub ]](closest[index], player);
                if (isdefined(trigger)) {
                    trigger.parent_player = player;
                    if (zm_unitrigger::assess_and_apply_visibility(trigger, closest[index], player, 0)) {
                        if (player zm_utility::is_player_looking_at(closest[index].origin, 0.9, 0)) {
                            if (![[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::is_same_trigger ]](old_trigger, trigger) && isdefined(old_trigger)) {
                                zm_unitrigger::cleanup_trigger(old_trigger, player);
                            }
                            level._unitriggers.trigger_pool[player getentitynumber()] = trigger;
                            trigger_found = 1;
                            break;
                        }
                        if (!isdefined(first_usable)) {
                            first_usable = index;
                        }
                    }
                    if (!isdefined(first_visible)) {
                        first_visible = index;
                    }
                    if (isdefined(trigger)) {
                        if ([[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::is_same_trigger ]](old_trigger, trigger)) {
                            level._unitriggers.trigger_pool[player getentitynumber()] = undefined;
                        } else {
                            zm_unitrigger::cleanup_trigger(trigger, player);
                        }
                    }
                    last_trigger = trigger;
                }
                index++;
                waited = 1;
                wait 1;
            }
            if (!isdefined(player)) {
                continue;
            }
            if (trigger_found) {
                continue;
            }
            if (isdefined(first_usable)) {
                index = first_usable;
            } else if (isdefined(first_visible)) {
                index = first_visible;
            }
            trigger = [[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::check_and_build_trigger_from_unitrigger_stub ]](closest[index], player);
            if (isdefined(trigger)) {
                trigger.parent_player = player;
                level._unitriggers.trigger_pool[player getentitynumber()] = trigger;
                if ([[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::is_same_trigger ]](old_trigger, trigger)) {
                    continue;
                }
                if (isdefined(old_trigger)) {
                    zm_unitrigger::cleanup_trigger(old_trigger, player);
                }
                if (isdefined(trigger)) {
                    zm_unitrigger::assess_and_apply_visibility(trigger, trigger.stub, player, 0);
                }
            }
        }

        wait 1;
    }
}
    
detour zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::function_94419264() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::function_94419264 ]]();

    //ShieldLog("^2Entering zm_unitrigger::function_94419264 with player " + self getEntityNumber());
    
    if (!isdefined(self.var_13a302d2)) {
        self.var_13a302d2 = [];
    }
    
    wait 5;

    if (isdefined(self) && isdefined(level.var_dc25ba05) && level.var_dc25ba05) {
        self thread [[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::function_358a2fc7 ]]();
    }

    while (isdefined(self)) {
        trigger = self.useholdent;
        if (isdefined(trigger)) {
            self [[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::function_71b67b2a ]](trigger);
        } else {
            self.var_13a302d2 = array::remove_undefined(self.var_13a302d2, 0);
            if (!isdefined(self.var_9de1a3d2)) {
                self.var_9de1a3d2 = 0;
            }
            if (self.var_9de1a3d2 >= self.var_13a302d2.size) {
                self.var_9de1a3d2 = 0;
            }
            if (self.var_9de1a3d2 < self.var_13a302d2.size) {
                if (isdefined(self.var_13a302d2[self.var_9de1a3d2])) {
                    self [[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::function_71b67b2a ]](self.var_13a302d2[self.var_9de1a3d2]);
                }
                self.var_9de1a3d2++;
            }
        }

        [[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::function_ba088f52 ]](trigger);
        
        wait 0.5;
    }
}

function_ba39b142() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_unitrigger<scripts\zm_common\zm_unitrigger.gsc>::function_ba39b142 ]]();
    
    if (!isdefined(level.var_9d46713)) {
        level.var_9d46713 = 0;
    }
    if (!isdefined(level.var_9bb1f3e7)) {
        level.var_9bb1f3e7 = 0;
    }
    while (level.var_9bb1f3e7 == gettime() && level.var_9d46713 >= 2) {
        wait 0.5;
    }
    if (level.var_9bb1f3e7 != gettime()) {
        level.var_9d46713 = 0;
        level.var_9bb1f3e7 = gettime();
    }
    level.var_9d46713++;
}

/#
detour zm_vo<scripts\zm_common\zm_vo.gsc>::function_fb728280()
{
    return;
}

detour zm_round_logic<scripts\zm_common\zm_round_logic.gsc>::function_d20309f1()
{
    return;
}

detour zm_powerups<scripts\zm_common\zm_powerups.gsc>::powerup_hud_monitor()
{
    return;
}

detour zm_player<scripts\zm_common\zm_player.gsc>::zm_breadcrumbs()
{
    return;
}
#/

detour zm_fasttravel<scripts\zm_common\zm_fasttravel.gsc>::function_66d020b0(var_5314bd63, nd_path_start, var_384528, str_notify, var_6c365dbf, var_12230d08, var_5817f611, var_8f1ba730 = 0, var_6e7468ee = 1) {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_fasttravel<scripts\zm_common\zm_fasttravel.gsc>::function_66d020b0 ]](var_5314bd63, nd_path_start, var_384528, str_notify, var_6c365dbf, var_12230d08, var_5817f611, var_8f1ba730, var_6e7468ee);
    
    level endon(#"end_game");
    self endoncallback(@zm_fasttravel<scripts\zm_common\zm_fasttravel.gsc>::function_79766c56, #"bled_out", #"death");
    self.var_16735873 = 1;
    self [[ @zm_fasttravel<scripts\zm_common\zm_fasttravel.gsc>::function_7a607f29 ]](var_12230d08);
    self.var_f4e33249 = 1;
    self val::set(#"fasttravel", "freezecontrols", 1);
    if (isdefined(var_12230d08)) {
        var_5817f611 = var_12230d08.script_string;
        self.var_5817f611 = var_5817f611;
        var_44c6df03 = var_12230d08.var_cafe149c;
    }
    if (!var_8f1ba730) {
        while (level.var_d03afa3[var_5817f611] === 1) {
            util::wait_network_frame();
        }
        level thread [[ @zm_fasttravel<scripts\zm_common\zm_fasttravel.gsc>::function_78e3c2ba ]](var_5817f611);
    }
    foreach (e_player in getplayers()) {
        if (e_player getEntityNumber() <= 3)
            e_player clientfield::set_player_uimodel("WorldSpaceIndicators.bleedOutModel" + e_player getentitynumber() + ".hide", 1);
    }
    if (!self laststand::player_is_in_laststand()) {
        str_stance = self getstance();
        switch (str_stance) {
        case #"crouch":
            self setstance("stand");
            wait 0.2;
            break;
        case #"prone":
            self setstance("stand");
            wait 1;
            break;
        }
    }
    if (isdefined(var_6c365dbf)) {
        if (isarray(var_6c365dbf)) {
            self util::create_streamer_hint(var_6c365dbf[0].origin, var_6c365dbf[0].angles, 1);
        } else {
            self util::create_streamer_hint(var_6c365dbf.origin, var_6c365dbf.angles, 1);
        }
    }
    self notify(#"hash_1c35eb15aa210d6", {#var_9fa6220c:var_12230d08});
    self zm_stats::increment_challenge_stat(#"fast_travels");
    self contracts::increment_zm_contract(#"contract_zm_fast_travel");
    if (!(isdefined(self.var_472e3448) && self.var_472e3448)) {
        self stopsounds();
    }
    if (!isdefined(var_12230d08) || isdefined(var_12230d08) && !(isdefined(var_12230d08.var_694cbc6f) && var_12230d08.var_694cbc6f)) {
        self ghost();
    }
    self thread [[ @zm_fasttravel<scripts\zm_common\zm_fasttravel.gsc>::function_946fc2d6 ]]();
    self clientfield::increment("fasttravel_start_fx", 1);
    if (isdefined(var_5314bd63)) {
        self thread [[ @zm_fasttravel<scripts\zm_common\zm_fasttravel.gsc>::fasttravel_spline ]](var_5314bd63, nd_path_start, var_384528);
    } else if (isdefined(var_12230d08) && var_12230d08.script_noteworthy === "flinger") {
        self thread [[ @zm_fasttravel<scripts\zm_common\zm_fasttravel.gsc>::fasttravel_flinger ]](var_6c365dbf, var_12230d08);
    } else if (isdefined(level.var_16fecec8) && level.var_16fecec8) {
        self thread [[ @zm_fasttravel<scripts\zm_common\zm_fasttravel.gsc>::function_a78584c0 ]](var_6c365dbf);
    } else {
        self thread [[ @zm_fasttravel<scripts\zm_common\zm_fasttravel.gsc>::function_62686dda ]](var_6c365dbf);
    }
    self waittill(#"fasttravel_over");
    if (isdefined(var_5314bd63)) {
        self clientfield::set("fasttravel_rail_fx", 0);
        self clientfield::set_to_player("player_chaos_light_rail_fx", 0);
        util::wait_network_frame();
        self allowcrouch(1);
        self allowprone(1);
    } else {
        self val::reset(#"fasttravel", "freezecontrols");
    }
    if (isdefined(var_44c6df03)) {
        self clientfield::increment(var_44c6df03, 1);
    } else {
        self clientfield::increment("fasttravel_end_fx", 1);
    }
    self show();
    if (isdefined(self.var_85c91ccc)) {
        level.var_f410ef3b[self.var_85c91ccc] = 0;
    }
    if (isdefined(str_notify)) {
        level notify(str_notify);
    }
    if (isdefined(var_6c365dbf)) {
        self util::clear_streamer_hint();
    }
    self.var_5817f611 = undefined;
    self notify(#"fasttravel_finished", {#var_9fa6220c:var_12230d08});
    foreach (e_player in getplayers()) {
        if (e_player getEntityNumber() <= 3)
            e_player clientfield::set_player_uimodel("WorldSpaceIndicators.bleedOutModel" + e_player getentitynumber() + ".hide", 0);
    }
    if (isdefined(var_6e7468ee) && var_6e7468ee && isdefined(level.var_34eb792d)) {
        self thread [[ level.var_34eb792d ]](self, var_12230d08);
    }
    self util::delay(0.3, undefined, &zm_audio::create_and_play_dialog, #"fast_travel", #"end");
}

detour zm_fasttravel<scripts\zm_common\zm_fasttravel.gsc>::function_d4fbc062(var_6a4c362c) {
    n_index = [[ @zm_fasttravel<scripts\zm_common\zm_fasttravel.gsc>::get_player_index ]](self);

    if (n_index > 3)
    {
        return var_6a4c362c[0];
    }

    a_e_players = getplayers();
    if (self function_60d91d03(var_6a4c362c[n_index], a_e_players)) {
        return var_6a4c362c[n_index];
    }
    foreach (var_f0bbde5 in var_6a4c362c) {
        if (var_f0bbde5 == var_6a4c362c[n_index]) {
            continue;
        }
        if (self function_60d91d03(var_f0bbde5, a_e_players)) {
            return var_f0bbde5;
        }
    }
    return var_6a4c362c[n_index];
}

function_60d91d03(var_f0bbde5, a_e_players) {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_fasttravel<scripts\zm_common\zm_fasttravel.gsc>::function_60d91d03 ]](var_f0bbde5, a_e_players);

    if (!isDefined(var_f0bbde5))
        return false;

    b_safe = 1;
    foreach (e_player in a_e_players) {
        if (isdefined(e_player.var_16735873) && e_player.var_16735873) {
            continue;
        }
        if (abs(var_f0bbde5.origin[2] - e_player.origin[2]) > 60) {
            continue;
        }
        if (distance2dsquared(var_f0bbde5.origin, e_player.origin) > 4096) {
            continue;
        }
        b_safe = 0;
        break;
    }
    return b_safe;
}

detour zombie_gegenees_util<scripts\zm_common\util\ai_gegenees_util.gsc>::function_5685dac6() {
    n_player_count = zm_utility::function_a2541519(level.players.size);
    switch (n_player_count) {
    case 1:
        return 1;
    case 2:
        return 2;
    case 3:
        return 2;
    case 4:
        return 3;

    default:
        return 3;
    }
}

detour zombie_skeleton_util<scripts\zm_common\util\ai_skeleton_util.gsc>::function_d3195b0c() {
    switch (getplayers().size) {
    case 1:
        return 3;
    case 2:
        return 5;
    case 3:
        return 7;
    case 4:
        return 10;

    default:
        return 10;
    }
}

detour potm<scripts\core_common\potm_shared.gsc>::init()
{
    ShieldLog("^5Potm initialized");

    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @potm<scripts\core_common\potm_shared.gsc>::init ]]();
    
    return;
}

detour demo<scripts\core_common\demo_shared.gsc>::add_bookmark(bookmark, overrideentitycamera) {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @demo<scripts\core_common\demo_shared.gsc>::add_bookmark ]](bookmark, overrideentitycamera);
    
    return;
}

detour demo<scripts\core_common\demo_shared.gsc>::kill_bookmark(var_81538b15, var_f28fb772, einflictor, var_50d1e41a, overrideentitycamera) {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @demo<scripts\core_common\demo_shared.gsc>::kill_bookmark ]](var_81538b15, var_f28fb772, einflictor, var_50d1e41a, overrideentitycamera);
    
    return;
}

detour demo<scripts\core_common\demo_shared.gsc>::bookmark(bookmarkname, time, var_81538b15, var_f28fb772, scoreeventpriority) {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @demo<scripts\core_common\demo_shared.gsc>::bookmark ]](bookmarkname, time, var_81538b15, var_f28fb772, scoreeventpriority);
    
    return;
}

detour demo<scripts\core_common\demo_shared.gsc>::init() {
    ShieldLog("^5Demo initialized");

    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @demo<scripts\core_common\demo_shared.gsc>::init ]]();
    
    return;
}

detour demo<scripts\core_common\demo_shared.gsc>::watch_actor_bookmarks() {
    ShieldLog("^5Demo watch_actor_bookmarks");

    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @demo<scripts\core_common\demo_shared.gsc>::watch_actor_bookmarks ]]();
    
    return;
}

boss_ix_orig(e_trig) {
    level endon(#"end_game");
    setclearanceceiling(142);
    var_801d42e6 = 0;
    b_teleported = 0;
    level.boss_entry_tower_remains = getent("boss_entry_tower_remains", "targetname");
    level.boss_entry_tower_remains hide();
    entrance_tower_collision = getent("entrance_tower_collision", "targetname");
    entrance_tower_collision disconnectpaths();
    scene::init("p8_fxanim_zm_towers_boss_arena_gate_destroy_bundle");
    var_d2fb9acc = getdvar(#"hash_3065419bcba97739", 0);
    if (!var_d2fb9acc) {
        while (!b_teleported) {
            while (!var_801d42e6) {
                e_trig waittill(#"touch");
                var_a10268d3 = getplayers();
                var_66c0821c = 0;
                foreach (e_player in var_a10268d3) {
                    if (e_player istouching(e_trig)) {
                        var_66c0821c++;
                    }
                }
                if (var_66c0821c == var_a10268d3.size) {
                    var_801d42e6 = 1;
                    continue;
                }
                var_801d42e6 = 0;
            }
            e_trig waittill(#"trigger");
            level thread zm_audio::function_bca32e49(#"m_quest", #"open_gate", undefined, 1);
            var_a10268d3 = getplayers();
            var_66c0821c = 0;
            foreach (e_player in var_a10268d3) {
                if (e_player istouching(e_trig)) {
                    var_66c0821c++;
                }
            }
            if (var_66c0821c == var_a10268d3.size) {
                b_teleported = 1;
            }
        }
    }
    e_gate = getent("arena_gate_west", "targetname");
    v_amount = vectorscale(e_gate.script_vector, 1);
    e_gate moveto(e_gate.origin + v_amount, 3);
    e_gate playsound(#"hash_1259041350e5f60d");
    wait 1;
    level scene::init("boss_battle_tempo", "targetname");
    level thread zm_utility::function_9ad5aeb1(1);
    wait 1;
    var_ff91be3a = struct::get_array("s_zm_towers_port_to_boss", "targetname");
    var_a10268d3 = getplayers();
    for (i = 0; i < var_a10268d3.size; i++) {
        var_a10268d3[i] setorigin(var_ff91be3a[i].origin);
        var_a10268d3[i] setplayerangles(var_ff91be3a[i].angles);
    }

    callback::on_spawned(@zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_d4e923e7);
    level notify(#"hash_4a06aa98c6c7b671");
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_9dad4c51 ]]();

    level thread ix_boss_fight();
}

detour zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_6378f02b(e_trig) {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
    {
        level boss_ix_orig(e_trig);
        return;
    }
    
    level endon(#"end_game");
    setclearanceceiling(142);
    var_801d42e6 = 0;
    b_teleported = 0;
    level.boss_entry_tower_remains = getent("boss_entry_tower_remains", "targetname");
    level.boss_entry_tower_remains hide();
    entrance_tower_collision = getent("entrance_tower_collision", "targetname");
    entrance_tower_collision disconnectpaths();
    scene::init("p8_fxanim_zm_towers_boss_arena_gate_destroy_bundle");
    var_d2fb9acc = getdvar(#"hash_3065419bcba97739", 0);
    if (!var_d2fb9acc) {
        while (!b_teleported) {
            while (!var_801d42e6) {
                e_trig waittill(#"touch");
                var_a10268d3 = getplayers();
                var_66c0821c = 0;
                foreach (e_player in var_a10268d3) {
                    if (e_player istouching(e_trig)) {
                        var_66c0821c++;
                    }
                }
                if (var_66c0821c == var_a10268d3.size) {
                    var_801d42e6 = 1;
                    continue;
                }
                var_801d42e6 = 0;
            }
            e_trig waittill(#"trigger");
            level thread zm_audio::function_bca32e49(#"m_quest", #"open_gate", undefined, 1);
            var_a10268d3 = getplayers();
            var_66c0821c = 0;
            foreach (e_player in var_a10268d3) {
                if (e_player istouching(e_trig)) {
                    var_66c0821c++;
                }
            }
            if (var_66c0821c == var_a10268d3.size) {
                b_teleported = 1;
            }
        }
    }
    e_gate = getent("arena_gate_west", "targetname");
    v_amount = vectorscale(e_gate.script_vector, 1);
    e_gate moveto(e_gate.origin + v_amount, 3);
    e_gate playsound(#"hash_1259041350e5f60d");
    wait 1;
    level scene::init("boss_battle_tempo", "targetname");
    level thread zm_utility::function_9ad5aeb1(1);
    
    wait 1;

    structs_orig = struct::get_array("s_zm_towers_port_to_boss", "targetname");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] dontinterpolate();
        players[i] SetRandomOrigin(structs_orig[0].origin);
        players[i] setplayerangles(structs_orig[0].angles);
    }

    callback::on_spawned(@zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_d4e923e7);
    level notify(#"hash_4a06aa98c6c7b671");
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_9dad4c51 ]]();

    level thread ix_boss_fight();
}

detour red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_3a2efd4e(b_cheated = 0, var_7982b1c8 = 1, var_8ef91a04 = 1)
{
    return function_3a2efd4e(b_cheated, var_7982b1c8, var_8ef91a04);
}

function_3a2efd4e(b_cheated = 0, var_7982b1c8 = 1, var_8ef91a04 = 1) {
    level endon(#"end_game", #"hash_7646638df88a3656");
    level flag::wait_till("zones_initialized");
    level._zombiemode_check_firesale_loc_valid_func = @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::return_false;
    array::thread_all(getplayers(), @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_a4bcce4e);
    zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_on", 0);
    level notify(#"fire_sale_off");

    callback::on_spawned(@red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::on_player_spawned);
    callback::on_connect(@red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::on_player_connect);

    if (b_cheated) {
        level flag::set("power_on");
        level flag::set(#"pap_quest_completed");
        level flag::set(#"zm_red_fasttravel_open");
        /#
            if (getdvarint(#"hash_36841a9b10fd186d", 0)) {
                var_7982b1c8 = 0;
            } else {
                level scene::init_streamer(#"aib_vign_cust_zm_red_boss_intro", #"allies");
            }
        #/
    }
    foreach (chest in level.chests) {
        chest zm_magicbox::hide_chest(0);
    }
    foreach (player in getplayers()) {
        player disableweaponfire();
    }
    
    level.musicsystemoverride = 1;
    
    [[ @zm_red_challenges<scripts\zm\zm_red_challenges.gsc>::function_304fb042 ]]();

    if (var_7982b1c8) {

        if (!getDvarInt(#"shield_enh_Hardcore_Bosses", 0))
            music::setmusicstate("boss_battle_intro_igc");

        level scene::play(#"aib_vign_cust_zm_red_boss_intro");
    }

    foreach (player in getplayers()) {
        player enableweaponfire();
    }

    level.s_boss_battle.mdl_perseus show();
    level.s_boss_battle.var_c67e8352 show();
    level.s_boss_battle.var_5e9e4c15 show();

    if (!(isdefined(level.var_27a02034) && level.var_27a02034)) {
        scene::add_scene_func("aib_vign_cust_zm_red_boss2_intro_exit", &function_21ef9bb7);
    }

    level thread scene::play("boss_intro_exit", "targetname");
    zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", 9);
    zm_round_spawning::function_376e51ef(#"skeleton");
    zm_round_spawning::function_376e51ef(#"gegenees");
    level function_3de660a0();
    level clientfield::set("" + #"hash_71f9fcfb2cd84a9c", 1);
    zm_zonemgr::enable_zone("zone_boss_plateau_1");
    zm_zonemgr::enable_zone("zone_boss_plateau_2");
    zm_zonemgr::enable_zone("zone_boss_plateau_3");
    var_9dc587a9 = struct::get_array("s_boss_arena_teleport");

    if (getDvarInt(#"shield_com_clients", 0) >= 5) {
        a_players = getplayers();
        for (i = 0; i < a_players.size; i++) {
            if (var_8ef91a04) {
                a_players[i] SetRandomOrigin(var_9dc587a9[0].origin);
                a_players[i] setplayerangles(var_9dc587a9[0].angles);
            }

            a_players[i] thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_9099e4d8 ]]();

            foreach (var_de3a312c in level.var_3958c9ff) {
                a_players[i] thread [[ @zm_red_fasttravel<scripts\zm\zm_red_fasttravel.gsc>::function_28deccf1 ]](var_de3a312c, 1);
            }

            a_players[i] thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_6401a80e ]]();
            a_players[i] thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_1722dae1 ]]();
        }
    }
    else
    {
        a_players = getplayers();
        for (i = 0; i < a_players.size; i++) {
            if (var_8ef91a04) {
                a_players[i] setorigin(var_9dc587a9[i].origin);
                a_players[i] setplayerangles(var_9dc587a9[i].angles);
            }
            a_players[i] thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_9099e4d8 ]]();
            foreach (var_de3a312c in level.var_3958c9ff) {
                a_players[i] thread [[ @zm_red_fasttravel<scripts\zm\zm_red_fasttravel.gsc>::function_28deccf1 ]](var_de3a312c, 1);
            }
            a_players[i] thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_6401a80e ]]();
            a_players[i] thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_1722dae1 ]]();
        }
    }

    level.var_6f6cc58 = @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_123b6625;
    level.var_4e4950d1 = @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_20c2dd32;

    [[ @zm_red<scripts\zm\zm_red.gsc>::function_eeb6a1e7 ]]();

    e_vo_player = array::random(util::get_active_players(#"allies"));
    if (isdefined(e_vo_player)) {
        e_vo_player thread zm_vo::function_a2bd5a0c(#"hash_607c594be89dec0e", 2);
    }

    level thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_f6306dea ]]();

    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        music::setmusicstate("boss_battle_stage_1");

    wait 3;

    level thread function_756474bf();
}

function_756474bf() {
    level endon(#"hash_7646638df88a3656");
    level flag::set("pause_round_timeout");
    callback::on_player_damage(@red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_4cd6f3d3);
    level.var_e120ae98 = @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_60d4faca;
    level.custom_spawnplayer = @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_9bc4f8cb;
    zm_bgb_anywhere_but_here::function_886fce8f(0);
    level.zombie_round_start_delay = 0;
    level.zombie_powerups[#"fire_sale"].func_should_drop_with_regular_powerups = &return_false;
    level.zombie_powerups[#"bonus_points_team"].func_should_drop_with_regular_powerups = &return_false;
    level.zombie_powerups[#"bonus_points_player"].func_should_drop_with_regular_powerups = &return_false;
    level.zombie_powerups[#"bonus_points_player_shared"].func_should_drop_with_regular_powerups = &return_false;
    if (!isdefined(level.var_d6f059f7)) {
        level.var_d6f059f7 = max(level.round_number, 25);
    }
    level.var_5d1805c4 = @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_d899c62c;
    switch (level.players.size) {
    case 1:
        var_12e5a581 = 7;
        level.s_boss_battle.var_415fc88 = 15;
        level.s_boss_battle.var_2f02900b = 1;
        level.s_boss_battle.var_b7fe5d46 = 9000;
        level.s_boss_battle.var_7fc7f236 = 12000;
        level.s_boss_battle.var_1e4f5dab = 10000;
        level.s_boss_battle.var_407b6d64 = 5000;
        break;
    case 2:
        var_12e5a581 = 10;
        level.s_boss_battle.var_415fc88 = 20;
        level.s_boss_battle.var_2f02900b = 2;
        level.s_boss_battle.var_b7fe5d46 = 12000;
        level.s_boss_battle.var_7fc7f236 = 15000;
        level.s_boss_battle.var_1e4f5dab = 12000;
        level.s_boss_battle.var_407b6d64 = 7000;
        break;
    case 3:
        var_12e5a581 = 12;
        level.s_boss_battle.var_415fc88 = 25;
        level.s_boss_battle.var_2f02900b = 3;
        level.s_boss_battle.var_b7fe5d46 = 15000;
        level.s_boss_battle.var_7fc7f236 = 10000;
        level.s_boss_battle.var_1e4f5dab = 10000;
        level.s_boss_battle.var_407b6d64 = 9000;
        break;
    case 4:
        var_12e5a581 = 15;
        level.s_boss_battle.var_415fc88 = 33;
        level.s_boss_battle.var_2f02900b = 3;
        level.s_boss_battle.var_b7fe5d46 = 18000;
        level.s_boss_battle.var_7fc7f236 = 25000;
        level.s_boss_battle.var_1e4f5dab = 15000;
        level.s_boss_battle.var_407b6d64 = 15000;
        break;

    // more players?
    default:
        var_12e5a581 = int(15 * level.players.size / 4);
        level.s_boss_battle.var_415fc88 = int(33 * level.players.size / 4);
        level.s_boss_battle.var_2f02900b = 1;
        level.s_boss_battle.var_b7fe5d46 = int(18000 * level.players.size / 4);
        level.s_boss_battle.var_7fc7f236 = int(25000 * level.players.size / 4);
        level.s_boss_battle.var_1e4f5dab = int(15000 * level.players.size / 4);
        level.s_boss_battle.var_407b6d64 = int(15000 * level.players.size / 4);
        break;
    }

    level.zombie_ai_limit = level.s_boss_battle.var_2f02900b;
    [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_8b1f9518 ]]();
    level thread function_517bbfad(level.s_boss_battle.var_2f02900b);
    while (level.s_boss_battle.var_dc656db3 == 0) {
        waitframe(1);
    }
    level flag::set(#"hash_79d95c7c3d63882d");
    zm_bgb_anywhere_but_here::function_886fce8f();
    level.zombie_ai_limit = var_12e5a581;
    level flag::wait_till(#"hash_315fae99adaebfb4");
    wait 3;
    level thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_263a0b8 ]]();
    level flag::wait_till_timeout(300, #"hash_15ba89b2357ff618");
    if (flag::get(#"pegasus_attacking")) {
        wait 3;
    }
    [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_79611ef0 ]](1);
    level flag::wait_till(#"hash_6dab61ca45a8eaea");
    level flag::wait_till_clear(#"pegasus_attacking");
    level flag::clear("spawn_zombies");
    level zm_utility::function_9ad5aeb1(0, 1, 1, 0);
    [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_54c795f6 ]]();
    level notify(#"boss_stage_1_done");
    level flag::set(#"hash_7be183aa6a4cbe7");

    level.s_boss_battle.mdl_perseus [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_c7a3202c ]]("zone_boss_plateau_2");
    level.s_boss_battle.mdl_perseus scene::play(#"aib_vign_cust_zm_red_boss1_stg2_to_stg3_01", level.s_boss_battle.var_d82d0e73);
    [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_4d844f2 ]]();
    level thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_170c8b16 ]]();
    [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_79611ef0 ]](2);
    e_vo_player = array::random(util::get_active_players(#"allies"));
    if (isdefined(e_vo_player)) {
        e_vo_player thread zm_vo::function_a2bd5a0c(#"hash_67e6464e20e49efb", 1);
    }
    [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_54c795f6 ]]();
    level.s_boss_battle.mdl_perseus [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_c7a3202c ]]("zone_boss_plateau_2");
    [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_4d844f2 ]]();
    level thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_14833fc2 ]]();
    [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_e4f860ab ]]();
    level flag::set("spawn_zombies");
    level thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_290d42b8 ]]();
    level flag::wait_till(#"hash_6dab61ca45a8eaea");
}

function_6378f02b(e_trig) {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
    {
        level boss_ix_orig(e_trig);
        return;
    }
    
    level endon(#"end_game");
    setclearanceceiling(142);
    var_801d42e6 = 0;
    b_teleported = 0;
    level.boss_entry_tower_remains = getent("boss_entry_tower_remains", "targetname");
    level.boss_entry_tower_remains hide();
    entrance_tower_collision = getent("entrance_tower_collision", "targetname");
    entrance_tower_collision disconnectpaths();
    scene::init("p8_fxanim_zm_towers_boss_arena_gate_destroy_bundle");
    var_d2fb9acc = getdvar(#"hash_3065419bcba97739", 0);
    if (!var_d2fb9acc) {
        while (!b_teleported) {
            while (!var_801d42e6) {
                e_trig waittill(#"touch");
                var_a10268d3 = getplayers();
                var_66c0821c = 0;
                foreach (e_player in var_a10268d3) {
                    if (e_player istouching(e_trig)) {
                        var_66c0821c++;
                    }
                }
                if (var_66c0821c == var_a10268d3.size) {
                    var_801d42e6 = 1;
                    continue;
                }
                var_801d42e6 = 0;
            }
            e_trig waittill(#"trigger");
            level thread zm_audio::function_bca32e49(#"m_quest", #"open_gate", undefined, 1);
            var_a10268d3 = getplayers();
            var_66c0821c = 0;
            foreach (e_player in var_a10268d3) {
                if (e_player istouching(e_trig)) {
                    var_66c0821c++;
                }
            }
            if (var_66c0821c == var_a10268d3.size) {
                b_teleported = 1;
            }
        }
    }
    e_gate = getent("arena_gate_west", "targetname");
    v_amount = vectorscale(e_gate.script_vector, 1);
    e_gate moveto(e_gate.origin + v_amount, 3);
    e_gate playsound(#"hash_1259041350e5f60d");
    wait 1;
    level scene::init("boss_battle_tempo", "targetname");
    level thread zm_utility::function_9ad5aeb1(1);
    
    wait 1;

    structs_orig = struct::get_array("s_zm_towers_port_to_boss", "targetname");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] dontinterpolate();
        players[i] SetRandomOrigin(structs_orig[0].origin);
        players[i] setplayerangles(structs_orig[0].angles);
    }

    callback::on_spawned(@zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_d4e923e7);
    level notify(#"hash_4a06aa98c6c7b671");
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_9dad4c51 ]]();

    level thread ix_boss_fight();
}

detour zm_perk_mod_widows_wine<scripts\zm\perk\zm_perk_mod_widows_wine.gsc>::widows_wine_perk_activate() {
    if(!isDefined(self.var_a33a5a37))
        self.var_a33a5a37 = 0;
    
    self.var_a33a5a37++;
}

detour zm_altbody<scripts\zm_common\zm_altbody.gsc>::trigger_watch_kiosk(name, trigger_name, trigger_hint, whenvisible) {
    ShieldLog("^trigger_watch_kiosk");
    
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_altbody<scripts\zm_common\zm_altbody.gsc>::trigger_watch_kiosk ]](name, trigger_name, trigger_hint, whenvisible);

    return;
}

detour zm_altbody<scripts\zm_common\zm_altbody.gsc>::trigger_monitor_visibility(name, whenvisible) {
    ShieldLog("^trigger_monitor_visibility");

    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_altbody<scripts\zm_common\zm_altbody.gsc>::trigger_monitor_visibility ]](name, whenvisible);

    return;
}

detour zm_stats<scripts\zm_common\zm_stats.gsc>::player_stats_init()
{
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_stats<scripts\zm_common\zm_stats.gsc>::player_stats_init ]]();
    
    if (!IsBot(self))
    {
        return [[ @zm_stats<scripts\zm_common\zm_stats.gsc>::player_stats_init ]]();
    }

    return;
}

detour zm_stats<scripts\zm_common\zm_stats.gsc>::add_client_stat(stat_name, stat_value, include_gametype)
{
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_stats<scripts\zm_common\zm_stats.gsc>::add_client_stat ]](stat_name, stat_value, include_gametype);
    
    if (!IsBot(self))
    {
        return [[ @zm_stats<scripts\zm_common\zm_stats.gsc>::add_client_stat ]](stat_name, stat_value, include_gametype);
    }

    return;
}

detour zm_stats<scripts\zm_common\zm_stats.gsc>::function_7741345e(player, w_current, n_shots_fired, n_hits)
{
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_stats<scripts\zm_common\zm_stats.gsc>::function_7741345e ]](player, w_current, n_shots_fired, n_hits);
    
    if (!IsBot(player))
    {
        return [[ @zm_stats<scripts\zm_common\zm_stats.gsc>::function_7741345e ]](player, w_current, n_shots_fired, n_hits);
    }

    return;
}

detour globallogic_score<scripts\zm_common\gametypes\globallogic_score.gsc>::getpersstat(dataname) {
    if (!isDefined(self.pers[dataname]))
    {
        if (dataname == #"score")
            return 500;
        else
            return 0;
    }
    
    return self.pers[dataname];
}

detour zm_round_logic<scripts\zm_common\zm_round_logic.gsc>::round_over() {
    if (isdefined(level.noroundnumber) && level.noroundnumber == 1) {
        return;
    }

    level flag::clear("round_active");

    time = [[ level.func_get_delay_between_rounds ]]();

    players = getplayers();
    for (player_index = 0; player_index < players.size; player_index++) {
        if (IsBot(players[player_index]))
            continue;

        if (!isdefined(players[player_index].pers[#"previous_distance_traveled"])) {
            players[player_index].pers[#"previous_distance_traveled"] = 0;
        }
        distancethisround = int(players[player_index].pers[#"distance_traveled"] - players[player_index].pers[#"previous_distance_traveled"]);
        players[player_index].pers[#"previous_distance_traveled"] = players[player_index].pers[#"distance_traveled"];
        players[player_index] incrementplayerstat("distance_traveled", distancethisround);
        if (players[player_index].pers[#"team"] != "spectator") {
            players[player_index] zm_round_logic::recordroundendstats();
        }
    }

    recordzombieroundend();

    level flag::wait_till_any_timeout(time, array("round_reset", #"trial_failed"));
}

detour zm_player<scripts\zm_common\zm_player.gsc>::player_monitor_time_played() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_player<scripts\zm_common\zm_player.gsc>::player_monitor_time_played ]]();

    if(IsBot(self))
        return;

    return [[ @zm_player<scripts\zm_common\zm_player.gsc>::player_monitor_time_played ]]();
}

detour zm_player<scripts\zm_common\zm_player.gsc>::player_monitor_travel_dist() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_player<scripts\zm_common\zm_player.gsc>::player_monitor_travel_dist ]]();
    
    self notify(#"stop_player_monitor_travel_dist");
    self endon(#"stop_player_monitor_travel_dist", #"disconnect");

    if(IsBot(self))
        return;

    n_current_distance = 0;
    prevpos = self.origin;
    
    while (isdefined(self)) {
        wait 0.1;
        if (self.var_16735873 !== 1) {
            n_distance = distance(self.origin, prevpos);
            self.pers[#"distance_traveled"] = self.pers[#"distance_traveled"] + n_distance;
            if (n_distance > 1 && int(self.pers[#"distance_traveled"]) > n_current_distance) {
                self zm_stats::function_301c4be2("boas_distanceSprinted", int(n_distance));
                n_current_distance = self.pers[#"distance_traveled"];
            }
        }
        prevpos = self.origin;
    }
}

detour zombie_dog_util<scripts\zm_common\util\ai_dog_util.gsc>::function_71e3c90d() {
    switch (level.players.size) {
    case 1:
        if (zm_utility::is_trials()) {
            return 6;
        }
        return 3;
    case 2:
        if (zm_utility::is_trials()) {
            return 10;
        }
        return 5;
    case 3:
        if (zm_utility::is_trials()) {
            return 14;
        }
        return 7;
    case 4:
        if (zm_utility::is_trials()) {
            return 20;
        }
        return 10;
    }

    // still no return? then with players
    return 5 * level.players.size;
}

detour zm_zonemgr<scripts\zm_common\zm_zonemgr.gsc>::function_d4cf2b9b(force_update = 0) {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_zonemgr<scripts\zm_common\zm_zonemgr.gsc>::function_d4cf2b9b ]](force_update);
    
    pixbeginevent(#"hash_62bff2437ffcdbcd");
    if (getdvarint(#"zm_zone_pathing", 1)) {
        if (force_update) {
            level.zone_paths = [];
        }
        players = getplayers();
        active_players = [];
        zone_paths = [];
        foreach (player in getplayers()) {
            if (player.sessionstate !== "spectator") {
                active_players[active_players.size] = player;
            }
        }
        foreach (player in active_players) {
            ent_number = player getentitynumber();

            if (ent_number > 4)
                break;

            var_c6bd50df = player zm_zonemgr::get_player_zone();
            if (!isdefined(var_c6bd50df)) {
                continue;
            }
            if (isdefined(level.zone_paths[ent_number]) && isdefined(level.zone_paths[ent_number][var_c6bd50df])) {
                if (level.zone_paths[ent_number][var_c6bd50df].cost == 0) {
                    zone_paths[ent_number] = level.zone_paths[ent_number];
                    continue;
                }
            }
            zone = level.zones[var_c6bd50df];
            var_23ca4e6e = [];
            zone_info = spawnstruct();
            zone_info.cost = 0;
            var_23ca4e6e[zone.name] = zone_info;
            var_51c813e9 = 0;
            zone_queue = [];
            zone_queue[zone_queue.size] = zone.name;
            while (zone_queue.size > var_51c813e9) {
                zone = level.zones[zone_queue[var_51c813e9]];
                if (isdefined(zone.var_d68ef0f9) && zone.var_d68ef0f9) {
                    var_51c813e9++;
                    continue;
                }
                zone_info = var_23ca4e6e[zone.name];
                foreach (var_4a52ff35, adjacent_zone in zone.adjacent_zones) {
                    if (isdefined(var_23ca4e6e[var_4a52ff35]) || isdefined(level.zones[var_4a52ff35].var_d68ef0f9) && level.zones[var_4a52ff35].var_d68ef0f9) {
                        continue;
                    }
                    if (adjacent_zone.is_connected) {
                        var_658cf985 = spawnstruct();
                        var_658cf985.to_zone = zone.name;
                        var_658cf985.cost = zone_info.cost + 1;
                        var_23ca4e6e[var_4a52ff35] = var_658cf985;
                        zone_queue[zone_queue.size] = var_4a52ff35;
                    }
                }
                var_51c813e9++;
            }
            zone_paths[ent_number] = var_23ca4e6e;
        }
        level.zone_paths = zone_paths;
    }
    pixendevent();
}

detour zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::function_ea1042c6(var_986431d3, var_394c506d) {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::function_ea1042c6 ]](var_986431d3, var_394c506d);

    var_986431d3.challenge_struct = struct::get(var_986431d3.target);
    var_394c506d sethintstring(#"hash_685d7c68f4c511a7");
    while (true) {
        s_info = var_986431d3 waittill(#"trigger");
        e_player = s_info.activator;
        if (isplayer(e_player)) {
            break;
        }
    }
    e_player.challenge_struct = var_986431d3.challenge_struct;
    e_player.challenge_struct.var_25276720 = e_player;
    e_player.challenge_struct.var_4931480f = getent(var_986431d3.challenge_struct.target, "targetname");
    e_player.challenge_struct.var_4931480f flag::init(#"hash_19856658ee6e4f3a");
    var_394c506d setinvisibletoall();
    foreach (player in getplayers()) {
        if (IsBot(player))
            continue;
        
        if (player != e_player) {
            var_394c506d setvisibletoplayer(player);
            var_394c506d sethintstringforplayer(player, #"hash_1705b54e6528bc52");
            var_394c506d.var_da61c116 = 1;
            e_player.challenge_struct.var_4931480f setinvisibletoplayer(player);
            continue;
        }
        var_394c506d setvisibletoplayer(e_player);
        var_394c506d sethintstringforplayer(e_player, #"hash_4af8c1464e537f6");
        var_986431d3 setinvisibletoall();
        var_986431d3.var_da61c116 = 1;
    }
    var_284d45c2 = getentarray("t_challenge_cleat_hint_trig", "script_noteworthy");
    foreach (trig in var_284d45c2) {
        if (trig != var_394c506d) {
            trig sethintstringforplayer(e_player, #"hash_3e2be45acfa798cd");
        }
    }
    foreach (var_682f5a89 in level.var_38935e23) {
        if (var_682f5a89 != e_player.challenge_struct.var_4931480f) {
            var_682f5a89 setinvisibletoplayer(e_player, 1);
            continue;
        }
        var_682f5a89 setinvisibletoall();
        var_682f5a89 setvisibletoplayer(e_player);
        var_682f5a89.var_da61c116 = 1;
    }
    e_player thread [[ @zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::function_67ffec1d ]]();
    var_6eaa1749 = getentarray("t_zm_towers_cleat_damage_trig", "script_noteworthy");
    foreach (var_ed4ae98 in var_6eaa1749) {
        var_ed4ae98 setinvisibletoplayer(e_player, 1);
    }
    e_player.challenge_struct.var_4931480f function_1583001a(e_player, var_986431d3);
    var_20e5c3e2 = var_986431d3.target + "_banner";
    e_banner = getent(var_20e5c3e2, "targetname");
    str_color = [[ @zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::function_7e61f202 ]](e_banner);
    e_banner scene::play("p8_fxanim_zm_towers_banner_achievement_" + str_color + "_bundle");
}

function_1583001a(e_player, var_986431d3) {
    e_player endon(#"disconnect");
    e_player flag::init(#"hash_5a74f9da0718c63d");
    e_player flag::init(#"flag_player_completed_all_challenges");
    e_trig = self;
    e_trig flag::set(#"hash_19856658ee6e4f3a");
    e_trig.banner = getent(e_trig.target, "targetname");
    e_trig.banner.var_d412a3e6 = getent(e_trig.banner.target, "targetname");
    var_986431d3.challenge_struct.e_trig = e_trig;
    e_trig.challenge_struct = var_986431d3.challenge_struct;
    switch (e_trig.challenge_struct.targetname) {
    case #"odin_brazier":
        level clientfield::set("brazier_fire_blue", 1);
        var_38e7a8be = #"hash_78c79ed7fe5a14e6";
        break;
    case #"zeus_brazier":
        level clientfield::set("brazier_fire_purple", 1);
        var_38e7a8be = #"hash_2865f19fb8f73873";
        break;
    case #"ra_brazier":
        level clientfield::set("brazier_fire_red", 1);
        var_38e7a8be = #"hash_260c83bb9470b";
        break;
    case #"danu_brazier":
        level clientfield::set("brazier_fire_green", 1);
        var_38e7a8be = #"hash_7ff858c269b8be00";
        break;
    }
    level thread zm_audio::sndannouncerplayvox(var_38e7a8be);
    var_986431d3.challenge_struct thread [[ @zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::function_702ac990 ]](e_player, e_trig);
    wait 0.1;
    foreach (player in getplayers()) {
        if (IsBot(player))
            continue;

        if (player != e_player) {
            if (player flag::exists(#"flag_player_completed_all_challenges") && player flag::get(#"flag_player_completed_all_challenges")) {
                player [[ @zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::function_11e35de5 ]](e_trig);
                continue;
            }
            e_trig.banner.var_d412a3e6 setinvisibletoplayer(player);
        }
    }
}

detour zm_laststand<scripts\zm_common\zm_laststand.gsc>::laststand_bleedout(delay) {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_laststand<scripts\zm_common\zm_laststand.gsc>::laststand_bleedout ]](delay);
    
    self endon(#"player_revived", #"zombified", #"disconnect", #"instakill_player");
    level endon(#"end_game", #"round_reset");
    if (level flag::get("round_reset")) {
        return;
    }
    self thread zm_perks::function_b4c0e0ee(delay);
    if (isdefined(level.var_5b7d2700) && level.var_5b7d2700) {
        return;
    }
    if (isdefined(self.is_zombie) && self.is_zombie || isdefined(self.var_39c78617) && self.var_39c78617) {
        self notify(#"bled_out");
        globallogic_player::function_b2873ebe();
        level notify(#"player_bled_out", {#player:self});
        self callback::callback(#"on_player_bleedout");
        util::wait_network_frame();
        self zm_laststand::bleed_out();
        return;
    }
    self clientfield::set("zmbLastStand", 1);
    self.bleedout_time = delay;
    n_default_bleedout_time = getdvarfloat(#"player_laststandbleedouttime", 0);
    level.var_ff482f76 zm_laststand_client::open(self, 0);
    level.var_ff482f76 zm_laststand_client::set_num_downs(self, self.n_downs);
    level.var_ff482f76 zm_laststand_client::set_revive_progress(self, 0);
    while (self.bleedout_time > 0) {
        self.bleedout_time -= 1;

        if (self getentitynumber() < 4)
            level clientfield::set("laststand_update" + self getentitynumber(), self.bleedout_time / delay);
        
        level.var_ff482f76 zm_laststand_client::set_bleedout_progress(self, self.bleedout_time / delay);
        wait 1;
    }
    while (self.var_16735873 === 1) {
        wait 0.1;
    }
    while (isdefined(self.revivetrigger) && isdefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived) {
        wait 0.1;
    }
    self notify(#"bled_out");
    globallogic_player::function_b2873ebe();
    level notify(#"player_bled_out", {#player:self});
    self callback::callback(#"on_player_bleedout");
    self.var_ea7ea155 = 1;
    util::wait_network_frame();
    level.var_ff482f76 zm_laststand_client::close(self);
    level.var_1c957023 self_revive_visuals::close(self);
    self zm_laststand::bleed_out();
}

// bot's interactions
detour plannercommanderutility<scripts\core_common\ai\planner_commander_utility.gsc>::function_86c0732e(planner, constants) {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @plannercommanderutility<scripts\core_common\ai\planner_commander_utility.gsc>::function_86c0732e ]](planner, constants);
    
    if (math::cointoss(35)) {
        //ShieldLog("returned actual planner shit..");
        return [[ @plannercommanderutility<scripts\core_common\ai\planner_commander_utility.gsc>::function_86c0732e ]](planner, constants);
    }

    //return;
}

/#
detour plannercommanderutility<scripts\core_common\ai\planner_commander_utility.gsc>::strategysquadcreateofsizexparam(planner, constants) {
    return undefined;
}
#/

/#
detour bot<scripts\core_common\bots\bot.gsc>::function_678e7c0(bundlename) {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @bot<scripts\core_common\bots\bot.gsc>::function_678e7c0 ]](bundlename);

   if (math::cointoss(15)) {
        return [[ @bot<scripts\core_common\bots\bot.gsc>::function_678e7c0 ]](bundlename);
    }

    return false;
}
#/

GetRealPlayers()
{
    players = [];

    foreach(player in GetPlayers())
    {
        if (!IsBot(player))
            players[players.size] = player;
    }

    return players;
}

detour zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_b2901ae4() {
    ShieldLog("^3zodt8_sentinel::function_b2901ae4");

    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_b2901ae4 ]]();

    level flag::wait_till("all_players_spawned");
    level flag::wait_till(#"initial_blackscreen_passed");

    wait 5;
    
    a_s_telegraphs = struct::get_array(#"s_telegraph");
    foreach (s_telegraph in a_s_telegraphs) {
        s_telegraph flag::init(s_telegraph.script_flag);
        s_telegraph zm_unitrigger::create(undefined, (64, 64, 72), @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_a025a65e, 1);
        zm_unitrigger::function_89380dda(s_telegraph.s_unitrigger, 1);
        s_telegraph thread [[ @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_c76f5e7f ]]();
    }
    var_a1a864c9 = getentarray("mdl_short", "targetname");
    var_b64616b0 = getentarray("mdl_long", "targetname");

    foreach (var_e54375bf in var_a1a864c9) {
        var_e54375bf.original_angles = var_e54375bf.angles;
        var_e54375bf rotateroll(-350, 0.1);
    }

    foreach (var_52330a61 in var_b64616b0) {
        var_52330a61.original_angles = var_52330a61.angles;
        var_52330a61 rotateroll(-240, 0.1);
    }

    wait 5;
    hidemiscmodels("bridge_controls");
}

detour zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_28effa18() {
    ShieldLog("^2zodt8_eye::function_28effa18");

    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_28effa18 ]]();
    
    level flag::wait_till("all_players_spawned");
    level flag::wait_till(#"initial_blackscreen_passed");

    wait 7;
    
    [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_901c5ffe ]]("eng", 0);
    [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_901c5ffe ]]("st", 0);
    [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_901c5ffe ]]("pro", 0);
    [[ @zodt8_eye<scripts\zm\zm_zodt8_eye.gsc>::function_901c5ffe ]]("pd", 0);
}

detour zm_stats<scripts\zm_common\zm_stats.gsc>::initializematchstats() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_stats<scripts\zm_common\zm_stats.gsc>::initializematchstats ]]();

    if (IsBot(self) || self getentitynumber() >= 4)
        return;

    return [[ @zm_stats<scripts\zm_common\zm_stats.gsc>::initializematchstats ]]();
}

detour zodt8_achievements<scripts\zm\zm_zodt8_achievements.gsc>::function_79182658() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zodt8_achievements<scripts\zm\zm_zodt8_achievements.gsc>::function_79182658 ]]();

    if (IsBot(self))
        return;

    return [[ @zodt8_achievements<scripts\zm\zm_zodt8_achievements.gsc>::function_79182658 ]]();
}

detour zodt8_achievements<scripts\zm\zm_zodt8_achievements.gsc>::on_player_connect() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zodt8_achievements<scripts\zm\zm_zodt8_achievements.gsc>::on_player_connect ]]();
    
    if (IsBot(self))
        return;

    return [[ @zodt8_achievements<scripts\zm\zm_zodt8_achievements.gsc>::on_player_connect ]]();
}

detour zm_zodt8<scripts\zm\zm_zodt8.gsc>::function_96c0d840() {
    return;
}

detour zm_zodt8<scripts\zm\zm_zodt8.gsc>::function_dc8b6da() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_zodt8<scripts\zm\zm_zodt8.gsc>::function_dc8b6da ]]();
    
    if (IsBot(self))
        return;

    return [[ @zm_zodt8<scripts\zm\zm_zodt8.gsc>::function_dc8b6da ]]();
}

detour zm_zodt8<scripts\zm\zm_zodt8.gsc>::on_player_spawned() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_zodt8<scripts\zm\zm_zodt8.gsc>::on_player_spawned ]]();

    if (IsBot(self))
        return;

    return [[ @zm_zodt8<scripts\zm\zm_zodt8.gsc>::on_player_spawned ]]();
}

detour zm_zodt8<scripts\zm\zm_zodt8.gsc>::function_a987d50f() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_zodt8<scripts\zm\zm_zodt8.gsc>::function_a987d50f ]]();
    
    level endon(#"end_game");
    var_40d9ad40 = 0;
    var_3f2d17a4 = 0;
    var_69083fb0 = array("zone_grand_stairs_b_deck", "zone_grand_stairs_c_deck", "zone_grand_stairs_d_deck", "zone_dining_hall_fore", "zone_dining_hall_aft", "zone_galley");
    var_58686f84 = getent("moonlight_on_volume", "targetname");
    while (true) {
        var_40d9ad40 = 0;
        for (i = 0; i < level.players.size && !var_40d9ad40; i++) {
            e_player = level.players[i];

            if (IsBot(e_player))
                continue;

            if (isinarray(var_69083fb0, e_player.zone_name)) {
                var_40d9ad40 = 1;
                break;
            }
            if (e_player.zone_name === "zone_promenade_deck" && e_player istouching(var_58686f84)) {
                var_40d9ad40 = 1;
                break;
            }
        }
        if (var_3f2d17a4) {
            if (!var_40d9ad40) {
                exploder::exploder("exp_lgt_fakemoon_c_deck");
                var_3f2d17a4 = 0;
            }
        } else if (var_40d9ad40) {
            exploder::stop_exploder("exp_lgt_fakemoon_c_deck");
            var_3f2d17a4 = 1;
        }
        wait 0.25;
    }
}

detour zm_towers_achievements<scripts\zm\zm_towers_achievements.gsc>::init() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_towers_achievements<scripts\zm\zm_towers_achievements.gsc>::init ]]();
    
    level flag::init(#"hash_6efaa75e1959aa0f");

    callback::on_connect(&function_131495a5);
    callback::on_connect(&function_6fdb733f);
    callback::on_ai_killed(@zm_towers_achievements<scripts\zm\zm_towers_achievements.gsc>::function_7b7ba154);
    callback::on_ai_killed(@zm_towers_achievements<scripts\zm\zm_towers_achievements.gsc>::function_3cbde7f5);
    callback::on_ai_killed(@zm_towers_achievements<scripts\zm\zm_towers_achievements.gsc>::function_b43c1bad);

    level.gib_on_damage = @zm_towers_achievements<scripts\zm\zm_towers_achievements.gsc>::function_cda4b8ba;

    level thread [[ @zm_towers_achievements<scripts\zm\zm_towers_achievements.gsc>::function_a87d82d1 ]]();
    level thread [[ @zm_towers_achievements<scripts\zm\zm_towers_achievements.gsc>::function_cbdb5e70 ]]();

    level flag::wait_till("all_players_spawned");
    
    array::thread_all(GetRealPlayers(), @zm_towers_achievements<scripts\zm\zm_towers_achievements.gsc>::function_131495a5);
    array::thread_all(GetRealPlayers(), @zm_towers_achievements<scripts\zm\zm_towers_achievements.gsc>::function_6fdb733f);
    array::thread_all(GetRealPlayers(), @zm_towers_achievements<scripts\zm\zm_towers_achievements.gsc>::function_45057dc4);
}

function_131495a5() {
    if (IsBot(self))
        return;
    
    self notify("558820cf64d9ca3f");
    self endon("558820cf64d9ca3f");
    level endon(#"end_game");
    self endon(#"disconnect");
    while (true) {
        s_waitresult = self waittill(#"weapon_change");
        w_weapon = s_waitresult.weapon;
        if ([[ @zm_weap_crossbow<scripts\zm\weapons\zm_weap_crossbow.gsc>::is_crossbow_upgraded ]](w_weapon)) {
            break;
        }
    }

    self zm_utility::giveachievement_wrapper("zm_towers_get_ww");
}

function_6fdb733f() {
    if (IsBot(self))
        return;

    self notify("72218f31e92393e3");
    self endon("72218f31e92393e3");
    level endon(#"door_opened", #"end_game", #"hash_6efaa75e1959aa0f");
    self endon(#"death");
    if (level.round_number > 1 || level flag::get(#"hash_6efaa75e1959aa0f")) {
        return;
    }
    while (true) {
        level waittill(#"end_of_round");
        if (level.round_number >= 20) {
            break;
        }
    }

    self zm_utility::giveachievement_wrapper("zm_towers_arena_survive");
}

detour zm_red_achievement<scripts\zm\zm_red_achievement.gsc>::function_3aed7ccf()
{
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_red_achievement<scripts\zm\zm_red_achievement.gsc>::function_3aed7ccf ]]();

    if (!IsBot(self))
        return [[ @zm_red_achievement<scripts\zm\zm_red_achievement.gsc>::function_3aed7ccf ]]();

    // no for bots
    return;
}

detour zm_utility<scripts\zm_common\zm_utility.gsc>::track_players_intersection_tracker() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_utility<scripts\zm_common\zm_utility.gsc>::track_players_intersection_tracker ]]();

    return;
}

detour zm_ai_faller<scripts\zm_common\zm_ai_faller.gsc>::zombie_faller_delete() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_ai_faller<scripts\zm_common\zm_ai_faller.gsc>::zombie_faller_delete ]]();
    
    level.zombie_total++;
    self zombie_utility::reset_attack_spot();
    if (isdefined(self.zombie_faller_location)) {
        self.zombie_faller_location.is_enabled = 1;
        self.zombie_faller_location = undefined;
    }

    self dodamage(self.health + 666, self.origin);
}

detour zm_laststand<scripts\zm_common\zm_laststand.gsc>::revive_trigger_spawn() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_laststand<scripts\zm_common\zm_laststand.gsc>::revive_trigger_spawn ]]();
    
    if (isdefined(level.var_28bbd30a) && level.var_28bbd30a) {
        return;
    }

    if (isdefined(self.revivetrigger))
	{
		self.revivetrigger delete();
	}

    radius = getdvarint(#"revive_trigger_radius", 75);
    self.revivetrigger = spawn("trigger_radius", (0, 0, 0), 0, radius, radius);
    self.revivetrigger sethintstring("");
    self.revivetrigger setcursorhint("HINT_NOICON");
    self.revivetrigger setmovingplatformenabled(1);
    self.revivetrigger enablelinkto();
    self.revivetrigger.origin = self.origin;
    self.revivetrigger linkto(self);
    self.revivetrigger setinvisibletoplayer(self);
    self.revivetrigger.beingrevived = 0;
    self.revivetrigger.createtime = gettime();


    self thread zm_laststand::revive_trigger_think();
}

detour zm_stats<scripts\zm_common\zm_stats.gsc>::update_global_counters_on_match_end() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_stats<scripts\zm_common\zm_stats.gsc>::update_global_counters_on_match_end ]]();

    return;
}

detour util<scripts\core_common\util_shared.gsc>::get_players(team = #"any") {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @util<scripts\core_common\util_shared.gsc>::get_players ]](team);

    team = undefined;
    return level.players;
}

detour hud_message<scripts\core_common\hud_message_shared.gsc>::init()
{
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @hud_message<scripts\core_common\hud_message_shared.gsc>::init ]]();

    shieldlog("returned hud_message init");
    return;
}

detour hud_message<scripts\core_common\hud_message_shared.gsc>::on_player_connect()
{
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @hud_message<scripts\core_common\hud_message_shared.gsc>::on_player_connect ]]();

    shieldlog("returned hud_message on_player_connect");
    return;
}

detour bot_action<scripts\core_common\bots\bot_action.gsc>::execution_loop() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @bot_action<scripts\core_common\bots\bot_action.gsc>::execution_loop ]]();

    self endon(#"hash_5b4f399c08222e2", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
    level endon(#"game_ended");

    while (self bot::initialized()) {
        actionparams = undefined;
        actionparams = self bot_action::function_9e181b0f();
        if (isdefined(self.bot.var_211ab18e) && !self.bot.var_211ab18e) {
            self bot_position::start();
        }
        if (!isdefined(actionparams)) {
            return;
        }
        [[ @bot_action<scripts\core_common\bots\bot_action.gsc>::function_e7b123e8 ]](actionparams);
        self bot::function_ffbfd83b();
    }
}

/#
detour plannersquad<scripts\core_common\ai\planner_squad.gsc>::_updateplanner(squad) {
    ShieldLog("returned plannersquad squad update planner");
    return;
}

detour plannercommander<scripts\core_common\ai\planner_commander.gsc>::_updateplanner(commander) {
    ShieldLog("returned plannercommander squad update planner");
    return;
}
#/

detour bot<scripts\core_common\bots\bot.gsc>::update_loop() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @bot<scripts\core_common\bots\bot.gsc>::update_loop ]]();

    self endon(#"death", #"bled_out");
    level endon(#"game_ended");
    
    if (isdefined(level.var_fa5cacde) && level.var_fa5cacde) {
        waitframe(1);
        self bottakemanualcontrol();
        return;
    }

    self bot_action::start();
    self bot_position::start();
    self bot_stance::start();

    while (isdefined(self.bot)) {
        self bot::function_ec403901();
        self bot::function_23c46f6e();
        self bot::function_92b0ec6b();

        if (!self isplayinganimscripted() && !self arecontrolsfrozen() && !self function_5972c3cf() && !self isinvehicle() && isdefined(self.sessionstate) && self.sessionstate == "playing") {
            self bot_action::update();
            self thread bot_position::update(self.bot.tacbundle);
            self bot_stance::update(self.bot.tacbundle);
            self bot::update_swim();
        } else {
            self bot_action::reset();
            self bot_position::reset();
            self bot_stance::reset();
            if (self bot::function_dd750ead()) {
                gameobject = undefined;
                gameobject = self bot::get_interact();
                if (isdefined(gameobject.inuse) && gameobject.inuse && isdefined(gameobject.trigger) && self.claimtrigger === gameobject.trigger) {
                    self bottapbutton(3);
                }
            }
        }
        
        // reviving needs a waitframe
        if (isDefined(self.bot.revivetarget))
        {
            //ShieldLog("bot is reviving, adding waitframe");
            waitframe(1);
        }
        else
            wait randomFloatRange(0.15, 0.25);

        //waitframe(1);
    }
}

detour zm_bot<scripts\zm_common\bots\zm_bot.gsc>::function_69745ea0() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_bot<scripts\zm_common\bots\zm_bot.gsc>::function_69745ea0 ]]();

    self endon(#"death", #"disconnect");
    self notify(#"hash_6b46933396f9db04");
    self endon(#"hash_6b46933396f9db04");
    while (isdefined(self)) {
        if (isbot(self)) {
            maxsightdist = undefined;
            allenemies = undefined;
            visibleenemy = undefined;

            maxsightdist = sqrt(self.maxsightdistsqrd);
            allenemies = self getenemiesinradius(self.origin, maxsightdist);
            allenemies = arraysortclosest(allenemies, self.origin);
            visibleenemy = allenemies[0];
            foreach (enemy in allenemies) {
                if (self cansee(enemy, 2500)) {
                    visibleenemy = enemy;
                    break;
                }
            }
            if (isdefined(visibleenemy) && isdefined(self.favoriteenemy) && self cansee(self.favoriteenemy, 2500)) {
                if (distance(self.origin, visibleenemy.origin) < distance(self.origin, self.favoriteenemy.origin) * 0.9) {
                    self.favoriteenemy = visibleenemy;
                }
            } else {
                self.favoriteenemy = visibleenemy;
            }
        }

        wait randomFloatRange(0.25, 0.50);
    }
}

// closest target function
detour zm_utility<scripts\zm_common\zm_utility.gsc>::function_c52e1749(origin, players) {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_utility<scripts\zm_common\zm_utility.gsc>::function_c52e1749 ]](origin, players);

    // strip the players array and make it 4
    stripped_players = [];
    for (i = 0; i < 4 && i < players.size; i++) {
        stripped_players[i] = players[i];
    }
    
    return [[ @zm_utility<scripts\zm_common\zm_utility.gsc>::function_c52e1749 ]](origin, stripped_players);
}

detour namespace_df88241c<script_174ebb9642933bf7>::function_59257d57() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @namespace_df88241c<script_174ebb9642933bf7.gsc>::function_59257d57 ]]();

    players_to_use = 4;

    if (level flag::exists("nova_crawlers_round") && level flag::get("nova_crawlers_round")) {
        return level.zombie_ai_limit;
    }
    if (zm_utility::is_trials()) {
        return (level.var_f4f794bf[players_to_use - 1] * 2);
    }
    return level.var_f4f794bf[players_to_use - 1];
}

detour zm_characters<scripts\zm_common\zm_characters.gsc>::function_b04c6f1f() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_characters<scripts\zm_common\zm_characters.gsc>::function_b04c6f1f ]]();

    if (!isdefined(level.var_6f14e9e1)) {
        level.var_6f14e9e1 = [];
    }
    arrayremovevalue(level.var_6f14e9e1, undefined, 0);
    var_8e495b9e = zm_characters::get_characters();
    foreach (player in level.var_6f14e9e1) {
        if (isdefined(player.characterindex)) {
            var_7d1b4e26 = zm_characters::function_d35e4c92(player.characterindex);
            //arrayremoveindex(var_8e495b9e, var_7d1b4e26, 1);
        }
    }
    if (var_8e495b9e.size > 0) {
        var_2d9ca68d = array::random(var_8e495b9e);
        n_character_index = array::random(var_2d9ca68d);
        return n_character_index;
    }
    return level.validcharacters[0];
}

detour zm_round_logic<scripts\zm_common\zm_round_logic.gsc>::get_zombie_spawn_delay(n_round) {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_round_logic<scripts\zm_common\zm_round_logic.gsc>::get_zombie_spawn_delay ]](n_round);
        
    if (n_round > 60) {
        n_round = 60;
    }
    n_player_count = zm_utility::function_a2541519(level.players.size);
    switch (n_player_count) {
    case 1:
        n_delay = zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5");
        break;
    case 2:
        n_delay = zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5") * 0.75;
        break;
    case 3:
        n_delay = zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5") * 0.445;
        break;
    case 4:
        n_delay = zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5") * 0.335;
        break;
    }

    if (n_player_count >= 4)
    {
        n_delay = zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5") * 0.335;
    }

    for (i = 1; i < n_round; i++) {
        n_delay *= 0.95;
        if (n_delay <= 0.1) {
            n_delay = 0.1;
            break;
        }
    }
    return n_delay;
}

detour zm<scripts\zm_common\zm.gsc>::player_too_many_players_check() {
    return;
}

detour zm_score<scripts\zm_common\zm_score.gsc>::score_cf_increment_info(name, var_ce49f2dd = 0) {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_score<scripts\zm_common\zm_score.gsc>::score_cf_increment_info ]](name, var_ce49f2dd);
    
    if (self.entity_num >= 4)
        return;

    if (!var_ce49f2dd && self bgb::function_69b88b5()) {
        clientfield::increment_world_uimodel("PlayerList.client" + self.entity_num + ".score_cf_" + name);
    }
}

detour zm_powerups<scripts\zm_common\zm_powerups.gsc>::function_2ff352cc() {
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return [[ @zm_powerups<scripts\zm_common\zm_powerups.gsc>::function_2ff352cc ]]();
    
    a_e_players = getplayers();
    if (!isdefined(a_e_players) || !a_e_players.size) {
        n_players = 1;
    } else {
        n_players = a_e_players.size;
    }

    // patch
    if (n_players >= 4)
        n_players = 4;

    n_kill_count = randomintrangeinclusive(zombie_utility::get_zombie_var(#"hash_434b3261c607850" + n_players), zombie_utility::get_zombie_var(#"zombie_powerup_drop_max_" + n_players));
    if (zm_custom::function_901b751c(#"zmpowerupfrequency") == 0) {
        n_kill_count *= 2;
    } else if (zm_custom::function_901b751c(#"zmpowerupfrequency") == 2) {
        n_kill_count = floor(n_kill_count / 2);
    }
    if (zm_trial_no_powerups::is_active()) {
        n_kill_count /= zm_trial_no_powerups::function_2fc5f13();
    }
    if (n_kill_count < 1) {
        n_kill_count = 1;
    }
    return n_kill_count;
}

MorePlayersPatches()
{
    if (GetDvarInt(#"shield_com_clients", 0) <= 4)
        return;

    SetGametypeSetting(#"allowplayofthematch", 0);
    game.potm_enabled = false;

    ShieldLog("^1More Players Init");

    callback::on_spawned(&achiv_many_players);

    //callback::on_spawned(&bots_stronger);

    callback::on_disconnect(&on_player_disconnect);
}

bots_stronger()
{
    self endon(#"death", #"disconnect");
    
    if (isbot(self))
    {
        self endon(#"death", #"disconnect");
        
        while (true) {
            if (self util::is_spectating()) {
                self zm_player::spectator_respawn_player();
                wait 1;
            }

            self.maxhealth = 400;
            self.health = 400;

            wait randomFloatRange(3, 8);
        }
    }
}

achiv_many_players()
{
    SetGametypeSetting(#"allowplayofthematch", 0);
    game.potm_enabled = false;

    if (isbot(self) || isDefined(level.IsUsingDebugLUI))
        return;

    self endon(#"death", #"disconnect");
    
    while (true) {
        active_players = undefined;
        players = undefined;

        wait 10;

        players = getplayers();
        active_players = [];
        foreach (player in getplayers()) {
            if (player.sessionstate !== "spectator") {
                active_players[active_players.size] = player;
            }
        }

        if (active_players.size >= 5 && zm_round_logic::get_round_number() >= 20) {
            self LUINotifyEvent(#"enh_achv_manager", 2, 10, true);
            break;
        }
    }
}

on_player_disconnect()
{
    if (isdefined(self.revivetrigger))
	{
		self.revivetrigger delete();
	}
}