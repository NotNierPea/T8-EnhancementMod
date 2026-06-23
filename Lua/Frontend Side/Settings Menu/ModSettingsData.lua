--[[
      .\hksc.exe '.\Lua\Frontend Side\ModSettingsData.lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\ModSettingsData.luac'
]]

------------------------

if not CoD.isFrontend then
    return
end

CoD.InitEnhLuaFile()

------------------------

local JSON_PATH = "project-bo4/saved/server/EnhancementMain.json"
local CTRL      = Engine[@"getprimarycontroller"]()

local function ReadJson( dvar, key, type, default )
    Engine[@"exec"]( CTRL, ('readjson %s "" %s %s %s false %s'):format(dvar, key, type, tostring(default), JSON_PATH) ) -- string.format
end

------------------------

local CHOICES = {
    toggle = {
        { option = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_94EB0E3329EDF5F" ), value = 0, default = true },
        { option = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/enabled" ),          value = 1 },
    },
    toggle_on = {
        { option = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_94EB0E3329EDF5F" ), value = 0 },
        { option = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/enabled" ),          value = 1, default = true },
    },
}

-- colors
local COLOR_CHOICES = {
    { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/Red" ),    value = 1, default = true },
    { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/Black" ),  value = 0 },
    { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/Green" ),  value = 2 },
    { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/Yellow" ), value = 3 },
    { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/Blue" ),   value = 4 },
    { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/Cyan" ),   value = 5 },
    { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/Pink" ),   value = 6 },
    { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/White" ),  value = 7 },
    { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/Grey" ),   value = 9 },
}

------------------------

-- all settings
local SETTINGS = {
    Online = {
        { name = @"shield/lobbyalwaysjoinable",  desc = @"shield/lobbyalwaysjoinable_desc",  dvar = "shield_enh_LobbyAlwaysJoinable",  choices = "toggle" },
        { name = @"shield/shield_publicpause",   desc = @"shield/shield_publicpause_desc",   dvar = "shield_enh_ShieldPublicPause",    choices = "toggle" },
        { name = @"shield/lui_debug",            desc = @"shield/lui_debug_desc",            dvar = "shield_enh_lui_debug",            choices = "toggle" },
    },
    Gamemode = {
        { name = @"shield/ee_alwaysenabled",     desc = @"shield/ee_alwaysenabled_desc",     dvar = "shield_enh_EE_AlwaysEnabled",     choices = "toggle" },
        { name = @"shield/bankmoney",            desc = @"shield/bankmoney_desc",            dvar = "shield_enh_BankMoney",            choices = "toggle" },
        { name = @"shield/dropweapons",          desc = @"shield/dropweapons_desc",          dvar = "shield_enh_DropWeapons",          choices = "toggle" },
        { name = @"shield/allweapons_in_box",    desc = @"shield/allweapons_in_box_desc",    dvar = "shield_enh_AllWeaponsinBox",      choices = "toggle" },
        { name = @"shield/boxpatch",             desc = @"shield/boxpatch_desc",             dvar = "shield_enh_BoxPatch",             choices = "toggle" },
        { name = @"shield/damagepoints",         desc = @"shield/damagepoints_desc",         dvar = "shield_enh_DamagePoints",         choices = "toggle" },
        { name = @"shield/perka",                desc = @"shield/perka_desc",                dvar = "shield_enh_Perka",                choices = "toggle" },
        { name = @"shield/superperk",            desc = @"shield/superperk_desc",            dvar = "shield_enh_SuperPerkMode",        choices = "toggle" },
        { name = @"shield/five_early_ee",        desc = @"shield/five_early_ee_desc",        dvar = "shield_enh_five_early_ee",        choices = "toggle" },
        { name = @"shield/second_grenade",       desc = @"shield/second_grenade_desc",       dvar = "shield_enh_second_grenade",       choices = "toggle" },
        { name = @"shield/mainquest_continue",   desc = @"shield/mainquest_continue_desc",   dvar = "shield_enh_MainQuestContinue",    choices = "toggle" },
    },
    Directed = {
        { name = @"shield/directed_mode",          desc = @"shield/directed_mode_desc",          dvar = "shield_enh_DirectedMode",          choices = "toggle" },
        { name = @"shield/directed_mode_roundcap", desc = @"shield/directed_mode_roundcap_desc", dvar = "shield_enh_DirectedMode_RoundCap", choices = "toggle", json_default = true },
    },
    Challenges = {
        --{ name = @"shield/variators",        desc = @"shield/variators_desc",        dvar = "shield_enh_Variators",      choices = "toggle" },
        { name = @"shield/superrealistic",   desc = @"shield/superrealistic_desc",   dvar = "shield_enh_SuperRealistic", choices = "toggle" },
        { name = @"shield/rampage",          desc = @"shield/rampage_desc",          dvar = "shield_enh_RampageMode",    choices = "toggle" },
        { name = @"shield/hardcore_bosses",  desc = @"shield/hardcore_bosses_desc",  dvar = "shield_enh_Hardcore_Bosses",choices = "toggle" },
        { name = @"shield/practice_bosses",  desc = @"shield/practice_bosses_desc",  dvar = "shield_enh_Practice_Bosses",choices = "toggle" },
        { name = @"shield/team_cranked",     desc = @"shield/team_cranked_desc",     dvar = "shield_enh_TeamCranked",    choices = "toggle" },
    },
    Round = {
        { name = @"shield/round_music",                  desc = @"shield/round_music_desc",                  dvar = "shield_enh_Round_Music",                 choices = "toggle" },
        { name = @"shield/round_music_normal",           desc = @"shield/round_music_normal_desc",           dvar = "shield_enh_Round_Music_Normal",          choices = "toggle" },
        { name = @"shield/round_music_normal_gameover",  desc = @"shield/round_music_normal_gameover_desc",  dvar = "shield_enh_Round_Music_Normal_GameOver", choices = "toggle" },
        { name = @"shield/round_music_shadows",          desc = @"shield/round_music_shadows_desc",          dvar = "shield_enh_Round_Music_Shadows",         choices = "toggle" },
        { name = @"shield/round_music_shadows_gameover", desc = @"shield/round_music_shadows_gameover_desc", dvar = "shield_enh_Round_Music_Shadows_GameOver",choices = "toggle" },
        { name = @"shield/round_music_zet",              desc = @"shield/round_music_zet_desc",              dvar = "shield_enh_Round_Music_Zet",             choices = "toggle" },
        { name = @"shield/round_music_zet_gameover",     desc = @"shield/round_music_zet_gameover_desc",     dvar = "shield_enh_Round_Music_Zet_GameOver",   choices = "toggle" },
        { name = @"shield/round_music_og",               desc = @"shield/round_music_og_desc",               dvar = "shield_enh_Round_Music_OG",              choices = "toggle" },
        { name = @"shield/round_music_og_gameover",      desc = @"shield/round_music_og_gameover_desc",      dvar = "shield_enh_Round_Music_OG_GameOver",    choices = "toggle" },
    },
    Announcer = {
        { name = @"shield/custom_vos",        desc = @"shield/custom_vos_desc",        dvar = "shield_enh_CustomVO_Power",        choices = "toggle" },
        { name = @"shield/custom_vos_normal", desc = @"shield/custom_vos_normal_desc", dvar = "shield_enh_CustomVO_Power_Normal", choices = "toggle" },
        { name = @"shield/custom_vos_crank",  desc = @"shield/custom_vos_crank_desc",  dvar = "shield_enh_CustomVO_Power_Crank",  choices = "toggle" },
        { name = @"shield/custom_vos_bo6",    desc = @"shield/custom_vos_bo6_desc",    dvar = "shield_enh_CustomVO_Power_BO6",    choices = "toggle" },
    },
    UI = {
        { name = @"shield/althud",                desc = @"shield/althud_desc",                dvar = "shield_enh_AltHud",              choices = "toggle" },
        { name = @"shield/remove_blackscreen",    desc = @"shield/remove_blackscreen_desc",    dvar = "shield_enh_RemoveBlackScreen",   choices = "toggle" },
        { name = @"shield/gameover_options",      desc = @"shield/gameover_options_desc",      dvar = "shield_enh_GameOverOptions",     choices = "toggle" },
        { name = @"shield/counter_zombie",        desc = @"shield/counter_zombie_desc",        dvar = "shield_enh_Counter_Enabled",     choices = "toggle" },
        { name = @"shield/ShowTimer",             desc = @"shield/ShowTimer_desc",             dvar = "shield_enh_ShowTimer",           choices = "toggle" },
        { name = @"shield/zmbbars",               desc = @"shield/zmbbars_desc",               dvar = "shield_enh_HealthBars",          choices = "toggle" },
        { name = @"shield/zmbdamage",             desc = @"shield/zmbdamage_desc",             dvar = "shield_enh_DamageNumbers",       choices = "toggle" },
        { name = @"shield/movie_disable",         desc = @"shield/movie_disable_desc",         dvar = "shield_enh_MovieDisable",        choices = "toggle" },
        { name = @"shield/loading_custom_screen", desc = @"shield/loading_custom_screen_desc", dvar = "shield_enh_LoadingCustomScreen", choices = "toggle_on", json_default = true },
        { name = @"shield/tips_chat",             desc = @"shield/tips_chat_desc",             dvar = "shield_enh_TipsChat",            choices = "toggle_on", json_default = true },
        { name = @"shield/powerups_timer",        desc = @"shield/powerups_timer_desc",        dvar = "shield_enh_PowerUpsTimer",       choices = "toggle_on", json_default = true },
        { name = @"shield/attachmentslimit",      desc = @"shield/attachmentslimit_desc",      dvar = "shield_enh_AttachmentsLimit",    choices = "toggle" },
    },
    UIConfig = {
        { name = @"shield/subtitles_color",         desc = @"shield/subtitles_color_desc",         dvar = "shield_enh_Subtitles_Color",             json_type = "uint64_t", json_default = 1,
            choices = {
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/Cyan" ),    value = 0, default = true },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/Default" ), value = 1 },
            }
        },
        { name = @"shield/subtitles_font",          desc = @"shield/subtitles_font_desc",          dvar = "shield_enh_Subtitles_FontStyle",         json_type = "uint64_t", json_default = 1,
            choices = {
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/zmbdamage_font2" ), value = 0, default = true },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/zmbdamage_font3" ), value = 1 },
            }
        },
        { name = @"shield/RoundColor",              desc = @"shield/RoundColor_desc",              dvar = "shield_enh_RoundColor",                  json_type = "uint64_t", json_default = 4,
            choices = {
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/Pink" ),    value = 1, default = true },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/Blue" ),    value = 2 },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/Green" ),   value = 3 },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/Default" ), value = 4 },
            }
        },
        { name = @"shield/althud_interaction_font", desc = @"shield/althud_interaction_font_desc", dvar = "shield_enh_Althud_Interaction_FontStyle", json_type = "uint64_t", json_default = 1,
            choices = {
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/althud_interaction_font1" ), value = 0, default = true },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/althud_interaction_font2" ), value = 1 },
            }
        },
        { name = @"shield/counter_textcolor",       desc = @"shield/counter_textcolor",            dvar = "shield_enh_Counter_TextColor",           json_type = "uint64_t", json_default = 1, choices = COLOR_CHOICES },
        { name = @"shield/counter_numbercolor",     desc = @"shield/counter_numbercolor",          dvar = "shield_enh_Counter_NumberColor",         json_type = "uint64_t", json_default = 1, choices = COLOR_CHOICES },
        { name = @"shield/counter_font",            desc = @"shield/counter_font",                 dvar = "shield_enh_Counter_FontStyle",           json_type = "uint64_t", json_default = 1,
            choices = {
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/font1" ), value = 1, default = true },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/font2" ), value = 2 },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/font3" ), value = 3 },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/font4" ), value = 4 },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/font5" ), value = 5 },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/font6" ), value = 7 },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/font7" ), value = 6 },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/font8" ), value = 8 },
            }
        },
        { name = @"shield/counter_position",        desc = @"shield/counter_position_desc",        dvar = "shield_enh_Counter_Position",            json_type = "uint64_t", json_default = 1,
            choices = {
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/pos1" ), value = 1, default = true },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/pos2" ), value = 2 },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/pos3" ), value = 3 },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/pos4" ), value = 4 },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/pos5" ), value = 5 },
            }
        },
        { name = @"shield/counter_onlyzmb",         desc = @"shield/counter_onlyzmb",              dvar = "shield_enh_Counter_OnlyRemainingZombies", choices = "toggle" },
        { name = @"shield/zmbdamage_font",          desc = @"shield/zmbdamage_font_desc",          dvar = "shield_enh_Damage_FontStyle",            json_type = "uint64_t", json_default = 1,
            choices = {
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/zmbdamage_font1" ), value = 0, default = true },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/zmbdamage_font2" ), value = 1 },
                { option = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/zmbdamage_font3" ), value = 2 },
            }
        },
    },
    Classic = {
        { name = @"shield/classicmode",       desc = @"shield/classicmode_desc",       dvar = "shield_enh_ClassicMode",            choices = "toggle" },
        { name = @"shield/classicmode_gums",  desc = @"shield/classicmode_gums_desc",  dvar = "shield_enh_Gums",                   choices = "toggle" },
        { name = @"shield/classic_loadouts",  desc = @"shield/classic_loadouts_desc",  dvar = "shield_enh_ClassicMode_Loadouts",   choices = "toggle", json_default = true },
        { name = @"shield/double_tab_toggle", desc = @"shield/double_tab_toggle_desc", dvar = "shield_enh_ClassicMode_DoubleTab2", choices = "toggle" },
    },
}

-- lookup for classic realted ig
local SETTINGS_BY_DVAR = {}
for _, settings_array in pairs(SETTINGS) do
    for _, setting in ipairs(settings_array) do
        SETTINGS_BY_DVAR[setting.dvar] = setting
    end
end

-- load dvars
for _, settings_array in pairs(SETTINGS) do
    for _, setting in ipairs(settings_array) do
        local jtype   = setting.json_type    or "bool"
        local jdefault= setting.json_default or false
        -- strip "shield_enh_" prefix to get the json key
        local key = setting.dvar:match("^shield_enh_(.+)$") or setting.dvar
        ReadJson( setting.dvar, key, jtype, jdefault )
    end
end

Engine[@"setdvar"]( "shield_search_settings", "" )

------------------------

-- helpres
local function ResolveChoices( setting )
    if type(setting.choices) == "string" then
        return CHOICES[setting.choices]
    end
    return setting.choices
end

local function InsertSetting( list, controller, setting )
    table.insert( list, CoD.OptionsUtility.CreateDvarSettings(
        controller,
        setting.name,
        setting.desc,
        setting.dvar,
        setting.dvar,
        ResolveChoices(setting),
        nil,
        CoD.OnModDataChange
    ))
end

local function BuildSettingsList( controller, categories )
    local list = {}
    for _, category in ipairs(categories) do
        for _, setting in ipairs(category) do
            InsertSetting(list, controller, setting)
        end
    end
    return list
end

local function SetupSubscription( arg0, arg1, arg2 )
    local model = Engine[@"createmodel"]( Engine[@"getglobalmodel"](), "GametypeSettings.Update" )
    if arg1.updateSubscription then
        arg1:removeSubscription(arg1.updateSubscription)
    end
    arg1.updateSubscription = arg1:subscribeToModel(model, function()
        arg1:updateDataSource()
    end, false)
end

local function MakeDataSource( sourceName, categories )
    return DataSourceHelpers.ListSetup( sourceName, function( controller )
        return BuildSettingsList(controller, categories)
    end, nil, nil, SetupSubscription )
end

-- Datasources
DataSources.OnlineSettingsData    = MakeDataSource( "OnlineSettingsData",    { SETTINGS.Online } )
DataSources.GamemodeSettingsData  = MakeDataSource( "GamemodeSettingsData",  { SETTINGS.Gamemode } )
DataSources.DirectedSettingsData  = MakeDataSource( "DirectedSettingsData",  { SETTINGS.Directed } )
DataSources.ChallengeSettingsData = MakeDataSource( "ChallengeSettingsData", { SETTINGS.Challenges } )
DataSources.RoundSettingsData     = MakeDataSource( "RoundSettingsData",     { SETTINGS.Round } )
DataSources.AnnouncerSettingsData = MakeDataSource( "AnnouncerSettingsData", { SETTINGS.Announcer } )
DataSources.UISettingsData        = MakeDataSource( "UISettingsData",        { SETTINGS.UI } )
DataSources.UISettingsConfigData  = MakeDataSource( "UISettingsConfigData",  { SETTINGS.UIConfig } )
DataSources.ShieldClassicSettings = MakeDataSource( "ShieldClassicSettings", { SETTINGS.Classic } )

-- Classic Related
DataSources.ShieldClassicSettingsRelated = DataSourceHelpers.ListSetup( "ShieldClassicSettingsRelated", function( controller )
    local list = {}
    for _, dvar in ipairs({
        "shield_enh_Perka",
        "shield_enh_AllWeaponsinBox",
        "shield_enh_AltHud",
        "shield_enh_second_grenade",
    }) do
        InsertSetting(list, controller, SETTINGS_BY_DVAR[dvar])
    end
    return list
end, nil, nil, SetupSubscription )

-- Search
DataSources.SearchSettingsData = DataSourceHelpers.ListSetup( "SearchSettingsData", function( controller )
    local list = {}
    local query = string.lower( Dvar[@"shield_search_settings"]:get() or "" )

	for _, settings_array in pairs(SETTINGS) do
		for _, setting in ipairs(settings_array) do
            if query == "" or
               string.find( string.lower(Engine[@"localize"](setting.name)), query, 1, true ) or
               string.find( string.lower(Engine[@"localize"](setting.desc)), query, 1, true )
            then
                InsertSetting(list, controller, setting)
            end
        end
    end

    if CoD.SettingsSearchNoRes_Global ~= nil then
        CoD.SettingsSearchNoRes_Global:setAlpha(#list == 0 and 1 or 0)
    end

    return list
end, nil, nil, SetupSubscription )