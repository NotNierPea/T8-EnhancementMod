SaveGames()
{   
    setDvar(#"shield_enh_SaveGame", 0);
    
    // NOT FINISHED
    //return;

    if (GetPlayers().size >= 2)
    {
        ShieldLog("^1Not Loading Save, Non Solo Match");
        return;
    }

    if(GetDvarInt("shield_enh_SaveGame_Load", 0))
    {
        ShieldLog("^2Trying to Load Save...");

        SaveGame = ShieldFromJson("EnhGameSave");

        if(isDefined(SaveGame) && isDefined(SaveGame.Map))
        {
            SameMap = GetMapID();

            ShieldLog("^1Need Map ID " + SaveGame.Map);

            if (SameMap != SaveGame.Map)
            {
                ShieldLog("^1Map is Diff, not loading blah blah");
                return;
            }

            if (SaveGame.WasPAPOn)
                level thread ActivatePAP();

            if (isdefined(SaveGame.MainQuest_Step) && SaveGame.MainQuest_Step > 0)
                level thread SetMainQuestStep(SaveGame.MainQuest_Step);

            level flag::wait_till("all_players_spawned");
            MainPlayer = GetPlayers()[0];
            
            if (isDefined(SaveGame.CharacterIndex))
            {
                MainPlayer player_role::set(SaveGame.CharacterIndex);
                MainPlayer setcharacterbodytype(SaveGame.CharacterIndex);
                MainPlayer setcharacteroutfit(0);
            }

            level flag::wait_till("initial_blackscreen_passed");

            if (isdefined(SaveGame.Directed_RoundCap) && SaveGame.Directed_RoundCap > 0)
            {
                level Directed_SetRoundCap(SaveGame.Directed_RoundCap);
            }

            currentweapon = MainPlayer getcurrentweapon();

            MainPlayer.score = SaveGame.points;
            MainPlayer setOrigin(SaveGame.cords);
            MainPlayer setPlayerAngles(SaveGame.angles);

            // level.weaponnone
            if (SaveGame.Equipment != "none")
            {
                MainPlayer zm_weapons::weapon_give(GetWeapon(SaveGame.Equipment));
                MainPlayer zm_loadout::set_player_lethal_grenade(GetWeapon(SaveGame.Equipment));

                if (isDefined(SaveGame.Equipment_Ammo))
                    MainPlayer setWeaponAmmoClip(GetWeapon(SaveGame.Equipment), SaveGame.Equipment_Ammo);

                if (isDefined(SaveGame.Equipment_Recharge))
                    MainPlayer gadgetPowerSet(MainPlayer gadgetGetSlot(GetWeapon(SaveGame.Equipment)), SaveGame.Equipment_Recharge);
            }

            if (isDefined(SaveGame.Secondary_Equipment) && SaveGame.Secondary_Equipment != "none")
            {
                MainPlayer.secondary_equipment = getweapon(SaveGame.Secondary_Equipment);
                MainPlayer.secondary_equipment_amount = SaveGame.Secondary_Equipment_Ammo;
                MainPlayer.secondary_equipment_charge = SaveGame.Secondary_Equipment_Recharge;
                MainPlayer.secondary_equipment_slot = MainPlayer gadgetGetSlot(GetWeapon(SaveGame.Equipment));
                MainPlayer LUINotifyEvent(#"shield_enh_equipment", 2, GetEquipmentID(MainPlayer.secondary_equipment), SaveGame.Secondary_Equipment_Ammo);
            }

            MainPlayer takeweapon(currentweapon);
            
            // Perks..
            i = 0;
            foreach (Perk in SaveGame.ActivePerks)
            {
                // ignore the perk mod ffs
                if (i != 5)
                    MainPlayer thread zm_perks::function_9bdf581f(Perk, i);
                
                i++;
                wait 0.1;
            }

            // Extra Perks
            foreach (Perk in SaveGame.ExtraPerks)
            {
                MainPlayer thread zm_perks::function_29387491(Perk);
                wait 0.1;
            }
            
            // Doors..
            ZombieDoors = getentarray("zombie_door", "targetname");
            for (i = 0; i < ZombieDoors.size; i++)
            {
                if (array::contains(SaveGame.DoorsArray, ZombieDoors[i].script_flag))
                {
                    // Open Door, last time it was..
                    ZombieDoors[i] notify(#"trigger", {#activator:MainPlayer, #is_forced:1});

                    //ShieldLog("^4Door " + ZombieDoors[i].script_flag + " is trying to open....");
                }
                //else
                    //ShieldLog("^4Hmm, Door " + ZombieDoors[i].script_flag + " was ignored....");
            }

            // Debris..
            ZombieDebris = getentarray("zombie_debris", "targetname");
            for (i = 0; i < ZombieDebris.size; i++)
            {
                //ShieldLog("checking door if was in array: " + ZombieDebris[i].script_flag);

                if (!isDefined(ZombieDebris[i].script_flag))
                {
                    ShieldLog("^2hey this door does not have a flag: " + ZombieDebris[i].origin);

                    if (!array::contains(SaveGame.DebrisArray, ZombieDebris[i].origin))
                    {
                        // Open Door, last time it was..
                        ZombieDebris[i] notify(#"trigger", {#activator:MainPlayer, #is_forced:1});
                    }

                    continue;
                }

                // if it has one
                if (!array::contains(SaveGame.DebrisArray, ZombieDebris[i].script_flag))
                {
                    // Open Door, last time it was..
                    ZombieDebris[i] notify(#"trigger", {#activator:MainPlayer, #is_forced:1});
                }
            }

            // airlocks? if they are fucking used
            ZombieAirlocks = getentarray("zombie_airlock_buy", "targetname");
            for (i = 0; i < ZombieAirlocks.size; i++)
            {
                if (!array::contains(SaveGame.DebrisArray, ZombieAirlocks[i].script_flag))
                {
                    // Open Door, last time it was..
                    ZombieAirlocks[i] notify(#"trigger", {#activator:MainPlayer, #is_forced:1});
                }
            }

            // Items.., get them in and player pick them up.
            a_items_picked = SaveGame.ItemsPickedUp;
            foreach (e_item in a_items_picked)
            {
                new_item = zm_crafting::get_component(e_item);

                if (isDefined(new_item))
                    zm_items::player_pick_up(MainPlayer, new_item);

                // for directed..
                foreach(w_item in getitemarray())
                {
                    if (w_item.item.name == new_item.name)
                    {
                        w_item SetInvisibleToAll();
                        w_item.saved_picked = true;
                    }
                }
            }

            wait 1;
            
            a_craftingtables_built = SaveGame.CraftingTables;
            blueprint_index = 0;
            
            foreach (a_s_crafting in level.var_4fe2f84d) {
                foreach (s_crafting in a_s_crafting) {
                    blueprint_name = "";
                    if (isDefined(s_crafting.blueprint))
                    {
                        blueprint_name = s_crafting.blueprint.name;
                    }
                    else
                    {
                        blueprint_name = s_crafting.craftfoundry.name;
                    }

                    ShieldLog("building " + blueprint_name);

                    blueprints_c = s_crafting zm_crafting::function_4165306b(MainPlayer);

                    blueprint_to_use = undefined;
                    foreach (bp in blueprints_c) {
                        foreach(built_bp in a_craftingtables_built) {
                            ShieldLog("checking " + bp.name + " === " + built_bp);
                            if (bp.name === built_bp) {
                                blueprint_to_use = bp;

                                ShieldLog("using " + blueprint_to_use.name);
                                blueprint_index++;
                                break;
                            }
                        }
                    }

                    if (isDefined(blueprint_to_use))
                    {
                        s_crafting.blueprint = blueprint_to_use;
                        s_crafting zm_crafting::function_a187b293();
                        level notify(#"blueprint_completed", {#blueprint:s_crafting.blueprint, #produced:s_crafting.blueprint.var_54a97edd, #player:MainPlayer, #stub:s_crafting});
                    }
                    
                    wait 0.15;
                }
            }

            wait 2;

            // Weapons..
            MainPlayer zm_weapons::weapon_give(GetWeapon(SaveGame.Weapon_1));
            if (isDefined(SaveGame.Weapon_1_AAT)) 
                MainPlayer aat::acquire(GetWeapon(SaveGame.Weapon_1), SaveGame.Weapon_1_AAT);
            if (isDefined(SaveGame.Weapon_1_Packs))
                MainPlayer zm_pap_util::repack_weapon(GetWeapon(SaveGame.Weapon_1), SaveGame.Weapon_1_Packs);

            MainPlayer setWeaponAmmoClip(GetWeapon(SaveGame.Weapon_1), SaveGame.Weapon_1_Clip);
            MainPlayer setWeaponAmmoStock(GetWeapon(SaveGame.Weapon_1), SaveGame.Weapon_1_Stock);
            
            wait 1;
            
            if (isDefined(SaveGame.Weapon_2))
            {
                MainPlayer zm_weapons::weapon_give(GetWeapon(SaveGame.Weapon_2));
                if (isDefined(SaveGame.Weapon_2_AAT)) 
                 MainPlayer aat::acquire(GetWeapon(SaveGame.Weapon_2), SaveGame.Weapon_2_AAT);
                if (isDefined(SaveGame.Weapon_2_Packs))
                 MainPlayer zm_pap_util::repack_weapon(GetWeapon(SaveGame.Weapon_2), SaveGame.Weapon_2_Packs);

                wait 0.1;

                MainPlayer setWeaponAmmoClip(GetWeapon(SaveGame.Weapon_2), SaveGame.Weapon_2_Clip);
                MainPlayer setWeaponAmmoStock(GetWeapon(SaveGame.Weapon_2), SaveGame.Weapon_2_Stock);
            }

            wait 2;

            // melee
            if (isDefined(SaveGame.MeleeWeapon) && SaveGame.MeleeWeapon != "none")
                MainPlayer zm_weapons::weapon_give(GetWeapon(SaveGame.MeleeWeapon));
            
            // UI Fix Logic
            if (SaveGame.round > 255)
            {
                ShieldLog("^4Running Logic for 255+");

                level thread zm_utility::zombie_goto_round(250);
                level thread zm_game_module::zombie_goto_round(250);

                wait 15;

                level waittill(#"start_of_round");
            }

            ShieldLog("^4Set Round for " + SaveGame.round);

            level thread zm_utility::zombie_goto_round(SaveGame.round);
            level thread zm_game_module::zombie_goto_round(SaveGame.round);

            // !! NEED TESTING!!
           // if (isDefined(SaveGame.Specialist) && isDefined(SaveGame.Specialist_Level))
            //{
                //MainPlayer zm_hero_weapon::hero_give_weapon(GetWeapon(SaveGame.Specialist), 1);
                //MainPlayer zm_hero_weapon::function_45b7d6c1(SaveGame.Specialist_Level);
           // }

            // Shield?
            if (SaveGame.HasShield)
            {
                weapon = level.weaponriotshield;
                if (isdefined(self.weaponriotshield)) {
                    weapon = self.weaponriotshield;
                }

                MainPlayer [[ @zm_bgb_shields_up<scripts\zm_common\bgbs\zm_bgb_shields_up.gsc>::give_shield ]]();
                MainPlayer [[ @zm_bgb_shields_up<scripts\zm_common\bgbs\zm_bgb_shields_up.gsc>::give_shield ]]();

                if (isDefined(SaveGame.ShieldDurability) && SaveGame.ShieldDurability > 0)
                {
                    damagemax = 800;
                    damagetogive = damagemax - SaveGame.ShieldDurability;
                    MainPlayer damageriotshield(damagetogive);
                }

                if (isDefined(SaveGame.ShieldAmmo))
                {
                    MainPlayer setWeaponAmmoClip(weapon, SaveGame.ShieldAmmo);
                }
            }

            if (GetDvarInt(#"shield_enh_ClassicMode", 0))
            {
                foreach(perk in SaveGame.ClassicPerks)
                {
                    MainPlayer GiveClassicPerk(perk, MainPlayer, true);
                    wait 0.1;
                }
            }

            if (GetDvarInt(#"shield_enh_Gums", 0) && isDefined(SaveGame.ClassicGum)) {
                MainPlayer thread GiveBGBPack(SaveGame.ClassicGum);
            }  

            wait 1;
            
            // after perks
            if (isDefined(SaveGame.Weapon_3))
            {
                MainPlayer zm_weapons::weapon_give(GetWeapon(SaveGame.Weapon_3));
                if (isDefined(SaveGame.Weapon_3_AAT)) 
                 MainPlayer aat::acquire(GetWeapon(SaveGame.Weapon_3), SaveGame.Weapon_3_AAT);
                if (isDefined(SaveGame.Weapon_3_Packs))
                 MainPlayer zm_pap_util::repack_weapon(GetWeapon(SaveGame.Weapon_3), SaveGame.Weapon_3_Packs);

                wait 0.1;
                
                MainPlayer setWeaponAmmoClip(GetWeapon(SaveGame.Weapon_3), SaveGame.Weapon_3_Clip);
                MainPlayer setWeaponAmmoStock(GetWeapon(SaveGame.Weapon_3), SaveGame.Weapon_3_Stock);
            }

            if (isdefined(SaveGame.RampageMode) && SaveGame.RampageMode)
            {
                level.RampageActive = true;
                level notify(#"rampage_toggle");
                foreach(player in level.players)
                {
                    player LUINotifyEvent(#"shield_enh_rampage_mode", 1, level.RampageActive ? 1 : 0);
                }

                wait 2;
                level thread UpdateRampageZombies();
            }

            // side quests..
            if (isdefined(SaveGame.Side_Quest_Tomahawk) && SaveGame.Side_Quest_Tomahawk)
            {
                level flag::set(#"soul_catchers_charged");
                wait 0.25;
                var_fd22f9df = struct::get("tom_pil");
                mdl_tomahawk = var_fd22f9df.scene_ents[#"prop 2"];
                mdl_tomahawk notify(#"hash_72879554ff8d0b60");
            }

            if (isdefined(SaveGame.BOTD_Challenge_Left) && SaveGame.BOTD_Challenge_Left.size > 0)
            {
                level thread Save_OverrideChallenges(SaveGame.BOTD_Challenge_Left);
            }

            setDvar(#"shield_enh_SaveGame_Load", 0);
            ShieldLog("^3Well it seems it loaded fine.");
        }
        else
         ShieldLog("^2No Saves...");
    }

    while(true)
    {
        if(GetDvarInt(#"shield_enh_SaveGame", 0))
        {
            MainPlayer = GetPlayers()[0];

            // doors
            ZombieDoors = getentarray("zombie_door", "targetname");
            ZobmieAirlocks = getentarray("zombie_airlock_buy", "targetname");
            ZombieDebris = getentarray("zombie_debris", "targetname");

            if (GetPlayers().size >= 2)
            {
                ShieldLog("^1Not Saving, Non Solo Match");
                return;
            }

            if (isDefined(MainPlayer))
            {
                Map = GetMapID();
                WeaponsData = MainPlayer getWeaponsListPrimaries();

                DoorsOpened = array();
                DebrisClosed = array();

                foreach (Door in ZombieDoors)
                {
                    if (Door._door_open === 1 || Door.has_been_opened === 1)
                    {
                        array::add(DoorsOpened, Door.script_flag, true);
                    }
                }

                foreach (Door in ZobmieAirlocks)
                {
                    array::add(DebrisClosed, Door.script_flag, true);
                }

                // they get deleted if they are opened...
                foreach (Door in ZombieDebris)
                {
                    array::add(DebrisClosed, Door.script_flag, true);

                    // ffs
                    if (!isDefined(Door.script_flag))
                    {
                        array::add(DebrisClosed, Door.origin, true);
                    }
                }

                PerksActive = array();
                for (i = 0; i < MainPlayer.var_c27f1e90.size; i++) 
                {
                    perk = MainPlayer.var_c27f1e90[i];
                    if (MainPlayer hasperk(perk))
                    {
                        //n_index = MainPlayer zm_perks::function_c1efcc57(perk);
                        //MainPlayer zm_perks::function_9bdf581f(perk, n_index);

                        array::add(PerksActive, perk, true);
                    }
                }
                
                PerksExtra = array();
                for (i = 0; i < MainPlayer.var_67ba1237.size; i++) 
                {
                    perk = MainPlayer.var_67ba1237[i];
                    if (MainPlayer hasperk(perk))
                    {
                        //n_index = MainPlayer zm_perks::function_c1efcc57(perk);
                        //MainPlayer zm_perks::function_9bdf581f(perk, n_index);

                        array::add(PerksExtra, perk, true);
                    }
                }

                a_items_picked = array();

                if (isDefined(MainPlayer.item_inventory_save))
                {
                    foreach (e_item in MainPlayer.item_inventory_save)
                    {
                        array::add(a_items_picked, e_item.name, true);
                    }
                }

                if (isDefined(level.item_inventory_save))
                {
                    foreach (e_item in level.item_inventory_save)
                    {
                        array::add(a_items_picked, e_item.name, true);
                    }
                }

                crafting_tables = array();
                foreach (a_s_crafting in level.var_4fe2f84d) {
                    foreach (s_crafting in a_s_crafting) {
                        if (isDefined(s_crafting.blueprint) && isDefined(s_crafting.blueprint.completed) && s_crafting.blueprint.completed)
                        {
                            blueprint_name = "";
                            if (isDefined(s_crafting.blueprint))
                            {
                                blueprint_name = s_crafting.blueprint.name;
                            }
                            else
                            {
                                blueprint_name = s_crafting.craftfoundry.name;
                            }
                            array::add(crafting_tables, blueprint_name, true);
                        }
                        else
                            array::add(crafting_tables, "unbuilt", true);
                    }
                }

                ClassicPerksGet = array();

                if (GetDvarInt(#"shield_enh_ClassicMode", 0))
                {
                    random_perks_classic = array(#"HasJugg", #"specialty_doubletap2", #"specialty_whoswho", #"HasElemental", #"specialty_vultureaid", #"specialty_fastreload");

                    if (isDefined(MainPlayer.HasJugg) && MainPlayer.HasJugg)
                    {
                        array::add(ClassicPerksGet, #"HasJugg", true);
                    }

                    if (isDefined(MainPlayer.HasElemental) && MainPlayer.HasElemental)
                    {
                        array::add(ClassicPerksGet, #"HasElemental", true);
                    }

                    foreach(perk in random_perks_classic)
                    {
                        if (perk === #"HasJugg" || perk === #"HasElemental")
                            continue;

                        if (MainPlayer hasPerk(perk))
                        {
                            array::add(ClassicPerksGet, perk, true);
                        }
                    }
                }

                ClassicGumGet = undefined;

                if (GetDvarInt(#"shield_enh_Gums", 0) && isDefined(MainPlayer.holding_bgb)) {
                    ClassicGumGet = MainPlayer.holding_bgb;
                }

                MainQuest_Step = 0;
                ChallengesLeft = [];
                switch(BO4GetMap())
                {
                    case "IX":
                    MainQuest_Step = level._ee[#"main_quest"].current_step;
                    break;

                    case "Blood":
                    MainQuest_Step = level._ee[#"paschal_quest"].current_step;
                    ChallengesLeft = isdefined(level.var_85cc9fcc) ? level.var_85cc9fcc : [];
                    break;

                    case "AE":

                    break;

                    case "AO":

                    break;

                    case "Dead":

                    break;

                    case "Tag":

                    break;

                    case "Classified":
                    
                    break;

                    case "Voyage":
                    MainQuest_Step = level._ee[#"main_quest"].current_step;
                    break;
                }

                Equipment = MainPlayer zm_loadout::get_player_lethal_grenade().name;
                if (isDefined(MainPlayer.var_3b55baa1) && isDefined(MainPlayer.var_3b55baa1.name))
                {
                    Equipment = MainPlayer.var_3b55baa1.name;
                }

                Equipment_Recharge = MainPlayer gadgetPowerGet(MainPlayer gadgetGetSlot(GetWeapon(Equipment)));
                if (isDefined(MainPlayer.var_e01bb56))
                {
                    Equipment_Recharge = MainPlayer.var_e01bb56;
                }

                Secondary_Equipment = "none";
                Secondary_Equipment_Recharge = 0;
                Secondary_Equipment_Ammo = 0;
                if (isDefined(MainPlayer.secondary_equipment) && isDefined(MainPlayer.secondary_equipment.name))
                {
                    if (!MainPlayer.grenade_slot)
                    {
                        Secondary_Equipment = MainPlayer.secondary_equipment.name;
                        Secondary_Equipment_Recharge = MainPlayer gadgetPowerGet(MainPlayer.secondary_equipment_slot);
                        Secondary_Equipment_Ammo = MainPlayer getWeaponAmmoClip(MainPlayer.secondary_equipment);
                    }
                    else
                    {
                        Secondary_Equipment = MainPlayer.main_equipment.name;
                        Secondary_Equipment_Recharge = MainPlayer gadgetPowerGet(MainPlayer.main_equipment_slot);
                        Secondary_Equipment_Ammo = MainPlayer getWeaponAmmoClip(MainPlayer.main_equipment);
                    }
                }

                // all vars
                SavesGame = {
                    #Points: MainPlayer.score,
                    #Map: Map,
                    #Round: zm_round_logic::get_round_number(),
                    #CharacterIndex: MainPlayer.characterindex,
                    #WasPAPOn: GetPAPState(),
                    #ItemsPickedUp: a_items_picked,
                    #CraftingTables: crafting_tables,
                    #Cords: MainPlayer.origin,
                    #Angles: MainPlayer.angles,
                    #Weapons: WeaponsData.size,
                    #MeleeWeapon: undefined,
                    #Weapon_1: WeaponsData[0].name,
                    #Weapon_2: undefined,
                    #Weapon_3: undefined,
                    #Weapon_1_Clip: MainPlayer getweaponammoclip(WeaponsData[0]),
                    #Weapon_1_Stock: MainPlayer getweaponammostock(WeaponsData[0]),
                    #Weapon_2_Clip: undefined,
                    #Weapon_2_Stock: undefined,
                    #Weapon_3_Clip: undefined,
                    #Weapon_3_Stock: undefined,
                    #Weapon_1_Packs: undefined,
                    #Weapon_2_Packs: undefined,
                    #Weapon_3_Packs: undefined,
                    #Weapon_1_AAT: undefined,
                    #Weapon_2_AAT: undefined,
                    #Weapon_3_AAT: undefined,
                    #Equipment: Equipment,
                    #Equipment_Recharge: Equipment_Recharge,
                    #Equipment_Ammo: MainPlayer getWeaponAmmoClip(MainPlayer zm_loadout::get_player_lethal_grenade()),
                    #Secondary_Equipment: Secondary_Equipment,
                    #Secondary_Equipment_Recharge: Secondary_Equipment_Recharge,
                    #Secondary_Equipment_Ammo: Secondary_Equipment_Ammo,
                    #Specialist: MainPlayer.var_fd05e363.name,
                    #Specialist_Recharge: MainPlayer gadgetPowerGet(MainPlayer gadgetGetSlot(MainPlayer.var_fd05e363)),
                    #Specialist_Level: MainPlayer.var_72d6f15d,
                    #ActivePerks: PerksActive,
                    #ExtraPerks: PerksExtra,
                    #ClassicPerks: ClassicPerksGet,
                    #ClassicGum : ClassicGumGet,
                    #HasShield: (isdefined(MainPlayer.hasriotshield) && MainPlayer.hasriotshield),
                    #ShieldDurability: (isdefined(MainPlayer.hasriotshield) && MainPlayer.hasriotshield) ? MainPlayer damageriotshield(0) : 0,
                    #ShieldAmmo: (isdefined(MainPlayer.hasriotshield) && MainPlayer.hasriotshield) ? MainPlayer getWeaponAmmoClip(MainPlayer.weaponriotshield) : 0,
                    #DoorsArray: DoorsOpened,
                    #DebrisArray: DebrisClosed,
                    #MainQuest_Step: MainQuest_Step,
                    #Directed_RoundCap: isdefined(level.round_cap) ? level.round_cap : 0,
                    #RampageMode: isdefined(level.RampageActive) ? level.RampageActive : false,
                    #Side_Quest_Tomahawk: level flag::exists(#"soul_catchers_charged") && level flag::get(#"soul_catchers_charged"),
                    #BOTD_Challenge_Left: ChallengesLeft
                };
                
                // packs
                if(isDefined(MainPlayer.var_2843d3cc) && isDefined(MainPlayer.var_2843d3cc[zm_weapons::function_93cd8e76(WeaponsData[0])]))
                    SavesGame.Weapon_1_Packs = MainPlayer.var_2843d3cc[zm_weapons::function_93cd8e76(WeaponsData[0])];

                // atts
                TryAAT = MainPlayer aat::getaatonweapon(WeaponsData[0]);
                if (isDefined(TryAAT))
                    SavesGame.Weapon_1_AAT = TryAAT.name;

                // IF more than one weapon
                if (isDefined(WeaponsData[1]))
                {
                    SavesGame.Weapon_2 = WeaponsData[1].name;

                    TryAAT = MainPlayer aat::getaatonweapon(WeaponsData[1]);
                    if (isDefined(TryAAT))
                        SavesGame.Weapon_2_AAT = TryAAT.name;
                        
                    if(isDefined(MainPlayer.var_2843d3cc) && isDefined(MainPlayer.var_2843d3cc[zm_weapons::function_93cd8e76(WeaponsData[1])]))
                        SavesGame.Weapon_2_Packs = MainPlayer.var_2843d3cc[zm_weapons::function_93cd8e76(WeaponsData[1])];

                    SavesGame.Weapon_2_Clip = MainPlayer getweaponammoclip(WeaponsData[1]);
                    SavesGame.Weapon_2_Stock = MainPlayer getweaponammostock(WeaponsData[1]);
                }

                if (isDefined(WeaponsData[2]))
                {
                    SavesGame.Weapon_3 = WeaponsData[2].name;

                    TryAAT = MainPlayer aat::getaatonweapon(WeaponsData[2]);
                    if (isDefined(TryAAT))
                        SavesGame.Weapon_3_AAT = TryAAT.name;

                    if(isDefined(MainPlayer.var_2843d3cc) && isDefined(MainPlayer.var_2843d3cc[zm_weapons::function_93cd8e76(WeaponsData[2])]))
                        SavesGame.Weapon_3_Packs = MainPlayer.var_2843d3cc[zm_weapons::function_93cd8e76(WeaponsData[2])];

                    SavesGame.Weapon_3_Clip = MainPlayer getweaponammoclip(WeaponsData[2]);
                    SavesGame.Weapon_3_Stock = MainPlayer getweaponammostock(WeaponsData[2]);
                }

                MeleeWeapon = undefined;
                a_w_weapons = MainPlayer getweaponslist(0);
                foreach (w_weapon in a_w_weapons) {
                    if (zm_loadout::is_melee_weapon(w_weapon)) {
                        MeleeWeapon = w_weapon;
                    }
                }

                if (isDefined(MeleeWeapon))
                    SavesGame.MeleeWeapon = MeleeWeapon.name;

                ShieldToJson("EnhGameSave", SavesGame);
                setDvar(#"shield_enh_SaveGame", 0);

                // test
                SavesGameTest = {
                    #Points: 6969,
                    #Map: 12
                };

                ShieldToJson("EnhGameSaveTest", SavesGameTest);

                foreach(player in level.players) 
                    player iPrintLn("^1Saved Game...");
            }
        }

        wait 1.5;
    }
}