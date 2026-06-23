T8WeaponsDrops()
{
    clientfield::register("scriptmover", "highlight_shit", 1, 1, "int", &highlight_shit, 0, 0);
}

highlight_shit(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) 
{
    if (newval) {
        self playrenderoverridebundle("rob_sonar_set_friendly_zm", "tag_origin");
        self playrenderoverridebundle("rob_sonar_set_friendly");
        return;
    }
    
    self stoprenderoverridebundle("rob_sonar_set_friendly_zm", "tag_origin");
    self stoprenderoverridebundle("rob_sonar_set_friendly");
}