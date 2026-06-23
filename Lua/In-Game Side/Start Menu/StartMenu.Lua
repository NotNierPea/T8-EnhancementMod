--[[
      .\hksc.exe '.\Scripts\StartMenu.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\StartMenu.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

-- for changing stuff mid-game (characters, elixirs, camos, etc)
CoD.StartMenuReload = function()
      CoD.StartMenu_GameOptions_ZM = InheritFrom( LUI.UIElement )
      CoD.StartMenu_GameOptions_ZM.__defaultWidth = 1920
      CoD.StartMenu_GameOptions_ZM.__defaultHeight = 1080
      CoD.StartMenu_GameOptions_ZM.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.StartMenu_GameOptions_ZM )
            self.id = "StartMenu_GameOptions_ZM"
            self.soundSet = "ChooseDecal"
            self.onlyChildrenFocusable = true
            self.anyChildUsesUpdateState = true
            f1_arg0:addElementToPendingUpdateStateList( self )
            local f1_local1 = nil
            f1_local1 = LUI.UIElement.createFake()
            self.buttonList = f1_local1
            local f1_local2 = nil

            local Is_Scoreboard_Widget = f1_arg0.MPScore ~= nil

            -- ! our shit
            local ChangeSpecialButton = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.50, 0.50, 584.30, 883.30, 0.50, 0.50, -367.51, -295.51 )
            ChangeSpecialButton.MiddleText:setTTF( "notosans_bold" )
            ChangeSpecialButton.MiddleText:setText("Change Specialist")

            ChangeSpecialButton.MiddleTextFocus:setText("Change Specialist")
            ChangeSpecialButton.MiddleTextFocus:setTTF( "notosans_bold" )

            ChangeSpecialButton:mergeStateConditions( {
                  {
                        stateName = "Locked",
                        condition = function ( menu, element, event )
                              return false
                        end
                  }
            } )

            ChangeSpecialButton:linkToElementModel( self, nil, false, function ( model )
                  ChangeSpecialButton:setModel( model, f1_arg1 )
            end )
            self:addElement( ChangeSpecialButton )
            self.ChangeSpecialButton = ChangeSpecialButton

            f1_arg0:AddButtonCallbackFunction( ChangeSpecialButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
                  PlaySoundAlias( "uin_paint_image_flip_toggle" )
                  OpenOverlay( self, "ShieldEnhClassOptions", controller )
                  
            end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
                  if IsGamepad( controller ) then
                        CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm" )
                        return true
                  elseif IsMouseOrKeyboard( controller ) then
                        CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm" )
                        return false
                  else
                        return false
                  end
            end, false )

            ChangeSpecialButton.id = "ChangeSpecialButton"

            local ChangeBGBButton = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.50, 0.50, 584.30, 883.30, 0.50, 0.50, -367.51 + 100, -295.51 + 100 )
            ChangeBGBButton.MiddleText:setTTF( "notosans_bold" )
            ChangeBGBButton.MiddleText:setText("Change Elixirs")

            ChangeBGBButton.MiddleTextFocus:setText("Change Elixirs")
            ChangeBGBButton.MiddleTextFocus:setTTF( "notosans_bold" )

            ChangeBGBButton:mergeStateConditions( {
                  {
                        stateName = "Locked",
                        condition = function ( menu, element, event )
                              return false
                        end
                  }
            } )

            ChangeBGBButton:linkToElementModel( self, nil, false, function ( model )
                  ChangeBGBButton:setModel( model, f1_arg1 )
            end )
            self:addElement( ChangeBGBButton )
            self.ChangeBGBButton = ChangeBGBButton

            f1_arg0:AddButtonCallbackFunction( ChangeBGBButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
                  PlaySoundAlias( "uin_paint_image_flip_toggle" )
                  OpenOverlay( self, "ShieldEnhClassOptionsBGB", controller )
                  
            end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
                  if IsGamepad( controller ) then
                        CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm" )
                        return true
                  elseif IsMouseOrKeyboard( controller ) then
                        CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm" )
                        return false
                  else
                        return false
                  end
            end, false )

            ChangeBGBButton.id = "ChangeBGBButton"

            local ChangeCharacters = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.50, 0.50, 584.30, 883.30, 0.50, 0.50, -367.51 + 200, -295.51 + 200 )
            ChangeCharacters.MiddleText:setTTF( "notosans_bold" )
            ChangeCharacters.MiddleText:setText("Change Character")

            ChangeCharacters.MiddleTextFocus:setText("Change Character")
            ChangeCharacters.MiddleTextFocus:setTTF( "notosans_bold" )

            ChangeCharacters:mergeStateConditions( {
                  {
                        stateName = "Locked",
                        condition = function ( menu, element, event )
                              return false
                        end
                  }
            } )

            ChangeCharacters:linkToElementModel( self, nil, false, function ( model )
                  ChangeCharacters:setModel( model, f1_arg1 )
            end )
            self:addElement( ChangeCharacters )
            self.ChangeCharacters = ChangeCharacters

            f1_arg0:AddButtonCallbackFunction( ChangeCharacters, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
                  PlaySoundAlias( "uin_paint_image_flip_toggle" )
                  OpenOverlay( self, "ShieldEnhClassOptionsCharacter", controller )
                  
            end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
                  if IsGamepad( controller ) then
                        CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm" )
                        return true
                  elseif IsMouseOrKeyboard( controller ) then
                        CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm" )
                        return false
                  else
                        return false
                  end
            end, false )

            ChangeCharacters.id = "ChangeCharacters"

            local CamosButton = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.50, 0.50, 584.30, 883.30, 0.50, 0.50, -367.51 + 300, -295.51 + 300 )
            CamosButton.MiddleText:setTTF( "notosans_bold" )
            CamosButton.MiddleText:setText("Change Camos")

            CamosButton.MiddleTextFocus:setText("Change Camos")
            CamosButton.MiddleTextFocus:setTTF( "notosans_bold" )

            CamosButton:mergeStateConditions( {
                  {
                        stateName = "Locked",
                        condition = function ( menu, element, event )
                              return false
                        end
                  }
            } )

            CamosButton:linkToElementModel( self, nil, false, function ( model )
                  CamosButton:setModel( model, f1_arg1 )
            end )
            self:addElement( CamosButton )
            self.CamosButton = CamosButton

            f1_arg0:AddButtonCallbackFunction( CamosButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
                  PlaySoundAlias( "uin_paint_image_flip_toggle" )
                  CoD.EnhModPrintInfo("camo menu open")
                  
                  OpenOverlay( self, "ShieldEnhCamoOptions", controller )
                  
            end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
                  if IsGamepad( controller ) then
                        CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm" )
                        return true
                  elseif IsMouseOrKeyboard( controller ) then
                        CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm" )
                        return false
                  else
                        return false
                  end
            end, false )

            CamosButton.id = "CamosButton"

            local SaveGameButton = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.50, 0.50, 584.30, 883.30, 0.50, 0.50, -367.51 + 400, -295.51 + 400 )
            SaveGameButton.MiddleText:setTTF( "notosans_bold" )
            SaveGameButton.MiddleText:setText("Save Game")

            SaveGameButton.MiddleTextFocus:setText("Save Game")
            SaveGameButton.MiddleTextFocus:setTTF( "notosans_bold" )

            SaveGameButton:mergeStateConditions( {
                  {
                        stateName = "Locked",
                        condition = function ( menu, element, event )
                              return false
                        end
                  }
            } )

            SaveGameButton:linkToElementModel( self, nil, false, function ( model )
                  SaveGameButton:setModel( model, f1_arg1 )
            end )
            self:addElement( SaveGameButton )
            self.SaveGameButton = SaveGameButton

            f1_arg0:AddButtonCallbackFunction( SaveGameButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
                  PlaySoundAlias( "uin_paint_image_flip_toggle" )
                  CoD.EnhModPrintInfo("Save Save!")
                  
                  -- save
                  Engine[@"exec"](Engine[@"getprimarycontroller"](), 'set shield_enh_SaveGame 1')
                  CoD.BaseUtility.SwitchModeOnMenu( controller )
			RefreshLobbyRoom( menu, controller )
			StartMenuGoBack( menu, controller )
                  
            end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
                  if IsGamepad( controller ) then
                        CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm" )
                        return true
                  elseif IsMouseOrKeyboard( controller ) then
                        CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm" )
                        return false
                  else
                        return false
                  end
            end, false )

            SaveGameButton.id = "SaveGameButton"

            local BoxPatchesButton = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.50, 0.50, 584.30, 883.30, 0.50, 0.50, -367.51 + 650, -295.51 + 650 )
            BoxPatchesButton.MiddleText:setTTF( "notosans_bold" )
            BoxPatchesButton.MiddleText:setText("Box Patch Settings")

            BoxPatchesButton.MiddleTextFocus:setText("Box Patch Settings")
            BoxPatchesButton.MiddleTextFocus:setTTF( "notosans_bold" )

            BoxPatchesButton:mergeStateConditions( {
                  {
                        stateName = "Locked",
                        condition = function ( menu, element, event )
                              return false
                        end
                  }
            } )

            BoxPatchesButton:linkToElementModel( self, nil, false, function ( model )
                  BoxPatchesButton:setModel( model, f1_arg1 )
            end )
            self:addElement( BoxPatchesButton )
            self.BoxPatchesButton = BoxPatchesButton

            f1_arg0:AddButtonCallbackFunction( BoxPatchesButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
                  PlaySoundAlias( "uin_paint_image_flip_toggle" )
                  CoD.EnhModPrintInfo("Save Save!")
                  
                  -- open
                  OpenOverlay( self, "ShieldEnhBoxPatchOptions", controller )
                  
            end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
                  if IsGamepad( controller ) then
                        CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm" )
                        return true
                  elseif IsMouseOrKeyboard( controller ) then
                        CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm" )
                        return false
                  else
                        return false
                  end
            end, false )

            BoxPatchesButton.id = "BoxPatchesButton"

            if Is_Scoreboard_Widget then
                  ChangeSpecialButton:setAlpha(0)
                  ChangeBGBButton:setAlpha(0)
                  ChangeCharacters:setAlpha(0)
                  CamosButton:setAlpha(0)
                  SaveGameButton:setAlpha(0)
                  BoxPatchesButton:setAlpha(0)
            end

            if Engine[@"getdvarint"]("shield_enh_BoxPatch") ~= 1 then
                  BoxPatchesButton:setAlpha(0)
            end

            local PCbuttonList = LUI.UIList.new( f1_arg0, f1_arg1, 27, 0, nil, true, false, false, false )
            PCbuttonList:setLeftRight( 0.5, 0.5, -874, -564 )
            PCbuttonList:setTopBottom( 0.5, 0.5, -569, -161 )
            PCbuttonList:setWidgetType( CoD.List1ButtonLarge_PH )
            PCbuttonList:setVerticalCount( 5 )
            PCbuttonList:setSpacing( 27 )
            PCbuttonList:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            PCbuttonList:setDataSource( "StartMenuGameOptions" )
            PCbuttonList:registerEventHandler( "gain_focus", function ( element, event )
                  local f2_local0 = nil
                  if element.gainFocus then
                        f2_local0 = element:gainFocus( event )
                  elseif element.super.gainFocus then
                        f2_local0 = element.super:gainFocus( event )
                  end
                  CoD.Menu.UpdateButtonShownState( element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"] )
                  return f2_local0
            end )
            f1_arg0:AddButtonCallbackFunction( PCbuttonList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
                  ProcessListAction( self, element, controller, menu )
                  return true
            end, function ( element, menu, controller )
                  CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm" )
                  return true
            end, false )
            self:addElement( PCbuttonList )
            self.PCbuttonList = PCbuttonList
            
            local rankProgress = CoD.ProgressBar_Rank.new( f1_arg0, f1_arg1, 0.5, 0.5, -857, 857, 1, 1, -157.5, -58.5 )
            self:addElement( rankProgress )
            self.rankProgress = rankProgress
            
            local TrialsRulesBackground = CoD.InGameTrialsRulesBackgroundTall.new( f1_arg0, f1_arg1, 0.5, 0.5, -538, 650, 0, 0, 93, 898 )
            TrialsRulesBackground:setAlpha( 0 )
            TrialsRulesBackground:setScale( 0.95, 0.95 )
            self:addElement( TrialsRulesBackground )
            self.TrialsRulesBackground = TrialsRulesBackground
            
            local RoundDescriptionGrid = LUI.GridLayout.new( f1_arg0, f1_arg1, false, 0, 0, 7, 0, nil, nil, false, false, false, false )
            RoundDescriptionGrid:setLeftRight( 0.5, 0.5, -530, 654 )
            RoundDescriptionGrid:setTopBottom( 0, 0, 190, 853 )
            RoundDescriptionGrid:setAlpha( 0 )
            RoundDescriptionGrid:setScale( 0.95, 0.95 )
            RoundDescriptionGrid:setWidgetType( CoD.ZMAARTrialTabRoundStatTall )
            RoundDescriptionGrid:setHorizontalCount( 3 )
            RoundDescriptionGrid:setVerticalCount( 10 )
            RoundDescriptionGrid:setSpacing( 7 )
            RoundDescriptionGrid:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            RoundDescriptionGrid:setDataSource( "ZmAarTrialRoundGrid" )
            self:addElement( RoundDescriptionGrid )
            self.RoundDescriptionGrid = RoundDescriptionGrid
            
            local Scoreboard = CoD.ScoreboardZM.new( f1_arg0, f1_arg1, 0.5, 0.5, -444, 444, 0.5, 0.5, -373, 27 )
            self:addElement( Scoreboard )
            self.Scoreboard = Scoreboard
            
            local ScoreboardRush = CoD.ScoreboardRush.new( f1_arg0, f1_arg1, 0.5, 0.5, -465, 465, 0.5, 0.5, -433.5, 69.5 )
            ScoreboardRush:setAlpha( 0 )
            self:addElement( ScoreboardRush )
            self.ScoreboardRush = ScoreboardRush
            
            local PCKoreaContentDescriptorsContainer = nil
            
            PCKoreaContentDescriptorsContainer = CoD.PC_Korea_ContentDescriptors_Container.new( f1_arg0, f1_arg1, 0.5, 0.5, 750, 939, 0, 0, 46, 382 )
            self:addElement( PCKoreaContentDescriptorsContainer )
            self.PCKoreaContentDescriptorsContainer = PCKoreaContentDescriptorsContainer
            
            local TcmRules = CoD.Tcm_Pause_Rules.new( f1_arg0, f1_arg1, 0.5, 0.5, -501.5, 503.5, 0.5, 0.5, 29.5, 391.5 )
            self:addElement( TcmRules )
            self.TcmRules = TcmRules
            
            local DoubleXPIconsLeftAligned = CoD.DoubleXPIconsLeftAligned.new( f1_arg0, f1_arg1, 0.5, 0.5, -874, -658, 1, 1, -229.5, -157.5 )
            self:addElement( DoubleXPIconsLeftAligned )
            self.DoubleXPIconsLeftAligned = DoubleXPIconsLeftAligned
            
            self:mergeStateConditions( {
                  {
                        stateName = "CP_PauseMenu",
                        condition = function ( menu, element, event )
                              return IsCampaign()
                        end
                  },
                  {
                        stateName = "Trials_PauseMenu",
                        condition = function ( menu, element, event )
                              return CoD.HUDUtility.IsAnyGameType( f1_arg1, "ztrials" )
                        end
                  },
                  {
                        stateName = "Rush_PauseMenu",
                        condition = function ( menu, element, event )
                              return CoD.HUDUtility.IsAnyGameType( f1_arg1, "zstandard" )
                        end
                  }
            } )
            local f1_local12 = self
            local f1_local13 = self.subscribeToModel
            local f1_local14 = Engine[@"getglobalmodel"]()
            f1_local13( f1_local12, f1_local14["lobbyRoot.lobbyNav"], function ( f8_arg0 )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = f8_arg0:get(),
                        modelName = "lobbyRoot.lobbyNav"
                  } )
            end, false )
            LUI.OverrideFunction_CallOriginalFirst( self, "setState", function ( element, controller, f9_arg2, f9_arg3, f9_arg4 )
                  if not IsCurrentMenu( f1_arg0, "StartMenu_Main" ) then
                        HideWidget( self.buttonList )
                        HideWidget( self.rankProgress )
                        HideWidget( self.PCKoreaContentDescriptorsContainer )
                  end
            end )
            f1_local1.id = "buttonList"
            PCbuttonList.id = "PCbuttonList"
            RoundDescriptionGrid.id = "RoundDescriptionGrid"
            Scoreboard.id = "Scoreboard"
            ScoreboardRush.id = "ScoreboardRush"
            TcmRules.id = "TcmRules"
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            if PreLoadFunc then
                  PreLoadFunc( self, f1_arg1, f1_arg0 )
            end
            f1_local13 = self
            if IsPC() and not IsCurrentMenu( f1_arg0, "StartMenu_Main" ) and CoD.HUDUtility.IsAnyGameType( f1_arg1, "zstandard" ) then
                  ReplaceElementWithFake( self, "rankProgress" )
            end
            return self
      end

      CoD.StartMenu_GameOptions_ZM.__resetProperties = function ( f10_arg0 )
            f10_arg0.RoundDescriptionGrid:completeAnimation()
            f10_arg0.Scoreboard:completeAnimation()
            f10_arg0.rankProgress:completeAnimation()
            f10_arg0.TrialsRulesBackground:completeAnimation()
            f10_arg0.ScoreboardRush:completeAnimation()
            f10_arg0.RoundDescriptionGrid:setAlpha( 0 )
            f10_arg0.Scoreboard:setAlpha( 1 )
            f10_arg0.rankProgress:setLeftRight( 0.5, 0.5, -857, 857 )
            f10_arg0.rankProgress:setTopBottom( 1, 1, -157.5, -58.5 )
            f10_arg0.rankProgress:setAlpha( 1 )
            f10_arg0.TrialsRulesBackground:setAlpha( 0 )
            f10_arg0.ScoreboardRush:setAlpha( 0 )
      end

      CoD.StartMenu_GameOptions_ZM.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f11_arg0, f11_arg1 )
                        f11_arg0:__resetProperties()
                        f11_arg0:setupElementClipCounter( 3 )
                        local f11_local0 = function ( f12_arg0 )
                              local f12_local0 = function ( f13_arg0 )
                                    f13_arg0:beginAnimation( 150 )
                                    f13_arg0:setAlpha( 1 )
                                    f13_arg0:registerEventHandler( "transition_complete_keyframe", f11_arg0.clipFinished )
                              end
                              
                              f11_arg0.rankProgress:beginAnimation( 150 )
                              f11_arg0.rankProgress:registerEventHandler( "interrupted_keyframe", f11_arg0.clipInterrupted )
                              f11_arg0.rankProgress:registerEventHandler( "transition_complete_keyframe", f12_local0 )
                        end
                        
                        f11_arg0.rankProgress:completeAnimation()
                        f11_arg0.rankProgress:setAlpha( 0 )
                        f11_local0( f11_arg0.rankProgress )
                        f11_arg0.RoundDescriptionGrid:completeAnimation()
                        f11_arg0.RoundDescriptionGrid:setAlpha( 0 )
                        f11_arg0.clipFinished( f11_arg0.RoundDescriptionGrid )
                        local f11_local1 = function ( f14_arg0 )
                              f11_arg0.Scoreboard:beginAnimation( 150, Enum[@"luitween"][@"luitween_ease_in"] )
                              f11_arg0.Scoreboard:setAlpha( 1 )
                              f11_arg0.Scoreboard:registerEventHandler( "interrupted_keyframe", f11_arg0.clipInterrupted )
                              f11_arg0.Scoreboard:registerEventHandler( "transition_complete_keyframe", f11_arg0.clipFinished )
                        end
                        
                        f11_arg0.Scoreboard:completeAnimation()
                        f11_arg0.Scoreboard:setAlpha( 0 )
                        f11_local1( f11_arg0.Scoreboard )
                  end
            },
            CP_PauseMenu = {
                  DefaultClip = function ( f15_arg0, f15_arg1 )
                        f15_arg0:__resetProperties()
                        f15_arg0:setupElementClipCounter( 2 )
                        f15_arg0.rankProgress:completeAnimation()
                        f15_arg0.rankProgress:setLeftRight( 0.5, 0.5, 18, 460 )
                        f15_arg0.rankProgress:setTopBottom( 1, 1, 259, 358 )
                        f15_arg0.clipFinished( f15_arg0.rankProgress )
                        local f15_local0 = function ( f16_arg0 )
                              f15_arg0.Scoreboard:beginAnimation( 150, Enum[@"luitween"][@"luitween_ease_in"] )
                              f15_arg0.Scoreboard:setAlpha( 1 )
                              f15_arg0.Scoreboard:registerEventHandler( "interrupted_keyframe", f15_arg0.clipInterrupted )
                              f15_arg0.Scoreboard:registerEventHandler( "transition_complete_keyframe", f15_arg0.clipFinished )
                        end
                        
                        f15_arg0.Scoreboard:completeAnimation()
                        f15_arg0.Scoreboard:setAlpha( 0 )
                        f15_local0( f15_arg0.Scoreboard )
                  end
            },
            Trials_PauseMenu = {
                  DefaultClip = function ( f17_arg0, f17_arg1 )
                        f17_arg0:__resetProperties()
                        f17_arg0:setupElementClipCounter( 4 )
                        local f17_local0 = function ( f18_arg0 )
                              local f18_local0 = function ( f19_arg0 )
                                    f19_arg0:beginAnimation( 149 )
                                    f19_arg0:setAlpha( 1 )
                                    f19_arg0:registerEventHandler( "transition_complete_keyframe", f17_arg0.clipFinished )
                              end
                              
                              f17_arg0.rankProgress:beginAnimation( 300 )
                              f17_arg0.rankProgress:registerEventHandler( "interrupted_keyframe", f17_arg0.clipInterrupted )
                              f17_arg0.rankProgress:registerEventHandler( "transition_complete_keyframe", f18_local0 )
                        end
                        
                        f17_arg0.rankProgress:completeAnimation()
                        f17_arg0.rankProgress:setAlpha( 0 )
                        f17_local0( f17_arg0.rankProgress )
                        local f17_local1 = function ( f20_arg0 )
                              f17_arg0.TrialsRulesBackground:beginAnimation( 150 )
                              f17_arg0.TrialsRulesBackground:setAlpha( 1 )
                              f17_arg0.TrialsRulesBackground:registerEventHandler( "interrupted_keyframe", f17_arg0.clipInterrupted )
                              f17_arg0.TrialsRulesBackground:registerEventHandler( "transition_complete_keyframe", f17_arg0.clipFinished )
                        end
                        
                        f17_arg0.TrialsRulesBackground:completeAnimation()
                        f17_arg0.TrialsRulesBackground:setAlpha( 0 )
                        f17_local1( f17_arg0.TrialsRulesBackground )
                        local f17_local2 = function ( f21_arg0 )
                              local f21_local0 = function ( f22_arg0 )
                                    f22_arg0:beginAnimation( 150 )
                                    f22_arg0:setAlpha( 1 )
                                    f22_arg0:registerEventHandler( "transition_complete_keyframe", f17_arg0.clipFinished )
                              end
                              
                              f17_arg0.RoundDescriptionGrid:beginAnimation( 150 )
                              f17_arg0.RoundDescriptionGrid:registerEventHandler( "interrupted_keyframe", f17_arg0.clipInterrupted )
                              f17_arg0.RoundDescriptionGrid:registerEventHandler( "transition_complete_keyframe", f21_local0 )
                        end
                        
                        f17_arg0.RoundDescriptionGrid:completeAnimation()
                        f17_arg0.RoundDescriptionGrid:setAlpha( 0 )
                        f17_local2( f17_arg0.RoundDescriptionGrid )
                        f17_arg0.Scoreboard:completeAnimation()
                        f17_arg0.Scoreboard:setAlpha( 0 )
                        f17_arg0.clipFinished( f17_arg0.Scoreboard )
                  end
            },
            Rush_PauseMenu = {
                  DefaultClip = function ( f23_arg0, f23_arg1 )
                        f23_arg0:__resetProperties()
                        f23_arg0:setupElementClipCounter( 3 )
                        local f23_local0 = function ( f24_arg0 )
                              local f24_local0 = function ( f25_arg0 )
                                    f25_arg0:beginAnimation( 150 )
                                    f25_arg0:setAlpha( 1 )
                                    f25_arg0:registerEventHandler( "transition_complete_keyframe", f23_arg0.clipFinished )
                              end
                              
                              f23_arg0.rankProgress:beginAnimation( 150 )
                              f23_arg0.rankProgress:registerEventHandler( "interrupted_keyframe", f23_arg0.clipInterrupted )
                              f23_arg0.rankProgress:registerEventHandler( "transition_complete_keyframe", f24_local0 )
                        end
                        
                        f23_arg0.rankProgress:completeAnimation()
                        f23_arg0.rankProgress:setAlpha( 0 )
                        f23_local0( f23_arg0.rankProgress )
                        f23_arg0.Scoreboard:completeAnimation()
                        f23_arg0.Scoreboard:setAlpha( 0 )
                        f23_arg0.clipFinished( f23_arg0.Scoreboard )
                        local f23_local1 = function ( f26_arg0 )
                              f23_arg0.ScoreboardRush:beginAnimation( 150, Enum[@"luitween"][@"luitween_ease_in"] )
                              f23_arg0.ScoreboardRush:setAlpha( 1 )
                              f23_arg0.ScoreboardRush:registerEventHandler( "interrupted_keyframe", f23_arg0.clipInterrupted )
                              f23_arg0.ScoreboardRush:registerEventHandler( "transition_complete_keyframe", f23_arg0.clipFinished )
                        end
                        
                        f23_arg0.ScoreboardRush:completeAnimation()
                        f23_arg0.ScoreboardRush:setAlpha( 0 )
                        f23_local1( f23_arg0.ScoreboardRush )
                  end
            }
      }

      CoD.StartMenu_GameOptions_ZM.__onClose = function ( f27_arg0 )
            f27_arg0.ChangeSpecialButton:close()
            f27_arg0.buttonList:close()
            f27_arg0.PCbuttonList:close()
            f27_arg0.rankProgress:close()
            f27_arg0.TrialsRulesBackground:close()
            f27_arg0.RoundDescriptionGrid:close()
            f27_arg0.Scoreboard:close()
            f27_arg0.ScoreboardRush:close()
            f27_arg0.PCKoreaContentDescriptorsContainer:close()
            f27_arg0.TcmRules:close()
            f27_arg0.DoubleXPIconsLeftAligned:close()
            f27_arg0.ChangeCharacters:close()
            f27_arg0.SaveGameButton:close()
            f27_arg0.BoxPatchesButton:close()
      end
end