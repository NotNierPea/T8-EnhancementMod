// for zm crafting icon, shield's
detour zm_crafting<scripts\zm_common\zm_crafting.gsc>::function_f37c4bb5(player) {
	if(!GetDvarInt(#"shield_enh_ClassicMode", 0))
		return [[ @zm_crafting<scripts\zm_common\zm_crafting.gsc>::function_f37c4bb5 ]](player);

    if (self.stub.crafted) {
        return;
    }
    if (!isdefined(self.stub.blueprint)) {
        return;
    }
    var_c060d2c8 = self.stub.var_c060d2c8;
    silent = 0;
    initial_current_weapon = player getcurrentweapon();
    current_weapon = zm_weapons::get_nonalternate_weapon(initial_current_weapon);
    if (current_weapon.isheroweapon || current_weapon.isgadget || current_weapon.isriotshield) {
        silent = 1;
    }
    if (silent) {
        progress_result = zm_progress::progress_think(player, level.var_98dad84e, var_c060d2c8);
    } else {
        progress_result = zm_progress::progress_think(player, level.var_90237ebd, var_c060d2c8);
    }
    self notify(#"hash_6db03c91467a21f5", {#b_completed:progress_result});
    if (progress_result) {
        self.stub.crafted = 1;
        player_crafted = player;
        self.stub.blueprint.completed = 1;
        if (isdefined(self.stub.blueprint.var_d8967a0c) && self.stub.blueprint.var_d8967a0c) {
            zm_crafting::function_6f635422(player, self.stub.blueprint);
        }
        level notify(#"blueprint_completed", {#blueprint:self.stub.blueprint, #produced:self.stub.blueprint.var_54a97edd, #player:player, #stub:self.stub});
        player notify(#"blueprint_completed", {#blueprint:self.stub.blueprint, #produced:self.stub.blueprint.var_54a97edd});
        if (self.stub.blueprint.var_46309255 === "persistent_buy" || self.stub.blueprint.var_46309255 === "buy_once_then_box" || self.stub.blueprint.var_46309255 === "spawn_as_ingredient") {
            zm_crafting::function_987a472(self.stub.blueprint.var_54a97edd.worldmodel, self.stub.blueprint);
        }
        if (isdefined(player_crafted)) {
            player_crafted playsound(#"zmb_craftable_complete");
            if (isdefined(self.stub.blueprint.name)) {
                player_crafted thread zm_audio::create_and_play_dialog(#"build_complete", self.stub.blueprint.name);
            }
        }
        if (isdefined(self.stub.craftfoundry.callback_funcs)) {
            foreach (func in self.stub.craftfoundry.callback_funcs) {
                self thread [[ func ]](player);
            }
        }
        if (isdefined(self.stub.blueprint.var_54a97edd) && isdefined(self.stub.blueprint.var_54a97edd.isriotshield) && self.stub.blueprint.var_54a97edd.isriotshield) {
            foreach (e_player in getplayers()) {
                /#
                    e_player zm_challenges::debug_print("<dev string:x198>");
                #/
                e_player zm_stats::increment_challenge_stat(#"shields_built", undefined, 1);
            }
        }
        if (isdefined(self.stub.blueprint.var_46309255)) {
            self.stub state_craft(self.stub.blueprint.var_46309255);
        }
    }
}

state_craft(state)
{
	if (!isdefined(state)) {
        return;
    }
    self.var_90dfb0bf = state;
    if (!isdefined(level.var_b87dee47[self.var_90dfb0bf])) {
        return;
    }
    if (isdefined(level.var_b87dee47[self.var_90dfb0bf].var_aee03b4c)) {
        self [[ level.var_b87dee47[self.var_90dfb0bf].var_aee03b4c ]]();
    }
}

vulture_add_new_objective(objective, image_id, str_waittill, waitill_ent = self, player_ent = undefined)
{
	self endon(#"death");

	if (!isDefined(level.VultureIndex))
	{
		// if fast_restart
		for (i = 0; i < 100; i++)
		{
			LUINotifyEvent(#"enhancement_vulture_visibility", 2, 0, i);
		}

		level.VultureIndex = 0;
	}

	if (isDefined(waitill_ent))
	{
		level.VultureIndex++;

		self.n_obj_id = level.VultureIndex;
		
		self thread release_obj_on_death(str_waittill, waitill_ent);
	}

	// fuck off lui
	wait 0.1;

	if (isDefined(player_ent))
		player_ent LUINotifyEvent(#"enhancement_vulture_visibility", 6, 1, self.n_obj_id, int(self.origin[0]), int(self.origin[1]), isDefined(self.is_weapon) ? int(self.origin[2]) : int(self.origin[2] + 50), image_id);
	else
		LUINotifyEvent(#"enhancement_vulture_visibility", 6, 1, self.n_obj_id, int(self.origin[0]), int(self.origin[1]), isDefined(self.is_weapon) ? int(self.origin[2]) : int(self.origin[2] + 50), image_id);

	if (isDefined(waitill_ent))
		level.VultureObjects[level.VultureObjects.size] = self;
}

release_obj_on_death(str_waittill = #"nothing", entity)
{
	n_obj_id = self.n_obj_id;

    level util::waittill_any_ents(self, #"death", self, #"release_objs", entity, str_waittill);

	ShieldLog("Removing Vulture Obj: " + n_obj_id);
	
	LUINotifyEvent(#"enhancement_vulture_visibility", 2, 0, self.n_obj_id);

	arrayremovevalue(level.VultureObjects, self);
	self.n_obj_id = undefined;
}

VultureAidLogic()
{
	self endon(#"death", #"disconnect", #"player_downed", #"stop_updating_vulture");

	while(true)
	{
		foreach(obj in level.VultureObjects)
		{
			if (util::is_looking_at(obj.origin, 0.50, false, isDefined(obj.is_weapon) ? undefined : (0, 0, 50)))
			{
				// distance checking for weapons, too many.
				if ((isDefined(obj.is_weapon) || isDefined(obj.is_perk)) && distancesquared(obj.origin, self.origin) < 1800000)
				{
					self LUINotifyEvent(#"enhancement_vulture_visibility", 2, 2, obj.n_obj_id);

					continue;
				}
				
				if (!isDefined(obj.is_weapon) && !isDefined(obj.is_perk))
					// normal
					self LUINotifyEvent(#"enhancement_vulture_visibility", 2, 2, obj.n_obj_id);
				else
					self LUINotifyEvent(#"enhancement_vulture_visibility", 2, 3, obj.n_obj_id);
			}
			else
				self LUINotifyEvent(#"enhancement_vulture_visibility", 2, 3, obj.n_obj_id);
		}

		wait 0.05;
	}
}

GetPerkVultureID(id)
{
	switch(id)
	{
		case #"specialty_zombshell": return 43;
		case #"specialty_wolf_protector": return 27;
		case #"specialty_widowswine": return 42;
		case #"specialty_staminup": return 38;
		case #"specialty_shield": return 41;
		case #"specialty_quickrevive": return 36;
		case #"specialty_phdflopper": return 35;
		case #"specialty_mystery": return 37;
		case #"specialty_extraammo": return 26;
		case #"specialty_etherealrazor": return 33;
		case #"specialty_electriccherry": return 32;
		case #"specialty_death_dash": return 25;
		case #"specialty_deadshot": return 29;
		case #"specialty_cooldown": return 40;
		case #"specialty_camper": return 39;
		case #"specialty_berserker": return 31;
		case #"specialty_awareness": return 30;
		case #"specialty_additionalprimaryweapon": return 34;
		default: return 0;
	}
}

Vulture_AddObjectives()
{
	level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

	ShieldLog("^2Adding Vulture's Objectives...");

	level.VultureObjects = [];

	if (isDefined(level.GumMachine))
		level.GumMachine thread vulture_add_new_objective(#"enh_objective", 1);

	for (i = 0; i < level._spawned_wallbuys.size; i++) {
        wallbuy = level._spawned_wallbuys[i];

        target_struct = struct::get(wallbuy.target, "targetname");
        if (isdefined(target_struct) && isdefined(target_struct.target)) {
            wallbuy_fx = getent(target_struct.target, "targetname");
            if (isdefined(wallbuy_fx)) {
				wallbuy_fx.is_weapon = true;
                wallbuy_fx thread vulture_add_new_objective(#"enh_objective", 2);
            }
        }
	}

	// perkes classic
	foreach(perk in level.CustomClassicPerks)
	{
		perk.is_perk = true;
		perk thread vulture_add_new_objective(#"enh_objective", perk.vulture_id);
	}

	// normal perks, for each player depending on icon
	foreach (s_altar in struct::get_array("perk_vapor_altar")) 
	{
		if (isDefined(s_altar))
		{
			collision = spawn("script_model", s_altar.origin + (0, 0, -30), 1);
			collision.angles = s_altar.angles;
			collision setmodel(#"zm_collision_perks1");
			collision.script_noteworthy = "clip";
			collision disconnectpaths();
			collision notSolid();

			perk_coll = collision;
			perk_coll.is_perk = true;

			s_altar.perk_coll = perk_coll;

			perk_coll thread vulture_add_new_objective(#"enh_objective", 16, #"nothing", perk_coll);
		}
	}

	foreach (s_altar in struct::get_array("perk_vapor_altar")) 
	{
		if (isDefined(s_altar))
		{
			// for each player
			slot_altar = s_altar.script_int;
			vulture_id_perk = 0;

			foreach(player in level.players)
			{
				foreach (slot, perk in player.var_c27f1e90) {
					if (slot === slot_altar)
					{
						vulture_id_perk = GetPerkVultureID(perk);
					}
				}

				// NOT NEW, just modify with that undefined param for each player.
				s_altar.perk_coll thread vulture_add_new_objective(#"enh_objective", vulture_id_perk, #"nothing", undefined, player);
			}
		}
	}

	thread MagicBoxUpdate();
	thread PaPUpdate();

	// zm crafting
	thread add_shield_objective_vulture();

	// debug
	//foreach(player in level.players) player thread VultureAidLogic();
}

add_shield_objective_vulture()
{
	ShieldLog("blueprint watcher...");

	while(true)
	{
		waitresult = level waittill(#"blueprint_completed");
		ShieldLog("blueprint notify");

		// TODO: add an icon for it
        if (isdefined(waitresult.produced)) {
			ShieldLog("blueprint add");

			collision = spawn("script_model", waitresult.stub.origin, 1);
			collision.angles = waitresult.stub.angles;
			collision setmodel(#"zm_collision_perks1");
			collision.script_noteworthy = "clip";
			collision disconnectpaths();
			collision notSolid();

			// 5 for crafting table icon..
			collision thread vulture_add_new_objective(#"enh_objective", 5);
        }
	}
}

PaPUpdate()
{
    level endon(#"end_game", #"game_ended");

    PaPs = level.pack_a_punch.trigger_stubs;

    foreach(pap in PaPs)
    {
        pap.vulture_pap = false; // mark as inactive initially
    }

    while(true)
    {
        PaPs = level.pack_a_punch.trigger_stubs;

        foreach(pap in PaPs)
        {
            pap_machine = pap.zbarrier;

            if (!isDefined(pap) || !isDefined(pap_machine))
                continue;

            is_on = pap_machine flag::get(#"Pack_A_Punch_on");

            // handle when it turns on
            if (is_on && !pap.vulture_pap)
            {
                pap thread vulture_add_new_objective(#"enh_objective", 3);
                pap.vulture_pap = true;
                ShieldLog("^4Added new vulture PaP");
            }

            // handle when it turns off
            else if (!is_on && pap.vulture_pap)
            {
                pap notify("release_objs");
                pap.vulture_pap = false;
                ShieldLog("^4Removed vulture PaP");
            }
        }

        wait 1; // only check once per second
    }
}

MagicBoxUpdate()
{
	level endon(#"end_game", #"game_ended");

	// ffs treyarch...
	foreach(chest in level.chests)
	{
		zbarrier = chest.zbarrier;

		collision = spawn("script_model", zbarrier.origin + (0, 0, -30), 1);
		collision.angles = zbarrier.angles;
		collision setmodel(#"zm_collision_perks1");
		collision.script_noteworthy = "clip";
		collision disconnectpaths();
		collision notSolid();

		chest.coll = collision;
	}

	old_chest_index = undefined;

	while(true)
	{
		if (level.chest_index != -1)
		{
			chest = level.chests[level.chest_index];
			if (isDefined(chest))
			{
				obj = chest.coll;

				// Detect chest change
				if (old_chest_index !== level.chest_index)
				{
					// Notify previous chest to release its objective
					if (isDefined(old_chest_index) && isDefined(level.chests[old_chest_index]))
					{
						old_chest = level.chests[old_chest_index];
						if (isDefined(old_chest.coll))
						{
							old_chest.coll notify("release_objs");
						}
					}

					old_chest_index = level.chest_index;
				}

				if(isDefined(obj) && !isDefined(obj.n_obj_id))
				{
					ShieldLog("^4adding new chest for vulture....");

					obj thread vulture_add_new_objective(#"enh_objective", 1, #"kill_chest_think", chest);
				}
			}
		}

		wait 1;
	}
}