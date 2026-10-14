#include scripts\core_common\system_shared.csc;
#include scripts\core_common\clientfield_shared.csc;
#include scripts\core_common\util_shared.csc;
#include scripts\zm_common\zm_perks.csc;
#include scripts\zm_common\zm_customgame.csc;
#include scripts\zm_common\zm_loadout.csc;
#include scripts\core_common\beam_shared.csc;
#include scripts\core_common\aat_shared.csc;
#include scripts\core_common\callbacks_shared.csc;
#include scripts\zm_common\zm_utility.csc;

#namespace T8EnhancementMod;

autoexec InitSystem() 
{
    if (util::is_frontend_map()) return; // frontend, i dont want to fucking loop again please

    system::register("T8EnhancementMod", &Init, &PostInit, undefined);
}

Bo3AatClientInit()
{
    // aat system may not be up yet when called from Init, so wait a bit for it
    level thread Bo3AatClientInitThread();
}

Bo3AatClientInitThread()
{
    for (i = 0; i < 300; i++)
    {
        if (isdefined(level.aat_initializing))
        {
            if (level.aat_initializing)
                break;
        }
        if (isdefined(level.aat))
        {
            if (isdefined(level.aat["zm_aat_kill_o_watt"]))
                break;
        }
        waitframe(1);
    }

    if (isdefined(level.aat_initializing))
    {
        if (level.aat_initializing)
            aat::register("zm_aat_fire_works", #"shield/aat_fire_works", "fireworks_classic");
    }

    // apply names here — do not hook finalize_initialization (AAR/exit re-fires it)
    for (i = 0; i < 300; i++)
    {
        if (isdefined(level.aat))
        {
            if (isdefined(level.aat["zm_aat_kill_o_watt"]))
            {
                Bo3AatClientNames();
                return;
            }
        }
        waitframe(1);
    }
}

Bo3AatClientNames()
{
    if (!isdefined(level.aat))
        return;
    if (!isdefined(level.aat["zm_aat_kill_o_watt"]))
        return;

    level.aat["zm_aat_kill_o_watt"].localized_string = #"shield/aat_dead_wire";
    level.aat["zm_aat_kill_o_watt"].n_index = 1;

    if (isdefined(level.aat["zm_aat_plasmatic_burst"]))
    {
        level.aat["zm_aat_plasmatic_burst"].localized_string = #"shield/aat_blast_furnace";
        level.aat["zm_aat_plasmatic_burst"].n_index = 2;
    }
    if (isdefined(level.aat["zm_aat_brain_decay"]))
    {
        level.aat["zm_aat_brain_decay"].localized_string = #"shield/aat_turned";
        level.aat["zm_aat_brain_decay"].n_index = 3;
    }
    if (isdefined(level.aat["zm_aat_frostbite"]))
    {
        level.aat["zm_aat_frostbite"].localized_string = #"shield/aat_thunder_wall";
        level.aat["zm_aat_frostbite"].n_index = 4;
    }
    if (isdefined(level.aat["zm_aat_fire_works"]))
    {
        level.aat["zm_aat_fire_works"].localized_string = #"shield/aat_fire_works";
        level.aat["zm_aat_fire_works"].n_index = 5;
    }
}

Bo3FurnaceTag()
{
    if (isdefined(self gettagorigin("j_spine4")))
        return "j_spine4";
    if (isdefined(self gettagorigin("tag_origin")))
        return "tag_origin";
    return undefined;
}

Bo3FurnaceBlast(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
    if (!isdefined(self))
        return;
    fx = playfx(localclientnum, "zombie/fx_bgb_burned_out_3p_zmb", self.origin);
    level thread Bo3FurnaceGround(localclientnum, fx);
    self playsound(localclientnum, #"wpn_aat_blast_furnace_plr");
}

Bo3FurnaceGround(localclientnum, fx)
{
    wait 2.5;
    if (isdefined(fx))
        stopfx(localclientnum, fx);
}

Bo3FurnaceBurnFx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
    if (newval)
    {
        tag = self Bo3FurnaceTag();
        if (!isdefined(tag))
            return;
        self.bo3_furnace_torso = util::playfxontag(localclientnum, "zombie/fx_bgb_burned_out_fire_torso_zmb", self, tag);
        return;
    }
    if (isdefined(self.bo3_furnace_torso))
    {
        stopfx(localclientnum, self.bo3_furnace_torso);
        self.bo3_furnace_torso = undefined;
    }
}

Bo3ThunderFx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
    if (!isdefined(self))
        return;
    origin = self.origin;
    if (!isdefined(origin))
        return;
    playfx(localclientnum, "zm_weapons/fx8_aat_elec_exp", origin);
}

Init()
{
    if (BO4GetMap() == "Blood")
    {
        level thread [[ @zm_weap_chakram<scripts\zm\weapons\zm_weap_chakram.csc>::__init__ ]]();
        level thread [[ @zm_weap_hammer<scripts\zm\weapons\zm_weap_hammer.csc>::__init__ ]]();
        level thread [[ @zm_weap_sword_pistol<scripts\zm\weapons\zm_weap_sword_pistol.csc>::__init__ ]]();
        level thread [[ @zm_weap_scepter<scripts\zm\weapons\zm_weap_scepter.csc>::__init__ ]]();

        level thread [[ @zm_weap_homunculus<scripts\zm\weapons\zm_weap_homunculus.csc>::__init__ ]]();
    }

    //ShieldLog("^1T8 Enhancement Mod Loaded! (CSC)");

    level._effect[#"bo3_furnace_exp"] = "zombie/fx_bgb_burned_out_3p_zmb";
    level._effect[#"bo3_furnace_burn"] = "zombie/fx_bgb_burned_out_fire_torso_zmb";
    level._effect[#"bo3_thunder"] = "zm_weapons/fx8_aat_elec_exp";

    // bo3port_drink needs 3 bits for labels 0-6; the rest are 0/1 or counters
    clientfield::register("toplayer", "bo3port_power", 1, 1, "int", &Bo3PortPower, 0, 0);
    clientfield::register("toplayer", "bo3port_drink", 1, 3, "int", &Bo3PortDrink, 0, 0);
    clientfield::register("toplayer", "bo3port_machine_on", 1, 1, "int", &Bo3PortMachineOn, 0, 0);
    clientfield::register("actor", "bo3_aat_furnace_blast", 1, 1, "counter", &Bo3FurnaceBlast, 0, 0);
    clientfield::register("actor", "bo3_aat_furnace_burn", 1, 1, "int", &Bo3FurnaceBurnFx, 0, 0);
    clientfield::register("actor", "bo3_aat_thunder", 1, 1, "counter", &Bo3ThunderFx, 0, 0);

    Bo3AatClientInit();

    thread ShieldPublicPauseScript();
    thread HardcoreBossesScript();
    thread T8WeaponsDrops();

    // !! - later
}

Bo3PortPower(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
    SetDvar(#"bo3port_power", newval);
}

Bo3PortDrink(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
    SetDvar(#"bo3port_drink", newval);
}

Bo3PortMachineOn(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
    SetDvar(#"bo3port_machine_on", newval);
}

PostInit() 
{ 
    if (BO4GetMap() == "Blood")
        level thread [[ @zm_weap_homunculus<scripts\zm\weapons\zm_weap_homunculus.csc>::__main__ ]]();

    thread Setup();
}

Setup()
{
    //thread ConfigLogicCSC();
    //thread ZombieCounterT8(); // csc <- unused, for now

    // Debug
    //thread Eye_Change_Camera();
}