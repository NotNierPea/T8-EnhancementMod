--[[
      .\hksc.exe '.\Scripts\Cranked.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\Cranked.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

-- cranked's
CoD.CrankedTimer = InheritFrom( LUI.UIElement )
CoD.CrankedTimer.__defaultWidth = 1920
CoD.CrankedTimer.__defaultHeight = 1080
CoD.CrankedTimer.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
      local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.CrankedTimer )
	self.id = "CrankedTimer"
	self.soundSet = "FriendsMenu"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )

      -- background
      local CrankedImageBG = LUI.UIImage.new(0.00, 0.00, 45.00, 300.00, 0.00, 0.00, -185.00, -98.00)
      CrankedImageBG:setRGB(1, 1, 1)
      CrankedImageBG:setAlpha(0.80)
      CrankedImageBG:setImage(RegisterImage(@"score_bg"))
      self:addElement(CrankedImageBG)
      self.CrankedImageBG = CrankedImageBG

      -- cranked text
      local CrankedText = LUI.UIText.new(0.00, 0.00, 99.00, 125.00, 0.00, 0.00, -188.00, -148.00)
      CrankedText:setTTF( "shield_mom" )
      CrankedText:setText("Get Ready...")

      CrankedText:setShaderVector( 0, 0, 0, 0, 0 )
      CrankedText:setShaderVector( 1, 0.5, 0, 0, 0 )
      CrankedText:setShaderVector( 2, 0, 0, 0, 0 )
      CrankedText:setShaderVector( 3, 0, 0, 0, 0 )
      CrankedText:setShaderVector( 4, 0, 0, 0, 0 )
      CrankedText:setRGB(0, 1, 0)

      self:addElement( CrankedText )
      self.CrankedText = CrankedText

      -- timer
      local CrankedTimer = LUI.UIText.new(0.00, 0.00, 100.00, 125.00, 0.00, 0.00, -163.00, -106.00)
      CrankedTimer:setTTF( "shield_mom" )
      CrankedTimer:setText("...")

      CrankedTimer:setShaderVector( 0, 0, 0, 0, 0 )
      CrankedTimer:setShaderVector( 1, 0.5, 0, 0, 0 )
      CrankedTimer:setShaderVector( 2, 0, 0, 0, 0 )
      CrankedTimer:setShaderVector( 3, 0, 0, 0, 0 )
      CrankedTimer:setShaderVector( 4, 0, 0, 0, 0 )

      self:addElement( CrankedTimer )
      self.CrankedTimer = CrankedTimer

      local CrankedImageBG = LUI.UIImage.new(0.00, 0.00, 0.00, 90.00, 0.00, 0.00, -185.00, -98.00)
      CrankedImageBG:setRGB(1, 1, 1)
      CrankedImageBG:setAlpha(0.80)
      CrankedImageBG:setImage(RegisterImage(@"cranked_image"))
      self:addElement(CrankedImageBG)
      self.CrankedImageBG = CrankedImageBG

      local CrankedImage = LUI.UIImage.new(0.00, 0.00, 0.00, 90.00, 0.00, 0.00, -185.00, -98.00)
      CrankedImage:setRGB(1, 1, 1)
      CrankedImage:setAlpha(0.10)
      CrankedImage:setImage(RegisterImage(@"cranked_image_draw"))
      CrankedImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	CrankedImage:setShaderVector( 1, 0.5, 0, 0, 0 )
	CrankedImage:setShaderVector( 2, 0.5, 0, 0, 0 )
	CrankedImage:setShaderVector( 3, 0, 0, 0, 0 )
	CrankedImage:setShaderVector( 4, 0, 0, 0, 0 )

      -- Keep track of previous time to detect increases
      local previousTime = 0
      local isDoingAnimation = false
      local FirstTime = false

      CrankedImage:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"enh_team_cranked" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)

                  if scriptData[1] == 0 then
                        self:beginAnimation("keyframe", 1000, false, false, CoD.TweenType.Linear)
                        self:setAlpha(1)
                        return
                  end

                  if scriptData[1] == 99 then
                        if CoD.ZmNotifBGBContainerFactory ~= nil then
                              CoD.ZmNotifBGBContainerFactory:appendNotification( {
                                    clip = "TextandImageBGB",
                                    title = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/team_cranked" ),
                                    description = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/team_cranked_desc_ingame" ),
                                    bgbImage = RegisterImage(@"cranked_image")
                              } )
                        end
                        return
                  end

                  self:setAlpha(1)
                  self.CrankedTimer:setAlpha(1)
                  self.CrankedImage:setAlpha(0.10)
                  self.CrankedImageBG:setAlpha(0.80)

                  self.CrankedText:setText("CRANKED!")

                  local TimeLeft = scriptData[1] / 100
                  local MaxTime = scriptData[2] / 100

                  -- Convert to minutes:seconds.decimals format
                  local minutes = math.floor(TimeLeft / 60)
                  local seconds = TimeLeft % 60
                  local secondsWhole = math.floor(seconds)
                  local decimals = math.floor((seconds - secondsWhole) * 10)

                  local percent = scriptData[1] / scriptData[2]
                  self.CrankedImage:setShaderVector(0, percent, 0, 0, 0)

                  local angle = 360 * percent  -- full sweep
                  self.CrankedImageClock:setZRot(-angle)
                  -- Format as MM:SS.DD
                  local timeString = string.format("%d:%02d.%d", minutes, secondsWhole, decimals)

                  -- Apply color effects
                  if isDoingAnimation == false and TimeLeft > previousTime then
                        isDoingAnimation = true
                        -- Time increased - flash green
                        self.CrankedTimer:beginAnimation("keyframe", 350, false, false, CoD.TweenType.Linear)
                        self.CrankedTimer:setRGB(0, 1, 0)

                        self.CrankedTimer:registerEventHandler("transition_complete_keyframe", function (element, event)
                              element:beginAnimation("keyframe", 350, false, false, CoD.TweenType.Linear)
                              element:setRGB(1, 1, 1)

                              element:registerEventHandler("transition_complete_keyframe", function (element, event)
                                    isDoingAnimation = false
                              end)
                        end)

                        self.CrankedImage:beginAnimation("keyframe", 350, false, false, CoD.TweenType.Linear)
                        self.CrankedImage:setRGB(0, 1, 0)

                        self.CrankedImage:registerEventHandler("transition_complete_keyframe", function (element, event)
                              element:beginAnimation("keyframe", 350, false, false, CoD.TweenType.Linear)
                              element:setRGB(1, 1, 1)

                              element:registerEventHandler("transition_complete_keyframe", function (element, event)
                                    isDoingAnimation = false
                              end)
                        end)

                  elseif isDoingAnimation == false then
                        -- Normal color state
                        if TimeLeft < 10 then
                              self.CrankedTimer:setRGB(1, 0, 0)
                              self.CrankedImage:setRGB(1, 0, 0)
                        else 
                              self.CrankedTimer:setRGB(1, 1, 1)
                              self.CrankedImage:setRGB(1, 1, 1)
                        end
                  end
                  
                  self.CrankedTimer:setText(timeString)
                  previousTime = TimeLeft
            end
      end)
      self:addElement(CrankedImage)
      self.CrankedImage = CrankedImage

      local CrankedImageClock = LUI.UIImage.new(0.00, 0.00, 0.00, 90.00, 0.00, 0.00, -185.00, -98.00)
      CrankedImageClock:setRGB(1, 1, 1)
      CrankedImageClock:setAlpha(1)
      CrankedImageClock:setImage(RegisterImage(@"cranked_image_draw_clock"))
      self:addElement(CrankedImageClock)
      self.CrankedImageClock = CrankedImageClock

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

      self:setAlpha(0)
      
	return self
end

CoD.CrankedTimer.__resetProperties = function ( f16_arg0 )

end

CoD.CrankedTimer.__clipsPerState = {

	DefaultState = {
		DefaultClip = function ( f17_arg0, f17_arg1 )
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter( 0 )
		end,

            Hidden = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			--f18_arg0.CrankedImage:completeAnimation()
			--f18_arg0.CrankedImage:setAlpha(0)
			--f18_arg0.clipFinished( f18_arg0.CrankedImage )

			--f18_arg0.CrankedTimer:setText("")
		end
	},

	Hidden = {
		DefaultClip = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			--f18_arg0.CrankedImage:completeAnimation()
			--f18_arg0.CrankedImage:setAlpha(0)
			--f18_arg0.clipFinished( f18_arg0.CrankedImage )

			--f18_arg0.CrankedTimer:setText("")
		end
	}

}

CoD.CrankedTimer.__onClose = function ( f19_arg0 )
	f19_arg0.CrankedImage:close()
      f19_arg0.CrankedTimer:close()
end