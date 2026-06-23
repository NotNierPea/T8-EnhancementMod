detour zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_12944b2e() {
    if(!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_12944b2e ]]();
    
    level endon(#"end_game");
    if (getdvarint(#"zm_debug_ee", 0)) {
        var_4059c402 = 1;
    } else {
        var_4059c402 = 3;
    }
    var_4d573637 = getentarray("mdl_fertilizer_component_1", "targetname");
    while (true) {
        level waittill(#"end_of_round");
        var_8eba7a9f = 0;
        foreach (n_charcoal in level.var_5cb7d214.var_e913cb3d) {
            mdl_wood = var_4d573637[var_8eba7a9f];
            if (isdefined(mdl_wood)) {
                if (var_4059c402 > 1) {
                    if (true) {
                        mdl_wood clientfield::set("" + #"hash_c382c02584ba249", 1);
                    }
                    if (true) { // always after a round..
                        mdl_wood playsound(#"hash_5f8e33ac1c927130");
                        mdl_wood clientfield::set("" + #"hash_c382c02584ba249", 0);
                        mdl_wood clientfield::set("" + #"hash_273efcc293063e5e", 1);
                        mdl_wood thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_d4646ede ]]();
                    }
                } else {
                    mdl_wood setmodel(#"hash_4286272708c5e5c0");
                }
            }
            if (true) {
                var_8eba7a9f++;
            }
        }
        if (var_8eba7a9f >= 1) {
            level thread Directed_SetObjective(26);
            var_9b1b2f2d = struct::get(#"hash_224dd0372d9a6eff");

            fake_model = util::spawn_model(#"tag_origin", var_9b1b2f2d.origin, var_9b1b2f2d.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", var_9b1b2f2d, #"trigger_activated");

            e_player = var_9b1b2f2d zm_unitrigger::function_fac87205("", (96, 180, 96), 1);
            e_player thread zm_vo::function_a2bd5a0c(#"hash_c393cb786feb084", 0, 0, 9999, 1);
            e_player playsound(#"hash_35c03e3efe6d4487");
            foreach (var_d3c8748e in var_4d573637) {
                if (isdefined(var_d3c8748e)) {
                    var_d3c8748e delete();
                }
            }
            level clientfield::set("" + #"hash_a2fb645044ed12e", 0);
            util::wait_network_frame();
            fake_model delete();
            break;
        }
    }
    level flag::set(#"collect_charcoal_completed");
}

detour zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_3a5c3a3c() {
    [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_3a5c3a3c ]]();
    level notify(#"danu_challenge_started");
}

detour zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_1e3536b6() {
    level.ra_challenge_failed = true;
    return [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_1e3536b6 ]]();
}

detour zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_67c2c9d0() {
    level.ra_challenge_failed = true;
    return [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_67c2c9d0 ]]();
}

add_flag_objective()
{
    flag = self;
    fake_model = util::spawn_model(#"tag_origin", flag.origin, flag.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"trigger", level, #"stop_flags_objective");
    flag waittill(#"trigger");
    level notify(#"stop_flags_objective");
    util::wait_network_frame();
    fake_model delete();
}

mark_directed_objective_trap()
{
    fake_model = util::spawn_model(#"tag_origin", self.origin, self.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"trigger", level, #"stop_directed_traps_objective");
    level waittill(#"stop_directed_traps_objective");
    util::wait_network_frame();
    fake_model delete();
}

ShieldWatcher()
{
    while(true)
    {
        str_result = level waittill(#"blueprint_completed");
        
        if (str_result.blueprint.name != #"zblueprint_trap_hellpools")
            level.b_built_shield = true;
    }
}

directed_mark_tower_wood_objective()
{
    fake_model = util::spawn_model(#"tag_origin", self.origin, self.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", level, #"stop_towers_objective");
    
    while((!isDefined(self.var_1d6dd729) || !self.var_1d6dd729) && (!isDefined(level.wood_fallen))) // wood fallen
        util::wait_network_frame();

    level notify(#"stop_towers_objective");
    util::wait_network_frame();
    fake_model delete();
}

SpawnGlads()
{
    level endon(#"stop_towers_objective", #"end_game");

    while(true)
    {
        gladiators = getaiarchetypearray(#"gladiator");
        destroyes = 0;
        
        foreach(glad in gladiators)
        {
            if (glad.var_9fde8624 == #"gladiator_destroyer")
                destroyes++;
        }

        if (destroyes == 0)
        {
            glad = [[ @zombie_gladiator_util<scripts\zm_common\util\ai_gladiator_util.gsc>::function_69f309b ]](1, "ranged", undefined, 1);
            wait 1;
        }

        // mark them
        gladiators = getaiarchetypearray(#"gladiator");
        foreach(glad in gladiators)
        {
            if (glad.var_9fde8624 == #"gladiator_destroyer" && !isDefined(glad.added_obj))
            {
                glad thread directed_add_new_objective(#"enh_objective", 1, #"death", level, #"stop_towers_objective");
                glad.added_obj = true;
            }
        }

        wait 1;
    }
}

blight_markers(a_ents, var_4d6e64ec)
{
    wait 3;
    blight = a_ents[#"blight_blister"];

    if (isDefined(blight))
    {
        fake_model = util::spawn_model(#"tag_origin", blight.origin, blight.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", level, #"hash_4a0610c40e953981");
        level waittill(#"hash_4a0610c40e953981");
        util::wait_network_frame();
        fake_model delete();

        level.damaged_bulbs++;
        level thread Directed_UpdateObjective(level.damaged_bulbs);
    }
}

directed_mark_bull_damage()
{
    fake_model = util::spawn_model(#"tag_origin", self.origin, self.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", self, #"death");
    self waittill(#"death");
    util::wait_network_frame();
    fake_model delete();
    
    level.bulls_damaged++;
    level thread Directed_UpdateObjective(level.bulls_damaged);
}

directed_add_storm_objective()
{
    fake_model = util::spawn_model(#"tag_origin", self.origin, self.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", self, #"stop_storm_objective");

    while(!self flag::exists(#"hash_6865328fef54bb82"))
        util::wait_network_frame();

    self flag::wait_till(#"hash_6865328fef54bb82");

    self notify(#"stop_storm_objective");
    util::wait_network_frame();
    fake_model delete();

    level.storms_activated++;
    level thread Directed_UpdateObjective(level.storms_activated);
}

directed_add_blue_ball_objective()
{
    fake_model = util::spawn_model(#"tag_origin", self.origin, self.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"trigger_activated", level, #"stop_balls_objective");
    self waittill(#"trigger_activated");
    util::wait_network_frame();
    fake_model delete();
}

directed_add_light_rune_objective()
{
    e_trig = self.t_trig;
    fake_model = util::spawn_model(#"tag_origin", e_trig.origin, e_trig.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", level, #"lune_group_done");

    while(self.b_active)
        util::wait_network_frame();

    util::wait_network_frame();
    fake_model delete();

    level notify(#"lune_group_done");
}

AcidPartWatcher()
{
    level.var_b56b2097 waittill(#"trigger", #"death");
    level.picked_up_acid_part = true;
}

Directed_TrackHeads()
{
    level endon(#"end_game", #"stop_tracker_objectives");

    while(true)
    {
        if (isdefined(level.var_c22016cf))
            level Directed_UpdateObjective(level.var_c22016cf);
        wait 0.5;
    }
}

directed_update_shield_objective()
{
    self waittill(#"trigger", #"death");
    level.shield_parts_collected++;
    level Directed_UpdateObjective(level.shield_parts_collected);
}

directed_update_acid_objective()
{
    self waittill(#"trigger", #"death");
    level.acid_parts_collected++;
    level Directed_UpdateObjective(level.acid_parts_collected);
}

directed_update_shots_grinder()
{
    self endon(#"stop_objective_17");

    while(true)
    {
        if (isDefined(level.var_5cb7d214.var_cdbfd18f))
        {
            val = 0;

            if (level.var_5cb7d214.var_cdbfd18f >= 1)
                val = 1;

            if (level.var_5cb7d214.var_cdbfd18f >= 2)
                val = 2;

            if (level.var_5cb7d214.var_cdbfd18f >= 3)
                val = 3;

            level Directed_UpdateObjective(val);
        }
        wait 0.5;
    }
}

update_directed_danu_timer()
{
    level endon(#"end_game");
    var_2093456 = getent("t_fertilizer_enter", "targetname");
    var_b683ba09 = 0;
    var_65cf92c1 = 13;
    while (true) {
        var_eca6c0ef = 0;
        foreach (player in level.activeplayers) {
            if (!player istouching(var_2093456)) {
                var_eca6c0ef = 1;
                break;
            }
        }
        if (level flag::get("special_round") || level flag::get(#"hash_4fd3d0c01f9b4c30")) {
            waitframe(1);
            continue;
        }
        if (var_eca6c0ef) {
            var_b683ba09 = 0;
            waitframe(1);
            continue;
        }
        wait 1;
        var_b683ba09++;
        level thread Directed_UpdateObjective(var_b683ba09);
        if (var_b683ba09 >= var_65cf92c1) {
            break;
        }
    }
}

directed_update_screw_objective()
{
    level endon(#"end_game", #"stop_update_screws_objective");
    self waittill(#"death");
    level.screws_damaged++;

    level thread Directed_UpdateObjective(level.screws_damaged);
}

Directed_GladTracker()
{
    level endon(#"end_game", #"stop_glad_tracker");

    while(true)
    {
        if (!isdefined(level.var_35df8567) || !isdefined(level.var_2959a011))
        {
            wait 0.5;
            continue;
        }
        
        calc_amount = (level.var_35df8567 - level.var_2959a011);
        if (calc_amount < 0)
            calc_amount = 0;

        level Directed_UpdateObjective(calc_amount);
        wait 0.5;
    }
}

update_plate_tracker()
{
    level endon(#"end_game", #"stop_plate_objective");

    while (true) {
        var_89bffd7b = trigger::wait_till("defend_pplate_trig");
        e_player = var_89bffd7b.who;
        if (isplayer(e_player)) {
            for(i = 0; i <= 6; i++)
            {
                if (e_player istouching(getent("defend_pplate_trig", "targetname"))) {
                    level thread Directed_UpdateObjective(i);
                }
                else
                    break;
                
                wait 1;
            }
        }
    }
}

Directed_Defend_Timer()
{
    level endon(#"end_game", #"stop_defend_timer");

    while (true) {
        level Directed_UpdateObjective(int((300 - level.var_ec9554ad)));
        wait 0.5;
    }
}

IXDirectedMode_PAP()
{
    // starting round cap
    level thread Directed_SetRoundCap(4);
    level thread Directed_SetObjective(1);

    // PAP Encounters
    pap_encounters = array("t_pap_quest_danu_encounter", "t_pap_quest_ra_encounter", "t_pap_quest_odin_encounter", "t_pap_quest_zeus_encounter");
    foreach(encounter in pap_encounters)
    {
        t_trigger = getent(encounter, "targetname");
        t_gong = getent(t_trigger.target, "targetname");
        t_gong thread directed_add_new_objective(#"enh_objective", 1, #"nothing", t_trigger, #"trigger");
    }
    
    level thread Directed_TrackHeads();
    level flag::wait_till_all(array(#"hash_3d833ecc64915d8d", #"hash_d38ff215be3a4fc", #"hash_4142472dec557d03", #"hash_45b6b1ee5d5038b4"));
    level notify(#"stop_tracker_objectives");
    level thread Directed_SetObjective(2);

    // Heads for PAP
    mdl_sentinel_artifact = getent("mdl_pap_quest_sentinel_artifact", "targetname");
    mdl_sentinel_artifact thread directed_add_new_objective(#"enh_objective", 1, #"nothing", level, #"stop_directed_pap_objective");
    level flag::wait_till(#"zm_towers_pap_quest_completed");
    level notify(#"stop_directed_pap_objective");

    // after pap
    level thread Directed_SetRoundCap(7);

}

IXDirectedMode_Shield()
{
    level thread Directed_SetObjective(14);

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
            if ((isDefined(try_name)) && !isdefined(item.saved_picked) && (try_name != #"hash_72cba96681a7af18" && try_name != #"hash_72cbab6681a7b27e" && try_name != #"hash_72cbac6681a7b431"))
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
                    if (!(try_name == #"hash_72cba96681a7af18" || try_name == #"hash_72cbab6681a7b27e" || try_name == #"hash_72cbac6681a7b431"))
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
            foreach (trigger in level.var_4fe2f84d[#"zblueprint_shield_zhield_zword"]) {
                fake_model = util::spawn_model(#"tag_origin", trigger.origin, trigger.angles);
                fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", level, #"blueprint_completed");
                level waittill(#"blueprint_completed");
                util::wait_network_frame();
                fake_model delete();
            }
        }
    }
}

IXDirectedMode_WonderWeapon()
{
    // Check if any player has ww
    b_has_wonder_weapon = false;
    foreach(player in level.players)
    {
        if (player hasWeapon(getweapon(#"ww_crossbow_t8")) || player hasWeapon(getweapon(#"ww_crossbow_t8_upgraded")))
        {
            b_has_wonder_weapon = true;
            break;
        }
    }

    if (isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 2)
    {
        b_has_wonder_weapon = true;
    }

    if (!b_has_wonder_weapon)
    {
        level thread Directed_SetObjective(3);

        // cauldron
        if (!level flag::get(#"hash_17f15c9242ddea6f"))
        {
            trigger_ww = getent("t_ww_quest_knock_brazier", "targetname");
            fake_model = util::spawn_model(#"tag_origin", trigger_ww.origin, trigger_ww.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", trigger_ww, #"trigger");
            trigger_ww waittill(#"trigger");
            util::wait_network_frame();
            fake_model delete();
        }

        // stone head
        if (!level flag::get(#"hash_5cdf5c960293141a"))
        {
            level thread Directed_SetObjective(4);
            level.var_240da80 thread directed_add_new_objective(#"enh_objective", 1, #"death", level.var_240da80, #"death");
            level.var_240da80 waittill(#"death");
        }

        // acid trap
        level thread Directed_SetObjective(5);

        level.acid_parts_collected = 0;
        a_items_array = getitemarray();
        a_items_counter = 0;
        foreach(item in a_items_array)
        {
            try_name = item.item.name;
            if ((isDefined(try_name)) && (try_name == #"hash_72cba96681a7af18" || try_name == #"hash_72cbab6681a7b27e" || try_name == #"hash_72cbac6681a7b431"))
            {
                if (item != level.var_b56b2097)
                {
                    item thread directed_add_new_objective(#"enh_objective", 1, #"death", item, #"trigger");
                    item thread directed_update_acid_objective();
                }

                a_items_counter++;
            }
            //else if (isDefined(try_name))
                //iPrintLnBold("Item not pinged: " + try_name);
        }

        level.acid_parts_collected = (3 - a_items_counter);
        level Directed_UpdateObjective(level.acid_parts_collected);

        // check if players had knifed the flag
        had_knife_flag = false;
        foreach(player in level.players)
        {
            if (isDefined(player.challenge_struct))
            {
                had_knife_flag = true;
                break;
            }

        }

        if (!had_knife_flag)
        {
            foreach(flag in getentarray("t_zm_towers_cleat_damage_trig", "script_noteworthy"))
            {
                flag thread add_flag_objective();
            }
        }

        if (!level flag::get("challenge_trap_piece_spawned"))
        {
            level flag::wait_till("challenge_trap_piece_spawned");
            
            wait 0.25; // wait for it to move
            level.var_b56b2097 thread directed_add_new_objective(#"enh_objective", 1, #"death", level.var_b56b2097, #"trigger");
            level.var_b56b2097 waittill(#"trigger", #"death");
        }
        else if (level flag::get("challenge_trap_piece_spawned") && !isdefined(level.picked_up_acid_part))
        {
            wait 0.25; // wait for it to move
            level.var_b56b2097 thread directed_add_new_objective(#"enh_objective", 1, #"death", level.var_b56b2097, #"trigger");
            level.var_b56b2097 waittill(#"trigger", #"death");
        }

        level thread Directed_SetObjective(6);

        // mark acid trap locations
        if (!isdefined(level.var_708e0925))
        {
            foreach (t_crafting in level.var_4fe2f84d[#"zblueprint_trap_hellpools"]) {
                t_crafting thread mark_directed_objective_trap();
            }

            while (!isDefined(level.var_2ea12e52))
                util::wait_network_frame();

            level notify(#"stop_directed_traps_objective");
            level thread Directed_SetObjective(7);
        }

        wait 0.5;

        fake_model = util::spawn_model(#"tag_origin", level.var_2ea12e52.origin, level.var_2ea12e52.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death");
        while (!isDefined(level.var_ea8de547))
            util::wait_network_frame();
        fake_model delete();

        wait 0.5;

        // mark acid trap locations
        foreach (t_crafting in level.var_4fe2f84d[#"zblueprint_trap_hellpools"]) {
            if (t_crafting.script_noteworthy == level.var_708e0925)
            t_crafting thread mark_directed_objective_trap();
        }

        while(isDefined(level.var_ea8de547))
            util::wait_network_frame();

        level notify(#"stop_directed_traps_objective");
        level thread Directed_SetObjective(8);

        wait 0.5;

        level.var_f49fd32c thread directed_add_new_objective(#"enh_objective", 1, #"death", level.var_f49fd32c, #"death");
        level.var_f49fd32c waittill(#"death");
        level thread Directed_SetObjective(9);

        // get golden vase
        level.mdl_jar = undefined;
        while(!isDefined(level.mdl_jar))
        {
            Golden_Spawns = struct::get_array("s_ww_quest_impervious_jar_start");
            foreach(golden_spawn in Golden_Spawns)
            {
                struc_get = struct::get(golden_spawn.target);

                if (isDefined(struc_get))
                {
                    s_loc = struct::get(struc_get.target);

                    if (isDefined(s_loc) && isDefined(s_loc.var_6d6bbd67))
                    {
                        level.mdl_jar = s_loc.var_6d6bbd67;
                        break;
                    }
                }
            }

            wait 0.25;
        }

        // pick-up golden vase
        level thread Directed_SetObjective(10);
        fake_model = util::spawn_model(#"tag_origin", level.mdl_jar.origin, level.mdl_jar.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death");
        level.mdl_jar waittill(#"death", #"trigger");
        fake_model delete();

        // place key + vase in tree
        level thread Directed_SetObjective(11);
        t_trigger = getent("t_ww_quest_spile_damage_trigger", "targetname");
        fake_model = util::spawn_model(#"tag_origin", t_trigger.origin, t_trigger.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death");
        t_trigger waittill(#"death", #"trigger");
        while(!isDefined(level.var_1028e128)) util::wait_network_frame();
        fake_model delete();
        level flag::wait_till(#"hash_5649f57b918f85f8");

        level thread Directed_SetObjective(12);
        level waittill(#"end_of_round", #"between_round_over");

        wait 1;

        if (isDefined(level.var_1028e128))
        {       
            level thread Directed_SetObjective(10);
            fake_model = util::spawn_model(#"tag_origin", level.var_1028e128.origin, level.var_1028e128.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death");
            level.var_1028e128 waittill(#"death", #"trigger");
            fake_model delete();
        }

        level thread Directed_SetObjective(13);
        foreach (e_chest in level.var_13fc0c88) {
            n_index = array::find(level.chests, e_chest.owner);
            if (level.chest_index === n_index)
            {
                e_temp = e_chest.var_732ed72e;
                fake_model = util::spawn_model(#"tag_origin", e_temp.origin, e_temp.angles);
                fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", level, #"stop_chest_objective");
                level flag::wait_till(#"hash_77ff9a8101ea687b");
                level notify(#"stop_chest_objective");
                fake_model delete();
            }
        }

        wait 8;
    }
}

IXDirectedMode()
{
    wait_time = 1;

    if(GetDvarInt("shield_enh_SaveGame_Load", 0))
        wait_time = 12;
    
    level thread ShieldWatcher();
    level thread AcidPartWatcher();

    wait wait_time;

    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 1))
        IXDirectedMode_PAP();

    IXDirectedMode_Shield();
    IXDirectedMode_WonderWeapon();
    
    // Main Quest
    level thread Directed_SetRoundCap(10);
    
    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 2))
    {
        // Skull
        Skull = getent("mdl_fertilizer_component_2", "targetname");
        if (isDefined(Skull))
        {
            level thread Directed_SetObjective(15);
            fake_model = util::spawn_model(#"tag_origin", Skull.origin, Skull.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", Skull, #"death");

            while(isDefined(Skull))
                util::wait_network_frame();
            
            fake_model delete();
        }

        // Grinder
        if (!level flag::get(#"hash_4c6ced4815715faf"))
        {
            level thread Directed_SetObjective(16);

            mdl_grinder = getent("mdl_grinder", "targetname");
            fake_model = util::spawn_model(#"tag_origin", mdl_grinder.origin, mdl_grinder.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", mdl_grinder, #"stop_objective_16");
            mdl_grinder waittill(#"trigger_activated");
            mdl_grinder notify(#"stop_objective_16");
            fake_model delete();

            wait 1;
            level thread Directed_SetObjective(17);
            
            mdl_grinder = getent("mdl_grinder", "targetname");
            fake_model = util::spawn_model(#"tag_origin", mdl_grinder.origin, mdl_grinder.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", mdl_grinder, #"stop_objective_17");
            mdl_grinder thread directed_update_shots_grinder();
            level flag::wait_till(#"hash_4c6ced4815715faf");
            mdl_grinder notify(#"stop_objective_17");
            util::wait_network_frame();
            fake_model delete();
        }

        // Dung
        if (!level flag::get(#"collect_dung_completed"))
        {
            while(true)
            {
                level thread Directed_SetObjective(18);

                power_up = undefined;
                while(true)
                {
                    str_result = level waittill(#"powerup_dropped");
                    power_up_name = str_result.powerup.powerup_name;

                    if (power_up_name == #"dung") // dung
                    {
                        power_up = str_result.powerup;
                        break;
                    }
                }

                level thread Directed_SetObjective(19);
                fake_model = util::spawn_model(#"tag_origin", power_up.origin, power_up.angles);
                fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", power_up, #"powerup_grabbed");
                str_wait = power_up waittill(#"powerup_grabbed", #"powerup_timedout");
                util::wait_network_frame();
                fake_model delete();
                
                if (isplayer(str_wait.e_grabber))
                {
                    break;
                }
            }
        }

        // Wood
        if (level.var_5cb7d214.n_wood == 0)
        {
            b_wood_fallen = false;
            w_towers = getentarray("t_fertilizer_tower", "targetname");
            foreach(tower in w_towers)
            {
                if (isDefined(tower.var_1d6dd729) && tower.var_1d6dd729) // wood fallen
                {
                    b_wood_fallen = true;
                    break;
                }
            }

            if (!b_wood_fallen)
            {
                level thread SpawnGlads();
                level thread Directed_SetObjective(22);

                w_towers = getentarray("t_fertilizer_tower", "targetname");
                foreach(tower in w_towers)
                {
                    tower thread directed_mark_tower_wood_objective();
                }

                level waittill(#"stop_towers_objective");
            }
        }

        wait 0.5;

        if (isDefined(level.wood_fallen))
        {
            level thread Directed_SetObjective(23);

            fake_model = util::spawn_model(#"tag_origin", level.wood_fallen.origin, level.wood_fallen.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", level.wood_fallen, #"death");
            level.wood_fallen waittill(#"death");
            util::wait_network_frame();
            fake_model delete();
        }

        wait 0.5;

        if (level.var_5cb7d214.n_wood == 1)
        {
            level thread Directed_SetObjective(24);

            oven_s = struct::get(#"hash_224dd0372d9a6eff");
            fake_model = util::spawn_model(#"tag_origin", oven_s.origin, oven_s.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", oven_s, #"trigger_activated");
            oven_s waittill(#"trigger_activated");
            util::wait_network_frame();
            fake_model delete();
        }

        if (level.var_5cb7d214.n_wood == 0)
        {
            level thread Directed_SetObjective(25);
        }

        if (!level flag::get(#"collect_charcoal_completed"))
            level flag::wait_till(#"collect_charcoal_completed");
    }

    // push to 12
    level thread Directed_SetRoundCap(12);
    
    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 3))
    {
        // Place dung in marked location
        level thread Directed_SetObjective(20);
        loc_a = struct::get(#"hash_44451a49b3653789");
        fake_model = util::spawn_model(#"tag_origin", loc_a.origin, loc_a.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", loc_a, #"trigger_activated");
        loc_a waittill(#"trigger_activated");
        util::wait_network_frame();
        fake_model delete();

        level thread Directed_SetObjective(27);
        level waittill(#"start_of_round");
        level waittill(#"end_of_round");

        level thread Directed_SetObjective(28);
        loc_a = struct::get(#"hash_44451a49b3653789");
        fake_model = util::spawn_model(#"tag_origin", loc_a.origin, loc_a.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", level, #"stop_d_objective");
        
        while (isdefined(getent("mdl_pile", "targetname")))
            util::wait_network_frame();

        level notify(#"stop_d_objective");
        util::wait_network_frame();
        fake_model delete();
    }

    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 4))
    {
        level thread Directed_SetObjective(29);
        danu_place = struct::get(#"hash_3fda284f010e01fd");
        fake_model = util::spawn_model(#"tag_origin", danu_place.origin, danu_place.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", danu_place, #"trigger_activated");
        danu_place waittill(#"trigger_activated");
        util::wait_network_frame();
        fake_model delete();

        level thread Directed_SetObjective(30);
        level waittill(#"end_of_round");
        level thread Directed_UpdateObjective(1);
        level waittill(#"end_of_round");
        level thread Directed_UpdateObjective(2);
        level waittill(#"end_of_round");
        level thread Directed_UpdateObjective(3);

        wait 0.5;

        level thread Directed_SetObjective(31);
        danu_place = struct::get(#"hash_3fda284f010e01fd");
        fake_model = util::spawn_model(#"tag_origin", danu_place.origin, danu_place.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", level, #"stop_danu_objective");
        level flag::wait_till(#"place_fertilizer_completed");
        level notify(#"stop_danu_objective");
        fake_model delete();
    }

    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 5))
    {
        level thread Directed_SetObjective(32);
        level thread update_directed_danu_timer();
        danu_place = struct::get(#"hash_3fda284f010e01fd");
        fake_model = util::spawn_model(#"tag_origin", danu_place.origin, danu_place.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", level, #"stop_danu_objective");
        level.damaged_bulbs = 0;
        scene::add_scene_func(#"p8_fxanim_zm_towers_chaos_pustule_bundle", &blight_markers, "init", 0);
        level waittill(#"danu_challenge_started");
        level notify(#"stop_danu_objective");
        util::wait_network_frame();
        fake_model delete();

        level thread Directed_SetObjective(33);
        level flag::wait_till(#"hash_23c79f4deefd8aa1");
    }

    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 6))
    {
        level thread Directed_SetObjective(34);
        level thread Directed_SetRoundCap(16);

        wait 3;
        level.bulls_damaged = 0;
        foreach(bull in level.var_36116a82)
        {
            t_damage = getent(bull.target, "targetname");
            t_damage thread directed_mark_bull_damage();
        }

        level flag::wait_till(#"bull_heads_completed");
    }

    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 7))
    {
        while(true)
        {
            if (level flag::get(#"hash_7f6689c71e55e8ab"))
                break;
            
            if (isdefined(level.ra_challenge_failed))
            {
                level.ra_challenge_failed = undefined;

                while (!(isdefined(level.var_8c8485cf) && level.var_8c8485cf))
                    util::wait_network_frame();

                level thread Directed_UpdateObjective(0);
            }

            // reset counter
            level thread Directed_UpdateObjective(0);
            
            level thread Directed_SetObjective(35);
            fake_model = util::spawn_model(#"tag_origin", level.var_82234300.origin, level.var_82234300.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", level, #"stop_bull_objective");

            while (isdefined(level.var_8c8485cf) && level.var_8c8485cf)
                util::wait_network_frame();
            
            fake_model delete();

            level thread Directed_SetObjective(36);
            
            while(!(isdefined(level.var_8c8485cf) && level.var_8c8485cf))
            {
                if (level flag::get(#"hash_7f6689c71e55e8ab"))
                    break;

                a_zombies = getaispeciesarray(level.zombie_team, "all");
                foreach(zombie in a_zombies)
                {
                    if (isdefined(zombie) && isdefined(zombie.aitype) && isdefined(level.var_765eb0c3) && level.var_765eb0c3 <= 3)
                    {
                        if (!level flag::get(#"hash_e35ac19ee7b732c"))
                        {
                            if (((isdefined(level.var_d1a9acf9) && zombie.aitype == level.var_d1a9acf9[level.var_765eb0c3])))
                            {
                                if (!isdefined(zombie.added_objective))
                                {
                                    zombie thread directed_add_new_objective(#"enh_objective", 1, #"death", zombie, #"death");
                                    zombie.added_objective = true;
                                }
                            }
                        }
                        else
                        {
                            if (((isdefined(level.var_41437b5) && zombie.aitype == level.var_41437b5[level.var_765eb0c3])))
                            {
                                if (!isdefined(zombie.added_objective))
                                {
                                    zombie thread directed_add_new_objective(#"enh_objective", 1, #"death", zombie, #"death");
                                    zombie.added_objective = true;
                                }
                            }
                        }
                    }

                    if (isdefined(level.var_765eb0c3))
                        level thread Directed_UpdateObjective(level.var_765eb0c3);
                }

                if (isdefined(level.ra_challenge_failed))
                {
                    level thread Directed_SetObjective(37);

                    // reset counter
                    level thread Directed_UpdateObjective(0);

                    level waittill(#"start_of_round");
                    level thread Directed_UpdateObjective(0);
                    break;
                }
                
                wait 0.5;
            }
        }
    }

    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 8))
    {
        level thread Directed_SetObjective(38);
        level thread Directed_SetRoundCap(18);

        s_loc = struct::get("s_maelstrom_initiate");
        fake_model = util::spawn_model(#"tag_origin", s_loc.origin, s_loc.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", s_loc, #"trigger_activated");
        s_loc waittill(#"trigger_activated");
        util::wait_network_frame();
        fake_model delete();

        wait 2;

        level thread Directed_SetObjective(39);   

        level.screws_damaged = 0;
        screws = getentarray("t_maelstrom_sponge", "targetname");
        foreach(screw in screws)
        {
            screw_trig = getent(screw.target, "targetname");
            screw_trig thread directed_add_new_objective(#"enh_objective", 1, #"death");
            screw_trig thread directed_update_screw_objective();
        }

        level flag::wait_till(#"hash_35bd62e100e54ab3");
        level notify(#"stop_update_screws_objective");
    }

    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 9))
    {
        level thread Directed_SetObjective(40);
        level.storms_activated = 0;
        a_mdl_spikes = getentarray("mdl_maelstrom_arc", "targetname");
        foreach(mdl in a_mdl_spikes)
        {
            mdl thread directed_add_storm_objective();
        }

        level flag::wait_till(#"hash_4f15d2623e98015d");
    }

    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 10))
    {
        level thread Directed_SetObjective(41);
        a_s_balls = struct::get_array("s_maelstrom_float");
        foreach (s_ball in a_s_balls) {
            s_ball thread directed_add_blue_ball_objective();
        }

        level flag::wait_till(#"hash_50e2bacfe0486f6a");
        level notify(#"stop_balls_objective");
        wait 7;
        level thread Directed_SetObjective(42);
        level thread Directed_GladTracker();

        level flag::wait_till(#"hash_4866241882c534b7");
        level notify(#"stop_glad_tracker");
    }

    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 13))
    {
        level thread Directed_SetObjective(43);

        foreach(light in getentarray("skillshot_1", "targetname"))
        {
            light thread directed_add_light_rune_objective();
        }

        level waittill(#"lune_group_done");

        wait 1;

        foreach(light in getentarray("skillshot_2", "targetname"))
        {
            light thread directed_add_light_rune_objective();
        }

        level waittill(#"lune_group_done");

        wait 1;

        foreach(light in getentarray("skillshot_3", "targetname"))
        {
            light thread directed_add_light_rune_objective();
        }

        level waittill(#"lune_group_done");

        level flag::wait_till(#"hash_20c92720a4602dc7");
    }
    
    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 14))
    {
        level thread Directed_SetObjective(44);
        level thread Directed_SetRoundCap(20);

        plate = getent("defend_pplate_trig", "targetname");
        level thread update_plate_tracker();
        fake_model = util::spawn_model(#"tag_origin", plate.origin, plate.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", level, #"stop_plate_objective");
        while(!isdefined(level.var_34a4aede))
            util::wait_network_frame();
        
        level notify(#"stop_plate_objective");
        util::wait_network_frame();
        fake_model delete();

        wait 0.5;

        level thread Directed_SetObjective(45);
        level thread Directed_Defend_Timer();
        level flag::wait_till(#"hash_277d03629ade12e8");
        level notify(#"stop_defend_timer");

        level thread Directed_SetObjective(46);
        s_key = struct::get("defend_key_loc");
        fake_model = util::spawn_model(#"tag_origin", s_key.origin, s_key.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", s_key, #"trigger_activated");
        s_key waittill(#"trigger_activated");
        util::wait_network_frame();
        fake_model delete();
    }
    
    level thread Directed_SetObjective(47);
    level thread Directed_SetRoundCap(25);
    t_zm_towers_boss_teleport = getent("t_zm_towers_boss_teleport", "targetname");
    fake_model = util::spawn_model(#"tag_origin", t_zm_towers_boss_teleport.origin, t_zm_towers_boss_teleport.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", t_zm_towers_boss_teleport, #"trigger");
    t_zm_towers_boss_teleport waittill(#"trigger");
    util::wait_network_frame();
    fake_model delete();

    wait 3;

    level thread Directed_SetObjective(48);

    while(!isdefined(level.e_elephant))
        util::wait_network_frame();

    wait 1;

    level thread Directed_SetObjective(49);
    level.e_elephant thread directed_add_new_objective(#"enh_objective", 1, #"death", level.e_elephant, #"death");
    level.e_elephant waittill(#"death");

    wait 3;

    while(!isdefined(level.e_elephant))
        util::wait_network_frame();
        
    wait 1;

    level.e_elephant thread directed_add_new_objective(#"enh_objective", 1, #"death", level.e_elephant, #"death");
    level.e_elephant waittill(#"death");

    level thread Directed_SetObjective(999);
    level thread Directed_Change_GameOver_Screen();
}