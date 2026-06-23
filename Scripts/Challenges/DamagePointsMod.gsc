DamagePoints()
{
    if(isDefined(level.RushModActive))
     return;

    if(GetDvarInt(#"shield_enh_DamagePoints", 0))
     thread DamagePoints_Setup();
}

DamagePoints_Setup()
{
    level endon(#"end_game", #"game_ended");

    ShieldLog("^5Damage Points Enabled!");
    callback::on_spawned(&OnDamageSet);
    zm_player::register_player_damage_callback(&OnDamage);
}

OnDamageSet()
{
    self endon(#"disconnect");
    level endon(#"end_game", #"game_ended");

    self.HDrainPoints = array(50, 100, 250, 500, 1000, 2500, 3000); // blood money
    self.DrainP = 1;
}

OnDamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) // points are health
{
    self endon(#"disconnect");
    level endon(#"end_game", #"game_ended");
    if (!zm_utility::is_explosive_damage(smeansofdeath) && !bgb::is_enabled(#"zm_bgb_blood_debt")
    && !(isdefined(self.var_dad8bef6) && self.var_dad8bef6) && (isdefined(self.HDrainPoints)) && (isdefined(self.DrainP)))
    {
        if (idamage > 0) 
        {
            if (self.HDrainPoints.size > 1) 
            {
                n_cost = self.HDrainPoints[0];
            } 
            else 
            {
                n_cost = self.HDrainPoints[0] * self.DrainP;
                //self.DrainP++;
            }
            if (self zm_score::can_player_purchase(n_cost, 1)) 
            {
                self CostPoints(n_cost);
                return 0;
            } 
            else 
            {
                return idamage;
            }
        }
    }
    return -1;
}


CostPoints(n_cost)
{
    self endon(#"disconnect", #"spawned_player");
    level endon(#"end_game", #"game_ended");

    self zm_score::minus_to_player_score(n_cost, 1);
    if (self.HDrainPoints.size > 1) {
        self.HDrainPoints = array::remove_index(self.HDrainPoints, 0);
    }
}