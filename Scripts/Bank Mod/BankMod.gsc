T8Bank()
{
    /#
    // ?? - commands
        // save object into a json file, if object is undefined, the file is deleted
        ShieldToJson(string name, object object = undefined);
        // get an object from a json, if the file doesn't exist, the function returns undefined
        ShieldFromJson(string name) -> object;
        // delete a json
        ShieldRemoveJson(string name);
    #/

    /#
        SaveLod = {
        #Money: 0
        };
    #/

    /#
    level.Saves = ShieldFromJson("T8BankSettings");
    if(!isDefined(level.Saves)) // if its first time loading the mod.....
    {
        level.Saves = {
        #Money: 2500
        };
    }
    #/

    if(!GetDvarInt(#"shield_enh_BankMoney", 0)) 
     return;

    callback::on_connect(&onPlayerConnect);
    callback::on_spawned(&BankPlayerSpawned);

    level flag::wait_till("all_players_spawned"); // waits for players 
    level flag::wait_till("initial_blackscreen_passed"); // waits for players

    ShieldLog("^6T8Bank - Loaded Init!");
    switch(BO4GetMap())
    {
        case "IX":
        BankOrigin = (212, -586, 80);
        break;

        case "Blood":
        BankOrigin = (8945, 11608, 490);
        break;

        case "AE":
        BankOrigin = (-2072, -1120, 90);
        break;

        case "AO":
        BankOrigin = (-177, -2336, 0);
        break;

        case "Dead":
        BankOrigin = (-2, -928, 45);
        break;

        case "Tag":
        BankOrigin = (641, 3816, 75);
        break;

        case "Classified":
        BankOrigin = (235, 3018, 60);
        break;

        case "Voyage":
        BankOrigin = (0, -4085, 975);
        break;
    }

    Bank = util::spawn_model("zombie_z_money_icon", BankOrigin, (0, 90, 0));
    Bank clientfield::set("powerup_fx", 2); // blue
    bank thread RotateAndBobItem();
    Bank zm_unitrigger::create(&TriggerSetup, 120, &CheckingTrigger);

    /#
        {
            "type": "scriptparsetree",
            "name": "scripts/zm_common/T8Bank.gsc",
            "path": "T8Bank.gscc",
            "hooks": [
                "scripts/zm_common/load.gsc"
            ]
        },
    #/

    /#
        stats::set_stat(#"item_stats", #"sniper_locus_t8", #"challenges_tu", #"challengevalue", 5);
        stats::get_stat(#"item_stats", #"sniper_locus_t8", #"challenges_tu", #"challengevalue");
    #/
    
}

TriggerSetup(e_player)
{
    if(e_player.BankMode == 2)
    {
        if(isDefined(e_player.BankMoney))
        {
            if(e_player.score <= e_player.BankCost)
            {
                self setcursorhint("HINT_NOICON");
                self sethintstringforplayer(e_player, #"shield/playernotenough", e_player.BankCost);
                return 1;
            }
            else
            {
                self setcursorhint("HINT_NOICON");
                self sethintstringforplayer(e_player, #"shield/bankdep", e_player.BankMoney, e_player.BankCost);
                return 1;
            }
        }
    }
    else
    {
        if(isDefined(e_player.BankMoney))
        {
            if(e_player.BankMoney < e_player.BankCost)
            {
                self setcursorhint("HINT_NOICON");
                self sethintstringforplayer(e_player, #"shield/banknotenough", e_player.BankCost);
                return 1;
            }
            else
            {
                self setcursorhint("HINT_NOICON");
                self sethintstringforplayer(e_player, #"shield/bankwid", e_player.BankMoney, e_player.BankCost);
                return 1;
            }
        }
    }
}

CheckingTrigger()
{
    self endon(#"death");

    while(true)
    {
        waitresult = undefined;
        waitresult = self waittill(#"trigger");

        player = waitresult.activator;

        if(player.BankMode == 1)
        {
            if(isDefined(player.BankMoney))
            {
                if(player.BankMoney < player.BankCost)
                {
                    // ?? - not enough
                }
                else
                {
                    PlayerGiveScore(player.BankCost, player);
                    player playsoundtoplayer(#"zmb_cha_ching", player);
                    player.BankMoney = player.BankMoney - player.BankCost;
                }
            }
        }
        else
        {
            if(isDefined(player.BankMoney))
            {
                if(player.score > player.BankCost)
                {
                    PlayerGiveScore(player.BankCost * -1, player);
                    player playsoundtoplayer(#"zmb_cha_ching", player);
                    player.BankMoney = player.BankMoney + player.BankCost;
                }
            }
        }
        
        /#
        // save
        level.Saves.Money = player.BankMoney;
        ShieldToJson("T8BankSettings", level.Saves);
        #/

        player stats::set_stat(#"item_stats", #"sniper_locus_t8", #"challenges_tu", #"challengevalue", player.BankMoney);
    }
}

onPlayerConnect()
{
    
}

BankPlayerSpawned()
{
    self endon(#"death", "disconnect");

    self.BankMoney = self stats::get_stat(#"item_stats", #"sniper_locus_t8", #"challenges_tu", #"challengevalue");
    self.BankCost = 250;
    self.BankMode = 1;

    level flag::wait_till("initial_blackscreen_passed"); // waits for players
    wait 2;
    
    self iPrintLn("^0 Current Bank Money: " + self.BankMoney);
    while(true)
    {
        if(self MeleeButtonPressed())
         self.BankMode = self.BankMode == 1 ? 2 : 1;

        if(self AdsButtonPressed() && self.BankCost < 2500)
          self.BankCost = self.BankCost + 250;

        if(self AttackButtonPressed() && self.BankCost > 250)
          self.BankCost = self.BankCost - 250;
        
        //if (self useButtonPressed())
          //self BO4OriginPrint();

        wait 0.5;
    }
}

PlayerGiveScore(value, player)
{
    player zm_score::add_to_player_score(value);
}