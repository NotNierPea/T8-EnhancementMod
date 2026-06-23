AllWeaponsinBox()
{
    if(GetDvarInt(#"shield_enh_AllWeaponsinBox", 0))
     thread Setup_AllWeaponsinBox();
}

Setup_AllWeaponsinBox()
{
    ShieldLog("^6All Weapons in Box Enabled!");

    if (GetDvarInt(#"shield_enh_ClassicMode", 0))
    {
        ShieldLog("^6All Weapons in Box Classic Only Mode..");

        foreach(weapon in level.zombie_weapons)
        {
            if(zm_loadout::is_lethal_grenade(weapon.weapon))
            {
                weapon.is_in_box = 1;
            }
        }
    }
    else
    {
        foreach(weapon in level.zombie_weapons)
        {
            weapon.is_in_box = 1;

            if(isdefined(weapon.weapon.isriotshield) && weapon.weapon.isriotshield)
            {
                weapon.is_in_box = 1;
            }
        }

        if(BO4GetMap() == "AE") // just incase if they dont get included in box
        {
            Hand1 = GetWeapon("ww_hand_g");
            Hand2 = GetWeapon("ww_hand_c");
            Hand3 = GetWeapon("ww_hand_h");
            Hand4 = GetWeapon("ww_hand_o");
            Thu = GetWeapon(#"thunderstorm");
            Hand1.is_in_box = 1;
            Hand2.is_in_box = 1;
            Hand3.is_in_box = 1;
            Hand4.is_in_box = 1;
            Thu.is_in_box = 1;
        }

        homunculus = GetWeapon(#"homunculus");
        cymbal_monkey = GetWeapon(#"cymbal_monkey");
        homunculus.is_in_box = 1;
        cymbal_monkey.is_in_box = 1;
    }
}