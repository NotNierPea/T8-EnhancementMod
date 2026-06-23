--[[
      .\hksc.exe '.\Scripts\RoundContainer.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\RoundContainer.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

-- used for directed round cap and rampage effect
CoD.RoundContainerReload = function()
      CoD.ZmRndContainer = InheritFrom( LUI.UIElement )
      CoD.ZmRndContainer.__defaultWidth = 336
      CoD.ZmRndContainer.__defaultHeight = 300
      CoD.ZmRndContainer.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.ZmRndContainer )
            self.id = "ZmRndContainer"
            self.soundSet = "HUD"
            self.anyChildUsesUpdateState = true
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            -- rampage's
            local Rampage_Inducer = LUI.UIImage.new(0.00, 0.00, 20.00, 250.00, 0.00, 0.00, 100.00, 260.00)
            Rampage_Inducer:setAlpha(0)
            Rampage_Inducer:setImage(RegisterImage(@"rampage_inducer_round"))
            Rampage_Inducer:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_flipbook" ) )
            Rampage_Inducer:setShaderVector(0, 24, 0, 0, 0)
            Rampage_Inducer:setShaderVector(1, 25, 0, 0, 0)
            self:addElement(Rampage_Inducer)
            self.Rampage_Inducer = Rampage_Inducer
            self.Rampage_Inducer_Toggle = false

            -- directed's
            local DirectedBackground = LUI.UIImage.new(0.00, 0.00, 0.00, 260.00, 0.00, 0.00, 250.00, 300.00)
            DirectedBackground:setRGB(1, 1, 1)
            DirectedBackground:setAlpha(0)
            DirectedBackground:setImage(RegisterImage(@"score_bg"))
            self:addElement(DirectedBackground)
            self.DirectedBackground = DirectedBackground

            local DirectedText = LUI.UIText.new( 0.00, 0.00, 43.00, 200.00, 0.00, 0.00, 260.00, 300.00 )
            DirectedText:setRGB( 1, 0.35, 0.35 )
            DirectedText:setTTF( "skorzhen" )
            DirectedText:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            self:addElement( DirectedText )
            self.DirectedText = DirectedText
            
            self.Directed_Toggle = false

            if Engine[@"getdvarint"]("shield_enh_ClassicMode") == 1 and Engine[@"getdvarint"]("shield_enh_AltHud") == 1 then
                  DirectedText:setTopBottom(0.00, 0.00, 260.00, 300.00) -- later
                  DirectedBackground:setTopBottom(0.00, 0.00, 250.00, 300.00) -- later
                  Rampage_Inducer:setTopBottom(0.00, 0.00, -480.00, -320.00)
            end

            -- prevent trials from creating multiple subscriptions
            if (f1_arg4 == -51 and not CoD.HUDUtility.IsAnyGameType( f1_arg1, "ztrials" )) or (f1_arg4 ~= -51 and CoD.HUDUtility.IsAnyGameType( f1_arg1, "ztrials" )) then
                  self:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
                        if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"enhancement_directed_round_cap" ) then
                              local scriptData = CoD.GetScriptNotifyData(model)
                              local RoundCap = scriptData[1]

                              -- notify round cap reached
                              if RoundCap == 999 then
                                    self.DirectedText:setText("ROUND CAP REACHED!")
                              else
                                    self.DirectedText:setText("ROUND CAP: " .. RoundCap)
                              end

                              self.DirectedText:setAlpha(1)
                              self.DirectedBackground:setAlpha(1)
                              self.Directed_Toggle = true
                        end
                  end)
                  
                  self:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
                        if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"shield_enh_rampage_mode" ) then
                              local scriptData = CoD.GetScriptNotifyData(model)
                              local IsActive = scriptData[1]

                              if IsActive == 1 then
                                    self.Rampage_Inducer:setAlpha(0.80)
                                    self.Rampage_Inducer_Toggle = true
                              else
                                    self.Rampage_Inducer:setAlpha(0)
                                    self.Rampage_Inducer_Toggle = false
                              end

                              -- notify
                              if CoD.ZmNotifBGBContainerFactory ~= nil then
                                    local TextMain = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/rampage_inducer" )
                                    local TextDesc = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/rampage_inducer_desc" )

                                    if IsActive == 0 then
                                          TextMain = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/rampage_inducer_disabled" )
                                          TextDesc = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/rampage_inducer_disabled_desc" )
                                    end


                                    CoD.ZmNotifBGBContainerFactory:appendNotification( {
                                          clip = "TextandImageBGB",
                                          title = TextMain,
                                          description = TextDesc,
                                          bgbImage = RegisterImage(@"rampage_inducer")
                                    } )
                              end
                        end
                  end)
            end

            local ZmRnd = CoD.ZmRnd.new( f1_arg0, f1_arg1, 0, 0, 0, 336, 1, 1, -300, 0 )
            ZmRnd:subscribeToGlobalModel( f1_arg1, "GameScore", nil, function ( model )
                  ZmRnd:setModel( model, f1_arg1 )
            end )
            self:addElement( ZmRnd )
            self.ZmRnd = ZmRnd
            
            self:mergeStateConditions( {
                  {
                        stateName = "TrialsShow",
                        condition = function ( menu, element, event )
                              local f3_local0 = CoD.HUDUtility.IsAnyGameType( f1_arg1, "ztrials" )
                              if f3_local0 then
                                    if not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"] ) then
                                          f3_local0 = not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"] )
                                    else
                                          f3_local0 = false
                                    end
                              end
                              return f3_local0
                        end
                  },
                  {
                        stateName = "Invisible",
                        condition = function ( menu, element, event )
                              local f4_local0 = CoD.ModelUtility.IsModelValueTrue( f1_arg1, "hudItems.playerSpawned" )
                              if f4_local0 then
                                    if Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"] ) or Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"] ) or Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"] ) or Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"] ) or not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"] ) or Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"] ) or Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"] ) or Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"] ) or Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"] ) or Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"] ) or Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"] ) or Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"] ) or Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"] ) or Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"] ) or Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"] ) or not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"] ) then
                                          f4_local0 = not Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"] )
                                    else
                                          f4_local0 = false
                                    end
                              end
                              return f4_local0
                        end
                  },
                  {
                        stateName = "InvisibleCopy",
                        condition = function ( menu, element, event )
                              return CoD.HUDUtility.IsAnyGameType( f1_arg1, "zstandard", "ztrials" )
                        end
                  }
            } )
            local f1_local2 = self
            local f1_local3 = self.subscribeToModel
            local f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function ( f6_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f6_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function ( f7_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f7_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["hudItems.playerSpawned"], function ( f8_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f8_arg0:get(),
                        modelName = "hudItems.playerSpawned"
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function ( f9_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f9_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function ( f10_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f10_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function ( f11_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f11_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function ( f12_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f12_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function ( f13_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f13_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function ( f14_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f14_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function ( f15_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f15_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function ( f16_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f16_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function ( f17_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f17_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function ( f18_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f18_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function ( f19_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f19_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function ( f20_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f20_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function ( f21_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f21_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function ( f22_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f22_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]
                  } )
            end, false )
            f1_local2 = self
            f1_local3 = self.subscribeToModel
            f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
            f1_local3( f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function ( f23_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f23_arg0:get(),
                        modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]
                  } )
            end, false )
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            return self
      end

      CoD.ZmRndContainer.__resetProperties = function ( f24_arg0 )
            f24_arg0.ZmRnd:completeAnimation()
            f24_arg0.ZmRnd:setAlpha( 1 )
            f24_arg0.Rampage_Inducer:completeAnimation()

            if f24_arg0.Rampage_Inducer_Toggle == true then
                  f24_arg0.Rampage_Inducer:setAlpha( 0.80 )
            else
                  f24_arg0.Rampage_Inducer:setAlpha( 0 )
            end

            if f24_arg0.Directed_Toggle == true then
                  f24_arg0.DirectedBackground:setAlpha( 1 )
                  f24_arg0.DirectedText:setAlpha( 1 )
            else
                  f24_arg0.DirectedBackground:setAlpha( 0 )
                  f24_arg0.DirectedText:setAlpha( 0 )
            end
      end

      CoD.ZmRndContainer.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f25_arg0, f25_arg1 )
                        f25_arg0:__resetProperties()
                        f25_arg0:setupElementClipCounter( 1 )
                        local f25_local0 = function ( f26_arg0 )
                              f25_arg0.ZmRnd:beginAnimation( 190 )
                              f25_arg0.ZmRnd:setAlpha( 1 )
                              f25_arg0.ZmRnd:registerEventHandler( "interrupted_keyframe", f25_arg0.clipInterrupted )
                              f25_arg0.ZmRnd:registerEventHandler( "transition_complete_keyframe", f25_arg0.clipFinished )
                        end
                        
                        f25_arg0.ZmRnd:completeAnimation()
                        f25_arg0.ZmRnd:setAlpha( 0 )
                        f25_local0( f25_arg0.ZmRnd )

                        local f25_local01 = function ( f26_arg0 )
                              f25_arg0.Rampage_Inducer:beginAnimation( 190 )

                              if f25_arg0.Rampage_Inducer_Toggle == true then
                                    f25_arg0.Rampage_Inducer:setAlpha( 0.80 )
                              else
                                    f25_arg0.Rampage_Inducer:setAlpha( 0 )
                              end
                              f25_arg0.Rampage_Inducer:registerEventHandler( "interrupted_keyframe", f25_arg0.clipInterrupted )
                              f25_arg0.Rampage_Inducer:registerEventHandler( "transition_complete_keyframe", f25_arg0.clipFinished )
                        end

                        f25_arg0.Rampage_Inducer:completeAnimation()

                        if f25_arg0.Rampage_Inducer_Toggle == true then
                              f25_arg0.Rampage_Inducer:setAlpha( 0.80 )
                        else
                              f25_arg0.Rampage_Inducer:setAlpha( 0 )
                        end
                        
                        f25_local01( f25_arg0.Rampage_Inducer )

                        local f25_local012 = function ( f26_arg0 )
                              f25_arg0.DirectedText:beginAnimation( 190 )

                              if f25_arg0.Directed_Toggle == true then
                                    f25_arg0.DirectedText:setAlpha( 1 )
                              else
                                    f25_arg0.DirectedText:setAlpha( 0 )
                              end
                              f25_arg0.DirectedText:registerEventHandler( "interrupted_keyframe", f25_arg0.clipInterrupted )
                              f25_arg0.DirectedText:registerEventHandler( "transition_complete_keyframe", f25_arg0.clipFinished )
                        end

                        f25_arg0.DirectedText:completeAnimation()

                        if f25_arg0.Directed_Toggle == true then
                              f25_arg0.DirectedText:setAlpha( 1 )
                        else
                              f25_arg0.DirectedText:setAlpha( 0 )
                        end
                        
                        f25_local012( f25_arg0.DirectedText )

                        local f25_local0123 = function ( f26_arg0 )
                              f25_arg0.DirectedBackground:beginAnimation( 190 )

                              if f25_arg0.Directed_Toggle == true then
                                    f25_arg0.DirectedBackground:setAlpha( 1 )
                              else
                                    f25_arg0.DirectedBackground:setAlpha( 0 )
                              end
                              f25_arg0.DirectedBackground:registerEventHandler( "interrupted_keyframe", f25_arg0.clipInterrupted )
                              f25_arg0.DirectedBackground:registerEventHandler( "transition_complete_keyframe", f25_arg0.clipFinished )
                        end

                        f25_arg0.DirectedBackground:completeAnimation()

                        if f25_arg0.Directed_Toggle == true then
                              f25_arg0.DirectedBackground:setAlpha( 1 )
                        else
                              f25_arg0.DirectedBackground:setAlpha( 0 )
                        end
                        
                        f25_local0123( f25_arg0.DirectedBackground )
                  end,
                  Invisible = function ( f27_arg0, f27_arg1 )
                        f27_arg0:__resetProperties()
                        f27_arg0:setupElementClipCounter( 1 )
                        local f27_local0 = function ( f28_arg0 )
                              f27_arg0.ZmRnd:beginAnimation( 150 )
                              f27_arg0.ZmRnd:setAlpha( 0 )
                              f27_arg0.ZmRnd:registerEventHandler( "interrupted_keyframe", f27_arg0.clipInterrupted )
                              f27_arg0.ZmRnd:registerEventHandler( "transition_complete_keyframe", f27_arg0.clipFinished )
                        end
                        
                        f27_arg0.ZmRnd:completeAnimation()
                        f27_arg0.ZmRnd:setAlpha( 1 )
                        f27_local0( f27_arg0.ZmRnd )

                        local f27_local01 = function ( f28_arg0 )
                              f27_arg0.Rampage_Inducer:beginAnimation( 150 )
                              f27_arg0.Rampage_Inducer:setAlpha( 0 )
                              f27_arg0.Rampage_Inducer:registerEventHandler( "interrupted_keyframe", f27_arg0.clipInterrupted )
                              f27_arg0.Rampage_Inducer:registerEventHandler( "transition_complete_keyframe", f27_arg0.clipFinished )
                        end

                        f27_arg0.Rampage_Inducer:completeAnimation()
                        f27_arg0.Rampage_Inducer:setAlpha( 0 )
                        f27_local01( f27_arg0.Rampage_Inducer )

                        local f27_local02 = function ( f28_arg0 )
                              f27_arg0.DirectedText:beginAnimation( 150 )
                              f27_arg0.DirectedText:setAlpha( 0 )
                              f27_arg0.DirectedText:registerEventHandler( "interrupted_keyframe", f27_arg0.clipInterrupted )
                              f27_arg0.DirectedText:registerEventHandler( "transition_complete_keyframe", f27_arg0.clipFinished )
                        end

                        f27_arg0.DirectedText:completeAnimation()
                        f27_arg0.DirectedText:setAlpha( 0 )
                        f27_local02( f27_arg0.DirectedText )

                        local f27_local03 = function ( f28_arg0 )
                              f27_arg0.DirectedBackground:beginAnimation( 150 )
                              f27_arg0.DirectedBackground:setAlpha( 0 )
                              f27_arg0.DirectedBackground:registerEventHandler( "interrupted_keyframe", f27_arg0.clipInterrupted )
                              f27_arg0.DirectedBackground:registerEventHandler( "transition_complete_keyframe", f27_arg0.clipFinished )
                        end

                        f27_arg0.DirectedBackground:completeAnimation()
                        f27_arg0.DirectedBackground:setAlpha( 0 )
                        f27_local03( f27_arg0.DirectedBackground )
                  end
            },
            TrialsShow = {
                  DefaultClip = function ( f29_arg0, f29_arg1 )
                        f29_arg0:__resetProperties()
                        f29_arg0:setupElementClipCounter( 0 )
                  end,
                  Invisible = function ( f30_arg0, f30_arg1 )
                        f30_arg0:__resetProperties()
                        f30_arg0:setupElementClipCounter( 1 )
                        local f30_local0 = function ( f31_arg0 )
                              f30_arg0.ZmRnd:beginAnimation( 150 )
                              f30_arg0.ZmRnd:setAlpha( 0 )
                              f30_arg0.ZmRnd:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
                              f30_arg0.ZmRnd:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
                        end
                        
                        f30_arg0.ZmRnd:completeAnimation()
                        f30_arg0.ZmRnd:setAlpha( 1 )
                        f30_local0( f30_arg0.ZmRnd )

                        local f30_local01 = function ( f31_arg0 )
                              f30_arg0.Rampage_Inducer:beginAnimation( 150 )
                              f30_arg0.Rampage_Inducer:setAlpha( 0 )
                              f30_arg0.Rampage_Inducer:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
                              f30_arg0.Rampage_Inducer:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
                        end

                        f30_arg0.Rampage_Inducer:completeAnimation()
                        f30_arg0.Rampage_Inducer:setAlpha( 0 )
                        f30_local01( f30_arg0.Rampage_Inducer )

                        local f30_local02 = function ( f31_arg0 )
                              f30_arg0.DirectedText:beginAnimation( 150 )
                              f30_arg0.DirectedText:setAlpha( 0 )
                              f30_arg0.DirectedText:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
                              f30_arg0.DirectedText:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
                        end

                        f30_arg0.DirectedText:completeAnimation()
                        f30_arg0.DirectedText:setAlpha( 0 )
                        f30_local02( f30_arg0.DirectedText )

                        local f30_local03 = function ( f31_arg0 )
                              f30_arg0.DirectedBackground:beginAnimation( 150 )
                              f30_arg0.DirectedBackground:setAlpha( 0 )
                              f30_arg0.DirectedBackground:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
                              f30_arg0.DirectedBackground:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
                        end

                        f30_arg0.DirectedBackground:completeAnimation()
                        f30_arg0.DirectedBackground:setAlpha( 0 )
                        f30_local03( f30_arg0.DirectedBackground )
                  end
            },
            Invisible = {
                  DefaultClip = function ( f32_arg0, f32_arg1 )
                        f32_arg0:__resetProperties()
                        f32_arg0:setupElementClipCounter( 1 )
                        f32_arg0.ZmRnd:completeAnimation()
                        f32_arg0.ZmRnd:setAlpha( 0 )
                        f32_arg0.clipFinished( f32_arg0.ZmRnd )

                        f32_arg0.Rampage_Inducer:completeAnimation()
                        f32_arg0.Rampage_Inducer:setAlpha( 0 )
                        f32_arg0.clipFinished( f32_arg0.Rampage_Inducer )

                        f32_arg0.DirectedText:completeAnimation()
                        f32_arg0.DirectedText:setAlpha( 0 )
                        f32_arg0.clipFinished( f32_arg0.DirectedText )

                        f32_arg0.DirectedBackground:completeAnimation()
                        f32_arg0.DirectedBackground:setAlpha( 0 )
                        f32_arg0.clipFinished( f32_arg0.DirectedBackground )
                  end,
                  DefaultState = function ( f33_arg0, f33_arg1 )
                        f33_arg0:__resetProperties()
                        f33_arg0:setupElementClipCounter( 1 )
                        local f33_local0 = function ( f34_arg0 )
                              f33_arg0.ZmRnd:beginAnimation( 150 )
                              f33_arg0.ZmRnd:setAlpha( 1 )
                              f33_arg0.ZmRnd:registerEventHandler( "interrupted_keyframe", f33_arg0.clipInterrupted )
                              f33_arg0.ZmRnd:registerEventHandler( "transition_complete_keyframe", f33_arg0.clipFinished )
                        end
                        
                        f33_arg0.ZmRnd:completeAnimation()
                        f33_arg0.ZmRnd:setAlpha( 0 )
                        f33_local0( f33_arg0.ZmRnd )

                        local f33_local01 = function ( f34_arg0 )
                              f33_arg0.Rampage_Inducer:beginAnimation( 150 )
                              f33_arg0.Rampage_Inducer:setAlpha( 0 )
                              f33_arg0.Rampage_Inducer:registerEventHandler( "interrupted_keyframe", f33_arg0.clipInterrupted )
                              f33_arg0.Rampage_Inducer:registerEventHandler( "transition_complete_keyframe", f33_arg0.clipFinished )
                        end
                        
                        f33_arg0.Rampage_Inducer:completeAnimation()
                        f33_arg0.Rampage_Inducer:setAlpha( 0 )
                        f33_local01( f33_arg0.Rampage_Inducer )

                        local f33_local02 = function ( f34_arg0 )
                              f33_arg0.DirectedText:beginAnimation( 150 )
                              f33_arg0.DirectedText:setAlpha( 0 )
                              f33_arg0.DirectedText:registerEventHandler( "interrupted_keyframe", f33_arg0.clipInterrupted )
                              f33_arg0.DirectedText:registerEventHandler( "transition_complete_keyframe", f33_arg0.clipFinished )
                        end
                        
                        f33_arg0.DirectedText:completeAnimation()
                        f33_arg0.DirectedText:setAlpha( 0 )
                        f33_local02( f33_arg0.DirectedText )

                        local f33_local03 = function ( f34_arg0 )
                              f33_arg0.DirectedBackground:beginAnimation( 150 )
                              f33_arg0.DirectedBackground:setAlpha( 0 )
                              f33_arg0.DirectedBackground:registerEventHandler( "interrupted_keyframe", f33_arg0.clipInterrupted )
                              f33_arg0.DirectedBackground:registerEventHandler( "transition_complete_keyframe", f33_arg0.clipFinished )
                        end
                        
                        f33_arg0.DirectedBackground:completeAnimation()
                        f33_arg0.DirectedBackground:setAlpha( 0 )
                        f33_local03( f33_arg0.DirectedBackground )
                  end
            },
            InvisibleCopy = {
                  DefaultClip = function ( f35_arg0, f35_arg1 )
                        f35_arg0:__resetProperties()
                        f35_arg0:setupElementClipCounter( 1 )
                        f35_arg0.ZmRnd:completeAnimation()
                        f35_arg0.ZmRnd:setAlpha( 0 )
                        f35_arg0.clipFinished( f35_arg0.ZmRnd )
                        f35_arg0.Rampage_Inducer:completeAnimation()
                        f35_arg0.Rampage_Inducer:setAlpha( 0 )
                        f35_arg0.clipFinished( f35_arg0.Rampage_Inducer )

                        f35_arg0.DirectedText:completeAnimation()
                        f35_arg0.DirectedText:setAlpha( 0 )
                        f35_arg0.clipFinished( f35_arg0.DirectedText )

                        f35_arg0.DirectedBackground:completeAnimation()
                        f35_arg0.DirectedBackground:setAlpha( 0 )
                        f35_arg0.clipFinished( f35_arg0.DirectedBackground )
                  end,
                  DefaultState = function ( f36_arg0, f36_arg1 )
                        f36_arg0:__resetProperties()
                        f36_arg0:setupElementClipCounter( 1 )
                        local f36_local0 = function ( f37_arg0 )
                              f36_arg0.ZmRnd:beginAnimation( 150 )
                              f36_arg0.ZmRnd:setAlpha( 1 )
                              f36_arg0.ZmRnd:registerEventHandler( "interrupted_keyframe", f36_arg0.clipInterrupted )
                              f36_arg0.ZmRnd:registerEventHandler( "transition_complete_keyframe", f36_arg0.clipFinished )
                        end
                        
                        f36_arg0.ZmRnd:completeAnimation()
                        f36_arg0.ZmRnd:setAlpha( 0 )
                        f36_local0( f36_arg0.ZmRnd )

                        local f36_local10 = function ( f37_arg0 )
                              f36_arg0.Rampage_Inducer:beginAnimation( 150 )
                              f36_arg0.Rampage_Inducer:setAlpha( 0 )
                              f36_arg0.Rampage_Inducer:registerEventHandler( "interrupted_keyframe", f36_arg0.clipInterrupted )
                              f36_arg0.Rampage_Inducer:registerEventHandler( "transition_complete_keyframe", f36_arg0.clipFinished )
                        end
                        
                        f36_arg0.Rampage_Inducer:completeAnimation()
                        f36_arg0.Rampage_Inducer:setAlpha( 0 )
                        f36_local10( f36_arg0.Rampage_Inducer )

                        local f36_local102 = function ( f37_arg0 )
                              f36_arg0.DirectedBackground:beginAnimation( 150 )
                              f36_arg0.DirectedBackground:setAlpha( 0 )
                              f36_arg0.DirectedBackground:registerEventHandler( "interrupted_keyframe", f36_arg0.clipInterrupted )
                              f36_arg0.DirectedBackground:registerEventHandler( "transition_complete_keyframe", f36_arg0.clipFinished )
                        end
                        
                        f36_arg0.DirectedBackground:completeAnimation()
                        f36_arg0.DirectedBackground:setAlpha( 0 )
                        f36_local102( f36_arg0.DirectedBackground )

                        local f36_local1023 = function ( f37_arg0 )
                              f36_arg0.DirectedText:beginAnimation( 150 )
                              f36_arg0.DirectedText:setAlpha( 0 )
                              f36_arg0.DirectedText:registerEventHandler( "interrupted_keyframe", f36_arg0.clipInterrupted )
                              f36_arg0.DirectedText:registerEventHandler( "transition_complete_keyframe", f36_arg0.clipFinished )
                        end
                        
                        f36_arg0.DirectedText:completeAnimation()
                        f36_arg0.DirectedText:setAlpha( 0 )
                        f36_local1023( f36_arg0.DirectedText )
                  end
            }
      }

      CoD.ZmRndContainer.__onClose = function ( f38_arg0 )
            f38_arg0.ZmRnd:close()
            f38_arg0.Rampage_Inducer:close()
            f38_arg0.DirectedText:close()
            f38_arg0.DirectedBackground:close()
      end
end