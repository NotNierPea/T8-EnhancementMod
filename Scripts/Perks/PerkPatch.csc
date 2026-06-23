// TODO: reduce bits and try to get .progress better....
detour zm_perks<scripts\zm_common\zm_perks.csc>::perks_register_clientfield()
{
    //if (!GetDvarInt("shield_enh_Perka", 0))
	// return [[ @zm_perks<scripts\zm_common\zm_perks.csc>::perks_register_clientfield ]]();

    if (isdefined(level.zombiemode_using_perk_intro_fx) && level.zombiemode_using_perk_intro_fx) {
        clientfield::register("scriptmover", "clientfield_perk_intro_fx", 1, 1, "int", &zm_perks::perk_meteor_fx, 0, 0);
    }

    if (level._custom_perks.size > 0) {
        a_keys = getarraykeys(level._custom_perks);
        for (i = 0; i < a_keys.size; i++) {
            if (isdefined(level._custom_perks[a_keys[i]].clientfield_register)) {
                level [[ level._custom_perks[a_keys[i]].clientfield_register ]]();
            }
        }
    }

    for (i = 0; i < 4; i++) {
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".itemIndex", 1, 5, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".state", 1, 2, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".progress", 1, 5, "float", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".chargeCount", 1, 3, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".timerActive", 1, 1, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".bleedoutOrderIndex", 1, 2, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".bleedoutActive", 1, 1, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".specialEffectActive", 1, 1, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.perkVapor." + i + ".modifierActive", 6000, 1, "int", undefined, 0, 0);
    }
    
    clientfield::register("clientuimodel", "hudItems.perkVapor.bleedoutProgress", 9000, 8, "float", undefined, 0, 0);
    
    for (i = 0; i < 13; i++) {
        n_version = 1;
        if (i >= 4) {
            n_version = 8000;
        }
        clientfield::register("clientuimodel", "hudItems.extraPerkVapor." + i + ".itemIndex", n_version, 5, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.extraPerkVapor." + i + ".state", n_version, 2, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.extraPerkVapor." + i + ".progress", n_version, 2, "float", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.extraPerkVapor." + i + ".chargeCount", n_version, 2, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.extraPerkVapor." + i + ".timerActive", n_version, 1, "int", undefined, 0, 0);
        clientfield::register("clientuimodel", "hudItems.extraPerkVapor." + i + ".specialEffectActive", n_version, 1, "int", undefined, 0, 0);
    }

    clientfield::register("scriptmover", "" + #"hash_cf74c35ecc5a49", 1, 1, "int", &zm_perks::function_bb184fed, 0, 0);
    clientfield::register("toplayer", "" + #"hash_35fe26fc5cb223b3", 1, 3, "int", &zm_perks::_train_sd_bombexplode, 0, 1);
    clientfield::register("toplayer", "" + #"hash_6fb426c48a4877e0", 1, 3, "int", &zm_perks::function_d5f2f6ac, 0, 1);
    clientfield::register("toplayer", "" + #"hash_345845080e40675d", 1, 3, "int", &zm_perks::function_136826b0, 0, 1);
    clientfield::register("toplayer", "" + #"hash_1da6660f0414562", 1, 3, "int", &zm_perks::function_a4c33786, 0, 1);
   
   if (level.var_c3e5c4cd == 2) {
        clientfield::register("world", "" + #"hash_46334db9e3c76275", 1, 1, "int", &zm_perks::function_9b4bc8e7, 0, 0);
        clientfield::register("scriptmover", "" + #"hash_50eb488e58f66198", 1, 1, "int", &zm_perks::function_52c149b2, 0, 0);
        clientfield::register("allplayers", "" + #"hash_222c3403d2641ea6", 1, 3, "int", &zm_perks::function_ab7cd429, 0, 0);
        clientfield::register("toplayer", "" + #"hash_17283692696da23b", 1, 1, "counter", &zm_perks::function_ccbdf992, 0, 0);
    }

    level thread zm_perks::perk_init_code_callbacks();
}