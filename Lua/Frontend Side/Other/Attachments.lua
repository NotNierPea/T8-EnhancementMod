--[[
      .\hksc.exe '.\Lua\Frontend Side\Attachments.lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\Attachments.luac'
]]

------------------------

if not CoD.isFrontend then
	return
end

CoD.InitEnhLuaFile()

------------------------


CoD.ZMLoadoutUtility.UpdateEquippedWeaponAttachmentAttributesOriginal = CoD.ZMLoadoutUtility.UpdateEquippedWeaponAttachmentAttributes

-- crash issue, fix -> f35_local20.itemIndex < 8
CoD.ZMLoadoutUtility.UpdateEquippedWeaponAttachmentAttributes = function ( f35_arg0, f35_arg1, f35_arg2 )
	if Engine[@"getdvarint"]( "shield_enh_AttachmentsLimit" ) == 0 then
		return CoD.ZMLoadoutUtility.UpdateEquippedWeaponAttachmentAttributesOriginal( f35_arg0, f35_arg1, f35_arg2 )
	end

	local f35_local0 = Enum[@"weaponattributescolumn"][@"weaponattributes_reference"]
	local f35_local1 = Enum[@"weaponattributescolumn"][@"weaponattributes_weapon_name"]
	local f35_local2 = Enum[@"weaponattributescolumn"][@"weaponattributes_damage"]
	local f35_local3 = Enum[@"weaponattributescolumn"][@"weaponattributes_range"]
	local f35_local4 = Enum[@"weaponattributescolumn"][@"weaponattributes_fire_rate"]
	local f35_local5 = Enum[@"weaponattributescolumn"][@"weaponattributes_accuracy"]
	local f35_local6 = Engine[@"hash_7B98952F69D937F9"]( f35_arg1, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f35_arg2 )
	local f35_local7 = {
		damage = 0,
		range = 0,
		fireRate = 0,
		accuracy = 0,
		magCount = 0,
		magSize = 0
	}
	local f35_local8 = {}
	for f35_local19, f35_local20 in ipairs( f35_arg0._armoryAttachmentTable ) do
		if f35_local20.itemIndex > CoD.CACUtility.EmptyItemIndex and f35_local20.itemIndex < 8 then
			local f35_local12 = Engine[@"getattachmentref"]( f35_arg1, f35_local20.itemIndex, f35_arg2 )
			table.insert( f35_local8, f35_local12 )
			local f35_local13 = Engine[@"tablelookup"]( CoD.weaponAttributes, f35_local2, f35_local0, f35_local12, f35_local1, f35_local6 )
			local f35_local14 = Engine[@"tablelookup"]( CoD.weaponAttributes, f35_local3, f35_local0, f35_local12, f35_local1, f35_local6 )
			local f35_local15 = Engine[@"tablelookup"]( CoD.weaponAttributes, f35_local4, f35_local0, f35_local12, f35_local1, f35_local6 )
			local f35_local16 = Engine[@"tablelookup"]( CoD.weaponAttributes, f35_local5, f35_local0, f35_local12, f35_local1, f35_local6 )
			local f35_local17 = f35_local7.damage
			local f35_local18
			if not f35_local13 then
				f35_local18 = 0
				if not f35_local18 then
				
				else
					f35_local7.damage = f35_local17 + f35_local18
					f35_local17 = f35_local7.range
					if not f35_local14 then
						f35_local18 = 0
						if not f35_local18 then
						
						else
							f35_local7.range = f35_local17 + f35_local18
							f35_local17 = f35_local7.fireRate
							if not f35_local15 then
								f35_local18 = 0
								if not f35_local18 then
								
								else
									f35_local7.fireRate = f35_local17 + f35_local18
									f35_local17 = f35_local7.accuracy
									if not f35_local16 then
										f35_local18 = 0
										if not f35_local18 then
										
										else
											f35_local7.accuracy = f35_local17 + f35_local18
										end
									end
									f35_local18 = f35_local16
								end
							end
							f35_local18 = f35_local15
						end
					end
					f35_local18 = f35_local14
				end
			end
			f35_local18 = f35_local13
		end
	end
	f35_local7.magCount, f35_local7.magSize = CoD.WeaponAttachmentsUtility.GetClipCountAndSizeForWeapon( f35_local6, f35_local8 )
	return f35_local8, f35_local7
end

CoD.ZMLoadoutUtility.EquipArmoryAttachment = function ( f11_arg0, f11_arg1, f11_arg2, f11_arg3 )
	local f11_local0 = CoD.BaseUtility.GetMenuSessionMode( f11_arg0 )
	local f11_local1 = CoD.CACUtility.IsAttachmentOptic( f11_arg0._weaponItemIndex, f11_arg2, f11_local0 )
	f11_arg0._isEditing = true
	for f11_local2 = 1, #f11_arg0._armoryAttachmentTable, 1 do
		if f11_arg0._armoryAttachmentTable[f11_local2].itemIndex == CoD.CACUtility.EmptyItemIndex and f11_arg0._armoryAttachmentTable[f11_local2].isOptic == f11_local1 then
			local f11_local5 = CoD.ZMLoadoutUtility.GetMutuallyExclusiveArmoryAttachments( f11_arg1, f11_arg0._weaponItemIndex, f11_arg2, f11_local0, true )
			for f11_local6 = 1, #f11_local5, 1 do
				local f11_local9 = f11_local5[f11_local6].attachmentIndex
				if CoD.CACUtility.EmptyItemIndex < f11_local9 then
					CoD.ZMLoadoutUtility.RemoveArmoryAttachment( f11_arg1, f11_arg0, f11_local9 )
				end
			end
			f11_arg0._armoryAttachmentTable[f11_local2] = {
				itemIndex = f11_arg2,
				isOptic = f11_local1,
				isUberAttachment = f11_arg3
			}
			return true
		end
	end
	return false
end