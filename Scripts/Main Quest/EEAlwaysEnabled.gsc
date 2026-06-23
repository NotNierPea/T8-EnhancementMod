detour zm_utility<scripts\zm_common\zm_utility.gsc>::is_ee_enabled() 
{
	return true;
}

EEAlwaysEnabled()
{
    setGametypeSetting(#"hash_3c5363541b97ca3e", 1); // ee enabled
    setDvar(#"zm_ee_enabled", 1);

    // no contract
    level.var_aa2d5655 = undefined;
    // can xp
    level.var_5164a0ca = undefined;
    // xp multi
    level.var_3426461d = &GetXPMultiplier; // has to be done even with detours
    // disable ee
    level.var_73d1e054 = undefined;
    // end game mode type
    level.var_211e3a53 = undefined;
}