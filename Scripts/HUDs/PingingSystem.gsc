ping_add_new_objective(objective, image_id, client_num, str_waittill)
{
	self endon(#"death");

	self.o_n_obj_id = get_next_obj_id_ping();

    ShieldLog("using ping for id: " + self.o_n_obj_id);

    self.PingedObjective = true;
	//if (Objective_State(self.o_n_obj_id) == "empty") {
		//ShieldLog("Registering Objective ID: " + self.o_n_obj_id);
    
	objective_add(self.o_n_obj_id, "active", self, objective);
	objective_onentity(self.o_n_obj_id, self);

	//}
	//else {
	//	//ShieldLog("Re-configuring Objective ID: " + self.o_n_obj_id);
	//	Objective_OnEntity(self.o_n_obj_id, self);
	//	Objective_SetState(self.o_n_obj_id, "active");
	//}
	function_da7940a3(self.o_n_obj_id, 1);

    // if it gets reused..
    self notify(#"stop_ping_death");
	self thread ping_release_obj_on_death(str_waittill);

    wait 0.1;

    foreach(player in level.players)
    {
        player playsoundtoplayer(#"hash_5590bcb35a1c2562", player);
    }

	// lui
	LUINotifyEvent(#"enhancement_objective_visibility", 4, self.o_n_obj_id, 3, image_id, client_num);

    self thread pingLifetime();
    self thread ShowVisibility();

    //ShieldLog("^1added objective " + self.o_n_obj_id);
}

ping_release_obj_on_death(str_waittill = #"nothing")
{
    self endon(#"stop_ping_death");

    o_n_obj_id = self.o_n_obj_id;

    self util::waittill_any_ents(self, "death", level, "release_objs", self, str_waittill);

	if (isDefined(self) && isDefined(self.o_n_obj_id))
	{
		//ShieldLog("Releasing Objective ID: " + o_n_obj_id);
        objective_setinvisibletoall(o_n_obj_id);
        //objective_delete(o_n_obj_id);
        release_obj_id_ping(o_n_obj_id);

        LUINotifyEvent(#"enhancement_objective_visibility", 2, self.o_n_obj_id, 0);

		self.o_n_obj_id = undefined;

        self.PingedObjective = false;

        arrayremovevalue(level.ObjectivePosArr, self);
	}
    else
    {    
        objective_setinvisibletoall(o_n_obj_id);
        //objective_delete(o_n_obj_id);
        release_obj_id_ping(o_n_obj_id);

        LUINotifyEvent(#"enhancement_objective_visibility", 2, o_n_obj_id, 0);
    }

    array::filter(level.ObjectivePosArr, 0, &IsValidObj);
}

IsValidObj(ent)
{
    return isDefined(ent);
}

PingingSystem()
{
    level.ObjectivePosArr = [];
    level.pingCooldown = 1.0; // seconds
    level.pingDistance = 1000; // units

    callback::on_spawned(&onPlayerSpawn);
}

onPlayerSpawn()
{
    self.pingLastTime = 0;
    self thread monitorPingInput();
}

monitorPingInput()
{
    self endon(#"death");
    
    if (IsBot(self))
    {
        return;
    }

    level flag::wait_till("initial_blackscreen_passed");

    for(;;)
    {
        if(self changeseatbuttonpressed() && self adsButtonPressed() && self canPing())
        {
            pingLocation = self getCursorPos(level.pingDistance);
            if(isDefined(pingLocation))
            {
                self.pingLastTime = getTime();
                self showPing(pingLocation);

                //ShieldLog("^1added objective model");
            }

            wait 0.35;
        }
        wait 0.05;
    }
}

canPing()
{
    if (!isDefined(self.pingLastTime))
        self.pingLastTime = 0;

    return ((getTime() / 1000.0) - (self.pingLastTime / 1000.0)) >= level.pingCooldown;
}

showPing(pos)
{
    pingEnt = util::spawn_model("tag_origin", pos);
    pingEnt thread ping_add_new_objective(#"enh_objective", 1, self GetEntityNumber(), #"ping_lifetime_end");
    pingEnt.IsCustomObjectiveModel = true;

    level.ObjectivePosArr[level.ObjectivePosArr.size] = pingEnt;
}

pingLifetime()
{
    self endon(#"death");

    wait 10;

    self notify(#"ping_lifetime_end");

    wait 0.5;

    if (isDefined(self) && isDefined(self.IsCustomObjectiveModel))
        self delete();
}

getCursorPos(distance)
{
    forward = anglesToForward(self getPlayerAngles());
    start = self getEye();
    end = start + forward * distance;
    trace = bulletTrace(start, end, false, self);

    // check if we hit an entity (actor/model)
    if (isDefined(trace["entity"]))
    {
        if (isDefined(trace["entity"].PingedObjective) && trace["entity"].PingedObjective == true)
        {
            trace["entity"] notify(#"ping_lifetime_end");
        }
        else
        {
            trace["entity"] thread ping_add_new_objective(#"enh_objective", 1, self GetEntityNumber(), #"ping_lifetime_end");
            self.pingLastTime = getTime();
        }

        return undefined; // don't spawn a new ping at position
    }

    // check for zombies/AIs using bulletTracePassed
    ents = getentarray();
    foreach(ent in ents)
    {
        if (!isDefined(ent) || !isAlive(ent) || ent == self)
            continue;

        if (self is_looking_at(ent))
        {
            if (isDefined(ent.PingedObjective) && ent.PingedObjective == true)
            {
                ent notify(#"ping_lifetime_end");
            }
            else
            {
                ent thread ping_add_new_objective(#"enh_objective", 1, self GetEntityNumber(), #"ping_lifetime_end");
                self.pingLastTime = getTime();
            }
            return undefined;
        }
    }

    // our objectives
    foreach(ent in level.ObjectivePosArr)
    {
        if (!isDefined(ent))
            continue;
        
        if (self util::is_looking_at(ent.origin))
        {
            if (isDefined(ent.PingedObjective) && ent.PingedObjective == true)
            {
                ent notify(#"ping_lifetime_end");
            }

            return undefined;
        }
    }

    if(trace["fraction"] < 1)
        return trace["position"];
        
    return undefined;
}

ShowVisibility()
{
    self endon(#"death", #"ping_lifetime_end");

    while(true)
    {
        LUINotifyEvent(#"enhancement_objective_visibility", 3, self.o_n_obj_id, 1, 1);
        util::wait_network_frame(1);
    }
}