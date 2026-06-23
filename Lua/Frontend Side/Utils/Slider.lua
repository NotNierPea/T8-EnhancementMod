--[[
      .\hksc.exe '.\Lua\Frontend Side\Slider.lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\Slider.luac'
]]

------------------------

if not CoD.isFrontend then
	return
end

CoD.InitEnhLuaFile()

------------------------

local function Enh_GetEditModeActions( f53_arg0, f53_arg1 )
	local max_clients_com_shield = Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f53_arg0 ), "max_clients_com_shield" )

	if max_clients_com_shield == nil then
		max_clients_com_shield = Engine[@"createmodel"]( Engine[@"getmodelforcontroller"]( f53_arg0 ), "max_clients_com_shield" )
	end
	
	max_clients_com_shield:set(Engine[@"getdvarint"]("shield_com_clients"))

	CoD.EnhModPrintInfo("get")
	local f53_local0 = {}

	local f53_local4 = {}
	local f53_local5 = {
		actionName = @"shield/client_num",
		widgetType = "slider",
		perControllerValueModel = "max_clients_com_shield",
		lowValue = 0,
		highValue = 127
	}
	local f53_local6 = Engine[@"getmodelforcontroller"]( f53_arg0 )
	f53_local5.currentValue = 0
	f53_local4.models = f53_local5
	f53_local4.properties = {
		updateAction = function ( f60_arg0, f60_arg1, f60_arg2, f60_arg3 )
			local GetNum = math.floor((f53_local5.highValue - f53_local5.lowValue) * f60_arg2)

			Engine[@"setdvar"]("shield_com_clients", GetNum)

			Engine[@"setlobbymaxclients"](Enum[@"lobbytype"][@"lobby_type_game"], GetNum) 
			Engine[@"setlobbymaxclients"](Enum[@"lobbytype"][@"lobby_type_private"], GetNum)
			Engine[@"setlobbymaxclients"](Engine[@"getprimarycontroller"](), GetNum)
			Dvar[@"hash_4FF45B41C6046F8"]:set(GetNum)
			Engine[@"setmodelvalue"](Engine[@"createmodel"]( Engine[@"createmodel"]( Engine[@"getglobalmodel"](), "PartyPrivacy" ), "maxPlayers" ), GetNum)
		end
	}

	table.insert( f53_local0, f53_local4 )

	CoD.EnhModPrintInfo("out")

	return f53_local0
end

local function Enh_WidgetSelectorFunc( f49_arg0, f49_arg1, f49_arg2 )
	return CoD.CraftActionSliderEnh
end

------------------------

DataSources.EnhActionsPC = DataSourceHelpers.ListSetup( "PC.CraftActionsPC", function ( f50_arg0, f50_arg1 )
	return Enh_GetEditModeActions( f50_arg0, f50_arg1.menu )
end, false, {
	getWidgetTypeForItem = Enh_WidgetSelectorFunc
} )

------------------------

CoD.CraftActionSliderEnh = InheritFrom( LUI.UIElement )
CoD.CraftActionSliderEnh.__defaultWidth = 375
CoD.CraftActionSliderEnh.__defaultHeight = 60
CoD.CraftActionSliderEnh.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.CraftActionSliderEnh )
	self.id = "CraftActionSliderEnh"
	self.soundSet = "SelectColor"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )

	local FrameBorder = LUI.UIImage.new( 0, 1, -1, 1, 0, 1, -1, 1 )
	FrameBorder:setAlpha( 0.75 )
	FrameBorder:setImage( RegisterImage( @"uie_ui_menu_store_common_frame" ) )
	FrameBorder:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_nineslice_add" ) )
	FrameBorder:setShaderVector( 0, 0, 0, 0, 0 )
	FrameBorder:setupNineSliceShader( 12, 12 )
	self:addElement( FrameBorder )
	self.FrameBorder = FrameBorder
	
	local Background = LUI.UIImage.new( 0, 1, 0, 0, 0, 1, 0, 0 )
	Background:setAlpha( 0.95 )
	Background:setImage( RegisterImage( @"uie_ui_menu_specialist_hub_repeat_bg" ) )
	Background:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_16CBE95C250C6D15" ) )
	Background:setShaderVector( 0, 0, 0, 0, 0 )
	Background:setupNineSliceShader( 196, 88 )
	self:addElement( Background )
	self.Background = Background
	
	local BackingFocus = LUI.UIImage.new( 0, 1, 0, 0, 0, 1, 0, 0 )
	BackingFocus:setRGB( 0.84, 0.82, 0.74 )
	BackingFocus:setAlpha( 0 )
	self:addElement( BackingFocus )
	self.BackingFocus = BackingFocus
	
	local EditBox = CoD.SliderBar_EditBox.new( f1_arg0, f1_arg1, 0, 0, 315, 375, 0, 0, 0, 60 )
	EditBox.PCHighlightBorder:setAlpha( 0.3 )
	self:addElement( EditBox )
	self.EditBox = EditBox
	
	local CraftActionSliderWidget = CoD.CraftActionSliderWidget.new( f1_arg0, f1_arg1, 0, 0, 0, 315, 0, 0, 0, 60 )
	CraftActionSliderWidget:linkToElementModel( self, nil, false, function ( model )
		CraftActionSliderWidget:setModel( model, f1_arg1 )
	end )
	self:addElement( CraftActionSliderWidget )
	self.CraftActionSliderWidget = CraftActionSliderWidget

	CraftActionSliderWidget.actionName:setTopBottom(0, 0, 5, 25)
	
	local emptyFocusable = CoD.emptyFocusable.new( f1_arg0, f1_arg1, 0.5, 0.5, -187.5, 187.5, 0.5, 0.5, -30, 30 )
	self:addElement( emptyFocusable )
	self.emptyFocusable = emptyFocusable
	
	self:mergeStateConditions( {
		{
			stateName = "Disabled",
			condition = function ( menu, element, event )
				return IsDisabled( element, f1_arg1 )
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
	EditBox.id = "EditBox"
	CraftActionSliderWidget.id = "CraftActionSliderWidget"
	emptyFocusable.id = "emptyFocusable"
	self.__defaultFocus = emptyFocusable
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	if PreLoadFunc then
		PreLoadFunc( self, f1_arg1, f1_arg0 )
	end
	local f1_local6 = self
	if IsPC() then
		CoD.PCUtility.CraftActionSliderBindDrag( self, self.CraftActionSliderWidget, f1_arg1, f1_arg0 )
		CoD.PCUtility.SetCraftActionStatusModel( self, self.CraftActionSliderWidget, f1_arg1, f1_arg0 )
		CoD.PCUtility.SetSliderValueModel( self, self.CraftActionSliderWidget, f1_arg1, f1_arg0 )
		CoD.PCUtility.CraftLockFocusOnDrag( self.CraftActionSliderWidget, f1_arg1, f1_arg0 )
		CoD.PCUtility.CraftActionSliderSetInputBox( self, self.EditBox, f1_arg1, f1_arg0 )
		CoD.PCUtility.SetElementEditBoxMaxChar( self.EditBox, 4 )
	end
	return self
end

CoD.CraftActionSliderEnh.__resetProperties = function ( f5_arg0 )
	f5_arg0.EditBox:completeAnimation()
	f5_arg0.BackingFocus:completeAnimation()
	f5_arg0.EditBox:setTopBottom( 0, 0, 0, 60 )
	f5_arg0.BackingFocus:setAlpha( 0 )
end

CoD.CraftActionSliderEnh.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f6_arg0, f6_arg1 )
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter( 1 )
			f6_arg0.EditBox:completeAnimation()
			f6_arg0.EditBox:setTopBottom( 0, 0, 0, 60 )
			f6_arg0.clipFinished( f6_arg0.EditBox )
		end,
		ChildFocus = function ( f7_arg0, f7_arg1 )
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter( 2 )
			f7_arg0.BackingFocus:completeAnimation()
			f7_arg0.BackingFocus:setAlpha( 0.03 )
			f7_arg0.clipFinished( f7_arg0.BackingFocus )
			f7_arg0.EditBox:completeAnimation()
			f7_arg0.EditBox:setTopBottom( 0, 0, 0, 60 )
			f7_arg0.clipFinished( f7_arg0.EditBox )
		end,
		GainChildFocus = function ( f8_arg0, f8_arg1 )
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter( 2 )
			local f8_local0 = function ( f9_arg0 )
				f8_arg0.BackingFocus:beginAnimation( 200 )
				f8_arg0.BackingFocus:setAlpha( 0.03 )
				f8_arg0.BackingFocus:registerEventHandler( "interrupted_keyframe", f8_arg0.clipInterrupted )
				f8_arg0.BackingFocus:registerEventHandler( "transition_complete_keyframe", f8_arg0.clipFinished )
			end
			
			f8_arg0.BackingFocus:completeAnimation()
			f8_arg0.BackingFocus:setAlpha( 0 )
			f8_local0( f8_arg0.BackingFocus )
			f8_arg0.EditBox:completeAnimation()
			f8_arg0.EditBox:setTopBottom( 0, 0, 0, 60 )
			f8_arg0.clipFinished( f8_arg0.EditBox )
		end,
		LoseChildFocus = function ( f10_arg0, f10_arg1 )
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter( 2 )
			local f10_local0 = function ( f11_arg0 )
				f10_arg0.BackingFocus:beginAnimation( 200 )
				f10_arg0.BackingFocus:setAlpha( 0 )
				f10_arg0.BackingFocus:registerEventHandler( "interrupted_keyframe", f10_arg0.clipInterrupted )
				f10_arg0.BackingFocus:registerEventHandler( "transition_complete_keyframe", f10_arg0.clipFinished )
			end
			
			f10_arg0.BackingFocus:completeAnimation()
			f10_arg0.BackingFocus:setAlpha( 0.03 )
			f10_local0( f10_arg0.BackingFocus )
			f10_arg0.EditBox:completeAnimation()
			f10_arg0.EditBox:setTopBottom( 0, 0, 0, 60 )
			f10_arg0.clipFinished( f10_arg0.EditBox )
		end
	},
	Disabled = {
		DefaultClip = function ( f12_arg0, f12_arg1 )
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter( 0 )
		end
	}
}

CoD.CraftActionSliderEnh.__onClose = function ( f13_arg0 )
	f13_arg0.EditBox:close()
	f13_arg0.CraftActionSliderWidget:close()
	f13_arg0.emptyFocusable:close()
	f13_arg0.FrameBorder:close()
end

CoD.CraftActionHeaderEnh = InheritFrom( LUI.UIElement )
CoD.CraftActionHeaderEnh.__defaultWidth = 375
CoD.CraftActionHeaderEnh.__defaultHeight = 800
CoD.CraftActionHeaderEnh.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.CraftActionHeaderEnh )
	self.id = "v"
	self.soundSet = "SelectColor"
	
	local Backing = LUI.UIImage.new( 0, 1, 0, 0, 0, 1, -35, 0 )
	Backing:setImage( RegisterImage( @"uie_ui_menu_specialist_hub_repeat_bg" ) )
	Backing:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_16CBE95C250C6D15" ) )
	Backing:setShaderVector( 0, 0, 0, 0, 0 )
	Backing:setupNineSliceShader( 196, 88 )
	self:addElement( Backing )
	self.Backing = Backing
	
	local Frame = LUI.UIImage.new( 0, 1, -1, 1, 0, 1, -36, 1 )
	Frame:setAlpha( 0.2 )
	Frame:setImage( RegisterImage( @"uie_ui_menu_store_common_frame" ) )
	Frame:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_nineslice_add" ) )
	Frame:setShaderVector( 0, 0, 0, 0, 0 )
	Frame:setupNineSliceShader( 16, 16 )
	self:addElement( Frame )
	self.Frame = Frame
	
	local text = LUI.UIText.new( 0, 1, 0, 100, 0, 1, -24, -8 )
	text:setRGB( ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b )
	text:setTTF( "ttmussels_demibold" )
	text:setLetterSpacing( 6 )
	text:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	text:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
	self:addElement( text )
	self.text = text
	
	self.text:linkToElementModel( self, "actionName", true, function ( model )
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			text:setText( LocalizeToUpperString( f2_local0 ) )
		end
	end )
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.CraftActionHeaderEnh.__onClose = function ( f3_arg0 )
	f3_arg0.text:close()
end

-- other slider
CoD.CustomGames_SettingSliderNoCustom_Enh = InheritFrom( LUI.UIElement )
CoD.CustomGames_SettingSliderNoCustom_Enh.__defaultWidth = 1000
CoD.CustomGames_SettingSliderNoCustom_Enh.__defaultHeight = 60
CoD.CustomGames_SettingSliderNoCustom_Enh.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.CustomGames_SettingSliderNoCustom_Enh )
	self.id = "CustomGames_SettingSliderNoCustom_Enh"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local StartMenuOptionsSettingSlider = CoD.CustomGames_SettingSliderNoCustom_Internal.new( f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 60 )
	StartMenuOptionsSettingSlider:linkToElementModel( self, nil, false, function ( model )
		StartMenuOptionsSettingSlider:setModel( model, f1_arg1 )
	end )
	self:addElement( StartMenuOptionsSettingSlider )
	self.StartMenuOptionsSettingSlider = StartMenuOptionsSettingSlider
	
	StartMenuOptionsSettingSlider.id = "StartMenuOptionsSettingSlider"
	self.__defaultFocus = StartMenuOptionsSettingSlider
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.CustomGames_SettingSliderNoCustom_Enh.__resetProperties = function ( f3_arg0 )
	f3_arg0.StartMenuOptionsSettingSlider:completeAnimation()
	f3_arg0.StartMenuOptionsSettingSlider:setScale( 1, 1 )
end

CoD.CustomGames_SettingSliderNoCustom_Enh.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f4_arg0, f4_arg1 )
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter( 0 )
		end,
		ChildFocus = function ( f5_arg0, f5_arg1 )
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter( 1 )
			f5_arg0.StartMenuOptionsSettingSlider:completeAnimation()
			f5_arg0.StartMenuOptionsSettingSlider:setScale( 1.05, 1.05 )
			f5_arg0.clipFinished( f5_arg0.StartMenuOptionsSettingSlider )
		end,
		GainChildFocus = function ( f6_arg0, f6_arg1 )
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter( 1 )
			local f6_local0 = function ( f7_arg0 )
				f6_arg0.StartMenuOptionsSettingSlider:beginAnimation( 200 )
				f6_arg0.StartMenuOptionsSettingSlider:setScale( 1.05, 1.05 )
				f6_arg0.StartMenuOptionsSettingSlider:registerEventHandler( "interrupted_keyframe", f6_arg0.clipInterrupted )
				f6_arg0.StartMenuOptionsSettingSlider:registerEventHandler( "transition_complete_keyframe", f6_arg0.clipFinished )
			end
			
			f6_arg0.StartMenuOptionsSettingSlider:completeAnimation()
			f6_arg0.StartMenuOptionsSettingSlider:setScale( 1, 1 )
			f6_local0( f6_arg0.StartMenuOptionsSettingSlider )
		end,
		LoseChildFocus = function ( f8_arg0, f8_arg1 )
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter( 1 )
			local f8_local0 = function ( f9_arg0 )
				f8_arg0.StartMenuOptionsSettingSlider:beginAnimation( 200 )
				f8_arg0.StartMenuOptionsSettingSlider:setScale( 1, 1 )
				f8_arg0.StartMenuOptionsSettingSlider:registerEventHandler( "interrupted_keyframe", f8_arg0.clipInterrupted )
				f8_arg0.StartMenuOptionsSettingSlider:registerEventHandler( "transition_complete_keyframe", f8_arg0.clipFinished )
			end
			
			f8_arg0.StartMenuOptionsSettingSlider:completeAnimation()
			f8_arg0.StartMenuOptionsSettingSlider:setScale( 1.05, 1.05 )
			f8_local0( f8_arg0.StartMenuOptionsSettingSlider )
		end
	}
}

CoD.CustomGames_SettingSliderNoCustom_Enh.__onClose = function ( f10_arg0 )
	f10_arg0.StartMenuOptionsSettingSlider:close()
end