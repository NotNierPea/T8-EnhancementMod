detour zm_audio<scripts\zm_common\zm_audio.gsc>::sndmusicsystem_playstate(state, var_ceca37b = 0) {
    if (state === "game_over" && GetDvarInt(#"shield_enh_Round_Music", 0) && !GetDvarInt(#"shield_enh_Round_Music_Normal_GameOver", 0))
    {
        PlayRandomGameOverMusic();
        return;
    }
    
    if (state === "game_over" && GetDvarInt(#"shield_enh_Round_Music", 0) && math::cointoss() && AnyGameoverDvarIsOn())
    {
        PlayRandomGameOverMusic();
        return;
    }

    return zm_audio::sndmusicsystem_playstate(state, var_ceca37b);
}

detour zm_audio<scripts\zm_common\zm_audio.gsc>::function_4138a262() {
    if(!GetDvarInt(#"shield_enh_Round_Music", 0)) 
        return zm_audio::function_4138a262();

    if (!isdefined(level.var_607bd5fb)) {
        level.var_607bd5fb = 0;
    }
    var_bf1569b1 = 0;
    var_3a6fab91 = zm_round_spawning::function_f6cd912d(1);
    if (isdefined(var_3a6fab91)) {
        var_f40360e8 = var_3a6fab91.n_round;
        if (isdefined(var_f40360e8) && level.round_number == var_f40360e8) {
            var_bf1569b1 = 1;
        }
    }
    if (isdefined(level.musicsystem.states[#"round_start_first"]) && level.round_number <= 1) {
        level thread zm_audio::sndmusicsystem_playstate("round_start_first");
        return;
    }
    if (var_bf1569b1) {
        level thread zm_audio::sndmusicsystem_playstate("round_start_special");
        level.var_607bd5fb = 1;
        return;
    }

    if(GetDvarInt(#"shield_enh_Round_Music", 0) && !GetDvarInt(#"shield_enh_Round_Music_Normal", 0) && level.FirstTime) 
    {
        PlayRandomStartMusic();
        return;
    }

    if(GetDvarInt(#"shield_enh_Round_Music", 0) && math::cointoss() && level.FirstTime) 
    {
        PlayRandomStartMusic();
        return;
    }

    level.FirstTime = true;

    level thread zm_audio::sndmusicsystem_playstate("round_start");
}

detour zm_audio<scripts\zm_common\zm_audio.gsc>::function_d0f5602a() {
    if(!GetDvarInt(#"shield_enh_Round_Music", 0)) 
        return zm_audio::function_d0f5602a();
    
    if (level.var_607bd5fb) {
        level thread zm_audio::sndmusicsystem_playstate("round_end_special");
        level.var_607bd5fb = 0;
        return;
    }

    if(GetDvarInt(#"shield_enh_Round_Music", 0) && !GetDvarInt(#"shield_enh_Round_Music_Normal", 0) && level.FirstTime) 
    {
        PlayRandomEndMusic();
        return;
    }

    if(GetDvarInt(#"shield_enh_Round_Music", 0) && math::cointoss() && level.FirstTime) 
    {
        PlayRandomEndMusic();
        return;
    }

    level.FirstTime = true;

    level thread zm_audio::sndmusicsystem_playstate("round_end");    
}

RoundMusicShouldPlay()
{
    if (isDefined(level.PracticeModeActive) && level.PracticeModeActive)
        return false;

    if (level flag::exists(#"boss_fight_started") && level flag::get(#"boss_fight_started"))
        return false;

    if (isDefined(level.musicsystemoverride) && level.musicsystemoverride)
        return false;
    
    if (isDefined(level.music_dont_play) && level.music_dont_play)
        return false;

    return true;
}

AnyGameoverDvarIsOn()
{
    if (GetDvarInt(#"shield_enh_Round_Music_Shadows_GameOver", 0))
    {
        return true;
    }

    if (GetDvarInt(#"shield_enh_Round_Music_Zet_GameOver", 0))
    {
        return true;
    }

    if (GetDvarInt(#"shield_enh_Round_Music_OG_GameOver", 0))
    {
        return true;
    }

    return false;
}

PlayRandomGameOverMusic()
{
    bundles_sounds = [];

    if (GetDvarInt(#"shield_enh_Round_Music_Shadows_GameOver", 0))
    {
        array::add(bundles_sounds, 41, true);
    }

    if (GetDvarInt(#"shield_enh_Round_Music_Zet_GameOver", 0))
    {
        array::add(bundles_sounds, 58, true);
    }

    if (GetDvarInt(#"shield_enh_Round_Music_OG_GameOver", 0))
    {
        array::add(bundles_sounds, 59, true);
    }

    SoundToPlay = array::random(bundles_sounds);

    // ignore checks -> true, to play in frontend lol
    if (isDefined(SoundToPlay))
        ShieldPlay(true, false, SoundToPlay, true);
}

PlayRandomStartMusic()
{
    bundles_sounds = [];

    if (GetDvarInt(#"shield_enh_Round_Music_Shadows", 0))
    {
        array::add(bundles_sounds, 30, true);
        array::add(bundles_sounds, 31, true);
        array::add(bundles_sounds, 32, true);
        array::add(bundles_sounds, 33, true);
        array::add(bundles_sounds, 34, true);
        array::add(bundles_sounds, 35, true);
        array::add(bundles_sounds, 36, true);
        array::add(bundles_sounds, 37, true);
    }

    if (GetDvarInt(#"shield_enh_Round_Music_Zet", 0))
    {
        array::add(bundles_sounds, 50, true);
        array::add(bundles_sounds, 51, true);
        array::add(bundles_sounds, 52, true);
        array::add(bundles_sounds, 53, true);
    }

    if (GetDvarInt(#"shield_enh_Round_Music_OG", 0))
    {
        array::add(bundles_sounds, 200, true);
    }

    SoundToPlay = array::random(bundles_sounds);

    if (isDefined(SoundToPlay) && RoundMusicShouldPlay())
        ShieldPlay(true, false, SoundToPlay);
}

PlayRandomEndMusic()
{
    bundles_sounds = [];

    if (GetDvarInt(#"shield_enh_Round_Music_Shadows", 0))
    {
        array::add(bundles_sounds, 38, true);
        array::add(bundles_sounds, 39, true);
        array::add(bundles_sounds, 40, true);
    }

    if (GetDvarInt(#"shield_enh_Round_Music_Zet", 0))
    {
        array::add(bundles_sounds, 55, true);
        array::add(bundles_sounds, 56, true);
        array::add(bundles_sounds, 57, true);
        array::add(bundles_sounds, 54, true);
    }

    if (GetDvarInt(#"shield_enh_Round_Music_OG", 0))
    {
        array::add(bundles_sounds, 201, true);
    }

    SoundToPlay = array::random(bundles_sounds);

    if (isDefined(SoundToPlay) && RoundMusicShouldPlay())
        ShieldPlay(true, false, SoundToPlay);
}

RoundMusic()
{
    level.FirstTime = false;

    if(!GetDvarInt(#"shield_enh_Round_Music", 0)) 
    {
        return;
    }

    // for ix
    level waittill(#"hash_4a06aa98c6c7b671");

    level.music_dont_play = true;
}