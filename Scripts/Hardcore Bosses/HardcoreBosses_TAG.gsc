// (-1776.19, 521.319, 241.643)
// level.var_5d5b7e8e.var_a41818b5
detour namespace_4b68b2b3<script_4b80fc97d8469299>::function_3c9be590(var_5ea5c94d, ended_early) {
    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return [[ @namespace_4b68b2b3<script_4b80fc97d8469299.gsc>::function_3c9be590 ]](var_5ea5c94d, ended_early);

    foreach(player in level.players)
    {
        //player iPrintLnBold("hardcore boss enter..");
    }

    while(zm_round_logic::get_round_number() < 255 && !GetDvarInt(#"shield_enh_DirectedMode", 0)) {
        ShieldLog("switch round");

        level thread zm_utility::zombie_goto_round(255);
        level thread zm_game_module::zombie_goto_round(255);

        wait 0.15;
    }

    level notify(#"rampage_off");

    level.zombie_vars["zombie_max_ai"] = 40;
    level.zombie_ai_limit = 40;
    level.zombie_actor_limit = 40;

    level.disable_nuke_delay_spawning = 1;
    level.zombie_round_start_delay = 0;

    level.zombie_vars["zombie_spawn_delay"] = 0; // zombies delay remove 0
    level.zombie_vars["zombie_between_round_time"] = 0; // 3enh_achv_hardcore_tag

    zombie_utility::set_zombie_var(#"zombie_spawn_delay", 0);
    zombie_utility::set_zombie_var(#"zombie_between_round_time", 0);

    // super sprint mode
    level.var_43fb4347 = "super_sprint";

    level.musicsystemoverride = 1;

    playsoundatposition(#"hash_431cadb65b1777ce", (0, 0, 0));
    level thread lui::screen_flash(0.4, 2, 0.8, 1, "white");
    playsoundatposition(#"evt_nuke_flash", (0, 0, 0));

    wait .5;
    foreach(player in level.players)
    {
        player dontinterpolate();
        player SetRandomOrigin((-1097.6, 589.722, 4.21355));

        player bgb::take();
        player bgb_pack::function_ac9cb612(1);
        player bgb::suspend_weapon_cycling();
        player.bgb_disabled = 1;
    }

    LUINotifyEvent(#"notify_boss_ui", 1, 4);
    
    wait 0.5;

    if (var_5ea5c94d || ended_early) {
        level.var_50b3f446 = 1;
        level notify(#"hash_5266a594b96823e2");
        level.var_b2b15659 = 1;
    }

    foreach (s_challenge_station in level.a_s_challenge_stations) {
        s_challenge_station.b_is_active = 0;
        s_challenge_station [[ @zm_orange_challenges<scripts\zm\zm_orange_challenges.gsc>::function_fd8a137e ]]();
    }
    
    level flag::clear(#"hash_3028604821838259");

    // clear this later
    //[[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::pause_zombies ]](1, 0);

    level flag::set(#"disable_special_rounds");
    [[ @zm_orange_mq_hell<scripts\zm\zm_orange_mq_hell.gsc>::spawn_guide ]]();
    [[ @zm_orange_lighthouse<scripts\zm\zm_orange_lighthouse.gsc>::function_da304f6e ]](0);

    level thread SpawnBlockersTag();
    level thread RingZombies();

    level.var_5d5b7e8e.var_a41818b5.origin = (-1776.19, 521.319, 241.643);
    level.var_5d5b7e8e.var_a41818b5 val::set(#"mq_hell", "takedamage", 0);
    level.var_5d5b7e8e.var_a41818b5 thread MoveAroundArti();

    wait 0.5;

    // lava
    [[ @zm_orange_mq_hell<scripts\zm\zm_orange_mq_hell.gsc>::lava_control ]]();
    level.var_5d5b7e8e.var_5ca15e11 show();
    level.var_5d5b7e8e.var_5ca15e11 solid();

    level clientfield::set("" + #"hash_5e69ee96304ec40b", 1);
    level clientfield::set("" + #"hash_72b5b0359ca48427", 1);

    array::thread_all(level.var_35e33dbe, &RocknRoll);
    level.func_get_delay_between_rounds = @zm_orange_mq_hell<scripts\zm\zm_orange_mq_hell.gsc>::no_delay;

    level flag::set(#"infinite_round_spawning");
    level flag::set(#"hell_on_earth");
    level flag::set(#"hash_69a9d00e65ee6c40");

    level.var_5d5b7e8e.var_a41818b5 clientfield::set("" + #"lantern_fx", 1);
    //level.var_5d5b7e8e.var_a41818b5.mdl_lantern clientfield::set("" + #"lantern_outline", 0); // not a teammate anymore lool, there is no fucking anything for that 0 in the csc side..
    level.var_5d5b7e8e.var_a41818b5.mdl_lantern clientfield::set("winters_wail_slow_field_eye", 1);

    // ring
    level.var_5d5b7e8e.var_a41818b5.e_ring = util::spawn_model("p8_fxp_hell_sphere", level.var_5d5b7e8e.var_a41818b5.origin);
    level.var_5d5b7e8e.var_a41818b5.e_ring linkto(level.var_5d5b7e8e.var_a41818b5);
    level.var_5d5b7e8e.var_a41818b5.e_ring thread RingWatcher();

    wait 1;

    level.var_5d5b7e8e.var_a41818b5 clientfield::increment("" + #"lantern_explode_fx", 1);
    level.var_5d5b7e8e.var_a41818b5 clientfield::set("" + #"lantern_fx", 3);

    // hitbox
    level.hitbox_arti = util::spawn_model(#"p7_zm_vending_widows_wine", level.var_5d5b7e8e.var_a41818b5.origin, (0, 0, 0));
    level.hitbox_arti linkTo(level.var_5d5b7e8e.var_a41818b5);
    level.hitbox_arti thread MonitorDamageArti();

    // music, first phase one
    music::setmusicstate("none");
    ShieldPlay(true, true, 91);

    // again
    foreach(player in level.players)
    {
        player bgb::take();
        player bgb_pack::function_ac9cb612(1);
        player bgb::suspend_weapon_cycling();
        player.bgb_disabled = 1;
    }

    wait 3;
    LUINotifyEvent(#"notify_boss_ui", 1, 5);

    // again
    foreach(player in level.players)
    {
        player bgb::take();
        player bgb_pack::function_ac9cb612(1);
        player bgb::suspend_weapon_cycling();
        player.bgb_disabled = 1;
    }

    // and fucking again
    foreach(player in level.players)
    {
        player bgb::take();
        player bgb_pack::function_ac9cb612(1);
        player bgb::suspend_weapon_cycling();
        player.bgb_disabled = 1;
    }

    // end
    level waittill(#"end_boss_fight");
    [[ @zm_orange_mq_hell<scripts\zm\zm_orange_mq_hell.gsc>::function_737be926 ]]();

    // ? wait for pick then continue the quest as normal hopefully????
    level thread OverrideQuest(#"main_quest", #"hash_7d78cef11f6afb5e", &FreeSkipClean, &FreeSkipClean);
    level.hitbox_arti delete();
    
    level flag::wait_till(#"hash_621acea2fedc0408");

    // delete the ring
    level.var_5d5b7e8e.var_a41818b5.e_ring delete();

    LUINotifyEvent(#"notify_boss_name", 1, 0);
    LUINotifyEvent(#"notify_boss_health_meter", 1, 0);

    // activate ziplines
    level flag::set(#"hash_7d9f8ec3cb9af87e");
    level flag::set(#"facility_available");
    level flag::set(#"hash_7d230fa8f283c105");
    level flag::set(#"hash_7def3e555eba842c");
    level flag::set(#"hash_e29d662bb90e4bc");
    level flag::clear(#"hell_on_earth");
}

RingZombies()
{
    level endon(#"end_boss_fight");

    while(true)
    {
        a_ai_zombies = zombie_utility::get_zombie_array();
        a_zombie = array::random(a_ai_zombies);

        if(isDefined(a_zombie) && !isDefined(a_zombie.e_ring))
            a_zombie thread AddRingZombie();

        wait randomFloatRange(5, 15);
    }
}

AddRingZombie()
{
    self endoncallback(&RingDelete, #"death");

    self.e_ring = util::spawn_model("p8_fxp_hell_sphere", self.origin + (0, 0, 50));
    self.e_ring setscale(0.70);
    self.e_ring linkto(self);

    self.ignore_nuke = 1;
    self.b_ignore_cleanup = 1;
    self.takedamage = 0;

    wait randomFloatRange(10, 25);

    if (isDefined(self.e_ring))
        self.e_ring delete();

    if(isDefined(self))
    {
        // end
        self.takedamage = 1;
        self.ignore_nuke = 0;
        self.b_ignore_cleanup = 0;
    }
}

RingDelete(notify_var)
{
    if(isDefined(self) && isDefined(self.e_ring))
        self.e_ring delete();
}

GetAttackTimeArti()
{
    if (self.PhaseTrigger)
        return 3.35;

    return 6.0;
}

GetSwitchTimeArti()
{
    if (self.PhaseTrigger)
        return 6.5;

    return 10.0;
}

MoveAroundArti()
{
    level endon(#"end_game");
    self endon(#"death", #"stop_attack");

    ShieldLog("^1artimove..");

    self.IsAttacking = false;  
    self.PhaseTrigger = false;
    self.StopShit = false;

    // effects around it
    //playFXOnTag(#"zm_weapons/fx8_equip_mltv_fire_human_torso_loop_zm", self, "tag_origin");

    while(true)
    {
        // Pick a random player
        players = ReturnValidPlayers();
        if(players.size > 0)
        {
            target_player = players[randomint(players.size)];

            // Set parameters for the orbit
            orbit_radius = self.PhaseTrigger ? 650 : 1000; // very far
            orbit_height = 300; // base height above ground
            orbit_speed = 40.0; // degrees per frame

            // Bobbing parameters
            bob_amplitude = 150; // how much to bob up/down
            bob_speed = 120.0; // how fast to bob

            // Pick a random starting angle
            angle = randomfloat(360);

            // Time to next player switch
            switch_time = randomfloatrange(1, 5);
            switch_timer = 0;

            attack_time_max = self GetAttackTimeArti();
            attack_time = randomfloatrange(1, attack_time_max);
            attack_timer = 0;

            bob_time = 0;

            orbit_dir = 1; // 1 = counterclockwise, -1 = clockwise
            switch_dir_time_max = self GetSwitchTimeArti();
            switch_dir_time = randomfloatrange(5, switch_dir_time_max); // how often it may switch
            switch_dir_timer = 0;

            // Orbit logic
            while(isdefined(target_player) && isdefined(self))
            {
                if ((isDefined(self.DoingAnimation) && self.DoingAnimation) || self.StopShit)
                {
                    wait 0.01;
                    continue;
                }
                
                // Update player origin in case they move
                player_origin = target_player.origin;
                orbit_pos_init = self.PhaseTrigger ? (1349.46, 3480.45, 364.4) : (-1776.19, 521.319, 241.643); // dont use player's, just mid-point

                // Calculate new position around the player in a circle
                radians = angle * (3.14159265 / 180);
                offset_vec = (cos(radians) * orbit_radius, sin(radians) * orbit_radius, orbit_height);

                // Bobbing calculation
                bob_offset = bob_amplitude * sin(bob_time * bob_speed);
                orbit_pos = orbit_pos_init + offset_vec + (0, 0, bob_offset);

                // Move the boss eye to the new position
                self.origin = orbit_pos;

                // Look at the player
                //self.angles = vectortoangles(player_origin - self.origin);

                // Increment angle for next frame
                angle += orbit_speed * orbit_dir;

                // Increment timers
                switch_timer += 0.01;
                attack_timer += 0.01;
                bob_time += 0.01;

                // Switch player if needed
                if(switch_timer >= switch_time)
                {
                    players = ReturnValidPlayers();
                    if(players.size > 0)
                        target_player = players[randomint(players.size)];
                    switch_time = randomfloatrange(1, 5);
                    switch_timer = 0;
                }

                // Attack if needed
                if(attack_timer >= attack_time)
                {
                    // Perform attack on the player, no threading
                    self PerformAttackArti(target_player, randomIntRange(0, 4));

                    attack_time_max = self GetAttackTimeArti();
                    attack_time = randomfloatrange(1, attack_time_max);
                    attack_timer = 0;
                }

                switch_dir_timer += 0.01;
                if(switch_dir_timer >= switch_dir_time)
                {
                    orbit_dir *= -1; // flip direction
                    switch_dir_timer = 0;
                    switch_dir_time_max = self GetSwitchTimeArti();
                    switch_dir_time = randomfloatrange(5, switch_dir_time_max); // randomize next flip
                }

                wait 0.01;
            }
        }

        wait 1;
    }
}

PerformAttackArti(player, attack_id)
{
    self endon(#"death", #"stop_attack");

    if(!isdefined(player) || !isdefined(attack_id))
        return;

    self playsound(#"hash_1af3a3933941d01a");

    ShieldLog("going for attack " + attack_id);

    // debug
    //attack_id = 3;

    self.IsAttacking = true;

    switch(attack_id)
    {
        case 0:
            // follow a target player to damage him if its near
            wait 0.50;

            self.old_origin = self.origin;
            self.FollowPlayer = player;

            n_times_to_move = randomIntRange(7, 14);
            n_time_to_move = 2;

            if (self.PhaseTrigger)
            {
                n_times_to_move = randomIntRange(12, 20);
                n_time_to_move = 1;
            }

            // (0, 0, 35) offset needed for player
            for (i = 0; i < n_times_to_move; i++)
            {
                if (isdefined(self.FollowPlayer) && zm_utility::is_player_valid(self.FollowPlayer)) 
                {
                    v_target = self.FollowPlayer.origin;
                    steps = 60; // Increased steps for smoother motion
                    wait_time = n_time_to_move / steps;
                    
                    for(j = 1; j <= steps; j++)
                    {
                        fraction = j / steps;
                        // Using lerp for smoother interpolation
                        next_pos = self.origin * (1 - fraction) + (v_target + (0, 0, 35)) * fraction;
                        self.origin = next_pos;
                        wait 0.006; // Locked to ~60fps for consistency
                    }
                }
                else
                    break;
            }

            // Return smoothly
            steps = 60; // Increased steps for return motion
            total_return_time = 0.75;
            wait_time = 0.016; // ~60fps

            start_pos = self.origin;
            for(j = 1; j <= steps; j++)
            {
                fraction = j / steps;
                // Smooth easing function
                ease_fraction = 1 - ((1 - fraction) * (1 - fraction));
                next_pos = start_pos * (1 - ease_fraction) + (self.old_origin + (0, 0, 35)) * ease_fraction;
                self.origin = next_pos;
                wait wait_time;
            }
            
            wait 0.15;
        break;

        case 1:
            // spin attack: go to the middle, spin, then dash to random points near the middle while spinning, throwing stuff too
            ShieldLog("starting spin attack");

            // Move to the middle point
            middle_point = self.PhaseTrigger ? (1349.46, 3480.45, 364.4) : (-1776.19, 521.319, 241.643);
            self.old_origin = self.origin;

            steps = 60;
            total_return_time = 0.75;
            wait_time = 0.016;

            start_pos = self.origin;
            for(j = 1; j <= steps; j++)
            {
                fraction = j / steps;
                ease_fraction = 1 - ((1 - fraction) * (1 - fraction));
                next_pos = start_pos * (1 - ease_fraction) + (middle_point + (0, 0, 35)) * ease_fraction;
                self.origin = next_pos;
                wait wait_time;
            }

            wait 0.75;

            spin_time = randomfloatrange(1.0, 2.0);
            spin_speed = 720;
            elapsed = 0;

            time_grenade = 0.0;
            time_grenade_throw = 0.10;
            
            if (self.PhaseTrigger)
            {
                time_grenade_throw = 0.06;
            }

            while (elapsed < spin_time)
            {
                if (time_grenade < time_grenade_throw)
                {
                    time_grenade += 0.01;
                }
                else
                {
                    // throw something
                    self thread SpawnFreezeProjectile(self.origin, randomFloatRange(-1.85, 1.85));
                    time_grenade = 0.0;
                }

                elapsed += 0.01;
                wait 0.01;
            }

            num_dashes = randomIntRange(3, 6);
            for (i = 0; i < num_dashes; i++)
            {
                offset = (randomfloatrange(-600, 600), randomfloatrange(-600, 600), randomfloatrange(-200, 200));
                target_point = middle_point + offset;

                dash_dir = vectortoangles(target_point - self.origin);
                dash_time = 0.5;
                dash_steps = int(dash_time / 0.01);
                start_pos = self.origin;
                for (j = 0; j < dash_steps; j++)
                {
                    frac = j / float(dash_steps);
                    self.origin = start_pos + (target_point - start_pos) * frac;

                    if (time_grenade < time_grenade_throw)
                    {
                        time_grenade += 0.01;
                    }
                    else
                    {
                        // throw something
                        self thread SpawnFreezeProjectile(self.origin, randomFloatRange(-1.85, 1.85));
                        time_grenade = 0.0;
                    }

                    wait 0.01;
                }

                self.origin = target_point;
                wait 0.05;
            }

            // Return to the middle and stop spinning
            steps = 60;
            total_return_time = 0.75;
            wait_time = 0.016;

            start_pos = self.origin;
            for(j = 1; j <= steps; j++)
            {
                fraction = j / steps;
                ease_fraction = 1 - ((1 - fraction) * (1 - fraction));
                next_pos = start_pos * (1 - ease_fraction) + (self.old_origin + (0, 0, 35)) * ease_fraction;
                self.origin = next_pos;
                wait wait_time;
            }

            wait 0.15;
        break;

        case 2:
            // follow a zombie and make him overpowered
            playsoundatposition(#"evt_last_stand", (0, 0, 0));
            wait 0.50;

            self.old_origin = self.origin;

            time_max = 8;
            
            if (self.PhaseTrigger)
            {
                time_max = 15;
            }

            time = 0;
            current_zombie = undefined;

            while(time < time_max)
            {
                // If no current zombie or current zombie died, find a new one
                if(!isDefined(current_zombie))
                {
                    a_ai_zombies = zombie_utility::get_zombie_array();
                    if(a_ai_zombies.size > 0)
                    {
                        current_zombie = array::random(a_ai_zombies);
                        if(isDefined(current_zombie))
                        {
                            // Make zombie stronger
                            current_zombie.takedamage = 0;
                            current_zombie.ignore_nuke = 1;
                            current_zombie.b_ignore_cleanup = 1;
                        }
                    }
                }

                if(isDefined(current_zombie))
                {
                    target_pos = current_zombie.origin + (0, 0, 100);
                    move_speed = 0.2;
                    
                    new_pos = self.origin + ((target_pos - self.origin) * move_speed);
                    self.origin = new_pos;

                    // Check if zombie died
                    if(!isAlive(current_zombie))
                    {
                        current_zombie = undefined;
                    }
                }

                time += 0.01;
                wait 0.01;
            }

            if(isDefined(current_zombie))
            {
                current_zombie.takedamage = 0;
                current_zombie.ignore_nuke = 0;
                current_zombie.b_ignore_cleanup = 0;
            }

            // Return to original position
            steps = 60;
            total_return_time = 0.75;
            wait_time = 0.016;

            start_pos = self.origin;
            for(j = 1; j <= steps; j++)
            {
                fraction = j / steps;
                ease_fraction = 1 - ((1 - fraction) * (1 - fraction));
                next_pos = start_pos * (1 - ease_fraction) + (self.old_origin + (0, 0, 35)) * ease_fraction;
                self.origin = next_pos;
                wait wait_time;
            }
        break;

        case 3:
            // light house's lazer on the player?
            playsoundatposition(#"evt_last_stand", (0, 0, 0));
            wait 0.50;
            
            vh_target = undefined;
            while(!isDefined(vh_target))
            {
                vh_target = spawner::simple_spawn_single(getent("virgil", "targetname"));
                waitframe(1);
            }

            vh_target.origin = player.origin;
            vh_target.b_moving = 0;
            vh_target val::set(#"trap_target", "takedamage", 0);

            self.vh_target = vh_target;

            self clientfield::set("laser_set_arti", 1);
            self.vh_target clientfield::set("laser_beem_arti", 1);

            time_max = 8;
            
            if (self.PhaseTrigger)
            {
                time_max = 15;
            }

            time = 0;
            last_player_pos = player.origin;
            while(time < time_max)
            {      
                // calc last position to current position
                dir_vector = player.origin - last_player_pos;
                
                if(length(dir_vector) > 0)
                {
                    dir_vector = vectornormalize(dir_vector);
                    target_pos = player.origin - (dir_vector * 50); // behind player
                }
                else
                {
                    target_pos = player.origin;
                }

                move_speed = 0.2;
                
                new_pos = self.vh_target.origin + ((target_pos - self.vh_target.origin) * move_speed);
                self.vh_target.origin = new_pos;
                
                distance = 75 * 75;

                foreach(player in level.players)
                {
                    if (distanceSquared(player.origin, self.vh_target.origin) <= distance)
                    {
                        player doDamage(10, player.origin);
                    }
                }

                last_player_pos = player.origin;
                time += 0.01;
                wait 0.01;
            }

            self.vh_target clientfield::set("laser_beem_arti", 0);
            wait 0.50;
            self.vh_target delete();
        break;
    }

    self.IsAttacking = false;
}

laser_rotate(v_pos, n_aim_time) {
    v_dir = v_pos - self.origin;
    angles = vectortoangles(v_dir);
    self rotateto(angles, n_aim_time);
}

SpawnFreezeProjectile(origin, throw_power)
{
    if (!isdefined(origin) || !isdefined(throw_power)) {
        return;
    }

    ticking_freeze = util::spawn_model(#"p7_zm_power_up_insta_kill", origin, (0, 0, 0));
    ticking_freeze clientfield::set("powerup_fx", 2);
    
    ticking_freeze physicslaunch
    (
        ticking_freeze.origin, 
        vectorscale((randomFloatRange(0.15, 0.45) * throw_power, randomFloatRange(0.15, 0.45) * throw_power, randomFloatRange(0.15, 0.45) * throw_power),
        64)
    );

    ticking_freeze thread StartTickingFreeze();
}

StartTickingFreeze()
{
    self endon(#"death");

    wait 2.6;

    self playsound(#"hash_2f8c9575cb36a298");
    playfx(level._effect[#"hash_1eae5969d11a8b16"], self.origin);
    playfx(level._effect[#"teleport_splash"], self.origin);

    // freeze nearby players
    foreach(player in level.players)
    {
        if (distanceSquared(self.origin, player.origin) < 18000)
        {
            // freeze player like the water's
            player thread [[ @zm_orange_water<scripts\zm\zm_orange_water.gsc>::water_player_freeze ]]();
            player thread zm_audio::create_and_play_dialog(#"freeze", #"frozen");
        }
    }

    wait 0.25;
    self delete();
}

MonitorDamageArti()
{
    self endon(#"death");

    self hide();
    self function_2baad8fc();
    self.var_6f84b820 = #"boss";
    self solid();
    self.script_noteworthy = "clip";
    self disconnectpaths();
    self SetScale(1.4);
    self setCanDamage(1);
    self.takedamage = 1;

    target_set(self);

    players_size = (GetPlayers().size - 1);
    balance_health = 750000 + (players_size * 250000);

    // this is only used for damage trigger
    self.health = balance_health + 999999999;

    // balanced health with players
    self.health_phase_max = balance_health;
    self.health_phase = balance_health;

    LUINotifyEvent(#"notify_boss_name", 1, 13);
    LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(self.health_phase / self.health_phase_max));

    // Track last damage time
    self.last_damage_time = GetTime();
    self.white_bar_update_delay = 2.2; // seconds to wait after last damage

    // Only one white bar update thread at a time
    if (!isdefined(self.monitor_white_bar_thread))
        self.monitor_white_bar_thread = self thread MonitorWhiteBarUpdate();

    self_arti = level.var_5d5b7e8e.var_a41818b5;

    while(true)
    {
        s_notify = self waittill(#"damage");
        n_damage = s_notify.amount;
        w_weapon = s_notify.weapon;
        a_attacker = s_notify.attacker;

        // no thanks
        if (isdefined(w_weapon) && zm_weapons::is_wonder_weapon(w_weapon)) {
            n_damage *= 0.5;
        }

        if (isDefined(self.end_phase))
            n_damage *= 3;

        if (isPlayer(a_attacker))
        {
            a_attacker util::show_hit_marker();
        }
        else
            continue;

        self.health_phase -= n_damage;
    
        params = spawnstruct();
        params.einflictor = self;
        params.idamage = n_damage;
        params.idflags = 0;
        params.smeansofdeath = ""; // what
        params.weapon = w_weapon;
        params.vpoint = self.origin;
        params.vdir = self.origin;
        params.shitloc = undefined;
        params.vdamageorigin = self.origin;
        params.psoffsettime = undefined;

        LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(self.health_phase / self.health_phase_max));

        // Update last damage time
        self.last_damage_time = GetTime();

        // Reset the white bar update thread if it's waiting
        if (isdefined(self.monitor_white_bar_thread))
        {
            self notify(#"reset_white_bar_timer");
        }

        foreach(player in level.players)
        {
            params.eattacker = player;

            player callback::callback(#"on_ai_damage", params);
        }

        if (self.health_phase < 0 && !self_arti.PhaseTrigger && !self_arti.IsAttacking)
        {
            // first phase done
            LUINotifyEvent(#"notify_boss_name", 1, 14);

            self_arti.StopShit = true;

            ShieldStopAllMusics();

            playsoundatposition(#"hash_431cadb65b1777ce", (0, 0, 0));
            level thread lui::screen_flash(0.4, 2, 0.8, 1, "white");
            playsoundatposition(#"evt_nuke_flash", (0, 0, 0));

            wait .5;
            foreach(player in level.players)
            {
                player dontinterpolate();
                player SetRandomOrigin((1320.05, 3494.99, 30));
            }

            // phase 2
            self_arti.PhaseTrigger = true;

            self.health_phase_max = balance_health;
            self.health_phase = balance_health;

            LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(self.health_phase / self.health_phase_max));

            self_arti.StopShit = false;

            zm_powerup_full_ammo::grab_full_ammo(getplayers()[0]);

            wait 3;

            ShieldPlay(true, true, 92);
        }
        else if (self.health_phase < 0 && self_arti.PhaseTrigger && !self_arti.IsAttacking && !isDefined(self.end_phase))
        {
            // second phase done
            self.end_phase = true;

            self_arti.StopShit = true;

            // last phase end
            zm_powerup_full_ammo::grab_full_ammo(getplayers()[0]);
            LUINotifyEvent(#"notify_boss_name", 1, 15);

            self.health_phase_max = balance_health;
            self.health_phase = balance_health;

            LUINotifyEvent(#"notify_boss_health_meter", 2, 1, ConvertNumToLUI(self.health_phase / self.health_phase_max));

            ShieldStopAllMusics();

            playsoundatposition(#"hash_431cadb65b1777ce", (0, 0, 0));
            level thread lui::screen_flash(0.4, 3, 0.8, 1, "white");
            playsoundatposition(#"evt_nuke_flash", (0, 0, 0));

            wait .5;
            foreach(player in level.players)
            {
                player dontinterpolate();
                player SetRandomOrigin((-3657.03, 4475.06, 1176.13));
                
                player bgb_pack::function_ac9cb612(0);
                player bgb::resume_weapon_cycling();
                player.bgb_disabled = 0;
            }

            level.var_5d5b7e8e.var_a41818b5.e_ring notify(#"stop_rings");

            wait 0.25;
            [[ @zm_orange_mq_hell<scripts\zm\zm_orange_mq_hell.gsc>::function_5c135d54 ]](75);
            level.var_5d5b7e8e.var_a41818b5.origin = (-3793.07, 4587.64, 1201.08);

            level.var_5d5b7e8e.var_a41818b5 thread ChargeUpWipeArti();

            wait 3;

            ShieldPlay(true, true, 92);
        }
        else if (self.health_phase < 0 && self_arti.PhaseTrigger && !self_arti.IsAttacking && isDefined(self.end_phase))
        {
            // end everything
            level thread [[ @zm_hms_util<scripts\zm\zm_hms_util.gsc>::pause_zombies ]](1, 0);

            // no sound this time
            level thread lui::screen_flash(0.4, 3, 0.8, 1, "white");
            playsoundatposition(#"evt_nuke_flash", (0, 0, 0));

            ShieldStopAllMusics();
            level.var_5d5b7e8e.var_a41818b5 notify(#"stop_wipe");
            level notify(#"end_boss_fight");

            LUINotifyEvent(#"notify_boss_name", 1, 0);
            LUINotifyEvent(#"notify_boss_health_meter", 1, 0);
            return;
        }
    }
}

ChargeUpWipeArti()
{
    self endon(#"death", #"stop_wipe");

    wait 50;

    zm_powerup_nuke::grab_nuke(getplayers()[0]);
    foreach (player in ReturnValidPlayers()) {
        player dodamage(player.health + 666, player.origin);
        continue;
    }

    level notify(#"end_game");
}

FlipRocks() {
    self endon(#"death");

    Old_Loc = self.e_rock.origin;
    flip = 0;

    self.e_rock playsound(#"hash_7d258d025446af9");

    while(true)
    {
        flip = !flip;

        if (flip)
        {
            self.e_rock moveto(self.e_rock.var_3a161b40, 0.5);
        }
        else
        {
            self.e_rock moveto(Old_Loc, 0.5);
        }
        
        wait randomFloatRange(10, 35);
    }
}

RocknRoll() {
    self.origin = self.var_3a161b40 - (0, 0, 16);
    self.var_dfcc5d82 thread FlipRocks();
    self.var_dfcc5d82 triggerenable(1);
}

RingRadius()
{
    self endon(#"death", #"stop_rings");

    // init old radius if missing
    if (self.old_radius == undefined || self.old_radius <= 0)
        self.old_radius = 1;

    while(true)
    {
        new_radius = randomFloatRange(75, 335);
        scale_time = 2;
        steps = 45;
        wait_time = scale_time / steps;
        
        radius_increment = (new_radius - self.old_radius) / steps;
        
        // scale radius
        for(i = 0; i < steps; i++)
        {
            current_radius = self.old_radius + (radius_increment * i);
            [[ @zm_orange_mq_hell<scripts\zm\zm_orange_mq_hell.gsc>::function_5c135d54 ]](current_radius);
            wait wait_time;
        }
        
        // last scale
        [[ @zm_orange_mq_hell<scripts\zm\zm_orange_mq_hell.gsc>::function_5c135d54 ]](new_radius);
        self.old_radius = new_radius;

        wait randomFloatRange(30, 75);
    }
}

RingWatcher() {
    self endon(#"death");
    self thread RingRadius();

    while (true) {
        n_radius_sqr = self.n_radius * self.n_radius;
        foreach (e_player in getplayers()) {
            if (distancesquared(self.origin, e_player.origin) < n_radius_sqr) {
                if (e_player.has_ring_shit !== 1) {
                    e_player thread RingIn();
                }
                continue;
            }
            if (e_player.has_ring_shit !== 0) {
                e_player RingOut();
            }
        }
        wait 0.1;
    }
}

RingIn() {
    self endon(#"death");
    self.has_ring_shit = 1;
    self clientfield::set_to_player("" + #"hash_78b8d89d34b32241", 2);
    self zm_audio::create_and_play_dialog(#"hell_on_earth", #"circle");
    while (self.has_ring_shit) {
        self dodamage(90, self.origin);
        wait 0.75;
    }
}

RingOut() {
    self.has_ring_shit = 0;
    self clientfield::set_to_player("" + #"hash_78b8d89d34b32241", 1);
}

SpawnBlockersTag()
{
    // ship
    ship1 = SpawnTagBlocker((-1994.8, -308.566, 55.0625), (0, -131, 0), 1, false);
    ship2 = SpawnTagBlocker((-2017.52, -305.717, 55.9594), (0, -131, 0), 1, false);
    ship3 = SpawnTagBlocker((-1923.2, -269.635, 48.387), (0, -131, 0), 1, false);

    // cave
    cave1 = SpawnTagBlocker((-2105.29, 1698.56, 134.353), (0, -10, 0), 1, false);
    cave2 = SpawnTagBlocker((-2061.95, 1697.22, 143.912), (0, -10, 0), 1, false);

    // door
    door1 = SpawnTagBlocker((512.953, 3309.3, 26.5529), (0, -10, 0), 1, false);
    door2 = SpawnTagBlocker((536.646, 3323.52, 25.8513), (0, -10, 0), 1, false);

    // big ent
    big1 = SpawnTagBlocker((2040.18, 2748.2, 42.801), (0, -10, 0), 1, false);
    big2 = SpawnTagBlocker((2006.77, 2715.52, 41.1532), (0, -10, 0), 1, false);
    big3 = SpawnTagBlocker((1957.26, 2683.98, 38.1723), (0, -10, 0), 1, false);

    level waittill(#"end_boss_fight");

    // delete them
    ship1 delete();
    ship2 delete();
    ship3 delete();

    cave1 delete();
    cave2 delete();

    door1 delete();
    door2 delete();

    big1 delete();
    big2 delete();
    big3 delete();
}