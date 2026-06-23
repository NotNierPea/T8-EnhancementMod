// THIS HAS BEEN REMOVED SINCE ITS GARBAGE!
VariatorsInit()
{
	//if(GetDvarInt(#"shield_enh_Variators", 0)) 
     //thread Variators();

	 return; // not finished
}

Variators()
{
	ShieldLog("^1Variators Init...");

	Variators = array("stay_together", "1hp", "ultra", "extra_zombies", "stronger_zombies", "enraged_zombies", "expensive_doors", "afraid",
	"damage_restarts_specialist", "no_player_names", "specialist_extended_cooldown", "limited_specialist", "no_specialist_upgrades", "no_specialists"
	,"exlixirs_extended_cooldown", "no_elixirs", "bleeding_damage", "no_selfres", "rampage_rounds");

	TryVariators = array::randomize(Variators);

	VariatorsAmount = randomIntRange(3, 8);

	for (i = 0; i < VariatorsAmount; i++)
	{
		level.ChosenVariators[i] = TryVariators[i];
	}

	SetupVariators();

	SendVariatorsToLUI();
}

SendVariatorsToLUI()
{
	if(!GetDvarInt(#"shield_enh_Variators", 0)) 
     return;

	level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

	wait 2.5;

	//foreach(vari in level.ChosenVariators)
		//GetPlayers()[0] iPrintLnBold("Chosen Var -> " + vari);

	//return; // not done yet

	// send to lua, and display chosen variators
	foreach(player in level.players)
	{
		thread PlayerToLUI(player);
	}
}

PlayerToLUI(player)
{
	for (i = 0; i < level.ChosenVariators.size; i++)
	{
		var_id = 0;

		switch(level.ChosenVariators[i])
		{
			case "stay_together":
			var_id = 1;
			break;

			case "1hp":
			var_id = 2;
			break;

			case "ultra":
			var_id = 3;
			break;

			case "extra_zombies":
			var_id = 4;
			break;

			case "stronger_zombies":
			var_id = 5;
			break;

			case "enraged_zombies":
			var_id = 6;
			break;

			case "expensive_doors":
			var_id = 7;
			break;

			case "afraid":
			var_id = 8;
			break;

			case "damage_restarts_specialist":
			var_id = 9;
			break;

			case "no_player_names":
			var_id = 10;
			break;

			case "specialist_extended_cooldown":
			var_id = 11;
			break;

			case "limited_specialist":
			var_id = 12;
			break;

			case "no_specialist_upgrades":
			var_id = 13;
			break;

			case "no_specialists":
			var_id = 14;
			break;

			case "exlixirs_extended_cooldown":
			var_id = 15;
			break;
			
			case "no_elixirs":
			var_id = 16;
			break;

			case "bleeding_damage":
			var_id = 17;
			break;

			case "no_selfres":
			var_id = 18;
			break;

			case "rampage_rounds":
			var_id = 19;
			break;

			default:
			ShieldLog("^1Missing Variator Check for UI/LUA " + level.ChosenVariators[i] + "!!!");
			break;
		}

		// fuck lua
		amount = level.ChosenVariators.size;
		index = i + 1;

		player LUINotifyEvent(#"enhancement_variators", 4, 1, index, var_id, amount);

		// wait a lil to display the other one lol
		wait 1.45;
	}

	wait 2.5;

	player LUINotifyEvent(#"enhancement_variators", 3, 0, 0, 0);
}

SetupVariators()
{
	for (i = 0; i < level.ChosenVariators.size; i++)
	{
		ShieldLog("^2Here we go -> " + level.ChosenVariators[i]);

		switch(level.ChosenVariators[i])
		{
			case "stay_together":
			thread Variator_STAYTOGETHER();
			break;

			case "1hp":
			thread Variator_1HP();
			break;

			case "ultra":
			thread Variator_ULTRA();
			break;

			case "extra_zombies":
			thread Variator_EXTRA_ZOMBIES();
			break;

			case "stronger_zombies":
			thread Variator_STRONGER_ZOMBIES();
			break;

			case "enraged_zombies":
			thread Variator_ENRAGED_ZOMBIES();
			break;

			case "expensive_doors":
			thread Variator_EXPENSIVE_DOORS();
			break;

			case "afraid":
			thread Variator_NO_CLASS();
			break;

			case "damage_restarts_specialist":
			thread Variator_DAMAGE_RESTARTS_SPEC();
			break;

			case "no_player_names":
			thread Variator_NO_PLAYER_NAMES();
			break;

			case "specialist_extended_cooldown":
			thread Variator_EXTENDED_SPEC();
			break;

			case "limited_specialist":
			thread Variator_LIMITED_SPEC();
			break;

			case "no_specialist_upgrades":
			thread Variator_NO_SPEC_UPGRADES();
			break;

			case "no_specialists":
			thread Variator_NO_SPECS();
			break;

			case "exlixirs_extended_cooldown":
			thread Variator_EXTENDED_ELIXIRS();
			break;
			
			case "no_elixirs":
			thread Variator_NO_ELIXIRS();
			break;

			case "bleeding_damage":
			thread Variator_BLEEDING_DAMAGE();
			break;

			case "no_selfres":
			thread Variator_NO_SELFRES();
			break;

			case "rampage_rounds":
			thread Variator_RAMPAGE_ROUNDS();
			break;

			default:
			ShieldLog("^1Missing Variator Check " + level.ChosenVariators[i] + "!!!");
			break;
		}
	}

	thread VariatorsDebugging();
}

VariatorsDebugging()
{

}

Variator_1HP()
{
	level flagsys::wait_till(#"zombie_vars_init");
    zombie_utility::set_zombie_var(#"player_base_health", 1);
}

Variator_ULTRA()
{
	setgametypesetting(#"zmdifficulty", 3);
}

Variator_ENRAGED_ZOMBIES()
{
	setgametypesetting(#"zmzombieminspeed",2);
    setgametypesetting(#"zmzombiemaxspeed ",3);
}

Variator_EXTRA_ZOMBIES()
{
	level flagsys::wait_till(#"zombie_vars_init");

	TryCount = zombie_utility::get_zombie_var(#"zombie_ai_per_player");

	zombie_utility::set_zombie_var(#"zombie_ai_per_player", TryCount * 7);
}

Variator_STRONGER_ZOMBIES()
{
	level flagsys::wait_till(#"zombie_vars_init");

	TryCountInc = zombie_utility::get_zombie_var(#"zombie_health_increase");
	TryCountMult = zombie_utility::get_zombie_var(#"zombie_health_increase_multiplier");

	zombie_utility::set_zombie_var(#"zombie_health_increase", TryCountInc * 25);
    zombie_utility::set_zombie_var(#"zombie_health_increase_multiplier", TryCountMult * 25);
}

Variator_STAYTOGETHER()
{
	level endon("end_game");
	level endon("game_ended");

	level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

	while (true)
	{
		players = GetPlayers();

		if (players.size <= 1)
		{
			ShieldLog("^1Stay Together stopped due to player count.");
			break;
		}

		for (i = 0; i < players.size; i++)
		{
			player = players[i];
			isCloseToAnyone = false;

			for (j = 0; j < players.size; j++)
			{
				if (i == j) continue;

				other = players[j];

				if (distanceSquared(player.origin, other.origin) <= 250500)
				{
					isCloseToAnyone = true;
					break;
				}
			}

			if (!isCloseToAnyone)
			{
				player dodamage(50, player.origin + (0, 0, 20));
				player playsound(#"zmb_bgb_popshocks_impact");

				player iPrintLn("^1You are too far from your teammates!");
			}
		}

		wait 3;
	}
}

Variator_EXPENSIVE_DOORS()
{
	level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

	a_door_buys = getentarray("zombie_door", "targetname");
	array::thread_all(a_door_buys, &Door_Price_Inrease, 1500);
	a_debris_buys = getentarray("zombie_debris", "targetname");
	array::thread_all(a_debris_buys, &Door_Price_Inrease, 1500);
}

Door_Price_Inrease(price) {
	self.zombie_cost += price;
	if (isdefined(level.var_d0b54199)) {
		self thread [[ level.var_d0b54199 ]](self, self.zombie_cost);
		return;
	}
	if (self.targetname == "zombie_door") {
		self zm_utility::set_hint_string(self, "default_buy_door", self.zombie_cost);
		return;
	}
	self zm_utility::set_hint_string(self, "default_buy_debris", self.zombie_cost);
}

Variator_NO_SELFRES()
{
	level flagsys::wait_till(#"zombie_vars_init");

	zombie_utility::set_zombie_var(#"hash_67ae1b8cbb7c985", 0);
}

Variator_RAMPAGE_ROUNDS()
{
	// already enabled anyways???
	if(GetDvarInt(#"shield_enh_RampageMode", 0)) 
		return;

    Setup_RampageMode_Var();
}

Setup_RampageMode_Var()
{
    level endon(#"end_game", #"game_ended");
    
    //SetGametypeSetting(#"zmzombieminspeed",2);
    //SetGametypeSetting(#"zmzombiemaxspeed ",3);
    
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

    // stop overiding them
    while(true)
    {
        level.disable_nuke_delay_spawning = 1;
        level.zombie_round_start_delay = 0;

        level.zombie_vars["zombie_spawn_delay"] = 0; // zombies delay remove 0
        level.zombie_vars["zombie_between_round_time"] = 0; // 3

        zombie_utility::set_zombie_var(#"zombie_spawn_delay", 0);
        zombie_utility::set_zombie_var(#"zombie_between_round_time", 0);

        wait 360;
    }
}

Variator_NO_CLASS()
{
	SetGametypeSetting(#"zmstartingweaponenabled", 0);

	level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

	foreach(player in level.players)
	{
		player.bgb_pack[0] = "zm_bgb_arsenal_accelerator";
		player.bgb_pack[1] = "zm_bgb_equip_mint";
		player.bgb_pack[2] = "zm_bgb_anywhere_but_here";
		player.bgb_pack[3] = "zm_bgb_always_done_swiftly";
		for (i = 0; i < 4; i++) {
			if (isdefined(player.bgb_pack[i]) && isdefined(level.bgb[player.bgb_pack[i]])) {
				player bgb_pack::function_7b91e81c(i, level.bgb[player.bgb_pack[i]].item_index);
			}
		}

		player zm_weapons::weapon_give(getweapon(#"eq_frag_grenade"));
		player zm_loadout::set_player_lethal_grenade(getweapon(#"eq_frag_grenade"));
	}
}

Variator_BLEEDING_DAMAGE()
{
	callback::on_player_damage(&on_bleeding_damage);
}

on_bleeding_damage(params)
{
	self endon("death");
	self endon("disconnect");

	if (!(isdefined(self.is_bleeding) && self.is_bleeding) && !self laststand::player_is_in_laststand() && self.health <= 5)
	{
		self.is_bleeding = true;

		for (i = 0; i < 6; i++)
		{
			self dodamage(5, self.origin);
			wait 0.8;
		}

		self.is_bleeding = undefined;
	}
}

Variator_NO_ELIXIRS()
{
	setgametypesetting(#"zmelixirsenabled", 0);
}

Variator_EXTENDED_ELIXIRS()
{
	setgametypesetting(#"zmelixirscooldown", 0);
}

Variator_NO_SPECS()
{
	setgametypesetting(#"zmspecweaponisenabled", 0);
}

Variator_NO_SPEC_UPGRADES()
{
	callback::on_spawned(&No_Spec_Upgrades);
}

No_Spec_Upgrades()
{
	self endon("death");
	self endon("disconnect");

	while(true)
	{
		self.var_821c9bf3 = 0;
        self.var_41183060 = 0;

		wait 3;
	}
}

Limited_Spec()
{
	self endon("death");
	self endon("disconnect");

	while(true)
	{
		self gadgetpowerset(level.var_a53a05b5, 100);

		// stop charge
		level.var_a1feaa28 = 0.0001;

		level waittill(#"between_round_over");
	}
}

Variator_LIMITED_SPEC()
{
	callback::on_spawned(&Limited_Spec);
}

Variator_EXTENDED_SPEC()
{
	level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

	level.var_a1feaa28 = 0.3;
}

Variator_NO_PLAYER_NAMES()
{

}

Variator_DAMAGE_RESTARTS_SPEC()
{
	callback::on_player_damage(&on_spec_damage);
}

on_spec_damage(params)
{
	self endon("death");
	self endon("disconnect");

	if (params.idamage >= 50)
	{
		self gadgetpowerset(level.var_a53a05b5, 0);
	}
}