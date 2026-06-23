--[[
      .\hksc.exe '.\Scripts\WhosWhoMeter.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\WhosWhoMeter.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

CoD.WhosWhoMeter = InheritFrom( LUI.UIElement )
CoD.WhosWhoMeter.__defaultWidth = 1920
CoD.WhosWhoMeter.__defaultHeight = 1080
CoD.WhosWhoMeter.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
      local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.WhosWhoMeter )
	self.id = "WhosWhoMeter"
	self.soundSet = "FriendsMenu"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )

      -- text says reviving
      local CursorHintText = LUI.UIText.new(0.5, 0.5, -40, 250, 0.5, 0.5, 130, 155)
      CursorHintText:setAlpha(0)
      CursorHintText:setTTF( "notosans_bold" )
      CursorHintText:setText("Reviving...")

      CursorHintText:setShaderVector( 0, 0, 0, 0, 0 )
      CursorHintText:setShaderVector( 1, 0.5, 0, 0, 0 )
      CursorHintText:setShaderVector( 2, 0, 0, 0, 0 )
      CursorHintText:setShaderVector( 3, 0, 0, 0, 0 )
      CursorHintText:setShaderVector( 4, 0, 0, 0, 0 )

      self:addElement( CursorHintText )
      self.CursorHintText = CursorHintText

      -- meter
      local WhosWhoMeter = LUI.UIImage.new(0.5, 0.5, -250, 250, 0.5, 0.5, 100, 110)
      WhosWhoMeter:setImage(RegisterImage(@"hash_76D2FBF31F53910C"))
      WhosWhoMeter:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_4316E67E1DF2198E"))
      WhosWhoMeter:setShaderVector(1.000000, 0.01, 0, 0, 0) 
      WhosWhoMeter:setShaderVector(2.000000, 1, 0, 0, 0)   
      WhosWhoMeter:setShaderVector(3.000000, 0, 0, 0, 0) 
      WhosWhoMeter:setRGB(0, 1, 1)
      WhosWhoMeter:setAlpha(0)
      self:addElement(WhosWhoMeter)
      self.WhosWhoMeter = WhosWhoMeter
      
      local WhosWhoMeter_bg = LUI.UIImage.new(0.5, 0.5, -250 - 4, 250 + 4, 0.5, 0.5, 100 - 6, 110 + 6)
      WhosWhoMeter_bg:setImage(RegisterImage(@"progress_bar_frame"))
      WhosWhoMeter_bg:setMaterial(LUI.UIImage.GetCachedMaterial("ui_multiply"))
      WhosWhoMeter_bg:setRGB(0, 0, 0)
      WhosWhoMeter_bg:setAlpha(0)
      self:addElement(WhosWhoMeter_bg)
      self.WhosWhoMeter_bg = WhosWhoMeter_bg

      WhosWhoMeter:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
                        if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"notify_whos_who_meter" ) then
                              local scriptData = CoD.GetScriptNotifyData(model)
                              
                              local id = scriptData[1]

                              if id == 1 then
                                    local meter = scriptData[2] / 100
                                    local meter_shader = meter / 100

                                    self.WhosWhoMeter:setAlpha(1)
                                    self.WhosWhoMeter_bg:setAlpha(1)
                                    self.CursorHintText:setAlpha(1)
                              
                                    self.WhosWhoMeter:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear) -- 300 S
                                    self.WhosWhoMeter:setShaderVector(0.000000, meter_shader, 0, 0, 0)
                              else
                                    self.WhosWhoMeter:setAlpha(0)
                                    self.WhosWhoMeter_bg:setAlpha(0)
                                    self.CursorHintText:setAlpha(0)
                              end
                        end
                  end)
      
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

CoD.WhosWhoMeter.__resetProperties = function ( f16_arg0 )
	f16_arg0.WhosWhoMeter:completeAnimation()
	f16_arg0.WhosWhoMeter:setRGB(0, 1, 1)
      f16_arg0.WhosWhoMeter:setAlpha(0)
      f16_arg0.WhosWhoMeter_bg:completeAnimation()
	f16_arg0.WhosWhoMeter_bg:setRGB(0, 0, 0)
      f16_arg0.WhosWhoMeter_bg:setAlpha(0)
      f16_arg0.CursorHintText:setAlpha(0)
end

CoD.WhosWhoMeter.__clipsPerState = {

	DefaultState = {
		DefaultClip = function ( f17_arg0, f17_arg1 )
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter( 0 )
		end,

            Hidden = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			f18_arg0.WhosWhoMeter:completeAnimation()
			f18_arg0.WhosWhoMeter:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.WhosWhoMeter )

                  f18_arg0.WhosWhoMeter_bg:completeAnimation()
			f18_arg0.WhosWhoMeter_bg:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.WhosWhoMeter_bg )

                  f18_arg0.CursorHintText:completeAnimation()
			f18_arg0.CursorHintText:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.CursorHintText )
		end
	},

	Hidden = {
		DefaultClip = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			f18_arg0.WhosWhoMeter:completeAnimation()
			f18_arg0.WhosWhoMeter:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.WhosWhoMeter )

                  f18_arg0.WhosWhoMeter_bg:completeAnimation()
                  f18_arg0.WhosWhoMeter_bg:setAlpha(0)
                  f18_arg0.clipFinished( f18_arg0.WhosWhoMeter_bg )

                  f18_arg0.CursorHintText:completeAnimation()
                  f18_arg0.CursorHintText:setAlpha(0)
                  f18_arg0.clipFinished( f18_arg0.CursorHintText )
		end
	}
}

CoD.WhosWhoMeter.__onClose = function ( f19_arg0 )
	f19_arg0.WhosWhoMeter:close()
      f19_arg0.WhosWhoMeter_bg:close()
      f19_arg0.CursorHintText:close()
end