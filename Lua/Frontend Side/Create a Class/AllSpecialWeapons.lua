--[[
      .\hksc.exe '.\Lua\Frontend Side\AllSpecialWeapons.lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\AllSpecialWeapons.luac'
]]

------------------------

if not CoD.isFrontend then
	return
end

CoD.InitEnhLuaFile()

------------------------

-- all special weapons
DataSources.ZMSpecialWeapons = ListHelper_SetupDataSource( "ZMSpecialWeapons", function ( f41_arg0, f41_arg1 )
	local f41_local0 = {}
	local f41_local1 = "herogadget"
	local f41_local2 = CoD.BaseUtility.GetMenuSessionMode( f41_arg1.menu )
	local f41_local3 = CoD.CACUtility.GetItemIndexEquippedInSlot( f41_local1, f41_arg0, CoD.BaseUtility.GetMenuModel( f41_arg1.menu ) )
	local f41_local4 -- uhmm??
	for f41_local7, f41_local8 in ipairs( CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f41_local2, f41_local1 ) ) do
		if f41_local8.allocation ~= -1 then
			table.insert( f41_local0, {
				models = {
					name = f41_local8.name,
					globalItemIndex = f41_local8.globalItemIndex,
					itemIndex = f41_local8.itemIndex,
					displayName = f41_local8.displayName,
					image = CoD.CACUtility.GetPreviewImage( f41_local2, f41_local8 ),
					description = f41_local8.description,
					equipped = f41_local8.itemIndex == f41_local3,
					stageDetailDatasource = CoD.ZMLoadoutUtility.GetStageDetailsDataSource( "stageDetailDatasource_weapon" .. f41_local7, f41_local8.unlockableItemStages ),
					disablePersonalization = true,
					isRestricted = CoD.CACUtility.AreSpecialWeaponsRestricted( false )
				},
				properties = {
					equipSound = f41_local8[@"equipsound"],
					unequipSound = f41_local8[@"hash_B608E98BF6A8991"]
				}
			} )
		end
	end
	if f41_arg1._zmStorySubscription == nil then
		f41_local4 = Engine[@"getmodelforcontroller"]( f41_arg0 )
		f41_arg1._zmStorySubscription = f41_arg1:subscribeToModel( f41_local4.selectedZMStory, function ()
			f41_arg1:updateDataSource()
		end, false )
	end
	return f41_local0
end, true )

------------------------

-- special weapons here
CoD.ZMSpecialWeaponSelect = InheritFrom( CoD.Menu )
LUI.createMenu.ZMSpecialWeaponSelect = function ( f1_arg0, f1_arg1 )
	local self = CoD.Menu.NewForUIEditor( "ZMSpecialWeaponSelect", f1_arg0 )
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData( self, f1_arg1 )
	self:setClass( CoD.ZMSpecialWeaponSelect )
	self.soundSet = "ZCAC"
	self:setOwner( f1_arg0 )
	self:setLeftRight( 0, 1, 0, 0 )
	self:setTopBottom( 0, 1, 0, 0 )
	self:playSound( "menu_open", f1_arg0 )
	self.anyChildUsesUpdateState = true
	
	local BackgroundSlidePanel = CoD.cac_background_slide_panel.new( f1_local1, f1_arg0, 0, 1, 0, 0, 0.5, 0.5, 132, 754 )
	BackgroundSlidePanel:setZoom( 70 )
	self:addElement( BackgroundSlidePanel )
	self.BackgroundSlidePanel = BackgroundSlidePanel
	
	local RestrictedText = CoD.RestrictedItemWarningText.new( f1_local1, f1_arg0, 0.5, 0.5, -247, 247, 0.5, 0.5, 76, 106 )
	self:addElement( RestrictedText )
	self.RestrictedText = RestrictedText
	
	local itemList = LUI.UIList.new( f1_local1, f1_arg0, 9, 0, nil, false, false, false, false )
	itemList:setLeftRight( 0.5, 0.5, -597.5, 597.5 )
	itemList:setTopBottom( 0.5, 0.5, 264, 410 )
	itemList:setWidgetType( CoD.ZMItemGridButton )
	itemList:setHorizontalCount( 4 )
	itemList:setVerticalCount(2) -- fix
	itemList:setSpacing( 9 )
	itemList:setScale(0.6, 0.6)
	itemList:setAlignment( Enum[@"hash_67A5123B654282D2"][@"hash_1FEEB12BCB0D7041"] )
	itemList:setDataSource( "ZMSpecialWeapons" )
	itemList:linkToElementModel( itemList, "globalItemIndex", true, function ( model, f2_arg1 )
		CoD.Menu.UpdateButtonShownState( f2_arg1, f1_local1, f1_arg0, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"] )
	end )
	itemList:linkToElementModel( itemList, "refHash", true, function ( model, f3_arg1 )
		CoD.Menu.UpdateButtonShownState( f3_arg1, f1_local1, f1_arg0, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"] )
	end )
	itemList:registerEventHandler( "list_item_gain_focus", function ( element, event )
		local f4_local0 = nil
		CoD.CACUtility.UpdateWeaponModel( f1_local1, element, f1_arg0 )
		CoD.ZMLoadoutUtility.UpdateZMSpecialWeaponActiveStageModel( element, f1_arg0 )
		return f4_local0
	end )
	itemList:registerEventHandler( "lose_list_focus", function ( element, event )
		local f5_local0 = nil
		CoD.CACUtility.SetActiveListItemToEquippedItem( f1_local1, f1_arg0, element )
		CoD.CACUtility.UpdateWeaponModel( f1_local1, element, f1_arg0 )
		CoD.ZMLoadoutUtility.UpdateZMSpecialWeaponActiveStageModel( element, f1_arg0 )
		return f5_local0
	end )
	itemList:registerEventHandler( "gain_focus", function ( element, event )
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus( event )
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus( event )
		end
		CoD.Menu.UpdateButtonShownState( element, f1_local1, f1_arg0, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"] )
		return f6_local0
	end )
	f1_local1:AddButtonCallbackFunction( itemList, f1_arg0, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function ( element, menu, controller, model )
		if not CoD.CACUtility.IsCACItemLocked( menu, element, controller ) and not CoD.CACUtility.IsCACBlackMarketItemLocked( menu, element, controller ) then
			CoD.CACUtility.EquipWeapon( self, element, menu, controller, false )
			UpdateSelfElementState( menu, self, controller )
			return true
		else
			
		end
	end, function ( element, menu, controller )
		if not CoD.CACUtility.IsCACItemLocked( menu, element, controller ) and not CoD.CACUtility.IsCACBlackMarketItemLocked( menu, element, controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], @"hash_6D0BB36CD318F55F", nil, "ui_confirm" )
			return true
		else
			return false
		end
	end, false )
	self.__on_menuOpened_itemList = function ( f9_arg0, f9_arg1, f9_arg2, f9_arg3 )
		CoD.CACUtility.SetActiveListItemToEquippedItem( f9_arg2, f9_arg1, itemList )
	end
	
	f1_local1:addMenuOpenedCallback( self.__on_menuOpened_itemList )
	self:addElement( itemList )
	self.itemList = itemList
	
	local ItemInfo = CoD.ItemNameDescUnlockText.new( f1_local1, f1_arg0, 0.5, 0.5, -755, -255, 0.5, 0.5, -65, 42 )
	ItemInfo:mergeStateConditions( {
		{
			stateName = "Zombie",
			condition = function ( menu, element, event )
				return AlwaysTrue()
			end
		}
	} )
	self:addElement( ItemInfo )
	self.ItemInfo = ItemInfo
	
	local TopBar = LUI.UIImage.new( -0.07, 1.13, 0, 0, 0.5, 0.5, 171, 174 )
	TopBar:setRGB( 0.32, 0.55, 0.67 )
	TopBar:setImage( RegisterImage( @"hash_242BCCF45B82FBED" ) )
	self:addElement( TopBar )
	self.TopBar = TopBar
	
	local TopBar2 = LUI.UIImage.new( -0.07, 1.13, 0, 0, 0.5, 0.5, 247, 250 )
	TopBar2:setRGB( 0.36, 0.61, 0.74 )
	TopBar2:setZoom( 2 )
	TopBar2:setImage( RegisterImage( @"hash_242BCCF45B82FBED" ) )
	TopBar2:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_54E6CE42E0799F57" ) )
	self:addElement( TopBar2 )
	self.TopBar2 = TopBar2
	
	local hint = LUI.UIText.new( 0.5, 0.5, -960, 960, 0.5, 0.5, 145, 163 )
	hint:setRGB( 0.58, 0.58, 0.58 )
	hint:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"hash_4AF3B94B4D16A655" ) )
	hint:setTTF( "ttmussels_regular" )
	hint:setLetterSpacing( 2 )
	hint:setAlignment( Enum[@"hash_67A5123B654282D2"][@"hash_1FEEB12BCB0D7041"] )
	hint:setAlignment( Enum[@"hash_67A5123B654282D2"][@"hash_3F41D595A2B0EDF3"] )
	self:addElement( hint )
	self.hint = hint
	
	local StageList = LUI.UIList.new( f1_local1, f1_arg0, 144, 0, nil, false, false, false, false )
	StageList:setLeftRight( 0.5, 0.5, -594, 594 )
	StageList:setTopBottom( 0.5, 0.5, 189, 289 )
	StageList:setWidgetType( CoD.ZMSpecialWeapon_StageInfo )
	StageList:setHorizontalCount( 3 )
	StageList:setSpacing( 144 )
	StageList:setAlignment( Enum[@"hash_67A5123B654282D2"][@"hash_558C8A85F2048829"] )
	StageList:registerEventHandler( "list_item_gain_focus", function ( element, event )
		local f11_local0 = nil
		CoD.ZMLoadoutUtility.UpdateZMSpecialWeaponStageModel( f1_local1, element, f1_arg0 )
		CoD.ZMLoadoutUtility.SetZMSpecialWeaponStageModel( element, f1_arg0 )
		return f11_local0
	end )
	self:addElement( StageList )
	self.StageList = StageList
	
	local ZMSpecialWeaponStageDescription = CoD.ZMSpecialWeapon_StageDescription.new( f1_local1, f1_arg0, 0.5, 0.5, 155, 755, 0.5, 0.5, -65, 42 )
	ZMSpecialWeaponStageDescription:subscribeToGlobalModel( f1_arg0, "ZMSpecialWeaponStage", nil, function ( model )
		ZMSpecialWeaponStageDescription:setModel( model, f1_arg0 )
	end )
	self:addElement( ZMSpecialWeaponStageDescription )
	self.ZMSpecialWeaponStageDescription = ZMSpecialWeaponStageDescription
	
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new( f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0 )
	FooterContainerFrontendRight:registerEventHandler( "menu_loaded", function ( element, event )
		local f13_local0 = nil
		if element.menuLoaded then
			f13_local0 = element:menuLoaded( event )
		elseif element.super.menuLoaded then
			f13_local0 = element.super:menuLoaded( event )
		end
		if not IsPC() then
			SizeToSafeArea( element, f1_arg0 )
		end
		if not f13_local0 then
			f13_local0 = element:dispatchEventToChildren( event )
		end
		return f13_local0
	end )
	self:addElement( FooterContainerFrontendRight )
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	
	local CACHeader = CoD.CommonHeader.new( f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67 )
	CACHeader.subtitle.StageTitle:setText( LocalizeToUpperString( CoD.CACUtility.GetHeaderNameForLoadoutSlot( self, @"hash_15C60F77B9332E5B" ) ) )
	CACHeader.subtitle.subtitle:setAlpha( 0 )
	CACHeader:subscribeToGlobalModel( f1_arg0, "LobbyRoot", "lobbyTitle", function ( model )
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			CACHeader.subtitle.subtitle:setText( Engine[@"hash_4F9F1239CFD921FE"]( f14_local0 ) )
		end
	end )
	CACHeader:linkToElementModel( self, nil, false, function ( model )
		CACHeader:setModel( model, f1_arg0 )
	end )
	CACHeader:registerEventHandler( "menu_loaded", function ( element, event )
		local f16_local0 = nil
		if element.menuLoaded then
			f16_local0 = element:menuLoaded( event )
		elseif element.super.menuLoaded then
			f16_local0 = element.super:menuLoaded( event )
		end
		SizeToSafeArea( element, f1_arg0 )
		if not f16_local0 then
			f16_local0 = element:dispatchEventToChildren( event )
		end
		return f16_local0
	end )
	self:addElement( CACHeader )
	self.CACHeader = CACHeader
	
	local BackingGrayMediumLeft = CoD.header_container_frontend.new( f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 42 )
	BackingGrayMediumLeft:registerEventHandler( "menu_loaded", function ( element, event )
		local f17_local0 = nil
		if element.menuLoaded then
			f17_local0 = element:menuLoaded( event )
		elseif element.super.menuLoaded then
			f17_local0 = element.super:menuLoaded( event )
		end
		SizeToSafeArea( element, f1_arg0 )
		if not f17_local0 then
			f17_local0 = element:dispatchEventToChildren( event )
		end
		return f17_local0
	end )
	self:addElement( BackingGrayMediumLeft )
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	
	local arrow = LUI.UIImage.new( 0.5, 0.5, -318, -154, 0.5, 0.5, 174, 250 )
	arrow:setImage( RegisterImage( @"hash_5FCA9CA5BDA28506" ) )
	self:addElement( arrow )
	self.arrow = arrow
	
	local arrow2 = LUI.UIImage.new( 0.5, 0.5, 126, 290, 0.5, 0.5, 174, 250 )
	arrow2:setImage( RegisterImage( @"hash_5FCA9CA5BDA28506" ) )
	self:addElement( arrow2 )
	self.arrow2 = arrow2
	
	local XCamMouseControl = nil
	
	XCamMouseControl = CoD.XCamMouseControl.new( f1_local1, f1_arg0, 0, 1, 0, 0, 0.5, 0.5, -473, 132 )
	self:addElement( XCamMouseControl )
	self.XCamMouseControl = XCamMouseControl
	
	RestrictedText:linkToElementModel( itemList, nil, false, function ( model )
		RestrictedText:setModel( model, f1_arg0 )
	end )
	ItemInfo:linkToElementModel( itemList, nil, false, function ( model )
		ItemInfo:setModel( model, f1_arg0 )
	end )
	StageList:linkToElementModel( itemList, "stageDetailDatasource", true, function ( model )
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			StageList:setDataSource( f20_local0 )
		end
	end )
	self:registerEventHandler( "menu_loaded", function ( self, event )
		local f21_local0 = nil
		if self.menuLoaded then
			f21_local0 = self:menuLoaded( event )
		elseif self.super.menuLoaded then
			f21_local0 = self.super:menuLoaded( event )
		end
		SendClientScriptMenuChangeNotify( f1_arg0, f1_local1, true )
		if not f21_local0 then
			f21_local0 = self:dispatchEventToChildren( event )
		end
		return f21_local0
	end )
	f1_local1:AddButtonCallbackFunction( self, f1_arg0, Enum[@"hash_3DD78803F918E9D"][@"hash_1805EFA15E9E7E5A"], nil, function ( element, menu, controller, model )
		GoBack( self, controller )
		return true
	end, function ( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum[@"hash_3DD78803F918E9D"][@"hash_1805EFA15E9E7E5A"], @"hash_370A9FDC87CD3D48", nil, nil )
		return true
	end, false )
	LUI.OverrideFunction_CallOriginalFirst( self, "close", function ( element )
		SendClientScriptMenuChangeNotify( f1_arg0, f1_local1, false )
		CoD.CACUtility.ClearClassWeaponModel( f1_local1, f1_arg0 )
	end )
	itemList.id = "itemList"
	StageList.id = "StageList"
	FooterContainerFrontendRight:setModel( self.buttonModel, f1_arg0 )
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	self:processEvent( {
		name = "menu_loaded",
		controller = f1_arg0
	} )
	self.__defaultFocus = itemList
	if CoD.isPC and (IsKeyboard( f1_arg0 ) or self.ignoreCursor) then
		self:restoreState( f1_arg0 )
	end
	self.__on_close_removeOverrides = function ()
		f1_local1:removeMenuOpenedCallback( self.__on_menuOpened_itemList )
	end
	
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg0 )
	end
	
	local f1_local17 = self
	CoD.CACUtility.UpdateWeaponModel( f1_local1, self, f1_arg0 )
	CoD.BaseUtility.SetModelFromPropertyModel( f1_arg0, self, self )

	return self
end

CoD.ZMSpecialWeaponSelect.__onClose = function ( f26_arg0 )
	f26_arg0.__on_close_removeOverrides()
	f26_arg0.RestrictedText:close()
	f26_arg0.ItemInfo:close()
	f26_arg0.StageList:close()
	f26_arg0.BackgroundSlidePanel:close()
	f26_arg0.itemList:close()
	f26_arg0.ZMSpecialWeaponStageDescription:close()
	f26_arg0.FooterContainerFrontendRight:close()
	f26_arg0.CACHeader:close()
	f26_arg0.BackingGrayMediumLeft:close()
	f26_arg0.XCamMouseControl:close()
end