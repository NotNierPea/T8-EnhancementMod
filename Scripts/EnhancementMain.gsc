#include scripts/zm_common/zm_player.gsc;
#include scripts\core_common\bots\bot;
#include scripts/zm_common/zm_ui_inventory.gsc; // !!
#include scripts\core_common\player\player_role;
#include scripts\core_common\weapons_shared.gsc;
#include scripts\core_common\values_shared;
#include scripts\core_common\spawner_shared;
#include scripts\zm_common\zm_spawner.gsc;
#include scripts/zm_common/zm_unitrigger.gsc; // !!
#include scripts\zm_common\zm_crafting;
#include scripts\core_common\drown.gsc;
#include scripts\zm_common\zm_progress;
#include scripts\core_common\trigger_shared.gsc;
#include scripts\core_common\ai_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\demo_shared;
#include scripts\zm_common\bb;
#include scripts\core_common\dialog_shared;
#include script_301f64a4090c381a;
#include scripts\core_common\potm_shared;
#include scripts\zm_common\trials\zm_trial_disable_bgbs;
#include scripts\core_common\ai\zombie_utility;
#include scripts\zm_common\trials\zm_trial_disable_buys;
#include scripts\zm_common\trials\zm_trial_disable_perks;
#include scripts\zm_common\trials\zm_trial_randomize_perks;
#include scripts\zm\powerup\zm_powerup_full_ammo.gsc;
#include scripts\zm_common\zm_customgame.gsc;
#include scripts\zm_common\zm_trial;
#include scripts\core_common\activecamo_shared;
#include scripts\zm_common\zm_round_logic.gsc;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_sq_modules;
#include scripts\zm_common\zm_transformation;
#include scripts\core_common\bots\bot_util.gsc;
#include scripts\core_common\bots\bot_action.gsc;
#include scripts\zm_common\zm_armor;
#include scripts\zm\powerup\zm_powerup_nuke;
#include scripts\zm\weapons\zm_weap_riotshield;
#include scripts\zm\powerup\zm_powerup_nuke.gsc;
#include scripts\core_common\ai\zombie_death.gsc;
#include scripts\core_common\exploder_shared;
#include scripts\zm_common\zm_vo.gsc;
#include scripts\zm_common\zm_daily_challenges.gsc;
#include scripts\zm_common\zm_items.gsc;
#include scripts\core_common\vehicle_shared.gsc;
#include scripts\core_common\throttle_shared.gsc;
#include scripts\zm_common\zm_cleanup_mgr.gsc;
#include scripts\core_common\struct;
#include scripts/zm_common/zm_characters.gsc;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\hud_message_shared;
#include scripts\core_common\hud_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\flag_shared;
#include scripts\zm_common\zm_talisman;
#include scripts\zm_common\gametypes\dev.gsc;
#include scripts\zm_common\zm_score.gsc;
#include scripts\zm_common\util.gsc;
#include scripts\zm_common\zm_audio.gsc;
#include scripts\zm_common\zm_powerups.gsc;
#include scripts\zm_common\zm_stats.gsc;
#include scripts\zm_common\zm_contracts;
#include scripts\zm_common\zm_power.gsc;
#include scripts\zm_common\bgbs\zm_bgb_anywhere_but_here;
#include scripts\zm_common\zm_hero_weapon.gsc;
#include scripts\zm_common\zm_pack_a_punch_util.gsc;
#include scripts\core_common\perks;
#include scripts\zm_common\zm_pack_a_punch.gsc;
#include scripts\core_common\aat_shared.gsc;
#include scripts\zm_common\zm_bgb_pack;
#include scripts\zm_common\zm_ffotd;
#include scripts/core_common/ai/zombie_utility.gsc;
#include scripts\zm_common\zm_magicbox.gsc;
#include scripts\core_common\rank_shared.gsc;
#include scripts\core_common\challenges_shared.gsc;
#include script_6ce38ab036223e6e.gsc;
#include scripts\zm_common\gametypes\globallogic_score.gsc;
#include scripts\zm_common\gametypes\globallogic.gsc;
#include scripts\abilities\ability_power;
#include scripts\core_common\contracts_shared.gsc;
#include script_47fb62300ac0bd60.gsc;
#include script_6c5b51f98cd04fa3.gsc;
#include scripts\core_common\match_record.gsc;
#include scripts\zm_common\zm_laststand.gsc;
#include scripts\core_common\laststand_shared.gsc;
#include scripts\zm_common\load.gsc;
#include scripts\zm_common\zm_bgb.gsc;
#include scripts/core_common/music_shared.gsc;
#include scripts/core_common/lui_shared.gsc;
#include scripts/core_common/animation_shared.gsc;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\scene_shared.gsc;
#include scripts\zm_common\zm_zonemgr;
#include scripts\zm_common\zm_power;
#include scripts\zm_common\zm_blockers;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_equipment;
#include scripts\core_common\gestures;
#include scripts/zm_common/zm_game_module.gsc; // !!
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm;
#include script_3f9e0dc8454d98e1;
#include script_24c32478acf44108; // !!!!!
#include scripts\core_common\gameobjects_shared.gsc; // !!!!!!
#include script_4194df57536e11ed;
#include script_190d6b82bcca0908;
#include scripts\zm_common\gametypes\zm_gametype.gsc;
#include scripts\zm_common\zm_hud.gsc;
#include script_6d7d84509b62f422;
#include scripts\zm_common\zm_sq.gsc;
#include scripts\zm_common\trials\zm_trial_no_powerups;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\autogenerated\luielems\zm_laststand\self_revive_visuals;
#include scripts\autogenerated\luielems\zm_laststand\zm_laststand_client;
#include scripts\zm_common\gametypes\globallogic_player;
#include scripts\zm_common\zm_round_spawning;
#include scripts\zm_common\bots\zm_bot_action;
#include scripts\zm_common\bots\zm_bot_position;
#include scripts\core_common\bots\bot;
#include scripts\core_common\bots\bot_action;

#include scripts\core_common\bots\bot_action;
#include scripts\core_common\bots\bot_chain;
#include scripts\core_common\bots\bot_interface;
#include scripts\core_common\bots\bot_position;
#include scripts\core_common\bots\bot_stance;

//#include scripts\zm_common\zm_fasttravel.gsc; // !! csc mismatch???

#include scripts\zm_common\bgbs\zm_bgb_shields_up.gsc;
#include scripts\zm_common\bgbs\zm_bgb_perkaholic.gsc;
#include scripts\zm_common\bgbs\zm_bgb_refresh_mint.gsc;
#include scripts\zm_common\bgbs\zm_bgb_burned_out.gsc;
#include scripts\zm_common\bgbs\zm_bgb_quacknarok.gsc;
#include scripts\zm_common\bgbs\zm_bgb_reign_drops.gsc;
#include scripts\zm_common\bgbs\zm_bgb_perk_up.gsc;

#include scripts\zm\perk\zm_perk_electric_cherry.gsc;
#include scripts\zm\perk\zm_perk_wolf_protector.gsc;

#include scripts\core_common\healthoverlay.gsc;
#include scripts\core_common\visionset_mgr_shared.gsc;
#include scripts\zm_common\zm.gsc;
#include scripts\core_common\ai\archetype_damage_utility.gsc;

#namespace T8EnhancementMod;

autoexec InitSystem() 
{
    // Changed from Dvars now, with lua settings...

    //thread ConfigLogicGSC();

    // have to register it anyways
    clientfield::register("toplayer", "" + #"shield_paused_hud", 1, 1, "int");

    /*
    if(!GetDvarInt(#"shield_enh_ZombiesMods", 0))
    {
        ShieldLog("^1Enhancement Mods Disabled...");
        return;
    } 
    */

    system::register("T8EnhancementMod", &Init, &PostInit, undefined);
}

Init()
{  
    // run the system ignores this map does..
    if (BO4GetMap() == "Blood")
    {
        level thread [[ @zm_weap_chakram<scripts\zm\weapons\zm_weap_chakram.gsc>::__init__ ]]();
        level thread [[ @zm_weap_hammer<scripts\zm\weapons\zm_weap_hammer.gsc>::__init__ ]]();
        level thread [[ @zm_weap_sword_pistol<scripts\zm\weapons\zm_weap_sword_pistol.gsc>::__init__ ]]();
        level thread [[ @zm_weap_scepter<scripts\zm\weapons\zm_weap_scepter.gsc>::__init__ ]]();

        level thread [[ @zm_weap_homunculus<scripts\zm\weapons\zm_weap_homunculus.gsc>::__init__ ]]();
    }

    ShieldLog("^1Enhancement Mod Loaded!");
    
    thread SaveGames();
    thread PracticeMode();
    thread HardcoreBosses();
    //thread VariatorsInit();
    thread GameSettingsInit();
    thread ClassicMode();
    thread PingingSystem();
    thread MorePlayersPatches();
    thread AltHUD();
    thread DirectedMode();
}

PostInit() 
{
    if (BO4GetMap() == "Blood")
        level thread [[ @zm_weap_homunculus<scripts\zm\weapons\zm_weap_homunculus.gsc>::__main__ ]]();
    
    //compiler::detour();
    thread Setup();
}

Setup()
{
    thread GameSettingsPostInit();
    thread DamagePoints();
    thread SuperRealistic();
    thread EEAlwaysEnabled();
    thread T8Bank();
    thread T8WeaponsDrops();
    thread EnableWeaponInspection();
    thread ZombieCounterT8(); // gsc
    thread RemoveBlackScreen();
    thread GameOverFunctions();
    thread BoxPatches();
    thread AllWeaponsinBox();
    thread FastRestartFixes();
    thread PauseAlwaysJoinable();
    thread RampageMode();
    thread SuperPerksMode();
    thread MenuResponseSystem();
    thread DebugMode();
    thread AddZombieHealthBars();
    thread AddZombieDamageNums();
    thread MusicWatcher();
    thread TeamCranked();
    thread RoundMusic();
    thread CustomAchivWaits();
    thread SecondaryEquipment();
    thread PowerUpsTimer();

    // moved, not really related to classic lol
    thread ClassicMode_ElixirGum();

    level flag::wait_till("all_players_spawned"); // waits for players 
    level flag::wait_till("initial_blackscreen_passed"); // waits for players

    // musics
    ShieldStopAllMusics();

    // sfxs
    ShieldStopAllSfx();

    // ui
    LUINotifyEvent(#"notify_boss_ui", 1, 0);

    // reset rampage if was on
    foreach(player in level.players)
    {
        player LUINotifyEvent(#"shield_enh_rampage_mode", 1, level.RampageActive ? 1 : 0);
    }

    foreach(player in level.players) {
        player iPrintLn("^1Zombies Enhancement Mod Loaded!, Made by Pea");

        // if host has tips on
        if (GetDvarInt(#"shield_enh_TipsChat", 1)) {
            player iPrintLn("^2Commands: /save (Saves a match), /thr (Third Person), /rmp (Rampage Mode), /cm <camo_id> (Changes Camo)");
            player iPrintLn("^3Binds: To open Gestures/Emotes Menu [{+calloutwheel}] (PC) OR [{+activate}] and after [{+smoke}] (Controller), To ping an location, Hold [{+speed_throw}] and press [{+switchseat}]");
        }
    }

    if (BO4GetMap() == "IX") {
        wait 5;

        // fix ix's lua icon
        foreach(player in level.players)
            level.var_210ce105 [[ @zm_towers_crowd_meter<scripts\autogenerated\luielems\zm\zm_towers_crowd_meter.gsc>::set_state ]](player, "crowd_no_love");
    }
}