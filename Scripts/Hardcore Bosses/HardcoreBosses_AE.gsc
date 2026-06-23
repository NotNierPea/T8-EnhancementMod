// detour red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::

function_3de660a0() {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_3de660a0 ]]();

    /*
    level.var_b2b15659 = 1;
    level.powerup_vo_available = &return_false;
    level zm_audio::function_6191af93(#"general", #"gib", "", "");
    level zm_audio::function_6191af93(#"elixir", #"drink", "", "");
    level zm_audio::function_6191af93(#"blight_father", #"weak_points", "", "");
    level zm_audio::function_6191af93(#"catalyst_transform", #"react", "", "");
    level zm_audio::function_6191af93(#"catalyst_water", #"react", "", "");
    level zm_audio::function_6191af93(#"catalyst_electric", #"react", "", "");
    level zm_audio::function_6191af93(#"catalyst_plasma", #"react", "", "");
    level zm_audio::function_6191af93(#"catalyst_corrosive", #"react", "", "");
    level zm_audio::function_6191af93(#"catalyst_corrosive", #"react", "", "");
    */

    thread AE_Intro();
    thread SpawningEnemiesLogic();
}

detour red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_d9802986() {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_d9802986 ]]();
    
    self notify("1e89b8ab1ad1c3c6");
    self endon("1e89b8ab1ad1c3c6");
    level endon(#"perseus_defeated", #"hash_7646638df88a3656");
    s_pinnacle = struct::get("s_pinnacle_center");
    e_perseus = level.s_boss_battle.mdl_perseus;
    b_target_found = 0;
    e_target = undefined;
    while (!b_target_found) {
        a_e_active_players = util::get_active_players(#"allies");
        a_e_active_players = array::randomize(a_e_active_players);
        if (a_e_active_players.size > 1) {
            foreach (e_active_player in a_e_active_players) {
                if (zm_utility::is_player_valid(e_active_player) && !(isdefined(e_active_player.var_16735873) && e_active_player.var_16735873) && e_perseus.var_56b1208a !== e_active_player && !e_active_player istouching(level.s_boss_battle.var_98ea549b)) {
                    e_target = e_active_player;
                }
            }
        } else {
            e_target = a_e_active_players[0];
        }
        if (!isdefined(e_target)) {
            wait 0.3;
            continue;
        }
        b_target_found = 1;
    }
    e_perseus.var_56b1208a = e_target;
    b_success = e_perseus [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_9e8c41f4 ]](e_target);
    if (isdefined(b_success) && b_success) {
        if (!isdefined(e_perseus.var_90e23166)) {
            e_perseus.var_90e23166 = 5;
        }
        if (!e_perseus.var_90e23166) {
            e_perseus thread zm_vo::vo_say(#"hash_7565b085198b71db", 0, 1, 9999);
            e_perseus.var_90e23166 = randomintrangeinclusive(8, 17);
        } else {
            e_perseus.var_90e23166--;
        }

        for(i = 0; i < 3; i++)
        {
            level thread chaos_bolt_thrower(e_target);
            e_perseus scene::play(#"aib_vign_cust_zm_red_boss1_stg1_chaos_atk_01", level.s_boss_battle.var_d82d0e73);

            wait 1;
        }
    } else {

    }

    wait 10;

    level notify(#"hash_47a15209e6e6fc14");
}

chaos_bolt_thrower(e_target) {
    e_perseus = level.s_boss_battle.mdl_perseus;
    v_target_pos = e_target.origin;
    if (level.s_boss_battle.n_stage != 4) {
        level waittill(#"artillery_out");
    }
    var_5f07628 = e_perseus gettagorigin("tag_weapon_right");
    if (isplayer(e_target)) {
        projectile = magicbullet(level.s_boss_battle.var_5db6ed5f, var_5f07628, v_target_pos, e_perseus);
        if (level.s_boss_battle.n_stage > 1) {
            projectile clientfield::set("" + #"hash_64910f94ebb8d66a", 2);
        } else {
            projectile clientfield::set("" + #"hash_64910f94ebb8d66a", 1);
        }
        b_annihilator = 0;
    } else {
        projectile = magicbullet(level.s_boss_battle.var_5db6ed5f, var_5f07628, v_target_pos, e_perseus);
        projectile clientfield::set("" + #"hash_64910f94ebb8d66a", 3);
        b_annihilator = 1;
    }

    projectile missile_settarget(e_target);
    
    s_result = projectile waittilltimeout(7, #"projectile_impact_explode", #"projectile_impact_player", #"projectile_impact");
    if (s_result._notify === #"timeout") {
        return;
    } else if (s_result._notify === #"projectile_impact_player") {
        if (isdefined(s_result.player)) {
            v_pos = getclosestpointonnavmesh(s_result.player.origin, 128, 16);
        }
    } else if (s_result._notify === #"projectile_impact_explode" || s_result._notify === #"projectile_impact") {
        if (isdefined(s_result.position)) {
            v_pos = getclosestpointonnavmesh(s_result.position, 128, 16);
        }
    }
    if (isdefined(v_pos)) {

        for(i = 0; i < 3; i++)
            SpawnBombProjectile(v_pos + (0, 0, 50), randomFloatRange(0.80, 1.50));

        playsoundatposition(#"hash_2a8cdf7d7ef28efe", v_pos);
        if (b_annihilator) {
            [[ @zm_aoe<scripts\zm_common\zm_aoe.gsc>::function_371b4147 ]](7, #"zm_aoe_chaos_bolt_annihilate", v_pos);
            return;
        }
        if ([[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_85593a2 ]](v_pos)) {
            return 0;
        }

        // 0-3
        switch (randomIntRange(0, 4)) {
        case 0:
        case 1:
            [[ @zm_aoe<scripts\zm_common\zm_aoe.gsc>::function_371b4147 ]](5, #"zm_aoe_chaos_bolt", v_pos);
            break;
        case 2:
        case 3:
            [[ @zm_aoe<scripts\zm_common\zm_aoe.gsc>::function_371b4147 ]](6, #"zm_aoe_chaos_bolt_2", v_pos);
            break;
        }
    }
}

detour red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_21ef9bb7(a_ents)
{
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_21ef9bb7 ]](a_ents);

    return function_21ef9bb7(a_ents);
}

function_21ef9bb7(a_ents) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_21ef9bb7 ]](a_ents);

    level endon(#"hash_4be6553c5ac0ec2b", #"boss_stunned", #"hash_6b4f82e61af7cb08");
    if (isarray(a_ents)) {
        a_keys = getarraykeys(a_ents);
        if (isinarray(a_keys, #"pegasus")) {
            e_boss = self.scene_ents[#"pegasus"];
            is_pegasus = 1;
            e_boss thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_8e7ffff8 ]]();
        } else if (isinarray(a_keys, #"boss_1")) {
            e_boss = self.scene_ents[#"boss_1"];
            is_pegasus = 0;
        }
    }
    if (!isdefined(e_boss)) {
        return;
    }
    e_boss endon(#"death");
    level thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_5fc81f0a ]](e_boss);
    e_boss.var_6f84b820 = #"boss";
    e_boss setteam("axis");
    target_set(e_boss);
    if (!function_ffa5b184(e_boss)) {
        e_boss function_2baad8fc();
    }

    if (!isDefined(level.reset_for_pegasus))
        level.reset_for_pegasus = false;

    players_size = (GetPlayers().size - 1);
    balance_health = 500000 + (players_size * 250000);

    // using level instead of self, gets reset everytime cause of scene::play
    if (!isDefined(level.health_phase))
    {
        level.health_phase = balance_health;
        level.health_phase_max = balance_health;
    }

    if (!is_pegasus && !level.reset_for_pegasus)
    {
        level.health_phase = balance_health;
        level.health_phase_max = balance_health;

        level.reset_for_pegasus = true;
    }

    if (!isDefined(level.cleared_island_2))
        level.cleared_island_2 = false;

    // enraged models
    if (is_pegasus)
    {
        if (level.health_phase < (200000 + (players_size * 150000)))
        {
            e_boss clientfield::set("" + #"special_target", 1);
            LUINotifyEvent(#"notify_boss_name", 1, 5);

            if (!level.cleared_island_2)
            {
                // might cause errors on boss_fight_done phase 2..
                level thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_79611ef0 ]](2);
                level.cleared_island_2 = true;
            }
        }
        else if (level.health_phase < (350000 + (players_size * 250000)))
        {
            e_boss setModel(#"hash_61790877a7f8e580");
            LUINotifyEvent(#"notify_boss_name", 1, 4);

            // first island
            if (!level flag::get(#"hash_15ba89b2357ff618"))
                level flag::set(#"hash_15ba89b2357ff618");
        }
        else
        {
            e_boss setModel(#"c_t8_zmb_dlc2_pegasus_fb");
            LUINotifyEvent(#"notify_boss_name", 1, 3);
        }

        if (level.health_phase < 0)
        {
            // first phase done
            level flag::set(#"hash_6dab61ca45a8eaea");
        }
    }
    else
    {
        if (level.health_phase < (250000 + (players_size * 200000)))
        {
            e_boss clientfield::set("" + #"special_target", 1);
            LUINotifyEvent(#"notify_boss_name", 1, 7);
        }

        if (level.health_phase < 0)
        {
            // first phase done
            level flag::set(#"hash_6dab61ca45a8eaea");

            // force a stun to end it
            level.s_boss_battle.var_ad3f929f = 9999999;
        }
    }

    // Track last damage time
    level.last_damage_time = GetTime();
    level.white_bar_update_delay = 2.2; // seconds to wait after last damage

    if (!isdefined(level.monitor_white_bar_thread))
        level.monitor_white_bar_thread = level thread MonitorWhiteBarUpdate();

    LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(level.health_phase / level.health_phase_max));
    
    while (true) {
        s_waitresult = e_boss waittill(#"damage", #"death");
        e_boss.health = 10000000;
        if (s_waitresult._notify === "death") {
            return;
        }
        e_attacker = s_waitresult.attacker;
        w_weapon = s_waitresult.weapon;
        n_damage = s_waitresult.amount;
        if (isdefined(e_attacker) && isplayer(e_attacker)) {
            e_boss [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_4c17036d ]](e_attacker);

            params = spawnstruct();
            params.einflictor = e_boss;
            params.idamage = n_damage;
            params.idflags = 0;
            params.smeansofdeath = undefined;
            params.weapon = w_weapon;
            params.vpoint = e_boss.origin;
            params.vdir = e_boss.origin;
            params.shitloc = e_boss.origin;
            params.vdamageorigin = e_boss.origin;
            params.psoffsettime = undefined;

            foreach(player in level.players)
            {
                params.eattacker = player;
                
                player callback::callback(#"on_ai_damage", params);
            }

            if (isdefined(w_weapon) && zm_weapons::is_wonder_weapon(w_weapon)) {
                n_damage *= 1.45;
            }

            if (isdefined(n_damage) && n_damage > 0) {
                
                // for phase 2 -> splash helion
                if (n_damage > 10000)
                {
                    n_damage = 10000;
                }

                level.health_phase -= n_damage;

                LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(level.health_phase / level.health_phase_max));

                // Update last damage time
                level.last_damage_time = GetTime();

                // Reset the white bar update thread if it's waiting
                if (isdefined(level.monitor_white_bar_thread))
                {
                    level notify(#"reset_white_bar_timer");
                }
            }
        }

        /*
        if (var_653b9351) {
            level.s_boss_battle.var_36f0e240 += s_waitresult.amount;
        } else if (zm_weapons::function_35746b9c(s_waitresult.weapon)) {
            level.s_boss_battle.var_ad3f929f += 50;
        } else {
            level.s_boss_battle.var_ad3f929f += s_waitresult.amount;
        }
        */

        // stun needed
        //level.s_boss_battle.var_ad3f929f = 20;
        //level.s_boss_battle.var_36f0e240 = 20;
    }
}

detour red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_b3df51ad(a_ents) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_b3df51ad ]](a_ents);

    level endon(#"hash_4be6553c5ac0ec2b", #"hash_7646638df88a3656");
    e_pegasus = self.scene_ents[#"pegasus"];
    e_pegasus.health = 100000;

    wait 3;

    while (true) {
        //level waittill(#"bombs_away");

        v_drop_point = e_pegasus zm_utility::groundpos(e_pegasus.origin);
        if (v_drop_point[2] > 600 && ![[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_85593a2 ]](v_drop_point)) {
            [[ @zm_aoe<scripts\zm_common\zm_aoe.gsc>::function_371b4147 ]](4, #"zm_aoe_strafe_storm", v_drop_point);
            e_pegasus thread SpawnBombProjectile(e_pegasus.origin, randomFloatRange(0.80, 1.50));
        }

        wait_t = 0.25;

        // enraged times
        if (level.health_phase < 200000)
        {
            wait_t = 0.11;
        }
        else if (level.health_phase < 350000)
        {
            wait_t = 0.16;
        }

        wait wait_t;
    }
}

// damage triggers
detour red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_b4723f8e(v_origin, e_pegasus) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_b4723f8e ]](v_origin, e_pegasus);

    mdl_origin = spawn("script_model", v_origin);
    mdl_origin setmodel("tag_origin");
    mdl_origin clientfield::set("" + #"pegasus_storm", 1);
    n_radius = 456;
    for (n_iterations = int(20); n_iterations > 0; n_iterations--) {
        foreach (e_player in getplayers()) {
            if (!isalive(e_player)) {
                continue;
            }
            n_radius_squared = n_radius * n_radius;
            if (distancesquared(e_player.origin, v_origin) < n_radius_squared) {
                e_player clientfield::set("" + #"hash_73e309ffb25bf63d", 1);
                e_player thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::lightning_flash ]]();
                e_player status_effect::status_effect_apply(level.s_boss_battle.var_86d9f46c, undefined, e_pegasus);
                e_player dodamage(70, v_origin);
            }
        }
        wait 0.5;
        if (n_radius < 1000) {
            n_radius = math::clamp(n_radius + 50, 256, 1000);
        }
    }
    mdl_origin clientfield::set("" + #"pegasus_storm", 0);
}

detour red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_325b6d95(v_origin) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_325b6d95 ]](v_origin);

    level endon(#"hash_7646638df88a3656");
    n_radius = 1500;
    n_iterations = int(20);
    w_fire = getweapon(#"incendiary_fire");
    while (n_iterations > 0) {
        foreach (e_player in getplayers()) {
            if (!isalive(e_player)) {
                continue;
            }
            n_radius_squared = n_radius * n_radius;
            if (distancesquared(e_player.origin, v_origin) < n_radius_squared) {
                e_player status_effect::status_effect_apply(level.s_boss_battle.var_b42f3b39, w_fire, level.s_boss_battle.mdl_perseus, 0);
                e_player dodamage(70, v_origin);
            }
        }
        wait 0.5;
        n_iterations--;
    }
}

detour zm_aoe<scripts\zm_common\zm_aoe.gsc>::function_bea2e288(type) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @zm_aoe<scripts\zm_common\zm_aoe.gsc>::function_bea2e288 ]](type);
    
    var_46f1b5eb = [[ @zm_aoe<scripts\zm_common\zm_aoe.gsc>::function_e969e75 ]](type);
    //assert(isdefined(var_46f1b5eb));
    players = getplayers();
    foreach (aoe in var_46f1b5eb.var_9a08bb02) {
        foreach (player in players) {
            //assert(isdefined(aoe.entity));
            dist = distance(aoe.entity.origin, player.origin);
            withinrange = dist <= var_46f1b5eb.radius;
            var_c0af03ae = 0;
            if (!withinrange) {
                continue;
            }
            heightdiff = abs(aoe.entity.origin[2] - player.origin[2]);
            if (heightdiff <= var_46f1b5eb.height) {
                var_c0af03ae = 1;
            }
            if (withinrange && var_c0af03ae) {
                damage = mapfloat(0, var_46f1b5eb.radius, var_46f1b5eb.damagemin, var_46f1b5eb.damagemax, dist);
                player dodamage(randomFloatRange(50, 100), aoe.entity.origin);
                player notify(#"aoe_damage", {#str_source:aoe.type, #origin:aoe.entity.origin});

                // only for ae
                if (isDefined(level.s_boss_battle) && isDefined(level.s_boss_battle.var_b42f3b39) && isDefined(level.s_boss_battle.mdl_perseus))
                {
                    w_fire = getweapon(#"incendiary_fire");
                    player status_effect::status_effect_apply(level.s_boss_battle.var_b42f3b39, w_fire, level.s_boss_battle.mdl_perseus, 0);
                }
            }
        }
    }
}

detour zm_aoe<scripts\zm_common\zm_aoe.gsc>::function_668a9b2d(aoe, type) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @zm_aoe<scripts\zm_common\zm_aoe.gsc>::function_668a9b2d ]](aoe, type);

    var_46f1b5eb = [[ @zm_aoe<scripts\zm_common\zm_aoe.gsc>::function_e969e75 ]](type);
    
    aoe.endtime += 35.0; // more lifetime of aoe..

    //assert(isdefined(var_46f1b5eb), "<dev string:x74>");
    array::add(var_46f1b5eb.var_9a08bb02, aoe);
    //assert(var_46f1b5eb.var_9a08bb02.size <= var_46f1b5eb.var_3a11a165);
}

function_517bbfad(var_2f02900b) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_517bbfad ]](var_2f02900b);

    level endon(#"end_game");
    //level flag::clear("spawn_zombies");

    on_kill = @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_a362f6ed;
    on_spawn = @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_5e02e791;

    callback::on_ai_killed(on_kill);
    callback::on_ai_spawned(on_spawn);

    level scene::play("column_miniboss_ent", "targetname");
    if (var_2f02900b > 1) {
        level thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_9d06f858 ]](#"hash_1bc4862b9138d947");
        level thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_9d06f858 ]](#"hash_3f87a91683ebe8e3");
    }
    level flag::set("spawn_zombies");
    while (level.s_boss_battle.var_dc656db3 < var_2f02900b) {
        waitframe(1);
    }

    callback::remove_on_ai_killed(on_kill);
    callback::remove_on_ai_spawned(on_spawn);

    level flag::set(#"hash_315fae99adaebfb4");
}

// pegasus attacking
detour red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_7a7b5e79() {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_7a7b5e79 ]]();
    
    level endon(#"boss_stage_1_done", #"hash_7646638df88a3656");
    times = 0;
    var_22f02aa3 = struct::get_array("boss_attack_1");

    first_time = false;

    while (isDefined(struct::get("first_strike", "script_string"))) {

        if (!first_time)
        {
            s_loc = struct::get("first_strike", "script_string");

            first_time = true;
        }
        else
            s_loc = undefined;

        while (level flag::get(#"hash_7be183aa6a4cbe7") || level flag::get(#"hash_6dab61ca45a8eaea")) {
            wait 1;
        }

        level flag::set(#"pegasus_attacking");

        //filter = @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_a695c70b;
        var_22f02aa3 = array::filter(var_22f02aa3, 0, &filter_islands);
        if (!isdefined(s_loc)) {
            s_loc = array::random(var_22f02aa3);
        }
        if (isdefined(level.s_boss_battle.var_5de58d03) && level.s_boss_battle.var_5de58d03) {
            s_loc = var_22f02aa3[0];
        }
        s_loc [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_b8510127 ]]();
        wait 1.1;
        s_loc thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_ca661e4b ]](0, times);
        s_loc [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_1ce83bec ]]();
        level flag::clear(#"pegasus_attacking");
        times++;
        wait 1.5;
    }
}

// TODO: check it again, he still might attack on other islands in phase 3
filter_islands(s_loc) {
    if (s_loc.script_int === 1 && level flag::get(#"hash_75d9474065de2230")) {
        return false;
    }

    if (s_loc.script_int === 2 && level.health_phase < 200000) {
        return false;
    }

    return true;
}

// persus
detour red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_4a58a0(e_perseus) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_4a58a0 ]](e_perseus);

    level endon(#"hash_71d7e6a55a1ca9e", #"hash_7646638df88a3656");
    /#
        if (getdvarint(#"zm_debug_ee", 0)) {
            e_perseus thread function_213d02bd();
        }
    #/
    s_target = array::random(level.s_boss_battle.var_5203fa2b);
    v_destination = s_target.origin;
    if (!isdefined(e_perseus.var_cd1eedcd) || !e_perseus.var_cd1eedcd) {
        if (!isdefined(e_perseus.var_8ba6a643)) {
            e_perseus.var_8ba6a643 = 0;
        }
        var_10b0c19e = e_perseus.var_8ba6a643 - level.s_boss_battle.var_5dc26e42;
        if (var_10b0c19e < 0) {
            e_perseus thread zm_vo::vo_say(#"hash_4690d77cb085e0c8", 0, 1, 9999);
            e_perseus.var_cd1eedcd = randomintrangeinclusive(3, 7);
            e_perseus.var_8ba6a643 = level.s_boss_battle.var_5dc26e42;
        }
    } else {
        e_perseus.var_cd1eedcd--;
    }
    level thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::perseus_teleport_fx ]](v_destination);
    e_perseus scene::play(#"aib_vign_cust_zm_red_boss1_stg3_teleport_start_01", level.s_boss_battle.var_d82d0e73);
    e_perseus.origin = v_destination;
    e_perseus.angles = s_target.angles;
    level thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_766fb0b1 ]](e_perseus.origin);
    level thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::perseus_teleport_fx ]]((20323.7, 21819.1, 1419.25));

    e_perseus scene::play(#"hash_732e3b38ca890511", "start", level.s_boss_battle.var_d82d0e73);
    if (level.s_boss_battle.var_ad3f929f >= level.s_boss_battle.var_1e4f5dab) {
        level thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_14833fc2 ]]();
        level notify(#"hash_6b4f82e61af7cb08");
        level thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_84fac8d5 ]](3, 1);
        e_perseus thread scene::play(#"hash_732e3b38ca890511", "fail_start", level.s_boss_battle.var_d82d0e73);
        var_c5374ab4 = 3;
        if (getdvarint(#"zm_debug_ee", 0)) {
            if (getdvarint(#"hash_3031043ff4ac0395", 0)) {
                var_c5374ab4 = 60;
            }
        }
        wait var_c5374ab4;
        if (level flag::get(#"hash_6dab61ca45a8eaea")) {
            level notify(#"perseus_defeated");
            e_perseus thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_caa7eeb ]]();
            level flag::wait_till(#"hash_1c0b421abe38d4e0");
            foreach (player in getplayers()) {
                if (isdefined(player) && player clientfield::get_to_player("" + #"hash_403e80cafccc207c")) {
                    player clientfield::set_to_player("" + #"hash_403e80cafccc207c", 0);
                }
            }
            level thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_ce82050b ]]();
            level notify(#"hash_71d7e6a55a1ca9e");
        }
        e_perseus scene::play(#"hash_732e3b38ca890511", "fail_end", level.s_boss_battle.var_d82d0e73);
        level notify(#"hash_4d25b32acbac5117");
        level.s_boss_battle.var_ad3f929f = 0;
    } else {
        e_perseus scene::play(#"hash_732e3b38ca890511", "atk_end", level.s_boss_battle.var_d82d0e73);
        e_perseus scene::play(#"hash_732e3b38ca890511", "start", level.s_boss_battle.var_d82d0e73);
        e_perseus scene::play(#"hash_732e3b38ca890511", "atk_end", level.s_boss_battle.var_d82d0e73);
        e_perseus scene::play(#"hash_732e3b38ca890511", "start", level.s_boss_battle.var_d82d0e73);
        e_perseus scene::play(#"hash_732e3b38ca890511", "atk_end", level.s_boss_battle.var_d82d0e73);
    }
    e_perseus.origin = level.s_boss_battle.s_pinnacle.origin;
    e_perseus.angles = (0, 90, 0);
    level notify(#"hash_78452700119fc913");
}

// his bullets?
detour red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_2a866d1a(a_ents) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_2a866d1a ]](a_ents);
    
    level endon(#"end_game");
    e_perseus = level.s_boss_battle.mdl_perseus;
    var_5287d229 = anglestoforward(e_perseus.angles);

    n_times = 25;

    if (level.health_phase < 250000)
    {
        n_times = 40;
    }

    yaw_step = 360 / n_times;

    for (i = 0; i < n_times; i++) {
        n_yaw = yaw_step * i;  // evenly space around 360
        var_bbaa9da2 = e_perseus.angles + (0, n_yaw, 0);
        v_direction = anglestoforward(var_bbaa9da2);

        v_target_loc = e_perseus.origin + v_direction;
        launchvelocity = vectornormalize(v_target_loc - e_perseus.origin) * 2000;

        projectile = e_perseus magicmissile(level.s_boss_battle.var_5db6ed5f, v_target_loc + (16, 0, 54), launchvelocity);
        projectile clientfield::set("" + #"hash_64910f94ebb8d66a", 3);
    }
}

// from classic mode detour's, probably used only when he is down? pegusus
damage_logic_ae(notify_var, e_boss) {
    level endon(#"hash_4d25b32acbac5117", #"hash_7646638df88a3656");
    self endon(#"death");

    ShieldLog("starting damage return: " + notify_var);

    // probably will never run anyways
    return;

    if (!isDefined(self.health_phase))
    {
        self.health_phase = 500000;
        self.health_phase_max = 500000;
    }

    // Track last damage time
    self.last_damage_time = GetTime();
    self.white_bar_update_delay = 2.2; // seconds to wait after last damage

    if (!isdefined(self.monitor_white_bar_thread))
        self.monitor_white_bar_thread = self thread MonitorWhiteBarUpdate();

    LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(self.health_phase / self.health_phase_max));

    while (true) {
        s_waitresult = self waittill(notify_var);

        ShieldLog("got damage");

        self.health = 10000000;
        if (notify_var == #"damage") {
            e_attacker = s_waitresult.attacker;
            w_weapon = s_waitresult.weapon;
            n_damage = s_waitresult.amount;
        } 
        else
        {
            continue;
        }

        if (isdefined(n_damage) && n_damage > 0) {
            self thread [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_4c17036d ]](e_attacker, true);

            self.health_phase -= n_damage;

            LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(self.health_phase / self.health_phase_max));

            // Update last damage time
            self.last_damage_time = GetTime();

            // Reset the white bar update thread if it's waiting
            if (isdefined(self.monitor_white_bar_thread))
            {
                self notify(#"reset_white_bar_timer");
            }
                    
            /#
            if (level.s_boss_battle.var_5dc26e42 >= var_391b5374) {
                level flag::set(#"hash_6dab61ca45a8eaea"); // used twice for both of them
            }
            if (isdefined(e_attacker) && isplayer(e_attacker)) {
                self function_4c17036d(e_attacker, 1); // hit marker
            }
            #/
        }
    }
}

AE_Intro()
{
    while(zm_round_logic::get_round_number() < 215 && !GetDvarInt(#"shield_enh_DirectedMode", 0)) {
        ShieldLog("switch round");

        level thread zm_utility::zombie_goto_round(215);
        level thread zm_game_module::zombie_goto_round(215);

        level.var_43fb4347 = "super_sprint";

        wait 0.15;
    }

    LUINotifyEvent(#"notify_boss_ui", 1, 6);

    music::setmusicstate("none");

    wait 3.5;

    ShieldPlay(true, true, 3);

    foreach(player in level.players)
    {
        player bgb::take();
        player bgb_pack::function_ac9cb612(1);
        player bgb::suspend_weapon_cycling();
        player.bgb_disabled = 1;
    }

    music::setmusicstate("none");

    LUINotifyEvent(#"notify_boss_ui", 1, 7);

    LUINotifyEvent(#"notify_boss_name", 1, 3);
    LUINotifyEvent(#"notify_boss_health_meter", 2, 1, 100);

    zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", 16);

    level waittill(#"boss_stage_1_done");

    ShieldStopAllMusics();

    wait 5;

    LUINotifyEvent(#"notify_boss_ui", 1, 6);

    level notify(#"stop_elixir_watcher");

    wait 1;

    LUINotifyEvent(#"notify_boss_name", 1, 6);
    LUINotifyEvent(#"notify_boss_health_meter", 2, 1, 100);

    ShieldPlay(true, true, 4);

    foreach (player in getplayers()) {
        player bgb_pack::function_ac9cb612(0);
        player bgb::resume_weapon_cycling();
        player.bgb_disabled = 0;
    }

    wait 2.5;

    LUINotifyEvent(#"notify_boss_ui", 1, 7);

    wait 2;

    zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", 16);

    level waittill(#"perseus_defeated");

    // stop music
    ShieldStopAllMusics();
}

SpawningEnemiesLogic()
{
    level endon(#"end_game");

    wait 5;

    level.DelaySpawn = false;

    thread ZombieSpawningLogic();
    thread MiniBossSpawningLogic();
    thread DelayWatcher();
    thread ElixirWatcher();

    zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", 16);
}

ElixirWatcher()
{
    level endon(#"end_game", #"stop_elixir_watcher");

    while(true)
    {
        foreach(player in level.players)
        {
            player bgb::take();
            player bgb_pack::function_ac9cb612(1);
            player bgb::suspend_weapon_cycling();
            player.bgb_disabled = 1;
        }

        wait 0.5;
    }
}

ZombieSpawningLogic()
{
    level endon(#"end_game");

    while(true)
    {
        level.zombie_ai_limit = 33;
        level.var_5d1805c4 = undefined; // no 255 hp scaling please

        while (getaiteamarray(level.zombie_team).size >= 33 || level.DelaySpawn)
            util::wait_network_frame();

        e_zombie = zombie_utility::spawn_zombie(getentarray("zombie_spawner", "script_noteworthy")[0], undefined, undefined, level.round_number);

        if (isDefined(e_zombie))
            e_zombie thread LifeZombieTime();

        wait 1.5;
    }
}

DelayWatcher()
{
    level endon(#"end_game");
    
    level waittill(#"boss_stage_1_done");

    level.DelaySpawn = true;

    wait 15;

    level.DelaySpawn = false;
}

LifeZombieTime()
{
    self endon(#"death");

    wait randomFloatRange(10, 25);

    self clientfield::increment("" + #"zombie_delete");
    self val::set("cleanup_zombie", "ignoreall", 1);
    wait 0.5;
    self delete();
}

MiniBossSpawningLogic()
{
    level endon(#"end_game");
    
    while(true)
    {
        if (level.DelaySpawn)
        {
            wait 5;
            continue;
        }
        
        if (math::cointoss(60)) {
            if ([[ @zm_ai_blight_father<scripts\zm\ai\zm_ai_blight_father.gsc>::function_858c7fa5 ]]()) {
                zm_transform::function_bdd8aba6(#"blight_father");
                s_waitresult = level waittilltimeout(10, #"transformation_complete");
                if (s_waitresult._notify != "timeout") {
                    [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_8b1f9518 ]]();
                }
            }
            return;
        }
        
        if ([[ @zombie_gegenees_util<scripts\zm_common\util\ai_gegenees_util.gsc>::function_48c60fc2 ]]()) {
            str_scene = array::random(level.s_boss_battle.var_2624492f);
            level scene::play(str_scene, "targetname");
            [[ @red_boss_battle<scripts\zm\zm_red_boss_battle.gsc>::function_8b1f9518 ]]();
        }

        wait 45;
    }
}