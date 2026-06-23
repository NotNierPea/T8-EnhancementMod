detour zm_office<scripts\zm\zm_office.gsc>::outro_watcher()
{
    ShieldLog("^1Outro Watcher Called!!");

    if(!GetDvarInt(#"shield_enh_five_early_ee", 0)) 
     return [[ @zm_office<scripts\zm\zm_office.gsc>::outro_watcher ]]();

    ShieldLog("^1Watching for 60 rounds");

    if (level.round_number == 60) {
        level notify(#"main_quest_complete");
    }
}