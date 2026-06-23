--[[
      .\hksc.exe '.\Scripts\BGBSelect.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\BGBSelect.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

local function SendClassOptionBGB(Index_BGB, ID_Choice)
      CoD.BaseUtility.SendCustomMenuResponse(Engine[@"getprimarycontroller"](), "shield_enh_class_changes", Index_BGB, ID_Choice)
end

------------------------

DataSources.ShieldBGBMainIndexes = DataSourceHelpers.ListSetup( "ShieldBGBMainIndexes", function ( f3_arg0, f3_arg1 )
      local InfoBGBs = {}

      table.insert(InfoBGBs, {
            models = {
                  title = Engine[@"hash_4F9F1239CFD921FE"]( Engine[@"getitemname"]( Engine[@"getdvarint"]("shield_enh_saved_bgb0"), Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"] ) ),
                  icon = GetItemImageForIndex( Engine[@"getdvarint"]("shield_enh_saved_bgb0"), Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"] ),
                  index_id = 0
            },
            properties = {}
      })
      table.insert(InfoBGBs, {
            models = {
                  title = Engine[@"hash_4F9F1239CFD921FE"]( Engine[@"getitemname"]( Engine[@"getdvarint"]("shield_enh_saved_bgb1"), Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"] ) ),
                  icon = GetItemImageForIndex( Engine[@"getdvarint"]("shield_enh_saved_bgb1"), Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"] ),
                  index_id = 1
            },
            properties = {}
      })
      table.insert(InfoBGBs, {
            models = {
                  title = Engine[@"hash_4F9F1239CFD921FE"]( Engine[@"getitemname"]( Engine[@"getdvarint"]("shield_enh_saved_bgb2"), Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"] ) ),
                  icon = GetItemImageForIndex( Engine[@"getdvarint"]("shield_enh_saved_bgb2"), Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"] ),
                  index_id = 2
            },
            properties = {}
      })
      table.insert(InfoBGBs, {
            models = {
                  title = Engine[@"hash_4F9F1239CFD921FE"]( Engine[@"getitemname"]( Engine[@"getdvarint"]("shield_enh_saved_bgb3"), Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"] ) ),
                  icon = GetItemImageForIndex( Engine[@"getdvarint"]("shield_enh_saved_bgb3"), Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"] ),
                  index_id = 3
            },
            properties = {}
      })

      return InfoBGBs
end, true )

DataSources.ShieldBGBsList = DataSourceHelpers.ListSetup( "ShieldBGBsList", function ( f3_arg0, f3_arg1 )
      local filters = {}
      local array_temp = {}
      
      for id, bgb in pairs( CoD.CACUtility.GetUnlockableItemTable() ) do
            if bgb.itemGroup ~= nil then 
                  if bgb.itemGroup == "bubblegum_consumable" or bgb.itemGroup == "bubblegum" then
                        table.insert(array_temp, bgb)
                  end
            end
      end
      
      local rarityOrder = {
            [Enum[@"bgbrarity"][@"bgbrarity_common"]] = 1,
            [Enum[@"bgbrarity"][@"bgbrarity_rare"]] = 2,
            [Enum[@"bgbrarity"][@"bgbrarity_legendary"]] = 3,
            [Enum[@"bgbrarity"][@"bgbrarity_epic"]] = 4
      }
      
      table.sort( array_temp, function ( a, b )
            local rarityA = a[@"bgbrarity"]
            local rarityB = b[@"bgbrarity"]
            
            local orderA = rarityOrder[rarityA] or 0
            local orderB = rarityOrder[rarityB] or 0
            
            if orderA == orderB then
                  local nameA = tostring(Engine[@"hash_4F9F1239CFD921FE"](a.displayName) or "")
                  local nameB = tostring(Engine[@"hash_4F9F1239CFD921FE"](b.displayName) or "")
                  return nameA < nameB
            end
            return orderA < orderB
      end )
      
      --for _, bgb in ipairs( array_temp ) do
            --CoD.EnhModPrintInfo("BGB:", Engine[@"hash_4F9F1239CFD921FE"](bgb.displayName), "Rarity:", bgb[@"bgbrarity"])
      --end
      
      for _, bgb in ipairs( array_temp ) do
            local active_bgb = false

            for i = 0, 4 do
                  local try_see_active = Engine[@"getdvarint"]("shield_enh_saved_bgb" .. i)
                  --CoD.EnhModPrintInfo(try_see_active, bgb.itemIndex)
                  if try_see_active == bgb.itemIndex then
                        --CoD.EnhModPrintInfo("active bgb " .. Engine[@"hash_4F9F1239CFD921FE"](bgb.displayName))
                        active_bgb = true
                        break
                  end
            end

            table.insert(filters, {
                  models = {
                        name = Engine[@"hash_4F9F1239CFD921FE"](bgb.displayName),
                        image = bgb.previewImage,
                        request_id = bgb.globalItemIndex,
                        item_index = bgb.itemIndex,
                        active = active_bgb
                  },
                  properties = {}
            })
      end
      
      return filters
end, true )

------------------------

CoD.SetupSubModelForSave_BGB = function(hud, controller)
      hud:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"shield_enh_saved_bgbs" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)
                  Engine[@"setdvar"]("shield_enh_saved_bgb" .. scriptData[1], scriptData[2])
            end
      end)
end

------------------------

CoD.Shield_BGBStyleMain = InheritFrom( LUI.UIElement )
CoD.Shield_BGBStyleMain.__defaultWidth = 180
CoD.Shield_BGBStyleMain.__defaultHeight = 63
CoD.Shield_BGBStyleMain.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.Shield_BGBStyleMain )
	self.id = "Shield_BGBStyleMain"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local NoiseTiledBacking = CoD.Shield_WeaponsStyle.new( f1_arg0, f1_arg1, 0.5, 0.5, -70, 70, 0.5, 0.5, -97, 97 )
	NoiseTiledBacking:mergeStateConditions( {
		{
			stateName = "Locked",
			condition = function ( menu, element, event )
				return CoD.BaseUtility.IsSelfInState( self, "Locked" )
			end
		},
		{
			stateName = "Classified",
			condition = function ( menu, element, event )
				return CoD.BaseUtility.IsSelfInState( self, "Classified" )
			end
		},
		{
			stateName = "ClassifiedShowProgress",
			condition = function ( menu, element, event )
				return CoD.BaseUtility.IsSelfInState( self, "ClassifiedShowProgress" )
			end
		}
	} )
	NoiseTiledBacking:linkToElementModel( self, nil, false, function ( model )
		NoiseTiledBacking:setModel( model, f1_arg1 )
	end )
	NoiseTiledBacking:linkToElementModel( self, "title", true, function ( model )
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			NoiseTiledBacking.Label:setText( f6_local0 )
		end
	end )

	NoiseTiledBacking.FocusGlow:setAlpha(0)
	NoiseTiledBacking.FocusGlow:setRGB(0, 0, 0)

	NoiseTiledBacking.Label:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
	NoiseTiledBacking.Label:setAlignment( Enum[@"luialignment"][@"lui_alignment_middle"] )

	NoiseTiledBacking.Label:setLeftRight(0.00, 0.00, -1.00, 140.00)
	NoiseTiledBacking.Label:setTopBottom(0, 0, 93 + 50, 113 + 50)

	-- get the site for click datasource
	NoiseTiledBacking:linkToElementModel( self, "link", true, function ( model )
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			self.site = f6_local0
		end
	end )

	self:addElement( NoiseTiledBacking )
	self.NoiseTiledBacking = NoiseTiledBacking
	
	self:mergeStateConditions( {
		{
			stateName = "Locked",
			condition = function ( menu, element, event )
				return CoD.ModelUtility.IsSelfModelValueTrue( element, f1_arg1, "isLocked" )
			end
		},
		{
			stateName = "Classified",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "ClassifiedShowProgress",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		}
	} )
	self:linkToElementModel( self, "isLocked", true, function ( model )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLocked"
		} )
	end )
	LUI.OverrideFunction_CallOriginalFirst( self, "setState", function ( element, controller, f11_arg2, f11_arg3, f11_arg4 )
		UpdateElementState( self, "NoiseTiledBacking", controller )
	end )
	NoiseTiledBacking.id = "NoiseTiledBacking"
	self.__defaultFocus = NoiseTiledBacking
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.Shield_BGBStyleMain.__resetProperties = function ( f12_arg0 )
	f12_arg0.NoiseTiledBacking:completeAnimation()
	f12_arg0.NoiseTiledBacking:setScale( 1, 1 )
end

CoD.Shield_BGBStyleMain.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f13_arg0, f13_arg1 )
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter( 0 )
		end,
		ChildFocus = function ( f14_arg0, f14_arg1 )
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter( 1 )
			f14_arg0.NoiseTiledBacking:completeAnimation()
			f14_arg0.NoiseTiledBacking:setScale( 1.05, 1.05 )
			f14_arg0.clipFinished( f14_arg0.NoiseTiledBacking )
		end,
		GainChildFocus = function ( f15_arg0, f15_arg1 )
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter( 1 )
			local f15_local0 = function ( f16_arg0 )
				f15_arg0.NoiseTiledBacking:beginAnimation( 200 )
				f15_arg0.NoiseTiledBacking:setScale( 1.05, 1.05 )
				f15_arg0.NoiseTiledBacking:registerEventHandler( "interrupted_keyframe", f15_arg0.clipInterrupted )
				f15_arg0.NoiseTiledBacking:registerEventHandler( "transition_complete_keyframe", f15_arg0.clipFinished )
			end
			
			f15_arg0.NoiseTiledBacking:completeAnimation()
			f15_arg0.NoiseTiledBacking:setScale( 1, 1 )
			f15_local0( f15_arg0.NoiseTiledBacking )
		end,
		LoseChildFocus = function ( f17_arg0, f17_arg1 )
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter( 1 )
			local f17_local0 = function ( f18_arg0 )
				f17_arg0.NoiseTiledBacking:beginAnimation( 200 )
				f17_arg0.NoiseTiledBacking:setScale( 1, 1 )
				f17_arg0.NoiseTiledBacking:registerEventHandler( "interrupted_keyframe", f17_arg0.clipInterrupted )
				f17_arg0.NoiseTiledBacking:registerEventHandler( "transition_complete_keyframe", f17_arg0.clipFinished )
			end
			
			f17_arg0.NoiseTiledBacking:completeAnimation()
			f17_arg0.NoiseTiledBacking:setScale( 1.05, 1.05 )
			f17_local0( f17_arg0.NoiseTiledBacking )
		end
	},
	Locked = {
		DefaultClip = function ( f19_arg0, f19_arg1 )
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter( 0 )
		end
	},
	Classified = {
		DefaultClip = function ( f20_arg0, f20_arg1 )
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter( 0 )
		end
	},
	ClassifiedShowProgress = {
		DefaultClip = function ( f21_arg0, f21_arg1 )
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter( 0 )
		end
	}
}

CoD.Shield_BGBStyleMain.__onClose = function ( f22_arg0 )
	f22_arg0.NoiseTiledBacking:close()
end

CoD.ShieldEnhClassOptionsBGB = InheritFrom( CoD.Menu )
LUI.createMenu.ShieldEnhClassOptionsBGB = function ( f1_arg0, f1_arg1 )
	local self = CoD.Menu.NewForUIEditor( "ShieldEnhClassOptionsBGB", f1_arg0 )
	local f1_local1 = self
	self:setClass( CoD.ShieldEnhClassOptionsBGB )
	self.soundSet = "none"
	self:setOwner( f1_arg0 )
	self:setLeftRight( 0, 1, 0, 0 )
	self:setTopBottom( 0, 1, 0, 0 )
	self:playSound( "menu_open", f1_arg0 )
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList( self )
	
	local CommomCenteredPopup = CoD.CommonCenteredPopup.new( f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0 )
	CommomCenteredPopup.TitleText:setText("Select Elixirs")
	CommomCenteredPopup.HeaderBackground:setAlpha( 0 )
	CommomCenteredPopup.HeaderTopBar:setAlpha( 0 )
	CommomCenteredPopup.HeaderBottomBar:setAlpha( 0 )
	self:addElement( CommomCenteredPopup )
	self.CommomCenteredPopup = CommomCenteredPopup

      -- use shield_enh_saved_bgb1-4 for saved item_index from GSC, then we can use  Engine[@"getdvarint"]
      --f311_arg1:appendNotification( {
      --      clip = "TextandImageBGB",
      --      title = Engine[@"hash_4F9F1239CFD921FE"]( Engine[@"getitemname"]( f311_local1, Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"] ) ),
      --      description = Engine[@"hash_4F9F1239CFD921FE"]( Engine[@"getitemdesc"]( f311_local1, Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"] ) ),
      --      bgbImage = RegisterImage( GetItemImageForIndex( f311_local1, Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], Enum[@"emodes"][@"mode_zombies"] ) )
      --} )
      -- to display them i guess???

      local BGBMainList = LUI.UIList.new( f1_local1, f1_arg0, 10, 0, nil, false, false, false, false )
	BGBMainList:setLeftRight( 0.5, 0.5, -1300, 1300 )
	BGBMainList:setTopBottom( 0, 0, 115, 300 )
	BGBMainList:setVerticalCount(1)
	BGBMainList:setHorizontalCount(4)
      BGBMainList:setAutoScaleContent( true )
	BGBMainList:setSpacing( -15 )
	BGBMainList:setWidgetType( CoD.Shield_BGBStyleMain )
	BGBMainList:setVerticalCounter( CoD.verticalCounter )
	BGBMainList:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	BGBMainList:setDataSource( "ShieldBGBMainIndexes" )

      Engine[@"setdvar"]("shield_enh_selected_bgb_index", -1)

      local last_element = nil
	f1_local1:AddButtonCallbackFunction( BGBMainList, f1_arg0, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function ( element, menu, controller, model )
            PlaySoundAlias( "uin_toggle_generic" )

            if last_element == element then
                  return
            end
            
            -- get request id
            local index_id_get = element:getModel(model, "index_id")
            local index_id = index_id_get:get()

            CoD.EnhModPrintInfo("index_id", index_id)
            Engine[@"setdvar"]("shield_enh_selected_bgb_index", (index_id + 1))

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

	self:addElement( BGBMainList )
	self.BGBMainList = BGBMainList

      BGBMainList.id = "BGBMainList"

      -- bgbs
      local BGBList = LUI.UIList.new( f1_local1, f1_arg0, 10, 0, nil, false, false, false, false )
	BGBList:setLeftRight( 0.50, 0.50, 0.00, 426.00 )
	BGBList:setTopBottom( 0.00, 0.00, 335.25, 1000.25 )
	BGBList:setVerticalCount(6)
	BGBList:setHorizontalCount(1)
      BGBList:setAutoScaleContent( true )
      BGBList:setSpacing(-20)
	BGBList:setWidgetType( CoD.SpecialWeaponSelection_Enh )
	BGBList:setVerticalCounter( CoD.verticalCounter )
	BGBList:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	BGBList:setDataSource( "ShieldBGBsList" )

	f1_local1:AddButtonCallbackFunction( BGBList, f1_arg0, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function ( element, menu, controller, model )
            PlaySoundAlias( "uin_toggle_generic" )
            
            -- get item index
            local item_index_get = element:getModel(model, "item_index")
            local item_index = item_index_get:get()

            -- get gloabl item index
            local request_id_get = element:getModel(model, "request_id")
            local request_id = request_id_get:get()

            if Engine[@"getdvarint"]("shield_enh_selected_bgb_index") ~= -1 then
                  SendClassOptionBGB("bgb_" .. Engine[@"getdvarint"]("shield_enh_selected_bgb_index") .. "_enh", request_id)
                  Engine[@"setdvar"]("shield_enh_saved_bgb" .. Engine[@"getdvarint"]("shield_enh_selected_bgb_index") - (1), item_index)

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

	self:addElement( BGBList )
	self.BGBList = BGBList

      BGBList.id = "BGBList"

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

	self.__defaultFocus = BGBList

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

CoD.ShieldEnhClassOptionsBGB.__resetProperties = function ( f13_arg0 )

end

CoD.ShieldEnhClassOptionsBGB.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f14_arg0, f14_arg1 )
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter( 0 )
		end
	},
}

CoD.ShieldEnhClassOptionsBGB.__onClose = function ( f16_arg0 )
	f16_arg0.CommomCenteredPopup:close()
      f16_arg0.BGBMainList:close()
      f16_arg0.BGBList:close()
end