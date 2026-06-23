--[[
      .\hksc.exe '.\Scripts\SecondEquipments.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\SecondEquipments.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

CoD.ApplySecondEquipments = function(hud, controller, EquipmentsHud)
      -- Second Equipments
      local Second_Equipment = LUI.UIImage.new(0.00, 0.00, 64.00 - 6, 120.00 - 6, 0.00, 0.00, 3.00, 58.00)
      Second_Equipment:setScale(0.75, 0.75)
      Second_Equipment:setAlpha(0.5)
      Second_Equipment:setImage(RegisterImage(@"blacktransparent"))
      EquipmentsHud:addElement(Second_Equipment)
      EquipmentsHud.Second_Equipment = Second_Equipment

      -- Text
      local ZMEquipmentItemCounter = CoD.ZMEquipmentItemCounter.new( hud, controller, 0, 0, 36 - 6, 72 - 6, 0, 0, 40, 64 )
      ZMEquipmentItemCounter:setAlpha( 0.80 )
      ZMEquipmentItemCounter:setScale(0.75, 0.75)
      ZMEquipmentItemCounter.Quantity:setText( "" )
      ZMEquipmentItemCounter.Quantity:setLeftRight( 0.00, 0.00, 100.00, 100.00 )
      ZMEquipmentItemCounter.Quantity:setTopBottom( 0.00, 0.00, 0.00, 27.00 )
	EquipmentsHud:addElement( ZMEquipmentItemCounter )
	EquipmentsHud.ZMEquipmentItemCounter = ZMEquipmentItemCounter

      ZMEquipmentItemCounter:mergeStateConditions( {
		{
			stateName = "Hidden",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		}
	} )

      -- offset with althud
      if Engine[@"getdvarint"]("shield_enh_AltHud") == 1 then
            Second_Equipment:setLeftRight( 0.00, 0.00, 114.00, 170.00 )
            ZMEquipmentItemCounter.Quantity:setLeftRight( 0.00, 0.00, 176.00, 176.00 )
      end

      local Equipment_Table = {
            [901] = @"ui_icon_equipment_zm_homunculus_dark",
            [902] = @"ui_icon_inventory_cymbal_monkey", -- no dark version available..
            [903] = @"ui_icon_equipment_zm_tomahawk_dark",
            [904] = @"ui_icon_equipment_zm_snowball_dark",
            [905] = @"ui_icon_equipment_zm_snowball_dark",

            [906] = @"ui_icon_equipment_zm_music_box_dark",
            [907] = @"ui_icon_equipment_zm_nesting_doll_dark",

            [908] = @"ui_icon_inventory_zm_red_eqp_lightning_rod"
      }

      EquipmentsHud:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"shield_enh_equipment" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)
                  local Try_Image = nil

                  -- reset
                  if scriptData[1] == 1000 then
                        EquipmentsHud.Second_Equipment:setImage( RegisterImage(@"blacktransparent") )
                        EquipmentsHud.ZMEquipmentItemCounter.Quantity:setText( "" )
                        return
                  end

                  if scriptData[1] < 900 then
                        Try_Image = RegisterImage(GetWeaponItemImageFromIndex(scriptData[1]))
                  else
                        Try_Image = RegisterImage(Equipment_Table[scriptData[1]])
                  end

                  EquipmentsHud.Second_Equipment:setImage( Try_Image )
                  EquipmentsHud.ZMEquipmentItemCounter.Quantity:setText( CoD.BaseUtility.AlreadyLocalized( scriptData[2] ) )
            end
      end)
end