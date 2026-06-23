--[[
      .\hksc.exe '.\Scripts\PostMainQuestContinue.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\PostMainQuestContinue.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

CoD.EnhQuestContinueOptions = InheritFrom( LUI.UIElement )
CoD.EnhQuestContinueOptions.__defaultWidth = 1920
CoD.EnhQuestContinueOptions.__defaultHeight = 1080
CoD.EnhQuestContinueOptions.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.EnhQuestContinueOptions )
	self.id = "EnhQuestContinueOptions"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )

	CoD.EnhModPrintInfo("setting up main quest continue menu")

	-------------------------------

	-- some background ig
	local Backer = LUI.UIImage.new( 0, 1, 0, 0, 0, 1, 0, 0 )
	Backer:setAlpha(0.85)
	Backer:setRGB(0, 0, 0)
	self:addElement( Backer )
	self.Backer = Backer

	local Continue = LUI.UIText.new(0.50, 0.50, -193.00, 176.00, 0.50, 0.50, -76.25, 2.75)
	Continue:setTTF("skorzhen")
	Continue:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
	Continue:setAlignment( Enum[@"luialignment"][@"lui_alignment_middle"] )
	Continue:setText("Continue?")

	Continue:setShaderVector(0, 0, 0, 0, 0)
	Continue:setShaderVector(1, 0.5, 0, 0, 0)
	Continue:setShaderVector(2, 0, 0, 0, 0)
	Continue:setShaderVector(3, 0, 0, 0, 0)
	Continue:setShaderVector(4, 0, 0, 0, 0)

	self:addElement(Continue)
	self.Continue = Continue

	local Continue_Desc = LUI.UIText.new(0.50, 0.50, -477.75, -137.75, 0.50, 0.50, 20.75, 43.75)
	Continue_Desc:setTTF("skorzhen")
	Continue_Desc:setText("Choose to Continue playing the match with special rewards OR End the match and see your After Action Report Stats.")

	Continue_Desc:setShaderVector(0, 0, 0, 0, 0)
	Continue_Desc:setShaderVector(1, 0.5, 0, 0, 0)
	Continue_Desc:setShaderVector(2, 0, 0, 0, 0)
	Continue_Desc:setShaderVector(3, 0, 0, 0, 0)
	Continue_Desc:setShaderVector(4, 0, 0, 0, 0)

	self:addElement(Continue_Desc)
	self.Continue_Desc = Continue_Desc

	-- test button
	local ContinueButton = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.50, 0.50, 40.76, 338.76, 0.50, 0.50, 65.50, 115.50 )

	ContinueButton.MiddleText:setTTF( "skorzhen" )
	ContinueButton.MiddleText:setText("Continue")

	ContinueButton.MiddleTextFocus:setText("Continue")
	ContinueButton.MiddleTextFocus:setTTF( "skorzhen" )
	
	ContinueButton:linkToElementModel( self, nil, false, function ( model )
		ContinueButton:setModel( model, f1_arg1 )
	end )
	self:addElement( ContinueButton )
	self.ContinueButton = ContinueButton


	f1_arg0:AddButtonCallbackFunction( ContinueButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
		if not MenuPropertyIsTrue(f1_arg0, "m_inputDisabled") then
				PlaySoundAlias( "uin_paint_image_flip_toggle" )
				CoD.EnhModPrintInfo("ContinueButton")

				CoD.BaseUtility.SendCustomMenuResponse(Engine[@"getprimarycontroller"](), "shield_enh_mainquest_continue", "blah", 2)

				-- Fade out animation
				self:beginAnimation("fadeout", 300)
				self:setAlpha(0)

				LockInput( self, f1_arg1, false )
				SetAllowCursorMovement( f1_arg0, false )
				SetMenuProperty( f1_arg0, "m_inputDisabled", true )

				Engine[@"setdvar"]("ui_drawcrosshair", 1)

				return true
		end
				return false
	end, function ( element, menu, controller )
				CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm" )
				return false
	end, false )

	ContinueButton.id = "ContinueButton"

	-- test button
	local ExitButton = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.50, 0.50, -362.25, -62.25, 0.50, 0.50, 65.50, 115.50 )

	ExitButton.MiddleText:setTTF( "skorzhen" )
	ExitButton.MiddleText:setText("End Match")

	ExitButton.MiddleTextFocus:setText("End Match")
	ExitButton.MiddleTextFocus:setTTF( "skorzhen" )
	
	ExitButton:linkToElementModel( self, nil, false, function ( model )
		ExitButton:setModel( model, f1_arg1 )
	end )
	self:addElement( ExitButton )
	self.ExitButton = ExitButton

    f1_arg0:AddButtonCallbackFunction( ExitButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
            if not MenuPropertyIsTrue(f1_arg0, "m_inputDisabled") then
                  PlaySoundAlias( "uin_paint_image_flip_toggle" )
                  CoD.EnhModPrintInfo("ExitButton")

                  CoD.BaseUtility.SendCustomMenuResponse(Engine[@"getprimarycontroller"](), "shield_enh_mainquest_continue", "blah", 1)

                  -- Fade out animation
                  self:beginAnimation("fadeout", 300)
                  self:setAlpha(0)

                  LockInput( self, f1_arg1, false )
				  SetAllowCursorMovement( f1_arg0, false )
                  SetMenuProperty( f1_arg0, "m_inputDisabled", true )

                  Engine[@"setdvar"]("ui_drawcrosshair", 1)

                  return true
            end
                  return false
      end, function ( element, menu, controller )
                  CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm" )
                  return false
      end, false )

		ExitButton.id = "ExitButton"

      -- meter
      local MeterTimeout_bg = LUI.UIImage.new(0.5, 0.5, -500 - 4, 500 + 4, 0.5, 0.5, 140 - 6, 150 + 6)
      MeterTimeout_bg:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
      MeterTimeout_bg:setRGB(0, 0, 0)
      MeterTimeout_bg:setAlpha(0)
      self:addElement(MeterTimeout_bg)
      self.MeterTimeout_bg = MeterTimeout_bg
      
      local MeterTimeout = LUI.UIImage.new(0.5, 0.5, -500, 500, 0.5, 0.5, 140, 150)
      MeterTimeout:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_4316E67E1DF2198E"))
      MeterTimeout:setShaderVector(1.000000, 0.01, 0, 0, 0)
      MeterTimeout:setShaderVector(2.000000, 1, 0, 0, 0)
      MeterTimeout:setShaderVector(3.000000, 0, 0, 0, 0)
      MeterTimeout:setRGB(0, 1, 1)
      MeterTimeout:setAlpha(0)
      self:addElement(MeterTimeout)
      self.MeterTimeout = MeterTimeout

      Continue:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
		if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"enhancement_mainquest_visibility" ) then
				local scriptData = CoD.GetScriptNotifyData(model)
				
				local id = scriptData[1]

				if id == 1 then
					-- host
					self:beginAnimation("fadein", 300)
					self:setAlpha(1)

					LockInput( self, f1_arg1, true )
					SetAllowCursorMovement( f1_arg0, true )
					SetMenuProperty( f1_arg0, "m_inputDisabled", false )

					Engine[@"setdvar"]("ui_drawcrosshair", 0)
				elseif id == 2 then
					-- non host
					self:beginAnimation("fadein", 300)
					self:setAlpha(1)

					LockInput( self, f1_arg1, true )
					SetAllowCursorMovement( f1_arg0, true )
					SetMenuProperty( f1_arg0, "m_inputDisabled", false )

					Engine[@"setdvar"]("ui_drawcrosshair", 0)

					self.Continue:setText("Waiting for Host to choose an option...")
					self.Continue_Desc:setAlpha(0)
					self.ContinueButton:setAlpha(0)
					self.ExitButton:setAlpha(0)
				elseif id == 3 then
					local meter = scriptData[2] / 100
					local meter_shader = meter / 100

					self.MeterTimeout:setAlpha(1)
					self.MeterTimeout_bg:setAlpha(1)
					self.MeterTimeout:beginAnimation("keyframe", 200, false, false, CoD.TweenType.Linear) -- 300 S
					self.MeterTimeout:setShaderVector(0.000000, meter_shader, 0, 0, 0)
				else
					self:beginAnimation("fadeout", 300)
					self:setAlpha(0)

					LockInput( self, f1_arg1, false )
					SetAllowCursorMovement( f1_arg0, false )
					SetMenuProperty( f1_arg0, "m_inputDisabled", true )

					Engine[@"setdvar"]("ui_drawcrosshair", 1)
				end
		end
	end)

	-------------------------------

	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )

    if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end

	self.__defaultFocus = CloseButton
	SetMenuProperty( f1_arg0, "m_inputDisabled", true )
	self:setAlpha(0)

	return self
end

CoD.EnhQuestContinueOptions.__resetProperties = function ( f16_arg0 )
	
end

CoD.EnhQuestContinueOptions.__clipsPerState = {

}

CoD.EnhQuestContinueOptions.__onClose = function ( f19_arg0 )

end