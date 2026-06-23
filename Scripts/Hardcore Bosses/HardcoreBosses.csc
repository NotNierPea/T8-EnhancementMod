HardcoreBossesScript()
{
    // ! - just register it anyways.
    //if(!GetDvarInt(#"shield_enh_Hardcore_Bosses", 0))
        //return;

    ShieldLog("^1Hardcore Bosses Enabled! (CSC)");

    switch(BO4GetMap())
    {
        case "IX":
        break;

        case "Blood":
        break;

        case "AE":
        break;

        case "AO":
        break;

        case "Dead":
        clientfield::register("actor", "" + #"hash_87483ed44cb2791", 8000, 1, "int", &boss_appear, 0, 0);
        clientfield::register("actor", "" + #"hash_69c1868b7a8a7beb", 8000, 1, "int", &boss_appear_v3, 0, 0);
        clientfield::register("actor", "" + #"hash_1bf2c2f62ad1bf56", 8000, 1, "int", &boss_appear_v2, 0, 0);
        break;

        case "Tag":
        clientfield::register("scriptmover", "winters_wail_slow_field_eye", 1, 1, "int", &eye_fx, 0, 0);

        clientfield::register("vehicle", "laser_set_arti", 24000, 1, "int", &laser_set_arti, 0, 0);
        clientfield::register("vehicle", "laser_beem_arti", 24000, 1, "int", &laser_beem_arti, 0, 0);
        break;

        case "Classified":
        break;

        case "Voyage":
        clientfield::register("scriptmover", "winters_wail_slow_field_eye", 1, 1, "int", &eye_fx, 0, 0);
        break;
    }
}

boss_appear(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self)) {
        return;
    }
    self thread boss_fx(localclientnum);
    if (newval == 1) {
        self playrenderoverridebundle(#"hash_c5c4890c94eb1c7");
        playsound(localclientnum, #"hash_8fc267f3e184882", self.origin);
        return;
    }
    self stoprenderoverridebundle(#"hash_c5c4890c94eb1c7");
    playsound(localclientnum, #"hash_f5264369f84b89b", self.origin);
}

boss_fx(localclientnum) {
    self endon(#"death");
    if (!isdefined(self.var_aac4aa35)) {
        self.var_aac4aa35 = util::playfxontag(localclientnum, level._effect[#"fx8_boss_eye_glow"], self, "tag_eye");
    } else {
        if (isdefined(self.var_aac4aa35)) {
            stopfx(localclientnum, self.var_aac4aa35);
        }
        self.var_aac4aa35 = undefined;
    }
    self.var_e0580f33 = util::playfxontag(localclientnum, level._effect[#"hash_1e4fa83f4db14c46"], self, "j_spine4");
    wait 0.5;
    if (isdefined(self.var_e0580f33)) {
        stopfx(localclientnum, self.var_e0580f33);
    }
    self.var_e0580f33 = undefined;
}

boss_appear_v2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self mapshaderconstant(localclientnum, 0, "ScriptVector4", 0, 1, 0, 0);
        return;
    }
    self mapshaderconstant(localclientnum, 0, "ScriptVector4", 0, 0, 0, 0);
}

boss_appear_v3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self)) {
        return;
    }
    self thread boss_fx(localclientnum);
    if (newval == 1) {
        self playrenderoverridebundle(#"hash_6a2d3edbb0f2c98d");
        return;
    }
    self stoprenderoverridebundle(#"hash_6a2d3edbb0f2c98d");
}

eye_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
       self.current_fx = util::playfxontag(localclientnum, level._effect[#"winters_wail_slow_field"], self, "tag_fx_beam");
    }
    else if (isDefined(self.current_fx))
        stopfx(localclientnum, self.current_fx);
}

laser_set_arti(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.arti_set = self;
}

laser_beem_arti(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_85adeb8c)) {
        beamkill(localclientnum, self.var_85adeb8c);
        self.var_85adeb8c = undefined;
    }
    if (isdefined(self.var_9c7e4ef8)) {
        stopfx(localclientnum, self.var_9c7e4ef8);
    }
    if (newval > 0) {
        var_ab11c23d = level.arti_set;

        if (isDefined(var_ab11c23d))    
        {
            self.var_85adeb8c = level beam::function_cfb2f62a(localclientnum, var_ab11c23d, "tag_origin", self, "tag_origin", "beam8_zm_orange_lighthouse_trap_strike");
            self.var_9c7e4ef8 = util::playfxontag(localclientnum, level._effect[#"hash_48d5d5ee69c7e417"], self, "tag_origin");
        }
    }
}