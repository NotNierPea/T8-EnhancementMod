--[[
      .\hksc.exe '.\Scripts\BossHealthBar.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\BossHealthBar.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

CoD.BossHealthBar = InheritFrom( LUI.UIElement )
CoD.BossHealthBar.__defaultWidth = 1920
CoD.BossHealthBar.__defaultHeight = 1080
CoD.BossHealthBar.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
      local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.BossHealthBar )
	self.id = "BossHealthBar"
	self.soundSet = "FriendsMenu"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )

      self.IsVisible = false

      -- BossName
      local BossName = LUI.UIText.new(0.5, 0.5, -40, 250, 0, 0, 130 - 65, 155 - 65)
      BossName:setAlpha(0)
      BossName:setTTF( "shield_mom" )
      BossName:setText("")

      BossName:setShaderVector( 0, 0, 0, 0, 0 )
      BossName:setShaderVector( 1, 0.5, 0, 0, 0 )
      BossName:setShaderVector( 2, 0, 0, 0, 0 )
      BossName:setShaderVector( 3, 0, 0, 0, 0 )
      BossName:setShaderVector( 4, 0, 0, 0, 0 )

      self:addElement( BossName )
      self.BossName = BossName

      -- meter
      local BossHealthMeter_bg = LUI.UIImage.new(0.5, 0.5, -500 - 4, 500 + 4, 0, 0, 100 - 50 - 6, 110 - 55 + 6)
      --BossHealthMeter_bg:setImage(RegisterImage(@"progress_bar_frame"))
      BossHealthMeter_bg:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
      BossHealthMeter_bg:setRGB(0, 0, 0)
      BossHealthMeter_bg:setAlpha(0)
      self:addElement(BossHealthMeter_bg)
      self.BossHealthMeter_bg = BossHealthMeter_bg

      local BossHealthMeter_l = LUI.UIImage.new(0.5, 0.5, -500, 500, 0, 0, 100 - 50, 110 - 55)
      --BossHealthMeter_l:setImage(RegisterImage(@"hash_76D2FBF31F53910C"))
      BossHealthMeter_l:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_4316E67E1DF2198E"))
      BossHealthMeter_l:setShaderVector(1.000000, 0.01, 0, 0, 0) 
      BossHealthMeter_l:setShaderVector(2.000000, 1, 0, 0, 0)   
      BossHealthMeter_l:setShaderVector(3.000000, 0, 0, 0, 0) 
      BossHealthMeter_l:setRGB(1, 1, 1)
      BossHealthMeter_l:setAlpha(1)
      self:addElement(BossHealthMeter_l)
      self.BossHealthMeter_l = BossHealthMeter_l

      local BossHealthMeter = LUI.UIImage.new(0.5, 0.5, -500, 500, 0, 0, 100 - 50, 110 - 55)
      --BossHealthMeter:setImage(RegisterImage(@"hash_76D2FBF31F53910C"))
      BossHealthMeter:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_4316E67E1DF2198E"))
      BossHealthMeter:setShaderVector(1.000000, 0.01, 0, 0, 0)
      BossHealthMeter:setShaderVector(2.000000, 1, 0, 0, 0)
      BossHealthMeter:setShaderVector(3.000000, 0, 0, 0, 0)
      BossHealthMeter:setRGB(0, 1, 1)
      BossHealthMeter:setAlpha(0)
      self:addElement(BossHealthMeter)
      self.BossHealthMeter = BossHealthMeter

      BossHealthMeter:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
			if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"notify_boss_name" ) then
					local scriptData = CoD.GetScriptNotifyData(model)
					
					local id = scriptData[1]

					-- voyage's eye
					if id == 1 then
						self.BossName:setText("Eye Of Despair")
						self.BossName:setAlpha(1)

						self.IsVisible = true
					elseif id == 2 then
						self.BossName:setText("Fallen Eye")
						self.BossName:setAlpha(1)

						self.IsVisible = true
					elseif id == 3 then
						self.BossName:setText("Pegasus")
						self.BossName:setAlpha(1)

						self.BossHealthMeter:setRGB(1, 0, 0.60)

						self.IsVisible = true
					elseif id == 4 then
						self.BossName:setText("Fallen Pegasus")
						self.BossName:setAlpha(1)

						self.IsVisible = true
					elseif id == 5 then
						-- ? placeholder? think of something better maybe for phase 3
						self.BossName:setText("Broken Pegasus")
						self.BossName:setAlpha(1)

						self.IsVisible = true
					elseif id == 6 then
						self.BossName:setText("Perseus")
						self.BossName:setAlpha(1)

						self.IsVisible = true
					elseif id == 7 then
						self.BossName:setText("Fallen Perseus")
						self.BossName:setAlpha(1)

						self.IsVisible = true
					elseif id == 8 then
						self.BossName:setText("...")
						self.BossName:setAlpha(1)

						self.BossHealthMeter:setRGB(1, 1, 0)

						self.IsVisible = true
					elseif id == 9 then
						self.BossName:setText("Elephant")
						self.BossName:setAlpha(1)

						self.IsVisible = true
					elseif id == 10 then
						self.BossName:setText("Fallen Elephant")
						self.BossName:setAlpha(1)

						self.IsVisible = true
					elseif id == 11 then
						if scriptData[2] == 5 then
								self.BossName:setText("Orbs (Last Phase)")
						else
								self.BossName:setText("Orbs (Phase " .. scriptData[2] .. ")")
						end
						self.BossName:setAlpha(1)

						self.BossHealthMeter:setRGB(1, 0, 0)

						self.IsVisible = true
					elseif id == 12 then
						self.BossName:setText("Brutus")
						self.BossName:setAlpha(1)

						self.BossHealthMeter:setRGB(1, 0, 0)

						self.IsVisible = true
					elseif id == 13 then
						self.BossName:setText("Agarthan")
						self.BossName:setAlpha(1)

						self.BossHealthMeter:setRGB(1, 0, 0)

						self.IsVisible = true
					elseif id == 14 then
						self.BossName:setText("Broken Agarthan")
						self.BossName:setAlpha(1)

						self.BossHealthMeter:setRGB(1, 0, 0)

						self.IsVisible = true
					elseif id == 15 then
						self.BossName:setText("Charging Agarthan")
						self.BossName:setAlpha(1)

						self.BossHealthMeter:setRGB(1, 0, 0)

						self.IsVisible = true
					elseif id == 16 then
						self.BossName:setText("Avogadro")
						self.BossName:setAlpha(1)

						self.BossHealthMeter:setRGB(0, 0, 1)

						self.IsVisible = true
					elseif id == 17 then
						self.BossName:setText("Weak Avogadro")
						self.BossName:setAlpha(1)

						self.BossHealthMeter:setRGB(0, 1, 1)

						self.IsVisible = true
					elseif id == 18 then
						self.BossName:setText("Wolf")
						self.BossName:setAlpha(1)

						self.BossHealthMeter:setRGB(1, 0, 0)

						self.IsVisible = true
					else
						self.BossName:setText("")
						self.BossName:setAlpha(0)

						self.IsVisible = false
					end
			end
		end)

      BossHealthMeter:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
			if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"notify_boss_health_meter" ) then
					local scriptData = CoD.GetScriptNotifyData(model)
					
					local id = scriptData[1]

					if id == 1 then
						self.BossHealthMeter:setAlpha(1)
						self.BossHealthMeter_l:setAlpha(1)
						self.BossHealthMeter_bg:setAlpha(1)
						self.BossName:setAlpha(1)

						if (scriptData[3] ~= nil) then
								local meter_l = scriptData[3] / 100

								self.BossHealthMeter_l:beginAnimation("keyframe", 400, false, false, CoD.TweenType.Linear) -- 400 S
								self.BossHealthMeter_l:setShaderVector(0.000000, meter_l, 0, 0, 0)
						else

								local meter = scriptData[2] / 100

								self.BossHealthMeter:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear) -- 300 S
								self.BossHealthMeter:setShaderVector(0.000000, meter, 0, 0, 0)

						end

						self.IsVisible = true
					else
						self.BossHealthMeter:setAlpha(0)
						self.BossHealthMeter_l:setAlpha(0)
						self.BossHealthMeter_bg:setAlpha(0)
						self.BossName:setAlpha(0)

						self.IsVisible = false
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

CoD.BossHealthBar.__resetProperties = function ( f16_arg0 )
      f16_arg0.BossHealthMeter:completeAnimation()
      --f16_arg0.BossHealthMeter:setRGB(0, 1, 1)
      f16_arg0.BossHealthMeter:setAlpha(1)
      f16_arg0.BossHealthMeter_bg:completeAnimation()
      --f16_arg0.BossHealthMeter_bg:setRGB(0, 0, 0)
      f16_arg0.BossHealthMeter_bg:setAlpha(1)
      f16_arg0.BossName:setAlpha(1)
      f16_arg0.BossHealthMeter_l:completeAnimation()
      --f16_arg0.BossHealthMeter_l:setRGB(1, 1, 1)
      f16_arg0.BossHealthMeter_l:setAlpha(1)

      if f16_arg0.IsVisible then
            
      else
            f16_arg0.BossHealthMeter:completeAnimation()
            f16_arg0.BossHealthMeter:setAlpha(0)
            f16_arg0.BossHealthMeter_bg:completeAnimation()
            f16_arg0.BossHealthMeter_bg:setAlpha(0)
            f16_arg0.BossName:setAlpha(0)
            f16_arg0.BossHealthMeter_l:completeAnimation()
            f16_arg0.BossHealthMeter_l:setAlpha(0)
      end
end

CoD.BossHealthBar.__clipsPerState = {

	DefaultState = {
		DefaultClip = function ( f17_arg0, f17_arg1 )
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter( 0 )
		end,

            Hidden = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			f18_arg0.BossHealthMeter:completeAnimation()
			f18_arg0.BossHealthMeter:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.BossHealthMeter )

            f18_arg0.BossHealthMeter_bg:completeAnimation()
			f18_arg0.BossHealthMeter_bg:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.BossHealthMeter_bg )

            f18_arg0.BossName:completeAnimation()
			f18_arg0.BossName:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.BossName )

			f18_arg0.BossHealthMeter_l:completeAnimation()
			f18_arg0.BossHealthMeter_l:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.BossHealthMeter_l )
		end
	},

	Hidden = {
		DefaultClip = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			f18_arg0.BossHealthMeter:completeAnimation()
			f18_arg0.BossHealthMeter:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.BossHealthMeter )

			f18_arg0.BossHealthMeter_bg:completeAnimation()
			f18_arg0.BossHealthMeter_bg:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.BossHealthMeter_bg )

			f18_arg0.BossName:completeAnimation()
			f18_arg0.BossName:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.BossName )

			f18_arg0.BossHealthMeter_l:completeAnimation()
			f18_arg0.BossHealthMeter_l:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.BossHealthMeter_l )
		end
	}
}

CoD.BossHealthBar.__onClose = function ( f19_arg0 )
	f19_arg0.BossHealthMeter:close()
	f19_arg0.BossHealthMeter_l:close()
	f19_arg0.BossHealthMeter_bg:close()
	f19_arg0.BossName:close()
end