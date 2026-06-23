--[[
      .\hksc.exe '.\Scripts\Utils.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\Utils.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile = function()
      require( "ui/uieditor/menus/startgameflow/loading_zm" )
      require( "ui/uieditor/widgets/hud/movieplayback/moviesubtitles" )
      require( "ui/uieditor/widgets/loadinganimation/loadingscreenskipprompt" )
      require( "ui/uieditor/widgets/notifications/xp/doublexpiconsleftaligned" )
      require( "ui/uieditor/widgets/startgameflow/loadingscreentalkerwidgetcpzm" )
      require( "ui/uieditor/widgets/startgameflow/loadingscreensharedcpzm" )
      require( "ui/uieditor/widgets/pc_notif" )
      require( "x64:5c0887595cfb6bb1" )

      require("x64:488c89835c36151") -- gameover needs
      require("x64:5170894c2be18f57")
      require("x64:7e1697b8a432349")

      require( "lua/shared/luareadonlytables" )
      require( "lua/shared/lobbydata" )
      require( "x64:5127dca51df8f7c7" )
      require( "x64:785d6d26960f9bae" )
      require( "x64:675e553bec904d39" )

      require( "ui/utility/overlayutility" )

      require( "x64:206d3dba7fca3db6" )
      require( "ui/uieditor/widgets/notifications/xp/doublexpiconsleftaligned" )
      require( "x64:64e305ae5efd943d" )
      require( "x64:21c6bd5c481bc2be" )
      require( "x64:3f1759af4f758ac8" )
      require( "x64:13a06c735b413259" )
      require( "x64:25526ba46c282c68" )
      require( "x64:362d19097b6da0d8" )
      require( "x64:7b710bc406e458bd" )

      require( "ui/uieditor/widgets/backgroundframes/menuframeingame" )
      require( "ui/uieditor/widgets/startmenu/options/startmenuoptionsbackground" )
      require( "x64:36374709588b8a15" )
      require( "ui/uieditor/widgets/director/directorquitbuttoncontainer" )
      require( "ui/uieditor/widgets/hud/console/consoleentrycontainer" )

      require("x64:5dad384961396711")

      require( "x64:598e888b7d3db378" )
      require( "x64:7d31d988677643" )
      require( "x64:1e4d86781e568c41" )
      require( "x64:2d9b05e07fa074ee" )

      require( "x64:7857aae823214ba2" )
      require( "x64:67139dde30490cc8" )
      require( "x64:776b99ac28573661" )
      require( "x64:4be457f86919afa5" )

      require( "ui/uieditor/widgets/blackmarket/smokewidget" )
      require( "x64:5857f6c026e9ea99" )

      require( "x64:1dddc350afc94b48" )
      require( "x64:3ad2dd10539beaf7" )

      require( "x64:ff22b286a167aad" )

      require( "x64:8c081eae077f5fd" )

      require( "ui/uieditor/widgets/hud/centerconsole/centerconsoleentrycontainer" )

      require( "x64:4c50f23ab4600782" )
      require( "x64:1ee862a5c760e804" )
      require( "ui/uieditor/widgets/lobby/common/fe_listsubheaderpanel" )

      require( "x64:1e974620a2d49d8f" )

      require( "ui/uieditor/widgets/chat/ingame/ingamechatclient" )
      require( "ui/uieditor/widgets/chat/chatclientchatentryscrollviewcontainer" )
      require( "ui/uieditor/widgets/chat/chatclientchatentrystaticview" )
      require( "ui/uieditor/widgets/chat/chatclientfilterbutton" )
      require( "ui/uieditor/widgets/chat/chatclientinputtextbox" )
      require( "ui/uieditor/widgets/emptyfocusable" )

      require( "ui/uieditor/widgets/border" )
      require( "x64:234a25dc398a559c" )

      require( "x64:55814753ce54450b" )

      require( "ui/uieditor/widgets/loadinganimation/animationloadingwidget" )

      require( "x64:69220087c645f831" )
      require( "x64:5edc0771252f0eb7" )
end

CoD.EnhModPrintInfo = function(PrintInfo, DebugName)
	if DebugName ~= nill then
		Engine[@"printinfo"](0, "^1Enhancement LUA Debug: " .. tostring(DebugName) .. " -> " .. tostring(PrintInfo))
	elseif PrintInfo ~= nill then
		Engine[@"printinfo"](0, "^1Enhancement LUA Debug: " .. tostring(PrintInfo))
	end
end

CoD.BO4GetMap = function()
    if(Engine[@"GetCurrentMap"]() == "zm_towers") then return "IX"
    elseif(Engine[@"GetCurrentMap"]() == "zm_escape") then return "Blood"
    elseif(Engine[@"GetCurrentMap"]() == "zm_red") then return "AE"
    elseif(Engine[@"GetCurrentMap"]() == "zm_white") then return "AO"
    elseif(Engine[@"GetCurrentMap"]() == "zm_mansion") then return "Dead"
    elseif(Engine[@"GetCurrentMap"]() == "zm_orange") then return "Tag"
    elseif(Engine[@"GetCurrentMap"]() == "zm_office") then return "Classified"
    elseif(Engine[@"GetCurrentMap"]() == "zm_zodt8") then return "Voyage"
    end
end

CoD.GetErrorText = function(controller)
	local errortext = Engine[@"getmodelvalue"]( Engine[@"getmodel"]( DataSources.MessageDialog.getModel(controller), "message" ) )
	if errortext ~= nil then
		if type(errortext) == "xhash" then
			errortext = Engine[@"hash_4F9F1239CFD921FE"]( errortext )
		end
		return errortext
	else
		return "No Error"
	end
end

CoD.ArrayContains = function(array, item)
    if not array then return false end
    for _, value in ipairs(array) do
        if value == item then
            return true
        end
    end
    return false
end

CoD.ArrayRemove = function(array, item)
      if not array then return false end
      for i, value in ipairs(array) do
            if value == item then
                  table.remove(array, i)
                  return true
            end
      end
      return false
end