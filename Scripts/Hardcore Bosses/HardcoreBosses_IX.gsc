ix_boss_fight()
{
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::boss_fight ]]();
    
    level.ShouldSpawnEnemies = true;

    ShieldLog("Boss fight enter...");

    level endon(#"end_game");
    level notify(#"hash_4a06aa98c6c7b671");
    [[ @zm_towers_crowd<scripts\zm\zm_towers_crowd.gsc>::function_5c1184e ]](0);
    [[ @zm_towers_crowd<scripts\zm\zm_towers_crowd.gsc>::function_aec5ec5a ]](1);
    level.var_9a992b09 = 1;

    link_crowd = @zm_towers_crowd<scripts\zm\zm_towers_crowd.gsc>::function_51ea46f3;
    array::thread_all(level.players, link_crowd, 0, 1);
    level.var_b2b15659 = 1;
    switch (level.players.size) {
    case 1:
        level.var_ced6f061 = 12;
        break;
    case 2:
        level.var_ced6f061 = 15;
        break;
    case 3:
    case 4:
        level.var_ced6f061 = 18;
        break;
    }

    level.var_ced6f061 = 30; // 33

    level.var_5d1805c4 = undefined; // no 255 hp scaling please

    // debug
    //setDvar(#"shield_skip_elephintro", 1);

    b_bool = getDvarInt(#"shield_skip_elephintro", 0);

    zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", 3);
    level flag::set(#"hash_4f293396150d2c00");
    level [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_45ac4bb8 ]](1, 0);
    var_3a6fab91 = zm_round_spawning::function_f6cd912d();
    if (isdefined(var_3a6fab91)) {
        zm_round_spawning::function_d36196b1(var_3a6fab91.n_round);
    }
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_3a3bf6e8 ]]();
    zm_bgb_anywhere_but_here::function_886fce8f(0);
    level flag::set("pause_round_timeout");
    [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::pause_zombies ]](1);
    level flag::init("both_towers_bosses_killed");
    if (!b_bool) {
        [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_2a9ec1e9 ]]();

        link_spawn1 = @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_81c5a136;
        link_spawn2 = @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_ef2a451c;

        zm_round_spawning::function_c1571721(link_spawn1);
        zm_round_spawning::function_54fee373(link_spawn2);
        level.var_153e9058 = 1;
        level.var_ff68dee = 0;
        level.var_1643d0d = arraycopy(level.var_3ecc60fc);
    }
    //foreach (player in level.players) {
        //player clientfield::set_to_player("snd_crowd_react", 11);
    //}
    zm_zonemgr::enable_zone("zone_boss_battle");
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_13576d14 ]]();
    var_d2fb9acc = getdvar(#"hash_3065419bcba97739", 0);
    if (!var_d2fb9acc) {
        wait 8;
    }

    if (b_bool) {
        scene::play("p8_fxanim_zm_towers_boss_arena_gate_raise_bundle", "Shot 1");
        scene::play("p8_fxanim_zm_towers_boss_arena_gate_raise_bundle", "Shot 2");
        scene::play("p8_fxanim_zm_towers_boss_arena_gate_raise_bundle", "Shot 3");

        level thread IX_Intro();
    } else {
        level thread IX_Intro();
        level thread IX_Phase0Logic();
        level waittill(#"hash_12768f75609d32ca");
    }

    //level clientfield::set("crowd_react_boss", 0);
    if (!var_d2fb9acc) {
        wait 6;
    }
    level.var_ff68dee = 15;
    var_47312393 = struct::get("towers_boss_location_1", "script_noteworthy");
    sp_spawner = getent("zombie_towers_boss_spawner", "script_noteworthy");

    // broken ass shit
    //trigger::wait_till("large_gate_l_trigger", "targetname");

    if (b_bool)
        level waittill(#"start_debug_boxx");
    else
        wait 25;

    e_linkspawn = @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_f9da4403;
    e_elephant = spawner::simple_spawn_single(sp_spawner, e_linkspawn, var_47312393, #"hash_266f53fb994e6120");
    while (!isdefined(e_elephant.ai.riders) || e_elephant.ai.riders.size < 2) {
        wait 0.1;
    }

    e_elephant thread FasterElephant();
    e_elephant thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_1a05e10c ]](#"towers_boss_ground_attack", #"m_quest", #"shockwave_warn");
    //level util::delay(2, undefined, &clientfield::set, "crowd_react_boss", 1);
    level.var_3395fcab = 1;
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_ae1cbf2e ]]();

    ShieldStopAllMusics();

    e_anim = @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_a407b7bc;
    animation::add_global_notetrack_handler("tower_contact", e_anim, 0);
    e_elephant.takedamage = 0;

    LUINotifyEvent(#"notify_boss_ui", 1, 8);

    wait 0.5;

    ShieldPlay(true, true, 61);

    wait 1;

    LUINotifyEvent(#"notify_boss_ui", 1, 9);

    scene::play(#"aib_vign_cust_zm_twrs_ent_hllpht_00", array(e_elephant));
    e_elephant.takedamage = 1;

    callback::on_ai_damage(&ElephantCheckHighDamage, e_elephant);

    e_elephant notify(#"entrace_done");
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_4d682898 ]]();
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_92e1954c ]]();
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_1a05e10c ]](#"hash_5c38f322b9e6a58d", #"m_quest", #"missile_warn");
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_1a05e10c ]](#"hash_1a3fb5566689f319", #"m_quest", #"missile_track");
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_1a05e10c ]](#"hash_1580cd3b2c801f46", #"m_quest", #"charge_warn");
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_c64fc074 ]]();
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_95785950 ]](45, level.var_49328379, #"armor_nag", #"hash_634700dd42db02d8");
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_95785950 ]](90, level.var_8b66546e, #"basket_nag", #"hash_634700dd42db02d8");

    run_all = @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_3d487e02;
    array::thread_all(level.players, run_all);
    wait 2;
    [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_14833fc2 ]]();
    if (!b_bool) {
        [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::pause_zombies ]](0);
        level flag::set(#"infinite_round_spawning");
    }
    e_elephant waittill(#"death");

    ShieldStopAllMusics();
    level.ShouldSpawnEnemies = false;

    [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::pause_zombies ]](1, 0);
    //foreach (player in level.players) {
       // player clientfield::set_to_player("snd_crowd_react", 13);
    //}
    wait 1;
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_e50623f ]]();
    wait 15;
    [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_14833fc2 ]]();
    trigger::wait_till("large_gate_r_trigger", "targetname");
    level notify(#"hash_5d826e11ebe4b6e7");
    level.var_a52a5487 = 1;
    var_19ef8f95 = struct::get("towers_boss_location_2", "script_noteworthy");
    sp_spawner = getent("zombie_towers_boss2_spawner", "script_noteworthy");
    e_elephant = spawner::simple_spawn_single(sp_spawner, e_linkspawn, var_19ef8f95, #"hash_266f56fb994e6639");
    e_elephant thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_1a05e10c ]](#"towers_boss_ground_attack", #"m_quest", #"shockwave_warn");
    while (!isdefined(e_elephant.ai.riders) || e_elephant.ai.riders.size < 4) {
        wait 0.1;
    }

    e_elephant thread FasterElephant();
    
    //foreach (player in level.players) {
    //    player clientfield::set_to_player("snd_crowd_react", 12);
    //}

    level.ShouldSpawnEnemies = true;

    run_all_anim = @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_b2e7b40d;
    animation::add_global_notetrack_handler("tower_contact_2", run_all_anim, 0);
    level scene::play("p8_fxanim_zm_towers_boss_arena_gate_destroy_bundle", "shot 1");
    e_elephant notify(#"hash_6537a2364ba9dcb3");
    level thread scene::play("p8_fxanim_zm_towers_boss_arena_gate_destroy_bundle", "shot 2");
    e_elephant.takedamage = 0;

    LUINotifyEvent(#"notify_boss_ui", 1, 8);

    wait 0.5;

    ShieldPlay(true, true, 61);

    // enable..
    foreach (player in getplayers()) {
        player bgb_pack::function_ac9cb612(0);
        player bgb::resume_weapon_cycling();
        player.bgb_disabled = 0;
    }

    wait 1;

    LUINotifyEvent(#"notify_boss_ui", 1, 9);

    scene::play(#"aib_vign_cust_zm_twrs_ent_hllpht_01", array(e_elephant));
    e_elephant.takedamage = 1;

    callback::on_ai_damage(&ElephantCheckHighDamage, e_elephant);

    e_elephant notify(#"entrace_done");
    level.var_3395fcab = 2;
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_4550c346 ]]();
    wait 2;
    if (!b_bool) {
        [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::pause_zombies ]](0);
        level flag::set(#"infinite_round_spawning");
        level.var_153e9058 = 0;
    }
    
    e_elephant waittill(#"death");

    level.var_2d744147 = gettime();
    [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::pause_zombies ]](1, 0);
    level flag::clear(#"infinite_round_spawning");
    //foreach (player in level.players) {
    //    player clientfield::set_to_player("snd_crowd_react", 13);
    //}
    level notify(#"boss_battle_done");

    ShieldStopAllMusics();

    remove_spawn = @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_d4e923e7;
    callback::remove_on_spawned(remove_spawn);
}

// bosses
elephant_big_melee(entity) {
    ShieldLog("eleph big melee");

    origin = entity gettagorigin("j_nose4");
    radiusdamage(origin, 800, 150, 90, entity);
    enemies = util::function_81ccf6d3(self.team);
    foreach (target in enemies) {
        dist = distance(self.origin, target.origin);
        if (isplayer(target) && dist < 600) {
            params = getstatuseffect(#"hash_2c80515d8ac9f1b4");
            weapon = getweapon(#"zombie_ai_defaultmelee");
            target status_effect::status_effect_apply(params, weapon, entity, 0, 500);
            var_95fca4e5 = (target.origin[0], target.origin[1], self.origin[2]);
            var_7d97040b = vectornormalize(var_95fca4e5 - self.origin);
            target playerknockback(1);
            knockback = mapfloat(0, 600, 100, 1000, dist);
            target applyknockback(int(knockback), var_7d97040b);
            target playerknockback(0);
        }
    }
    entity clientfield::increment("towers_boss_melee_effect");
    zombiesarray = getaiarchetypearray(#"zombie");
    zombiesarray = arraycombine(zombiesarray, getaiarchetypearray(#"catalyst"), 0, 0);
    zombiesarray = arraycombine(zombiesarray, getaiarchetypearray(#"tiger"), 0, 0);

    linkf = @archetypeelephant<scripts\core_common\ai\archetype_elephant.gsc>::function_1d65bc12;
    zombiesarray = array::filter(zombiesarray, 0, linkf, entity);
    [[ self.ai.var_64eb729e ]](zombiesarray, entity);
    var_bfd0a84a = getentarray("towers_boss_tower_trigger", "targetname");
    foreach (var_e220a902 in var_bfd0a84a) {
        if (!(isdefined(var_e220a902.b_exploded) && var_e220a902.b_exploded)) {
            distsq = distancesquared(entity.origin, var_e220a902.origin);
            if (distsq < 300 * 300) {
                continue;
            }
            if (!util::within_fov(entity.origin, entity.angles, var_e220a902.origin, cos(90))) {
                continue;
            }
            var_e220a902 notify(#"tower_boss_scripted_trigger_tower");
        }
    }
}

elephant_melee(entity) {
    ShieldLog("melee");

    origin = entity gettagorigin("j_nose4");
    radiusdamage(origin, 700, 90, 60, entity);
    enemies = util::function_81ccf6d3(self.team);
    foreach (target in enemies) {
        dist = distance(self.origin, target.origin);
        if (isplayer(target) && dist < 550) {
            params = getstatuseffect(#"hash_2c80515d8ac9f1b4");
            weapon = getweapon("zombie_ai_defaultmelee");
            target status_effect::status_effect_apply(params, weapon, entity, 0, 500);
            var_7d97040b = vectornormalize(anglestoforward(target.origin - self.origin));
            target playerknockback(1);
            knockback = mapfloat(0, 450, 100, 500, dist);
            target applyknockback(int(knockback), var_7d97040b);
            target playerknockback(0);
            target dodamage(randomFloatRange(70, 150), self.origin);
        }
    }
    entity clientfield::increment("towers_boss_melee_effect");
}

dust_ball_shit(dustball) {
    ShieldLog("dust_ball_shit");

    enemies = util::function_81ccf6d3(self.team);
    foreach (target in enemies) {
        if (isplayer(target)) {
            distsq = distancesquared(dustball.origin, target.origin);
            if (distsq <= 550 * 550) {
                params = getstatuseffect(#"hash_12a64221f4d27f9b");
                weapon = getweapon(#"eq_molotov");
                target status_effect::status_effect_apply(params, weapon, dustball, 0, 3000, undefined, dustball.origin);
                target dodamage(randomFloatRange(30, 90), dustball.origin);
            }
        }
    }
}

elephant_ground_attack(entity, splitorigin) {
    ShieldLog("elephant_ground_attack");

    self endon(#"death");
    forwardvec = vectornormalize(anglestoforward(entity.angles));
    forwarddist = 1200;
    if (isdefined(splitorigin)) {
        launchpoint = splitorigin;
    } else {
        launchpoint = entity.origin + forwarddist * forwardvec;
    }
    closestpointonnavmesh = getclosestpointonnavmesh(launchpoint, 500, 200);
    if (isdefined(closestpointonnavmesh)) {
        trace = groundtrace(closestpointonnavmesh + (0, 0, 200), closestpointonnavmesh + (0, 0, -200), 0, undefined);
        if (isdefined(trace[#"position"])) {
            newpos = trace[#"position"];
        }
        dustball = spawnvehicle(#"hash_6be593a62b8b87a5", newpos, entity.angles, "dynamic_spawn_ai");
        if (isdefined(dustball)) {
            dustball.var_6353e3f1 = 1;
            entity.ai.var_f2d193df = gettime() + randomintrange(1000, 1800);
            if (isdefined(self.var_fe41477d) && self.var_fe41477d) {
                entity.ai.var_f2d193df = gettime() + 1500;
            }
        }
    } else {

    }
    wait 0.5;
    targets = getplayers();
    for (i = 0; i < targets.size; i++) {
        target = targets[i];
        if (![[ @archetypeelephant<scripts\core_common\ai\archetype_elephant.gsc>::is_player_valid ]](target, 1, 1) || ![[ @archetypeelephant<scripts\core_common\ai\archetype_elephant.gsc>::function_71790b86 ]](entity)) {
            arrayremovevalue(targets, target);
            break;
        }
    }
    if (targets.size == 0) {
        return;
    }
    if (targets.size > 1 && self.ai.phase == #"hash_266f56fb994e6639" && isdefined(dustball) && isalive(dustball) && !isdefined(splitorigin)) {
        [[ @archetypeelephant<scripts\core_common\ai\archetype_elephant.gsc>::function_ce8fe2b0 ]](self, dustball.origin);
    }
}

launch_elephant_proj(entity) {
    ShieldLog("launch_elephant_proj");

    //assert(isdefined(entity.ai.var_a05929e4));

    numProjectiles = 2;
    for (i = 0; i < numProjectiles; i++) {
        launchpos = entity gettagorigin("j_head");
        var_d82e1fd1 = entity gettagangles("j_head");
        landpos = entity.var_f6ea2286;
        if (!isdefined(landpos)) {
            landpos = entity.favoriteenemy.origin;
        }
        headproj = spawn("script_model", launchpos);
        headproj setmodel("tag_origin");
        vectorfromenemy = vectornormalize(entity.origin - landpos);
        vectorfromenemy = vectorscale(vectorfromenemy, 250);
        targetpos = landpos + vectorfromenemy + (0, 0, 200);
        headproj clientfield::set("towers_boss_head_proj_fx_cf", 1);
        trajectory = [];
        dirtotarget = targetpos - launchpos;
        var_f1c85329 = (0, 0, 30);
        var_62e75be4 = (0, 0, 200);
        trajectory[trajectory.size] = launchpos + dirtotarget * 0.85 + var_f1c85329;
        trajectory[trajectory.size] = launchpos + dirtotarget * 0.5 + var_62e75be4;
        trajectory[trajectory.size] = launchpos + dirtotarget * 0.15 + var_f1c85329;
        trajectory = array::reverse(trajectory);
        var_10b732dc = 0.25;
        foreach (point in trajectory) {
            headproj moveto(point, var_10b732dc);
            headproj waittill(#"movedone");
        }
        self playsound(#"hash_62894125ab280b62");
        self notify(#"hash_79e095919e415a70");
        if (isdefined(entity.ai.var_502d9d0d)) {
            [[ entity.ai.var_502d9d0d ]](entity, headproj);
        }

        wait 0.15;
    }
}

detour zm_ai_elephant<scripts\zm\ai\zm_ai_elephant.gsc>::function_d13a21cb(entity, projectile) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @zm_ai_elephant<scripts\zm\ai\zm_ai_elephant.gsc>::function_d13a21cb ]](entity, projectile);

    ShieldLog("function_d13a21cb");

    projectile endon(#"death");
    landpos = entity.var_f6ea2286;
    if (!isdefined(landpos)) {
        landpos = entity.favoriteenemy.origin;
    }
    projectile clientfield::set("towers_boss_head_proj_explosion_fx_cf", 1);
    enemyorigin = landpos + (0, 0, 300);
    physicsexplosionsphere(projectile.origin, 1000, 300, 400);
    numProjectiles = 20;
    for (i = 0; i < numProjectiles; i++) {
        randomdistance = randomintrange(0, 720);
        yaw = (360 / numProjectiles) * i; // full circle
        angles = (0, yaw, 0);
        dir = anglestoforward(angles) * randomdistance;
        var_c6b637a5 = landpos + dir;
        launchvelocity = vectornormalize(var_c6b637a5 - projectile.origin) * 2500;
        grenade = entity magicmissile(entity.ai.var_a05929e4, projectile.origin, launchvelocity);
        grenade thread [[ @zm_ai_elephant<scripts\zm\ai\zm_ai_elephant.gsc>::function_7d162bd0 ]](grenade);

        wait 0.1;
    }
    projectile clientfield::set("towers_boss_head_proj_fx_cf", 0);
    wait 0.1;
    projectile delete();
}

detour archetypeelephant<scripts\core_common\ai\archetype_elephant.gsc>::function_f51431a9(elephant) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @archetypeelephant<scripts\core_common\ai\archetype_elephant.gsc>::function_f51431a9 ]](elephant);

    ShieldLog("function_f51431a9");

    elephant endon(#"death");

    elephant thread MonitorHealthElephant();

    LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(elephant.health / elephant.maxhealth));

    LUINotifyEvent(#"notify_boss_name", 1, 9);

    while (true) {
        should_break_shield = elephant.health <= elephant.maxhealth * 0.1;
        should_die = elephant.health <= 10;
        currentstate = elephant.ai.var_112ec817;
        
        switch (currentstate) {
        case #"hash_8e170ae91588f20":
            if (should_die) {
                LUINotifyEvent(#"notify_boss_name", 1, 8);
                level thread [[ @archetypeelephant<scripts\core_common\ai\archetype_elephant.gsc>::elephantstartdeath ]](elephant);
                return;
            }
            break;
        case #"hash_8e173ae91589439":
            if (should_break_shield) {
                LUINotifyEvent(#"notify_boss_name", 1, 10);
                LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(elephant.health / elephant.maxhealth));
                elephant [[ @archetypeelephant<scripts\core_common\ai\archetype_elephant.gsc>::function_4d479d22 ]](elephant);

                LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(elephant.health / elephant.maxhealth));
                wait 0.5;
                LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(elephant.health / elephant.maxhealth));
                wait 0.5;
                LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(elephant.health / elephant.maxhealth));
            }
            break;
        }
        wait 1;
    }
}

arrow_throw_proj() {
    ShieldLog("arrow_throw_proj");

    //assert(isdefined(self.ai.spearweapon));

    for(i = 0; i < 3; i++)
    {
        forwarddir = anglestoforward(self.angles);
        var_a137cb9f = self gettagorigin("tag_weapon_right");
        if (isdefined(self.ai.var_c3f91959)) {
            var_eb549b4f = self.ai.var_c3f91959.origin;
            projectile = magicbullet(self.ai.spearweapon, var_a137cb9f, var_eb549b4f + (randomFloatRange(0, (100 * i) + 1.0), randomFloatRange(0, (100 * i) + 1.0), 0), self.ai.elephant);
        } else if (isdefined(self.ai.elephant.favoriteenemy)) {
            var_eb549b4f = self.ai.elephant.favoriteenemy.origin;
            projectile = magicbullet(self.ai.spearweapon, var_a137cb9f, var_eb549b4f + (randomFloatRange(0, (100 * i) + 1.0), randomFloatRange(0, (100 * i) + 1.0), 0), self.ai.elephant, self.ai.elephant.favoriteenemy);
        } else {
            return;
        }
        var_e15d8b1f = 2;
        if (self.ai.elephant.ai.var_112ec817 == #"hash_8e170ae91588f20") {
            var_e15d8b1f = 3;
        }
        projectile thread [[ @zm_ai_elephant<scripts\zm\ai\zm_ai_elephant.gsc>::function_7d162bd0 ]](projectile, var_e15d8b1f, self.ai.var_c3f91959);
        projectile thread [[ @zm_ai_elephant<scripts\zm\ai\zm_ai_elephant.gsc>::function_61d12301 ]](projectile);
        projectile thread [[ @zm_ai_elephant<scripts\zm\ai\zm_ai_elephant.gsc>::watch_for_death ]](projectile);
        if (self.var_c8ec4813) {
            self detach("p7_shr_weapon_spear_lrg", "tag_weapon_right");
            self.var_c8ec4813 = 0;
        }
    }
}

FasterElephant()
{
    level endon(#"end_game");
    self endon(#"death");

    while(true)
    {
        if (isDefined(self) && !isDefined(self.is_speed))
        {
            self asmsetanimationrate(1.20);

            if (isDefined(self.ai) && isDefined(self.ai.riders))
            {
                foreach(rider in self.ai.riders)
                {
                    rider asmsetanimationrate(1.45);
                }
            }

            self.is_speed = true;
        }

        wait 5;
    }
}

MonitorHealthElephant()
{
    self endon(#"death");

    self.last_damage_time = GetTime();
    self.white_bar_update_delay = 2.2; // seconds to wait after last damage

    if (!isdefined(self.monitor_white_bar_thread))
        self.monitor_white_bar_thread = self thread MonitorWhiteBarUpdateElephant();

    while(true)
    {
        self waittill(#"damage");

        wait 0.1;

        LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(self.health / self.maxhealth));

        // Update last damage time
        self.last_damage_time = GetTime();

        // Reset the white bar update thread if it's waiting
        if (isdefined(self.monitor_white_bar_thread))
        {
            self notify(#"reset_white_bar_timer");
        }

        wait 0.1;
    }
}

MonitorWhiteBarUpdateElephant()
{
    self endon(#"death");

    while(true)
    {
        self waittilltimeout(self.white_bar_update_delay, #"reset_white_bar_timer");

        // If timeout, update white bar
        if (GetTime() - self.last_damage_time >= self.white_bar_update_delay)
        {
            self UpdateHealthBarWhiteElephant();
        }
    }
}

UpdateHealthBarWhiteElephant()
{
    self endon(#"death");

    LUINotifyEvent(#"notify_boss_health_meter", 3, 1, ConvertNumToLUI(self.health / self.maxhealth), ConvertNumToLUI(self.health / self.maxhealth));
}

IX_Phase0Logic()
{
    level endon(#"boss_battle_done");
    
    level.var_263754a7 = randomintrangeinclusive(9, 20);
    var_e4a16c04 = array();
    var_671dac98 = array();
    var_e4a16c04[0] = getent("hell_gate_1_l", "targetname");
    var_e4a16c04[1] = getent("hell_gate_1_m", "targetname");
    var_e4a16c04[2] = getent("hell_gate_1_h", "targetname");
    var_671dac98[0] = getent("hell_gate_2_l", "targetname");
    var_671dac98[1] = getent("hell_gate_2_m", "targetname");
    var_671dac98[2] = getent("hell_gate_2_h", "targetname");
    switch (level.players.size) {
    case 1:
    default:
        n_wait_amount = 2.5;
        break;
    case 2:
        n_wait_amount = 1.66667;
        break;
    case 3:
        n_wait_amount = 1.25;
        break;
    case 4:
        n_wait_amount = 0.833333;
        break;
    }

    n_wait_amount = 0.5;

    level flag::set(#"infinite_round_spawning");

    level thread intro_scenes();
    wait 10;

    //link_kill = @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_2e309b5c;
    callback::on_ai_killed(&KillZombieIX);
    foreach (player in level.players) {
        //player clientfield::set_to_player("snd_crowd_react", 12);
        player [[ @zm_towers_challenges<scripts\zm\zm_towers_challenges.gsc>::function_fd8a137e ]]();
    }
    level thread scene::play("boss_battle_tempo", "targetname");
    level thread [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_432247a7 ]]();
    [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_c84b435 ]]();
    a_s_spawners = struct::get_array("boss_battle_spawns");
    a_s_spawners = arraycombine(a_s_spawners, struct::get_array("boss_temp_gate_tele", "targetname"), 0, 0);
    var_bfa27650 = [];
    foreach (s_spawn in a_s_spawners) {
        if (s_spawn.script_noteworthy === "gladiator_location") {
            if (!isdefined(var_bfa27650)) {
                var_bfa27650 = [];
            } else if (!isarray(var_bfa27650)) {
                var_bfa27650 = array(var_bfa27650);
            }
            if (!isinarray(var_bfa27650, s_spawn)) {
                var_bfa27650[var_bfa27650.size] = s_spawn;
            }
        }
    }

    check_ai = @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_94f7ef12;

    tigers_spawnpos = struct::get_array("s_zm_towers_port_to_boss", "targetname");

    while (true) {
        level.zombie_ai_limit = 30;

        if ((level.ai[#"axis"].size < level.var_ced6f061) && level.ShouldSpawnEnemies) {
            n_toggle = randomintrangeinclusive(0, 3);
            switch (n_toggle) {
            case 0:
                var_6454115e = array::random(var_bfa27650);
                level thread [[ @zombie_gladiator_util<scripts\zm_common\util\ai_gladiator_util.gsc>::function_69f309b ]](1, "melee", check_ai, 1, var_6454115e, max(25, level.round_number));
                break;
            case 1:
                var_6454115e = array::random(var_bfa27650);
                level thread [[ @zombie_gladiator_util<scripts\zm_common\util\ai_gladiator_util.gsc>::function_69f309b ]](1, "ranged", check_ai, 1, var_6454115e, max(25, level.round_number));
                break;
            case 2:
                for (i = 0; i < 2; i++) {
                    var_6454115e = [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_30868c0b ]](a_s_spawners, "tiger_location");
                    var_1c62893d = getspawnerarray("zombie_spawner_tiger", "targetname")[0];
                    ai = undefined;
                    while (!isdefined(ai)) {
                        ai = zombie_utility::spawn_zombie(var_1c62893d, "boss_filler", var_6454115e, max(25, level.round_number));
                        waitframe(1);
                    }
                    ai [[ @zm_towers_main_quest<scripts\zm\zm_towers_main_quest.gsc>::function_94f7ef12 ]](var_6454115e);
                    wait 0.5;
                    s_teleport = array::random(tigers_spawnpos);
                    ai forceteleport(s_teleport.origin);
                }
                break; 
            case 3:
                e_zombie = zombie_utility::spawn_zombie(getentarray("zombie_spawner", "script_noteworthy")[0], undefined, undefined, level.round_number);
                break;
            default:
                break;
            }
        }
        wait n_wait_amount;
    }
}

intro_scenes()
{
    level endon(#"hash_12768f75609d32ca", #"end_game");
    exploder::exploder("fxexp_boss_arena_gas_gate_1");
    exploder::exploder("fxexp_boss_arena_gas_gate_2");
    var_4ad6b8c9 = struct::get_array("s_s_r_s_b_b");
    foreach (s_loc in var_4ad6b8c9) {
        s_loc.var_7c5f8ec1 = util::spawn_model("tag_origin", s_loc.origin);
        s_loc.var_7c5f8ec1 thread [[ @zm_towers_special_rounds<scripts\zm\zm_towers_special_rounds.gsc>::function_85324f75 ]]();
    }
    scene::play("p8_fxanim_zm_towers_boss_arena_gate_raise_bundle", "Shot 1");
    wait 15;
    scene::play("p8_fxanim_zm_towers_boss_arena_gate_raise_bundle", "Shot 2");
    level flag::set(#"hash_353dcb95f778ad73");
    wait 15;
    scene::play("p8_fxanim_zm_towers_boss_arena_gate_raise_bundle", "Shot 3");
    level notify(#"hash_12768f75609d32ca");
}

KillZombieIX(s_params) {
    e_attacker = s_params.eattacker;
    v_origin = self.origin;
    if (!isplayer(e_attacker)) {
        return;
    }

    if (math::cointoss(15)) {
        random_power = array::random(array("full_ammo", "wolf_bonus_hero_power", "wolf_bonus_ammo", "wolf_bonus_points", "free_perk", "carpenter", "bonus_points_player"
        , "insta_kill", "hero_weapon_power", "nuke", "double_points"));

        zm_powerups::specific_powerup_drop(random_power, v_origin);
    }
}

ElephantCheckHighDamage(var_386e5658, s_info) // no high random damage / instakill bug
{
    //ShieldLog("^1Elephant Test -> Called");
    
    if (!isdefined(s_info) || self != var_386e5658) 
        n_damage = 0;
    else
    {
        n_damage = s_info.idamage;

        //ShieldLog("^2Elephant Test -> Checked -> " + n_damage);

        if (n_damage > 5000)
         return 5000;
    }

    return n_damage;
}

IX_Intro()
{
    while(zm_round_logic::get_round_number() < 255 && !GetDvarInt(#"shield_enh_DirectedMode", 0)) {
        ShieldLog("switch round");

        level thread zm_utility::zombie_goto_round(255);
        level thread zm_game_module::zombie_goto_round(255);

        level.var_43fb4347 = "super_sprint";

        wait 0.15;
    }

    wait 7;

    ShieldPlay(true, true, 60);

    wait 8;

    LUINotifyEvent(#"notify_boss_ui", 1, 8);

    music::setmusicstate("none");

    wait 3.5;

    foreach(player in level.players)
    {
        player bgb::take();
        player bgb_pack::function_ac9cb612(1);
        player bgb::suspend_weapon_cycling();
        player.bgb_disabled = 1;
    }

    music::setmusicstate("none");

    LUINotifyEvent(#"notify_boss_ui", 1, 9);

    LUINotifyEvent(#"notify_boss_name", 1, 8);
    LUINotifyEvent(#"notify_boss_health_meter", 2, 1, 100);

    zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", 3);

    level notify(#"start_debug_boxx");
}

IX_SetupHard()
{
    ShieldLog("^1Overriding Elephant Attacks Nodes..");

    level._notetrack_handler["towersboss_melee"] = &elephant_melee;
    level._notetrack_handler["towersboss_melee_big"] = &elephant_big_melee;
    level._notetrack_handler["launch_head_proj"] = &launch_elephant_proj;
    level._notetrack_handler["launch_head_proj2"] = &launch_elephant_proj;
    level._notetrack_handler["towers_boss_ground_attack"] = &elephant_ground_attack;

    level._animnotetrackhandlers["arrow_throw"][0] = array(&arrow_throw_proj, 0, array());

    level.var_c6001986 = &dust_ball_shit;

    // just in-case of delays
    wait 10;

    level._notetrack_handler["towersboss_melee"] = &elephant_melee;
    level._notetrack_handler["towersboss_melee_big"] = &elephant_big_melee;
    level._notetrack_handler["launch_head_proj"] = &launch_elephant_proj;
    level._notetrack_handler["launch_head_proj2"] = &launch_elephant_proj;
    level._notetrack_handler["towers_boss_ground_attack"] = &elephant_ground_attack;

    level._animnotetrackhandlers["arrow_throw"][0] = array(&arrow_throw_proj, 0, array());

    level.var_c6001986 = &dust_ball_shit;
}