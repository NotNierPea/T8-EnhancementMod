--[[
      .\hksc.exe '.\Scripts\SpecialWeaponSelect.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\SpecialWeaponSelect.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

local function SendClassOption(ID_Choice)
      CoD.BaseUtility.SendCustomMenuResponse(Engine[@"getprimarycontroller"](), "shield_enh_class_changes", "blah", ID_Choice)
end

------------------------

DataSources.ShieldSpecialWeaponsList = DataSourceHelpers.ListSetup( "ShieldSpecialWeaponsList", function ( f3_arg0, f3_arg1 )
	local filters = {

      }

      local StoryID = CoD.ZMStoryUtility.GetCurrentMapStory()
      
      if StoryID ~= 1 then
            table.insert(filters, {
                  models = {
                        name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_7790ff78e52080c5"),
                        image = "ui_icon_equipment_zm_katana_lvl1_dark",
                        request_id = 1,
                        active = Engine[@"getdvarint"]("shield_enh_saved_special") == 1
                  },
                  properties = {}
            })
            table.insert(filters, {
                  models = {
                        name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_7345f0adb27a0044"),
                        image = "ui_icon_equipment_zm_gravityspikes_lvl1_dark",
                        request_id = 2,
                        active = Engine[@"getdvarint"]("shield_enh_saved_special") == 2
                  },
                  properties = {}
            })
            table.insert(filters, {
                  models = {
                        name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5ee1ca239eadc729"),
                        image = "ui_icon_equipment_zm_flamethrower_lvl1_dark",
                        request_id = 3,
                        active = Engine[@"getdvarint"]("shield_enh_saved_special") == 3
                  },
                  properties = {}
            })
            table.insert(filters, {
                  models = {
                        name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_e64c8db91f11686"),
                        image = "ui_icon_equipment_zm_minigun_lvl1_dark",
                        request_id = 4,
                        active = Engine[@"getdvarint"]("shield_enh_saved_special") == 4
                  },
                  properties = {}
            })
      end
      
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5180997d24e0b10b"),
                  image = "ui_icon_equpiment_zm_swordcannon_lv1_dark",
                  request_id = 6,
                  active = Engine[@"getdvarint"]("shield_enh_saved_special") == 5
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/hero_hammer"),
                  image = "ui_icon_equpiment_zm_meleehammer_lv1_dark",
                  request_id = 5,
                  active = Engine[@"getdvarint"]("shield_enh_saved_special") == 6
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/hero_chakram"),
                  image = "ui_icon_equpiment_zm_chakram_lv1_dark",
                  request_id = 7,
                  active = Engine[@"getdvarint"]("shield_enh_saved_special") == 7
            },
            properties = {}
      })
      table.insert(filters, {
            models = {
                  name = Engine[@"hash_4F9F1239CFD921FE"](@"zmweapon/hero_scepter"),
                  image = "ui_icon_equpiment_zm_rastaff_lv1_dark",
                  request_id = 8,
                  active = Engine[@"getdvarint"]("shield_enh_saved_special") == 8
            },
            properties = {}
      })

	return filters
end, true )

------------------------

CoD.SetupSubModelForSave_Specialist = function(hud, controller)
      hud:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"shield_enh_saved_special" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)
                  Engine[@"setdvar"]("shield_enh_saved_special", scriptData[1])
            end
      end)
end

------------------------

CoD.ShieldEnhClassOptions = InheritFrom( CoD.Menu )
LUI.createMenu.ShieldEnhClassOptions = function ( f1_arg0, f1_arg1 )
	local self = CoD.Menu.NewForUIEditor( "ShieldEnhClassOptions", f1_arg0 )
	local f1_local1 = self
	self:setClass( CoD.ShieldEnhClassOptions )
	self.soundSet = "none"
	self:setOwner( f1_arg0 )
	self:setLeftRight( 0, 1, 0, 0 )
	self:setTopBottom( 0, 1, 0, 0 )
	self:playSound( "menu_open", f1_arg0 )
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList( self )
	
	local CommomCenteredPopup = CoD.CommonCenteredPopup.new( f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0 )
	CommomCenteredPopup.TitleText:setText("Select Special Weapon")
	CommomCenteredPopup.HeaderBackground:setAlpha( 0 )
	CommomCenteredPopup.HeaderTopBar:setAlpha( 0 )
	CommomCenteredPopup.HeaderBottomBar:setAlpha( 0 )
	self:addElement( CommomCenteredPopup )
	self.CommomCenteredPopup = CommomCenteredPopup

      -- specialist
      local SpecialList = LUI.UIList.new( f1_local1, f1_arg0, 10, 0, nil, false, false, false, false )
	SpecialList:setLeftRight( 0.50, 0.50, -2161.00, 426.00 )
	SpecialList:setTopBottom( 0.00, 0.00, 110.25, 857.25 )
	SpecialList:setVerticalCount(8)
	SpecialList:setHorizontalCount(1)
      SpecialList:setAutoScaleContent( true )
      SpecialList:setSpacing(-20)
	SpecialList:setWidgetType( CoD.SpecialWeaponSelection_Enh )
	SpecialList:setVerticalCounter( CoD.verticalCounter )
	SpecialList:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	SpecialList:setDataSource( "ShieldSpecialWeaponsList" )

	f1_local1:AddButtonCallbackFunction( SpecialList, f1_arg0, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function ( element, menu, controller, model )
            PlaySoundAlias( "uin_toggle_generic" )
            
            -- get request id
            local request_id_get = element:getModel(model, "request_id")
            local request_id = request_id_get:get()

            SendClassOption(request_id)
            Engine[@"setdvar"]("shield_enh_saved_special", request_id)
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

	self:addElement( SpecialList )
	self.SpecialList = SpecialList

      SpecialList.id = "SpecialList"

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

	self.__defaultFocus = SpecialList

	if CoD.isPC and (IsKeyboard( f1_arg0 ) or self.ignoreCursor) then
		self:restoreState( f1_arg0 )
	end
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg0 )
	end
	
	f1_local7 = self
	--MenuHidesFreeCursor( f1_local1, f1_arg0 )

	CoD.EnhModPrintInfo("Called", "Shield Special Class")

	return self
end

CoD.ShieldEnhClassOptions.__resetProperties = function ( f13_arg0 )

end

CoD.ShieldEnhClassOptions.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f14_arg0, f14_arg1 )
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter( 0 )
		end
	},
}

CoD.ShieldEnhClassOptions.__onClose = function ( f16_arg0 )
	f16_arg0.CommomCenteredPopup:close()
      f16_arg0.SpecialList:close()
end