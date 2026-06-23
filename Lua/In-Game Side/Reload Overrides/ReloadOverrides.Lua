--[[
      .\hksc.exe '.\Scripts\ReloadOverrides.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\ReloadOverrides.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

CoD.LoadShitAgain = function()
	CoD.PowerUpsTimerReload()
	CoD.ZMInventoryReload()
	CoD.GameOverReload()
	CoD.RoundContainerReload()
	CoD.StartMenuReload()
	CoD.MorePlayersFixesReload()
	CoD.IXCrowdMeterFixReload()
	CoD.RemoveErrorBoxesReload()
	CoD.ObjectivesReload()
	CoD.AchievementsReload()
	CoD.WeaponPosAltHudFix()
end

-- Load AltHuds, and other stuff
CoD.PC_Notif_Container = InheritFrom( LUI.UIElement )
CoD.PC_Notif_Container.__defaultWidth = 450
CoD.PC_Notif_Container.__defaultHeight = 100
CoD.PC_Notif_Container.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	CoD.PCUtility.StartAddingSticky( f1_arg0, self )
	CoD.PCNotificationsUtility.PreSetupNotificationWidget( self, f1_arg0, f1_arg1 )
	self:setUseCylinderMapping( false )
	self:setClass( CoD.PC_Notif_Container )
	self.id = "PC_Notif_Container"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )
	local PCNotif = nil
	
	PCNotif = CoD.PC_Notif.new( f1_arg0, f1_arg1, 0.5, 0.5, -225, 225, 0, 0, 0, 100 )
	self:addElement( PCNotif )
	self.PCNotif = PCNotif
	
	self:mergeStateConditions( {
		{
			stateName = "Invisible",
			condition = function ( menu, element, event )
				return not CoD.PCNotificationsUtility.IsNotificationWidgetVisible( f1_arg1 )
			end
		}
	} )
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"hash_4DF5CFBC1771947"]( f1_arg1 )
	f1_local3( f1_local2, f1_local4["PC.CurrentNotification.visibility"], function ( f3_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "PC.CurrentNotification.visibility"
		} )
	end, false )
	LUI.OverrideFunction_CallOriginalFirst( self, "setState", function ( element, controller, f4_arg2, f4_arg3, f4_arg4 )
		if IsSelfInState( self, "Invisible" ) and IsElementPropertyValue( self, "__wasOpen", true ) then
			PlayClip( self, "Out", controller )
			SetElementProperty( self, "__wasOpen", false )
			SetLoseFocusToSelf( self, controller )
		elseif IsInDefaultState( element ) then
			PlayClip( self, "In", controller )
			SetElementProperty( self, "__wasOpen", true )
		end
	end )
	if CoD.isPC then
		PCNotif.id = "PCNotif"
	end
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	f1_local3 = self
	CoD.PCNotificationsUtility.PrepareNotificationContainer( self, f1_arg1, f1_arg0, self.PCNotif )
	DisableKeyboardNavigationByElement( self )
	CoD.PCUtility.StopAddingSticky( f1_arg0 )

	if f1_arg0.LoadingScreenSharedCPZM ~= nil then 
		CoD.EnhModPrintInfo("Called", "PC Notif Container -> AltHuds")

		local Loading_ZM = f1_arg0
		local LoadingShared = Loading_ZM.LoadingScreenSharedCPZM

		LoadingShared.loadingBar:subscribeToGlobalModel( f1_arg1, "LoadingScreenTeamInfo", "loadedFraction", function ( model )
				local f3_local0 = model:get()
				if f3_local0 ~= nil then

					-- ! reload it multiple times to make sure this fucking shit gets loaded

					if Engine[@"getdvarint"]("shield_enh_AltHud") == 1 then
							-- for co-op
							CoD.LoadAltHuds()
					end

					CoD.LoadShitAgain()

					LoadingShared.loadingBar:setRGB(1, 0, 1)
					LoadingShared.loadingBar:setShaderVector( 0, CoD.GetVectorComponentFromString( f3_local0, 1 ), CoD.GetVectorComponentFromString( f3_local0, 2 ), CoD.GetVectorComponentFromString( f3_local0, 3 ), CoD.GetVectorComponentFromString( f3_local0, 4 ) )
				end
		end )
	end

	-- for solo
	if Engine[@"getdvarint"]("shield_enh_AltHud") == 1 then
		CoD.LoadAltHuds()
	end

	CoD.LoadShitAgain()

	return self
end

CoD.PC_Notif_Container.__resetProperties = function ( f5_arg0 )
	f5_arg0.PCNotif:completeAnimation()
	f5_arg0.PCNotif:setLeftRight( 0.5, 0.5, -225, 225 )
	f5_arg0.PCNotif:setAlpha( 1 )
end

CoD.PC_Notif_Container.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f6_arg0, f6_arg1 )
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter( 1 )
			f6_arg0.PCNotif:completeAnimation()
			f6_arg0.PCNotif:setAlpha( 1 )
			f6_arg0.clipFinished( f6_arg0.PCNotif )
		end,
		In = function ( f7_arg0, f7_arg1 )
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter( 1 )
			local f7_local0 = function ( f8_arg0 )
				f7_arg0.PCNotif:beginAnimation( 250, Enum[@"hash_1F50FFF429AB1890"][@"hash_15193EA7825DC097"] )
				f7_arg0.PCNotif:setLeftRight( 0.5, 0.5, -225, 225 )
				f7_arg0.PCNotif:setAlpha( 1 )
				f7_arg0.PCNotif:registerEventHandler( "interrupted_keyframe", f7_arg0.clipInterrupted )
				f7_arg0.PCNotif:registerEventHandler( "transition_complete_keyframe", f7_arg0.clipFinished )
			end
			
			f7_arg0.PCNotif:completeAnimation()
			f7_arg0.PCNotif:setLeftRight( 0.5, 0.5, -175, 275 )
			f7_arg0.PCNotif:setAlpha( 0 )
			f7_local0( f7_arg0.PCNotif )
		end
	},
	Invisible = {
		DefaultClip = function ( f9_arg0, f9_arg1 )
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter( 1 )
			f9_arg0.PCNotif:completeAnimation()
			f9_arg0.PCNotif:setAlpha( 0 )
			f9_arg0.clipFinished( f9_arg0.PCNotif )
		end,
		Out = function ( f10_arg0, f10_arg1 )
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter( 1 )
			local f10_local0 = function ( f11_arg0 )
				f10_arg0.PCNotif:beginAnimation( 250, Enum[@"hash_1F50FFF429AB1890"][@"hash_15193EA7825DC097"] )
				f10_arg0.PCNotif:setLeftRight( 0.5, 0.5, -205, 245 )
				f10_arg0.PCNotif:setAlpha( 0 )
				f10_arg0.PCNotif:registerEventHandler( "interrupted_keyframe", f10_arg0.clipInterrupted )
				f10_arg0.PCNotif:registerEventHandler( "transition_complete_keyframe", f10_arg0.clipFinished )
			end
			
			f10_arg0.PCNotif:completeAnimation()
			f10_arg0.PCNotif:setLeftRight( 0.5, 0.5, -225, 225 )
			f10_arg0.PCNotif:setAlpha( 1 )
			f10_local0( f10_arg0.PCNotif )
		end
	}
}

CoD.PC_Notif_Container.__onClose = function ( f12_arg0 )
	f12_arg0.PCNotif:close()
end