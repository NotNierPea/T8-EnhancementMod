T8WeaponsDrops()
{
    clientfield::register("scriptmover", "highlight_shit", 1, 1, "int");

    if(!GetDvarInt(#"shield_enh_DropWeapons", 0))
        return;

    level.weapon_ui_index = 0;
    callback::on_spawned(&WeaponDropsPlayer);
}

WeaponDropsPlayer()
{
    self endon(#"death", "disconnect");

    level flag::wait_till("initial_blackscreen_passed"); // waits for players
    wait 2;
    
    self iPrintLn("^0to Drop Weapons, Hold [{+activate}] and Aim!");
    while(true)
    {
       if(self useButtonPressed() && self AdsButtonPressed())
       {
            holdRequired = 0.5; // hold
            elapsed = 0;
            tick = 0.1;

            while(self useButtonPressed() && self AdsButtonPressed() && elapsed < holdRequired)
            {
                wait tick;
                elapsed += tick;
            }

            if(elapsed >= holdRequired)
            {
                self DropWeapon();
                wait 0.25;
            }
       }

       wait 0.1;
    }
}

DroppedWeapon_CheckPickup(e_player)
{
    model = self.stub.related_parent;

    if (!isdefined(self) || !isplayer(e_player))
        return false;
    
    if (!isdefined(model) || !isdefined(model.weapon))
        return false;

    if (!e_player util::is_looking_at(model))
        return false;
    
    self setcursorhint("HINT_WEAPON", model.weapon);
    self sethintstring(#"hash_6a4c5538a960189d");
    return true;
}

WaitTriggerWeaponPickup() 
{
    self endon(#"death");
    model = self.stub.related_parent;

    while (true) {
        waitresult = self waittill(#"trigger");
        e_player = waitresult.activator;

        if (isplayer(e_player)) {
            e_player thread zm_weapons::weapondata_give(model.weapon_data);
            model notify("delete_me");
            return;
        }
    }
}

DropWeapon(weapon)
{
    CurrentWeapons = self getWeaponsListPrimaries();
    if(CurrentWeapons.size <= 1) // check if less than 2 weapons
        return;

    CurrentWeapon = (isDefined(weapon)) ? weapon : self GetCurrentWeapon();

    // checks
    if (!isdefined(CurrentWeapon) || CurrentWeapon === level.weaponnone || zm_loadout::is_hero_weapon(CurrentWeapon) || zm_equipment::is_equipment(CurrentWeapon) || (isDefined(CurrentWeapon.isriotshield) && CurrentWeapon.isriotshield))
        return;

    // spawn slightly above player so it sits in the air
    spawn_pos = self.origin + (0, 0, 18);
    dropped_weapon = zm_utility::spawn_weapon_model(CurrentWeapon, undefined, spawn_pos, self.angles, self GetWeaponOptions(CurrentWeapon));
    dropped_weapon clientfield::set("highlight_shit", 1);

    playsoundatposition(#"hash_23ed06ab941bc579", self.origin);
    //dropped_weapon clientfield::set("medallion_fx", 1);

    dropped_weapon.origin = spawn_pos;
    dropped_weapon bobbing((0, 0, 1), 5.5, 9.5);

    // save weapon's stats
    dropped_weapon.weapon = CurrentWeapon;
    dropped_weapon.weapon_data = self zm_weapons::get_player_weapondata(CurrentWeapon);

    // hash_6f931d032000253a < deadshot
    self playsoundtoplayer(#"hash_b8e60131176554b", self);
    self takeWeapon(CurrentWeapon);

    dropped_weapon thread WeaponRegisterTrigger();
    dropped_weapon thread UI_WeaponWatcher();
    dropped_weapon thread Timeout_DroppedWeapon(); // despawn later
}

WeaponRegisterTrigger()
{
    // ! wait to prevent instant pick-up !
    wait 0.5;
    self zm_unitrigger::create(&DroppedWeapon_CheckPickup, 64, &WaitTriggerWeaponPickup);
}

UI_WeaponWatcher()
{
    // create ui widget 3d (request, index, cords, weapon index)
    level.weapon_ui_index++;

    // failsafe
    if (level.weapon_ui_index > 5000)
        level.weapon_ui_index = 0;

    self_id = level.weapon_ui_index;
    weapon = weapons::getbaseweapon(self.weapon);
    weapon_id = getbaseweaponitemindex(weapons::getbaseweapon(self.weapon));

    // specials (500+), they do not have id set to them!!
    if (weapon_id == 0 || weapon.name == #"ray_gun")
    {
        // unpgraded..
        weapon_name_to_use = zm_weapons::get_base_weapon(self.weapon).name;
        switch(weapon_name_to_use)
        {
            case #"ww_crossbow_t8":
            weapon_id = 500;
            break;
            case #"ww_crossbow_charged_t8":
            weapon_id = 501;
            break;

            case #"ww_tricannon_t8":
            weapon_id = 502;
            break;
            case #"ww_tricannon_fire_t8":
            weapon_id = 503;
            break;
            case #"ww_tricannon_earth_t8":
            weapon_id = 504;
            break;
            case #"ww_tricannon_water_t8":
            weapon_id = 505;
            break;
            case #"ww_tricannon_air_t8":
            weapon_id = 506;
            break;

            case #"ww_blundergat_t8":
            weapon_id = 507;
            break;
            case #"ww_blundergat_acid_t8":
            weapon_id = 508;
            break;
            case #"ww_blundergat_fire_t8":
            weapon_id = 509;
            break;

            case #"ww_random_ray_gun1":
            weapon_id = 510;
            break;
            case #"ww_random_ray_gun2":
            weapon_id = 511;
            break;
            case #"ww_random_ray_gun3":
            weapon_id = 512;
            break;

            case #"ww_hand_c":
            weapon_id = 513;
            break;
            case #"ww_hand_g":
            weapon_id = 514;
            break;
            case #"ww_hand_h":
            weapon_id = 515;
            break;
            case #"ww_hand_o":
            weapon_id = 516;
            break;
            case #"ww_hand_c_uncharged":
            weapon_id = 517;
            break;
            case #"ww_hand_g_uncharged":
            weapon_id = 518;
            break;
            case #"ww_hand_h_uncharged":
            weapon_id = 519;
            break;
            case #"ww_hand_o_uncharged":
            weapon_id = 520;
            break;

            case #"ray_gun":
            weapon_id = 530;
            break;
            case #"ray_gun_mk2":
            weapon_id = 531;
            break;

            case #"ray_gun_mk2v":
            weapon_id = 521;
            break;
            case #"ray_gun_mk2x":
            weapon_id = 522;
            break;
            case #"ray_gun_mk2y":
            weapon_id = 523;
            break;
            case #"ray_gun_mk2z":
            weapon_id = 524;
            break;

            case #"thundergun":
            weapon_id = 525;
            break;
            case #"tundragun":
            weapon_id = 530;
            break;
            case #"ww_tesla_gun_t8":
            weapon_id = 526;
            break;
            case #"ww_tesla_sniper_t8":
            weapon_id = 527;
            break;

            case #"ww_freezegun_t8":
            weapon_id = 528;
            break;
            case #"ww_freezegun_t8_upgraded":
            weapon_id = 529;
            break;

            default:
            weapon_id = 0;
            break;
        }
    }

    LUINotifyEvent(#"enhancement_custom_weapon", 6, 1, self_id, Int(self.origin[0]), Int(self.origin[1]), Int(self.origin[2]) + (15), weapon_id);
    while(true)
    {
        if (!isDefined(self))
            break;

        foreach(player in level.players)
        {
            if (distanceSquared(self.origin, player.origin) < 14216)
                player LUINotifyEvent(#"enhancement_custom_weapon", 2, 3, self_id);
            else
                player LUINotifyEvent(#"enhancement_custom_weapon", 2, 4, self_id);
        }

        wait 0.05;
    }

    LUINotifyEvent(#"enhancement_custom_weapon", 2, 0, self_id);
}

Timeout_DroppedWeapon()
{
    self waittilltimeout(120, #"delete_me");
    
    if (isdefined(self.s_unitrigger))
        zm_unitrigger::unregister_unitrigger(self.s_unitrigger);

    if (isdefined(self))
        self delete();
}