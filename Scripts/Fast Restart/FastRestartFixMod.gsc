FastRestartFixes()
{
    switch(BO4GetMap())
    {
        case "Tag":
        TagFastRestartFix();
        break;

        case "Voyage":
        VODFastRestartFix();
        break;
    }
}

TagFastRestartFix()
{
    OverrideQuest(#"hash_729a1e4eb041be9b", "step_1", &FuckOffZebra);
}

FuckOffZebra(b_skipped)
{
    wait 3;
    [[ @zm_orange_ee_misc<scripts\zm\zm_orange_ee_misc.gsc>::trinket_quest ]](0);
}

VODFastRestartFix()
{
    level.var_58bc5d04 = getTime();
}