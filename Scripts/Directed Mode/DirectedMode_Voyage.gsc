detour namespace_4a807bff<script_7893277eec698972>::function_3ef485b1(t_trig) {
    if(!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return [[ @namespace_4a807bff<script_7893277eec698972.gsc>::function_3ef485b1 ]](t_trig);
    
    level endon(#"end_game");
    t_trig endon(#"hash_cf18f85af2935e8");

    // our logic
    if (t_trig.str_drop == #"concentrated_decay" && isdefined(level.ping_gas_drops) && level.ping_gas_drops)
    {
        fake_model = util::spawn_model(#"tag_origin", t_trig.origin, t_trig.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"trigger", t_trig, #"death");
    }

    waitresult = t_trig waittill(#"trigger");

    if (t_trig.str_drop == #"concentrated_decay" && isdefined(level.ping_gas_drops) && level.ping_gas_drops)
    {
        level.posion_objective_active = true;
        fake_model delete();
    }

    e_player = waitresult.activator;
    switch (t_trig.str_drop) {
    case #"concentrated_decay":
        [[ @namespace_4a807bff<script_7893277eec698972.gsc>::function_ca37502d ]](e_player);
        break;
    case #"concentrated_plasma":
        [[ @namespace_4a807bff<script_7893277eec698972.gsc>::function_1b182e8c ]](e_player);
        break;
    case #"concentrated_purity":
        [[ @namespace_4a807bff<script_7893277eec698972.gsc>::function_b9b7b8c ]](e_player);
        break;
    case #"concentrated_radiance":
        [[ @namespace_4a807bff<script_7893277eec698972.gsc>::function_b3695700 ]](e_player);
        break;
    }
    level.var_ab242e52--;
    t_trig notify(#"picked_up");
    t_trig.var_abf1e2f7 delete();
    t_trig delete();
}

detour namespace_4a807bff<script_7893277eec698972>::function_e00eae6(e_player) {
    if(!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return [[ @namespace_4a807bff<script_7893277eec698972.gsc>::function_e00eae6 ]](e_player);

    var_9102824b = e_player [[ @namespace_4a807bff<script_7893277eec698972.gsc>::function_8f59b576 ]]();
    if (isdefined(var_9102824b)) {
        e_player takeweapon(var_9102824b);
        switch (e_player.var_b6ddf07f) {
        case #"decay":
            level notify(#"kraken_earth_upgraded");
            var_be9badbc = #"ww_tricannon_earth_t8";
            var_73d97896 = 2;
            break;
        case #"plasma":
            var_be9badbc = #"ww_tricannon_fire_t8";
            var_73d97896 = 3;
            break;
        case #"purity":
            var_be9badbc = #"ww_tricannon_water_t8";
            var_73d97896 = 1;
            break;
        case #"radiance":
            var_be9badbc = #"ww_tricannon_air_t8";
            var_73d97896 = 4;
            break;
        default:
            //assert(0, "<dev string:x78>");
            var_be9badbc = #"ww_tricannon_t8";
            break;
        }
        if ([[ @namespace_4a807bff<script_7893277eec698972.gsc>::function_81d8403b ]](var_9102824b)) {
            var_be9badbc += "_upgraded";
        }
        w_weapon = getweapon(var_be9badbc);
        e_player giveweapon(w_weapon);
        e_player [[ @namespace_4a807bff<script_7893277eec698972.gsc>::function_58269323 ]]();
        if (!isdefined(e_player.var_b01de37)) {
            e_player.var_b01de37 = [];
        } else if (!isarray(e_player.var_b01de37)) {
            e_player.var_b01de37 = array(e_player.var_b01de37);
        }
        e_player.var_b01de37[w_weapon] = var_73d97896;
    }
}

detour zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_9b60ef24() {
    if(!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return [[ @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_9b60ef24 ]]();

    if (!isdefined(level.pipes_shot))
        level.pipes_shot = 0;

    while (!isdefined(level.ping_pipes))
        util::wait_network_frame();
    
    wait 1;
    trigger = spawn("trigger_damage", self.origin, 0, 12, 24);
    
    fake_model = util::spawn_model(#"tag_origin", self.origin, self.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", trigger, #"death");
    w_earth = getweapon(#"ww_tricannon_earth_t8");
    var_15b49ebc = getweapon(#"ww_tricannon_earth_t8_upgraded");
    while (true) {
        s_result = trigger waittill(#"trigger");
        if (isdefined(s_result.activator) && isplayer(s_result.activator)) {
            w_weapon = s_result.activator getcurrentweapon();
            if (w_weapon == w_earth || w_weapon == var_15b49ebc) {
                self notify(#"hash_6ad372c0b5c6245a");
                self clientfield::set("" + #"pipe_fx", 2);
                s_result.activator util::show_hit_marker(1);
                trigger delete();
                fake_model delete();
                level.var_b67e1da6 = s_result.activator;
                level.pipes_shot++;
                level thread Directed_UpdateObjective(level.pipes_shot);

                if (level.pipes_shot == struct::get_array(#"hash_bf15c9f5060cda0").size) // 9
                {
                    level notify(#"pipes_completed");
                }
                return;
            }
        }
    }
}

detour zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_7711ae4b(a_glyphs, mdl_light) {
    if(!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return [[ @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_7711ae4b ]](a_glyphs, mdl_light);
    
    level endon(#"hash_77f76266b597a1f7");
    for (i = 0; i < a_glyphs.size; i++) {
        str_planet_name = a_glyphs[i].targetname;
        level flag::init(str_planet_name + "_done");
        level.next_planet_waiting = str_planet_name;
        level flag::wait_till(str_planet_name + "_done");
        level thread [[ @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_50b3a576 ]](str_planet_name, i + 1);
        level flag::delete(str_planet_name + "_done");
        level notify(#"planet_shot");
    }
    level.planets_completed = true;
    level flag::set(#"hash_1a742576c41a0ab9");
    level thread [[ @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_996d1a4c ]](a_glyphs, mdl_light);
    waitframe(1);
    level notify(#"hash_e9d5238dbce48ca");
}

detour zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_647da52c(str_planet_name) {
    if(!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return [[ @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_647da52c ]](str_planet_name);

    level endon(#"hash_77f76266b597a1f7", str_planet_name + "_pickup");
    n_interval = 10;
    n_current_time = 0;
    if (getplayers().size > 1) {
        n_time = 80;
    } else {
        n_time = 100;
    }
    while (n_current_time < n_time) {
        if (!isdefined(level.var_e830f656)) {
            level.var_e830f656 = str_planet_name;
        }
        wait n_interval;
        n_current_time += n_interval;
        n_interval = max(1, n_interval * 0.666);
        if (level.var_e830f656 === str_planet_name) {
            playsoundatposition(#"hash_1e42da88156af69f", (0, 0, 0));
        }
    }
    level flag::set(#"hash_77f76266b597a1f7");
}

detour zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_cfd304b3() {
    if(!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return [[ @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_cfd304b3 ]]();

    level endon(#"hash_349bc60cedc7491e");
    level.frozen_step_started = true;
    n_round = zm_round_logic::get_round_number();
    a_players = util::get_active_players();
    n_players = a_players.size;
    foreach (player in a_players) {
        player clientfield::set("bs_player_ice_br_cf", 1);
    }
    switch (n_players) {
    case 1:
        n_time = 180;
        break;
    case 2:
        n_time = 160;
        break;
    case 3:
        n_time = 135;
        break;
    case 4:
        n_time = 120;
        break;
    }
    n_increment = n_time / 9;
    var_398f5909 = n_time;
    level Directed_SetObjective(27);
    level Directed_UpdateObjective(int(var_398f5909));
    while (var_398f5909 > 0) {
        streamermodelhint(#"hash_55657a69ddb2f287" + "dmg_01", n_increment);
        streamermodelhint(#"hash_55657a69ddb2f287" + "dmg_02", n_increment);
        streamermodelhint(#"hash_55657a69ddb2f287" + "dmg_03", n_increment);
        if (var_398f5909 < n_increment) {
            wait var_398f5909;
        } else {
            wait n_increment;
        }
        foreach (player in a_players) {
            if (isdefined(player)) {
                player clientfield::increment_to_player("" + #"hash_7a927551ca199a1c", 1);
            }
        }

        var_398f5909 -= n_increment;
        level Directed_UpdateObjective(int(var_398f5909));
    }
    level notify(#"frozen_timeout");
    foreach (player in a_players) {
        if (isdefined(player)) {
            player clientfield::increment_to_player("" + #"hash_7a927551ca199a1c", 1);
            player clientfield::set_to_player("" + #"camera_snow", 0);
            player clientfield::set("bs_player_ice_br_cf", 0);
        }
    }
    level thread [[ @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_5473a2b3 ]](n_round);
    [[ @zodt8_sentinel<scripts\zm\zm_zodt8_sentinel_trial.gsc>::function_964dd361 ]]();
    level flag::set("spawn_zombies");
    level flag::set("zombie_drop_powerups");
    level flag::clear(#"disable_fast_travel");
    level flag::clear(#"pause_round_timeout");
    level.var_11f7a9af = undefined;
    level clientfield::set("fasttravel_exploder", 1);
}

directed_mark_pap_loc()
{
    fake_model = util::spawn_model(#"tag_origin", self.origin, self.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", self, #"stop_directed_pap");
    
    while (!(isdefined(self.b_used) && self.b_used))
    {
        util::wait_network_frame(1);
    }

    self notify(#"stop_directed_pap");

    util::wait_network_frame();
    fake_model delete();

    level.paps_activated++;
    level thread Directed_UpdateObjective(level.paps_activated);
}

ShieldWatcher_Voyage()
{
    while(true)
    {
        str_result = level waittill(#"blueprint_completed");
        
        if (str_result.blueprint.name == #"zblueprint_shield_dual_wield")
            level.b_built_shield = true;
    }
}

KitWatcher_Voyage()
{
    while(true)
    {
        str_result = level waittill(#"blueprint_completed");
        
        if (str_result.blueprint.name == #"zblueprint_zod_tricannon_upgrade")
            level.b_built_kit = true;
    }
}

Directed_ChestObjectiveCounter()
{
    level waittill(#"hash_17332cf9062484a6");
    level.stop_box_counter = true;
}

directed_update_kit_objective()
{
    self waittill(#"trigger", #"death");
    level.kit_parts_collected++;
    level Directed_UpdateObjective(level.kit_parts_collected);
}

directed_update_clocks_set()
{
    level endon(#"stop_clocks_directed");

    while(true)
    {
        level.clocks_set = 0;
        a_s_telegraphs = struct::get_array(#"s_telegraph");
        foreach (s_telegraph in a_s_telegraphs) {
            clock_logic = struct::get(s_telegraph.var_46f0b81a, "script_noteworthy"); 

            if (isdefined(clock_logic) && clock_logic flag::get(clock_logic.script_flag))
            {
                level.clocks_set++;
            }
        }

        level thread Directed_UpdateObjective(level.clocks_set);
        wait 0.2;
    }
}

directed_clock_logic_mark()
{
    self endon(#"death");
    level endon(#"stop_clocks_directed");

    while(true)
    {
        clock_logic = struct::get(self.var_46f0b81a, "script_noteworthy");

        if (isdefined(clock_logic))
        {
            if (clock_logic flag::get(clock_logic.script_flag))
            {
                clock_logic.var_3501cf51 notify(#"stop_clocks_directed");
                clock_logic.has_objective = undefined;
                wait 0.25;
            }
            else if (!isdefined(clock_logic.has_objective))
            {
                clock_logic.var_3501cf51 directed_add_new_objective(#"enh_objective", 1, #"stop_clocks_directed", level, #"stop_clocks_directed", self.var_3d89d732, self.var_d0b3106f);
                clock_logic.has_objective = true;
                wait 0.25;
            }

            clock_logic.var_3501cf51 directed_update_objective(clock_logic.var_3d89d732, clock_logic.var_d0b3106f);
        }

        wait 0.25;
    }
}

directed_add_planet_symbol_objective()
{
    level endon(#"stop_planet_symbol_objective");

    while(!level flag::get(#"hash_63a102a7ae564e99"))
    {
        b_bool = false;
        while(!b_bool)
        {
            mdl_planet = getent(self.targetname, "str_object_name");
            if (isdefined(mdl_planet) && isdefined(mdl_planet.var_ddb0a5b4) && mdl_planet.var_ddb0a5b4 === 0)
            {
                level.planets_activated--;
                level thread Directed_UpdateObjective(level.planets_activated);
                b_bool = true;
            }

            if (!isdefined(mdl_planet))
            {
                b_bool = true;
            }

            util::wait_network_frame();
        }

        self.mdl_glyph thread directed_add_new_objective(#"enh_objective", 1, #"death", self.mdl_glyph, #"stop_planet_symbol_objective");

        b_bool = false;
        while(!b_bool)
        {
            mdl_planet = getent(self.targetname, "str_object_name");
            if (isdefined(mdl_planet) && isdefined(mdl_planet.var_ddb0a5b4) && mdl_planet.var_ddb0a5b4 === 1)
            {
                b_bool = true;
            }

            util::wait_network_frame();
        }

        level.planets_activated++;

        if (isdefined(self.mdl_glyph))
            self.mdl_glyph notify(#"stop_planet_symbol_objective");

        level thread Directed_UpdateObjective(level.planets_activated);

        util::wait_network_frame();
    }
}

PlanetFailWatcher()
{
    level endon(#"planet_step_completed");
    while(true)
    {
        level flag::wait_till(#"hash_77f76266b597a1f7");
        level.planet_step_failed = true;
        level notify(#"planet_failed");
        ShieldLog("failed planet step");
        level flag::wait_till_clear(#"hash_77f76266b597a1f7");
        wait 1;
    }
}

FrozenFailWatcher()
{
    level endon(#"frozen_step_completed");
    while(true)
    {
        level waittill(#"frozen_timeout");
        level.frozen_step_failed = true;
        ShieldLog("failed frozen step");
        wait 1;
    }
}

ValveWatcher()
{
    t_use_water_pump_fore = getent("t_use_water_pump_fore", "targetname");
    t_use_water_pump_fore waittill(#"trigger");

    level.water_valves_used = true;
}

VoyageDirectedMode()
{
    wait_time = 1;

    level thread ShieldWatcher_Voyage();
    level thread KitWatcher_Voyage();

    if(GetDvarInt("shield_enh_SaveGame_Load", 0))
        wait_time = 12;

    wait wait_time;

    // starting round cap
    level thread Directed_SetRoundCap(4);
    
    // Power
    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 1))
    {
        level thread Directed_SetObjective(1);

        mdl_artifact = getent("artifact_mind", "script_noteworthy");
        mdl_artifact thread directed_add_new_objective(#"enh_objective", 1, #"death", mdl_artifact, #"trigger");
        mdl_artifact waittill("death");
    }

    // PAP
    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 2))
    {
        level thread Directed_SetObjective(2);
        level thread Directed_UpdateObjective(0);
        level.paps_activated = 0;
        foreach (s_loc in level.s_pap_quest.a_s_locations) 
        {
            s_loc.unitrigger_stub thread directed_mark_pap_loc();
        }

        level flag::wait_till("pap_quest_complete");
    }
    
    // Shield
    level thread Directed_SetRoundCap(7);
    level thread Directed_SetObjective(3);
    b_built_shield = false;
    if (!b_built_shield)
    {
        level.shield_parts_collected = 0;

        // highlight parts
        a_items_array = getitemarray();
        a_items_counter = 0;
        foreach(item in a_items_array)
        {
            try_name = item.item.name;
            if ((isDefined(try_name)) && !isdefined(item.saved_picked) && (try_name != #"hash_60b473e8d0f810aa" && try_name != #"hash_60b471e8d0f80d44" && try_name != #"hash_60b472e8d0f80ef7"))
            {
                item thread directed_add_new_objective(#"enh_objective", 1, #"death", item, #"trigger");
                item thread directed_update_shield_objective();
                a_items_counter++;
            }
        }

        level.shield_parts_collected = (3 - a_items_counter);
        level Directed_UpdateObjective(level.shield_parts_collected);

        // wait for items to be picked up
        while(true)
        {
            a_items_array = getitemarray();
            b_all_picked_up = true;
            
            foreach(item in a_items_array)
            {
                try_name = item.item.name;
                if (isDefined(try_name) && !isdefined(item.saved_picked))
                {
                    if (!(try_name == #"hash_60b473e8d0f810aa" || try_name == #"hash_60b471e8d0f80d44" || try_name == #"hash_60b472e8d0f80ef7"))
                    {
                        b_all_picked_up = false;
                        break;
                    }
                }
            }

            if (b_all_picked_up)
                break;

            wait 0.5;
        }
        
        if (!isDefined(level.b_built_shield))
        {
            foreach (trigger in level.var_4fe2f84d[#"zblueprint_shield_dual_wield"]) {
                fake_model = util::spawn_model(#"tag_origin", trigger.origin, trigger.angles);
                fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", level, #"blueprint_completed");
                level waittill(#"blueprint_completed");
                util::wait_network_frame();
                fake_model delete();
            }
        }
    }

    // Wonder Weapon
    // Check if any has it
    b_any_has_kraken = false;
    foreach(player in level.players)
    {
        if (player hasWeapon(getweapon(#"ww_tricannon_t8")) || player hasWeapon(getweapon(#"ww_tricannon_earth_t8")) || player hasWeapon(getweapon(#"ww_tricannon_fire_t8")) || player hasWeapon(getweapon(#"ww_tricannon_water_t8")) || player hasWeapon(getweapon(#"ww_tricannon_air_t8")) ||
            player hasWeapon(getweapon(#"ww_tricannon_t8_upgraded")) || player hasWeapon(getweapon(#"ww_tricannon_earth_t8_upgraded")) || player hasWeapon(getweapon(#"ww_tricannon_fire_t8_upgraded")) || player hasWeapon(getweapon(#"ww_tricannon_water_t8_upgraded")) || player hasWeapon(getweapon(#"ww_tricannon_air_t8_upgraded")))
        {
            b_any_has_kraken = true;
            break;
        }
    }

    level thread Directed_SetRoundCap(10);
    
    if (!b_any_has_kraken)
    {
        level thread Directed_SetObjective(4);
            
        while(true)
        {
            ai_stoker = [[ @zm_ai_stoker<scripts\zm\ai\zm_ai_stoker.gsc>::spawn_single ]](true);
            wait 1;
            if (isdefined(ai_stoker))
            {
                ai_stoker thread directed_add_new_objective(#"enh_objective", 1, #"death", ai_stoker, #"death");
                ai_stoker waittill(#"death");

                key_spawned = true;
                counter = 0;
                while(!isdefined(level.var_86d6efbf))
                {
                    wait 1;
                    counter++;

                    if (counter > 2)
                    {
                        key_spawned = false;
                        break;
                    }
                }

                if (!key_spawned)
                    continue;

                level.var_86d6efbf thread directed_add_new_objective(#"enh_objective", 1, #"death", level.var_86d6efbf, #"death");
                level.var_86d6efbf waittill(#"death");
                break;
            }
            else
            {
                wait 1;
            }
        }

        wait 0.5;

        // all chests
        level thread Directed_SetObjective(5);
        level.var_f9f50915.mdl_chest thread directed_add_new_objective(#"enh_objective", 1, #"death", level.var_f9f50915, #"trigger_activated");
        level.var_f9f50915 waittill(#"trigger_activated");

        wait 0.5;

        while(true)
        {
            level.stop_box_counter = false;
            level.var_f9f50915.mdl_chest thread directed_add_new_objective(#"enh_objective", 1, #"death", level, #"stop_box_counter");
            level thread Directed_SetObjective(6 + level.var_e2ce1fe1);
            level thread Directed_ChestObjectiveCounter();

            while(true)
            {
                if (level.stop_box_counter)
                {
                    level thread Directed_UpdateObjective(10 * (level.var_e2ce1fe1 + 1));
                    level notify(#"stop_box_counter");
                    level.stop_box_counter = false;
                    break;
                }

                level thread Directed_UpdateObjective(level.n_kill_count);
                wait 0.5;
            }

            wait 6;

            if (level.var_e2ce1fe1 == 3)
                break;
        }
        
        wait 5;
        
        level thread Directed_SetObjective(9);
        wonder_loc = getent(level.var_f3abf34a.target, "targetname");
        fake_model = util::spawn_model(#"tag_origin", wonder_loc.origin, wonder_loc.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", wonder_loc, #"death");
        level waittill(#"hash_2889330d50a4cc38");
    }

    // Kit
    level thread Directed_SetObjective(10);
    b_built_kit = false;
    if (!b_built_kit)
    {
        level.kit_parts_collected = 0;

        // highlight parts
        a_items_array = getitemarray();
        a_items_counter = 0;
        foreach(item in a_items_array)
        {
            try_name = item.item.name;
            if ((isDefined(try_name)) && !isdefined(item.saved_picked) && (try_name == #"hash_60b473e8d0f810aa" || try_name == #"hash_60b471e8d0f80d44" || try_name == #"hash_60b472e8d0f80ef7"))
            {
                item thread directed_add_new_objective(#"enh_objective", 1, #"death", item, #"trigger");
                item thread directed_update_kit_objective();
                a_items_counter++;
            }
        }

        level.kit_parts_collected = (3 - a_items_counter);
        level Directed_UpdateObjective(level.kit_parts_collected);

        // wait for items to be picked up
        while(true)
        {
            a_items_array = getitemarray();
            b_all_picked_up = true;
            
            foreach(item in a_items_array)
            {
                try_name = item.item.name;
                if (isDefined(try_name) && !isdefined(item.saved_picked))
                {
                    if (!(try_name != #"hash_60b473e8d0f810aa" && try_name != #"hash_60b471e8d0f80d44" && try_name != #"hash_60b472e8d0f80ef7"))
                    {
                        b_all_picked_up = false;
                        break;
                    }
                }
            }

            if (b_all_picked_up)
                break;

            wait 0.5;
        }
        
        if (!isDefined(level.b_built_kit))
        {
            foreach (trigger in level.var_4fe2f84d[#"zblueprint_zod_tricannon_upgrade"]) {
                fake_model = util::spawn_model(#"tag_origin", trigger.origin, trigger.angles);
                fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", level, #"blueprint_completed");
                level waittill(#"blueprint_completed");
                util::wait_network_frame();
                fake_model delete();
            }
        }
    }

    // Main Quest
    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 3))
    {
        // CLock Step
        level thread Directed_SetRoundCap(12);
        level thread Directed_SetObjective(11);

        wait 1;

        level.clocks_set = 0;
        a_s_telegraphs = struct::get_array(#"s_telegraph");
        foreach (s_telegraph in a_s_telegraphs) {
            s_telegraph thread directed_clock_logic_mark();
        }

        level thread directed_update_clocks_set();

        level flag::wait_till(#"hash_2d1cd18f39ac5fa7");
        wait 1.5;
        level notify(#"stop_clocks_directed");
    }

    level thread Directed_SetRoundCap(16);

    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 4))
    {
        // a_flags = array(#"hash_515a88d1cbabc18e", #"hash_1322dd3a3d7411a5", #"hash_2f5be8d749b4e88e", #"hash_33a5d8dd1204080e");
        sparks_order = array(10000, 10001, 10002, 10003);
        sparks_order_index = 0;
        while(true)
        {
            foreach (s_spark in level.a_s_sparks) {
                level thread Directed_SetObjective(12);
                fake_model = util::spawn_model(#"tag_origin", s_spark.origin, s_spark.angles);
                id_to_send = 0;

                switch (s_spark.script_noteworthy) {
                case #"hash_41a5c5168ffb2a97":
                    id_to_send = 10000;
                    break;
                case #"hash_400a481490a4e390":
                    id_to_send = 10001;
                    break;
                case #"hash_5562e324d230f057":
                    id_to_send = 10002;
                    break;
                case #"hash_41fae186552f1259":
                    id_to_send = 10003;
                    break;
                }

                if (sparks_order[sparks_order_index] == id_to_send)
                {
                    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", s_spark, #"death", id_to_send == 0 ? undefined : id_to_send);

                    switch(sparks_order_index) {
                    case 0:
                        while(!isdefined(level.mdl_portal))
                        {
                            a_ai = getaiteamarray(level.zombie_team);
                            foreach(ai in a_ai)
                            {
                                if (ai.archetype == #"catalyst" && isdefined(ai.var_9fde8624) && ai.var_9fde8624 == #"catalyst_corrosive" && !isdefined(ai.added_objective))
                                {
                                    ai thread directed_add_new_objective(#"enh_objective", 1, #"death", level, #"stop_catalyst_ping");
                                    ai.added_objective = true;
                                }
                            }
                            wait 0.5;
                        }

                        level notify(#"stop_catalyst_ping");

                        fake_model delete();
                        level thread Directed_SetObjective(13);
                        level.mdl_portal thread directed_add_new_objective(#"enh_objective", 1, #"death", level.mdl_portal, #"death");
                        level.mdl_portal waittill(#"death");
                        level thread Directed_SetObjective(14);
                        
                        level flag::wait_till(#"hash_511653209a0c8cc5" + "earth" + "_completed");
                        level thread Directed_SetObjective(15);
                        level.mdl_artifact_directed thread directed_add_new_objective(#"enh_objective", 1, #"death", level.mdl_artifact_directed, #"death");
                        level.mdl_artifact_directed waittill(#"death");
                        break;
                    case 1:
                        while(!isdefined(level.mdl_portal))
                        {
                            a_ai = getaiteamarray(level.zombie_team);
                            foreach(ai in a_ai)
                            {
                                if (ai.archetype == #"catalyst" && isdefined(ai.var_9fde8624) && ai.var_9fde8624 == #"catalyst_water" && !isdefined(ai.added_objective))
                                {
                                    ai thread directed_add_new_objective(#"enh_objective", 1, #"death", level, #"stop_catalyst_ping");
                                    ai.added_objective = true;
                                }
                            }
                            wait 0.5;
                        }

                        level notify(#"stop_catalyst_ping");

                        fake_model delete();
                        level thread Directed_SetObjective(13);
                        level.mdl_portal thread directed_add_new_objective(#"enh_objective", 1, #"death", level.mdl_portal, #"death");
                        level.mdl_portal waittill(#"death");
                        level thread Directed_SetObjective(14);

                        level flag::wait_till(#"hash_511653209a0c8cc5" + "water" + "_completed");
                        level thread Directed_SetObjective(15);
                        level.mdl_artifact_directed thread directed_add_new_objective(#"enh_objective", 1, #"death", level.mdl_artifact_directed, #"death");
                        level.mdl_artifact_directed waittill(#"death");
                        break;
                    case 2:
                        while(!isdefined(level.mdl_portal))
                        {
                            a_ai = getaiteamarray(level.zombie_team);
                            foreach(ai in a_ai)
                            {
                                if (ai.archetype == #"catalyst" && isdefined(ai.var_9fde8624) && ai.var_9fde8624 == #"catalyst_electric" && !isdefined(ai.added_objective))
                                {
                                    ai thread directed_add_new_objective(#"enh_objective", 1, #"death", level, #"stop_catalyst_ping");
                                    ai.added_objective = true;
                                }
                            }
                            wait 0.5;
                        }

                        level notify(#"stop_catalyst_ping");

                        fake_model delete();
                        level thread Directed_SetObjective(13);
                        level.mdl_portal thread directed_add_new_objective(#"enh_objective", 1, #"death", level.mdl_portal, #"death");
                        level.mdl_portal waittill(#"death");
                        level thread Directed_SetObjective(14);

                        level flag::wait_till(#"hash_511653209a0c8cc5" + "air" + "_completed");
                        level thread Directed_SetObjective(15);
                        level.mdl_artifact_directed thread directed_add_new_objective(#"enh_objective", 1, #"death", level.mdl_artifact_directed, #"death");
                        level.mdl_artifact_directed waittill(#"death");
                        break; 
                    case 3:
                        while(!isdefined(level.mdl_portal))
                        {
                            a_ai = getaiteamarray(level.zombie_team);
                            foreach(ai in a_ai)
                            {
                                if (ai.archetype == #"catalyst" && isdefined(ai.var_9fde8624) && ai.var_9fde8624 == #"catalyst_plasma" && !isdefined(ai.added_objective))
                                {
                                    ai thread directed_add_new_objective(#"enh_objective", 1, #"death", level, #"stop_catalyst_ping");
                                    ai.added_objective = true;
                                }
                            }
                            wait 0.5;
                        }

                        level notify(#"stop_catalyst_ping");

                        fake_model delete();
                        level thread Directed_SetObjective(13);
                        level.mdl_portal thread directed_add_new_objective(#"enh_objective", 1, #"death", level.mdl_portal, #"death");
                        level.mdl_portal waittill(#"death");
                        level thread Directed_SetObjective(14);

                        level flag::wait_till(#"hash_511653209a0c8cc5" + "fire" + "_completed");
                        level thread Directed_SetObjective(15);
                        level.mdl_artifact_directed thread directed_add_new_objective(#"enh_objective", 1, #"death", level.mdl_artifact_directed, #"death");
                        level.mdl_artifact_directed waittill(#"death");
                        break; 
                    }

                    sparks_order_index++;
                }

                if (sparks_order_index >= 4)
                    break;
            }

            if (sparks_order_index >= 4)
                break;
        }

        wait 2;
    }
    
    level thread Directed_SetRoundCap(19);

    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 5))
    {
        // Pipes
        // check if any player has earth kraken
        b_any_has_earth_kraken = false;
        b_any_has_posion_item = false;
        foreach(player in level.players)
        {
            if (player hasWeapon(getweapon(#"ww_tricannon_earth_t8")) || player hasWeapon(getweapon(#"ww_tricannon_earth_t8_upgraded")))
            {
                b_any_has_earth_kraken = true;
                break;
            }

            if (isdefined(player.var_b6ddf07f) && player.var_b6ddf07f == #"decay")
            {
                b_any_has_posion_item = true;
                break;
            }
        }

        if (!b_any_has_earth_kraken)
        {
            if (!b_any_has_posion_item)
            {
                level.ping_gas_drops = true;
                level thread Directed_SetObjective(17);

                while(true)
                {
                    if (isdefined(level.posion_objective_active))
                        break;
                    
                    a_ai = getaiteamarray(level.zombie_team);
                    foreach(ai in a_ai)
                    {
                        if (ai.archetype == #"catalyst" && isdefined(ai.var_9fde8624) && ai.var_9fde8624 == #"catalyst_corrosive" && !isdefined(ai.added_objective))
                        {
                            ai thread directed_add_new_objective(#"enh_objective", 1, #"death", level, #"stop_catalyst_ping");
                            ai.added_objective = true;
                        }
                    }
                    wait 0.5;
                }

                level.ping_gas_drops = undefined;

                level notify(#"stop_catalyst_ping");
            }
            
            level thread Directed_SetObjective(18);
            foreach (trigger in level.var_4fe2f84d[#"zblueprint_zod_tricannon_upgrade"]) {
                fake_model = util::spawn_model(#"tag_origin", trigger.origin, trigger.angles);
                fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", level, #"blueprint_completed");
                level waittill(#"kraken_earth_upgraded");
                level.ping_pipes = true;
                util::wait_network_frame();
                fake_model delete();
            }
        }
        else
        {
            level.ping_pipes = true;
        }
        
        level thread Directed_SetObjective(16);
        level waittill(#"pipes_completed");

        if (level.s_pap_quest.var_4ee2e2ab === 2 || level flag::get(#"hash_598d4e6af1cf4c39"))
        {
            level thread Directed_SetObjective(20);
        }
        else
        {
            level thread Directed_SetObjective(19);
            wait 20;
            level thread [[ @zodt8_pap_quest<scripts\zm\zm_zodt8_pap_quest.gsc>::function_306b4f35 ]]();
            level waittill(#"pap_moved");
            level thread Directed_SetObjective(20);
        }

        fake_model = util::spawn_model(#"tag_origin", level.pap_machine.origin, level.pap_machine.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", fake_model, #"death");
        while(!isdefined(level.mdl_artifact_directed))
            util::wait_network_frame();
        wait 1;
        while(isdefined(level.mdl_artifact_directed))
            util::wait_network_frame();
        fake_model delete();
    }

    level thread Directed_SetRoundCap(22);
    
    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 6))
    {
        level thread ValveWatcher();

        // Planets Symbols
        level thread Directed_SetObjective(21);
        level thread Directed_SetRoundCap(23);
        level.planets_activated = 0;
        a_glyphs = struct::get_array(#"planet_glyph", "script_noteworthy");
        foreach (s_glyph in a_glyphs) {
            s_glyph thread directed_add_planet_symbol_objective();
        }
        
        level flag::wait_till(#"hash_63a102a7ae564e99");
        level notify(#"stop_planet_symbol_objective");

        level thread Directed_SetObjective(22);

        if (!isdefined(level.water_valves_used))
        {
            t_use_water_pump_fore = getent("t_use_water_pump_fore", "targetname");
            fake_model = util::spawn_model(#"tag_origin", t_use_water_pump_fore.origin, t_use_water_pump_fore.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", t_use_water_pump_fore, #"trigger");
            t_use_water_pump_fore waittill(#"trigger");
            fake_model delete();
        }

        level thread Directed_SetObjective(23);
        s_solar_panel = struct::get(#"loc_sun");
        fake_model = util::spawn_model(#"tag_origin", s_solar_panel.origin, s_solar_panel.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", s_solar_panel, #"trigger_activated");
        s_solar_panel waittill(#"trigger_activated");
        fake_model delete();

        // Planets Order
        // s_landing = struct::get(str_planet_name + "_coyote");
        level thread PlanetFailWatcher();
        level thread Directed_SetObjective(24);
        wait 10;
        while(!isdefined(level.next_planet_waiting))
            util::wait_network_frame();

        level.planets_shot = 0;
        while(true)
        {
            if (isdefined(level.planets_completed) && level.planets_completed)
                break;

            if (!isdefined(level.a_planets))
            {
                level.planets_shot = 0;
                level Directed_UpdateObjective(level.planets_shot);
                wait 0.5;
                continue;
            }

            if (isdefined(level.planet_step_failed) && level.planet_step_failed)
            {
                level.planets_shot = 0;
                level.planet_step_failed = undefined;
                
                level thread Directed_SetObjective(26);
                level waittill(#"end_of_round", #"start_of_round");
                level thread Directed_SetObjective(23);
                s_solar_panel = struct::get(#"loc_sun");
                fake_model = util::spawn_model(#"tag_origin", s_solar_panel.origin, s_solar_panel.angles);
                fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", s_solar_panel, #"trigger_activated");
                s_solar_panel waittill(#"trigger_activated");
                fake_model delete();
                level thread Directed_SetObjective(24);
                wait 10;
            }
    
            foreach(planet in level.a_planets)
            {
                if (!isdefined(planet))
                    continue;
                
                if (!isdefined(planet.str_object_name))
                    continue;

                if (!isdefined(level.next_planet_waiting))
                    continue;

                if (!isdefined(level.a_planets))
                    continue;
                
                if (planet.str_object_name != level.next_planet_waiting)
                    continue;

                ShieldLog("running logic for planet: " + planet.str_object_name);
                str_planet_name = planet.str_object_name;
                id_to_use = 0;

                switch (planet.str_object_name) {
                case #"uranus":
                    id_to_use = 7;
                    break;
                case #"saturn":
                    id_to_use = 6;
                    break;
                case #"jupiter":
                    id_to_use = 5;
                    break;
                case #"sun":
                    id_to_use = 1;
                    break;
                case #"mars":
                    id_to_use = 4;
                    break;
                case #"mercury":
                    id_to_use = 2;
                    break;
                case #"venus":
                    id_to_use = 3;
                    break;
                case #"neptune":
                    id_to_use = 8;
                    break;
                case #"moon":
                    id_to_use = 9;
                    break;
                }

                level Directed_SetObjective(24);
                level Directed_UpdateObjective(level.planets_shot);

                if (planet.str_object_name !== #"moon")
                    planet thread directed_add_new_objective(#"enh_objective", 1, #"stop_objective", level, #"stop_planet_objective", id_to_use == 0 ? undefined : (id_to_use + 20000));
                else
                {
                    custom_cords = (61974.7, -37295.6, 35792);
                    fake_model = util::spawn_model(#"tag_origin", custom_cords, planet.angles);
                    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"stop_objective", level, #"stop_planet_objective", id_to_use == 0 ? undefined : (id_to_use + 20000));
                }

                str_result = level waittill(#"planet_shot", #"planet_failed");
                if (str_result._notify == #"planet_failed")
                {
                    level notify(#"stop_planet_objective");
                    level notify(#"stop_orb_objective");
                    break;
                }

                level Directed_SetObjective(25);
                level Directed_UpdateObjective(level.planets_shot);

                if (planet.str_object_name !== #"moon")
                    planet notify(#"stop_objective");
                else
                {
                    fake_model notify(#"stop_objective");
                    fake_model delete();
                }

                // Mark orb
                orb_loc = struct::get(planet.str_object_name + "_coyote");
                fake_model = util::spawn_model(#"tag_origin", orb_loc.origin, orb_loc.angles);
                fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", level, #"stop_orb_objective", id_to_use == 0 ? undefined : (id_to_use + 30000));
                while(isdefined(planet) && isdefined(planet.str_object_name) && level flag::exists(planet.str_object_name + "_pickup") && !level flag::get(planet.str_object_name + "_pickup"))
                    util::wait_network_frame();
                fake_model delete();

                level.planets_shot++;
                level Directed_UpdateObjective(level.planets_shot);

                if (str_planet_name === #"sun")
                    level.planets_completed = true;
                
                wait 0.25;
                break; // exit loop to wait for next_planet_waiting to update
            }

            wait 0.25;
        }
    }

    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 7))
    {
        // Iceberg Lockdown
        level thread FrozenFailWatcher();
        level thread Directed_SetRoundCap(26);
        level thread Directed_SetObjective(27);
        while(!isdefined(level.frozen_step_started))
            util::wait_network_frame();
        level.frozen_step_started = undefined;
        wait 5;

        while(true)
        {
            s_loc = struct::get(#"hash_3f00f45f819284ba", "script_string");
            fake_model = util::spawn_model(#"tag_origin", s_loc.origin, s_loc.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", s_loc, #"death");
            level thread Directed_SetObjective(27);

            while(!level flag::get(#"hash_349bc60cedc7491e") && !isdefined(level.frozen_step_failed))
                util::wait_network_frame();

            wait 1;

            if (level flag::get(#"hash_349bc60cedc7491e"))
            {
                // success
                fake_model delete();
                break;
            }

            if (isdefined(level.frozen_step_failed) && level.frozen_step_failed)
            {
                level.frozen_step_failed = undefined;

                // failed
                fake_model delete();
                
                level Directed_SetObjective(28);
                level waittill(#"end_of_round");
                level Directed_SetObjective(31);
                s_reset = struct::get(#"sun_coyote");
                fake_model_s = util::spawn_model(#"tag_origin", s_reset.origin, s_reset.angles);
                fake_model_s thread directed_add_new_objective(#"enh_objective", 1, #"death", s_reset, #"death");
                while(!isdefined(level.frozen_step_started))
                    util::wait_network_frame();
                level.frozen_step_started = undefined;
                fake_model_s delete();
            }
        }

        wait 5;
    }

    // finale if all of the previous steps were saved
    level Directed_SetObjective(29);
    s_struct = struct::get(#"final_portal");
    fake_model = util::spawn_model(#"tag_origin", s_struct.origin, s_struct.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", s_struct, #"death");

    while(s_struct.var_b7273b77 == 1)
        util::wait_network_frame();

    fake_model delete();

    wait 3;
    
    level Directed_SetObjective(30);
    s_tree = struct::get(#"hash_1022226235c54b6");
    fake_model = util::spawn_model(#"tag_origin", s_tree.origin, s_tree.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", s_tree, #"death");
    level waittill(#"hash_332a98e65f5dce4");
    fake_model delete();

    level Directed_SetObjective(31);
    level flag::wait_till(#"boss_fight_started");
    level Directed_SetObjective(32);

    level.e_boss thread directed_add_new_objective(#"enh_objective", 1, #"death", level, #"stop_eye_directed");
    level flag::wait_till(#"hash_25d8c88ff3f91ee5");

    level thread Directed_SetObjective(999);
    level thread Directed_Change_GameOver_Screen();
    level notify(#"stop_eye_directed");
}