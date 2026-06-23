--[[
      .\hksc.exe '.\Scripts\CharacterSelect.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\CharacterSelect.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

local function SendClassOptionCharacter(ID_Choice)
      CoD.BaseUtility.SendCustomMenuResponse(Engine[@"getprimarycontroller"](), "shield_enh_class_changes", "shield_enh_character_choose", ID_Choice)
end

------------------------

DataSources.ShieldCharactersList = DataSourceHelpers.ListSetup( "ShieldCharactersList", function ( f3_arg0, f3_arg1 )
      local filters = {}
      local allCharacters = {}

      -- Get current lobby map
      local LobbyMap = Engine[@"converttoxhash"]( Engine[@"lobbygetmap"]() )
      local MapsTable = LuaUtils.GetMapsTable()
      local MapInfo = MapsTable[LobbyMap]

      -- Add current map characters first
      if MapInfo and MapInfo.zmCharacters then
            for nums, char in pairs( MapInfo.zmCharacters ) do
                  table.insert(filters, {
                        models = {
                              name = Engine[@"hash_4F9F1239CFD921FE"]( GetCharacterDisplayNameByIndex( char.characterIndex ) ),
                              image = GetPositionDraftStatePortraitByIndex( CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_NORMAL, char.characterIndex ),
                              request_id = char.characterIndex,
                              active = Engine[@"getdvarint"]("shield_enh_saved_character") == char.characterIndex,
                              is_small = true
                        },
                        properties = {}
                  })
                  allCharacters[char.characterIndex] = true
            end
      end

      -- Add all other characters from all maps
      for mapHash, mapData in pairs( MapsTable ) do
            if mapData.zmCharacters then
                  for nums, char in pairs( mapData.zmCharacters ) do
                        if not allCharacters[char.characterIndex] then
                              table.insert(filters, {
                                    models = {
                                          name = Engine[@"hash_4F9F1239CFD921FE"]( GetCharacterDisplayNameByIndex( char.characterIndex ) ),
                                          image = GetPositionDraftStatePortraitByIndex( CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_NORMAL, char.characterIndex ),
                                          request_id = char.characterIndex,
                                          active = Engine[@"getdvarint"]("shield_enh_saved_character") == char.characterIndex,
                                          is_small = true
                                    },
                                    properties = {}
                              })
                              allCharacters[char.characterIndex] = true
                        end
                  end
            end
      end

      return filters
end, true )

------------------------

CoD.SetupSubModelForSave_Character = function(hud, controller)
      hud:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"shield_enh_saved_character" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)
                  Engine[@"setdvar"]("shield_enh_saved_character", scriptData[1])
            end
      end)
end

------------------------

CoD.ShieldEnhClassOptionsCharacter = InheritFrom( CoD.Menu )
LUI.createMenu.ShieldEnhClassOptionsCharacter = function ( f1_arg0, f1_arg1 )
	local self = CoD.Menu.NewForUIEditor( "ShieldEnhClassOptionsCharacter", f1_arg0 )
	local f1_local1 = self
	self:setClass( CoD.ShieldEnhClassOptionsCharacter )
	self.soundSet = "none"
	self:setOwner( f1_arg0 )
	self:setLeftRight( 0, 1, 0, 0 )
	self:setTopBottom( 0, 1, 0, 0 )
	self:playSound( "menu_open", f1_arg0 )
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList( self )
	
	local CommomCenteredPopup = CoD.CommonCenteredPopup.new( f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0 )
	CommomCenteredPopup.TitleText:setText("Select Character")
	CommomCenteredPopup.HeaderBackground:setAlpha( 0 )
	CommomCenteredPopup.HeaderTopBar:setAlpha( 0 )
	CommomCenteredPopup.HeaderBottomBar:setAlpha( 0 )
	self:addElement( CommomCenteredPopup )
	self.CommomCenteredPopup = CommomCenteredPopup

      -- Characters
      local CharacterList = LUI.UIList.new( f1_local1, f1_arg0, 10, 0, nil, false, false, false, false )
	CharacterList:setLeftRight( 0.50, 0.50, 0.00, 426.00 )
	CharacterList:setTopBottom( 0.00, 0.00, 110.25, 857.25 )
	CharacterList:setVerticalCount(8)
	CharacterList:setHorizontalCount(1)
      CharacterList:setAutoScaleContent( true )
      CharacterList:setSpacing(-20)
	CharacterList:setWidgetType( CoD.SpecialWeaponSelection_Enh )
	CharacterList:setVerticalCounter( CoD.verticalCounter )
	CharacterList:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	CharacterList:setDataSource( "ShieldCharactersList" )

	f1_local1:AddButtonCallbackFunction( CharacterList, f1_arg0, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function ( element, menu, controller, model )
            PlaySoundAlias( "uin_toggle_generic" )
            
            -- get request id
            local request_id_get = element:getModel(model, "request_id")
            local request_id = request_id_get:get()

            SendClassOptionCharacter(request_id)
            Engine[@"setdvar"]("shield_enh_saved_character", request_id)
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

	self:addElement( CharacterList )
	self.CharacterList = CharacterList

    CharacterList.id = "CharacterList"

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

	self.__defaultFocus = CharacterList

	if CoD.isPC and (IsKeyboard( f1_arg0 ) or self.ignoreCursor) then
		self:restoreState( f1_arg0 )
	end
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg0 )
	end
	
	f1_local7 = self
	--MenuHidesFreeCursor( f1_local1, f1_arg0 )

	CoD.EnhModPrintInfo("Called", "Shield Character Class")

	return self
end

CoD.ShieldEnhClassOptionsCharacter.__resetProperties = function ( f13_arg0 )

end

CoD.ShieldEnhClassOptionsCharacter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f14_arg0, f14_arg1 )
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter( 0 )
		end
	},
}

CoD.ShieldEnhClassOptionsCharacter.__onClose = function ( f16_arg0 )
	f16_arg0.CommomCenteredPopup:close()
      f16_arg0.CharacterList:close()
end