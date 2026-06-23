--[[
      .\hksc.exe '.\Lua\Frontend Side\PreGameButtons.lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\PreGameButtons.luac'
]]

------------------------

if not CoD.isFrontend then
	return
end

CoD.InitEnhLuaFile()

------------------------

-- This is loaded by the support mod anyways
DataSources.DirectorPregameButtonsCustom = ListHelper_SetupDataSource( "DirectorPregameButtonsCustom", function ( f115_arg0, f115_arg1 )
	local f115_local0 = {}
	local f115_local1 = Engine[@"createmodel"]( Engine[@"getglobalmodel"](), "lobbyRoot.lobbyMainMode" )
	f115_local1 = f115_local1:get()
	local f115_local2 = LuaUtils.GetEModeForLobbyMainMode( f115_local1 )
	local f115_local3 = CoD.BreadcrumbUtility.GetStorageLoadoutBufferForPlayer( f115_arg0, f115_local2 )
	local f115_local4 = function ( f116_arg0, f116_arg1 )
		local f116_local0 = {}
		local f116_local1 = f116_arg0.hintText
		local f116_local2 = false
		local f116_local3 = false
		if not f116_local1 and f116_arg0.featureItemIndex then
			f116_local1 = nil
			if CoD.CACUtility.IsFeatureItemLocked( f115_arg0, f116_arg0.featureItemIndex, f115_local2 ) then
				f116_local1 = CoD.GetUnlockStringForItemIndex( f115_arg0, f116_arg0.featureItemIndex, Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"], f115_local2 )
			end
		end
		if f116_arg0.newBreadcrumbFunc then
			f116_local2 = f116_arg0.newBreadcrumbFunc( nil, f115_arg0, f115_local2 )
		end
		if f116_arg0.hasRestrictionsEquippedFunc then
			f116_local3 = f116_arg0.hasRestrictionsEquippedFunc( f115_arg0 )
		end
		local f116_local4 = table.insert
		local f116_local5 = f115_local0
		local f116_local6 = {}
		local f116_local7 = {
			name = f116_arg0.name,
			subtitle = f116_arg0.subtitle,
			iconBackground = f116_arg0.iconBackground,
			featureItemIndex = f116_arg0.featureItemIndex or -1,
			showPregameButton = f116_arg0.showPregameButton,
			hintText = f116_local1 or "",
			hasBreadcrumb = f116_local2,
			isRestricted = f116_local3,
			trialLocked = f116_arg0.trialLocked or false
		}
		local f116_local8 = f116_arg0.breadcrumbModel
		if not f116_local8 then
			f116_local8 = Engine[@"getglobalmodel"]()
		end
		f116_local7.breadcrumbModel = f116_local8
		f116_local6.models = f116_local7
		f116_local6.properties = {
			action = f116_arg1.action,
			actionParam = f116_arg1.actionParam,
			selectIndex = f116_arg1.selectIndex
		}
		f116_local4( f116_local5, f116_local6 )
	end
	
	if f115_local1 == Enum[@"lobbymainmode"][@"lobby_mainmode_mp"] then
		CoD.CACUtility.maxAttachments = {
			primary = 6,
			secondary = 6
		}

		CoD.CACUtility.maxPrimaryAttachments = 6
		CoD.CACUtility.maxSecondaryAttachments = 6
		CoD.ZMLoadoutUtility.ArmoryUberAllocation = 2
		CoD.ZMLoadoutUtility.MaxArmoryAttachments = 6
		CoD.CACUtility.maxAllocation = 10

		local f115_local5 = Engine[@"getglobalmodel"]()
		f115_local5 = f115_local5["lobbyRoot.selectedGameType"]
		local f115_local6 = true
		if f115_arg1:getParent() then
			local f115_local7 = f115_arg1:getParent()
			if f115_local7._preGameType == "custom" and CoD.DirectorUtility.HideCustomizationGametypes[f115_local5:get()] then
				f115_local6 = false
			end
		end
		if f115_arg1:getParent() then
			local f115_local7 = f115_arg1:getParent()
			if f115_local7._preGameType == "public" then
				f115_local7 = Engine[@"getglobalmodel"]()
				f115_local7 = f115_local7["lobbyRoot.playlistId"]
				if f115_local7 and f115_local7:get() then
					local f115_local8 = IsLobbyNetworkModeLive()
					if f115_local8 then
						f115_local8 = Engine[@"getplaylistinfobyid"]( f115_local7:get() )
					end
					if f115_local8 and #f115_local8.rotationList > 0 then
						f115_local6 = not CoD.DirectorUtility.HideCustomizationPlaylistGametypes[f115_local8.rotationList[1].gametype]
					end
				end
			end
		end
		if not CoDShared.IsInTheaterLobby() then
			if not IsLobbyNetworkModeLAN() and (not CoD.DirectorUtility.IsOfflineDemo() or Engine[@"hash_5CB675CA7856DA25"]()) then
				f115_local4( {
					name = @"menu/depot",
					subtitle = @"menu/depot",
					iconBackground = @"$blacktransparent",
					showPregameButton = true,
					breadcrumbModel = DataSources.DepotBreadcrumbs.getModel( f115_arg0 )
				}, {
					action = CoD.DirectorUtility.OpenDirectorPersonalizationMenu,
					actionParam = {
						_sessionMode = f115_local2,
						_storageLoadoutBuffer = f115_local3,
						_allowsQuickSelect = true
					}
				} )
				f115_local4( {
					name = @"hash_6FF94A9EB646C873",
					subtitle = @"hash_6FF94A9EB646C873",
					iconBackground = @"$blacktransparent",
					showPregameButton = true,
					breadcrumbModel = DataSources.CharacterBreadcrumbs.recreateCharacterBreadcrumbModelsIfNeeded( f115_arg0, f115_local2 )
				}, {
					action = CoD.DirectorUtility.OpenDirectorChangeCharacterMenu,
					actionParam = {
						_sessionMode = f115_local2,
						_storageLoadoutBuffer = f115_local3,
						_selectIndex = 1
					}
				} )
			end
			f115_local4( {
				name = @"menu/change",
				subtitle = @"hash_31A1B9A85C55950F",
				iconBackground = @"$blacktransparent",
				showPregameButton = f115_local6,
				newBreadcrumbFunc = CoD.BreadcrumbUtility.IsAnyScorestreaksNew,
				hasRestrictionsEquippedFunc = CoD.CACUtility.AnyEquippedScorestreaksBanned
			}, {
				action = CoD.DirectorUtility.DirectorOpenOverlayWithMenuSessionMode,
				actionParam = {
					menuName = "SupportSelection",
					eMode = f115_local2
				}
			} )
			f115_local4( {
				name = @"menu/edit",
				subtitle = @"hash_6C705394F8BCCCC9",
				iconBackground = @"$blacktransparent",
				featureItemIndex = CoD.CACUtility.GetFeatureCACItemIndex(),
				showPregameButton = f115_local6,
				newBreadcrumbFunc = CoD.BreadcrumbUtility.IsAnythingInCACNew,
				hasRestrictionsEquippedFunc = CoD.CACUtility.AnyClassContainsRestrictedItems
			}, {
				action = CoD.OpenCACWithMenuSessionModeClassic, -- for classic's menu if classic dvar is on
				actionParam = {
					eMode = f115_local2
				},
				selectIndex = true
			} )
		end
	end
	if f115_local1 == Enum[@"lobbymainmode"][@"lobby_mainmode_zm"] then
			if Engine[@"getdvarint"]("shield_enh_AttachmentsLimit") == 1 then
				CoD.CACUtility.maxAttachments = {
					primary = 20,
					secondary = 20
				}

				CoD.CACUtility.maxPrimaryAttachments = 20
				CoD.CACUtility.maxSecondaryAttachments = 20
				CoD.ZMLoadoutUtility.ArmoryUberAllocation = 0
				CoD.ZMLoadoutUtility.MaxArmoryAttachments = 20
				CoD.CACUtility.maxAllocation = 20
			else
				CoD.CACUtility.maxAttachments = {
					primary = 6,
					secondary = 6
				}

				CoD.CACUtility.maxPrimaryAttachments = 6
				CoD.CACUtility.maxSecondaryAttachments = 6
				CoD.ZMLoadoutUtility.ArmoryUberAllocation = 2
				CoD.ZMLoadoutUtility.MaxArmoryAttachments = 6
				CoD.CACUtility.maxAllocation = 10
			end

            -- enh menu
            f115_local4( {
                  name = @"shield/enh_setting",
                  subtitle = @"shield/enh_setting",
                  iconBackground = @"$blacktransparent",
                  showPregameButton = true
            }, {
                  action = CoD.DirectorUtility.DirectorSelectOpenPopup,
                  actionParam = "ShieldEnhOptionsMenu"
            } )


		if not IsLobbyNetworkModeLAN() and (not CoD.DirectorUtility.IsOfflineDemo() or Engine[@"hash_5CB675CA7856DA25"]()) then
			f115_local4( {
				name = @"hash_249E353FB642CB3F",
				subtitle = @"hash_249E353FB642CB3F",
				iconBackground = @"$blacktransparent",
				showPregameButton = true,
				breadcrumbModel = DataSources.CharacterBreadcrumbs.recreateCharacterBreadcrumbModelsIfNeeded( f115_arg0, f115_local2 )
			}, {
				action = CoD.DirectorUtility.OpenDirectorChangeCharacterMenu,
				actionParam = {
					_sessionMode = f115_local2,
					_storageLoadoutBuffer = f115_local3,
					_selectIndex = 1
				}
			} )
		end
		f115_local4( {
			name = @"menu/armory",
			subtitle = @"menu/armory",
			iconBackground = @"$blacktransparent",
			showPregameButton = true
		}, {
			action = CoD.DirectorUtility.OpenArmoryMenu,
			actionParam = {
				_sessionMode = f115_local2,
				_loadoutSlot = "armory"
			}
		} )
		f115_local4( {
			name = @"menu/edit",
			subtitle = @"hash_43E876868767ECEB",
			iconBackground = @"$blacktransparent",
			showPregameButton = true
		}, {
			action = CoD.OpenCACWithMenuSessionModeClassic,
			actionParam = {
				eMode = f115_local2
			},
			selectIndex = true
		} )
	end
	if f115_local1 == Enum[@"lobbymainmode"][@"lobby_mainmode_wz"] then
		if not IsLobbyNetworkModeLAN() and (not CoD.DirectorUtility.IsOfflineDemo() or Engine[@"hash_5CB675CA7856DA25"]()) then
			f115_local4( {
				name = @"menu/depot",
				subtitle = @"menu/depot",
				iconBackground = @"$blacktransparent",
				showPregameButton = true,
				breadcrumbModel = DataSources.DepotBreadcrumbs.getModel( f115_arg0 )
			}, {
				action = CoD.DirectorUtility.OpenDirectorPersonalizationMenu,
				actionParam = {
					_sessionMode = f115_local2,
					_storageLoadoutBuffer = f115_local3,
					_allowsQuickSelect = true
				}
			} )
		end
		f115_local4( {
			name = @"hash_249E353FB642CB3F",
			subtitle = @"hash_249E353FB642CB3F",
			iconBackground = @"$blacktransparent",
			showPregameButton = true,
			breadcrumbModel = DataSources.CharacterBreadcrumbs.recreateCharacterBreadcrumbModelsIfNeeded( f115_arg0, f115_local2 )
		}, {
			action = CoD.DirectorUtility.OpenDirectorChangeCharacterMenu,
			actionParam = {
				_sessionMode = f115_local2,
				_storageLoadoutBuffer = f115_local3
			}
		} )
		f115_local4( {
			name = @"menu/armory",
			subtitle = @"menu/armory",
			iconBackground = @"$blacktransparent",
			showPregameButton = true,
			trialLocked = IsGameTrial()
		}, {
			action = CoD.DirectorUtility.OpenWZPersonalizeWeaponMenu,
			actionParam = {
				_sessionMode = f115_local2,
				_loadoutSlot = "wzpersonalize"
			},
			selectIndex = true
		} )
	end
	local f115_local5 = CoD.DirectorUtility.CreateOfflineScreenState()
	if f115_arg1.offlineScreenStateSubscription == nil then
		f115_arg1.offlineScreenStateSubscription = f115_arg1:subscribeToModel( f115_local5, function ()
			f115_arg1:updateDataSource()
		end, false )
	end
	if not f115_arg1.occlusionChangeSubscription then
		f115_arg1.occlusionChangeSubscription = true
		f115_arg1.menu:appendEventHandler( "occlusion_change", function ( f118_arg0, f118_arg1 )
			if not f118_arg1.occluded then
				f115_arg1:updateDataSource()
			end
		end )
	end

	CoD.DirectorUtility.AddLobbyNavSubscriptionOnce( f115_arg1 )
	return f115_local0
end )