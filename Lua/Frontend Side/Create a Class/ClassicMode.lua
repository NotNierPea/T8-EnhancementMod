--[[
      .\hksc.exe '.\Lua\Frontend Side\ClassicMode.lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\ClassicMode.luac'
]]

------------------------

if not CoD.isFrontend then
	return
end

CoD.InitEnhLuaFile()

------------------------

local PerkCurrentTab = 0

------------------------

CoD.OpenCACWithMenuSessionModeClassic = function( f100_arg0, f100_arg1, f100_arg2, f100_arg3, f100_arg4 )
	if CoD.DirectorUtility.ShouldShowAppLoadoutAvailable( f100_arg4, f100_arg2 ) then
		CoD.OverlayUtility.CreateOverlay( f100_arg2, f100_arg4, "AppLoadoutConfirmLoadout", f100_arg2, nil )
		return 
	end
	local f100_local0 = f100_arg3.eMode
	local f100_local1 = "MPCustomizeClassMenu"
	if f100_local0 == Enum[@"emodes"][@"mode_zombies"] then
		f100_local1 = "ZMCustomizeClassMenu"
		if CoD.DirectorUtility.IsLoadoutPreviewWidgetShown( f100_arg2 ) then
			CoD.DirectorUtility.HideLoadoutPreview( f100_arg2 )
		end

		-- classic's
		if Engine[@"getdvarint"]("shield_enh_ClassicMode") == 1 and Engine[@"getdvarint"]("shield_enh_ClassicMode_Loadouts") == 1 then
			f100_local1 = "ZMCustomizeClassMenuClassic"
		end
	end
	OpenOverlay( f100_arg0, f100_local1, f100_arg2, {
		_sessionMode = f100_local0
	} )
end

------------------------

-- Classic CAC Settings
DataSources.ClassicCACListOptions = DataSourceHelpers.ListSetup( "ClassicCACListOptions", function ( f138_arg0 )
	local Settings = {}

	
	table.insert( Settings, CoD.OptionsUtility.CreateDvarSettings( f138_arg0, @"shield/classic_preview", @"shield/classic_preview", "shield_enh_ClassicPerview", "shield_enh_ClassicPerview", {
		{
			option = Engine[@"hash_4F9F1239CFD921FE"]( @"hash_94EB0E3329EDF5F" ),
			value = 0,
			default = true
		},
		{
			option = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/enabled" ),
			value = 1
		}
	}, nil, CoD.OnModDataChange ) )


	return Settings

end, nil, nil, function ( f139_arg0, f139_arg1, f139_arg2 )
	local f139_local0 = Engine[@"createmodel"]( Engine[@"getglobalmodel"](), "GametypeSettings.Update" )
	if f139_arg1.updateSubscription then
		f139_arg1:removeSubscription( f139_arg1.updateSubscription )
	end
	f139_arg1.updateSubscription = f139_arg1:subscribeToModel( f139_local0, function ()
		f139_arg1:updateDataSource()
	end, false )
end )


------------------------

CoD.ZMCustomizeClassMenuClassic = InheritFrom( CoD.Menu )
LUI.createMenu.ZMCustomizeClassMenuClassic = function ( f1_arg0, f1_arg1 )
	CoD.EnhModPrintInfo("classic's menu here")

	local self = CoD.Menu.NewForUIEditor( "ZMCustomizeClassMenuClassic", f1_arg0 )
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData( self, f1_arg1 )
	SendClientScriptMenuChangeNotify( f1_arg0, f1_local1, true )
	CoD.ZMStoryUtility.SetSelectedStoryToCurrentMapStory( f1_arg0 )
	CoD.LobbyUtility.SetMenuControllerRestriction( self, f1_arg0, 1 )
	self:setClass( CoD.ZMCustomizeClassMenuClassic )
	self.soundSet = "FrontendMain"
	self:setOwner( f1_arg0 )
	self:setLeftRight( 0, 1, 0, 0 )
	self:setTopBottom( 0, 1, 0, 0 )
	self:playSound( "menu_open", f1_arg0 )
	self.anyChildUsesUpdateState = true
	local ScorestreakAspectRatioFix = nil
	
	ScorestreakAspectRatioFix = CoD.Scorestreak_AspectRatioFix.new( f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0 )
	self:addElement( ScorestreakAspectRatioFix )
	self.ScorestreakAspectRatioFix = ScorestreakAspectRatioFix
	
	local DirectorCustomizeClassZM = CoD.DirectorCustomizeClassZMClassic.new( f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0 )
	self:addElement( DirectorCustomizeClassZM )
	self.DirectorCustomizeClassZM = DirectorCustomizeClassZM

	local GenericMenuFrame = CoD.GenericMenuFrame.new( f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0 )
	GenericMenuFrame.CommonHeader.BGSceneBlur:setAlpha( 1 )
	GenericMenuFrame.CommonHeader.subtitle.StageTitle:setText( "Classic Menu" )
	GenericMenuFrame:subscribeToGlobalModel( f1_arg0, "LobbyRoot", "lobbyTitle", function ( model )
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrame.CommonHeader.subtitle.subtitle:setText( "Classic Menu" )
		end
	end )
	self:addElement( GenericMenuFrame )
	self.GenericMenuFrame = GenericMenuFrame

	GenericMenuFrame.FooterContainerFrontendRight.RightContainerPC:setAlpha(0)
	
	local SafeAreaContainer = CoD.ZMCustomizeClassSafeAreaContainerClassic.new( f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080 )
	SafeAreaContainer:registerEventHandler( "menu_loaded", function ( element, event )
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded( event )
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded( event )
		end
		SizeToSafeArea( element, f1_arg0 )
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren( event )
		end
		return f3_local0
	end )
	self:addElement( SafeAreaContainer )
	self.SafeAreaContainer = SafeAreaContainer
	
	self:linkToElementModel( self, nil, true, function ( model, f6_arg1 )
		CoD.Menu.UpdateButtonShownState( f6_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_start"] )
	end )
	f1_local1:AddButtonCallbackFunction( self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function ( element, menu, controller, model )
		GoBack( self, controller )
		SendClientScriptMenuChangeNotify( controller, menu, false )
		SaveLoadoutGeneric( controller )
		UpdateGamerprofile( self, element, controller )
		CoD.ZMLoadoutUtility.SaveZMLoadoutBuffer( controller )
		CoD.LobbyUtility.SetMenuControllerRestriction( self, controller, 0 )
		return true
	end, function ( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil )
		return true
	end, false )
	f1_local1:AddButtonCallbackFunction( self, f1_arg0, Enum[@"luibutton"][@"lui_key_start"], "ui_contextual_1", function ( element, menu, controller, model )
		if not CoD.CACUtility.IsCurrentClassLocked( menu, controller ) then
			CoD.CACUtility.OpenClassOptions( self, menu, controller, "ClassOptions" )
			return true
		else
			
		end
	end, function ( element, menu, controller )
		if not CoD.CACUtility.IsCurrentClassLocked( menu, controller ) then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_start"], @"menu/class_options", nil, "ui_contextual_1" )
			return true
		else
			return false
		end
	end, false )
	LUI.OverrideFunction_CallOriginalFirst( self, "close", function ( element )
		ResetFrontendMusic( f1_arg0 )
		CoD.ZMStoryUtility.SetSelectedStoryToCurrentMapStory( f1_arg0 )
	end )
	DirectorCustomizeClassZM.id = "DirectorCustomizeClassZM"
	if CoD.isPC then
		GenericMenuFrame.id = "GenericMenuFrame"
	end
	SafeAreaContainer.id = "SafeAreaContainer"
	self:processEvent( {
		name = "menu_loaded",
		controller = f1_arg0
	} )
	self.__defaultFocus = DirectorCustomizeClassZM
	if CoD.isPC and (IsKeyboard( f1_arg0 ) or self.ignoreCursor) then
		self:restoreState( f1_arg0 )
	end
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg0 )
	end
	local f1_local6 = self
	if not CoD.BaseUtility.IsMenuSessionModeEqualTo( f1_local1, Enum[@"emodes"][@"mode_invalid"] ) then
		CoD.BaseUtility.SetStateByMenuSessionMode( f1_local1, self, f1_arg0 )
		CoD.FTUEUtility.ShowFTUESequenceIfNotSeen( self, f1_arg0, "ZMLoadoutIntroduction" )
	else
		SetCharacterModeToSessionMode( self, f1_arg0, Enum[@"emodes"][@"mode_zombies"] )
		CoD.FTUEUtility.ShowFTUESequenceIfNotSeen( self, f1_arg0, "ZMLoadoutIntroduction" )
	end
	return self
end

CoD.ZMCustomizeClassMenuClassic.__onClose = function ( f12_arg0 )
	f12_arg0.DirectorCustomizeClassZM:close()
	f12_arg0.GenericMenuFrame:close()
	f12_arg0.ScorestreakAspectRatioFix:close()
	f12_arg0.SafeAreaContainer:close()
end

CoD.ZMCustomizeClassSafeAreaContainerClassic = InheritFrom( LUI.UIElement )
CoD.ZMCustomizeClassSafeAreaContainerClassic.__defaultWidth = 1920
CoD.ZMCustomizeClassSafeAreaContainerClassic.__defaultHeight = 1080
CoD.ZMCustomizeClassSafeAreaContainerClassic.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.ZMCustomizeClassSafeAreaContainerClassic )
	self.id = "ZMCustomizeClassSafeAreaContainerClassic"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	
	local TabBacking = CoD.CommonTabBarBacking.new( f1_arg0, f1_arg1, -0.1, 1.1, 0, 0, 0, 0, 52, 89 )
	TabBacking.TabBackingBlur:setAlpha( 0 )
	self:addElement( TabBacking )
	self.TabBacking = TabBacking
	
	local CACHeader = CoD.CommonHeader.new( f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 67 )
	CACHeader.subtitle.StageTitle:setText( "Classic Mode Menu" )
	CACHeader.subtitle.subtitle:setAlpha( 0 )
	CACHeader:subscribeToGlobalModel( f1_arg1, "LobbyRoot", "lobbyTitle", function ( model )
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CACHeader.subtitle.subtitle:setText( Engine[@"hash_4F9F1239CFD921FE"]( f2_local0 ) )
		end
	end )
	CACHeader:linkToElementModel( self, nil, false, function ( model )
		CACHeader:setModel( model, f1_arg1 )
	end )
	self:addElement( CACHeader )
	self.CACHeader = CACHeader
	
	--local customClassList = CoD.ZMCustomClassTabs.new( f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 35.5, 95.5 )
	--self:addElement( customClassList )
	--self.customClassList = customClassList
	
	-- to make my own tabs work
	--local ZMStoryTabs = CoD.ZMStoryTabs.new( f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 2, 62 )
	--self:addElement( ZMStoryTabs )
	--self.ZMStoryTabs = ZMStoryTabs
	
	--customClassList.id = "customClassList"
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.ZMCustomizeClassSafeAreaContainerClassic.__onClose = function ( f4_arg0 )
	f4_arg0.TabBacking:close()
	f4_arg0.CACHeader:close()
	--f4_arg0.customClassList:close()
	--f4_arg0.ZMStoryTabs:close()
end

DataSources.PerkSelectListClassic = DataSourceHelpers.ListSetup( "PerkSelectListClassic", function ( f18_arg0, f18_arg1 )
	local f18_local0 = {}
	local f18_local1 = "specialty"
	local f18_local2 = CoD.BaseUtility.GetMenuSessionMode( f18_arg1.menu )
	local f18_local3 = CoD.BaseUtility.GetMenuModel( f18_arg1.menu )
	local f18_local4 = DataSources.ZMEquippedPerks.getModel( f18_arg0 )
	local f18_local5 = CoD.CACUtility.GetItemEquippedInSlot( f18_local4.currentSlot:get(), nil, f18_local3 )

	if PerkCurrentTab == 0 then
		for f18_local9, f18_local10 in ipairs( CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f18_local2, f18_local1 ) ) do
			if f18_local10.allocation ~= -1 and not CoD.CACUtility.DvarHideUnlockableItem( f18_local10.nameHash, f18_local2 ) then
				table.insert( f18_local0, {
					models = {
						name = f18_local10.name,
						globalItemIndex = 99,
						itemIndex = 99,
						displayName = f18_local10.displayName,
						image = CoD.CACUtility.GetPreviewImageLarge( f18_local2, f18_local10 ),
						description = f18_local10.description,
						modifierName = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/modifier", f18_local10[@"hash_18FC01EA0DDD81D"] or @"hash_0" ),
						modifierDesc = f18_local10[@"modifierdescription"] or @"hash_0",
						isRestricted = CoD.CACUtility.IsPerkRestricted( CoD.ZMPerkUtility.PerkToBooleanGameSettingsHash[f18_local10.nameHash], false ),
						IsClassicMoifier = false
					},
					properties = {
						selectIndex = false,
						equipSound = f18_local10[@"equipsound"] or @"hash_858B7E73692FF70"
					}
				} )

				CoD.EnhModPrintInfo(f18_local10.name)
			end
		end
	end

	if PerkCurrentTab == 1 then
		-- classic ones
		table.insert( f18_local0, {
			models = {
				name = @"shield/jugg_string",
				globalItemIndex = 99,
				itemIndex = 99,
				displayName = @"shield/jugg_string",
				image = RegisterImage(@"jugg_classic"),
				description = @"shield/jugg_string_desc",
				modifierName = @"shield/jugg_string",
				modifierDesc = @"shield/classic_modifier",
				isRestricted = false,
				IsClassicMoifier = false
			},
			properties = {
				selectIndex = false,
				equipSound = @"hash_858B7E73692FF70"
			}
		} )

		table.insert( f18_local0, {
			models = {
				name = @"shield/vulture_string",
				globalItemIndex = 99,
				itemIndex = 99,
				displayName = @"shield/vulture_string",
				image = RegisterImage(@"vult_classic"),
				description = @"shield/vulture_string_desc",
				modifierName = @"shield/vulture_string",
				modifierDesc = @"shield/classic_modifier",
				isRestricted = false,
				IsClassicMoifier = false
			},
			properties = {
				selectIndex = false,
				equipSound = @"hash_858B7E73692FF70"
			}
		} )

		table.insert( f18_local0, {
			models = {
				name = @"shield/elemental_string",
				globalItemIndex = 99,
				itemIndex = 99,
				displayName = @"shield/elemental_string",
				image = RegisterImage(@"elem_classic"),
				description = @"shield/elemental_string_desc",
				modifierName = @"shield/elemental_string",
				modifierDesc = @"shield/classic_modifier",
				isRestricted = false,
				IsClassicMoifier = false
			},
			properties = {
				selectIndex = false,
				equipSound = @"hash_858B7E73692FF70"
			}
		} )

		table.insert( f18_local0, {
			models = {
				name = @"shield/fastreload_string",
				globalItemIndex = 99,
				itemIndex = 99,
				displayName = @"shield/fastreload_string",
				image = RegisterImage(@"speed_classic"),
				description = @"shield/fastreload_string_desc",
				modifierName = @"shield/fastreload_string",
				modifierDesc = @"shield/classic_modifier",
				isRestricted = false,
				IsClassicMoifier = false
			},
			properties = {
				selectIndex = false,
				equipSound = @"hash_858B7E73692FF70"
			}
		} )

		table.insert( f18_local0, {
			models = {
				name = @"shield/doubletab_string",
				globalItemIndex = 99,
				itemIndex = 99,
				displayName = @"shield/doubletab_string1",
				image = RegisterImage(@"double_classic_one"),
				description = @"shield/doubletab_string_desc1",
				modifierName = @"shield/doubletab_string",
				modifierDesc = @"shield/classic_modifier",
				isRestricted = false,
				IsClassicMoifier = false
			},
			properties = {
				selectIndex = false,
				equipSound = @"hash_858B7E73692FF70"
			}
		} )

		table.insert( f18_local0, {
			models = {
				name = @"shield/doubletab_string",
				globalItemIndex = 99,
				itemIndex = 99,
				displayName = @"shield/doubletab_string2",
				image = RegisterImage(@"double_classic"),
				description = @"shield/doubletab_string_desc2",
				modifierName = @"shield/doubletab_string",
				modifierDesc = @"shield/classic_modifier",
				isRestricted = false,
				IsClassicMoifier = false
			},
			properties = {
				selectIndex = false,
				equipSound = @"hash_858B7E73692FF70"
			}
		} )

		table.insert( f18_local0, {
			models = {
				name = @"shield/whoswho_string",
				globalItemIndex = 99,
				itemIndex = 99,
				displayName = @"shield/whoswho_string",
				image = RegisterImage(@"who_classic"),
				description = @"shield/whoswho_string_desc",
				modifierName = @"shield/whoswho_string",
				modifierDesc = @"shield/classic_modifier",
				isRestricted = false,
				IsClassicMoifier = false
			},
			properties = {
				selectIndex = false,
				equipSound = @"hash_858B7E73692FF70"
			}
		} )
	end	

	-- voyage
	if PerkCurrentTab == 2 then
		local perkOrder = {
			"perk_bandolier",
			"perk_dead_shot",
			"perk_quick_revive", 
			"perk_tortoise"
		}

		for index, perkName in ipairs(perkOrder) do
			for _, f18_local10 in ipairs( CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f18_local2, f18_local1 ) ) do
				if f18_local10.allocation ~= -1 and not CoD.CACUtility.DvarHideUnlockableItem( f18_local10.nameHash, f18_local2 ) and f18_local10.name == perkName then
					table.insert( f18_local0, {
						models = {
							name = f18_local10.name,
							globalItemIndex = 99,
							itemIndex = 99,
							displayName = f18_local10.displayName,
							image = CoD.CACUtility.GetPreviewImageLarge( f18_local2, f18_local10 ),
							description = f18_local10.description, 
							modifierName = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/modifier", f18_local10[@"hash_18FC01EA0DDD81D"] or @"hash_0" ),
							modifierDesc = f18_local10[@"modifierdescription"] or @"hash_0",
							isRestricted = CoD.CACUtility.IsPerkRestricted( CoD.ZMPerkUtility.PerkToBooleanGameSettingsHash[f18_local10.nameHash], false ),
							IsClassicMoifier = index == 4
						},
						properties = {
							selectIndex = false,
							equipSound = f18_local10[@"equipsound"] or @"hash_858B7E73692FF70"
						}
					} )
					break
				end
			end
		end
	end

	-- ix
	if PerkCurrentTab == 3 then
		local perkOrder = {
			"perk_slider",
			"perk_widows_wine",
			"perk_stronghold", 
			"perk_wolf_protector"
		}

		for index, perkName in ipairs(perkOrder) do
			for _, f18_local10 in ipairs( CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f18_local2, f18_local1 ) ) do
				if f18_local10.allocation ~= -1 and not CoD.CACUtility.DvarHideUnlockableItem( f18_local10.nameHash, f18_local2 ) and f18_local10.name == perkName then
					table.insert( f18_local0, {
						models = {
							name = f18_local10.name,
							globalItemIndex = 99,
							itemIndex = 99,
							displayName = f18_local10.displayName,
							image = CoD.CACUtility.GetPreviewImageLarge( f18_local2, f18_local10 ),
							description = f18_local10.description, 
							modifierName = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/modifier", f18_local10[@"hash_18FC01EA0DDD81D"] or @"hash_0" ),
							modifierDesc = f18_local10[@"modifierdescription"] or @"hash_0",
							isRestricted = CoD.CACUtility.IsPerkRestricted( CoD.ZMPerkUtility.PerkToBooleanGameSettingsHash[f18_local10.nameHash], false ),
							IsClassicMoifier = index == 4
						},
						properties = {
							selectIndex = false,
							equipSound = f18_local10[@"equipsound"] or @"hash_858B7E73692FF70"
						}
					} )
					break
				end
			end
		end
	end

	-- blood
	if PerkCurrentTab == 4 then
		local perkOrder = {
			"perk_quick_revive",
			"perk_stronghold",
			"perk_slider", 
			"perk_staminup"
		}

		for index, perkName in ipairs(perkOrder) do
			for _, f18_local10 in ipairs( CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f18_local2, f18_local1 ) ) do
				if f18_local10.allocation ~= -1 and not CoD.CACUtility.DvarHideUnlockableItem( f18_local10.nameHash, f18_local2 ) and f18_local10.name == perkName then
					table.insert( f18_local0, {
						models = {
							name = f18_local10.name,
							globalItemIndex = 99,
							itemIndex = 99,
							displayName = f18_local10.displayName,
							image = CoD.CACUtility.GetPreviewImageLarge( f18_local2, f18_local10 ),
							description = f18_local10.description, 
							modifierName = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/modifier", f18_local10[@"hash_18FC01EA0DDD81D"] or @"hash_0" ),
							modifierDesc = f18_local10[@"modifierdescription"] or @"hash_0",
							isRestricted = CoD.CACUtility.IsPerkRestricted( CoD.ZMPerkUtility.PerkToBooleanGameSettingsHash[f18_local10.nameHash], false ),
							IsClassicMoifier = index == 4
						},
						properties = {
							selectIndex = false,
							equipSound = f18_local10[@"equipsound"] or @"hash_858B7E73692FF70"
						}
					} )
					break
				end
			end
		end
	end

	-- class
	if PerkCurrentTab == 10 then
		local perkOrder = {
			"perk_staminup",
			"perk_cooldown",
			"perk_wolf_protector", 
			"perk_electric_cherry"
		}

		for index, perkName in ipairs(perkOrder) do
			for _, f18_local10 in ipairs( CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f18_local2, f18_local1 ) ) do
				if f18_local10.allocation ~= -1 and not CoD.CACUtility.DvarHideUnlockableItem( f18_local10.nameHash, f18_local2 ) and f18_local10.name == perkName then
					table.insert( f18_local0, {
						models = {
							name = f18_local10.name,
							globalItemIndex = 99,
							itemIndex = 99,
							displayName = f18_local10.displayName,
							image = CoD.CACUtility.GetPreviewImageLarge( f18_local2, f18_local10 ),
							description = f18_local10.description, 
							modifierName = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/modifier", f18_local10[@"hash_18FC01EA0DDD81D"] or @"hash_0" ),
							modifierDesc = f18_local10[@"modifierdescription"] or @"hash_0",
							isRestricted = CoD.CACUtility.IsPerkRestricted( CoD.ZMPerkUtility.PerkToBooleanGameSettingsHash[f18_local10.nameHash], false ),
							IsClassicMoifier = index == 4
						},
						properties = {
							selectIndex = false,
							equipSound = f18_local10[@"equipsound"] or @"hash_858B7E73692FF70"
						}
					} )
					break
				end
			end
		end
	end

	-- dead
	if PerkCurrentTab == 6 then
		local perkOrder = {
			"perk_widows_wine",
			"perk_slider",
			"perk_stronghold", 
			"perk_wolf_protector"
		}

		for index, perkName in ipairs(perkOrder) do
			for _, f18_local10 in ipairs( CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f18_local2, f18_local1 ) ) do
				if f18_local10.allocation ~= -1 and not CoD.CACUtility.DvarHideUnlockableItem( f18_local10.nameHash, f18_local2 ) and f18_local10.name == perkName then
					table.insert( f18_local0, {
						models = {
							name = f18_local10.name,
							globalItemIndex = 99,
							itemIndex = 99,
							displayName = f18_local10.displayName,
							image = CoD.CACUtility.GetPreviewImageLarge( f18_local2, f18_local10 ),
							description = f18_local10.description, 
							modifierName = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/modifier", f18_local10[@"hash_18FC01EA0DDD81D"] or @"hash_0" ),
							modifierDesc = f18_local10[@"modifierdescription"] or @"hash_0",
							isRestricted = CoD.CACUtility.IsPerkRestricted( CoD.ZMPerkUtility.PerkToBooleanGameSettingsHash[f18_local10.nameHash], false ),
							IsClassicMoifier = index == 4
						},
						properties = {
							selectIndex = false,
							equipSound = f18_local10[@"equipsound"] or @"hash_858B7E73692FF70"
						}
					} )
					break
				end
			end
		end
	end

	-- ae
	if PerkCurrentTab == 7 then
		local perkOrder = {
			"perk_slider",
			"perk_widows_wine",
			"perk_tortoise", 
			"perk_cooldown"
		}

		for index, perkName in ipairs(perkOrder) do
			for _, f18_local10 in ipairs( CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f18_local2, f18_local1 ) ) do
				if f18_local10.allocation ~= -1 and not CoD.CACUtility.DvarHideUnlockableItem( f18_local10.nameHash, f18_local2 ) and f18_local10.name == perkName then
					table.insert( f18_local0, {
						models = {
							name = f18_local10.name,
							globalItemIndex = 99,
							itemIndex = 99,
							displayName = f18_local10.displayName,
							image = CoD.CACUtility.GetPreviewImageLarge( f18_local2, f18_local10 ),
							description = f18_local10.description, 
							modifierName = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/modifier", f18_local10[@"hash_18FC01EA0DDD81D"] or @"hash_0" ),
							modifierDesc = f18_local10[@"modifierdescription"] or @"hash_0",
							isRestricted = CoD.CACUtility.IsPerkRestricted( CoD.ZMPerkUtility.PerkToBooleanGameSettingsHash[f18_local10.nameHash], false ),
							IsClassicMoifier = index == 4
						},
						properties = {
							selectIndex = false,
							equipSound = f18_local10[@"equipsound"] or @"hash_858B7E73692FF70"
						}
					} )
					break
				end
			end
		end
	end

	-- ao
	if PerkCurrentTab == 8 then
		local perkOrder = {
			"perk_electric_cherry",
			"perk_cooldown",
			"perk_stronghold", 
			"perk_dead_shot"
		}

		for index, perkName in ipairs(perkOrder) do
			for _, f18_local10 in ipairs( CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f18_local2, f18_local1 ) ) do
				if f18_local10.allocation ~= -1 and not CoD.CACUtility.DvarHideUnlockableItem( f18_local10.nameHash, f18_local2 ) and f18_local10.name == perkName then
					table.insert( f18_local0, {
						models = {
							name = f18_local10.name,
							globalItemIndex = 99,
							itemIndex = 99,
							displayName = f18_local10.displayName,
							image = CoD.CACUtility.GetPreviewImageLarge( f18_local2, f18_local10 ),
							description = f18_local10.description, 
							modifierName = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/modifier", f18_local10[@"hash_18FC01EA0DDD81D"] or @"hash_0" ),
							modifierDesc = f18_local10[@"modifierdescription"] or @"hash_0",
							isRestricted = CoD.CACUtility.IsPerkRestricted( CoD.ZMPerkUtility.PerkToBooleanGameSettingsHash[f18_local10.nameHash], false ),
							IsClassicMoifier = index == 4
						},
						properties = {
							selectIndex = false,
							equipSound = f18_local10[@"equipsound"] or @"hash_858B7E73692FF70"
						}
					} )
					break
				end
			end
		end
	end

	-- tag
	if PerkCurrentTab == 9 then
		local perkOrder = {
			"perk_stronghold",
			"perk_wolf_protector",
			"perk_staminup", 
			"perk_cooldown"
		}

		for index, perkName in ipairs(perkOrder) do
			for _, f18_local10 in ipairs( CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f18_local2, f18_local1 ) ) do
				if f18_local10.allocation ~= -1 and not CoD.CACUtility.DvarHideUnlockableItem( f18_local10.nameHash, f18_local2 ) and f18_local10.name == perkName then
					table.insert( f18_local0, {
						models = {
							name = f18_local10.name,
							globalItemIndex = 99,
							itemIndex = 99,
							displayName = f18_local10.displayName,
							image = CoD.CACUtility.GetPreviewImageLarge( f18_local2, f18_local10 ),
							description = f18_local10.description, 
							modifierName = Engine[@"hash_4F9F1239CFD921FE"]( @"menu/modifier", f18_local10[@"hash_18FC01EA0DDD81D"] or @"hash_0" ),
							modifierDesc = f18_local10[@"modifierdescription"] or @"hash_0",
							isRestricted = CoD.CACUtility.IsPerkRestricted( CoD.ZMPerkUtility.PerkToBooleanGameSettingsHash[f18_local10.nameHash], false ),
							IsClassicMoifier = index == 4
						},
						properties = {
							selectIndex = false,
							equipSound = f18_local10[@"equipsound"] or @"hash_858B7E73692FF70"
						}
					} )
					break
				end
			end
		end
	end

	return f18_local0
end, true )

DataSources.ShieldPerksFilters = DataSourceHelpers.ListSetup( "ShieldPerksFilters", function ( f3_arg0, f3_arg1 )
	local filters = {
        {
            
			models = {
				name = @"shield/main_perks",
				filter = 0
			},
                  properties = {
				filter = 0
			}
		},
		{
            
			models = {
				name = @"shield/classic_perks",
				filter = 1
			},
                  properties = {
				filter = 1
			}

		},
	}
	return filters
end, true )

DataSources.ShieldPerksFiltersMaps = DataSourceHelpers.ListSetup( "ShieldPerksFiltersMaps", function ( f3_arg0, f3_arg1 )
	local filters = {
        {
            
			models = {
				name = @"hash_58a3d2684056d788",
				filter = 2
			},
                  properties = {
				filter = 2
			}
		},
		{
            
			models = {
				name = @"hash_1fbf66a81cc73280",
				filter = 3
			},
                  properties = {
				filter = 3
			}
		},
		{
            
			models = {
				name = @"hash_6426e91377126148",
				filter = 4
			},
                  properties = {
				filter = 4
			}
		},
		{
			models = {
				name = @"hash_2437c1b174fa4038",
				filter = 10
			},
            properties = {
				filter = 10
			}
		},
		{
            
			models = {
				name = @"hash_4d4de632931b7580",
				filter = 6
			},
                  properties = {
				filter = 6
			}
		},
		{
            
			models = {
				name = @"hash_5e6b3d39d479f22e",
				filter = 7
			},
                  properties = {
				filter = 7
			}
		},
		{
            
			models = {
				name = @"hash_2744ee0ea477fe83",
				filter = 8
			},
                  properties = {
				filter = 8
			}
		},
		{
            
			models = {
				name = @"hash_14894d0fe4dfa76d",
				filter = 9
			},
                  properties = {
				filter = 9
			}
		}
	}
	return filters
end, true )

-- perk slot
CoD.ZMPerkOptionCustom = InheritFrom( LUI.UIElement )
CoD.ZMPerkOptionCustom.__defaultWidth = 132
CoD.ZMPerkOptionCustom.__defaultHeight = 128
CoD.ZMPerkOptionCustom.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.ZMPerkOptionCustom )
	self.id = "ZMPerkOptionCustom"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local ZMPerk = CoD.ZMElixirSlotInternalCustom.new( f1_arg0, f1_arg1, 0.5, 0.5, -80, 80, 0.5, 0.5, -80, 80 )
	ZMPerk:mergeStateConditions( {
		{
			stateName = "Locked",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "NoConsumablesRemainingEquipped",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "NoConsumablesRemaining",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "Equipped",
			condition = function ( menu, element, event )
				return CoD.ZMPerkUtility.IsPerkEquipped( self, f1_arg1, menu )
			end
		}
	} )
	local f1_local2 = ZMPerk
	local f1_local3 = ZMPerk.subscribeToModel
	local f1_local4 = DataSources.ZMEquippedPerks.getModel( f1_arg1 )
	f1_local3( f1_local2, f1_local4.updateEquipped, function ( f6_arg0 )
		f1_arg0:updateElementState( ZMPerk, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "updateEquipped"
		} )
	end, false )
	ZMPerk:linkToElementModel( ZMPerk, "globalItemIndex", true, function ( model )
		f1_arg0:updateElementState( ZMPerk, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "globalItemIndex"
		} )
	end )
	ZMPerk:setScale( 0.9, 0.9 )
	ZMPerk:linkToElementModel( self, nil, false, function ( model )
		ZMPerk:setModel( model, f1_arg1 )
	end )
	self:addElement( ZMPerk )
	self.ZMPerk = ZMPerk
	
	ZMPerk.id = "ZMPerk"
	self.__defaultFocus = ZMPerk
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.ZMPerkOptionCustom.__resetProperties = function ( f9_arg0 )
	f9_arg0.ZMPerk:completeAnimation()
	f9_arg0.ZMPerk:setScale( 0.9, 0.9 )
end

CoD.ZMPerkOptionCustom.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f10_arg0, f10_arg1 )
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter( 0 )
		end,
		ChildFocus = function ( f11_arg0, f11_arg1 )
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter( 1 )
			f11_arg0.ZMPerk:completeAnimation()
			f11_arg0.ZMPerk:setScale( 0.93, 0.93 )
			f11_arg0.clipFinished( f11_arg0.ZMPerk )
		end,
		GainChildFocus = function ( f12_arg0, f12_arg1 )
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter( 1 )
			local f12_local0 = function ( f13_arg0 )
				f12_arg0.ZMPerk:beginAnimation( 200, Enum[@"luitween"][@"luitween_ease_both"] )
				f12_arg0.ZMPerk:setScale( 0.93, 0.93 )
				f12_arg0.ZMPerk:registerEventHandler( "interrupted_keyframe", f12_arg0.clipInterrupted )
				f12_arg0.ZMPerk:registerEventHandler( "transition_complete_keyframe", f12_arg0.clipFinished )
			end
			
			f12_arg0.ZMPerk:completeAnimation()
			f12_arg0.ZMPerk:setScale( 0.9, 0.9 )
			f12_local0( f12_arg0.ZMPerk )
		end,
		LoseChildFocus = function ( f14_arg0, f14_arg1 )
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter( 1 )
			local f14_local0 = function ( f15_arg0 )
				f14_arg0.ZMPerk:beginAnimation( 200, Enum[@"luitween"][@"luitween_ease_both"] )
				f14_arg0.ZMPerk:setScale( 0.9, 0.9 )
				f14_arg0.ZMPerk:registerEventHandler( "interrupted_keyframe", f14_arg0.clipInterrupted )
				f14_arg0.ZMPerk:registerEventHandler( "transition_complete_keyframe", f14_arg0.clipFinished )
			end
			
			f14_arg0.ZMPerk:completeAnimation()
			f14_arg0.ZMPerk:setScale( 0.93, 0.93 )
			f14_local0( f14_arg0.ZMPerk )
		end
	}
}

CoD.ZMPerkOptionCustom.__onClose = function ( f16_arg0 )
	f16_arg0.ZMPerk:close()
end

CoD.ZMElixirSlotInternalCustom = InheritFrom( LUI.UIElement )
CoD.ZMElixirSlotInternalCustom.__defaultWidth = 160
CoD.ZMElixirSlotInternalCustom.__defaultHeight = 160
CoD.ZMElixirSlotInternalCustom.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self.IsModifer = false
	self:setClass( CoD.ZMElixirSlotInternalCustom )
	self.id = "ZMElixirSlotInternalCustom"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local backgroundBlur = LUI.UIImage.new( 0.02, 0.02, 9, 145, 0.04, 0.04, 10.5, 138.5 )
	backgroundBlur:setRGB( 0, 0, 0 )
	backgroundBlur:setAlpha( 0.8 )
	backgroundBlur:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_E2354BE557C4C7A" ) )
	backgroundBlur:setShaderVector( 0, 0, 0, 0, 0 )
	self:addElement( backgroundBlur )
	self.backgroundBlur = backgroundBlur
	
	local FocusBackground = LUI.UIImage.new( 0, 1, 9.5, 9.5, 0, 1, 12, 12 )
	FocusBackground:setRGB( 0.74, 0.74, 0.74 )
	FocusBackground:setAlpha( 0 )
	self:addElement( FocusBackground )
	self.FocusBackground = FocusBackground
	
	local Box = LUI.UIImage.new( 0, 0, 0, 160, 0, 0, 0, 160 )
	Box:setAlpha( 0.5 )
	Box:setImage( RegisterImage( @"uie_ui_menu_zombies_cac_elixir_slot_box" ) )
	self:addElement( Box )
	self.Box = Box

	local LightFocus = LUI.UIImage.new( 0, 0, 0, 160, 0, 0, 0, 160 )
	LightFocus:setRGB( 1, 0, 0 )
	LightFocus:setAlpha( 0 )
	LightFocus:setImage( RegisterImage( @"uie_ui_menu_zombies_cac_elixir_slot_light_focus" ) )
	self:addElement( LightFocus )
	self.LightFocus = LightFocus
	
	local Brackets = LUI.UIImage.new( 0, 0, 0, 160, 0, 0, 0, 160 )
	Brackets:setRGB( 0.66, 0.63, 0.52 )
	Brackets:setAlpha( 0.5 )
	Brackets:setImage( RegisterImage( @"uie_ui_menu_zombies_cac_elixir_slot_brackets" ) )
	self:addElement( Brackets )
	self.Brackets = Brackets
	
	local Brackets2 = LUI.UIImage.new( 0, 0, 0, 160, 0, 0, 0, 160 )
	Brackets2:setRGB( ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b )
	Brackets2:setAlpha( 0 )
	Brackets2:setImage( RegisterImage( @"uie_ui_menu_zombies_cac_elixir_slot_brackets" ) )
	Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
	Brackets2:setShaderVector( 0, 0.5, 0.5, 0, 0 )
	Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
	Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
	Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
	Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
	self:addElement( Brackets2 )
	self.Brackets2 = Brackets2
	
	local itemImage = LUI.UIImage.new( 0.5, 0.5, -52.5, 52.5, 0.5, 0.5, -60.5, 44.5 )
	itemImage:linkToElementModel( self, "image", true, function ( model )
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			itemImage:setImage( CoD.BaseUtility.AlreadyRegistered( f2_local0 ) )
		end
	end )
	self:addElement( itemImage )
	self.itemImage = itemImage
	
	local EquippedMarkerTick = LUI.UIImage.new( 1, 1, -46, -2, 0, 0, 9, 53 )
	EquippedMarkerTick:setAlpha( 0 )
	EquippedMarkerTick:setZoom( 4 )
	EquippedMarkerTick:setImage( RegisterImage( @"uie_ui_menu_cac_equipped_marker_tick" ) )
	self:addElement( EquippedMarkerTick )
	self.EquippedMarkerTick = EquippedMarkerTick
	
	local ConsumableCounter = CoD.BGBListItem_ConsumableCounter.new( f1_arg0, f1_arg1, 0, 0, 14, 52, 0, 0, 17, 55 )
	ConsumableCounter:mergeStateConditions( {
		{
			stateName = "Hidden",
			condition = function ( menu, element, event )
				return not CoD.CACUtility.IsCACItemConsumable( menu, element, Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"] )
			end
		},
		{
			stateName = "NoConsumablesRemaining",
			condition = function ( menu, element, event )
				return not CoD.CACUtility.DoesCACItemHaveConsumablesRemaining( menu, element, f1_arg1, Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"] )
			end
		}
	} )
	ConsumableCounter:linkToElementModel( ConsumableCounter, "itemIndex", true, function ( model )
		f1_arg0:updateElementState( ConsumableCounter, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex"
		} )
	end )
	ConsumableCounter:linkToElementModel( self, "itemIndex", true, function ( model )
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ConsumableCounter.ElixirCount:setText( CoD.CACUtility.GetConsumableCountFromIndex( f1_arg1, f1_arg0, Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], f6_local0 ) )
		end
	end )
	self:addElement( ConsumableCounter )
	self.ConsumableCounter = ConsumableCounter
	
	local Outline = LUI.UIImage.new( 0, 0, 0, 160, 0, 0, 0, 160 )
	Outline:setRGB( 1, 0, 0 )
	Outline:setAlpha( 0 )
	Outline:setImage( RegisterImage( @"uie_ui_menu_zombies_cac_elixir_slot_outline" ) )
	self:addElement( Outline )
	self.Outline = Outline

	local OutlineR = LUI.UIImage.new( 0, 0, -5, 165, 0, 0, -5, 165 )
	OutlineR:setRGB( 0, 0.35, 1 )
	OutlineR:setAlpha( 0 )
	OutlineR:setImage( RegisterImage( @"uie_ui_menu_zombies_cac_elixir_slot_outline" ) )
	self:addElement( OutlineR )
	self.OutlineR = OutlineR
	
	local Corners = LUI.UIImage.new( 0, 0, 0, 160, 0, 0, 0, 160 )
	Corners:setRGB( 1, 0, 0 )
	Corners:setScale( 0.99, 0.99 )
	Corners:setImage( RegisterImage( @"uie_ui_menu_zombies_cac_elixir_slot_corners" ) )
	self:addElement( Corners )
	self.Corners = Corners
	
	local Dots = LUI.UIImage.new( 0, 0, 0, 160, 0, 0, 0, 160 )
	Dots:setRGB( 0.47, 0.15, 0.15 )
	Dots:setAlpha( 0.3 )
	Dots:setImage( RegisterImage( @"uie_ui_menu_zombies_cac_elixir_slot_dots" ) )
	self:addElement( Dots )
	self.Dots = Dots
	
	local LockedIcon = LUI.UIImage.new( 0.5, 0.5, -16, 16, 0.5, 0.5, -24, 8 )
	LockedIcon:setAlpha( 0 )
	LockedIcon:setImage( RegisterImage( @"uie_icon_locks_lock_01" ) )
	self:addElement( LockedIcon )
	self.LockedIcon = LockedIcon
	
	local itemName = LUI.UIText.new( 0.5, 0.5, -69.5, 70.5, 1, 1, -33, -17 )
	itemName:setRGB( 0.58, 0.58, 0.58 )
	itemName:setTTF( "ttmussels_demibold" )
	itemName:setLetterSpacing( 1.1 )
	itemName:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
	itemName:setAlignment( Enum[@"luialignment"][@"lui_alignment_bottom"] )
	itemName:setBackingType( 2 )
	itemName:setBackingColor( 0, 0, 0 )
	itemName:setBackingAlpha( 0.8 )
	itemName:setBackingXPadding( 3 )
	itemName:linkToElementModel( self, "displayName", true, function ( model )
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			itemName:setText( Engine[@"hash_4F9F1239CFD921FE"]( f7_local0 ) )
		end
	end )
	self:addElement( itemName )
	self.itemName = itemName
	
	Box:linkToElementModel( self, "IsClassicMoifier", true, function ( model )
		local f7_local0 = model:get()
		if f7_local0 ~= nil and f7_local0 == true then
			OutlineR:setAlpha( 1 )
			self.IsModifer = true
		else
			OutlineR:setAlpha( 0 )
			self.IsModifer = false
		end
	end )
	
	local CommonButtonOutline = CoD.CommonButtonOutline.new( f1_arg0, f1_arg1, 0, 1, 7.5, -6.5, 0, 1, 13, -11 )
	CommonButtonOutline.Lines:setAlpha( 0 )
	self:addElement( CommonButtonOutline )
	self.CommonButtonOutline = CommonButtonOutline
	
	local RestrictionIcon = CoD.RestrictedItemWarning.new( f1_arg0, f1_arg1, 0.5, 0.5, -30, 30, 0.5, 0.5, -29, 21 )
	RestrictionIcon:linkToElementModel( self, nil, false, function ( model )
		RestrictionIcon:setModel( model, f1_arg1 )
	end )
	self:addElement( RestrictionIcon )
	self.RestrictionIcon = RestrictionIcon
	
	CommonButtonOutline.id = "CommonButtonOutline"
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.ZMElixirSlotInternalCustom.__resetProperties = function ( f9_arg0 )
	f9_arg0.Box:completeAnimation()
	f9_arg0.Brackets2:completeAnimation()
	f9_arg0.Corners:completeAnimation()
	f9_arg0.itemImage:completeAnimation()
	f9_arg0.Brackets:completeAnimation()
	f9_arg0.LightFocus:completeAnimation()
	f9_arg0.Outline:completeAnimation()

	if f9_arg0.IsModifer ~= nil and f9_arg0.IsModifer == true then
		f9_arg0.OutlineR:setAlpha(1)
	else
		f9_arg0.OutlineR:setAlpha(0)
	end
	
	f9_arg0.itemName:completeAnimation()
	f9_arg0.Dots:completeAnimation()
	f9_arg0.LockedIcon:completeAnimation()
	f9_arg0.ConsumableCounter:completeAnimation()
	f9_arg0.EquippedMarkerTick:completeAnimation()
	f9_arg0.Box:setRGB( 1, 1, 1 )
	f9_arg0.Brackets2:setAlpha( 0 )
	f9_arg0.Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
	f9_arg0.Brackets2:setShaderVector( 0, 0.5, 0.5, 0, 0 )
	f9_arg0.Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
	f9_arg0.Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
	f9_arg0.Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
	f9_arg0.Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
	f9_arg0.Corners:setAlpha( 1 )
	f9_arg0.Corners:setScale( 0.99, 0.99 )
	f9_arg0.itemImage:setLeftRight( 0.5, 0.5, -52.5, 52.5 )
	f9_arg0.itemImage:setTopBottom( 0.5, 0.5, -60.5, 44.5 )
	f9_arg0.itemImage:setRGB( 1, 1, 1 )
	f9_arg0.itemImage:setAlpha( 1 )
	f9_arg0.Brackets:setRGB( 0.66, 0.63, 0.52 )
	f9_arg0.Brackets:setAlpha( 0.5 )
	f9_arg0.LightFocus:setRGB( 1, 0, 0 )
	f9_arg0.LightFocus:setAlpha( 0 )
	f9_arg0.Outline:setAlpha( 0 )
	f9_arg0.itemName:setRGB( 0.58, 0.58, 0.58 )
	f9_arg0.Dots:setRGB( 0.47, 0.15, 0.15 )
	f9_arg0.Dots:setAlpha( 0.3 )
	f9_arg0.LockedIcon:setAlpha( 0 )
	f9_arg0.ConsumableCounter:setRGB( 1, 1, 1 )
	f9_arg0.EquippedMarkerTick:setAlpha( 0 )
end

CoD.ZMElixirSlotInternalCustom.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f10_arg0, f10_arg1 )
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter( 4 )
			f10_arg0.Box:completeAnimation()
			f10_arg0.Box:setRGB( 1, 1, 1 )
			f10_arg0.clipFinished( f10_arg0.Box )
			f10_arg0.Brackets2:completeAnimation()
			f10_arg0.Brackets2:setAlpha( 0 )
			f10_arg0.clipFinished( f10_arg0.Brackets2 )
			f10_arg0.itemImage:completeAnimation()
			f10_arg0.itemImage:setLeftRight( 0.5, 0.5, -52.5, 52.5 )
			f10_arg0.clipFinished( f10_arg0.itemImage )
			f10_arg0.Corners:completeAnimation()
			f10_arg0.Corners:setAlpha( 0 )
			f10_arg0.clipFinished( f10_arg0.Corners )
		end,
		ChildFocus = function ( f11_arg0, f11_arg1 )
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter( 8 )
			f11_arg0.Box:completeAnimation()
			f11_arg0.Box:setRGB( 1, 1, 1 )
			f11_arg0.clipFinished( f11_arg0.Box )
			f11_arg0.LightFocus:completeAnimation()
			f11_arg0.LightFocus:setAlpha( 0.1 )
			f11_arg0.clipFinished( f11_arg0.LightFocus )
			f11_arg0.Brackets:completeAnimation()
			f11_arg0.Brackets:setRGB( ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b )
			f11_arg0.Brackets:setAlpha( 1 )
			f11_arg0.clipFinished( f11_arg0.Brackets )
			f11_arg0.Brackets2:completeAnimation()
			f11_arg0.Brackets2:setAlpha( 1 )
			f11_arg0.Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
			f11_arg0.Brackets2:setShaderVector( 0, 1, 0, 0, 0 )
			f11_arg0.Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
			f11_arg0.Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
			f11_arg0.Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
			f11_arg0.Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
			f11_arg0.clipFinished( f11_arg0.Brackets2 )
			f11_arg0.Outline:completeAnimation()
			f11_arg0.Outline:setAlpha( 0.2 )
			f11_arg0.clipFinished( f11_arg0.Outline )
			f11_arg0.Corners:completeAnimation()
			f11_arg0.Corners:setAlpha( 1 )
			f11_arg0.Corners:setScale( 1.02, 1.02 )
			f11_arg0.clipFinished( f11_arg0.Corners )
			f11_arg0.Dots:completeAnimation()
			f11_arg0.Dots:setRGB( 1, 0, 0 )
			f11_arg0.Dots:setAlpha( 1 )
			f11_arg0.clipFinished( f11_arg0.Dots )
			f11_arg0.itemName:completeAnimation()
			f11_arg0.itemName:setRGB( 1, 0, 0 )
			f11_arg0.clipFinished( f11_arg0.itemName )
		end,
		GainChildFocus = function ( f12_arg0, f12_arg1 )
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter( 8 )
			f12_arg0.Box:completeAnimation()
			f12_arg0.Box:setRGB( 1, 1, 1 )
			f12_arg0.clipFinished( f12_arg0.Box )
			local f12_local0 = function ( f13_arg0 )
				f12_arg0.LightFocus:beginAnimation( 200 )
				f12_arg0.LightFocus:setAlpha( 0.1 )
				f12_arg0.LightFocus:registerEventHandler( "interrupted_keyframe", f12_arg0.clipInterrupted )
				f12_arg0.LightFocus:registerEventHandler( "transition_complete_keyframe", f12_arg0.clipFinished )
			end
			
			f12_arg0.LightFocus:completeAnimation()
			f12_arg0.LightFocus:setAlpha( 0 )
			f12_local0( f12_arg0.LightFocus )
			local f12_local1 = function ( f14_arg0 )
				f12_arg0.Brackets:beginAnimation( 200 )
				f12_arg0.Brackets:setRGB( ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b )
				f12_arg0.Brackets:setAlpha( 1 )
				f12_arg0.Brackets:registerEventHandler( "interrupted_keyframe", f12_arg0.clipInterrupted )
				f12_arg0.Brackets:registerEventHandler( "transition_complete_keyframe", f12_arg0.clipFinished )
			end
			
			f12_arg0.Brackets:completeAnimation()
			f12_arg0.Brackets:setRGB( ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b )
			f12_arg0.Brackets:setAlpha( 0.5 )
			f12_local1( f12_arg0.Brackets )
			local f12_local2 = function ( f15_arg0 )
				f12_arg0.Brackets2:beginAnimation( 200 )
				f12_arg0.Brackets2:setAlpha( 1 )
				f12_arg0.Brackets2:setShaderVector( 0, 1, 0, 0, 0 )
				f12_arg0.Brackets2:registerEventHandler( "interrupted_keyframe", f12_arg0.clipInterrupted )
				f12_arg0.Brackets2:registerEventHandler( "transition_complete_keyframe", f12_arg0.clipFinished )
			end
			
			f12_arg0.Brackets2:completeAnimation()
			f12_arg0.Brackets2:setAlpha( 0 )
			f12_arg0.Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
			f12_arg0.Brackets2:setShaderVector( 0, 0.5, 0.5, 0, 0 )
			f12_arg0.Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
			f12_arg0.Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
			f12_arg0.Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
			f12_arg0.Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
			f12_local2( f12_arg0.Brackets2 )
			local f12_local3 = function ( f16_arg0 )
				f12_arg0.Outline:beginAnimation( 200 )
				f12_arg0.Outline:setAlpha( 0.2 )
				f12_arg0.Outline:registerEventHandler( "interrupted_keyframe", f12_arg0.clipInterrupted )
				f12_arg0.Outline:registerEventHandler( "transition_complete_keyframe", f12_arg0.clipFinished )
			end
			
			f12_arg0.Outline:completeAnimation()
			f12_arg0.Outline:setAlpha( 0 )
			f12_local3( f12_arg0.Outline )
			local f12_local4 = function ( f17_arg0 )
				f12_arg0.Corners:beginAnimation( 200 )
				f12_arg0.Corners:setAlpha( 1 )
				f12_arg0.Corners:setScale( 1.02, 1.02 )
				f12_arg0.Corners:registerEventHandler( "interrupted_keyframe", f12_arg0.clipInterrupted )
				f12_arg0.Corners:registerEventHandler( "transition_complete_keyframe", f12_arg0.clipFinished )
			end
			
			f12_arg0.Corners:completeAnimation()
			f12_arg0.Corners:setAlpha( 0 )
			f12_arg0.Corners:setScale( 0.99, 0.99 )
			f12_local4( f12_arg0.Corners )
			local f12_local5 = function ( f18_arg0 )
				f12_arg0.Dots:beginAnimation( 200 )
				f12_arg0.Dots:setRGB( 1, 0, 0 )
				f12_arg0.Dots:setAlpha( 1 )
				f12_arg0.Dots:registerEventHandler( "interrupted_keyframe", f12_arg0.clipInterrupted )
				f12_arg0.Dots:registerEventHandler( "transition_complete_keyframe", f12_arg0.clipFinished )
			end
			
			f12_arg0.Dots:completeAnimation()
			f12_arg0.Dots:setRGB( 0.61, 0, 0 )
			f12_arg0.Dots:setAlpha( 0.3 )
			f12_local5( f12_arg0.Dots )
			local f12_local6 = function ( f19_arg0 )
				f12_arg0.itemName:beginAnimation( 200 )
				f12_arg0.itemName:setRGB( 1, 0, 0 )
				f12_arg0.itemName:registerEventHandler( "interrupted_keyframe", f12_arg0.clipInterrupted )
				f12_arg0.itemName:registerEventHandler( "transition_complete_keyframe", f12_arg0.clipFinished )
			end
			
			f12_arg0.itemName:completeAnimation()
			f12_arg0.itemName:setRGB( 0.58, 0.58, 0.58 )
			f12_local6( f12_arg0.itemName )
		end,
		LoseChildFocus = function ( f20_arg0, f20_arg1 )
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter( 8 )
			f20_arg0.Box:completeAnimation()
			f20_arg0.Box:setRGB( 1, 1, 1 )
			f20_arg0.clipFinished( f20_arg0.Box )
			local f20_local0 = function ( f21_arg0 )
				f20_arg0.LightFocus:beginAnimation( 200 )
				f20_arg0.LightFocus:setAlpha( 0 )
				f20_arg0.LightFocus:registerEventHandler( "interrupted_keyframe", f20_arg0.clipInterrupted )
				f20_arg0.LightFocus:registerEventHandler( "transition_complete_keyframe", f20_arg0.clipFinished )
			end
			
			f20_arg0.LightFocus:completeAnimation()
			f20_arg0.LightFocus:setAlpha( 0.1 )
			f20_local0( f20_arg0.LightFocus )
			local f20_local1 = function ( f22_arg0 )
				f20_arg0.Brackets:beginAnimation( 200 )
				f20_arg0.Brackets:setRGB( ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b )
				f20_arg0.Brackets:setAlpha( 0.5 )
				f20_arg0.Brackets:registerEventHandler( "interrupted_keyframe", f20_arg0.clipInterrupted )
				f20_arg0.Brackets:registerEventHandler( "transition_complete_keyframe", f20_arg0.clipFinished )
			end
			
			f20_arg0.Brackets:completeAnimation()
			f20_arg0.Brackets:setRGB( ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b )
			f20_arg0.Brackets:setAlpha( 1 )
			f20_local1( f20_arg0.Brackets )
			local f20_local2 = function ( f23_arg0 )
				f20_arg0.Brackets2:beginAnimation( 200 )
				f20_arg0.Brackets2:setAlpha( 0 )
				f20_arg0.Brackets2:setShaderVector( 0, 0.5, 0.5, 0, 0 )
				f20_arg0.Brackets2:registerEventHandler( "interrupted_keyframe", f20_arg0.clipInterrupted )
				f20_arg0.Brackets2:registerEventHandler( "transition_complete_keyframe", f20_arg0.clipFinished )
			end
			
			f20_arg0.Brackets2:completeAnimation()
			f20_arg0.Brackets2:setAlpha( 1 )
			f20_arg0.Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
			f20_arg0.Brackets2:setShaderVector( 0, 1, 0, 0, 0 )
			f20_arg0.Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
			f20_arg0.Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
			f20_arg0.Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
			f20_arg0.Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
			f20_local2( f20_arg0.Brackets2 )
			local f20_local3 = function ( f24_arg0 )
				f20_arg0.Outline:beginAnimation( 200 )
				f20_arg0.Outline:setAlpha( 0 )
				f20_arg0.Outline:registerEventHandler( "interrupted_keyframe", f20_arg0.clipInterrupted )
				f20_arg0.Outline:registerEventHandler( "transition_complete_keyframe", f20_arg0.clipFinished )
			end
			
			f20_arg0.Outline:completeAnimation()
			f20_arg0.Outline:setAlpha( 0.2 )
			f20_local3( f20_arg0.Outline )
			local f20_local4 = function ( f25_arg0 )
				f20_arg0.Corners:beginAnimation( 200 )
				f20_arg0.Corners:setAlpha( 0 )
				f20_arg0.Corners:setScale( 0.99, 0.99 )
				f20_arg0.Corners:registerEventHandler( "interrupted_keyframe", f20_arg0.clipInterrupted )
				f20_arg0.Corners:registerEventHandler( "transition_complete_keyframe", f20_arg0.clipFinished )
			end
			
			f20_arg0.Corners:completeAnimation()
			f20_arg0.Corners:setAlpha( 1 )
			f20_arg0.Corners:setScale( 1.02, 1.02 )
			f20_local4( f20_arg0.Corners )
			local f20_local5 = function ( f26_arg0 )
				f20_arg0.Dots:beginAnimation( 200 )
				f20_arg0.Dots:setRGB( 0.61, 0, 0 )
				f20_arg0.Dots:setAlpha( 0.3 )
				f20_arg0.Dots:registerEventHandler( "interrupted_keyframe", f20_arg0.clipInterrupted )
				f20_arg0.Dots:registerEventHandler( "transition_complete_keyframe", f20_arg0.clipFinished )
			end
			
			f20_arg0.Dots:completeAnimation()
			f20_arg0.Dots:setRGB( 1, 0, 0 )
			f20_arg0.Dots:setAlpha( 1 )
			f20_local5( f20_arg0.Dots )
			local f20_local6 = function ( f27_arg0 )
				f20_arg0.itemName:beginAnimation( 200 )
				f20_arg0.itemName:setRGB( 0.58, 0.58, 0.58 )
				f20_arg0.itemName:registerEventHandler( "interrupted_keyframe", f20_arg0.clipInterrupted )
				f20_arg0.itemName:registerEventHandler( "transition_complete_keyframe", f20_arg0.clipFinished )
			end
			
			f20_arg0.itemName:completeAnimation()
			f20_arg0.itemName:setRGB( 1, 0, 0 )
			f20_local6( f20_arg0.itemName )
		end
	},
	Locked = {
		DefaultClip = function ( f28_arg0, f28_arg1 )
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter( 5 )
			f28_arg0.Box:completeAnimation()
			f28_arg0.Box:setRGB( 0, 0, 0 )
			f28_arg0.clipFinished( f28_arg0.Box )
			f28_arg0.itemImage:completeAnimation()
			f28_arg0.itemImage:setLeftRight( 0.5, 0.5, -52.5, 52.5 )
			f28_arg0.itemImage:setTopBottom( 0.5, 0.5, -60.5, 44.5 )
			f28_arg0.itemImage:setRGB( 0.5, 0.5, 0.5 )
			f28_arg0.itemImage:setAlpha( 0 )
			f28_arg0.clipFinished( f28_arg0.itemImage )
			f28_arg0.Corners:completeAnimation()
			f28_arg0.Corners:setAlpha( 0 )
			f28_arg0.clipFinished( f28_arg0.Corners )
			f28_arg0.LockedIcon:completeAnimation()
			f28_arg0.LockedIcon:setAlpha( 0.33 )
			f28_arg0.clipFinished( f28_arg0.LockedIcon )
			f28_arg0.itemName:completeAnimation()
			f28_arg0.itemName:setRGB( 0.58, 0.58, 0.58 )
			f28_arg0.clipFinished( f28_arg0.itemName )
		end,
		ChildFocus = function ( f29_arg0, f29_arg1 )
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter( 10 )
			f29_arg0.Box:completeAnimation()
			f29_arg0.Box:setRGB( 1, 1, 1 )
			f29_arg0.clipFinished( f29_arg0.Box )
			f29_arg0.LightFocus:completeAnimation()
			f29_arg0.LightFocus:setAlpha( 0.1 )
			f29_arg0.clipFinished( f29_arg0.LightFocus )
			f29_arg0.Brackets:completeAnimation()
			f29_arg0.Brackets:setRGB( ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b )
			f29_arg0.Brackets:setAlpha( 1 )
			f29_arg0.clipFinished( f29_arg0.Brackets )
			f29_arg0.Brackets2:completeAnimation()
			f29_arg0.Brackets2:setAlpha( 1 )
			f29_arg0.Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
			f29_arg0.Brackets2:setShaderVector( 0, 1, 0, 0, 0 )
			f29_arg0.Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
			f29_arg0.Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
			f29_arg0.Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
			f29_arg0.Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
			f29_arg0.clipFinished( f29_arg0.Brackets2 )
			f29_arg0.itemImage:completeAnimation()
			f29_arg0.itemImage:setAlpha( 0 )
			f29_arg0.clipFinished( f29_arg0.itemImage )
			f29_arg0.Outline:completeAnimation()
			f29_arg0.Outline:setAlpha( 0.2 )
			f29_arg0.clipFinished( f29_arg0.Outline )
			f29_arg0.Corners:completeAnimation()
			f29_arg0.Corners:setAlpha( 1 )
			f29_arg0.Corners:setScale( 1.02, 1.02 )
			f29_arg0.clipFinished( f29_arg0.Corners )
			f29_arg0.Dots:completeAnimation()
			f29_arg0.Dots:setRGB( 1, 0, 0 )
			f29_arg0.Dots:setAlpha( 1 )
			f29_arg0.clipFinished( f29_arg0.Dots )
			f29_arg0.LockedIcon:completeAnimation()
			f29_arg0.LockedIcon:setAlpha( 0.75 )
			f29_arg0.clipFinished( f29_arg0.LockedIcon )
			f29_arg0.itemName:completeAnimation()
			f29_arg0.itemName:setRGB( 1, 0, 0 )
			f29_arg0.clipFinished( f29_arg0.itemName )
		end,
		GainChildFocus = function ( f30_arg0, f30_arg1 )
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter( 10 )
			local f30_local0 = function ( f31_arg0 )
				f30_arg0.Box:beginAnimation( 200 )
				f30_arg0.Box:setRGB( 1, 1, 1 )
				f30_arg0.Box:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
				f30_arg0.Box:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
			end
			
			f30_arg0.Box:completeAnimation()
			f30_arg0.Box:setRGB( 0, 0, 0 )
			f30_local0( f30_arg0.Box )
			local f30_local1 = function ( f32_arg0 )
				f30_arg0.LightFocus:beginAnimation( 200 )
				f30_arg0.LightFocus:setAlpha( 0.1 )
				f30_arg0.LightFocus:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
				f30_arg0.LightFocus:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
			end
			
			f30_arg0.LightFocus:completeAnimation()
			f30_arg0.LightFocus:setAlpha( 0 )
			f30_local1( f30_arg0.LightFocus )
			local f30_local2 = function ( f33_arg0 )
				f30_arg0.Brackets:beginAnimation( 200 )
				f30_arg0.Brackets:setRGB( ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b )
				f30_arg0.Brackets:setAlpha( 1 )
				f30_arg0.Brackets:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
				f30_arg0.Brackets:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
			end
			
			f30_arg0.Brackets:completeAnimation()
			f30_arg0.Brackets:setRGB( 0.66, 0.63, 0.52 )
			f30_arg0.Brackets:setAlpha( 0.5 )
			f30_local2( f30_arg0.Brackets )
			local f30_local3 = function ( f34_arg0 )
				f30_arg0.Brackets2:beginAnimation( 200 )
				f30_arg0.Brackets2:setAlpha( 1 )
				f30_arg0.Brackets2:setShaderVector( 0, 1, 0, 0, 0 )
				f30_arg0.Brackets2:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
				f30_arg0.Brackets2:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
			end
			
			f30_arg0.Brackets2:completeAnimation()
			f30_arg0.Brackets2:setAlpha( 0 )
			f30_arg0.Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
			f30_arg0.Brackets2:setShaderVector( 0, 0.5, 0.5, 0, 0 )
			f30_arg0.Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
			f30_arg0.Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
			f30_arg0.Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
			f30_arg0.Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
			f30_local3( f30_arg0.Brackets2 )
			local f30_local4 = function ( f35_arg0 )
				f30_arg0.itemImage:beginAnimation( 200 )
				f30_arg0.itemImage:setRGB( 1, 1, 1 )
				f30_arg0.itemImage:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
				f30_arg0.itemImage:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
			end
			
			f30_arg0.itemImage:completeAnimation()
			f30_arg0.itemImage:setLeftRight( 0.5, 0.5, -52.5, 52.5 )
			f30_arg0.itemImage:setTopBottom( 0.5, 0.5, -60.5, 44.5 )
			f30_arg0.itemImage:setRGB( 0.5, 0.5, 0.5 )
			f30_arg0.itemImage:setAlpha( 0 )
			f30_local4( f30_arg0.itemImage )
			local f30_local5 = function ( f36_arg0 )
				f30_arg0.Outline:beginAnimation( 200 )
				f30_arg0.Outline:setAlpha( 0.2 )
				f30_arg0.Outline:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
				f30_arg0.Outline:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
			end
			
			f30_arg0.Outline:completeAnimation()
			f30_arg0.Outline:setAlpha( 0 )
			f30_local5( f30_arg0.Outline )
			local f30_local6 = function ( f37_arg0 )
				f30_arg0.Corners:beginAnimation( 200 )
				f30_arg0.Corners:setAlpha( 1 )
				f30_arg0.Corners:setScale( 1.02, 1.02 )
				f30_arg0.Corners:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
				f30_arg0.Corners:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
			end
			
			f30_arg0.Corners:completeAnimation()
			f30_arg0.Corners:setAlpha( 0 )
			f30_arg0.Corners:setScale( 0.99, 0.99 )
			f30_local6( f30_arg0.Corners )
			local f30_local7 = function ( f38_arg0 )
				f30_arg0.Dots:beginAnimation( 200 )
				f30_arg0.Dots:setRGB( 1, 0, 0 )
				f30_arg0.Dots:setAlpha( 1 )
				f30_arg0.Dots:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
				f30_arg0.Dots:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
			end
			
			f30_arg0.Dots:completeAnimation()
			f30_arg0.Dots:setRGB( 0.47, 0.15, 0.15 )
			f30_arg0.Dots:setAlpha( 0.3 )
			f30_local7( f30_arg0.Dots )
			local f30_local8 = function ( f39_arg0 )
				f30_arg0.LockedIcon:beginAnimation( 200 )
				f30_arg0.LockedIcon:setAlpha( 0.75 )
				f30_arg0.LockedIcon:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
				f30_arg0.LockedIcon:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
			end
			
			f30_arg0.LockedIcon:completeAnimation()
			f30_arg0.LockedIcon:setAlpha( 0.33 )
			f30_local8( f30_arg0.LockedIcon )
			local f30_local9 = function ( f40_arg0 )
				f30_arg0.itemName:beginAnimation( 200 )
				f30_arg0.itemName:setRGB( 1, 0, 0 )
				f30_arg0.itemName:registerEventHandler( "interrupted_keyframe", f30_arg0.clipInterrupted )
				f30_arg0.itemName:registerEventHandler( "transition_complete_keyframe", f30_arg0.clipFinished )
			end
			
			f30_arg0.itemName:completeAnimation()
			f30_arg0.itemName:setRGB( 0.58, 0.58, 0.58 )
			f30_local9( f30_arg0.itemName )
		end,
		LoseChildFocus = function ( f41_arg0, f41_arg1 )
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter( 10 )
			local f41_local0 = function ( f42_arg0 )
				f41_arg0.Box:beginAnimation( 200 )
				f41_arg0.Box:setRGB( 0, 0, 0 )
				f41_arg0.Box:registerEventHandler( "interrupted_keyframe", f41_arg0.clipInterrupted )
				f41_arg0.Box:registerEventHandler( "transition_complete_keyframe", f41_arg0.clipFinished )
			end
			
			f41_arg0.Box:completeAnimation()
			f41_arg0.Box:setRGB( 1, 1, 1 )
			f41_local0( f41_arg0.Box )
			local f41_local1 = function ( f43_arg0 )
				f41_arg0.LightFocus:beginAnimation( 200 )
				f41_arg0.LightFocus:setAlpha( 0 )
				f41_arg0.LightFocus:registerEventHandler( "interrupted_keyframe", f41_arg0.clipInterrupted )
				f41_arg0.LightFocus:registerEventHandler( "transition_complete_keyframe", f41_arg0.clipFinished )
			end
			
			f41_arg0.LightFocus:completeAnimation()
			f41_arg0.LightFocus:setAlpha( 0.1 )
			f41_local1( f41_arg0.LightFocus )
			local f41_local2 = function ( f44_arg0 )
				f41_arg0.Brackets:beginAnimation( 200 )
				f41_arg0.Brackets:setRGB( 0.66, 0.63, 0.52 )
				f41_arg0.Brackets:setAlpha( 0.5 )
				f41_arg0.Brackets:registerEventHandler( "interrupted_keyframe", f41_arg0.clipInterrupted )
				f41_arg0.Brackets:registerEventHandler( "transition_complete_keyframe", f41_arg0.clipFinished )
			end
			
			f41_arg0.Brackets:completeAnimation()
			f41_arg0.Brackets:setRGB( ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b )
			f41_arg0.Brackets:setAlpha( 1 )
			f41_local2( f41_arg0.Brackets )
			local f41_local3 = function ( f45_arg0 )
				f41_arg0.Brackets2:beginAnimation( 200 )
				f41_arg0.Brackets2:setAlpha( 0 )
				f41_arg0.Brackets2:setShaderVector( 0, 0.5, 0.5, 0, 0 )
				f41_arg0.Brackets2:registerEventHandler( "interrupted_keyframe", f41_arg0.clipInterrupted )
				f41_arg0.Brackets2:registerEventHandler( "transition_complete_keyframe", f41_arg0.clipFinished )
			end
			
			f41_arg0.Brackets2:completeAnimation()
			f41_arg0.Brackets2:setAlpha( 1 )
			f41_arg0.Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
			f41_arg0.Brackets2:setShaderVector( 0, 1, 0, 0, 0 )
			f41_arg0.Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
			f41_arg0.Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
			f41_arg0.Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
			f41_arg0.Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
			f41_local3( f41_arg0.Brackets2 )
			local f41_local4 = function ( f46_arg0 )
				f41_arg0.itemImage:beginAnimation( 200 )
				f41_arg0.itemImage:setRGB( 0.5, 0.5, 0.5 )
				f41_arg0.itemImage:registerEventHandler( "interrupted_keyframe", f41_arg0.clipInterrupted )
				f41_arg0.itemImage:registerEventHandler( "transition_complete_keyframe", f41_arg0.clipFinished )
			end
			
			f41_arg0.itemImage:completeAnimation()
			f41_arg0.itemImage:setLeftRight( 0.5, 0.5, -52.5, 52.5 )
			f41_arg0.itemImage:setTopBottom( 0.5, 0.5, -60.5, 44.5 )
			f41_arg0.itemImage:setRGB( 1, 1, 1 )
			f41_arg0.itemImage:setAlpha( 0 )
			f41_local4( f41_arg0.itemImage )
			local f41_local5 = function ( f47_arg0 )
				f41_arg0.Outline:beginAnimation( 200 )
				f41_arg0.Outline:setAlpha( 0 )
				f41_arg0.Outline:registerEventHandler( "interrupted_keyframe", f41_arg0.clipInterrupted )
				f41_arg0.Outline:registerEventHandler( "transition_complete_keyframe", f41_arg0.clipFinished )
			end
			
			f41_arg0.Outline:completeAnimation()
			f41_arg0.Outline:setAlpha( 0.2 )
			f41_local5( f41_arg0.Outline )
			local f41_local6 = function ( f48_arg0 )
				f41_arg0.Corners:beginAnimation( 200 )
				f41_arg0.Corners:setAlpha( 0 )
				f41_arg0.Corners:setScale( 0.99, 0.99 )
				f41_arg0.Corners:registerEventHandler( "interrupted_keyframe", f41_arg0.clipInterrupted )
				f41_arg0.Corners:registerEventHandler( "transition_complete_keyframe", f41_arg0.clipFinished )
			end
			
			f41_arg0.Corners:completeAnimation()
			f41_arg0.Corners:setAlpha( 1 )
			f41_arg0.Corners:setScale( 1.02, 1.02 )
			f41_local6( f41_arg0.Corners )
			local f41_local7 = function ( f49_arg0 )
				f41_arg0.Dots:beginAnimation( 200 )
				f41_arg0.Dots:setRGB( 0.47, 0.15, 0.15 )
				f41_arg0.Dots:setAlpha( 0.3 )
				f41_arg0.Dots:registerEventHandler( "interrupted_keyframe", f41_arg0.clipInterrupted )
				f41_arg0.Dots:registerEventHandler( "transition_complete_keyframe", f41_arg0.clipFinished )
			end
			
			f41_arg0.Dots:completeAnimation()
			f41_arg0.Dots:setRGB( 1, 0, 0 )
			f41_arg0.Dots:setAlpha( 1 )
			f41_local7( f41_arg0.Dots )
			local f41_local8 = function ( f50_arg0 )
				f41_arg0.LockedIcon:beginAnimation( 200 )
				f41_arg0.LockedIcon:setAlpha( 0.33 )
				f41_arg0.LockedIcon:registerEventHandler( "interrupted_keyframe", f41_arg0.clipInterrupted )
				f41_arg0.LockedIcon:registerEventHandler( "transition_complete_keyframe", f41_arg0.clipFinished )
			end
			
			f41_arg0.LockedIcon:completeAnimation()
			f41_arg0.LockedIcon:setAlpha( 0.75 )
			f41_local8( f41_arg0.LockedIcon )
			local f41_local9 = function ( f51_arg0 )
				f41_arg0.itemName:beginAnimation( 200 )
				f41_arg0.itemName:setRGB( 0.58, 0.58, 0.58 )
				f41_arg0.itemName:registerEventHandler( "interrupted_keyframe", f41_arg0.clipInterrupted )
				f41_arg0.itemName:registerEventHandler( "transition_complete_keyframe", f41_arg0.clipFinished )
			end
			
			f41_arg0.itemName:completeAnimation()
			f41_arg0.itemName:setRGB( 1, 0, 0 )
			f41_local9( f41_arg0.itemName )
		end
	},
	NoConsumablesRemainingEquipped = {
		DefaultClip = function ( f52_arg0, f52_arg1 )
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter( 7 )
			f52_arg0.Box:completeAnimation()
			f52_arg0.Box:setRGB( 0.59, 0.59, 0.59 )
			f52_arg0.clipFinished( f52_arg0.Box )
			f52_arg0.Brackets:completeAnimation()
			f52_arg0.Brackets:setRGB( 0.23, 0.23, 0.23 )
			f52_arg0.clipFinished( f52_arg0.Brackets )
			f52_arg0.itemImage:completeAnimation()
			f52_arg0.itemImage:setLeftRight( 0.5, 0.5, -52.5, 52.5 )
			f52_arg0.itemImage:setRGB( 0.39, 0.39, 0.39 )
			f52_arg0.clipFinished( f52_arg0.itemImage )
			f52_arg0.EquippedMarkerTick:completeAnimation()
			f52_arg0.EquippedMarkerTick:setAlpha( 1 )
			f52_arg0.clipFinished( f52_arg0.EquippedMarkerTick )
			f52_arg0.ConsumableCounter:completeAnimation()
			f52_arg0.ConsumableCounter:setRGB( 0.79, 0, 0 )
			f52_arg0.clipFinished( f52_arg0.ConsumableCounter )
			f52_arg0.Corners:completeAnimation()
			f52_arg0.Corners:setAlpha( 0 )
			f52_arg0.clipFinished( f52_arg0.Corners )
			f52_arg0.itemName:completeAnimation()
			f52_arg0.itemName:setRGB( 0.39, 0.39, 0.39 )
			f52_arg0.clipFinished( f52_arg0.itemName )
		end,
		ChildFocus = function ( f53_arg0, f53_arg1 )
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter( 9 )
			f53_arg0.Box:completeAnimation()
			f53_arg0.Box:setRGB( 0.45, 0.31, 0.33 )
			f53_arg0.clipFinished( f53_arg0.Box )
			f53_arg0.LightFocus:completeAnimation()
			f53_arg0.LightFocus:setRGB( 1, 0, 0 )
			f53_arg0.LightFocus:setAlpha( 0.1 )
			f53_arg0.clipFinished( f53_arg0.LightFocus )
			f53_arg0.Brackets2:completeAnimation()
			f53_arg0.Brackets2:setAlpha( 1 )
			f53_arg0.Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
			f53_arg0.Brackets2:setShaderVector( 0, 1, 0, 0, 0 )
			f53_arg0.Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
			f53_arg0.Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
			f53_arg0.Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
			f53_arg0.Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
			f53_arg0.clipFinished( f53_arg0.Brackets2 )
			f53_arg0.itemImage:completeAnimation()
			f53_arg0.itemImage:setRGB( 0.49, 0.49, 0.49 )
			f53_arg0.clipFinished( f53_arg0.itemImage )
			f53_arg0.EquippedMarkerTick:completeAnimation()
			f53_arg0.EquippedMarkerTick:setAlpha( 1 )
			f53_arg0.clipFinished( f53_arg0.EquippedMarkerTick )
			f53_arg0.ConsumableCounter:completeAnimation()
			f53_arg0.ConsumableCounter:setRGB( 1, 0, 0 )
			f53_arg0.clipFinished( f53_arg0.ConsumableCounter )
			f53_arg0.Outline:completeAnimation()
			f53_arg0.Outline:setAlpha( 0.2 )
			f53_arg0.clipFinished( f53_arg0.Outline )
			f53_arg0.Corners:completeAnimation()
			f53_arg0.Corners:setScale( 1.02, 1.02 )
			f53_arg0.clipFinished( f53_arg0.Corners )
			f53_arg0.itemName:completeAnimation()
			f53_arg0.itemName:setRGB( 1, 0, 0 )
			f53_arg0.clipFinished( f53_arg0.itemName )
		end,
		GainChildFocus = function ( f54_arg0, f54_arg1 )
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter( 9 )
			local f54_local0 = function ( f55_arg0 )
				f54_arg0.Box:beginAnimation( 200 )
				f54_arg0.Box:setRGB( 0.45, 0.31, 0.33 )
				f54_arg0.Box:registerEventHandler( "interrupted_keyframe", f54_arg0.clipInterrupted )
				f54_arg0.Box:registerEventHandler( "transition_complete_keyframe", f54_arg0.clipFinished )
			end
			
			f54_arg0.Box:completeAnimation()
			f54_arg0.Box:setRGB( 1, 1, 1 )
			f54_local0( f54_arg0.Box )
			local f54_local1 = function ( f56_arg0 )
				f54_arg0.LightFocus:beginAnimation( 200 )
				f54_arg0.LightFocus:setAlpha( 0.1 )
				f54_arg0.LightFocus:registerEventHandler( "interrupted_keyframe", f54_arg0.clipInterrupted )
				f54_arg0.LightFocus:registerEventHandler( "transition_complete_keyframe", f54_arg0.clipFinished )
			end
			
			f54_arg0.LightFocus:completeAnimation()
			f54_arg0.LightFocus:setAlpha( 0 )
			f54_local1( f54_arg0.LightFocus )
			local f54_local2 = function ( f57_arg0 )
				f54_arg0.Brackets2:beginAnimation( 200 )
				f54_arg0.Brackets2:setAlpha( 1 )
				f54_arg0.Brackets2:setShaderVector( 0, 1, 0, 0, 0 )
				f54_arg0.Brackets2:registerEventHandler( "interrupted_keyframe", f54_arg0.clipInterrupted )
				f54_arg0.Brackets2:registerEventHandler( "transition_complete_keyframe", f54_arg0.clipFinished )
			end
			
			f54_arg0.Brackets2:completeAnimation()
			f54_arg0.Brackets2:setAlpha( 0 )
			f54_arg0.Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
			f54_arg0.Brackets2:setShaderVector( 0, 0.5, 0.5, 0, 0 )
			f54_arg0.Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
			f54_arg0.Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
			f54_arg0.Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
			f54_arg0.Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
			f54_local2( f54_arg0.Brackets2 )
			local f54_local3 = function ( f58_arg0 )
				f54_arg0.itemImage:beginAnimation( 200 )
				f54_arg0.itemImage:setRGB( 0.49, 0.49, 0.49 )
				f54_arg0.itemImage:registerEventHandler( "interrupted_keyframe", f54_arg0.clipInterrupted )
				f54_arg0.itemImage:registerEventHandler( "transition_complete_keyframe", f54_arg0.clipFinished )
			end
			
			f54_arg0.itemImage:completeAnimation()
			f54_arg0.itemImage:setRGB( 0.39, 0.39, 0.39 )
			f54_local3( f54_arg0.itemImage )
			f54_arg0.EquippedMarkerTick:completeAnimation()
			f54_arg0.EquippedMarkerTick:setAlpha( 1 )
			f54_arg0.clipFinished( f54_arg0.EquippedMarkerTick )
			f54_arg0.ConsumableCounter:completeAnimation()
			f54_arg0.ConsumableCounter:setRGB( 1, 0, 0 )
			f54_arg0.clipFinished( f54_arg0.ConsumableCounter )
			local f54_local4 = function ( f59_arg0 )
				f54_arg0.Outline:beginAnimation( 200 )
				f54_arg0.Outline:setAlpha( 0.2 )
				f54_arg0.Outline:registerEventHandler( "interrupted_keyframe", f54_arg0.clipInterrupted )
				f54_arg0.Outline:registerEventHandler( "transition_complete_keyframe", f54_arg0.clipFinished )
			end
			
			f54_arg0.Outline:completeAnimation()
			f54_arg0.Outline:setAlpha( 0 )
			f54_local4( f54_arg0.Outline )
			local f54_local5 = function ( f60_arg0 )
				f54_arg0.Corners:beginAnimation( 200 )
				f54_arg0.Corners:setAlpha( 1 )
				f54_arg0.Corners:setScale( 1.02, 1.02 )
				f54_arg0.Corners:registerEventHandler( "interrupted_keyframe", f54_arg0.clipInterrupted )
				f54_arg0.Corners:registerEventHandler( "transition_complete_keyframe", f54_arg0.clipFinished )
			end
			
			f54_arg0.Corners:completeAnimation()
			f54_arg0.Corners:setAlpha( 0 )
			f54_arg0.Corners:setScale( 0.99, 0.99 )
			f54_local5( f54_arg0.Corners )
			local f54_local6 = function ( f61_arg0 )
				f54_arg0.itemName:beginAnimation( 200 )
				f54_arg0.itemName:setRGB( 1, 0, 0 )
				f54_arg0.itemName:registerEventHandler( "interrupted_keyframe", f54_arg0.clipInterrupted )
				f54_arg0.itemName:registerEventHandler( "transition_complete_keyframe", f54_arg0.clipFinished )
			end
			
			f54_arg0.itemName:completeAnimation()
			f54_arg0.itemName:setRGB( 0.58, 0.58, 0.58 )
			f54_local6( f54_arg0.itemName )
		end,
		LoseChildFocus = function ( f62_arg0, f62_arg1 )
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter( 9 )
			local f62_local0 = function ( f63_arg0 )
				f62_arg0.Box:beginAnimation( 200 )
				f62_arg0.Box:setRGB( 1, 1, 1 )
				f62_arg0.Box:registerEventHandler( "interrupted_keyframe", f62_arg0.clipInterrupted )
				f62_arg0.Box:registerEventHandler( "transition_complete_keyframe", f62_arg0.clipFinished )
			end
			
			f62_arg0.Box:completeAnimation()
			f62_arg0.Box:setRGB( 0.45, 0.31, 0.33 )
			f62_local0( f62_arg0.Box )
			local f62_local1 = function ( f64_arg0 )
				f62_arg0.LightFocus:beginAnimation( 200 )
				f62_arg0.LightFocus:setAlpha( 0 )
				f62_arg0.LightFocus:registerEventHandler( "interrupted_keyframe", f62_arg0.clipInterrupted )
				f62_arg0.LightFocus:registerEventHandler( "transition_complete_keyframe", f62_arg0.clipFinished )
			end
			
			f62_arg0.LightFocus:completeAnimation()
			f62_arg0.LightFocus:setAlpha( 0.1 )
			f62_local1( f62_arg0.LightFocus )
			local f62_local2 = function ( f65_arg0 )
				f62_arg0.Brackets2:beginAnimation( 200 )
				f62_arg0.Brackets2:setAlpha( 0 )
				f62_arg0.Brackets2:setShaderVector( 0, 0.5, 0.5, 0, 0 )
				f62_arg0.Brackets2:registerEventHandler( "interrupted_keyframe", f62_arg0.clipInterrupted )
				f62_arg0.Brackets2:registerEventHandler( "transition_complete_keyframe", f62_arg0.clipFinished )
			end
			
			f62_arg0.Brackets2:completeAnimation()
			f62_arg0.Brackets2:setAlpha( 1 )
			f62_arg0.Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
			f62_arg0.Brackets2:setShaderVector( 0, 1, 0, 0, 0 )
			f62_arg0.Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
			f62_arg0.Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
			f62_arg0.Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
			f62_arg0.Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
			f62_local2( f62_arg0.Brackets2 )
			local f62_local3 = function ( f66_arg0 )
				f62_arg0.itemImage:beginAnimation( 200 )
				f62_arg0.itemImage:setRGB( 0.39, 0.39, 0.39 )
				f62_arg0.itemImage:registerEventHandler( "interrupted_keyframe", f62_arg0.clipInterrupted )
				f62_arg0.itemImage:registerEventHandler( "transition_complete_keyframe", f62_arg0.clipFinished )
			end
			
			f62_arg0.itemImage:completeAnimation()
			f62_arg0.itemImage:setRGB( 0.49, 0.49, 0.49 )
			f62_local3( f62_arg0.itemImage )
			f62_arg0.EquippedMarkerTick:completeAnimation()
			f62_arg0.EquippedMarkerTick:setAlpha( 1 )
			f62_arg0.clipFinished( f62_arg0.EquippedMarkerTick )
			f62_arg0.ConsumableCounter:completeAnimation()
			f62_arg0.ConsumableCounter:setRGB( 1, 0, 0 )
			f62_arg0.clipFinished( f62_arg0.ConsumableCounter )
			local f62_local4 = function ( f67_arg0 )
				f62_arg0.Outline:beginAnimation( 200 )
				f62_arg0.Outline:setAlpha( 0 )
				f62_arg0.Outline:registerEventHandler( "interrupted_keyframe", f62_arg0.clipInterrupted )
				f62_arg0.Outline:registerEventHandler( "transition_complete_keyframe", f62_arg0.clipFinished )
			end
			
			f62_arg0.Outline:completeAnimation()
			f62_arg0.Outline:setAlpha( 0.2 )
			f62_local4( f62_arg0.Outline )
			local f62_local5 = function ( f68_arg0 )
				f62_arg0.Corners:beginAnimation( 200 )
				f62_arg0.Corners:setAlpha( 0 )
				f62_arg0.Corners:setScale( 0.99, 0.99 )
				f62_arg0.Corners:registerEventHandler( "interrupted_keyframe", f62_arg0.clipInterrupted )
				f62_arg0.Corners:registerEventHandler( "transition_complete_keyframe", f62_arg0.clipFinished )
			end
			
			f62_arg0.Corners:completeAnimation()
			f62_arg0.Corners:setAlpha( 1 )
			f62_arg0.Corners:setScale( 1.02, 1.02 )
			f62_local5( f62_arg0.Corners )
			local f62_local6 = function ( f69_arg0 )
				f62_arg0.itemName:beginAnimation( 200 )
				f62_arg0.itemName:setRGB( 0.58, 0.58, 0.58 )
				f62_arg0.itemName:registerEventHandler( "interrupted_keyframe", f62_arg0.clipInterrupted )
				f62_arg0.itemName:registerEventHandler( "transition_complete_keyframe", f62_arg0.clipFinished )
			end
			
			f62_arg0.itemName:completeAnimation()
			f62_arg0.itemName:setRGB( 1, 0, 0 )
			f62_local6( f62_arg0.itemName )
		end
	},
	NoConsumablesRemaining = {
		DefaultClip = function ( f70_arg0, f70_arg1 )
			f70_arg0:__resetProperties()
			f70_arg0:setupElementClipCounter( 7 )
			f70_arg0.Box:completeAnimation()
			f70_arg0.Box:setRGB( 0.59, 0.59, 0.59 )
			f70_arg0.clipFinished( f70_arg0.Box )
			f70_arg0.Brackets:completeAnimation()
			f70_arg0.Brackets:setRGB( 0.23, 0.23, 0.23 )
			f70_arg0.clipFinished( f70_arg0.Brackets )
			f70_arg0.itemImage:completeAnimation()
			f70_arg0.itemImage:setLeftRight( 0.5, 0.5, -52.5, 52.5 )
			f70_arg0.itemImage:setRGB( 0.39, 0.39, 0.39 )
			f70_arg0.clipFinished( f70_arg0.itemImage )
			f70_arg0.EquippedMarkerTick:completeAnimation()
			f70_arg0.EquippedMarkerTick:setAlpha( 0 )
			f70_arg0.clipFinished( f70_arg0.EquippedMarkerTick )
			f70_arg0.ConsumableCounter:completeAnimation()
			f70_arg0.ConsumableCounter:setRGB( 0.79, 0, 0 )
			f70_arg0.clipFinished( f70_arg0.ConsumableCounter )
			f70_arg0.Corners:completeAnimation()
			f70_arg0.Corners:setAlpha( 0 )
			f70_arg0.clipFinished( f70_arg0.Corners )
			f70_arg0.itemName:completeAnimation()
			f70_arg0.itemName:setRGB( 0.39, 0.39, 0.39 )
			f70_arg0.clipFinished( f70_arg0.itemName )
		end,
		ChildFocus = function ( f71_arg0, f71_arg1 )
			f71_arg0:__resetProperties()
			f71_arg0:setupElementClipCounter( 9 )
			f71_arg0.Box:completeAnimation()
			f71_arg0.Box:setRGB( 0.45, 0.31, 0.33 )
			f71_arg0.clipFinished( f71_arg0.Box )
			f71_arg0.LightFocus:completeAnimation()
			f71_arg0.LightFocus:setRGB( 1, 0, 0 )
			f71_arg0.LightFocus:setAlpha( 0.1 )
			f71_arg0.clipFinished( f71_arg0.LightFocus )
			f71_arg0.Brackets2:completeAnimation()
			f71_arg0.Brackets2:setAlpha( 1 )
			f71_arg0.Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
			f71_arg0.Brackets2:setShaderVector( 0, 1, 0, 0, 0 )
			f71_arg0.Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
			f71_arg0.Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
			f71_arg0.Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
			f71_arg0.Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
			f71_arg0.clipFinished( f71_arg0.Brackets2 )
			f71_arg0.itemImage:completeAnimation()
			f71_arg0.itemImage:setRGB( 0.49, 0.49, 0.49 )
			f71_arg0.clipFinished( f71_arg0.itemImage )
			f71_arg0.EquippedMarkerTick:completeAnimation()
			f71_arg0.EquippedMarkerTick:setAlpha( 0 )
			f71_arg0.clipFinished( f71_arg0.EquippedMarkerTick )
			f71_arg0.ConsumableCounter:completeAnimation()
			f71_arg0.ConsumableCounter:setRGB( 1, 0, 0 )
			f71_arg0.clipFinished( f71_arg0.ConsumableCounter )
			f71_arg0.Outline:completeAnimation()
			f71_arg0.Outline:setAlpha( 0.2 )
			f71_arg0.clipFinished( f71_arg0.Outline )
			f71_arg0.Corners:completeAnimation()
			f71_arg0.Corners:setScale( 1.02, 1.02 )
			f71_arg0.clipFinished( f71_arg0.Corners )
			f71_arg0.itemName:completeAnimation()
			f71_arg0.itemName:setRGB( 1, 0, 0 )
			f71_arg0.clipFinished( f71_arg0.itemName )
		end,
		GainChildFocus = function ( f72_arg0, f72_arg1 )
			f72_arg0:__resetProperties()
			f72_arg0:setupElementClipCounter( 9 )
			local f72_local0 = function ( f73_arg0 )
				f72_arg0.Box:beginAnimation( 200 )
				f72_arg0.Box:setRGB( 0.45, 0.31, 0.33 )
				f72_arg0.Box:registerEventHandler( "interrupted_keyframe", f72_arg0.clipInterrupted )
				f72_arg0.Box:registerEventHandler( "transition_complete_keyframe", f72_arg0.clipFinished )
			end
			
			f72_arg0.Box:completeAnimation()
			f72_arg0.Box:setRGB( 1, 1, 1 )
			f72_local0( f72_arg0.Box )
			local f72_local1 = function ( f74_arg0 )
				f72_arg0.LightFocus:beginAnimation( 200 )
				f72_arg0.LightFocus:setAlpha( 0.1 )
				f72_arg0.LightFocus:registerEventHandler( "interrupted_keyframe", f72_arg0.clipInterrupted )
				f72_arg0.LightFocus:registerEventHandler( "transition_complete_keyframe", f72_arg0.clipFinished )
			end
			
			f72_arg0.LightFocus:completeAnimation()
			f72_arg0.LightFocus:setAlpha( 0 )
			f72_local1( f72_arg0.LightFocus )
			local f72_local2 = function ( f75_arg0 )
				f72_arg0.Brackets2:beginAnimation( 200 )
				f72_arg0.Brackets2:setAlpha( 1 )
				f72_arg0.Brackets2:setShaderVector( 0, 1, 0, 0, 0 )
				f72_arg0.Brackets2:registerEventHandler( "interrupted_keyframe", f72_arg0.clipInterrupted )
				f72_arg0.Brackets2:registerEventHandler( "transition_complete_keyframe", f72_arg0.clipFinished )
			end
			
			f72_arg0.Brackets2:completeAnimation()
			f72_arg0.Brackets2:setAlpha( 0 )
			f72_arg0.Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
			f72_arg0.Brackets2:setShaderVector( 0, 0.5, 0.5, 0, 0 )
			f72_arg0.Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
			f72_arg0.Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
			f72_arg0.Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
			f72_arg0.Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
			f72_local2( f72_arg0.Brackets2 )
			local f72_local3 = function ( f76_arg0 )
				f72_arg0.itemImage:beginAnimation( 200 )
				f72_arg0.itemImage:setRGB( 0.49, 0.49, 0.49 )
				f72_arg0.itemImage:registerEventHandler( "interrupted_keyframe", f72_arg0.clipInterrupted )
				f72_arg0.itemImage:registerEventHandler( "transition_complete_keyframe", f72_arg0.clipFinished )
			end
			
			f72_arg0.itemImage:completeAnimation()
			f72_arg0.itemImage:setRGB( 0.39, 0.39, 0.39 )
			f72_local3( f72_arg0.itemImage )
			f72_arg0.EquippedMarkerTick:completeAnimation()
			f72_arg0.EquippedMarkerTick:setAlpha( 0 )
			f72_arg0.clipFinished( f72_arg0.EquippedMarkerTick )
			f72_arg0.ConsumableCounter:completeAnimation()
			f72_arg0.ConsumableCounter:setRGB( 1, 0, 0 )
			f72_arg0.clipFinished( f72_arg0.ConsumableCounter )
			local f72_local4 = function ( f77_arg0 )
				f72_arg0.Outline:beginAnimation( 200 )
				f72_arg0.Outline:setAlpha( 0.2 )
				f72_arg0.Outline:registerEventHandler( "interrupted_keyframe", f72_arg0.clipInterrupted )
				f72_arg0.Outline:registerEventHandler( "transition_complete_keyframe", f72_arg0.clipFinished )
			end
			
			f72_arg0.Outline:completeAnimation()
			f72_arg0.Outline:setAlpha( 0 )
			f72_local4( f72_arg0.Outline )
			local f72_local5 = function ( f78_arg0 )
				f72_arg0.Corners:beginAnimation( 200 )
				f72_arg0.Corners:setAlpha( 1 )
				f72_arg0.Corners:setScale( 1.02, 1.02 )
				f72_arg0.Corners:registerEventHandler( "interrupted_keyframe", f72_arg0.clipInterrupted )
				f72_arg0.Corners:registerEventHandler( "transition_complete_keyframe", f72_arg0.clipFinished )
			end
			
			f72_arg0.Corners:completeAnimation()
			f72_arg0.Corners:setAlpha( 0 )
			f72_arg0.Corners:setScale( 0.99, 0.99 )
			f72_local5( f72_arg0.Corners )
			local f72_local6 = function ( f79_arg0 )
				f72_arg0.itemName:beginAnimation( 200 )
				f72_arg0.itemName:setRGB( 1, 0, 0 )
				f72_arg0.itemName:registerEventHandler( "interrupted_keyframe", f72_arg0.clipInterrupted )
				f72_arg0.itemName:registerEventHandler( "transition_complete_keyframe", f72_arg0.clipFinished )
			end
			
			f72_arg0.itemName:completeAnimation()
			f72_arg0.itemName:setRGB( 0.58, 0.58, 0.58 )
			f72_local6( f72_arg0.itemName )
		end,
		LoseChildFocus = function ( f80_arg0, f80_arg1 )
			f80_arg0:__resetProperties()
			f80_arg0:setupElementClipCounter( 9 )
			local f80_local0 = function ( f81_arg0 )
				f80_arg0.Box:beginAnimation( 200 )
				f80_arg0.Box:setRGB( 1, 1, 1 )
				f80_arg0.Box:registerEventHandler( "interrupted_keyframe", f80_arg0.clipInterrupted )
				f80_arg0.Box:registerEventHandler( "transition_complete_keyframe", f80_arg0.clipFinished )
			end
			
			f80_arg0.Box:completeAnimation()
			f80_arg0.Box:setRGB( 0.45, 0.31, 0.33 )
			f80_local0( f80_arg0.Box )
			local f80_local1 = function ( f82_arg0 )
				f80_arg0.LightFocus:beginAnimation( 200 )
				f80_arg0.LightFocus:setAlpha( 0 )
				f80_arg0.LightFocus:registerEventHandler( "interrupted_keyframe", f80_arg0.clipInterrupted )
				f80_arg0.LightFocus:registerEventHandler( "transition_complete_keyframe", f80_arg0.clipFinished )
			end
			
			f80_arg0.LightFocus:completeAnimation()
			f80_arg0.LightFocus:setAlpha( 0.1 )
			f80_local1( f80_arg0.LightFocus )
			local f80_local2 = function ( f83_arg0 )
				f80_arg0.Brackets2:beginAnimation( 200 )
				f80_arg0.Brackets2:setAlpha( 0 )
				f80_arg0.Brackets2:setShaderVector( 0, 0.5, 0.5, 0, 0 )
				f80_arg0.Brackets2:registerEventHandler( "interrupted_keyframe", f80_arg0.clipInterrupted )
				f80_arg0.Brackets2:registerEventHandler( "transition_complete_keyframe", f80_arg0.clipFinished )
			end
			
			f80_arg0.Brackets2:completeAnimation()
			f80_arg0.Brackets2:setAlpha( 1 )
			f80_arg0.Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
			f80_arg0.Brackets2:setShaderVector( 0, 1, 0, 0, 0 )
			f80_arg0.Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
			f80_arg0.Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
			f80_arg0.Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
			f80_arg0.Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
			f80_local2( f80_arg0.Brackets2 )
			local f80_local3 = function ( f84_arg0 )
				f80_arg0.itemImage:beginAnimation( 200 )
				f80_arg0.itemImage:setRGB( 0.39, 0.39, 0.39 )
				f80_arg0.itemImage:registerEventHandler( "interrupted_keyframe", f80_arg0.clipInterrupted )
				f80_arg0.itemImage:registerEventHandler( "transition_complete_keyframe", f80_arg0.clipFinished )
			end
			
			f80_arg0.itemImage:completeAnimation()
			f80_arg0.itemImage:setRGB( 0.49, 0.49, 0.49 )
			f80_local3( f80_arg0.itemImage )
			f80_arg0.EquippedMarkerTick:completeAnimation()
			f80_arg0.EquippedMarkerTick:setAlpha( 0 )
			f80_arg0.clipFinished( f80_arg0.EquippedMarkerTick )
			f80_arg0.ConsumableCounter:completeAnimation()
			f80_arg0.ConsumableCounter:setRGB( 1, 0, 0 )
			f80_arg0.clipFinished( f80_arg0.ConsumableCounter )
			local f80_local4 = function ( f85_arg0 )
				f80_arg0.Outline:beginAnimation( 200 )
				f80_arg0.Outline:setAlpha( 0 )
				f80_arg0.Outline:registerEventHandler( "interrupted_keyframe", f80_arg0.clipInterrupted )
				f80_arg0.Outline:registerEventHandler( "transition_complete_keyframe", f80_arg0.clipFinished )
			end
			
			f80_arg0.Outline:completeAnimation()
			f80_arg0.Outline:setAlpha( 0.2 )
			f80_local4( f80_arg0.Outline )
			local f80_local5 = function ( f86_arg0 )
				f80_arg0.Corners:beginAnimation( 200 )
				f80_arg0.Corners:setAlpha( 0 )
				f80_arg0.Corners:setScale( 0.99, 0.99 )
				f80_arg0.Corners:registerEventHandler( "interrupted_keyframe", f80_arg0.clipInterrupted )
				f80_arg0.Corners:registerEventHandler( "transition_complete_keyframe", f80_arg0.clipFinished )
			end
			
			f80_arg0.Corners:completeAnimation()
			f80_arg0.Corners:setAlpha( 1 )
			f80_arg0.Corners:setScale( 1.02, 1.02 )
			f80_local5( f80_arg0.Corners )
			local f80_local6 = function ( f87_arg0 )
				f80_arg0.itemName:beginAnimation( 200 )
				f80_arg0.itemName:setRGB( 0.58, 0.58, 0.58 )
				f80_arg0.itemName:registerEventHandler( "interrupted_keyframe", f80_arg0.clipInterrupted )
				f80_arg0.itemName:registerEventHandler( "transition_complete_keyframe", f80_arg0.clipFinished )
			end
			
			f80_arg0.itemName:completeAnimation()
			f80_arg0.itemName:setRGB( 1, 0, 0 )
			f80_local6( f80_arg0.itemName )
		end
	},
	Equipped = {
		DefaultClip = function ( f88_arg0, f88_arg1 )
			f88_arg0:__resetProperties()
			f88_arg0:setupElementClipCounter( 6 )
			f88_arg0.LightFocus:completeAnimation()
			f88_arg0.LightFocus:setRGB( ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b )
			f88_arg0.LightFocus:setAlpha( 0.2 )
			f88_arg0.clipFinished( f88_arg0.LightFocus )
			f88_arg0.Brackets2:completeAnimation()
			f88_arg0.Brackets2:setAlpha( 1 )
			f88_arg0.Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
			f88_arg0.Brackets2:setShaderVector( 0, 1, 0, 0, 0 )
			f88_arg0.Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
			f88_arg0.Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
			f88_arg0.Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
			f88_arg0.Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
			f88_arg0.clipFinished( f88_arg0.Brackets2 )
			f88_arg0.itemImage:completeAnimation()
			f88_arg0.itemImage:setLeftRight( 0.5, 0.5, -52.5, 52.5 )
			f88_arg0.clipFinished( f88_arg0.itemImage )
			f88_arg0.EquippedMarkerTick:completeAnimation()
			f88_arg0.EquippedMarkerTick:setAlpha( 1 )
			f88_arg0.clipFinished( f88_arg0.EquippedMarkerTick )
			f88_arg0.Corners:completeAnimation()
			f88_arg0.Corners:setAlpha( 0 )
			f88_arg0.clipFinished( f88_arg0.Corners )
			f88_arg0.itemName:completeAnimation()
			f88_arg0.itemName:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
			f88_arg0.clipFinished( f88_arg0.itemName )
		end,
		ChildFocus = function ( f89_arg0, f89_arg1 )
			f89_arg0:__resetProperties()
			f89_arg0:setupElementClipCounter( 8 )
			f89_arg0.LightFocus:completeAnimation()
			f89_arg0.LightFocus:setRGB( 1, 0, 0 )
			f89_arg0.LightFocus:setAlpha( 0.1 )
			f89_arg0.clipFinished( f89_arg0.LightFocus )
			f89_arg0.Brackets2:completeAnimation()
			f89_arg0.Brackets2:setAlpha( 1 )
			f89_arg0.Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
			f89_arg0.Brackets2:setShaderVector( 0, 1, 0, 0, 0 )
			f89_arg0.Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
			f89_arg0.Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
			f89_arg0.Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
			f89_arg0.Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
			f89_arg0.clipFinished( f89_arg0.Brackets2 )
			f89_arg0.itemImage:completeAnimation()
			f89_arg0.itemImage:setLeftRight( 0.5, 0.5, -52.5, 52.5 )
			f89_arg0.clipFinished( f89_arg0.itemImage )
			f89_arg0.EquippedMarkerTick:completeAnimation()
			f89_arg0.EquippedMarkerTick:setAlpha( 1 )
			f89_arg0.clipFinished( f89_arg0.EquippedMarkerTick )
			f89_arg0.Outline:completeAnimation()
			f89_arg0.Outline:setAlpha( 0.2 )
			f89_arg0.clipFinished( f89_arg0.Outline )
			f89_arg0.Corners:completeAnimation()
			f89_arg0.Corners:setAlpha( 1 )
			f89_arg0.Corners:setScale( 1.02, 1.02 )
			f89_arg0.clipFinished( f89_arg0.Corners )
			f89_arg0.Dots:completeAnimation()
			f89_arg0.Dots:setRGB( 1, 0, 0 )
			f89_arg0.Dots:setAlpha( 1 )
			f89_arg0.clipFinished( f89_arg0.Dots )
			f89_arg0.itemName:completeAnimation()
			f89_arg0.itemName:setRGB( 1, 0, 0 )
			f89_arg0.clipFinished( f89_arg0.itemName )
		end,
		GainChildFocus = function ( f90_arg0, f90_arg1 )
			f90_arg0:__resetProperties()
			f90_arg0:setupElementClipCounter( 8 )
			local f90_local0 = function ( f91_arg0 )
				f90_arg0.LightFocus:beginAnimation( 200 )
				f90_arg0.LightFocus:setRGB( 1, 0, 0 )
				f90_arg0.LightFocus:setAlpha( 0.1 )
				f90_arg0.LightFocus:registerEventHandler( "interrupted_keyframe", f90_arg0.clipInterrupted )
				f90_arg0.LightFocus:registerEventHandler( "transition_complete_keyframe", f90_arg0.clipFinished )
			end
			
			f90_arg0.LightFocus:completeAnimation()
			f90_arg0.LightFocus:setRGB( ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b )
			f90_arg0.LightFocus:setAlpha( 0.2 )
			f90_local0( f90_arg0.LightFocus )
			f90_arg0.Brackets2:completeAnimation()
			f90_arg0.Brackets2:setAlpha( 1 )
			f90_arg0.Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
			f90_arg0.Brackets2:setShaderVector( 0, 1, 0, 0, 0 )
			f90_arg0.Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
			f90_arg0.Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
			f90_arg0.Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
			f90_arg0.Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
			f90_arg0.clipFinished( f90_arg0.Brackets2 )
			f90_arg0.itemImage:completeAnimation()
			f90_arg0.itemImage:setLeftRight( 0.5, 0.5, -52.5, 52.5 )
			f90_arg0.clipFinished( f90_arg0.itemImage )
			f90_arg0.EquippedMarkerTick:completeAnimation()
			f90_arg0.EquippedMarkerTick:setAlpha( 1 )
			f90_arg0.clipFinished( f90_arg0.EquippedMarkerTick )
			local f90_local1 = function ( f92_arg0 )
				f90_arg0.Outline:beginAnimation( 200 )
				f90_arg0.Outline:setAlpha( 0.2 )
				f90_arg0.Outline:registerEventHandler( "interrupted_keyframe", f90_arg0.clipInterrupted )
				f90_arg0.Outline:registerEventHandler( "transition_complete_keyframe", f90_arg0.clipFinished )
			end
			
			f90_arg0.Outline:completeAnimation()
			f90_arg0.Outline:setAlpha( 0 )
			f90_local1( f90_arg0.Outline )
			local f90_local2 = function ( f93_arg0 )
				f90_arg0.Corners:beginAnimation( 200 )
				f90_arg0.Corners:setAlpha( 1 )
				f90_arg0.Corners:setScale( 1.02, 1.02 )
				f90_arg0.Corners:registerEventHandler( "interrupted_keyframe", f90_arg0.clipInterrupted )
				f90_arg0.Corners:registerEventHandler( "transition_complete_keyframe", f90_arg0.clipFinished )
			end
			
			f90_arg0.Corners:completeAnimation()
			f90_arg0.Corners:setAlpha( 0 )
			f90_arg0.Corners:setScale( 0.99, 0.99 )
			f90_local2( f90_arg0.Corners )
			local f90_local3 = function ( f94_arg0 )
				f90_arg0.Dots:beginAnimation( 200 )
				f90_arg0.Dots:setRGB( 1, 0, 0 )
				f90_arg0.Dots:setAlpha( 1 )
				f90_arg0.Dots:registerEventHandler( "interrupted_keyframe", f90_arg0.clipInterrupted )
				f90_arg0.Dots:registerEventHandler( "transition_complete_keyframe", f90_arg0.clipFinished )
			end
			
			f90_arg0.Dots:completeAnimation()
			f90_arg0.Dots:setRGB( 0.61, 0, 0 )
			f90_arg0.Dots:setAlpha( 0.3 )
			f90_local3( f90_arg0.Dots )
			local f90_local4 = function ( f95_arg0 )
				f90_arg0.itemName:beginAnimation( 200 )
				f90_arg0.itemName:setRGB( 1, 0, 0 )
				f90_arg0.itemName:registerEventHandler( "interrupted_keyframe", f90_arg0.clipInterrupted )
				f90_arg0.itemName:registerEventHandler( "transition_complete_keyframe", f90_arg0.clipFinished )
			end
			
			f90_arg0.itemName:completeAnimation()
			f90_arg0.itemName:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
			f90_local4( f90_arg0.itemName )
		end,
		LoseChildFocus = function ( f96_arg0, f96_arg1 )
			f96_arg0:__resetProperties()
			f96_arg0:setupElementClipCounter( 8 )
			local f96_local0 = function ( f97_arg0 )
				f96_arg0.LightFocus:beginAnimation( 200 )
				f96_arg0.LightFocus:setRGB( ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b )
				f96_arg0.LightFocus:setAlpha( 0.2 )
				f96_arg0.LightFocus:registerEventHandler( "interrupted_keyframe", f96_arg0.clipInterrupted )
				f96_arg0.LightFocus:registerEventHandler( "transition_complete_keyframe", f96_arg0.clipFinished )
			end
			
			f96_arg0.LightFocus:completeAnimation()
			f96_arg0.LightFocus:setRGB( 1, 0, 0 )
			f96_arg0.LightFocus:setAlpha( 0.1 )
			f96_local0( f96_arg0.LightFocus )
			f96_arg0.Brackets2:completeAnimation()
			f96_arg0.Brackets2:setAlpha( 1 )
			f96_arg0.Brackets2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
			f96_arg0.Brackets2:setShaderVector( 0, 1, 0, 0, 0 )
			f96_arg0.Brackets2:setShaderVector( 1, 0.5, 0, 0, 0 )
			f96_arg0.Brackets2:setShaderVector( 2, 0.5, 0, 0, 0 )
			f96_arg0.Brackets2:setShaderVector( 3, 0, 0, 0, 0 )
			f96_arg0.Brackets2:setShaderVector( 4, 0, 0, 0, 0 )
			f96_arg0.clipFinished( f96_arg0.Brackets2 )
			f96_arg0.itemImage:completeAnimation()
			f96_arg0.itemImage:setLeftRight( 0.5, 0.5, -52.5, 52.5 )
			f96_arg0.clipFinished( f96_arg0.itemImage )
			f96_arg0.EquippedMarkerTick:completeAnimation()
			f96_arg0.EquippedMarkerTick:setAlpha( 1 )
			f96_arg0.clipFinished( f96_arg0.EquippedMarkerTick )
			local f96_local1 = function ( f98_arg0 )
				f96_arg0.Outline:beginAnimation( 200 )
				f96_arg0.Outline:setAlpha( 0 )
				f96_arg0.Outline:registerEventHandler( "interrupted_keyframe", f96_arg0.clipInterrupted )
				f96_arg0.Outline:registerEventHandler( "transition_complete_keyframe", f96_arg0.clipFinished )
			end
			
			f96_arg0.Outline:completeAnimation()
			f96_arg0.Outline:setAlpha( 0.2 )
			f96_local1( f96_arg0.Outline )
			local f96_local2 = function ( f99_arg0 )
				f96_arg0.Corners:beginAnimation( 200 )
				f96_arg0.Corners:setAlpha( 0 )
				f96_arg0.Corners:setScale( 0.99, 0.99 )
				f96_arg0.Corners:registerEventHandler( "interrupted_keyframe", f96_arg0.clipInterrupted )
				f96_arg0.Corners:registerEventHandler( "transition_complete_keyframe", f96_arg0.clipFinished )
			end
			
			f96_arg0.Corners:completeAnimation()
			f96_arg0.Corners:setAlpha( 1 )
			f96_arg0.Corners:setScale( 1.02, 1.02 )
			f96_local2( f96_arg0.Corners )
			local f96_local3 = function ( f100_arg0 )
				f96_arg0.Dots:beginAnimation( 200 )
				f96_arg0.Dots:setRGB( 0.61, 0, 0 )
				f96_arg0.Dots:setAlpha( 0.3 )
				f96_arg0.Dots:registerEventHandler( "interrupted_keyframe", f96_arg0.clipInterrupted )
				f96_arg0.Dots:registerEventHandler( "transition_complete_keyframe", f96_arg0.clipFinished )
			end
			
			f96_arg0.Dots:completeAnimation()
			f96_arg0.Dots:setRGB( 1, 0, 0 )
			f96_arg0.Dots:setAlpha( 1 )
			f96_local3( f96_arg0.Dots )
			local f96_local4 = function ( f101_arg0 )
				f96_arg0.itemName:beginAnimation( 200 )
				f96_arg0.itemName:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
				f96_arg0.itemName:registerEventHandler( "interrupted_keyframe", f96_arg0.clipInterrupted )
				f96_arg0.itemName:registerEventHandler( "transition_complete_keyframe", f96_arg0.clipFinished )
			end
			
			f96_arg0.itemName:completeAnimation()
			f96_arg0.itemName:setRGB( 1, 0, 0 )
			f96_local4( f96_arg0.itemName )
		end
	}
}

CoD.ZMElixirSlotInternalCustom.__onClose = function ( f102_arg0 )
	f102_arg0.itemImage:close()
	f102_arg0.ConsumableCounter:close()
	f102_arg0.itemName:close()
	f102_arg0.CommonButtonOutline:close()
	f102_arg0.OutlineR:close()
	f102_arg0.RestrictionIcon:close()
end

-- SafePerksList
CoD.SafePerksList = InheritFrom( LUI.UIElement )
CoD.SafePerksList.__defaultWidth = 1920
CoD.SafePerksList.__defaultHeight = 1080
CoD.SafePerksList.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.SafePerksList )
	self.id = "SafePerksList"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true

	local PerksList = LUI.UIList.new( f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false )
	PerksList:setLeftRight( 0.5, 0.5, -600, 500 )
	PerksList:setTopBottom( 0, 0, 0, 400 )
	PerksList:setScale( 1, 1 )
	PerksList:setWidgetType( CoD.ZMPerkOptionCustom )
	PerksList:setHorizontalCount( 7 )
	PerksList:setVerticalCount( 3 )
	PerksList:setSpacing( 8 )
	PerksList:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	PerksList:setVerticalCounter( CoD.verticalCounter )
	PerksList:setDataSource( "PerkSelectListClassic" )
	PerksList:registerEventHandler( "gain_focus", function ( element, event )
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus( event )
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus( event )
		end
		CoD.Menu.UpdateButtonShownState( element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"] )
		return f10_local0
	end )
	self:addElement( PerksList )
	self.PerksList = PerksList

	PerksList.id = "PerksList"

	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.SafePerksList.__onClose = function ( f5_arg0 )
	f5_arg0.PerksList:close()
end

CoD.DirectorCustomizeClassZMClassic = InheritFrom( LUI.UIElement )
CoD.DirectorCustomizeClassZMClassic.__defaultWidth = 1920
CoD.DirectorCustomizeClassZMClassic.__defaultHeight = 1080
CoD.DirectorCustomizeClassZMClassic.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.DirectorCustomizeClassZMClassic )
	self.id = "DirectorCustomizeClassZMClassic"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local EquippedBGBContainer = CoD.EquippedBGBContainer.new( f1_arg0, f1_arg1, 0.5, 0.5, -899, -549, 0.5, 0.5, -289, 61 )
	EquippedBGBContainer:linkToElementModel( self, nil, false, function ( model )
		EquippedBGBContainer:setModel( model, f1_arg1 )
	end )
	--self:addElement( EquippedBGBContainer )
	self.EquippedBGBContainer = EquippedBGBContainer
	
	local PCEquippedBGBContainer = nil
	
	PCEquippedBGBContainer = CoD.PC_EquippedBGBContainer.new( f1_arg0, f1_arg1, 0.5, 0.5, -795, -668, 0.5, 0.5, -334, 114 )
	PCEquippedBGBContainer:linkToElementModel( self, nil, false, function ( model )
		PCEquippedBGBContainer:setModel( model, f1_arg1 )
	end )
	--self:addElement( PCEquippedBGBContainer )
	self.PCEquippedBGBContainer = PCEquippedBGBContainer
	
	local startWeapon = CoD.LoadoutClassItemZombie.new( f1_arg0, f1_arg1, 0.5, 0.5, 622 - 100, 922 - 100, 0.5, 0.5, 56.5 - 60, 198.5 - 60 )
	startWeapon.LoadoutClassItemContainerZombie.loadoutName:setText( "Starting Weapon in Chaos Story." )
	startWeapon.LoadoutClassItemContainerZombie.loadoutName:setTTF( "notosans_bold" )
	startWeapon.LoadoutClassItemContainerZombie.loadoutName:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_90D57B1E92D39D7" ) )
	startWeapon.LoadoutClassItemContainerZombie.loadoutName:setShaderVector( 0, 1, 0, 0, 0 )
	startWeapon.LoadoutClassItemContainerZombie.loadoutName:setShaderVector( 1, 0, 0, 0, 0 )
	startWeapon.LoadoutClassItemContainerZombie.loadoutName:setShaderVector( 2, 0.2, 0.3, 1, 0.3 )
	startWeapon.LoadoutClassItemContainerZombie.loadoutName:setLetterSpacing( 4 )

	-- set weapon's info
	startWeapon.LoadoutClassItemContainerZombie.itemName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"weapon/pistol_topbreak_t8"))
	startWeapon.LoadoutClassItemContainerZombie.itemImage:setImage(RegisterImage(@"hash_7aaaacd7f5bba0c7"))
	startWeapon:registerEventHandler( "gain_focus", function ( element, event )
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus( event )
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus( event )
		end
		CoD.Menu.UpdateButtonShownState( element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"] )
		return f5_local0
	end )
	f1_arg0:AddButtonCallbackFunction( startWeapon, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function ( element, menu, controller, model )
		--CoD.CACUtility.OpenCACOverlay( self, menu, controller, "ZMStartWeaponSelect", self, "zmStartWeapon" )
		return true
	end, function ( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil )
		return true
	end, false )
	self:addElement( startWeapon )
	self.startWeapon = startWeapon

	local startWeaponAether = CoD.LoadoutClassItemZombie.new( f1_arg0, f1_arg1, 0.5, 0.5, 622 - 100, 922 - 100, 0.5, 0.5, 56.5 + 100, 198.5 + 100 )
	startWeaponAether.LoadoutClassItemContainerZombie.loadoutName:setText( "Starting Weapon in Aether Story." )
	startWeaponAether.LoadoutClassItemContainerZombie.loadoutName:setTTF( "notosans_bold" )
	startWeaponAether.LoadoutClassItemContainerZombie.loadoutName:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_90D57B1E92D39D7" ) )
	startWeaponAether.LoadoutClassItemContainerZombie.loadoutName:setShaderVector( 0, 1, 0, 0, 0 )
	startWeaponAether.LoadoutClassItemContainerZombie.loadoutName:setShaderVector( 1, 0, 0, 0, 0 )
	startWeaponAether.LoadoutClassItemContainerZombie.loadoutName:setShaderVector( 2, 0.2, 0.3, 1, 0.3 )
	startWeaponAether.LoadoutClassItemContainerZombie.loadoutName:setLetterSpacing( 4 )

	-- set weapon's info
	startWeaponAether.LoadoutClassItemContainerZombie.itemName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"weapon/pistol_standard_t8"))
	startWeaponAether.LoadoutClassItemContainerZombie.itemImage:setImage(RegisterImage(@"pistol_standard_t8_camo_alfa_icon"))
	startWeaponAether:registerEventHandler( "gain_focus", function ( element, event )
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus( event )
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus( event )
		end
		CoD.Menu.UpdateButtonShownState( element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"] )
		return f5_local0
	end )
	f1_arg0:AddButtonCallbackFunction( startWeaponAether, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function ( element, menu, controller, model )
		--CoD.CACUtility.OpenCACOverlay( self, menu, controller, "ZMStartWeaponSelect", self, "zmStartWeapon" )
		return true
	end, function ( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil )
		return true
	end, false )
	self:addElement( startWeaponAether )
	self.startWeaponAether = startWeaponAether
	
	local primarygrenade = CoD.LoadoutClassItemZombie.new( f1_arg0, f1_arg1, 0.5, 0.5, 622 - 100, 922 - 100, 0.5, 0.5, 56.5 + 260, 198.5 + 260 )
	primarygrenade.LoadoutClassItemContainerZombie.loadoutName:setText( "Starting Equipments" )
	primarygrenade.LoadoutClassItemContainerZombie.loadoutName:setTTF( "notosans_bold" )
	primarygrenade.LoadoutClassItemContainerZombie.loadoutName:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_90D57B1E92D39D7" ) )
	primarygrenade.LoadoutClassItemContainerZombie.loadoutName:setShaderVector( 0, 1, 0, 0, 0 )
	primarygrenade.LoadoutClassItemContainerZombie.loadoutName:setShaderVector( 1, 0, 0, 0, 0 )
	primarygrenade.LoadoutClassItemContainerZombie.loadoutName:setShaderVector( 2, 0.2, 0.3, 1, 0.3 )
	primarygrenade.LoadoutClassItemContainerZombie.loadoutName:setLetterSpacing( 4 )

	-- set weapon's info
	primarygrenade.LoadoutClassItemContainerZombie.itemName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"weapon/fraggrenade"))
	primarygrenade.LoadoutClassItemContainerZombie.itemImage:setImage(RegisterImage(@"ui_icon_equpiment_zm_frag"))

	primarygrenade:registerEventHandler( "gain_focus", function ( element, event )
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus( event )
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus( event )
		end
		CoD.Menu.UpdateButtonShownState( element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"] )
		return f9_local0
	end )
	f1_arg0:AddButtonCallbackFunction( primarygrenade, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function ( element, menu, controller, model )
		--CoD.CACUtility.OpenCACOverlay( self, menu, controller, "ZMEquipmentSelect", self, "primarygrenade" )
		return true
	end, function ( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil )
		return true
	end, false )
	self:addElement( primarygrenade )
	self.primarygrenade = primarygrenade
	
	local specialWeapon = CoD.LoadoutClassItemZombie.new( f1_arg0, f1_arg1, 0.5, 0.5, 622, 922, 0.5, 0.5, -333, -133 )
	specialWeapon.LoadoutClassItemContainerZombie.itemImage:setScale( 1.2, 1.2 )
	specialWeapon.LoadoutClassItemContainerZombie.loadoutName:setText( LocalizeToUpperString( @"hash_20987AAEBF5D492B" ) )
	specialWeapon:linkToElementModel( self, "herogadget", false, function ( model )
		specialWeapon:setModel( model, f1_arg1 )
	end )
	specialWeapon:registerEventHandler( "gain_focus", function ( element, event )
		local f13_local0 = nil
		if element.gainFocus then
			f13_local0 = element:gainFocus( event )
		elseif element.super.gainFocus then
			f13_local0 = element.super:gainFocus( event )
		end
		CoD.Menu.UpdateButtonShownState( element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"] )
		return f13_local0
	end )
	f1_arg0:AddButtonCallbackFunction( specialWeapon, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function ( element, menu, controller, model )
		CoD.CACUtility.OpenCACOverlay( self, menu, controller, "ZMSpecialWeaponSelect", self, "herogadget" )
		return true
	end, function ( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil )
		return true
	end, false )
	--self:addElement( specialWeapon )
	self.specialWeapon = specialWeapon
	
	local ZMTallismanStatusButton = CoD.ZMTalismanStatusButton.new( f1_arg0, f1_arg1, 0.5, 0.5, -774, -684, 0.5, 0.5, 269.5, 359.5 )
	ZMTallismanStatusButton:linkToElementModel( self, "talisman1", false, function ( model )
		ZMTallismanStatusButton:setModel( model, f1_arg1 )
	end )
	local ZMTalismanEquipLine = ZMTallismanStatusButton
	local PerkAltars = ZMTallismanStatusButton.subscribeToModel
	local LabelWeapons = Engine[@"getglobalmodel"]()
	PerkAltars( ZMTalismanEquipLine, LabelWeapons["lobbyRoot.lobbyNetworkMode"], function ( f17_arg0, f17_arg1 )
		CoD.Menu.UpdateButtonShownState( f17_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"] )
		CoD.Menu.UpdateButtonShownState( f17_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"] )
		CoD.Menu.UpdateButtonShownState( f17_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"] )
	end, false )
	ZMTalismanEquipLine = ZMTallismanStatusButton
	PerkAltars = ZMTallismanStatusButton.subscribeToModel
	LabelWeapons = Engine[@"getglobalmodel"]()
	PerkAltars( ZMTalismanEquipLine, LabelWeapons["lobbyRoot.lobbyNav"], function ( f18_arg0, f18_arg1 )
		CoD.Menu.UpdateButtonShownState( f18_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"] )
		CoD.Menu.UpdateButtonShownState( f18_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"] )
		CoD.Menu.UpdateButtonShownState( f18_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"] )
	end, false )
	ZMTallismanStatusButton:linkToElementModel( ZMTallismanStatusButton, "itemIndex", true, function ( model, f19_arg1 )
		CoD.Menu.UpdateButtonShownState( f19_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"] )
		CoD.Menu.UpdateButtonShownState( f19_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"] )
	end )
	ZMTallismanStatusButton:appendEventHandler( "input_source_changed", function ( f20_arg0, f20_arg1 )
		f20_arg1.menu = f20_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState( f20_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"] )
		CoD.Menu.UpdateButtonShownState( f20_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"] )
	end )
	ZMTalismanEquipLine = ZMTallismanStatusButton
	PerkAltars = ZMTallismanStatusButton.subscribeToModel
	LabelWeapons = Engine[@"getmodelforcontroller"]( f1_arg1 )
	PerkAltars( ZMTalismanEquipLine, LabelWeapons.LastInput, function ( f21_arg0, f21_arg1 )
		CoD.Menu.UpdateButtonShownState( f21_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"] )
		CoD.Menu.UpdateButtonShownState( f21_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"] )
	end, false )
	ZMTallismanStatusButton:registerEventHandler( "gain_focus", function ( element, event )
		local f22_local0 = nil
		if element.gainFocus then
			f22_local0 = element:gainFocus( event )
		elseif element.super.gainFocus then
			f22_local0 = element.super:gainFocus( event )
		end
		CoD.Menu.UpdateButtonShownState( element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"] )
		CoD.Menu.UpdateButtonShownState( element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"] )
		CoD.Menu.UpdateButtonShownState( element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"] )
		return f22_local0
	end )
	f1_arg0:AddButtonCallbackFunction( ZMTallismanStatusButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function ( element, menu, controller, model )
		if IsLive() then
			CoD.CACUtility.OpenCACOverlay( self, menu, controller, "ZMTalismanSelect", self, "talisman1" )
			return true
		else
			
		end
	end, function ( element, menu, controller )
		if IsLive() then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil )
			return true
		else
			return false
		end
	end, false )
	f1_arg0:AddButtonCallbackFunction( ZMTallismanStatusButton, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"], "ui_remove", function ( element, menu, controller, model )
		if not CoD.ModelUtility.IsSelfModelValueEqualTo( element, controller, "itemIndex", CoD.CACUtility.EmptyItemIndex ) and IsMouseOrKeyboard( controller ) and IsLive() then
			CoD.CACUtility.UnequipItem( controller, menu, element )
			return true
		else
			
		end
	end, function ( element, menu, controller )
		if not CoD.ModelUtility.IsSelfModelValueEqualTo( element, controller, "itemIndex", CoD.CACUtility.EmptyItemIndex ) and IsMouseOrKeyboard( controller ) and IsLive() then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"menu/remove", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove" )
			return true
		else
			return false
		end
	end, false )
	f1_arg0:AddButtonCallbackFunction( ZMTallismanStatusButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function ( element, menu, controller, model )
		if not CoD.ModelUtility.IsSelfModelValueEqualTo( element, controller, "itemIndex", CoD.CACUtility.EmptyItemIndex ) and IsGamepad( controller ) and IsLive() then
			CoD.CACUtility.UnequipItem( controller, menu, element )
			return true
		else
			
		end
	end, function ( element, menu, controller )
		if not CoD.ModelUtility.IsSelfModelValueEqualTo( element, controller, "itemIndex", CoD.CACUtility.EmptyItemIndex ) and IsGamepad( controller ) and IsLive() then
			CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/remove", nil, nil )
			return true
		else
			return false
		end
	end, false )
	ZMTallismanStatusButton:AddContextualMenuAction( f1_arg0, f1_arg1, @"menu/remove", function ( f29_arg0, f29_arg1, f29_arg2, f29_arg3 )
		if not CoD.ModelUtility.IsSelfModelValueEqualTo( f29_arg0, f29_arg2, "itemIndex", CoD.CACUtility.EmptyItemIndex ) and IsLive() then
			return function ( f30_arg0, f30_arg1, f30_arg2, f30_arg3 )
				CoD.CACUtility.UnequipItem( f30_arg2, f30_arg1, f30_arg0 )
			end
			
		else
			
		end
	end )
	--self:addElement( ZMTallismanStatusButton )
	self.ZMTallismanStatusButton = ZMTallismanStatusButton
	
	PerkAltars = LUI.UIList.new( f1_arg0, f1_arg1, 14, 0, nil, false, false, false, false )
	PerkAltars:mergeStateConditions( {
		{
			stateName = "Modifier",
			condition = function ( menu, element, event )
				return IsLastListElement( element )
			end
		}
	} )
	PerkAltars:setLeftRight( 0.5, 0.5, -480, 482 )
	PerkAltars:setTopBottom( 0.5, 0.5, -338, 112 )
	PerkAltars:setWidgetType( CoD.ZMPerkSlot )
	PerkAltars:setHorizontalCount( 4 )
	PerkAltars:setSpacing( 14 )
	PerkAltars:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	PerkAltars:setDataSource( "" )
	self:addElement( PerkAltars )
	self.PerkAltars = PerkAltars

	-- perk list custom
	local PerksList = CoD.SafePerksList.new(f1_arg0, f1_arg1, 0.5, 0.5, -500, 500, 0.5, 0.5, 0, 400)
	self:addElement(PerksList)
	self.PerksList = PerksList
	
	PerksList.id = "PerksList"

	-- preview
	local SettingsList = CoD.SettingsModListData.new( f1_arg0, f1_arg1, 0.5, 0.5, -450, 400, 0.5, 0.5, 10, 400 )
	self:addElement( SettingsList )
	self.SettingsList = SettingsList

	SettingsList.id = "SettingsList"

	SettingsList.SettingsList:setWidgetType(CoD.CustomGames_SettingSliderNoCustom)
	SettingsList.SettingsList:setDataSource("ClassicCACListOptions")
	SettingsList.SettingDescription:setAlpha(0)

	-- tab for perks
    local PerkTabs = CoD.Common_Tabbar_Center.new( f1_arg0, f1_arg1, 0.5, 0.5, -480, 400, 0.5, 0.5, -61.5, 0.5 )

	PerkTabs.left:mergeStateConditions( {
		{
			stateName = "Disabled",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		}
	} )

    PerkTabs.right:mergeStateConditions( {
		{
			stateName = "Disabled",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		}
	} )

	PerkTabs.Tabs.grid:setHorizontalCount( 4 )
	PerkTabs.Tabs.grid:setDataSource( "ShieldPerksFilters" )
	PerkTabs:registerEventHandler( "list_active_changed", function ( element, event )
		CoD.EnhModPrintInfo("Updating Perk tab", element.filter)
		PerkCurrentTab = element.filter
		self.PerksList.PerksList:setDataSource("")
		self.PerksList.PerksList:setDataSource("PerkSelectListClassic")
	end )
	self:addElement( PerkTabs )
	self.PerkTabs = PerkTabs

    PerkTabs.id = "PerkTabs"

	SettingsList.SettingsList:registerEventHandler( "grid_item_changed", function ( element, event )
		local dvar_val = Engine[@"getdvarint"]("shield_enh_ClassicPerview")

		if dvar_val == 0 then
			PerkTabs.Tabs.grid:setDataSource( "" )
			PerkTabs.Tabs.grid:setDataSource( "ShieldPerksFilters" )
		else
			PerkTabs.Tabs.grid:setDataSource( "" )
			PerkTabs.Tabs.grid:setDataSource( "ShieldPerksFiltersMaps" )
		end
	end )

	local PerkNameX = LUI.UIText.new( 0.5, 0.5, -530, 400, 0.5, 0.5, -450, -400 )
	PerkNameX:setRGB( 0.58, 0.86, 1 )
	PerkNameX:setText( "" )
	PerkNameX:setTTF( "notosans_bold" )
	PerkNameX:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_90D57B1E92D39D7" ) )
	PerkNameX:setShaderVector( 0, 1, 0, 0, 0 )
	PerkNameX:setShaderVector( 1, 0, 0, 0, 0 )
	PerkNameX:setShaderVector( 2, 0.2, 0.3, 1, 0.3 )
	PerkNameX:setLetterSpacing( 4 )
	PerkNameX:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	PerkNameX:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
	self:addElement( PerkNameX )
	self.PerkNameX = PerkNameX

	PerkNameX:linkToElementModel( PerksList.PerksList, "DisplayName", true, function ( model )
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			PerkNameX:setText( Engine[@"hash_4F9F1239CFD921FE"]( f7_local0 ) )
		end
	end )

	local PerkDesc = LUI.UIText.new( 0.5, 0.5, -530, 400, 0.5, 0.5, -370, -340)
	PerkDesc:setRGB( 0.58, 0.86, 1 )
	PerkDesc:setText( "" )
	PerkDesc:setTTF( "notosans_bold" )
	PerkDesc:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_90D57B1E92D39D7" ) )
	PerkDesc:setShaderVector( 0, 1, 0, 0, 0 )
	PerkDesc:setShaderVector( 1, 0, 0, 0, 0 )
	PerkDesc:setShaderVector( 2, 0.2, 0.3, 1, 0.3 )
	PerkDesc:setLetterSpacing( 4 )
	PerkDesc:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	PerkDesc:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
	self:addElement( PerkDesc )
	self.PerkDesc = PerkDesc

	PerkDesc:linkToElementModel( PerksList.PerksList, "description", true, function ( model )
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			PerkDesc:setText( Engine[@"hash_4F9F1239CFD921FE"]( f7_local0 ) )
		end
	end )

	local PerkDescModifier = LUI.UIText.new( 0.5, 0.5, -530, 400, 0.5, 0.5, -120 - 30, -90 - 30)
	PerkDescModifier:setRGB( 1, 0.56, 0.86 )
	PerkDescModifier:setText( "Modifier: " )
	PerkDescModifier:setTTF( "notosans_bold" )
	PerkDescModifier:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_90D57B1E92D39D7" ) )
	PerkDescModifier:setShaderVector( 0, 1, 0, 0, 0 )
	PerkDescModifier:setShaderVector( 1, 0, 0, 0, 0 )
	PerkDescModifier:setShaderVector( 2, 0.2, 0.3, 1, 0.3 )
	PerkDescModifier:setLetterSpacing( 4 )
	PerkDescModifier:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	PerkDescModifier:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
	self:addElement( PerkDescModifier )
	self.PerkDescModifier = PerkDescModifier

	PerkDescModifier:linkToElementModel( PerksList.PerksList, "modifierDesc", true, function ( model )
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			PerkDescModifier:setText( "Modifier: " .. Engine[@"hash_4F9F1239CFD921FE"]( f7_local0 ) )
		end
	end )

	self.__defaultFocus = PerksList

	ZMTalismanEquipLine = CoD.ZMTalismanEquipLine.new( f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540 )
	ZMTalismanEquipLine:linkToElementModel( self, "talisman1", false, function ( model )
		ZMTalismanEquipLine:setModel( model, f1_arg1 )
	end )
	--self:addElement( ZMTalismanEquipLine )
	self.ZMTalismanEquipLine = ZMTalismanEquipLine
	
	LabelWeapons = LUI.UIText.new( 0.5, 0.5, 625, 825, 0.5, 0.5, -377, -356 )
	LabelWeapons:setRGB( 0.58, 0.86, 1 )
	LabelWeapons:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"zmui/weapons" ) )
	LabelWeapons:setTTF( "ttmussels_regular" )
	LabelWeapons:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_90D57B1E92D39D7" ) )
	LabelWeapons:setShaderVector( 0, 1, 0, 0, 0 )
	LabelWeapons:setShaderVector( 1, 0, 0, 0, 0 )
	LabelWeapons:setShaderVector( 2, 0.2, 0.3, 1, 0.3 )
	LabelWeapons:setLetterSpacing( 4 )
	LabelWeapons:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	LabelWeapons:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
	--self:addElement( LabelWeapons )
	self.LabelWeapons = LabelWeapons
	
	local LabelPerks = LUI.UIText.new( 0.5, 0.5, -481, -281, 0.5, 0.5, -377, -356 )
	LabelPerks:setRGB( 0.58, 0.86, 1 )
	LabelPerks:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"zmui/perks" ) )
	LabelPerks:setTTF( "ttmussels_regular" )
	LabelPerks:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_90D57B1E92D39D7" ) )
	LabelPerks:setShaderVector( 0, 1, 0, 0, 0 )
	LabelPerks:setShaderVector( 1, 0, 0, 0, 0 )
	LabelPerks:setShaderVector( 2, 0.2, 0.3, 1, 0.3 )
	LabelPerks:setLetterSpacing( 4 )
	LabelPerks:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	LabelPerks:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
	--self:addElement( LabelPerks )
	self.LabelPerks = LabelPerks
	
	local LabelElixirs = LUI.UIText.new( 0.5, 0.5, -824, -624, 0.5, 0.5, -377, -356 )
	LabelElixirs:setRGB( 0.58, 0.85, 1 )
	LabelElixirs:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"zmui/elixirs" ) )
	LabelElixirs:setTTF( "ttmussels_regular" )
	LabelElixirs:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_90D57B1E92D39D7" ) )
	LabelElixirs:setShaderVector( 0, 1, 0, 0, 0 )
	LabelElixirs:setShaderVector( 1, 0, 0, 0, 0 )
	LabelElixirs:setShaderVector( 2, 0.2, 0.3, 1, 0.3 )
	LabelElixirs:setLetterSpacing( 4 )
	LabelElixirs:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
	LabelElixirs:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
	--self:addElement( LabelElixirs )
	self.LabelElixirs = LabelElixirs
	
	local LabelTalisman = LUI.UIText.new( 0.5, 0.5, -824, -624, 0.5, 0.5, 181, 202 )
	LabelTalisman:setRGB( 0.58, 0.85, 1 )
	LabelTalisman:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"zmui/talisman" ) )
	LabelTalisman:setTTF( "ttmussels_regular" )
	LabelTalisman:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_90D57B1E92D39D7" ) )
	LabelTalisman:setShaderVector( 0, 1, 0, 0, 0 )
	LabelTalisman:setShaderVector( 1, 0, 0, 0, 0 )
	LabelTalisman:setShaderVector( 2, 0.2, 0.3, 1, 0.3 )
	LabelTalisman:setLetterSpacing( 4 )
	LabelTalisman:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
	LabelTalisman:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
	--self:addElement( LabelTalisman )
	self.LabelTalisman = LabelTalisman
	
	local ChooseClassLockedOverlay = CoD.ChooseClassLockedOverlay.new( f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 1, 1, -1080, 0 )
	ChooseClassLockedOverlay:mergeStateConditions( {
		{
			stateName = "Visible",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "ZombiesVisible",
			condition = function ( menu, element, event )
				return CoD.CACUtility.IsCurrentClassLocked( menu, f1_arg1 )
			end
		}
	} )
	ChooseClassLockedOverlay:linkToElementModel( ChooseClassLockedOverlay, nil, true, function ( model )
		f1_arg0:updateElementState( ChooseClassLockedOverlay, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil
		} )
	end )
	ChooseClassLockedOverlay:linkToElementModel( self, nil, false, function ( model )
		ChooseClassLockedOverlay:setModel( model, f1_arg1 )
	end )
	--self:addElement( ChooseClassLockedOverlay )
	self.ChooseClassLockedOverlay = ChooseClassLockedOverlay
	
	self:mergeStateConditions( {
		{
			stateName = "PublicKeyboard",
			condition = function ( menu, element, event )
				return CoD.DirectorUtility.ShowDirectorPublic( f1_arg1 ) and IsMouseOrKeyboard( f1_arg1 )
			end
		},
		{
			stateName = "Public",
			condition = function ( menu, element, event )
				return CoD.DirectorUtility.ShowDirectorPublic( f1_arg1 )
			end
		},
		{
			stateName = "DefaultStateKeyboard",
			condition = function ( menu, element, event )
				return IsMouseOrKeyboard( f1_arg1 )
			end
		}
	} )
	local f1_local14 = self
	local f1_local15 = self.subscribeToModel
	local f1_local16 = Engine[@"getglobalmodel"]()
	f1_local15( f1_local14, f1_local16["lobbyRoot.lobbyNav"], function ( f44_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f44_arg0:get(),
			modelName = "lobbyRoot.lobbyNav"
		} )
	end, false )
	self:appendEventHandler( "input_source_changed", function ( f45_arg0, f45_arg1 )
		f45_arg1.menu = f45_arg1.menu or f1_arg0
		f1_arg0:updateElementState( self, f45_arg1 )
	end )
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local15( f1_local14, f1_local16.LastInput, function ( f46_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f46_arg0:get(),
			modelName = "LastInput"
		} )
	end, false )
	EquippedBGBContainer.id = "EquippedBGBContainer"
	if CoD.isPC then
		PCEquippedBGBContainer.id = "PCEquippedBGBContainer"
	end
	startWeapon.id = "startWeapon"
	startWeaponAether.id = "startWeaponAether"
	primarygrenade.id = "primarygrenade"
	specialWeapon.id = "specialWeapon"
	ZMTallismanStatusButton.id = "ZMTallismanStatusButton"
	PerkAltars.id = "PerkAltars"
	if CoD.isPC then
		ChooseClassLockedOverlay.id = "ChooseClassLockedOverlay"
	end
	self.__defaultFocus = PerkAltars
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	f1_local15 = self
	if IsPC() and AlwaysFalse() then
		CoD.PCUtility.SetLoadoutKeypadShortcut( f1_arg0, self, f1_arg1, self.customClasssList )
	end
	f1_local15 = ZMTallismanStatusButton
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu( f1_local15, f1_arg1, "name", "", "" )
	end
	return self
end

CoD.DirectorCustomizeClassZMClassic.__resetProperties = function ( f47_arg0 )
	f47_arg0.PCEquippedBGBContainer:completeAnimation()
	f47_arg0.EquippedBGBContainer:completeAnimation()
	f47_arg0.PCEquippedBGBContainer:setAlpha( 1 )
	f47_arg0.EquippedBGBContainer:setAlpha( 1 )
end

CoD.DirectorCustomizeClassZMClassic.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f48_arg0, f48_arg1 )
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter( 1 )
			f48_arg0.PCEquippedBGBContainer:completeAnimation()
			f48_arg0.PCEquippedBGBContainer:setAlpha( 0 )
			f48_arg0.clipFinished( f48_arg0.PCEquippedBGBContainer )
		end
	},
	PublicKeyboard = {
		DefaultClip = function ( f49_arg0, f49_arg1 )
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter( 1 )
			f49_arg0.EquippedBGBContainer:completeAnimation()
			f49_arg0.EquippedBGBContainer:setAlpha( 0 )
			f49_arg0.clipFinished( f49_arg0.EquippedBGBContainer )
		end
	},
	Public = {
		DefaultClip = function ( f50_arg0, f50_arg1 )
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter( 1 )
			f50_arg0.PCEquippedBGBContainer:completeAnimation()
			f50_arg0.PCEquippedBGBContainer:setAlpha( 0 )
			f50_arg0.clipFinished( f50_arg0.PCEquippedBGBContainer )
		end
	},
	DefaultStateKeyboard = {
		DefaultClip = function ( f51_arg0, f51_arg1 )
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter( 1 )
			f51_arg0.EquippedBGBContainer:completeAnimation()
			f51_arg0.EquippedBGBContainer:setAlpha( 0 )
			f51_arg0.clipFinished( f51_arg0.EquippedBGBContainer )
		end
	}
}

CoD.DirectorCustomizeClassZMClassic.__onClose = function ( f52_arg0 )
	f52_arg0.EquippedBGBContainer:close()
	f52_arg0.PCEquippedBGBContainer:close()
	f52_arg0.startWeapon:close()
	f52_arg0.startWeaponAether:close()
	f52_arg0.primarygrenade:close()
	f52_arg0.specialWeapon:close()
	f52_arg0.ZMTallismanStatusButton:close()
	f52_arg0.PerkAltars:close()
	f52_arg0.ZMTalismanEquipLine:close()
	f52_arg0.ChooseClassLockedOverlay:close()
	f52_arg0.PerksList:close()
	f52_arg0.PerkDesc:close()
	f52_arg0.PerkNameX:close()
	f52_arg0.PerkTabs:close()
	f52_arg0.PerkDescModifier:close()
end

CoD.ZMLoadoutUtility.IsArmoryElementBaseAttachmentEquippedOriginal = CoD.ZMLoadoutUtility.IsArmoryElementBaseAttachmentEquipped
CoD.ZMLoadoutUtility.IsArmoryElementBaseAttachmentEquipped = function ( f104_arg0, f104_arg1, f104_arg2 )
	if Engine[@"getdvarint"]("shield_enh_AttachmentsLimit") == 0 then
		return CoD.ZMLoadoutUtility.IsArmoryElementBaseAttachmentEquippedOriginal( f104_arg0, f104_arg1, f104_arg2 )
	end

	return true
end