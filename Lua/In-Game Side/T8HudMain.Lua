--[[
      .\hksc.exe '.\Scripts\T8HudMain.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\T8HudMain.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

-- for notifs
CoD.ZmNotifBGBContainerFactory = nil

-- idk probably not used anymore
CoD.ScorePCNonGlobal = nil

------------------------

-- call overrides
CoD.LoadShitAgain()

-- main hud
LUI.createMenu[ "T7Hud_" .. Engine[@"GetCurrentMap"]() ] = function ( controller ) 
      local self = LUI.createMenu.T7Hud_zm_factory( controller )

      Engine[ @"PrintInfo" ](0, "^2Loading Enhancement Huds...")

      CoD.SetupSubModelForSave_BGB(self, controller)
      CoD.SetupSubModelForSave_Specialist(self, controller)
      CoD.SetupSubModelForSave_Character(self, controller)
      CoD.SetupSubModelForSave_BoxPatch(self, controller)
      CoD.SetupSubModelForSave_Camo(self, controller)

      CoD.SetupAchievementsModels(self, controller)

      CoD.SetupMusicSoundPlayer(self, controller)

      -- whos who
      local WhosWhoMeter = CoD.WhosWhoMeter.new(self, controller, 0, 1, 0, 0, 0, 1, 0, 0)
      self:addElement(WhosWhoMeter)
      self.WhosWhoMeter = WhosWhoMeter

      -- damages
      local Widgets3DContainer = CoD.Widgets3DContainer.new(self, controller, 0, 1, 0, 0, 0, 1, 0, 0)
      self:addElement(Widgets3DContainer)
      self.Widgets3DContainer = Widgets3DContainer

      -- boss health bar
      local BossHealthBar = CoD.BossHealthBar.new(self, controller, 0, 1, 0, 0, 0, 1, 0, 0)
      self:addElement(BossHealthBar)
      self.BossHealthBar = BossHealthBar

      -- loadout
      local EnhLoadout = CoD.EnhLoadoutOptions.new(self, controller, 0, 1, 0, 0, 0, 1, 0, 0)
	EnhLoadout:registerEventHandler( "menu_loaded", function ( element, event )
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded( event )
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded( event )
		end
		if IsLowAspectRatio( self ) and not IsPC() then
			SizeToSafeArea( element, self )
		end
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren( event )
		end
		return f5_local0
	end )
	self:addElement( EnhLoadout )
	self.EnhLoadout = EnhLoadout

      EnhLoadout.id = "EnhLoadout"

      -- main quest post completion
      local EnhQuestContinue = CoD.EnhQuestContinueOptions.new(self, controller, 0, 1, 0, 0, 0, 1, 0, 0)
	EnhQuestContinue:registerEventHandler( "menu_loaded", function ( element, event )
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded( event )
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded( event )
		end
		if IsLowAspectRatio( self ) and not IsPC() then
			SizeToSafeArea( element, self )
		end
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren( event )
		end
		return f5_local0
	end )
	self:addElement( EnhQuestContinue )
	self.EnhQuestContinue = EnhQuestContinue

      EnhQuestContinue.id = "EnhQuestContinue"

      -- hotkey
      local HotkeyMgr = CoD.EnhHotkeyMgr.new(self, controller, 0, 1, 0, 0, 0, 1, 0, 0)
	HotkeyMgr:registerEventHandler( "menu_loaded", function ( element, event )
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded( event )
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded( event )
		end
		if IsLowAspectRatio( self ) and not IsPC() then
			SizeToSafeArea( element, self )
		end
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren( event )
		end
		return f5_local0
	end )
	self:addElement( HotkeyMgr )
	self.HotkeyMgr = HotkeyMgr

      HotkeyMgr.id = "HotkeyMgr"

      -- gestures/callouts
      local CalloutItems = CoD.EnhCalloutItems.new(self, controller, 0, 1, 0, 0, 0, 1, 0, 0)
      CalloutItems:mergeStateConditions( {
		{
			stateName = "Visible",
			condition = function ( menu, element, event )
				local button = CoD.HUDUtility.EnhIsCalloutsButtonPressed( controller )
				return button
			end
		}
	} )
      self:addElement( CalloutItems )
	self.CalloutItems = CalloutItems

      CalloutItems.id = "CalloutItems"

      -- debug lui stuff
      if Engine[@"getdvarint"]("shield_enh_lui_debug") == 1 then
            CoD.AddDebugWidgets(self, controller)
      end

      CoD.ApplyZombieCounter(self, controller)

      local SafeAreaNon = self.SafeAreaContainer
      CoD.ZmNotifBGBContainerFactory = SafeAreaNon.ZmNotifBGBContainerFactory
      local PlayerWidgetNon = SafeAreaNon.PlayerWidget
      local PerksLogicNon = SafeAreaNon.ZMPerkVaporsContainer
      local ExtraPerksNon = PlayerWidgetNon.ZMExtraPerkVapors

      local AmmoWidgetNon = SafeAreaNon.AmmoWidgetZMContainer
      local AmmoWidgetMainNon = AmmoWidgetNon.AmmoWidgetZM

      local EquipmentsNon = AmmoWidgetMainNon.Equipment.Equipment

      local AmmoPCNon = SafeAreaNon.AmmoPC
      local ZmAmmoFacNon = AmmoPCNon.ZmAmmo
      local ZmAmmoProbNon = ZmAmmoFacNon.ZmAmmoProp0
      local BGBFacNon = ZmAmmoProbNon.ZmAmmoBGBCarouselFactory

      local ElixirsPCNon = BGBFacNon.PCButtons -- pc
      local ElixirsConsoleNon = BGBFacNon.buttons -- console...

      local ScorePCNon = SafeAreaNon.ScorePC

      CoD.ScorePCNonGlobal = ScorePCNon

      CoD.ApplySecondEquipments(self, controller, EquipmentsNon)

      -- Logic Perks Extra
      if Engine[@"getdvarint"]("shield_enh_ClassicMode") == 1 then
            local ClassicPerks = CoD.ClassicPerks.new(self, controller, 0, 1, 0, 0, 0, 1, 0, 0)

            if Engine[@"getdvarint"]("shield_enh_AltHud") ~= 1 then
                  ClassicPerks:setLeftRight(0.00, 1.00, 170.00, 0.00)
            end
            
            ScorePCNon:addElement(ClassicPerks)
            ScorePCNon.ClassicPerks = ClassicPerks
      end

      -- directed mode
      local DirectedMode = CoD.DirectedModeObjective.new(self, controller, 0, 1, 0, 0, 0, 1, 0, 0)
      ScorePCNon:addElement(DirectedMode)
      ScorePCNon.DirectedMode = DirectedMode

      -- classic gum logic
      local ClassicGum = CoD.ClassicGum.new(self, controller, 0, 1, 0, 0, 0, 1, 0, 0)
      self.ZMInventory:addElement(ClassicGum)
      self.ZMInventory.ClassicGum = ClassicGum

      -- cranked mode
      local CrankedTimer = CoD.CrankedTimer.new(self, controller, 0, 1, 0, 0, 0, 1, 0, 0)
      ScorePCNon:addElement(CrankedTimer)
      ScorePCNon.CrankedTimer = CrankedTimer

      -- hardcore boss ui
      CoD.ApplyHardcoreBossesUI(self, controller, ElixirsPCNon, ElixirsConsoleNon)

      if Engine[@"getdvarint"]("shield_enh_Perka") == 1 then
            CoD.ApplyMorePerks(self, controller, ExtraPerksNon)
      end

      -- THEY DO NOT HAVE MODIFIERS EFFECT
      if Engine[@"getdvarint"]("shield_enh_SuperPerkMode") == 1 then
            CoD.ApplySuperPerks(self, controller, ExtraPerksNon, PerksLogicNon)
      end

      -- hide bgb if classic
      if Engine[@"getdvarint"]("shield_enh_ClassicMode") == 1 and Engine[@"getdvarint"]("shield_enh_ClassicMode_Loadouts") == 1 then
            BGBFacNon:setAlpha(0)
      end

      -- alt hud
      if Engine[@"getdvarint"]("shield_enh_AltHud") == 1 then
            CoD.ApplyAltHud(self, controller)
      end

      CoD.LoadShitAgain()
      return self
end