--[[
      .\hksc.exe '.\Scripts\ChatCommands.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\ChatCommands.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

local function SaveGameCommand()
      PlaySoundAlias( "uin_paint_image_flip_toggle" )
      CoD.EnhModPrintInfo("Save Save!")
      
      -- save
      Engine[@"exec"](Engine[@"getprimarycontroller"](), 'set shield_enh_SaveGame 1')

      -- notice (util is not loaded so no)
      --CoD.OverlayUtility.CreateOverlay(controller, menu, "EnhSaveSaved")

      -- must return something
      return false, true, false, @"shield/saved"
end

local ThirdPersonActive = 0
local function TryThirdPerson()
      PlaySoundAlias( "uin_paint_image_flip_toggle" )

      if ThirdPersonActive == 0 then
            ThirdPersonActive = 1
      else
            ThirdPersonActive = 0
      end

      -- doesn't work
      --ThirdPersonActive = not ThirdPersonActive

      CoD.EnhModPrintInfo("Third Third! -> " .. Engine[@"getclientnum"]( Engine[@"getprimarycontroller"]()) .. " -> " .. ThirdPersonActive)

      -- set thr
      CoD.BaseUtility.SendCustomMenuResponse(Engine[@"getprimarycontroller"](), "shield_enh_menu", "blah", ThirdPersonActive)

      -- must return something
      return false, true, false, @"shield/thirdperson"
end

local function TrySendRampage()
      PlaySoundAlias( "uin_paint_image_flip_toggle" )
      -- set thr
      CoD.BaseUtility.SendCustomMenuResponse(Engine[@"getprimarycontroller"](), "shield_enh_menu", "blah", 4)

      -- must return something
      return false, true, false, @"shield/rampage_message"
end

local function TrySendCamo(f34_arg0, f34_arg1, f34_arg2)
      if f34_arg1 == nil and CoD.ChatClientUtility.ChatWidget then
		return false, f34_arg2 == nil, false, @"shield/wrong_camo_message"
	elseif f34_arg1 then
		local CamoIDGet = tonumber(f34_arg1)

		if CamoIDGet ~= nil and CamoIDGet > 0 then
			CoD.EnhModPrintInfo("Camo ID", CamoIDGet)

                  PlaySoundAlias( "uin_paint_image_flip_toggle" )
			CoD.BaseUtility.SendCustomMenuResponse(Engine[@"getprimarycontroller"](), "shield_enh_menu", "shield_enh_camo", CamoIDGet)

			return false, true, false, @"shield/camo_message"
		end
	end

	return false, true, false, @"shield/wrong_camo_message"
end

-- insert commands..
table.insert(CoD.ChatClientUtility.ChatCommands, {
      strings = {
            "save",
            "savegame"
      },
      fct = SaveGameCommand
})

table.insert(CoD.ChatClientUtility.ChatCommands, {
      strings = {
            "thr",
            "thirdperson"
      },
      fct = TryThirdPerson
})

table.insert(CoD.ChatClientUtility.ChatCommands, {
      strings = {
            "rampage",
            "rmp"
      },
      fct = TrySendRampage
})

table.insert(CoD.ChatClientUtility.ChatCommands, {
      strings = {
            "camo",
            "cm"
      },
      fct = TrySendCamo
})