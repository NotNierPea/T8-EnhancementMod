--[[
      .\hksc.exe '.\Lua\Frontend Side\Utils.lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\Utils.luac'
]]

------------------------

if not CoD.isFrontend then
	return
end

CoD.InitEnhLuaFile = function()
	if not DataSourceHelpers then
		DataSourceHelpers = {}
	end

	if not DataSources then
		DataSources = {}
	end

	require( "x64:27b70bc94aba2979" ) -- difficulty selections
	require( "lua/shared/luaenum" )

	require( "x64:31bbde4283bb35f8" ) -- map selections
	require( "x64:1523012e06043492" )
	require( "x64:52abb3dc03d38a77" )
	require( "x64:3fd3a35782695797" )
	require( "x64:4e80af213f3caa57" )
	require( "ui/uieditor/widgets/scrollbars/verticalcounter" )
	require( "x64:582580983913de78" )

	require( "x64:6ade951b2d8c4d9a" )
	require( "x64:7f6ae994925ce8e1" )
	require( "ui/uieditor/widgets/footer/footercontainer_frontend_right" )
	require( "x64:7662addde48b6aa5" )

	require( "ui/uieditor/widgets/footer/footerbutton_backhold" )
	require( "x64:1e69a699d13ef927" )
	require( "ui/uieditor/widgets/pc/footer/footerbutton_frontend_pc_left" )
	require( "ui/uieditor/widgets/pc/footer/footerbutton_frontend_pc_right" )

	-- Main Frontend
	require( "x64:3d58649a93c7c23a" )
	require( "x64:643bb843a38237" )
	require( "x64:4b06ac7d487ebb93" )
	require( "x64:7574ad94e3056951" )
	require( "x64:36767134a413986e" )
	require( "x64:312a47386affd813" )
	require( "x64:72a8dac04babf8b8" )
	require( "x64:98f657bdbe677aa" )
	require( "x64:3a03e6abe332775" )
	require( "x64:9258f7404e4ba1d" )
	require( "x64:26af9b7da2a5cafd" )
	require( "x64:1247779f7898be87" )
	require( "x64:7c0f8856fca43866" )
	require( "x64:40776309501d0fd4" )
	require( "ui/uieditor/widgets/header/header_container_frontend" )
	require( "x64:713012bca0fbd2f4" )
	require( "x64:16be582def81a3b7" )
	require( "x64:2dd67ebb9f0b033a" )
	require( "x64:46ee653ade3452f5" )
	require( "x64:5c0887595cfb6bb1" )
	require( "ui/uieditor/actions_helper" )

	require( "ui/uieditor/widgets/chat/frontend/frontendchatclient" )

	require( "ui/uieditor/widgets/chat/chatclientchatentryscrollviewcontainer" )
	require( "ui/uieditor/widgets/chat/chatclientfilterbutton" )
	require( "ui/uieditor/widgets/chat/chatclientinputtextbox" )
	require( "ui/uieditor/widgets/emptyfocusable" )

	require( "ui/uieditor/widgets/border" )
	require( "x64:234a25dc398a559c" )

	require( "ui/uieditor/widgets/chat/chatclientchatentrystaticview" )

	require( "x64:4a2bcf8aadb8131e" )

	require( "x64:3ab3f46201c530b4" )

	require( "x64:1f91d9d528eb4ebd" )
	require( "x64:71f846296f1a1b81" )

	require( "lua/shared/luautils" )

	require( "ui/uieditor/widgets/director/directorpartyleaderonlyprompt" )

	require( "ui/uieditor/widgets/cac/newbreadcrumbcount" )
	require( "ui/uieditor/widgets/buttonprogressringcontainer" )

	require( "ui/uieditor/widgets/bumperbuttonwithkeymousetext" )
	require( "ui/uieditor/widgets/director/directorselecttexttab" )
	require( "ui/uieditor/widgets/tabbedwidgets/basictablist" )

	require( "x64:54b31e839f22a9f3" )
	require( "x64:12d64ca9d3c705ce" )
	require( "x64:6131b51676141877" )
	require( "x64:617d3422e33a0d58" )
	require( "x64:1ea788cab9c8c2f2" )
	require( "ui/uieditor/widgets/director/directorselectbutton" )
	require( "x64:772675e4fd5488ad" )
	require( "x64:1b4ca9804aae519a" )
	require( "x64:224e2d03e4415acb" )
	require( "x64:71f331b3b9d7ec0d" )
	require( "ui/uieditor/widgets/pc/bnetstore/pc_bnetstore_purchasebutton" )
	require( "x64:300d5a6dd418ced5" )

	require( "ui/uieditor/widgets/common/commoncornerpips01" )
	require( "ui/uieditor/widgets/director/directorbuttonadd" )
	require( "x64:261730f9c061ba21" )
	require( "x64:650279cd666ce7ee" )
	require( "ui/uieditor/menus/social/social_playerdetailspopup" )

	require( "x64:6bc6e2379d2241fb" )
	require( "ui/uieditor/widgets/fileshare/fullscreenpopup/fullscreenpopuptemplate" )
	require( "x64:15d80cb371475b19" )
	require( "x64:179ffb6336ac6e4c" )
	require( "x64:6156d841adc02c80" )
	require( "ui/uieditor/widgets/playercard/selfidentitybadge" )
	require( "ui/uieditor/widgets/startmenu/startmenu_codpoints" )

	require( "ui/uieditor/widgets/header/headerlinescontainer" )

	require( "ui/uieditor/menus/lobby/directorfindgamewz" )
	require( "x64:6260c7a8e3737127" )
	require( "x64:751ef3a2adbd471e" )
	require( "ui/uieditor/widgets/director/directormapandgametypecontainer" )
	require( "ui/uieditor/widgets/director/directorpregamebuttonoption" )
	require( "x64:500e3efc70851381" )
	require( "x64:37b2e5c29b34a47e" )
	require( "x64:4bfdd9a330518b28" )
	require( "x64:146b093e7d34ea80" )
	require( "x64:2a155eac5398a2a3" )
	require( "x64:2d4ed3fd8d1fcc4a" )
	require( "x64:1429ef25909713fe" )
	require( "x64:34632a684587e313" )
	require( "ui/uieditor/widgets/notifications/publiclobbystagenotification/stagenotificationcontainer" )
	require( "x64:445928c36e455a1" )

	require( "x64:7dab8c3a6f5b136c" )
	require( "ui/uieditor/widgets/director/directorselectbuttonlines" )

	require( "ui/uieditor/widgets/common/commonheader" )
	require( "x64:6fda45231af81f63" )
	require( "x64:20daafb4764cb9e3" )
	require( "x64:3ac3ecac3599406b" )

	require( "x64:6dbdc73a4a6c0b46" )

	require( "x64:2de1e084b1f3792d" )
	require( "x64:562963bd5f35a7f6" )
	require( "x64:47c8f6290ec1890e" )
	require( "x64:763f019e9d0f8956" )
	require( "x64:1ef651f35122631" )
	require( "ui/uieditor/widgets/onofftextimagebacking" )

	require( "ui/uieditor/widgets/director/directorpregamebutton" )

	require( "x64:1bb65ae797e77e7b" )
	require( "x64:23e426332d66c91e" )
	require( "ui/uieditor/widgets/startgameflow/loadingscreensharedcpzm" )

	require( "ui/uieditor/widgets/backgroundframes/genericmenuframe" )
	require( "x64:6e1b6065122832d3" )
	require( "x64:27196315b0b927fd" )

	require( "x64:1ced5f2569bfff4a" )

	require( "ui/uieditor/widgets/systemoverlays/systemoverlay_full_layout" )
	require( "ui/uieditor/widgets/pc/pc_smallclosebutton" )

	require( "ui/uieditor/widgets/systemoverlays/systemoverlay_compact_layout" )

	require( "x64:294bcc019394211c" )
	require( "x64:25ec5b3e9479f805" )

	require( "x64:1019bf86db65af0e" )
	require( "ui/uieditor/widgets/aar_t8/medals/aarmedalstab" )
	require( "ui/uieditor/widgets/aar_t8/rewards/aarrewardstab" )
	require( "x64:dcd854a7bb6c2c2" )
	require( "x64:293feffa3a82d41c" )
	require( "x64:30feb272637b3842" )
	require( "x64:1a1b9abe59dc83dc" )
	require( "x64:9d68986bd32e9fe" )
	require( "x64:5db2330a5cdd63e8" )

	require( "ui/uieditor/widgets/cac/cac_background_slide_panel" )
	require( "ui/uieditor/widgets/cac/itemnamedescunlocktext" )
	require( "ui/uieditor/widgets/cac/menuchooseclass/itemwidgets/itemweaponlevel" )
	require( "ui/uieditor/widgets/cac/weaponattributes" )
	require( "x64:ba5fa76d22ca8fe" )
	require( "ui/uieditor/widgets/pc/utility/xcammousecontrol" )
	require( "x64:6341ce33d59fafd1" )
	require( "x64:5f36454e4aa0e1bb" )
	require( "x64:eb8711f5087e974" )
	require( "x64:62bd296def421df5" )
	require( "x64:7e3a68f67fb108c9" )

	require( "ui/uieditor/widgets/cac/cac_background_slide_panel_short" )
	require( "ui/uieditor/widgets/cac/cacheader" )
	require( "ui/uieditor/widgets/cac/weaponattachmentselect/attachmentflyoutcontainer" )
	require( "x64:4ec07622a7f2e74e" )
	require( "ui/uieditor/widgets/director/directordividerwithgradient" )
	require( "ui/uieditor/widgets/onofftext" )

	require( "x64:6103d565b59f1a18" )
	require( "x64:3db0d043e3841f5c" )

	require( "x64:1c2f345c8ff5611e" )
	require( "x64:5e0fb1c5ee5c0772" )

	require( "x64:25b3f12fb71c1346" )
	require( "x64:51417b7fe0a0948" )
	require( "x64:77046b0d9f3594f1" )
	require( "x64:20602298da419f4f" )
	require( "x64:4ceb8e53c9b511d" )

	require( "x64:183bf909ab80816a" )
	require( "x64:1a79cd5379458ac3" )
	require( "x64:2d13dde082cbfc3a" )

	require( "ui/uieditor/widgets/footer/fe_footercontainermain" )
	require( "ui/uieditor/widgets/main/atvicopy" )
	require( "ui/uieditor/widgets/main/connectionlabel" )
	require( "ui/uieditor/widgets/main/startlabel" )
	require( "ui/uieditor/widgets/director/directorquitbuttoncontainer" )
	require( "x64:73a1772776cde124" )
	require( "x64:3ae1040cb9e1ab23" )
	require( "ui/uieditor/widgets/footer/fe_leftcontainermain" )
	require( "ui/uieditor/widgets/footer/fe_rightcontainermain" )
	require( "ui/uieditor/widgets/pc/utility/verticallistspacer" )

	require( "ui/uieditor/menus/lobby/directorchoosemapandgametype" )
	require( "ui/uieditor/menus/lobby/directorcustomgamesetup" )
	require( "x64:320adbc63353ec37" )
	require( "x64:447c727557c223b9" )
	require( "x64:48830a14f983c4c4" )
	require( "x64:746270a4d7cafbc0" )
	require( "x64:3e18985ca0ef8cf8" )

	require( "ui/uieditor/widgets/freecursor/freecursorwidget" )

	require( "ui/uieditor/widgets/loadinganimation/animationloadingwidget" )
	--require( "lua/lobby/common/lobbycore" )

	require( "x64:41b4f8e8fb49420" )

	require( "ui/uieditor/widgets/director/directorfixedwidthheading" )
	require( "x64:12f210cb5e3fa853" )
	require( "ui/uieditor/widgets/director/directorteammember" )

	require( "x64:289bbf8ecb3a0513" )

	require( "x64:66fdeb9eb1239c18" )
	require( "x64:58d2cf73e51e9eb2" )
	require( "x64:3445c36edf7e511d" )
	require( "x64:220629a2e70ddf60" )

	require( "x64:2736f83e92990ede" )

	require( "ui/uieditor/widgets/startmenu/options/startmenuoptionsmaincorners" )
	require( "ui/uieditor/widgets/startmenu/options/startmenuoptionsmainframe" )

	require( "ui/uieditor/widgets/common/commoncenteredpopup" )
	require( "x64:fe9df26e257edb3" )

	require( "x64:2e656d7766a8b00a" )
	require( "x64:3b1c64f85af4ce49" )

	------------------------------

	require( "x64:3a79adf0dbc1a1b6" )
	require( "x64:71c4c59d812255d" )
	require( "ui/uieditor/widgets/scoreboard/tabbedscoreboardfuibox" )
	require( "ui/uieditor/widgets/startmenu/options/startmenuoptionsbackground" )

	require( "x64:181a24c5340caa1e" )
	require( "ui/uieditor/widgets/director/directorselect_tabbar_center" )

	require( "x64:2ceea494103cb1e2" )
	require( "x64:334096eb04183443" )
end

-- for most datasources
CoD.OnModDataChange = function( f137_arg0, f137_arg1, f137_arg2, f137_arg3, f137_arg4 )
	local dvar_name = f137_arg3
	local dvar_value = Engine[@"getdvarint"]( dvar_name )
	local dvar_new_value = f137_arg1.value
	CoD.OptionsUtility.UpdateInfoModels( f137_arg1 )

	if dvar_new_value == dvar_value then
		return 
	else
		Engine[@"setdvar"]( dvar_name, dvar_new_value )

		-- number or bool dvar compare
		if dvar_name == "shield_enh_RoundColor" or dvar_name == "shield_enh_Counter_TextColor" or dvar_name == "shield_enh_Counter_NumberColor" or dvar_name == "shield_enh_Counter_Position" or dvar_name == "shield_enh_Counter_FontStyle" or dvar_name == "shield_enh_Damage_FontStyle" or dvar_name == "shield_enh_Althud_Interaction_FontStyle" or dvar_name == "shield_enh_Subtitles_Color" or dvar_name == "shield_enh_Subtitles_FontStyle" then
			Engine[@"exec"](Engine[@"getprimarycontroller"](), 'writejson "" ' .. string.gsub(dvar_name, "shield_enh_", "") .. ' ' .. dvar_new_value .. ' uint64_t project-bo4/saved/server/EnhancementMain.json')
		else
			Engine[@"exec"](Engine[@"getprimarycontroller"](), 'writejson "" ' .. string.gsub(dvar_name, "shield_enh_", "") .. ' ' .. dvar_new_value .. ' bool project-bo4/saved/server/EnhancementMain.json')
		end
	end
end

CoD.EnhModPrintInfo = function(PrintInfo, DebugName)
	if DebugName ~= nill then
		Engine[@"printinfo"](0, "^1Enhancement LUA Debug: " .. tostring(DebugName) .. " -> " .. tostring(PrintInfo))
	elseif PrintInfo ~= nill then
		Engine[@"printinfo"](0, "^1Enhancement LUA Debug: " .. tostring(PrintInfo))
	end
end