--[[
      .\hksc.exe '.\Scripts\SuperPerks.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\SuperPerks.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

CoD.ApplySuperPerks = function(hud, controller, ExtraPerks, PerksLogic)
	-- THEY DO NOT HAVE MODIFIERS EFFECT!!
    ExtraPerks:setRGB(5, 5, 0.7)

	PerksLogic:setRGB(5, 5, 0.7)

	CoD.EnhModPrintInfo("Activated Super Perk Mode for Extra Perks....")
end