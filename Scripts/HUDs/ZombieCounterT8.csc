ZombieCounterT8() 
{
    //clientfield::register("toplayer", "" + #"zombies_counter_alive", 1, 10, "int", &cf_set_zombies_count, 0, 0);
    //clientfield::register("toplayer", "" + #"zombies_counter_remaining", 1, 10, "int", &cf_set_zombies_count_remaining, 0, 0);

    /#
    level.zombies_counter = 
    {
        #count : 0,
        #remaining : 0
    };
    #/
    
    /#
    if(!isDefined(level.ConfigEncCSC)) return;

    switch(level.ConfigEncCSC.Counter_TextColor) // stupid way but works lol
    {
        case "Red":
        level.TextHudColor = "^1";
        break;

        case "Yellow":
        level.TextHudColor = "^3";
        break;

        case "Black":
        level.TextHudColor = "^0";
        break;

        case "White":
        level.TextHudColor = "^7";
        break;

        case "Green":
        level.TextHudColor = "^2";
        break;

        case "Cyan":
        level.TextHudColor = "^5";
        break;

        case "Pink":
        level.TextHudColor = "^6";
        break;

        case "Blue":
        level.TextHudColor = "^4"; // ^4
        break;

        case "Grey":
        level.TextHudColor = "^9";
        break;

        default:
        level.TextHudColor = "^1";
        break;
    }

    switch(level.ConfigEncCSC.Counter_NumberColor)
    {
        case "Red":
        level.NumberHudColor = "^1";
        break;

        case "Yellow":
        level.NumberHudColor = "^3";
        break;

        case "Black":
        level.NumberHudColor = "^0";
        break;

        case "White":
        level.NumberHudColor = "^7";
        break;

        case "Green":
        level.NumberHudColor = "^2";
        break;

        case "Cyan":
        level.NumberHudColor = "^5";
        break;

        case "Pink":
        level.NumberHudColor = "^6";
        break;

        case "Blue":
        level.NumberHudColor = "^4"; // ^4
        break;

        case "Grey":
        level.NumberHudColor = "^9";
        break;

        default:
        level.NumberHudColor = "^1";
        break;
    }

    #/
    
    /#
    ShieldRegisterHudElem(#"zombies_counter", level.TextHudColor + "Waiting for The Zombies...", 
        0xFFFF0000, // color red
        level.ConfigEncCSC.Counter_X, level.ConfigEncCSC.Counter_Y, // x/y
        level.ConfigEncCSC.Counter_AnchorX, level.ConfigEncCSC.Counter_AnchorY, // anchor x/y
        level.ConfigEncCSC.Counter_AlignX, level.ConfigEncCSC.Counter_AlignY, // align x/y
        level.ConfigEncCSC.Counter_Scale // scale
    );
    #/
}

UpdateHud() 
{
    if(!isDefined(level.ConfigEncCSC)) return;
    
    if(!level.ConfigEncCSC.Counter_OnlyRemainingZombies) ShieldHudElemSetText(#"zombies_counter", 
    level.TextHudColor + "Zombies: " + level.NumberHudColor + level.zombies_counter.count + 
    level.TextHudColor + " (" + level.NumberHudColor + level.zombies_counter.remaining + level.TextHudColor + " Remaining)");

    else ShieldHudElemSetText(#"zombies_counter", level.NumberHudColor + 
    level.zombies_counter.remaining + level.TextHudColor + " Zombies Remaining");
}

cf_set_zombies_count(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) 
{
    level.zombies_counter.count = newval;
    UpdateHud();
}

cf_set_zombies_count_remaining(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) 
{
    level.zombies_counter.remaining = newval;
    UpdateHud();
}
