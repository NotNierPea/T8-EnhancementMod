--[[
      .\hksc.exe '.\Scripts\RemoveErrorBoxes.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\RemoveErrorBoxes.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

local function Orignal_ShouldOpenMessageDialog( f33_arg0, f33_arg1 )
	if f33_arg0:getParent() == nil then
		return 
	end
	local f33_local0 = Engine[@"getmodel"]( Engine[@"getglobalmodel"](), "messageDialog" )
	if f33_local0 ~= nil then
		if IsInGame() then
			local f33_local1 = Engine[@"getmodel"]( f33_local0, "controller" )
			if f33_local1 ~= nil and Engine[@"getmodelvalue"]( f33_local1 ) ~= f33_arg1 then
				return false
			end
		end
		local f33_local1 = Engine[@"getmodel"]( f33_local0, "messagePending" )
		if f33_local1 ~= nil and Engine[@"getmodelvalue"]( f33_local1 ) > 0 then
			return true
		end
	end
	return false
end

function ShouldOpenMessageDialog(f33_arg0, f33_arg1)
      CoD.EnhModPrintInfo("Called", "Should Open Message Dialog")

      if not Orignal_ShouldOpenMessageDialog(f33_arg0, f33_arg1) then
            CoD.EnhModPrintInfo("Returned....", "Should Open Message Dialog")
            return false
      end

      local CurrentError = CoD.GetErrorText(f33_arg1)
      local CurrentType = "Unknown Error"
      
      -- here is fixing printing issues (kilo crash)
      if string.find( CurrentError, "script error" ) then -- client and server
            CurrentError = string.sub(CurrentError, 2, 80) -- cut the stupid symbol that causes print errors
            CurrentType = "Script Error"
            --CoD.EnhModPrintInfo("a Script Error Occurred! -> ^3" .. CurrentError)
      elseif string.find( CurrentError, "UI Error") then -- LUI only
            CurrentError = string.sub(CurrentError, 1, 80) -- no symbol
            CurrentType = "UI Error"
            --CoD.EnhModPrintInfo("a LUI Error Occurred! -> ^3" .. CurrentError)
      end

      CurrentError = string.gsub(CurrentError, "\n", " ") -- kilo crash if \n
      CurrentError = "^3" .. CurrentType .. ": " .. CurrentError .. "... (see logs)"

      -- send it to chat
      Engine[@"hash_19B57C0F0680848E"]( "1-1-1", CurrentError )
      return false
end

-- remove error boxes and send the error in chat instead
CoD.RemoveErrorBoxesReload = function()
      function ShouldOpenMessageDialog(f33_arg0, f33_arg1)
            CoD.EnhModPrintInfo("Called", "Should Open Message Dialog")

            if not Orignal_ShouldOpenMessageDialog(f33_arg0, f33_arg1) then
                  CoD.EnhModPrintInfo("Returned....", "Should Open Message Dialog")
                  return false
            end

            local CurrentError = CoD.GetErrorText(f33_arg1)
            local CurrentType = "Unknown Error"
            
            -- here is fixing printing issues (kilo crash)
            if string.find( CurrentError, "script error" ) then -- client and server
                  CurrentError = string.sub(CurrentError, 2, 80) -- cut the stupid symbol that causes print errors
                  CurrentType = "Script Error"
                  --CoD.EnhModPrintInfo("a Script Error Occurred! -> ^3" .. CurrentError)
            elseif string.find( CurrentError, "UI Error") then -- LUI only
                  CurrentError = string.sub(CurrentError, 1, 80) -- no symbol
                  CurrentType = "UI Error"
                  --CoD.EnhModPrintInfo("a LUI Error Occurred! -> ^3" .. CurrentError)
            end

            CurrentError = string.gsub(CurrentError, "\n", " ") -- kilo crash if \n
            CurrentError = "^3" .. CurrentType .. ": " .. CurrentError .. "... (see logs)"

            -- send it to chat
            Engine[@"hash_19B57C0F0680848E"]( "1-1-1", CurrentError )
            return false
      end
end