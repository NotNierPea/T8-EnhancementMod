--[[
      .\hksc.exe '.\Scripts\Callouts.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\Callouts.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

-- global var..
local Callouts_Idx = 13

------------------------

CoD.HUDUtility.EnhAddCalloutWheelCallback = function ( f463_arg0, f463_arg1 )
	f463_arg1._onChooseWedge = function ( f464_arg0, f464_arg1, f464_arg2 )
		CoD.BaseUtility.SendCustomMenuResponse(Engine[@"getprimarycontroller"](), "shield_enh_gesture", "blah", f464_arg2.addNumber:get())
            CoD.EnhModPrintInfo("Gesture: sent callback id " .. f464_arg2.addNumber:get())
	end
end

CoD.HUDUtility.EnhInitWheelPCForMouseDrag = function ( f447_arg0, f447_arg1, f447_arg2, f447_arg3 )
	if not CoD.isPC then
		return 
	else
		local f447_local0 = f447_arg0
		local f447_local1 = f447_arg0.subscribeToModel
		local f447_local2 = DataSources.FreeCursor.getModel( f447_arg1 )
		f447_local1( f447_local0, f447_local2.position, function ( f448_arg0 )
			if f447_arg0._mouseSelectionEnabled and not f447_arg0._gamepadSelectionEnabled then
				CoD.HUDUtility.UpdateCurrentStickSelectionModelOnPC( f447_arg0, f447_arg1, f447_arg3 )
			end
		end, false )
		LUI.OverrideFunction_CallOriginalFirst( f447_arg0, "setState", function ( element, controller, f449_arg2, f449_arg3, f449_arg4 )
			if IsSelfInState( f447_arg0, "Visible" ) then
				if IsMouseOrKeyboard( controller ) then
					CoD.HUDUtility.MenuDelayedSetRightStickLock( f447_arg2, controller, 0, true )
					Engine[@"hash_2D368E9CBCFAE9B0"]()
					f447_arg0._mouseSelectionEnabled = true
					EnableMouseLockInputBinding( f447_arg2, controller, true, true )
				end
			else
				f447_arg0._mouseSelectionEnabled = false
				local f449_local0 = f447_arg3:getStickModel( controller )
				f449_local0.SelectedWedge:set( -1 )
				EnableMouseLockInputBinding( f447_arg2, controller, false, true )
			end
		end )
	end
end

CoD.HUDUtility.EnhIsCalloutsButtonPressed = function ( controller )
      local button_pressed = false
      
      -- keyboard/mouse's
      button_pressed = CoD.ModelUtility.IsModelValueEqualToEnum( controller, "ButtonBits.actionSlots.Flourish_Callouts", Enum[@"hash_1A3A4D6F29781E2C"][@"hash_DF43D93F8EF4FEA"] )
      if not button_pressed then
            button_pressed = CoD.ModelUtility.IsModelValueEqualTo( controller, "hudItems.PCWheels.calloutWheelKeyPressed", 1 )
            if button_pressed then
                  button_pressed = CoD.ModelUtility.IsModelValueEqualTo( controller, "hudItems.PCWheels.sprayGestureWheelKeyPressed", 0 )
            end
      end

      if not button_pressed then
            -- gamepad's
            button_pressed = CoD.ModelUtility.AreButtonModelValueBitsSet( controller, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], Enum[@"luibuttonflags"][@"flag_down"] )
            if button_pressed then
                  button_pressed = CoD.ModelUtility.IsModelValueEqualTo( controller, "ButtonBits." .. Enum[@"luibutton"][@"lui_key_lb"], 1 )
            end
      end

      --CoD.EnhModPrintInfo("value: " .. tostring(button_pressed))

	return button_pressed
end

local function AddCalloutToTable( array_tbl, name, image )
      if not array_tbl then return end
      local arrIndex = #array_tbl -- start from 0
      table.insert( array_tbl, {
            models = {
                  image = image or @"loot_ui_icon_stickers_random_22_large",
                  disabled = false,
                  text = name or "",
                  arrayIndex = arrIndex,
                  index = arrIndex,
                  chosen = false,
                  addNumber = arrIndex,
                  isSocialCallout = false
            },
            properties = {}
      } )
end

------------------------

DataSources.EnhCalloutWheel = DataSourceHelpers.ListSetup( "EnhCalloutWheel", function ( f459_arg0, f459_arg1 )
      local array_callouts = {}

      local callouts = {
            { name = "Fishing Rod",             image = @"loot_ui_icon_stickers_random_22_large" },
            { name = "Yawn",                    image = @"loot_ui_icon_stickers_random_22_large" },
            { name = "Cooking",                 image = @"loot_ui_icon_stickers_random_22_large" },
            { name = "Standing",                image = @"loot_ui_icon_stickers_random_22_large" },
            { name = "Prob Hunt",               image = @"loot_ui_icon_stickers_random_22_large" },
            { name = "Spinner",                 image = @"loot_ui_icon_stickers_random_22_large" },
            { name = "Dance #1",                image = @"loot_ui_icon_stickers_random_22_large" },
            { name = "Time's Running Out",      image = @"loot_ui_icon_stickers_random_22_large" },
            { name = "Clap Clap",               image = @"loot_ui_icon_stickers_random_22_large" },
            { name = "Dance #2",                image = @"loot_ui_icon_stickers_random_22_large" },
            { name = "Dance #3",                image = @"loot_ui_icon_stickers_random_22_large" },
            { name = "Dance #4",                image = @"loot_ui_icon_stickers_random_22_large" },
            { name = "Dance #5",                image = @"loot_ui_icon_stickers_random_22_large" },
      }

      for i, c in ipairs( callouts ) do
            AddCalloutToTable( array_callouts, c.name, c.image )
      end

      return array_callouts
end, nil, nil, function ( f462_arg0, f462_arg1, f462_arg2 )
end )

------------------------

CoD.EnhWheelPrompt = InheritFrom( LUI.UIElement )
CoD.EnhWheelPrompt.__defaultWidth = 80
CoD.EnhWheelPrompt.__defaultHeight = 80
CoD.EnhWheelPrompt.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.EnhWheelPrompt )
	self.id = "EnhWheelPrompt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local RStick = LUI.UIImage.new( 0.5, 0.5, -40, 40, 0.5, 0.5, -40, 40 )
	RStick:subscribeToGlobalModel( f1_arg1, "Controller", "move_right_stick_button_image", function ( model )
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RStick:setImage( RegisterImage( f2_local0 ) )
		end
	end )
	self:addElement( RStick )
	self.RStick = RStick
	
	self:mergeStateConditions( {
		{
			stateName = "Keyboard",
			condition = function ( menu, element, event )
				return IsMouseOrKeyboard( f1_arg1 )
			end
		}
	} )
	self:appendEventHandler( "input_source_changed", function ( f4_arg0, f4_arg1 )
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState( self, f4_arg1 )
	end )
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local3( f1_local2, f1_local4.LastInput, function ( f5_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput"
		} )
	end, false )
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.EnhWheelPrompt.__resetProperties = function ( f6_arg0 )
	f6_arg0.RStick:completeAnimation()
	f6_arg0.RStick:setAlpha( 1 )
end

CoD.EnhWheelPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f7_arg0, f7_arg1 )
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter( 1 )
			f7_arg0.RStick:completeAnimation()
			f7_arg0.RStick:setAlpha( 1 )
			f7_arg0.clipFinished( f7_arg0.RStick )
		end
	},
	Keyboard = {
		DefaultClip = function ( f8_arg0, f8_arg1 )
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter( 1 )
			f8_arg0.RStick:completeAnimation()
			f8_arg0.RStick:setAlpha( 0 )
			f8_arg0.clipFinished( f8_arg0.RStick )
		end
	}
}

CoD.EnhWheelPrompt.__onClose = function ( f9_arg0 )
	f9_arg0.RStick:close()
end

CoD.EnhCalloutItemText = InheritFrom( LUI.UIElement )
CoD.EnhCalloutItemText.__defaultWidth = 182
CoD.EnhCalloutItemText.__defaultHeight = 26
CoD.EnhCalloutItemText.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.EnhCalloutItemText )
	self.id = "EnhCalloutItemText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local Title = LUI.UIText.new( 0.5, 0.5, -91, 91, 0, 0, 0, 26 )
	Title:setTTF( "ttmussels_regular" )
	Title:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
	Title:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
	Title:linkToElementModel( self, "text", true, function ( model )
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Title:setText( CoD.BaseUtility.LocalizeIfXHash( f2_local0 ) )
		end
	end )
	self:addElement( Title )
	self.Title = Title
	
	self:mergeStateConditions( {
		{
			stateName = "SocialCallout",
			condition = function ( menu, element, event )
				return CoD.ModelUtility.IsSelfModelValueEqualTo( element, f1_arg1, "isSocialCallout", 1 )
			end
		}
	} )
	self:linkToElementModel( self, "isSocialCallout", true, function ( model )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isSocialCallout"
		} )
	end )
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.EnhCalloutItemText.__resetProperties = function ( f5_arg0 )
	f5_arg0.Title:completeAnimation()
	f5_arg0.Title:setRGB( 1, 1, 1 )
end

CoD.EnhCalloutItemText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f6_arg0, f6_arg1 )
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter( 0 )
		end
	},
	SocialCallout = {
		DefaultClip = function ( f7_arg0, f7_arg1 )
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter( 1 )
			f7_arg0.Title:completeAnimation()
			f7_arg0.Title:setRGB( 1.0, 1.0, 1.0 )
			f7_arg0.clipFinished( f7_arg0.Title )
		end
	}
}

CoD.EnhCalloutItemText.__onClose = function ( f8_arg0 )
	f8_arg0.Title:close()
end

CoD.EnhCalloutItem = InheritFrom( LUI.UIElement )
CoD.EnhCalloutItem.__defaultWidth = 382
CoD.EnhCalloutItem.__defaultHeight = 382
CoD.EnhCalloutItem.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.EnhCalloutItem )
	self.id = "EnhCalloutItem"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local backingSolid = LUI.UIImage.new( -0.5, 1.5, 0, 0, -0.5, 0.5, -8, -8 )
	backingSolid:setRGB( 0, 0, 0 )
	backingSolid:setAlpha( 0.5 )
	backingSolid:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_3027EBC307ABF865" ) )
	backingSolid:setShaderVector( 0, 0.1, 0.25, 0, 0 )
	backingSolid:setShaderVector( 2, 0, 0, 0, 0 )
	backingSolid:linkToElementModel( self, "angleWidth", true, function ( model )
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			backingSolid:setShaderVector( 1, CoD.GetVectorComponentFromString( f2_local0, 1 ), CoD.GetVectorComponentFromString( f2_local0, 2 ), CoD.GetVectorComponentFromString( f2_local0, 3 ), CoD.GetVectorComponentFromString( f2_local0, 4 ) )
		end
	end )
	self:addElement( backingSolid )
	self.backingSolid = backingSolid
	
	local backing = LUI.UIImage.new( -0.5, 1.5, 0, 0, -0.5, 0.5, -8, -8 )
	backing:setRGB( 0, 0, 0 )
	backing:setAlpha( 0.5 )
	backing:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_3027EBC307ABF865" ) )
	backing:setShaderVector( 0, 0.1, 0.25, 0, 0 )
	backing:setShaderVector( 2, 0, 0, 0, 0 )
	backing:linkToElementModel( self, "angleWidth", true, function ( model )
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			backing:setShaderVector( 1, CoD.GetVectorComponentFromString( f3_local0, 1 ), CoD.GetVectorComponentFromString( f3_local0, 2 ), CoD.GetVectorComponentFromString( f3_local0, 3 ), CoD.GetVectorComponentFromString( f3_local0, 4 ) )
		end
	end )
	self:addElement( backing )
	self.backing = backing
	
	local Title = CoD.EnhCalloutItemText.new( f1_arg0, f1_arg1, 0.5, 0.5, -91, 91, 0, 0, -122, -96 )
	Title:linkToElementModel( self, "zRot", true, function ( model )
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Title:setZRot( Multiple( -1, f4_local0 ) )
		end
	end )
	Title:linkToElementModel( self, nil, false, function ( model )
		Title:setModel( model, f1_arg1 )
	end )
	self:addElement( Title )
	self.Title = Title
	
	self:mergeStateConditions( {
		{
			stateName = "Disabled",
			condition = function ( menu, element, event )
				return CoD.ModelUtility.IsSelfModelValueTrue( element, f1_arg1, "disabled" )
			end
		},
		{
			stateName = "Chosen",
			condition = function ( menu, element, event )
				return CoD.ModelUtility.IsSelfModelValueTrue( element, f1_arg1, "chosen" ) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue( element, f1_arg1, "RightStick", "SelectedWedge", "index" )
			end
		},
		{
			stateName = "Highlighted",
			condition = function ( menu, element, event )
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue( element, f1_arg1, "RightStick", "SelectedWedge", "index" )
			end
		}
	} )
	self:linkToElementModel( self, "disabled", true, function ( model )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled"
		} )
	end )
	self:linkToElementModel( self, "chosen", true, function ( model )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "chosen"
		} )
	end )
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = DataSources.RightStick.getModel( f1_arg1 )
	f1_local5( f1_local4, f1_local6.SelectedWedge, function ( f11_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "SelectedWedge"
		} )
	end, false )
	self:linkToElementModel( self, "index", true, function ( model )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "index"
		} )
	end )
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.EnhCalloutItem.__resetProperties = function ( f13_arg0 )
	f13_arg0.Title:completeAnimation()
	f13_arg0.backing:completeAnimation()
	f13_arg0.Title:setTopBottom( 0, 0, -122, -96 )
	f13_arg0.Title:setRGB( 1, 1, 1 )
	f13_arg0.Title:setAlpha( 1 )
	f13_arg0.backing:setTopBottom( -0.5, 0.5, -8, -8 )
	f13_arg0.backing:setRGB( 0, 0, 0 )
	f13_arg0.backing:setAlpha( 0.5 )
	f13_arg0.backing:setScale( 1, 1 )
end

CoD.EnhCalloutItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f14_arg0, f14_arg1 )
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter( 1 )
			f14_arg0.Title:completeAnimation()
			f14_arg0.Title:setRGB( 0.78, 0.75, 0.62 )
			f14_arg0.clipFinished( f14_arg0.Title )
		end,
		Selected = function ( f15_arg0, f15_arg1 )
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter( 2 )
			local f15_local0 = function ( f16_arg0 )
				f15_arg0.backing:beginAnimation( 150 )
				f15_arg0.backing:setRGB( 0.57, 0.42, 0.03 )
				f15_arg0.backing:setAlpha( 0.6 )
				f15_arg0.backing:registerEventHandler( "interrupted_keyframe", f15_arg0.clipInterrupted )
				f15_arg0.backing:registerEventHandler( "transition_complete_keyframe", f15_arg0.clipFinished )
			end
			
			f15_arg0.backing:completeAnimation()
			f15_arg0.backing:setRGB( 0, 0, 0 )
			f15_arg0.backing:setAlpha( 0.5 )
			f15_local0( f15_arg0.backing )
			local f15_local1 = function ( f17_arg0 )
				f15_arg0.Title:beginAnimation( 150 )
				f15_arg0.Title:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
				f15_arg0.Title:registerEventHandler( "interrupted_keyframe", f15_arg0.clipInterrupted )
				f15_arg0.Title:registerEventHandler( "transition_complete_keyframe", f15_arg0.clipFinished )
			end
			
			f15_arg0.Title:completeAnimation()
			f15_arg0.Title:setRGB( 0.78, 0.75, 0.62 )
			f15_local1( f15_arg0.Title )
		end,
		Highlighted = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 2 )
			local f18_local0 = function ( f19_arg0 )
				f18_arg0.backing:beginAnimation( 200, Enum[@"luitween"][@"luitween_ease_both"] )
				f18_arg0.backing:setTopBottom( -0.5, 0.5, -45, -45 )
				f18_arg0.backing:setRGB( 0.57, 0.42, 0.03 )
				f18_arg0.backing:setAlpha( 1 )
				f18_arg0.backing:setScale( 1.2, 1.2 )
				f18_arg0.backing:registerEventHandler( "interrupted_keyframe", f18_arg0.clipInterrupted )
				f18_arg0.backing:registerEventHandler( "transition_complete_keyframe", f18_arg0.clipFinished )
			end
			
			f18_arg0.backing:completeAnimation()
			f18_arg0.backing:setTopBottom( -0.5, 0.5, -8, -8 )
			f18_arg0.backing:setRGB( 0, 0, 0 )
			f18_arg0.backing:setAlpha( 0.5 )
			f18_arg0.backing:setScale( 1, 1 )
			f18_local0( f18_arg0.backing )
			local f18_local1 = function ( f20_arg0 )
				f18_arg0.Title:beginAnimation( 200, Enum[@"luitween"][@"luitween_ease_both"] )
				f18_arg0.Title:setTopBottom( 0, 0, -132, -106 )
				f18_arg0.Title:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
				f18_arg0.Title:registerEventHandler( "interrupted_keyframe", f18_arg0.clipInterrupted )
				f18_arg0.Title:registerEventHandler( "transition_complete_keyframe", f18_arg0.clipFinished )
			end
			
			f18_arg0.Title:completeAnimation()
			f18_arg0.Title:setTopBottom( 0, 0, -122, -96 )
			f18_arg0.Title:setRGB( 0.78, 0.75, 0.62 )
			f18_local1( f18_arg0.Title )
		end,
		Chosen = function ( f21_arg0, f21_arg1 )
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter( 2 )
			local f21_local0 = function ( f22_arg0 )
				f21_arg0.backing:beginAnimation( 200, Enum[@"luitween"][@"luitween_ease_both"] )
				f21_arg0.backing:setTopBottom( -0.5, 0.5, -45, -45 )
				f21_arg0.backing:setRGB( 0.57, 0.42, 0.03 )
				f21_arg0.backing:setAlpha( 1 )
				f21_arg0.backing:setScale( 1.2, 1.2 )
				f21_arg0.backing:registerEventHandler( "interrupted_keyframe", f21_arg0.clipInterrupted )
				f21_arg0.backing:registerEventHandler( "transition_complete_keyframe", f21_arg0.clipFinished )
			end
			
			f21_arg0.backing:completeAnimation()
			f21_arg0.backing:setTopBottom( -0.5, 0.5, -8, -8 )
			f21_arg0.backing:setRGB( 0, 0, 0 )
			f21_arg0.backing:setAlpha( 0.5 )
			f21_arg0.backing:setScale( 1, 1 )
			f21_local0( f21_arg0.backing )
			local f21_local1 = function ( f23_arg0 )
				f21_arg0.Title:beginAnimation( 200, Enum[@"luitween"][@"luitween_ease_both"] )
				f21_arg0.Title:setTopBottom( 0, 0, -132, -106 )
				f21_arg0.Title:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
				f21_arg0.Title:registerEventHandler( "interrupted_keyframe", f21_arg0.clipInterrupted )
				f21_arg0.Title:registerEventHandler( "transition_complete_keyframe", f21_arg0.clipFinished )
			end
			
			f21_arg0.Title:completeAnimation()
			f21_arg0.Title:setTopBottom( 0, 0, -122, -96 )
			f21_arg0.Title:setRGB( 0.78, 0.75, 0.62 )
			f21_local1( f21_arg0.Title )
		end
	},
	Disabled = {
		DefaultClip = function ( f24_arg0, f24_arg1 )
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter( 2 )
			f24_arg0.backing:completeAnimation()
			f24_arg0.backing:setRGB( 0.15, 0.15, 0.15 )
			f24_arg0.clipFinished( f24_arg0.backing )
			f24_arg0.Title:completeAnimation()
			f24_arg0.Title:setRGB( 0.78, 0.75, 0.62 )
			f24_arg0.clipFinished( f24_arg0.Title )
		end
	},
	Chosen = {
		DefaultClip = function ( f25_arg0, f25_arg1 )
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter( 2 )
			f25_arg0.backing:completeAnimation()
			f25_arg0.backing:setTopBottom( -0.5, 0.5, -45, -45 )
			f25_arg0.backing:setRGB( 0.57, 0.42, 0.03 )
			f25_arg0.backing:setAlpha( 1 )
			f25_arg0.backing:setScale( 1.2, 1.2 )
			f25_arg0.clipFinished( f25_arg0.backing )
			f25_arg0.Title:completeAnimation()
			f25_arg0.Title:setTopBottom( 0, 0, -132, -106 )
			f25_arg0.Title:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
			f25_arg0.clipFinished( f25_arg0.Title )
		end,
		DefaultState = function ( f26_arg0, f26_arg1 )
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter( 2 )
			local f26_local0 = function ( f27_arg0 )
				local f27_local0 = function ( f28_arg0 )
					f28_arg0:beginAnimation( 240, Enum[@"luitween"][@"luitween_ease_both"] )
					f28_arg0:setTopBottom( -0.5, 0.5, -8, -8 )
					f28_arg0:setRGB( 0, 0, 0 )
					f28_arg0:setAlpha( 0.5 )
					f28_arg0:setScale( 1, 1 )
					f28_arg0:registerEventHandler( "transition_complete_keyframe", f26_arg0.clipFinished )
				end
				
				f26_arg0.backing:beginAnimation( 160 )
				f26_arg0.backing:setRGB( 0.92, 0.85, 0.67 )
				f26_arg0.backing:registerEventHandler( "interrupted_keyframe", f26_arg0.clipInterrupted )
				f26_arg0.backing:registerEventHandler( "transition_complete_keyframe", f27_local0 )
			end
			
			f26_arg0.backing:completeAnimation()
			f26_arg0.backing:setTopBottom( -0.5, 0.5, -45, -45 )
			f26_arg0.backing:setRGB( 0.57, 0.42, 0.03 )
			f26_arg0.backing:setAlpha( 1 )
			f26_arg0.backing:setScale( 1.2, 1.2 )
			f26_local0( f26_arg0.backing )
			local f26_local1 = function ( f29_arg0 )
				local f29_local0 = function ( f30_arg0 )
					f30_arg0:beginAnimation( 240, Enum[@"luitween"][@"luitween_ease_both"] )
					f30_arg0:setTopBottom( 0, 0, -122, -96 )
					f30_arg0:setRGB( 0.78, 0.75, 0.62 )
					f30_arg0:registerEventHandler( "transition_complete_keyframe", f26_arg0.clipFinished )
				end
				
				f26_arg0.Title:beginAnimation( 160 )
				f26_arg0.Title:registerEventHandler( "interrupted_keyframe", f26_arg0.clipInterrupted )
				f26_arg0.Title:registerEventHandler( "transition_complete_keyframe", f29_local0 )
			end
			
			f26_arg0.Title:completeAnimation()
			f26_arg0.Title:setTopBottom( 0, 0, -132, -106 )
			f26_arg0.Title:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
			f26_arg0.Title:setAlpha( 1 )
			f26_local1( f26_arg0.Title )
		end,
		Highlighted = function ( f31_arg0, f31_arg1 )
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter( 2 )
			f31_arg0.backing:completeAnimation()
			f31_arg0.backing:setTopBottom( -0.5, 0.5, -45, -45 )
			f31_arg0.backing:setRGB( 0.57, 0.42, 0.03 )
			f31_arg0.backing:setAlpha( 1 )
			f31_arg0.backing:setScale( 1.2, 1.2 )
			f31_arg0.clipFinished( f31_arg0.backing )
			f31_arg0.Title:completeAnimation()
			f31_arg0.Title:setTopBottom( 0, 0, -132, -106 )
			f31_arg0.Title:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
			f31_arg0.clipFinished( f31_arg0.Title )
		end
	},
	Highlighted = {
		DefaultClip = function ( f32_arg0, f32_arg1 )
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter( 2 )
			f32_arg0.backing:completeAnimation()
			f32_arg0.backing:setTopBottom( -0.5, 0.5, -45, -45 )
			f32_arg0.backing:setRGB( 0.57, 0.42, 0.03 )
			f32_arg0.backing:setAlpha( 1 )
			f32_arg0.backing:setScale( 1.2, 1.2 )
			f32_arg0.clipFinished( f32_arg0.backing )
			f32_arg0.Title:completeAnimation()
			f32_arg0.Title:setTopBottom( 0, 0, -132, -106 )
			f32_arg0.Title:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
			f32_arg0.clipFinished( f32_arg0.Title )
		end,
		DefaultState = function ( f33_arg0, f33_arg1 )
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter( 2 )
			local f33_local0 = function ( f34_arg0 )
				f33_arg0.backing:beginAnimation( 200, Enum[@"luitween"][@"luitween_ease_both"] )
				f33_arg0.backing:setTopBottom( -0.5, 0.5, -8, -8 )
				f33_arg0.backing:setRGB( 0, 0, 0 )
				f33_arg0.backing:setAlpha( 0.5 )
				f33_arg0.backing:setScale( 1, 1 )
				f33_arg0.backing:registerEventHandler( "interrupted_keyframe", f33_arg0.clipInterrupted )
				f33_arg0.backing:registerEventHandler( "transition_complete_keyframe", f33_arg0.clipFinished )
			end
			
			f33_arg0.backing:completeAnimation()
			f33_arg0.backing:setTopBottom( -0.5, 0.5, -45, -45 )
			f33_arg0.backing:setRGB( 0.57, 0.42, 0.03 )
			f33_arg0.backing:setAlpha( 1 )
			f33_arg0.backing:setScale( 1.2, 1.2 )
			f33_local0( f33_arg0.backing )
			local f33_local1 = function ( f35_arg0 )
				f33_arg0.Title:beginAnimation( 200, Enum[@"luitween"][@"luitween_ease_both"] )
				f33_arg0.Title:setTopBottom( 0, 0, -122, -96 )
				f33_arg0.Title:setRGB( 0.78, 0.75, 0.62 )
				f33_arg0.Title:registerEventHandler( "interrupted_keyframe", f33_arg0.clipInterrupted )
				f33_arg0.Title:registerEventHandler( "transition_complete_keyframe", f33_arg0.clipFinished )
			end
			
			f33_arg0.Title:completeAnimation()
			f33_arg0.Title:setTopBottom( 0, 0, -132, -106 )
			f33_arg0.Title:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
			f33_local1( f33_arg0.Title )
		end,
		Chosen = function ( f36_arg0, f36_arg1 )
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter( 2 )
			f36_arg0.backing:completeAnimation()
			f36_arg0.backing:setTopBottom( -0.5, 0.5, -45, -45 )
			f36_arg0.backing:setRGB( 0.57, 0.42, 0.03 )
			f36_arg0.backing:setAlpha( 1 )
			f36_arg0.backing:setScale( 1.2, 1.2 )
			f36_arg0.clipFinished( f36_arg0.backing )
			f36_arg0.Title:completeAnimation()
			f36_arg0.Title:setTopBottom( 0, 0, -132, -106 )
			f36_arg0.Title:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
			f36_arg0.clipFinished( f36_arg0.Title )
		end
	}
}

CoD.EnhCalloutItem.__onClose = function ( f37_arg0 )
	f37_arg0.backingSolid:close()
	f37_arg0.backing:close()
	f37_arg0.Title:close()
end

CoD.EnhCalloutItems = InheritFrom( LUI.UIElement )
CoD.EnhCalloutItems.__defaultWidth = 1920
CoD.EnhCalloutItems.__defaultHeight = 1080
CoD.EnhCalloutItems.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setUseCylinderMapping( false )
	self:setClass( CoD.EnhCalloutItems )
	self.id = "EnhCalloutItems"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local BGDarkening = LUI.UIImage.new( 0, 1, 0, 0, 0, 1, 0, 0 )
	BGDarkening:setRGB( 0, 0, 0 )
	BGDarkening:setAlpha( 0.65 )
	self:addElement( BGDarkening )
	self.BGDarkening = BGDarkening
	
	local CenterCircle = LUI.UIImage.new( 0.5, 0.5, -78, 78, 0.5, 0.5, -78, 78 )
	CenterCircle:setImage( RegisterImage( @"cranked_image_draw" ) )
	CenterCircle:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_F755127C95CF5B6" ) )
      CenterCircle:setRGB(0, 0, 0)
	CenterCircle:setShaderVector( 0, 1.5, 0, 0, 0 )
	self:addElement( CenterCircle )
	self.CenterCircle = CenterCircle
	
	local CalloutItems = LUI.WheelLayout.new( f1_arg0, f1_arg1, nil )
	CalloutItems:setLeftRight( 0.5, 0.5, -177, 177 )
	CalloutItems:setTopBottom( 0.5, 0.5, -177, 177 )
	CalloutItems:setWidgetType( CoD.EnhCalloutItem )
	CalloutItems:setCount( Callouts_Idx )
	CalloutItems:setDataSource( "EnhCalloutWheel" )
	self:addElement( CalloutItems )
	self.CalloutItems = CalloutItems
	
	local EnhWheelPrompt = CoD.EnhWheelPrompt.new( f1_arg0, f1_arg1, 0.5, 0.5, -9.5, 9.5, 0.5, 0.5, -5.5, 5.5 )
	EnhWheelPrompt:subscribeToGlobalModel( f1_arg1, "Controller", "move_right_stick_button_image", function ( model )
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			EnhWheelPrompt.RStick:setImage( RegisterImage( f2_local0 ) )
		end
	end )
	self:addElement( EnhWheelPrompt )
	self.EnhWheelPrompt = EnhWheelPrompt
	
	self:mergeStateConditions( {
		{
			stateName = "Visible",
			condition = function ( menu, element, event )
				local button = CoD.HUDUtility.EnhIsCalloutsButtonPressed( f1_arg1 )
				return button
			end
		}
	} )
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local8( f1_local7, f1_local9["ButtonBits.actionSlots.Flourish_Callouts"], function ( f8_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "ButtonBits.actionSlots.Flourish_Callouts"
		} )
	end, false )
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local8( f1_local7, f1_local9["hudItems.PCWheels.calloutWheelKeyPressed"], function ( f9_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "hudItems.PCWheels.calloutWheelKeyPressed"
		} )
	end, false )

	self.subscribeToModel( self, Engine[@"getmodelforcontroller"]( f1_arg1 )["ButtonBits." .. Enum[@"luibutton"][@"lui_key_lb"]], function ( f9_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "ButtonBits." .. Enum[@"luibutton"][@"lui_key_lb"]
		} )
	end, false )

	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local8( f1_local7, f1_local9["hudItems.PCWheels.sprayGestureWheelKeyPressed"], function ( f10_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "hudItems.PCWheels.sprayGestureWheelKeyPressed"
		} )
	end, false )
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local8( f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function ( f11_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]
		} )
	end, false )
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local8( f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function ( f12_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]
		} )
	end, false )
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local8( f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]], function ( f13_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]
		} )
	end, false )
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local8( f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function ( f14_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]
		} )
	end, false )
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local8( f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function ( f15_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]
		} )
	end, false )
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getglobalmodel"]()
	f1_local8( f1_local7, f1_local9["lobbyRoot.lobbyNav"], function ( f16_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "lobbyRoot.lobbyNav"
		} )
	end, false )
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforclient"]( Engine[@"getclientnum"]( f1_arg1 ) )
	f1_local8( f1_local7, f1_local9.isInLastStand, function ( f17_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "isInLastStand"
		} )
	end, false )
	LUI.OverrideFunction_CallOriginalFirst( self, "setState", function ( element, controller, f18_arg2, f18_arg3, f18_arg4 )
		if IsSelfInState( self, "Visible" ) then
			CoD.HUDUtility.MenuDelayedSetRightStickLock( f1_arg0, controller, 0, true )
                  Engine[@"setdvar"]("ui_drawcrosshair", 0)
		else
			CoD.HUDUtility.MenuDelayedSetRightStickLock( f1_arg0, controller, 125, false )
			CoD.HUDUtility.DisableWheelSelection( controller, self, self.CalloutItems )
                  Engine[@"setdvar"]("ui_drawcrosshair", 1)
		end
	end )
	self:subscribeToGlobalModel( f1_arg1, "RightStick", "Length", function ( model )
		local f19_local0 = self
		if IsSelfInState( self, "Visible" ) then
			CoD.HUDUtility.UpdateSelectionModelFromLength( f1_arg1, self, self.CalloutItems, model, false )
		end
	end )

      --[[ no need for pointer tbh
	self:subscribeToGlobalModel( f1_arg1, "RightStick", "Degrees", function ( model )
		local f20_local0 = self
		if IsSelfInState( self, "Visible" ) then
			CoD.HUDUtility.EnhUpdateSelectionModelFromDegrees( f1_arg1, self, self.CalloutItems, false )
		end
	end )
      ]]

	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	f1_local8 = self
	CoD.HUDUtility.EnhAddCalloutWheelCallback( f1_arg1, self.CalloutItems )
	CoD.HUDUtility.EnhInitWheelPCForMouseDrag( self, f1_arg1, f1_arg0, self.CalloutItems )
	return self
end

CoD.EnhCalloutItems.__resetProperties = function ( f21_arg0 )
	f21_arg0.CalloutItems:completeAnimation()
	f21_arg0.CenterCircle:completeAnimation()
	f21_arg0.BGDarkening:completeAnimation()
	f21_arg0.EnhWheelPrompt:completeAnimation()
	f21_arg0.CalloutItems:setAlpha( 1 )
	f21_arg0.CenterCircle:setAlpha( 1 )
	f21_arg0.BGDarkening:setAlpha( 0.65 )
	f21_arg0.EnhWheelPrompt:setAlpha( 1 )
end

CoD.EnhCalloutItems.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f22_arg0, f22_arg1 )
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter( 6 )
			f22_arg0.BGDarkening:completeAnimation()
			f22_arg0.BGDarkening:setAlpha( 0 )
			f22_arg0.clipFinished( f22_arg0.BGDarkening )
			f22_arg0.CenterCircle:completeAnimation()
			f22_arg0.CenterCircle:setAlpha( 0 )
			f22_arg0.clipFinished( f22_arg0.CenterCircle )
			f22_arg0.CalloutItems:completeAnimation()
			f22_arg0.CalloutItems:setAlpha( 0 )
			f22_arg0.clipFinished( f22_arg0.CalloutItems )
			f22_arg0.EnhWheelPrompt:completeAnimation()
			f22_arg0.EnhWheelPrompt:setAlpha( 0 )
			f22_arg0.clipFinished( f22_arg0.EnhWheelPrompt )
		end,
		Visible = function ( f23_arg0, f23_arg1 )
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter( 6 )
			local f23_local0 = function ( f24_arg0 )
				f23_arg0.BGDarkening:beginAnimation( 60 )
				f23_arg0.BGDarkening:setAlpha( 0.65 )
				f23_arg0.BGDarkening:registerEventHandler( "interrupted_keyframe", f23_arg0.clipInterrupted )
				f23_arg0.BGDarkening:registerEventHandler( "transition_complete_keyframe", f23_arg0.clipFinished )
			end
			
			f23_arg0.BGDarkening:completeAnimation()
			f23_arg0.BGDarkening:setAlpha( 0 )
			f23_local0( f23_arg0.BGDarkening )
			local f23_local1 = function ( f25_arg0 )
				f23_arg0.CenterCircle:beginAnimation( 60 )
				f23_arg0.CenterCircle:setAlpha( 1 )
				f23_arg0.CenterCircle:registerEventHandler( "interrupted_keyframe", f23_arg0.clipInterrupted )
				f23_arg0.CenterCircle:registerEventHandler( "transition_complete_keyframe", f23_arg0.clipFinished )
			end
			
			f23_arg0.CenterCircle:completeAnimation()
			f23_arg0.CenterCircle:setAlpha( 0 )
			f23_local1( f23_arg0.CenterCircle )
			local f23_local2 = function ( f26_arg0 )
				f23_arg0.CalloutItems:beginAnimation( 60 )
				f23_arg0.CalloutItems:setAlpha( 1 )
				f23_arg0.CalloutItems:registerEventHandler( "interrupted_keyframe", f23_arg0.clipInterrupted )
				f23_arg0.CalloutItems:registerEventHandler( "transition_complete_keyframe", f23_arg0.clipFinished )
			end
			
			f23_arg0.CalloutItems:completeAnimation()
			f23_arg0.CalloutItems:setAlpha( 0 )
			f23_local2( f23_arg0.CalloutItems )
			local f23_local3 = function ( f27_arg0 )
				f23_arg0.EnhWheelPrompt:beginAnimation( 60 )
				f23_arg0.EnhWheelPrompt:setAlpha( 1 )
				f23_arg0.EnhWheelPrompt:registerEventHandler( "interrupted_keyframe", f23_arg0.clipInterrupted )
				f23_arg0.EnhWheelPrompt:registerEventHandler( "transition_complete_keyframe", f23_arg0.clipFinished )
			end
			
			f23_arg0.EnhWheelPrompt:completeAnimation()
			f23_arg0.EnhWheelPrompt:setAlpha( 0 )
			f23_local3( f23_arg0.EnhWheelPrompt )
		end
	},
	Visible = {
		DefaultClip = function ( f29_arg0, f29_arg1 )
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter( 0 )
		end,
		DefaultState = function ( f30_arg0, f30_arg1 )
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter( 5 )
			local f30_local0 = function ( f31_arg0 )
				local f31_local0 = function ( f32_arg0 )
					f32_arg0:beginAnimation( 380 )
					f32_arg0:setAlpha( 0 )
					f32_arg0:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
				end
				
				f30_arg0.BGDarkening:beginAnimation( 120 )
				f30_arg0.BGDarkening:setAlpha( 0.4 )
				f30_arg0.BGDarkening:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
				f30_arg0.BGDarkening:registerEventHandler( "transition_complete_keyframe", f31_local0 )
			end
			
			f30_arg0.BGDarkening:completeAnimation()
			f30_arg0.BGDarkening:setAlpha( 0.65 )
			f30_local0( f30_arg0.BGDarkening )
			local f30_local1 = function ( f33_arg0 )
				local f33_local0 = function ( f34_arg0 )
					f34_arg0:beginAnimation( 380 )
					f34_arg0:setAlpha( 0 )
					f34_arg0:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
				end
				
				f30_arg0.CenterCircle:beginAnimation( 120 )
				f30_arg0.CenterCircle:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
				f30_arg0.CenterCircle:registerEventHandler( "transition_complete_keyframe", f33_local0 )
			end
			
			f30_arg0.CenterCircle:completeAnimation()
			f30_arg0.CenterCircle:setAlpha( 1 )
			f30_local1( f30_arg0.CenterCircle )
			local f30_local2 = function ( f35_arg0 )
				f30_arg0.CalloutItems:beginAnimation( 500, Enum[@"luitween"][@"luitween_ease_out"] )
				f30_arg0.CalloutItems:setAlpha( 0 )
				f30_arg0.CalloutItems:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
				f30_arg0.CalloutItems:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
			end
			
			f30_arg0.CalloutItems:completeAnimation()
			f30_arg0.CalloutItems:setAlpha( 1 )
			f30_local2( f30_arg0.CalloutItems )
			local f30_local3 = function ( f36_arg0 )
				f30_arg0.EnhWheelPrompt:beginAnimation( 120 )
				f30_arg0.EnhWheelPrompt:setAlpha( 0 )
				f30_arg0.EnhWheelPrompt:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
				f30_arg0.EnhWheelPrompt:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
			end
			
			f30_arg0.EnhWheelPrompt:completeAnimation()
			f30_arg0.EnhWheelPrompt:setAlpha( 1 )
			f30_local3( f30_arg0.EnhWheelPrompt )
		end
	}
}

CoD.EnhCalloutItems.__onClose = function ( f38_arg0 )
	f38_arg0.CalloutItems:close()
	f38_arg0.EnhWheelPrompt:close()
end