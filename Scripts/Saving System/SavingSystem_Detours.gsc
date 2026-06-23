// ============================== \\

// vod fix
detour namespace_4a807bff<script_7893277eec698972>::function_707a3db7() {
    level endon(#"end_game", #"hash_477e8ec5d0789334");
    self endon(#"disconnect");

    ShieldLog("callback before on function_707a3db7");

    waitresult = undefined;
    while(true)
    {
        waitresult = self waittill(#"weapon_change");

        if (isdefined(waitresult) && isdefined(waitresult.weapon)) {  
            if ([[ @namespace_4a807bff<script_7893277eec698972.gsc>::is_tricannon ]](waitresult.weapon)) {
                break;
            }
        }
    }

    if (!isdefined(level.var_ab242e52)) {
        level.var_ab242e52 = 0;
    }
    callback::on_ai_killed(@namespace_4a807bff<script_7893277eec698972.gsc>::function_f4a7fd49);
    callback::remove_on_connect(@namespace_4a807bff<script_7893277eec698972.gsc>::function_707a3db7);
    level flag::set(#"hash_477e8ec5d0789334");
}

// five fix
detour namespace_a5657ff1<script_4bae07eadc57bb51>::function_2767c5d7(e_player) {
    if (isdefined(self.stub) && isdefined(self.stub.blueprint)) {
        t_crafting = self.stub;
    } else if (isdefined(self.blueprint)) {
        t_crafting = self;
    }
    if (t_crafting.blueprint.name == #"zblueprint_office_teleporter_modifier") {
        func_link = @namespace_a5657ff1<script_4bae07eadc57bb51.gsc>::function_73e06b11;
        t_crafting.var_4f749ffe show();

        if (function_8b1a219a()) {
            if (isDefined(self.stub))
                level.var_279a11a3 = self.stub.var_4f749ffe zm_unitrigger::create(#"hash_36ff79a9f968a5ee", 64, func_link);
            else
                level.var_279a11a3 = self.var_4f749ffe zm_unitrigger::create(#"hash_36ff79a9f968a5ee", 64, func_link);
            return;
        }

        if (isDefined(self.stub))
            level.var_279a11a3 = self.stub.var_4f749ffe zm_unitrigger::create(#"hash_7103e08d3e6bf1aa", 64, func_link);
        else
            level.var_279a11a3 = self.var_4f749ffe zm_unitrigger::create(#"hash_7103e08d3e6bf1aa", 64, func_link);
    }
}

// items
detour zm_items<scripts\zm_common\zm_items.gsc>::player_pick_up(player, w_item) {
    if (w_item.var_9fffdcee) {
        holder = level;
    } else {
        holder = player;
    }

    if (!isdefined(holder.item_inventory)) {
        holder.item_inventory = [];
    }
    
    if (!isdefined(holder.item_inventory_save)) {
        holder.item_inventory_save = [];
    }

    holder.item_inventory_save[w_item] = w_item;
    holder.item_inventory[w_item] = 1;


    if (w_item.var_df0f9ce9) {
        if (isdefined(holder.item_slot_inventory[w_item.var_df0f9ce9])) {
            player zm_items::function_ab3bb6bf(holder, holder.item_slot_inventory[w_item.var_df0f9ce9]);
        }
        holder.item_slot_inventory[w_item.var_df0f9ce9] = w_item;
    }
    level notify(#"component_collected", {#component:w_item, #holder:holder});
    player notify(#"component_collected", {#component:w_item, #holder:holder});
    if (isdefined(level.item_callbacks[w_item])) {
        foreach (callback in level.item_callbacks[w_item]) {
            player [[ callback ]](holder, w_item);
        }
    }
    if (!(isdefined(level.var_ddfee332) && level.var_ddfee332) && player hasweapon(w_item)) {
        player takeweapon(w_item);
    }
}

detour zm_items<scripts\zm_common\zm_items.gsc>::player_on_spawned() {
    if (!isdefined(self.item_inventory)) {
        self.item_inventory = [];
    }
    if (!isdefined(self.item_slot_inventory)) {
        self.item_slot_inventory = [];
    }
    if (!isdefined(self.item_inventory_save)) {
        self.item_inventory_save = [];
    }
}

// for AO-pap loading
detour zm_white_special_rounds<scripts\zm\zm_white_special_rounds.gsc>::function_d4e24379(e_player)
{
    if (isDefined(level.SaveSkipped) && level.SaveSkipped)
        return 0;
    else
        return [[ @zm_white_special_rounds<scripts\zm\zm_white_special_rounds.gsc>::function_d4e24379 ]](e_player);
}

// Tag Intro
detour zm_orange_pablo<scripts\zm\zm_orange_pablo.gsc>::pablo_intro()
{   
    if (!isDefined(level.SaveSkipped) || !level.SaveSkipped)
        return [[ @zm_orange_pablo<scripts\zm\zm_orange_pablo.gsc>::pablo_intro ]]();
    
    ShieldLog("^2Tag Pablo Intro -> Stopped");
    level.var_f6f7a368 = 2;

    level flag::set(#"pablo_intro");
    level flag::set(#"hash_641f14d0b2fd57d7");

    level.pablo_npc thread [[ @zm_orange_pablo<scripts\zm\zm_orange_pablo.gsc>::function_1dc9b29a ]]();
    level.pablo_npc thread [[ @zm_orange_pablo<scripts\zm\zm_orange_pablo.gsc>::function_57c115a8 ]]();
    return;
}

detour zm_hero_weapon<scripts\zm_common\zm_hero_weapon.gsc>::hero_weapon_player_init()
{
    ShieldLog("^6Hero Weapon Init...");
    
    if(GetDvarInt("shield_enh_SaveGame_Load", 0) && !GetDvarInt(#"shield_enh_ClassicMode", 0))
    {
        SaveGame = ShieldFromJson("EnhGameSave");

        if(isDefined(SaveGame) && isDefined(SaveGame.Map))
        {
            SameMap = GetMapID();

            if (SameMap != SaveGame.Map)
            {
                //ShieldLog("^1Map is Diff, not loading blah blah");
                return [[ @zm_hero_weapon<scripts\zm_common\zm_hero_weapon.gsc>::hero_weapon_player_init ]]();
            }
        }
        else
            return [[ @zm_hero_weapon<scripts\zm_common\zm_hero_weapon.gsc>::hero_weapon_player_init ]]();
    }

    if(GetDvarInt("shield_enh_SaveGame_Load", 0) && !GetDvarInt(#"shield_enh_ClassicMode", 0))
    {
        ShieldLog("^6Setting Hero Weapon...");
        
        if (!isdefined(self.var_fd05e363)) 
        {
            self.var_fd05e363 = GetWeapon(SaveGame.Specialist);
            self.var_72d6f15d = 0;
            self.var_ec334996 = 0;
            if (isdefined(self.talisman_special_startlv3) && self.talisman_special_startlv3 || SaveGame.Specialist_Level == 2) {
                self zm_hero_weapon::function_45b7d6c1(2);
                //self.var_c09adff0 = 1;
            }
            if (isdefined(self.talisman_special_startlv2) && self.talisman_special_startlv2 || SaveGame.Specialist_Level == 1) {
                self zm_hero_weapon::function_45b7d6c1(1);
                self.var_e77eadb7 = 1;
            }
            self zm_hero_weapon::function_23978edd();
            if (isdefined(self.talisman_special_startlv2) && self.talisman_special_startlv2 || SaveGame.Specialist_Level == 1) {
                if (isdefined(level.var_5ee61f18[self.var_b708af7b])) {
                    self.var_ec334996 = level.var_5ee61f18[self.var_b708af7b][1];
                } else {
                    self.var_ec334996 = GetSpecialistRechargeThing(2800);
                }
            }
            if (isdefined(self.talisman_special_startlv3) && self.talisman_special_startlv3 || SaveGame.Specialist_Level == 2) {
                if (isdefined(level.var_5ee61f18[self.var_b708af7b])) {
                    self.var_ec334996 = level.var_5ee61f18[self.var_b708af7b][2];
                } else {
                    self.var_ec334996 = GetSpecialistRechargeThing(8000);
                }
            }
            self.var_41183060 = 0;
            self.var_821c9bf3 = 0;
            self.var_c9279111 = 0;
            self.var_dc37311e = 0;
            self.var_1bcf6a9e = 0;
            self.var_da2f5f0b = 0;
            self.var_184a3854 = 0;
            self.var_d11656b = 0;
            self.var_9cef1b1e = 0;
        }
    }
    else if(GetDvarInt(#"shield_enh_ClassicMode", 0))
    {
        ShieldLog("^6Hero Weapon Init Player Classic...");
    
        if (!isdefined(self.var_fd05e363)) {
            self.var_fd05e363 = self zm_loadout::function_439b009a("herogadget");
            self.var_72d6f15d = 0;
            self.var_ec334996 = 0;
            if (isdefined(self.talisman_special_startlv3) && self.talisman_special_startlv3) {
                self zm_hero_weapon::function_45b7d6c1(2);
                self.var_c09adff0 = 1;
            }
            if (isdefined(self.talisman_special_startlv2) && self.talisman_special_startlv2) {
                self zm_hero_weapon::function_45b7d6c1(1);
                self.var_e77eadb7 = 1;
            }
            self zm_hero_weapon::function_23978edd();
            if (isdefined(self.talisman_special_startlv2) && self.talisman_special_startlv2) {
                if (isdefined(level.var_5ee61f18[self.var_b708af7b])) {
                    self.var_ec334996 = level.var_5ee61f18[self.var_b708af7b][1];
                } else {
                    self.var_ec334996 = GetSpecialistRechargeThing(2800);
                }
            }
            if (isdefined(self.talisman_special_startlv3) && self.talisman_special_startlv3) {
                if (isdefined(level.var_5ee61f18[self.var_b708af7b])) {
                    self.var_ec334996 = level.var_5ee61f18[self.var_b708af7b][2];
                } else {
                    self.var_ec334996 = GetSpecialistRechargeThing(8000);
                }
            }
            self.var_41183060 = 0;
            self.var_821c9bf3 = 0;
            self.var_c9279111 = 0;
            self.var_dc37311e = 0;
            self.var_1bcf6a9e = 0;
            self.var_da2f5f0b = 0;
            self.var_184a3854 = 0;
            self.var_d11656b = 0;
            self.var_9cef1b1e = 0;
        }
    }
    else 
     return [[ @zm_hero_weapon<scripts\zm_common\zm_hero_weapon.gsc>::hero_weapon_player_init ]]();
    
    if (zm_custom::function_901b751c(#"zmspecweaponisenabled") && !GetDvarInt(#"shield_enh_ClassicMode", 0)) {
        self zm_hero_weapon::hero_give_weapon(self.var_fd05e363, 0);
        if (self.var_fd05e363.isgadget) {
            slot = self gadgetgetslot(self.var_fd05e363);
            var_aabc1f49 = isdefined(self.firstspawn) ? self.firstspawn : 1;
            if (slot >= 0 && var_aabc1f49) {
                self gadgetpowerreset(slot, 1);
            }
        }

        self gadgetPowerSet(self gadgetGetSlot(GetWeapon(SaveGame.Specialist)), SaveGame.Specialist_Recharge);
    }
}

// ------------------------------ \\
