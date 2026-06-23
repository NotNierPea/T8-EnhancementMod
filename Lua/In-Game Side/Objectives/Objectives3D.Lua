--[[
      .\hksc.exe '.\Scripts\Objectives3D.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\Objectives3D.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

local VultureAidImage = {
      [1] = "vulture_box",
      [2] = "vulture_weap",
      [3] = "vulture_pap",
      [4] = "vulture_perk",
      [5] = "crafting_vulture"
}

local VultureAidImagePerks = {
      -- classic?
      [10] = "jugg_classic",
      [11] = "speed_classic",
      [12] = "double_classic",
      [13] = "vult_classic",
      [14] = "who_classic",
      [15] = "elem_classic",
      [16] = "vulture_perk",

      -- main
      [25] = "ui_icon_perks_blaze_phase_lg",
      [26] = "ui_icon_perks_zm_bandolierbandit_lg",
      [27] = "ui_icon_perks_zm_bloodwolfbite_lg",
      [28] = "",
      [29] = "ui_icon_perks_zm_deadshot_lg",
      [30] = "ui_icon_perks_zm_deathperception_lg",
      [31] = "ui_icon_perks_zm_dyingwish_lg",
      [32] = "ui_icon_perks_zm_electricburst_lg",
      [33] = "ui_icon_perks_zm_etherealrazor_lg",
      [34] = "ui_icon_perks_zm_mulekick_lg",
      [35] = "ui_icon_perks_zm_phdslider_lg",
      [36] = "ui_icon_perks_zm_quickrevive_lg",
      [37] = "ui_icon_perks_zm_secretsauce_lg",
      [38] = "ui_icon_perks_zm_staminup_lg",
      [39] = "ui_icon_perks_zm_stonecoldstronghold_lg",
      [40] = "ui_icon_perks_zm_timeslip_lg",
      [41] = "ui_icon_perks_zm_victorioustortoise_lg",
      [42] = "ui_icon_perks_zm_winterswail_lg",
      [43] = "ui_icon_perks_zombshell_lg",
}

------------------------

CoD.VultureContainer = InheritFrom( LUI.UIElement )
CoD.VultureContainer.__defaultWidth = 16
CoD.VultureContainer.__defaultHeight = 16
CoD.VultureContainer.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
      local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.VultureContainer )
	self.id = "VultureContainer"
	self.soundSet = "FriendsMenu"
	self.anyChildUsesUpdateState = true
	--f1_arg0:addElementToPendingUpdateStateList( self )

      local vulture_image = LUI.UIImage.new(0, 0, -16, 16, 0, 0, -16, 16)
      vulture_image:setRGB(1, 1, 1)
      vulture_image:setAlpha(1)
      self:addElement(vulture_image)
      self.vulture_image = vulture_image

      LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )

      if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.VultureContainer.__resetProperties = function ( f16_arg0 )
	
end

CoD.VultureContainer.__clipsPerState = {

}

CoD.VultureContainer.__onClose = function ( f19_arg0 )
      f19_arg0.vulture_image:close()
end

CoD.WeaponContainer3D = InheritFrom( LUI.UIElement )
CoD.WeaponContainer3D.__defaultWidth = 16
CoD.WeaponContainer3D.__defaultHeight = 16
CoD.WeaponContainer3D.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
      local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.WeaponContainer3D )
	self.id = "WeaponContainer3D"
	self.soundSet = "FriendsMenu"
	self.anyChildUsesUpdateState = true
	--f1_arg0:addElementToPendingUpdateStateList( self )

      local BG = LUI.UIImage.new( 0, 0, -150, 150, 0, 0, -30, 70 )
	BG:setRGB( 0, 0, 0 )
      BG:setAlpha( 0.75 )
	BG:setZRot( 180 )
	self:addElement( BG )
	self.BG = BG

      local Outline = LUI.UIImage.new( 0, 0, -150, 150, 0, 0, -30, 70 )
      Outline:setRGB( 1, 1, 1 )
	Outline:setAlpha( 0.05 )
	Outline:setImage( RegisterImage( @"uie_highlight_border_line" ) )
	Outline:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_nineslice_normal" ) )
	Outline:setShaderVector( 0, 0, 0, 0, 0 )
	Outline:setupNineSliceShader( 6, 6 )
	self:addElement( Outline )
	self.Outline = Outline

      self.weapon_text = LUI.UIText.new(0, 0, -100, 100, 0, 0, -30, 0)
      self.weapon_text:setTTF("notosans_bold")
	self.weapon_text:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(self.weapon_text)

      local weapon_image = LUI.UIImage.new(0, 0, -112, 112, 0, 0, 0, 64)
      weapon_image:setRGB(1, 1, 1)
      weapon_image:setAlpha(1)
      self:addElement(weapon_image)
      self.weapon_image = weapon_image

      LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )

      if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.WeaponContainer3D.__resetProperties = function ( f16_arg0 )
	
end

CoD.WeaponContainer3D.__clipsPerState = {

}

CoD.WeaponContainer3D.__onClose = function ( f19_arg0 )
      f19_arg0.weapon_image:close()
      f19_arg0.weapon_text:close()
      f19_arg0.Outline:close()
      f19_arg0.BG:close()
end

-- thanks to scrappy
CoD.Text3D = InheritFrom(LUI.UIElement)
CoD.Text3D.new = function(menu, controller)
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end

	self:setUseStencil(false)
	self:setClass(CoD.Text3D)
	self.id = "CoD.Text3D"
	self.soundSet = "HUD"
	self:setLeftRight(0, 0, -100, 100)
	self:setTopBottom(0, 0, -24.5, 24.5)
	self.anyChildUsesUpdateState = true

	self.Text = LUI.UIText.new(0, 0, -100, 100, 0, 0, -24.5, 24.5)

      if Engine[@"getdvarint"]("shield_enh_Damage_FontStyle") == 0 then
	      self.Text:setTTF("shield_damage")
            self.Text:setRGB(1, 0, 0)
            self.Text:setScale(0.55, 0.55)
      elseif Engine[@"getdvarint"]("shield_enh_Damage_FontStyle") == 1 then
            self.Text:setTTF("shield_mom")
      else
            self.Text:setTTF("notosans_bold")
      end


	self.Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(self.Text)
	
	LUI.OverrideFunction_CallOriginalSecond(self, "close", function(element)
		element.Text:close()
	end)

	if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end

	return self
end

CoD.Text3D.__clipsPerState = {
      DefaultState = {
            DefaultClip = function(event_self, event_arg1)
                  event_self:setupElementClipCounter(1)

                  event_self.Text:completeAnimation()
                  local randLeftRight = math.random(-70, 140)
                  local randTopBottom = math.random(50, 100)
                  event_self.Text:beginAnimation("keyframe", 1300, false, false, CoD.TweenType.Linear)
                  event_self.Text:setLeftRight(0, 0, -100 + randLeftRight, 100 + randLeftRight)
                  event_self.Text:setTopBottom(0, 0, -24.5 - randTopBottom, 24.5 - randTopBottom)
                  event_self.Text:setAlpha(0)
                  event_self.Text:registerEventHandler("transition_complete_keyframe", event_self.clipFinished)
            end
      }
}

CoD.Text3DContainer = InheritFrom(LUI.UIElement)
CoD.Text3DContainer.new = function(menu, controller)
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc(self, controller)
	end

	self:setUseStencil(false)
	self:setClass(CoD.Text3DContainer)
	self.id = "CoD.Text3DContainer"
	self.soundSet = "HUD"
	self:setLeftRight(0, 0, 0, 0)
	self:setTopBottom(0, 0, 0, 0)
	self.anyChildUsesUpdateState = true

	self.Text3D = CoD.Text3D.new(menu, controller)
	self:addElement(self.Text3D)

	LUI.OverrideFunction_CallOriginalSecond(self, "close", function(element)
		element.Text3D:close()
	end)

	if PostLoadFunc then
		PostLoadFunc(self, controller, menu)
	end

	return self
end

-- used for vulture images, weapon drops, damage numbers, extra stuff that are not needed to be in objectives, so we use lui's setupGeneric3DWidget instead.
CoD.Widgets3DContainer = InheritFrom( LUI.UIElement )
CoD.Widgets3DContainer.__defaultWidth = 1920
CoD.Widgets3DContainer.__defaultHeight = 1080
CoD.Widgets3DContainer.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
      local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.Widgets3DContainer )
	self.id = "Widgets3DContainer"
	self.soundSet = "FriendsMenu"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )

      self:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"enhancement_damage_visibility" ) then
                  local data = CoD.GetScriptNotifyData(model)
                  if data then
                        local Text3DContainer = CoD.Text3DContainer.new(self, controller)
                        
                        -- if 0, set to IMMUNE, if not then just the damage number.
                        if data[4] == 0 then
                              Text3DContainer.Text3D.Text:setText("IMMUNE")
                        else
                              Text3DContainer.Text3D.Text:setText(tostring(data[4]))
                        end

                        Text3DContainer:setupGeneric3DWidget(data[1], data[2], data[3])
                        Text3DContainer:setLeftRight(0, 0, 200, 300)
                        Text3DContainer:setTopBottom(0, 0, 300, 500)
                        
                        -- yellow if headshot
                        if data[5] == 1 then
                              Text3DContainer.Text3D.Text:setRGB(1, 1, 0) -- Set text color to yellow
                        end

                        Text3DContainer.Text3D:registerEventHandler("transition_complete_keyframe", function()
                              Text3DContainer:close()
                        end)

                        Text3DContainer.Text3D:playClip("DefaultClip")
                        Text3DContainer.Text3D:beginAnimation("keyframe", 1500, true, true)
                        self:addElement(Text3DContainer)
                  end
            end
      end)


      self.vultureImages = self.vultureImages or {}

      self:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"enhancement_vulture_visibility" ) then
                  local data = CoD.GetScriptNotifyData(model)
                  -- request, 1 add, 0 remove, 2 show, 3 hide
                  local Request = data[1]
                  local selfId = data[2]
                  local imageId = data[6]

                  if Request == 1 then
                        -- Add new vulture image
                        local vulture_container = CoD.VultureContainer.new(self, controller, 0, 0, -16, 16, 0, 0, -16, 16)
                        
                        if imageId < 10 then
                              vulture_container.vulture_image:setImage(RegisterImage(VultureAidImage[imageId] or @"vulture_box"))
                        else
                              vulture_container.vulture_image:setImage(RegisterImage(VultureAidImagePerks[imageId] or @"vulture_box"))
                        end

                        vulture_container:setupGeneric3DWidget(data[3], data[4], data[5])
                        vulture_container:setAlpha(0)
                        self:addElement(vulture_container)
                        self.vultureImages[selfId] = vulture_container

                  elseif Request == 0 then
                        -- Remove vulture image
                        local vulture_container = self.vultureImages[selfId]
                        if vulture_container then
                              vulture_container:close()
                              self.vultureImages[selfId] = nil
                        end

                  elseif Request == 2 then
                        -- Show vulture image
                        local vulture_container = self.vultureImages[selfId]
                        if vulture_container then
                              vulture_container:setAlpha(1)
                        end

                  elseif Request == 3 then
                        -- Hide vulture image
                        local vulture_container = self.vultureImages[selfId]
                        if vulture_container then
                              vulture_container:setAlpha(0)
                        end
                  end
            end
      end)

      self.whoswhoImages = self.whoswhoImages or {}

      self:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"enhancement_whoswho_visibility" ) then
                  local data = CoD.GetScriptNotifyData(model)
                  -- request, 1 add, 0 remove, 2 show, 3 hide
                  local Request = data[1]
                  local selfId = data[2]
                  local imageId = data[6]

                  if Request == 1 then
                        -- Add new whoswho image
                        local whoswho_container = CoD.VultureContainer.new(self, controller, 0, 0, -24, 24, 0, 0, -24, 24)
                        whoswho_container.vulture_image:setImage(RegisterImage(@"revive_whos"))
                        whoswho_container:setupGeneric3DWidget(data[3], data[4], data[5])
                        whoswho_container:setAlpha(1)
                        self:addElement(whoswho_container)
                        self.whoswhoImages[selfId] = whoswho_container

                  elseif Request == 0 then
                        -- Remove whoswho image
                        local whoswho_container = self.whoswhoImages[selfId]
                        if whoswho_container then
                              whoswho_container:close()
                              self.whoswhoImages[selfId] = nil
                        end
                  end
            end
      end)

      self.customImages = self.customImages or {}

      -- only used for AO's hardcore boss fight for now
      self:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"enhancement_custom_visibility" ) then
                  local data = CoD.GetScriptNotifyData(model)
                  -- request, 1 add, 0 remove, 2 show, 3 hide
                  local Request = data[1]
                  local selfId = data[2]
                  local imageId = data[6]

                  if Request == 1 then
                        -- Add new custom image
                        local custom_container = CoD.VultureContainer.new(self, controller, 0, 0, -64, 64, 0, 0, -64, 64)
                        custom_container.vulture_image:setLeftRight(0, 0, -64, 64)
                        custom_container.vulture_image:setTopBottom(0, 0, -64, 64)
                        custom_container.vulture_image:setImage(RegisterImage(@"t7_hud_mp_inventory_shockcharge"))
                        custom_container:setupGeneric3DWidget(data[3], data[4], data[5])
                        custom_container:setAlpha(1)
                        self:addElement(custom_container)
                        self.customImages[selfId] = custom_container

                  elseif Request == 0 then
                        -- Remove custom image
                        local custom_container = self.customImages[selfId]
                        if custom_container then
                              custom_container:close()
                              self.customImages[selfId] = nil
                        end
                  end
            end
      end)

      self.weaponImages = self.weaponImages or {}

      -- manual list for specials!
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

      self:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"enhancement_custom_weapon" ) then
                  local data = CoD.GetScriptNotifyData(model)
                  -- request, 1 add, 0 remove, 2 show, 3 hide
                  local Request = data[1]
                  local selfId = data[2]
                  local weaponID = data[6]

                  --CoD.EnhModPrintInfo("recived gsc weapon index -> " .. weaponID)

                  if Request == 1 then
                        local weapon_container = CoD.WeaponContainer3D.new(self, controller, 0, 0, -150, 150, 0, 0, -150, 150)
                        weapon_container:setupGeneric3DWidget(data[3], data[4], data[5])

                        if (weaponID < 500) then
                              weapon_container.weapon_image:setImage(RegisterImage(GetWeaponItemImageFromIndex(weaponID)))
                              weapon_container.weapon_text:setText( Engine[@"hash_4F9F1239CFD921FE"](GetItemNameFromIndex( Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"], weaponID ) ))
                        else
                              local Image = WeaponSpecialsImages[weaponID]
                              local Text = WeaponSpecialsTexts[weaponID]

                              weapon_container.weapon_image:setImage(RegisterImage(Image))
                              weapon_container.weapon_text:setText(Engine[@"hash_4F9F1239CFD921FE"](Text))
                        end
                        weapon_container:setAlpha(0)
                        self:addElement(weapon_container)
                        self.weaponImages[selfId] = weapon_container

                  elseif Request == 0 then
                        local weapon_container = self.weaponImages[selfId]
                        if weapon_container then
                              weapon_container:close()
                              self.weaponImages[selfId] = nil
                        end
                  elseif Request == 3 then
                        local weapon_container = self.weaponImages[selfId]
                        if weapon_container then
                              weapon_container:setAlpha(1)
                        end
                  elseif Request == 4 then
                        local weapon_container = self.weaponImages[selfId]
                        if weapon_container then
                              weapon_container:setAlpha(0)
                        end
                  end
            end
      end)

      self:mergeStateConditions( {
		{
			stateName = "Hidden",
			condition = function ( menu, element, event )
				local f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"] )
				if not f12_local0 then
					f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"] )
					if not f12_local0 then
						f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"] )
						if not f12_local0 then
							f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"] )
							if not f12_local0 then
								if Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"] ) then
									f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"] )
									if not f12_local0 then
										f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"] )
										if not f12_local0 then
											f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"] )
											if not f12_local0 then
												f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"] )
												if not f12_local0 then
													f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"] )
													if not f12_local0 then
														f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"] )
														if not f12_local0 then
															f12_local0 = Engine[@"isvisibilitybitset"]( f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"] )
														end
													end
												end
											end
										end
									end
								else
									f12_local0 = true
								end
							end
						end
					end
				end
				return f12_local0
			end
		}
	} )
      
      local f1_local12 = self
	local f1_local13 = self.subscribeToModel
	local f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function ( f13_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function ( f14_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function ( f15_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function ( f16_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function ( f17_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function ( f18_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function ( f19_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function ( f20_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function ( f21_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function ( f22_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function ( f23_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]
		} )
	end, false )
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"]( f1_arg1 )
	f1_local13( f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function ( f24_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]
		} )
	end, false )

      LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )

      if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.Widgets3DContainer.__resetProperties = function ( f16_arg0 )

end

CoD.Widgets3DContainer.__clipsPerState = {

}

CoD.Widgets3DContainer.__onClose = function ( f19_arg0 )

end