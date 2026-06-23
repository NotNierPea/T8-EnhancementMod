ShieldPublicPauseScript()
{
    ShieldRegisterHudElem(#"shield_paused_hud", "", 
        0xFFFF0000, // color red
        0, 100, // x/y
        1, 0, // anchor x/y
        1, 0, // align x/y
        1.25 // scale
    );

    clientfield::register("toplayer", "" + #"shield_paused_hud", 1, 1, "int", &SetPausedHud, 0, 0);
}

SetPausedHud(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
    if(newval)
    {
        ShieldHudElemSetText(#"shield_paused_hud", "^9 Paused!");
    }
    else
    {
        ShieldHudElemSetText(#"shield_paused_hud", "^2 UnPaused!");
        wait 1.5;
        ShieldHudElemSetText(#"shield_paused_hud", "");
    }
}