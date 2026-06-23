// Queue system for powerup sounds
init_powerups_vo()
{
	level.soundQueue = [];
	level.isPlayingSound = false;
	level thread ProcessSoundQueue();
}

ProcessSoundQueue()
{
	level endon(#"end_game", #"game_ended");
	
	while(true)
	{
		if(level.soundQueue.size > 0 && !level.isPlayingSound)
		{
			level.isPlayingSound = true;
			soundData = level.soundQueue[0];
			level.soundQueue = array::remove_index(level.soundQueue, 0);
			
			ShieldPlay(false, false, soundData);
			wait 1.15; // Minimal delay between sounds
			
			level.isPlayingSound = false;
		}
		wait 0.05;
	}
}

AddToSoundQueue(sound)
{
	if(!isdefined(level.soundQueue))
	{
		level.soundQueue = [];
		level.isPlayingSound = false;
		level thread ProcessSoundQueue();
	}
	level.soundQueue[level.soundQueue.size] = sound;
}

/*
detour zm_powerups<scripts\zm_common\zm_powerups.gsc>::powerup_vo(type) {
	if(!GetDvarInt(#"shield_enh_CustomVO_Power_Crank", 0) && !GetDvarInt(#"shield_enh_CustomVO_Power_BO6", 0))
	{
		ShieldLog("^2Playing Normal VO: " + type);
		return [[ @zm_powerups<scripts\zm_common\zm_powerups.gsc>::powerup_vo ]](type);
	}

	if (type == "zombie_blood")
	 return [[ @zm_powerups<scripts\zm_common\zm_powerups.gsc>::powerup_vo ]](type);

	self endon(#"disconnect");
	if (!isplayer(self)) {
		return;
	}
	
	if(GetDvarInt(#"shield_enh_CustomVO_Power_Crank", 0) && GetDvarInt(#"shield_enh_CustomVO_Power_BO6", 0))
	{
		if (math::cointoss())
			self PlayCrankedPowerUp(type);
		else if (math::cointoss())
			self PlayBO6PowerUp(type);
	}
	else if (GetDvarInt(#"shield_enh_CustomVO_Power_Crank", 0) && math::cointoss())
	{
		self PlayCrankedPowerUp(type);
	}
	else if (GetDvarInt(#"shield_enh_CustomVO_Power_BO6", 0) && math::cointoss())
	{
		self PlayBO6PowerUp(type);
	}
	else
	{
		return [[ @zm_powerups<scripts\zm_common\zm_powerups.gsc>::powerup_vo ]](type);
	}
	
	if (isdefined(level.custom_powerup_vo_response)) {
		level [[ level.custom_powerup_vo_response ]](self, type);
	}
}
*/

detour zm_audio<scripts\zm_common\zm_audio.gsc>::sndannouncerplayvox(type, player, str_sound, var_e08a84d6, b_wait_if_busy = 0, var_92885147 = 0)
{
	//ShieldLog("snd called with " + type);

	if(!GetDvarInt(#"shield_enh_CustomVO_Power", 0))
	{
		return [[ @zm_audio<scripts\zm_common\zm_audio.gsc>::sndannouncerplayvox ]](type, player, str_sound, var_e08a84d6, b_wait_if_busy, var_92885147);
	}

	// Check if any custom VO options are enabled
	b_cranked_enabled = GetDvarInt(#"shield_enh_CustomVO_Power_Crank", 0);
	b_bo6_enabled = GetDvarInt(#"shield_enh_CustomVO_Power_BO6", 0);
	b_normal_enabled = GetDvarInt(#"shield_enh_CustomVO_Power_Normal", 0);

	if(!b_cranked_enabled && !b_bo6_enabled && !b_normal_enabled)
	{
		return [[ @zm_audio<scripts\zm_common\zm_audio.gsc>::sndannouncerplayvox ]](type, player, str_sound, var_e08a84d6, b_wait_if_busy, var_92885147);
	}

	// Check if type is a powerup we want to handle
	powerup_types = array("bonus_points_team", "free_perk", "hero_weapon_power", "bonus_points_player", "full_power", "insta_kill", "double_points", "firesale", "fire_sale", /*#"hash_6080366ece401431",*/ "bonfiresale", "full_ammo", "nuke", "carpenter", "bonus");
	
	if(!isinarray(powerup_types, type))
	{
		return [[ @zm_audio<scripts\zm_common\zm_audio.gsc>::sndannouncerplayvox ]](type, player, str_sound, var_e08a84d6, b_wait_if_busy, var_92885147);
	}

	// Count enabled options for weighted selection
	enabled_options = array();
	if(b_cranked_enabled) enabled_options[enabled_options.size] = "cranked";
	if(b_bo6_enabled) enabled_options[enabled_options.size] = "bo6";
	if(b_normal_enabled) enabled_options[enabled_options.size] = "normal";

	if(enabled_options.size == 0)
	{
		return [[ @zm_audio<scripts\zm_common\zm_audio.gsc>::sndannouncerplayvox ]](type, player, str_sound, var_e08a84d6, b_wait_if_busy, var_92885147);
	}

	// Random selection from enabled options
	selected_option = enabled_options[randomInt(enabled_options.size)];

	switch(selected_option)
	{
		case "cranked":
			self PlayCrankedPowerUp(type);
			break;
		case "bo6":
			self PlayBO6PowerUp(type);
			break;
		case "normal":
		default:
			return [[ @zm_audio<scripts\zm_common\zm_audio.gsc>::sndannouncerplayvox ]](type, player, str_sound, var_e08a84d6, b_wait_if_busy, var_92885147);
	}
}
 
/*
detour zm_powerup_free_perk<scripts\zm\powerup\zm_powerup_free_perk.gsc>::grab_free_perk(var_a3878cd) {
	b_played_vo = false;

	if(GetDvarInt(#"shield_enh_CustomVO_Power_Crank", 0) && GetDvarInt(#"shield_enh_CustomVO_Power_BO6", 0))
	{
		if (math::cointoss())
		{
			self PlayCrankedPowerUp("free_perk");
			b_played_vo = true;
		}
		else if (math::cointoss())
		{
			self PlayBO6PowerUp("free_perk");
			b_played_vo = true;
		}
	}
	else if (GetDvarInt(#"shield_enh_CustomVO_Power_Crank", 0) && math::cointoss())
	{
		self PlayCrankedPowerUp("free_perk");
		b_played_vo = true;
	}
	else if (GetDvarInt(#"shield_enh_CustomVO_Power_BO6", 0) && math::cointoss())
	{
		self PlayBO6PowerUp("free_perk");
		b_played_vo = true;
	}
	
	return [[ @zm_powerup_free_perk<scripts\zm\powerup\zm_powerup_free_perk.gsc>::grab_free_perk ]](var_a3878cd);
}
*/

/*
detour zm_powerup_hero_weapon_power<scripts\zm\powerup\zm_powerup_hero_weapon_power.gsc>::hero_weapon_power(e_player) {
	b_played_vo = false;

	if(GetDvarInt(#"shield_enh_CustomVO_Power_Crank", 0) && GetDvarInt(#"shield_enh_CustomVO_Power_BO6", 0))
	{
		if (math::cointoss())
		{
			self PlayCrankedPowerUp("full_power");
			b_played_vo = true;
		}
		else if (math::cointoss())
		{
			self PlayBO6PowerUp("full_power");
			b_played_vo = true;
		}
	}
	else if (GetDvarInt(#"shield_enh_CustomVO_Power_Crank", 0) && math::cointoss())
	{
		self PlayCrankedPowerUp("full_power");
		b_played_vo = true;
	}
	else if (GetDvarInt(#"shield_enh_CustomVO_Power_BO6", 0) && math::cointoss())
	{
		self PlayBO6PowerUp("full_power");
		b_played_vo = true;
	}
	
	return [[ @zm_powerup_hero_weapon_power<scripts\zm\powerup\zm_powerup_hero_weapon_power.gsc>::hero_weapon_power ]](e_player);
}
*/

PlayCrankedPowerUp(type)
{
	ShieldLog("^2Team Cranked: Powerup Collected: " + type);

	switch(type)
	{
		case "insta_kill":
			AddToSoundQueue(7);
			break;

		case "double_points":
			AddToSoundQueue(8);
			break;

		case "firesale":
		case "bonfiresale":
			AddToSoundQueue(9);
			break;

		case "full_ammo":
			AddToSoundQueue(10);
			break;
			
		case "nuke":
			AddToSoundQueue(11);
			break;

		case "carpenter":
			AddToSoundQueue(12);
			break;

		case "bonus":
		case "bonus_points_player":
		case "bonus_points_team":
			AddToSoundQueue(13);
			break;

		case "free_perk":
			AddToSoundQueue(14);
			break;

		case "full_power":
		case "hero_weapon_power":
			AddToSoundQueue(15);
			break;
	}
}

PlayBO6PowerUp(type)
{
	ShieldLog("^2BO6: Powerup Collected: " + type);

	switch(type)
	{
		case "insta_kill":
			AddToSoundQueue(80);
			break;

		case "double_points":
			AddToSoundQueue(81);
			break;

		case "firesale":
		case "fire_sale":
		case "bonfiresale":
			AddToSoundQueue(82);
			break;

		case "full_ammo":
			AddToSoundQueue(83);
			break;
			
		case "nuke":
			AddToSoundQueue(84);
			break;

		case "carpenter":
			AddToSoundQueue(85);
			break;

		case "bonus":
		case "bonus_points_player":
		case "bonus_points_team":
			AddToSoundQueue(86);
			break;

		case "free_perk":
			AddToSoundQueue(87);
			break;

		case "full_power":
		case "hero_weapon_power":
			AddToSoundQueue(88);
			break;
	}
}

TeamCranked()
{
	level thread init_powerups_vo();

	if(!GetDvarInt(#"shield_enh_TeamCranked", 0))
	{
		return;
	} 

	ShieldLog("^2Team Cranked Enabled!");

	// turn on vos for cranked, other options don't care
	setDvar(#"shield_enh_CustomVO_Power", 1);
	setDvar(#"shield_enh_CustomVO_Power_Crank", 1);

	// will decrease as the round goes
	level.teamCrankedTimer = 75;
	level.stopCrankedTimer = false;

	level thread TeamCranked_Timer();
	level thread TeamCranked_RoundWatcher();
	level thread TeamCranked_ZombieKillWatcher();
	level thread TeamCranked_RoundEnder();
	level thread TeamCranked_DoubleWatcher();

	zm_powerups::register_powerup("custom_pizza", &PickPizzaPowerup);
    zm_powerups::add_zombie_powerup("custom_pizza", "p8_zm_powerup_rush_point", #"zombie/powerup_minigun", &func_should_never_drop_custom, 0, 0, 0);
}

func_should_never_drop_custom(var_arg)
{
	return false;
}

PickPizzaPowerup(player)
{
	// gotta thread
	level thread PizzaIncreaseTime();
	level thread PizzaPlayVoice();
}

PizzaIncreaseTime()
{
	level.stopCrankedTimer = true;
	wait 0.03;
	result = GetTeamCrankedTimerForRoundPlus(zm_round_logic::get_round_number(), true);
	result += level.teamCrankedTimer;
	result = min(result, GetTeamCrankedTimerForRound(zm_round_logic::get_round_number())); // cap at max time for round
	wait 0.03;
	level.teamCrankedTimer = result;
	level.stopCrankedTimer = false;
}

PizzaPlayVoice()
{
	wait 0.5;

	pizza_line = randomIntRange(1, 9) + 21;
	AddToSoundQueue(pizza_line);
}

TeamCranked_RoundEnder()
{
	level endon(#"end_game", #"game_ended", #"stop_zombie_round_ender");

	level flag::wait_till("all_players_spawned");
	level flag::wait_till("initial_blackscreen_passed");

	wait 2.5;

	// ignore first round
	level waittill(#"between_round_over");

	wait 20;

	ShieldLog("^3Team Cranked: Starting Round Ender!");

	while(true)
	{
		level.zombie_vars["zombie_spawn_delay"] = 0; // zombies delay remove 0
		zombie_utility::set_zombie_var(#"zombie_spawn_delay", 0);

		level.zombie_vars["zombie_between_round_time"] = 3;
		zombie_utility::set_zombie_var(#"zombie_between_round_time", 3);

		zombies = GetAITeamArray(level.zombie_team);
		total = max(1, zombies.size + zm_round_logic::get_zombie_count_for_round(level.round_number, level.players.size));
		active_count = 0;

		foreach(zombie in zombies)
		{
			if(isdefined(zombie) && (!isdefined(zombie.ignore_enemy_count) || !zombie.ignore_enemy_count))
			{
				active_count++;
			}
		}

		// skip if the remaining zombies are 0
		percentage = total > 0 ? (active_count / total) : 0;
		//ShieldLog("^3Team Cranked: Active Zombies: " + active_count + " / " + total + " (" + int(percentage * 100) + "%)");

		// Skip if below 15%
		if (percentage <= 0.15)
		{
			level notify(#"round_ending");
			level thread TeamCranked_SkipRound();
			level waittill(#"round_skipped");
		}

		wait 0.5;
	}
}

TeamCranked_SkipRound()
{
	//ShieldLog("^3Team Cranked: Skipping Round!");

	level notify(#"kill_round");
    level notify(#"kill_round_wait");

	wait 5;

	level waittilltimeout(30, #"between_round_over");

	wait 15;

	level notify(#"round_skipped");
}

TeamCranked_RoundWatcher()
{
	level endon(#"end_game", #"game_ended");

	level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

	wait 2.5;

	while(true)
	{
		level waittill(#"end_of_round");

		level.stopCrankedTimer = true;
		wait 0.5;
		level.teamCrankedTimer = GetTeamCrankedTimerForRound(zm_round_logic::get_round_number());
		wait 5;
		level.stopCrankedTimer = false;

		level thread PlayRandomYap();

		zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", 16);
	}
}

// zm vo talks when rounds ends?
PlayRandomYap()
{
	if (randomIntRange(0, 100) >= 25)
	{
		return;
	}

	wait 1.5;

	// from 1-6 (+15)
	choice = randomIntRange(1, 7) + 15;

	AddToSoundQueue(choice);
}

GetTeamCrankedTimerForRound(roundNum)
{
	return max(6, 75 - (roundNum - 1) * 5); // min 6 seconds, starts at 75 and decreases by 5 each round
}

GetTeamCrankedTimerForRoundPlus(roundNum, pizza_powerup = false)
{
	if (!pizza_powerup)
	{
		if(roundNum <= 5)
		{
			return 10;
		}
		else if(roundNum <= 15)
		{
			return 5;
		}
		else
		{
			return 3;
		}
	}
	else
	{
		if(roundNum <= 5)
		{
			return 15;
		}
		else if(roundNum <= 15)
		{
			return 10;
		}
		else
		{
			return 5;
		}
	}
}

TeamCranked_ZombieKillWatcher()
{
	level endon(#"end_game", #"game_ended");

	level flag::wait_till("all_players_spawned");
	level flag::wait_till("initial_blackscreen_passed");

	callback::on_ai_killed(&Cranked_AIKilled);

	wait 2.5;

	while(true)
	{
		level waittill(#"zombie_killed");

		level.stopCrankedTimer = true;
		wait 0.03;
		result = GetTeamCrankedTimerForRoundPlus(zm_round_logic::get_round_number());
		result += level.teamCrankedTimer;
		result = min(result, GetTeamCrankedTimerForRound(zm_round_logic::get_round_number())); // cap at max time for round
		wait 0.03;
		level.teamCrankedTimer = result;
		level.stopCrankedTimer = false;
	}
}

TeamCranked_DoubleWatcher()
{
	level endon(#"end_game", #"game_ended");

	level flag::wait_till("all_players_spawned");
	level flag::wait_till("initial_blackscreen_passed");

	wait 2.5;

	while(true)
	{
		if (zm_powerups::function_cfd04802(#"double_points"))
			zombie_utility::set_zombie_var_team(#"zombie_point_scalar", GetPlayers()[0].team, 3);
		else
			zombie_utility::set_zombie_var_team(#"zombie_point_scalar", GetPlayers()[0].team, 2);

		wait 0.5;
	}
}

Cranked_AIKilled(s_params) {
	self endon(#"death");
	
    if (isplayer(s_params.eattacker)) {
        level notify(#"zombie_killed");

		if (randomIntRange(0, 100) < 5) {
			e_powerup = zm_powerups::specific_powerup_drop("custom_pizza", self.origin, undefined, 0.1, s_params.eattacker, 0, 1, 1);
			if (isdefined(e_powerup)) {
				e_powerup setscale(0.85);

				e_powerup clientfield::set("powerup_fx", 4);
			}
		}
    }
}

TimerShouldGo()
{
	// based on flags liek spawn_zombies or whatever?
	if (!level flag::get(#"spawn_zombies") || isDefined(level.PracticeModeActive))
	{
		return false;
	}

	// cutscenes
	foreach(player in level.players)
	{
		if (player scene::is_igc_active())
		{
			return false;
		}
	}

	return true;
}

TeamCranked_Timer()
{
	level endon(#"end_game", #"game_ended");

	level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

	// activate hud
	foreach(player in level.players)
		player LUINotifyEvent(#"enh_team_cranked", 1, 0);

	wait 5;

	// play a voice saying cranked or something like bo6.
	ShieldPlay(false, false, 6);

	foreach(player in level.players)
		player LUINotifyEvent(#"enh_team_cranked", 1, 99);

	while(true)
	{
		wait 0.01;

		// dont update timer if paused
		if (level.stopCrankedTimer || !TimerShouldGo())
		{
			continue;
		}

		level.teamCrankedTimer -= 0.05;

		if(level.teamCrankedTimer <= 0)
		{
			level thread TeamCranked_Timeout();
			return;
		}
		else
		{
			max_time = GetTeamCrankedTimerForRound(zm_round_logic::get_round_number());
			foreach(player in level.players) player LUINotifyEvent(#"enh_team_cranked", 2, ConvertNumToLUI(level.teamCrankedTimer), ConvertNumToLUI(max_time));
		}
	}
}

TeamCranked_Timeout()
{
	foreach(player in level.players)
	{
		if(isAlive(player))
		{
			player doDamage(player.maxhealth + 100, player.origin, undefined);

			// explode
			for (i = 0; i < 5; i++)
			{
				player SendWeaponMagic("launcher_standard_t8", player, (0, 0, 0), player, true);
			}
		}
	}

	level notify(#"end_game");
}