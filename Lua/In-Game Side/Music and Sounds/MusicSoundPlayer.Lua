--[[
      .\hksc.exe '.\Scripts\MusicSoundPlayer.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\MusicSoundPlayer.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

local SoundsData = {
      -- hardcore boss fight
      [1] = "remedy_eye.mp3",
      [2] = "retribution_eye.mp3",
      [3] = "trial_pegasus.mp3",
      [4] = "trial_perseus.mp3",
      [60] = "eleph_phase0.mp3",
      [61] = "eleph_phase1.mp3",
      [90] = "burtus_theme.mp3",
      [91] = "artifact_theme.mp3",
      [92] = "artifact_theme_2.mp3",
      [93] = "artifact_theme_3.mp3",
      [94] = "avogadro_theme.mp3",

      -- classic mode
      [5] = "whos_who_sfx.mp3",
      [70] = "speed_jingle.mp3",
      [71] = "jug_jingle.mp3",
      [72] = "vulture_jingle.mp3",
      [73] = "whoswho_jingle.mp3",
      [74] = "doubletab_jingle.mp3",
      [75] = "elemental_jingle.mp3",

      -- cranked
      [6] = "welcome_to_cranked.mp3",
      [7] = "cranked_instakill.mp3",
      [8] = "double_points.mp3",
      [9] = "firesale.mp3",
      [10] = "full_ammo.mp3",
      [11] = "nuke.mp3",
      [12] = "carpenter.mp3",
      [13] = "bonus.mp3",
      [14] = "free_perk.mp3",
      [15] = "full_power.mp3",
      [16] = "yap1.mp3",
      [17] = "yap2.mp3",
      [18] = "yap3.mp3",
      [19] = "yap4.mp3",
      [20] = "yap5.mp3",
      [21] = "yap6.mp3",
      [22] = "yap_pizza1.mp3",
      [23] = "yap_pizza2.mp3",
      [24] = "yap_pizza3.mp3",
      [25] = "yap_pizza4.mp3",
      [26] = "yap_pizza5.mp3",
      [27] = "yap_pizza6.mp3",
      [28] = "yap_pizza7.mp3",
      [29] = "yap_pizza8.mp3",

      -- bo6 vos
      [80] = "bo6_instakill.mp3",
      [81] = "bo6_double_points.mp3",
      [82] = "bo6_firesale.mp3",
      [83] = "bo6_full_ammo.mp3",
      [84] = "bo6_nuke.mp3",
      [85] = "bo6_carpenter.mp3",
      [86] = "bo6_bonus.mp3",
      [87] = "bo6_free_perk.mp3",
      [88] = "bo6_full_power.mp3",

      -- round music
      -- shadows
      [30] = "shadows_start1.mp3",
      [31] = "shadows_start2.mp3",
      [32] = "shadows_start3.mp3",
      [33] = "shadows_start4.mp3",
      [34] = "shadows_start5.mp3",
      [35] = "shadows_start3_long.mp3",
      [36] = "shadows_start4_long.mp3",
      [37] = "shadows_start5_long.mp3",

      [38] = "shadows_end1.mp3",
      [39] = "shadows_end2.mp3",
      [40] = "shadows_end3.mp3",

      -- zet
      [50] = "zet_start1.mp3",
      [51] = "zet_start2.mp3",
      [52] = "zet_start3.mp3",
      [53] = "zet_start4.mp3",

      [55] = "zet_end1.mp3",
      [56] = "zet_end2.mp3",
      [57] = "zet_end3.mp3",
      [54] = "zet_end4.mp3",

      -- nht
      [200] = "og_round_start.mp3",
      [201] = "og_round_end.mp3",

      -- gameover
      [41] = "shadows_gameover.mp3",
      [58] = "zet_end.mp3",
      [59] = "og_gameover.mp3"
}

local IndexVolumes = {

}

------------------------

CoD.SetupMusicSoundPlayer = function(hud, controller)
      hud:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"enh_music_manager" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)
                  local PathToSounds = '"project-bo4\\mods\\EnhancementModT8\\Sounds\\'
                  
                  -- stop sound/music
                  if scriptData[1] == 99 then
                        Engine[@"exec"](Engine[@"getprimarycontroller"](), 'shield_stop')
                        return
                  end

                  if scriptData[1] == 100 then
                        Engine[@"exec"](Engine[@"getprimarycontroller"](), 'shield_stop_sfx')
                        return
                  end

                  if scriptData[1] == 101 then
                        Engine[@"exec"](Engine[@"getprimarycontroller"](), 'shield_stop_name ' .. scriptData[2])
                        CoD.ArrayRemove( IndexVolumes, scriptData[2] )
                        return
                  end

                  local SoundPath = PathToSounds .. '\\' .. SoundsData[scriptData[1]] .. '"' -- end current path with a <">
                  local IsMusic = scriptData[2] == nil or scriptData[2] == 1
                  local ShouldLoop = scriptData[3] == nil or scriptData[3] == 1
                  local IgnoreChecks = scriptData[4] ~= nil and scriptData[4] == 1
                  local IsBasedOnDistance = scriptData[5] ~= nil and scriptData[5] == 1

                  local Check_Value = 0

                  if IgnoreChecks == true then
                        Check_Value = 1
                  else
                        Check_Value = 0
                  end

                  if IsBasedOnDistance == true then
                        local Volume = scriptData[6] / 100
                        local IndexVolume = scriptData[7]
                        local FirstPlay = not CoD.ArrayContains( IndexVolumes, IndexVolume )
                        
                        if FirstPlay == true then
                              if IsMusic == true then
                                    if ShouldLoop == true then
                                          Engine[@"exec"](Engine[@"getprimarycontroller"](), 'shield_play ' .. SoundPath .. ' "' .. IndexVolume .. '" ' .. '1' .. ' 0' .. " 0" .. " 1 " .. Check_Value) -- music's loop
                                    else
                                          Engine[@"exec"](Engine[@"getprimarycontroller"](), 'shield_play ' .. SoundPath .. ' "' .. IndexVolume .. '" ' .. '0' .. ' 0' .. " 0" .. " 1 " .. Check_Value) -- music's
                                    end
                              else
                                    if ShouldLoop == true then
                                          Engine[@"exec"](Engine[@"getprimarycontroller"](), 'shield_play ' .. SoundPath .. ' "' .. IndexVolume .. '" ' .. '1' .. ' 0' .. ' 1' .. " 1 " .. Check_Value) -- sfx's loop
                                    else
                                          Engine[@"exec"](Engine[@"getprimarycontroller"](), 'shield_play ' .. SoundPath .. ' "' .. IndexVolume .. '" ' .. '0' .. ' 0' .. ' 1' .. " 1 " .. Check_Value) -- sfx's
                                    end
                              end

                              table.insert( IndexVolumes, IndexVolume )
                        else
                              Engine[@"exec"](Engine[@"getprimarycontroller"](), 'shield_set_volume ' .. '"' .. IndexVolume .. '" ' .. Volume)
                        end

                        return
                  end
                  
                  -- music path -> loop -> is_frontend
                  if IsMusic == true then
                        if ShouldLoop == true then
                              Engine[@"exec"](Engine[@"getprimarycontroller"](), 'shield_play ' .. SoundPath .. ' "" ' .. '1' .. ' 0' .. " 0" .. " 1 " .. Check_Value) -- music's loop
                        else
                              Engine[@"exec"](Engine[@"getprimarycontroller"](), 'shield_play ' .. SoundPath .. ' "" ' .. '0' .. ' 0' .. " 0" .. " 1 " .. Check_Value) -- music's
                        end
                  else
                        if ShouldLoop == true then
                              Engine[@"exec"](Engine[@"getprimarycontroller"](), 'shield_play ' .. SoundPath .. ' "" ' .. '1' .. ' 0' .. ' 1' .. " 1 " .. Check_Value) -- sfx's loop
                        else
                              Engine[@"exec"](Engine[@"getprimarycontroller"](), 'shield_play ' .. SoundPath .. ' "" ' .. '0' .. ' 0' .. ' 1' .. " 1 " .. Check_Value) -- sfx's
                        end
                  end
            end
      end)
end