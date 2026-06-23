--[[
      .\hksc.exe '.\Lua\Frontend Side\SavedGameMenu.lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\SavedGameMenu.luac'
]]

------------------------

if not CoD.isFrontend then
	return
end

CoD.InitEnhLuaFile()

------------------------

-- save dvars
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'readjson shield_enh_save_map "" map uint64_t 10 false project-bo4/saved/server/EnhGameSave.json')
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'readjson shield_enh_save_points "" points uint64_t 1 false project-bo4/saved/server/EnhGameSave.json') -- unused?
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'readjson shield_enh_save_round "" round uint64_t 1 false project-bo4/saved/server/EnhGameSave.json')

------------------------

CoD.OverlayUtility.Overlays.EnhSaveLoaded = {
	menuName = "SystemOverlay_Compact",
	postCreateStep = function ( f155_arg0, f155_arg1 )
		f155_arg0.anyControllerAllowed = true
	end,
	title = @"menu/notice",
	description = @"shield/saveloaded",
	categoryType = CoD.OverlayUtility.OverlayTypes.Connection,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	listDatasource = function ( f156_arg0 )

	end
}

CoD.OverlayUtility.Overlays.EnhSaveRulesSaved = {
	menuName = "SystemOverlay_Compact",
	postCreateStep = function ( f155_arg0, f155_arg1 )
		f155_arg0.anyControllerAllowed = true
	end,
	title = @"menu/notice",
	description = @"shield/saved_rules_custom",
	categoryType = CoD.OverlayUtility.OverlayTypes.Connection,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	listDatasource = function ( f156_arg0 )
		DataSources.EnhSaveRulesSavedList = DataSourceHelpers.ListSetup( "EnhSaveRulesSavedList", function ( f157_arg0 )
			return {
				{
					models = {
						displayText = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/ok" )
					},
					properties = {
						action = function ( f158_arg0, f158_arg1, f158_arg2, f158_arg3, f158_arg4 )
							GoBack( f158_arg4, f158_arg2 )
						end
					}
				}
			}
		end, true, nil )
		return "EnhSaveRulesSavedList"
	end
}

CoD.OverlayUtility.Overlays.EnhSaveRulesLoaded = {
	menuName = "SystemOverlay_Compact",
	postCreateStep = function ( f155_arg0, f155_arg1 )
		f155_arg0.anyControllerAllowed = true
	end,
	title = @"menu/notice",
	description = @"shield/loaded_rules_custom",
	categoryType = CoD.OverlayUtility.OverlayTypes.Connection,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	listDatasource = function ( f156_arg0 )
		DataSources.EnhSaveRulesLoadedList = DataSourceHelpers.ListSetup( "EnhSaveRulesLoadedList", function ( f157_arg0 )
			return {
				{
					models = {
						displayText = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/ok" )
					},
					properties = {
						action = function ( f158_arg0, f158_arg1, f158_arg2, f158_arg3, f158_arg4 )
							GoBack( f158_arg4, f158_arg2 )
						end
					}
				}
			}
		end, true, nil )
		return "EnhSaveRulesLoadedList"
	end
}

------------------------

-- Shield_Enh_SavesPopup
CoD.Shield_Enh_SavesPopup = InheritFrom( CoD.Menu )
LUI.createMenu.Shield_Enh_SavesPopup = function ( f1_arg0, f1_arg1 )
	local self = CoD.Menu.NewForUIEditor( "Shield_Enh_SavesPopup", f1_arg0 )
	local f1_local1 = self
	self:setClass( CoD.Shield_Enh_SavesPopup )
	self.soundSet = "none"
	self:setOwner( f1_arg0 )
	self:setLeftRight( 0, 1, 0, 0 )
	self:setTopBottom( 0, 1, 0, 0 )
	self:playSound( "menu_open", f1_arg0 )
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList( self )

	local CommomCenteredPopup = CoD.CommonCenteredPopup.new( f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0 )
	CommomCenteredPopup.TitleText:setText("Saved Game Options")
	CommomCenteredPopup.HeaderBackground:setAlpha( 0 )
	CommomCenteredPopup.HeaderTopBar:setAlpha( 0 )
	CommomCenteredPopup.HeaderBottomBar:setAlpha( 0 )
	self:addElement( CommomCenteredPopup )
	self.CommomCenteredPopup = CommomCenteredPopup

	local LoadSaveFileButton = CoD.DirectorSelectButtonMiniInternal.new( f1_local1, f1_arg0,  0.50, 0.50, -317.00, 312.00, 0.50, 0.50, -105.00 - 84, -45.00 - 84 )
	
	LoadSaveFileButton.MiddleText:setTTF( "notosans_bold" )
	LoadSaveFileButton.MiddleText:setText("Load Current Save")

	LoadSaveFileButton.MiddleTextFocus:setText("Load Current Save")
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

	f1_local1:AddButtonCallbackFunction( LoadSaveFileButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function ( element, menu, controller, model )
		PlaySoundAlias( "uin_paint_image_flip_toggle" )
		CoD.EnhModPrintInfo("Save Save Options")
		
		--OpenOverlay( self, "Shield_Enh_SavesPopup", controller )

		-- load save
		local MapToLoad = Dvar[@"shield_enh_save_map"]:get()
		Engine[@"exec"](Engine[@"getprimarycontroller"](), 'set shield_enh_SaveGame_Load 1')

		local PlaylistID = 0
		if MapToLoad == "0" then
			PlaylistID = 253 -- Voyage of Despair
		elseif MapToLoad == "1" then
			PlaylistID = 257 -- IX
		elseif MapToLoad == "2" then
			PlaylistID = 261 -- Blood of the Dead
		elseif MapToLoad == "3" then
			PlaylistID = 265 -- Classified
		elseif MapToLoad == "4" then
			PlaylistID = 269 -- Dead of the Night
		elseif MapToLoad == "5" then
			PlaylistID = 273 -- ancient evil
		elseif MapToLoad == "6" then
			PlaylistID = 277 -- ao
		elseif MapToLoad == "7" then
			PlaylistID = 281 -- tag
		end
		
		-- notice is loading
		CoD.OverlayUtility.CreateOverlay(controller, menu, "EnhSaveLoaded")

		-- leave current lobby
		local lobby_data = LobbyData.GetCurrentMenuTarget()
		if lobby_data[@"name"] ~= LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME then
			Engine[@"lobbyevent"]( "OnGoBack", {
				controller = controller,
				withParty = LuaEnum.LEAVE_WITH_PARTY.WITHOUT
			} )
		end

		-- load after leaving
		self:addElement( LUI.UITimer.newElementTimer( 3500, true, function ()
			-- set playlist
			Engine[@"setplaylistid"]( PlaylistID )
			LuaUtils.SetQuickplayPlaylistID( PlaylistID )

			-- set gamemode (classic only for now)
			CoD.ZombieUtility.SetPlaylistTab(3, @"hash_773b5b4896f886cb")

			-- go to private lobby
			CoD.DirectorUtility.NavigateToPrivateLobbyForCurrentMode( menu, controller )

			-- launch game after delay
			self:addElement( LUI.UITimer.newElementTimer( 7000, true, function ()
				Engine[@"exec"](Engine[@"getprimarycontroller"](), "lobbylaunchgame")
			end))
		end))
		return true
	end, function ( element, menu, controller ) -- idk if the keyboard checks important or not
		if IsGamepad( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm" )
			return true
		elseif IsMouseOrKeyboard( controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm" )
			return false
		else
			return false
		end
	end, false )
	
	LoadSaveFileButton.id = "LoadSaveFileButton"

	self.__defaultFocus = LoadSaveFileButton

	-- images
	local Mainframe = CoD.StartMenuOptionsMainFrame.new( f1_arg0, f1_arg1, 0.50, 0.50, -313.25 - 1, 307.75 + 1, 0.50, 0.50, -364.74 - 1, -196.74 + 1)
	Mainframe:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
	Mainframe:setAlpha( 0.05 )
	self:addElement( Mainframe )
	self.Mainframe = Mainframe

	local MapImage = LUI.UIImage.new( 0.50, 0.50, -313.25, 307.75, 0.50, 0.50, -364.74, -196.74 )
	MapImage:setImage( RegisterImage( @"uie_ui_menu_emblem_grid" ) )
	MapImage:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_1A02C44161370F6D" ) )
	MapImage:setShaderVector( 0, 0, 0, 0, 0 )
	MapImage:setShaderVector( 1, 1, 1, 0, 0 )
	MapImage:setShaderVector( 2, 0, 0, 0, 0 )
	self:addElement( MapImage )
	self.MapImage = MapImage

	local MapBackImage = LUI.UIImage.new( 0.50, 0.50, -313.25, 307.75, 0.50, 0.50, -364.74, -196.74 )
	MapBackImage:setRGB( 0, 0, 0 )
	MapBackImage:setAlpha( 0.6 )
	self:addElement( MapBackImage )
	self.MapBackImage = MapBackImage

	local SettingDescription = LUI.UIText.new( 0.50, 0.50, -305.51, 1035.49, 0.50, 0.50, -232.51, -202.51 )
	SettingDescription:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
	SettingDescription:setTTF("notosans_bold")
	SettingDescription:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	SettingDescription:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
	self:addElement( SettingDescription )
	self.SettingDescription = SettingDescription
	
	local Map = ""
	local ImageMap = ""
	
	-- dumb ass
	if Dvar[@"shield_enh_save_map"]:get() == "10" then
		Map = nil
	end
	
	if Dvar[@"shield_enh_save_map"]:get() == "0" then
		Map = "Voyage Of Despair"
		ImageMap = "img_zm_zodt8_aar_preview"
	elseif Dvar[@"shield_enh_save_map"]:get() == "1" then
		Map = "IX"
		ImageMap = "img_zm_towers_aar_preview"
	elseif Dvar[@"shield_enh_save_map"]:get() == "2" then
		Map = "Blood Of The Dead"
		ImageMap = "img_zm_escape_aar_preview"
	elseif Dvar[@"shield_enh_save_map"]:get() == "3" then
		Map = "Classified"
		ImageMap = "img_zm_office_aar_preview"
	elseif Dvar[@"shield_enh_save_map"]:get() == "4" then
		Map = "Dead Of The Night"
		ImageMap = "img_zm_mansion_aar_preview"
	elseif Dvar[@"shield_enh_save_map"]:get() == "5" then
		Map = "Ancient Evil"
		ImageMap = "img_zm_red_aar_preview"
	elseif Dvar[@"shield_enh_save_map"]:get() == "6" then
		Map = "Alpha Omega"
		ImageMap = "img_zm_alpha_omega_aar_preview"
	elseif Dvar[@"shield_enh_save_map"]:get() == "7" then
		Map = "Tag Der Toten"
		ImageMap = "img_zm_orange_aar_preview"
	end

	if Map == nil then
		SettingDescription:setText("No Save Available..")
	else
		MapImage:setImage( RegisterImage( ImageMap ) )
		SettingDescription:setText(Map .. " | Round: " .. Dvar[@"shield_enh_save_round"]:get())
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

	--self.__defaultFocus = SettingDescription

	if CoD.isPC and (IsKeyboard( f1_arg0 ) or self.ignoreCursor) then
		self:restoreState( f1_arg0 )
	end
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg0 )
	end
	
	f1_local7 = self
	--MenuHidesFreeCursor( f1_local1, f1_arg0 )

	CoD.EnhModPrintInfo("Called", "Shield's Enh Save Settings Menu")

	return self
end

CoD.Shield_Enh_SavesPopup.__resetProperties = function ( f13_arg0 )

end

CoD.Shield_Enh_SavesPopup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f14_arg0, f14_arg1 )
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter( 0 )
		end
	},
}

CoD.Shield_Enh_SavesPopup.__onClose = function ( f16_arg0 )
	f16_arg0.CommomCenteredPopup:close()
	f16_arg0.SettingDescription:close()
	f16_arg0.LoadSaveFileButton:close()
end