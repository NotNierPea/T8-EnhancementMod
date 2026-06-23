ClassicMode_ElixirGum()
{
	if (!GetDvarInt("shield_enh_Gums", 0))
		return;
	
	ShieldLog("^1Init Classic Mode Custom Elixirs!!");

	level flag::wait_till("all_players_spawned");

	switch(BO4GetMap())
    {
        case "IX":
		Cords = (-255, 578, 75);
		Angles = (0, 0, 0);
        break;

        case "Blood":
		Cords = (9943, 11525, 296);
		Angles = (0, 0, 0);
        break;

        case "AE":
		Cords = (-758.012, -734.014, 105);
		Angles = (0, 0, 0);
        break;

        case "AO":
		Cords = (256.464, -2283.56, -15);
		Angles = (0, 0, 0);
        break;

        case "Dead":
		Cords = (143.65, -1040.32, 40);
		Angles = (0, 0, 0);
        break;

        case "Tag":
		Cords = (582, 3731, 70);
		Angles = (0, 0, 0);
        break;

        case "Classified":
		Cords = (-967, 2499, 60);
		Angles = (0, 0, 0);
        break;

        case "Voyage":
		Cords = (238, -5059, 1155);
		Angles = (0, 0, 0);
        break;
    }
	
	level.GumIsWaiting = false;
	level.GumWaiting = "";

	level.PriceGum = 500;
	level.GumsUsed = 0;

	GumMachine = util::spawn_model(#"p8_zm_powerup_rush_point", Cords, Angles);
	GumMachine thread RotateAndBobItem();
	GumMachine clientfield::set("powerup_fx", 2);
	//GumMachine clientfield::set("highlight_item", 1);

	GumMachine zm_unitrigger::create(&CheckStringGums, 110);
    GumMachine thread WaitTriggerGums(); // ffs treyarch

	level.GumMachine = GumMachine;

	thread MonitorRoundChangeGum();
}

MonitorRoundChangeGum()
{
	while(true)
	{
		level waittill(#"between_round_over");

		level.PriceGum = 500;
		level.GumsUsed = 0;
	}
}

CheckStringGums(e_player) 
{
	if (level.GumIsWaiting)
	{
        if (isDefined(e_player.GumWaiting))
        {
            self sethintstringforplayer(e_player, #"shield/gum_get", e_player.GumWaiting);
            return true;
        }
        else
        {
            self sethintstringforplayer(e_player, "");
            return true;
        }
	}
	
	self sethintstringforplayer(e_player, #"shield/gum_machine", level.PriceGum);
    return true;
}

GiveBGBPack(BGBName)
{
	self endon(#"death", #"stop_old_bgb");

    self.holding_bgb = BGBName;

	if (!isDefined(level.bgb[BGBName]))
	{
		ShieldLog("^1uh oh!!");
		return;
	}

	// anim
	//self bgb::bgb_gumball_anim(BGBName);
	self luinotifyevent(#"zombie_bgb_notification", 1, level.bgb[BGBName].item_index);
    self luinotifyeventtospectators(#"zombie_bgb_notification", 1, level.bgb[BGBName].item_index);

	// lua notify, 1 = in pack, 0 = not in pack
	self luinotifyevent(#"shield_zombie_bgb_pack", 2, 1, level.bgb[BGBName].item_index);

    hold_time = 0.50; // seconds to hold the button
    hold_progress = 0.0;

    while (true)
    {
        if (self changeseatbuttonpressed() && !self adsButtonPressed())
        {
            hold_progress += 0.1;

            if (hold_progress >= hold_time)
            {
                self thread GiveBGB(BGBName, true);
                self thread zm_utility::play_sound_on_ent("purchase");

                // remove from UI
                self luinotifyevent(#"shield_zombie_bgb_pack", 2, 0, level.bgb[BGBName].item_index);
                break;
            }
        }
        else
        {
            if (hold_progress > 0)
            {
                hold_progress = 0.0;
            }
        }

        wait 0.1;
    }

    self.holding_bgb = undefined;
}

WaitTriggerGums()
{
    self endon(#"death");
    while (true) {
        waitresult = undefined;
        waitresult = self waittill(#"trigger_activated");
        e_player = waitresult.e_who;

		if (!e_player zm_score::can_player_purchase(level.PriceGum))
		{
			//e_player iPrintLnBold("no");
			zm_utility::play_sound_on_ent("no_purchase");
            e_player thread zm_audio::create_and_play_dialog("general", "outofmoney");
			continue;
		}

        level.GumIsWaiting = true;

		e_player zm_score::minus_to_player_score(level.PriceGum);
		e_player zm_utility::play_sound_on_ent("purchase");

		level.GumsUsed++;

		level.PriceGum += (level.GumsUsed * 500 * zm_round_logic::get_round_number());

		// logic
		if (isDefined(level.bgb))
		{
		    self Ghost();
            
            mdl_reward = util::spawn_model(#"tag_origin", self.origin + (0, 0, 0));
            mdl_reward SetScale(3.5);
            mdl_reward clientfield::set("powerup_fx", 4);

            mdl_reward thread RotateAndBobItem(undefined, undefined, undefined, 12.5, 16.5);
            
            // play little anim just like wonderfizz
            times_anim_max = randomIntRange(10, 20);
            times_anim = 0;

            while(true)
            {
                array_random = array::randomize(getarraykeys(level.bgb));
			    bgb_anim = level.bgb[array_random[0]];

                if (times_anim > times_anim_max)
                    break;
                
                bgb_str = bgb_anim.name;

                weapon = GetBGBModel_Weapon(bgb_str);

                if(!isDefined(weapon) || IsBadElixir(bgb_str))
                {
                    continue;
                }

                weapon_options = e_player calcweaponoptions(bgb_anim.camo_index, 0, 0);

                if (isDefined(weapon.worldmodel))
                {
                    mdl_reward SetScale(0.01);
                    mdl_reward useweaponmodel(weapon, weapon.worldmodel, weapon_options);
                    util::wait_network_frame();
                    mdl_reward SetScale(3.5);
                    //ShieldLog(weapon.worldmodel);
                }

                wait 0.25;

                times_anim++;
            }


			keys = array::randomize(getarraykeys(level.bgb));
			ElixirsRandomGet = level.bgb[keys[0]];

			Retrys = 0;

			while(IsBadElixir(ElixirsRandomGet.name))
			{
				ShieldLog("bad elixir ):, " + ElixirsRandomGet.name);

				Retrys++;
				ElixirsRandomGet = level.bgb[keys[Retrys]];
			}

			// play anim			
			ShieldLog(ShieldHashLookup(ElixirsRandomGet.name));
			
			e_player.GumWaiting = GetGumNamePlease(ElixirsRandomGet.name);

            weapon_get = GetBGBModel_Weapon(ElixirsRandomGet.name);

            if (isDefined(weapon_get) && isDefined(weapon_get.worldmodel))
            {
                weapon_options = e_player calcweaponoptions(ElixirsRandomGet.camo_index, 0, 0);

                mdl_reward SetScale(0.01);
                mdl_reward useweaponmodel(weapon_get, weapon_get.worldmodel, weapon_options);
                util::wait_network_frame();
                mdl_reward SetScale(3.5);
                //ShieldLog(weapon_get.worldmodel);
            }

		    self clientfield::set("powerup_fx", 4);

			self thread PlayCoolEffectsGum();
            self thread TimeoutGum();

            while(true)
            {
                waitresult = undefined;
                waitresult = self waittill(#"trigger_activated", #"timeout_gum");

                if (!isDefined(e_player))
                    break;

                if (isDefined(waitresult.e_who) && waitresult.e_who != e_player)
                    continue;
                
                if (waitresult._notify == #"trigger_activated")
                {
                    e_player notify(#"stop_old_bgb");
                    e_player thread GiveBGBPack(ElixirsRandomGet.name);

                    break;
                }
                else
                {
                    // timeout
                    break;
                }
            }

            
		    self clientfield::set("powerup_fx", 2);
		    self show();

            self notify(#"stop_timeout_gum");

			level.GumIsWaiting = false;

            if (isDefined(e_player))
			    e_player.GumWaiting = undefined;

            mdl_reward delete();

            wait 0.5;
		}
    }
}

TimeoutGum()
{
    self endon(#"death", #"stop_timeout_gum");

    wait 7;

    self notify(#"timeout_gum");
    wait 0.1;
    self notify(#"timeout_gum");
    wait 0.1;
    self notify(#"timeout_gum");
}

PlayCoolEffectsGum()
{
	self endon(#"death", #"stop_timeout_gum");

	while(level.GumIsWaiting)
	{
		playfx(level._effect[#"electric_cherry_explode"], self.origin);
		wait 2.25;
	}
}