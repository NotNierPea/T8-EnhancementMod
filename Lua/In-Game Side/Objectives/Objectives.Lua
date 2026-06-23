--[[
      .\hksc.exe '.\Scripts\Objectives.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\Objectives.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

local PingImages = {
      [1] = "ping_icon",
      [2] = "vulture_weap",
      [3] = "vulture_pap",
      [4] = "vulture_perk"
}

local DirectedImages = {
      [1] = "directed_icon",
}

local DirectedHints = {
      [10000] = "Poison Zombie",
      [10001] = "Water Zombie",
      [10002] = "Lightning Zombie",
      [10003] = "Fire Zombie",

      [20001] = "The Sun",
      [20002] = "Mercury",
      [20003] = "Venus",
      [20004] = "Mars",
      [20005] = "Jupiter",
      [20006] = "Saturn",
      [20007] = "Uranus",
      [20008] = "Neptune",
      [20009] = "Moon",

      [30001] = "The Sun's Orb",
      [30002] = "Mercury's Orb",
      [30003] = "Venus's Orb",
      [30004] = "Mars's Orb",
      [30005] = "Jupiter's Orb",
      [30006] = "Saturn's Orb",
      [30007] = "Uranus's Orb",
      [30008] = "Neptune's Orb",
      [30009] = "Moon's Orb",
}

------------------------

-- this is used for health bars, directed, pings
CoD.ObjectivesReload = function()
      -- objectives stuff
      CoD.EnhObjective = InheritFrom( LUI.UIElement )
      CoD.EnhObjective.__defaultWidth = 120
      CoD.EnhObjective.__defaultHeight = 180
      CoD.EnhObjective.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            CoD.BaseUtility.CreateControllerModel( f1_arg1, "interactivePrompt.activeObjectiveID" )
            self:setClass( CoD.EnhObjective )
            self.id = "EnhObjective"
            self.soundSet = "default"
            self.anyChildUsesUpdateState = true
            f1_arg0:addElementToPendingUpdateStateList( self )

            ---------------------------- ---------------------------- ---------------------------- ----------------------------

            -- stuff here
            -- text
            local CursorHintText = LUI.UIText.new(0.5, 0.5, -102, 375, 0.5, 0.5, 15, 36.5)
            CursorHintText:setRGB(1, 1, 1)
            CursorHintText:setText("Zombie")
            CursorHintText:setTTF( "0arame_mono_stencil" )
            CursorHintText:setLetterSpacing( 0.5 )
            CursorHintText:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            CursorHintText:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
            self:addElement( CursorHintText )
            self.CursorHintText = CursorHintText

            -- health bars
            local health_bar_bg = LUI.UIImage.new(0.5, 0.5, -100 - 4, 100 + 4, 0.5, 0.5, -7 + 50 - 6, 0 + 50 + 6)
            --health_bar_bg:setImage(RegisterImage(@"progress_bar_frame")) -- changed -> progress_bar_frame
            health_bar_bg:setMaterial(LUI.UIImage.GetCachedMaterial("ui_multiply"))
            health_bar_bg:setRGB(0, 0, 0)
            health_bar_bg:setAlpha(0.80)
            self:addElement(health_bar_bg)
            self.health_bar_bg = health_bar_bg

            local health_bar_l = LUI.UIImage.new(0.5, 0.5, -100, 100, 0.5, 0.5, -7 + 50, 0 + 50)
            --health_bar_l:setImage(RegisterImage(@"hash_76D2FBF31F53910C"))
            health_bar_l:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_4316E67E1DF2198E"))
            health_bar_l:setShaderVector(1.000000, 0.01, 0, 0, 0) 
            health_bar_l:setShaderVector(2.000000, 1, 0, 0, 0)   
            health_bar_l:setShaderVector(3.000000, 0, 0, 0, 0) 
            health_bar_l:setRGB(1, 1, 1)
            health_bar_l:setAlpha(1)
            self:addElement(health_bar_l)
            self.health_bar_l = health_bar_l

            local health_bar = LUI.UIImage.new(0.5, 0.5, -100, 100, 0.5, 0.5, -7 + 50, 0 + 50)
            --health_bar:setImage(RegisterImage(@"hash_76D2FBF31F53910C"))
            health_bar:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_4316E67E1DF2198E"))
            health_bar:setShaderVector(1.000000, 0.01, 0, 0, 0) 
            health_bar:setShaderVector(2.000000, 1, 0, 0, 0)   
            health_bar:setShaderVector(3.000000, 0, 0, 0, 0) 
            health_bar:setRGB(1, 0, 0)
            health_bar:setAlpha(1)
            self:addElement(health_bar)
            self.health_bar = health_bar

            local vulture_image = LUI.UIImage.new(0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
            vulture_image:setImage(RegisterImage(@"vulture_box"))
            vulture_image:setRGB(1, 1, 1)
            vulture_image:setAlpha(0)
            self:addElement(vulture_image)
            self.vulture_image = vulture_image

            local ping_image = LUI.UIImage.new(0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
            ping_image:setImage(RegisterImage(@"vulture_box"))
            ping_image:setRGB(1, 1, 1)
            ping_image:setAlpha(0)
            self:addElement(ping_image)
            self.ping_image = ping_image

            local hint_objective = LUI.UIText.new( 0.5, 0.5, -192, 192, 0.5, 0.5, 45, 75)
            hint_objective:setText( "" )
            hint_objective:setTTF( "skorzhen" )
            hint_objective:setRGB( 1, 0.35, 0.35 )
            hint_objective:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_90D57B1E92D39D7" ) )
            hint_objective:setShaderVector( 0, 0.8, 0, 0, 0 )
            hint_objective:setShaderVector( 1, 0, 0, 0, 0 )
            hint_objective:setShaderVector( 2, 1, 1, 1, 0.4 )
            hint_objective:setLetterSpacing( 2 )
            hint_objective:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            hint_objective:setAlignment( Enum[@"luialignment"][@"lui_alignment_bottom"] )
            hint_objective:setBackingType( 2 )
            hint_objective:setBackingXPadding( 6 )
            hint_objective:setBackingYPadding( 4 )
            hint_objective:setBackingImage( RegisterImage( @"hash_675D661B612187DF" ) )
            LUI.OverrideFunction_CallOriginalFirst( hint_objective, "setText", function ( element, controller )
                  ScaleWidgetToLabelCentered( self, element, 4 )
            end )
            self:addElement( hint_objective )
            self.hint_objective = hint_objective

            local WaypointText = CoD.Waypoint_TextBG_Zm.new( f1_arg0, f1_arg1, 0.5, 0.5, -60, 60, 0.5, 0.5, -85, -55 )
            WaypointText:mergeStateConditions( {
                  {
                        stateName = "Contested",
                        condition = function ( menu, element, event )
                              return CoD.WaypointUtility.ShouldShowWaypointAsContested( f1_arg1, self )
                        end
                  },
                  {
                        stateName = "Protect",
                        condition = function ( menu, element, event )
                              return CoD.WaypointUtility.ShouldShowWaypointAsProtect( f1_arg1, self )
                        end
                  }
            } )
            WaypointText:linkToElementModel( WaypointText, "clientUseMask", true, function ( model )
                  f1_arg0:updateElementState( WaypointText, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "clientUseMask"
                  } )
            end )
            WaypointText:linkToElementModel( WaypointText, "gamemodeFlags", true, function ( model )
                  f1_arg0:updateElementState( WaypointText, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "gamemodeFlags"
                  } )
            end )
            WaypointText:linkToElementModel( WaypointText, "distanceText", true, function ( model )
                  f1_arg0:updateElementState( WaypointText, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "distanceText"
                  } )
            end )
            WaypointText:linkToElementModel( WaypointText, "clamped", true, function ( model )
                  f1_arg0:updateElementState( WaypointText, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "clamped"
                  } )
            end )
            WaypointText:linkToElementModel( WaypointText, "text", true, function ( model )
                  f1_arg0:updateElementState( WaypointText, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "text"
                  } )
            end )
            WaypointText:linkToElementModel( self, nil, false, function ( model )
                  WaypointText:setModel( model, f1_arg1 )
            end )
            WaypointText:linkToElementModel( self, "text", true, function ( model )
                  local f22_local0 = model:get()
                  if f22_local0 ~= nil then
                        WaypointText.WaypointTextWithBG.text:setText( Engine[@"hash_4F9F1239CFD921FE"]( f22_local0 ) )
                  end
            end )
            WaypointText:linkToElementModel( self, "distanceText", true, function ( model )
                  local f23_local0 = model:get()
                  if f23_local0 ~= nil then
                        WaypointText.DistanceTextWithBG.text:setText( LocalizeIntoStringIfNotEmpty( @"hash_37235825812D46C6", f23_local0 ) )
                  end
            end )
            WaypointText:setAlpha(0)
            self:addElement( WaypointText )
            self.WaypointText = WaypointText

            -- damage
            local DamageText = LUI.UIText.new(0.5, 0.5, -375, 375, 0.5, 0.5, -20, 35)

            DamageText:setText("")

            DamageText:setTTF( "shield_mom" )

            DamageText:setRGB(0, 1, 1)

            DamageText:setShaderVector( 0, 0, 0, 0, 0 )
            DamageText:setShaderVector( 1, 0.5, 0, 0, 0 )
            DamageText:setShaderVector( 2, 0, 0, 0, 0 )
            DamageText:setShaderVector( 3, 0, 0, 0, 0 )
            DamageText:setShaderVector( 4, 0, 0, 0, 0 )

            DamageText:setLetterSpacing( 0.5 )

            DamageText:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            DamageText:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )

            self:addElement( DamageText )
            self.DamageText = DamageText

            -- updating info
            self:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
                  if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"enhancement_objective_visibility" ) then
                        local scriptData = CoD.GetScriptNotifyData(model)
                        
                        local main_id = self.objId
                        local id = scriptData[1]
                        local hide_show = scriptData[2]

                        --CoD.EnhModPrintInfo("got lua notify: " .. main_id)

                        if id == main_id then

                        if hide_show == 1 then 
                              --self:beginAnimation( 1010 )
                              if scriptData[3] == nil then
                                    local IsOff = CoD.ModelUtility.IsSelfModelValueTrue( self, f1_arg1, "isOffscreen" ) 

                                    if IsOff then
                                          self:setAlpha(0)
                                    else
                                          self:setAlpha(1)
                                    end
                              else
                                    self:setAlpha(1)
                              end
                               --CoD.EnhModPrintInfo("Displaying Objective " .. self.objId)
                        elseif hide_show == 2 then
                              --CoD.EnhModPrintInfo("setting up objective for vulture: " .. self.objId)

                              -- vulutre's
                              local ImageID = scriptData[3]

                              self.health_bar_bg:setAlpha(0)
                              self.health_bar:setAlpha(0)
                              self.health_bar_l:setAlpha(0)
                              self.CursorHintText:setAlpha(0)
                              
                              self.DamageText:setText("")

                              self.vulture_image:setAlpha(1)

                              if ImageID < 10 then
                                    self.vulture_image:setImage(RegisterImage(VultureAidImage[ImageID]))
                              else
                                    self.vulture_image:setImage(RegisterImage(VultureAidImagePerks[ImageID]))
                              end

                              -- resize for pap image
                              if ImageID == 3 then
                                    --self.vulture_image:setScale(1.5, 1.5)
                              end

                              if ImageID == 4 then
                                    self.vulture_image:setScale(0.75, 0.75)
                              end

                        elseif hide_show == 3 then
                              --CoD.EnhModPrintInfo("setting up objective for ping: " .. self.objId)

                              --PlaySoundAlias( "uin_paint_image_flip_toggle" )

                              -- ping's
                              local ImageID = scriptData[3]
                              local ClientNum = scriptData[4]

                              self.health_bar_bg:setAlpha(0)
                              self.health_bar:setAlpha(0)
                              self.health_bar_l:setAlpha(0)
                              self.CursorHintText:setAlpha(0)
                              
                              self.DamageText:setText("")
                              
                              self.ping_image:setAlpha(1)
                              
                              
                              if ClientNum == 0 then
                                    self.ping_image:setRGB(0, 0, 1)
                              else
                                    self.ping_image:setRGB(ZombieClientScoreboardColor(ClientNum))
                              end

                              self.ping_image:setImage(RegisterImage(PingImages[ImageID]))
                              
                              -- directed ping
                        elseif hide_show == 4 then
                              CoD.EnhModPrintInfo("setting up objective for directed: " .. self.objId)
                              self.health_bar_bg:setAlpha(0)
                              self.health_bar:setAlpha(0)
                              self.health_bar_l:setAlpha(0)
                              self.CursorHintText:setAlpha(0)
                              self.DamageText:setText("")
                              self.hint_objective:setText("")

                              local ImageID = scriptData[3]
                              local ExtraText = scriptData[4]
                              local ExtraText2 = scriptData[5]

                              self.WaypointText:setAlpha(1)
                              self.WaypointText:setRGB( 1, 0.35, 0.35 )
                              self.ping_image:setRGB( 1, 0.35, 0.35 )
                              self.ping_image:setAlpha(1)
                              self.ping_image:setImage(RegisterImage(DirectedImages[ImageID]))

                              if ExtraText ~= nil and ExtraText ~= "" then
                                    self.hint_objective:setText(ExtraText)

                                    if DirectedHints[ExtraText] ~= nil then
                                          self.hint_objective:setText(DirectedHints[ExtraText])
                                    end
                              end
                              if ExtraText2 ~= nil and ExtraText2 ~= "" then
                                    self.hint_objective:setText(ExtraText .. "/" .. ExtraText2)
                              end
                        else 
                              self:setAlpha(0)
                              self.DamageText:setText("")
                        end
                        end
                  end
            end)

            local HealthBar_Old = 0
            local HealthBar_L_Old = 0

            local Zombie_Names_Table = {
                  [0] = "",
                  [1] = "Zombie",
                  [2] = "Stoker",
                  [3] = "Blight Father",
                  [4] = "Lightning Zombie",
                  [5] = "Poison Zombie",
                  [6] = "Fire Zombie",
                  [7] = "Water Zombie",
                  [8] = "Destroyer",
                  [9] = "Marauder",
                  [10] = "Tiger",
                  [11] = "Brutus",
                  [12] = "Hellhound",
                  [13] = "Werewolf",
                  [14] = "Nosferatu",
                  [15] = "Nova Crawler",
                  [16] = "Skeleton Zombie",
                  [17] = "Gegenees",
                  [18] = "Electric Zombie",
            }

            self:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
                  if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"enhancement_objective_health" ) then
                        local scriptData = CoD.GetScriptNotifyData(model)
                        
                        local main_id = self.objId
                        local id = scriptData[1]
                        local health = scriptData[2] / 100
                        local health_max = scriptData[3] / 100
                        local health_bar_calc = scriptData[4] / 100
                        local ArchetypeIndex = scriptData[6]

                        if(id == main_id) then
                              self.health_bar_bg:setAlpha(1)
                              self.health_bar:setAlpha(1)
                              self.health_bar_l:setAlpha(1)
                              self.CursorHintText:setAlpha(1)

                              self.ping_image:setAlpha(0)
                              self.vulture_image:setAlpha(0)
                              
                              if scriptData[6] ~= nil then
                                    CursorHintText:setText(Zombie_Names_Table[ArchetypeIndex])
                              end
                              
                              if health_bar_calc == HealthBar_Old or scriptData[5] ~= nil then -- check if same..

                              else                                        
                                    health_bar:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear) -- 300 S
                                    health_bar:setShaderVector(0.000000, health_bar_calc, 0, 0, 0)
                                    HealthBar_Old = health_bar_calc
                              end
                              
                              -- white one
                              if scriptData[5] ~= nil then
                                    local health_bar_calc_l = scriptData[5] / 100

                                    if health_bar_calc_l == HealthBar_L_Old then

                                    else
                                          health_bar_l:beginAnimation("keyframe", 400, false, false, CoD.TweenType.Linear) -- 300 S
                                          health_bar_l:setShaderVector(0.000000, health_bar_calc_l, 0, 0, 0)
                                          HealthBar_L_Old = health_bar_calc_l
                                    end
                              end
                        end
                  end
            end)

            self:setAlpha(0)

            --CoD.EnhModPrintInfo("Init an Objective..")

            ---------------------------- ---------------------------- ---------------------------- ----------------------------

            return self
      end
      
      CoD.EnhObjective.__resetProperties = function ( f66_arg0 )
            
      end
      
      CoD.EnhObjective.__clipsPerState = {
            
      }

      CoD.EnhObjective.__onClose = function ( f73_arg0 )
            f73_arg0.CursorHintText:close()
            f73_arg0.health_bar:close()
            f73_arg0.health_bar_l:close()
            f73_arg0.health_bar_bg:close()
            f73_arg0.vulture_image:close()
            f73_arg0.ping_image:close()
            f73_arg0.hint_objective:close()
            f73_arg0.DamageText:close()
      end
end