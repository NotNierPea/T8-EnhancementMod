AddObjectiveDamageNumber(origin, damage_dealt, is_headshot = false) 
{
	// show and use damage_dealt, only to player
	self LUINotifyEvent(#"enhancement_damage_visibility", 5, Int(origin[0]), Int(origin[1]), Int(origin[2]), Int(damage_dealt), is_headshot);
}

AddZombieDamageNums()
{
	if(!GetDvarInt(#"shield_enh_DamageNumbers", 0))
     	return;

	ShieldLog("^1Damage Numbers enabled..");

	callback::on_ai_damage(&on_ai_damage);
}

on_ai_damage(params)
{
	if (isplayer(params.eattacker)) {
		// Use vpoint if defined, else fallback to vdamageorigin
		n_origin = isdefined(params.vpoint) ? params.vpoint : params.vdamageorigin;
		n_damage = params.idamage;

		is_headshot = (!isdefined(params.smeansofdeath)) ? false : self zm_utility::is_headshot(params.weapon, params.shitloc, params.smeansofdeath);

		if (isdefined(n_damage) && n_damage > -1 && isdefined(n_origin))
			params.eattacker AddObjectiveDamageNumber(n_origin, n_damage, is_headshot);

		//ShieldLog("added " + n_damage + " damage number at " + n_origin);
	}
}