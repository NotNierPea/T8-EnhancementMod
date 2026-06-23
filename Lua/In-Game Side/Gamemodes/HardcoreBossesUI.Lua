--[[
      .\hksc.exe '.\Scripts\HardcoreBossesUI.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\HardcoreBossesUI.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------


CoD.ZmAmmo_ParticleFX_Boss = InheritFrom( LUI.UIElement )
CoD.ZmAmmo_ParticleFX_Boss.__defaultWidth = 1920
CoD.ZmAmmo_ParticleFX_Boss.__defaultHeight = 1080
CoD.ZmAmmo_ParticleFX_Boss.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.ZmAmmo_ParticleFX_Boss )
	self.id = "ZmAmmo_ParticleFX_Boss"
	self.soundSet = "default"
	
	local p1 = LUI.UIImage.new( 0, 1, 0, 215, 0, 1, 0, 112 )
	p1:setImage( RegisterImage( @"uie_t7_zm_derriese_hud_ammo_projection_p1" ) )
	p1:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_tile_scroll_normal" ) )
	p1:setShaderVector( 0, 1, 1, 0, 0 )
	p1:setShaderVector( 1, 0.05, 0, 0, 0 )
	self:addElement( p1 )
	self.p1 = p1
	
	local p2 = LUI.UIImage.new( 0, 1, 0, 215, 0, 1, 0, 112 )
	p2:setImage( RegisterImage( @"uie_t7_zm_derriese_hud_ammo_projection_p2" ) )
	p2:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_tile_scroll_normal" ) )
	p2:setShaderVector( 0, 1, 1, 0, 0 )
	p2:setShaderVector( 1, 0.3, 0, 0, 0 )
	self:addElement( p2 )
	self.p2 = p2
	
	local p3 = LUI.UIImage.new( 0, 1, 0, 215, 0, 1, 0, 112 )
	p3:setImage( RegisterImage( @"uie_t7_zm_derriese_hud_ammo_projection_p3" ) )
	p3:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_tile_scroll_normal" ) )
	p3:setShaderVector( 0, 1, 1, 0, 0 )
	p3:setShaderVector( 1, 0.7, 0, 0, 0 )
	self:addElement( p3 )
	self.p3 = p3
	
	local mask = LUI.UIImage.new( 0, 1, 0, 215, 0, 1, 0, 112 )
	mask:setRGB( 0, 0, 0 )
	mask:setImage( RegisterImage( @"uie_t7_zm_derriese_hud_ammo_projection_mask" ) )
	self:addElement( mask )
	self.mask = mask
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.ApplyHardcoreBossesUI = function(hud, controller, ElixirsPC, ElixirsConsole)
      local FadeColor = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
      FadeColor:setAlpha(0)
      hud.FadeColor = FadeColor
      hud:addElement(FadeColor)

      hud.BossParticleRight = nil
      hud.BossParticleLeft = nil

      -- right side
      local ZmAmmoParticleFX3right = CoD.ZmAmmo_ParticleFX_Boss.new( hud, controller, 0.00, 1.00, -100.00, 0.00, 1.00, 0.00, 0.00, 800.00 )
      ZmAmmoParticleFX3right:setRGB( 0, 1, 1 )
      ZmAmmoParticleFX3right:setAlpha( 0 )
      ZmAmmoParticleFX3right:setRFTMaterial( LUI.UIImage.GetCachedMaterial( @"ui_add" ) )
      ZmAmmoParticleFX3right.p1:setAlpha( 1 )
      ZmAmmoParticleFX3right.p2:setAlpha( 1 )
      ZmAmmoParticleFX3right.p3:setAlpha( 1 )
      hud:addElement( ZmAmmoParticleFX3right )
      hud.ZmAmmoParticleFX3right = ZmAmmoParticleFX3right

      hud.BossParticleRight = ZmAmmoParticleFX3right

      -- left side
      local ZmAmmoParticleFX3left = CoD.ZmAmmo_ParticleFX_Boss.new( hud, controller, 0.00, 1.00, -100.00, 0.00, 1.00, 0.00, 0.00, 800.00 )
      ZmAmmoParticleFX3left:setRGB( 0, 1, 1 )
      ZmAmmoParticleFX3left:setAlpha( 0 )
      ZmAmmoParticleFX3left:setZRot(180) -- left and top little
      ZmAmmoParticleFX3left:setRFTMaterial( LUI.UIImage.GetCachedMaterial( @"ui_add" ) )
      ZmAmmoParticleFX3left.p1:setAlpha( 1 )
      ZmAmmoParticleFX3left.p2:setAlpha( 1 )
      ZmAmmoParticleFX3left.p3:setAlpha( 1 )
      hud:addElement( ZmAmmoParticleFX3left )
      hud.ZmAmmoParticleFX3left = ZmAmmoParticleFX3left

      hud.BossParticleLeft = ZmAmmoParticleFX3left

      hud:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
      if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"notify_boss_ui" ) then
            local scriptData = CoD.GetScriptNotifyData(model)

            if scriptData[1] == 0 then
                  -- remove ui
                  ElixirsPC.fourthElixir.Cross:setImage(RegisterImage(@"hash_469BEFB7E55FBA50"))
                  ElixirsPC.thirdElixir.Cross:setImage(RegisterImage(@"hash_469BEFB7E55FBA50"))
                  ElixirsPC.secondElixir.Cross:setImage(RegisterImage(@"hash_469BEFB7E55FBA50"))
                  ElixirsPC.firstElixir.Cross:setImage(RegisterImage(@"hash_469BEFB7E55FBA50"))

                  ElixirsConsole.left.Cross:setImage(RegisterImage(@"hash_469BEFB7E55FBA50"))
                  ElixirsConsole.bottom.Cross:setImage(RegisterImage(@"hash_469BEFB7E55FBA50"))
                  ElixirsConsole.right.Cross:setImage(RegisterImage(@"hash_469BEFB7E55FBA50"))
                  ElixirsConsole.up.Cross:setImage(RegisterImage(@"hash_469BEFB7E55FBA50"))

                  if hud.BossParticleRight ~= nil then
                        hud.BossParticleRight:setAlpha(0)
                  end

                  if hud.BossParticleLeft ~= nil then
                        hud.BossParticleLeft:setAlpha(0)
                  end

                  hud:setRGB(1, 1, 1)
            elseif scriptData[1] == 1 then
                  -- enable ui
            elseif scriptData[1] == 2 then
                  -- fade blue
                  hud.FadeColor:setRGB(0, 0, 1)
                  hud.FadeColor:beginAnimation("fadein", 1500)
                  hud.FadeColor:setAlpha(1)

                  ElixirsPC.fourthElixir.Cross:setImage(RegisterImage(@"boss_lock"))
                  ElixirsPC.thirdElixir.Cross:setImage(RegisterImage(@"boss_lock"))
                  ElixirsPC.secondElixir.Cross:setImage(RegisterImage(@"boss_lock"))
                  ElixirsPC.firstElixir.Cross:setImage(RegisterImage(@"boss_lock"))

                  ElixirsConsole.left.Cross:setImage(RegisterImage(@"boss_lock"))
                  ElixirsConsole.bottom.Cross:setImage(RegisterImage(@"boss_lock"))
                  ElixirsConsole.right.Cross:setImage(RegisterImage(@"boss_lock"))
                  ElixirsConsole.up.Cross:setImage(RegisterImage(@"boss_lock"))

                  if hud.BossParticleRight ~= nil then
                        hud.BossParticleRight:setAlpha(1)
                  end

                  if hud.BossParticleLeft ~= nil then
                        hud.BossParticleLeft:setAlpha(1)
                  end
                  
            elseif scriptData[1] == 3 then
                  -- stop fade blue
                  hud:setRGB(0.60, 0.60, 1)

                  hud.FadeColor:beginAnimation("fadeout", 1000)
                  hud.FadeColor:setAlpha(0)

            elseif scriptData[1] == 4 then
                  -- fade red
                  hud.FadeColor:setRGB(1, 0, 0)
                  hud.FadeColor:beginAnimation("fadein", 3000)
                  hud.FadeColor:setAlpha(1)

                  ElixirsPC.fourthElixir.Cross:setImage(RegisterImage(@"boss_lock_p"))
                  ElixirsPC.thirdElixir.Cross:setImage(RegisterImage(@"boss_lock_p"))
                  ElixirsPC.secondElixir.Cross:setImage(RegisterImage(@"boss_lock_p"))
                  ElixirsPC.firstElixir.Cross:setImage(RegisterImage(@"boss_lock_p"))

                  ElixirsConsole.left.Cross:setImage(RegisterImage(@"boss_lock_p"))
                  ElixirsConsole.bottom.Cross:setImage(RegisterImage(@"boss_lock_p"))
                  ElixirsConsole.right.Cross:setImage(RegisterImage(@"boss_lock_p"))
                  ElixirsConsole.up.Cross:setImage(RegisterImage(@"boss_lock_p"))

                  -- set particles to red
                  if hud.BossParticleRight ~= nil then
                        hud.BossParticleRight:setRGB(1, 0, 0)
                  end

                  if hud.BossParticleLeft ~= nil then
                        hud.BossParticleLeft:setRGB(1, 0, 0)
                  end
                  
            elseif scriptData[1] == 5 then
                  -- stop fade red
                  hud:setRGB(1, 0.60, 0.60)

                  hud.FadeColor:beginAnimation("fadeout", 1000)
                  hud.FadeColor:setAlpha(0)
            elseif scriptData[1] == 6 then
                  -- fade pink
                  hud.FadeColor:setRGB(1, 0, 0.60)
                  hud.FadeColor:beginAnimation("fadein", 1500)
                  hud.FadeColor:setAlpha(1)

                  ElixirsPC.fourthElixir.Cross:setImage(RegisterImage(@"boss_lock_p"))
                  ElixirsPC.thirdElixir.Cross:setImage(RegisterImage(@"boss_lock_p"))
                  ElixirsPC.secondElixir.Cross:setImage(RegisterImage(@"boss_lock_p"))
                  ElixirsPC.firstElixir.Cross:setImage(RegisterImage(@"boss_lock_p"))

                  ElixirsConsole.left.Cross:setImage(RegisterImage(@"boss_lock_p"))
                  ElixirsConsole.bottom.Cross:setImage(RegisterImage(@"boss_lock_p"))
                  ElixirsConsole.right.Cross:setImage(RegisterImage(@"boss_lock_p"))
                  ElixirsConsole.up.Cross:setImage(RegisterImage(@"boss_lock_p"))

                  if hud.BossParticleRight ~= nil then
                        hud.BossParticleRight:setAlpha(1)
                        hud.BossParticleRight:setRGB(1, 0, 0)
                  end

                  if hud.BossParticleLeft ~= nil then
                        hud.BossParticleLeft:setAlpha(1)
                        hud.BossParticleLeft:setRGB(1, 0, 0)
                  end

            elseif scriptData[1] == 7 then
                  -- stop fade pink
                  hud:setRGB(1, 0.50, 0.70)

                  hud.FadeColor:beginAnimation("fadeout", 1000)
                  hud.FadeColor:setAlpha(0)
            elseif scriptData[1] == 8 then
                  -- fade yellow
                  hud.FadeColor:setRGB(1, 1, 0)
                  hud.FadeColor:beginAnimation("fadein", 1500)
                  hud.FadeColor:setAlpha(1)

                  ElixirsPC.fourthElixir.Cross:setImage(RegisterImage(@"boss_lock_b"))
                  ElixirsPC.thirdElixir.Cross:setImage(RegisterImage(@"boss_lock_b"))
                  ElixirsPC.secondElixir.Cross:setImage(RegisterImage(@"boss_lock_b"))
                  ElixirsPC.firstElixir.Cross:setImage(RegisterImage(@"boss_lock_b"))

                  ElixirsConsole.left.Cross:setImage(RegisterImage(@"boss_lock_b"))
                  ElixirsConsole.bottom.Cross:setImage(RegisterImage(@"boss_lock_b"))
                  ElixirsConsole.right.Cross:setImage(RegisterImage(@"boss_lock_b"))
                  ElixirsConsole.up.Cross:setImage(RegisterImage(@"boss_lock_b"))

                  if hud.BossParticleRight ~= nil then
                        hud.BossParticleRight:setAlpha(1)
                        hud.BossParticleRight:setRGB(1, 1, 0)
                  end

                  if hud.BossParticleLeft ~= nil then
                        hud.BossParticleLeft:setAlpha(1)
                        hud.BossParticleLeft:setRGB(1, 1, 0)
                  end

            elseif scriptData[1] == 9 then
                  -- stop fade yellow
                  hud:setRGB(1, 0.80, 0.60)

                  hud.FadeColor:beginAnimation("fadeout", 1000)
                  hud.FadeColor:setAlpha(0)
            end
      end
      end)
end