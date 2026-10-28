ConvertNumToLUI(num)
{
    return Int(num * 100);
}

add_new_objective(objective, str_waittill)
{
	self endon(#"death");

	self.n_obj_id = gameobjects::get_next_obj_id();
	if (Objective_State(self.n_obj_id) == "empty") {
		//ShieldLog("Registering Objective ID: " + self.n_obj_id);
		Objective_Add(self.n_obj_id, "active", self, objective);
	}
	else {
		//ShieldLog("Re-configuring Objective ID: " + self.n_obj_id);
		Objective_OnEntity(self.n_obj_id, self);
		Objective_SetState(self.n_obj_id, "active");
	}
	function_da7940a3(self.n_obj_id, 1);
	self thread release_obj_on_death_v(str_waittill);
}

release_obj_on_death_v(str_waittill = #"nothing")
{
    self util::waittill_any_ents(self, "death", level, "release_objs", self, str_waittill);

	if (isDefined(self))
	{
		n_obj_id = self.n_obj_id;

		//ShieldLog("Releasing Objective ID: " + n_obj_id);
		gameobjects::release_obj_id(n_obj_id);
		Objective_SetState(n_obj_id, "invisible");

		arrayremovevalue(level.VultureObjects, self);

		self.n_obj_id = undefined;
	}
}

CustomObjectiveTest()
{
    level.GumMachine add_new_objective(#"enh_objective", "death");
}

TestShit()
{
	//e_powerup = zm_powerups::specific_powerup_drop("bonfire_sale", self.origin, undefined, 0.1, self, 0, 1, 1);

	//SpawnTestCube(self);
	//SpawnTestTruss(self);
	//SpawnTestCactus(self);
	//SpawnTestLodSphere(self);
	//level thread SpawnTestCrate(self);
	//level thread SpawnTestBall(self);
	//level thread SpawnTestDumbbell(self);
	//SpawnTestMaterials(self);
	//SpawnTestWiggle(self);
	SpawnTestMannequin(self);
	level thread TestAsrSounds(self);
}

/*
    Intro, loop and outro sounds (enh_sounds.json): the intro plays once, the loop until the sound is stopped, then the
    outro. enh_test_asr (3 files: a rising chirp, a 600 Hz hum, a falling chirp) with playsound / stopsounds,
    enh_test_asr_cut (one file cut at loopStart / loopEnd) with playloopsound / stoploopsound. 150 units ahead.
*/
TestAsrSounds(player)
{
    yaw = (0, player.angles[1], 0);
    speaker = spawn("script_origin", player.origin + AnglesToForward(yaw) * 150 + (0, 0, 40));
    speaker endon(#"death");
    for (i = 0; i < 3; i++)
    {
        wait 3;
        speaker playsound(#"enh_test_asr");
        ShieldLog("^6enh_test_asr started (intro, then the loop)");
        wait 2 + i;
        speaker stopsounds();
        ShieldLog("^6enh_test_asr stopped (the outro)");
    }
    for (i = 0; i < 2; i++)
    {
        wait 3;
        speaker playloopsound(#"enh_test_asr_cut");
        ShieldLog("^6enh_test_asr_cut started (intro, then the loop)");
        wait 4;
        speaker stoploopsound();
        ShieldLog("^6enh_test_asr_cut stopped (the outro)");
    }
}

/*
    A model on a game skeleton (enh_mannequin: the bones of a zm_common body, skeletons/zm_body.json) plays the game's
    anims. Three mannequins in front of the player on zm_common anims (enh_anims.json): a walk loop with root motion and
    footsteps, a short loop, an action; each loop restarts at its spot. Then the zombies wear it (dvar
    enh_mannequin_zombies, 1 by default) and should walk and attack as usual.
*/
SpawnTestMannequin(player)
{
    yaw = (0, player.angles[1], 0);
    names = array(#"hash_446d13b87621a4b5", #"hash_48aae5cdff0a155f", #"hash_18ae694c332864f");
    labels = array("stock walk", "stock loop", "stock action");
    for (i = 0; i < 3; i++)
    {
        home = player.origin + AnglesToForward(yaw) * 120 + AnglesToRight(yaw) * (i - 1) * 60;
        man = spawn("script_model", home);
        man.angles = yaw;
        man setmodel(#"enh_mannequin");
        man useanimtree("generic");
        ShieldLog("^6enh_mannequin spawned at " + man.origin + " for " + labels[i]);
        man thread PlayMannequin(names[i], labels[i], home, yaw);
        man thread LogWiggleNotetracks(names[i], labels[i]);
    }
    // behind them, our anim made in blender on the same skeleton (enh_mannequin_wave: the left arm waves, the head nods)
    home = player.origin + AnglesToForward(yaw) * 200;
    man = spawn("script_model", home);
    man.angles = yaw;
    man setmodel(#"enh_mannequin");
    man useanimtree("generic");
    man thread PlayMannequin(#"enh_mannequin_wave", "custom wave", home, yaw);
    man thread LogWiggleNotetracks(#"enh_mannequin_wave", "custom wave");
    level thread MannequinZombies();
}

// the anim from its spot each time (root motion walks it away), its bones once posed
PlayMannequin(xanim, label, home, yaw)
{
    self endon(#"death");
    for (loops = 0; loops < 1000; loops++)
    {
        self.origin = home;
        self.angles = yaw;
        self animscripted(xanim, home, yaw, xanim, "normal", undefined, 1, 0.2);
        if (loops == 0)
        {
            wait 0.5;
            foreach(bone in array("j_mainroot", "j_spine4", "j_head", "j_wrist_le", "j_ankle_ri"))
            {
                ShieldLog("^6" + label + " " + bone + " at " + (self gettagorigin(bone) - self.origin));
            }
        }
        self waittillmatch({#notetrack:"end"}, xanim);
        if (loops < 2)
        {
            ShieldLog("^6" + label + " ended, the entity at " + self.origin);
        }
    }
}

// the zombies wear the mannequin: their own animtree and anims on its bones
MannequinZombies()
{
    level endon(#"end_game");
    if (getdvarint(#"enh_mannequin_zombies", 1) == 0)
    {
        return;
    }
    count = 0;
    for (;;)
    {
        foreach(zombie in getaiteamarray(level.zombie_team))
        {
            if (isdefined(zombie.enh_mannequin) || !isalive(zombie))
            {
                continue;
            }
            zombie.enh_mannequin = 1;
            zombie detachall();
            zombie setmodel(#"enh_mannequin");
            if (count < 3)
            {
                ShieldLog("^6zombie " + zombie getentitynumber() + " wears enh_mannequin");
            }
            count++;
        }
        wait 0.5;
    }
}

/*
    Skinned models and xanims (enh.ff, models/enh_wiggle.gltf), three columns in front of the player: the loop (a sound
    notetrack enh_test_3d on j_seg3 at 0.25, wiggle_half), the same loop in 301 frames (enh_wiggle_long) and a walk with
    root motion (enh_wiggle_walk: tag_origin moves 100 forward, turns 90 degrees, the entity should follow). The bullets
    hit each segment where it is, the players the column at rest.
*/
SpawnTestWiggle(player)
{
    yaw = (0, player.angles[1], 0);
    names = array(#"enh_wiggle_loop", #"enh_wiggle_long", #"enh_wiggle_walk");
    labels = array("enh_wiggle_loop", "enh_wiggle_long", "enh_wiggle_walk");
    for (i = 0; i < 3; i++)
    {
        wiggle = spawn("script_model", player.origin + AnglesToForward(yaw) * 100 + AnglesToRight(yaw) * (i - 1) * 60);
        wiggle.angles = yaw;
        wiggle setmodel(#"enh_wiggle");
        wiggle useanimtree("generic");
        ShieldLog("^6enh_wiggle spawned at " + wiggle.origin + " for " + labels[i]);
        wiggle thread PlayWiggle(names[i], labels[i]);
        wiggle thread LogWiggleNotetracks(names[i], labels[i]);
    }
}

/*
    The anims of an animtree are the ones the scripts and the loaded scriptbundles name (enh.ff's
    scriptbundle/default/enh_anims.json). The bones at rest first: j_seg1 0, j_seg2 20, j_seg3 40 up.
*/
PlayWiggle(xanim, label)
{
    self endon(#"death");
    wait 0.5;
    foreach(bone in array("tag_origin", "j_seg1", "j_seg2", "j_seg3"))
    {
        ShieldLog("^6" + label + " " + bone + " at " + (self gettagorigin(bone) - self.origin));
    }
    for (loops = 0; loops < 1000; loops++)
    {
        self animscripted(xanim, self.origin, self.angles, xanim, "normal", undefined, 1, 0);
        self waittillmatch({#notetrack:"end"}, xanim);
        if (loops < 3)
        {
            ShieldLog("^6" + label + " ended, the entity at " + self.origin + " angles " + self.angles);
        }
    }
}

// the notetracks as they fire (the first loops); anim is the global anim struct in gsc, not a usable name
LogWiggleNotetracks(xanim, label)
{
    self endon(#"death");
    for (i = 0; i < 12; i++)
    {
        s_result = self waittill(xanim);
        ShieldLog("^6" + label + " notetrack " + s_result.notetrack);
    }
}

// material options (enh.ff): a glowing cube on the left, a see-through one on the right, behind the test cube
SpawnTestMaterials(player)
{
    yaw = (0, player.angles[1], 0);
    glow = spawn("script_model", player.origin + AnglesToForward(yaw) * 160 - AnglesToRight(yaw) * 60);
    glow.angles = yaw;
    glow setmodel(#"enh_cube_glow");
    glass = spawn("script_model", player.origin + AnglesToForward(yaw) * 160 + AnglesToRight(yaw) * 60);
    glass.angles = yaw;
    glass setmodel(#"enh_cube_glass");
    ShieldLog("^6enh_cube_glow and enh_cube_glass spawned");
}

// lods (enh.ff): teddy close, rust further, green far, walk away from it to see them switch
SpawnTestLodSphere(player)
{
    yaw = (0, player.angles[1], 0);
    sphere = spawn("script_model", player.origin + AnglesToForward(yaw) * 220);
    sphere.angles = yaw;
    sphere setmodel(#"enh_lodsphere");
    sphere disconnectpaths();

    ShieldLog("^6enh_lodsphere spawned at " + sphere.origin);
}

// two materials and a physics prop (enh.ff): the crate drops in front of the player, then gets thrown up
SpawnTestCrate(player)
{
    yaw = (0, player.angles[1], 0);
    crate = spawn("script_model", player.origin + AnglesToForward(yaw) * 150 + AnglesToRight(yaw) * 200 + (0, 0, 60));
    crate.angles = yaw;
    crate setmodel(#"enh_crate");
    ShieldLog("^6enh_crate spawned at " + crate.origin);

    wait 1;
    crate physicslaunch(crate.origin, (0, 0, 1));
    ShieldLog("^6enh_crate physicslaunch");
    wait 6;
    crate physicslaunch(crate.origin + (5, 0, 20), (0, 0, 250));
    ShieldLog("^6enh_crate thrown");
}

/*
    Physics props: the first physicslaunch makes the physics object, on the server and the client each (an impulse at
    the point). A later one goes through the client's bullet impact (force * bulletForceScale of the preset, 0 for the
    game's default one). So one launch at spawn, the force from dvars (the game's scripts use 1 to wake a prop, 3 to 13
    for a hop), and PushOnShots after.
*/

// the ground under a point
GroundBelow(pos)
{
    return bullettrace(pos + (0, 0, 64), pos - (0, 0, 256), false, undefined)["position"];
}

// convex hull collision (enh.ff): the ball on the ground on the player's left, pushed at its top so it rolls away
SpawnTestBall(player)
{
    yaw = (0, player.angles[1], 0);
    ball = spawn("script_model", GroundBelow(player.origin + AnglesToForward(yaw) * 150 - AnglesToRight(yaw) * 200) + (0, 0, 2));
    ball.angles = yaw;
    ball setmodel(#"enh_ball");
    ShieldLog("^6enh_ball spawned at " + ball.origin);

    wait 0.5;
    // the model's origin is its bottom, 40 up is above its center
    force = getdvarfloat(#"enh_ball_force", 10);
    ball physicslaunch(ball.origin + (0, 0, 40), AnglesToForward(yaw) * force);
    ShieldLog("^6enh_ball launched, force " + force);
    ball thread PushOnShots("enh_ball");
}

/*
    Shots: once a prop comes to rest the server destroys its physics object and makes it stationary again (trType 0,
    the "stationary" notify, its origin where it stopped), so the game's bullet push (the client's physics object
    only) has nothing to push. physicsexplosionsphere only pushes the map's dynents. A new physicslaunch at the hit
    point makes the physics object again, its impulse there.
*/
PushOnShots(name)
{
    self endon(#"death");
    self setcandamage(1);
    self.health = 1000000;

    while(true)
    {
        s_result = self waittill(#"damage");
        self.health = 1000000;
        force = getdvarfloat(#"enh_shot_force", 6);
        self physicslaunch(s_result.position, vectornormalize(s_result.direction) * force);
        ShieldLog("^6" + name + " hit at " + s_result.position + ", launched with " + force);
    }
}

// a convex piece per object (enh.ff collisionObj): the dumbbell on its two balls across the view, rolled away
SpawnTestDumbbell(player)
{
    yaw = (0, player.angles[1], 0);
    bell = spawn("script_model", GroundBelow(player.origin + AnglesToForward(yaw) * 320) + (0, 0, 2));
    bell.angles = yaw + (0, 90, 0);
    bell setmodel(#"enh_dumbbell");
    ShieldLog("^6enh_dumbbell spawned at " + bell.origin);

    wait 0.5;
    // the tops of its balls are 20 up
    force = getdvarfloat(#"enh_dumbbell_force", 10);
    bell physicslaunch(bell.origin + (0, 0, 18), AnglesToForward(yaw) * force);
    ShieldLog("^6enh_dumbbell launched, force " + force);
    bell thread PushOnShots("enh_dumbbell");
}

RocketGun()
{
	self endon(#"death", #"stop_rocket_gun");

	self.rocket_gun = true;

	self iPrintLnBold("rocket_gun ^2on");

	while(getDvarInt(#"enh_rocket_gun", 0))
	{
		self waittill(#"weapon_fired");
		MagicBullet(getWeapon("launcher_standard_t8_upgraded"), self getPlayerCameraPos(), BulletTrace(self getPlayerCameraPos(), self getPlayerCameraPos() + anglesToForward(self getPlayerAngles())  * 100000, false, self)["position"], self);
		wait 0.001;
	}

	self.rocket_gun = undefined;
}

GodModePlayer()
{
	self endon(#"death");

	self iPrintLnBold("godmode ^2on");

	while(isDefined(self.godmode_s))
	{
		self enableInvulnerability();
		wait 0.15;
	}

	self iPrintLnBold("godmode ^1off");

	self disableInvulnerability();
}

// ate's
ANoclipBind() {
    self endon(#"spawned_player", #"disconnect", #"bled_out");
    level endon(#"end_game", #"game_ended");
    self notify(#"stop_player_out_of_playable_area_monitor");
	self unlink();
    if(isdefined(self.originObj)) self.originObj delete();
    ts = 0;

    self.noclip_s = false;

	while(true) {
		if(self.noclip_s) {
			self.originObj = spawn("script_origin", self.origin, 1);
    		self.originObj.angles = self.angles;
			self PlayerLinkTo(self.originObj, undefined);
			self enableweapons();

			while(true) {
				if(!self.noclip_s) {
					self iPrintLnBold("^6Fly mode ^1disabled");
					break;
				}
				if (isdefined(self.originObj.future_tp)) {
					self.originObj.origin = self.originObj.future_tp;
					self.originObj.future_tp = undefined;
					waitframe(1);
					continue;
				}
				
                nts = GetTime();
                if (nts > ts) {
                    ts = nts + 25000; // add 25s
                    self iPrintLnBold("^6Fly mode ^2enabled");
                    self iPrintLnBold("^5" + "[{+sprint}]" + "^6: fly, ^5" + "[{+gostand}]" + "^6: up, ^5" + "[{+stance}]" + "^6: down");
                }

				if(self sprintbuttonpressed()) {
					fly_speed = 60;
				} else {
					fly_speed = 20;
				}

				player_angles = self getPlayerAngles();

				// I'm too tired to remember my vector courses
				front_vector = AnglesToForward(player_angles);
				left_vector = AnglesToForward(player_angles - (0, 90, 0));
				top_vector = AnglesToForward(player_angles - (90, 0, 0));

				v_movement = self getNormalizedMovement();

				if (self jumpbuttonpressed()) {
					z_movement = 1;
				} else if (self stancebuttonpressed()) {
					z_movement = -1;
				} else {
					z_movement = 0;
				}

				move_vector = 
					// add z angle
						z_movement * top_vector 
					// add front movement
					+ front_vector * v_movement[0] 
					// remove left/right z vector part because it was weird
					+ (left_vector[0], left_vector[1], 0) * v_movement[1];
				move_vector_scaled = vectorScale(move_vector, fly_speed);
				originpos = self.origin + move_vector_scaled;
				self.originObj.origin = originpos;
				waitframe(1);
			}
			self unlink();
			if(isdefined(self.originObj)) self.originObj delete();
			waitframe(1);
		}
		waitframe(1);
	}
}

RegisterDebugCmds()
{
	// for achivs
	level.IsUsingDebugLUI = true;

	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/godmode/on\" \"set enh_godmode 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/godmode/off\" \"set enh_godmode 0\"\n");

	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/godmode_all/on\" \"set enh_godmode_all 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/godmode_all/off\" \"set enh_godmode_all 0\"\n");

	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/rocket_gun/on\" \"set enh_rocket_gun 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/rocket_gun/off\" \"set enh_rocket_gun 0\"\n");

	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/noclip/on\" \"set enh_noclip 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/noclip/off\" \"set enh_noclip 0\"\n");

	for (i = 1; i <= 150; i++)
		adddebugcommand("devgui_cmd \"enh_dev_gsc/round/skip/" + i + "\" \"set enh_skip_round " + i + "\"\n");

	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/score/+500\" \"set enh_score_player 500\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/score/-500\" \"set enh_score_player -500\"\n");

	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/test_func/on\" \"set enh_test 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/player/test_func/off\" \"set enh_test 0\"\n");

	adddebugcommand("devgui_cmd \"enh_dev_gsc/game/timescale_speed/1x\" \"set enh_timescale_speed 1\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/game/timescale_speed/2x\" \"set enh_timescale_speed 2\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/game/timescale_speed/5x\" \"set enh_timescale_speed 5\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/game/timescale_speed/10x\" \"set enh_timescale_speed 10\"\n");
	adddebugcommand("devgui_cmd \"enh_dev_gsc/game/timescale_speed/0x\" \"set enh_timescale_speed 0\"\n");

	thread LoopDvars();
}

LoopDvars()
{
	while(true)
	{
		godmode_all = undefined;
		godmode = undefined;
		rocket_gun = undefined;
		noclip = undefined;
		test = undefined;
		skip_round = undefined;
		score_player = undefined;
		Host_Player = undefined;

		Host_Player = GetPlayers()[0];

		if (isDefined(Host_Player))
		{
			if (!isDefined(Host_Player.noclip_s))
			{
				Host_Player thread ANoclipBind();
			}

			godmode = getDvarInt(#"enh_godmode", 0);

			if (godmode && !isDefined(Host_Player.godmode_s))
			{
				Host_Player.godmode_s = true;
				Host_Player thread GodModePlayer();
			}
			else if (!godmode)
			{
				Host_Player.godmode_s = undefined;
			}

			godmode_all = getDvarInt(#"enh_godmode_all", 0);

			if (godmode_all)
			{
				foreach(player in level.players)
				{
					if (!isDefined(player.godmode_s) && player != Host_Player)
					{
						player.godmode_s = true;
						player thread GodModePlayer();
					}
				}
			}
			else if (!godmode_all)
			{
				foreach(player in level.players)
					if (isDefined(player.godmode_s) && player != Host_Player)
						player.godmode_s = undefined;
			}

			rocket_gun = getDvarInt(#"enh_rocket_gun", 0);

			if (rocket_gun && !isDefined(Host_Player.rocket_gun))
			{
				Host_Player thread RocketGun();
			}
			else if (!rocket_gun)
			{
				Host_Player notify(#"stop_rocket_gun");
				Host_Player.rocket_gun = undefined;
			}

			noclip = getDvarInt(#"enh_noclip", 0);

			if (noclip)
			{
				Host_Player.noclip_s = true;
			}
			else
			{
				Host_Player.noclip_s = false;
			}

			test = getDvarInt(#"enh_test", 0);

			if (test)
			{
				Host_Player thread TestShit();
				setDvar(#"enh_test", 0);
			}

			speed_game = getDvarInt(#"enh_timescale_speed", 1);
			setslowmotion(1, speed_game, 0);

			skip_round = getDvarInt(#"enh_skip_round", 0);

			if (skip_round > 0)
			{
				level thread zm_utility::zombie_goto_round(skip_round);
        		level thread zm_game_module::zombie_goto_round(skip_round);

				setDvar(#"enh_skip_round", 0);
			}

			score_player = getDvarInt(#"enh_score_player", 0);

			if (score_player != 0)
			{
				foreach(player in level.players) player zm_score::add_to_player_score(score_player);

				setDvar(#"enh_score_player", 0);
			}
		}

		wait 0.15;
	}
}

// custom xmodel test (enh.ff): enh_cube is in the zone's bgcache, the server only sets models that are
SpawnTestCube(player)
{
    yaw = (0, player.angles[1], 0);
    cube = spawn("script_model", player.origin + AnglesToForward(yaw) * 96);
    cube.angles = yaw;
    cube setmodel(#"enh_cube");

    // zombies follow the navmesh, not collision: cut it around the model (its collmap brush)
    cube disconnectpaths();

    ShieldLog("^6enh_cube spawned at " + cube.origin);

    cube thread TestCubeSounds(player);
}

// custom sound test (enh.ff sound bank enh.all): a 2d chime to the player, 3d beeps of random pitch, then a loop on the cube
TestCubeSounds(player)
{
    self endon(#"death");

    player playlocalsound(#"enh_test_2d");
    ShieldLog("^6enh_test_2d played");

    for(i = 0; i < 5; i++)
    {
        wait 3;
        self playsound(#"enh_test_3d");
        ShieldLog("^6enh_test_3d played on the cube");
    }

    // fades in over 1s (its FadeIn), out over 1s
    wait 3;
    self playloopsound(#"enh_test_loop");
    ShieldLog("^6enh_test_loop started on the cube");
    wait 8;
    self stoploopsound(1);
    ShieldLog("^6enh_test_loop stopped");

    // one of 3 sounds each time (thud, ping, chirp), never the same twice in a row
    wait 2;
    for(i = 0; i < 8; i++)
    {
        self playsound(#"enh_test_variant");
        ShieldLog("^6enh_test_variant played on the cube");
        wait 1.5;
    }

    // a stereo melody stored as flac
    wait 1;
    player playlocalsound(#"enh_test_flac");
    ShieldLog("^6enh_test_flac played");

    // a music state of the bank, 16s of chords, faded out over 4 beats when it changes
    wait 6;
    music::setmusicstate("enh_test_music");
    ShieldLog("^6music state enh_test_music");
    wait 10;
    music::setmusicstate("none");
    ShieldLog("^6music state none");
}

// imported xmodel test (enh.ff): the game's truss from a wraith obj, to the right of the cube
SpawnTestTruss(player)
{
    yaw = (0, player.angles[1], 0);
    truss = spawn("script_model", player.origin + AnglesToForward(yaw) * 96 + AnglesToRight(yaw) * 96);
    truss.angles = yaw;
    truss setmodel(#"enh_truss");
    truss disconnectpaths();

    ShieldLog("^6enh_truss spawned at " + truss.origin);
}

// model from another game (enh.ff): a frostbite fbx through blender, to the left of the cube, facing the player
SpawnTestCactus(player)
{
    yaw = (0, player.angles[1], 0);
    cactus = spawn("script_model", player.origin + AnglesToForward(yaw) * 96 - AnglesToRight(yaw) * 96);
    cactus.angles = (0, player.angles[1] + 180, 0);
    cactus setmodel(#"enh_cactus");
    cactus disconnectpaths();

    ShieldLog("^6enh_cactus spawned at " + cactus.origin);
}

DebugMode()
{
    level endon(#"end_game", #"game_ended");
    
    if (!GetDvarInt(#"shield_enh_lui_debug", 0))
        return;

    ShieldLog("^6Debug LUI Init");

    // if you dont wait for black screen loading and start luinotify early, you fucking crash the server.
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("initial_blackscreen_passed");

	thread RegisterDebugCmds();
    wait 10;

	Host_Player = GetPlayers()[0];
	Host_Player endon(#"death");

    while(true)
    {
		pos = undefined;
		vel = undefined;
		angles = undefined;
		health = undefined;
		isGrounded = undefined;

        if (!isDefined(Host_Player))
        {
            wait 1;
        
            Host_Player = GetPlayers()[0];
            continue;
        }

        // position, args -> isfloat (2 if vector), type, args
        pos = Host_Player.origin;
        Host_Player LUINotifyEvent(#"enhancement_debug_info", 5, 2, 0, ConvertNumToLUI(pos[0]), ConvertNumToLUI(pos[1]), ConvertNumToLUI(pos[2]));

        // velocity
        vel = Host_Player GetVelocity();
        Host_Player LUINotifyEvent(#"enhancement_debug_info", 5, 2, 1, ConvertNumToLUI(vel[0]), ConvertNumToLUI(vel[1]), ConvertNumToLUI(vel[2]));

        // angles (FIXED for player)
        angles = Host_Player.angles;
        Host_Player LUINotifyEvent(#"enhancement_debug_info", 5, 2, 2, ConvertNumToLUI(angles[0]), ConvertNumToLUI(angles[1]), ConvertNumToLUI(angles[2]));

        // health
        health = Host_Player.health;
        Host_Player LUINotifyEvent(#"enhancement_debug_info", 5, 1, 3, ConvertNumToLUI(health), 0, 0);

        // grounded
        isGrounded = Host_Player IsOnGround() ? 1 : 0;
        Host_Player LUINotifyEvent(#"enhancement_debug_info", 5, 1, 4, ConvertNumToLUI(isGrounded), 0, 0);

        if(Host_Player AdsButtonPressed() && Host_Player useButtonPressed())
		{
            ShieldLog("-------------------------");
			ShieldLog("Debug Info:\nPOS: " + pos + "\nVEL: " + vel + "\nANG: " + angles + "\nHP: " + health + "\nGP: " + isGrounded);
            ShieldLog("-------------------------");

            Host_Player LUINotifyEvent(#"enhancement_debug_info", 1, 4);
		}
        else
            Host_Player LUINotifyEvent(#"enhancement_debug_info", 1, 3);

        util::wait_network_frame(1);
    }
}