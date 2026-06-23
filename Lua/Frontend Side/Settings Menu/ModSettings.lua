--[[
      .\hksc.exe '.\Lua\Frontend Side\ModSettings.lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\ModSettings.luac'
]]

------------------------

if not CoD.isFrontend then
	return
end

CoD.InitEnhLuaFile()

------------------------

-- used for sub menu's
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'set shield_enh_datasource none')
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'set shield_enh_datasource_get none')

------------------------

-- Mods Options Tab
DataSources.ModsOptionsTabs = DataSourceHelpers.ListSetup( "ModsOptionsTabs", function ( f3_arg0, f3_arg1 )
	local tabs = {
		{
			models = {
				name = @"shield/enh_tab",
				filter = "enh_mods"
			}
		}
	}
      
	return tabs
end, true )

------------------------

-- Main Options Menu
CoD.ShieldEnhOptionsMenu = InheritFrom( CoD.Menu )
LUI.createMenu.ShieldEnhOptionsMenu = function ( f1_arg0, f1_arg1 )
	local self = CoD.Menu.NewForUIEditor( "ShieldEnhOptionsMenu", f1_arg0 )
	local f1_local1 = self
	self:setClass( CoD.ShieldEnhOptionsMenu )
	self.soundSet = "default"
	self:setOwner( f1_arg0 )
	self:setLeftRight( 0, 1, 0, 0 )
	self:setTopBottom( 0, 1, 0, 0 )
	self:playSound( "menu_open", f1_arg0 )
	self.anyChildUsesUpdateState = true
	
	local Background = CoD.StartMenuOptionsBackground.new( f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0 )
	self:addElement( Background )
	self.Background = Background
	
	local FooterContainerFrontendRight = nil
	
	FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new( f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 1, 1, -48, 0 )
	self:addElement( FooterContainerFrontendRight )
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	
	-- removed, breaks glowing on pc
	--[[
	local FooterContainerFrontendRight2 = CoD.Fo..., -48, 0 )
	]]
	
	--[[
	local CornerPipR = LUI.UIImage.new( 0, 0, 1749.5, 1765.5, 0, 0, 930, 946 )
	CornerPipR:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
	CornerPipR:setAlpha( 0.25 )
	CornerPipR:setImage( RegisterImage( @"hash_28DC834094E7A02C" ) )
	self:addElement( CornerPipR )
	self.CornerPipR = CornerPipR
	
	local CornerPipL = LUI.UIImage.new( 0, 0, 155, 171, 0, 0, 930, 946 )
	CornerPipL:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
	CornerPipL:setAlpha( 0.25 )
	CornerPipL:setYRot( 180 )
	CornerPipL:setImage( RegisterImage( @"hash_28DC834094E7A02C" ) )
	self:addElement( CornerPipL )
	self.CornerPipL = CornerPipL
	]]
	
	--local TabbedScoreboardFuiBox = CoD.TabbedScoreboardFuiBox.new( f1_local1, f1_arg0, 0, 0, 1645.5, 1757.5, 0, 0, 954, 970 )
	--self:addElement( TabbedScoreboardFuiBox )
	--self.TabbedScoreboardFuiBox = TabbedScoreboardFuiBox

	local ShieldEnhModMenu_SafeAreaFront = CoD.ShieldEnhModMenu_SafeAreaFront.new( f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080 )
	ShieldEnhModMenu_SafeAreaFront:registerEventHandler( "menu_loaded", function ( element, event )
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded( event )
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded( event )
		end
		if not IsPC() then
			SizeToSafeArea( element, f1_arg0 )
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren( event )
		end
		return f3_local0
	end )
	self:addElement( ShieldEnhModMenu_SafeAreaFront )
	self.ShieldEnhModMenu_SafeAreaFront = ShieldEnhModMenu_SafeAreaFront

	-- tip
	local TipSettingDescription = LUI.UIText.new( 0.20, 0.20, -300, 250, 0.70, 0.70, 150, 180 )
	--TipSettingDescription:setText("Tip: You can scroll down for more options with the mouse scroll or with arrows")
	TipSettingDescription:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
	TipSettingDescription:setTTF("notosans_bold")
	TipSettingDescription:setBackingType( 2 )
	TipSettingDescription:setBackingColor( 0.04, 0.81, 1 )
	TipSettingDescription:setBackingAlpha( 0.01 )
	TipSettingDescription:setBackingXPadding( 12 )
	TipSettingDescription:setBackingYPadding( 6 )
	TipSettingDescription:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	TipSettingDescription:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
	self:addElement( TipSettingDescription )
	self.TipSettingDescription = TipSettingDescription

	ShieldEnhModMenu_SafeAreaFront.id = "ShieldEnhModMenu_SafeAreaFront"

	-- remove for now
	--SaveDescription:setAlpha(0)
	--LoadSaveFileButton:setAlpha(0)
	--sizeLoadSaveFileButton:setAlpha(0)

	f1_local1:AddButtonCallbackFunction( self, f1_arg0, Enum[@"hash_3DD78803F918E9D"][@"hash_1805EFA15E9E7E5A"], nil, function ( element, menu, controller, model )
		GoBack( self, controller )
		return true
	end, function ( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum[@"hash_3DD78803F918E9D"][@"hash_1805EFA15E9E7E5A"], @"hash_6A4032FB2AAB69F2", nil, nil )
		return true
	end, false )

	FooterContainerFrontendRight:setModel( self.buttonModel, f1_arg0 )
	FooterContainerFrontendRight.id = "FooterContainerFrontendRight"

	self:processEvent( {
		name = "menu_loaded",
		controller = f1_arg0
	} )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg0 )
	end
	
	--MenuHidesFreeCursor( f1_local1, f1_arg0 )
	CoD.EnhModPrintInfo("Called", "Shield's Enh Mod Options")

	SizeToSafeArea(ShieldEnhModMenu_SafeAreaFront, f1_arg0)
	self.__defaultFocus = ShieldEnhModMenu_SafeAreaFront.UI_Settings

	return self
end

CoD.ShieldEnhOptionsMenu.__onClose = function ( f8_arg0 )
	f8_arg0.Background:close()
	f8_arg0.FooterContainerFrontendRight:close()
	f8_arg0.ShieldEnhModMenu_SafeAreaFront:close()
	f8_arg0.TipSettingDescription:close()
end

CoD.ShieldEnhModMenu_SafeAreaFront = InheritFrom( LUI.UIElement )
CoD.ShieldEnhModMenu_SafeAreaFront.__defaultWidth = 1920
CoD.ShieldEnhModMenu_SafeAreaFront.__defaultHeight = 1080
CoD.ShieldEnhModMenu_SafeAreaFront.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.ShieldEnhModMenu_SafeAreaFront )
	self.id = "ShieldEnhModMenu_SafeAreaFront"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true

	local TabBacking = CoD.CommonTabBarBacking.new( f1_arg0, f1_arg1, -0.1, 1.1, 0, 0, 0, 0, 52, 89 )
	TabBacking.TabBackingBlur:setAlpha( 0 )
	self:addElement( TabBacking )
	self.TabBacking = TabBacking
	
	local CommonHeader = CoD.CommonHeader.new( f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 67 )
	CommonHeader.subtitle.StageTitle:setText("^2Enhancements Mod Settings")
	CommonHeader.subtitle.subtitle:setText("^3Modify Mods Settings")
	self:addElement( CommonHeader )
	self.CommonHeader = CommonHeader

	local HeaderPixelGridTiledBackingR = LUI.UIImage.new( 0, 0, 0, 4000, 0.5, 0.5, -160.5 + 300, -120.5 + 300 )
	HeaderPixelGridTiledBackingR:setAlpha( 0.15 )
	HeaderPixelGridTiledBackingR:setImage( RegisterImage( @"hash_1311E811A3183347" ) )
	HeaderPixelGridTiledBackingR:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_16CBE95C250C6D15" ) )
	HeaderPixelGridTiledBackingR:setShaderVector( 0, 0, 0, 0, 0 )
	HeaderPixelGridTiledBackingR:setupNineSliceShader( 128, 128 )
	self:addElement( HeaderPixelGridTiledBackingR )
	self.HeaderPixelGridTiledBackingR = HeaderPixelGridTiledBackingR
	
	local HeaderPixelGridTiledBackingL = LUI.UIImage.new( 0, 0, 0, 4000, 0.5, 0.5, -400.5, -360.5 )
	HeaderPixelGridTiledBackingL:setAlpha( 0.25 )
	HeaderPixelGridTiledBackingL:setImage( RegisterImage( @"hash_1311E811A3183347" ) )
	HeaderPixelGridTiledBackingL:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_16CBE95C250C6D15" ) )
	HeaderPixelGridTiledBackingL:setShaderVector( 0, 0, 0, 0, 0 )
	HeaderPixelGridTiledBackingL:setupNineSliceShader( 128, 128 )
	self:addElement( HeaderPixelGridTiledBackingL )
	self.HeaderPixelGridTiledBackingL = HeaderPixelGridTiledBackingL
	
	local ShieldSettingsTabs = CoD.Common_Tabbar_Center.new( f1_arg0, f1_arg1, 0.5, 0.5, -100.5, 100.5, 0, 0, 52.5 - 15, 113.5 - 15 )

	local f1_local4 = ShieldSettingsTabs
	local HeaderStripe = ShieldSettingsTabs.subscribeToModel
	local f1_local6 = Engine[@"hash_78DF2E5447F384B9"]()
	HeaderStripe( f1_local4, f1_local6["lobbyRoot.lobbyNav"], function ( f3_arg0 )
		f1_arg0:updateElementState( ShieldSettingsTabs, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav"
		} )
	end, false )

	ShieldSettingsTabs.Tabs.grid:setDataSource( "ModsOptionsTabs" )
	ShieldSettingsTabs:registerEventHandler( "grid_item_changed", function ( element, event )
		local f2_local0 = nil
		UpdateAllMenuButtonPrompts( f1_arg0, f1_arg1 )
		CloseContextualMenu( f1_arg0, f1_arg1 )
		return f2_local0
	end )
	self:addElement( ShieldSettingsTabs )
	self.ShieldSettingsTabs = ShieldSettingsTabs

	-- slider for bots
	local actionsListPCEnh = LUI.UIList.new( f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false )
	actionsListPCEnh:setLeftRight( 0.5, 0.5, -842.5 + 80, -467.5 )
	actionsListPCEnh:setTopBottom( 0.5, 0.5, 153, 300 )
	actionsListPCEnh:setAlpha( 1 )
	actionsListPCEnh:setWidgetType( CoD.CraftActionHeaderEnh )
	actionsListPCEnh:setVerticalCount( 15 )
	actionsListPCEnh:setSpacing( 0 )
	actionsListPCEnh:setDataSource( "EnhActionsPC" )
	self:addElement( actionsListPCEnh )
	self.actionsListPCEnh = actionsListPCEnh

	actionsListPCEnh.id = "actionsListPCEnh"

	local AchivButton = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.5, 0.5, 0 - 760 + 400, 300 - 760 + 400, 0.5, 0.5, 200, 250)
	
	AchivButton.MiddleText:setTTF( "notosans_bold" )
	AchivButton.MiddleText:setText("Achievements")

	AchivButton.MiddleTextFocus:setText("Achievements")
	AchivButton.MiddleTextFocus:setTTF( "notosans_bold" )

	AchivButton:linkToElementModel( self, nil, false, function ( model )
		AchivButton:setModel( model, f1_arg1 )
	end )
	self:addElement( AchivButton )
	self.AchivButton = AchivButton

	f1_arg0:AddButtonCallbackFunction( AchivButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
		PlaySoundAlias( "uin_paint_image_flip_toggle" )
		CoD.EnhModPrintInfo("AchivButton")
		
		OpenOverlay( self, "Shield_Enh_AchievementsMenu", controller )

	end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
		if IsGamepad( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/join", nil, "ui_confirm" )
			return true
		elseif IsMouseOrKeyboard( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm" )
			return false
		else
			return false
		end
	end, false )

	AchivButton.id = "AchivButton"

	local UI_Settings = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.5, 0.5, 0 - 760, 300 - 760, 0.5, 0.5, 0 - 340, 50 - 340)
	
	UI_Settings.MiddleText:setTTF( "notosans_bold" )
	UI_Settings.MiddleText:setText("UI Settings")

	UI_Settings.MiddleTextFocus:setText("UI Settings")
	UI_Settings.MiddleTextFocus:setTTF( "notosans_bold" )
	
	UI_Settings:linkToElementModel( self, nil, false, function ( model )
		UI_Settings:setModel( model, f1_arg1 )
	end )
	self:addElement( UI_Settings )
	self.UI_Settings = UI_Settings

	f1_arg0:AddButtonCallbackFunction( UI_Settings, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
		PlaySoundAlias( "uin_paint_image_flip_toggle" )
		CoD.EnhModPrintInfo("UI_Settings")

		-- title
		Dvar[@"shield_enh_datasource"]:set("UI Settings")

		-- datasource
		Dvar[@"shield_enh_datasource_get"]:set("UISettingsData")

		-- then open menu
		OpenOverlay( self, "Shield_EnhID_SettingsPopup", controller )

	end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
		if IsGamepad( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/join", nil, "ui_confirm" )
			return true
		elseif IsMouseOrKeyboard( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm" )
			return false
		else
			return false
		end
	end, false )

	UI_Settings.id = "UI_Settings"

	local UI_Settings_Config = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.5, 0.5, 0 - 760, 300 - 760, 0.5, 0.5, 0 - 140, 50 - 140 )
	
	UI_Settings_Config.MiddleText:setTTF( "notosans_bold" )
	UI_Settings_Config.MiddleText:setText("UI Config Settings")

	UI_Settings_Config.MiddleTextFocus:setText("UI Config Settings")
	UI_Settings_Config.MiddleTextFocus:setTTF( "notosans_bold" )
	
	UI_Settings_Config:linkToElementModel( self, nil, false, function ( model )
		UI_Settings_Config:setModel( model, f1_arg1 )
	end )
	self:addElement( UI_Settings_Config )
	self.UI_Settings_Config = UI_Settings_Config

	f1_arg0:AddButtonCallbackFunction( UI_Settings_Config, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
		PlaySoundAlias( "uin_paint_image_flip_toggle" )
		CoD.EnhModPrintInfo("UI_Settings_Config")
		
		-- title
		Dvar[@"shield_enh_datasource"]:set("UI Config Settings")

		-- datasource
		Dvar[@"shield_enh_datasource_get"]:set("UISettingsConfigData")

		-- then open menu
		OpenOverlay( self, "Shield_EnhID_SettingsPopup", controller )

	end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
		if IsGamepad( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/join", nil, "ui_confirm" )
			return true
		elseif IsMouseOrKeyboard( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm" )
			return false
		else
			return false
		end
	end, false )

	UI_Settings_Config.id = "UI_Settings_Config"

	local Game_Settings = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.5, 0.5, 0 - 760 + 400, 300 - 760 + 400, 0.5, 0.5, 0 - 340, 50 - 340)
	
	Game_Settings.MiddleText:setTTF( "notosans_bold" )
	Game_Settings.MiddleText:setText("Gamemode Settings")

	Game_Settings.MiddleTextFocus:setText("Gamemode Settings")
	Game_Settings.MiddleTextFocus:setTTF( "notosans_bold" )
	
	Game_Settings:linkToElementModel( self, nil, false, function ( model )
		Game_Settings:setModel( model, f1_arg1 )
	end )
	self:addElement( Game_Settings )
	self.Game_Settings = Game_Settings

	f1_arg0:AddButtonCallbackFunction( Game_Settings, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
		PlaySoundAlias( "uin_paint_image_flip_toggle" )
		CoD.EnhModPrintInfo("Game_Settings")
		
		-- title
		Dvar[@"shield_enh_datasource"]:set("Gamemode Settings")

		-- datasource
		Dvar[@"shield_enh_datasource_get"]:set("GamemodeSettingsData")

		-- then open menu
		OpenOverlay( self, "Shield_EnhID_SettingsPopup", controller )

	end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
		if IsGamepad( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/join", nil, "ui_confirm" )
			return true
		elseif IsMouseOrKeyboard( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm" )
			return false
		else
			return false
		end
	end, false )

	Game_Settings.id = "Game_Settings"

	local Online_Settings = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.5, 0.5, 0 - 760 + 800, 300 - 760 + 800, 0.5, 0.5, 0 - 340, 50 - 340)
	
	Online_Settings.MiddleText:setTTF( "notosans_bold" )
	Online_Settings.MiddleText:setText("Online Settings")

	Online_Settings.MiddleTextFocus:setText("Online Settings")
	Online_Settings.MiddleTextFocus:setTTF( "notosans_bold" )
	
	Online_Settings:linkToElementModel( self, nil, false, function ( model )
		Online_Settings:setModel( model, f1_arg1 )
	end )
	self:addElement( Online_Settings )
	self.Online_Settings = Online_Settings

	f1_arg0:AddButtonCallbackFunction( Online_Settings, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
		PlaySoundAlias( "uin_paint_image_flip_toggle" )
		CoD.EnhModPrintInfo("Online_Settings")
		
		-- title
		Dvar[@"shield_enh_datasource"]:set("Online Settings")

		-- datasource
		Dvar[@"shield_enh_datasource_get"]:set("OnlineSettingsData")

		-- then open menu
		OpenOverlay( self, "Shield_EnhID_SettingsPopup", controller )

	end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
		if IsGamepad( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/join", nil, "ui_confirm" )
			return true
		elseif IsMouseOrKeyboard( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm" )
			return false
		else
			return false
		end
	end, false )

	Online_Settings.id = "Online_Settings"
	
	HeaderStripe = CoD.header_container_frontend.new( f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 42 )
	self:addElement( HeaderStripe )
	self.HeaderStripe = HeaderStripe

	-- classic button
	local ClassicModeButton = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.5, 0.5, 0 - 760 + 1200, 300 - 760 + 1200, 0.5, 0.5, 0 - 340, 50 - 340)
	
	ClassicModeButton:setRGB(1, 0, 0)

	ClassicModeButton.MiddleText:setTTF( "notosans_bold" )
	ClassicModeButton.MiddleText:setText("Classic Mode")

	ClassicModeButton.MiddleTextFocus:setText("Classic Mode")
	ClassicModeButton.MiddleTextFocus:setTTF( "notosans_bold" )

	ClassicModeButton:mergeStateConditions( {
		{
			stateName = "Locked",
			condition = function ( menu, element, event )
				return false
			end
		}
	} )

	ClassicModeButton:linkToElementModel( self, nil, false, function ( model )
		ClassicModeButton:setModel( model, f1_arg1 )
	end )
	self:addElement( ClassicModeButton )
	self.ClassicModeButton = ClassicModeButton

	f1_arg0:AddButtonCallbackFunction( ClassicModeButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
		PlaySoundAlias( "uin_paint_image_flip_toggle" )
		CoD.EnhModPrintInfo("Classic Mode PopUp")
		
		-- open settings for it
		--OpenOverlay( self, "Shield_ClassicMode_SettingsPopup", controller )
		-- title
		Dvar[@"shield_enh_datasource"]:set("Classic Mode Settings")

		-- datasource
		Dvar[@"shield_enh_datasource_get"]:set("ShieldClassicSettings")

		-- then open menu
		OpenOverlay( self, "Shield_EnhID_SettingsPopup", controller )
	end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
		if IsGamepad( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/join", nil, "ui_confirm" )
			return true
		elseif IsMouseOrKeyboard( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm" )
			return false
		else
			return false
		end
	end, false )

	ClassicModeButton.id = "ClassicModeButton"

	local LoadSaveFileButton = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.5, 0.5, 0 - 760 + 400, 300 - 760 + 400, 0.5, 0.5, 0 - 140, 50 - 140 )
	
	LoadSaveFileButton.MiddleText:setTTF( "notosans_bold" )
	LoadSaveFileButton.MiddleText:setText("Saved Game Options")

	LoadSaveFileButton.MiddleTextFocus:setText("Saved Game Options")
	LoadSaveFileButton.MiddleTextFocus:setTTF( "notosans_bold" )

	LoadSaveFileButton:mergeStateConditions( {
		{
			stateName = "Locked",
			condition = function ( menu, element, event )
				return false
			end
		}
	} )

	LoadSaveFileButton:linkToElementModel( self, nil, false, function ( model )
		LoadSaveFileButton:setModel( model, f1_arg1 )
	end )
	self:addElement( LoadSaveFileButton )
	self.LoadSaveFileButton = LoadSaveFileButton

	f1_arg0:AddButtonCallbackFunction( LoadSaveFileButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
		PlaySoundAlias( "uin_paint_image_flip_toggle" )
		CoD.EnhModPrintInfo("Save Save Options")
		
		OpenOverlay( self, "Shield_Enh_SavesPopup", controller )

		-- load save
		--Engine[@"exec"](Engine[@"getprimarycontroller"](), 'set shield_enh_SaveGame_Load 1')

		-- notice
		--CoD.OverlayUtility.CreateOverlay(controller, menu, "EnhSaveLoaded")
	end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
		if IsGamepad( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/join", nil, "ui_confirm" )
			return true
		elseif IsMouseOrKeyboard( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm" )
			return false
		else
			return false
		end
	end, false )

	local DirectedModeButton = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.5, 0.5, 0 - 760 + 400, 300 - 760 + 400, 0.5, 0.5, 0 - 140 + 200, 50 - 140 + 200 )
	
	DirectedModeButton.MiddleText:setTTF( "notosans_bold" )
	DirectedModeButton.MiddleText:setText("Directed Mode")

	DirectedModeButton.MiddleTextFocus:setText("Directed Mode")
	DirectedModeButton.MiddleTextFocus:setTTF( "notosans_bold" )

	DirectedModeButton:setRGB(1, 1, 0)

	DirectedModeButton:mergeStateConditions( {
		{
			stateName = "Locked",
			condition = function ( menu, element, event )
				return false
			end
		}
	} )

	DirectedModeButton:linkToElementModel( self, nil, false, function ( model )
		DirectedModeButton:setModel( model, f1_arg1 )
	end )
	self:addElement( DirectedModeButton )
	self.DirectedModeButton = DirectedModeButton

	f1_arg0:AddButtonCallbackFunction( DirectedModeButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
		PlaySoundAlias( "uin_paint_image_flip_toggle" )
		
		-- title
		Dvar[@"shield_enh_datasource"]:set("Directed Mode Settings")

		-- datasource
		Dvar[@"shield_enh_datasource_get"]:set("DirectedSettingsData")

		-- then open menu
		OpenOverlay( self, "Shield_EnhID_SettingsPopup", controller )
	end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
		if IsGamepad( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/join", nil, "ui_confirm" )
			return true
		elseif IsMouseOrKeyboard( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm" )
			return false
		else
			return false
		end
	end, false )

	DirectedModeButton.id = "DirectedModeButton"

	local Challs_Settings = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.5, 0.5, 0 - 760 + 800, 300 - 760 + 800, 0.5, 0.5, 0 - 140, 50 - 140 )
	
	Challs_Settings.MiddleText:setTTF( "notosans_bold" )
	Challs_Settings.MiddleText:setText("Challenges Settings")

	Challs_Settings.MiddleTextFocus:setText("Challenges Settings")
	Challs_Settings.MiddleTextFocus:setTTF( "notosans_bold" )
	
	Challs_Settings:linkToElementModel( self, nil, false, function ( model )
		Challs_Settings:setModel( model, f1_arg1 )
	end )
	self:addElement( Challs_Settings )
	self.Challs_Settings = Challs_Settings

	f1_arg0:AddButtonCallbackFunction( Challs_Settings, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
		PlaySoundAlias( "uin_paint_image_flip_toggle" )
		CoD.EnhModPrintInfo("Challs_Settings")
		
		-- title
		Dvar[@"shield_enh_datasource"]:set("Challenges Settings")

		-- datasource
		Dvar[@"shield_enh_datasource_get"]:set("ChallengeSettingsData")

		-- then open menu
		OpenOverlay( self, "Shield_EnhID_SettingsPopup", controller )

	end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
		if IsGamepad( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/join", nil, "ui_confirm" )
			return true
		elseif IsMouseOrKeyboard( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm" )
			return false
		else
			return false
		end
	end, false )

	Challs_Settings.id = "Challs_Settings"

	local Round_Settings = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.5, 0.5, 0 - 760 + 1200, 300 - 760 + 1200, 0.5, 0.5, 0 - 140, 50 - 140 )
	
	Round_Settings.MiddleText:setTTF( "notosans_bold" )
	Round_Settings.MiddleText:setText("Music Settings")

	Round_Settings.MiddleTextFocus:setText("Music Settings")
	Round_Settings.MiddleTextFocus:setTTF( "notosans_bold" )
	
	Round_Settings:linkToElementModel( self, nil, false, function ( model )
		Round_Settings:setModel( model, f1_arg1 )
	end )
	self:addElement( Round_Settings )
	self.Round_Settings = Round_Settings

	f1_arg0:AddButtonCallbackFunction( Round_Settings, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
		PlaySoundAlias( "uin_paint_image_flip_toggle" )
		CoD.EnhModPrintInfo("Round_Settings")
		
		-- title
		Dvar[@"shield_enh_datasource"]:set("Music Settings")

		-- datasource
		Dvar[@"shield_enh_datasource_get"]:set("RoundSettingsData")

		-- then open menu
		OpenOverlay( self, "Shield_EnhID_SettingsPopup", controller )

	end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
		if IsGamepad( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/join", nil, "ui_confirm" )
			return true
		elseif IsMouseOrKeyboard( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm" )
			return false
		else
			return false
		end
	end, false )

	Round_Settings.id = "Round_Settings"

	local Announcer_Settings = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.5, 0.5, 0 - 760 + 1200, 300 - 760 + 1200, 0.5, 0.5, 0 - 140 + 200, 50 - 140 + 200 )
	
	Announcer_Settings.MiddleText:setTTF( "notosans_bold" )
	Announcer_Settings.MiddleText:setText("Announcer Settings")

	Announcer_Settings.MiddleTextFocus:setText("Announcer Settings")
	Announcer_Settings.MiddleTextFocus:setTTF( "notosans_bold" )
	
	Announcer_Settings:linkToElementModel( self, nil, false, function ( model )
		Announcer_Settings:setModel( model, f1_arg1 )
	end )
	self:addElement( Announcer_Settings )
	self.Announcer_Settings = Announcer_Settings

	f1_arg0:AddButtonCallbackFunction( Announcer_Settings, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
		PlaySoundAlias( "uin_paint_image_flip_toggle" )
		CoD.EnhModPrintInfo("Announcer_Settings")
		
		-- title
		Dvar[@"shield_enh_datasource"]:set("Announcer Settings")

		-- datasource
		Dvar[@"shield_enh_datasource_get"]:set("AnnouncerSettingsData")

		-- then open menu
		OpenOverlay( self, "Shield_EnhID_SettingsPopup", controller )

	end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
		if IsGamepad( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/join", nil, "ui_confirm" )
			return true
		elseif IsMouseOrKeyboard( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm" )
			return false
		else
			return false
		end
	end, false )

	Announcer_Settings.id = "Announcer_Settings"

	local Search_Settings = CoD.DirectorSelectButtonMiniInternal.new( f1_arg0, f1_arg1, 0.5, 0.5, 0 - 760 + 800, 300 - 760 + 800, 0.5, 0.5, 0 - 140 + 200, 50 - 140 + 200 )
	
	Search_Settings.MiddleText:setTTF( "notosans_bold" )
	Search_Settings.MiddleText:setText("Search Settings")

	Search_Settings.MiddleTextFocus:setText("Search Settings")
	Search_Settings.MiddleTextFocus:setTTF( "notosans_bold" )
	
	Search_Settings:linkToElementModel( self, nil, false, function ( model )
		Search_Settings:setModel( model, f1_arg1 )
	end )
	self:addElement( Search_Settings )
	self.Search_Settings = Search_Settings

	f1_arg0:AddButtonCallbackFunction( Search_Settings, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
		PlaySoundAlias( "uin_paint_image_flip_toggle" )
		CoD.EnhModPrintInfo("Search_Settings")
		
		-- title
		Dvar[@"shield_enh_datasource"]:set("Search Settings")

		-- datasource
		Dvar[@"shield_enh_datasource_get"]:set("SearchSettingsData")

		-- then open menu
		OpenOverlay( self, "Shield_EnhID_SettingsPopup", controller )

	end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
		if IsGamepad( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/join", nil, "ui_confirm" )
			return true
		elseif IsMouseOrKeyboard( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm" )
			return false
		else
			return false
		end
	end, false )

	Search_Settings.id = "Search_Settings"
	
	LoadSaveFileButton.id = "LoadSaveFileButton"
	ShieldSettingsTabs.id = "ShieldSettingsTabs"

	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.ShieldEnhModMenu_SafeAreaFront.__onClose = function ( f8_arg0 )
	f8_arg0.HeaderStripe:close()
	f8_arg0.ShieldSettingsTabs:close()
	f8_arg0.CommonHeader:close()
	f8_arg0.TabBacking:close()

	f8_arg0.ClassicModeButton:close()
	f8_arg0.LoadSaveFileButton:close()

	f8_arg0.UI_Settings:close()
	f8_arg0.UI_Settings_Config:close()
	f8_arg0.AchivButton:close()
	f8_arg0.actionsListPCEnh:close()
	f8_arg0.Game_Settings:close()
	f8_arg0.Challs_Settings:close()
	f8_arg0.Online_Settings:close()

	f8_arg0.HeaderPixelGridTiledBackingL:close()
	f8_arg0.HeaderPixelGridTiledBackingR:close()
end