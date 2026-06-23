--[[
      .\hksc.exe '.\Scripts\Achievements.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\Achievements.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

local global_achiv = nil

local AchievementInfo = {
      [1] = { name = @"shield/enh_achv_hardcore", image = "loot_ui_icon_stickers_random_22_large", dvar = "enh_achv_hardcore", score = 75 },
      [2] = { name = @"shield/enh_achv_hardcore_eleph", image = "loot_ui_icon_stickers_random_29_large", dvar = "enh_achv_hardcore_eleph", score = 110 },
      [3] = { name = @"shield/enh_achv_hardcore_ae", image = "loot_ui_icon_stickers_cute_monsters_2_large", dvar = "enh_achv_hardcore_ae", score = 90 },
      [4] = { name = @"shield/enh_achv_hardcore_eye", image = "loot_ui_icon_stickers_graffitiparts_1", dvar = "enh_achv_hardcore_eye", score = 125 },
      [5] = { name = @"shield/enh_achv_classic_ee", image = "loot_ui_icon_stickers_misty_01", dvar = "enh_achv_classic_ee", score = 50 },
      [6] = { name = @"shield/enh_achv_all_hardcore", image = "loot_ui_icon_stickers_vampire_hunter_01", dvar = "enh_achv_all_hardcore", score = 250 },
      [7] = { name = @"shield/enh_achv_cranked_ee", image = "ui_icon_weapon_charms_pizza", dvar = "enh_achv_cranked_ee", score = 65 },
      [8] = { name = @"shield/enh_achv_classic_round50", image = "loot_ui_icon_stickers_survival_tools_06", dvar = "enh_achv_classic_round50", score = 35 },
      [9] = { name = @"shield/enh_achv_classic_round100", image = "loot_ui_icon_stickers_survival_tools_01", dvar = "enh_achv_classic_round100", score = 70 },
      [10] = { name = @"shield/enh_achv_many_players", image = "loot_ui_icon_stickers_zsquad_01", dvar = "enh_achv_many_players", score = 35 },
      [11] = { name = @"shield/enh_achv_hardcore_blood", image = "loot_ui_icon_stickers_random_16_large", dvar = "enh_achv_hardcore_blood", score = 100 },
      [12] = { name = @"shield/enh_achv_hardcore_tag", image = "loot_ui_icon_stickers_graffitiparts_6", dvar = "enh_achv_hardcore_tag", score = 105 },
      [13] = { name = @"shield/enh_achv_hardcore_ao", image = "loot_ui_icon_stickers_misc_9", dvar = "enh_achv_hardcore_ao", score = 100 },
      [14] = { name = @"shield/enh_achv_hardcore_dotn", image = "loot_ui_icon_stickers_zm_wolf_moon", dvar = "enh_achv_hardcore_dotn", score = 110 }
}

------------------------

local function GetAchievementInfo(idx)
      return AchievementInfo[idx]
end

CoD.AchievementsReload = function()
      CoD.PCAchievementsUtility.ShowAchievementNotification = function ( f3_arg0, f3_arg1 )
            if global_achiv then
                  local f3_local0 = global_achiv
                  f3_local0 = f3_local0.showNotification:get()
                  if f3_local0 then
                        if f3_arg0._achievementNotificationTimer then
                              f3_arg0._achievementNotificationTimer:close()
                              f3_arg0._achievementNotificationTimer = nil
                        end
                        f3_arg0._achievementNotificationTimer = LUI.UITimer.newElementTimer( 4000, true, function ()
                              local f4_local0 = DataSources.PCAchievementNotification.getModel( f3_arg1 )
                              f4_local0.showNotification:set( false )
                              f3_arg0._achievementNotificationTimer:close()
                              f3_arg0._achievementNotificationTimer = nil
                        end )
                        f3_arg0:addElement( f3_arg0._achievementNotificationTimer )
                  end
                  
                  -- reset for normal achievements..
                  global_achiv = nil

                  return f3_local0
            end

            if f3_arg1 then
                  local f3_local0 = DataSources.PCAchievementNotification.getModel( f3_arg1 )
                  f3_local0 = f3_local0.showNotification:get()
                  if f3_local0 then
                        if f3_arg0._achievementNotificationTimer then
                              f3_arg0._achievementNotificationTimer:close()
                              f3_arg0._achievementNotificationTimer = nil
                        end
                        f3_arg0._achievementNotificationTimer = LUI.UITimer.newElementTimer( 5000, true, function ()
                              local f4_local0 = DataSources.PCAchievementNotification.getModel( f3_arg1 )
                              f4_local0.showNotification:set( false )
                              f3_arg0._achievementNotificationTimer:close()
                              f3_arg0._achievementNotificationTimer = nil
                        end )
                        f3_arg0:addElement( f3_arg0._achievementNotificationTimer )
                  end
                  return f3_local0
            else
                  return false
            end
      end
end

CoD.SetupAchievementsModels = function(hud, controller)
      hud:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"enh_achv_manager" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)
                  
                  local idx = scriptData[1]
                  local unlocked = scriptData[2]
                  local bool_unlocked = false

                  if unlocked == 1 then
                        local achv = GetAchievementInfo(idx)

                        if idx ~= 6 then
                              if achv and Engine[@"getdvarint"](achv.dvar) == 0 then
                                    local model_to_use = Engine[@"getmodelforcontroller"]( controller )
                                    global_achiv = model_to_use:create( "PC.Achievement.Notification" )
                                    local f2_local2 = global_achiv:create( "name" )
                                    f2_local2:set( achv.name )
                                    f2_local2 = global_achiv:create( "score" )
                                    f2_local2:set( achv.score )
                                    f2_local2 = global_achiv:create( "image" )
                                    f2_local2:set( achv.image )
                                    f2_local2 = global_achiv:create( "showNotification" )
                                    f2_local2:set( true )
                                    
                                    bool_unlocked = true
                              end
                        else
                              -- all hardcore achive
                              if achv 
                              and Engine[@"getdvarint"](achv.dvar) == 0 and Engine[@"getdvarint"]("enh_achv_hardcore_eleph") == 1
                              and Engine[@"getdvarint"]("enh_achv_hardcore_ae") == 1 and Engine[@"getdvarint"]("enh_achv_hardcore_eye") == 1 
                              and Engine[@"getdvarint"]("enh_achv_hardcore_blood") == 1 and Engine[@"getdvarint"]("enh_achv_hardcore_tag") == 1
                              and Engine[@"getdvarint"]("enh_achv_hardcore_ao") == 1 and Engine[@"getdvarint"]("enh_achv_hardcore_dotn") == 1 then
                                    local model_to_use = Engine[@"getmodelforcontroller"]( controller )
                                    global_achiv = model_to_use:create( "PC.Achievement.Notification" )
                                    local f2_local2 = global_achiv:create( "name" )
                                    f2_local2:set( achv.name )
                                    f2_local2 = global_achiv:create( "score" )
                                    f2_local2:set( achv.score )
                                    f2_local2 = global_achiv:create( "image" )
                                    f2_local2:set( achv.image )
                                    f2_local2 = global_achiv:create( "showNotification" )
                                    f2_local2:set( true )

                                    bool_unlocked = true
                              end
                        end
                  end

                  local value_to_write = 0
                  if unlocked == 1 then
                        value_to_write = 1
                  end

                  if bool_unlocked == true then
                        local PathToSounds = '"project-bo4\\mods\\EnhancementModT8\\Sounds\\'
                        local SoundPath = PathToSounds .. '\\' .. "achiv_sound.mp3" .. '"'

                        Engine[@"exec"](Engine[@"getprimarycontroller"](), 'shield_play ' .. SoundPath .. ' "" ' .. '0' .. ' 0' .. ' 1' .. " 1 " .. "0")
                  end

                  -- unlock the achv
                  Engine[@"exec"](Engine[@"getprimarycontroller"](), 'writejson "" var' .. idx .. ' ' .. value_to_write .. ' uint64_t players/vars.json')
            end
      end)
end