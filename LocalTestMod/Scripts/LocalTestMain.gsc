#include scripts\core_common\system_shared;

#namespace EnhancementLocalTest;

// LocalTest helpers moved into Scripts/Debug/DebugMode_LUI.gsc (F9 / enh_dev_gsc).
// Enable "Debug Stuff for UI" in settings, press F9, then use:
//   enh_dev_gsc/map/open_doors
//   enh_dev_gsc/map/power_on
//   enh_dev_gsc/map/activate_pap
//   enh_dev_gsc/map/open_map_setup
//   enh_dev_gsc/game/aat_always_proc
//   enh_dev_gsc/player/* (god, noclip, score, …)

autoexec InitSystem()
{
    system::register("EnhancementLocalTest", &Init, undefined, undefined);
}

Init()
{
    ShieldLog("^3LocalTest Mod is obsolete — use Enhancement Debug LUI (F9 / enh_dev_gsc)");
}
