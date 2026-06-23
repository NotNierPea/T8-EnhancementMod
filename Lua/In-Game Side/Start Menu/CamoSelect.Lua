--[[
      .\hksc.exe '.\Scripts\CamoSelect.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\CamoSelect.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

local function SendClassOptionCamo(Index_Weapon, ID_Choice)
      CoD.BaseUtility.SendCustomMenuResponse(Engine[@"getprimarycontroller"](), "shield_enh_class_changes", Index_Weapon, ID_Choice)
end

------------------------

-- TODO: the camo indexes here seems to be wrong? most of them are not correct, gotta be checked, and also remove the duplicated ones.. (maybe they are reactives)
DataSources.ShieldCamosList = DataSourceHelpers.ListSetup( "ShieldCamosList", function ( f3_arg0, f3_arg1 )
      local filters = {}

      local bad_camo_images = {
            [0] = @"hash_4933ddd5fd3fae95",
            [1] = @"hash_0ab79626479f8daa",
            [2] = @"hash_231110df868a14bf",
            [3] = @"hash_23110fdf868a130c",
      }

      local camo_table = Engine[@"tablefindrows"]( CoD.attachmentTable, 1, "camo")
	if camo_table then
		for _, camo in ipairs( camo_table ) do
			local camo_name = Engine[@"hash_4C6F8EC444864600"]( CoD.attachmentTable, camo, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_name"] )
                  local camo_index = Engine[@"hash_4C6F8EC444864600"]( CoD.attachmentTable, camo, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_index"] )
                  local camo_image = Engine[@"hash_4C6F8EC444864600"]( CoD.attachmentTable, camo, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_image"] )

                  local active_status = false

                  if camo_index ~= nil then
                        for i = 0, 3 do
                              local try_see_active = Engine[@"getdvarint"]("shield_enh_saved_weapon_camo" .. i)
                              if try_see_active == camo_index then
                                    active_status = true
                                    break
                              end
                        end

                        if camo_name == nil then
                              camo_name = @"shield/unnamed_camo"
                        end

                        if camo_image == nil then
                              camo_image = @"blacktransparent"
                        end

                        -- debug
                        --local test_image = RegisterImage( camo_image )
                        --CoD.EnhModPrintInfo("camo image registered: " .. tostring(test_image) .. " for " .. tostring(camo_image))

                        -- check bad camo
                        for _, bad_camo_image in pairs(bad_camo_images) do
                              --CoD.EnhModPrintInfo("camo check: " .. tostring(camo_image) .. " vs " .. tostring(bad_camo_image))
                              if camo_image == bad_camo_image then
                                    --CoD.EnhModPrintInfo("bad camo found, replacing with default")
                                    camo_image = @"blacktransparent"
                                    break
                              end
                        end

                        table.insert(filters, {
                              models = {
                                    name = Engine[@"hash_4F9F1239CFD921FE"](camo_name),
                                    image = camo_image,
                                    request_id = camo_index,
                                    item_index = camo_index,
                                    active = active_status,
                                    is_small = true
                              },
                              properties = {}
                        })
                  end
		end
	end

      local camo_table2 = Engine[@"tablefindrows"]( CoD.CACUtility.CamoOptionsTable, 1, "camo")
      if camo_table2 then
            for _, camo in ipairs( camo_table2 ) do
			local camo_name = Engine[@"hash_4C6F8EC444864600"]( CoD.attachmentTable, camo, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_name"] )
                  local camo_index = Engine[@"hash_4C6F8EC444864600"]( CoD.attachmentTable, camo, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_index"] )
                  local camo_image = Engine[@"hash_4C6F8EC444864600"]( CoD.attachmentTable, camo, Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_image"] )

                  local active_status = false

                  if camo_index ~= nil then
                        for i = 0, 3 do
                              local try_see_active = Engine[@"getdvarint"]("shield_enh_saved_weapon_camo" .. i)
                              if try_see_active == camo_index then
                                    active_status = true
                                    break
                              end
                        end

                        if camo_name == nil then
                              camo_name = @"shield/unnamed_camo"
                        end

                        if camo_image == nil then
                              camo_image = @"blacktransparent"
                        end

                        -- debug
                        --local test_image = RegisterImage( camo_image )
                        --CoD.EnhModPrintInfo("camo image registered: " .. tostring(test_image) .. " for " .. tostring(camo_image))

                        -- check bad camo
                        for _, bad_camo_image in pairs(bad_camo_images) do
                              --CoD.EnhModPrintInfo("camo check: " .. tostring(camo_image) .. " vs " .. tostring(bad_camo_image))
                              if camo_image == bad_camo_image then
                                    --CoD.EnhModPrintInfo("bad camo found, replacing with default")
                                    camo_image = @"blacktransparent"
                                    break
                              end
                        end

                        table.insert(filters, {
                              models = {
                                    name = Engine[@"hash_4F9F1239CFD921FE"](camo_name),
                                    image = camo_image,
                                    request_id = camo_index,
                                    item_index = camo_index,
                                    active = active_status,
                                    is_small = true
                              },
                              properties = {}
                        })
                  end
		end
	end

      -- order them
      table.sort( filters, function ( a, b )
            return a.models.request_id < b.models.request_id
      end )

      -- remove duplicates
      --[[
      local seen = {}
      local unique_filters = {}
      for _, item in ipairs( filters ) do
            if not seen[item.models.request_id] then
                  seen[item.models.request_id] = true
                  table.insert( unique_filters, item )
            end
      end
      ]]
      
      return filters
end, true )

DataSources.ShieldWeaponMainIndexes = DataSourceHelpers.ListSetup( "ShieldWeaponMainIndexes", function ( f3_arg0, f3_arg1 )
      local InfoWeapons = {}

      local WeaponSpecialsImages = {
            [500] = @"hash_38208b311390cffb",
            [501] = @"hash_38208b311390cffb",

            [502] = @"hash_5d6013ed244ad82e",
            [503] = @"hash_6f96f7b76789aac2",
            [504] = @"hash_24074854d000a742",
            [505] = @"hash_2289301d453f2d17",
            [506] = @"hash_25740919ad0c89d7",

            [507] = @"ui_icon_weapons_zm_blundergat",
            [508] = @"ui_icon_weapons_zm_blundergat",
            [509] = @"ui_icon_weapons_zm_blundergat",

            [510] = @"hash_6c021551a1cc7457",
            [511] = @"hash_45BC5C96B44A5900",
            [512] = @"hash_45BC5D96B44A5AB3",

            [513] = @"ui_icon_weapons_zm_charon",
            [514] = @"ui_icon_weapons_zm_gaia",
            [515] = @"hash_7eeafad2e284cab9",
            [516] = @"ui_icon_weapons_zm_ouranos",
            [517] = @"ui_icon_weapons_zm_charon",
            [518] = @"ui_icon_weapons_zm_gaia",
            [519] = @"hash_7eeafad2e284cab9",
            [520] = @"ui_icon_weapons_zm_ouranos",

            [521] = @"ui_icon_weapon_ray_gun_mk2_xl",
            [522] = @"ui_icon_weapon_ray_gun_mk2x_xl",
            [523] = @"ui_icon_weapon_ray_gun_mk2y_xl",
            [524] = @"ui_icon_weapon_ray_gun_mk2z_xl",

            [525] = @"ui_icon_weapons_zm_thundergun",
            [530] = @"hash_25E0F029D4B69CE0",
            [526] = @"hash_490135AAF2E50681",
            [527] = @"hash_490135AAF2E50681",

            [528] = @"hash_648aefaf2d1c9156",
            [529] = @"hash_648aefaf2d1c9156",

            [530] = @"ui_icon_weapon_ray_gun_render",
            [531] = @"ui_icon_weapons_zm_raygun_mk2",
      }
      local WeaponSpecialsTexts = {
            [500] = @"zmweapon/ww_crossbow_t8",
            [501] = @"zmweapon/ww_crossbow_t8_upgraded",

            [502] = @"zmweapon/ww_tricannon_t8",
            [503] = @"zmweapon/ww_tricannon_fire_t8",
            [504] = @"zmweapon/ww_tricannon_earth_t8",
            [505] = @"zmweapon/ww_tricannon_water_t8",
            [506] = @"zmweapon/ww_tricannon_air_t8",

            [507] = @"zmweapon/blundergat",
            [508] = @"zmweapon/acidgat",
            [509] = @"zmweapon/magmagat",

            [510] = @"hash_4e413fbdde10b051",
            [511] = @"hash_25ddfdd724070696",
            [512] = @"hash_7b8a03d0c40ea097",

            [513] = @"hash_eb276333b85f293",
            [514] = @"hash_5e7b4f837b6c6744",
            [515] = @"hash_523af889850e67e6",
            [516] = @"hash_7022c47b56e0ed9f",
            [517] = @"hash_3aeda1b4f0b1547e",
            [518] = @"hash_2e94430f1fc60691",
            [519] = @"hash_367b6a2d351eb73f",
            [520] = @"hash_38bc1e3aad78424a",

            [521] = @"zmweapon/ray_gun_mk2v",
            [522] = @"zmweapon/ray_gun_mk2x",
            [523] = @"zmweapon/ray_gun_mk2y",
            [524] = @"zmweapon/ray_gun_mk2z",

            [525] = @"zmweapon/thundergun",
            [530] = @"zmweapon/tundragun",
            [526] = @"zombie/tesla_gun",
            [527] = @"hash_2283e591fbfea663",

            [528] = @"hash_1bdc86ecbb20fd14",
            [529] = @"zmweapon/ww_freezegun_t8_upgraded",

            [530] = @"weapon/ray_gun",
            [531] = @"zmweapon/ray_gun_mk2",
      }

      if (Engine[@"getdvarint"]("shield_enh_saved_weapon0") < 500) then
            table.insert(InfoWeapons, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](GetItemNameFromIndex( Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"], Engine[@"getdvarint"]("shield_enh_saved_weapon0") ) ),
                        icon = GetWeaponItemImageFromIndex( Engine[@"getdvarint"]("shield_enh_saved_weapon0") ),
                        index_id = 0
                  },
                  properties = {}
            })
      else
            table.insert(InfoWeapons, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](WeaponSpecialsTexts[ Engine[@"getdvarint"]("shield_enh_saved_weapon0") ] ),
                        icon = WeaponSpecialsImages[ Engine[@"getdvarint"]("shield_enh_saved_weapon0") ],
                        index_id = 0
                  },
                  properties = {}
            })
      end

      if (Engine[@"getdvarint"]("shield_enh_saved_weapon1") < 500) then
            table.insert(InfoWeapons, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](GetItemNameFromIndex( Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"], Engine[@"getdvarint"]("shield_enh_saved_weapon1") ) ),
                        icon = GetWeaponItemImageFromIndex( Engine[@"getdvarint"]("shield_enh_saved_weapon1") ),
                        index_id = 1
                  },
                  properties = {}
            })
      else
            table.insert(InfoWeapons, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](WeaponSpecialsTexts[ Engine[@"getdvarint"]("shield_enh_saved_weapon1") ] ),
                        icon = WeaponSpecialsImages[ Engine[@"getdvarint"]("shield_enh_saved_weapon1") ],
                        index_id = 1
                  },
                  properties = {}
            })
      end

      if (Engine[@"getdvarint"]("shield_enh_saved_weapon2") < 500) then
            table.insert(InfoWeapons, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](GetItemNameFromIndex( Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"], Engine[@"getdvarint"]("shield_enh_saved_weapon2") ) ),
                        icon = GetWeaponItemImageFromIndex( Engine[@"getdvarint"]("shield_enh_saved_weapon2") ),
                        index_id = 2
                  },
                  properties = {}
            })
      else
            table.insert(InfoWeapons, {
                  models = {
                        title = Engine[@"hash_4F9F1239CFD921FE"](WeaponSpecialsTexts[ Engine[@"getdvarint"]("shield_enh_saved_weapon2") ] ),
                        icon = WeaponSpecialsImages[ Engine[@"getdvarint"]("shield_enh_saved_weapon2") ],
                        index_id = 2
                  },
                  properties = {}
            })
      end

      return InfoWeapons
end, true )

------------------------

CoD.SetupSubModelForSave_Camo = function(hud, controller)
      hud:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"shield_enh_saved_weapons_camos" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)
                  Engine[@"setdvar"]("shield_enh_saved_weapon_camo" .. scriptData[1], scriptData[2])
            end
      end)
end

------------------------

CoD.ShieldEnhCamoOptions = InheritFrom( CoD.Menu )
LUI.createMenu.ShieldEnhCamoOptions = function ( f1_arg0, f1_arg1 )
	local self = CoD.Menu.NewForUIEditor( "ShieldEnhCamoOptions", f1_arg0 )
	local f1_local1 = self
	self:setClass( CoD.ShieldEnhCamoOptions )
	self.soundSet = "none"
	self:setOwner( f1_arg0 )
	self:setLeftRight( 0, 1, 0, 0 )
	self:setTopBottom( 0, 1, 0, 0 )
	self:playSound( "menu_open", f1_arg0 )
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList( self )

	local CommomCenteredPopup = CoD.CommonCenteredPopup.new( f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0 )
	CommomCenteredPopup.TitleText:setText("Select Camos")
	CommomCenteredPopup.HeaderBackground:setAlpha( 0 )
	CommomCenteredPopup.HeaderTopBar:setAlpha( 0 )
	CommomCenteredPopup.HeaderBottomBar:setAlpha( 0 )
	self:addElement( CommomCenteredPopup )
	self.CommomCenteredPopup = CommomCenteredPopup

      local WeaponMainIndexes = LUI.UIList.new( f1_local1, f1_arg0, 10, 0, nil, false, false, false, false )
	WeaponMainIndexes:setLeftRight( 0.5, 0.5, -1300, 1300 )
	WeaponMainIndexes:setTopBottom( 0, 0, 115, 300 )
	WeaponMainIndexes:setVerticalCount(1)
	WeaponMainIndexes:setHorizontalCount(4)
      WeaponMainIndexes:setAutoScaleContent( true )
	WeaponMainIndexes:setSpacing( -15 )
	WeaponMainIndexes:setWidgetType( CoD.Shield_WeaponIndexStyleMain )
	WeaponMainIndexes:setVerticalCounter( CoD.verticalCounter )
	WeaponMainIndexes:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	WeaponMainIndexes:setDataSource( "ShieldWeaponMainIndexes" )

      Engine[@"setdvar"]("shield_enh_selected_weapon_index", -1)

      local last_element = nil
	f1_local1:AddButtonCallbackFunction( WeaponMainIndexes, f1_arg0, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function ( element, menu, controller, model )
            PlaySoundAlias( "uin_toggle_generic" )

            if last_element == element then
                  return
            end
            
            -- get request id
            local index_id_get = element:getModel(model, "index_id")
            local index_id = index_id_get:get()

            CoD.EnhModPrintInfo("index_id", index_id)
            Engine[@"setdvar"]("shield_enh_selected_weapon_index", (index_id + 1))

            element:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)
            element:setRGB(1, 1, 0.75)

            if last_element ~= nil then
                  last_element:beginAnimation("keyframe", 100, false, false, CoD.TweenType.Linear)
                  last_element:setRGB(1, 1, 1)
            end
            last_element = element
            return true
	end, function ( element, menu, controller )
		if true then
			CoD.Menu.SetButtonLabel( menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], @"hash_6D0BB36CD318F55F", nil, "ui_confirm" )
			return true
		else
			return false
		end
	end, false )

	self:addElement( WeaponMainIndexes )
	self.WeaponMainIndexes = WeaponMainIndexes

      WeaponMainIndexes.id = "WeaponMainIndexes"

      -- Camos List
      local CamosList = LUI.UIList.new( f1_local1, f1_arg0, 10, 0, nil, false, false, false, false )
	CamosList:setLeftRight( 0.50, 0.50, 0.00, 426.00 )
	CamosList:setTopBottom( 0.00, 0.00, 335.25, 1000.25 )
	CamosList:setVerticalCount(6)
	CamosList:setHorizontalCount(1)
      CamosList:setAutoScaleContent( true )
      CamosList:setSpacing(-20)
	CamosList:setWidgetType( CoD.SpecialWeaponSelection_Enh )
	CamosList:setVerticalCounter( CoD.verticalCounter )
	CamosList:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	CamosList:setDataSource( "ShieldCamosList" )

	f1_local1:AddButtonCallbackFunction( CamosList, f1_arg0, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function ( element, menu, controller, model )
            PlaySoundAlias( "uin_toggle_generic" )
            
            -- get item index
            local item_index_get = element:getModel(model, "item_index")
            local item_index = item_index_get:get()

            -- get gloabl item index
            local request_id_get = element:getModel(model, "request_id")
            local request_id = request_id_get:get()

            if Engine[@"getdvarint"]("shield_enh_selected_weapon_index") ~= -1 then
                  SendClassOptionCamo("weapon_" .. Engine[@"getdvarint"]("shield_enh_selected_weapon_index") .. "_enh", request_id)
                  Engine[@"setdvar"]("shield_enh_saved_weapon_camo" .. Engine[@"getdvarint"]("shield_enh_selected_weapon_index") - (1), item_index)

                  CoD.EnhModPrintInfo("sending " .. item_index)
            end

            GoBack( self, controller )
            return true
	end, function ( element, menu, controller )
		if true then
			CoD.Menu.SetButtonLabel( menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], @"hash_6D0BB36CD318F55F", nil, "ui_confirm" )
			return true
		else
			return false
		end
	end, false )

	self:addElement( CamosList )
	self.CamosList = CamosList

      CamosList.id = "CamosList"

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

	self.__defaultFocus = CamosList

	if CoD.isPC and (IsKeyboard( f1_arg0 ) or self.ignoreCursor) then
		self:restoreState( f1_arg0 )
	end
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg0 )
	end
	
	f1_local7 = self
	--MenuHidesFreeCursor( f1_local1, f1_arg0 )

	CoD.EnhModPrintInfo("Called", "Shield Camos Menu")

	return self
end

CoD.ShieldEnhCamoOptions.__resetProperties = function ( f13_arg0 )

end

CoD.ShieldEnhCamoOptions.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f14_arg0, f14_arg1 )
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter( 0 )
		end
	},
}

CoD.ShieldEnhCamoOptions.__onClose = function ( f16_arg0 )
	f16_arg0.CommomCenteredPopup:close()
      f16_arg0.WeaponMainIndexes:close()
      f16_arg0.CamosList:close()
end