--[[
      .\hksc.exe '.\Lua\Frontend Side\SettingsSubMenu.lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\SettingsSubMenu.luac'
]]

------------------------

if not CoD.isFrontend then
	return
end

CoD.InitEnhLuaFile()

------------------------

CoD.SettingsSearchNoRes_Global = nil

------------------------

-- list of settings to avoid issues
CoD.SettingsModListData = InheritFrom( LUI.UIElement )
CoD.SettingsModListData.__defaultWidth = 1600
CoD.SettingsModListData.__defaultHeight = 620
CoD.SettingsModListData.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.SettingsModListData )
	self.id = "SettingsModListData"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true

	local SettingsList = LUI.UIList.new( f1_arg0, f1_arg1, 15, 0, nil, false, false, false, false )
	SettingsList:setLeftRight( 0.5, 0.5, -275, 275 )
	SettingsList:setTopBottom( 0, 0, 400, 1000 )
	SettingsList:setAutoScaleContent( true )
	SettingsList:setVerticalCount(11)
	SettingsList:setHorizontalCount(1)
	SettingsList:setSpacing( 5 )
	SettingsList:setWidgetType( CoD.CustomGames_SettingSliderNoCustom_Enh )
	SettingsList:setVerticalCounter( CoD.verticalCounter )
	--ActiveModsList:setDataSource( "ShieldActiveModsList" )
	SettingsList:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )

	if Engine[@"getdvarint"]("shield_ui_color") == 0 then
		SettingsList:setRGB(0, 1, 1)
	elseif Engine[@"getdvarint"]("shield_ui_color") == 1 then
		SettingsList:setRGB(1, 0, 0)
	elseif Engine[@"getdvarint"]("shield_ui_color") == 2 then
		SettingsList:setRGB(0, 1, 0)
	end

	SettingsList:setDataSource("")
	SettingsList:updateDataSource()
	SettingsList:setDataSource( Dvar[@"shield_enh_datasource_get"]:get() )
	SettingsList:updateDataSource()

	self:addElement( SettingsList )
	self.SettingsList = SettingsList

	SettingsList.id = "SettingsList"

	-- desc
	local SettingDescription = LUI.UIText.new( 0.5, 0.5, -300, 250, 0.5, 0.5, 365, 390 )

	SettingDescription:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
	SettingDescription:setTTF("notosans_bold")
	SettingDescription:setBackingType( 2 )
	SettingDescription:setBackingColor( 0.04, 0.81, 1 )
	SettingDescription:setBackingAlpha( 0.01 )
	SettingDescription:setBackingXPadding( 12 )
	SettingDescription:setBackingYPadding( 6 )
	SettingDescription:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	SettingDescription:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
	self:addElement( SettingDescription )
	self.SettingDescription = SettingDescription

	-- link it, subtitles like
	SettingDescription:linkToElementModel( SettingsList, "desc", true, function ( model )
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			SettingDescription:setText( Engine[@"hash_4F9F1239CFD921FE"]( f7_local0 ) )

			--if Dvar[@"shield_enh_datasource_get"]:get() == "SearchSettingsData" then
				self.SettingsList:updateDataSource()
			--end
		end
	end )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end

	return self
end

CoD.SettingsModListData.__onClose = function ( f9_arg0 )
	f9_arg0.SettingDescription:close()
	f9_arg0.SettingsList:close()
end

CoD.Shield_EnhID_SettingsPopup = InheritFrom( CoD.Menu )
LUI.createMenu.Shield_EnhID_SettingsPopup = function ( f1_arg0, f1_arg1 )
	local self = CoD.Menu.NewForUIEditor( "Shield_EnhID_SettingsPopup", f1_arg0 )
	local f1_local1 = self
	self:setClass( CoD.Shield_EnhID_SettingsPopup )
	self.soundSet = "none"
	self:setOwner( f1_arg0 )
	self:setLeftRight( 0, 1, 0, 0 )
	self:setTopBottom( 0, 1, 0, 0 )
	self:playSound( "menu_open", f1_arg0 )
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList( self )
	
	local CommomCenteredPopup = CoD.CommonCenteredPopup.new( f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0 )
	CommomCenteredPopup.TitleText:setText(Dvar[@"shield_enh_datasource"]:get())
	CommomCenteredPopup.HeaderBackground:setAlpha( 0 )
	CommomCenteredPopup.HeaderTopBar:setAlpha( 0 )
	CommomCenteredPopup.HeaderBottomBar:setAlpha( 0 )
	self:addElement( CommomCenteredPopup )
	self.CommomCenteredPopup = CommomCenteredPopup

	local SearchBox = CoD.Shield_SearchBox.new( f1_local1, f1_arg1, 0.50, 0.50, -270, 270, 0.50, 0.50, -405, -355 )
	SearchBox:linkToElementModel( self, nil, false, function ( model )
		SearchBox:setModel( model, f1_arg1 )
	end )
	SearchBox.TextBox:setLeftRight(0, 0, 20 + 55, 320 + 55)
	SearchBox.RankHighlight:setText("^3Search: ")
	SearchBox.RankHighlight:setRGB(1, 1, 1)
	self:addElement( SearchBox )
	self.SearchBox = SearchBox

	-- prevent element pool being fucked
	local SearchBoxModel = Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f1_arg1 ), "SearchBox" )

	if SearchBoxModel == nil then
		SearchBoxModel = Engine[@"createmodel"]( Engine[@"getmodelforcontroller"]( f1_arg1 ), "SearchBox" )
	end

	--Engine[@"setdvar"]( "shield_search_settings", "" )
	SearchBoxModel:set(Engine[@"getdvarstring"]("shield_search_settings"))

	CoD.PCUtility.SetupEditControlWithModel( SearchBox, f1_arg1, f1_local1, SearchBoxModel, function ( f331_arg0, f331_arg1, f331_arg2 )
		if not f331_arg2.canceled and f331_arg2.name == "textbox_editdone" then
			local NameData = f331_arg0:get()

			CoD.EnhModPrintInfo("Search", NameData)
			PlaySoundAlias( "uin_paint_image_flip_toggle" )
			
			Engine[@"setdvar"]("shield_search_settings", NameData)
			self.SettingsList.SettingsList:setDataSource("")
			self.SettingsList.SettingsList:updateDataSource()
			self.SettingsList.SettingsList:setDataSource("SearchSettingsData")
			self.SettingsList.SettingsList:updateDataSource()
		else
			f331_arg0:set("") -- reset it
		end
	end )

	self.SearchBox.id = "SearchBox"
	self.SearchBoxModel = SearchBoxModel

	if Dvar[@"shield_enh_datasource_get"]:get() == "SearchSettingsData" then
		self.SearchBox:setAlpha(1)
	else
		self.SearchBox:setAlpha(0)
	end
	
	-- datasources for unlocks here
	local SettingsList = CoD.SettingsModListData.new( self, f1_arg0, 0.5, 0.5, -275, 275, 0.5, 0.5, -800, 800 )
	self:addElement( SettingsList )
	self.SettingsList = SettingsList

	if Dvar[@"shield_enh_datasource_get"]:get() == "SearchSettingsData" then
		SettingsList:setTopBottom( 0.5, 0.5, -700, 800 )
		SettingsList.SettingsList:setVerticalCount(7)

		SettingsList.SettingDescription:setTopBottom( 0.5, 0.5, 335 - 25, 360 - 25 )
	end

	self.__defaultFocus = SettingsList.SettingsList

	local SettingsSearchNoRes = LUI.UIText.new( 0.50, 0.50, -152.75, 576.25, 0.50, 0.50, -35.00, 7.00 )
	SettingsSearchNoRes:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
	SettingsSearchNoRes:setTTF("notosans_bold")
	SettingsSearchNoRes:setBackingType( 2 )
	SettingsSearchNoRes:setText("No Results Found")
	SettingsSearchNoRes:setBackingColor( 0.04, 0.81, 1 )
	SettingsSearchNoRes:setBackingAlpha( 0.01 )
	SettingsSearchNoRes:setBackingXPadding( 12 )
	SettingsSearchNoRes:setBackingYPadding( 6 )
	SettingsSearchNoRes:setAlpha(0)
	SettingsSearchNoRes:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	SettingsSearchNoRes:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
	self:addElement( SettingsSearchNoRes )
	self.SettingsSearchNoRes = SettingsSearchNoRes

	CoD.SettingsSearchNoRes_Global = SettingsSearchNoRes

	SettingsList.id = "SettingsList"

	local SettingsListRelatedDesc = LUI.UIText.new( 0.50, 0.50, -264.00, 285.00, 0.50, 0.50, -39.00, -14.00 )
	SettingsListRelatedDesc:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
	SettingsListRelatedDesc:setTTF("notosans_bold")
	SettingsListRelatedDesc:setBackingType( 2 )
	SettingsListRelatedDesc:setText("Related Settings")
	SettingsListRelatedDesc:setBackingColor( 0.04, 0.81, 1 )
	SettingsListRelatedDesc:setBackingAlpha( 0.01 )
	SettingsListRelatedDesc:setBackingXPadding( 12 )
	SettingsListRelatedDesc:setBackingYPadding( 6 )
	SettingsListRelatedDesc:setAlpha(0)
	SettingsListRelatedDesc:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	SettingsListRelatedDesc:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
	self:addElement( SettingsListRelatedDesc )
	self.SettingsListRelatedDesc = SettingsListRelatedDesc

	local SettingsListRelated = CoD.SettingsModListData.new( self, f1_arg0, 0.5, 0.5, -275, 275, 0.5, 0.5, -400, 400 )
	self:addElement( SettingsListRelated )
	self.SettingsListRelated = SettingsListRelated

	SettingsListRelated.id = "SettingsListRelated"

	self.SettingsListRelated.SettingsList:setDataSource("")
	self.SettingsListRelated.SettingDescription:setAlpha(0)
	self.SettingsListRelated:setAlpha(0)

	if Dvar[@"shield_enh_datasource_get"]:get() == "ShieldClassicSettings" then
		self.SettingsListRelatedDesc:setAlpha(1)
		self.SettingsListRelatedDesc:setText("Related Classic Mode Settings")
		self.SettingsListRelated:setAlpha(1)
		self.SettingsListRelated.SettingsList:setDataSource("ShieldClassicSettingsRelated")
	end

	self:appendEventHandler( "input_source_changed", function ( f9_arg0, f9_arg1 )
		f9_arg1.menu = f9_arg1.menu or f1_local1
		f1_local1:updateElementState( self, f9_arg1 )
	end )
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"]( f1_arg0 )
	f1_local7( f1_local6, f1_local8.LastInput, function ( f10_arg0 )
		f1_local1:updateElementState( self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "LastInput"
		} )
	end, false )
	f1_local1:AddButtonCallbackFunction( self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function ( element, menu, controller, model )
		GoBack( self, controller )
		ClearMenuSavedState( menu )
		ForceNotifyGlobalModel( controller, "GametypeSettings.Update" )
		return true
	end, function ( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil )
		return true
	end, false )
	CommomCenteredPopup.buttons:setModel( self.buttonModel, f1_arg0 )
	if CoD.isPC then
		CommomCenteredPopup.id = "CommomCenteredPopup"
	end
	self:processEvent( {
		name = "menu_loaded",
		controller = f1_arg0
	} )

	if CoD.isPC and (IsKeyboard( f1_arg0 ) or self.ignoreCursor) then
		self:restoreState( f1_arg0 )
	end
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg0 )
	end
	
	f1_local7 = self
	--MenuHidesFreeCursor( f1_local1, f1_arg0 )

	CoD.EnhModPrintInfo("Called", "Shield's Enh Settings Menu -> " .. Dvar[@"shield_enh_datasource_get"]:get())

	return self
end

CoD.Shield_EnhID_SettingsPopup.__resetProperties = function ( f13_arg0 )

end

CoD.Shield_EnhID_SettingsPopup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f14_arg0, f14_arg1 )
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter( 0 )
		end
	},
}

CoD.Shield_EnhID_SettingsPopup.__onClose = function ( f16_arg0 )
	f16_arg0.CommomCenteredPopup:close()
	f16_arg0.SettingsList:close()
	f16_arg0.SearchBox:close()
	f16_arg0.SettingsListRelated:close()
	f16_arg0.SettingsListRelatedDesc:close()
	f16_arg0.SettingsSearchNoRes:close()
end