--[[
      .\hksc.exe '.\Scripts\LoadoutMenu.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\LoadoutMenu.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

local WeaponCurrentTab = 0

------------------------

local function SendLoadoutOption(ID_Choice)
      CoD.BaseUtility.SendCustomMenuResponse(Engine[@"getprimarycontroller"](), "shield_enh_loadout", "blah", ID_Choice)
end

------------------------

DataSources.ShieldWeaponsListEmpty = DataSourceHelpers.ListSetup( "ShieldWeaponsListEmpty", function ( f3_arg0, f3_arg1 )
      local InfoMods = {}

      return InfoMods
end, true )

DataSources.ShieldWeaponsList = DataSourceHelpers.ListSetup( "ShieldWeaponsList", function ( f3_arg0, f3_arg1 )
      local TabID = WeaponCurrentTab
      CoD.EnhModPrintInfo("Getting weapon data for tab: " .. TabID)

      local InfoMods = {}

      -- Utility tab (TabID == 0)
      if TabID == 0 then
            -- Utility actions
            table.insert(InfoMods, {
                  models = {
                        title = "Unpack Current Weapon",
                        icon = "vulture_pap",
                        desc = "",
                        request_id = 0,
                        small_icon = true
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = "Pack Current Weapon (Repack++)",
                        icon = "vulture_pap",
                        desc = "",
                        request_id = 1,
                        small_icon = true
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = "Give AAT: Cryofreeze",
                        icon = @"t7_icon_zm_aat_thunder_wall",
                        desc = "",
                        request_id = 106,
                        small_icon = true
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = "Give AAT: Kill-O-Watt",
                        icon = @"t7_icon_zm_aat_dead_wire",
                        desc = "",
                        request_id = 107,
                        small_icon = true
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = "Give AAT: Fire Bomb",
                        icon = @"t7_icon_zm_aat_blast_furnace",
                        desc = "",
                        request_id = 108,
                        small_icon = true
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = "Give AAT: Brain Decay",
                        icon = @"t7_icon_zm_aat_turned",
                        desc = "",
                        request_id = 109,
                        small_icon = true
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = "Give Perk #1",
                        icon = "vulture_perk",
                        desc = "",
                        request_id = 102,
                        small_icon = true
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = "Give Perk #2",
                        icon = "vulture_perk",
                        desc = "",
                        request_id = 103,
                        small_icon = true
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = "Give Perk #3",
                        icon = "vulture_perk",
                        desc = "",
                        request_id = 104,
                        small_icon = true
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = "Give Perk #4",
                        icon = "vulture_perk",
                        desc = "",
                        request_id = 105,
                        small_icon = true
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = "Give Perks",
                        icon = "vulture_weap",
                        desc = "",
                        request_id = 2,
                        small_icon = true
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = "Remove Perks",
                        icon = "boss_lock",
                        desc = "",
                        request_id = 3,
                        small_icon = true
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = "Give Perkaholic",
                        icon = "ui_icon_elixirs_near_perkaholic",
                        desc = "",
                        request_id = 4,
                        small_icon = true
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = "Remove Shield",
                        icon = @"i_wpn_t8_sig_battle_shield_glass_c",
                        desc = "",
                        request_id = 101,
                        small_icon = false
                  },
                  properties = {}
            })

            -- classic perks
            if Engine[@"getdvarint"]("shield_enh_ClassicMode") == 1 then
                  table.insert(InfoMods, {
                        models = {
                              title = "Give Classic Perks",
                              icon = @"vulture_weap",
                              desc = "",
                              request_id = 110,
                              small_icon = true
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = "Give Juggernog",
                              icon = @"jugg_classic",
                              desc = "",
                              request_id = 111,
                              small_icon = true
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = "Give Double Tab",
                              icon = @"double_classic",
                              desc = "",
                              request_id = 112,
                              small_icon = true
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = "Give Who's Who",
                              icon = @"who_classic",
                              desc = "",
                              request_id = 113,
                              small_icon = true
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = "Give Elemental Pop",
                              icon = @"elem_classic",
                              desc = "",
                              request_id = 114,
                              small_icon = true
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = "Give Vulture Aid",
                              icon = @"vult_classic",
                              desc = "",
                              request_id = 115,
                              small_icon = true
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = "Give Speed Cola",
                              icon = @"speed_classic",
                              desc = "",
                              request_id = 116,
                              small_icon = true
                        },
                        properties = {}
                  })

                  table.insert(InfoMods, {
                        models = {
                              title = "Remove Classic Perks",
                              icon = @"boss_lock",
                              desc = "",
                              request_id = 117,
                              small_icon = true
                        },
                        properties = {}
                  })
            end

      -- Assault Rifles (TabID == 1)
      elseif TabID == 1 then
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_accurate_t8"),
                        icon = "ar_accurate_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 16,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_fastfire_t8"),
                        icon = "ar_fastfire_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 17,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_damage_t8"),
                        icon = "ar_damage_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 18,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_stealth_t8"),
                        icon = "ar_stealth_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 19,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_modular_t8"),
                        icon = "ar_modular_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 20,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_mg1909_t8"),
                        icon = "ui_icon_weapons_zm_armg1909",
                        desc = "",
                        request_id = 21,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_standard_t8"),
                        icon = "ar_standard_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 22,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_galil_t8"),
                        icon = "ar_galil_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 23,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_peacekeeper_t8"),
                        icon = "ar_peacekeeper_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 24,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_doublebarrel_t8"),
                        icon = "ar_doublebarrel_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 25,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_an94_t8"),
                        icon = "ar_an94_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 26,
                        small_icon = false
                  },
                  properties = {}
            })
      -- SMGs (TabID == 2)
      elseif TabID == 2 then
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_folding_t8"),
                        icon = "smg_folding_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 27,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_drum_pistol_t8"),
                        icon = @"hash_44f83df3c310dbec",
                        desc = "",
                        request_id = 28,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_accurate_t8"),
                        icon = "smg_accurate_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 29,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_fastfire_t8"),
                        icon = "smg_fastfire_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 30,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_capacity_t8"),
                        icon = "smg_capacity_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 31,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_handling_t8"),
                        icon = "smg_handling_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 32,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_standard_t8"),
                        icon = "smg_standard_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 33,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_minigun_t8"),
                        icon = "smg_minigun_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 34,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_vmp_t8"),
                        icon = "smg_vmp_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 35,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_fastburst_t8"),
                        icon = "smg_fastburst_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 36,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_mp40"),
                        icon = "ui_icon_weapon_smg_mp40_xl",
                        desc = "",
                        request_id = 37,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/smg_thompson"),
                        icon = "ui_icon_weapons_zm_thompson",
                        desc = "",
                        request_id = 70,
                        small_icon = false
                  },
                  properties = {}
            })
      -- Tactical Rifles (TabID == 3)
      elseif TabID == 3 then
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/tr_powersemi_t8"),
                        icon = "tr_powersemi_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 38,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/tr_longburst_t8"),
                        icon = "tr_longburst_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 39,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/tr_midburst_t8"),
                        icon = "tr_midburst_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 40,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/tr_damageburst_t8"),
                        icon = "tr_damageburst_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 46,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/tr_leveraction_t8"),
                        icon = "ui_icon_weapons_zm_trleveraction",
                        desc = "",
                        request_id = 47,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/tr_flechette_t8"),
                        icon = "tr_flechette_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 48,
                        small_icon = false
                  },
                  properties = {}
            })
      -- LMGs (TabID == 4)
      elseif TabID == 4 then
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/lmg_heavy_t8"),
                        icon = "lmg_heavy_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 41,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/lmg_spray_t8"),
                        icon = "lmg_spray_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 42,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/lmg_standard_t8"),
                        icon = "lmg_standard_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 43,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/lmg_double_t8"),
                        icon = "ui_icon_weapon_lmg_double_render_xl",
                        desc = "",
                        request_id = 59,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/lmg_stealth_t8"),
                        icon = "lmg_stealth_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 60,
                        small_icon = false
                  },
                  properties = {}
            })
      -- Snipers (TabID == 5)
      elseif TabID == 5 then
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/sniper_fastrechamber_t8"),
                        icon = "sniper_fastrechamber_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 49,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/sniper_powerbolt_t8"),
                        icon = "sniper_powerbolt_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 50,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/sniper_powersemi_t8"),
                        icon = "sniper_powersemi_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 51,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/sniper_quickscope_t8"),
                        icon = "sniper_quickscope_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 52,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/sniper_mini14_t8"),
                        icon = "sniper_mini14_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 53,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/sniper_locus_t8"),
                        icon = "sniper_locus_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 54,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/sniper_damagesemi_t8"),
                        icon = "sniper_damagesemi_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 55,
                        small_icon = false
                  },
                  properties = {}
            })
      elseif TabID == 6 then
            -- Shotguns
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/shotgun_pump_t8"),
                        icon = "shotgun_pump_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 11,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/shotgun_semiauto_t8"),
                        icon = "shotgun_semiauto_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 12,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/shotgun_trenchgun_t8"),
                        icon = @"hash_68919da50189b818",
                        desc = "",
                        request_id = 13,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/shotgun_fullauto_t8"),
                        icon = "shotgun_fullauto_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 14,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/shotgun_precision_t8"),
                        icon = "shotgun_precision_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 15,
                        small_icon = false
                  },
                  properties = {}
            })
      elseif TabID == 7 then
             -- Pistols
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/pistol_standard_t8"),
                        icon = "pistol_standard_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 44,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/pistol_topbreak_t8"),
                        icon = @"hash_7aaaacd7f5bba0c7",
                        desc = "",
                        request_id = 45,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/pistol_revolver_t8"),
                        icon = "pistol_revolver_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 56,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/pistol_burst_t8"),
                        icon = "pistol_burst_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 57,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/pistol_fullauto_t8"),
                        icon = "pistol_fullauto_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 58,
                        small_icon = false
                  },
                  properties = {}
            })
      elseif TabID == 8 then
            -- Launchers
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/launcher_standard_t8"),
                        icon = "launcher_standard_t8_camo_alfa_icon",
                        desc = "",
                        request_id = 10,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_73f926dd393ef4df"),
                        icon = @"ui_icon_weapons_zm_special_ballisticknife",
                        desc = "",
                        request_id = 68,
                        small_icon = false
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/special_crossbow_t8"),
                        icon = @"hash_100dddfed3d2a5c0",
                        desc = "",
                        request_id = 69,
                        small_icon = false
                  },
                  properties = {}
            })
            -- shield and stuff
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/riotshield"),
                        icon = @"i_wpn_t8_sig_battle_shield_glass_c",
                        desc = "",
                        request_id = 100,
                        small_icon = false
                  },
                  properties = {}
            })

            -- equipments
            local StoryID = CoD.ZMStoryUtility.GetCurrentMapStory()

            if StoryID == 1 then
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/homunculus"),
                              icon = @"ui_icon_equipment_zm_homunculus",
                              desc = "",
                              request_id = 61,
                              small_icon = true
                        },
                        properties = {}
                  })   
            else
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zombie/cymbal_monkey"),
                              icon = @"ui_icon_inventory_cymbal_monkey",
                              desc = "",
                              request_id = 62,
                              small_icon = true
                        },
                        properties = {}
                  })

                  -- rayguns
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ray_gun"),
                              icon = @"ui_icon_weapon_ray_gun_render",
                              desc = "",
                              request_id = 71,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ray_gun_mk2"),
                              icon = @"ui_icon_weapon_ray_gun_mk2_render",
                              desc = "",
                              request_id = 72,
                              small_icon = false
                        },
                        properties = {}
                  })
            end

            -- normal ones
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/fraggrenade"),
                        icon = @"ui_icon_equpiment_zm_frag",
                        desc = "",
                        request_id = 63,
                        small_icon = true
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/acid_bomb"),
                        icon = @"ui_icon_equpiment_zm_acid",
                        desc = "",
                        request_id = 64,
                        small_icon = true
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/claymore"),
                        icon = @"hash_624b6b9096319641",
                        desc = "",
                        request_id = 65,
                        small_icon = true
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/wraith_fire"),
                        icon = @"hash_430b55584d35cbc2",
                        desc = "",
                        request_id = 66,
                        small_icon = true
                  },
                  properties = {}
            })
            table.insert(InfoMods, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/mini_turret"),
                        icon = @"t7_hud_ks_auto_sentry",
                        desc = "",
                        request_id = 67,
                        small_icon = true
                  },
                  properties = {}
            })

            -- special map weapons here 60-idk
            if CoD.BO4GetMap() == "Voyage" then
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ww_tricannon_t8"),
                              icon = @"hash_5d6013ed244ad82e",
                              desc = "",
                              request_id = 90,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ww_tricannon_fire_t8"),
                              icon = @"hash_6f96f7b76789aac2",
                              desc = "",
                              request_id = 91,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ww_tricannon_earth_t8"),
                              icon = @"hash_24074854d000a742",
                              desc = "",
                              request_id = 92,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ww_tricannon_water_t8"),
                              icon = @"hash_2289301d453f2d17",
                              desc = "",
                              request_id = 93,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ww_tricannon_air_t8"),
                              icon = @"hash_25740919ad0c89d7",
                              desc = "",
                              request_id = 94,
                              small_icon = false
                        },
                        properties = {}
                  })
                  -- frost shield
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_49b2e832f765cb5"),
                              icon = @"i_wpn_t8_sig_battle_shield_glass_c",
                              desc = "",
                              request_id = 95,
                              small_icon = false
                        },
                        properties = {}
                  })
            end

            if CoD.BO4GetMap() == "Blood" then
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/blundergat"),
                              icon = @"ui_icon_weapons_zm_blundergat",
                              desc = "",
                              request_id = 90,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/acidgat"),
                              icon = @"ui_icon_weapons_zm_blundergat",
                              desc = "",
                              request_id = 91,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/magmagat"),
                              icon = @"ui_icon_weapons_zm_blundergat",
                              desc = "",
                              request_id = 92,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/tomahawk_upgraded"),
                              icon = @"ui_icon_equipment_zm_tomahawk",
                              desc = "",
                              request_id = 93,
                              small_icon = true
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5b5dc1454044a964"),
                              icon = @"hash_13ef923686346dc9",
                              desc = "",
                              request_id = 94,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"warzone/spknifeork_t8"),
                              icon = @"ui_icon_weapon_melee_spknifeork_render",
                              desc = "",
                              request_id = 95,
                              small_icon = false
                        },
                        properties = {}
                  })
            end

            if CoD.BO4GetMap() == "AE" then
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_eb276333b85f293"),
                              icon = @"ui_icon_weapons_zm_charon",
                              desc = "",
                              request_id = 90,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5e7b4f837b6c6744"),
                              icon = @"ui_icon_weapons_zm_gaia",
                              desc = "",
                              request_id = 91,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_523af889850e67e6"),
                              icon = @"hash_7eeafad2e284cab9",
                              desc = "",
                              request_id = 92,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_7022c47b56e0ed9f"),
                              icon = @"ui_icon_weapons_zm_ouranos",
                              desc = "",
                              request_id = 93,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zombie/thunderstorm"),
                              icon = @"ui_icon_inventory_zm_red_eqp_lightning_rod",
                              desc = "",
                              request_id = 94,
                              small_icon = true
                        },
                        properties = {}
                  })
                  
                  -- un-upgraded ones
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3aeda1b4f0b1547e"),
                              icon = @"ui_icon_weapons_zm_charon",
                              desc = "",
                              request_id = 95,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2e94430f1fc60691"),
                              icon = @"ui_icon_weapons_zm_gaia",
                              desc = "",
                              request_id = 96,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_367b6a2d351eb73f"),
                              icon = @"hash_7eeafad2e284cab9",
                              desc = "",
                              request_id = 97,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_38bc1e3aad78424a"),
                              icon = @"ui_icon_weapons_zm_ouranos",
                              desc = "",
                              request_id = 98,
                              small_icon = false
                        },
                        properties = {}
                  })
            end

            if CoD.BO4GetMap() == "IX" then
                 table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ww_crossbow_t8"),
                              icon = @"hash_38208b311390cffb",
                              desc = "",
                              request_id = 90,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ww_crossbow_t8_upgraded"),
                              icon = @"hash_38208b311390cffb",
                              desc = "",
                              request_id = 91,
                              small_icon = false
                        },
                        properties = {}
                  })
            end

            if CoD.BO4GetMap() == "Dead" then
                 table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4e413fbdde10b051"),
                              icon = @"hash_6c021551a1cc7457",
                              desc = "",
                              request_id = 90,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_25ddfdd724070696"),
                              icon = @"hash_45BC5C96B44A5900", -- C5BC5C96B44A5900
                              desc = "",
                              request_id = 91,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_7b8a03d0c40ea097"),
                              icon = @"hash_45BC5D96B44A5AB3", -- C5BC5D96B44A5AB3
                              desc = "",
                              request_id = 92,
                              small_icon = false
                        },
                        properties = {}
                  })

                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"shield/stake_knife"),
                              icon = @"ui_icon_zm_callings_knife",
                              desc = "",
                              request_id = 93,
                              small_icon = false
                        },
                        properties = {}
                  })
            end

            if CoD.BO4GetMap() == "Tag" then
                 table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/thundergun"),
                              icon = @"ui_icon_weapons_zm_thundergun",
                              desc = "",
                              request_id = 90,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zombie/tesla_gun"),
                              icon = @"hash_490135AAF2E50681",
                              desc = "",
                              request_id = 91,
                              small_icon = false
                        },
                        properties = {}
                  })

                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2283e591fbfea663"),
                              icon = @"hash_490135AAF2E50681",
                              desc = "",
                              request_id = 92,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/tundragun"),
                              icon = @"hash_25E0F029D4B69CE0",
                              desc = "",
                              request_id = 93,
                              small_icon = false
                        },
                        properties = {}
                  })

                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/music_box"),
                              icon = @"ui_icon_equipment_zm_music_box",
                              desc = "",
                              request_id = 94,
                              small_icon = true
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/nesting_doll_grenade"),
                              icon = @"ui_icon_equipment_zm_nesting_doll",
                              desc = "",
                              request_id = 95,
                              small_icon = true
                        },
                        properties = {}
                  })
            end

            if CoD.BO4GetMap() == "AO" then
                 table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ray_gun_mk2v"),
                              icon = @"ui_icon_weapon_ray_gun_mk2_xl",
                              desc = "",
                              request_id = 90,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ray_gun_mk2x"),
                              icon = @"ui_icon_weapon_ray_gun_mk2x_xl",
                              desc = "",
                              request_id = 91,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ray_gun_mk2y"),
                              icon = @"ui_icon_weapon_ray_gun_mk2y_xl",
                              desc = "",
                              request_id = 92,
                              small_icon = false
                        },
                        properties = {}
                  })
                  table.insert(InfoMods, {
                        models = {
                              title = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ray_gun_mk2z"),
                              icon = @"ui_icon_weapon_ray_gun_mk2z_xl",
                              desc = "",
                              request_id = 93,
                              small_icon = false
                        },
                        properties = {}
                  })
            end

      else
            -- fallback: show all weapons (for debug or if tab is unknown)
      end

	return InfoMods
end, true )

DataSources.ShieldWeaponFiltersEmpty = DataSourceHelpers.ListSetup( "ShieldWeaponFiltersEmpty", function ( f3_arg0, f3_arg1 )
	local filters = {

      }
	return filters
end, true )

DataSources.ShieldWeaponFilters = DataSourceHelpers.ListSetup( "ShieldWeaponFilters", function ( f3_arg0, f3_arg1 )
	local filters = {
            {
                  -- options
			models = {
				name = @"hash_2fa47140d97f89d",
				filter = 0
			},
                  properties = {
				filter = 0
			}
		},
		{
                  -- assult riflers
			models = {
				name = @"hash_7FE1B0B2003A6CC1",
				filter = 1
			},
                  properties = {
				filter = 1
			}

		},
            {
                  -- smgs
			models = {
				name = @"hash_35A1E94F52AC6DAB",
				filter = 2
			},
                  properties = {
				filter = 2
			}

		},
            {
                  -- tactical
			models = {
				name = @"hash_1FB38D2633FBBEC7",
				filter = 3
			},
                  properties = {
				filter = 3
			}

		},
            {
                  -- lmg
			models = {
				name = @"hash_6DB6F169E46CD4E4",
				filter = 4
			},
                  properties = {
				filter = 4
			}

		},
            {
                  -- snipers
			models = {
				name = @"hash_2EF865AD574F5FAD",
				filter = 5
			},
                  properties = {
				filter = 5
			}

		},
            {
                  -- shotguns
			models = {
				name = @"hash_247a4bc3a33f5efc",
				filter = 6
			},
                  properties = {
				filter = 6
			}

		},
            {
                  -- pistols
			models = {
				name = @"hash_31f931942007cab9",
				filter = 7
			},
                  properties = {
				filter = 7
			}

		},
            {
                  -- secondries
			models = {
				name = @"hash_5B00F60446232842",
				filter = 8
			},
                  properties = {
				filter = 8
			}

		}
	}
	return filters
end, true )

------------------------

-- weapons tab and shit
CoD.WeaponsListData = InheritFrom( LUI.UIElement )
CoD.WeaponsListData.__defaultWidth = 1600
CoD.WeaponsListData.__defaultHeight = 620
CoD.WeaponsListData.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.WeaponsListData )
	self.id = "WeaponsListData"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true

	-------------------------

	-- request datasource
      local WeaponsList = LUI.UIList.new( f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false )
	WeaponsList:setLeftRight( 0.5, 0.5, -1300, 1300 )
	WeaponsList:setTopBottom( 0, 0, 350, 840 )
	WeaponsList:setVerticalCount(4)
	WeaponsList:setHorizontalCount(4)
      WeaponsList:setAutoScaleContent( true )
	WeaponsList:setSpacing( 30 )
      --WeaponsList:setScale(0.75, 0.75)
	WeaponsList:setWidgetType( CoD.Shield_WeaponsStyleMain )
	WeaponsList:setVerticalCounter( CoD.verticalCounter )
	WeaponsList:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	WeaponsList:setDataSource( "ShieldWeaponsListEmpty" )

	f1_arg0:AddButtonCallbackFunction( WeaponsList, f1_arg1, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function ( element, menu, controller, model )
		if not MenuPropertyIsTrue(f1_arg0, "m_inputDisabled") then
			PlaySoundAlias( "uin_toggle_generic" )
			
			-- get request id
                  local request_id_get = element:getModel(model, "request_id")
                  local request_id = request_id_get:get()

			CoD.EnhModPrintInfo("request id", request_id)

                  SendLoadoutOption(request_id)

			return true
		else
			
		end
	end, function ( element, menu, controller )
		if true then
			CoD.Menu.SetButtonLabel( menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], @"hash_6D0BB36CD318F55F", nil, "ui_confirm" )
			return true
		else
			return false
		end
	end, false )

	self:addElement( WeaponsList )
	self.WeaponsList = WeaponsList

      WeaponsList.id = "WeaponsList"

      -- tabs for datasource
      local WeaponsTabs = CoD.Common_Tabbar_Center.new( f1_arg0, f1_arg1, 0.5, 0.5, -480, 480, 0.5, 0.5, -361.5 + 100, -300.5 + 100 )

      WeaponsTabs.left:mergeStateConditions( {
		{
			stateName = "Disabled",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		}
	} )
      WeaponsTabs.right:mergeStateConditions( {
		{
			stateName = "Disabled",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		}
	} )

	WeaponsTabs.Tabs.grid:setHorizontalCount( 7 )
      WeaponsTabs.Tabs.grid:setVerticalCount( 1 )
	WeaponsTabs.Tabs.grid:setDataSource( "ShieldWeaponFiltersEmpty" )
      WeaponsTabs:registerEventHandler( "list_active_changed", function ( element, event )
            CoD.EnhModPrintInfo("Updating Weapon tab", element.filter)
            WeaponCurrentTab = element.filter

            self.WeaponsList:setDataSource("")
            self.WeaponsList:setDataSource( "ShieldWeaponsList" )

		self.WeaponsList:updateDataSource()
            self.WeaponsList:updateCounters()
	end )
	self:addElement( WeaponsTabs )
	self.WeaponsTabs = WeaponsTabs

      WeaponsTabs.id = "WeaponsTabs"

	-------------------------

	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end

	return self
end

CoD.WeaponsListData.__onClose = function ( f9_arg0 )
	
end

CoD.EnhLoadoutOptions = InheritFrom( LUI.UIElement )
CoD.EnhLoadoutOptions.__defaultWidth = 1920
CoD.EnhLoadoutOptions.__defaultHeight = 1080
CoD.EnhLoadoutOptions.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.EnhLoadoutOptions )
	self.id = "EnhLoadoutOptions"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )

      CoD.EnhModPrintInfo("setting up loadout shit")

      -------------------------------

      -- some background ig
      local Backer = LUI.UIImage.new( 0.5, 0.5, -950, 950, 0.5, 0.5, -400, 500 )
      Backer:setImage( RegisterImage( @"enh_blood_ammo" ) )
      Backer:setAlpha(0.85)
      Backer:setRGB(1, 1, 1)
      self:addElement( Backer )
      self.Backer = Backer

      -- test button
      local CloseButton = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.5, 0.5, 0 - 760 + 230, 300 - 760 + 230, 0.5, 0.5, 0 - 330, 50 - 330)

	CloseButton.MiddleText:setTTF( "shield_mom" )
	CloseButton.MiddleText:setText("Close Menu")

	CloseButton.MiddleTextFocus:setText("Close Menu")
	CloseButton.MiddleTextFocus:setTTF( "shield_mom" )
	
	CloseButton:linkToElementModel( self, nil, false, function ( model )
		CloseButton:setModel( model, f1_arg1 )
	end )
	self:addElement( CloseButton )
	self.CloseButton = CloseButton

      f1_arg0:AddButtonCallbackFunction( CloseButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
            if not MenuPropertyIsTrue(f1_arg0, "m_inputDisabled") then
                  PlaySoundAlias( "uin_paint_image_flip_toggle" )
                  CoD.EnhModPrintInfo("CloseButton")

                  -- Fade out animation
                  self:beginAnimation("fadeout", 300)
                  self:setAlpha(0)

                  LockInput( self, f1_arg1, false )
			SetAllowCursorMovement( f1_arg0, false )
                  SetMenuProperty( f1_arg0, "m_inputDisabled", true )

                  Engine[@"setdvar"]("ui_drawcrosshair", 1)

                  return true
            end
                  return false
      end, function ( element, menu, controller )
                  CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm" )
                  return false
      end, false )

	CloseButton.id = "CloseButton"

      local WeaponsStuff = CoD.WeaponsListData.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -500, 500)
      self:addElement(WeaponsStuff)
      self.WeaponsStuff = WeaponsStuff

      WeaponsStuff.id = "WeaponsStuff"

      -- shield_enh_loadout_request if 1
      -- SendLoadoutOption(id)

      local LoadoutText = LUI.UIText.new(0.5, 0.5, -125, 250, 0.5, 0.5, -330, -290)
      LoadoutText:setTTF("notosans_bold")
      LoadoutText:setText("Loadout Options")

      LoadoutText:setShaderVector(0, 0, 0, 0, 0)
      LoadoutText:setShaderVector(1, 0.5, 0, 0, 0)
      LoadoutText:setShaderVector(2, 0, 0, 0, 0)
      LoadoutText:setShaderVector(3, 0, 0, 0, 0)
      LoadoutText:setShaderVector(4, 0, 0, 0, 0)

      self:addElement(LoadoutText)
      self.LoadoutText = LoadoutText

      LoadoutText:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
                        if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"shield_enh_loadout_request" ) then
                              local scriptData = CoD.GetScriptNotifyData(model)
                              
                              local id = scriptData[1]

                              if id == 1 then
                                    self:beginAnimation("fadein", 300)
                                    self:setAlpha(1)

                                    LockInput( self, f1_arg1, true )
			                  SetAllowCursorMovement( f1_arg0, true )
                                    SetMenuProperty( f1_arg0, "m_inputDisabled", false )

                                    self.WeaponsStuff.WeaponsTabs.Tabs.grid:setDataSource( "ShieldWeaponFilters" )
                                    self.WeaponsStuff.WeaponsTabs.Tabs.grid:updateDataSource()

                                    self.WeaponsStuff.WeaponsList:setDataSource("ShieldWeaponsList")
                                    self.WeaponsStuff.WeaponsList:updateDataSource()

                                    Engine[@"setdvar"]("ui_drawcrosshair", 0)
                              else
                                    self:beginAnimation("fadeout", 300)
                                    self:setAlpha(0)

                                    LockInput( self, f1_arg1, false )
			                  SetAllowCursorMovement( f1_arg0, false )
                                    SetMenuProperty( f1_arg0, "m_inputDisabled", true )
                                    
                                    self.WeaponsStuff.WeaponsTabs.Tabs.grid:setDataSource( "ShieldWeaponFiltersEmpty" )
                                    self.WeaponsStuff.WeaponsTabs.Tabs.grid:updateDataSource()

                                    self.WeaponsStuff.WeaponsList:setDataSource("ShieldWeaponsListEmpty")
                                    self.WeaponsStuff.WeaponsList:updateDataSource()

                                    Engine[@"setdvar"]("ui_drawcrosshair", 1)
                              end
                        end
                  end)
      
      LoadoutText.id = "LoadoutText"

      -------------------------------

      f1_arg0:AddButtonCallbackFunction( self, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function ( element, menu, controller, model )
            if not MenuPropertyIsTrue(f1_arg0, "m_inputDisabled") then
                  self:beginAnimation("fadeout", 300)
                  PlaySoundAlias( "uin_paint_image_flip_toggle" )
                  CoD.EnhModPrintInfo("CloseButtonKey")

                  -- Fade out animation
                  self:beginAnimation("fadeout", 300)
                  self:setAlpha(0)

                  LockInput( self, f1_arg1, false )
                  SetAllowCursorMovement( f1_arg0, false )
                  SetMenuProperty( f1_arg0, "m_inputDisabled", true )

                  self.WeaponsStuff.WeaponsTabs.Tabs.grid:setDataSource( "ShieldWeaponFiltersEmpty" )
                  self.WeaponsStuff.WeaponsTabs.Tabs.grid:updateDataSource()

                  self.WeaponsStuff.WeaponsList:setDataSource("ShieldWeaponsListEmpty")
                  self.WeaponsStuff.WeaponsList:updateDataSource()

                  Engine[@"setdvar"]("ui_drawcrosshair", 1)
                  return true
            else

            end
	end, function ( element, menu, controller )
		return true
	end, false )

      LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )

      if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end

      self.__defaultFocus = CloseButton
	
      --SetElementProperty( self, "demoShowMouse", true )
	SetMenuProperty( f1_arg0, "m_inputDisabled", true )

      self:setAlpha(0)

	return self
end

CoD.EnhLoadoutOptions.__resetProperties = function ( f16_arg0 )
	
end

CoD.EnhLoadoutOptions.__clipsPerState = {

}

CoD.EnhLoadoutOptions.__onClose = function ( f19_arg0 )

end