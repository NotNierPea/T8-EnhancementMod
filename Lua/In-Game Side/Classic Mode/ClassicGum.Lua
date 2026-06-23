--[[
      .\hksc.exe '.\Scripts\ClassicGum.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\ClassicGum.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

CoD.ClassicGum = InheritFrom( LUI.UIElement )
CoD.ClassicGum.__defaultWidth = 1920
CoD.ClassicGum.__defaultHeight = 1080
CoD.ClassicGum.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
      local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.ClassicGum )
	self.id = "ClassicGum"
	self.soundSet = "FriendsMenu"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )

      -- hint for button
      local CursorHintText = LUI.UIText.new(1.00, 1.00, -100.00, 1889.80, 0.00, 0.00, 427.00, 447.00)
      CursorHintText:setTTF( "shield_mom" )
      CursorHintText:setText("")

      CursorHintText:setShaderVector( 0, 0, 0, 0, 0 )
      CursorHintText:setShaderVector( 1, 0.5, 0, 0, 0 )
      CursorHintText:setShaderVector( 2, 0, 0, 0, 0 )
      CursorHintText:setShaderVector( 3, 0, 0, 0, 0 )
      CursorHintText:setShaderVector( 4, 0, 0, 0, 0 )

      self:addElement( CursorHintText )
      self.CursorHintText = CursorHintText

      local GumImage = LUI.UIImage.new(1.00, 1.00, -132.00, -50.00, 0.00, 0.00, 400.00, 478.00)
      GumImage:setImage(RegisterImage( GetItemImageForIndex( 0, Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"] ) ) ) -- alt
      GumImage:setRGB(1, 1, 1)
      GumImage:setAlpha(0)
      GumImage:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"shield_zombie_bgb_pack" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)

                  if scriptData[1] == 0 then
                        GumImage:setAlpha(0)

                        self.CursorHintText:setText("")

                        self.HasGum = 0
                  elseif scriptData[1] == 1 then
                        local ItemIndexGum = scriptData[2]

                        -- set image and appear
                        GumImage:setImage(RegisterImage( GetItemImageForIndex( ItemIndexGum, Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"] ) ))
                        GumImage:setAlpha(1)

                        self.CursorHintText:setText("[{+switchseat}] (HOLD)")

                        self.HasGum = 1
                  end
            end
      end)
      self:addElement(GumImage)
      self.HasGum = 0
      self.GumImage = GumImage

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

CoD.ClassicGum.__resetProperties = function ( f16_arg0 )
	f16_arg0.GumImage:completeAnimation()
	f16_arg0.GumImage:setRGB(1, 1, 1)
      f16_arg0.GumImage:setAlpha(f16_arg0.HasGum)
      --f16_arg0.CursorHintText:completeAnimation()
	--f16_arg0.CursorHintText:setRGB(1, 1, 1)

      if f16_arg0.HasGum == 1 then
            f16_arg0.CursorHintText:setText("[{+switchseat}] (HOLD)")
      else
            f16_arg0.CursorHintText:setText("")
      end
end

CoD.ClassicGum.__clipsPerState = {

	DefaultState = {
		DefaultClip = function ( f17_arg0, f17_arg1 )
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter( 0 )
		end,

            Hidden = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			f18_arg0.GumImage:completeAnimation()
			f18_arg0.GumImage:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.GumImage )

                  --f18_arg0.CursorHintText:completeAnimation()
			f18_arg0.CursorHintText:setText("")
			--f18_arg0.clipFinished( f18_arg0.CursorHintText )
		end
	},

	Hidden = {
		DefaultClip = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			f18_arg0.GumImage:completeAnimation()
			f18_arg0.GumImage:setAlpha(0)
			f18_arg0.clipFinished( f18_arg0.GumImage )

                  --f18_arg0.CursorHintText:completeAnimation()
			f18_arg0.CursorHintText:setText("")
			--f18_arg0.clipFinished( f18_arg0.CursorHintText )
		end
	}

}

CoD.ClassicGum.__onClose = function ( f19_arg0 )
	f19_arg0.GumImage:close()
      f19_arg0.CursorHintText:close()
end