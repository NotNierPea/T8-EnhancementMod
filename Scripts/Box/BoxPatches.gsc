BoxPatches()
{
    if(GetDvarInt(#"shield_enh_BoxPatch", 0)) 
     thread Setup_BoxPatches();
}

Setup_BoxPatches()
{
    ShieldLog("^6Box Patches Enabled!");

    level flagsys::wait_till(#"zombie_vars_init");
    level flag::wait_till("initial_blackscreen_passed");

    foreach(chest in level.chests) chest._box_opened_by_fire_sale = undefined;
}

ForceBoxes()
{
    level endon(#"stop_forcing_boxes");

    if (isdefined(level.first_box_to_patch))
    {
        while(level.chest_accessed == 0)
        {
            level.forcethisweapon = level.first_box_to_patch;
            level.customrandomweaponweights = &ForceWeapon;
            foreach(chest in level.chests) chest._box_opened_by_fire_sale = undefined;
            wait 0.01;
        }
        level.chest_accessed = 0;
    }

    if (isdefined(level.second_box_to_patch))
    {
        while(level.chest_accessed == 0)
        {
            level.forcethisweapon = level.second_box_to_patch;
            level.customrandomweaponweights = &ForceWeapon;
            foreach(chest in level.chests) chest._box_opened_by_fire_sale = undefined;
            wait 0.01;
        }
        level.chest_accessed = 0;
    }

    if (isdefined(level.third_box_to_patch))
    {
        while(level.chest_accessed == 0)
        {
            level.forcethisweapon = level.third_box_to_patch;
            level.customrandomweaponweights = &ForceWeapon;
            foreach(chest in level.chests) chest._box_opened_by_fire_sale = undefined;
            wait 0.01;
        }
        level.chest_accessed = 0;
    }
}

ForceWeapon(a_keys)
{
    level.customrandomweaponweights = undefined;
    arrayinsert(a_keys, getweapon(level.forcethisweapon), 0);
    return a_keys;
}