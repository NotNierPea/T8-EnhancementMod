detour zm_round_logic<scripts\zm_common\zm_round_logic.gsc>::set_round_number(new_round) {
    if (!isDefined(level.round_cap))
        return [[ @zm_round_logic<scripts\zm_common\zm_round_logic.gsc>::set_round_number ]](new_round);

    if (new_round > level.round_cap)
    {
        new_round = level.round_cap;
        level thread DirectedNotifyRoundCapReached();
    }
    
    world.roundnumber = new_round ^ 115;
}

Directed_Change_GameOver_Screen()
{
    level waittill(#"end_game");

    for (i = 1; i <= 15; i++)
    {
        LUINotifyEvent(#"shield_enh_gameover_directed", 1, 1);
        wait 0.25;
    }
}

Directed_SetObjective(objective_id) {
    if (isdefined(level.players) && objective_id != 0 && objective_id != 999 && objective_id != 1000)
    {
        foreach(player in level.players)
        {
            player playsoundtoplayer(#"hash_2ef2e5af521e9817", player);
        }
    }

    level.Directed_Objective = objective_id;
    LUINotifyEvent(#"enhancement_directed_objective", 1, objective_id);
}

Directed_UpdateObjective(objective_number = 0, objective_max = 0) {
    if (!isDefined(level.Directed_Objective))
        return;

    //ShieldLog("Updating Directed Objective: " + level.Directed_Objective + " with number: " + objective_number);
    LUINotifyEvent(#"enhancement_directed_objective", 3, level.Directed_Objective, objective_number, objective_max);
}

Directed_SetRoundCap(round_cap) {
    if (!GetDvarInt(#"shield_enh_DirectedMode_RoundCap", 1))
        return;

    // ? what
    if (isdefined(level.round_cap) && level.round_cap > round_cap)
        return;
    
    level.round_cap = round_cap;
    LUINotifyEvent(#"enhancement_directed_round_cap", 1, round_cap);
}

DirectedNotifyRoundCapReached()
{
    foreach(player in level.players)
    {
        player playsoundtoplayer(#"hash_1377aa36d8ba27e1", player);
    }

    LUINotifyEvent(#"enhancement_directed_round_cap", 1, 999);
    wait 3;
    LUINotifyEvent(#"enhancement_directed_round_cap", 1, level.round_cap);
}

DirectedMode()
{
    if(!GetDvarInt(#"shield_enh_DirectedMode", 0)) 
        return;

    if (GetDvarInt(#"shield_enh_Practice_Bosses", 0) || GetDvarInt(#"shield_enh_TeamCranked", 0))
        return;

    if (GetDvarString(#"g_gametype", "") != "zclassic")
        return;

    // remove later when all maps are added
    if (BO4GetMap() != "IX" && BO4GetMap() != "Voyage" && BO4GetMap() != "Blood")
        return;

    ShieldLog("^3Directed Mode Enabled!");

    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    level thread Directed_SetRoundCap(1);
    level thread Directed_SetObjective(0);

    // intro notify
    level thread Directed_SetObjective(1000);

    switch(BO4GetMap())
    {
        case "IX":
        IXDirectedMode();
        break;

        case "Blood":
        BOTDDirectedMode();
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
        VoyageDirectedMode();
        break;
    }
}

directed_add_new_objective(objective, objective_image = 1, str_waittill, str_entity, str_wait_entity, objective_text_hint, objective_text_hint2)
{
	self endon(#"death");

	self.o_n_obj_id = get_next_obj_id_directed();
	objective_add(self.o_n_obj_id, "active", self, objective);
	objective_onentity(self.o_n_obj_id, self);
	function_da7940a3(self.o_n_obj_id, 1);

    // if it gets reused..
    self notify(#"stop_directed_death");
	self thread directed_release_obj_on_death(str_waittill, str_entity, str_wait_entity);
    self thread directed_objective_visable();

    wait 0.1;

    foreach(player in level.players)
    {
        player playsoundtoplayer(#"hash_5590bcb35a1c2562", player);
    }

    self.enh_objective_image = objective_image;

	// lui
    if (isdefined(objective_text_hint) && isdefined(objective_text_hint2))
	    LUINotifyEvent(#"enhancement_objective_visibility", 5, self.o_n_obj_id, 4, self.enh_objective_image, objective_text_hint, objective_text_hint2);
    else if (isdefined(objective_text_hint))
        LUINotifyEvent(#"enhancement_objective_visibility", 4, self.o_n_obj_id, 4, self.enh_objective_image, objective_text_hint);
    else
        LUINotifyEvent(#"enhancement_objective_visibility", 3, self.o_n_obj_id, 4, self.enh_objective_image);
}

directed_update_objective(objective_text_hint, objective_text_hint2)
{
    if (!isDefined(self.o_n_obj_id))
        return;

    // lui
    if (isdefined(objective_text_hint) && isdefined(objective_text_hint2))
        LUINotifyEvent(#"enhancement_objective_visibility", 5, self.o_n_obj_id, 4, self.enh_objective_image, objective_text_hint, objective_text_hint2);
    else if (isdefined(objective_text_hint))
        LUINotifyEvent(#"enhancement_objective_visibility", 4, self.o_n_obj_id, 4, self.enh_objective_image, objective_text_hint);
    else
        LUINotifyEvent(#"enhancement_objective_visibility", 3, self.o_n_obj_id, 4, self.enh_objective_image);
}

directed_release_obj_on_death(str_waittill = #"nothing", str_entity = self, str_wait_entity = #"nothing")
{
    self endon(#"stop_directed_death");

    o_n_obj_id = self.o_n_obj_id;

    self util::waittill_any_ents(self, "death", level, "release_objs", self, str_waittill, str_entity, str_wait_entity);

	if (isDefined(self) && isDefined(self.o_n_obj_id))
	{
        self notify(#"stop_lifetime");

        objective_setinvisibletoall(o_n_obj_id);
        release_obj_id_directed(o_n_obj_id);

        LUINotifyEvent(#"enhancement_objective_visibility", 2, self.o_n_obj_id, 0);

		self.o_n_obj_id = undefined;
	}
    else
    {    
        objective_setinvisibletoall(o_n_obj_id);
        release_obj_id_directed(o_n_obj_id);

        LUINotifyEvent(#"enhancement_objective_visibility", 2, o_n_obj_id, 0);
    }
}

directed_objective_visable()
{
    self endon(#"death", #"stop_directed_death", #"stop_lifetime");

    while(true)
    {
        LUINotifyEvent(#"enhancement_objective_visibility", 3, self.o_n_obj_id, 1, 1);
        util::wait_network_frame(1);
    }
}