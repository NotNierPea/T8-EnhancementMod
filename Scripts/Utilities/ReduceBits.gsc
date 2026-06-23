/* still used for something ig
detour bgb<scripts\zm_common\zm_bgb.gsc>::__init__() {

    On_Spawn = @bgb<scripts\zm_common\zm_bgb.gsc>::on_player_spawned;

    callback::on_spawned(On_Spawn);

    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }

    level.weaponbgbgrab = getweapon(#"zombie_bgb_grab");
    level.var_ddff6359 = array(getweapon(#"hash_d0f29de78e218ad"), getweapon(#"hash_5e07292c519531e6"), getweapon(#"hash_305e5faa9ecb625a"), getweapon(#"hash_23cc1f9c16b375c3"), getweapon(#"hash_155cc0a9ba3c3260"), getweapon(#"hash_2394c41f048f7d2"), getweapon(#"hash_4565adf3abc61ea3"));
    level.bgb = [];

    clientfield::register_clientuimodel("zmhud.bgb_current", 1, 1, "int", 0);
    clientfield::register_clientuimodel("zmhud.bgb_display", 1, 1, "int", 0);
    clientfield::register_clientuimodel("zmhud.bgb_timer", 1, 1, "float", 0);
    clientfield::register_clientuimodel("zmhud.bgb_activations_remaining", 1, 1, "int", 0);
    clientfield::register_clientuimodel("zmhud.bgb_invalid_use", 1, 1, "counter", 0);
    clientfield::register_clientuimodel("zmhud.bgb_one_shot_use", 1, 1, "counter", 0);
    clientfield::register("toplayer", "bgb_blow_bubble", 1, 1, "counter");

    vehicle_damage_override = @bgb<scripts\zm_common\zm_bgb.gsc>::vehicle_damage_override;
    lost_perk_override = @bgb<scripts\zm_common\zm_bgb.gsc>::lost_perk_override;

    zm::register_vehicle_damage_callback(vehicle_damage_override);
    zm_perks::register_lost_perk_override(lost_perk_override);
}
*/

detour zm_red_challenges<scripts\zm\zm_red_challenges.gsc>::init()  {
    if (zm_utility::is_standard()) {
        return;
    }

    clientfield::register("scriptmover", "" + #"hash_74fc30de57a0657a", 16000, 3, "int");
    clientfield::register("scriptmover", "" + #"hash_21f5fab6a3d22093", 16000, 3, "int");

    //clientfield::register("scriptmover", "" + #"keyline_model", 16000, 1, "int");
    //clientfield::register("scriptmover", "" + #"pickup_glow", 16000, 1, "int");

    clientfield::register("scriptmover", "" + #"hash_8b48433c3fe40e4", 16000, 3, "int");
    clientfield::register("toplayer", "" + #"hash_4bde11d71410ea67", 16000, 3, "int");
    clientfield::register("world", "" + #"cleanup_challenges", 16000, 1, "int");
    clientfield::register("allplayers", "" + #"hash_47490b879090eb55", 16000, 3, "int");
    clientfield::register("allplayers", "" + #"hash_7b1dd5c08e2585c", 16000, 3, "int");
    clientfield::register("scriptmover", "" + #"rob_coals", 16000, 1, "int");
    level flag::init("fl_challenge_phase_1");
    level flag::init("fl_challenge_phase_2");
    level flag::init("fl_challenge_phase_3");
    level.var_c540c875 = struct::get_array("s_challenge_loc_x", "targetname");
    level.var_c540c875 = array::randomize(level.var_c540c875);
    level.var_e3a16c1e = 0;
    level.var_f7c11d3b = [];
    for (i = 0; i < 21; i++) {
        level.var_f7c11d3b[i] = 0;
    }
    level flag::init("fl_challenges_initialized");
    level flag::init("fl_challenges_active");
    level thread [[ @zm_red_challenges<scripts\zm\zm_red_challenges.gsc>::function_e3f96252 ]]();
    level thread [[ @zm_red_challenges<scripts\zm\zm_red_challenges.gsc>::function_756c88b7 ]]();
    level thread [[ @zm_red_challenges<scripts\zm\zm_red_challenges.gsc>::function_8ff7b0bb ]]();
    callback::on_connecting(@zm_red_challenges<scripts\zm\zm_red_challenges.gsc>::on_player_connect);
    callback::on_ai_killed(@zm_red_challenges<scripts\zm\zm_red_challenges.gsc>::on_ai_killed);
    level.var_857878e6 = @zm_red_challenges<scripts\zm\zm_red_challenges.gsc>::function_857878e6;
    zm::register_actor_damage_callback(@zm_red_challenges<scripts\zm\zm_red_challenges.gsc>::actor_damage_callback);
    level.var_45420301 = [];
    level.var_45420301[level.var_45420301.size] = #"weapon_pistol";
    level.var_45420301[level.var_45420301.size] = #"weapon_cqb";
    level.var_45420301[level.var_45420301.size] = #"weapon_assault";
    level.var_45420301[level.var_45420301.size] = #"weapon_tactical";
    level.var_45420301[level.var_45420301.size] = #"weapon_lmg";
    level.var_45420301[level.var_45420301.size] = #"weapon_sniper";
    level.var_45420301[level.var_45420301.size] = #"weapon_knife";
    level.var_45420301 = array::randomize(level.var_45420301);
    level.var_b95f226e = 0;
    level.var_54800463 = [];
    level.var_54800463[level.var_54800463.size] = #"torso";
    level.var_54800463[level.var_54800463.size] = #"arms";
    level.var_54800463[level.var_54800463.size] = #"hands";
    level.var_54800463[level.var_54800463.size] = #"legs";
    level.var_54800463[level.var_54800463.size] = #"feet";
    level.var_7ccd49a7 = 0;
    level.var_529bdc63 = [];
    level.var_529bdc63[0] = struct::spawn();
    level.var_529bdc63[0].n_zombie_archetype = #"gegenees";
    level.var_529bdc63[0].str_msg = #"hash_7d3a87af11535537";
    level.var_529bdc63[0].var_18f2b3cb = 0.05;
    level.var_529bdc63[0].str_zone = undefined;
    level.var_529bdc63[1] = struct::spawn();
    level.var_529bdc63[1].n_zombie_archetype = #"blight_father";
    level.var_529bdc63[1].str_msg = #"hash_33f17c3034f8da74";
    level.var_529bdc63[1].var_18f2b3cb = 0.08;
    level.var_529bdc63[1].str_zone = undefined;
    level.var_529bdc63[2] = struct::spawn();
    level.var_529bdc63[2].n_zombie_archetype = #"skeleton";
    level.var_529bdc63[2].str_msg = #"hash_2e51dfa0a7d98b5a";
    level.var_529bdc63[2].var_18f2b3cb = 0.07;
    level.var_529bdc63[2].str_zone = undefined;
    level.var_529bdc63[3] = struct::spawn();
    level.var_529bdc63[3].n_zombie_archetype = #"catalyst";
    level.var_529bdc63[3].str_msg = #"hash_30c2fa2ab04f1d99";
    level.var_529bdc63[3].var_18f2b3cb = 0.07;
    level.var_529bdc63[3].str_zone = undefined;
    level.var_529bdc63 = array::randomize(level.var_529bdc63);
    level.var_848df2ac = 0;
    [[ @zm_red_challenges_rewards<scripts\zm\zm_red_challenges_rewards.gsc>::init ]]();
    level.var_fb3a9df0 = 0;
    level.var_c6ab748f = 0;
    level.var_8b7ab859 = 1000;
    level.var_e8503818 = [];
    level.var_e8503818[1] = #"hash_725802b808e14c76";
    level.var_e8503818[2] = #"hash_725802b808e14c76";
    level.var_e8503818[3] = #"hash_725802b808e14c76";
    level.var_e8503818[4] = #"hash_725802b808e14c76";
    level.var_e8503818[5] = #"hash_725802b808e14c76";
    level.var_e8503818[6] = #"hash_725802b808e14c76";
    level.var_e8503818[7] = #"hash_725802b808e14c76";
    level.var_e8503818[13] = #"hash_6401bc0ff0d3db94";
    level.var_e8503818[10] = #"hash_73d3851d119f51a4";
    level.var_e8503818[11] = #"hash_6b8b6df4e4c161a7";
    level.var_e8503818[14] = #"hash_25b9a3d3430aa158";
    level.var_e8503818[15] = #"hash_59056a7b92714e58";
    level.var_e8503818[16] = #"hash_59056a7b92714e58";
    level.var_e8503818[17] = #"hash_59056a7b92714e58";
    level.var_e8503818[18] = #"hash_59056a7b92714e58";
    level.var_e8503818[19] = #"hash_59056a7b92714e58";
    level.var_e8503818[20] = #"hash_59056a7b92714e58";
    level.var_e8503818[12] = #"hash_5440bf458877a7e2";
    level.var_e8503818[0] = #"hash_1517f0bbb322181e";
    level.var_e8503818[9] = #"hash_3cdcae60e7ea21e7";
    level.var_e8503818[8] = #"hash_62cbc1e881d872fb";
    level.var_edbe6a7f = [];
    level.var_edbe6a7f[0] = 0;
    level.var_edbe6a7f[1] = 0;
    level.var_edbe6a7f[2] = 0;
    level.var_edbe6a7f[3] = 0;
}