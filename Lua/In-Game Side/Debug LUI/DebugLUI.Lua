--[[
      .\hksc.exe '.\Scripts\DebugLUI.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\DebugLUI.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

CoD.AddDebugWidgets = function(hud, controller)
      local labels = {
            "POS",
            "VEL",
            "ANG",
            "HP",
            "GR"
      }

      local debug_values = {}
      local line_elements = {}

      -- Left/right anchors
      local leftAnchor, rightAnchor, left, right = 0, 0, 5, 0
      local topAnchor, bottomAnchor = 0.65, 0.65
      local lineHeight = 30

      -- line (line 1)
      local header = LUI.UIText.new(leftAnchor, rightAnchor, left, right, topAnchor, bottomAnchor, 0, lineHeight)
      header:setTTF("notosans_light")
      header:setText("Debug Info:")
      hud:addElement(header)
      line_elements[1] = header

      -- create lines for each label
      for i = 1, #labels do
      local line = LUI.UIText.new(leftAnchor, rightAnchor, left, right, topAnchor, bottomAnchor, lineHeight * i, lineHeight * (i + 1))
      line:setTTF("notosans_light")
      line:setText("Waiting...")
      hud:addElement(line)
      line_elements[i + 1] = line
      end

      local function update_display()
      -- header is line_elements[1], no change needed here

      for idx, label in ipairs(labels) do
            local data = debug_values[idx-1]
            if data then
            local isfloat = debug_values[(idx-1) .. "_isfloat"]
            local lineText
            if isfloat == 2 then
                  lineText = string.format("%s: %.2f %.2f %.2f", label, data[1]/100, data[2]/100, data[3]/100)
            elseif isfloat == 1 then
                  lineText = string.format("%s: %.2f", label, data[1]/100)
            else
                  lineText = string.format("%s: %d", label, data[1])
            end
            line_elements[idx + 1]:setText(lineText)
            else
            line_elements[idx + 1]:setText("")
            end
      end              
      end

      hud:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function(model)
      if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"enhancement_debug_info") then
            local scriptData = CoD.GetScriptNotifyData(model)

            if scriptData[1] == 3 then
                  header:setText("Debug Info:")
                  return
            elseif scriptData[1] == 4 then
                  header:setText("^2Debug Info: (Printing logs...)")
                  return
            end

            local IsFloat = tonumber(scriptData[1])
            local type_id = tonumber(scriptData[2])
            local val1 = tonumber(scriptData[3])
            local val2 = tonumber(scriptData[4])
            local val3 = tonumber(scriptData[5])

            debug_values[type_id] = {val1, val2, val3}
            debug_values[type_id .. "_isfloat"] = IsFloat

            update_display()
      end
      end)
end