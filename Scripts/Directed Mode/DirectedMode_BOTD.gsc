detour namespace_fc5c8455<script_2ba3951675c7ee1c>::function_3e6b7a2d() {
    if(!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return [[ @namespace_fc5c8455<script_2ba3951675c7ee1c.gsc>::function_3e6b7a2d ]]();

    var_fbab1c11 = undefined;
    while (true) {
        var_d249c0e6 = 25;
        n_power = var_d249c0e6;
        s_result = self waittill(#"trigger");
        e_player = s_result.activator;
        if (isdefined(e_player.var_1ea09849) && e_player.var_1ea09849 && var_d249c0e6 > 0) {
            self.stub.related_parent notify(#"stop_barrel_objective");

            self.stub.var_ff554ec clientfield::increment("" + #"hash_3c74a33b8e1adb73");
            self.stub.var_ff554ec clientfield::set("" + #"hash_6954721e3aab6b22", 0);
            if (isdefined(e_player.n_cooldown_time)) {
                if (e_player.n_cooldown_time + n_power > 25) {
                    e_player.n_cooldown_time = 25;
                } else {
                    e_player.n_cooldown_time += n_power;
                }
            }
            var_d249c0e6 = 0;
            if (isalive(e_player) && isdefined(e_player.var_1ea09849) && e_player.var_1ea09849) {
                e_player clientfield::increment_to_player("" + #"hash_c79e0b124c4b75");
                e_player givemaxammo(getweapon(#"ww_blundergat_fire_t8_unfinished"));
                if (!(isdefined(e_player.var_a40e9d01) && e_player.var_a40e9d01)) {
                    e_player.var_a40e9d01 = 1;
                    e_player thread [[ @namespace_fc5c8455<script_2ba3951675c7ee1c.gsc>::function_e02f6600 ]]();
                    e_player zm_audio::create_and_play_dialog(#"magmagat", #"reheat", undefined, 1);
                }
            }
            level waittill(#"hash_575b654fc5c59146");
        }
    }
}

detour namespace_fc5c8455<script_2ba3951675c7ee1c>::function_cbe7f871() {
    v_weapon_origin_offset = (8, -2, 9);
    v_weapon_angles_offset = (0, -90, 0);
    self.stub.v_weapon_origin = level.var_cc5631a6.origin + v_weapon_origin_offset;
    self.stub.v_weapon_angles = level.var_cc5631a6.angles + v_weapon_angles_offset;
    var_a29167c5 = undefined;
    if (level flag::get(#"hash_3fb7d58b07b04333")) {
        var_a29167c5 = 1;
    }
    while (true) {
        s_result = self waittill(#"trigger");
        e_player = s_result.activator;
        level notify(#"trigger_blundergat_objective");
        if (!level flag::get(#"hash_3fb7d58b07b04333") && !level flag::get(#"hash_1d5f5fbf80476490")) {
            self.stub thread [[ @namespace_fc5c8455<script_2ba3951675c7ee1c.gsc>::function_d74a3faf ]](e_player);
            continue;
        }
        if (level flag::get(#"hash_3fb7d58b07b04333") && !level flag::get(#"hash_1d5f5fbf80476490")) {
            self.stub thread [[ @namespace_fc5c8455<script_2ba3951675c7ee1c.gsc>::function_fcf0a319 ]](e_player, var_a29167c5);
            continue;
        }
        if (level flag::get(#"hash_3fb7d58b07b04333") && level flag::get(#"hash_1d5f5fbf80476490")) {
            self.stub notify(#"hash_38a4480847fe9677", {#activator:e_player});
        }
    }
}

detour namespace_a9aa9d72<script_668c4fbb94671fb4>::function_9f38c4a2() {
    if(!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_9f38c4a2 ]]();

    if (isdefined(level.var_daaf0e5d) && isinarray(level.var_85cc9fcc, level.var_daaf0e5d)) {
        var_ce57a284 = level.var_daaf0e5d;
        level.var_daaf0e5d = undefined;
    } else {
        var_ce57a284 = array::random(level.var_85cc9fcc);
    }
    var_328baab5 = struct::get_array("pa_po_pos", "targetname");
    foreach (s_portal_pos in var_328baab5) {
        if (s_portal_pos.script_string === var_ce57a284) {
            var_aa11c23c = util::spawn_model("tag_origin", s_portal_pos.origin, s_portal_pos.angles);
            var_aa11c23c.script_string = s_portal_pos.script_string;
            var_aa11c23c.script_noteworthy = "blast_attack_interactables";
            break;
        }
    }

    level notify(#"challenge_selected", {#challenge:var_ce57a284});
    level.current_orb_challenge = var_aa11c23c;
    return var_aa11c23c;
}

detour namespace_a9aa9d72<script_668c4fbb94671fb4>::function_685fffc4() {
    if(!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_685fffc4 ]]();

    self endon(#"death", #"hash_42d705f0ff5334bb");
    var_9636ee0 = [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_ae0bae8 ]]();
    var_31adaadb = 0;
    var_e5b1f8d7 = undefined;
    var_49154180 = 10;
    while (var_31adaadb <= var_9636ee0) {
        if (isdefined(self.var_c95261d) && self.var_c95261d && isdefined(self.var_5bf7575e) && self.var_5bf7575e) {
            var_31adaadb++;
            level thread Directed_UpdateObjective(int(var_31adaadb), int(var_9636ee0 + 1));
        }
        var_36f8baa8 = (var_9636ee0 - var_31adaadb) / var_9636ee0;
        var_b25755cf = int(var_36f8baa8 * 10);
        if (var_b25755cf != var_49154180) {
            self clientfield::set("" + #"hash_3e506d7aedac6ae0", var_b25755cf);
            var_49154180 = var_b25755cf;
        }
        wait 1;
    }
    level.var_acc853e7 notify(#"hash_3cef5405e0643505");
    level.var_acc853e7 playsound(#"zmb_sq_souls_release");
    waitframe(1);
    if (level.var_acc853e7 clientfield::get("" + #"hash_65da20412fcaf97e")) {
        level.var_acc853e7 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
    }
    level.var_acc853e7.var_c95261d = undefined;
    level.var_68fa1bc = undefined;
    level.var_acc853e7.var_238b3806 = undefined;
    level.var_acc853e7 notsolid();
    level.var_acc853e7 ai::set_behavior_attribute("run", 1);
}

detour namespace_a9aa9d72<script_668c4fbb94671fb4>::function_33701563() {
    if (!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_33701563 ]]();

    self endon(#"death", #"hash_300e9fed7925cd69");
    var_64aaa12a = struct::get_array("showers_kill_pos", "targetname");
    callback::on_ai_killed(@namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_c8d4b885);
    level.var_b1060d52 = 0;
    while (true) {
        inventory_picku = array::random(var_64aaa12a);
        var_81de1755 = util::spawn_model("tag_origin", inventory_picku.origin, inventory_picku.angles);
        level.current_blue_circle = var_81de1755;
        self thread [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_6bb299fa ]]();
        self thread [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_613cf0a7 ]](var_81de1755);
        var_d61ccd7e = randomfloatrange(16, 29);
        s_result = self waittilltimeout(var_d61ccd7e, #"hash_4636f041ae52f0fa", #"hash_7953672ffc47be3");
        var_81de1755 playsound(#"hash_6f41c19432e2559a");
        var_81de1755 clientfield::set("" + #"hash_a51ae59006ab41b", 0);
        var_81de1755 delete();
        level.var_3f1b1c67 delete();
        if (s_result._notify == #"hash_7953672ffc47be3" || s_result._notify == #"hash_4636f041ae52f0fa") {
            callback::remove_on_ai_killed(@namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_c8d4b885);
            level.var_b1060d52 = undefined;
            level.showers_chall_completed = true;
            return;
        }
        self notify(#"hash_60f9171b687c9d06");
    }
}

detour namespace_a9aa9d72<script_668c4fbb94671fb4>::function_6bb299fa() {
    if (!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_6bb299fa ]]();

    self endon(#"death", #"hash_60f9171b687c9d06", #"hash_4636f041ae52f0fa", #"hash_300e9fed7925cd69");
    var_9cdf5d68 = 2;
    var_202d423f = [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_841bb7a7 ]]();
    while (level.var_b1060d52 < var_202d423f) {
        level Directed_UpdateObjective(int(level.var_b1060d52), int(var_202d423f));
        n_percent = level.var_b1060d52 / 29;
        n_blood = int(10 - n_percent * 10);
        if (n_blood != var_9cdf5d68 && n_blood < 9) {
            if (isdefined(level.var_4dad7caf)) {
                level.var_4dad7caf clientfield::set("" + #"hash_504d26c38b96651c", n_blood);
            }
            var_9cdf5d68 = n_blood;
            if (isdefined(level.var_7c9cd6ae)) {
                level.var_7c9cd6ae clientfield::set("" + #"hash_504d26c38b96651c", n_blood);
            }
        }
        wait 0.2;
    }
    self notify(#"hash_7953672ffc47be3");
    if (isdefined(level.var_4dad7caf)) {
        level.var_4dad7caf clientfield::set("" + #"hash_504d26c38b96651c", 1);
    }
    if (isdefined(level.var_7c9cd6ae)) {
        level.var_7c9cd6ae clientfield::set("" + #"hash_504d26c38b96651c", 1);
    }
}

detour namespace_a9aa9d72<script_668c4fbb94671fb4>::function_67a6f551() {
    if (!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_67a6f551 ]]();

    self endon(#"death");
    var_9cdf5d68 = 10;
    while (isalive(self)) {
        s_result = self waittill(#"damage");
        level thread Directed_UpdateObjective(int(self.health));
        n_percent = self.health / 961;
        n_blood = int(n_percent * 10);
        if (n_blood != var_9cdf5d68) {
            self clientfield::set("" + #"hash_3e506d7aedac6ae0", n_blood);
            var_9cdf5d68 = n_blood;
        }
        self [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_1b049b47 ]]();
    }
}

detour namespace_a9aa9d72<script_668c4fbb94671fb4>::function_4e69659c() {
    if (!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_4e69659c ]]();
    
    self endon(#"death", #"hash_71716a8e79096aee");
    self thread [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_e5801a77 ]]();
    while (true) {
        while (self.var_7fbed236 > 0) {
            self.goalradius = 128;
            if (isalive(self.e_activator)) {
                self thread [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_23d7198d ]](self.e_activator);
                self setgoal(self.e_activator);
            } else {
                self setgoal(self.origin);
            }
            wait 0.25;
            self.var_7fbed236 = math::clamp(self.var_7fbed236 - 0.25, 0, 300);
            level thread Directed_UpdateObjective(int(self.var_7fbed236));
        }
        self setgoal(self.origin);
        self playsound(#"hash_2d161f5686b2700a");
        s_result = self waittill(#"hash_2499fc5cec93bec8");
    }
}

detour namespace_a9aa9d72<script_668c4fbb94671fb4>::function_333c93f3(var_3df8381d) {
    if (!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_333c93f3 ]](var_3df8381d);

    level.var_66a47b57 = spawn("trigger_radius_use", self.origin, 0, 48);
    level.var_66a47b57 triggerignoreteam();
    level.var_66a47b57 sethintstring(#"");
    level.var_66a47b57 setcursorhint("HINT_NOICON");
    level.var_66a47b57.is_visible = 1;
    level.var_66a47b57 endon(#"death");
    var_ae5529ba = undefined;
    var_9b830416 = 0;
    var_af097de7 = [];
    var_77d58f80 = [];
    var_3ad399df = #"code_dot";
    var_ca1854a9 = #"code_dash";
    if (var_3df8381d == 30) {
        var_ae5529ba = 3;
        var_af097de7 = array(var_3ad399df, var_3ad399df, var_3ad399df, var_ca1854a9, var_ca1854a9);
    } else if (var_3df8381d >= 20) {
        var_ae5529ba = 2;
        var_af097de7 = array(var_3ad399df, var_3ad399df, var_ca1854a9, var_ca1854a9, var_ca1854a9);
    } else if (var_3df8381d >= 10) {
        var_ae5529ba = 1;
        var_af097de7 = array(var_3ad399df, var_ca1854a9, var_ca1854a9, var_ca1854a9, var_ca1854a9);
    }

    switch (var_3df8381d) {
    case 1:
    case 11:
    case 21:
        var_9b830416 = 1;
        var_77d58f80 = array(var_3ad399df, var_ca1854a9, var_ca1854a9, var_ca1854a9, var_ca1854a9);
        break;
    case 2:
    case 12:
    case 22:
        var_9b830416 = 2;
        var_77d58f80 = array(var_3ad399df, var_3ad399df, var_ca1854a9, var_ca1854a9, var_ca1854a9);
        break;
    case 3:
    case 13:
    case 23:
        var_9b830416 = 3;
        var_77d58f80 = array(var_3ad399df, var_3ad399df, var_3ad399df, var_ca1854a9, var_ca1854a9);
        break;
    case 4:
    case 14:
    case 24:
        var_9b830416 = 4;
        var_77d58f80 = array(var_3ad399df, var_3ad399df, var_3ad399df, var_3ad399df, var_ca1854a9);
        break;
    case 5:
    case 15:
    case 25:
        var_9b830416 = 5;
        var_77d58f80 = array(var_3ad399df, var_3ad399df, var_3ad399df, var_3ad399df, var_3ad399df);
        break;
    case 6:
    case 16:
    case 26:
        var_9b830416 = 6;
        var_77d58f80 = array(var_ca1854a9, var_3ad399df, var_3ad399df, var_3ad399df, var_3ad399df);
        break;
    case 7:
    case 17:
    case 27:
        var_9b830416 = 7;
        var_77d58f80 = array(var_ca1854a9, var_ca1854a9, var_3ad399df, var_3ad399df, var_3ad399df);
        break;
    case 8:
    case 18:
    case 28:
        var_9b830416 = 8;
        var_77d58f80 = array(var_ca1854a9, var_ca1854a9, var_ca1854a9, var_3ad399df, var_3ad399df);
        break;
    case 9:
    case 19:
    case 29:
        var_9b830416 = 9;
        var_77d58f80 = array(var_ca1854a9, var_ca1854a9, var_ca1854a9, var_ca1854a9, var_3ad399df);
        break;
    case 0:
    case 10:
    case 20:
    case 30:
        var_9b830416 = 0;
        var_77d58f80 = array(var_ca1854a9, var_ca1854a9, var_ca1854a9, var_ca1854a9, var_ca1854a9);
        break;
    default:
        break;
    }

    all_codes_str = "^3Code Required to Enter: ";
    foreach(code in var_af097de7) {
        if (code == var_3ad399df) {
            all_codes_str += "(dot) ";
        } else if (code == var_ca1854a9) {
            all_codes_str += "(dash) ";
        }
    }

    foreach(code in var_77d58f80) {
        if (code == var_3ad399df) {
            all_codes_str += "(dot) ";
        } else if (code == var_ca1854a9) {
            all_codes_str += "(dash) ";
        }
    }

    foreach(player in level.players)
        player iPrintLn(all_codes_str);

    var_fda79bf3 = 0;
    while (true) {
        s_result = level.var_66a47b57 waittill(#"trigger");
        e_player = s_result.activator;
        level.var_66a47b57 setinvisibletoall();
        level.var_66a47b57.is_visible = 0;
        if (!isplayer(e_player)) {
            level.var_66a47b57 setvisibletoall();
            level.var_66a47b57.is_visible = 1;
            continue;
        }
        if (!(isdefined(var_fda79bf3) && var_fda79bf3)) {
            level.var_66a47b57 thread [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_b87b2393 ]]();
            var_fda79bf3 = 1;
        }
        if (isdefined(var_ae5529ba) && var_ae5529ba > 0) {
            var_49e994d2 = e_player [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_bfe4e5a9 ]](var_af097de7, var_ae5529ba);
            if (!(isdefined(var_49e994d2) && var_49e994d2)) {
                if (isdefined(e_player)) {
                    e_player playlocalsound(#"hash_28d80c177e66c724");
                }
                level.var_66a47b57 setvisibletoall();
                level.var_66a47b57.is_visible = 1;
                continue;
            }
        }
        if (isplayer(e_player)) {
            var_5830315f = e_player [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_bfe4e5a9 ]](var_77d58f80, var_9b830416);
            if (isdefined(var_5830315f) && var_5830315f) {
                playsoundatposition(#"zmb_lightning_l", level.var_66a47b57.origin);
                level notify(#"hash_3ffb8bc647b5d06b");
                e_player thread zm_audio::create_and_play_dialog(#"success_resp", #"generic");
                level.var_66a47b57 delete();
                return;
            } else if (isdefined(e_player)) {
                e_player playlocalsound(#"hash_28d80c177e66c724");
            }
        }
        level.var_66a47b57 setvisibletoall();
        level.var_66a47b57.is_visible = 1;
    }
}

detour namespace_a9aa9d72<script_668c4fbb94671fb4>::function_81650808(var_aa11c23c, var_56eace20) {
    if (!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return [[ @namespace_a9aa9d72<script_668c4fbb94671fb4.gsc>::function_81650808 ]](var_aa11c23c, var_56eace20);

    var_aa11c23c endon(#"death", #"hash_300e9fed7925cd69", #"hash_34486fb413da1672");
    while (level.var_89231fe9 < var_56eace20) {
        self thread GenMarks(var_aa11c23c);
        s_result = self.t_interact waittill(#"trigger");
        self.mdl_light setmodel(#"p8_zm_zod_light_bulb_01_on");
        self.mdl_light clientfield::set("" + #"hash_119729072e708651", 1);
        wait 1;
        self.mdl_light setmodel(#"p8_zm_zod_light_bulb_01_off");
        self.mdl_light clientfield::set("" + #"hash_119729072e708651", 0);
        wait 1;
        if (self !== level.var_84fbe7bc[level.var_89231fe9]) {
            var_aa11c23c notify(#"hash_34486fb413da1672", {#b_success:0, #e_player:s_result.activator});
        }
        level.var_89231fe9++;

        if (isdefined(self.fake_model))
        {
            self.fake_model delete();
            self.fake_model = undefined;
        }
    }
    var_aa11c23c notify(#"hash_34486fb413da1672", {#b_success:1, #e_player:s_result.activator});
}

GenMarks(var_aa11c23c)
{
    var_aa11c23c endon(#"death", #"hash_300e9fed7925cd69", #"hash_34486fb413da1672");

    while(true)
    {
        if (self === level.var_84fbe7bc[level.var_89231fe9] && !isdefined(self.fake_model)) {
            fake_model = util::spawn_model("tag_origin", self.origin, self.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", self, #"death");
            self.fake_model = fake_model;
        }
        else if (isdefined(self.fake_model) && self !== level.var_84fbe7bc[level.var_89231fe9]) {
            self.fake_model delete();
            self.fake_model = undefined;
        }

        wait 0.1;
    }
}

ShieldWatcher_BOTD()
{
    while(true)
    {
        str_result = level waittill(#"blueprint_completed");
        
        if (str_result.blueprint.name == #"zblueprint_shield_spectral_shield")
            level.b_built_shield = true;
    }
}

fake_model_wait_for_blueprint()
{
    level waittill(#"blueprint_completed");

    if (isDefined(self))
        self delete();
}

directed_mark_dog_charge(dog)
{
    dog waittill(#"fully_charged");
    self delete();
}

directed_update_skull_objective()
{
    self waittill(#"death", #"caught_by_tomahawk");
    level.skulls_collected++;
    level Directed_UpdateObjective(level.skulls_collected);
}

fake_model_wait_for_clue_end()
{
    level waittill(#"stop_clues_objective");

    if (isDefined(self))
        self delete();
}

directed_wait_barrel_objective(barrel)
{
    barrel waittill(#"stop_barrel_objective");

    if (isDefined(self))
        self delete();
}

UpdateBlunderSeconds(player_to_use)
{
    level endon(#"hash_5dc448a84a24492");

    while(true)
    {
        if (isdefined(player_to_use.n_cooldown_time) && player_to_use.n_cooldown_time > 0)
            level thread Directed_UpdateObjective(int(player_to_use.n_cooldown_time));
        else
            level notify(#"magma_timeout_objective");
        
        wait 0.5;
    }
}

can_slam_attack()
{
    wait 2;
    ai::set_behavior_attribute("can_ground_slam", true);
}

WallWatcher()
{
    level waittill(#"hash_703a48e58dfd43d6");
    level.broken_wall_set = true;
}

SpoonWallWatcher()
{
    level waittill(#"hash_4aedd2f50e5e307");
    level.spoon_wall_set = true;
}

StartDroppingBloods()
{
    level endon(#"stop_dropping_bloods");

    while(true)
    {
        foreach(player in level.players)
        {
            level thread zm_powerups::specific_powerup_drop("zombie_blood", player.origin);
        }
        
        wait randomFloatRange(30, 40);
    }
}

// challenges
Directed_PowerPlantChallenge() // function_c11e25eb
{
    level.current_orb_challenge endoncallback(&ChallengeFailLock, #"death");
    level thread Directed_SetObjective(52);

    gen = struct::get("ph_gen_pos", "targetname");
    fake_model = util::spawn_model(#"tag_origin", gen.origin, gen.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", gen, #"death");
    level.current_orb_challenge waittill(#"hash_47037a033334904");
    fake_model delete();

    level thread Directed_SetObjective(53);
    level.current_orb_challenge waittill(#"hash_2877e7dda4d090c8");

    level thread Directed_SetObjective(54);
    punch_loc = struct::get("ph_pc_pos", "targetname");
    fake_model = util::spawn_model(#"tag_origin", punch_loc.origin, punch_loc.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", punch_loc, #"death");
    level.current_orb_challenge waittill(#"punchcard_pickup");
    fake_model delete();

    level thread Directed_SetObjective(55);
    tv_loc = getent("md_te_mi", "targetname");
    fake_model = util::spawn_model(#"tag_origin", tv_loc.origin, tv_loc.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", tv_loc, #"death");
    level.current_orb_challenge waittill(#"hash_1548855706869d2f");
    fake_model delete();

    level thread Directed_SetObjective(56);

    wait 1;

    level.var_8eec9430 thread directed_add_new_objective(#"enh_objective", 1, #"death", level.var_8eec9430, #"death");
    while(!isdefined(level.mdl_red_orb))
    {
        switches = struct::get_array("ph_gh_pa", "script_noteworthy");
        foreach(switch_e in switches)
        {
            if (isinarray(level.var_62f48651, switch_e.script_int) && !isdefined(switch_e.fake_model)) {
                mdl_lever = getent("flicker_" + switch_e.script_int + 1, "targetname");

                origin_to_use = isdefined(mdl_lever) ? mdl_lever.origin : switch_e.origin;
                angle_to_use = isdefined(mdl_lever) ? mdl_lever.angles  : switch_e.angles;

                fake_model = util::spawn_model(#"tag_origin", origin_to_use, angle_to_use);
                fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", switch_e, #"death");
                switch_e.fake_model = fake_model;
            }

            if (!isinarray(level.var_62f48651, switch_e.script_int) && isdefined(switch_e.fake_model))
            {
                switch_e.fake_model delete();
                switch_e.fake_model = undefined;
            }
        }

        wait 0.1;
    }

    // remove old marked ones
    switches = struct::get_array("ph_gh_pa", "script_noteworthy");
    foreach(switch_e in switches)
    {
        if (isdefined(switch_e.fake_model))
        {
            switch_e.fake_model delete();
            switch_e.fake_model = undefined;
        }
    }

    level thread Directed_SetObjective(42);
    level.mdl_red_orb thread directed_add_new_objective(#"enh_objective", 1, #"death", level.mdl_red_orb, #"death");
    level.mdl_red_orb waittill(#"death");
}

Directed_DocksChallenge() // function_b264ca4d
{
    level.current_orb_challenge endoncallback(&ChallengeFailLock, #"death");
    level thread Directed_SetObjective(48);

    morse_input = getent("m_c_ra", "targetname");
    fake_model = util::spawn_model(#"tag_origin", morse_input.origin, morse_input.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", morse_input, #"death");
    level waittill(#"hash_3ffb8bc647b5d06b");
    fake_model delete();

    level thread Directed_SetObjective(49);

    fake_model = util::spawn_model(#"tag_origin", (2625.64, 9364.82, 1532.13), (0, 0, 0));
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", fake_model, #"death");

    while(!isdefined(level.var_558993a0))
    {
        util::wait_network_frame();
    }

    fake_model delete();

    wait 0.5;
    level thread Directed_SetObjective(50);
    level.var_558993a0 thread directed_add_new_objective(#"enh_objective", 1, #"death", level.var_558993a0, #"death");
    level.var_558993a0 waittill(#"hash_17de7292d988f537");

    level thread Directed_SetObjective(51);
    level.current_orb_challenge thread directed_add_new_objective(#"enh_objective", 1, #"death", level.var_558993a0, #"death");

    level waittill(#"hash_361c36fab747c7f0");
    while(!isdefined(level.mdl_red_orb))
    {
        util::wait_network_frame();
    }

    level thread Directed_SetObjective(42);
    level.mdl_red_orb thread directed_add_new_objective(#"enh_objective", 1, #"death", level.mdl_red_orb, #"death");
    level.mdl_red_orb waittill(#"death");
}

Directed_CellblockChallenge() // function_2b37242f
{
    level.current_orb_challenge endoncallback(&ChallengeFailLock, #"death");
    level thread Directed_SetObjective(45);

    fake_model = util::spawn_model(#"tag_origin", (2461.55, 9643.28, 1336.13), (0, 0, 0));
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", fake_model, #"death");

    while(!isdefined(level.var_7b71cdb7))
    {
        util::wait_network_frame();
    }

    fake_model delete();
    level.var_7b71cdb7 thread directed_add_new_objective(#"enh_objective", 1, #"death", level.var_7b71cdb7, #"death");
    level thread Directed_SetObjective(46);
    level.var_7b71cdb7 waittill(#"blast_attack");
    level thread Directed_SetObjective(47);
    level thread Directed_UpdateObjective(int(level.var_7b71cdb7.health));

    s_result = level.var_7b71cdb7 waittill(#"hash_6f435cd868870904", #"death");

    if (s_result._notify == #"hash_6f435cd868870904") {
        while(!isdefined(level.mdl_red_orb))
        {
            util::wait_network_frame();
        }

        level thread Directed_SetObjective(42);
        level.mdl_red_orb thread directed_add_new_objective(#"enh_objective", 1, #"death", level.mdl_red_orb, #"death");
        level.mdl_red_orb waittill(#"death");
    }
    else
    {
        ChallengeFailLock("none");
    }
}

Directed_ShowersChallenge() // function_b80b6749
{
    level.current_orb_challenge endoncallback(&ChallengeFailLock, #"death");
    level thread Directed_SetObjective(43);

    while(!isdefined(level.var_9d950ce5) || !isdefined(level.var_9d950ce5.t_interact))
    {
        util::wait_network_frame();
    }

    fake_model = util::spawn_model(#"tag_origin", level.var_9d950ce5.t_interact.origin, level.var_9d950ce5.t_interact.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", level.var_9d950ce5.t_interact, #"death");
    level.var_9d950ce5 waittill(#"hash_17de7292d988f537");
    level.var_9d950ce5 waittill(#"hash_17de7292d988f537");
    fake_model delete();

    level thread Directed_SetObjective(44);

    while(!isdefined(level.current_blue_circle))
        util::wait_network_frame();

    while(true)
    {
        if (isdefined(level.showers_chall_completed))
            break;
        
        level.current_blue_circle thread directed_add_new_objective(#"enh_objective", 1, #"death", level.current_blue_circle, #"death");
        level.current_blue_circle waittill(#"death");
    }

    wait 1;

    level thread Directed_SetObjective(43);
    fake_model = util::spawn_model(#"tag_origin", level.var_9d950ce5.t_interact.origin, level.var_9d950ce5.t_interact.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", level.var_9d950ce5.t_interact, #"death");
    
    while(!isdefined(level.mdl_red_orb))
    {
        util::wait_network_frame();
    }

    fake_model delete();

    level thread Directed_SetObjective(42);
    level.mdl_red_orb thread directed_add_new_objective(#"enh_objective", 1, #"death", level.mdl_red_orb, #"death");
    level.mdl_red_orb waittill(#"death");
}

Directed_NewIndustriesChallenge() // function_cdc8090a
{
    level.current_orb_challenge endoncallback(&ChallengeFailLock, #"death");
    level thread Directed_SetObjective(38);

    fake_model = util::spawn_model(#"tag_origin", (1712.18, 10586.1, 1336.13), (0, 0, 0));
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", fake_model, #"death");

    while(!isdefined(level.var_acc853e7))
    {
        util::wait_network_frame();
    }

    fake_model delete();
    wait 0.25;
    level.var_acc853e7 thread directed_add_new_objective(#"enh_objective", 1, #"death", level.var_acc853e7, #"death");
    level thread Directed_SetObjective(39);

    core = 61;
    switch (util::get_players().size) {
    case 1:
        core = 30.5;
        break;
    case 2:
        core = 42.7;
        break;
    case 3:
        core = 48.8;
        break;
    case 4:
        core = 61;
        break;
    }

    level thread Directed_UpdateObjective(0, int(core));
    level.var_acc853e7 endoncallback(&ChallengeFailLock, #"hash_436fe34b5e12d99a");
    level.var_acc853e7 waittill(#"hash_3cef5405e0643505");
    
    level thread Directed_SetObjective(40);
    spinning_trap = getentarray("zm_spinning_trap", "script_noteworthy");
    
    fake_model = util::spawn_model(#"tag_origin", spinning_trap[0].origin, spinning_trap[0].angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", spinning_trap[0], #"death");

    s_result = level.var_acc853e7 waittill(#"death");
    fake_model delete();

    while(!isdefined(level.mdl_red_orb))
    {
        util::wait_network_frame();
    }

    level thread Directed_SetObjective(42);
    level.mdl_red_orb thread directed_add_new_objective(#"enh_objective", 1, #"death", level.mdl_red_orb, #"death");
    level.mdl_red_orb waittill(#"death");
}

ChallengeFailLock(str_notify)
{
    // ?????
    if (!isdefined(level) || !isdefined(level.players) || !isdefined(GetPlayers()[0]))
        return;

    level thread Directed_SetObjective(41);
}

FreeShieldUpgrade()
{
    level endon(#"end_game");

    while(true)
    {
        foreach(player in level.players)
            player.var_5ba94c1e = true;
        
        wait 1;
    }
}

BOTDDirectedMode()
{
    level thread SpoonWallWatcher();
    level thread ShieldWatcher_BOTD();
    level thread FreeShieldUpgrade();

    wait_time = 1;

    if(GetDvarInt("shield_enh_SaveGame_Load", 0))
        wait_time = 12;

    wait wait_time;

    // starting round cap
    level thread Directed_SetRoundCap(4);

    // starting objective (power)
    level thread Directed_SetObjective(1);

    if (!isdefined(level.saved_pap_done))
    {
        trigs = getentarray("use_elec_switch", "targetname");
        trig_to_use = trigs[1];

        trig_to_use2 = undefined;
        foreach(trig in trigs)
        {
            if (trig != trig_to_use && isdefined(trig.script_int) && trig.script_int == 1)
            {
                trig_to_use2 = trig;
            }
        }

        fake_model = util::spawn_model(#"tag_origin", trig_to_use.origin, trig_to_use.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", trig_to_use, #"trigger");
        level flag::wait_till("power_on2");
        fake_model delete();

        level thread Directed_SetObjective(2);
        catwalk_t = getent("t_catwalk_door_open", "targetname");
        fake_model = util::spawn_model(#"tag_origin", catwalk_t.origin, catwalk_t.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", catwalk_t, #"trigger");
        catwalk_t waittill(#"trigger");
        fake_model delete();
        wait 0.25;

        level thread Directed_SetObjective(3);
        level flag::wait_till(#"catwalk_event_completed");

        wait 0.25;

        level thread Directed_SetObjective(4);
        fake_model = util::spawn_model(#"tag_origin", trig_to_use2.origin, trig_to_use2.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", trig_to_use2, #"trigger");
        level flag::wait_till("power_on1");
        fake_model delete();
    }

    level thread Directed_SetRoundCap(6);

    // Shield Parts
    // Key
    w_component = zm_crafting::get_component(#"zitem_spectral_shield_part_3");
    if (!zm_items::player_has(level.players[0], w_component))
    {
        level thread Directed_SetObjective(5);

        while (!isdefined(getaiarchetypearray(#"brutus")[0]))
            wait 0.1;

        brutus = getaiarchetypearray(#"brutus")[0];
        wait 1;
        brutus thread directed_add_new_objective(#"enh_objective", 1, #"death", brutus, #"death");
        while(!isdefined(level.mdl_brutus_key))
            util::wait_network_frame();

        level.mdl_brutus_key thread directed_add_new_objective(#"enh_objective", 1, #"death", level.mdl_brutus_key, #"death");
        level.mdl_brutus_key waittill(#"death");
    }

    level thread Directed_SetObjective(6);
    level thread Directed_UpdateObjective(1);

    // Parts
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
            if ((isDefined(try_name)) && !isdefined(item.saved_picked) && (try_name != #"hash_5517c604e6d95c91"))
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
                    if (!(try_name == #"hash_5517c604e6d95c91"))
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
            level thread Directed_SetObjective(7);
            foreach (a_s_crafting in level.var_4fe2f84d) {
                foreach (s_crafting in a_s_crafting) {
                    fake_model = util::spawn_model(#"tag_origin", s_crafting.origin, s_crafting.angles);
                    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", level, #"blueprint_completed");
                    fake_model thread fake_model_wait_for_blueprint();
                }
            }

            level waittill(#"blueprint_completed");
        }
    }

    // Pack-a-Punch
    if (!level flag::get(#"pap_quest_completed"))
    {
        level thread Directed_SetObjective(8);
        pap_box = getent("pap_shock_box", "script_string");
        fake_model = util::spawn_model(#"tag_origin", pap_box.origin + (0, 0, 50), pap_box.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"nothing", pap_box, #"trigger");
        level flag::wait_till(#"pap_quest_completed");
        fake_model delete();
    } 

    level thread Directed_SetRoundCap(8);

    // Hell-Retriever
    b_any_has_hell_retriever = false;
    foreach(player in level.players)
    {
        if (player hasweapon(getweapon(#"tomahawk_t8")) || player hasweapon(getweapon(#"tomahawk_t8_upgraded")))
        {
            b_any_has_hell_retriever = true;
            break;
        }
    }

    if (!b_any_has_hell_retriever && !level flag::get(#"soul_catchers_charged"))
    {
        level thread Directed_SetObjective(9);

        foreach(dog in level.var_4952e1)
        {
            if (isdefined(dog.is_charged) && dog.is_charged)
                continue;
            
            dog_ent = undefined;
            if (dog.script_noteworthy == "rune_3") {
                dog_ent = getent("rune_3", "targetname");
            } else if (dog.script_noteworthy == "rune_2") {
                dog_ent = getent("rune_2", "targetname");
            } else if (dog.script_noteworthy == "rune_1") {
                dog_ent = getent("rune_1", "targetname");
            }
            if (isdefined(dog_ent))
            {
                fake_model = util::spawn_model(#"tag_origin", dog_ent.origin, dog_ent.angles);
                fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", dog, #"fully_charged");
                fake_model thread directed_mark_dog_charge(dog);
            }
        }

        level flag::wait_till(#"soul_catchers_charged");
        level thread Directed_SetObjective(10);

        s_pos_trigger = struct::get("t_tom_pos", "targetname");
        fake_model = util::spawn_model(#"tag_origin", s_pos_trigger.origin, s_pos_trigger.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", level, #"tomahawk_aquired");
        level waittill(#"tomahawk_aquired");
        fake_model delete();
    }
    
    // Spoon
    any_has_spoon = false;
    foreach(player in level.players)
    {
        if (player hasweapon(getweapon(#"spoon_alcatraz")) || player hasweapon(getweapon(#"spork_alcatraz")) || player hasweapon(getweapon(#"golden_knife")) || player hasweapon(getweapon(#"spknifeork")))
        {
            any_has_spoon = true;
            break;
        }
    }

    if (!any_has_spoon)
    {
        level thread Directed_SetObjective(11);

        clues = array(#"n_c_w_p_01", #"n_c_w_p_02", #"n_c_w_p_03");
        foreach(clue in clues)
        {
            clue_ent = struct::get(clue);
            if (isdefined(clue_ent))
            {
                fake_model = util::spawn_model(#"tag_origin", clue_ent.origin + (0, 0, 25), clue_ent.angles);
                fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", level, #"stop_clues_objective");
                fake_model thread fake_model_wait_for_clue_end();
            }
        }

        code_input = struct::get("nixie_tube_2");
        if (isdefined(code_input))
        {
            fake_model = util::spawn_model(#"tag_origin", code_input.origin, code_input.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", level, #"stop_clues_objective");
            fake_model thread fake_model_wait_for_clue_end();
        }

        level flag::wait_till(#"hash_ed90925c898d1b0");
        level notify(#"stop_clues_objective");
        
        level thread Directed_SetObjective(12);
        crank_box = getent("crane_shock_box", "script_string");
        fake_model = util::spawn_model(#"tag_origin", crank_box.origin + (0, 0, 50), crank_box.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", crank_box, #"hash_7e1d78666f0be68b");
        crank_box waittill(#"hash_7e1d78666f0be68b");
        fake_model delete();

        level flag::wait_till(#"hash_6f71660057a5952f");

        level thread Directed_SetObjective(13);
        tomo_thing = getent("cr_sk_hit", "targetname");
        fake_model = util::spawn_model(#"tag_origin", tomo_thing.origin, tomo_thing.angles);
        fake_model linkTo(tomo_thing);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", tomo_thing, #"stop_tomo_objective");
        level flag::wait_till(#"hash_66f358c0066d77d8");
        tomo_thing notify(#"stop_tomo_objective");
        fake_model delete();

        level thread Directed_SetObjective(14);
        spoon_trig = struct::get("t_sp_pi");
        fake_model = util::spawn_model(#"tag_origin", spoon_trig.origin, spoon_trig.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", spoon_trig, #"trigger");
        level flag::wait_till(#"spoon_quest_completed");
        fake_model delete();
    }

    level thread Directed_SetRoundCap(11);

    // Wonder Weapon
    b_any_has_ww = false;
    foreach(player in level.players)
    {
        if (player hasWeapon(getweapon(#"ww_blundergat_t8")) || player hasWeapon(getweapon(#"ww_blundergat_t8_upgraded")) || player hasWeapon(getweapon(#"ww_blundergat_fire_t8")) || player hasWeapon(getweapon(#"ww_blundergat_fire_t8_upgraded")) || player hasWeapon(getweapon(#"ww_blundergat_acid_t8")) || player hasWeapon(getweapon(#"ww_blundergat_acid_t8_upgraded")) || player hasWeapon(getweapon(#"hash_494f5501b3f8e1e9")))
        {
            b_any_has_ww = true;
            break;
        }
    }

    if (!b_any_has_ww)
    {
        level thread Directed_SetObjective(15);
        level.skulls_collected = 0;
        foreach (mdl_skull in level.sq_bg_macguffins) {
            if (!isdefined(mdl_skull)) {
                continue;
            }
            if (!(isdefined(mdl_skull.b_collected) && mdl_skull.b_collected)) {
                mdl_skull thread directed_add_new_objective(#"enh_objective", 1, #"death", mdl_skull, #"caught_by_tomahawk");
                mdl_skull thread directed_update_skull_objective();
            }
        }
        
        level waittill(#"all_macguffins_acquired");
        level thread Directed_SetObjective(16);

        pick_up = struct::get("sq_bg_reward_pickup", "targetname");
        fake_model = util::spawn_model(#"tag_origin", pick_up.origin, pick_up.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", pick_up, #"trigger");
        level flag::wait_till(#"warden_blundergat_obtained");
        fake_model delete();
    }

    // Wonder Weapon Upgrade
    b_any_has_ww_upgraded = false;
    foreach(player in level.players)
    {
        if (player hasWeapon(getweapon(#"ww_blundergat_fire_t8")) || player hasWeapon(getweapon(#"ww_blundergat_fire_t8_upgraded")) || player hasWeapon(getweapon(#"ww_blundergat_acid_t8")) || player hasWeapon(getweapon(#"ww_blundergat_acid_t8_upgraded")) || player hasWeapon(getweapon(#"hash_494f5501b3f8e1e9")))
        {
            b_any_has_ww_upgraded = true;
            break;
        }
    }

    if (!b_any_has_ww_upgraded)
    {
        b_fail = false;
        b_give_blundergat = false;
        player_to_use = undefined;
        while(true)
        {
            if (b_fail && isdefined(player_to_use) && b_give_blundergat)
            {
                b_fail = false;
                b_give_blundergat = false;
                player_to_use thread zm_weapons::weapon_give(getweapon(#"ww_blundergat_t8"));
            }

            foreach(player in level.players)
            {
                if (player hasWeapon(getweapon(#"ww_blundergat_t8")) || player hasWeapon(getweapon(#"ww_blundergat_t8_upgraded")))
                {
                    player_to_use = player;
                    break;
                }
            }

            level thread Directed_SetObjective(17);
            place_wonder = struct::get("mg_fp_pos");
            fake_model = util::spawn_model(#"tag_origin", place_wonder.origin, place_wonder.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", place_wonder, #"death");
            level waittill(#"trigger_blundergat_objective");
            fake_model delete();

            level thread Directed_SetObjective(18);
            while(level.var_19a54d73 < 15)
            {
                // fail logic
                if (level flag::get(#"hash_3ec656e276ceee53"))
                {
                    b_fail = true;
                    b_give_blundergat = true;
                    break;
                }

                level thread Directed_UpdateObjective(level.var_19a54d73);
                wait 0.5;
            }

            if (b_fail)
                continue;

            level thread Directed_SetObjective(19);
            place_wonder = struct::get("mg_fp_pos");
            fake_model = util::spawn_model(#"tag_origin", place_wonder.origin, place_wonder.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", place_wonder, #"death");
            level flag::wait_till(#"hash_5e6097345e223e2d");
            fake_model delete();

            level thread Directed_SetObjective(20);
            barrels = struct::get_array("mg_fire_urn", "targetname");
            foreach(barrel in barrels)
            {
                fake_model = util::spawn_model(#"tag_origin", barrel.origin, barrel.angles);
                fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", barrel, #"stop_barrel_objective");
                fake_model thread directed_wait_barrel_objective(barrel);
            }

            upgrade_station = struct::get("mg_forg_pos");
            upgrade_station_target = struct::get(upgrade_station.target);
            fake_model = util::spawn_model(#"tag_origin", upgrade_station_target.origin, upgrade_station_target.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", level, #"stop_barrel_objective");

            level thread Directed_UpdateObjective(25);
            wait 3;
            foreach(player in level.players)
            {
                if (isdefined(player.n_cooldown_time) && player.n_cooldown_time > 0)
                {
                    player_to_use = player;
                    break;
                }
            }

            if (isdefined(player_to_use))
            {
                level thread UpdateBlunderSeconds(player_to_use);
            }
            
            str_result = level waittill(#"hash_5dc448a84a24492", #"magma_timeout_objective");
            if (str_result._notify == #"magma_timeout_objective")
            {
                b_fail = true;
                level thread Directed_SetObjective(32);

                barrels = struct::get_array("mg_fire_urn", "targetname");
                foreach(barrel in barrels)
                {
                    barrel notify(#"stop_barrel_objective");
                }

                fake_model delete();

                wait 3;
                continue;
            }

            level thread Directed_SetObjective(21);

            barrels = struct::get_array("mg_fire_urn", "targetname");
            foreach(barrel in barrels)
            {
                barrel notify(#"stop_barrel_objective");
            }

            level flag::wait_till(#"magma_forge_completed");
            fake_model delete();
            break;
        }
    }

    // Main Quest
    // Wall Step
    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 1))
    {
        spawner::function_89a2cd87(#"brutus", &can_slam_attack);
        wall_damage = getent("w_h_h_d_clip_m", "targetname");
        fake_model = util::spawn_model(#"tag_origin", wall_damage.origin, wall_damage.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", wall_damage, #"death");

        if (!isdefined(level.spoon_wall_set))
        {
            level thread Directed_SetObjective(22);
            level waittill(#"hash_4aedd2f50e5e307");
        }

        level thread Directed_SetObjective(23);
        level thread WallWatcher();

        brutus = undefined;
        while(true)
        {
            a_e_brutus = getaiarchetypearray(#"brutus");

            if (a_e_brutus.size > 0)
            {
                brutus = a_e_brutus[0];

                if (isdefined(brutus) && !isdefined(brutus.added_objective))
                {
                    brutus.added_objective = true;
                    brutus thread directed_add_new_objective(#"enh_objective", 1, #"death", brutus, #"death_brutus");
                }
            }
            else
            {
                level [[ @zombie_brutus_util<scripts\zm_common\util\ai_brutus_util.gsc>::attempt_brutus_spawn ]](1);
            }

            if (isdefined(level.broken_wall_set))
                break;

            wait 1;
        }

        if (isdefined(brutus) && isdefined(brutus.added_objective) && brutus.added_objective)
        {
            brutus notify(#"death_brutus");
        }

        fake_model delete();

        level thread Directed_SetObjective(24);

        s_orb = struct::get("s_house_orb");
        fake_model = util::spawn_model(#"tag_origin", s_orb.origin, s_orb.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", s_orb, #"death");
        level flag::wait_till(#"hash_61bba9aa86f61865");
        fake_model delete();

        power_switch = struct::get("s_ch_sw");
        fake_model = util::spawn_model(#"tag_origin", power_switch.origin, power_switch.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", power_switch, #"death");
        level flag::wait_till(#"hash_379fc22ed85f0dbc");
        fake_model delete();
    }

    level thread Directed_SetRoundCap(12);

    // Bird Step
    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 2))
    {
        level thread Directed_SetObjective(25);
        Map_Wall = struct::get("s_p_s2_ins");
        fake_model = util::spawn_model(#"tag_origin", Map_Wall.origin, Map_Wall.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", Map_Wall, #"death");
        Map_Wall.s_unitrigger_stub waittill(#"hash_4c6ab2a4a99f9539");
        fake_model delete();

        level thread Directed_SetObjective(26);
        Book_Scene = struct::get("s_p_s2_b");
        Book = Book_Scene.scene_ents[#"book"];

        fake_model = util::spawn_model(#"tag_origin", Book.origin, Book.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", Book, #"death");
        level waittill(#"hash_6da514c90059d5c2");
        fake_model delete();

        level thread Directed_SetObjective(27);

        while(!isdefined(level.var_dcc985c4) || !isdefined(level.var_dcc985c4.script_string) || !isdefined(level.var_dcc985c4.mdl_bird))
        {
            wait 0.1;
        }

        // 3 times, 4th is special
        blasted_bird_times = 0;
        for(i = 1; i <= 3; i++)
        {
            level Directed_SetObjective(27);
            wait 0.1;
            level Directed_UpdateObjective(blasted_bird_times);

            fake_model = util::spawn_model(#"tag_origin", level.var_dcc985c4.mdl_bird.origin, level.var_dcc985c4.mdl_bird.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", level.var_dcc985c4.mdl_bird, #"death");
            level waittill(#"seagull_blasted");
            fake_model delete();

            blasted_bird_times++;
            level thread Directed_UpdateObjective(blasted_bird_times);

            wait 1;
            level thread Directed_SetObjective(29);

            level waittill(#"between_round_over");
            wait 3;
        }

        wait 5;

        while(true)
        {
            level thread StartDroppingBloods();
            level thread Directed_SetObjective(28);

            fake_model = util::spawn_model(#"tag_origin", level.var_dcc985c4.mdl_bird.origin, level.var_dcc985c4.mdl_bird.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", level.var_dcc985c4.mdl_bird, #"death");

            while(!level flag::get(#"hash_8c500dbad4c6edb") && isdefined(level.var_dcc985c4.mdl_bird))
            {
                wait 0.1;
            }

            if (!isdefined(level.var_dcc985c4.mdl_bird))
            {
                level notify(#"stop_dropping_bloods");
                level thread Directed_SetObjective(31);
                fake_model delete();
                level waittill(#"between_round_over");
                wait 3;
                continue;
            }

            fake_model delete();
            break;
        }

        wait 1;

        level thread Directed_SetObjective(30);
        level notify(#"stop_dropping_bloods");
        level.mdl_book_zombie thread directed_add_new_objective(#"enh_objective", 1, #"death", level.mdl_book_zombie, #"death");
        level.mdl_book_zombie waittill(#"death");

        level thread Directed_SetObjective(33);

        book_loc = struct::get("k_fx_pos");
        fake_model = util::spawn_model(#"tag_origin", book_loc.origin, book_loc.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", book_loc, #"trigger");
        
        while(!isdefined(level.var_bbc27d0e))
            util::wait_network_frame();

        fake_model delete();
    }

    level thread Directed_SetRoundCap(16);
    level thread Directed_SetObjective(34);

    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 3))
    {
        // Challenges, // function_486ef0f6
        while(!isdefined(level.var_85cc9fcc))
            util::wait_network_frame();

        while(!isdefined(level.var_bbc27d0e))
            util::wait_network_frame();

        old_code = "";
        while(true)
        {
            // all challenges done
            if (!(level.var_85cc9fcc.size > 0))
                break;
            
            level thread Directed_SetObjective(34);
            fake_model = util::spawn_model(#"tag_origin", level.var_bbc27d0e.origin, level.var_bbc27d0e.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", level.var_bbc27d0e, #"death");
            level.var_bbc27d0e waittill(#"hash_1f3cf68a268a10f1");
            
            level thread Directed_SetObjective(35);

            code_input = struct::get("nixie_tube_2");
            if (isdefined(code_input))
            {
                fake_model_input = util::spawn_model(#"tag_origin", code_input.origin, code_input.angles);
                fake_model_input thread directed_add_new_objective(#"enh_objective", 1, #"death", fake_model_input, #"stop_clues_objective");
                fake_model_input thread fake_model_wait_for_clue_end();
            }
            
            result = level waittill(#"challenge_selected");
            while(!isdefined(level.var_99b333e1) || (isdefined(level.var_99b333e1) && old_code == ("" + level.var_99b333e1[0] + level.var_99b333e1[1] + level.var_99b333e1[2])))
                util::wait_network_frame();
            result_code_needed = "" + level.var_99b333e1[0] + level.var_99b333e1[1] + level.var_99b333e1[2];
            old_code = result_code_needed;

            while (true) {
                s_result = level waittill(#"hash_1ba800da972b0558");
                if (s_result.str_code == result_code_needed) {
                    break;
                }
            }

            fake_model delete();
            fake_model_input delete();

            level thread Directed_SetObjective(36);
            orb_to_use = level.current_orb_challenge;
            fake_model = util::spawn_model(#"tag_origin", orb_to_use.origin, orb_to_use.angles);
            fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", orb_to_use, #"death");

            s_result = orb_to_use waittill(#"portal_timeout", #"blast_attack");
            if (s_result._notify == #"portal_timeout") {
                level thread Directed_SetObjective(37);
                fake_model delete();
                wait 3;
                continue;
            }

            fake_model delete();
            switch (result.challenge) {
                case "new_industries":
                    level Directed_NewIndustriesChallenge();
                    break;

                case "showers":
                    level Directed_ShowersChallenge();
                    break;

                case "cellblock":
                    level Directed_CellblockChallenge();
                    break;

                case "docks":
                    level Directed_DocksChallenge();
                    break;

                case "power_plant":
                    level Directed_PowerPlantChallenge();
                    break;
            }

            wait 5;
        }

        level thread Directed_SetObjective(57);
        map_use = struct::get("s_p_s2_ins");
        fake_model = util::spawn_model(#"tag_origin", map_use.origin, map_use.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", map_use, #"death");
        map_use.s_unitrigger_stub waittill(#"hash_4c6ab2a4a99f9539");
        fake_model delete();
    }

    if (!(isdefined(level.MainQuest_Step) && level.MainQuest_Step >= 4))
    {
        // Pre-Brutus
        level thread Directed_SetObjective(58);
        summon_use = struct::get("s_p_s4_s_k_ins");
        fake_model = util::spawn_model(#"tag_origin", summon_use.origin, summon_use.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", summon_use, #"death");
        level flag::wait_till(#"hash_73b06a8a2c0b0e8d");
        fake_model delete();

        level thread Directed_SetObjective(59);
        level flag::wait_till(#"hash_2ae01ca8561c1819");

        level thread Directed_SetObjective(60);
        bag = struct::get("p_s_4_bag");
        fake_model = util::spawn_model(#"tag_origin", bag.origin, bag.angles);
        fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", bag, #"death");
        level waittill(#"hash_71944131dc1aa5f0");
        fake_model delete();

        level thread Directed_SetObjective(61);
        level.var_7a548c75 thread directed_add_new_objective(#"enh_objective", 1, #"death", level.var_7a548c75, #"stop_bag_objective");
        level waittill(#"drop_o");
        level.var_7a548c75 notify(#"stop_bag_objective");

        s_orb = struct::get("s_p_s_4_b_g_p_orb");
        while(!isdefined(s_orb.mdl_orb))
        {
            util::wait_network_frame();
        }

        level thread Directed_SetObjective(62);
        s_orb.mdl_orb thread directed_add_new_objective(#"enh_objective", 1, #"death", s_orb.mdl_orb, #"death");
        s_orb.mdl_orb waittill(#"death");
    }

    level thread Directed_SetRoundCap(20);
    level thread Directed_SetObjective(63);
    mdl_door = struct::get("s_p_s2_ins");
    fake_model = util::spawn_model(#"tag_origin", mdl_door.origin, mdl_door.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", mdl_door, #"death");
    level flag::wait_till(#"activate_west_side_exterior_stairs");
    fake_model delete();

    level thread Directed_SetObjective(64);
    mdl_door = getent("c29_door", "targetname");
    fake_model = util::spawn_model(#"tag_origin", mdl_door.origin, mdl_door.angles);
    fake_model thread directed_add_new_objective(#"enh_objective", 1, #"death", mdl_door, #"death");
    level flag::wait_till(#"hash_4fac802bd5dcebf4");
    fake_model delete();

    // Final Showdown
    level thread Directed_SetObjective(65);
    level flag::wait_till(#"main_quest_completed");

    level thread Directed_SetObjective(999);
    level thread Directed_Change_GameOver_Screen();
}