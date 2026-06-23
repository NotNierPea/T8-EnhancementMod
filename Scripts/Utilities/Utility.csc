BO4GetMap()
{
    map = util::get_map_name();

    if(map == "zm_towers") return "IX";//
    else if(map == "zm_escape") return "Blood";//
    else if(map == "zm_red") return "AE";//
    else if(map == "zm_white") return "AO";//
    else if(map == "zm_mansion") return "Dead";//
    else if(map == "zm_orange") return "Tag";
    else if(map == "zm_office") return "Classified";//
    else if(map == "zm_zodt8") return "Voyage";//
}

BO4ChaosMap()
{
    map = util::get_map_name();

    if(map == "zm_towers") return true;
    else if(map == "zm_red") return true;
    else if(map == "zm_mansion") return true;
    else if(map == "zm_zodt8") return true;

    return false;
}

BO4AetherMap()
{
    map = util::get_map_name();

    if(map == "zm_escape") return true;
    else if(map == "zm_white") return true;
    else if(map == "zm_orange") return true;
    else if(map == "zm_office") return true;

    return false;
}