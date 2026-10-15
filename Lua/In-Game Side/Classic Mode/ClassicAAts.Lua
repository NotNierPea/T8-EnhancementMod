--[[
      .\hksc.exe '.\Scripts\ClassicAAts.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\ClassicAAts.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

CoD.Bo3AatHit = InheritFrom( LUI.UIElement )
CoD.Bo3AatHit.__defaultWidth = 1920
CoD.Bo3AatHit.__defaultHeight = 1080
CoD.Bo3AatHit.new = function ( menu, controller, leftAnchor, rightAnchor, left, right, topAnchor, bottomAnchor, top, bottom )
	local self = LUI.UIElement.new( leftAnchor, rightAnchor, left, right, topAnchor, bottomAnchor, top, bottom )
	self:setClass( CoD.Bo3AatHit )
	self.id = "Bo3AatHit"

	local icons = {
		[1] = RegisterImage( @"t7_hud_zm_aat_deadwire" ),
		[2] = RegisterImage( @"t7_hud_zm_aat_blastfurnace" ),
		[3] = RegisterImage( @"t7_hud_zm_aat_turned" ),
		[4] = RegisterImage( @"t7_hud_zm_aat_thunderwall" ),
		[5] = RegisterImage( @"t7_hud_zm_aat_fireworks" )
	}

	local hit = LUI.UIImage.new( 0.5, 0.5, -24, 24, 0.5, 0.5, -24, 72 )
	hit:setRGB( 1, 1, 1 )
	hit:setAlpha( 0 )
	hit:setImage( icons[1] )
	self:addElement( hit )
	self.hit = hit
	self.suppressStockHit = false

	local function HideStockHit()
		local feedback = menu.DamageFeedback
		if feedback == nil then
			return
		end
		feedback:setAlpha( 0 )
		if feedback.damage then
			feedback.damage:completeAnimation()
			feedback.damage:setAlpha( 0 )
		end
		if feedback.death then
			feedback.death:completeAnimation()
			feedback.death:setAlpha( 0 )
		end
	end

	local function ShowStockHit()
		self.suppressStockHit = false
		local feedback = menu.DamageFeedback
		if feedback ~= nil then
			feedback:setAlpha( 1 )
		end
	end

	if menu.DamageFeedback ~= nil and menu.DamageFeedback.bo3AatHooked ~= true then
		menu.DamageFeedback.bo3AatHooked = true
		LUI.OverrideFunction_CallOriginalSecond( menu.DamageFeedback, "setState", function ( element )
			if self.suppressStockHit then
				element:setAlpha( 0 )
				if element.damage then
					element.damage:completeAnimation()
					element.damage:setAlpha( 0 )
				end
				if element.death then
					element.death:completeAnimation()
					element.death:setAlpha( 0 )
				end
			end
		end )
	end

	self:registerEventHandler( "bo3_aat_restore_hit", function ( element )
		ShowStockHit()
		if element.restoreTimer ~= nil then
			element.restoreTimer:close()
			element.restoreTimer = nil
		end
	end )

	hit:subscribeToGlobalModel( controller, "PerController", "scriptNotify", function ( model )
		if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"notify_bo3_aat_hit" ) then
			local scriptData = CoD.GetScriptNotifyData( model )
			local icon = icons[scriptData[1]]
			if icon ~= nil then
				self.suppressStockHit = true
				HideStockHit()
				if self.restoreTimer ~= nil then
					self.restoreTimer:reset()
				else
					self.restoreTimer = LUI.UITimer.new( 650, "bo3_aat_restore_hit", true )
					self:addElement( self.restoreTimer )
				end
				hit:completeAnimation()
				hit:setImage( icon )
				hit:setAlpha( 1 )
				hit:beginAnimation( 400 )
				hit:setAlpha( 0 )
			end
		end
	end )

	return self
end
