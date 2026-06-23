SecondaryEquipment()
{
    if(!GetDvarInt(#"shield_enh_second_grenade", 0)) 
        return;

    callback::on_spawned(&SecondaryEquipment_Spawned);
}

GetEquipmentID(equipment)
{
    weapon_id = getbaseweaponitemindex(weapons::getbaseweapon(equipment));

    if (isDefined(weapon_id) && weapon_id != 0)
        return weapon_id;
    
    // specials
    switch (equipment.name)
    {
        case #"homunculus":
            return 901;

        case #"cymbal_monkey":
            return 902;

        case #"tomahawk_t8":
        case #"tomahawk_t8_upgraded":
            return 903;
        
        case #"snowball":
            return 904;

        case #"snowball_yellow":
            return 905;

        case #"music_box":
            return 906;

        case #"eq_nesting_doll_grenade_rich":
        case #"eq_nesting_doll_grenade_takeo":
        case #"eq_nesting_doll_grenade_niko":
        case #"eq_nesting_doll_grenade":
            return 907;

        case #"Thunderstorm":
            return 908;
    }

    return 0;
}

SecondaryEquipment_MaxAmmoWatcher()
{
    self endon(#"death", #"disconnect");
    while(true)
    {
        util::waittill_any_ents(self, #"second_equipment_ammo", level, #"zmb_max_ammo_level");
        
        if (isDefined(self.secondary_equipment))
        {
            if (!self.grenade_slot)
            {
                self.secondary_equipment_amount = self.secondary_equipment.clipsize;
                self.secondary_equipment_charge = 100;
                self LUINotifyEvent(#"shield_enh_equipment", 2, GetEquipmentID(self.secondary_equipment), self.secondary_equipment_amount);
            }
            else
            {
                self.main_equipment_amount = self.main_equipment.clipsize;
                self.main_equipment_charge = 100;
                self LUINotifyEvent(#"shield_enh_equipment", 2, GetEquipmentID(self.main_equipment), self.main_equipment_amount);
            }
        }
    }
}

SecondaryEquipment_Spawned()
{
    self endon(#"death", #"disconnect");

    if (IsBot(self))
        return;

    // ? logic ?
    level flag::wait_till("initial_blackscreen_passed"); // waits for players
    self LUINotifyEvent(#"shield_enh_equipment", 1, 1000);
    wait 2;
    self iPrintLn("^0To switch between your equipments, Press [{+switchseat}] + [{+melee}]");
    ShieldLog("Player on spawned equipment");

    self thread SecondaryEquipment_MaxAmmoWatcher();

    self.main_equipment = self zm_loadout::get_player_lethal_grenade();
    self.grenade_slot = false;
    while(true)
    {
        if (self changeseatbuttonpressed() && self MeleeButtonPressed())
        {
            if (self isthrowinggrenade() || !isdefined(self.secondary_equipment))
            {
                wait 0.5;
                continue;
            }

            if (!self.grenade_slot)
            {
                self.main_equipment_slot = self gadgetGetSlot(self.main_equipment);
                self.main_equipment_amount = self getWeaponAmmoClip(self.main_equipment);
                self.main_equipment_charge = self gadgetPowerGet(self.main_equipment_slot);
                self.dont_switch_equipment = true;

                self zm_loadout::set_player_lethal_grenade(self.secondary_equipment);
                self zm_weapons::weapon_give(self.secondary_equipment, 1, 0);

                if (isDefined(self.secondary_equipment_amount))
                {
                    self setWeaponAmmoClip(self.secondary_equipment, self.secondary_equipment_amount);
                }

                if (isDefined(self.secondary_equipment_charge) && isDefined(self.secondary_equipment_slot))
                {
                    self gadgetPowerSet(self.secondary_equipment_slot, self.secondary_equipment_charge);
                }

                self.grenade_slot = true;
                self LUINotifyEvent(#"shield_enh_equipment", 2, GetEquipmentID(self.main_equipment), self.main_equipment_amount);
            }
            else
            {
                self.secondary_equipment_slot = self gadgetGetSlot(self.secondary_equipment);
                self.secondary_equipment_amount = self getWeaponAmmoClip(self.secondary_equipment);
                self.secondary_equipment_charge = self gadgetPowerGet(self.secondary_equipment_slot);
                self.dont_switch_equipment = true;

                self zm_loadout::set_player_lethal_grenade(self.main_equipment);
                self zm_weapons::weapon_give(self.main_equipment, 1, 0);
                self setWeaponAmmoClip(self.main_equipment, self.main_equipment_amount);
                self gadgetPowerSet(self.main_equipment_slot, self.main_equipment_charge);

                self.grenade_slot = false;
                self LUINotifyEvent(#"shield_enh_equipment", 2, GetEquipmentID(self.secondary_equipment), self.secondary_equipment_amount);
            }

            wait 1;
        }

        util::wait_network_frame(1);
    }
}