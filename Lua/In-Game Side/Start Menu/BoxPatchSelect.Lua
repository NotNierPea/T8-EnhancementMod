--[[
      .\hksc.exe '.\Scripts\BoxPatchSelect.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\BoxPatchSelect.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

local function SendBoxPatchOption(Index_Weapon, ID_Choice)
      CoD.BaseUtility.SendCustomMenuResponse(Engine[@"getprimarycontroller"](), "shield_enh_boxpatch", Index_Weapon, ID_Choice)
end

------------------------

DataSources.ShieldWeaponMainIndexesBoxPatches = DataSourceHelpers.ListSetup( "ShieldWeaponMainIndexesBoxPatches", function ( f3_arg0, f3_arg1 )
      local InfoWeapons = {}

      table.insert(InfoWeapons, {
                  models = {
                        title = "",
                        icon = "",
                        index_id = 0
                  },
                  properties = {}
            })
      table.insert(InfoWeapons, {
                  models = {
                        title = "",
                        icon = "",
                        index_id = 1
                  },
                  properties = {}
            })
      table.insert(InfoWeapons, {
                  models = {
                        title = "",
                        icon = "",
                        index_id = 2
                  },
                  properties = {}
            })

      return InfoWeapons
end, true )

DataSources.ShieldWeaponsListBoxPatch = DataSourceHelpers.ListSetup( "ShieldWeaponsListBoxPatch", function ( f3_arg0, f3_arg1 )
      local filters = {}

      -- Assault Rifles
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_accurate_t8"),
                  image = "ar_accurate_t8_camo_alfa_icon",
                  request_id = 16,
                  item_index = 16,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_fastfire_t8"),
                  image = "ar_fastfire_t8_camo_alfa_icon",
                  request_id = 17,
                  item_index = 17,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_damage_t8"),
                  image = "ar_damage_t8_camo_alfa_icon",
                  request_id = 18,
                  item_index = 18,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_stealth_t8"),
                  image = "ar_stealth_t8_camo_alfa_icon",
                  request_id = 19,
                  item_index = 19,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_modular_t8"),
                  image = "ar_modular_t8_camo_alfa_icon",
                  request_id = 20,
                  item_index = 20,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_mg1909_t8"),
                  image = "ui_icon_weapons_zm_armg1909",
                  request_id = 21,
                  item_index = 21,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_standard_t8"),
                  image = "ar_standard_t8_camo_alfa_icon",
                  request_id = 22,
                  item_index = 22,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_galil_t8"),
                  image = "ar_galil_t8_camo_alfa_icon",
                  request_id = 23,
                  item_index = 23,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_peacekeeper_t8"),
                  image = "ar_peacekeeper_t8_camo_alfa_icon",
                  request_id = 24,
                  item_index = 24,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_doublebarrel_t8"),
                  image = "ar_doublebarrel_t8_camo_alfa_icon",
                  request_id = 25,
                  item_index = 25,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ar_an94_t8"),
                  image = "ar_an94_t8_camo_alfa_icon",
                  request_id = 26,
                  item_index = 26,
                  active = false,
                  is_small = false
            },
            properties = {}
      })

      -- SMGs
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_folding_t8"),
                  image = "smg_folding_t8_camo_alfa_icon",
                  request_id = 27,
                  item_index = 27,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_drum_pistol_t8"),
                  image = @"hash_44f83df3c310dbec",
                  request_id = 28,
                  item_index = 28,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_accurate_t8"),
                  image = "smg_accurate_t8_camo_alfa_icon",
                  request_id = 29,
                  item_index = 29,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_fastfire_t8"),
                  image = "smg_fastfire_t8_camo_alfa_icon",
                  request_id = 30,
                  item_index = 30,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_capacity_t8"),
                  image = "smg_capacity_t8_camo_alfa_icon",
                  request_id = 31,
                  item_index = 31,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_handling_t8"),
                  image = "smg_handling_t8_camo_alfa_icon",
                  request_id = 32,
                  item_index = 32,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_standard_t8"),
                  image = "smg_standard_t8_camo_alfa_icon",
                  request_id = 33,
                  item_index = 33,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_minigun_t8"),
                  image = "smg_minigun_t8_camo_alfa_icon",
                  request_id = 34,
                  item_index = 34,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_vmp_t8"),
                  image = "smg_vmp_t8_camo_alfa_icon",
                  request_id = 35,
                  item_index = 35,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_fastburst_t8"),
                  image = "smg_fastburst_t8_camo_alfa_icon",
                  request_id = 36,
                  item_index = 36,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/smg_mp40"),
                  image = "ui_icon_weapon_smg_mp40_xl",
                  request_id = 37,
                  item_index = 37,
                  active = false,
                  is_small = false
            },
            properties = {}
      })

      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/smg_thompson"),
                  image = "ui_icon_weapons_zm_thompson",
                  request_id = 70,
                  item_index = 70,
                  active = false,
                  is_small = false
            },
            properties = {}
      })

      -- Tactical Rifles
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/tr_powersemi_t8"),
                  image = "tr_powersemi_t8_camo_alfa_icon",
                  request_id = 38,
                  item_index = 38,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/tr_longburst_t8"),
                  image = "tr_longburst_t8_camo_alfa_icon",
                  request_id = 39,
                  item_index = 39,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/tr_midburst_t8"),
                  image = "tr_midburst_t8_camo_alfa_icon",
                  request_id = 40,
                  item_index = 40,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/tr_damageburst_t8"),
                  image = "tr_damageburst_t8_camo_alfa_icon",
                  request_id = 46,
                  item_index = 46,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/tr_leveraction_t8"),
                  image = "ui_icon_weapons_zm_trleveraction",
                  request_id = 47,
                  item_index = 47,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/tr_flechette_t8"),
                  image = "tr_flechette_t8_camo_alfa_icon",
                  request_id = 48,
                  item_index = 48,
                  active = false,
                  is_small = false
            },
            properties = {}
      })

      -- LMGs
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/lmg_heavy_t8"),
                  image = "lmg_heavy_t8_camo_alfa_icon",
                  request_id = 41,
                  item_index = 41,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/lmg_spray_t8"),
                  image = "lmg_spray_t8_camo_alfa_icon",
                  request_id = 42,
                  item_index = 42,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/lmg_standard_t8"),
                  image = "lmg_standard_t8_camo_alfa_icon",
                  request_id = 43,
                  item_index = 43,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/lmg_double_t8"),
                  image = "ui_icon_weapon_lmg_double_render_xl",
                  request_id = 59,
                  item_index = 59,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/lmg_stealth_t8"),
                  image = "lmg_stealth_t8_camo_alfa_icon",
                  request_id = 60,
                  item_index = 60,
                  active = false,
                  is_small = false
            },
            properties = {}
      })

      -- Snipers
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/sniper_fastrechamber_t8"),
                  image = "sniper_fastrechamber_t8_camo_alfa_icon",
                  request_id = 49,
                  item_index = 49,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/sniper_powerbolt_t8"),
                  image = "sniper_powerbolt_t8_camo_alfa_icon",
                  request_id = 50,
                  item_index = 50,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/sniper_powersemi_t8"),
                  image = "sniper_powersemi_t8_camo_alfa_icon",
                  request_id = 51,
                  item_index = 51,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/sniper_quickscope_t8"),
                  image = "sniper_quickscope_t8_camo_alfa_icon",
                  request_id = 52,
                  item_index = 52,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/sniper_mini14_t8"),
                  image = "sniper_mini14_t8_camo_alfa_icon",
                  request_id = 53,
                  item_index = 53,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/sniper_locus_t8"),
                  image = "sniper_locus_t8_camo_alfa_icon",
                  request_id = 54,
                  item_index = 54,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/sniper_damagesemi_t8"),
                  image = "sniper_damagesemi_t8_camo_alfa_icon",
                  request_id = 55,
                  item_index = 55,
                  active = false,
                  is_small = false
            },
            properties = {}
      })

      -- Shotguns
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/shotgun_pump_t8"),
                  image = "shotgun_pump_t8_camo_alfa_icon",
                  request_id = 11,
                  item_index = 11,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/shotgun_semiauto_t8"),
                  image = "shotgun_semiauto_t8_camo_alfa_icon",
                  request_id = 12,
                  item_index = 12,
                  active = false,
                  is_small = false
            },
            properties = {}
      })

      if CoD.ZMStoryUtility.GetCurrentMapStory() == 1 then
            table.insert(filters, {
                  models = {
                        name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/shotgun_trenchgun_t8"),
                        image = @"hash_68919da50189b818",
                        request_id = 13,
                        item_index = 13,
                        active = false,
                        is_small = false
                  },
                  properties = {}
            })
      end

      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/shotgun_fullauto_t8"),
                  image = "shotgun_fullauto_t8_camo_alfa_icon",
                  request_id = 14,
                  item_index = 14,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/shotgun_precision_t8"),
                  image = "shotgun_precision_t8_camo_alfa_icon",
                  request_id = 15,
                  item_index = 15,
                  active = false,
                  is_small = false
            },
            properties = {}
      })

      -- Pistols
      if CoD.ZMStoryUtility.GetCurrentMapStory() == 0 then
            table.insert(filters, {
                  models = {
                        name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/pistol_standard_t8"),
                        image = "pistol_standard_t8_camo_alfa_icon",
                        request_id = 44,
                        item_index = 44,
                        active = false,
                        is_small = false
                  },
                  properties = {}
            })
      end

      if CoD.ZMStoryUtility.GetCurrentMapStory() == 1 then
            table.insert(filters, {
                  models = {
                        name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/pistol_topbreak_t8"),
                        image = @"hash_7aaaacd7f5bba0c7",
                        request_id = 45,
                        item_index = 45,
                        active = false,
                        is_small = false
                  },
                  properties = {}
            })
      end

      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/pistol_revolver_t8"),
                  image = "pistol_revolver_t8_camo_alfa_icon",
                  request_id = 56,
                  item_index = 56,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/pistol_burst_t8"),
                  image = "pistol_burst_t8_camo_alfa_icon",
                  request_id = 57,
                  item_index = 57,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/pistol_fullauto_t8"),
                  image = "pistol_fullauto_t8_camo_alfa_icon",
                  request_id = 58,
                  item_index = 58,
                  active = false,
                  is_small = false
            },
            properties = {}
      })

      -- Launchers and Specials
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/launcher_standard_t8"),
                  image = "launcher_standard_t8_camo_alfa_icon",
                  request_id = 10,
                  item_index = 10,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_73f926dd393ef4df"),
                  image = @"ui_icon_weapons_zm_special_ballisticknife",
                  request_id = 68,
                  item_index = 68,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/special_crossbow_t8"),
                  image = @"hash_100dddfed3d2a5c0",
                  request_id = 69,
                  item_index = 69,
                  active = false,
                  is_small = false
            },
            properties = {}
      })

      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/fraggrenade"),
                  image = @"ui_icon_equpiment_zm_frag",
                  request_id = 63,
                  item_index = 63,
                  active = false,
                  is_small = true
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/acid_bomb"),
                  image = @"ui_icon_equpiment_zm_acid",
                  request_id = 64,
                  item_index = 64,
                  active = false,
                  is_small = true
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/claymore"),
                  image = @"hash_624b6b9096319641",
                  request_id = 65,
                  item_index = 65,
                  active = false,
                  is_small = true
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/wraith_fire"),
                  image = @"hash_430b55584d35cbc2",
                  request_id = 66,
                  item_index = 66,
                  active = false,
                  is_small = true
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/mini_turret"),
                  image = @"t7_hud_ks_auto_sentry",
                  request_id = 67,
                  item_index = 67,
                  active = false,
                  is_small = true
            },
            properties = {}
      })

      local StoryID = CoD.ZMStoryUtility.GetCurrentMapStory()
      if StoryID == 1 then
            table.insert(filters, {
                  models = {
                        name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/homunculus"),
                        image = @"ui_icon_equipment_zm_homunculus",
                        request_id = 61,
                        item_index = 61,
                        active = false,
                        is_small = true
                  },
                  properties = {}
            })
      else
            table.insert(filters, {
                  models = {
                        name = Engine[@"hash_4F9F1239CFD921FE"](@"zombie/cymbal_monkey"),
                        image = @"ui_icon_inventory_cymbal_monkey",
                        request_id = 62,
                        item_index = 62,
                        active = false,
                        is_small = true
                  },
                  properties = {}
            })
            table.insert(filters, {
                  models = {
                        name = Engine[@"hash_4F9F1239CFD921FE"](@"weapon/ray_gun"),
                        image = @"ui_icon_weapon_ray_gun_render",
                        request_id = 71,
                        item_index = 71,
                        active = false,
                        is_small = false
                  },
                  properties = {}
            })
            table.insert(filters, {
                  models = {
                        name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ray_gun_mk2"),
                        image = @"ui_icon_weapon_ray_gun_mk2_render",
                        request_id = 72,
                        item_index = 72,
                        active = false,
                        is_small = false
                  },
                  properties = {}
            })
      end

      -- Voyage
      if CoD.BO4GetMap() == "Voyage" then
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ww_tricannon_t8"),
                  image = @"hash_5d6013ed244ad82e",
                  request_id = 90,
                  item_index = 90,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ww_tricannon_fire_t8"),
                  image = @"hash_6f96f7b76789aac2",
                  request_id = 91,
                  item_index = 91,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ww_tricannon_earth_t8"),
                  image = @"hash_24074854d000a742",
                  request_id = 92,
                  item_index = 92,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ww_tricannon_water_t8"),
                  image = @"hash_2289301d453f2d17",
                  request_id = 93,
                  item_index = 93,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ww_tricannon_air_t8"),
                  image = @"hash_25740919ad0c89d7",
                  request_id = 94,
                  item_index = 94,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_49b2e832f765cb5"),
                  image = @"i_wpn_t8_sig_battle_shield_glass_c",
                  request_id = 95,
                  item_index = 95,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      end

      -- Blood
      if CoD.BO4GetMap() == "Blood" then
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/blundergat"),
                  image = @"ui_icon_weapons_zm_blundergat",
                  request_id = 90,
                  item_index = 90,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/acidgat"),
                  image = @"ui_icon_weapons_zm_blundergat",
                  request_id = 91,
                  item_index = 91,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/magmagat"),
                  image = @"ui_icon_weapons_zm_blundergat",
                  request_id = 92,
                  item_index = 92,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      end

      -- AE
      if CoD.BO4GetMap() == "AE" then
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_eb276333b85f293"),
                  image = @"ui_icon_weapons_zm_charon",
                  request_id = 90,
                  item_index = 90,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5e7b4f837b6c6744"),
                  image = @"ui_icon_weapons_zm_gaia",
                  request_id = 91,
                  item_index = 91,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_523af889850e67e6"),
                  image = @"hash_7eeafad2e284cab9",
                  request_id = 92,
                  item_index = 92,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_7022c47b56e0ed9f"),
                  image = @"ui_icon_weapons_zm_ouranos",
                  request_id = 93,
                  item_index = 93,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zombie/thunderstorm"),
                  image = @"ui_icon_inventory_zm_red_eqp_lightning_rod",
                  request_id = 94,
                  item_index = 94,
                  active = false,
                  is_small = true
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3aeda1b4f0b1547e"),
                  image = @"ui_icon_weapons_zm_charon",
                  request_id = 95,
                  item_index = 95,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2e94430f1fc60691"),
                  image = @"ui_icon_weapons_zm_gaia",
                  request_id = 96,
                  item_index = 96,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_367b6a2d351eb73f"),
                  image = @"hash_7eeafad2e284cab9",
                  request_id = 97,
                  item_index = 97,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_38bc1e3aad78424a"),
                  image = @"ui_icon_weapons_zm_ouranos",
                  request_id = 98,
                  item_index = 98,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      end

      -- IX
      if CoD.BO4GetMap() == "IX" then
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ww_crossbow_t8"),
                  image = @"hash_38208b311390cffb",
                  request_id = 90,
                  item_index = 90,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ww_crossbow_t8_upgraded"),
                  image = @"hash_38208b311390cffb",
                  request_id = 91,
                  item_index = 91,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      end

      -- Dead
      if CoD.BO4GetMap() == "Dead" then
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4e413fbdde10b051"),
                  image = @"hash_6c021551a1cc7457",
                  request_id = 90,
                  item_index = 90,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_25ddfdd724070696"),
                  image = @"hash_45BC5C96B44A5900",
                  request_id = 91,
                  item_index = 91,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_7b8a03d0c40ea097"),
                  image = @"hash_45BC5D96B44A5AB3",
                  request_id = 92,
                  item_index = 92,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"shield/stake_knife"),
                  image = @"ui_icon_zm_callings_knife",
                  request_id = 93,
                  item_index = 93,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      end

      -- Tag
      if CoD.BO4GetMap() == "Tag" then
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/thundergun"),
                  image = @"ui_icon_weapons_zm_thundergun",
                  request_id = 90,
                  item_index = 90,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zombie/tesla_gun"),
                  image = @"hash_490135AAF2E50681",
                  request_id = 91,
                  item_index = 91,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2283e591fbfea663"),
                  image = @"hash_490135AAF2E50681",
                  request_id = 92,
                  item_index = 92,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/tundragun"),
                  image = @"hash_25E0F029D4B69CE0",
                  request_id = 93,
                  item_index = 93,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/music_box"),
                  image = @"ui_icon_equipment_zm_music_box",
                  request_id = 94,
                  item_index = 94,
                  active = false,
                  is_small = true
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/nesting_doll_grenade"),
                  image = @"ui_icon_equipment_zm_nesting_doll",
                  request_id = 95,
                  item_index = 95,
                  active = false,
                  is_small = true
            },
            properties = {}
      })
      end

      -- AO
      if CoD.BO4GetMap() == "AO" then
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ray_gun_mk2v"),
                  image = @"ui_icon_weapon_ray_gun_mk2_xl",
                  request_id = 90,
                  item_index = 90,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ray_gun_mk2x"),
                  image = @"ui_icon_weapon_ray_gun_mk2x_xl",
                  request_id = 91,
                  item_index = 91,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ray_gun_mk2y"),
                  image = @"ui_icon_weapon_ray_gun_mk2y_xl",
                  request_id = 92,
                  item_index = 92,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ray_gun_mk2z"),
                  image = @"ui_icon_weapon_ray_gun_mk2z_xl",
                  request_id = 93,
                  item_index = 93,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      end

      if CoD.BO4GetMap() == "Classified" then
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/ww_freezegun_t8_upgraded"),
                  image = @"hash_648aefaf2d1c9156",
                  request_id = 90,
                  item_index = 90,
                  active = false,
                  is_small = false
            },
            properties = {}
      })
      end

      return filters
end, true )

------------------------

CoD.SetupSubModelForSave_BoxPatch = function(hud, controller)
      hud:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"shield_enh_saved_weapons" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)
                  Engine[@"setdvar"]("shield_enh_saved_weapon" .. scriptData[1], scriptData[2])
            end
      end)
end

------------------------

CoD.ShieldEnhBoxPatchOptions = InheritFrom( CoD.Menu )
LUI.createMenu.ShieldEnhBoxPatchOptions = function ( f1_arg0, f1_arg1 )
	local self = CoD.Menu.NewForUIEditor( "ShieldEnhBoxPatchOptions", f1_arg0 )
	local f1_local1 = self
	self:setClass( CoD.ShieldEnhBoxPatchOptions )
	self.soundSet = "none"
	self:setOwner( f1_arg0 )
	self:setLeftRight( 0, 1, 0, 0 )
	self:setTopBottom( 0, 1, 0, 0 )
	self:playSound( "menu_open", f1_arg0 )
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList( self )
	
	local CommomCenteredPopup = CoD.CommonCenteredPopup.new( f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0 )
	CommomCenteredPopup.TitleText:setText("Select Weapons in Box")
	CommomCenteredPopup.HeaderBackground:setAlpha( 0 )
	CommomCenteredPopup.HeaderTopBar:setAlpha( 0 )
	CommomCenteredPopup.HeaderBottomBar:setAlpha( 0 )
	self:addElement( CommomCenteredPopup )
	self.CommomCenteredPopup = CommomCenteredPopup

      local WeaponMainIndexes = LUI.UIList.new( f1_local1, f1_arg0, 10, 0, nil, false, false, false, false )
	WeaponMainIndexes:setLeftRight( 0.5, 0.5, -1300, 1300 )
	WeaponMainIndexes:setTopBottom( 0, 0, 115, 300 )
	WeaponMainIndexes:setVerticalCount(1)
	WeaponMainIndexes:setHorizontalCount(4)
      WeaponMainIndexes:setAutoScaleContent( true )
	WeaponMainIndexes:setSpacing( -15 )
	WeaponMainIndexes:setWidgetType( CoD.Shield_WeaponIndexStyleMain )
	WeaponMainIndexes:setVerticalCounter( CoD.verticalCounter )
	WeaponMainIndexes:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	WeaponMainIndexes:setDataSource( "ShieldWeaponMainIndexesBoxPatches" )

      Engine[@"setdvar"]("shield_enh_selected_box_weapon_index", -1)

      local last_element = nil
	f1_local1:AddButtonCallbackFunction( WeaponMainIndexes, f1_arg0, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function ( element, menu, controller, model )
            PlaySoundAlias( "uin_toggle_generic" )

            if last_element == element then
                  return
            end
            
            -- get request id
            local index_id_get = element:getModel(model, "index_id")
            local index_id = index_id_get:get()

            CoD.EnhModPrintInfo("index_id", index_id)
            Engine[@"setdvar"]("shield_enh_selected_box_weapon_index", (index_id + 1))

            element:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)
            element:setRGB(1, 1, 0.75)

            if last_element ~= nil then
                  last_element:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)
                  last_element:setRGB(1, 1, 1)
            end
            last_element = element
            return true
	end, function ( element, menu, controller )
		if true then
			CoD.Menu.SetButtonLabel( menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], @"hash_6D0BB36CD318F55F", nil, "ui_confirm" )
			return true
		else
			return false
		end
	end, false )

	self:addElement( WeaponMainIndexes )
	self.WeaponMainIndexes = WeaponMainIndexes

      WeaponMainIndexes.id = "WeaponMainIndexes"

      -- Weapons List
      local WeaponsList = LUI.UIList.new( f1_local1, f1_arg0, 10, 0, nil, false, false, false, false )
	WeaponsList:setLeftRight( 0.50, 0.50, 0.00, 426.00 )
	WeaponsList:setTopBottom( 0.00, 0.00, 335.25, 1000.25 )
	WeaponsList:setVerticalCount(6)
	WeaponsList:setHorizontalCount(1)
      WeaponsList:setAutoScaleContent( true )
      WeaponsList:setSpacing(-20)
	WeaponsList:setWidgetType( CoD.SpecialWeaponSelectionBoxPatch_Enh )
	WeaponsList:setVerticalCounter( CoD.verticalCounter )
	WeaponsList:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	WeaponsList:setDataSource( "ShieldWeaponsListBoxPatch" )

	f1_local1:AddButtonCallbackFunction( WeaponsList, f1_arg0, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function ( element, menu, controller, model )
            PlaySoundAlias( "uin_toggle_generic" )

            -- get request index
            local request_id_get = element:getModel(model, "request_id")
            local request_id = request_id_get:get()

            local icon_get = element:getModel(model, "image") 
            local icon = icon_get:get()

            local text_get = element:getModel(model, "name") 
            local text = text_get:get()

            local is_small_get = element:getModel(model, "is_small") 
            local is_small = is_small_get:get()

            if Engine[@"getdvarint"]("shield_enh_selected_box_weapon_index") ~= -1 then
                  SendBoxPatchOption("boxpatch_" .. Engine[@"getdvarint"]("shield_enh_selected_box_weapon_index") .. "_enh", request_id)

                  if last_element ~= nil then
                        last_element.NoiseTiledBacking.Label:setText(text)
                        last_element.NoiseTiledBacking.CardIcon:setImage(RegisterImage(icon))

                        if is_small == true then
                              last_element.NoiseTiledBacking.CardIcon:setLeftRight(0.25, 0.75, 1, -1)
                        else
                              last_element.NoiseTiledBacking.CardIcon:setLeftRight(0, 1, 1, -1)
                        end
                  end
            end
            return true
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

	self:appendEventHandler( "input_source_changed", function ( f9_arg0, f9_arg1 )
		f9_arg1.menu = f9_arg1.menu or f1_local1
		f1_local1:updateElementState( self, f9_arg1 )
	end )
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"]( f1_arg0 )
	f1_local7( f1_local6, f1_local8.LastInput, function ( f10_arg0 )
		f1_local1:updateElementState( self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "LastInput"
		} )
	end, false )
	f1_local1:AddButtonCallbackFunction( self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function ( element, menu, controller, model )
		GoBack( self, controller )
		return true
	end, function ( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil )
		return true
	end, false )
	CommomCenteredPopup.buttons:setModel( self.buttonModel, f1_arg0 )
	if CoD.isPC then
		CommomCenteredPopup.id = "CommomCenteredPopup"
	end
	self:processEvent( {
		name = "menu_loaded",
		controller = f1_arg0
	} )

	self.__defaultFocus = WeaponsList

	if CoD.isPC and (IsKeyboard( f1_arg0 ) or self.ignoreCursor) then
		self:restoreState( f1_arg0 )
	end
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg0 )
	end
	
	f1_local7 = self
	--MenuHidesFreeCursor( f1_local1, f1_arg0 )

	CoD.EnhModPrintInfo("Called", "Shield BoxPatch Menu")

	return self
end

CoD.ShieldEnhBoxPatchOptions.__resetProperties = function ( f13_arg0 )

end

CoD.ShieldEnhBoxPatchOptions.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f14_arg0, f14_arg1 )
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter( 0 )
		end
	},
}

CoD.ShieldEnhBoxPatchOptions.__onClose = function ( f16_arg0 )
	f16_arg0.CommomCenteredPopup:close()
      f16_arg0.WeaponMainIndexes:close()
      f16_arg0.WeaponsList:close()
end