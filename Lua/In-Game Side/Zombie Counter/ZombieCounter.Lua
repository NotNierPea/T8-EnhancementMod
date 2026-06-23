--[[
      .\hksc.exe '.\Scripts\ZombieCounter.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\ZombieCounter.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

CoD.ApplyZombieCounter = function(hud, controller)
	-- defaults...
      local TextColor = 1
      local NumberColor = 5
      local Counter_Position = 1
      local Counter_OnlyZombies = 0

      local enhancement_zombie_counter = LUI.UIText.new(0, 0, 5, 0, 0.51, 0.51, 0, 30)
      enhancement_zombie_counter:setText("")
      enhancement_zombie_counter:setTTF("ttmussels_regular")
      --enhancement_zombie_counter:setAlignment( Enum[@"luialignment"][@"lui_alignment_right"] )
      enhancement_zombie_counter:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"enhancement_zombie_counter" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)

                  if scriptData[1] == 0 then
                        enhancement_zombie_counter:setText("") -- remove
                  elseif scriptData[1] == 1 then
                        
                        if Counter_OnlyZombies == 1 then
                              enhancement_zombie_counter:setText("^" .. NumberColor .. scriptData[3] .. " " .. "^" .. TextColor .. "Zombies remaining")
                        elseif Counter_OnlyZombies == 0 then
                              enhancement_zombie_counter:setText("^" .. TextColor .. "Zombies: " .. "^" .. NumberColor .. scriptData[2] .. " " .. "^" .. TextColor .. "(" .. "^" .. NumberColor .. scriptData[3] .. " " .. "^" .. TextColor .. "remaining)")
                        end
                  
                  elseif scriptData[1] == 2 then      
                        enhancement_zombie_counter:setText("^3Waiting For Zombies...")
                  elseif scriptData[1] == 3 then -- change settings...

                        TextColor = scriptData[2]
                        NumberColor = scriptData[3]
                        Counter_Position = scriptData[4]
                        Counter_OnlyZombies = scriptData[5]

                        -- font style
                        if Engine[@"getdvarint"]("shield_enh_Counter_FontStyle") == 1 then
                              enhancement_zombie_counter:setTTF("notosans_bold")
                        elseif Engine[@"getdvarint"]("shield_enh_Counter_FontStyle") == 2 then
                              enhancement_zombie_counter:setTTF("notosans_light")
                        elseif Engine[@"getdvarint"]("shield_enh_Counter_FontStyle") == 3 then
                              enhancement_zombie_counter:setTTF("ttmussels_regular")
                        elseif Engine[@"getdvarint"]("shield_enh_Counter_FontStyle") == 4 then
                              enhancement_zombie_counter:setTTF("notosans_regular")
                        elseif Engine[@"getdvarint"]("shield_enh_Counter_FontStyle") == 5 then
                              enhancement_zombie_counter:setTTF("skorzhen")
                        elseif Engine[@"getdvarint"]("shield_enh_Counter_FontStyle") == 6 then
                              enhancement_zombie_counter:setTTF("dinnext_regular")
                        elseif Engine[@"getdvarint"]("shield_enh_Counter_FontStyle") == 7 then
                              enhancement_zombie_counter:setTTF("ttmussels_demibold")
                        elseif Engine[@"getdvarint"]("shield_enh_Counter_FontStyle") == 8 then
                              enhancement_zombie_counter:setTTF("shield_mom")
                        end

                        if Counter_Position == 5 then
                              enhancement_zombie_counter:setTopBottom(0, 0, 0, 30)
                              enhancement_zombie_counter:setLeftRight(0, 0, 5, 0)
                        elseif Counter_Position == 4 then
                              enhancement_zombie_counter:setTopBottom(0, 0, 0, 30)
                              enhancement_zombie_counter:setLeftRight(0.84, 0, 5, 0)
                        elseif Counter_Position == 3 then
                              enhancement_zombie_counter:setTopBottom(0.51, 0.51, 0, 30)
                              enhancement_zombie_counter:setLeftRight(0.84, 0, 5, 0)
                        elseif Counter_Position == 2 then
                              enhancement_zombie_counter:setTopBottom(0, 0, 0, 30)
                              enhancement_zombie_counter:setLeftRight(0.43, 0, 5, 0)
                        elseif Counter_Position == 1 then
                              enhancement_zombie_counter:setTopBottom(0.51, 0.51, 0, 30)
                              enhancement_zombie_counter:setLeftRight(0, 0, 5, 0)
                        else
                              CoD.EnhModPrintInfo("Counter Error: Unknwon Position")
                  end
            end
      end
      end)
      hud:addElement(enhancement_zombie_counter)
end