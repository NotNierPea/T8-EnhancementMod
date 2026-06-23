detour zm_red_challenges<scripts\zm\zm_red_challenges.csc>::init() {
    if (zm_utility::is_standard()) {
        return;
    }

    clientfield::register("scriptmover", "" + #"hash_74fc30de57a0657a", 16000, 3, "int", @zm_red_challenges<scripts\zm\zm_red_challenges.csc>::function_de1bffd6, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_21f5fab6a3d22093", 16000, 3, "int", @zm_red_challenges<scripts\zm\zm_red_challenges.csc>::function_9ed71eeb, 0, 0);

    //clientfield::register("scriptmover", "" + #"keyline_model", 16000, 1, "int", &keyline_model, 0, 0);
    //clientfield::register("scriptmover", "" + #"pickup_glow", 16000, 1, "int", &pickup_glow, 0, 0);

    clientfield::register("scriptmover", "" + #"hash_8b48433c3fe40e4", 16000, 3, "int", @zm_red_challenges<scripts\zm\zm_red_challenges.csc>::function_75ac8f21, 0, 0);
    clientfield::register("toplayer", "" + #"hash_4bde11d71410ea67", 16000, 3, "int", @zm_red_challenges<scripts\zm\zm_red_challenges.csc>::function_250bbf4e, 0, 0);
    clientfield::register("world", "" + #"cleanup_challenges", 16000, 1, "int", @zm_red_challenges<scripts\zm\zm_red_challenges.csc>::cleanup_challenges, 0, 0);
    clientfield::register("allplayers", "" + #"hash_47490b879090eb55", 16000, 3, "int", @zm_red_challenges<scripts\zm\zm_red_challenges.csc>::function_840d5e0b, 0, 0);
    clientfield::register("allplayers", "" + #"hash_7b1dd5c08e2585c", 16000, 3, "int", @zm_red_challenges<scripts\zm\zm_red_challenges.csc>::function_c63a4f32, 0, 0);
    clientfield::register("scriptmover", "" + #"rob_coals", 16000, 1, "int", @zm_red_challenges<scripts\zm\zm_red_challenges.csc>::rob_coals, 0, 0);

    level._effect[#"hash_379eadfebd945316"] = #"hash_556b5a8aa255768d";
    level._effect[#"hash_3229d3874a037840"] = #"hash_48053ee21dfed9c9";
    level._effect[#"hash_31c3f08749acf655"] = #"hash_482741e21e1bc548";
    level._effect[#"hash_31c0cd8749aa8505"] = #"hash_482b24e21e1f7cd8";
    level._effect[#"hash_5f92f2e28c7ef455"] = #"hash_13cf1738cd97717e";
    level._effect[#"brazier_fire_blue"] = #"hash_487863cb3f012833";
    level._effect[#"brazier_fire_green"] = #"hash_276c55785b205f4e";
    level._effect[#"hash_533608bb3b3407b6"] = #"hash_4eff7803b81cd67d";
    level._effect[#"brazier_fire_purple"] = #"hash_2a46ebc323110b3d";
    level._effect[#"hash_64a625f8e26e3699"] = #"hash_79207c9d697f9e30";
    level._effect[#"hash_fa374812e6016c9"][1] = #"hash_676d05725a4ffab9";
    level._effect[#"hash_eafc8632695ccef"][1] = #"hash_511e23c849ed0926";
    level._effect[#"hash_fa374812e6016c9"][2] = #"hash_5199aa40f704fb10";
    level._effect[#"hash_eafc8632695ccef"][2] = #"hash_1dfbcfd9b38812ed";
    level._effect[#"hash_fa374812e6016c9"][3] = #"hash_6bfc5d7fce6b2a4e";
    level._effect[#"hash_eafc8632695ccef"][3] = #"maps/zm_red/fx8_soul_charge_purple";
    level._effect[#"hash_fa374812e6016c9"][4] = #"hash_6cfbd6f08cfc2656";
    level._effect[#"hash_eafc8632695ccef"][4] = #"hash_17bb97645fa8148b";
    level._effect[#"pickup_glow"] = #"zm_weapons/fx8_cymbal_monkey_light";

    [[ @zm_red_challenges_rewards<scripts\zm\zm_red_challenges_rewards.csc>::init ]]();

    level.var_7987392b = undefined;
}