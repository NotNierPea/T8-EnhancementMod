--[[
      .\hksc.exe '.\Scripts\MorePerks.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\MorePerks.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

DataSources.ExtraPerkVaporsCustom = DataSourceHelpers.CustomListSetup( "ExtraPerkVaporsCustom", function ( f11_arg0, f11_arg1, f11_arg2, f11_arg3, f11_arg4 )
	local f11_local0 = DataSources.HUDItems.getModel( f11_arg1 )
	for f11_local1 = 0, 13, 1 do
		local f11_local4 = f11_local0:create( "extraPerkVapor." .. f11_local1 )
		f11_local4:create( "state" )
		f11_local4:create( "itemIndex" )
		local f11_local5 = f11_local4:create( "altarName" )
		f11_local5:set( @"hash_0" )
		f11_local4:create( "specialEffectActive" )
		f11_local5 = f11_local4:create( "isLastAltar" )
		f11_local5:set( false )
		f11_local4:create( "chargeCount" )
		f11_local4:create( "progress" )
		f11_local4:create( "timerActive" )
		table.insert( f11_arg3, {
			model = f11_local4
		} )
	end
	f11_arg0._perkVaporSubscriptions = true
end )

CoD.ApplyMorePerks = function(hud, controller, ExtraPerks)
	ExtraPerks:setSpacing(-40)
	ExtraPerks:setHorizontalCount(13)
	ExtraPerks:setDataSource( "ExtraPerkVaporsCustom" )

	CoD.EnhModPrintInfo("Activated Extra Perks Mode....")
end