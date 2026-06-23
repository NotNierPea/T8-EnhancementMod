--[[
      .\hksc.exe '.\Scripts\ClassicPerks.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\ClassicPerks.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

CoD.ClassicPerks = InheritFrom( LUI.UIElement )
CoD.ClassicPerks.__defaultWidth = 1920
CoD.ClassicPerks.__defaultHeight = 1080
CoD.ClassicPerks.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
    local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.ClassicPerks )
	self.id = "ClassicPerks"
	self.soundSet = "FriendsMenu"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )

    function self:UpdatePerkPositions()
			local visiblePerks = {}
			
			-- collect visible perks
			if self.HasJugg == 1 then table.insert(visiblePerks, self.JuggImage) end
			if self.HasSpeed == 1 then table.insert(visiblePerks, self.SpeedImage) end
			if self.HasDouble == 1 then table.insert(visiblePerks, self.DoubleImage) end
			if self.HasVulture == 1 then table.insert(visiblePerks, self.VultureImage) end
			if self.HasWhosWho == 1 then table.insert(visiblePerks, self.WhosWhoImage) end
			if self.HasElemental == 1 then table.insert(visiblePerks, self.ElementalImage) end

			table.sort(visiblePerks, function(a, b)
					return a.pickupTime < b.pickupTime
			end)

			-- reposition visible ones
			for i, image in ipairs(visiblePerks) do
					local spacing = 50
					local xOffset = (spacing) * (i - 1)

					image:setLeftRight(0, 0, 184 + xOffset, 184 + xOffset + 42)
					image:setTopBottom(0, 0, 305, 347)
			end
      end

      local JuggImage = LUI.UIImage.new(0, 0, 187, 232, 0, 0, 305, 350)
      JuggImage:setImage(RegisterImage(@"jugg_classic"))
      JuggImage:setRGB(1, 1, 1)
      JuggImage:setAlpha(0)
      JuggImage:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"notify_jugg_image" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)

                  if scriptData[1] == 0 then
                        JuggImage:setAlpha(0)
                        self.HasJugg = 0
                        self.JuggImage.pickupTime = 0
                  elseif scriptData[1] == 1 then
                        JuggImage:setAlpha(1)
                        self.HasJugg = 1
                        self.JuggImage.pickupTime = Engine[@"milliseconds"]()
                  end

                  self:UpdatePerkPositions()
            end
      end)
      self:addElement(JuggImage)
      self.HasJugg = 0
      self.JuggImage = JuggImage

      local SpeedImage = LUI.UIImage.new(0, 0, 187 + 50, 232 + 50, 0, 0, 305, 350)
      SpeedImage:setImage(RegisterImage(@"speed_classic"))
      SpeedImage:setRGB(1, 1, 1)
      SpeedImage:setAlpha(0)
      SpeedImage:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"notify_speed_image" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)

                  if scriptData[1] == 0 then
                        SpeedImage:setAlpha(0)
                        self.HasSpeed = 0
                        self.SpeedImage.pickupTime = 0
                  elseif scriptData[1] == 1 then
                        SpeedImage:setAlpha(1)
                        self.HasSpeed = 1
                        self.SpeedImage.pickupTime = Engine[@"milliseconds"]()
                  end

                  self:UpdatePerkPositions()
            end
      end)
      self:addElement(SpeedImage)
      self.HasSpeed = 0
      self.SpeedImage = SpeedImage

      local DoubleImage = LUI.UIImage.new(0, 0, 187 + 100, 232 + 100, 0, 0, 305, 350)
      DoubleImage:setImage(RegisterImage(@"double_classic_one"))
      DoubleImage:setRGB(1, 1, 1)
      DoubleImage:setAlpha(0)
      DoubleImage:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"notify_double_image" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)

                  if scriptData[1] == 0 then
                        DoubleImage:setAlpha(0)
                        self.HasDouble = 0
                        self.DoubleImage.pickupTime = 0
                  elseif scriptData[1] == 1 then
                        DoubleImage:setAlpha(1)
                        self.HasDouble = 1
                        self.DoubleImage.pickupTime = Engine[@"milliseconds"]()
                  end

                  if scriptData[1] == 2 then
                        DoubleImage:setImage(RegisterImage(@"double_classic"))
                  end

                  self:UpdatePerkPositions()
            end
      end)
      self:addElement(DoubleImage)
      self.HasDouble = 0
      self.DoubleImage = DoubleImage

      local WhosWhoImage = LUI.UIImage.new(0, 0, 187 + 100, 232 + 100, 0, 0, 305, 350)
      WhosWhoImage:setImage(RegisterImage(@"who_classic"))
      WhosWhoImage:setRGB(1, 1, 1)
      WhosWhoImage:setAlpha(0)
      WhosWhoImage:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"notify_whos_who_image" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)

                  if scriptData[1] == 0 then
                        WhosWhoImage:setAlpha(0)
                        self.HasWhosWho = 0
                        self.WhosWhoImage.pickupTime = 0
                  elseif scriptData[1] == 1 then
                        WhosWhoImage:setAlpha(1)
                        self.HasWhosWho = 1
                        self.WhosWhoImage.pickupTime = Engine[@"milliseconds"]()
                  end

                  self:UpdatePerkPositions()
            end
      end)
      self:addElement(WhosWhoImage)
      self.HasWhosWho = 0
      self.WhosWhoImage = WhosWhoImage

      local ElementalImage = LUI.UIImage.new(0, 0, 187 + 100, 232 + 100, 0, 0, 305, 350)
      ElementalImage:setImage(RegisterImage(@"elem_classic"))
      ElementalImage:setRGB(1, 1, 1)
      ElementalImage:setAlpha(0)
      ElementalImage:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"notify_elem_image" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)

                  if scriptData[1] == 0 then
                        ElementalImage:setAlpha(0)
                        self.HasElemental = 0
                        self.ElementalImage.pickupTime = 0
                  elseif scriptData[1] == 1 then
                        ElementalImage:setAlpha(1)
                        self.HasElemental = 1
                        self.ElementalImage.pickupTime = Engine[@"milliseconds"]()
                  end

                  self:UpdatePerkPositions()
            end
      end)
      self:addElement(ElementalImage)
      self.HasElemental = 0
      self.ElementalImage = ElementalImage

      local VultureImage = LUI.UIImage.new(0, 0, 187 + 150, 232 + 150, 0, 0, 305, 350)
      VultureImage:setImage(RegisterImage(@"vult_classic"))
      VultureImage:setRGB(1, 1, 1)
      VultureImage:setAlpha(0)
      VultureImage:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"notify_vulture_image" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)

                  if scriptData[1] == 0 then
                        VultureImage:setAlpha(0)
                        self.HasVulture = 0
                        self.VultureImage.pickupTime = 0
                  elseif scriptData[1] == 1 then
                        VultureImage:setAlpha(1)
                        self.HasVulture = 1
                        self.VultureImage.pickupTime = Engine[@"milliseconds"]()
                  end

                  self:UpdatePerkPositions()
            end
      end)
      self:addElement(VultureImage)
      self.HasVulture = 0
      self.VultureImage = VultureImage

      self:mergeStateConditions( {
		{
			stateName = "Hidden",
			condition = function ( menu, element, event )
				local f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"] )
				if not f12_local0 then
					f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"] )
					if not f12_local0 then
						f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"] )
						if not f12_local0 then
							f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"] )
							if not f12_local0 then
								if Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"] ) then
									f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"] )
									if not f12_local0 then
										f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"] )
										if not f12_local0 then
											f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"] )
											if not f12_local0 then
												f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"] )
												if not f12_local0 then
													f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"] )
													if not f12_local0 then
														f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"] )
														if not f12_local0 then
															f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"] )
														end
													end
												end
											end
										end
									end
								else
									f12_local0 = true
								end
							end
						end
					end
				end
				return f12_local0
			end
		}
	} )
      
    local f1_local12 = self
	local f1_local13 = self.subscribeToModel
	local f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function ( f13_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function ( f14_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function ( f15_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function ( f16_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function ( f17_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function ( f18_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function ( f19_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function ( f20_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function ( f21_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function ( f22_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function ( f23_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function ( f24_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]
		} )
	end, false )

      LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )

      if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.ClassicPerks.__resetProperties = function ( f16_arg0 )
	f16_arg0.JuggImage:completeAnimation()
	f16_arg0.JuggImage:setRGB(1, 1, 1)
	f16_arg0.JuggImage:setAlpha(f16_arg0.HasJugg)
	f16_arg0.SpeedImage:completeAnimation()
	f16_arg0.SpeedImage:setRGB(1, 1, 1)
	f16_arg0.SpeedImage:setAlpha(f16_arg0.HasSpeed)
	f16_arg0.DoubleImage:completeAnimation()
	f16_arg0.DoubleImage:setRGB(1, 1, 1)
	f16_arg0.DoubleImage:setAlpha(f16_arg0.HasDouble)
	f16_arg0.VultureImage:completeAnimation()
	f16_arg0.VultureImage:setRGB(1, 1, 1)
	f16_arg0.VultureImage:setAlpha(f16_arg0.HasVulture)
	f16_arg0.WhosWhoImage:completeAnimation()
	f16_arg0.WhosWhoImage:setRGB(1, 1, 1)
	f16_arg0.WhosWhoImage:setAlpha(f16_arg0.HasWhosWho)
	f16_arg0.ElementalImage:completeAnimation()
	f16_arg0.ElementalImage:setRGB(1, 1, 1)
	f16_arg0.ElementalImage:setAlpha(f16_arg0.HasElemental)
end

CoD.ClassicPerks.__clipsPerState = {

	DefaultState = {
		DefaultClip = function ( f17_arg0, f17_arg1 )
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter( 0 )
		end,

			Hidden = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			f18_arg0.JuggImage:completeAnimation()
			f18_arg0.JuggImage:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.JuggImage )

			f18_arg0.SpeedImage:completeAnimation()
			f18_arg0.SpeedImage:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.SpeedImage )

			f18_arg0.DoubleImage:completeAnimation()
			f18_arg0.DoubleImage:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.DoubleImage )

			f18_arg0.VultureImage:completeAnimation()
			f18_arg0.VultureImage:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.VultureImage )

			f18_arg0.WhosWhoImage:completeAnimation()
			f18_arg0.WhosWhoImage:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.WhosWhoImage )

			f18_arg0.ElementalImage:completeAnimation()
			f18_arg0.ElementalImage:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.ElementalImage )
		end
	},

	Hidden = {
		DefaultClip = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			f18_arg0.JuggImage:completeAnimation()
			f18_arg0.JuggImage:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.JuggImage )

            f18_arg0.SpeedImage:completeAnimation()
			f18_arg0.SpeedImage:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.SpeedImage )

            f18_arg0.DoubleImage:completeAnimation()
			f18_arg0.DoubleImage:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.DoubleImage )

            f18_arg0.VultureImage:completeAnimation()
			f18_arg0.VultureImage:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.VultureImage )

            f18_arg0.WhosWhoImage:completeAnimation()
			f18_arg0.WhosWhoImage:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.WhosWhoImage )

            f18_arg0.ElementalImage:completeAnimation()
			f18_arg0.ElementalImage:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.ElementalImage )
		end
	}

}

CoD.ClassicPerks.__onClose = function ( f19_arg0 )
	f19_arg0.JuggImage:close()
	f19_arg0.SpeedImage:close()
	f19_arg0.DoubleImage:close()
	f19_arg0.VultureImage:close()
	f19_arg0.WhosWhoImage:close()
	f19_arg0.ElementalImage:close()
end