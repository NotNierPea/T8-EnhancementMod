detour zm_perks<scripts\zm_common\zm_perks.csc>::function_35ba0b0e(localclientnum, n_slot) 
{
    if(!GetDvarInt(#"shield_enh_ClassicMode", 0) || !getDvarInt(#"shield_enh_ClassicMode_Loadouts", 1))
	 return [[ @zm_perks<scripts\zm_common\zm_perks.csc>::function_35ba0b0e ]](localclientnum, n_slot);
    
    //ShieldLog("^1Get Perk -> CSC -> " + n_slot);

    level endon(#"demo_jump");
    self endon(#"death");

    //n_perk = n_slot + 1; // NO
    str_perk = GetPerkClassicMode(n_slot);

    //ShieldLog(str_perk + " - " + ShieldHashLookup(str_perk));

    return str_perk;
}

detour zm_powerups<scripts\zm_common\zm_powerups.csc>::function_618b5680(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
	if (!GetDvarInt("shield_enh_ClassicMode", 0))
	 return [[ @zm_powerups<scripts\zm_common\zm_powerups.csc>::function_618b5680 ]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);

    self [[ @zm_powerups<scripts\zm_common\zm_powerups.csc>::function_d6070ac5 ]](localclientnum);
    switch (newval) {
	case 5:
		str_fx = level._effect[#"hash_1bbdf961a543a8a4"];

		if (self.model !== #"tag_origin") {
			forcestreamxmodel(self.model);
			util::delay(1, undefined, &stopforcestreamingxmodel, self.model);
		}
		self util::waittill_dobj(localclientnum);
		if (!isdefined(self)) {
			return;
		}
		self.n_powerup_fx = util::playfxontag(localclientnum, str_fx, self, "tag_origin");

		return;
    case 1:
        str_fx = level._effect[#"powerup_intro"];
        break;
    case 2:
        str_fx = level._effect[#"hash_1bbdf961a543a8a4"];
        break;
    case 3:
        str_fx = level._effect[#"hash_68ab4922f64db792"];
        break;
    case 4:
        str_fx = level._effect[#"hash_216d76ce6f19d51c"];
    default:
        return;
    }

    self [[ @zm_powerups<scripts\zm_common\zm_powerups.csc>::play_powerup_fx ]](localclientnum, str_fx, 1);
}

detour zm_powerups<scripts\zm_common\zm_powerups.csc>::powerup_fx_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
	if (!GetDvarInt("shield_enh_ClassicMode", 0))
	 	return [[ @zm_powerups<scripts\zm_common\zm_powerups.csc>::powerup_fx_callback ]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);

    self [[ @zm_powerups<scripts\zm_common\zm_powerups.csc>::function_d6070ac5 ]](localclientnum);
    switch (newval) {
    case 1:
		str_fx = level._effect[#"powerup_on"];
		break;
	case 5:
        str_fx = level._effect[#"powerup_on_solo"];
        break;
    case 2:
        str_fx = level._effect[#"powerup_on_solo"];
        break;
    case 3:
        str_fx = level._effect[#"powerup_on_red"];
        break;
    case 4:
        str_fx = level._effect[#"powerup_on_caution"];
        break;
    default:
        return;
    }
	
    self [[ @zm_powerups<scripts\zm_common\zm_powerups.csc>::play_powerup_fx ]](localclientnum, str_fx);
}

detour zm_powerups<scripts\zm_common\zm_powerups.csc>::function_9f7265fd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
	if (!GetDvarInt("shield_enh_ClassicMode", 0))
	 	return [[ @zm_powerups<scripts\zm_common\zm_powerups.csc>::function_9f7265fd ]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);

    switch (newval) {
    case 1:
        str_fx = level._effect[#"powerup_grabbed"];
        break;
	case 5:
        str_fx = level._effect[#"powerup_grabbed_solo"];
        break;
    case 2:
        str_fx = level._effect[#"powerup_grabbed_solo"];
        break;
    case 3:
        str_fx = level._effect[#"powerup_grabbed_red"];
        break;
    case 4:
        str_fx = level._effect[#"powerup_grabbed_caution"];
        break;
    default:
        return;
    }

    playfx(localclientnum, str_fx, self.origin);
}