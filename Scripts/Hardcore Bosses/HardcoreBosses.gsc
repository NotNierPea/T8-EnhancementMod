// fix elixirs disable
detour bgb_pack<scripts\zm_common\zm_bgb_pack.gsc>::function_dc818f99() {
    self notify(#"hash_67100af32a422470");
    self endon(#"hash_67100af32a422470", #"disconnect");
    self.var_bd0d5874 = 0;
    self.var_8ef176f3 = 0;
    self.var_9302665 = 0;
    while (isdefined(self)) {
        if (function_2ee076a7()) {
            if (self meleebuttonpressed() || self sprintbuttonpressed() || self isinmovemode("ufo", "noclip") || level flagsys::get(#"menu_open")) {
                self.var_7c6f53f9 = 1;
                waitframe(1);
                continue;
            } else if (isdefined(self.var_7c6f53f9) && self.var_7c6f53f9) {
                self.var_7c6f53f9 = undefined;
                waitframe(1);
            }
        }
        if (self scene::is_igc_active()) {
            waitframe(1);
            continue;
        }
        if 
        ((
        isDefined(self.bgb_disabled) && self.bgb_disabled) && (self actionslotonebuttonpressed() || self actionslotfourbuttonpressed() || self actionslottwobuttonpressed() || self actionslotthreebuttonpressed())
        || (zm_trial_disable_bgbs::is_active() && (self actionslotonebuttonpressed() || self actionslotfourbuttonpressed() || self actionslottwobuttonpressed() || self actionslotthreebuttonpressed()))) {
            
            if (zm_trial_disable_bgbs::is_active())
                self zm_trial_util::function_97444b02();
            else
                self playsoundtoplayer(#"hash_5590bcb35a1c2562", self);
            
            while (self actionslotonebuttonpressed() || self actionslotfourbuttonpressed() || self actionslottwobuttonpressed() || self actionslotthreebuttonpressed())
                waitframe(1);
            continue;
        }
        n_index = 0;
        if (self actionslotonebuttonpressed() && !self bgb_pack::function_6f7d5230(n_index)) {
            self bgb_pack::function_ea17bc2a(n_index);
        }
        n_index = 1;
        if (self actionslotfourbuttonpressed() && !self bgb_pack::function_6f7d5230(n_index)) {
            self bgb_pack::function_ea17bc2a(n_index);
        }
        n_index = 2;
        if (self actionslottwobuttonpressed() && !self bgb_pack::function_6f7d5230(n_index)) {
            self bgb_pack::function_ea17bc2a(n_index);
        }
        n_index = 3;
        if (self actionslotthreebuttonpressed() && !self bgb_pack::function_6f7d5230(n_index)) {
            self bgb_pack::function_ea17bc2a(n_index);
        }
        waitframe(1);
    }
}

HardcoreBosses()
{
    // reset obj
    LUINotifyEvent(#"enhancement_custom_visibility", 2, 0, 1);

    // register it anyways.
    if (BO4GetMap() == "Voyage" || BO4GetMap() == "Tag")
        clientfield::register("scriptmover", "winters_wail_slow_field_eye", 1, 1, "int");

    if (BO4GetMap() == "Tag")
    {
        clientfield::register("vehicle", "laser_set_arti", 24000, 1, "int");
        clientfield::register("vehicle", "laser_beem_arti", 24000, 1, "int");
    }

    if (BO4GetMap() == "Dead")
    {
        clientfield::register("actor", "" + #"hash_87483ed44cb2791", 8000, 1, "int");
        clientfield::register("actor", "" + #"hash_69c1868b7a8a7beb", 8000, 1, "int");
        clientfield::register("actor", "" + #"hash_1bf2c2f62ad1bf56", 8000, 1, "int");
    }

    if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        return;
    
    ShieldLog("^1Hardcore Bosses Enabled!");

    switch(BO4GetMap())
    {
        case "IX":
        thread IX_SetupHard();
        break;

        case "Blood":
        thread Hardcore_BOTD_Init();
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
        break;
    }

    LUINotifyEvent(#"notify_boss_name", 1, 0);
    LUINotifyEvent(#"notify_boss_health_meter", 1, 0);
}