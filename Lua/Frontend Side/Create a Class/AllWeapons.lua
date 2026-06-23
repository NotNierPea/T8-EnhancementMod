--[[
      .\hksc.exe '.\Lua\Frontend Side\AllWeapons.lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\AllWeapons.luac'
]]

------------------------

if not CoD.isFrontend then
	return
end

CoD.InitEnhLuaFile()

------------------------

-- starting weapon tabs
DataSources.ZMStartingWeaponGroups = ListHelper_SetupDataSource( "ZMStartingWeaponGroups", function ( f47_arg0 )
	local f48_local0 = {}
	for f48_local5, f48_local6 in ipairs( CoD.ZMLoadoutUtility.ZMArmoryGroupNames ) do
		table.insert( f48_local0, {
			models = {
				name = f48_local6.name,
				tabHasRestrictions = false
			},
			properties = {
				loadoutType = f48_local6.loadoutType,
				category = f48_local6.weapon_category,
				itemGroup = f48_local6.itemGroup
			}
		} )
	end
	return f48_local0
end, true )

-- return armory waepons in starting weapon list
DataSources.Unlockables = ListHelper_SetupDataSource( "Unlockables", function ( f401_arg0, f401_arg1 )
	if IsZombies() then
		local f401_local0 = {}
		local f401_local1, f401_local2, f401_local3 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f401_arg1.menu )
		local f401_local4 = CoD.CACUtility.GetItemIndexEquippedInSlot( f401_local3, f401_arg0, f401_local1 )
		local f401_local5, f401_local6, f401_local7, f401_local8 = nil
		if f401_local3 == "primary" or f401_local3 == "secondary" then
			f401_local8 = CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f401_local2, f401_local9, f401_arg0, true )
		elseif f401_local3 == "equippedbubblegumpack" then
			f401_local8 = CoD.CACUtility.GetUnlockableBGBItemsForItemGroupAndRarity( f401_local2, f401_arg1.menu.__itemGroup, f401_arg1.menu.__rarity )
		--elseif CoD.ZMLoadoutUtility and f401_local3 == CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName then
			--f401_local8 = CoD.ZMLoadoutUtility.GetZombieStartWeaponsForForCategory( f401_arg1.menu, f401_local2 )
		elseif f401_local3 == "talent" then
			f401_local8 = CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f401_local2, f401_arg1.menu._talentFilter )
		elseif f401_local3 == "talisman1" then
			f401_local8 = CoD.CACUtility.GetUnlockableTalismanItemsForRarity( f401_local2, f401_arg1.menu.__rarity )
		elseif f401_local3 == "armory" or CoD.ZMLoadoutUtility and f401_local3 == CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName then
			local f401_local9 = f401_arg1.menu.__loadoutType
			if f401_local9 == "primary" then
				f401_local8 = CoD.CACUtility.GetUnlockableItemsForItemGroup( f401_arg0, f401_local2, f401_arg1.menu.__itemGroup )
			elseif f401_local9 == "secondary" then
				f401_local8 = CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f401_local2, f401_local9, f401_arg0, true )
			else
				f401_local8 = {}
			end
		elseif f401_local3 == "wzpersonalize" then
			f401_local8 = CoD.WZUtility.GetPersonalizeItemsForItemGroup( f401_arg0, f401_arg1.menu.__loadoutType, f401_arg1.menu.__itemGroup )
		elseif f401_local3 == "bonuscard" then
			f401_local8 = CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f401_local2, f401_local3 )
			f401_local5 = CoD.BonuscardUtility.GetEquippedIncompatibleBonuscards( f401_local1, f401_local2 )
			f401_local6 = CoD.BonuscardUtility.GetBonuscardInfoForLoadoutSlot( CoD.BaseUtility.GetMenuContextualEquipSlot( f401_arg1.menu ), "contextualBonuscards" )
			if f401_local6 then
				for f401_local13, f401_local14 in ipairs( f401_local6 ) do
					if not CoD.BonuscardUtility.IsBonuscardEquipped( f401_local1, f401_local14, f401_local2 ) then
						f401_local7 = Engine[@"hash_2D97229B24C685D5"]( f401_local14, f401_local2 )
					end
				end
			end
		else
			f401_local8 = CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f401_local2, f401_local3 )
		end
		local f401_local9 = f401_arg1.menu.__ignoreUnlockablesDefaultSelectIndex
		for f401_local13, f401_local14 in ipairs( f401_local8 ) do
			if f401_local14.allocation ~= -1 then
				local f401_local15 = CoD.CACUtility.BuildItemModelDataFromUnlockableItem( f401_arg1.menu, f401_arg0, f401_local14, f401_local4, f401_local5, f401_local6, f401_local7 )
				if f401_local15 then
					if not f401_local9 and f401_local15.properties and f401_local15.properties.selectIndex then
						f401_local9 = true
					end
					if f401_local15.models and (f401_local2 == Enum[@"emodes"][@"mode_zombies"]) then
						table.insert( f401_local0, f401_local15 )
					end
				end
			end
		end
		if not f401_local9 and #f401_local0 > 0 then
			f401_local0[1].properties.selectIndex = true
		end
		return f401_local0
	else
		local f401_local0 = {}
		local f401_local1, f401_local2, f401_local3 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot( f401_arg1.menu )
		local f401_local4 = CoD.CACUtility.GetItemIndexEquippedInSlot( f401_local3, f401_arg0, f401_local1 )
		local f401_local5, f401_local6, f401_local7, f401_local8 = nil
		if f401_local3 == "primary" or f401_local3 == "secondary" then
			f401_local8 = CoD.CACUtility.GetUnlockableItemsForItemGroup( f401_arg0, f401_local2, f401_arg1.menu.__itemGroup )
		elseif f401_local3 == "equippedbubblegumpack" then
			f401_local8 = CoD.CACUtility.GetUnlockableBGBItemsForItemGroupAndRarity( f401_local2, f401_arg1.menu.__itemGroup, f401_arg1.menu.__rarity )
		elseif CoD.ZMLoadoutUtility and f401_local3 == CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName then
			f401_local8 = CoD.ZMLoadoutUtility.GetZombieStartWeaponsForForCategory( f401_arg1.menu, f401_local2 )
		elseif f401_local3 == "talent" then
			f401_local8 = CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f401_local2, f401_arg1.menu._talentFilter )
		elseif f401_local3 == "talisman1" then
			f401_local8 = CoD.CACUtility.GetUnlockableTalismanItemsForRarity( f401_local2, f401_arg1.menu.__rarity )
		elseif f401_local3 == "armory" then
			local f401_local9 = f401_arg1.menu.__loadoutType
			if f401_local9 == "primary" then
				f401_local8 = CoD.CACUtility.GetUnlockableItemsForItemGroup( f401_arg0, f401_local2, f401_arg1.menu.__itemGroup )
			elseif f401_local9 == "secondary" then
				f401_local8 = CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f401_local2, f401_local9, f401_arg0, true )
			else
				f401_local8 = {}
			end
		elseif f401_local3 == "wzpersonalize" then
			f401_local8 = CoD.WZUtility.GetPersonalizeItemsForItemGroup( f401_arg0, f401_arg1.menu.__loadoutType, f401_arg1.menu.__itemGroup )
		elseif f401_local3 == "bonuscard" then
			f401_local8 = CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f401_local2, f401_local3 )
			f401_local5 = CoD.BonuscardUtility.GetEquippedIncompatibleBonuscards( f401_local1, f401_local2 )
			f401_local6 = CoD.BonuscardUtility.GetBonuscardInfoForLoadoutSlot( CoD.BaseUtility.GetMenuContextualEquipSlot( f401_arg1.menu ), "contextualBonuscards" )
			if f401_local6 then
				for f401_local13, f401_local14 in ipairs( f401_local6 ) do
					if not CoD.BonuscardUtility.IsBonuscardEquipped( f401_local1, f401_local14, f401_local2 ) then
						f401_local7 = Engine[@"hash_2D97229B24C685D5"]( f401_local14, f401_local2 )
					end
				end
			end
		else
			f401_local8 = CoD.CACUtility.GetUnlockableItemsForLoadoutSlot( f401_local2, f401_local3 )
		end
		local f401_local9 = f401_arg1.menu.__ignoreUnlockablesDefaultSelectIndex
		for f401_local13, f401_local14 in ipairs( f401_local8 ) do
			if f401_local14.allocation ~= -1 then
				local f401_local15 = CoD.CACUtility.BuildItemModelDataFromUnlockableItem( f401_arg1.menu, f401_arg0, f401_local14, f401_local4, f401_local5, f401_local6, f401_local7 )
				if f401_local15 then
					if not f401_local9 and f401_local15.properties and f401_local15.properties.selectIndex then
						f401_local9 = true
					end
					if f401_local15.models and (f401_local2 == Enum[@"emodes"][@"mode_zombies"] or not f401_local15.models.isRestricted) then
						table.insert( f401_local0, f401_local15 )
					end
				end
			end
		end
		if not f401_local9 and #f401_local0 > 0 then
			f401_local0[1].properties.selectIndex = true
		end
		return f401_local0
	end

	end, true, {
		getSpacerAfterColumn = function ( f402_arg0, f402_arg1, f402_arg2 )
			local f402_local0 = f402_arg0[f402_arg0.dataSourceName]
			if f402_local0[f402_arg1] then
				return f402_local0[f402_arg1].properties.vSpacing or 0
			else
				return 0
			end
		end,
		getSpacerAfterRow = function ( f403_arg0, f403_arg1, f403_arg2 )
			local f403_local0 = f403_arg0[f403_arg0.dataSourceName]
			if f403_local0[f403_arg1] then
				return f403_local0[f403_arg1].properties.hSpacing or 0
			else
				return 0
			end
		end
	}
)