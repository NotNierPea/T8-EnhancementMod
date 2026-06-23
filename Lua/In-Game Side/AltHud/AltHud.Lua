--[[
      .\hksc.exe '.\Scripts\AltHud.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\AltHud.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

-- Custom Glow BG
CoD.ScoreGlowBG = InheritFrom( LUI.UIElement )
CoD.ScoreGlowBG.__defaultWidth = 1920
CoD.ScoreGlowBG.__defaultHeight = 1080
CoD.ScoreGlowBG.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
      local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.ScoreGlowBG )
	self.id = "ScoreGlowBG"
	self.soundSet = "FriendsMenu"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )

      -- Glowing Score
      --local GlowScore
      local GlowScore = LUI.UIImage.new(0.00, 0.00, 72, 220.00, 0.00, 0.00, 22.00, 89.00) -- need good y pos

      if Engine[@"getdvarint"]("shield_enh_ClassicMode") == 1 then
            GlowScore:setTopBottom(0.00, 0.00, 22.00, 89.00)
            GlowScore:setLeftRight(0.00, 0.00, 72, 220.00)
      end

      GlowScore:setAlpha(0.60)
      GlowScore:setImage(RegisterImage(@"score_bg"))
      --GlowScore:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
      GlowScore:setRGB(1, 1, 1)
      self:addElement(GlowScore)
      self.GlowScore = GlowScore

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

CoD.ScoreGlowBG.__resetProperties = function ( f16_arg0 )
	f16_arg0.GlowScore:completeAnimation()
	f16_arg0.GlowScore:setRGB(1, 1, 1)
      f16_arg0.GlowScore:setAlpha(0.60)
end

CoD.ScoreGlowBG.__clipsPerState = {

	DefaultState = {
		DefaultClip = function ( f17_arg0, f17_arg1 )
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter( 0 )
		end,

            Hidden = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			f18_arg0.GlowScore:completeAnimation()
			f18_arg0.GlowScore:setAlpha(0)
                  --CoD.EnhModPrintInfo("Test Hidden")
			f18_arg0.clipFinished( f18_arg0.GlowScore )
		end
	},

	Hidden = {
		DefaultClip = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			f18_arg0.GlowScore:completeAnimation()
			f18_arg0.GlowScore:setAlpha(0)
                  --CoD.EnhModPrintInfo("Test Hidden")
			f18_arg0.clipFinished( f18_arg0.GlowScore )
		end
	}

}

CoD.ScoreGlowBG.__onClose = function ( f19_arg0 )
	f19_arg0.GlowScore:close()
end

-- Custom Glow BG, scr
CoD.ScoreGlowBGList = InheritFrom( LUI.UIElement )
CoD.ScoreGlowBGList.__defaultWidth = 1920
CoD.ScoreGlowBGList.__defaultHeight = 1080
CoD.ScoreGlowBGList.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
      local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.ScoreGlowBGList )
	self.id = "ScoreGlowBGList"
	self.soundSet = "FriendsMenu"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )

      -- Glowing Score
      --local GlowScore
      local GlowScore = LUI.UIImage.new(0.00, 0.00, 73, 200.00, 0.00, 0.00, 14.00, 73.00) -- need good y pos

      if Engine[@"getdvarint"]("shield_enh_ClassicMode") == 1 then
            GlowScore:setTopBottom(0.00, 0.00, 14.00, 73.0)
            GlowScore:setLeftRight(0.00, 0.00, 73, 200.00)
      end

      GlowScore:setAlpha(0.60)
      GlowScore:setImage(RegisterImage(@"score_bg"))
      --GlowScore:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
      GlowScore:setRGB(1, 1, 1)
      self:addElement(GlowScore)
      self.GlowScore = GlowScore

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

CoD.ScoreGlowBGList.__resetProperties = function ( f16_arg0 )
	f16_arg0.GlowScore:completeAnimation()
	f16_arg0.GlowScore:setRGB(1, 1, 1)
      f16_arg0.GlowScore:setAlpha(0.60)
end

CoD.ScoreGlowBGList.__clipsPerState = {

	DefaultState = {
		DefaultClip = function ( f17_arg0, f17_arg1 )
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter( 0 )
		end,

            Hidden = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			f18_arg0.GlowScore:completeAnimation()
			f18_arg0.GlowScore:setAlpha(0)
                  --CoD.EnhModPrintInfo("Test Hidden")
			f18_arg0.clipFinished( f18_arg0.GlowScore )
		end
	},

	Hidden = {
		DefaultClip = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			f18_arg0.GlowScore:completeAnimation()
			f18_arg0.GlowScore:setAlpha(0)
                  --CoD.EnhModPrintInfo("Test Hidden")
			f18_arg0.clipFinished( f18_arg0.GlowScore )
		end
	}

}

CoD.ScoreGlowBGList.__onClose = function ( f19_arg0 )
	f19_arg0.GlowScore:close()
end

------------------------

-- every override for alt hud, im too lazy to separate them honestly lol
CoD.LoadAltHuds = function()
      -- Ammo Widget ZM Clip Info
      CoD.AmmoWidgetZM_ClipInfo = InheritFrom( LUI.UIElement )
      CoD.AmmoWidgetZM_ClipInfo.__defaultWidth = 120
      CoD.AmmoWidgetZM_ClipInfo.__defaultHeight = 80
      CoD.AmmoWidgetZM_ClipInfo.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.AmmoWidgetZM_ClipInfo )
            self.id = "AmmoWidgetZM_ClipInfo"
            self.soundSet = "default"
            self.anyChildUsesUpdateState = true
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            local Clip = CoD.AmmoWidgetZM_ClipContainerNew.new( f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 1.5, 51.5 )
            Clip:mergeStateConditions( {
                  {
                        stateName = "LowAmmo",
                        condition = function ( menu, element, event )
                              local f2_local0 = IsLowAmmoClip( f1_arg1 )
                              if f2_local0 then
                                    f2_local0 = WeaponHasAmmo( f1_arg1 )
                                    if f2_local0 then
                                          f2_local0 = not IsSignatureWeaponInUse( f1_arg1 )
                                    end
                              end
                              return f2_local0
                        end
                  },
                  {
                        stateName = "NoAmmo",
                        condition = function ( menu, element, event )
                              local f3_local0
                              if not WeaponHasAmmo( f1_arg1 ) then
                                    f3_local0 = CoD.WeaponUtility.CurrentZMWeaponUsesAmmo( f1_arg1 )
                                    if f3_local0 then
                                          f3_local0 = not CoD.HUDUtility.IsCurrentViewmodelWeaponGamemodeHiddenAmmo( f1_arg1 )
                                    end
                              else
                                    f3_local0 = false
                              end
                              return f3_local0
                        end
                  },
                  {
                        stateName = "Hero",
                        condition = function ( menu, element, event )
                              return IsSignatureWeaponInUse( f1_arg1 )
                        end
                  }
            } )
            local ClipHero = Clip
            local ClipDual = Clip.subscribeToModel
            local ClipOnly = DataSources.CurrentWeapon.getModel( f1_arg1 )
            ClipDual( ClipHero, ClipOnly.ammoLow, function ( f5_arg0 )
                  f1_arg0:updateElementState( Clip, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f5_arg0:get(),
                        modelName = "ammoLow"
                  } )
            end, false )
            ClipHero = Clip
            ClipDual = Clip.subscribeToModel
            ClipOnly = DataSources.CurrentWeapon.getModel( f1_arg1 )
            ClipDual( ClipHero, ClipOnly.weaponHasAmmo, function ( f6_arg0 )
                  f1_arg0:updateElementState( Clip, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f6_arg0:get(),
                        modelName = "weaponHasAmmo"
                  } )
            end, false )
            ClipHero = Clip
            ClipDual = Clip.subscribeToModel
            ClipOnly = DataSources.CurrentWeapon.getModel( f1_arg1 )
            ClipDual( ClipHero, ClipOnly.equippedWeaponReference, function ( f7_arg0 )
                  f1_arg0:updateElementState( Clip, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f7_arg0:get(),
                        modelName = "equippedWeaponReference"
                  } )
            end, false )
            ClipHero = Clip
            ClipDual = Clip.subscribeToModel
            ClipOnly = DataSources.CurrentWeapon.getModel( f1_arg1 )
            ClipDual( ClipHero, ClipOnly.viewmodelWeaponName, function ( f8_arg0 )
                  f1_arg0:updateElementState( Clip, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f8_arg0:get(),
                        modelName = "viewmodelWeaponName"
                  } )
            end, false )
            Clip:linkToElementModel( self, "ammoInClip", true, function ( model )
                  local f9_local0 = model:get()
                  if f9_local0 ~= nil then
                        Clip.Clip.ClipShadow:setText( f9_local0 )
                  end
            end )
            Clip:linkToElementModel( self, "ammoInClip", true, function ( model )
                  local f10_local0 = model:get()
                  if f10_local0 ~= nil then
                        Clip.Clip.Clip:setText( f10_local0 )
                  end
            end )
            Clip:linkToElementModel( self, "ammoInClip", true, function ( model )
                  local f11_local0 = model:get()
                  if f11_local0 ~= nil then
                        Clip.ClipContainerPress.Clip:setText( f11_local0 )
                  end
            end )
            self:addElement( Clip )
            self.Clip = Clip
            
            ClipDual = CoD.AmmoWidgetZM_ClipContainerNew.new( f1_arg0, f1_arg1, 0.00, 1.00, -110.00, 0.00, 0.00, 0.00, 1.50, 51.50 )
            ClipDual:mergeStateConditions( {
                  {
                        stateName = "LowAmmo",
                        condition = function ( menu, element, event )
                              return IsLowAmmoDWClip( f1_arg1 )
                        end
                  },
                  {
                        stateName = "NoAmmo",
                        condition = function ( menu, element, event )
                              return AlwaysFalse()
                        end
                  },
                  {
                        stateName = "Hero",
                        condition = function ( menu, element, event )
                              return AlwaysFalse()
                        end
                  }
            } )
            ClipOnly = ClipDual
            ClipHero = ClipDual.subscribeToModel
            local TotalAmmoLabel = DataSources.CurrentWeapon.getModel( f1_arg1 )
            ClipHero( ClipOnly, TotalAmmoLabel.ammoDWLow, function ( f15_arg0 )
                  f1_arg0:updateElementState( ClipDual, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f15_arg0:get(),
                        modelName = "ammoDWLow"
                  } )
            end, false )
            ClipDual:setAlpha( 0 )
            ClipDual:setZoom( 3 )
            ClipDual:linkToElementModel( self, "ammoInDWClip", true, function ( model )
                  local f16_local0 = model:get()
                  if f16_local0 ~= nil then
                        ClipDual.Clip.ClipShadow:setText( f16_local0 )
                  end
            end )
            ClipDual:linkToElementModel( self, "ammoInDWClip", true, function ( model )
                  local f17_local0 = model:get()
                  if f17_local0 ~= nil then
                        ClipDual.Clip.Clip:setText( f17_local0 )
                  end
            end )
            ClipDual:linkToElementModel( self, "ammoInDWClip", true, function ( model )
                  local f18_local0 = model:get()
                  if f18_local0 ~= nil then
                        ClipDual.ClipContainerPress.Clip:setText( f18_local0 )
                  end
            end )
            self:addElement( ClipDual )
            self.ClipDual = ClipDual

            ClipHero = CoD.AmmoWidgetZM_ClipContainerHero.new( f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 17, 17 )
            ClipHero:mergeStateConditions( {
                  {
                        stateName = "Weapon",
                        condition = function ( menu, element, event )
                              return CoD.HUDUtility.UsingPlayerGadgetWithBar( f1_arg1 ) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum( f1_arg1, "PlayerAbilities", "playerGadget3.state", Enum[@"weapongadgetstates"][@"player_ability_state_inuse"] )
                        end
                  },
                  {
                        stateName = "Ability",
                        condition = function ( menu, element, event )
                              return CoD.HUDUtility.UsingPlayerGadgetWithBar( f1_arg1 )
                        end
                  }
            } )
            TotalAmmoLabel = ClipHero
            ClipOnly = ClipHero.subscribeToModel
            local TabBottomLine = DataSources.PlayerAbilities.getModel( f1_arg1 )
            ClipOnly( TotalAmmoLabel, TabBottomLine["playerGadget2.state"], function ( f21_arg0 )
                  f1_arg0:updateElementState( ClipHero, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f21_arg0:get(),
                        modelName = "playerGadget2.state"
                  } )
            end, false )
            TotalAmmoLabel = ClipHero
            ClipOnly = ClipHero.subscribeToModel
            TabBottomLine = DataSources.PlayerAbilities.getModel( f1_arg1 )
            ClipOnly( TotalAmmoLabel, TabBottomLine["playerGadget3.state"], function ( f22_arg0 )
                  f1_arg0:updateElementState( ClipHero, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f22_arg0:get(),
                        modelName = "playerGadget3.state"
                  } )
            end, false )
            TotalAmmoLabel = ClipHero
            ClipOnly = ClipHero.subscribeToModel
            TabBottomLine = DataSources.CurrentWeapon.getModel( f1_arg1 )
            ClipOnly( TotalAmmoLabel, TabBottomLine.viewmodelWeaponName, function ( f23_arg0 )
                  f1_arg0:updateElementState( ClipHero, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f23_arg0:get(),
                        modelName = "viewmodelWeaponName"
                  } )
            end, false )
            ClipHero:setAlpha( 0 )
            ClipHero:setZoom( 3 )
            self:addElement( ClipHero )
            self.ClipHero = ClipHero
            
            ClipOnly = CoD.AmmoWidgetZM_ClipContainerNew.new( f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -37.5, 37.5 )
            ClipOnly:mergeStateConditions( {
                  {
                        stateName = "LowAmmo",
                        condition = function ( menu, element, event )
                              return IsLowAmmoClip( f1_arg1 ) and WeaponHasAmmo( f1_arg1 )
                        end
                  },
                  {
                        stateName = "NoAmmo",
                        condition = function ( menu, element, event )
                              local f25_local0
                              if not WeaponHasAmmo( f1_arg1 ) then
                                    f25_local0 = CoD.WeaponUtility.CurrentZMWeaponUsesAmmo( f1_arg1 )
                              else
                                    f25_local0 = false
                              end
                              return f25_local0
                        end
                  },
                  {
                        stateName = "Hero",
                        condition = function ( menu, element, event )
                              return AlwaysTrue()
                        end
                  }
            } )
            TabBottomLine = ClipOnly
            TotalAmmoLabel = ClipOnly.subscribeToModel
            local TabBottomLine2 = DataSources.CurrentWeapon.getModel( f1_arg1 )
            TotalAmmoLabel( TabBottomLine, TabBottomLine2.ammoLow, function ( f27_arg0 )
                  f1_arg0:updateElementState( ClipOnly, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f27_arg0:get(),
                        modelName = "ammoLow"
                  } )
            end, false )
            TabBottomLine = ClipOnly
            TotalAmmoLabel = ClipOnly.subscribeToModel
            TabBottomLine2 = DataSources.CurrentWeapon.getModel( f1_arg1 )
            TotalAmmoLabel( TabBottomLine, TabBottomLine2.weaponHasAmmo, function ( f28_arg0 )
                  f1_arg0:updateElementState( ClipOnly, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f28_arg0:get(),
                        modelName = "weaponHasAmmo"
                  } )
            end, false )
            TabBottomLine = ClipOnly
            TotalAmmoLabel = ClipOnly.subscribeToModel
            TabBottomLine2 = DataSources.CurrentWeapon.getModel( f1_arg1 )
            TotalAmmoLabel( TabBottomLine, TabBottomLine2.equippedWeaponReference, function ( f29_arg0 )
                  f1_arg0:updateElementState( ClipOnly, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f29_arg0:get(),
                        modelName = "equippedWeaponReference"
                  } )
            end, false )
            ClipOnly:setAlpha( 0 )
            ClipOnly:setScale( 0.8, 0.8 )
            ClipOnly:linkToElementModel( self, "ammoInClip", true, function ( model )
                  local f30_local0 = model:get()
                  if f30_local0 ~= nil then
                        ClipOnly.Clip.ClipShadow:setText( f30_local0 )
                  end
            end )
            ClipOnly:linkToElementModel( self, "ammoInClip", true, function ( model )
                  local f31_local0 = model:get()
                  if f31_local0 ~= nil then
                        ClipOnly.Clip.Clip:setText( f31_local0 )
                  end
            end )
            ClipOnly:linkToElementModel( self, "ammoInClip", true, function ( model )
                  local f32_local0 = model:get()
                  if f32_local0 ~= nil then
                        ClipOnly.ClipContainerPress.Clip:setText( f32_local0 )
                  end
            end )
            self:addElement( ClipOnly )
            self.ClipOnly = ClipOnly
            
            TotalAmmoLabel = LUI.UIText.new( 0, 1, 0, 0, 0, 0, 55, 75 )
            TotalAmmoLabel:setRGB( ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b )
            TotalAmmoLabel:setTTF( "skorzhen" )
            TotalAmmoLabel:setLetterSpacing( 2 )
            TotalAmmoLabel:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            TotalAmmoLabel:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
            TotalAmmoLabel:linkToElementModel( self, "ammoStock", true, function ( model )
                  local f33_local0 = model:get()
                  if f33_local0 ~= nil then
                        TotalAmmoLabel:setText( f33_local0 )
                  end
            end )
            self:addElement( TotalAmmoLabel )
            self.TotalAmmoLabel = TotalAmmoLabel
            
            TabBottomLine = LUI.UIImage.new( 0.2, 0.8, 0, 0, 0, 0, 46.5, 50.5 )
            TabBottomLine:setAlpha( 0.5 )
            TabBottomLine:setImage( RegisterImage( @"uie_ui_menu_common_tab_line_bottom" ) )
            TabBottomLine:setMaterial( LUI.UIImage.GetCachedMaterial( @"ui_add" ) )
            self:addElement( TabBottomLine )
            self.TabBottomLine = TabBottomLine
            
            TabBottomLine2 = LUI.UIImage.new( 0.1, 0.1, 30.5, 65.5, 0, 0, 23, 18 )
            TabBottomLine2:setAlpha( 0 )
            TabBottomLine2:setZRot( 90 )
            TabBottomLine2:setImage( RegisterImage( @"uie_ui_menu_common_tab_line_bottom" ) )
            TabBottomLine2:setMaterial( LUI.UIImage.GetCachedMaterial( @"ui_add" ) )
            self:addElement( TabBottomLine2 )
            self.TabBottomLine2 = TabBottomLine2
            
            self:mergeStateConditions( {
                  {
                        stateName = "HiddenGamemodeWeapon",
                        condition = function ( menu, element, event )
                              return CoD.HUDUtility.IsCurrentViewmodelWeaponGamemodeHiddenAmmo( f1_arg1 )
                        end
                  },
                  {
                        stateName = "HeroWeapon",
                        condition = function ( menu, element, event )
                              return CoD.HUDUtility.UsingPlayerGadgetWithBar( f1_arg1 )
                        end
                  },
                  {
                        stateName = "ClipOnly",
                        condition = function ( menu, element, event )
                              return CoD.WeaponUtility.CurrentZMWeaponUsesAmmo( f1_arg1 ) and CoD.WeaponUtility.CurrentZMWeaponIsClipOnlyAmmo( f1_arg1 )
                        end
                  },
                  {
                        stateName = "WeaponDual",
                        condition = function ( menu, element, event )
                              local f37_local0 = CoD.WeaponUtility.CurrentZMWeaponUsesAmmo( f1_arg1 )
                              if f37_local0 then
                                    f37_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan( f1_arg1, "CurrentWeapon", "ammoInDWClip", -1 )
                                    if f37_local0 then
                                          f37_local0 = not CoD.HUDUtility.IsCurrentViewmodelWeaponGamemodeHiddenDWAmmo( f1_arg1 )
                                    end
                              end
                              return f37_local0
                        end
                  },
                  {
                        stateName = "Weapon",
                        condition = function ( menu, element, event )
                              return CoD.WeaponUtility.CurrentZMWeaponUsesAmmo( f1_arg1 ) and not IsWeaponClipGreaterThanOrEqualTo( f1_arg1, 100 )
                        end
                  },
                  {
                        stateName = "Weapon3Digits",
                        condition = function ( menu, element, event )
                              return CoD.WeaponUtility.CurrentZMWeaponUsesAmmo( f1_arg1 ) and IsWeaponClipGreaterThanOrEqualTo( f1_arg1, 100 )
                        end
                  }
            } )
            local f1_local8 = self
            local f1_local9 = self.subscribeToModel
            local f1_local10 = DataSources.CurrentWeapon.getModel( f1_arg1 )
            f1_local9( f1_local8, f1_local10.viewmodelWeaponName, function ( f40_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f40_arg0:get(),
                        modelName = "viewmodelWeaponName"
                  } )
            end, false )
            f1_local8 = self
            f1_local9 = self.subscribeToModel
            f1_local10 = DataSources.PlayerAbilities.getModel( f1_arg1 )
            f1_local9( f1_local8, f1_local10["playerGadget2.state"], function ( f41_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f41_arg0:get(),
                        modelName = "playerGadget2.state"
                  } )
            end, false )
            f1_local8 = self
            f1_local9 = self.subscribeToModel
            f1_local10 = DataSources.PlayerAbilities.getModel( f1_arg1 )
            f1_local9( f1_local8, f1_local10["playerGadget3.state"], function ( f42_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f42_arg0:get(),
                        modelName = "playerGadget3.state"
                  } )
            end, false )
            f1_local8 = self
            f1_local9 = self.subscribeToModel
            f1_local10 = DataSources.CurrentWeapon.getModel( f1_arg1 )
            f1_local9( f1_local8, f1_local10.equippedWeaponReference, function ( f43_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f43_arg0:get(),
                        modelName = "equippedWeaponReference"
                  } )
            end, false )
            f1_local8 = self
            f1_local9 = self.subscribeToModel
            f1_local10 = DataSources.CurrentWeapon.getModel( f1_arg1 )
            f1_local9( f1_local8, f1_local10.isClipOnly, function ( f44_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f44_arg0:get(),
                        modelName = "isClipOnly"
                  } )
            end, false )
            f1_local8 = self
            f1_local9 = self.subscribeToModel
            f1_local10 = DataSources.CurrentWeapon.getModel( f1_arg1 )
            f1_local9( f1_local8, f1_local10.ammoInDWClip, function ( f45_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f45_arg0:get(),
                        modelName = "ammoInDWClip"
                  } )
            end, false )
            f1_local8 = self
            f1_local9 = self.subscribeToModel
            f1_local10 = DataSources.CurrentWeapon.getModel( f1_arg1 )
            f1_local9( f1_local8, f1_local10.clipMaxAmmo, function ( f46_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f46_arg0:get(),
                        modelName = "clipMaxAmmo"
                  } )
            end, false )
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            return self
      end

      CoD.AmmoWidgetZM_ClipInfo.__resetProperties = function ( f47_arg0 )
            f47_arg0.TabBottomLine2:completeAnimation()
            f47_arg0.TabBottomLine:completeAnimation()
            f47_arg0.TotalAmmoLabel:completeAnimation()
            f47_arg0.ClipOnly:completeAnimation()
            f47_arg0.ClipHero:completeAnimation()
            f47_arg0.ClipDual:completeAnimation()
            f47_arg0.Clip:completeAnimation()
            f47_arg0.TabBottomLine2:setLeftRight( 0.1, 0.1, 30.5, 65.5 )
            f47_arg0.TabBottomLine2:setAlpha( 0 )
            f47_arg0.TabBottomLine:setAlpha( 0.5 )
            f47_arg0.TotalAmmoLabel:setAlpha( 1 )
            f47_arg0.ClipOnly:setAlpha( 0 )
            f47_arg0.ClipHero:setLeftRight( 0, 1, 0, 0 )
            f47_arg0.ClipHero:setTopBottom( 0, 1, 17, 17 )
            f47_arg0.ClipHero:setRGB( 1, 1, 1 )
            f47_arg0.ClipHero:setAlpha( 0 )
            f47_arg0.ClipDual:setLeftRight( 0.00, 1.00, -70.00, 0.00 )
            f47_arg0.ClipDual:setTopBottom( 0.00, 0.00, 1.50, 51.50 )
            f47_arg0.ClipDual:setAlpha( 0 )
            f47_arg0.Clip:setLeftRight( 0, 1, 0, 0 )
            f47_arg0.Clip:setTopBottom( 0, 0, 1.5, 51.5 )
            f47_arg0.Clip:setAlpha( 1 )
      end

      CoD.AmmoWidgetZM_ClipInfo.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f48_arg0, f48_arg1 )
                        f48_arg0:__resetProperties()
                        f48_arg0:setupElementClipCounter( 7 )
                        f48_arg0.Clip:completeAnimation()
                        f48_arg0.Clip:setAlpha( 0 )
                        f48_arg0.clipFinished( f48_arg0.Clip )
                        f48_arg0.ClipDual:completeAnimation()
                        f48_arg0.ClipDual:setAlpha( 0 )
                        f48_arg0.clipFinished( f48_arg0.ClipDual )
                        f48_arg0.ClipHero:completeAnimation()
                        f48_arg0.ClipHero:setAlpha( 0 )
                        f48_arg0.clipFinished( f48_arg0.ClipHero )
                        f48_arg0.ClipOnly:completeAnimation()
                        f48_arg0.ClipOnly:setAlpha( 0 )
                        f48_arg0.clipFinished( f48_arg0.ClipOnly )
                        f48_arg0.TotalAmmoLabel:completeAnimation()
                        f48_arg0.TotalAmmoLabel:setAlpha( 0 )
                        f48_arg0.clipFinished( f48_arg0.TotalAmmoLabel )
                        f48_arg0.TabBottomLine:completeAnimation()
                        f48_arg0.TabBottomLine:setAlpha( 0 )
                        f48_arg0.clipFinished( f48_arg0.TabBottomLine )
                        f48_arg0.TabBottomLine2:completeAnimation()
                        f48_arg0.TabBottomLine2:setAlpha( 0 )
                        f48_arg0.clipFinished( f48_arg0.TabBottomLine2 )
                  end
            },
            HiddenGamemodeWeapon = {
                  DefaultClip = function ( f49_arg0, f49_arg1 )
                        f49_arg0:__resetProperties()
                        f49_arg0:setupElementClipCounter( 7 )
                        f49_arg0.Clip:completeAnimation()
                        f49_arg0.Clip:setAlpha( 0 )
                        f49_arg0.clipFinished( f49_arg0.Clip )
                        f49_arg0.ClipDual:completeAnimation()
                        f49_arg0.ClipDual:setAlpha( 0 )
                        f49_arg0.clipFinished( f49_arg0.ClipDual )
                        f49_arg0.ClipHero:completeAnimation()
                        f49_arg0.ClipHero:setAlpha( 0 )
                        f49_arg0.clipFinished( f49_arg0.ClipHero )
                        f49_arg0.ClipOnly:completeAnimation()
                        f49_arg0.ClipOnly:setAlpha( 0 )
                        f49_arg0.clipFinished( f49_arg0.ClipOnly )
                        f49_arg0.TotalAmmoLabel:completeAnimation()
                        f49_arg0.TotalAmmoLabel:setAlpha( 0 )
                        f49_arg0.clipFinished( f49_arg0.TotalAmmoLabel )
                        f49_arg0.TabBottomLine:completeAnimation()
                        f49_arg0.TabBottomLine:setAlpha( 0 )
                        f49_arg0.clipFinished( f49_arg0.TabBottomLine )
                        f49_arg0.TabBottomLine2:completeAnimation()
                        f49_arg0.TabBottomLine2:setAlpha( 0 )
                        f49_arg0.clipFinished( f49_arg0.TabBottomLine2 )
                  end
            },
            HeroWeapon = {
                  DefaultClip = function ( f50_arg0, f50_arg1 )
                        f50_arg0:__resetProperties()
                        f50_arg0:setupElementClipCounter( 4 )
                        f50_arg0.Clip:completeAnimation()
                        f50_arg0.Clip:setAlpha( 0 )
                        f50_arg0.clipFinished( f50_arg0.Clip )
                        f50_arg0.ClipHero:completeAnimation()
                        f50_arg0.ClipHero:setLeftRight( 0, 1, 0, 0 )
                        f50_arg0.ClipHero:setTopBottom( 0, 1, 0, 0 )
                        f50_arg0.ClipHero:setRGB( 1, 1, 1 )
                        f50_arg0.ClipHero:setAlpha( 1 )
                        f50_arg0.clipFinished( f50_arg0.ClipHero )
                        f50_arg0.TotalAmmoLabel:completeAnimation()
                        f50_arg0.TotalAmmoLabel:setAlpha( 0 )
                        f50_arg0.clipFinished( f50_arg0.TotalAmmoLabel )
                        f50_arg0.TabBottomLine:completeAnimation()
                        f50_arg0.TabBottomLine:setAlpha( 0 )
                        f50_arg0.clipFinished( f50_arg0.TabBottomLine )
                  end
            },
            ClipOnly = {
                  DefaultClip = function ( f51_arg0, f51_arg1 )
                        f51_arg0:__resetProperties()
                        f51_arg0:setupElementClipCounter( 5 )
                        f51_arg0.Clip:completeAnimation()
                        f51_arg0.Clip:setLeftRight( 0, 1, 0, 0 )
                        f51_arg0.Clip:setTopBottom( 0, 0, 2.5, 77.5 )
                        f51_arg0.Clip:setAlpha( 0 )
                        f51_arg0.clipFinished( f51_arg0.Clip )
                        f51_arg0.ClipHero:completeAnimation()
                        f51_arg0.ClipHero:setLeftRight( 0, 1, 0, 0 )
                        f51_arg0.ClipHero:setTopBottom( 0, 1, 0, 0 )
                        f51_arg0.ClipHero:setRGB( 1, 1, 1 )
                        f51_arg0.ClipHero:setAlpha( 0 )
                        f51_arg0.clipFinished( f51_arg0.ClipHero )
                        f51_arg0.ClipOnly:completeAnimation()
                        f51_arg0.ClipOnly:setAlpha( 1 )
                        f51_arg0.clipFinished( f51_arg0.ClipOnly )
                        f51_arg0.TotalAmmoLabel:completeAnimation()
                        f51_arg0.TotalAmmoLabel:setAlpha( 0 )
                        f51_arg0.clipFinished( f51_arg0.TotalAmmoLabel )
                        f51_arg0.TabBottomLine:completeAnimation()
                        f51_arg0.TabBottomLine:setAlpha( 0 )
                        f51_arg0.clipFinished( f51_arg0.TabBottomLine )
                  end
            },
            WeaponDual = {
                  DefaultClip = function ( f52_arg0, f52_arg1 )
                        f52_arg0:__resetProperties()
                        f52_arg0:setupElementClipCounter( 4 )
                        f52_arg0.Clip:completeAnimation()
                        --f52_arg0.Clip:setLeftRight( 0.45, 0.95, 0, 0 )
                        --f52_arg0.Clip:setTopBottom( 0, 0, 10.5, 44.5 )
                        f52_arg0.clipFinished( f52_arg0.Clip )
                        f52_arg0.ClipDual:completeAnimation()
                        f52_arg0.ClipDual:setLeftRight( 0.00, 1.00, -70.00, 0.00 )
                        f52_arg0.ClipDual:setTopBottom( 0.00, 0.00, 1.50, 51.50 )
                        f52_arg0.ClipDual:setAlpha( 1 )
                        f52_arg0.clipFinished( f52_arg0.ClipDual )
                        f52_arg0.ClipHero:completeAnimation()
                        f52_arg0.ClipHero:setLeftRight( 1, 1, -218, -30 )
                        f52_arg0.ClipHero:setTopBottom( 1, 1, -78.5, 38.5 )
                        f52_arg0.clipFinished( f52_arg0.ClipHero )
                        --f52_arg0.TabBottomLine2:completeAnimation()
                        --f52_arg0.TabBottomLine2:setLeftRight( 0.1, 0.1, 28.5, 67.5 )
                        --f52_arg0.TabBottomLine2:setAlpha( 0.5 )
                        --f52_arg0.clipFinished( f52_arg0.TabBottomLine2 )
                  end
            },
            Weapon = {
                  DefaultClip = function ( f53_arg0, f53_arg1 )
                        f53_arg0:__resetProperties()
                        f53_arg0:setupElementClipCounter( 0 )
                  end
            },
            Weapon3Digits = {
                  DefaultClip = function ( f54_arg0, f54_arg1 )
                        f54_arg0:__resetProperties()
                        f54_arg0:setupElementClipCounter( 1 )
                        f54_arg0.ClipHero:completeAnimation()
                        f54_arg0.ClipHero:setLeftRight( 1, 2, -248, -248 )
                        f54_arg0.ClipHero:setTopBottom( 1, 2, -96, -96 )
                        f54_arg0.clipFinished( f54_arg0.ClipHero )
                  end,
                  HeroWeapon = function ( f55_arg0, f55_arg1 )
                        f55_arg0:__resetProperties()
                        f55_arg0:setupElementClipCounter( 1 )
                        f55_arg0.ClipHero:completeAnimation()
                        f55_arg0.ClipHero:setAlpha( 1 )
                        f55_arg0.clipFinished( f55_arg0.ClipHero )
                  end
            }
      }

      CoD.AmmoWidgetZM_ClipInfo.__onClose = function ( f56_arg0 )
            f56_arg0.Clip:close()
            f56_arg0.ClipDual:close()
            f56_arg0.ClipHero:close()
            f56_arg0.ClipOnly:close()
            f56_arg0.TotalAmmoLabel:close()
      end
      
      CoD.ZMPerkVaporsContainer = InheritFrom( LUI.UIElement )
      CoD.ZMPerkVaporsContainer.__defaultWidth = 500
      CoD.ZMPerkVaporsContainer.__defaultHeight = 150
      CoD.ZMPerkVaporsContainer.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            CoD.BaseUtility.InitControllerModel( f1_arg1, "PerkVaporStateUpdated", 0 )
            self:setClass( CoD.ZMPerkVaporsContainer )
            self.id = "ZMPerkVaporsContainer"
            self.soundSet = "none"
            self.anyChildUsesUpdateState = true
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            local bgbGlowOrangeOver = LUI.UIImage.new( 0.5, 0.5, -121, 121, 0.5, 0.5, -180.5, 180.5 )
            bgbGlowOrangeOver:setRGB( ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b )
            bgbGlowOrangeOver:setAlpha( 0 )
            bgbGlowOrangeOver:setZRot( 90 )
            bgbGlowOrangeOver:setImage( RegisterImage( @"uie_t7_core_hud_mapwidget_panelglow" ) )
            bgbGlowOrangeOver:setMaterial( LUI.UIImage.GetCachedMaterial( @"ui_add" ) )
            self:addElement( bgbGlowOrangeOver )
            self.bgbGlowOrangeOver = bgbGlowOrangeOver
            
            local Image = LUI.UIImage.new( 0.5, 0.5, -144, 144, 0, 0, 80, 124 )
            Image:setScale( 1.01, 1 )
            Image:setImage( RegisterImage( @"hash_6730624C02DD347E" ) )
            self:addElement( Image )
            self.Image = Image
            
            local vapors = LUI.UIList.new( f1_arg0, f1_arg1, -18, 0, nil, false, false, false, false )
            vapors:setLeftRight( 0.5, 0.5, -112.5, 113.5 )
            vapors:setTopBottom( 0, 0, 36, 134 )
            vapors:setWidgetType( CoD.ZMPerkVaporItem )
            vapors:setHorizontalCount( 4 )
            vapors:setSpacing( -30 )
            vapors:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            vapors:setDataSource( "PerkVapors" )
            self:addElement( vapors )
            self.vapors = vapors
            
            local CrossPerks = CoD.Hud_ZM_Perks_Disabled_Container.new( f1_arg0, f1_arg1, 0, 0, 83, 459, 0, 0, 14, 140 )
            self:addElement( CrossPerks )
            self.CrossPerks = CrossPerks
            
            local bgbAbilitySwirl = LUI.UIImage.new( 0.5, 0.5, -78.5, 83.5, 0, 0, 0, 160 )
            bgbAbilitySwirl:setRGB( ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b )
            bgbAbilitySwirl:setAlpha( 0 )
            bgbAbilitySwirl:setZRot( 330 )
            bgbAbilitySwirl:setScale( 1.65, 1.65 )
            bgbAbilitySwirl:setImage( RegisterImage( @"uie_t7_core_hud_ammowidget_abilityswirl" ) )
            bgbAbilitySwirl:setMaterial( LUI.UIImage.GetCachedMaterial( @"ui_add" ) )
            self:addElement( bgbAbilitySwirl )
            self.bgbAbilitySwirl = bgbAbilitySwirl
            
            self:mergeStateConditions( {
                  {
                        stateName = "TutorialHide",
                        condition = function ( menu, element, event )
                              return CoD.HUDUtility.IsAnyGameType( f1_arg1, "ztutorial" ) and CoD.ModelUtility.IsGlobalModelValueEqualTo( "hudItems.ztut.showPerks", 0 )
                        end
                  },
                  {
                        stateName = "Visible",
                        condition = function ( menu, element, event )
                              local f3_local0 = CoD.HUDUtility.IsAnyGameType( f1_arg1, "zstandard" )
                              if f3_local0 then
                                    if not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"] ) and Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"] ) then
                                          f3_local0 = not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"] )
                                    else
                                          f3_local0 = false
                                    end
                              end
                              return f3_local0
                        end
                  },
                  {
                        stateName = "Hidden",
                        condition = function ( menu, element, event )
                              local f4_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"] )
                              if not f4_local0 then
                                    f4_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"] )
                                    if not f4_local0 then
                                          f4_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"] )
                                          if not f4_local0 then
                                                f4_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"] )
                                                if not f4_local0 then
                                                      if Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"] ) then
                                                            f4_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"] )
                                                            if not f4_local0 then
                                                                  f4_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"] )
                                                                  if not f4_local0 then
                                                                        f4_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"] )
                                                                        if not f4_local0 then
                                                                              f4_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"] )
                                                                              if not f4_local0 then
                                                                                    f4_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"] )
                                                                                    if not f4_local0 then
                                                                                          f4_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"] )
                                                                                          if not f4_local0 then
                                                                                                f4_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"] )
                                                                                          end
                                                                                    end
                                                                              end
                                                                        end
                                                                  end
                                                            end
                                                      else
                                                            f4_local0 = true
                                                      end
                                                end
                                          end
                                    end
                              end
                              return f4_local0
                        end
                  }
            } )
            local f1_local6 = self
            local f1_local7 = self.subscribeToModel
            local f1_local8 = Engine[@"getglobalmodel"]()
            f1_local7( f1_local6, f1_local8["hudItems.ztut.showPerks"], function ( f5_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f5_arg0:get(),
                        modelName = "hudItems.ztut.showPerks"
                  } )
            end, false )
            f1_local6 = self
            f1_local7 = self.subscribeToModel
            f1_local8 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local7( f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function ( f6_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f6_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]
                  } )
            end, false )
            f1_local6 = self
            f1_local7 = self.subscribeToModel
            f1_local8 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local7( f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function ( f7_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f7_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]
                  } )
            end, false )
            f1_local6 = self
            f1_local7 = self.subscribeToModel
            f1_local8 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local7( f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function ( f8_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f8_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]
                  } )
            end, false )
            f1_local6 = self
            f1_local7 = self.subscribeToModel
            f1_local8 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local7( f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function ( f9_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f9_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]
                  } )
            end, false )
            f1_local6 = self
            f1_local7 = self.subscribeToModel
            f1_local8 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local7( f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function ( f10_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f10_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]
                  } )
            end, false )
            f1_local6 = self
            f1_local7 = self.subscribeToModel
            f1_local8 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local7( f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function ( f11_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f11_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]
                  } )
            end, false )
            f1_local6 = self
            f1_local7 = self.subscribeToModel
            f1_local8 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local7( f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function ( f12_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f12_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]
                  } )
            end, false )
            f1_local6 = self
            f1_local7 = self.subscribeToModel
            f1_local8 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local7( f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function ( f13_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f13_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]
                  } )
            end, false )
            f1_local6 = self
            f1_local7 = self.subscribeToModel
            f1_local8 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local7( f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function ( f14_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f14_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]
                  } )
            end, false )
            f1_local6 = self
            f1_local7 = self.subscribeToModel
            f1_local8 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local7( f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function ( f15_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f15_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]
                  } )
            end, false )
            f1_local6 = self
            f1_local7 = self.subscribeToModel
            f1_local8 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local7( f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function ( f16_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f16_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]
                  } )
            end, false )
            f1_local6 = self
            f1_local7 = self.subscribeToModel
            f1_local8 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local7( f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function ( f17_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f17_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]
                  } )
            end, false )
            vapors.id = "vapors"
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            return self
      end

      CoD.ZMPerkVaporsContainer.__resetProperties = function ( f18_arg0 )
            f18_arg0.vapors:completeAnimation()
            f18_arg0.Image:completeAnimation()
            f18_arg0.CrossPerks:completeAnimation()
            f18_arg0.bgbAbilitySwirl:completeAnimation()
            f18_arg0.bgbGlowOrangeOver:completeAnimation()
            f18_arg0.vapors:setAlpha( 1 )
            f18_arg0.Image:setAlpha( 1 )
            f18_arg0.CrossPerks:setAlpha( 1 )
            f18_arg0.bgbAbilitySwirl:setAlpha( 0 )
            f18_arg0.bgbAbilitySwirl:setZRot( 330 )
            f18_arg0.bgbGlowOrangeOver:setAlpha( 0 )
      end

      CoD.ZMPerkVaporsContainer.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f19_arg0, f19_arg1 )
                        f19_arg0:__resetProperties()
                        f19_arg0:setupElementClipCounter( 0 )
                  end,
                  Hidden = function ( f20_arg0, f20_arg1 )
                        f20_arg0:__resetProperties()
                        f20_arg0:setupElementClipCounter( 3 )
                        local f20_local0 = function ( f21_arg0 )
                              f20_arg0.Image:beginAnimation( 150 )
                              f20_arg0.Image:setAlpha( 0 )
                              f20_arg0.Image:registerEventHandler( "interrupted_keyframe", f20_arg0.clipInterrupted )
                              f20_arg0.Image:registerEventHandler( "transition_complete_keyframe", f20_arg0.clipFinished )
                        end
                        
                        f20_arg0.Image:completeAnimation()
                        f20_arg0.Image:setAlpha( 1 )
                        f20_local0( f20_arg0.Image )
                        local f20_local1 = function ( f22_arg0 )
                              f20_arg0.vapors:beginAnimation( 150 )
                              f20_arg0.vapors:setAlpha( 0 )
                              f20_arg0.vapors:registerEventHandler( "interrupted_keyframe", f20_arg0.clipInterrupted )
                              f20_arg0.vapors:registerEventHandler( "transition_complete_keyframe", f20_arg0.clipFinished )
                        end
                        
                        f20_arg0.vapors:completeAnimation()
                        f20_arg0.vapors:setAlpha( 1 )
                        f20_local1( f20_arg0.vapors )
                        local f20_local2 = function ( f23_arg0 )
                              f20_arg0.CrossPerks:beginAnimation( 150 )
                              f20_arg0.CrossPerks:setAlpha( 0 )
                              f20_arg0.CrossPerks:registerEventHandler( "interrupted_keyframe", f20_arg0.clipInterrupted )
                              f20_arg0.CrossPerks:registerEventHandler( "transition_complete_keyframe", f20_arg0.clipFinished )
                        end
                        
                        f20_arg0.CrossPerks:completeAnimation()
                        f20_arg0.CrossPerks:setAlpha( 1 )
                        f20_local2( f20_arg0.CrossPerks )
                  end
            },
            TutorialHide = {
                  DefaultClip = function ( f24_arg0, f24_arg1 )
                        f24_arg0:__resetProperties()
                        f24_arg0:setupElementClipCounter( 3 )
                        f24_arg0.Image:completeAnimation()
                        f24_arg0.Image:setAlpha( 0 )
                        f24_arg0.clipFinished( f24_arg0.Image )
                        f24_arg0.vapors:completeAnimation()
                        f24_arg0.vapors:setAlpha( 0 )
                        f24_arg0.clipFinished( f24_arg0.vapors )
                        f24_arg0.CrossPerks:completeAnimation()
                        f24_arg0.CrossPerks:setAlpha( 0 )
                        f24_arg0.clipFinished( f24_arg0.CrossPerks )
                  end,
                  DefaultState = function ( f25_arg0, f25_arg1 )
                        f25_arg0:__resetProperties()
                        f25_arg0:setupElementClipCounter( 4 )
                        local f25_local0 = function ( f26_arg0 )
                              local f26_local0 = function ( f27_arg0 )
                                    local f27_local0 = function ( f28_arg0 )
                                          local f28_local0 = function ( f29_arg0 )
                                                local f29_local0 = function ( f30_arg0 )
                                                      local f30_local0 = function ( f31_arg0 )
                                                            local f31_local0 = function ( f32_arg0 )
                                                                  f32_arg0:beginAnimation( 230 )
                                                                  f32_arg0:setAlpha( 0 )
                                                                  f32_arg0:registerEventHandler( "transition_complete_keyframe", f25_arg0.clipFinished )
                                                            end
                                                            
                                                            f31_arg0:beginAnimation( 110 )
                                                            f31_arg0:setAlpha( 0.7 )
                                                            f31_arg0:registerEventHandler( "transition_complete_keyframe", f31_local0 )
                                                      end
                                                      
                                                      f30_arg0:beginAnimation( 160 )
                                                      f30_arg0:setAlpha( 0 )
                                                      f30_arg0:registerEventHandler( "transition_complete_keyframe", f30_local0 )
                                                end
                                                
                                                f29_arg0:beginAnimation( 169 )
                                                f29_arg0:setAlpha( 0.7 )
                                                f29_arg0:registerEventHandler( "transition_complete_keyframe", f29_local0 )
                                          end
                                          
                                          f28_arg0:beginAnimation( 170 )
                                          f28_arg0:setAlpha( 0 )
                                          f28_arg0:registerEventHandler( "transition_complete_keyframe", f28_local0 )
                                    end
                                    
                                    f27_arg0:beginAnimation( 160 )
                                    f27_arg0:setAlpha( 0.7 )
                                    f27_arg0:registerEventHandler( "transition_complete_keyframe", f27_local0 )
                              end
                              
                              f25_arg0.bgbGlowOrangeOver:beginAnimation( 330 )
                              f25_arg0.bgbGlowOrangeOver:registerEventHandler( "interrupted_keyframe", f25_arg0.clipInterrupted )
                              f25_arg0.bgbGlowOrangeOver:registerEventHandler( "transition_complete_keyframe", f26_local0 )
                        end
                        
                        f25_arg0.bgbGlowOrangeOver:completeAnimation()
                        f25_arg0.bgbGlowOrangeOver:setAlpha( 0 )
                        f25_local0( f25_arg0.bgbGlowOrangeOver )
                        local f25_local1 = function ( f33_arg0 )
                              f33_arg0:beginAnimation( 330 )
                              f33_arg0:setAlpha( 1 )
                              f33_arg0:registerEventHandler( "transition_complete_keyframe", f25_arg0.clipFinished )
                        end
                        
                        f25_arg0.Image:beginAnimation( 330 )
                        f25_arg0.Image:setAlpha( 0 )
                        f25_arg0.Image:registerEventHandler( "interrupted_keyframe", f25_arg0.clipInterrupted )
                        f25_arg0.Image:registerEventHandler( "transition_complete_keyframe", f25_local1 )
                        local f25_local2 = function ( f34_arg0 )
                              local f34_local0 = function ( f35_arg0 )
                                    local f35_local0 = function ( f36_arg0 )
                                          f36_arg0:beginAnimation( 340, Enum[@"luitween"][@"luitween_bounce"] )
                                          f36_arg0:setAlpha( 1 )
                                          f36_arg0:registerEventHandler( "transition_complete_keyframe", f25_arg0.clipFinished )
                                    end
                                    
                                    f35_arg0:beginAnimation( 329 )
                                    f35_arg0:setAlpha( 0 )
                                    f35_arg0:registerEventHandler( "transition_complete_keyframe", f35_local0 )
                              end
                              
                              f34_arg0:beginAnimation( 330 )
                              f34_arg0:setAlpha( 1 )
                              f34_arg0:registerEventHandler( "transition_complete_keyframe", f34_local0 )
                        end
                        
                        f25_arg0.vapors:beginAnimation( 330 )
                        f25_arg0.vapors:setAlpha( 0 )
                        f25_arg0.vapors:registerEventHandler( "interrupted_keyframe", f25_arg0.clipInterrupted )
                        f25_arg0.vapors:registerEventHandler( "transition_complete_keyframe", f25_local2 )
                        local f25_local3 = function ( f37_arg0 )
                              local f37_local0 = function ( f38_arg0 )
                                    f38_arg0:beginAnimation( 199 )
                                    f38_arg0:setAlpha( 0 )
                                    f38_arg0:setZRot( 360 )
                                    f38_arg0:registerEventHandler( "transition_complete_keyframe", f25_arg0.clipFinished )
                              end
                              
                              f25_arg0.bgbAbilitySwirl:beginAnimation( 330 )
                              f25_arg0.bgbAbilitySwirl:setAlpha( 1 )
                              f25_arg0.bgbAbilitySwirl:setZRot( 240 )
                              f25_arg0.bgbAbilitySwirl:registerEventHandler( "interrupted_keyframe", f25_arg0.clipInterrupted )
                              f25_arg0.bgbAbilitySwirl:registerEventHandler( "transition_complete_keyframe", f37_local0 )
                        end
                        
                        f25_arg0.bgbAbilitySwirl:completeAnimation()
                        f25_arg0.bgbAbilitySwirl:setAlpha( 0 )
                        f25_arg0.bgbAbilitySwirl:setZRot( 0 )
                        f25_local3( f25_arg0.bgbAbilitySwirl )
                  end
            },
            Visible = {
                  DefaultClip = function ( f39_arg0, f39_arg1 )
                        f39_arg0:__resetProperties()
                        f39_arg0:setupElementClipCounter( 0 )
                  end,
                  Hidden = function ( f40_arg0, f40_arg1 )
                        f40_arg0:__resetProperties()
                        f40_arg0:setupElementClipCounter( 3 )
                        local f40_local0 = function ( f41_arg0 )
                              f40_arg0.Image:beginAnimation( 150 )
                              f40_arg0.Image:setAlpha( 0 )
                              f40_arg0.Image:registerEventHandler( "interrupted_keyframe", f40_arg0.clipInterrupted )
                              f40_arg0.Image:registerEventHandler( "transition_complete_keyframe", f40_arg0.clipFinished )
                        end
                        
                        f40_arg0.Image:completeAnimation()
                        f40_arg0.Image:setAlpha( 1 )
                        f40_local0( f40_arg0.Image )
                        local f40_local1 = function ( f42_arg0 )
                              f40_arg0.vapors:beginAnimation( 150 )
                              f40_arg0.vapors:setAlpha( 0 )
                              f40_arg0.vapors:registerEventHandler( "interrupted_keyframe", f40_arg0.clipInterrupted )
                              f40_arg0.vapors:registerEventHandler( "transition_complete_keyframe", f40_arg0.clipFinished )
                        end
                        
                        f40_arg0.vapors:completeAnimation()
                        f40_arg0.vapors:setAlpha( 1 )
                        f40_local1( f40_arg0.vapors )
                        local f40_local2 = function ( f43_arg0 )
                              f40_arg0.CrossPerks:beginAnimation( 150 )
                              f40_arg0.CrossPerks:setAlpha( 0 )
                              f40_arg0.CrossPerks:registerEventHandler( "interrupted_keyframe", f40_arg0.clipInterrupted )
                              f40_arg0.CrossPerks:registerEventHandler( "transition_complete_keyframe", f40_arg0.clipFinished )
                        end
                        
                        f40_arg0.CrossPerks:completeAnimation()
                        f40_arg0.CrossPerks:setAlpha( 1 )
                        f40_local2( f40_arg0.CrossPerks )
                  end
            },
            Hidden = {
                  DefaultClip = function ( f44_arg0, f44_arg1 )
                        f44_arg0:__resetProperties()
                        f44_arg0:setupElementClipCounter( 3 )
                        f44_arg0.Image:completeAnimation()
                        f44_arg0.Image:setAlpha( 0 )
                        f44_arg0.clipFinished( f44_arg0.Image )
                        f44_arg0.vapors:completeAnimation()
                        f44_arg0.vapors:setAlpha( 0 )
                        f44_arg0.clipFinished( f44_arg0.vapors )
                        f44_arg0.CrossPerks:completeAnimation()
                        f44_arg0.CrossPerks:setAlpha( 0 )
                        f44_arg0.clipFinished( f44_arg0.CrossPerks )
                  end,
                  Visible = function ( f45_arg0, f45_arg1 )
                        f45_arg0:__resetProperties()
                        f45_arg0:setupElementClipCounter( 3 )
                        local f45_local0 = function ( f46_arg0 )
                              f45_arg0.Image:beginAnimation( 150 )
                              f45_arg0.Image:setAlpha( 1 )
                              f45_arg0.Image:registerEventHandler( "interrupted_keyframe", f45_arg0.clipInterrupted )
                              f45_arg0.Image:registerEventHandler( "transition_complete_keyframe", f45_arg0.clipFinished )
                        end
                        
                        f45_arg0.Image:completeAnimation()
                        f45_arg0.Image:setAlpha( 0 )
                        f45_local0( f45_arg0.Image )
                        local f45_local1 = function ( f47_arg0 )
                              f45_arg0.vapors:beginAnimation( 150 )
                              f45_arg0.vapors:setAlpha( 1 )
                              f45_arg0.vapors:registerEventHandler( "interrupted_keyframe", f45_arg0.clipInterrupted )
                              f45_arg0.vapors:registerEventHandler( "transition_complete_keyframe", f45_arg0.clipFinished )
                        end
                        
                        f45_arg0.vapors:completeAnimation()
                        f45_arg0.vapors:setAlpha( 0 )
                        f45_local1( f45_arg0.vapors )
                        local f45_local2 = function ( f48_arg0 )
                              f45_arg0.CrossPerks:beginAnimation( 150 )
                              f45_arg0.CrossPerks:setAlpha( 1 )
                              f45_arg0.CrossPerks:registerEventHandler( "interrupted_keyframe", f45_arg0.clipInterrupted )
                              f45_arg0.CrossPerks:registerEventHandler( "transition_complete_keyframe", f45_arg0.clipFinished )
                        end
                        
                        f45_arg0.CrossPerks:completeAnimation()
                        f45_arg0.CrossPerks:setAlpha( 0 )
                        f45_local2( f45_arg0.CrossPerks )
                  end,
                  DefaultState = function ( f49_arg0, f49_arg1 )
                        f49_arg0:__resetProperties()
                        f49_arg0:setupElementClipCounter( 3 )
                        local f49_local0 = function ( f50_arg0 )
                              f49_arg0.Image:beginAnimation( 150 )
                              f49_arg0.Image:setAlpha( 1 )
                              f49_arg0.Image:registerEventHandler( "interrupted_keyframe", f49_arg0.clipInterrupted )
                              f49_arg0.Image:registerEventHandler( "transition_complete_keyframe", f49_arg0.clipFinished )
                        end
                        
                        f49_arg0.Image:completeAnimation()
                        f49_arg0.Image:setAlpha( 0 )
                        f49_local0( f49_arg0.Image )
                        local f49_local1 = function ( f51_arg0 )
                              f49_arg0.vapors:beginAnimation( 150 )
                              f49_arg0.vapors:setAlpha( 1 )
                              f49_arg0.vapors:registerEventHandler( "interrupted_keyframe", f49_arg0.clipInterrupted )
                              f49_arg0.vapors:registerEventHandler( "transition_complete_keyframe", f49_arg0.clipFinished )
                        end
                        
                        f49_arg0.vapors:completeAnimation()
                        f49_arg0.vapors:setAlpha( 0 )
                        f49_local1( f49_arg0.vapors )
                        local f49_local2 = function ( f52_arg0 )
                              f49_arg0.CrossPerks:beginAnimation( 150 )
                              f49_arg0.CrossPerks:setAlpha( 1 )
                              f49_arg0.CrossPerks:registerEventHandler( "interrupted_keyframe", f49_arg0.clipInterrupted )
                              f49_arg0.CrossPerks:registerEventHandler( "transition_complete_keyframe", f49_arg0.clipFinished )
                        end
                        
                        f49_arg0.CrossPerks:completeAnimation()
                        f49_arg0.CrossPerks:setAlpha( 0 )
                        f49_local2( f49_arg0.CrossPerks )
                  end
            }
      }

      CoD.ZMPerkVaporsContainer.__onClose = function ( f53_arg0 )
            f53_arg0.vapors:close()
            f53_arg0.CrossPerks:close()
      end

      CoD.AmmoWidgetZM_WeaponName = InheritFrom( LUI.UIElement )
      CoD.AmmoWidgetZM_WeaponName.__defaultWidth = 142
      CoD.AmmoWidgetZM_WeaponName.__defaultHeight = 33
      CoD.AmmoWidgetZM_WeaponName.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.AmmoWidgetZM_WeaponName )
            self.id = "AmmoWidgetZM_WeaponName"
            self.soundSet = "default"
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            local HeroAbilityUseString = LUI.UIText.new( 0.08, 1.08, -11, -11, 0, 0, 9.5, 23.5 )
            HeroAbilityUseString:setRGB( 0.92, 0.92, 0.92 )
            HeroAbilityUseString:setText( "" )
            HeroAbilityUseString:setTTF( "notosans_bold" )
            HeroAbilityUseString:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_171E049B161CD00A" ) )
            HeroAbilityUseString:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            HeroAbilityUseString:setAlignment( Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"] )
            self:addElement( HeroAbilityUseString )
            self.HeroAbilityUseString = HeroAbilityUseString

            HeroAbilityUseString:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function(model)
                if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"enhancement_weapon_name_color") then
                    local scriptData = CoD.GetScriptNotifyData(model)

                    if scriptData[1] == 0 then
                        HeroAbilityUseString:setRGB(0.92, 0.92, 0.92)
                        return
                    elseif scriptData[1] == 1 then
                        HeroAbilityUseString:setRGB(0.92, 0, 0)
                        return
                    end
                end
            end)
            
            self:subscribeToGlobalModel( f1_arg1, "PerController", "heldWeapons.0.updateWeaponSelect", function ( model )
                  local f2_local0 = self
                  PulseElementToStateAndBack( self, "Respawn", f1_arg1 )
            end )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            return self
      end

      CoD.AmmoWidgetZM_WeaponName.__resetProperties = function ( f3_arg0 )
            f3_arg0.HeroAbilityUseString:completeAnimation()
            f3_arg0.HeroAbilityUseString:setAlpha( 1 )
      end

      CoD.AmmoWidgetZM_WeaponName.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f4_arg0, f4_arg1 )
                        f4_arg0:__resetProperties()
                        f4_arg0:setupElementClipCounter( 1 )
                        local f4_local0 = function ( f5_arg0 )
                              f4_arg0.HeroAbilityUseString:beginAnimation( 1990 )
                              f4_arg0.HeroAbilityUseString:registerEventHandler( "interrupted_keyframe", f4_arg0.clipInterrupted )
                              f4_arg0.HeroAbilityUseString:registerEventHandler( "transition_complete_keyframe", f4_arg0.clipFinished )
                        end
                        
                        f4_arg0.HeroAbilityUseString:completeAnimation()
                        f4_arg0.HeroAbilityUseString:setAlpha( 1 )
                        f4_local0( f4_arg0.HeroAbilityUseString )
                  end,
                  Hidden = function ( f6_arg0, f6_arg1 )
                        f6_arg0:__resetProperties()
                        f6_arg0:setupElementClipCounter( 1 )
                        local f6_local0 = function ( f7_arg0 )
                              f6_arg0.HeroAbilityUseString:beginAnimation( 200 )
                              f6_arg0.HeroAbilityUseString:setAlpha( 0 )
                              f6_arg0.HeroAbilityUseString:registerEventHandler( "interrupted_keyframe", f6_arg0.clipInterrupted )
                              f6_arg0.HeroAbilityUseString:registerEventHandler( "transition_complete_keyframe", f6_arg0.clipFinished )
                        end
                        
                        f6_arg0.HeroAbilityUseString:completeAnimation()
                        f6_arg0.HeroAbilityUseString:setAlpha( 1 )
                        f6_local0( f6_arg0.HeroAbilityUseString )
                  end
            },
            Respawn = {
                  DefaultClip = function ( f8_arg0, f8_arg1 )
                        f8_arg0:__resetProperties()
                        f8_arg0:setupElementClipCounter( 1 )
                        f8_arg0.HeroAbilityUseString:completeAnimation()
                        f8_arg0.HeroAbilityUseString:setAlpha( 1 )
                        f8_arg0.clipFinished( f8_arg0.HeroAbilityUseString )
                  end,
                  DefaultState = function ( f9_arg0, f9_arg1 )
                        f9_arg0:__resetProperties()
                        f9_arg0:setupElementClipCounter( 1 )
                        local f9_local0 = function ( f10_arg0 )
                              local f10_local0 = function ( f11_arg0 )
                                    local f11_local0 = function ( f12_arg0 )
                                          f12_arg0:beginAnimation( 360 )
                                          f12_arg0:setAlpha( 0.2 )
                                          f12_arg0:registerEventHandler( "transition_complete_keyframe", f9_arg0.clipFinished )
                                    end
                                    
                                    f11_arg0:beginAnimation( 1530 )
                                    f11_arg0:registerEventHandler( "transition_complete_keyframe", f11_local0 )
                              end
                              
                              f9_arg0.HeroAbilityUseString:beginAnimation( 100 )
                              f9_arg0.HeroAbilityUseString:setAlpha( 1 )
                              f9_arg0.HeroAbilityUseString:registerEventHandler( "interrupted_keyframe", f9_arg0.clipInterrupted )
                              f9_arg0.HeroAbilityUseString:registerEventHandler( "transition_complete_keyframe", f10_local0 )
                        end
                        
                        f9_arg0.HeroAbilityUseString:completeAnimation()
                        f9_arg0.HeroAbilityUseString:setAlpha( 0 )
                        f9_local0( f9_arg0.HeroAbilityUseString )
                  end
            },
            Hidden = {
                  DefaultClip = function ( f13_arg0, f13_arg1 )
                        f13_arg0:__resetProperties()
                        f13_arg0:setupElementClipCounter( 1 )
                        f13_arg0.HeroAbilityUseString:completeAnimation()
                        f13_arg0.HeroAbilityUseString:setAlpha( 0 )
                        f13_arg0.clipFinished( f13_arg0.HeroAbilityUseString )
                  end,
                  DefaultState = function ( f14_arg0, f14_arg1 )
                        f14_arg0:__resetProperties()
                        f14_arg0:setupElementClipCounter( 1 )
                        local f14_local0 = function ( f15_arg0 )
                              f14_arg0.HeroAbilityUseString:beginAnimation( 200 )
                              f14_arg0.HeroAbilityUseString:setAlpha( 1 )
                              f14_arg0.HeroAbilityUseString:registerEventHandler( "interrupted_keyframe", f14_arg0.clipInterrupted )
                              f14_arg0.HeroAbilityUseString:registerEventHandler( "transition_complete_keyframe", f14_arg0.clipFinished )
                        end
                        
                        f14_arg0.HeroAbilityUseString:completeAnimation()
                        f14_arg0.HeroAbilityUseString:setAlpha( 0 )
                        f14_local0( f14_arg0.HeroAbilityUseString )
                  end
            }
      }

      CoD.PlayerWidget_ZM = InheritFrom( LUI.UIElement )
      CoD.PlayerWidget_ZM.__defaultWidth = 278
      CoD.PlayerWidget_ZM.__defaultHeight = 112
      CoD.PlayerWidget_ZM.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.PlayerWidget_ZM )
            self.id = "PlayerWidget_ZM"
            self.soundSet = "default"
            self.anyChildUsesUpdateState = true
            f1_arg0:addElementToPendingUpdateStateList( self )

            -- add glow for score
            local GlowScore = CoD.ScoreGlowBG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
            self:addElement(GlowScore)
            self.GlowScore = GlowScore
            
            local BackingBlur = LUI.UIImage.new( 0.5, 0.5, -176, 176, 0.5, 0.5, -64, 64 )
            BackingBlur:setAlpha( 0.9 )
            BackingBlur:setYRot( 180 )
            BackingBlur:setScale( 0.9, 0.9 )
            BackingBlur:setImage( RegisterImage( @"hash_6907FA1028168086" ) )
            BackingBlur:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_E2354BE557C4C7A" ) )
            BackingBlur:setShaderVector( 0, 0, 0, 0, 0 )
            self:addElement( BackingBlur )
            self.BackingBlur = BackingBlur
            
            local Backing = LUI.UIImage.new( 0.5, 0.5, -176, 176, 0.5, 0.5, -64, 64 )
            Backing:setYRot( 180 )
            Backing:setScale( 0.9, 0.9 )
            Backing:setImage( RegisterImage( @"hash_62656BC725F9EEB" ) )
            self:addElement( Backing )
            self.Backing = Backing
            
            local headshotBarBacking = CoD.AmmoWidgetZM_Specialist.new( f1_arg0, f1_arg1, 0.5, 0.5, -171, -36, 0.5, 0.5, -67, 68 )
            headshotBarBacking:subscribeToGlobalModel( f1_arg1, "PlayerListZM", "0", function ( model )
                  headshotBarBacking:setModel( model, f1_arg1 )
            end )
            self:addElement( headshotBarBacking )
            self.headshotBarBacking = headshotBarBacking
            
            local HealthValue = CoD.HealthInfoZM.new( f1_arg0, f1_arg1, 0, 0, -4, 234, 0, 0, 42.5, 208.5 )
            HealthValue:subscribeToGlobalModel( f1_arg1, "PerController", "predictedClientModel", function ( model )
                  local f3_local0 = model:get()
                  if f3_local0 ~= nil then
                        HealthValue:setModel( f3_local0, f1_arg1 )
                  end
            end )
            self:addElement( HealthValue )
            self.HealthValue = HealthValue
            
            local ScoreShadow = LUI.UIText.new( 0.00, 0.00, 0.50, 250.50, 0.00, 0.00, 25.50, 65.50 )
            ScoreShadow:setRGB( 0.1, 0.1, 0.1 )
            ScoreShadow:setTTF( "skorzhen" )
            ScoreShadow:setLetterSpacing( 2 )
            ScoreShadow:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            ScoreShadow:subscribeToGlobalModel( f1_arg1, "PlayerListZM", "0.playerScore", function ( model )
                  local f4_local0 = model:get()
                  if f4_local0 ~= nil then
                        ScoreShadow:setText( CoD.ZombieUtility.ReturnScoreifNotArcade( f4_local0 ) )
                  end
            end )
            self:addElement( ScoreShadow )
            self.ScoreShadow = ScoreShadow
            
            local Score = LUI.UIText.new( 0.00, 0.00, 0.00, 250.00, 0.00, 0.00, 25.00, 65.00 )
            Score:setTTF( "skorzhen" )
            Score:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_90D57B1E92D39D7" ) )
            Score:setShaderVector( 0, 0.11, 0, 0, 0 )
            Score:setShaderVector( 1, 0.13, 0, 0, 0 )
            Score:setShaderVector( 2, 0, 0, 0, 1 )
            Score:setLetterSpacing( 2 )
            Score:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            Score:subscribeToGlobalModel( f1_arg1, "PlayerListZM", "0.clientNum", function ( model )
                  local f5_local0 = model:get()
                  if f5_local0 ~= nil then
                        Score:setRGB( ZombieClientScoreboardColor( f5_local0 ) )
                  end
            end )
            Score:subscribeToGlobalModel( f1_arg1, "PlayerListZM", "0.playerScore", function ( model )
                  local f6_local0 = model:get()
                  if f6_local0 ~= nil then
                        Score:setText( CoD.ZombieUtility.ReturnScoreifNotArcade( f6_local0 ) )
                  end
            end )
            self:addElement( Score )
            self.Score = Score

            local SelfReviveCounter = CoD.ZM_SelfReviveCounter.new( f1_arg0, f1_arg1, 0, 0, -51, 34, 0, 0, 69.5, 114.5 )
            SelfReviveCounter:setScale( 0.75, 0.75 )
            self:addElement( SelfReviveCounter )
            self.SelfReviveCounter = SelfReviveCounter
            
            local Checkbox = CoD.PlayerWidget_ZM_Trials.new( f1_arg0, f1_arg1, 0, 0, -38.5, 90.5, 0, 0, 68, 124 )
            self:addElement( Checkbox )
            self.Checkbox = Checkbox
            
            local GlobalTracker = CoD.Hud_ZM_Trial_Global_Tracker.new( f1_arg0, f1_arg1, 0, 0, -38.5, 90.5, 0, 0, 68, 124 )
            GlobalTracker:subscribeToGlobalModel( f1_arg1, "ZMHudGlobal", "trials", function ( model )
                  GlobalTracker:setModel( model, f1_arg1 )
            end )
            self:addElement( GlobalTracker )
            self.GlobalTracker = GlobalTracker
            
            local ZMExtraPerkVapors = LUI.UIList.new( f1_arg0, f1_arg1, -25, 0, nil, false, false, false, false )
            ZMExtraPerkVapors:mergeStateConditions( {
                  {
                        stateName = "Hidden",
                        condition = function ( menu, element, event )
                              return CoD.ModelUtility.IsSelfModelValueEqualToEnumEitherValue( element, f1_arg1, "state", CoD.ZMPerkUtility.PerkVaporStates.DEFAULT, CoD.ZMPerkUtility.PerkVaporStates.HIDDEN )
                        end
                  },
                  {
                        stateName = "Available",
                        condition = function ( menu, element, event )
                              return AlwaysFalse()
                        end
                  }
            } )
            ZMExtraPerkVapors:linkToElementModel( ZMExtraPerkVapors, "state", true, function ( model )
                  f1_arg0:updateElementState( ZMExtraPerkVapors, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "state"
                  } )
            end )
            ZMExtraPerkVapors:setLeftRight( 0.5, 0.5, 201, 631 )
            ZMExtraPerkVapors:setTopBottom( 0.5, 0.5, -28.5, 69.5 )
            ZMExtraPerkVapors:setScale( 1.25, 1.25 )
            ZMExtraPerkVapors:setWidgetType( CoD.ZMPerkVaporItem )
            ZMExtraPerkVapors:setHorizontalCount( 9 )
            ZMExtraPerkVapors:setSpacing( -25 )
            ZMExtraPerkVapors:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            ZMExtraPerkVapors:setDataSource( "ExtraPerkVapors" )
            self:addElement( ZMExtraPerkVapors )
            self.ZMExtraPerkVapors = ZMExtraPerkVapors
            
            local DemoPip = CoD.DemoPip.new( f1_arg0, f1_arg1, 0, 0, 8, 13, 0, 0, 114.5, 119.5 )
            self:addElement( DemoPip )
            self.DemoPip = DemoPip
            
            self:mergeStateConditions( {
                  {
                        stateName = "HiddenCopy",
                        condition = function ( menu, element, event )
                              return CoD.HUDUtility.IsAnyGameType( f1_arg1, "zstandard" )
                        end
                  },
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
            self:subscribeToGlobalModel( f1_arg1, "PerController", "zmhud.damage_point_shake", function ( model )
                  local f25_local0 = self
                  PlayClip( self, "DefaultClip", f1_arg1 )
            end )
            ZMExtraPerkVapors.id = "ZMExtraPerkVapors"
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            return self
      end

      CoD.PlayerWidget_ZM.__resetProperties = function ( f26_arg0 )
            f26_arg0.SelfReviveCounter:completeAnimation()
            f26_arg0.Score:completeAnimation()
            f26_arg0.HealthValue:completeAnimation()
            f26_arg0.headshotBarBacking:completeAnimation()
            f26_arg0.Backing:completeAnimation()
            f26_arg0.Checkbox:completeAnimation()
            f26_arg0.BackingBlur:completeAnimation()
            f26_arg0.ScoreShadow:completeAnimation()
            f26_arg0.GlobalTracker:completeAnimation()
            f26_arg0.ZMExtraPerkVapors:completeAnimation()
            f26_arg0.DemoPip:completeAnimation()
            f26_arg0.SelfReviveCounter:setLeftRight( 0, 0, -51, 34 )
            f26_arg0.SelfReviveCounter:setTopBottom( 0, 0, 69.5, 114.5 )
            f26_arg0.SelfReviveCounter:setAlpha( 1 )
            f26_arg0.Score:setLeftRight( 0.00, 0.00, 0.00, 250.00 )
            f26_arg0.Score:setTopBottom( 0.00, 0.00, 25.00, 65.00 )
            f26_arg0.Score:setAlpha( 1 )
            f26_arg0.HealthValue:setLeftRight( 0, 0, -4, 234 )
            f26_arg0.HealthValue:setTopBottom( 0, 0, 42.5, 208.5 )
            f26_arg0.HealthValue:setAlpha( 1 )
            --f26_arg0.headshotBarBacking:setLeftRight( 0.5, 0.5, -171, -36 )
            --f26_arg0.headshotBarBacking:setTopBottom( 0.5, 0.5, -67, 68 )
            f26_arg0.headshotBarBacking:setAlpha( 1 )
            f26_arg0.Backing:setLeftRight( 0.5, 0.5, -176, 176 )
            f26_arg0.Backing:setTopBottom( 0.5, 0.5, -64, 64 )
            f26_arg0.Backing:setAlpha( 1 )
            f26_arg0.Checkbox:setAlpha( 1 )
            f26_arg0.BackingBlur:setAlpha( 0.9 )
            f26_arg0.ScoreShadow:setAlpha( 1 )
            f26_arg0.GlobalTracker:setAlpha( 1 )
            f26_arg0.ZMExtraPerkVapors:setAlpha( 1 )
            f26_arg0.DemoPip:setAlpha( 1 )
      end

      CoD.PlayerWidget_ZM.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f27_arg0, f27_arg1 )
                        f27_arg0:__resetProperties()
                        f27_arg0:setupElementClipCounter( 0 )
                  end,
                  Shake = function ( f28_arg0, f28_arg1 )
                        f28_arg0:__resetProperties()
                        f28_arg0:setupElementClipCounter( 5 )
                        local f28_local0 = function ( f29_arg0 )
                              local f29_local0 = function ( f30_arg0 )
                                    local f30_local0 = function ( f31_arg0 )
                                          f31_arg0:beginAnimation( 89 )
                                          f31_arg0:setLeftRight( 0.5, 0.5, -176, 176 )
                                          f31_arg0:setTopBottom( 0.5, 0.5, -64, 64 )
                                          f31_arg0:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
                                    end
                                    
                                    f30_arg0:beginAnimation( 90 )
                                    f30_arg0:setLeftRight( 0.5, 0.5, -171, 181 )
                                    f30_arg0:setTopBottom( 0.5, 0.5, -62, 66 )
                                    f30_arg0:registerEventHandler( "transition_complete_keyframe", f30_local0 )
                              end
                              
                              f28_arg0.Backing:beginAnimation( 80 )
                              f28_arg0.Backing:setLeftRight( 0.5, 0.5, -166, 186 )
                              f28_arg0.Backing:setTopBottom( 0.5, 0.5, -69, 59 )
                              f28_arg0.Backing:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
                              f28_arg0.Backing:registerEventHandler( "transition_complete_keyframe", f29_local0 )
                        end
                        
                        f28_arg0.Backing:completeAnimation()
                        f28_arg0.Backing:setLeftRight( 0.5, 0.5, -176, 176 )
                        f28_arg0.Backing:setTopBottom( 0.5, 0.5, -64, 64 )
                        f28_local0( f28_arg0.Backing )
                        local f28_local1 = function ( f32_arg0 )
                              local f32_local0 = function ( f33_arg0 )
                                    local f33_local0 = function ( f34_arg0 )
                                          f34_arg0:beginAnimation( 89 )
                                          f34_arg0:setLeftRight( 0, 0, -28, 75 )
                                          f34_arg0:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
                                    end
                                    
                                    f33_arg0:beginAnimation( 90 )
                                    f33_arg0:setLeftRight( 0, 0, -31.5, 71.5 )
                                    f33_arg0:setTopBottom( 0, 0, 4.5, 107.5 )
                                    f33_arg0:registerEventHandler( "transition_complete_keyframe", f33_local0 )
                              end
                              
                              f28_arg0.headshotBarBacking:beginAnimation( 80 )
                              --f28_arg0.headshotBarBacking:setLeftRight( 0.5, 0.5, -171, -36 )
                              --f28_arg0.headshotBarBacking:setTopBottom( 0.5, 0.5, -67, 68 )
                              f28_arg0.headshotBarBacking:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
                              f28_arg0.headshotBarBacking:registerEventHandler( "transition_complete_keyframe", f32_local0 )
                        end
                        
                        f28_arg0.headshotBarBacking:completeAnimation()
                        --f28_arg0.headshotBarBacking:setLeftRight( 0.5, 0.5, -171, -36 )
                        --f28_arg0.headshotBarBacking:setTopBottom( 0.5, 0.5, -67, 68 )
                        f28_local1( f28_arg0.headshotBarBacking )
                        local f28_local2 = function ( f35_arg0 )
                              local f35_local0 = function ( f36_arg0 )
                                    local f36_local0 = function ( f37_arg0 )
                                          f37_arg0:beginAnimation( 89 )
                                          f37_arg0:setLeftRight( 0, 0, -6, 232 )
                                          f37_arg0:setTopBottom( 0, 0, 42, 208 )
                                          f37_arg0:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
                                    end
                                    
                                    f36_arg0:beginAnimation( 90 )
                                    f36_arg0:setLeftRight( 0, 0, -4, 234 )
                                    f36_arg0:setTopBottom( 0, 0, 32, 198 )
                                    f36_arg0:registerEventHandler( "transition_complete_keyframe", f36_local0 )
                              end
                              
                              f28_arg0.HealthValue:beginAnimation( 80 )
                              f28_arg0.HealthValue:setLeftRight( 0, 0, 5, 243 )
                              f28_arg0.HealthValue:setTopBottom( 0, 0, 50, 216 )
                              f28_arg0.HealthValue:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
                              f28_arg0.HealthValue:registerEventHandler( "transition_complete_keyframe", f35_local0 )
                        end
                        
                        f28_arg0.HealthValue:completeAnimation()
                        f28_arg0.HealthValue:setLeftRight( 0, 0, -6, 232 )
                        f28_arg0.HealthValue:setTopBottom( 0, 0, 42, 208 )
                        f28_local2( f28_arg0.HealthValue )
                        local f28_local3 = function ( f38_arg0 )
                              local f38_local0 = function ( f39_arg0 )
                                    local f39_local0 = function ( f40_arg0 )
                                          f40_arg0:beginAnimation( 89 )
                                          f40_arg0:setLeftRight( 0, 0, 115, 244 )
                                          f40_arg0:setTopBottom( 0, 0, 26.5, 73.5 )
                                          f40_arg0:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
                                    end
                                    
                                    f39_arg0:beginAnimation( 90 )
                                    f39_arg0:setLeftRight( 0, 0, 113, 242 )
                                    f39_arg0:setTopBottom( 0, 0, 16.5, 63.5 )
                                    f39_arg0:registerEventHandler( "transition_complete_keyframe", f39_local0 )
                              end
                              
                              f28_arg0.Score:beginAnimation( 80 )
                              f28_arg0.Score:setLeftRight( 0.00, 0.00, 0.00, 250.00 )
                              f28_arg0.Score:setTopBottom( 0.00, 0.00, 25.00, 65.00 )
                              f28_arg0.Score:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
                              f28_arg0.Score:registerEventHandler( "transition_complete_keyframe", f38_local0 )
                        end
                        
                        f28_arg0.Score:completeAnimation()
                        f28_arg0.Score:setLeftRight( 0, 0, 115, 244 )
                        f28_arg0.Score:setTopBottom( 0, 0, 26.5, 73.5 )
                        f28_local3( f28_arg0.Score )
                        local f28_local4 = function ( f41_arg0 )
                              local f41_local0 = function ( f42_arg0 )
                                    local f42_local0 = function ( f43_arg0 )
                                          f43_arg0:beginAnimation( 89 )
                                          f43_arg0:setLeftRight( 0, 0, -38, 32 )
                                          f43_arg0:setTopBottom( 0, 0, -14.5, 30.5 )
                                          f43_arg0:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
                                    end
                                    
                                    f42_arg0:beginAnimation( 90 )
                                    f42_arg0:setLeftRight( 0, 0, -46, 24 )
                                    f42_arg0:setTopBottom( 0, 0, -33.5, 11.5 )
                                    f42_arg0:registerEventHandler( "transition_complete_keyframe", f42_local0 )
                              end
                              
                              f28_arg0.SelfReviveCounter:beginAnimation( 80 )
                              f28_arg0.SelfReviveCounter:setLeftRight( 0, 0, -21, 49 )
                              f28_arg0.SelfReviveCounter:setTopBottom( 0, 0, -23.44, 21.56 )
                              f28_arg0.SelfReviveCounter:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
                              f28_arg0.SelfReviveCounter:registerEventHandler( "transition_complete_keyframe", f41_local0 )
                        end
                        
                        f28_arg0.SelfReviveCounter:completeAnimation()
                        f28_arg0.SelfReviveCounter:setLeftRight( 0, 0, -38, 47 )
                        f28_arg0.SelfReviveCounter:setTopBottom( 0, 0, -14.5, 30.5 )
                        f28_local4( f28_arg0.SelfReviveCounter )
                  end,
                  Hidden = function ( f44_arg0, f44_arg1 )
                        f44_arg0:__resetProperties()
                        f44_arg0:setupElementClipCounter( 9 )
                        local f44_local0 = function ( f45_arg0 )
                              f44_arg0.BackingBlur:beginAnimation( 150 )
                              f44_arg0.BackingBlur:setAlpha( 0 )
                              f44_arg0.BackingBlur:registerEventHandler( "interrupted_keyframe", f44_arg0.clipInterrupted )
                              f44_arg0.BackingBlur:registerEventHandler( "transition_complete_keyframe", f44_arg0.clipFinished )
                        end
                        
                        f44_arg0.BackingBlur:completeAnimation()
                        f44_arg0.BackingBlur:setAlpha( 0.9 )
                        f44_local0( f44_arg0.BackingBlur )
                        local f44_local1 = function ( f46_arg0 )
                              f44_arg0.Backing:beginAnimation( 150 )
                              f44_arg0.Backing:setAlpha( 0 )
                              f44_arg0.Backing:registerEventHandler( "interrupted_keyframe", f44_arg0.clipInterrupted )
                              f44_arg0.Backing:registerEventHandler( "transition_complete_keyframe", f44_arg0.clipFinished )
                        end
                        
                        f44_arg0.Backing:completeAnimation()
                        f44_arg0.Backing:setAlpha( 1 )
                        f44_local1( f44_arg0.Backing )
                        local f44_local2 = function ( f47_arg0 )
                              f44_arg0.headshotBarBacking:beginAnimation( 150 )
                              f44_arg0.headshotBarBacking:setAlpha( 0 )
                              f44_arg0.headshotBarBacking:registerEventHandler( "interrupted_keyframe", f44_arg0.clipInterrupted )
                              f44_arg0.headshotBarBacking:registerEventHandler( "transition_complete_keyframe", f44_arg0.clipFinished )
                        end
                        
                        f44_arg0.headshotBarBacking:completeAnimation()
                        f44_arg0.headshotBarBacking:setAlpha( 1 )
                        f44_local2( f44_arg0.headshotBarBacking )
                        local f44_local3 = function ( f48_arg0 )
                              f44_arg0.HealthValue:beginAnimation( 150 )
                              f44_arg0.HealthValue:setAlpha( 0 )
                              f44_arg0.HealthValue:registerEventHandler( "interrupted_keyframe", f44_arg0.clipInterrupted )
                              f44_arg0.HealthValue:registerEventHandler( "transition_complete_keyframe", f44_arg0.clipFinished )
                        end
                        
                        f44_arg0.HealthValue:completeAnimation()
                        f44_arg0.HealthValue:setAlpha( 1 )
                        f44_local3( f44_arg0.HealthValue )
                        local f44_local4 = function ( f49_arg0 )
                              f44_arg0.ScoreShadow:beginAnimation( 150 )
                              f44_arg0.ScoreShadow:setAlpha( 0 )
                              f44_arg0.ScoreShadow:registerEventHandler( "interrupted_keyframe", f44_arg0.clipInterrupted )
                              f44_arg0.ScoreShadow:registerEventHandler( "transition_complete_keyframe", f44_arg0.clipFinished )
                        end
                        
                        f44_arg0.ScoreShadow:completeAnimation()
                        f44_arg0.ScoreShadow:setAlpha( 1 )
                        f44_local4( f44_arg0.ScoreShadow )
                        local f44_local5 = function ( f50_arg0 )
                              f44_arg0.Score:beginAnimation( 150 )
                              f44_arg0.Score:setAlpha( 0 )
                              f44_arg0.Score:registerEventHandler( "interrupted_keyframe", f44_arg0.clipInterrupted )
                              f44_arg0.Score:registerEventHandler( "transition_complete_keyframe", f44_arg0.clipFinished )
                        end
                        
                        f44_arg0.Score:completeAnimation()
                        f44_arg0.Score:setAlpha( 1 )
                        f44_local5( f44_arg0.Score )
                        local f44_local6 = function ( f51_arg0 )
                              f44_arg0.SelfReviveCounter:beginAnimation( 150 )
                              f44_arg0.SelfReviveCounter:setAlpha( 0 )
                              f44_arg0.SelfReviveCounter:registerEventHandler( "interrupted_keyframe", f44_arg0.clipInterrupted )
                              f44_arg0.SelfReviveCounter:registerEventHandler( "transition_complete_keyframe", f44_arg0.clipFinished )
                        end
                        
                        f44_arg0.SelfReviveCounter:completeAnimation()
                        f44_arg0.SelfReviveCounter:setAlpha( 1 )
                        f44_local6( f44_arg0.SelfReviveCounter )
                        local f44_local7 = function ( f52_arg0 )
                              f44_arg0.Checkbox:beginAnimation( 150 )
                              f44_arg0.Checkbox:setAlpha( 0 )
                              f44_arg0.Checkbox:registerEventHandler( "interrupted_keyframe", f44_arg0.clipInterrupted )
                              f44_arg0.Checkbox:registerEventHandler( "transition_complete_keyframe", f44_arg0.clipFinished )
                        end
                        
                        f44_arg0.Checkbox:completeAnimation()
                        f44_arg0.Checkbox:setAlpha( 1 )
                        f44_local7( f44_arg0.Checkbox )
                        local f44_local8 = function ( f53_arg0 )
                              f44_arg0.GlobalTracker:beginAnimation( 150 )
                              f44_arg0.GlobalTracker:setAlpha( 0 )
                              f44_arg0.GlobalTracker:registerEventHandler( "interrupted_keyframe", f44_arg0.clipInterrupted )
                              f44_arg0.GlobalTracker:registerEventHandler( "transition_complete_keyframe", f44_arg0.clipFinished )
                        end
                        
                        f44_arg0.GlobalTracker:completeAnimation()
                        f44_arg0.GlobalTracker:setAlpha( 1 )
                        f44_local8( f44_arg0.GlobalTracker )
                  end
            },
            HiddenCopy = {
                  DefaultClip = function ( f54_arg0, f54_arg1 )
                        f54_arg0:__resetProperties()
                        f54_arg0:setupElementClipCounter( 11 )
                        f54_arg0.BackingBlur:completeAnimation()
                        f54_arg0.BackingBlur:setAlpha( 0 )
                        f54_arg0.clipFinished( f54_arg0.BackingBlur )
                        f54_arg0.Backing:completeAnimation()
                        f54_arg0.Backing:setAlpha( 0 )
                        f54_arg0.clipFinished( f54_arg0.Backing )
                        f54_arg0.headshotBarBacking:completeAnimation()
                        f54_arg0.headshotBarBacking:setAlpha( 0 )
                        f54_arg0.clipFinished( f54_arg0.headshotBarBacking )
                        f54_arg0.HealthValue:completeAnimation()
                        f54_arg0.HealthValue:setAlpha( 0 )
                        f54_arg0.clipFinished( f54_arg0.HealthValue )
                        f54_arg0.ScoreShadow:completeAnimation()
                        f54_arg0.ScoreShadow:setAlpha( 0 )
                        f54_arg0.clipFinished( f54_arg0.ScoreShadow )
                        f54_arg0.Score:completeAnimation()
                        f54_arg0.Score:setAlpha( 0 )
                        f54_arg0.clipFinished( f54_arg0.Score )
                        f54_arg0.SelfReviveCounter:completeAnimation()
                        f54_arg0.SelfReviveCounter:setAlpha( 0 )
                        f54_arg0.clipFinished( f54_arg0.SelfReviveCounter )
                        f54_arg0.Checkbox:completeAnimation()
                        f54_arg0.Checkbox:setAlpha( 0 )
                        f54_arg0.clipFinished( f54_arg0.Checkbox )
                        f54_arg0.GlobalTracker:completeAnimation()
                        f54_arg0.GlobalTracker:setAlpha( 0 )
                        f54_arg0.clipFinished( f54_arg0.GlobalTracker )
                        f54_arg0.ZMExtraPerkVapors:completeAnimation()
                        f54_arg0.ZMExtraPerkVapors:setAlpha( 0 )
                        f54_arg0.clipFinished( f54_arg0.ZMExtraPerkVapors )
                        f54_arg0.DemoPip:completeAnimation()
                        f54_arg0.DemoPip:setAlpha( 0 )
                        f54_arg0.clipFinished( f54_arg0.DemoPip )
                  end
            },
            Hidden = {
                  DefaultClip = function ( f55_arg0, f55_arg1 )
                        f55_arg0:__resetProperties()
                        f55_arg0:setupElementClipCounter( 11 )
                        f55_arg0.BackingBlur:completeAnimation()
                        f55_arg0.BackingBlur:setAlpha( 0 )
                        f55_arg0.clipFinished( f55_arg0.BackingBlur )
                        f55_arg0.Backing:completeAnimation()
                        f55_arg0.Backing:setAlpha( 0 )
                        f55_arg0.clipFinished( f55_arg0.Backing )
                        f55_arg0.headshotBarBacking:completeAnimation()
                        f55_arg0.headshotBarBacking:setAlpha( 0 )
                        f55_arg0.clipFinished( f55_arg0.headshotBarBacking )
                        f55_arg0.HealthValue:completeAnimation()
                        f55_arg0.HealthValue:setAlpha( 0 )
                        f55_arg0.clipFinished( f55_arg0.HealthValue )
                        f55_arg0.ScoreShadow:completeAnimation()
                        f55_arg0.ScoreShadow:setAlpha( 0 )
                        f55_arg0.clipFinished( f55_arg0.ScoreShadow )
                        f55_arg0.Score:completeAnimation()
                        f55_arg0.Score:setAlpha( 0 )
                        f55_arg0.clipFinished( f55_arg0.Score )
                        f55_arg0.SelfReviveCounter:completeAnimation()
                        f55_arg0.SelfReviveCounter:setAlpha( 0 )
                        f55_arg0.clipFinished( f55_arg0.SelfReviveCounter )
                        f55_arg0.Checkbox:completeAnimation()
                        f55_arg0.Checkbox:setAlpha( 0 )
                        f55_arg0.clipFinished( f55_arg0.Checkbox )
                        f55_arg0.GlobalTracker:completeAnimation()
                        f55_arg0.GlobalTracker:setAlpha( 0 )
                        f55_arg0.clipFinished( f55_arg0.GlobalTracker )
                        f55_arg0.ZMExtraPerkVapors:completeAnimation()
                        f55_arg0.ZMExtraPerkVapors:setAlpha( 0 )
                        f55_arg0.clipFinished( f55_arg0.ZMExtraPerkVapors )
                        f55_arg0.DemoPip:completeAnimation()
                        f55_arg0.DemoPip:setAlpha( 0 )
                        f55_arg0.clipFinished( f55_arg0.DemoPip )
                  end,
                  DefaultState = function ( f56_arg0, f56_arg1 )
                        f56_arg0:__resetProperties()
                        f56_arg0:setupElementClipCounter( 9 )
                        local f56_local0 = function ( f57_arg0 )
                              f56_arg0.BackingBlur:beginAnimation( 150 )
                              f56_arg0.BackingBlur:setAlpha( 0.9 )
                              f56_arg0.BackingBlur:registerEventHandler( "interrupted_keyframe", f56_arg0.clipInterrupted )
                              f56_arg0.BackingBlur:registerEventHandler( "transition_complete_keyframe", f56_arg0.clipFinished )
                        end
                        
                        f56_arg0.BackingBlur:completeAnimation()
                        f56_arg0.BackingBlur:setAlpha( 0 )
                        f56_local0( f56_arg0.BackingBlur )
                        local f56_local1 = function ( f58_arg0 )
                              f56_arg0.Backing:beginAnimation( 150 )
                              f56_arg0.Backing:setAlpha( 1 )
                              f56_arg0.Backing:registerEventHandler( "interrupted_keyframe", f56_arg0.clipInterrupted )
                              f56_arg0.Backing:registerEventHandler( "transition_complete_keyframe", f56_arg0.clipFinished )
                        end
                        
                        f56_arg0.Backing:completeAnimation()
                        f56_arg0.Backing:setAlpha( 0 )
                        f56_local1( f56_arg0.Backing )
                        local f56_local2 = function ( f59_arg0 )
                              f56_arg0.headshotBarBacking:beginAnimation( 150 )
                              f56_arg0.headshotBarBacking:setAlpha( 1 )
                              f56_arg0.headshotBarBacking:registerEventHandler( "interrupted_keyframe", f56_arg0.clipInterrupted )
                              f56_arg0.headshotBarBacking:registerEventHandler( "transition_complete_keyframe", f56_arg0.clipFinished )
                        end
                        
                        f56_arg0.headshotBarBacking:completeAnimation()
                        f56_arg0.headshotBarBacking:setAlpha( 0 )
                        f56_local2( f56_arg0.headshotBarBacking )
                        local f56_local3 = function ( f60_arg0 )
                              f56_arg0.HealthValue:beginAnimation( 150 )
                              f56_arg0.HealthValue:setAlpha( 1 )
                              f56_arg0.HealthValue:registerEventHandler( "interrupted_keyframe", f56_arg0.clipInterrupted )
                              f56_arg0.HealthValue:registerEventHandler( "transition_complete_keyframe", f56_arg0.clipFinished )
                        end
                        
                        f56_arg0.HealthValue:completeAnimation()
                        f56_arg0.HealthValue:setAlpha( 0 )
                        f56_local3( f56_arg0.HealthValue )
                        local f56_local4 = function ( f61_arg0 )
                              f56_arg0.ScoreShadow:beginAnimation( 150 )
                              f56_arg0.ScoreShadow:setAlpha( 1 )
                              f56_arg0.ScoreShadow:registerEventHandler( "interrupted_keyframe", f56_arg0.clipInterrupted )
                              f56_arg0.ScoreShadow:registerEventHandler( "transition_complete_keyframe", f56_arg0.clipFinished )
                        end
                        
                        f56_arg0.ScoreShadow:completeAnimation()
                        f56_arg0.ScoreShadow:setAlpha( 0 )
                        f56_local4( f56_arg0.ScoreShadow )
                        local f56_local5 = function ( f62_arg0 )
                              f56_arg0.Score:beginAnimation( 150 )
                              f56_arg0.Score:setAlpha( 1 )
                              f56_arg0.Score:registerEventHandler( "interrupted_keyframe", f56_arg0.clipInterrupted )
                              f56_arg0.Score:registerEventHandler( "transition_complete_keyframe", f56_arg0.clipFinished )
                        end
                        
                        f56_arg0.Score:completeAnimation()
                        f56_arg0.Score:setAlpha( 0 )
                        f56_local5( f56_arg0.Score )
                        local f56_local6 = function ( f63_arg0 )
                              f56_arg0.SelfReviveCounter:beginAnimation( 150 )
                              f56_arg0.SelfReviveCounter:setAlpha( 1 )
                              f56_arg0.SelfReviveCounter:registerEventHandler( "interrupted_keyframe", f56_arg0.clipInterrupted )
                              f56_arg0.SelfReviveCounter:registerEventHandler( "transition_complete_keyframe", f56_arg0.clipFinished )
                        end
                        
                        f56_arg0.SelfReviveCounter:completeAnimation()
                        f56_arg0.SelfReviveCounter:setAlpha( 0 )
                        f56_local6( f56_arg0.SelfReviveCounter )
                        local f56_local7 = function ( f64_arg0 )
                              f56_arg0.Checkbox:beginAnimation( 150 )
                              f56_arg0.Checkbox:setAlpha( 1 )
                              f56_arg0.Checkbox:registerEventHandler( "interrupted_keyframe", f56_arg0.clipInterrupted )
                              f56_arg0.Checkbox:registerEventHandler( "transition_complete_keyframe", f56_arg0.clipFinished )
                        end
                        
                        f56_arg0.Checkbox:completeAnimation()
                        f56_arg0.Checkbox:setAlpha( 0 )
                        f56_local7( f56_arg0.Checkbox )
                        local f56_local8 = function ( f65_arg0 )
                              f56_arg0.GlobalTracker:beginAnimation( 150 )
                              f56_arg0.GlobalTracker:setAlpha( 1 )
                              f56_arg0.GlobalTracker:registerEventHandler( "interrupted_keyframe", f56_arg0.clipInterrupted )
                              f56_arg0.GlobalTracker:registerEventHandler( "transition_complete_keyframe", f56_arg0.clipFinished )
                        end
                        
                        f56_arg0.GlobalTracker:completeAnimation()
                        f56_arg0.GlobalTracker:setAlpha( 0 )
                        f56_local8( f56_arg0.GlobalTracker )
                  end
            }
      }

      CoD.PlayerWidget_ZM.__onClose = function ( f66_arg0 )
            f66_arg0.headshotBarBacking:close()
            f66_arg0.HealthValue:close()
            f66_arg0.ScoreShadow:close()
            f66_arg0.Score:close()
            f66_arg0.SelfReviveCounter:close()
            f66_arg0.Checkbox:close()
            f66_arg0.GlobalTracker:close()
            f66_arg0.ZMExtraPerkVapors:close()
            f66_arg0.DemoPip:close()
      end

      CoD.AmmoWidgetWZ_WeaponName = InheritFrom( LUI.UIElement )
      CoD.AmmoWidgetWZ_WeaponName.__defaultWidth = 138
      CoD.AmmoWidgetWZ_WeaponName.__defaultHeight = 12
      CoD.AmmoWidgetWZ_WeaponName.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.AmmoWidgetWZ_WeaponName )
            self.id = "AmmoWidgetWZ_WeaponName"
            self.soundSet = "default"
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            local HeroAbilityUseString = LUI.UIText.new( 0, 0, 0, 86, 0, 0, -0.5, 11.5 )
            HeroAbilityUseString:setRGB( 0.73, 0.71, 0.64 )
            HeroAbilityUseString:setText( "" )
            HeroAbilityUseString:setTTF( "notosans_bold" )
            HeroAbilityUseString:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_90D57B1E92D39D7" ) )
            HeroAbilityUseString:setShaderVector( 0, 1, 0, 0, 0 )
            HeroAbilityUseString:setShaderVector( 1, 0, 0, 0, 0 )
            HeroAbilityUseString:setShaderVector( 2, 0.8, 0.8, 0.8, 0.2 )
            HeroAbilityUseString:setLetterSpacing( 1 )
            HeroAbilityUseString:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            HeroAbilityUseString:setAlignment( Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"] )
            self:addElement( HeroAbilityUseString )
            self.HeroAbilityUseString = HeroAbilityUseString
            
            self:subscribeToGlobalModel( f1_arg1, "PerController", "heldWeapons.0.updateWeaponSelect", function ( model )
                  local f2_local0 = self
                  PulseElementToStateAndBack( self, "Respawn", f1_arg1 )
            end )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            return self
      end

      CoD.AmmoWidgetWZ_WeaponName.__resetProperties = function ( f3_arg0 )
            f3_arg0.HeroAbilityUseString:completeAnimation()
            f3_arg0.HeroAbilityUseString:setLeftRight( 0, 0, 0, 86 )
            f3_arg0.HeroAbilityUseString:setTopBottom( 0, 0, -0.5, 11.5 )
            f3_arg0.HeroAbilityUseString:setAlpha( 1 )
      end

      CoD.AmmoWidgetWZ_WeaponName.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f4_arg0, f4_arg1 )
                        f4_arg0:__resetProperties()
                        f4_arg0:setupElementClipCounter( 1 )
                        local f4_local0 = function ( f5_arg0 )
                              f4_arg0.HeroAbilityUseString:beginAnimation( 1990 )
                              f4_arg0.HeroAbilityUseString:registerEventHandler( "interrupted_keyframe", f4_arg0.clipInterrupted )
                              f4_arg0.HeroAbilityUseString:registerEventHandler( "transition_complete_keyframe", f4_arg0.clipFinished )
                        end
                        
                        f4_arg0.HeroAbilityUseString:completeAnimation()
                        f4_arg0.HeroAbilityUseString:setAlpha( 1 )
                        f4_local0( f4_arg0.HeroAbilityUseString )
                  end,
                  Hidden = function ( f6_arg0, f6_arg1 )
                        f6_arg0:__resetProperties()
                        f6_arg0:setupElementClipCounter( 1 )
                        local f6_local0 = function ( f7_arg0 )
                              f6_arg0.HeroAbilityUseString:beginAnimation( 200 )
                              f6_arg0.HeroAbilityUseString:setAlpha( 0 )
                              f6_arg0.HeroAbilityUseString:registerEventHandler( "interrupted_keyframe", f6_arg0.clipInterrupted )
                              f6_arg0.HeroAbilityUseString:registerEventHandler( "transition_complete_keyframe", f6_arg0.clipFinished )
                        end
                        
                        f6_arg0.HeroAbilityUseString:completeAnimation()
                        f6_arg0.HeroAbilityUseString:setLeftRight( 0, 0, -11, 127 )
                        f6_arg0.HeroAbilityUseString:setTopBottom( 0, 0, 11.5, 23.5 )
                        f6_arg0.HeroAbilityUseString:setAlpha( 1 )
                        f6_local0( f6_arg0.HeroAbilityUseString )
                  end
            },
            Respawn = {
                  DefaultClip = function ( f8_arg0, f8_arg1 )
                        f8_arg0:__resetProperties()
                        f8_arg0:setupElementClipCounter( 1 )
                        f8_arg0.HeroAbilityUseString:completeAnimation()
                        f8_arg0.HeroAbilityUseString:setAlpha( 1 )
                        f8_arg0.clipFinished( f8_arg0.HeroAbilityUseString )
                  end,
                  DefaultState = function ( f9_arg0, f9_arg1 )
                        f9_arg0:__resetProperties()
                        f9_arg0:setupElementClipCounter( 1 )
                        local f9_local0 = function ( f10_arg0 )
                              local f10_local0 = function ( f11_arg0 )
                                    local f11_local0 = function ( f12_arg0 )
                                          f12_arg0:beginAnimation( 360 )
                                          f12_arg0:setAlpha( 0.2 )
                                          f12_arg0:registerEventHandler( "transition_complete_keyframe", f9_arg0.clipFinished )
                                    end
                                    
                                    f11_arg0:beginAnimation( 1530 )
                                    f11_arg0:registerEventHandler( "transition_complete_keyframe", f11_local0 )
                              end
                              
                              f9_arg0.HeroAbilityUseString:beginAnimation( 100 )
                              f9_arg0.HeroAbilityUseString:setAlpha( 1 )
                              f9_arg0.HeroAbilityUseString:registerEventHandler( "interrupted_keyframe", f9_arg0.clipInterrupted )
                              f9_arg0.HeroAbilityUseString:registerEventHandler( "transition_complete_keyframe", f10_local0 )
                        end
                        
                        f9_arg0.HeroAbilityUseString:completeAnimation()
                        f9_arg0.HeroAbilityUseString:setAlpha( 0 )
                        f9_local0( f9_arg0.HeroAbilityUseString )
                  end
            },
            Hidden = {
                  DefaultClip = function ( f13_arg0, f13_arg1 )
                        f13_arg0:__resetProperties()
                        f13_arg0:setupElementClipCounter( 1 )
                        f13_arg0.HeroAbilityUseString:completeAnimation()
                        f13_arg0.HeroAbilityUseString:setLeftRight( 0, 0, -11, 127 )
                        f13_arg0.HeroAbilityUseString:setTopBottom( 0, 0, 11.5, 23.5 )
                        f13_arg0.HeroAbilityUseString:setAlpha( 0 )
                        f13_arg0.clipFinished( f13_arg0.HeroAbilityUseString )
                  end,
                  DefaultState = function ( f14_arg0, f14_arg1 )
                        f14_arg0:__resetProperties()
                        f14_arg0:setupElementClipCounter( 1 )
                        local f14_local0 = function ( f15_arg0 )
                              f14_arg0.HeroAbilityUseString:beginAnimation( 200 )
                              f14_arg0.HeroAbilityUseString:setAlpha( 1 )
                              f14_arg0.HeroAbilityUseString:registerEventHandler( "interrupted_keyframe", f14_arg0.clipInterrupted )
                              f14_arg0.HeroAbilityUseString:registerEventHandler( "transition_complete_keyframe", f14_arg0.clipFinished )
                        end
                        
                        f14_arg0.HeroAbilityUseString:completeAnimation()
                        f14_arg0.HeroAbilityUseString:setLeftRight( 0, 0, -11, 153 )
                        f14_arg0.HeroAbilityUseString:setTopBottom( 0, 0, 11.5, 21.5 )
                        f14_arg0.HeroAbilityUseString:setAlpha( 0 )
                        f14_local0( f14_arg0.HeroAbilityUseString )
                  end
            }
      }

      CoD.ZMScr_ListingSm = InheritFrom( LUI.UIElement )
      CoD.ZMScr_ListingSm.__defaultWidth = 196
      CoD.ZMScr_ListingSm.__defaultHeight = 88
      CoD.ZMScr_ListingSm.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.ZMScr_ListingSm )
            self.id = "ZMScr_ListingSm"
            self.soundSet = "HUD"
            self.anyChildUsesUpdateState = true
            f1_arg0:addElementToPendingUpdateStateList( self )

            -- add glow for score
            local GlowScore = CoD.ScoreGlowBGList.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
            GlowScore:setAlpha(0)
            self:addElement(GlowScore)
            self.GlowScore = GlowScore
            
            local AllyBGMainBlur = LUI.UIImage.new( 0, 0, 0, 196, 0, 0, 0, 88 )
            AllyBGMainBlur:setImage( RegisterImage( @"hash_1A0DC137E93FBA11" ) )
            AllyBGMainBlur:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_E2354BE557C4C7A" ) )
            AllyBGMainBlur:setShaderVector( 0, 0, 0, 0, 0 )
            self:addElement( AllyBGMainBlur )
            self.AllyBGMainBlur = AllyBGMainBlur
            
            local AllyBGMain = LUI.UIImage.new( 0, 0, 0, 196, 0, 0, 0, 88 )
            AllyBGMain:setImage( RegisterImage( @"hash_25BBCD252908044D" ) )
            self:addElement( AllyBGMain )
            self.AllyBGMain = AllyBGMain
            
            local Panel = CoD.DamageWidgetMP_PanelContainer.new( f1_arg0, f1_arg1, 0, 0, 9.5, 76.5, 0, 0, 10, 77 )
            Panel:setRGB( 0.61, 0.61, 0.61 )
            Panel:setAlpha( 0 )
            Panel:setRFTMaterial( LUI.UIImage.GetCachedMaterial( @"hash_2D79DB5C45AD6024" ) )
            Panel:setShaderVector( 0, 50, 10, 0, 0 )
            Panel:setShaderVector( 1, 100, 100, 0, 0 )
            Panel:setShaderVector( 2, 0.2, 0.04, 0, 0 )
            self:addElement( Panel )
            self.Panel = Panel
            
            local Glow = LUI.UIImage.new( 0.06, 0.76, 36, 14, 0, 0, 14, 69 )
            Glow:setAlpha( 0.2 )
            Glow:setImage( RegisterImage( @"uie_t7_core_hud_mapwidget_panelglow" ) )
            Glow:setMaterial( LUI.UIImage.GetCachedMaterial( @"ui_add" ) )
            Glow:linkToElementModel( self, "clientNum", true, function ( model )
                  local f2_local0 = model:get()
                  if f2_local0 ~= nil then
                        Glow:setRGB( ZombieClientScoreboardGlowColor( f2_local0 ) )
                  end
            end )
            --self:addElement( Glow )
            self.Glow = Glow
            
            local Image0 = LUI.UIImage.new( 0, 0, 0, 30, 1, 1, -30, 0 )
            Image0:linkToElementModel( self, "zombieInventoryIcon", true, function ( model )
                  local f3_local0 = model:get()
                  if f3_local0 ~= nil then
                        Image0:setImage( RegisterImage( f3_local0 ) )
                  end
            end )
            self:addElement( Image0 )
            self.Image0 = Image0

            local FrameOutline = LUI.UIImage.new( 0.00, 0.00, 3.00, 74.00, 0.00, 0.00, 14.00, 74.00 )
            FrameOutline:setImage( RegisterImage( @"glow_classic" ) )
            FrameOutline:setRGB(1, 0, 0)
            FrameOutline:setAlpha(0)

            local StoryID = CoD.ZMStoryUtility.GetCurrentMapStory()

            if StoryID == 1 then
                  FrameOutline:setRGB(1, 1, 0)
            else
                  FrameOutline:setRGB(0.3, 0.7, 1)

                  if Engine[@"lobbygetmap"]() == "zm_office" then
                        FrameOutline:setRGB(1, 0, 0)
                  end
            end

            --FrameOutline:linkToElementModel( self, "clientNum", true, function ( model )
            --      local f4_local0 = model:get()
            --      if f4_local0 ~= nil then
            --            FrameOutline:setRGB( ZombieClientScoreboardColor( f4_local0 ) )
            --      end
            --end )
            self:addElement(FrameOutline)
            self.FrameOutline = FrameOutline

            local Label3 = LUI.UIText.new( 0.00, 0.00, 97.00, 132.00, 0.00, 0.00, 25.00, 58.00 )
            Label3:setTTF( "notosans_bold" )
            Label3:setLetterSpacing( 0.5 )
            Label3:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            Label3:linkToElementModel( self, "clientNum", true, function ( model )
                  local f4_local0 = model:get()
                  if f4_local0 ~= nil then
                        Label3:setRGB( ZombieClientScoreboardColor( f4_local0 ) )
                  end
            end )
            Label3:linkToElementModel( self, "playerScore", true, function ( model )
                  local f5_local0 = model:get()
                  if f5_local0 ~= nil then
                        Label3:setText( f5_local0 )
                  end
            end )
            LUI.OverrideFunction_CallOriginalFirst( Label3, "setText", function ( element, controller )
                  --ScaleWidgetToLabel( self, element, 0 )
            end )
            self:addElement( Label3 )
            self.Label3 = Label3

            local FixedAspectRatioImage = CoD.ZMScr_Portrait.new( f1_arg0, f1_arg1, 0, 0, -2, 88, 0, 0, 10, 77 )
            FixedAspectRatioImage:setScale( 1, 1 )
            --FixedAspectRatioImage:setRFTMaterial( LUI.UIImage.GetCachedMaterial( @"hash_2D79DB5C45AD6024" ) )
            FixedAspectRatioImage:setShaderVector( 0, 34, 16, 0, 0 )
            FixedAspectRatioImage:setShaderVector( 1, 65, 100, 0, 0 )
            FixedAspectRatioImage:setShaderVector( 2, 0, 0.04, 0, 0 )
            FixedAspectRatioImage:linkToElementModel( self, "zombiePlayerIcon", true, function ( model )
                  local f7_local0 = model:get()
                  if f7_local0 ~= nil then
                        FixedAspectRatioImage.FixedAspectRatioImage:setImage( RegisterImage( f7_local0 ) )
                  end
            end )
            self:addElement( FixedAspectRatioImage )
            self.FixedAspectRatioImage = FixedAspectRatioImage
            
            local TrialsInfo = CoD.ZMScr_TrialsSm.new( f1_arg0, f1_arg1, 0, 0, -5, 81, 0, 0, 56, 98 )
            self:addElement( TrialsInfo )
            self.TrialsInfo = TrialsInfo
            
            self:mergeStateConditions( {
                  {
                        stateName = "VisibleLarge",
                        condition = function ( menu, element, event )
                              local f8_local0
                              if not CoD.ModelUtility.IsSelfModelValueEqualTo( element, f1_arg1, "playerScoreShown", 0 ) then
                                    f8_local0 = AlwaysFalse()
                              else
                                    f8_local0 = false
                              end
                              return f8_local0
                        end
                  },
                  {
                        stateName = "Visible",
                        condition = function ( menu, element, event )
                              return not CoD.ModelUtility.IsSelfModelValueEqualTo( element, f1_arg1, "playerScoreShown", 0 )
                        end
                  }
            } )
            self:linkToElementModel( self, "playerScoreShown", true, function ( model )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "playerScoreShown"
                  } )
            end )
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            return self
      end

      CoD.ZMScr_ListingSm.__resetProperties = function ( f11_arg0 )
            f11_arg0.Panel:completeAnimation()
            f11_arg0.Label3:completeAnimation()
            f11_arg0.Glow:completeAnimation()
            f11_arg0.TrialsInfo:completeAnimation()
            f11_arg0.Image0:completeAnimation()
            f11_arg0.AllyBGMain:completeAnimation()
            f11_arg0.AllyBGMainBlur:completeAnimation()
            f11_arg0.Panel:setLeftRight( 0, 0, 9.5, 76.5 )
            f11_arg0.Panel:setAlpha( 0 )
            f11_arg0.Panel:setScale( 1, 1 )
            f11_arg0.Label3:setLeftRight( 0.00, 0.00, 97.00, 132.00 )
            f11_arg0.Label3:setTopBottom( 0.00, 0.00, 25.00, 58.00 )
            f11_arg0.Label3:setAlpha( 1 )
            f11_arg0.Label3:setScale( 1, 1 )
            f11_arg0.Glow:setLeftRight( 0.06, 0.76, 36, 14 )
            f11_arg0.Glow:setTopBottom( 0, 0, 14, 69 )
            f11_arg0.Glow:setAlpha( 0.2 )
            f11_arg0.Glow:setScale( 1, 1 )
            f11_arg0.TrialsInfo:setLeftRight( 0, 0, -5, 81 )
            f11_arg0.TrialsInfo:setTopBottom( 0, 0, 56, 98 )
            f11_arg0.TrialsInfo:setAlpha( 1 )
            f11_arg0.Image0:setAlpha( 1 )
            f11_arg0.Image0:setScale( 1, 1 )
            f11_arg0.AllyBGMain:setAlpha( 1 )
            f11_arg0.AllyBGMainBlur:setAlpha( 1 )
            f11_arg0.FrameOutline:setAlpha(1)
            f11_arg0.GlowScore:setAlpha(1)
      end

      CoD.ZMScr_ListingSm.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f12_arg0, f12_arg1 )
                        f12_arg0:__resetProperties()
                        f12_arg0:setupElementClipCounter( 7 )
                        f12_arg0.AllyBGMainBlur:completeAnimation()
                        f12_arg0.AllyBGMainBlur:setAlpha( 0 )
                        f12_arg0.clipFinished( f12_arg0.AllyBGMainBlur )
                        f12_arg0.AllyBGMain:completeAnimation()
                        f12_arg0.AllyBGMain:setAlpha( 0 )
                        f12_arg0.clipFinished( f12_arg0.AllyBGMain )
                        f12_arg0.Panel:completeAnimation()
                        f12_arg0.Panel:setAlpha( 0 )
                        f12_arg0.clipFinished( f12_arg0.Panel )
                        f12_arg0.Glow:completeAnimation()
                        f12_arg0.Glow:setAlpha( 0 )
                        f12_arg0.clipFinished( f12_arg0.Glow )
                        f12_arg0.FrameOutline:completeAnimation()
                        f12_arg0.FrameOutline:setAlpha( 0 )
                        f12_arg0.clipFinished( f12_arg0.FrameOutline )
                        f12_arg0.GlowScore:completeAnimation()
                        f12_arg0.GlowScore:setAlpha( 0 )
                        f12_arg0.clipFinished( f12_arg0.GlowScore )
                        f12_arg0.Image0:completeAnimation()
                        f12_arg0.Image0:setAlpha( 0 )
                        f12_arg0.clipFinished( f12_arg0.Image0 )
                        f12_arg0.Label3:completeAnimation()
                        f12_arg0.Label3:setAlpha( 0 )
                        f12_arg0.clipFinished( f12_arg0.Label3 )
                        f12_arg0.TrialsInfo:completeAnimation()
                        f12_arg0.TrialsInfo:setAlpha( 0 )
                        f12_arg0.clipFinished( f12_arg0.TrialsInfo )
                  end,
                  Visible = function ( f13_arg0, f13_arg1 )
                        f13_arg0:__resetProperties()
                        f13_arg0:setupElementClipCounter( 7 )

                        local f13_local0 = function ( f14_arg0 )
                              f13_arg0.AllyBGMainBlur:beginAnimation( 300, Enum[@"luitween"][@"luitween_bounce"] )
                              f13_arg0.AllyBGMainBlur:setAlpha( 1 )
                              f13_arg0.AllyBGMainBlur:registerEventHandler( "interrupted_keyframe", f13_arg0.clipInterrupted )
                              f13_arg0.AllyBGMainBlur:registerEventHandler( "transition_complete_keyframe", f13_arg0.clipFinished )
                        end
                        
                        f13_arg0.AllyBGMainBlur:completeAnimation()
                        f13_arg0.AllyBGMainBlur:setAlpha( 0 )
                        f13_local0( f13_arg0.AllyBGMainBlur )

                        local f13_local12 = function ( f14_arg0 )
                              f13_arg0.FrameOutline:beginAnimation( 300, Enum[@"luitween"][@"luitween_bounce"] )
                              f13_arg0.FrameOutline:setAlpha( 1 )
                              f13_arg0.FrameOutline:registerEventHandler( "interrupted_keyframe", f13_arg0.clipInterrupted )
                              f13_arg0.FrameOutline:registerEventHandler( "transition_complete_keyframe", f13_arg0.clipFinished )
                        end
                        
                        f13_arg0.FrameOutline:completeAnimation()
                        f13_arg0.FrameOutline:setAlpha( 0 )
                        f13_local12( f13_arg0.FrameOutline )

                        local f13_local123 = function ( f14_arg0 )
                              f13_arg0.GlowScore:beginAnimation( 300, Enum[@"luitween"][@"luitween_bounce"] )
                              f13_arg0.GlowScore:setAlpha( 1 )
                              f13_arg0.GlowScore:registerEventHandler( "interrupted_keyframe", f13_arg0.clipInterrupted )
                              f13_arg0.GlowScore:registerEventHandler( "transition_complete_keyframe", f13_arg0.clipFinished )
                        end
                        
                        f13_arg0.GlowScore:completeAnimation()
                        f13_arg0.GlowScore:setAlpha( 0 )
                        f13_local123( f13_arg0.GlowScore )


                        local f13_local1 = function ( f15_arg0 )
                              f13_arg0.AllyBGMain:beginAnimation( 300, Enum[@"luitween"][@"luitween_bounce"] )
                              f13_arg0.AllyBGMain:setAlpha( 1 )
                              f13_arg0.AllyBGMain:registerEventHandler( "interrupted_keyframe", f13_arg0.clipInterrupted )
                              f13_arg0.AllyBGMain:registerEventHandler( "transition_complete_keyframe", f13_arg0.clipFinished )
                        end
                        
                        f13_arg0.AllyBGMain:completeAnimation()
                        f13_arg0.AllyBGMain:setAlpha( 0 )
                        f13_local1( f13_arg0.AllyBGMain )
                        local f13_local2 = function ( f16_arg0 )
                              f13_arg0.Panel:beginAnimation( 300, Enum[@"luitween"][@"luitween_bounce"] )
                              f13_arg0.Panel:registerEventHandler( "interrupted_keyframe", f13_arg0.clipInterrupted )
                              f13_arg0.Panel:registerEventHandler( "transition_complete_keyframe", f13_arg0.clipFinished )
                        end
                        
                        f13_arg0.Panel:completeAnimation()
                        f13_arg0.Panel:setAlpha( 0 )
                        f13_local2( f13_arg0.Panel )
                        local f13_local3 = function ( f17_arg0 )
                              f13_arg0.Glow:beginAnimation( 300, Enum[@"luitween"][@"luitween_bounce"] )
                              f13_arg0.Glow:setAlpha( 0.2 )
                              f13_arg0.Glow:registerEventHandler( "interrupted_keyframe", f13_arg0.clipInterrupted )
                              f13_arg0.Glow:registerEventHandler( "transition_complete_keyframe", f13_arg0.clipFinished )
                        end
                        
                        f13_arg0.Glow:completeAnimation()
                        f13_arg0.Glow:setAlpha( 0 )
                        f13_local3( f13_arg0.Glow )
                        local f13_local4 = function ( f18_arg0 )
                              f13_arg0.Image0:beginAnimation( 300, Enum[@"luitween"][@"luitween_bounce"] )
                              f13_arg0.Image0:setAlpha( 1 )
                              f13_arg0.Image0:registerEventHandler( "interrupted_keyframe", f13_arg0.clipInterrupted )
                              f13_arg0.Image0:registerEventHandler( "transition_complete_keyframe", f13_arg0.clipFinished )
                        end
                        
                        f13_arg0.Image0:completeAnimation()
                        f13_arg0.Image0:setAlpha( 0 )
                        f13_local4( f13_arg0.Image0 )
                        local f13_local5 = function ( f19_arg0 )
                              f13_arg0.Label3:beginAnimation( 300, Enum[@"luitween"][@"luitween_bounce"] )
                              f13_arg0.Label3:setAlpha( 1 )
                              f13_arg0.Label3:registerEventHandler( "interrupted_keyframe", f13_arg0.clipInterrupted )
                              f13_arg0.Label3:registerEventHandler( "transition_complete_keyframe", f13_arg0.clipFinished )
                        end
                        
                        f13_arg0.Label3:completeAnimation()
                        f13_arg0.Label3:setAlpha( 0 )
                        f13_local5( f13_arg0.Label3 )
                        local f13_local6 = function ( f20_arg0 )
                              f13_arg0.TrialsInfo:beginAnimation( 300, Enum[@"luitween"][@"luitween_bounce"] )
                              f13_arg0.TrialsInfo:setAlpha( 1 )
                              f13_arg0.TrialsInfo:registerEventHandler( "interrupted_keyframe", f13_arg0.clipInterrupted )
                              f13_arg0.TrialsInfo:registerEventHandler( "transition_complete_keyframe", f13_arg0.clipFinished )
                        end
                        
                        f13_arg0.TrialsInfo:completeAnimation()
                        f13_arg0.TrialsInfo:setAlpha( 0 )
                        f13_local6( f13_arg0.TrialsInfo )
                  end
            },
            VisibleLarge = {
                  DefaultClip = function ( f21_arg0, f21_arg1 )
                        f21_arg0:__resetProperties()
                        f21_arg0:setupElementClipCounter( 5 )
                        f21_arg0.Panel:completeAnimation()
                        f21_arg0.Panel:setLeftRight( 0, 0, 18.5, 85.5 )
                        f21_arg0.Panel:setScale( 1.25, 1.25 )
                        f21_arg0.clipFinished( f21_arg0.Panel )
                        f21_arg0.Glow:completeAnimation()
                        f21_arg0.Glow:setLeftRight( 0, 1, 74, 52 )
                        f21_arg0.Glow:setTopBottom( 0, 0, 16, 68 )
                        f21_arg0.Glow:setScale( 1.25, 1.25 )
                        f21_arg0.clipFinished( f21_arg0.Glow )
                        f21_arg0.Image0:completeAnimation()
                        f21_arg0.Image0:setScale( 1.25, 1.25 )
                        f21_arg0.clipFinished( f21_arg0.Image0 )
                        f21_arg0.Label3:completeAnimation()
                        f21_arg0.Label3:setLeftRight( 0.00, 0.00, 97.00, 132.00 )
                        f21_arg0.Label3:setTopBottom( 0.00, 0.00, 25.00, 58.00 )
                        f21_arg0.Label3:setScale( 1, 1 )
                        f21_arg0.clipFinished( f21_arg0.Label3 )
                        f21_arg0.TrialsInfo:completeAnimation()
                        f21_arg0.TrialsInfo:setLeftRight( 0, 0, 153.5, 239.5 )
                        f21_arg0.TrialsInfo:setTopBottom( 0, 0, -8.5, 33.5 )
                        f21_arg0.clipFinished( f21_arg0.TrialsInfo )
                  end,
                  DefaultState = function ( f22_arg0, f22_arg1 )
                        f22_arg0:__resetProperties()
                        f22_arg0:setupElementClipCounter( 4 )
                        local f22_local0 = function ( f23_arg0 )
                              f22_arg0.AllyBGMain:beginAnimation( 200 )
                              f22_arg0.AllyBGMain:registerEventHandler( "interrupted_keyframe", f22_arg0.clipInterrupted )
                              f22_arg0.AllyBGMain:registerEventHandler( "transition_complete_keyframe", f22_arg0.clipFinished )
                        end
                        
                        f22_arg0.AllyBGMain:completeAnimation()
                        f22_arg0.AllyBGMain:setAlpha( 1 )
                        f22_local0( f22_arg0.AllyBGMain )
                        local f22_local1 = function ( f24_arg0 )
                              f22_arg0.Panel:beginAnimation( 200 )
                              f22_arg0.Panel:setAlpha( 0 )
                              f22_arg0.Panel:registerEventHandler( "interrupted_keyframe", f22_arg0.clipInterrupted )
                              f22_arg0.Panel:registerEventHandler( "transition_complete_keyframe", f22_arg0.clipFinished )
                        end
                        
                        f22_arg0.Panel:completeAnimation()
                        f22_arg0.Panel:setAlpha( 1 )
                        f22_local1( f22_arg0.Panel )
                        local f22_local2 = function ( f25_arg0 )
                              f22_arg0.Glow:beginAnimation( 200 )
                              f22_arg0.Glow:setAlpha( 0 )
                              f22_arg0.Glow:registerEventHandler( "interrupted_keyframe", f22_arg0.clipInterrupted )
                              f22_arg0.Glow:registerEventHandler( "transition_complete_keyframe", f22_arg0.clipFinished )
                        end
                        
                        f22_arg0.Glow:completeAnimation()
                        f22_arg0.Glow:setAlpha( 0.2 )
                        f22_local2( f22_arg0.Glow )
                        local f22_local3 = function ( f26_arg0 )
                              f22_arg0.Label3:beginAnimation( 200 )
                              f22_arg0.Label3:setAlpha( 0 )
                              f22_arg0.Label3:registerEventHandler( "interrupted_keyframe", f22_arg0.clipInterrupted )
                              f22_arg0.Label3:registerEventHandler( "transition_complete_keyframe", f22_arg0.clipFinished )
                        end
                        
                        f22_arg0.Label3:completeAnimation()
                        f22_arg0.Label3:setAlpha( 1 )
                        f22_local3( f22_arg0.Label3 )
                  end
            },
            Visible = {
                  DefaultClip = function ( f27_arg0, f27_arg1 )
                        f27_arg0:__resetProperties()
                        f27_arg0:setupElementClipCounter( 0 )
                  end,
                  DefaultState = function ( f28_arg0, f28_arg1 )
                        f28_arg0:__resetProperties()
                        f28_arg0:setupElementClipCounter( 7 )
                        local f28_local0 = function ( f29_arg0 )
                              f28_arg0.AllyBGMainBlur:beginAnimation( 200 )
                              f28_arg0.AllyBGMainBlur:setAlpha( 0 )
                              f28_arg0.AllyBGMainBlur:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
                              f28_arg0.AllyBGMainBlur:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
                        end
                        
                        f28_arg0.AllyBGMainBlur:completeAnimation()
                        f28_arg0.AllyBGMainBlur:setAlpha( 1 )
                        f28_local0( f28_arg0.AllyBGMainBlur )

                        local f28_local01 = function ( f29_arg0 )
                              f28_arg0.FrameOutline:beginAnimation( 200 )
                              f28_arg0.FrameOutline:setAlpha( 0 )
                              f28_arg0.FrameOutline:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
                              f28_arg0.FrameOutline:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
                        end
                        
                        f28_arg0.FrameOutline:completeAnimation()
                        f28_arg0.FrameOutline:setAlpha( 1 )
                        f28_local01( f28_arg0.FrameOutline )

                        local f28_local012 = function ( f29_arg0 )
                              f28_arg0.GlowScore:beginAnimation( 200 )
                              f28_arg0.GlowScore:setAlpha( 0 )
                              f28_arg0.GlowScore:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
                              f28_arg0.GlowScore:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
                        end
                        
                        f28_arg0.GlowScore:completeAnimation()
                        f28_arg0.GlowScore:setAlpha( 1 )
                        f28_local012( f28_arg0.GlowScore )

                        local f28_local1 = function ( f30_arg0 )
                              f28_arg0.AllyBGMain:beginAnimation( 200 )
                              f28_arg0.AllyBGMain:setAlpha( 0 )
                              f28_arg0.AllyBGMain:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
                              f28_arg0.AllyBGMain:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
                        end
                        
                        f28_arg0.AllyBGMain:completeAnimation()
                        f28_arg0.AllyBGMain:setAlpha( 1 )
                        f28_local1( f28_arg0.AllyBGMain )
                        local f28_local2 = function ( f31_arg0 )
                              f28_arg0.Panel:beginAnimation( 200 )
                              f28_arg0.Panel:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
                              f28_arg0.Panel:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
                        end
                        
                        f28_arg0.Panel:completeAnimation()
                        f28_arg0.Panel:setAlpha( 0 )
                        f28_local2( f28_arg0.Panel )
                        local f28_local3 = function ( f32_arg0 )
                              f28_arg0.Glow:beginAnimation( 200 )
                              f28_arg0.Glow:setAlpha( 0 )
                              f28_arg0.Glow:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
                              f28_arg0.Glow:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
                        end
                        
                        f28_arg0.Glow:completeAnimation()
                        f28_arg0.Glow:setAlpha( 0.2 )
                        f28_local3( f28_arg0.Glow )
                        local f28_local4 = function ( f33_arg0 )
                              f28_arg0.Image0:beginAnimation( 200 )
                              f28_arg0.Image0:setAlpha( 0 )
                              f28_arg0.Image0:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
                              f28_arg0.Image0:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
                        end
                        
                        f28_arg0.Image0:completeAnimation()
                        f28_arg0.Image0:setAlpha( 1 )
                        f28_local4( f28_arg0.Image0 )
                        local f28_local5 = function ( f34_arg0 )
                              f28_arg0.Label3:beginAnimation( 200 )
                              f28_arg0.Label3:setAlpha( 0 )
                              f28_arg0.Label3:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
                              f28_arg0.Label3:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
                        end
                        
                        f28_arg0.Label3:completeAnimation()
                        f28_arg0.Label3:setAlpha( 1 )
                        f28_local5( f28_arg0.Label3 )
                        local f28_local6 = function ( f35_arg0 )
                              f28_arg0.TrialsInfo:beginAnimation( 200 )
                              f28_arg0.TrialsInfo:setAlpha( 0 )
                              f28_arg0.TrialsInfo:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
                              f28_arg0.TrialsInfo:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
                        end
                        
                        f28_arg0.TrialsInfo:completeAnimation()
                        f28_arg0.TrialsInfo:setAlpha( 1 )
                        f28_local6( f28_arg0.TrialsInfo )
                  end
            }
      }

      CoD.ZMScr_ListingSm.__onClose = function ( f36_arg0 )
            f36_arg0.Panel:close()
            f36_arg0.Glow:close()
            f36_arg0.Image0:close()
            f36_arg0.Label3:close()
            f36_arg0.FixedAspectRatioImage:close()
            f36_arg0.TrialsInfo:close()
            f36_arg0.FrameOutline:close()
            f36_arg0.GlowScore:close()
      end

      CoD.ZMScr_PlusPoints = InheritFrom( LUI.UIElement )
      CoD.ZMScr_PlusPoints.__defaultWidth = 140
      CoD.ZMScr_PlusPoints.__defaultHeight = 99
      CoD.ZMScr_PlusPoints.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.ZMScr_PlusPoints )
            self.id = "ZMScr_PlusPoints"
            self.soundSet = "HUD"
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            local Label2 = LUI.UIText.new( 0, 0, 1.5, 151.5, 0, 0, 21, 77 )
            Label2:setRGB( 1, 0.52, 0 )
            Label2:setAlpha( 0.01 )
            Label2:setZoom( -8 )
            Label2:setText( "" )
            Label2:setTTF( "notosans_bold" )
            Label2:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_2AE166D9BA8C6907" ) )
            Label2:setShaderVector( 0, 0.21, 0, 0, 0 )
            Label2:setShaderVector( 1, 0, 0, 0, 0 )
            Label2:setShaderVector( 2, 1, 0, 0, 0 )
            Label2:setLetterSpacing( 0.9 )
            Label2:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            Label2:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
            self:addElement( Label2 )
            self.Label2 = Label2
            
            local Label1 = LUI.UIText.new( 0, 0, 0.5, 150.5, 0, 0, 21, 77 )
            Label1:setRGB( 0.99, 0.95, 0.62 )
            Label1:setAlpha( 0 )
            Label1:setText( "" )
            Label1:setTTF( "notosans_bold" )
            Label1:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            Label1:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
            self:addElement( Label1 )
            self.Label1 = Label1
            
            local Glow = LUI.UIImage.new( 0, 0, 0, 140, 0, 0, 0, 99 )
            Glow:setRGB( 1, 0.26, 0 )
            Glow:setAlpha( 0.01 )
            Glow:setImage( RegisterImage( @"uie_t7_core_hud_mapwidget_panelglow" ) )
            Glow:setMaterial( LUI.UIImage.GetCachedMaterial( @"ui_add" ) )
            self:addElement( Glow )
            self.Glow = Glow
            
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            local f1_local4 = self
            CoD.HUDUtility.ForceCloseOnClose( self.Glow )
            CoD.HUDUtility.ForceCloseOnClose( self.Label1 )
            CoD.HUDUtility.ForceCloseOnClose( self.Label2 )
            return self
      end

      CoD.ZMScr_PlusPoints.__resetProperties = function ( f2_arg0 )
            f2_arg0.Glow:completeAnimation()
            f2_arg0.Label1:completeAnimation()
            f2_arg0.Label2:completeAnimation()
            f2_arg0.Glow:setRGB( 1, 0.26, 0 )
            f2_arg0.Glow:setAlpha( 0.01 )
            f2_arg0.Label1:setRGB( 0.99, 0.95, 0.62 )
            f2_arg0.Label1:setAlpha( 0 )
            f2_arg0.Label2:setRGB( 1, 0.52, 0 )
            f2_arg0.Label2:setAlpha( 0.01 )
      end

      CoD.ZMScr_PlusPoints.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f3_arg0, f3_arg1 )
                        f3_arg0:__resetProperties()
                        f3_arg0:setupElementClipCounter( 3 )
                        local f3_local0 = function ( f4_arg0 )
                              local f4_local0 = function ( f5_arg0 )
                                    local f5_local0 = function ( f6_arg0 )
                                          local f6_local0 = function ( f7_arg0 )
                                                f7_arg0:beginAnimation( 169, Enum[@"luitween"][@"luitween_bounce"] )
                                                f7_arg0:setAlpha( 0 )
                                                f7_arg0:registerEventHandler( "transition_complete_keyframe", f3_arg0.clipFinished )
                                          end
                                          
                                          f6_arg0:beginAnimation( 330 )
                                          f6_arg0:registerEventHandler( "transition_complete_keyframe", f6_local0 )
                                    end
                                    
                                    f5_arg0:beginAnimation( 140, Enum[@"luitween"][@"luitween_bounce"] )
                                    f5_arg0:registerEventHandler( "transition_complete_keyframe", f5_local0 )
                              end
                              
                              f3_arg0.Label2:beginAnimation( 130, Enum[@"luitween"][@"luitween_bounce"] )
                              f3_arg0.Label2:setAlpha( 0.43 )
                              f3_arg0.Label2:registerEventHandler( "interrupted_keyframe", f3_arg0.clipInterrupted )
                              f3_arg0.Label2:registerEventHandler( "transition_complete_keyframe", f4_local0 )
                        end
                        
                        f3_arg0.Label2:completeAnimation()
                        f3_arg0.Label2:setAlpha( 0 )
                        f3_local0( f3_arg0.Label2 )
                        local f3_local1 = function ( f8_arg0 )
                              local f8_local0 = function ( f9_arg0 )
                                    local f9_local0 = function ( f10_arg0 )
                                          f10_arg0:beginAnimation( 100, Enum[@"luitween"][@"luitween_bounce"] )
                                          f10_arg0:setAlpha( 0 )
                                          f10_arg0:registerEventHandler( "transition_complete_keyframe", f3_arg0.clipFinished )
                                    end
                                    
                                    f9_arg0:beginAnimation( 580 )
                                    f9_arg0:registerEventHandler( "transition_complete_keyframe", f9_local0 )
                              end
                              
                              f3_arg0.Label1:beginAnimation( 70 )
                              f3_arg0.Label1:setAlpha( 1 )
                              f3_arg0.Label1:registerEventHandler( "interrupted_keyframe", f3_arg0.clipInterrupted )
                              f3_arg0.Label1:registerEventHandler( "transition_complete_keyframe", f8_local0 )
                        end
                        
                        f3_arg0.Label1:completeAnimation()
                        f3_arg0.Label1:setAlpha( 0 )
                        f3_local1( f3_arg0.Label1 )
                        local f3_local2 = function ( f11_arg0 )
                              local f11_local0 = function ( f12_arg0 )
                                    local f12_local0 = function ( f13_arg0 )
                                          local f13_local0 = function ( f14_arg0 )
                                                f14_arg0:beginAnimation( 190, Enum[@"luitween"][@"luitween_bounce"] )
                                                f14_arg0:setAlpha( 0 )
                                                f14_arg0:registerEventHandler( "transition_complete_keyframe", f3_arg0.clipFinished )
                                          end
                                          
                                          f13_arg0:beginAnimation( 470 )
                                          f13_arg0:setAlpha( 0.34 )
                                          f13_arg0:registerEventHandler( "transition_complete_keyframe", f13_local0 )
                                    end
                                    
                                    f12_arg0:beginAnimation( 60, Enum[@"luitween"][@"luitween_bounce"] )
                                    f12_arg0:setAlpha( 0.42 )
                                    f12_arg0:registerEventHandler( "transition_complete_keyframe", f12_local0 )
                              end
                              
                              f3_arg0.Glow:beginAnimation( 40 )
                              f3_arg0.Glow:setAlpha( 1 )
                              f3_arg0.Glow:registerEventHandler( "interrupted_keyframe", f3_arg0.clipInterrupted )
                              f3_arg0.Glow:registerEventHandler( "transition_complete_keyframe", f11_local0 )
                        end
                        
                        f3_arg0.Glow:completeAnimation()
                        f3_arg0.Glow:setAlpha( 0 )
                        f3_local2( f3_arg0.Glow )
                  end,
                  NegativeScore = function ( f15_arg0, f15_arg1 )
                        f15_arg0:__resetProperties()
                        f15_arg0:setupElementClipCounter( 3 )
                        local f15_local0 = function ( f16_arg0 )
                              local f16_local0 = function ( f17_arg0 )
                                    local f17_local0 = function ( f18_arg0 )
                                          local f18_local0 = function ( f19_arg0 )
                                                f19_arg0:beginAnimation( 169, Enum[@"luitween"][@"luitween_bounce"] )
                                                f19_arg0:setAlpha( 0 )
                                                f19_arg0:registerEventHandler( "transition_complete_keyframe", f15_arg0.clipFinished )
                                          end
                                          
                                          f18_arg0:beginAnimation( 330 )
                                          f18_arg0:registerEventHandler( "transition_complete_keyframe", f18_local0 )
                                    end
                                    
                                    f17_arg0:beginAnimation( 140, Enum[@"luitween"][@"luitween_bounce"] )
                                    f17_arg0:registerEventHandler( "transition_complete_keyframe", f17_local0 )
                              end
                              
                              f15_arg0.Label2:beginAnimation( 130, Enum[@"luitween"][@"luitween_bounce"] )
                              f15_arg0.Label2:setAlpha( 0.43 )
                              f15_arg0.Label2:registerEventHandler( "interrupted_keyframe", f15_arg0.clipInterrupted )
                              f15_arg0.Label2:registerEventHandler( "transition_complete_keyframe", f16_local0 )
                        end
                        
                        f15_arg0.Label2:completeAnimation()
                        f15_arg0.Label2:setRGB( 0.59, 0.15, 0.11 )
                        f15_arg0.Label2:setAlpha( 0 )
                        f15_local0( f15_arg0.Label2 )
                        local f15_local1 = function ( f20_arg0 )
                              local f20_local0 = function ( f21_arg0 )
                                    local f21_local0 = function ( f22_arg0 )
                                          f22_arg0:beginAnimation( 100, Enum[@"luitween"][@"luitween_bounce"] )
                                          f22_arg0:setAlpha( 0 )
                                          f22_arg0:registerEventHandler( "transition_complete_keyframe", f15_arg0.clipFinished )
                                    end
                                    
                                    f21_arg0:beginAnimation( 580 )
                                    f21_arg0:registerEventHandler( "transition_complete_keyframe", f21_local0 )
                              end
                              
                              f15_arg0.Label1:beginAnimation( 70 )
                              f15_arg0.Label1:setAlpha( 1 )
                              f15_arg0.Label1:registerEventHandler( "interrupted_keyframe", f15_arg0.clipInterrupted )
                              f15_arg0.Label1:registerEventHandler( "transition_complete_keyframe", f20_local0 )
                        end
                        
                        f15_arg0.Label1:completeAnimation()
                        f15_arg0.Label1:setRGB( 0.78, 0.14, 0.08 )
                        f15_arg0.Label1:setAlpha( 0 )
                        f15_local1( f15_arg0.Label1 )
                        local f15_local2 = function ( f23_arg0 )
                              local f23_local0 = function ( f24_arg0 )
                                    local f24_local0 = function ( f25_arg0 )
                                          local f25_local0 = function ( f26_arg0 )
                                                f26_arg0:beginAnimation( 190, Enum[@"luitween"][@"luitween_bounce"] )
                                                f26_arg0:setAlpha( 0 )
                                                f26_arg0:registerEventHandler( "transition_complete_keyframe", f15_arg0.clipFinished )
                                          end
                                          
                                          f25_arg0:beginAnimation( 470 )
                                          f25_arg0:setAlpha( 0.34 )
                                          f25_arg0:registerEventHandler( "transition_complete_keyframe", f25_local0 )
                                    end
                                    
                                    f24_arg0:beginAnimation( 60, Enum[@"luitween"][@"luitween_bounce"] )
                                    f24_arg0:setAlpha( 0.42 )
                                    f24_arg0:registerEventHandler( "transition_complete_keyframe", f24_local0 )
                              end
                              
                              f15_arg0.Glow:beginAnimation( 40 )
                              f15_arg0.Glow:setAlpha( 1 )
                              f15_arg0.Glow:registerEventHandler( "interrupted_keyframe", f15_arg0.clipInterrupted )
                              f15_arg0.Glow:registerEventHandler( "transition_complete_keyframe", f23_local0 )
                        end
                        
                        f15_arg0.Glow:completeAnimation()
                        f15_arg0.Glow:setAlpha( 0 )
                        f15_local2( f15_arg0.Glow )
                  end,
                  BonusScore = function ( f27_arg0, f27_arg1 )
                        f27_arg0:__resetProperties()
                        f27_arg0:setupElementClipCounter( 3 )
                        local f27_local0 = function ( f28_arg0 )
                              local f28_local0 = function ( f29_arg0 )
                                    local f29_local0 = function ( f30_arg0 )
                                          local f30_local0 = function ( f31_arg0 )
                                                f31_arg0:beginAnimation( 169, Enum[@"luitween"][@"luitween_bounce"] )
                                                f31_arg0:setAlpha( 0 )
                                                f31_arg0:registerEventHandler( "transition_complete_keyframe", f27_arg0.clipFinished )
                                          end
                                          
                                          f30_arg0:beginAnimation( 330 )
                                          f30_arg0:registerEventHandler( "transition_complete_keyframe", f30_local0 )
                                    end
                                    
                                    f29_arg0:beginAnimation( 140, Enum[@"luitween"][@"luitween_bounce"] )
                                    f29_arg0:registerEventHandler( "transition_complete_keyframe", f29_local0 )
                              end
                              
                              f27_arg0.Label2:beginAnimation( 130, Enum[@"luitween"][@"luitween_bounce"] )
                              f27_arg0.Label2:setAlpha( 0.43 )
                              f27_arg0.Label2:registerEventHandler( "interrupted_keyframe", f27_arg0.clipInterrupted )
                              f27_arg0.Label2:registerEventHandler( "transition_complete_keyframe", f28_local0 )
                        end
                        
                        f27_arg0.Label2:completeAnimation()
                        f27_arg0.Label2:setRGB( 0.23, 0.45, 0.34 )
                        f27_arg0.Label2:setAlpha( 0 )
                        f27_local0( f27_arg0.Label2 )
                        local f27_local1 = function ( f32_arg0 )
                              local f32_local0 = function ( f33_arg0 )
                                    local f33_local0 = function ( f34_arg0 )
                                          f34_arg0:beginAnimation( 100, Enum[@"luitween"][@"luitween_bounce"] )
                                          f34_arg0:setAlpha( 0 )
                                          f34_arg0:registerEventHandler( "transition_complete_keyframe", f27_arg0.clipFinished )
                                    end
                                    
                                    f33_arg0:beginAnimation( 580 )
                                    f33_arg0:registerEventHandler( "transition_complete_keyframe", f33_local0 )
                              end
                              
                              f27_arg0.Label1:beginAnimation( 70 )
                              f27_arg0.Label1:setAlpha( 1 )
                              f27_arg0.Label1:registerEventHandler( "interrupted_keyframe", f27_arg0.clipInterrupted )
                              f27_arg0.Label1:registerEventHandler( "transition_complete_keyframe", f32_local0 )
                        end
                        
                        f27_arg0.Label1:completeAnimation()
                        f27_arg0.Label1:setRGB( 0.33, 0.95, 0.65 )
                        f27_arg0.Label1:setAlpha( 0 )
                        f27_local1( f27_arg0.Label1 )
                        local f27_local2 = function ( f35_arg0 )
                              local f35_local0 = function ( f36_arg0 )
                                    local f36_local0 = function ( f37_arg0 )
                                          local f37_local0 = function ( f38_arg0 )
                                                f38_arg0:beginAnimation( 190, Enum[@"luitween"][@"luitween_bounce"] )
                                                f38_arg0:setAlpha( 0 )
                                                f38_arg0:registerEventHandler( "transition_complete_keyframe", f27_arg0.clipFinished )
                                          end
                                          
                                          f37_arg0:beginAnimation( 470 )
                                          f37_arg0:setAlpha( 0.34 )
                                          f37_arg0:registerEventHandler( "transition_complete_keyframe", f37_local0 )
                                    end
                                    
                                    f36_arg0:beginAnimation( 60, Enum[@"luitween"][@"luitween_bounce"] )
                                    f36_arg0:setAlpha( 0.42 )
                                    f36_arg0:registerEventHandler( "transition_complete_keyframe", f36_local0 )
                              end
                              
                              f27_arg0.Glow:beginAnimation( 40 )
                              f27_arg0.Glow:setAlpha( 1 )
                              f27_arg0.Glow:registerEventHandler( "interrupted_keyframe", f27_arg0.clipInterrupted )
                              f27_arg0.Glow:registerEventHandler( "transition_complete_keyframe", f35_local0 )
                        end
                        
                        f27_arg0.Glow:completeAnimation()
                        f27_arg0.Glow:setRGB( 0.14, 0.46, 0.3 )
                        f27_arg0.Glow:setAlpha( 0 )
                        f27_local2( f27_arg0.Glow )
                  end
            }
      }

      CoD.ZMScr_PlusPoints.__onClose = function ( f39_arg0 )
            f39_arg0.Label2:close()
            f39_arg0.Label1:close()
            f39_arg0.Glow:close()
      end

      CoD.AmmoWidgetZM_Specialist = InheritFrom( LUI.UIElement )
      CoD.AmmoWidgetZM_Specialist.__defaultWidth = 103
      CoD.AmmoWidgetZM_Specialist.__defaultHeight = 103
      CoD.AmmoWidgetZM_Specialist.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            CoD.BaseUtility.InitControllerModel( f1_arg1, "hudItems.healingActive", false )
            self:setClass( CoD.AmmoWidgetZM_Specialist )
            self.id = "AmmoWidgetZM_Specialist"
            self.soundSet = "default"
            self.anyChildUsesUpdateState = true
            
            local CharacterPortrait = CoD.AmmoWidgetZM_CharacterPortrait.new( f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0 )
            --CharacterPortrait:setRFTMaterial( LUI.UIImage.GetCachedMaterial( @"hash_2D79DB5C45AD6024" ) )
            CharacterPortrait:setShaderVector( 0, 34, 16, 0, 0 )
            CharacterPortrait:setShaderVector( 1, 100, 100, 0, 0 )
            CharacterPortrait:setShaderVector( 2, 0, 0, 0, 0 )
            CharacterPortrait:linkToElementModel( self, "clientModel", true, function ( model )
                  local f2_local0 = model:get()
                  if f2_local0 ~= nil then
                        CharacterPortrait:setModel( f2_local0, f1_arg1 )
                  end
            end )
            self:addElement( CharacterPortrait )
            self.CharacterPortrait = CharacterPortrait
            
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then    
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            return self
      end
     
      CoD.AmmoWidgetZM_Specialist.__onClose = function ( f3_arg0 )
            f3_arg0.CharacterPortrait:close()
      end

      CoD.ZM_SelfReviveCounter = InheritFrom( LUI.UIElement )
      CoD.ZM_SelfReviveCounter.__defaultWidth = 85
      CoD.ZM_SelfReviveCounter.__defaultHeight = 45
      CoD.ZM_SelfReviveCounter.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            CoD.BaseUtility.InitControllerModelIfNotSet( f1_arg1, "ZMInventoryPersonal.self_revive_count", 0 )
            self:setClass( CoD.ZM_SelfReviveCounter )
            self.id = "ZM_SelfReviveCounter"
            self.soundSet = "none"
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            local Backer = LUI.UIImage.new( 0, 0, 13 - 25, 77 - 25, 0, 0, -9.5, 54.5 )
            Backer:setImage( RegisterImage( @"uie_t7_core_hud_mapwidget_panelglow" ) )
            Backer:setAlpha(0.85)
            Backer:setRGB(0, 0, 0)
            self:addElement( Backer )
            self.Backer = Backer

            local HealthIcon = LUI.UIImage.new( 0, 0, 0 - 25, 45 - 25, 0, 0, 0, 45 )
            HealthIcon:setAlpha( 0 )
            HealthIcon:setImage( RegisterImage( @"hash_677AEC1394EC7604" ) )
            self:addElement( HealthIcon )
            self.HealthIcon = HealthIcon
            
            local ReviveCount = LUI.UIText.new( 0.00, 0.00, 0.00, 40.00, 0.00, 0.00, -5.00, 42.00 )
            ReviveCount:setTTF( "notosans_bold" )
            ReviveCount:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_90D57B1E92D39D7" ) )
            ReviveCount:setShaderVector( 0, 0.4, 0, 0, 0 )
            ReviveCount:setShaderVector( 1, 0.1, 0, 0, 0 )
            ReviveCount:setShaderVector( 2, 0, 0, 0, 0.8 )
            ReviveCount:setScale(0.75, 0.75)
            ReviveCount:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            ReviveCount:subscribeToGlobalModel( f1_arg1, "ZMInventoryPersonal", "self_revive_count", function ( model )
                  local f2_local0 = model:get()
                  if f2_local0 ~= nil then
                        ReviveCount:setText( f2_local0 )
                  end
            end )
            self:addElement( ReviveCount )
            self.ReviveCount = ReviveCount

            self:mergeStateConditions( {
                  {
                        stateName = "Visible",
                        condition = function ( menu, element, event )
                              return CoD.ModelUtility.IsModelValueGreaterThan( f1_arg1, "ZMInventoryPersonal.self_revive_count", 0 )
                        end
                  }
            } )
            local f1_local4 = self
            local f1_local5 = self.subscribeToModel
            local f1_local6 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local5( f1_local4, f1_local6["ZMInventoryPersonal.self_revive_count"], function ( f4_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f4_arg0:get(),
                        modelName = "ZMInventoryPersonal.self_revive_count"
                  } )
            end, false )
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            return self
      end

      CoD.ZM_SelfReviveCounter.__resetProperties = function ( f5_arg0 )
            f5_arg0.HealthIcon:completeAnimation()
            f5_arg0.ReviveCount:completeAnimation()
            f5_arg0.Backer:completeAnimation()
            f5_arg0.HealthIcon:setAlpha( 0 )
            f5_arg0.ReviveCount:setAlpha( 1 )
            f5_arg0.Backer:setAlpha( 0.85 )
      end

      CoD.ZM_SelfReviveCounter.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f6_arg0, f6_arg1 )
                        f6_arg0:__resetProperties()
                        f6_arg0:setupElementClipCounter( 3 )
                        f6_arg0.Backer:completeAnimation()
                        f6_arg0.Backer:setAlpha( 0 )
                        f6_arg0.clipFinished( f6_arg0.Backer )
                        f6_arg0.HealthIcon:completeAnimation()
                        f6_arg0.HealthIcon:setAlpha( 0 )
                        f6_arg0.clipFinished( f6_arg0.HealthIcon )
                        f6_arg0.ReviveCount:completeAnimation()
                        f6_arg0.ReviveCount:setAlpha( 0 )
                        f6_arg0.clipFinished( f6_arg0.ReviveCount )
                  end
            },
            Visible = {
                  DefaultClip = function ( f7_arg0, f7_arg1 )
                        f7_arg0:__resetProperties()
                        f7_arg0:setupElementClipCounter( 0 )
                  end
            }
      }

      CoD.ZM_SelfReviveCounter.__onClose = function ( f8_arg0 )
            f8_arg0.ReviveCount:close()
      end

      CoD.AmmoWidgetZM_CharacterPortrait = InheritFrom( LUI.UIElement )
      CoD.AmmoWidgetZM_CharacterPortrait.__defaultWidth = 103
      CoD.AmmoWidgetZM_CharacterPortrait.__defaultHeight = 103
      CoD.AmmoWidgetZM_CharacterPortrait.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.AmmoWidgetZM_CharacterPortrait )
            self.id = "AmmoWidgetZM_CharacterPortrait"
            self.soundSet = "none"
            f1_arg0:addElementToPendingUpdateStateList( self )

            -- add outline for player char
            local FrameOutline = LUI.UIImage.new( 1.00, 1.00, -11.00, -138.00, 0.50, 0.50, -52.00, 50.00 )
            FrameOutline:setImage( RegisterImage( @"glow_classic" ) )
            FrameOutline:setRGB(1, 0, 0)
            FrameOutline:setAlpha(1)

            local StoryID = CoD.ZMStoryUtility.GetCurrentMapStory()

            if StoryID == 1 then
                  FrameOutline:setRGB(1, 1, 0)
            else
                  FrameOutline:setRGB(0.3, 0.7, 1)

                  if Engine[@"lobbygetmap"]() == "zm_office" then
                        FrameOutline:setRGB(1, 0, 0)
                  end
            end

            self:addElement(FrameOutline)
            self.FrameOutline = FrameOutline

            local Old_Portrait = nil
            local Normal = LUI.UIImage.new( 0, 1, 0, 0, 0.14, 0.86, 0, 0 )
            Normal:linkToElementModel( self, "characterIndex", true, function ( model )
                  local f2_local0 = model:get()
                  if f2_local0 ~= nil then
                        Old_Portrait = GetPositionDraftStatePortraitByIndex( CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_NORMAL, f2_local0 )
                        Normal:setImage( RegisterImage( GetPositionDraftStatePortraitByIndex( CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_NORMAL, f2_local0 ) ) )
                  end
            end )
            self:addElement( Normal )
            self.Normal = Normal
            
            Normal:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
                  if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"notify_custom_portrait" ) then
                        local scriptData = CoD.GetScriptNotifyData(model)
                        local ImageID = scriptData[1]

                        local ImageTable = {
                              [0] = nil,
                              [1] = @"eye_prot"
                        }

                        if ImageTable[ImageID] then
                              Normal:setImage( RegisterImage( ImageTable[ImageID] ) )
                        elseif Old_Portrait then
                              Normal:setImage( RegisterImage( Old_Portrait ) ) -- restore
                        end
                  end
            end)
            
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            local f1_local2 = self
            CoD.HUDUtility.SetupCharacterPortrait( self, f1_arg1 )
            return self
      end

      CoD.AmmoWidgetZM_CharacterPortrait.__resetProperties = function ( f3_arg0 )
            f3_arg0.Normal:completeAnimation()
            f3_arg0.Normal:setAlpha( 1 )
      end

      CoD.AmmoWidgetZM_CharacterPortrait.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f4_arg0, f4_arg1 )
                        f4_arg0:__resetProperties()
                        f4_arg0:setupElementClipCounter( 1 )
                        f4_arg0.Normal:completeAnimation()
                        f4_arg0.Normal:setAlpha( 1 )
                        f4_arg0.clipFinished( f4_arg0.Normal )
                  end
            }
      }

      CoD.AmmoWidgetZM_CharacterPortrait.__onClose = function ( f5_arg0 )
            f5_arg0.Normal:close()
            f5_arg0.FrameOutline:close()
      end

      CoD.ZMScr = InheritFrom( LUI.UIElement )
      CoD.ZMScr.__defaultWidth = 201
      CoD.ZMScr.__defaultHeight = 300
      CoD.ZMScr.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            CoD.HUDUtility.ZMScrPreLoad( self, f1_arg1 )
            self:setClass( CoD.ZMScr )
            self.id = "ZMScr"
            self.soundSet = "HUD"
            self.anyChildUsesUpdateState = true
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            local Listing2 = CoD.ZMScr_ListingSm.new( f1_arg0, f1_arg1, 0, 0, 24, 152, 0, 0, 188, 276 )
            Listing2:subscribeToGlobalModel( f1_arg1, "PlayerListZM", "1", function ( model )
                  Listing2:setModel( model, f1_arg1 )
            end )
            self:addElement( Listing2 )
            self.Listing2 = Listing2
            
            local Listing3 = CoD.ZMScr_ListingSm.new( f1_arg0, f1_arg1, 0, 0, 24, 152, 0, 0, 104, 192 )
            Listing3:subscribeToGlobalModel( f1_arg1, "PlayerListZM", "2", function ( model )
                  Listing3:setModel( model, f1_arg1 )
            end )
            self:addElement( Listing3 )
            self.Listing3 = Listing3
            
            local Listing4 = CoD.ZMScr_ListingSm.new( f1_arg0, f1_arg1, 0, 0, 24, 152, 0, 0, 20, 108 )
            Listing4:subscribeToGlobalModel( f1_arg1, "PlayerListZM", "3", function ( model )
                  Listing4:setModel( model, f1_arg1 )
            end )
            self:addElement( Listing4 )
            self.Listing4 = Listing4
            
            local ZMScrPlusPoints0 = CoD.ZMScr_PlusPointsContainer.new( f1_arg0, f1_arg1, 0, 0, 200, 365, 0, 0, 195, 300 )
            ZMScrPlusPoints0:setScale( 0.75, 0.75 )
            self:addElement( ZMScrPlusPoints0 )
            self.ZMScrPlusPoints0 = ZMScrPlusPoints0

            local ZMScrPlusPoints1 = CoD.ZMScr_PlusPointsContainer.new( f1_arg0, f1_arg1, 0, 0, 130, 258, 0, 0, 184, 283 )
            ZMScrPlusPoints1:setScale( 0.75, 0.75 )
            ZMScrPlusPoints1:subscribeToGlobalModel( f1_arg1, "PlayerListZM", "1", function ( model )
                  ZMScrPlusPoints1:setModel( model, f1_arg1 )
            end )
            self:addElement( ZMScrPlusPoints1 )
            self.ZMScrPlusPoints1 = ZMScrPlusPoints1
            
            local ZMScrPlusPoints2 = CoD.ZMScr_PlusPointsContainer.new( f1_arg0, f1_arg1, 0, 0, 130, 258, 0, 0, 100.5, 199.5 )
            ZMScrPlusPoints2:setScale( 0.75, 0.75 )
            ZMScrPlusPoints2:subscribeToGlobalModel( f1_arg1, "PlayerListZM", "2", function ( model )
                  ZMScrPlusPoints2:setModel( model, f1_arg1 )
            end )
            self:addElement( ZMScrPlusPoints2 )
            self.ZMScrPlusPoints2 = ZMScrPlusPoints2
            
            local ZMScrPlusPoints3 = CoD.ZMScr_PlusPointsContainer.new( f1_arg0, f1_arg1, 0, 0, 130, 258, 0, 0, 9, 108 )
            ZMScrPlusPoints3:setScale( 0.75, 0.75 )
            ZMScrPlusPoints3:subscribeToGlobalModel( f1_arg1, "PlayerListZM", "3", function ( model )
                  ZMScrPlusPoints3:setModel( model, f1_arg1 )
            end )
            self:addElement( ZMScrPlusPoints3 )
            self.ZMScrPlusPoints3 = ZMScrPlusPoints3
            
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end

            CoD.EnhModPrintInfo("Scorey..fes.g.ers.gh")
            
            local f1_local8 = self
            CoD.HUDUtility.ZMScrPostLoad( self, f1_arg1, f1_arg0 )
            return self
      end

      CoD.ZMScr.__resetProperties = function ( f8_arg0 )
            f8_arg0.Listing4:completeAnimation()
            f8_arg0.Listing3:completeAnimation()
            f8_arg0.Listing2:completeAnimation()
            f8_arg0.ZMScrPlusPoints0:completeAnimation()
            f8_arg0.ZMScrPlusPoints1:completeAnimation()
            f8_arg0.ZMScrPlusPoints2:completeAnimation()
            f8_arg0.ZMScrPlusPoints3:completeAnimation()
            f8_arg0.Listing4:setAlpha( 1 )
            f8_arg0.Listing3:setAlpha( 1 )
            f8_arg0.Listing2:setAlpha( 1 )
            f8_arg0.ZMScrPlusPoints0:setAlpha( 1 )
            f8_arg0.ZMScrPlusPoints1:setAlpha( 1 )
            f8_arg0.ZMScrPlusPoints2:setAlpha( 1 )
            f8_arg0.ZMScrPlusPoints3:setAlpha( 1 )
      end

      CoD.ZMScr.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f9_arg0, f9_arg1 )
                        f9_arg0:__resetProperties()
                        f9_arg0:setupElementClipCounter( 7 )
                        f9_arg0.Listing2:completeAnimation()
                        f9_arg0.Listing2:setAlpha( 0 )
                        f9_arg0.clipFinished( f9_arg0.Listing2 )
                        f9_arg0.Listing3:completeAnimation()
                        f9_arg0.Listing3:setAlpha( 0 )
                        f9_arg0.clipFinished( f9_arg0.Listing3 )
                        f9_arg0.Listing4:completeAnimation()
                        f9_arg0.Listing4:setAlpha( 0 )
                        f9_arg0.clipFinished( f9_arg0.Listing4 )
                        f9_arg0.ZMScrPlusPoints0:completeAnimation()
                        f9_arg0.ZMScrPlusPoints0:setAlpha( 0 )
                        f9_arg0.clipFinished( f9_arg0.ZMScrPlusPoints0 )
                        f9_arg0.ZMScrPlusPoints1:completeAnimation()
                        f9_arg0.ZMScrPlusPoints1:setAlpha( 0 )
                        f9_arg0.clipFinished( f9_arg0.ZMScrPlusPoints1 )
                        f9_arg0.ZMScrPlusPoints2:completeAnimation()
                        f9_arg0.ZMScrPlusPoints2:setAlpha( 0 )
                        f9_arg0.clipFinished( f9_arg0.ZMScrPlusPoints2 )
                        f9_arg0.ZMScrPlusPoints3:completeAnimation()
                        f9_arg0.ZMScrPlusPoints3:setAlpha( 0 )
                        f9_arg0.clipFinished( f9_arg0.ZMScrPlusPoints3 )
                  end,
                  HudStart = function ( f10_arg0, f10_arg1 )
                        f10_arg0:__resetProperties()
                        f10_arg0:setupElementClipCounter( 3 )
                        local f10_local0 = function ( f11_arg0 )
                              local f11_local0 = function ( f12_arg0 )
                                    f12_arg0:beginAnimation( 299, Enum[@"luitween"][@"luitween_bounce"] )
                                    f12_arg0:setAlpha( 1 )
                                    f12_arg0:registerEventHandler( "transition_complete_keyframe", f10_arg0.clipFinished )
                              end
                              
                              f10_arg0.Listing2:beginAnimation( 120 )
                              f10_arg0.Listing2:registerEventHandler( "interrupted_keyframe", f10_arg0.clipInterrupted )
                              f10_arg0.Listing2:registerEventHandler( "transition_complete_keyframe", f11_local0 )
                        end
                        
                        f10_arg0.Listing2:completeAnimation()
                        f10_arg0.Listing2:setAlpha( 0 )
                        f10_local0( f10_arg0.Listing2 )
                        local f10_local1 = function ( f13_arg0 )
                              local f13_local0 = function ( f14_arg0 )
                                    f14_arg0:beginAnimation( 300, Enum[@"luitween"][@"luitween_bounce"] )
                                    f14_arg0:setAlpha( 1 )
                                    f14_arg0:registerEventHandler( "transition_complete_keyframe", f10_arg0.clipFinished )
                              end
                              
                              f10_arg0.Listing3:beginAnimation( 240 )
                              f10_arg0.Listing3:registerEventHandler( "interrupted_keyframe", f10_arg0.clipInterrupted )
                              f10_arg0.Listing3:registerEventHandler( "transition_complete_keyframe", f13_local0 )
                        end
                        
                        f10_arg0.Listing3:completeAnimation()
                        f10_arg0.Listing3:setAlpha( 0 )
                        f10_local1( f10_arg0.Listing3 )
                        local f10_local2 = function ( f15_arg0 )
                              local f15_local0 = function ( f16_arg0 )
                                    f16_arg0:beginAnimation( 299, Enum[@"luitween"][@"luitween_bounce"] )
                                    f16_arg0:setAlpha( 1 )
                                    f16_arg0:registerEventHandler( "transition_complete_keyframe", f10_arg0.clipFinished )
                              end
                              
                              f10_arg0.Listing4:beginAnimation( 340, Enum[@"luitween"][@"luitween_bounce"] )
                              f10_arg0.Listing4:registerEventHandler( "interrupted_keyframe", f10_arg0.clipInterrupted )
                              f10_arg0.Listing4:registerEventHandler( "transition_complete_keyframe", f15_local0 )
                        end
                        
                        f10_arg0.Listing4:completeAnimation()
                        f10_arg0.Listing4:setAlpha( 0 )
                        f10_local2( f10_arg0.Listing4 )
                  end
            },
            Hidden = {
                  DefaultClip = function ( f17_arg0, f17_arg1 )
                        f17_arg0:__resetProperties()
                        f17_arg0:setupElementClipCounter( 7 )
                        f17_arg0.Listing2:completeAnimation()
                        f17_arg0.Listing2:setAlpha( 0 )
                        f17_arg0.clipFinished( f17_arg0.Listing2 )
                        f17_arg0.Listing3:completeAnimation()
                        f17_arg0.Listing3:setAlpha( 0 )
                        f17_arg0.clipFinished( f17_arg0.Listing3 )
                        f17_arg0.Listing4:completeAnimation()
                        f17_arg0.Listing4:setAlpha( 0 )
                        f17_arg0.clipFinished( f17_arg0.Listing4 )
                        f17_arg0.ZMScrPlusPoints0:completeAnimation()
                        f17_arg0.ZMScrPlusPoints0:setAlpha( 0 )
                        f17_arg0.clipFinished( f17_arg0.ZMScrPlusPoints0 )
                        f17_arg0.ZMScrPlusPoints1:completeAnimation()
                        f17_arg0.ZMScrPlusPoints1:setAlpha( 0 )
                        f17_arg0.clipFinished( f17_arg0.ZMScrPlusPoints1 )
                        f17_arg0.ZMScrPlusPoints2:completeAnimation()
                        f17_arg0.ZMScrPlusPoints2:setAlpha( 0 )
                        f17_arg0.clipFinished( f17_arg0.ZMScrPlusPoints2 )
                        f17_arg0.ZMScrPlusPoints3:completeAnimation()
                        f17_arg0.ZMScrPlusPoints3:setAlpha( 0 )
                        f17_arg0.clipFinished( f17_arg0.ZMScrPlusPoints3 )
                  end
            },
            HudStart = {
                  DefaultClip = function ( f18_arg0, f18_arg1 )
                        f18_arg0:__resetProperties()
                        f18_arg0:setupElementClipCounter( 0 )
                  end,
                  DefaultState = function ( f19_arg0, f19_arg1 )
                        f19_arg0:__resetProperties()
                        f19_arg0:setupElementClipCounter( 7 )
                        local f19_local0 = function ( f20_arg0 )
                              local f20_local0 = function ( f21_arg0 )
                                    f21_arg0:beginAnimation( 300, Enum[@"luitween"][@"luitween_bounce"] )
                                    f21_arg0:setAlpha( 0 )
                                    f21_arg0:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
                              end
                              
                              f19_arg0.Listing2:beginAnimation( 160 )
                              f19_arg0.Listing2:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
                              f19_arg0.Listing2:registerEventHandler( "transition_complete_keyframe", f20_local0 )
                        end
                        
                        f19_arg0.Listing2:completeAnimation()
                        f19_arg0.Listing2:setAlpha( 1 )
                        f19_local0( f19_arg0.Listing2 )
                        local f19_local1 = function ( f22_arg0 )
                              local f22_local0 = function ( f23_arg0 )
                                    f23_arg0:beginAnimation( 299, Enum[@"luitween"][@"luitween_bounce"] )
                                    f23_arg0:setAlpha( 0 )
                                    f23_arg0:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
                              end
                              
                              f19_arg0.Listing3:beginAnimation( 270 )
                              f19_arg0.Listing3:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
                              f19_arg0.Listing3:registerEventHandler( "transition_complete_keyframe", f22_local0 )
                        end
                        
                        f19_arg0.Listing3:completeAnimation()
                        f19_arg0.Listing3:setAlpha( 1 )
                        f19_local1( f19_arg0.Listing3 )
                        local f19_local2 = function ( f24_arg0 )
                              local f24_local0 = function ( f25_arg0 )
                                    f25_arg0:beginAnimation( 299, Enum[@"luitween"][@"luitween_bounce"] )
                                    f25_arg0:setAlpha( 0 )
                                    f25_arg0:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
                              end
                              
                              f19_arg0.Listing4:beginAnimation( 340 )
                              f19_arg0.Listing4:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
                              f19_arg0.Listing4:registerEventHandler( "transition_complete_keyframe", f24_local0 )
                        end
                        
                        f19_arg0.Listing4:completeAnimation()
                        f19_arg0.Listing4:setAlpha( 1 )
                        f19_local2( f19_arg0.Listing4 )
                        local f19_local3 = function ( f26_arg0 )
                              local f26_local0 = function ( f27_arg0 )
                                    f27_arg0:beginAnimation( 279, Enum[@"luitween"][@"luitween_bounce"] )
                                    f27_arg0:setAlpha( 0 )
                                    f27_arg0:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
                              end
                              
                              f19_arg0.ZMScrPlusPoints0:beginAnimation( 430 )
                              f19_arg0.ZMScrPlusPoints0:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
                              f19_arg0.ZMScrPlusPoints0:registerEventHandler( "transition_complete_keyframe", f26_local0 )
                        end
                        
                        f19_arg0.ZMScrPlusPoints0:completeAnimation()
                        f19_arg0.ZMScrPlusPoints0:setAlpha( 1 )
                        f19_local3( f19_arg0.ZMScrPlusPoints0 )
                        local f19_local4 = function ( f28_arg0 )
                              local f28_local0 = function ( f29_arg0 )
                                    f29_arg0:beginAnimation( 300, Enum[@"luitween"][@"luitween_bounce"] )
                                    f29_arg0:setAlpha( 0 )
                                    f29_arg0:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
                              end
                              
                              f19_arg0.ZMScrPlusPoints1:beginAnimation( 160 )
                              f19_arg0.ZMScrPlusPoints1:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
                              f19_arg0.ZMScrPlusPoints1:registerEventHandler( "transition_complete_keyframe", f28_local0 )
                        end
                        
                        f19_arg0.ZMScrPlusPoints1:completeAnimation()
                        f19_arg0.ZMScrPlusPoints1:setAlpha( 1 )
                        f19_local4( f19_arg0.ZMScrPlusPoints1 )
                        local f19_local5 = function ( f30_arg0 )
                              local f30_local0 = function ( f31_arg0 )
                                    f31_arg0:beginAnimation( 299, Enum[@"luitween"][@"luitween_bounce"] )
                                    f31_arg0:setAlpha( 0 )
                                    f31_arg0:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
                              end
                              
                              f19_arg0.ZMScrPlusPoints2:beginAnimation( 270 )
                              f19_arg0.ZMScrPlusPoints2:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
                              f19_arg0.ZMScrPlusPoints2:registerEventHandler( "transition_complete_keyframe", f30_local0 )
                        end
                        
                        f19_arg0.ZMScrPlusPoints2:completeAnimation()
                        f19_arg0.ZMScrPlusPoints2:setAlpha( 1 )
                        f19_local5( f19_arg0.ZMScrPlusPoints2 )
                        local f19_local6 = function ( f32_arg0 )
                              local f32_local0 = function ( f33_arg0 )
                                    f33_arg0:beginAnimation( 299, Enum[@"luitween"][@"luitween_bounce"] )
                                    f33_arg0:setAlpha( 0 )
                                    f33_arg0:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
                              end
                              
                              f19_arg0.ZMScrPlusPoints3:beginAnimation( 340 )
                              f19_arg0.ZMScrPlusPoints3:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
                              f19_arg0.ZMScrPlusPoints3:registerEventHandler( "transition_complete_keyframe", f32_local0 )
                        end
                        
                        f19_arg0.ZMScrPlusPoints3:completeAnimation()
                        f19_arg0.ZMScrPlusPoints3:setAlpha( 1 )
                        f19_local6( f19_arg0.ZMScrPlusPoints3 )
                  end
            }
      }

      CoD.ZMScr.__onClose = function ( f34_arg0 )
            f34_arg0.Listing2:close()
            f34_arg0.Listing3:close()
            f34_arg0.Listing4:close()
            f34_arg0.ZMScrPlusPoints0:close()
            f34_arg0.ZMScrPlusPoints1:close()
            f34_arg0.ZMScrPlusPoints2:close()
            f34_arg0.ZMScrPlusPoints3:close()
      end

      -- Cursor Hint
      CoD.ZMCursorHint = InheritFrom( LUI.UIElement )
      CoD.ZMCursorHint.__defaultWidth = 750
      CoD.ZMCursorHint.__defaultHeight = 135
      CoD.ZMCursorHint.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.ZMCursorHint )
            self.id = "ZMCursorHint"
            self.soundSet = "HUD"
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            local CursorHintText = LUI.UIText.new(0.5, 0.5, -375 - 3, 375 + 3, 0, 0, 3 - 3, 25 + 3)

            if Engine[@"getdvarint"]("shield_enh_Althud_Interaction_FontStyle") == 0 then
                  CursorHintText:setTTF( "shield_mom" )
            else
                  CursorHintText:setTTF( "notosans_bold" )
            end

            CursorHintText:setShaderVector( 0, 0, 0, 0, 0 )
            CursorHintText:setShaderVector( 1, 0.5, 0, 0, 0 )
            CursorHintText:setShaderVector( 2, 0, 0, 0, 0 )
            CursorHintText:setShaderVector( 3, 0, 0, 0, 0 )
            CursorHintText:setShaderVector( 4, 0, 0, 0, 0 )

            CursorHintText:setLetterSpacing( 0.5 )

            CursorHintText:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            CursorHintText:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )

            CursorHintText:setBackingType( 2 )
            CursorHintText:setBackingColor( 0.90, 0.90, 0.90 )
            CursorHintText:setBackingAlpha( 0.01 )
            CursorHintText:setBackingXPadding( 12 )
            CursorHintText:setBackingYPadding( 6 )

            --CursorHintText:setBackingType( 1 )
            --CursorHintText:setBackingWidget( CoD.Corner9SliceZM, f1_arg0, f1_arg1 )
            --CursorHintText:setBackingAlpha( 0.8 )
            --CursorHintText:setBackingXPadding( 40 )
            --CursorHintText:setBackingYPadding( 4 )

            CursorHintText:subscribeToGlobalModel( f1_arg1, "HUDItems", "cursorHintText", function ( model )
                  local f2_local0 = model:get()
                  if f2_local0 ~= nil then
                        CursorHintText:setText( f2_local0 )
                  end
            end )

            self:addElement( CursorHintText )
            self.CursorHintText = CursorHintText
            
            self:mergeStateConditions( {
                  {
                        stateName = "Active_NoImage",
                        condition = function ( menu, element, event )
                              local f3_local0 = IsCursorHintActive( f1_arg1 )
                              if f3_local0 then
                                    if not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"] ) and Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"] ) then
                                          f3_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo( f1_arg1, "HUDItems", "cursorHintImage", "blacktransparent" )
                                    else
                                          f3_local0 = false
                                    end
                              end
                              return f3_local0
                        end
                  },
                  {
                        stateName = "Active",
                        condition = function ( menu, element, event )
                              local f4_local0 = IsCursorHintActive( f1_arg1 )
                              if f4_local0 then
                                    if not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"] ) and Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"] ) and not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"] ) then
                                          f4_local0 = not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"] )
                                    else
                                          f4_local0 = false
                                    end
                              end
                              return f4_local0
                        end
                  }
            } )
            local f1_local2 = self
            local f1_local3 = self.subscribeToModel
            local f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["hudItems.showCursorHint"], function ( f5_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f5_arg0:get(),
                        modelName = "hudItems.showCursorHint"
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["hudItems.inventory.open"], function ( f6_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f6_arg0:get(),
                        modelName = "hudItems.inventory.open"
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"]], function ( f7_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f7_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function ( f8_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f8_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function ( f9_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f9_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function ( f10_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f10_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function ( f11_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f11_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]], function ( f12_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f12_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function ( f13_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f13_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"]], function ( f14_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f14_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function ( f15_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f15_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]], function ( f16_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f16_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"]], function ( f17_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f17_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function ( f18_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f18_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function ( f19_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f19_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = DataSources.HUDItems.getModel( f1_arg1 )
            f1_local3( f1_local2, f1_local4.cursorHintImage, function ( f20_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f20_arg0:get(),
                        modelName = "cursorHintImage"
                  } )
            end, false )
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            CoD.EnhModPrintInfo("Called", "ZM Cursor Hint")
           -- self:setRGB(0, 1, 1)

            return self
      end
      
      CoD.ZMCursorHint.__resetProperties = function ( f21_arg0 )
            f21_arg0.CursorHintText:completeAnimation()
            f21_arg0.CursorHintText:setAlpha( 1 )
      end
      
      CoD.ZMCursorHint.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f22_arg0, f22_arg1 )
                        f22_arg0:__resetProperties()
                        f22_arg0:setupElementClipCounter( 1 )
                        f22_arg0.CursorHintText:completeAnimation()
                        f22_arg0.CursorHintText:setAlpha( 0 )
                        f22_arg0.clipFinished( f22_arg0.CursorHintText )
                  end
            },
            Active_NoImage = {
                  DefaultClip = function ( f23_arg0, f23_arg1 )
                        f23_arg0:__resetProperties()
                        f23_arg0:setupElementClipCounter( 1 )
                        local f23_local0 = function ( f24_arg0 )
                              f23_arg0.CursorHintText:beginAnimation( 300 )
                              f23_arg0.CursorHintText:setAlpha( 1 )
                              f23_arg0.CursorHintText:registerEventHandler( "interrupted_keyframe", f23_arg0.clipInterrupted )
                              f23_arg0.CursorHintText:registerEventHandler( "transition_complete_keyframe", f23_arg0.clipFinished )
                        end
                        
                        f23_arg0.CursorHintText:completeAnimation()
                        f23_arg0.CursorHintText:setAlpha( 0 )
                        f23_local0( f23_arg0.CursorHintText )
                  end
            },
            Active = {
                  DefaultClip = function ( f25_arg0, f25_arg1 )
                        f25_arg0:__resetProperties()
                        f25_arg0:setupElementClipCounter( 1 )
                        local f25_local0 = function ( f26_arg0 )
                              f25_arg0.CursorHintText:beginAnimation( 300 )
                              f25_arg0.CursorHintText:setAlpha( 1 )
                              f25_arg0.CursorHintText:registerEventHandler( "interrupted_keyframe", f25_arg0.clipInterrupted )
                              f25_arg0.CursorHintText:registerEventHandler( "transition_complete_keyframe", f25_arg0.clipFinished )
                        end
                        
                        f25_arg0.CursorHintText:completeAnimation()
                        f25_arg0.CursorHintText:setAlpha( 0 )
                        f25_local0( f25_arg0.CursorHintText )
                  end
            }
      }

      CoD.ZMCursorHint.__onClose = function ( f27_arg0 )
            f27_arg0.CursorHintText:close()
      end

      -- Main Subtitles
      CoD.SubtitlesContainer = InheritFrom( LUI.UIElement )
      CoD.SubtitlesContainer.__defaultWidth = 1110
      CoD.SubtitlesContainer.__defaultHeight = 147
      CoD.SubtitlesContainer.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.SubtitlesContainer )
            self.id = "SubtitlesContainer"
            self.soundSet = "HUD"
            
            local SubtitleEntry0 = CoD.SubtitleEntryContainer.new( f1_arg0, f1_arg1, 0, 0, 0, 1110, 1, 1, -30, 0 )
            SubtitleEntry0:subscribeToGlobalModel( f1_arg1, "HUDItems", "subtitles.line0", function ( model )
                  SubtitleEntry0:setModel( model, f1_arg1 )
            end )
            self:addElement( SubtitleEntry0 )
            self.SubtitleEntry0 = SubtitleEntry0
            
            local SubtitleEntry1 = CoD.SubtitleEntryContainer.new( f1_arg0, f1_arg1, 0, 0, 0, 1110, 1, 1, -30, 0 )
            SubtitleEntry1:subscribeToGlobalModel( f1_arg1, "HUDItems", "subtitles.line1", function ( model )
                  SubtitleEntry1:setModel( model, f1_arg1 )
            end )
            self:addElement( SubtitleEntry1 )
            self.SubtitleEntry1 = SubtitleEntry1
            
            local SubtitleEntry2 = CoD.SubtitleEntryContainer.new( f1_arg0, f1_arg1, 0, 0, 0, 1110, 1, 1, -30, 0 )
            SubtitleEntry2:subscribeToGlobalModel( f1_arg1, "HUDItems", "subtitles.line2", function ( model )
                  SubtitleEntry2:setModel( model, f1_arg1 )
            end )
            self:addElement( SubtitleEntry2 )
            self.SubtitleEntry2 = SubtitleEntry2
            
            local SubtitleEntry3 = CoD.SubtitleEntryContainer.new( f1_arg0, f1_arg1, 0, 0, 0, 1110, 1, 1, -30, 0 )
            SubtitleEntry3:subscribeToGlobalModel( f1_arg1, "HUDItems", "subtitles.line3", function ( model )
                  SubtitleEntry3:setModel( model, f1_arg1 )
            end )
            self:addElement( SubtitleEntry3 )
            self.SubtitleEntry3 = SubtitleEntry3
            
            local SubtitleEntry4 = CoD.SubtitleEntryContainer.new( f1_arg0, f1_arg1, 0, 0, 0, 1110, 1, 1, -30, 0 )
            SubtitleEntry4:subscribeToGlobalModel( f1_arg1, "HUDItems", "subtitles.line4", function ( model )
                  SubtitleEntry4:setModel( model, f1_arg1 )
            end )
            self:addElement( SubtitleEntry4 )
            self.SubtitleEntry4 = SubtitleEntry4
            
            local SubtitleEntry5 = CoD.SubtitleEntryContainer.new( f1_arg0, f1_arg1, 0, 0, 0, 1110, 1, 1, -30, 0 )
            SubtitleEntry5:subscribeToGlobalModel( f1_arg1, "HUDItems", "subtitles.line5", function ( model )
                  SubtitleEntry5:setModel( model, f1_arg1 )
            end )
            self:addElement( SubtitleEntry5 )
            self.SubtitleEntry5 = SubtitleEntry5
            
            local SubtitleEntry6 = CoD.SubtitleEntryContainer.new( f1_arg0, f1_arg1, 0, 0, 0, 1110, 1, 1, -30, 0 )
            SubtitleEntry6:subscribeToGlobalModel( f1_arg1, "HUDItems", "subtitles.line6", function ( model )
                  SubtitleEntry6:setModel( model, f1_arg1 )
            end )
            self:addElement( SubtitleEntry6 )
            self.SubtitleEntry6 = SubtitleEntry6
            
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            if Engine[@"getdvarint"]("shield_enh_Subtitles_Color") == 0 then
                  self:setRGB(0, 1, 1)
            end
            
            local f1_local8 = self
            CoD.SubtitleUtility.Init( self, f1_arg1, "subtitles", nil )
            
            return self
      end
      
      CoD.SubtitlesContainer.__onClose = function ( f9_arg0 )
            f9_arg0.SubtitleEntry0:close()
            f9_arg0.SubtitleEntry1:close()
            f9_arg0.SubtitleEntry2:close()
            f9_arg0.SubtitleEntry3:close()
            f9_arg0.SubtitleEntry4:close()
            f9_arg0.SubtitleEntry5:close()
            f9_arg0.SubtitleEntry6:close()
      end  
      
      -- Main Subtitles Entry
      CoD.SubtitleEntry = InheritFrom( LUI.UIElement )
      CoD.SubtitleEntry.__defaultWidth = 1110
      CoD.SubtitleEntry.__defaultHeight = 33
      CoD.SubtitleEntry.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.SubtitleEntry )
            self.id = "SubtitleEntry"
            self.soundSet = "HUD"
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            local glow = LUI.UIText.new( 0, 0, 0, 1110, 0, 0, 0, 33 )
            glow:setRGB( 0, 0, 0 )
            glow:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_2AE166D9BA8C6907" ) )
            glow:setShaderVector( 0, 0.4, 0, 0, 0 )
            glow:setShaderVector( 1, -0.7, 0, 0, 0 )
            glow:setShaderVector( 2, 1, 0, 0, 0 )
            glow:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            glow:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
            glow:linkToElementModel( self, "text", true, function ( model )
                  local f2_local0 = model:get()
                  if f2_local0 ~= nil then
                        glow:setText( f2_local0 )
                  end
            end )
            self:addElement( glow )
            self.glow = glow
            
            local TextBox = LUI.UIText.new( 0, 0, 0, 1110, 0, 0, 0, 33 )
            TextBox:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_2AE166D9BA8C6907" ) )
            TextBox:setShaderVector( 0, 0, 0, 0, 0 )
            TextBox:setShaderVector( 1, 0, 0, 0, 0 )
            TextBox:setShaderVector( 2, 1, 0, 0, 0 )
            TextBox:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            TextBox:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
            TextBox:linkToElementModel( self, "text", true, function ( model )
                  local f3_local0 = model:get()
                  if f3_local0 ~= nil then
                        TextBox:setText( f3_local0 )
                  end
            end )
            LUI.OverrideFunction_CallOriginalFirst( TextBox, "setText", function ( element, controller )
                  UpdateWidgetHeightToMultilineText( self, element, 5 )
            end )
            self:addElement( TextBox )
            self.TextBox = TextBox
            
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end

            if Engine[@"getdvarint"]("shield_enh_Subtitles_FontStyle") == 0 then
                  TextBox:setTTF( "shield_mom" )
                  glow:setTTF( "shield_mom" )
            else
                  TextBox:setTTF( "notosans_bold" )
                  glow:setTTF( "notosans_bold" )
            end
            
            return self
      end
      
      CoD.SubtitleEntry.__resetProperties = function ( f5_arg0 )
            f5_arg0.TextBox:completeAnimation()
            f5_arg0.glow:completeAnimation()
            f5_arg0.TextBox:setAlpha( 1 )
            f5_arg0.glow:setAlpha( 1 )
      end
      
      CoD.SubtitleEntry.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f6_arg0, f6_arg1 )
                        f6_arg0:__resetProperties()
                        f6_arg0:setupElementClipCounter( 0 )
                  end,
                  FadeOut = function ( f7_arg0, f7_arg1 )
                        f7_arg0:__resetProperties()
                        f7_arg0:setupElementClipCounter( 2 )
                        local f7_local0 = function ( f8_arg0 )
                              f7_arg0.glow:beginAnimation( 280, Enum[@"luitween"][@"luitween_bounce"] )
                              f7_arg0.glow:setAlpha( 0 )
                              f7_arg0.glow:registerEventHandler( "interrupted_keyframe", f7_arg0.clipInterrupted )
                              f7_arg0.glow:registerEventHandler( "transition_complete_keyframe", f7_arg0.clipFinished )
                        end
                        
                        f7_arg0.glow:completeAnimation()
                        f7_arg0.glow:setAlpha( 1 )
                        f7_local0( f7_arg0.glow )
                        local f7_local1 = function ( f9_arg0 )
                              f7_arg0.TextBox:beginAnimation( 280, Enum[@"luitween"][@"luitween_bounce"] )
                              f7_arg0.TextBox:setAlpha( 0 )
                              f7_arg0.TextBox:registerEventHandler( "interrupted_keyframe", f7_arg0.clipInterrupted )
                              f7_arg0.TextBox:registerEventHandler( "transition_complete_keyframe", f7_arg0.clipFinished )
                        end
                        
                        f7_arg0.TextBox:completeAnimation()
                        f7_arg0.TextBox:setAlpha( 1 )
                        f7_local1( f7_arg0.TextBox )
                  end,
                  FadeIn = function ( f10_arg0, f10_arg1 )
                        f10_arg0:__resetProperties()
                        f10_arg0:setupElementClipCounter( 2 )
                        local f10_local0 = function ( f11_arg0 )
                              f10_arg0.glow:beginAnimation( 200, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_both"] )
                              f10_arg0.glow:setAlpha( 1 )
                              f10_arg0.glow:registerEventHandler( "interrupted_keyframe", f10_arg0.clipInterrupted )
                              f10_arg0.glow:registerEventHandler( "transition_complete_keyframe", f10_arg0.clipFinished )
                        end
                        
                        f10_arg0.glow:completeAnimation()
                        f10_arg0.glow:setAlpha( 0 )
                        f10_local0( f10_arg0.glow )
                        local f10_local1 = function ( f12_arg0 )
                              f10_arg0.TextBox:beginAnimation( 200, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_both"] )
                              f10_arg0.TextBox:setAlpha( 1 )
                              f10_arg0.TextBox:registerEventHandler( "interrupted_keyframe", f10_arg0.clipInterrupted )
                              f10_arg0.TextBox:registerEventHandler( "transition_complete_keyframe", f10_arg0.clipFinished )
                        end
                        
                        f10_arg0.TextBox:completeAnimation()
                        f10_arg0.TextBox:setAlpha( 0 )
                        f10_local1( f10_arg0.TextBox )
                  end,
                  Hide = function ( f13_arg0, f13_arg1 )
                        f13_arg0:__resetProperties()
                        f13_arg0:setupElementClipCounter( 2 )
                        f13_arg0.glow:completeAnimation()
                        f13_arg0.glow:setAlpha( 0 )
                        f13_arg0.clipFinished( f13_arg0.glow )
                        f13_arg0.TextBox:completeAnimation()
                        f13_arg0.TextBox:setAlpha( 1 )
                        f13_arg0.clipFinished( f13_arg0.TextBox )
                  end
            }
      }

      CoD.SubtitleEntry.__onClose = function ( f14_arg0 )
            f14_arg0.glow:close()
            f14_arg0.TextBox:close()
      end

      -- Self Revive Widget
      CoD.self_revive_visuals = InheritFrom( CoD.Menu )
      LUI.createMenu.self_revive_visuals = function ( f1_arg0, f1_arg1 )
            local self = CoD.Menu.NewForUIEditor( "self_revive_visuals", f1_arg0 )
            local f1_local1 = self
            self:setClass( CoD.self_revive_visuals )
            self.soundSet = "none"
            self:setOwner( f1_arg0 )
            self:setLeftRight( 0, 1, 0, 0 )
            self:setTopBottom( 0, 1, 0, 0 )
            self:playSound( "menu_open", f1_arg0 )
            self.ignoreCursor = true
            f1_local1:addElementToPendingUpdateStateList( self )
            
            local self_revive_progress_bar_fill = LUI.UIImage.new( 0.5, 0.5, -348, 348, 0.435, 0.435, 52.5, 86.5 ) -- changed
            self_revive_progress_bar_fill:setRGB( 0, 0.45, 1 )
            self_revive_progress_bar_fill:setImage( RegisterImage( @"uie_progress_bar_background" ) )
            self_revive_progress_bar_fill:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_wipe_normal" ) )
            self_revive_progress_bar_fill:setShaderVector( 1, 0, 0, 0, 0 )
            self_revive_progress_bar_fill:setShaderVector( 2, 1, 0, 0, 0 )
            self_revive_progress_bar_fill:setShaderVector( 3, 0, 0, 0, 0 )
            self_revive_progress_bar_fill:setShaderVector( 4, 0, 0, 0, 0 )
            self_revive_progress_bar_fill:linkToElementModel( self, "revive_progress", true, function ( model )
                  local f2_local0 = model:get()
                  if f2_local0 ~= nil then
                        self_revive_progress_bar_fill:setShaderVector( 0, CoD.GetVectorComponentFromString( f2_local0, 1 ), CoD.GetVectorComponentFromString( f2_local0, 2 ), CoD.GetVectorComponentFromString( f2_local0, 3 ), CoD.GetVectorComponentFromString( f2_local0, 4 ) )
                  end
            end )
            self:addElement( self_revive_progress_bar_fill )
            self.self_revive_progress_bar_fill = self_revive_progress_bar_fill
            
            local self_revive_progress_text = LUI.UIText.new( 0.5, 0.5, -218.5, 218.5, 0.5, 0.5, 15.5, 52.5 )
            self_revive_progress_text:setText( "^2" .. Engine[@"hash_4F9F1239CFD921FE"]( @"hash_3923A71AA4A500E1" ) .. "!" )
            self_revive_progress_text:setTTF( "notosans_bold" )
            self_revive_progress_text:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            self_revive_progress_text:setAlignment( Enum[@"luialignment"][@"lui_alignment_bottom"] )
            self:addElement( self_revive_progress_text )
            self.self_revive_progress_text = self_revive_progress_text
            
            self:mergeStateConditions( {
                  {
                        stateName = "Hidden",
                        condition = function ( menu, element, event )
                              local f3_local0 = Engine[@"isvisibilitybitset"]( f1_arg0, Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"] )
                              if not f3_local0 then
                                    f3_local0 = Engine[@"isvisibilitybitset"]( f1_arg0, Enum[@"uivisibilitybit"][@"bit_spectating_client"] )
                                    if not f3_local0 then
                                          f3_local0 = Engine[@"isvisibilitybitset"]( f1_arg0, Enum[@"uivisibilitybit"][@"bit_ui_active"] )
                                    end
                              end
                              return f3_local0
                        end
                  }
            } )
            local f1_local4 = self
            local f1_local5 = self.subscribeToModel
            local f1_local6 = Engine[@"getmodelforcontroller"]( f1_arg0 )
            f1_local5( f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function ( f4_arg0 )
                  f1_local1:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_local1,
                        controller = f1_arg0,
                        modelValue = f4_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]
                  } )
            end, false )
            f1_local4 = self
            f1_local5 = self.subscribeToModel
            f1_local6 = Engine[@"getmodelforcontroller"]( f1_arg0 )
            f1_local5( f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function ( f5_arg0 )
                  f1_local1:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_local1,
                        controller = f1_arg0,
                        modelValue = f5_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]
                  } )
            end, false )
            f1_local4 = self
            f1_local5 = self.subscribeToModel
            f1_local6 = Engine[@"getmodelforcontroller"]( f1_arg0 )
            f1_local5( f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function ( f6_arg0 )
                  f1_local1:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_local1,
                        controller = f1_arg0,
                        modelValue = f6_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]
                  } )
            end, false )
            self:processEvent( {
                  name = "menu_loaded",
                  controller = f1_arg0
            } )
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg0 )
            end
            
            self:setRGB(0, 1, 1)

            return self
      end
      
      CoD.self_revive_visuals.__resetProperties = function ( f7_arg0 )
            f7_arg0.self_revive_progress_text:completeAnimation()
            f7_arg0.self_revive_progress_bar_fill:completeAnimation()
            f7_arg0.self_revive_progress_text:setAlpha( 1 )
            f7_arg0.self_revive_progress_bar_fill:setAlpha( 1 )
      end
      
      CoD.self_revive_visuals.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f8_arg0, f8_arg1 )
                        f8_arg0:__resetProperties()
                        f8_arg0:setupElementClipCounter( 0 )
                  end
            },
            Hidden = {
                  DefaultClip = function ( f9_arg0, f9_arg1 )
                        f9_arg0:__resetProperties()
                        f9_arg0:setupElementClipCounter( 2 )
                        f9_arg0.self_revive_progress_bar_fill:completeAnimation()
                        f9_arg0.self_revive_progress_bar_fill:setAlpha( 0 )
                        f9_arg0.clipFinished( f9_arg0.self_revive_progress_bar_fill )
                        f9_arg0.self_revive_progress_text:completeAnimation()
                        f9_arg0.self_revive_progress_text:setAlpha( 0 )
                        f9_arg0.clipFinished( f9_arg0.self_revive_progress_text )
                  end
            }
      }

      CoD.self_revive_visuals.__onClose = function ( f10_arg0 )
            f10_arg0.self_revive_progress_bar_fill:close()
      end

      -- replace another perk shit
      CoD.ZMPerkVaporCooldownPulse = InheritFrom( LUI.UIElement )
      CoD.ZMPerkVaporCooldownPulse.__defaultWidth = 50
      CoD.ZMPerkVaporCooldownPulse.__defaultHeight = 50
      CoD.ZMPerkVaporCooldownPulse.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.ZMPerkVaporCooldownPulse )
            self.id = "ZMPerkVaporCooldownPulse"
            self.soundSet = "default"
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            local vaporImageActive = LUI.UIImage.new( 0, 0, 0, 50, 0, 0, 0, 50 )
            vaporImageActive:setRGB( 1, 0.95, 0.57 )
            vaporImageActive:setAlpha( 0.6 )
            vaporImageActive:setYRot( 360 )
            vaporImageActive:linkToElementModel( self, "itemIndex", true, function ( model )
                  local f2_local0 = model:get()
                  if f2_local0 ~= nil then
                        if Engine[@"getdvarint"]("shield_enh_ClassicMode") ~= 1 then
                              vaporImageActive:setImage(RegisterImage(GetItemImageFromIndex( Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f2_local0 )))
                        else
                              --vaporImageActive:setScale(0, 0)
                              --vaporImageActive:setAlpha(0)
                              --vaporImageActive:setTopBottom(9, 9, 0, 0)
                              vaporImageActive:setImage( RegisterImage( GetItemImageFromIndex( Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f2_local0 ) ) )
                        end
                  end
            end )
            self:addElement( vaporImageActive )
            self.vaporImageActive = vaporImageActive
            
            local vaporImageFull = LUI.UIImage.new( 0, 0, 0, 50, 0, 0, 0, 50 )
            vaporImageFull:setYRot( 360 )
            vaporImageFull:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_wipe_delta_normal" ) )
            vaporImageFull:setShaderVector( 0, 0, 1, 0, 0 )
            vaporImageFull:setShaderVector( 1, 0, 0, 0, 0 )
            vaporImageFull:setShaderVector( 3, 0, 0, 0, 0 )
            vaporImageFull:setShaderVector( 4, 0, 0, 0, 0 )
            vaporImageFull:linkToElementModel( self, "itemIndex", true, function ( model )
                  local f3_local0 = model:get()
                  if f3_local0 ~= nil then
                        if Engine[@"getdvarint"]("shield_enh_ClassicMode") ~= 1 then
                              vaporImageFull:setImage(RegisterImage(GetItemImageFromIndex( Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f3_local0 )))
                        else
                              vaporImageFull:setImage( RegisterImage( GetItemImageFromIndex( Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f3_local0 ) ) )
                        end
                  end
            end )
            vaporImageFull:linkToElementModel( self, "progress", true, function ( model )
                  local f4_local0 = model:get()
                  if f4_local0 ~= nil then
                        vaporImageFull:setShaderVector( 2, SetVectorComponent( 2, 1, SubtractVectorComponentFrom( 1, 1, CoD.GetVectorComponentFromString( f4_local0, 1 ), CoD.GetVectorComponentFromString( f4_local0, 2 ), CoD.GetVectorComponentFromString( f4_local0, 3 ), CoD.GetVectorComponentFromString( f4_local0, 4 ) ) ) )
                  end
            end )
            self:addElement( vaporImageFull )
            self.vaporImageFull = vaporImageFull
            
            local ElectricCherryEffect = LUI.UIImage.new( 0, 0, 0, 50, 0, 0, 0, 50 )
            ElectricCherryEffect:setAlpha( 0 )
            ElectricCherryEffect:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_A372C0731E3E2F8" ) )
            ElectricCherryEffect:setShaderVector( 0, 100, 0, 0, 0 )
            self:addElement( ElectricCherryEffect )
            self.ElectricCherryEffect = ElectricCherryEffect
            
            local ElectricBorder = LUI.UIImage.new( 0, 0, -8, 57, 0, 0, -7.5, 57.5 )
            ElectricBorder:setImage( RegisterImage( @"uie_ui_icon_perks_zm_electricburst_active" ) )
            ElectricBorder:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_flipbook_add" ) )
            ElectricBorder:setShaderVector( 0, 1, 5, 0, 0 )
            ElectricBorder:setShaderVector( 1, 10, 0, 0, 0 )
            self:addElement( ElectricBorder )
            self.ElectricBorder = ElectricBorder
            
            self:mergeStateConditions( {
                  {
                        stateName = "ElectricCherry",
                        condition = function ( menu, element, event )
                              return CoD.ModelUtility.IsSelfModelValueEqualTo( element, f1_arg1, "specialEffectActive", 1 ) and CoD.ZMPerkUtility.IsPerkSpecificItem( element, f1_arg1, @"perk_electric_cherry" )
                        end
                  },
                  {
                        stateName = "Timer",
                        condition = function ( menu, element, event )
                              return CoD.ModelUtility.IsSelfModelValueEqualTo( element, f1_arg1, "timerActive", 1 )
                        end
                  },
                  {
                        stateName = "CoolingDown",
                        condition = function ( menu, element, event )
                              return CoD.ModelUtility.IsSelfModelValueEqualToEnum( element, f1_arg1, "state", CoD.ZMPerkUtility.PerkVaporStates.COOLING_DOWN )
                        end
                  }
            } )
            self:linkToElementModel( self, "specialEffectActive", true, function ( model )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "specialEffectActive"
                  } )
            end )
            self:linkToElementModel( self, "itemIndex", true, function ( model )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "itemIndex"
                  } )
            end )
            self:linkToElementModel( self, "timerActive", true, function ( model )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "timerActive"
                  } )
            end )
            self:linkToElementModel( self, "state", true, function ( model )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "state"
                  } )
            end )
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            return self
      end
      
      CoD.ZMPerkVaporCooldownPulse.__resetProperties = function ( f12_arg0 )
            f12_arg0.ElectricCherryEffect:completeAnimation()
            f12_arg0.vaporImageActive:completeAnimation()
            f12_arg0.ElectricBorder:completeAnimation()
            f12_arg0.ElectricCherryEffect:setAlpha( 0 )
            f12_arg0.vaporImageActive:setAlpha( 0.6 )
            f12_arg0.ElectricBorder:setAlpha( 1 )
      end
      
      CoD.ZMPerkVaporCooldownPulse.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f13_arg0, f13_arg1 )
                        f13_arg0:__resetProperties()
                        f13_arg0:setupElementClipCounter( 3 )
                        f13_arg0.vaporImageActive:completeAnimation()
                        f13_arg0.vaporImageActive:setAlpha( 0 )
                        f13_arg0.clipFinished( f13_arg0.vaporImageActive )
                        f13_arg0.ElectricCherryEffect:completeAnimation()
                        f13_arg0.ElectricCherryEffect:setAlpha( 0 )
                        f13_arg0.clipFinished( f13_arg0.ElectricCherryEffect )
                        f13_arg0.ElectricBorder:completeAnimation()
                        f13_arg0.ElectricBorder:setAlpha( 0 )
                        f13_arg0.clipFinished( f13_arg0.ElectricBorder )
                  end
            },
            ElectricCherry = {
                  DefaultClip = function ( f14_arg0, f14_arg1 )
                        f14_arg0:__resetProperties()
                        f14_arg0:setupElementClipCounter( 3 )
                        f14_arg0.vaporImageActive:completeAnimation()
                        f14_arg0.vaporImageActive:setAlpha( 0,7 )
                        f14_arg0.clipFinished( f14_arg0.vaporImageActive )
                        f14_arg0.ElectricCherryEffect:completeAnimation()
                        f14_arg0.ElectricCherryEffect:setAlpha( 0 )
                        f14_arg0.clipFinished( f14_arg0.ElectricCherryEffect )
                        f14_arg0.ElectricBorder:completeAnimation()
                        f14_arg0.ElectricBorder:setAlpha( 1 )
                        f14_arg0.clipFinished( f14_arg0.ElectricBorder )
                  end
            },
            Timer = {
                  DefaultClip = function ( f15_arg0, f15_arg1 )
                        f15_arg0:__resetProperties()
                        f15_arg0:setupElementClipCounter( 3 )
                        f15_arg0.vaporImageActive:completeAnimation()
                        f15_arg0.vaporImageActive:setAlpha( 0.7 )
                        f15_arg0.clipFinished( f15_arg0.vaporImageActive )
                        f15_arg0.ElectricCherryEffect:completeAnimation()
                        f15_arg0.ElectricCherryEffect:setAlpha( 0 )
                        f15_arg0.clipFinished( f15_arg0.ElectricCherryEffect )
                        f15_arg0.ElectricBorder:completeAnimation()
                        f15_arg0.ElectricBorder:setAlpha( 0 )
                        f15_arg0.clipFinished( f15_arg0.ElectricBorder )
                  end
            },
            CoolingDown = {
                  DefaultClip = function ( f16_arg0, f16_arg1 )
                        f16_arg0:__resetProperties()
                        f16_arg0:setupElementClipCounter( 3 )
                        f16_arg0.vaporImageActive:completeAnimation()
                        f16_arg0.vaporImageActive:setAlpha( 0 )
                        f16_arg0.clipFinished( f16_arg0.vaporImageActive )
                        f16_arg0.ElectricCherryEffect:completeAnimation()
                        f16_arg0.ElectricCherryEffect:setAlpha( 0 )
                        f16_arg0.clipFinished( f16_arg0.ElectricCherryEffect )
                        f16_arg0.ElectricBorder:completeAnimation()
                        f16_arg0.ElectricBorder:setAlpha( 0 )
                        f16_arg0.clipFinished( f16_arg0.ElectricBorder )
                  end
            }
      }

      CoD.ZMPerkVaporCooldownPulse.__onClose = function ( f17_arg0 )
            f17_arg0.vaporImageActive:close()
            f17_arg0.vaporImageFull:close()
      end

      CoD.ZMPerkVaporPhDSliderEffect = InheritFrom( LUI.UIElement )
      CoD.ZMPerkVaporPhDSliderEffect.__defaultWidth = 50
      CoD.ZMPerkVaporPhDSliderEffect.__defaultHeight = 50
      CoD.ZMPerkVaporPhDSliderEffect.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.ZMPerkVaporPhDSliderEffect )
            self.id = "ZMPerkVaporPhDSliderEffect"
            self.soundSet = "default"
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            local PhDSliderEffect = LUI.UIImage.new( 0, 0, 0, 50, 0, 0, 0, 50 )
            PhDSliderEffect:setAlpha( 0 )
            PhDSliderEffect:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_31CC85D0A86303B0" ) )
            PhDSliderEffect:setShaderVector( 0, 3, 0, 0, 0 )
            PhDSliderEffect:linkToElementModel( self, "itemIndex", true, function ( model )
                  local f2_local0 = model:get()
                  if f2_local0 ~= nil then
                        if Engine[@"getdvarint"]("shield_enh_ClassicMode") ~= 1 then
                              PhDSliderEffect:setImage(RegisterImage(GetItemImageFromIndex( Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f2_local0 )))
                        else
                              PhDSliderEffect:setImage( RegisterImage( GetItemImageFromIndex( Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f2_local0 ) ) )
                        end
                  end
            end )
            self:addElement( PhDSliderEffect )
            self.PhDSliderEffect = PhDSliderEffect
            
            self:mergeStateConditions( {
                  {
                        stateName = "Ready",
                        condition = function ( menu, element, event )
                              return CoD.ModelUtility.IsSelfModelValueEqualTo( element, f1_arg1, "specialEffectActive", 1 ) and CoD.ZMPerkUtility.IsPerkSpecificItem( element, f1_arg1, @"perk_slider" )
                        end
                  }
            } )
            self:linkToElementModel( self, "specialEffectActive", true, function ( model )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "specialEffectActive"
                  } )
            end )
            self:linkToElementModel( self, "itemIndex", true, function ( model )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "itemIndex"
                  } )
            end )
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            return self
      end
      
      CoD.ZMPerkVaporPhDSliderEffect.__resetProperties = function ( f6_arg0 )
            f6_arg0.PhDSliderEffect:completeAnimation()
            f6_arg0.PhDSliderEffect:setAlpha( 0 )
      end
      
      CoD.ZMPerkVaporPhDSliderEffect.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f7_arg0, f7_arg1 )
                        f7_arg0:__resetProperties()
                        f7_arg0:setupElementClipCounter( 0 )
                  end
            },
            Ready = {
                  DefaultClip = function ( f8_arg0, f8_arg1 )
                        f8_arg0:__resetProperties()
                        f8_arg0:setupElementClipCounter( 1 )
                        local f8_local0 = function ( f9_arg0 )
                              local f9_local0 = function ( f10_arg0 )
                                    f10_arg0:beginAnimation( 310 )
                                    f10_arg0:setAlpha( 0 )
                                    f10_arg0:registerEventHandler( "transition_complete_keyframe", f8_arg0.clipFinished )
                              end
                              
                              f8_arg0.PhDSliderEffect:beginAnimation( 300 )
                              f8_arg0.PhDSliderEffect:setAlpha( 1 )
                              f8_arg0.PhDSliderEffect:registerEventHandler( "interrupted_keyframe", f8_arg0.clipInterrupted )
                              f8_arg0.PhDSliderEffect:registerEventHandler( "transition_complete_keyframe", f9_local0 )
                        end
                        
                        f8_arg0.PhDSliderEffect:completeAnimation()
                        f8_arg0.PhDSliderEffect:setAlpha( 0 )
                        f8_local0( f8_arg0.PhDSliderEffect )
                        f8_arg0.nextClip = "DefaultClip"
                  end
            }
      }

      CoD.ZMPerkVaporPhDSliderEffect.__onClose = function ( f11_arg0 )
            f11_arg0.PhDSliderEffect:close()
      end

      CoD.EnhZMPerkVaporModifierFrame = InheritFrom( LUI.UIElement )
      CoD.EnhZMPerkVaporModifierFrame.__defaultWidth = 80
      CoD.EnhZMPerkVaporModifierFrame.__defaultHeight = 80
      CoD.EnhZMPerkVaporModifierFrame.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.EnhZMPerkVaporModifierFrame )
            self.id = "EnhZMPerkVaporModifierFrame"
            self.soundSet = "none"
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            local Frame = LUI.UIImage.new( 0.00, 0.00, -2.5, 75.5, 0.00, 0.00, 0, 78 )
            Frame:setImage( RegisterImage( @"hash_6BE87F41005A7725" ) )
            Frame:setRGB(0.66, 0.66, 0.66)
            self:addElement( Frame )
            self.Frame = Frame

            local Frame2 = LUI.UIImage.new( 0.00, 0.00, -2.5, 75.5, 0.00, 0.00, 0, 78 )
            Frame2:setAlpha( 0.75 )
            Frame2:setRGB(0.66, 0.66, 0.66)
            Frame2:setImage( RegisterImage( @"hash_6BE87F41005A7725" ) )
            Frame2:setMaterial( LUI.UIImage.GetCachedMaterial( @"ui_add" ) )
            self:addElement( Frame2 )
            self.Frame2 = Frame2

            self:mergeStateConditions( {
                  {
                        stateName = "Active",
                        condition = function ( menu, element, event )
                              return AlwaysTrue()
                        end
                  },
                  {
                        stateName = "Inactive",
                        condition = function ( menu, element, event )
                              return AlwaysFalse()
                        end
                  }
            } )
            self:linkToElementModel( self, "isLastAltar", true, function ( model )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "isLastAltar"
                  } )
            end )
            self:linkToElementModel( self, "modifierActive", true, function ( model )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "modifierActive"
                  } )
            end )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            return self
      end
      
      CoD.EnhZMPerkVaporModifierFrame.__resetProperties = function ( f6_arg0 )
            f6_arg0.Frame:completeAnimation()
            f6_arg0.Frame2:completeAnimation()
            f6_arg0.Frame:setAlpha( 1 )
            f6_arg0.Frame2:setAlpha( 0.75 )
      end
      
      CoD.EnhZMPerkVaporModifierFrame.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f7_arg0, f7_arg1 )
                        f7_arg0:__resetProperties()
                        f7_arg0:setupElementClipCounter( 2 )
                        f7_arg0.Frame:completeAnimation()
                        f7_arg0.Frame:setAlpha( 0 )
                        f7_arg0.clipFinished( f7_arg0.Frame )
                        f7_arg0.Frame2:completeAnimation()
                        f7_arg0.Frame2:setAlpha( 0 )
                        f7_arg0.clipFinished( f7_arg0.Frame2 )
                  end
            },
            Active = {
                  DefaultClip = function ( f8_arg0, f8_arg1 )
                        f8_arg0:__resetProperties()
                        f8_arg0:setupElementClipCounter( 2 )

                        f8_arg0.Frame:setAlpha(1)
                        f8_arg0.Frame2:setAlpha(0.75)

                        --[[
                        f8_arg0:__resetProperties()
                        f8_arg0:setupElementClipCounter( 2 )
                        local f8_local0 = function ( f9_arg0 )
                              local f9_local0 = function ( f10_arg0 )
                                    f10_arg0:beginAnimation( 1000 )
                                    f10_arg0:setAlpha( 1 )
                                    f10_arg0:registerEventHandler( "transition_complete_keyframe", f8_arg0.clipFinished )
                              end
                              
                              f8_arg0.Frame:beginAnimation( 4000 )
                              f8_arg0.Frame:setAlpha( 0.25 )
                              f8_arg0.Frame:registerEventHandler( "interrupted_keyframe", f8_arg0.clipInterrupted )
                              f8_arg0.Frame:registerEventHandler( "transition_complete_keyframe", f9_local0 )
                        end
                        
                        f8_arg0.Frame:completeAnimation()
                        f8_arg0.Frame:setAlpha( 1 )
                        f8_local0( f8_arg0.Frame )
                        local f8_local1 = function ( f11_arg0 )
                              local f11_local0 = function ( f12_arg0 )
                                    f12_arg0:beginAnimation( 1000 )
                                    f12_arg0:setAlpha( 0.75 )
                                    f12_arg0:registerEventHandler( "transition_complete_keyframe", f8_arg0.clipFinished )
                              end
                              
                              f8_arg0.Frame2:beginAnimation( 4000 )
                              f8_arg0.Frame2:setAlpha( 0.25 )
                              f8_arg0.Frame2:registerEventHandler( "interrupted_keyframe", f8_arg0.clipInterrupted )
                              f8_arg0.Frame2:registerEventHandler( "transition_complete_keyframe", f11_local0 )
                        end
                        
                        f8_arg0.Frame2:completeAnimation()
                        f8_arg0.Frame2:setAlpha( 0.75 )
                        f8_local1( f8_arg0.Frame2 )
                        f8_arg0.nextClip = "DefaultClip"
                        ]]
                  end
            },
            Inactive = {
                  DefaultClip = function ( f13_arg0, f13_arg1 )
                        f13_arg0:__resetProperties()
                        f13_arg0:setupElementClipCounter( 2 )
                        f13_arg0.Frame:completeAnimation()
                        f13_arg0.Frame:setAlpha( 0 )
                        f13_arg0.clipFinished( f13_arg0.Frame )
                        f13_arg0.Frame2:completeAnimation()
                        f13_arg0.Frame2:setAlpha( 0 )
                        f13_arg0.clipFinished( f13_arg0.Frame2 )
                  end
            }
      }      

      -- for classic mode
      CoD.ZMPerkVaporItem = InheritFrom( LUI.UIElement )
      CoD.ZMPerkVaporItem.__defaultWidth = 70
      CoD.ZMPerkVaporItem.__defaultHeight = 98
      CoD.ZMPerkVaporItem.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.ZMPerkVaporItem )
            self.id = "ZMPerkVaporItem"
            self.soundSet = "none"
            self.anyChildUsesUpdateState = true
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            local VaporIcon = CoD.ZMPerkVaporIcon.new( f1_arg0, f1_arg1, 0, 0, 10, 60, 0, 0, 23.5, 73.5 )
            VaporIcon:setScale( 0.8, 0.8 )
            VaporIcon:linkToElementModel( self, nil, false, function ( model )
                  VaporIcon:setModel( model, f1_arg1 )
            end )
            self:addElement( VaporIcon )
            self.VaporIcon = VaporIcon

            local EnhModifierFrame = CoD.EnhZMPerkVaporModifierFrame.new( f1_arg0, f1_arg1, 0, 0, -1, 80, 0, 0, 10, 90 )
            EnhModifierFrame:linkToElementModel( self, nil, false, function ( model )
                  EnhModifierFrame:setModel( model, f1_arg1 )
            end )
            EnhModifierFrame:setRGB(0.15, 0.15, 0.15)
            self:addElement( EnhModifierFrame )
            self.EnhModifierFrame = EnhModifierFrame

            --if Engine[@"getdvarint"]("shield_enh_ClassicMode") ~= 1 then
                  EnhModifierFrame:setAlpha(0)
            --end
            
            local ModifierFrame = CoD.ZMPerkVaporModifierFrame.new( f1_arg0, f1_arg1, 0, 0, -1, 71, 0, 0, 13, 85 )
            ModifierFrame:linkToElementModel( self, nil, false, function ( model )
                  ModifierFrame:setModel( model, f1_arg1 )
            end )
            self:addElement( ModifierFrame )
            self.ModifierFrame = ModifierFrame
            
            local AltarName = LUI.UIText.new( 0.5, 1.5, -35, -35, 0, 0, 7, 24 )
            AltarName:setTTF( "notosans_bold" )
            AltarName:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_56250C6FCAC36BD4" ) )
            AltarName:setShaderVector( 0, 0, 0, 0, 0 )
            AltarName:setShaderVector( 1, 0, 0, 0, 1 )
            AltarName:setLetterSpacing( 2 )
            AltarName:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            AltarName:linkToElementModel( self, "altarName", true, function ( model )
                  local f4_local0 = model:get()
                  if f4_local0 ~= nil and Engine[@"getdvarint"]("shield_enh_ClassicMode") ~= 1 then
                        AltarName:setText( Engine[@"hash_4F9F1239CFD921FE"]( f4_local0 ) )
                  end
            end )
            self:addElement( AltarName )
            self.AltarName = AltarName
            
            local Charges = CoD.ZMPerkVaporItemChargeCountListWidget.new( f1_arg0, f1_arg1, 0, 0, 39, 75, 0, 0, 50.5, 74.5 )
            Charges:linkToElementModel( self, nil, false, function ( model )
                  Charges:setModel( model, f1_arg1 )
            end )
            self:addElement( Charges )
            self.Charges = Charges
            
            local DeadshotCharges = CoD.ZMPerkVaporDeadshotCountList.new( f1_arg0, f1_arg1, 0, 0, 14, 56, 0, 0, 26, 70 )
            DeadshotCharges:linkToElementModel( self, nil, false, function ( model )
                  DeadshotCharges:setModel( model, f1_arg1 )
            end )
            self:addElement( DeadshotCharges )
            self.DeadshotCharges = DeadshotCharges
            
            self:mergeStateConditions( {
                  {
                        stateName = "Hidden",
                        condition = function ( menu, element, event )
                              return CoD.ModelUtility.IsSelfModelValueEqualToEnum( element, f1_arg1, "state", CoD.ZMPerkUtility.PerkVaporStates.HIDDEN )
                        end
                  },
                  {
                        stateName = "Available",
                        condition = function ( menu, element, event )
                              return CoD.ModelUtility.IsSelfModelValueEqualToEnum( element, f1_arg1, "state", CoD.ZMPerkUtility.PerkVaporStates.DEFAULT )
                        end
                  },
                  {
                        stateName = "Consumed",
                        condition = function ( menu, element, event )
                              return CoD.ModelUtility.IsSelfModelValueEqualToEnum( element, f1_arg1, "state", CoD.ZMPerkUtility.PerkVaporStates.CONSUMED )
                        end
                  },
                  {
                        stateName = "CoolingDown",
                        condition = function ( menu, element, event )
                              return CoD.ModelUtility.IsSelfModelValueEqualToEnum( element, f1_arg1, "state", CoD.ZMPerkUtility.PerkVaporStates.COOLING_DOWN )
                        end
                  }
            } )
            self:linkToElementModel( self, "state", true, function ( model )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "state"
                  } )
            end )
            self:linkToElementModel( self, "state", true, function ( model )
                  local f12_local0 = self
                  ForceNotifyControllerModel( f1_arg1, "PerkVaporStateUpdated" )
            end )
            self:linkToElementModel( self, "itemIndex", true, function ( model )
                  local f13_local0 = self
                  ForceNotifyControllerModel( f1_arg1, "PerkVaporStateUpdated" )
            end )
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end

            --if Engine[@"getdvarint"]("shield_enh_ClassicMode") ~= 1 then
                  --self:setScale(1.25, 1.25)
            --else
                  self:setScale(0.85, 0.85)
            --end

            --CoD.EnhModPrintInfo("VaporItems for classic...")
            
            return self
      end
     
      CoD.ZMPerkVaporItem.__resetProperties = function ( f14_arg0 )
            f14_arg0.AltarName:completeAnimation()
            f14_arg0.VaporIcon:completeAnimation()
            f14_arg0.ModifierFrame:completeAnimation()
            f14_arg0.EnhModifierFrame:completeAnimation()
            f14_arg0.DeadshotCharges:completeAnimation()
            f14_arg0.Charges:completeAnimation()
            f14_arg0.AltarName:setLeftRight( 0.5, 1.5, -35, -35 )
            f14_arg0.AltarName:setTopBottom( 0, 0, 7, 24 )
            f14_arg0.AltarName:setRGB( 1, 1, 1 )
            f14_arg0.AltarName:setAlpha( 1 )
            f14_arg0.VaporIcon:setAlpha( 1 )
            f14_arg0.ModifierFrame:setAlpha( 1 )

            --if Engine[@"getdvarint"]("shield_enh_ClassicMode") == 1 then
                  f14_arg0.EnhModifierFrame:setAlpha( 0.75 )
            --else
                  --f14_arg0.EnhModifierFrame:setAlpha( 0 )
            --end

            f14_arg0.DeadshotCharges:setAlpha( 1 )
            f14_arg0.Charges:setAlpha( 1 )
      end
     
      CoD.ZMPerkVaporItem.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f15_arg0, f15_arg1 )
                        f15_arg0:__resetProperties()
                        f15_arg0:setupElementClipCounter( 5 )
                        --f15_arg0.EnhModifierFrame:setRGB(0, 0, 1)
                        f15_arg0.VaporIcon:completeAnimation()
                        f15_arg0.VaporIcon:setAlpha( 0 )
                        f15_arg0.clipFinished( f15_arg0.VaporIcon )
                        f15_arg0.ModifierFrame:completeAnimation()
                        f15_arg0.ModifierFrame:setAlpha( 0 )
                        f15_arg0.clipFinished( f15_arg0.ModifierFrame )
                        f15_arg0.EnhModifierFrame:completeAnimation()
                        f15_arg0.EnhModifierFrame:setAlpha( 0 )
                        f15_arg0.clipFinished( f15_arg0.EnhModifierFrame )
                        f15_arg0.AltarName:completeAnimation()
                        f15_arg0.AltarName:setAlpha( 0 )
                        f15_arg0.clipFinished( f15_arg0.AltarName )
                        f15_arg0.Charges:completeAnimation()
                        f15_arg0.Charges:setAlpha( 0 )
                        f15_arg0.clipFinished( f15_arg0.Charges )
                        f15_arg0.DeadshotCharges:completeAnimation()
                        f15_arg0.DeadshotCharges:setAlpha( 0 )
                        f15_arg0.clipFinished( f15_arg0.DeadshotCharges )
                  end
            },
            Hidden = {
                  DefaultClip = function ( f16_arg0, f16_arg1 )
                        f16_arg0:__resetProperties()
                        f16_arg0:setupElementClipCounter( 5 )
                        --f16_arg0.EnhModifierFrame:setRGB(0, 0, 1)
                        f16_arg0.VaporIcon:completeAnimation()
                        f16_arg0.VaporIcon:setAlpha( 0 )
                        f16_arg0.clipFinished( f16_arg0.VaporIcon )
                        f16_arg0.ModifierFrame:completeAnimation()
                        f16_arg0.ModifierFrame:setAlpha( 0 )
                        f16_arg0.clipFinished( f16_arg0.ModifierFrame )
                        f16_arg0.EnhModifierFrame:completeAnimation()
                        f16_arg0.EnhModifierFrame:setAlpha( 0 )
                        f16_arg0.clipFinished( f16_arg0.EnhModifierFrame )
                        f16_arg0.AltarName:completeAnimation()
                        f16_arg0.AltarName:setAlpha( 0 )
                        f16_arg0.clipFinished( f16_arg0.AltarName )
                        f16_arg0.Charges:completeAnimation()
                        f16_arg0.Charges:setAlpha( 0 )
                        f16_arg0.clipFinished( f16_arg0.Charges )
                        f16_arg0.DeadshotCharges:completeAnimation()
                        f16_arg0.DeadshotCharges:setAlpha( 0 )
                        f16_arg0.clipFinished( f16_arg0.DeadshotCharges )
                  end
            },
            Available = {
                  DefaultClip = function ( f17_arg0, f17_arg1 )
                        f17_arg0:__resetProperties()
                        f17_arg0:setupElementClipCounter( 4 )
                        --f17_arg0.EnhModifierFrame:setRGB(0, 0, 1)
                        f17_arg0.VaporIcon:completeAnimation()
                        f17_arg0.VaporIcon:setAlpha( 1 )
                        f17_arg0.clipFinished( f17_arg0.VaporIcon )
                        f17_arg0.AltarName:completeAnimation()
                        f17_arg0.AltarName:setLeftRight( 0.5, 1.5, -35, -35 )
                        f17_arg0.AltarName:setTopBottom( 0, 0, 7, 24 )
                        f17_arg0.AltarName:setRGB( 0.45, 0.45, 0.45 )
                        f17_arg0.clipFinished( f17_arg0.AltarName )
                        f17_arg0.Charges:completeAnimation()
                        f17_arg0.Charges:setAlpha( 0 )
                        f17_arg0.clipFinished( f17_arg0.Charges )
                        f17_arg0.DeadshotCharges:completeAnimation()
                        f17_arg0.DeadshotCharges:setAlpha( 0 )
                        f17_arg0.clipFinished( f17_arg0.DeadshotCharges )
                  end
            },
            Consumed = {
                  DefaultClip = function ( f18_arg0, f18_arg1 )
                        f18_arg0:__resetProperties()
                        f18_arg0:setupElementClipCounter( 3 )
                        --f18_arg0.EnhModifierFrame:setRGB(0, 0, 1)
                        f18_arg0.VaporIcon:completeAnimation()
                        f18_arg0.VaporIcon:setAlpha( 1 )
                        f18_arg0.clipFinished( f18_arg0.VaporIcon )
                        f18_arg0.AltarName:completeAnimation()
                        f18_arg0.AltarName:setRGB( 1, 1, 1 )
                        f18_arg0.clipFinished( f18_arg0.AltarName )
                        f18_arg0.DeadshotCharges:completeAnimation()
                        f18_arg0.DeadshotCharges:setAlpha( 1 )
                        f18_arg0.clipFinished( f18_arg0.DeadshotCharges )
                  end
            },
            CoolingDown = {
                  DefaultClip = function ( f19_arg0, f19_arg1 )
                        f19_arg0:__resetProperties()
                        f19_arg0:setupElementClipCounter( 3 )
                        f19_arg0.VaporIcon:completeAnimation()
                        f19_arg0.VaporIcon:setAlpha( 1 )
                        f19_arg0.clipFinished( f19_arg0.VaporIcon )
                        f19_arg0.AltarName:completeAnimation()
                        f19_arg0.AltarName:setRGB( 1, 1, 1 )
                        f19_arg0.clipFinished( f19_arg0.AltarName )
                        f19_arg0.DeadshotCharges:completeAnimation()
                        f19_arg0.DeadshotCharges:setAlpha( 1 )
                        f19_arg0.clipFinished( f19_arg0.DeadshotCharges )
                  end
            }
      }

      CoD.ZMPerkVaporItem.__onClose = function ( f20_arg0 )
            f20_arg0.VaporIcon:close()
            f20_arg0.ModifierFrame:close()
            f20_arg0.EnhModifierFrame:close()
            f20_arg0.AltarName:close()
            f20_arg0.Charges:close()
            f20_arg0.DeadshotCharges:close()
      end
      
      -- perks logic
      CoD.ZMPerkVaporIcon = InheritFrom( LUI.UIElement )
      CoD.ZMPerkVaporIcon.__defaultWidth = 50
      CoD.ZMPerkVaporIcon.__defaultHeight = 50
      CoD.ZMPerkVaporIcon.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.ZMPerkVaporIcon )
            self.id = "ZMPerkVaporIcon"
            self.soundSet = "default"
            self.anyChildUsesUpdateState = true
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            local vaporImageBacking = LUI.UIImage.new( 0, 0, 0, 50, 0, 0, 0, 50 )
            vaporImageBacking:setRGB( 0.45, 0.45, 0.45 )
            vaporImageBacking:setYRot( 360 )
            if Engine[@"getdvarint"]("shield_enh_ClassicMode") ~= 1 then
                  --vaporImageBacking:setScale( 0.8, 0.8 )
            else
                  vaporImageBacking:setScale( 0, 0 )
            end
            vaporImageBacking:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_saturation_normal" ) )
            vaporImageBacking:setShaderVector( 0, 1, 0, 0, 0 )
            vaporImageBacking:linkToElementModel( self, "itemIndex", true, function ( model )
                  local f2_local0 = model:get()
                  if f2_local0 ~= nil then
                        if Engine[@"getdvarint"]("shield_enh_ClassicMode") ~= 1 then
                              vaporImageBacking:setImage(RegisterImage(GetItemImageFromIndex( Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f2_local0 )))
                        else
                              vaporImageBacking:setScale(0, 0)
                              vaporImageBacking:setAlpha(0)
                              vaporImageBacking:setTopBottom(9, 9, 0, 0)
                              --vaporImageBacking:setImage( RegisterImage( "ui_icon_perks_zm_secretsauce" ) )
                        end
                  end
            end )
            self:addElement( vaporImageBacking )
            self.vaporImageBacking = vaporImageBacking
            
            local vaporImageFull = LUI.UIImage.new( 0, 0, 0, 50, 0, 0, 0, 50 )
            vaporImageFull:setYRot( 360 )
            vaporImageFull:linkToElementModel( self, "itemIndex", true, function ( model )
                  local f3_local0 = model:get()
                  if f3_local0 ~= nil then
                        if Engine[@"getdvarint"]("shield_enh_ClassicMode") ~= 1 then
                              vaporImageFull:setImage(RegisterImage(GetItemImageFromIndex( Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f3_local0 )))
                        else
                              vaporImageFull:setImage( RegisterImage( GetItemImageFromIndex( Enum[@"statindexoffset"][@"hash_49AF82A21BAD026D"], f3_local0 ) ) )
                        end
                  end
            end )
            self:addElement( vaporImageFull )
            self.vaporImageFull = vaporImageFull
            
            local CooldownAndTimerEffects = CoD.ZMPerkVaporCooldownPulse.new( f1_arg0, f1_arg1, 0, 0, 0, 50, 0, 0, 0, 50 )
            CooldownAndTimerEffects:linkToElementModel( self, nil, false, function ( model )
                  CooldownAndTimerEffects:setModel( model, f1_arg1 )
            end )
            self:addElement( CooldownAndTimerEffects )
            self.CooldownAndTimerEffects = CooldownAndTimerEffects
            
            local PhDSliderEffect = CoD.ZMPerkVaporPhDSliderEffect.new( f1_arg0, f1_arg1, 0, 0, 0, 50, 0, 0, 0, 50 )
            PhDSliderEffect:linkToElementModel( self, nil, false, function ( model )
                  PhDSliderEffect:setModel( model, f1_arg1 )
            end )
            self:addElement( PhDSliderEffect )
            self.PhDSliderEffect = PhDSliderEffect

            self:mergeStateConditions( {
                  {
                        stateName = "Active",
                        condition = function ( menu, element, event )
                              return CoD.ModelUtility.IsSelfModelValueEqualTo( element, f1_arg1, "timerActive", 1 )
                        end
                  },
                  {
                        stateName = "Available",
                        condition = function ( menu, element, event )
                              return CoD.ModelUtility.IsSelfModelValueEqualToEnum( element, f1_arg1, "state", CoD.ZMPerkUtility.PerkVaporStates.DEFAULT )
                        end
                  },
                  {
                        stateName = "Consumed",
                        condition = function ( menu, element, event )
                              return CoD.ModelUtility.IsSelfModelValueEqualToEnum( element, f1_arg1, "state", CoD.ZMPerkUtility.PerkVaporStates.CONSUMED )
                        end
                  },
                  {
                        stateName = "CoolingDown",
                        condition = function ( menu, element, event )
                              return CoD.ModelUtility.IsSelfModelValueEqualToEnum( element, f1_arg1, "state", CoD.ZMPerkUtility.PerkVaporStates.COOLING_DOWN )
                        end
                  }
            } )
            self:linkToElementModel( self, "timerActive", true, function ( model )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "timerActive"
                  } )
            end )
            self:linkToElementModel( self, "state", true, function ( model )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "state"
                  } )
            end )
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            --if Engine[@"getdvarint"]("shield_enh_ClassicMode") ~= 1 then
                  --self:setScale(1.25, 1.25)
            --else
                  self:setScale(0.85, 0.85)
            --end

            return self
      end

      CoD.ZMPerkVaporIcon.__resetProperties = function ( f12_arg0 )
            f12_arg0.vaporImageBacking:completeAnimation()
            f12_arg0.CooldownAndTimerEffects:completeAnimation()
            f12_arg0.vaporImageFull:completeAnimation()
            f12_arg0.vaporImageBacking:setAlpha( 1 )
            f12_arg0.CooldownAndTimerEffects:setAlpha( 1 )
            f12_arg0.vaporImageFull:setAlpha( 1 )
      end

      CoD.ZMPerkVaporIcon.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f13_arg0, f13_arg1 )
                        f13_arg0:__resetProperties()
                        f13_arg0:setupElementClipCounter( 3 )
                        f13_arg0.vaporImageBacking:completeAnimation()
                        f13_arg0.vaporImageBacking:setAlpha( 0 )
                        f13_arg0.clipFinished( f13_arg0.vaporImageBacking )
                        f13_arg0.vaporImageFull:completeAnimation()
                        f13_arg0.vaporImageFull:setAlpha( 0 )
                        f13_arg0.clipFinished( f13_arg0.vaporImageFull )
                        f13_arg0.CooldownAndTimerEffects:completeAnimation()
                        f13_arg0.CooldownAndTimerEffects:setAlpha( 0 )
                        f13_arg0.clipFinished( f13_arg0.CooldownAndTimerEffects )
                  end
            },
            Active = {
                  DefaultClip = function ( f14_arg0, f14_arg1 )
                        f14_arg0:__resetProperties()
                        f14_arg0:setupElementClipCounter( 3 )
                        f14_arg0.vaporImageBacking:completeAnimation()
                        f14_arg0.vaporImageBacking:setAlpha( 0 )
                        f14_arg0.clipFinished( f14_arg0.vaporImageBacking )
                        f14_arg0.vaporImageFull:completeAnimation()
                        f14_arg0.vaporImageFull:setAlpha( 0 )
                        f14_arg0.clipFinished( f14_arg0.vaporImageFull )
                        f14_arg0.CooldownAndTimerEffects:completeAnimation()
                        f14_arg0.CooldownAndTimerEffects:setAlpha( 1 )
                        f14_arg0.clipFinished( f14_arg0.CooldownAndTimerEffects )
                  end
            },
            Available = {
                  DefaultClip = function ( f15_arg0, f15_arg1 )
                        f15_arg0:__resetProperties()
                        f15_arg0:setupElementClipCounter( 2 )
                        f15_arg0.vaporImageFull:completeAnimation()
                        f15_arg0.vaporImageFull:setAlpha( 0 )
                        f15_arg0.clipFinished( f15_arg0.vaporImageFull )
                        f15_arg0.CooldownAndTimerEffects:completeAnimation()
                        f15_arg0.CooldownAndTimerEffects:setAlpha( 0 )
                        f15_arg0.clipFinished( f15_arg0.CooldownAndTimerEffects )
                  end
            },
            Consumed = {
                  DefaultClip = function ( f16_arg0, f16_arg1 )
                        f16_arg0:__resetProperties()
                        f16_arg0:setupElementClipCounter( 2 )
                        f16_arg0.vaporImageFull:completeAnimation()
                        f16_arg0.vaporImageFull:setAlpha( 1 )
                        f16_arg0.clipFinished( f16_arg0.vaporImageFull )
                        f16_arg0.CooldownAndTimerEffects:completeAnimation()
                        f16_arg0.CooldownAndTimerEffects:setAlpha( 0 )
                        f16_arg0.clipFinished( f16_arg0.CooldownAndTimerEffects )
                  end
            },
            CoolingDown = {
                  DefaultClip = function ( f17_arg0, f17_arg1 )
                        f17_arg0:__resetProperties()
                        f17_arg0:setupElementClipCounter( 3 )
                        f17_arg0.vaporImageBacking:completeAnimation()
                        f17_arg0.vaporImageBacking:setAlpha( 1 )
                        f17_arg0.clipFinished( f17_arg0.vaporImageBacking )
                        f17_arg0.vaporImageFull:completeAnimation()
                        f17_arg0.vaporImageFull:setAlpha( 0 )
                        f17_arg0.clipFinished( f17_arg0.vaporImageFull )
                        f17_arg0.CooldownAndTimerEffects:completeAnimation()
                        f17_arg0.CooldownAndTimerEffects:setAlpha( 1 )
                        f17_arg0.clipFinished( f17_arg0.CooldownAndTimerEffects )
                  end
            }
      }

      CoD.ZMPerkVaporIcon.__onClose = function ( f18_arg0 )
            f18_arg0.vaporImageBacking:close()
            f18_arg0.vaporImageFull:close()
            f18_arg0.CooldownAndTimerEffects:close()
            f18_arg0.PhDSliderEffect:close()
      end

      CoD.AmmoWidgetZM_AbilityItem = InheritFrom( LUI.UIElement )
      CoD.AmmoWidgetZM_AbilityItem.__defaultWidth = 72
      CoD.AmmoWidgetZM_AbilityItem.__defaultHeight = 59
      CoD.AmmoWidgetZM_AbilityItem.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.AmmoWidgetZM_AbilityItem )
            self.id = "AmmoWidgetZM_AbilityItem"
            self.soundSet = "default"
            self.anyChildUsesUpdateState = true
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            local SecondaryWeaponBGBlur = LUI.UIImage.new( 0.5, 0.5, -38, 38, 0, 0, -7, 73 )
            SecondaryWeaponBGBlur:setImage( RegisterImage( @"hash_1FE9388BE79636F7" ) )
            SecondaryWeaponBGBlur:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_E2354BE557C4C7A" ) )
            SecondaryWeaponBGBlur:setShaderVector( 0, 0, 0, 0, 0 )
            self:addElement( SecondaryWeaponBGBlur )
            self.SecondaryWeaponBGBlur = SecondaryWeaponBGBlur
            
            local SecondaryWeaponBG = LUI.UIImage.new( 0.5, 0.5, -38, 38, 0, 0, -7, 73 )
            SecondaryWeaponBG:setImage( RegisterImage( @"hash_46E5BECCF89F9216" ) )
            self:addElement( SecondaryWeaponBG )
            self.SecondaryWeaponBG = SecondaryWeaponBG
            
            local SecondaryWeaponMeterBGBlur = LUI.UIImage.new( 0.5, 0.5, -38, 38, 0, 0, -16, 12 )
            SecondaryWeaponMeterBGBlur:setImage( RegisterImage( @"hash_20BCE5D90EBC1F88" ) )
            SecondaryWeaponMeterBGBlur:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_E2354BE557C4C7A" ) )
            SecondaryWeaponMeterBGBlur:setShaderVector( 0, 0, 0, 0, 0 )
            self:addElement( SecondaryWeaponMeterBGBlur )
            self.SecondaryWeaponMeterBGBlur = SecondaryWeaponMeterBGBlur
            
            local SecondaryWeaponMeterBG = LUI.UIImage.new( 0.5, 0.5, -38, 38, 0, 0, -16, 12 )
            SecondaryWeaponMeterBG:setImage( RegisterImage( @"hash_27A319569188B535" ) )
            self:addElement( SecondaryWeaponMeterBG )
            self.SecondaryWeaponMeterBG = SecondaryWeaponMeterBG
            
            local ClockMeter = LUI.UIImage.new( 0.5, 0.5, -47, 47, 0.5, 0.5, -45.5, 48.5 )
            ClockMeter:setAlpha( 0 )
            ClockMeter:setImage( RegisterImage( @"hash_FE05CC9C49C7C7E" ) )
            ClockMeter:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
            ClockMeter:setShaderVector( 1, 0.5, 0, 0, 0 )
            ClockMeter:setShaderVector( 2, 0.5, 0, 0, 0 )
            ClockMeter:setShaderVector( 3, 0, 0, 0, 0 )
            ClockMeter:setShaderVector( 4, 0, 0, 0, 0 )
            ClockMeter:linkToElementModel( self, "powerRatio", true, function ( model )
                  local f2_local0 = model:get()
                  if f2_local0 ~= nil then
                        ClockMeter:setShaderVector( 0, AddToVector( 0.38, 0, 0.5, 0, ScaleVectorComponents( 0.25, 1, 1, 1, SetVectorComponent( 2, 0.38, CoD.GetVectorComponentFromString( f2_local0, 1 ), CoD.GetVectorComponentFromString( f2_local0, 2 ), CoD.GetVectorComponentFromString( f2_local0, 3 ), CoD.GetVectorComponentFromString( f2_local0, 4 ) ) ) ) )
                  end
            end )
            self:addElement( ClockMeter )
            self.ClockMeter = ClockMeter
            
            local ClockMeterAdd = LUI.UIImage.new( 0.5, 0.5, -47, 47, 0.5, 0.5, -45.5, 48.5 )
            ClockMeterAdd:setAlpha( 0 )
            ClockMeterAdd:setImage( RegisterImage( @"hash_FE05CC9C49C7C7E" ) )
            ClockMeterAdd:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_add" ) )
            ClockMeterAdd:setShaderVector( 1, 0.5, 0, 0, 0 )
            ClockMeterAdd:setShaderVector( 2, 0.5, 0, 0, 0 )
            ClockMeterAdd:setShaderVector( 3, 0, 0, 0, 0 )
            ClockMeterAdd:setShaderVector( 4, 0, 0, 0, 0 )
            ClockMeterAdd:linkToElementModel( self, "powerRatio", true, function ( model )
                  local f3_local0 = model:get()
                  if f3_local0 ~= nil then
                        ClockMeterAdd:setShaderVector( 0, AddToVector( 0.38, 0, 0.5, 0, ScaleVectorComponents( 0.25, 1, 1, 1, SetVectorComponent( 2, 0.38, CoD.GetVectorComponentFromString( f3_local0, 1 ), CoD.GetVectorComponentFromString( f3_local0, 2 ), CoD.GetVectorComponentFromString( f3_local0, 3 ), CoD.GetVectorComponentFromString( f3_local0, 4 ) ) ) ) )
                  end
            end )
            self:addElement( ClockMeterAdd )
            self.ClockMeterAdd = ClockMeterAdd
            
            local FlareBack = LUI.UIImage.new( 0, 0, -45.5, 114.5, 0, 0, -40, 100 )
            FlareBack:setAlpha( 0 )
            FlareBack:setImage( RegisterImage( @"uie_abeq_flare_back" ) )
            FlareBack:setMaterial( LUI.UIImage.GetCachedMaterial( @"ui_add" ) )
            self:addElement( FlareBack )
            self.FlareBack = FlareBack
            
            local Glow = LUI.UIImage.new( 0, 0, 9, 61, 0, 0, 7, 59 )
            Glow:setAlpha( 0 )
            Glow:setImage( RegisterImage( @"hash_3613317835FD35EB" ) )
            Glow:setMaterial( LUI.UIImage.GetCachedMaterial( @"ui_add" ) )
            self:addElement( Glow )
            self.Glow = Glow
            
            local AmmoWidgetAbilityContainer = CoD.AmmoWidget_AbilityContainer.new( f1_arg0, f1_arg1, 0, 0, -23, 69, 0, 0, -9, 35 )
            AmmoWidgetAbilityContainer:setAlpha( 0 )
            AmmoWidgetAbilityContainer:setScale( 1.4, 1.4 )
            self:addElement( AmmoWidgetAbilityContainer )
            self.AmmoWidgetAbilityContainer = AmmoWidgetAbilityContainer
            
            local FullBackingDeployed = LUI.UIImage.new( 0, 0, 8, 64, 0, 0, 2, 58 )
            FullBackingDeployed:setRGB( 0.84, 0.83, 0.77 )
            FullBackingDeployed:setAlpha( 0 )
            FullBackingDeployed:setZRot( 180 )
            FullBackingDeployed:setImage( RegisterImage( @"hash_6040221656249477" ) )
            FullBackingDeployed:setMaterial( LUI.UIImage.GetCachedMaterial( @"ui_add" ) )
            self:addElement( FullBackingDeployed )
            self.FullBackingDeployed = FullBackingDeployed
            
            local EquipmentBacking = LUI.UIImage.new( 0, 0, 5, 67, 0, 0, -1, 61 )
            EquipmentBacking:setRGB( 0, 0, 0 )
            EquipmentBacking:setAlpha( 0.6 )
            EquipmentBacking:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_elliptical_ring_normal" ) )
            EquipmentBacking:setShaderVector( 0, 50, 1, 0, 0 )
            EquipmentBacking:setShaderVector( 1, 100, 100, 0, 0 )
            EquipmentBacking:setShaderVector( 2, 0, 0.81, 0, 0 )
            self:addElement( EquipmentBacking )
            self.EquipmentBacking = EquipmentBacking
            
            local PowerBasedImageAvailable = LUI.UIImage.new( 0, 0, 9, 64, 0, 0, 3.5, 58.5 )
            PowerBasedImageAvailable:setRGB( ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b )
            PowerBasedImageAvailable:setScale( 0.86, 0.86 )
            PowerBasedImageAvailable:linkToElementModel( self, "id", true, function ( model )
                  local f4_local0 = model:get()
                  if f4_local0 ~= nil then
                        if Engine[@"getdvarint"]("shield_enh_ClassicMode") ~= 1 then
                              PowerBasedImageAvailable:setImage( GetWeaponGadgetIconAvailable( f4_local0 ) )
                        else
                              if self.IsSpecial ~= nil and self.IsSpecial == true then
                                    PowerBasedImageAvailable:setImage( RegisterImage(@"enh_death") )
                                    PowerBasedImageAvailable:setScale(1.25, 1.25)
                              else
                                    PowerBasedImageAvailable:setImage( GetWeaponGadgetIconAvailable( f4_local0 ) )
                              end
                        end
                  end
            end )
            self:addElement( PowerBasedImageAvailable )
            self.PowerBasedImageAvailable = PowerBasedImageAvailable
            
            local PowerBasedImageUnavailable = LUI.UIImage.new( 0, 0, 9, 64, 0, 0, 3.5, 58.5 )
            PowerBasedImageUnavailable:setAlpha( 0 )
            PowerBasedImageUnavailable:setScale( 0.86, 0.86 )
            PowerBasedImageUnavailable:linkToElementModel( self, "id", true, function ( model )
                  local f4_local05 = model:get()
                  if f4_local05 ~= nil then
                        if Engine[@"getdvarint"]("shield_enh_ClassicMode") ~= 1 then
                              --CoD.EnhModPrintInfo("unav test .. " .. tostring(GetWeaponGadgetIconUnavailable( f4_local05 )))
                              PowerBasedImageUnavailable:setImage( GetWeaponGadgetIconUnavailable( f4_local05 ) )
                        else
                              if self.IsSpecial ~= nil and self.IsSpecial == true then
                                    PowerBasedImageUnavailable:setImage( RegisterImage(@"enh_death") )
                                    PowerBasedImageUnavailable:setScale(1.25, 1.25)
                              else
                                    PowerBasedImageUnavailable:setImage( GetWeaponGadgetIconUnavailable( f4_local05 ) )
                              end
                        end
                  end
            end )
            self:addElement( PowerBasedImageUnavailable )
            self.PowerBasedImageUnavailable = PowerBasedImageUnavailable
            
            local NotAvailable = CoD.AmmoWidget_EquipmentEmpty.new( f1_arg0, f1_arg1, 0.5, 0.5, -26, 26, 0.5, 0.5, -18.5, 23.5 )
            NotAvailable:linkToElementModel( self, nil, false, function ( model )
                  NotAvailable:setModel( model, f1_arg1 )
            end )
            NotAvailable:linkToElementModel( self, "id", true, function ( model )
                  local f7_local0 = model:get()
                  if f7_local0 ~= nil then
                        if Engine[@"getdvarint"]("shield_enh_ClassicMode") ~= 1 then
                              NotAvailable.ImgIcon:setImage( GetWeaponGadgetIconAvailable( f7_local0 ) )
                        else
                              if self.IsSpecial ~= nil and self.IsSpecial == true then
                                    NotAvailable.ImgIcon:setImage( RegisterImage(@"enh_death") )
                                    NotAvailable.ImgIcon:setScale(1.25, 1.25)
                              else
                                    NotAvailable.ImgIcon:setImage( GetWeaponGadgetIconAvailable( f7_local0 ) )
                              end
                        end
                  end
            end )
            NotAvailable:linkToElementModel( self, "id", true, function ( model )
                  local f8_local0 = model:get()
                  if f8_local0 ~= nil then
                        if Engine[@"getdvarint"]("shield_enh_ClassicMode") ~= 1 then
                              NotAvailable.ImgIconGrow:setImage( GetWeaponGadgetIconAvailable( f8_local0 ) )
                        else
                              if self.IsSpecial ~= nil and self.IsSpecial == true then
                                    NotAvailable.ImgIconGrow:setImage( RegisterImage(@"enh_death") )
                                    NotAvailable.ImgIconGrow:setScale(1.25, 1.25)
                              else
                                    NotAvailable.ImgIconGrow:setImage( GetWeaponGadgetIconAvailable( f8_local0 ) )
                              end
                        end
                  end
            end )
            self:addElement( NotAvailable )
            self.NotAvailable = NotAvailable
            
            local HeroAbilityUseString = CoD.ControllerDependent_TextBox.new( f1_arg0, f1_arg1, 0.5, 0.5, -50, 50, 0, 0, -33, -9 )
            HeroAbilityUseString:mergeStateConditions( {
                  {
                        stateName = "KeyboardAndMouse",
                        condition = function ( menu, element, event )
                              return IsMouseOrKeyboard( f1_arg1 ) and AlwaysFalse()
                        end
                  },
                  {
                        stateName = "KeyboardAndMouseAbility",
                        condition = function ( menu, element, event )
                              return IsMouseOrKeyboard( f1_arg1 ) and AlwaysFalse()
                        end
                  },
                  {
                        stateName = "KeyboardAndMouseUltimate",
                        condition = function ( menu, element, event )
                              return IsMouseOrKeyboard( f1_arg1 ) and AlwaysFalse()
                        end
                  },
                  {
                        stateName = "KeyboardAndMouseScoreStreak",
                        condition = function ( menu, element, event )
                              return IsMouseOrKeyboard( f1_arg1 ) and AlwaysFalse()
                        end
                  },
                  {
                        stateName = "KeyboardAndMouseAbilityWZ",
                        condition = function ( menu, element, event )
                              return IsMouseOrKeyboard( f1_arg1 ) and AlwaysFalse()
                        end
                  },
                  {
                        stateName = "KeyboardAndMouseZM",
                        condition = function ( menu, element, event )
                              return IsMouseOrKeyboard( f1_arg1 )
                        end
                  }
            } )
            local HeroAbilityHoldStringPC = HeroAbilityUseString
            local HeroAbilityHoldString = HeroAbilityUseString.subscribeToModel
            local f1_local18 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            HeroAbilityHoldString( HeroAbilityHoldStringPC, f1_local18["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function ( f15_arg0 )
                  f1_arg0:updateElementState( HeroAbilityUseString, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f15_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]
                  } )
            end, false )
            HeroAbilityHoldStringPC = HeroAbilityUseString
            HeroAbilityHoldString = HeroAbilityUseString.subscribeToModel
            f1_local18 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            HeroAbilityHoldString( HeroAbilityHoldStringPC, f1_local18["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function ( f16_arg0 )
                  f1_arg0:updateElementState( HeroAbilityUseString, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f16_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]
                  } )
            end, false )
            HeroAbilityUseString:appendEventHandler( "input_source_changed", function ( f17_arg0, f17_arg1 )
                  f17_arg1.menu = f17_arg1.menu or f1_arg0
                  f1_arg0:updateElementState( HeroAbilityUseString, f17_arg1 )
            end )
            HeroAbilityHoldStringPC = HeroAbilityUseString
            HeroAbilityHoldString = HeroAbilityUseString.subscribeToModel
            f1_local18 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            HeroAbilityHoldString( HeroAbilityHoldStringPC, f1_local18.LastInput, function ( f18_arg0 )
                  f1_arg0:updateElementState( HeroAbilityUseString, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f18_arg0:get(),
                        modelName = "LastInput"
                  } )
            end, false )
            HeroAbilityUseString:setScale( LanguageOverrideNumberForScale( "arabic", 0.65, 1, 1 ) )
            HeroAbilityUseString.KBMText:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"hash_2EC61C43D90FCF56" ) )
            HeroAbilityUseString.GamepadText:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"hash_29E6A8D0F83F4FC6" ) )
            HeroAbilityUseString.GamepadText:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            self:addElement( HeroAbilityUseString )
            self.HeroAbilityUseString = HeroAbilityUseString
            
            HeroAbilityHoldString = CoD.AbilityHoldToActivate.new( f1_arg0, f1_arg1, 0.5, 0.5, -100, 100, 0, 0, -78, -29 )
            HeroAbilityHoldString:linkToElementModel( self, nil, false, function ( model )
                  HeroAbilityHoldString:setModel( model, f1_arg1 )
            end )
            self:addElement( HeroAbilityHoldString )
            self.HeroAbilityHoldString = HeroAbilityHoldString
            
            HeroAbilityHoldStringPC = nil
            
            HeroAbilityHoldStringPC = CoD.AbilityHoldToActivate.new( f1_arg0, f1_arg1, 0.5, 0.5, -100, 100, 0, 0, -93, -44 )
            HeroAbilityHoldStringPC.__Alpha = function ()
                  HeroAbilityHoldStringPC:setAlpha( CoD.HUDUtility.GetAbilityHoldToActivateAlpha( f1_arg1, self, 1 ) )
            end
            
            HeroAbilityHoldStringPC.__Alpha()
            HeroAbilityHoldStringPC:linkToElementModel( self, nil, false, function ( model )
                  HeroAbilityHoldStringPC:setModel( model, f1_arg1 )
            end )
            self:addElement( HeroAbilityHoldStringPC )
            self.HeroAbilityHoldStringPC = HeroAbilityHoldStringPC
            
            HeroAbilityHoldStringPC:linkToElementModel( self, "powerRatio", true, HeroAbilityHoldStringPC.__Alpha )
            local f1_local19 = HeroAbilityHoldStringPC
            f1_local18 = HeroAbilityHoldStringPC.subscribeToModel
            local f1_local20 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local18( f1_local19, f1_local20["GameplayFeedbackSettings.hideRadiationHold"], HeroAbilityHoldStringPC.__Alpha )
            self:mergeStateConditions( {
                  {
                        stateName = "Hidden",
                        condition = function ( menu, element, event )
                              return not CoD.ModelUtility.IsSelfModelValueNonEmptyString( element, f1_arg1, "id" )
                        end
                  },
                  {
                        stateName = "InUse",
                        condition = function ( menu, element, event )
                              return CoD.ModelUtility.IsSelfModelValueEqualToEnum( element, f1_arg1, "state", Enum[@"weapongadgetstates"][@"player_ability_state_inuse"] )
                        end
                  },
                  {
                        stateName = "Deployed",
                        condition = function ( menu, element, event )
                              return AlwaysFalse()
                        end
                  },
                  {
                        stateName = "PowerBasedEmptyCharging",
                        condition = function ( menu, element, event )
                              return CoD.ModelUtility.IsSelfModelValueEqualToEnum( element, f1_arg1, "state", Enum[@"weapongadgetstates"][@"player_ability_state_charging"] ) and CoD.ModelUtility.IsSelfModelValueEqualTo( element, f1_arg1, "powerRatio", 0 )
                        end
                  },
                  {
                        stateName = "PowerBasedCharging",
                        condition = function ( menu, element, event )
                              return CoD.ModelUtility.IsSelfModelValueEqualToEnum( element, f1_arg1, "state", Enum[@"weapongadgetstates"][@"player_ability_state_charging"] ) and not IsWarzone()
                        end
                  },
                  {
                        stateName = "PowerBased",
                        condition = function ( menu, element, event )
                              return not CoD.ModelUtility.IsSelfModelValueEqualToEnum( element, f1_arg1, "state", Enum[@"weapongadgetstates"][@"player_ability_state_hidden"] )
                        end
                  }
            } )
            self:linkToElementModel( self, "id", true, function ( model )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "id"
                  } )
            end )
            self:linkToElementModel( self, "state", true, function ( model )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "state"
                  } )
            end )
            self:linkToElementModel( self, "powerRatio", true, function ( model )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "powerRatio"
                  } )
            end )
            f1_local19 = self
            f1_local18 = self.subscribeToModel
            f1_local20 = Engine[@"getglobalmodel"]()
            f1_local18( f1_local19, f1_local20["lobbyRoot.lobbyNav"], function ( f31_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f31_arg0:get(),
                        modelName = "lobbyRoot.lobbyNav"
                  } )
            end, false )
            LUI.OverrideFunction_CallOriginalFirst( self, "setState", function ( element, controller, f32_arg2, f32_arg3, f32_arg4 )
                  if CoD.HUDUtility.ShouldPulseNewAmmo( self ) and IsSelfInState( self, "PowerBased" ) then
                        PlayClip( self, "Pulse", controller )
                  end
            end )
            self:linkToElementModel( self, "ammo", true, function ( model )
                  local f33_local0 = self
                  if IsSelfInState( self, "PowerBased" ) and CoD.HUDUtility.ShouldPulseNewAmmo( self ) then
                        PlayClip( self, "Pulse", f1_arg1 )
                  end
            end )
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            if PreLoadFunc then
                  PreLoadFunc( self, f1_arg1, f1_arg0 )
            end
            f1_local18 = self
            f1_local18 = HeroAbilityUseString
            if IsPC() then
                  CoD.PCWidgetUtility.EnableShrinkToFit( f1_local18 )
            end
            f1_local18 = HeroAbilityHoldString
            if IsPC() then
                  HideWidget( self.HeroAbilityHoldString )
            end
            return self
      end

      CoD.AmmoWidgetZM_AbilityItem.__resetProperties = function ( f34_arg0 )
            f34_arg0.NotAvailable:completeAnimation()
            f34_arg0.HeroAbilityUseString:completeAnimation()
            f34_arg0.FlareBack:completeAnimation()
            f34_arg0.PowerBasedImageUnavailable:completeAnimation()
            f34_arg0.PowerBasedImageAvailable:completeAnimation()
            f34_arg0.FullBackingDeployed:completeAnimation()
            f34_arg0.AmmoWidgetAbilityContainer:completeAnimation()
            f34_arg0.Glow:completeAnimation()
            f34_arg0.SecondaryWeaponBG:completeAnimation()
            f34_arg0.SecondaryWeaponMeterBG:completeAnimation()
            f34_arg0.SecondaryWeaponMeterBGBlur:completeAnimation()
            f34_arg0.SecondaryWeaponBGBlur:completeAnimation()
            f34_arg0.EquipmentBacking:completeAnimation()
            f34_arg0.ClockMeter:completeAnimation()
            f34_arg0.ClockMeterAdd:completeAnimation()
            f34_arg0.NotAvailable:setAlpha( 1 )
            f34_arg0.HeroAbilityUseString:setRGB( 1, 1, 1 )
            f34_arg0.HeroAbilityUseString:setAlpha( 1 )
            f34_arg0.FlareBack:setAlpha( 0 )
            f34_arg0.FlareBack:setScale( 1, 1 )
            f34_arg0.PowerBasedImageUnavailable:setRGB( 1, 1, 1 )
            f34_arg0.PowerBasedImageUnavailable:setAlpha( 0 )
            f34_arg0.PowerBasedImageAvailable:setAlpha( 1 )
            f34_arg0.FullBackingDeployed:setRGB( 0.84, 0.83, 0.77 )
            f34_arg0.FullBackingDeployed:setAlpha( 0 )
            f34_arg0.AmmoWidgetAbilityContainer:setAlpha( 0 )
            f34_arg0.Glow:setAlpha( 0 )
            f34_arg0.Glow:setMaterial( LUI.UIImage.GetCachedMaterial( @"ui_add" ) )
            f34_arg0.SecondaryWeaponBG:setAlpha( 1 )
            f34_arg0.SecondaryWeaponMeterBG:setAlpha( 1 )
            f34_arg0.SecondaryWeaponMeterBGBlur:setAlpha( 1 )
            f34_arg0.SecondaryWeaponBGBlur:setAlpha( 1 )
            f34_arg0.EquipmentBacking:setAlpha( 0.6 )
            f34_arg0.ClockMeter:setAlpha( 0 )
            f34_arg0.ClockMeterAdd:setAlpha( 0 )
      end

      CoD.AmmoWidgetZM_AbilityItem.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f35_arg0, f35_arg1 )
                        f35_arg0:__resetProperties()
                        f35_arg0:setupElementClipCounter( 3 )
                        f35_arg0.FlareBack:completeAnimation()
                        f35_arg0.FlareBack:setAlpha( 0 )
                        f35_arg0.clipFinished( f35_arg0.FlareBack )
                        f35_arg0.NotAvailable:completeAnimation()
                        f35_arg0.NotAvailable:setAlpha( 1 )
                        f35_arg0.clipFinished( f35_arg0.NotAvailable )
                        f35_arg0.HeroAbilityUseString:completeAnimation()
                        f35_arg0.HeroAbilityUseString:setRGB( 0.47, 0.47, 0.47 )
                        f35_arg0.HeroAbilityUseString:setAlpha( 0 )
                        f35_arg0.clipFinished( f35_arg0.HeroAbilityUseString )
                        f35_arg0.nextClip = "DefaultClip"
                  end
            },
            Hidden = {
                  DefaultClip = function ( f36_arg0, f36_arg1 )
                        f36_arg0:__resetProperties()
                        f36_arg0:setupElementClipCounter( 12 )
                        f36_arg0.SecondaryWeaponBGBlur:completeAnimation()
                        f36_arg0.SecondaryWeaponBGBlur:setAlpha( 0 )
                        f36_arg0.clipFinished( f36_arg0.SecondaryWeaponBGBlur )
                        f36_arg0.SecondaryWeaponBG:completeAnimation()
                        f36_arg0.SecondaryWeaponBG:setAlpha( 0 )
                        f36_arg0.clipFinished( f36_arg0.SecondaryWeaponBG )
                        f36_arg0.SecondaryWeaponMeterBGBlur:completeAnimation()
                        f36_arg0.SecondaryWeaponMeterBGBlur:setAlpha( 0 )
                        f36_arg0.clipFinished( f36_arg0.SecondaryWeaponMeterBGBlur )
                        f36_arg0.SecondaryWeaponMeterBG:completeAnimation()
                        f36_arg0.SecondaryWeaponMeterBG:setAlpha( 0 )
                        f36_arg0.clipFinished( f36_arg0.SecondaryWeaponMeterBG )
                        f36_arg0.Glow:completeAnimation()
                        f36_arg0.Glow:setAlpha( 0 )
                        f36_arg0.clipFinished( f36_arg0.Glow )
                        f36_arg0.AmmoWidgetAbilityContainer:completeAnimation()
                        f36_arg0.AmmoWidgetAbilityContainer:setAlpha( 0 )
                        f36_arg0.clipFinished( f36_arg0.AmmoWidgetAbilityContainer )
                        f36_arg0.FullBackingDeployed:completeAnimation()
                        f36_arg0.FullBackingDeployed:setAlpha( 0 )
                        f36_arg0.clipFinished( f36_arg0.FullBackingDeployed )
                        f36_arg0.EquipmentBacking:completeAnimation()
                        f36_arg0.EquipmentBacking:setAlpha( 0 )
                        f36_arg0.clipFinished( f36_arg0.EquipmentBacking )
                        f36_arg0.PowerBasedImageAvailable:completeAnimation()
                        f36_arg0.PowerBasedImageAvailable:setAlpha( 0 )
                        f36_arg0.clipFinished( f36_arg0.PowerBasedImageAvailable )
                        f36_arg0.PowerBasedImageUnavailable:completeAnimation()
                        f36_arg0.PowerBasedImageUnavailable:setAlpha( 0 )
                        f36_arg0.clipFinished( f36_arg0.PowerBasedImageUnavailable )
                        f36_arg0.NotAvailable:completeAnimation()
                        f36_arg0.NotAvailable:setAlpha( 0 )
                        f36_arg0.clipFinished( f36_arg0.NotAvailable )
                        f36_arg0.HeroAbilityUseString:completeAnimation()
                        f36_arg0.HeroAbilityUseString:setAlpha( 0 )
                        f36_arg0.clipFinished( f36_arg0.HeroAbilityUseString )
                  end
            },
            InUse = {
                  DefaultClip = function ( f37_arg0, f37_arg1 )
                        f37_arg0:__resetProperties()
                        f37_arg0:setupElementClipCounter( 4 )
                        f37_arg0.ClockMeter:completeAnimation()
                        f37_arg0.ClockMeter:setAlpha( 1 )
                        f37_arg0.clipFinished( f37_arg0.ClockMeter )
                        f37_arg0.ClockMeterAdd:completeAnimation()
                        f37_arg0.ClockMeterAdd:setAlpha( 1 )
                        f37_arg0.clipFinished( f37_arg0.ClockMeterAdd )
                        f37_arg0.NotAvailable:completeAnimation()
                        f37_arg0.NotAvailable:setAlpha( 0 )
                        f37_arg0.clipFinished( f37_arg0.NotAvailable )
                        f37_arg0.HeroAbilityUseString:completeAnimation()
                        f37_arg0.HeroAbilityUseString:setAlpha( 0 )
                        f37_arg0.clipFinished( f37_arg0.HeroAbilityUseString )
                        f37_arg0.nextClip = "DefaultClip"
                  end
            },
            Deployed = {
                  DefaultClip = function ( f38_arg0, f38_arg1 )
                        f38_arg0:__resetProperties()
                        f38_arg0:setupElementClipCounter( 2 )
                        f38_arg0.NotAvailable:completeAnimation()
                        f38_arg0.NotAvailable:setAlpha( 1 )
                        f38_arg0.clipFinished( f38_arg0.NotAvailable )
                        f38_arg0.HeroAbilityUseString:completeAnimation()
                        f38_arg0.HeroAbilityUseString:setRGB( 0.47, 0.47, 0.47 )
                        f38_arg0.HeroAbilityUseString:setAlpha( 1 )
                        f38_arg0.clipFinished( f38_arg0.HeroAbilityUseString )
                  end
            },
            PowerBasedEmptyCharging = {
                  DefaultClip = function ( f39_arg0, f39_arg1 )
                        f39_arg0:__resetProperties()
                        f39_arg0:setupElementClipCounter( 5 )
                        f39_arg0.FullBackingDeployed:completeAnimation()
                        f39_arg0.FullBackingDeployed:setRGB( 1, 1, 1 )
                        f39_arg0.FullBackingDeployed:setAlpha( 0.03 )
                        f39_arg0.clipFinished( f39_arg0.FullBackingDeployed )
                        f39_arg0.PowerBasedImageAvailable:completeAnimation()
                        f39_arg0.PowerBasedImageAvailable:setAlpha( 0 )
                        f39_arg0.clipFinished( f39_arg0.PowerBasedImageAvailable )
                        f39_arg0.PowerBasedImageUnavailable:completeAnimation()
                        f39_arg0.PowerBasedImageUnavailable:setAlpha( 1 )
                        f39_arg0.clipFinished( f39_arg0.PowerBasedImageUnavailable )
                        f39_arg0.NotAvailable:completeAnimation()
                        f39_arg0.NotAvailable:setAlpha( 1 )
                        f39_arg0.clipFinished( f39_arg0.NotAvailable )
                        f39_arg0.HeroAbilityUseString:completeAnimation()
                        f39_arg0.HeroAbilityUseString:setAlpha( 0 )
                        f39_arg0.clipFinished( f39_arg0.HeroAbilityUseString )
                  end
            },
            PowerBasedCharging = {
                  DefaultClip = function ( f40_arg0, f40_arg1 )
                        f40_arg0:__resetProperties()
                        f40_arg0:setupElementClipCounter( 6 )
                        f40_arg0.ClockMeter:completeAnimation()
                        f40_arg0.ClockMeter:setAlpha( 1 )
                        f40_arg0.clipFinished( f40_arg0.ClockMeter )
                        f40_arg0.FullBackingDeployed:completeAnimation()
                        f40_arg0.FullBackingDeployed:setAlpha( 0 )
                        f40_arg0.clipFinished( f40_arg0.FullBackingDeployed )
                        f40_arg0.PowerBasedImageAvailable:completeAnimation()
                        f40_arg0.PowerBasedImageAvailable:setAlpha( 0 )
                        f40_arg0.clipFinished( f40_arg0.PowerBasedImageAvailable )
                        f40_arg0.PowerBasedImageUnavailable:completeAnimation()
                        f40_arg0.PowerBasedImageUnavailable:setRGB( 1, 1, 1 )
                        f40_arg0.PowerBasedImageUnavailable:setAlpha( 1 )
                        f40_arg0.clipFinished( f40_arg0.PowerBasedImageUnavailable )
                        f40_arg0.NotAvailable:completeAnimation()
                        f40_arg0.NotAvailable:setAlpha( 1 )
                        f40_arg0.clipFinished( f40_arg0.NotAvailable )
                        f40_arg0.HeroAbilityUseString:completeAnimation()
                        f40_arg0.HeroAbilityUseString:setAlpha( 0 )
                        f40_arg0.clipFinished( f40_arg0.HeroAbilityUseString )
                  end
            },
            PowerBased = {
                  DefaultClip = function ( f41_arg0, f41_arg1 )
                        f41_arg0:__resetProperties()
                        f41_arg0:setupElementClipCounter( 7 )
                        f41_arg0.ClockMeter:completeAnimation()
                        f41_arg0.ClockMeter:setAlpha( 1 )
                        f41_arg0.clipFinished( f41_arg0.ClockMeter )
                        local f41_local0 = function ( f42_arg0 )
                              local f42_local0 = function ( f43_arg0 )
                                    local f43_local0 = function ( f44_arg0 )
                                          f44_arg0:beginAnimation( 2320 )
                                          f44_arg0:registerEventHandler( "transition_complete_keyframe", f41_arg0.clipFinished )
                                    end
                                    
                                    f43_arg0:beginAnimation( 340 )
                                    f43_arg0:setAlpha( 0 )
                                    f43_arg0:registerEventHandler( "transition_complete_keyframe", f43_local0 )
                              end
                              
                              f41_arg0.ClockMeterAdd:beginAnimation( 340 )
                              f41_arg0.ClockMeterAdd:setAlpha( 1 )
                              f41_arg0.ClockMeterAdd:registerEventHandler( "interrupted_keyframe", f41_arg0.clipInterrupted )
                              f41_arg0.ClockMeterAdd:registerEventHandler( "transition_complete_keyframe", f42_local0 )
                        end
                        
                        f41_arg0.ClockMeterAdd:completeAnimation()
                        f41_arg0.ClockMeterAdd:setAlpha( 0 )
                        f41_local0( f41_arg0.ClockMeterAdd )
                        f41_arg0.FlareBack:completeAnimation()
                        f41_arg0.FlareBack:setAlpha( 0 )
                        f41_arg0.FlareBack:setScale( 0.5, 0.5 )
                        f41_arg0.clipFinished( f41_arg0.FlareBack )
                        f41_arg0.Glow:completeAnimation()
                        f41_arg0.Glow:setAlpha( 0.1 )
                        f41_arg0.Glow:setMaterial( LUI.UIImage.GetCachedMaterial( @"ui_add" ) )
                        f41_arg0.clipFinished( f41_arg0.Glow )
                        f41_arg0.PowerBasedImageUnavailable:completeAnimation()
                        f41_arg0.PowerBasedImageUnavailable:setRGB( 0.74, 0.69, 0.42 )
                        f41_arg0.PowerBasedImageUnavailable:setAlpha( 0 )
                        f41_arg0.clipFinished( f41_arg0.PowerBasedImageUnavailable )
                        f41_arg0.NotAvailable:completeAnimation()
                        f41_arg0.NotAvailable:setAlpha( 1 )
                        f41_arg0.clipFinished( f41_arg0.NotAvailable )
                        f41_arg0.HeroAbilityUseString:completeAnimation()
                        f41_arg0.HeroAbilityUseString:setRGB( 1, 1, 1 )
                        f41_arg0.HeroAbilityUseString:setAlpha( 1 )
                        f41_arg0.clipFinished( f41_arg0.HeroAbilityUseString )
                        f41_arg0.nextClip = "DefaultClip"
                  end,
                  Pulse = function ( f45_arg0, f45_arg1 )
                        f45_arg0:__resetProperties()
                        f45_arg0:setupElementClipCounter( 3 )
                        f45_arg0.ClockMeter:completeAnimation()
                        f45_arg0.ClockMeter:setAlpha( 1 )
                        f45_arg0.clipFinished( f45_arg0.ClockMeter )
                        local f45_local0 = function ( f46_arg0 )
                              local f46_local0 = function ( f47_arg0 )
                                    local f47_local0 = function ( f48_arg0 )
                                          f48_arg0:beginAnimation( 2320 )
                                          f48_arg0:registerEventHandler( "transition_complete_keyframe", f45_arg0.clipFinished )
                                    end
                                    
                                    f47_arg0:beginAnimation( 340 )
                                    f47_arg0:setAlpha( 0 )
                                    f47_arg0:registerEventHandler( "transition_complete_keyframe", f47_local0 )
                              end
                              
                              f45_arg0.ClockMeterAdd:beginAnimation( 340 )
                              f45_arg0.ClockMeterAdd:setAlpha( 1 )
                              f45_arg0.ClockMeterAdd:registerEventHandler( "interrupted_keyframe", f45_arg0.clipInterrupted )
                              f45_arg0.ClockMeterAdd:registerEventHandler( "transition_complete_keyframe", f46_local0 )
                        end
                        
                        f45_arg0.ClockMeterAdd:completeAnimation()
                        f45_arg0.ClockMeterAdd:setAlpha( 0 )
                        f45_local0( f45_arg0.ClockMeterAdd )
                        f45_arg0.NotAvailable:completeAnimation()
                        f45_arg0.NotAvailable:setAlpha( 1 )
                        f45_arg0.clipFinished( f45_arg0.NotAvailable )
                        f45_arg0.nextClip = "Pulse"
                  end
            }
      }

      CoD.AmmoWidgetZM_AbilityItem.__onClose = function ( f49_arg0 )
            f49_arg0.ClockMeter:close()
            f49_arg0.ClockMeterAdd:close()
            f49_arg0.AmmoWidgetAbilityContainer:close()
            f49_arg0.PowerBasedImageAvailable:close()
            f49_arg0.PowerBasedImageUnavailable:close()
            f49_arg0.NotAvailable:close()
            f49_arg0.HeroAbilityUseString:close()
            f49_arg0.HeroAbilityHoldString:close()
            f49_arg0.HeroAbilityHoldStringPC:close()
      end
end

CoD.ApplyAltHud = function(hud, controller)
	local SafeArea = hud.SafeAreaContainer

	local AmmoWidget = SafeArea.AmmoWidgetZMContainer
	local AmmoWidgetMain = AmmoWidget.AmmoWidgetZM

	local RiotShieldHealth = SafeArea.RiotShieldHealth
	
	local SpecialsCont = AmmoWidgetMain.AmmoWidgetZMAbilityOrWeaponContainer
	local SpecialsLevel = AmmoWidgetMain.specialWeaponLevel
	local EquipmentsCont = AmmoWidgetMain.Equipment

	local Specials = AmmoWidgetMain.AmmoWidgetZMAbilityOrWeaponContainer.Ability
	local Equipments = AmmoWidgetMain.Equipment.Equipment

	local AmmoCount = AmmoWidgetMain.WeaponAmmoCount.WeaponAmmoCount
	local AmmoText = AmmoWidgetMain.WeaponAmmoCount.WeaponAmmoCount.Clip.Clip.Clip
	local AmmoTextDual = AmmoWidgetMain.WeaponAmmoCount.WeaponAmmoCount.ClipDual.Clip.Clip
	local AmmoTextOnly = AmmoWidgetMain.WeaponAmmoCount.WeaponAmmoCount.ClipOnly.Clip.Clip
	local AmmoTextOnlyShadow = AmmoWidgetMain.WeaponAmmoCount.WeaponAmmoCount.ClipOnly.Clip.ClipShadow
	local AmmoTextShadow = AmmoWidgetMain.WeaponAmmoCount.WeaponAmmoCount.Clip.Clip.ClipShadow
	local AmmoTextDualShadow = AmmoWidgetMain.WeaponAmmoCount.WeaponAmmoCount.ClipDual.Clip.ClipShadow
	local ClipDual = AmmoWidgetMain.WeaponAmmoCount.WeaponAmmoCount.ClipDual
	local AmmoLine = AmmoWidgetMain.WeaponAmmoCount.WeaponAmmoCount.TabBottomLine
	local AmmoLine2 = AmmoWidgetMain.WeaponAmmoCount.WeaponAmmoCount.TabBottomLine2
	local TotalAmmoText = AmmoWidgetMain.WeaponAmmoCount.WeaponAmmoCount.TotalAmmoLabel

	local WeaponImage = AmmoWidgetMain.WeaponAmmoCount.WeaponImage

	local Rounds = SafeArea.Rounds
	local RoundContainer = Rounds.ZmRnd
	local RndDigits = RoundContainer.RndDigits
	local DigitsInt = RndDigits.DigitsInt
	local ZmRndDigitWidget = DigitsInt.ZmRndDigitWidget
	local ZmRndDigitWidget0 = DigitsInt.ZmRndDigitWidget0
	local ZmRndDigitWidget1 = DigitsInt.ZmRndDigitWidget1

	local PerksLogic = SafeArea.ZMPerkVaporsContainer
	local BackingPerks = PerksLogic.Image
	
	local PlayerWidget = SafeArea.PlayerWidget
	local ExtraPerks = PlayerWidget.ZMExtraPerkVapors

	local HealthInfo = PlayerWidget.HealthValue
	local HealthValue = HealthInfo.HealthValue
	local HealthBar = HealthInfo.HealthBar
	local ArmorBar = HealthInfo.ArmorBar
	local ArmorPortrait = HealthInfo.ArmorPortrait -- icon prob

	local Score = PlayerWidget.Score
	local ScoreShadow = PlayerWidget.ScoreShadow

	local AmmoPC = SafeArea.AmmoPC
	local ZmAmmoFac = AmmoPC.ZmAmmo
	local ZmAmmoProb = ZmAmmoFac.ZmAmmoProp0
	local BGBFac = ZmAmmoProb.ZmAmmoBGBCarouselFactory

	local ElixirsPC = BGBFac.PCButtons -- pc
	local ElixirsConsole = BGBFac.buttons -- console...

	local ScorePC = SafeArea.ScorePC
	local MuleKick = AmmoWidgetMain.MuleKick

	MuleKick:setTopBottom(0, 0, 26.5 - 15, 66.5 - 15)

	AmmoCount:setLeftRight(0.00, 0.00, -500.00, -3.00)
	AmmoCount:setTopBottom(0.00, 0.00, 20.00, 100.00)

	WeaponImage:setLeftRight(0.00, 0.00, 65.00, 87.00)
	WeaponImage:setTopBottom(0.00, 0.00, 20.00, 73.00)

	ElixirsPC.FourthElixirBG:setScale(0, 0)
	ElixirsPC.FourthElixirBGWipe:setScale(0, 0)
	ElixirsPC.FourthElixirFrame:setScale(0, 0)
	ElixirsPC.ThirdElixirBG:setScale(0, 0)
	ElixirsPC.ThirdElixirBGWipe:setScale(0, 0)
	ElixirsPC.ThirdElixirFrame:setScale(0, 0)
	ElixirsPC.SecondElixirBG:setScale(0, 0)
	ElixirsPC.SecondElixirBGWipe:setScale(0, 0)
	ElixirsPC.SecondElixirFrame:setScale(0, 0)
	ElixirsPC.FirstElixirBG:setScale(0, 0)
	ElixirsPC.FirstElixirBGWipe:setScale(0, 0)
	ElixirsPC.FirstElixirFrame:setScale(0, 0)

	ElixirsPC.FirstBGBKeybind:setLeftRight(0.5, 0.5, 20.5 + 35, 123.5 + 35)
	ElixirsPC.SecondBGBKeybind:setLeftRight(0.5, 0.5, 20.5 + 35, 123.5 + 35)
	ElixirsPC.ThirdBGBKeybind:setLeftRight(0.5, 0.5, 20.5 + 35, 123.5 + 35)
	ElixirsPC.ThirdBGBKeybind2:setLeftRight(0.5, 0.5, 20.5 + 35, 123.5 + 35)
	
	PlayerWidget.Backing:setScale(0, 0)
	PlayerWidget.BackingBlur:setScale(0, 0)

	PlayerWidget.headshotBarBacking:setScale(0.65, 0.65)
	--PlayerWidget.headshotBarBacking:setLeftRight(1, 1, -67, 68)

	ExtraPerks:setLeftRight(0, 0, 201 + 200 + 115, 631 + 200 + 115)
	ExtraPerks:setTopBottom(0, 0, -28.5 + 57, 69.5 + 57)
	
	PerksLogic:setLeftRight(0, 0, -250 + 315 - 55 + 130, 250 + 315 + 130)
	PerksLogic:setTopBottom(1, 1, -159, -34)

	-- cause normal icons
	ExtraPerks:setSpacing(-32.5)

	if Engine[@"getdvarint"]("shield_enh_ClassicMode") == 1 then
			PerksLogic:setLeftRight(0, 0, -250 + 315 - 55, 250 + 315)
			
			--ExtraPerks:setSpacing(-32.5)
			--ExtraPerks:setScale(0.85, 0.85)
			ExtraPerks:setLeftRight(0, 0, 201 + 200, 631 + 200)
	end

	if Engine[@"getdvarint"]("shield_enh_ClassicMode") == 1 then
			PlayerWidget:setTopBottom(1, 1, -145 - 100, -33 - 100)
			--PlayerWidget.SelfReviveCounter:setTopBottom(0, 0, 69.5 - 80, 114.5 - 80)

			ScorePC.Listing2:setScale(0.8, 0.8)
			ScorePC.Listing2:setTopBottom(0, 0, 188 - 60, 276 - 60)

			ScorePC.Listing3:setScale(0.8, 0.8)
			ScorePC.Listing3:setTopBottom(0, 0, 104 - 40, 192 - 40)

			ScorePC.Listing4:setScale(0.8, 0.8)
			ScorePC.Listing4:setTopBottom(0, 0, 20 - 20, 108 - 20)

			--ScorePC.ZMScrPlusPoints0:setTopBottom(0, 0, 276 - 65, 375 - 65)

			ScorePC.ZMScrPlusPoints1:setTopBottom(0, 0, 184 - 60, 283 - 60)

			ScorePC.ZMScrPlusPoints2:setTopBottom(0, 0, 100.5 - 40, 199.5 - 40)

			ScorePC.ZMScrPlusPoints3:setTopBottom(0, 0, 9 - 20, 108 - 20)

			Rounds:setTopBottom(1, 1, 36 + 225, -252 + 225)
			
			-- player widget moved sooooo
			ExtraPerks:setTopBottom(0, 0, -28.5 + 157, 69.5 + 157)
	else
			ScorePC.Listing2:setScale(0.8, 0.8)
			ScorePC.Listing2:setTopBottom(0, 0, 188 + 60, 276 + 60)

			ScorePC.Listing3:setScale(0.8, 0.8)
			ScorePC.Listing3:setTopBottom(0, 0, 104 + 80, 192 + 80)

			ScorePC.Listing4:setScale(0.8, 0.8)
			ScorePC.Listing4:setTopBottom(0, 0, 20 + 100, 108 + 100)

			ScorePC.ZMScrPlusPoints0:setTopBottom(0, 0, 276 + 20, 375 + 20)

			ScorePC.ZMScrPlusPoints1:setTopBottom(0, 0, 184 + 60, 283 + 60)

			ScorePC.ZMScrPlusPoints2:setTopBottom(0, 0, 100.5 + 80, 199.5 + 80)

			ScorePC.ZMScrPlusPoints3:setTopBottom(0, 0, 9 + 100, 108 + 100)
	end

	-- other players
	ScorePC.Listing2.AllyBGMainBlur:setScale(0, 0)
	ScorePC.Listing2.AllyBGMain:setScale(0, 0)
	ScorePC.Listing3.AllyBGMainBlur:setScale(0, 0)
	ScorePC.Listing3.AllyBGMain:setScale(0, 0)
	ScorePC.Listing4.AllyBGMainBlur:setScale(0, 0)
	ScorePC.Listing4.AllyBGMain:setScale(0, 0)

	ScorePC.ZMScrPlusPoints0.ZMScrPlusPoints.Label1:setTTF("notosans_bold")
	ScorePC.ZMScrPlusPoints0.ZMScrPlusPoints.Label2:setTTF("notosans_bold")
	ScorePC.ZMScrPlusPoints1.ZMScrPlusPoints.Label1:setTTF("notosans_bold")
	ScorePC.ZMScrPlusPoints1.ZMScrPlusPoints.Label2:setTTF("notosans_bold")
	ScorePC.ZMScrPlusPoints2.ZMScrPlusPoints.Label1:setTTF("notosans_bold")
	ScorePC.ZMScrPlusPoints2.ZMScrPlusPoints.Label2:setTTF("notosans_bold")
	ScorePC.ZMScrPlusPoints3.ZMScrPlusPoints.Label1:setTTF("notosans_bold")
	ScorePC.ZMScrPlusPoints3.ZMScrPlusPoints.Label2:setTTF("notosans_bold")

	RiotShieldHealth:setLeftRight(1.00, 1.00, -230.00, -155.00)
	RiotShieldHealth:setTopBottom(1.00, 1.00, -180.00, -38.00)

	RiotShieldHealth:setScale(0.45, 0.45)

	SpecialsLevel:setLeftRight(0.00, 0.00, 322.00, 192.00)
	SpecialsLevel:setTopBottom(0.00, 0.00, 100.00, 80.00)
	SpecialsLevel:setScale(0.6, 0.6)
	
	SpecialsCont:setLeftRight(0, 0, 84.5 + 50, 156.5 + 50)

	EquipmentsCont:setLeftRight(0.00, 0.00, 385.00 - 20.0, 235.00 - 20.0)
	EquipmentsCont:setTopBottom(0.00, 0.00, 50.00, 149.00)

	EquipmentsCont:setScale(0.75, 0.75)

	Specials:setScale(0.75, 0.75)

	Specials:setLeftRight( 0.00, 0.00, 155.00, 227.00 )
	Specials:setTopBottom( 0.00, 0.00, -35.00, 24.00 )

	Equipments.SecondaryWeaponBGBlur:setScale(0, 0)
	--Equipments.SecondaryWeaponBG:setScale(0, 0)
	Equipments.FullBackingDeployed:setScale(0, 0)
	Equipments.EquipmentBacking:setScale(0, 0)

	Specials.SecondaryWeaponBGBlur:setScale(0, 0)
	--Specials.SecondaryWeaponBG:setScale(0, 0)
	Specials.FullBackingDeployed:setScale(0, 0)
	Specials.EquipmentBacking:setScale(0, 0)

	Score:setTTF("notosans_bold")
	ScoreShadow:setTTF("notosans_bold")

	--Score:setTopBottom(0.85, 0.85, 0, 80)
	--Score:setLeftRight(0, 0, 115, 244)
	--self:addElement(Score) -- fucking hjack it

	--ScoreShadow:setScale(0, 0)
	--HealthValue:setScale(0, 0)

	if Engine[@"getdvarint"]("shield_enh_ClassicMode") == 1 then
		Equipments.ClockMeter:setScale(0, 0)
		Equipments.ClockMeterAdd:setScale(0, 0)
		Equipments.SecondaryWeaponMeterBG:setScale(0, 0)
		Equipments.SecondaryWeaponMeterBGBlur:setScale(0, 0)

		CoD.EnhModPrintInfo("Removed Meter, BGB, WeaponList")
	end

	if Engine[@"getdvarint"]("shield_enh_ClassicMode") == 1 and Engine[@"getdvarint"]("shield_enh_ClassicMode_Loadouts") == 1 then
		BGBFac:setAlpha(0)
	end

	AmmoWidgetMain.WeaponEquippedList:setScale(0, 0)

	if Engine[@"getdvarint"]("shield_enh_ClassicMode") ~= 1 then
			HealthValue:setTopBottom(0, 0, 30 + 15, 55 + 15)
			HealthValue:setLeftRight(0, 0, 64 + 2.8, 168 + 2.8)
			HealthValue:setTTF("notosans_bold")

			HealthBar:setLeftRight(0, 0, 123 - 47.2, 275 - 47.2)
			HealthBar.HealthFill:setRGB(0, 1, 1)
	else
			HealthValue:setScale(0, 0)
			HealthBar:setScale(0, 0)
	end

	ArmorBar:setLeftRight(0, 0, 132 - 47.2, 266 - 47.2)
	ArmorPortrait:setLeftRight(0, 0, 264 - 47.2, 314 - 47.2)

	-- remove
	BackingPerks:setTopBottom(3, 3, 0, 0)
	BackingPerks:setAlpha(0)

	AmmoWidgetMain.Backing:setAlpha(0)
	-- better backing?

	AmmoWidgetMain.Backing:setLeftRight(0.00, 0.00, 200.00, 620.00)
	AmmoWidgetMain.Backing:setTopBottom(0.00, 0.00, 50.00, 200.00)
	AmmoWidgetMain.Backing:setRGB(1, 0, 0)
	AmmoWidgetMain.Backing:setScale(0, 0)

	AmmoWidgetMain.Backing:setImage(RegisterImage(@"enh_ammo_alt"))

	Equipments.SecondaryWeaponBG:setImage(RegisterImage(@"enh_blood_ammo_small"))
	Specials.SecondaryWeaponBG:setImage(RegisterImage(@"enh_blood_ammo_small"))

	Specials.IsSpecial = true

	Equipments.SecondaryWeaponBG:setRGB(1, 1, 1)
	Specials.SecondaryWeaponBG:setRGB(1, 1, 1)

	Equipments.SecondaryWeaponBG:setTopBottom(0, 0, -7 + 7.5, 73 - 7.5)
	Specials.SecondaryWeaponBG:setTopBottom(0, 0, -7 - 10, 73 + 15)
	Specials.SecondaryWeaponBG:setLeftRight(0.5, 0.5, -38 - 5, 38 + 1)

	Specials.SecondaryWeaponBG:setAlpha(0)
	Equipments.SecondaryWeaponBG:setAlpha(0)
	Equipments.SecondaryWeaponBG:setScale(0, 0)
	Specials.SecondaryWeaponBG:setScale(0, 0)

	Specials.HeroAbilityUseString:setTopBottom(3, 3, 0, 0)
	Specials.HeroAbilityUseString:setAlpha(0)
	Specials.HeroAbilityUseString:setScale(0, 0)

	Equipments.HeroAbilityUseString:setTopBottom(3, 3, 0, 0)
	Equipments.HeroAbilityUseString:setAlpha(0)
	Equipments.HeroAbilityUseString:setScale(0, 0)

	AmmoWidgetMain.BackingBlur:setAlpha(0)

	AmmoWidgetMain.aatText:setTTF("notosans_bold")

	-- fix
	--AmmoWidgetMain.aatText:setTopBottom(0, 0, 34.5 - 40, 54.5 - 40)
	--AmmoWidgetMain.AATIcon:setTopBottom(0, 0, 9.5 - 40, 81.5 - 40)

	AmmoWidgetMain.aatText:setLeftRight(0, 0, 495, 629)
	AmmoWidgetMain.aatText:setTopBottom(0, 0, 34 + 10, 54 + 10)

	AmmoWidgetMain.AATIcon:setLeftRight(0, 0, 430, 500)
	AmmoWidgetMain.AATIcon:setTopBottom(0, 0, 9 + 10, 81 + 10)

	AmmoText:setTTF("notosans_bold")
	AmmoTextDual:setTTF("notosans_bold")

	AmmoTextDualShadow:setTTF("notosans_bold")
	AmmoTextShadow:setTTF("notosans_bold")

	AmmoTextOnly:setTTF("notosans_bold")
	AmmoTextOnlyShadow:setTTF("notosans_bold")

	-- remove it
	AmmoLine:setAlpha(0)
	AmmoLine2:setAlpha(0)
	AmmoLine:setLeftRight(-1, -1, 0, 0)
	AmmoLine2:setLeftRight(-1, -1, 0, 0)

	TotalAmmoText:setTopBottom(0.00, 0.00, 10.00, 48.00)
	TotalAmmoText:setLeftRight(0.00, 1.00, 120.00, 0.00)
	TotalAmmoText:setTTF("notosans_bold")

	local NoChange = false

	if Engine[@"getdvarint"]("shield_enh_RoundColor") == 1 then
			Rounds:setRGB(1, 0, 1)
	elseif Engine[@"getdvarint"]("shield_enh_RoundColor") == 2 then
			Rounds:setRGB(0, 0, 1)
	elseif Engine[@"getdvarint"]("shield_enh_RoundColor") == 3 then
			Rounds:setRGB(0, 1, 0)
	elseif Engine[@"getdvarint"]("shield_enh_RoundColor") == 4 then
			NoChange = true
	end

	if NoChange == false then
			-- change from def to act (to change colors)
			-- mrks
			RoundContainer.Mrk1Def:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_mrk1act" ))

			RoundContainer.Mrk2Def:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_mrk2act" ))
			RoundContainer.Mrk3Def:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_mrk3act" ))
			RoundContainer.Mrk4Def:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_mrk4act" ))
			RoundContainer.Mrk5Def:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_mrk5act" ))

			-- first number
			ZmRndDigitWidget.Zero:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr0_act" ))
			ZmRndDigitWidget.One:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr1_act" ))
			ZmRndDigitWidget.Two:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr2_act" ))
			ZmRndDigitWidget.Three:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr3_act" ))
			ZmRndDigitWidget.Four:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr4_act" ))
			ZmRndDigitWidget.Five:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr5_act" ))
			ZmRndDigitWidget.Six:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr6_act" ))
			ZmRndDigitWidget.Seven:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr7_act" ))
			ZmRndDigitWidget.Eight:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr8_act" ))
			ZmRndDigitWidget.Nine:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr9_act" ))

			-- second number
			ZmRndDigitWidget0.Zero:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr0_act" ))
			ZmRndDigitWidget0.One:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr1_act" ))
			ZmRndDigitWidget0.Two:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr2_act" ))
			ZmRndDigitWidget0.Three:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr3_act" ))
			ZmRndDigitWidget0.Four:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr4_act" ))
			ZmRndDigitWidget0.Five:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr5_act" ))
			ZmRndDigitWidget0.Six:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr6_act" ))
			ZmRndDigitWidget0.Seven:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr7_act" ))
			ZmRndDigitWidget0.Eight:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr8_act" ))
			ZmRndDigitWidget0.Nine:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr9_act" ))

			-- three number
			ZmRndDigitWidget1.Zero:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr0_act" ))
			ZmRndDigitWidget1.One:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr1_act" ))
			ZmRndDigitWidget1.Two:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr2_act" ))
			ZmRndDigitWidget1.Three:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr3_act" ))
			ZmRndDigitWidget1.Four:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr4_act" ))
			ZmRndDigitWidget1.Five:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr5_act" ))
			ZmRndDigitWidget1.Six:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr6_act" ))
			ZmRndDigitWidget1.Seven:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr7_act" ))
			ZmRndDigitWidget1.Eight:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr8_act" ))
			ZmRndDigitWidget1.Nine:setImage(RegisterImage( @"uie_t7_zm_hud_rnd_nmbr9_act" ))
	end

	CoD.EnhModPrintInfo("Loaded Alternative HUDS!")
end

-- fix pos if downed
CoD.WeaponPosAltHudFix = function()
	CoD.AmmoWidgetZM_WeaponInfo = InheritFrom( LUI.UIElement )
	CoD.AmmoWidgetZM_WeaponInfo.__defaultWidth = 239
	CoD.AmmoWidgetZM_WeaponInfo.__defaultHeight = 97
	CoD.AmmoWidgetZM_WeaponInfo.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
		local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
		self:setClass( CoD.AmmoWidgetZM_WeaponInfo )
		self.id = "AmmoWidgetZM_WeaponInfo"
		self.soundSet = "default"
		self.anyChildUsesUpdateState = true
		f1_arg0:addElementToPendingUpdateStateList( self )
		
		local WeaponImage = CoD.AmmoWidgetZM_WeaponImage.new( f1_arg0, f1_arg1, 0, 0, -44, 120, 0, 0, 20.5, 73.5 )
		WeaponImage:linkToElementModel( self, nil, false, function ( model )
				WeaponImage:setModel( model, f1_arg1 )
		end )
		self:addElement( WeaponImage )
		self.WeaponImage = WeaponImage
		
		local WeaponAmmoCount = CoD.AmmoWidgetZM_ClipInfo.new( f1_arg0, f1_arg1, 0, 0, -123, -3, 0, 0, 0, 80 )
		WeaponAmmoCount:linkToElementModel( self, nil, false, function ( model )
				WeaponAmmoCount:setModel( model, f1_arg1 )
		end )
		self:addElement( WeaponAmmoCount )
		self.WeaponAmmoCount = WeaponAmmoCount
		
		local grappleWeapon = LUI.UIImage.new( 0, 0, 142, 207, 0, 0, -28, 2 )
		grappleWeapon:setAlpha( 0 )
		grappleWeapon:setZRot( -70 )
		grappleWeapon:linkToElementModel( self, "dwGrappleWeapon", true, function ( model )
				local f4_local0 = model:get()
				if f4_local0 ~= nil then
					grappleWeapon:setImage( RegisterImage( GetHudImageFromItemIndex( f4_local0 ) ) )
				end
		end )
		self:addElement( grappleWeapon )
		self.grappleWeapon = grappleWeapon
		
		local AmmoHeal_Prompt = CoD.AmmoWidgetZM_Prompt.new( f1_arg0, f1_arg1, 0, 0, -105, -41, 0, 0, 78, 90 )
		AmmoHeal_Prompt:mergeStateConditions( {
				{
					stateName = "LowAmmo",
					condition = function ( menu, element, event )
							return AlwaysFalse()
					end
				},
				{
					stateName = "LowHealth",
					condition = function ( menu, element, event )
							return AlwaysFalse()
					end
				}
		} )
		AmmoHeal_Prompt:setAlpha( 0 )
		self:addElement( AmmoHeal_Prompt )
		self.AmmoHeal_Prompt = AmmoHeal_Prompt
		
		self:mergeStateConditions( {
				{
					stateName = "NoAmmoWeapon",
					condition = function ( menu, element, event )
							return CoD.HUDUtility.IsCurrentViewmodelWeaponGamemodeHiddenAmmo( f1_arg1 )
					end
				},
				{
					stateName = "MP",
					condition = function ( menu, element, event )
							return IsMultiplayer()
					end
				}
		} )
		local f1_local5 = self
		local f1_local6 = self.subscribeToModel
		local f1_local7 = DataSources.CurrentWeapon.getModel( f1_arg1 )
		f1_local6( f1_local5, f1_local7.viewmodelWeaponName, function ( f9_arg0 )
				f1_arg0:updateElementState( self, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = f9_arg0:get(),
					modelName = "viewmodelWeaponName"
				} )
		end, false )
		f1_local5 = self
		f1_local6 = self.subscribeToModel
		f1_local7 = Engine[@"getglobalmodel"]()
		f1_local6( f1_local5, f1_local7["lobbyRoot.lobbyNav"], function ( f10_arg0 )
				f1_arg0:updateElementState( self, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = f10_arg0:get(),
					modelName = "lobbyRoot.lobbyNav"
				} )
		end, false )
		LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
		
		if PostLoadFunc then
				PostLoadFunc( self, f1_arg1, f1_arg0 )
		end
		
		return self
	end

	CoD.AmmoWidgetZM_WeaponInfo.__resetProperties = function ( f11_arg0 )
		f11_arg0.WeaponImage:completeAnimation()
		f11_arg0.WeaponAmmoCount:completeAnimation()
		f11_arg0.grappleWeapon:completeAnimation()
		f11_arg0.AmmoHeal_Prompt:completeAnimation()

		if Engine[@"getdvarint"]("shield_enh_AltHud") ~= 1 then
				f11_arg0.WeaponImage:setLeftRight( 0, 0, -44, 120 )
		end

		f11_arg0.WeaponImage:setAlpha( 1 )
		f11_arg0.WeaponAmmoCount:setAlpha( 1 )
		f11_arg0.grappleWeapon:setAlpha( 0 )
		f11_arg0.AmmoHeal_Prompt:setAlpha( 0 )
	end

	CoD.AmmoWidgetZM_WeaponInfo.__clipsPerState = {
		DefaultState = {
				DefaultClip = function ( f12_arg0, f12_arg1 )
					f12_arg0:__resetProperties()
					f12_arg0:setupElementClipCounter( 1 )
					f12_arg0.WeaponImage:completeAnimation()

					if Engine[@"getdvarint"]("shield_enh_AltHud") ~= 1 then
							f12_arg0.WeaponImage:setLeftRight( 0, 0, -77, 87 )
					end
					
					f12_arg0.clipFinished( f12_arg0.WeaponImage )
				end
		},
		NoAmmoWeapon = {
				DefaultClip = function ( f13_arg0, f13_arg1 )
					f13_arg0:__resetProperties()
					f13_arg0:setupElementClipCounter( 4 )
					f13_arg0.WeaponImage:completeAnimation()
					f13_arg0.WeaponImage:setAlpha( 0 )
					f13_arg0.clipFinished( f13_arg0.WeaponImage )
					f13_arg0.WeaponAmmoCount:completeAnimation()
					f13_arg0.WeaponAmmoCount:setAlpha( 0 )
					f13_arg0.clipFinished( f13_arg0.WeaponAmmoCount )
					f13_arg0.grappleWeapon:completeAnimation()
					f13_arg0.grappleWeapon:setAlpha( 0 )
					f13_arg0.clipFinished( f13_arg0.grappleWeapon )
					f13_arg0.AmmoHeal_Prompt:completeAnimation()
					f13_arg0.AmmoHeal_Prompt:setAlpha( 0 )
					f13_arg0.clipFinished( f13_arg0.AmmoHeal_Prompt )
				end
		},
		MP = {
				DefaultClip = function ( f14_arg0, f14_arg1 )
					f14_arg0:__resetProperties()
					f14_arg0:setupElementClipCounter( 1 )
					f14_arg0.WeaponImage:completeAnimation()
					f14_arg0.WeaponImage:setAlpha( 1 )
					f14_arg0.clipFinished( f14_arg0.WeaponImage )
				end
		}
	}

	CoD.AmmoWidgetZM_WeaponInfo.__onClose = function ( f15_arg0 )
		f15_arg0.WeaponImage:close()
		f15_arg0.WeaponAmmoCount:close()
		f15_arg0.grappleWeapon:close()
		f15_arg0.AmmoHeal_Prompt:close()
	end

	CoD.AmmoWidgetZM_WeaponImage = InheritFrom( LUI.UIElement )
	CoD.AmmoWidgetZM_WeaponImage.__defaultWidth = 164
	CoD.AmmoWidgetZM_WeaponImage.__defaultHeight = 50
	CoD.AmmoWidgetZM_WeaponImage.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
		local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
		self:setClass( CoD.AmmoWidgetZM_WeaponImage )
		self.id = "AmmoWidgetZM_WeaponImage"
		self.soundSet = "default"
		self.anyChildUsesUpdateState = true
		
		local PowerWeaponDrainGadget3 = CoD.AmmoWidgetZM_PowerWeaponDrain.new( f1_arg0, f1_arg1, 0, 0, -290, -125, 0, 0, -19.5, 41.5 )
		PowerWeaponDrainGadget3:setAlpha( 0 )
		PowerWeaponDrainGadget3.Empty:setRGB( ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b )
		PowerWeaponDrainGadget3.Fill2:setRGB( ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b )
		PowerWeaponDrainGadget3.Fill:setRGB( ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b )
		PowerWeaponDrainGadget3.Fill3:setRGB( ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b )
		PowerWeaponDrainGadget3:subscribeToGlobalModel( f1_arg1, "PlayerAbilities", "playerGadget3", function ( model )
				PowerWeaponDrainGadget3:setModel( model, f1_arg1 )
		end )
		self:addElement( PowerWeaponDrainGadget3 )
		self.PowerWeaponDrainGadget3 = PowerWeaponDrainGadget3
		
		local PowerWeaponDrainGadget2 = CoD.AmmoWidgetZM_PowerWeaponDrain.new( f1_arg0, f1_arg1, 0, 0, -290, -125, 0, 0, -19.5, 41.5 )
		PowerWeaponDrainGadget2:setAlpha( 0 )
		PowerWeaponDrainGadget2.Empty:setRGB( ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b )
		PowerWeaponDrainGadget2.Fill2:setRGB( ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b )
		PowerWeaponDrainGadget2.Fill:setRGB( ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b )
		PowerWeaponDrainGadget2.Fill3:setRGB( ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b )
		PowerWeaponDrainGadget2:subscribeToGlobalModel( f1_arg1, "PlayerAbilities", "playerGadget2", function ( model )
				PowerWeaponDrainGadget2:setModel( model, f1_arg1 )
		end )
		self:addElement( PowerWeaponDrainGadget2 )
		self.PowerWeaponDrainGadget2 = PowerWeaponDrainGadget2
		
		local WeaponImage = LUI.UIFixedAspectRatioImage.new( 0, 0, -236, -25, 0.5, 0.5, -34, 31 )
		WeaponImage:setScale( 0.8, 0.8 )
		WeaponImage:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_F755127C95CF5B6" ) )
		WeaponImage:setShaderVector( 0, 1, 0, 0, 0 )
		WeaponImage.__Image = function ( f4_arg0 )
				local f4_local0 = f4_arg0:get()
				if f4_local0 ~= nil then
					--CoD.EnhModPrintInfo("Weapon Image: " .. tostring(GetHudImageFromItemRefHash( self:getModel(), f4_local0 )))
					WeaponImage:setImage( RegisterImage( GetHudImageFromItemRefHash( self:getModel(), f4_local0 ) ) )
				end
		end
		
		WeaponImage:linkToElementModel( self, "equippedWeaponReference", true, WeaponImage.__Image )
		WeaponImage.__Image_FullPath = function ()
				local f5_local0 = self:getModel()
				if f5_local0 then
					f5_local0 = self:getModel()
					f5_local0 = f5_local0.equippedWeaponReference
				end
				if f5_local0 then
					WeaponImage.__Image( f5_local0 )
				end
		end
		
		self:addElement( WeaponImage )
		self.WeaponImage = WeaponImage
		
		local HeroAbilityUseString = CoD.AmmoWidgetZM_WeaponName.new( f1_arg0, f1_arg1, 0, 0, -212, -44, 0, 0, -28.5, 4.5 )
		HeroAbilityUseString:linkToElementModel( self, "weaponName", true, function ( model )
				local f6_local0 = model:get()
				if f6_local0 ~= nil then
					HeroAbilityUseString.HeroAbilityUseString:setText( ConvertToUpperString( CoD.BaseUtility.AlreadyLocalized( f6_local0 ) ) )
				end
		end )
		self:addElement( HeroAbilityUseString )
		self.HeroAbilityUseString = HeroAbilityUseString
		
		WeaponImage:linkToElementModel( self, "weapon", true, WeaponImage.__Image_FullPath )
		LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
		
		if PostLoadFunc then
				PostLoadFunc( self, f1_arg1, f1_arg0 )
		end
		
		return self
	end
	
	CoD.AmmoWidgetZM_WeaponImage.__onClose = function ( f7_arg0 )
		f7_arg0.PowerWeaponDrainGadget3:close()
		f7_arg0.PowerWeaponDrainGadget2:close()
		f7_arg0.WeaponImage:close()
		f7_arg0.HeroAbilityUseString:close()
	end
end