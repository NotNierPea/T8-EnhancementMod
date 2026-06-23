--[[
      .\hksc.exe '.\Scripts\HotkeyManager.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\HotkeyManager.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

-- ! not finished or used !
CoD.EnhHotkeyMgr = InheritFrom( LUI.UIElement )
CoD.EnhHotkeyMgr.__defaultWidth = 1920
CoD.EnhHotkeyMgr.__defaultHeight = 1080
CoD.EnhHotkeyMgr.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.EnhHotkeyMgr )
	self.id = "EnhHotkeyMgr"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )

	CoD.EnhModPrintInfo("setting up hotkey shit")

	-------------------------------

	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )

	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end

	return self
end

CoD.EnhHotkeyMgr.__resetProperties = function ( f16_arg0 )
	
end

CoD.EnhHotkeyMgr.__clipsPerState = {

}

CoD.EnhHotkeyMgr.__onClose = function ( f19_arg0 )

end