AddObjectiveHealthBar(b_on = 1, icon = #"enh_objective_health", archetype_index = 0) 
{
    self endon(#"death");

    if (isdefined(b_on) && b_on)
    {
		self.n_obj_id = get_next_obj_id_health();

		//ShieldLog("using health for id: " + self.n_obj_id);

		//if (Objective_State(self.n_obj_id) == "empty") {
			//ShieldLog("Registering Objective ID: " + self.n_obj_id);

		// offset Y -> 75, blight and gegenees use different icon
		if (archetype_index == 3 || archetype_index == 17)
		{
			icon = #"enh_objective_health_y";
		}

		objective_add(self.n_obj_id, "active", self, icon);
		objective_onentity(self.n_obj_id, self);

		//}
		//else {
		//	//ShieldLog("Re-configuring Objective ID: " + self.n_obj_id);
		//	Objective_OnEntity(self.n_obj_id, self);
		//	Objective_SetState(self.n_obj_id, "active");
		//}

		function_da7940a3(self.n_obj_id, 1);

		self thread NotifyDeath();
		
		// hide
		LUINotifyEvent(#"enhancement_objective_visibility", 2, self.n_obj_id, 0);
    }
}

NotifyDeath()
{
    self util::waittill_any_ents(self, "death", level, "release_objs");

	n_obj_id = self.n_obj_id;

	LUINotifyEvent(#"enhancement_objective_health", 4, self.number, 0, 0, 0);
	LUINotifyEvent(#"enhancement_objective_health", 5, self.number, 0, 0, 0, 0);

	wait 0.45;

	//ShieldLog("Releasing Objective ID: " + n_obj_id);
	objective_setinvisibletoall(n_obj_id);
    //objective_delete(n_obj_id);
    release_obj_id_health(n_obj_id);
}

AddZombieHealthBars()
{
    if(!GetDvarInt(#"shield_enh_HealthBars", 0))
     	return;

    callback::on_spawned(&objective_visibility_init);
    callback::on_ai_spawned(&HealthBarSpawn);
}

objective_visibility_init()
{
	level endon("end_game");
	self endon("disconnect");
	wait 0.05;
	self.zomb_array = array();

	if (!level flag::get("initial_blackscreen_passed"))
		level flag::wait_till("initial_blackscreen_passed");

    ShieldLog("starting objective_visibility_init..");

	while(true)
	{
		wait 0.05;

		// get ALL, even ingore ones
		a_ai_enemies = [];
		a_ai_valid_enemies = [];
		a_ai_enemies = getaiteamarray(level.zombie_team);

		for (i = 0; i < a_ai_enemies.size; i++) {
			if (!isdefined(a_ai_valid_enemies)) {
				a_ai_valid_enemies = [];
			} else if (!isarray(a_ai_valid_enemies)) {
				a_ai_valid_enemies = array(a_ai_valid_enemies);
			}
			a_ai_valid_enemies[a_ai_valid_enemies.size] = a_ai_enemies[i];
		}

		foreach(zomb in a_ai_valid_enemies)
		{
			if(self is_looking_at(zomb) && isdefined(zomb.number) && !IsInArray(self.zomb_array, zomb))
			{
				self LUINotifyEvent(#"enhancement_objective_visibility", 2, zomb.number, 1);
				array::add(self.zomb_array, zomb);
			}

			if(!self is_looking_at(zomb) && isdefined(zomb.number) && IsInArray(self.zomb_array, zomb) || !isDefined(zomb.first_time_waypoint) && isdefined(zomb.number))
			{
				self LUINotifyEvent(#"enhancement_objective_visibility", 2, zomb.number, 0);
				if(IsInArray(self.zomb_array, zomb))
					ArrayRemoveValue(self.zomb_array, zomb);

				zomb.first_time_waypoint = true;
			}
		}
	}
}

is_looking_at(ent_or_org, n_dot_range = 0.98, do_trace = true, v_offset)
{
	//IPrintLnBold("is looking is read");
	//Assert( isdefined( ent_or_org ), "ent_or_org is required parameter for is_facing function" );

	v_point = (IsVec(ent_or_org) ? ent_or_org : ent_or_org.origin);
	
	if (IsVec(v_offset))
	{
		v_point += v_offset;
	}
	
	b_can_see = false;
	b_use_tag_eye = false;
	
	if (IsPlayer(self) || IsAI(self))
	{
		b_use_tag_eye = true;
	}
	
	n_dot = self math::get_dot_direction(v_point + (0, 0, 50), false, true, "forward", b_use_tag_eye);

	if (n_dot > n_dot_range)
	{
		if (do_trace)
		{
			v_eye = self GetEye();
			trace = BulletTrace(v_eye, v_point + (0, 0, 50), true, self);
			if(IsActor(trace["entity"]) && trace["entity"] == ent_or_org)
				return true;

			else 
				return false;
		}
		else
		{
			b_can_see = true;
		}
	}
	//IPrintLnBold(b_can_see);
	return b_can_see;
}

GetArchetypeIndex(archetype)
{
	if (!isdefined(archetype))
		return 0;
	
	switch(archetype)
	{
		case #"zombie":
		return 1;
		break;

		case #"stoker":
		return 2;
		break;

		case #"blight_father":
		return 3;
		break;

		case #"catalyst":
			switch(self.var_9fde8624)
			{
				case #"catalyst_electric":
				return 4;
				break;
				case #"catalyst_corrosive":
				return 5;
				break;
				case #"catalyst_plasma":
				return 6;
				break;
				case #"catalyst_water":
				return 7;
				break;
			}
		break;

		case #"gladiator":
			switch(self.var_9fde8624)
			{
				case #"gladiator_destroyer":
				return 8;
				break;
				case #"gladiator_marauder":
				return 9;
				break;
			}
		break;
		
		case #"tiger":
		return 10;
		break;

		case #"brutus":
		return 11;
		break;

		case #"zombie_dog":
		return 12;
		break;

		case #"werewolf":
		return 13;
		break;

		case #"nosferatu":
		return 14;
		break;

		case #"nova_crawler":
		return 15;
		break;

		case #"skeleton":
		return 16;
		break;

		case #"gegenees":
		return 17;
		break;

		case #"zombie_electric":
		return 18;
		break;
	}
	
	// unknown, probably boss or anything else.
	return 0;
}

HealthBarSpawn()
{
    self endon(#"death");

	wait 1;

	Archetype_Index = GetArchetypeIndex(self.archetype);
	self AddObjectiveHealthBar(true, undefined, Archetype_Index);

	// for lua usage
	self.number = self.n_obj_id;
	
	wait 0.5;

	// for AE
	if (!level flag::get("initial_blackscreen_passed"))
		level flag::wait_till("initial_blackscreen_passed");

	if (!isDefined(self.number) || !isDefined(self.health) || !isDefined(self.maxhealth))
	 return;

	LUINotifyEvent(#"enhancement_objective_health", 4, self.number, ConvertNumToLUI(self.health), ConvertNumToLUI(self.maxhealth), ConvertNumToLUI(self.health / self.maxhealth));
	LUINotifyEvent(#"enhancement_objective_health", 6, self.number, ConvertNumToLUI(self.health), ConvertNumToLUI(self.maxhealth), ConvertNumToLUI(self.health / self.maxhealth), ConvertNumToLUI(self.health / self.maxhealth), Archetype_Index);

	// Track last damage time
    self.last_damage_time = GetTime();
    self.white_bar_update_delay = 1.15; // seconds to wait after last damage

    // Only one white bar update thread at a time
    if (!isdefined(self.monitor_white_bar_thread))
        self.monitor_white_bar_thread = self thread MonitorWhiteBarUpdateZMB();

	while(isdefined(self)) // monitor health
	{
		self waittill("damage");
		LUINotifyEvent(#"enhancement_objective_health", 4, self.number, ConvertNumToLUI(self.health), ConvertNumToLUI(self.maxhealth), ConvertNumToLUI(self.health / self.maxhealth));

		// Update last damage time
        self.last_damage_time = GetTime();

        // Reset the white bar update thread if it's waiting
        if (isdefined(self.monitor_white_bar_thread))
        {
            self notify(#"reset_white_bar_timer");
        }
	}
}

MonitorWhiteBarUpdateZMB()
{
    self endon(#"death");

    while(true)
    {
        // Wait for reset or timeout
        self waittilltimeout(self.white_bar_update_delay, #"reset_white_bar_timer");

        // If timeout, update white bar
        if (GetTime() - self.last_damage_time >= self.white_bar_update_delay)
        {
            UpdateHealthBarWhite();
        }
    }
}

UpdateHealthBarWhite()
{
    self endon(#"death");

	Archetype_Index = GetArchetypeIndex(self.archetype);
    LUINotifyEvent(#"enhancement_objective_health", 6, self.number, ConvertNumToLUI(self.health), ConvertNumToLUI(self.maxhealth), ConvertNumToLUI(self.health / self.maxhealth), ConvertNumToLUI(self.health / self.maxhealth), Archetype_Index);
}