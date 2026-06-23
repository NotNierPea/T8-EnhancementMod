--[[
      .\hksc.exe '.\Scripts\MorePlayerFixes.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\MorePlayerFixes.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

local ScoreboardListPos = {}
local ScoreBoardPos = 0

------------------------

-- fix 4+ players issues, unfinished and still needs more work
CoD.MorePlayersFixesReload = function()
      DataSources.PlayerListZM = {
            preparedForController = {},
            subscriptions = {},
            modelLinks = {
                  playerName = "playerName",
                  score = "playerScore",
                  scoreVisible = "playerScoreVisible",
                  rankIcon = "playerRankIcon",
                  rankNum = "rankNum",
                  clanAbbrev = "clanAbbrev",
                  clientNum = "clientNum",
                  playerConnected = "playerConnected",
                  playerIsDowned = "playerIsDowned",
                  zombiePlayerIcon = "zombiePlayerIcon",
                  zombieInventoryIcon = "zombieInventoryIcon",
                  playerScoreShown = "playerScoreShown",
                  clientModel = "clientModel"
            },
            clientNumToArrayIndex = function ( f351_arg0, f351_arg1 )
                  if f351_arg0 == f351_arg1 then
                        return 0
                  elseif f351_arg0 < f351_arg1 then
                        return 1 + f351_arg0
                  else
                        return f351_arg0
                  end
            end,
            prepare = function ( f352_arg0 )
                  if not DataSources.PlayerListZM.preparedForController then
                        DataSources.PlayerListZM.preparedForController = {}
                  end
                  if not DataSources.PlayerListZM.subscriptions[f352_arg0] then
                        DataSources.PlayerListZM.subscriptions[f352_arg0] = LUI.UIElement.new()
                  end
                  DataSources.PlayerListZM.subscriptions[f352_arg0]:unsubscribeFromAllModels()
                  DataSources.PlayerListZM.preparedForController[f352_arg0] = true
                  local f352_local0 = Engine[@"getmodelforcontroller"]( f352_arg0 )
                  local f352_local1 = Engine[@"createmodel"]( f352_local0, "PlayerList" )
                  local f352_local2 = Engine[@"getclientnum"]( f352_arg0 )

                  CoD.EnhModPrintInfo("before!!!!")

                  local MaxClients = 4

                  if Engine[@"getdvarint"]("com_maxclients") > 4 then
                        MaxClients = 2
                  end

                  CoD.EnhModPrintInfo("preparing PlayerList with max clients: " .. MaxClients)

                  for f352_local3 = 0, MaxClients - 1, 1 do
                        local f352_local6 = DataSources.PlayerListZM.clientNumToArrayIndex( f352_local3, f352_local2 )
                        local f352_local7 = Engine[@"getplayerlistdata"]( f352_arg0, f352_local3 )
                        local f352_local8 = f352_local1:create( f352_local6 )
                        for f352_local12, f352_local13 in pairs( DataSources.PlayerListZM.modelLinks ) do
                              Engine[@"setmodelvalue"]( Engine[@"createmodel"]( f352_local8, f352_local13 ), f352_local7[f352_local12] )
                        end
                        if CoD.ZombieUtility.InventoryIcon ~= nil then
                              DataSources.PlayerListZM.subscriptions[f352_arg0]:subscribeToModel( f352_local0["zmInventory.player" .. f352_local3 .. "hasItem"], function ( model )
                                    if Engine[@"getmodelvalue"]( model ) == 1 then
                                          Engine[@"setmodelvalue"]( Engine[@"createmodel"]( f352_local8, "zombieInventoryIcon" ), CoD.ZombieUtility.InventoryIcon )
                                    else
                                          Engine[@"setmodelvalue"]( Engine[@"createmodel"]( f352_local8, "zombieInventoryIcon" ), "blacktransparent" )
                                    end
                              end )
                        else
                              Engine[@"setmodelvalue"]( Engine[@"createmodel"]( f352_local8, "zombieInventoryIcon" ), "blacktransparent" )
                        end
                        DataSources.PlayerListZM.subscriptions[f352_arg0]:subscribeToModel( Engine[@"getmodel"]( Engine[@"getglobalmodel"](), "Clients." .. f352_local3 .. ".playerName" ), function ( model )
                              local f354_local0 = Engine[@"getmodelvalue"]( model )
                              if f354_local0 ~= nil then
                                    Engine[@"setmodelvalue"]( Engine[@"createmodel"]( f352_local8, "playerName" ), f354_local0 )
                              else
                                    Engine[@"setmodelvalue"]( Engine[@"createmodel"]( f352_local8, "playerName" ), "" )
                              end
                        end )
                        local f352_local9 = Engine[@"createmodel"]( f352_local8, "clientModel" )
                        f352_local9:set( Engine[@"getmodel"]( Engine[@"getglobalmodel"](), "Clients." .. f352_local3 ) )
                  end
                  local f352_local3 = function ( f355_arg0, f355_arg1 )
                        DataSources.PlayerListZM.updateModelsForClient( f355_arg0, f355_arg1 )
                  end
                  
                  DataSources.PlayerListZM.subscriptions[f352_arg0]:subscribeToModel( f352_local0.playerConnected, function ( model )
                        local f356_local0 = Engine[@"getmodelvalue"]( model )
                        if f356_local0 ~= nil then
                              f352_local3( f352_arg0, f356_local0 )
                        end
                  end, false )
                  DataSources.PlayerListZM.subscriptions[f352_arg0]:subscribeToModel( f352_local0.playerDisconnected, function ( model )
                        local f357_local0 = Engine[@"getmodelvalue"]( model )
                        if f357_local0 ~= nil then
                              f352_local3( f352_arg0, f357_local0 )
                        end
                  end, false )
            end,
            updateModelsForClient = function ( f358_arg0, f358_arg1 )
                  local f358_local0 = DataSources.PlayerListZM.getModelForPlayer( f358_arg0, f358_arg1 )
                  if f358_local0 ~= nil then
                        local f358_local1 = Engine[@"getplayerlistdata"]( f358_arg0, f358_arg1 )
                        for f358_local5, f358_local6 in pairs( DataSources.PlayerListZM.modelLinks ) do
                              local f358_local7 = Engine[@"getmodel"]( f358_local0, f358_local6 )
                              if f358_local7 then
                                    Engine[@"setmodelvalue"]( f358_local7, f358_local1[f358_local5] )
                              end
                        end
                  end
            end,
            getModelForPlayer = function ( f359_arg0, f359_arg1 )
                  local f359_local0 = Engine[@"getclientnum"]( f359_arg0 )
                  if f359_arg1 == f359_local0 then
                        local f359_local1 = Engine[@"getmodelforcontroller"]( f359_arg0 )
                        return f359_local1.PlayerList.playerSelf
                  else
                        local f359_local1 = DataSources.PlayerListZM.clientNumToArrayIndex( f359_arg1, f359_local0 )
                        local f359_local2 = Engine[@"getmodelforcontroller"]( f359_arg0 )
                        return f359_local2.PlayerList["player" .. f359_local1]
                  end
            end,
            getModel = function ( f360_arg0 )
                  if not DataSources.PlayerListZM.preparedForController or not DataSources.PlayerListZM.preparedForController[f360_arg0] then
                        DataSources.PlayerListZM.prepare( f360_arg0 )
                  end
                  local f360_local0 = Engine[@"getmodelforcontroller"]( f360_arg0 )
                  return f360_local0:create( "PlayerList" )
            end
      }

      DataSources.ZombieGameoverScoreboard = DataSourceHelpers.ListSetup( "ZombieGameoverScoreboard", function ( f13_arg0 )
            local f13_local0 = {}
            local f13_local1 = DataSources.ZMPlayerList.getModel( f13_arg0 )
            local f13_local2 = Engine[@"getclientnum"]( f13_arg0 )
            for f13_local3 = 0, Engine[@"getdvarint"]("com_maxclients"), 1 do
                  local f13_local6 = tonumber( Engine[@"getmodelvalue"]( Engine[@"getmodel"]( Engine[@"getglobalmodel"](), "scoreboard.team1." .. f13_local3 .. ".clientNum" ) ) )
                  local f13_local7 = f13_local3 + 1
                  if f13_local6 > -1 then
                        local f13_local8 = Engine[@"createmodel"]( f13_local1, DataSources.PlayerListZM.clientNumToArrayIndex( f13_local6, f13_local2 ) )
                        local f13_local9 = f13_local8:create( "zombiePlayerIcon" )
                        local f13_local10 = Engine[@"getmodel"]( Engine[@"getglobalmodel"](), "Clients." .. f13_local6 .. ".scoreboard" )
                        table.insert( f13_local0, {
                              models = {
                                    clientNum = f13_local6,
                                    position = f13_local7,
                                    zombiePlayerIcon = Engine[@"getmodelvalue"]( f13_local9 ),
                                    playerName = Engine[@"getmodelvalue"]( Engine[@"getmodel"]( f13_local10, "playerName" ) ),
                                    col1 = Engine[@"getmodelvalue"]( Engine[@"getmodel"]( f13_local10, "col1" ) ),
                                    col2 = Engine[@"getmodelvalue"]( Engine[@"getmodel"]( f13_local10, "col2" ) ),
                                    col3 = Engine[@"getmodelvalue"]( Engine[@"getmodel"]( f13_local10, "col3" ) ),
                                    col4 = Engine[@"getmodelvalue"]( Engine[@"getmodel"]( f13_local10, "footer1" ) ),
                                    col5 = Engine[@"getmodelvalue"]( Engine[@"getmodel"]( f13_local10, "footer2" ) )
                              }
                        } )
                  end
            end
            return f13_local0
      end, nil, nil, function ( f14_arg0, f14_arg1, f14_arg2 )
            if not f14_arg1.__gameEndSubscription then
                  f14_arg1.__gameEndSubscription = true
                  local f14_local0 = f14_arg1
                  local f14_local1 = f14_arg1.subscribeToModel
                  local f14_local2 = Engine[@"getmodelforcontroller"]( f14_arg0 )
                  f14_local1( f14_local0, f14_local2["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function ( f15_arg0 )
                        f14_arg1:clearLayout()
                        f14_arg1:updateDataSource( false, false )
                  end )
            end
      end )

      CoD.ZombieUtility.CommonPostLoadHud = function ( f2_arg0, f2_arg1, f2_arg2 )
            CoD.EnhModPrintInfo("Called", "CommonPostLoadHud")

            local f2_local0 = DataSources.WorldSpaceIndicators.getModel( f2_arg1 )
            CoD.HUDUtility.SetupGrenadeWarningIndicators( f2_arg0, f2_arg1 )
            if f2_local0 then
                  local f2_local1 = function ( f3_arg0 )
                        local f3_local0 = f3_arg0:getFirstChild()
                        while f3_local0 do
                              if LUI.startswith( f3_local0.id, "bleedOutItem" ) then
                                    local f3_local1 = f3_local0:getModel( f2_arg1, "playerName" )
                                    if f3_local1 then
                                          Engine[@"setmodelvalue"]( f3_local1, Engine[@"getgamertagforclient"]( f2_arg1, f3_local0.bleedOutClient ) )
                                    end
                              end
                              f3_local0 = f3_local0:getNextSibling()
                        end
                  end
                 
                  local f2_local2 = 0
                  local f2_local3 = true
                  while f2_local3 do
                        local f2_local4 = f2_local0:create( "bleedOutModel" .. f2_local2 )
                        local f2_local5 = f2_local4:create( "playerName" )
                        f2_local5:set( Engine[@"getgamertagforclient"]( f2_arg1, f2_local2 ) )
                        local f2_local6 = f2_local4:create( "prompt" )
                        f2_local6:set( @"zmui/revive" )
                        f2_local6 = f2_local4:create( "clockPercent" )
                        f2_local6:set( 0 )
                        f2_local6 = f2_local4:create( "bleedOutPercent" )
                        f2_local6:set( 0 )
                        f2_local6 = f2_local4:create( "stateFlags" )
                        f2_local6:set( 0 )
                        f2_local6 = f2_local4:create( "arrowAngle" )
                        f2_local6:set( 0 )
                        f2_local6 = f2_local4:create( "hide" )
                        f2_local6:set( 0 )
                        f2_local6 = CoD.ZM_Revive.new( f2_arg0, f2_arg1, 0, 0, 0, CoD.ZM_Revive.__defaultWidth, 0, 0, 0, CoD.ZM_Revive.__defaultHeight )
                        f2_local6.bleedOutClient = f2_local2
                        f2_local6.id = "bleedOutItem" .. f2_local2
                        f2_local6:setModel( f2_local4, f2_arg1 )
                        f2_local3 = f2_local6:setupBleedOutWidget( f2_arg1, f2_local2 )
                        f2_arg0:sendInitializationEvents( f2_arg1, f2_local6 )
                        f2_arg0.fullscreenContainer:addElement( f2_local6 )
                        if not f2_arg0._connectionChangeHandlerSubscription then
                              f2_arg0._connectionChangeHandlerSubscription = f2_arg0.fullscreenContainer:subscribeToModel( Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f2_arg1 ), "playerConnected" ), function ( model )
                                    f2_local1( f2_arg0.fullscreenContainer )
                              end )
                        end
                        f2_local2 = f2_local2 + 1
                  end
            end
            f2_arg0.m_inputDisabled = true
            if LUI.DEV ~= nil then
                  if LUI.DEVHideButtonPrompts then
                        f2_arg0.CursorHint:setAlpha( 0 )
                  end
                  f2_arg0:registerEventHandler( "hide_button_prompts", function ( element, event )
                        element.CursorHint:setAlpha( event.show and 1 or 0 )
                  end )
            end
      end

      CoD.ZombieUtility.GetStringPositionForIndex = function ( f74_arg0 )
            if CoD.ZombieUtility.Rush.PositionStrings[f74_arg0] ~= nil then
                  return Engine[@"hash_4F9F1239CFD921FE"]( CoD.ZombieUtility.Rush.PositionStrings[f74_arg0] )
            else
                  if f74_arg0 == 5 then
                        return "5th"
                  elseif f74_arg0 == 6 then
                        return "6th"
                  elseif f74_arg0 == 7 then
                        return "7th"
                  elseif f74_arg0 == 8 then
                        return "8th"
                  elseif f74_arg0 == 9 then
                        return "9th"
                  elseif f74_arg0 == 10 then
                        return "10th"
                  else
                        return tostring(f74_arg0) .. "th"
                  end
            end
      end
 
      CoD.HUDUtility.GetPlayerNameColorByClientNum = function ( f116_arg0, f116_arg1 )
	      if IsZombies() then
                  local f116_local0 = Enum[@"colorvisiondeficiencies"][@"cvd_off"]
                  local f116_local1 = Engine[@"getplayercommongamerprofile"]( f116_arg0 )
                  if f116_local1 ~= nil and f116_local1[@"colorblindmode"] ~= nil then
                        f116_local0 = f116_local1[@"colorblindmode"]:get()
                  end
                  if f116_local0 == Enum[@"colorvisiondeficiencies"][@"cvd_off"] then
                        local f116_local2 = nil
                        local f116_local3 = false

                        if f116_arg1 == 0 then
                                f116_local3 = true
                                f116_local2 = {1.00, 1.00, 1.00}  -- White
                        elseif f116_arg1 == 1 then
                                f116_local3 = true
                                f116_local2 = {0.49, 0.81, 0.93}  -- Light blue
                        elseif f116_arg1 == 2 then
                                f116_local3 = true
                                f116_local2 = {0.96, 0.79, 0.31}  -- Yellow/gold
                        elseif f116_arg1 == 3 then
                                f116_local3 = true
                                f116_local2 = {0.51, 0.93, 0.53}  -- Light green
                        elseif f116_arg1 == 4 then
                                f116_local3 = true
                                f116_local2 = {0.93, 0.51, 0.93}  -- Pink/purple
                        elseif f116_arg1 == 5 then
                                f116_local3 = true
                                f116_local2 = {1.00, 0.50, 0.31}  -- Orange
                        elseif f116_arg1 == 6 then
                                f116_local3 = true
                                f116_local2 = {0.54, 0.17, 0.89}  -- Purple
                        elseif f116_arg1 == 7 then
                                f116_local3 = true
                                f116_local2 = {0.94, 0.50, 0.50}  -- Salmon pink
                        elseif f116_arg1 == 8 then
                                f116_local3 = true
                                f116_local2 = {0.27, 0.51, 0.71}  -- Steel blue
                        elseif f116_arg1 == 9 then
                                f116_local3 = true 
                                f116_local2 = {0.85, 0.44, 0.84}  -- Orchid
                        elseif f116_arg1 == 10 then
                                f116_local3 = true
                                f116_local2 = {0.68, 0.85, 0.90}  -- Light cyan
                        elseif f116_arg1 == 11 then
                                f116_local3 = true
                                f116_local2 = {0.80, 0.52, 0.25}  -- Peru brown
                        elseif f116_arg1 == 12 then
                                f116_local3 = true
                                f116_local2 = {0.58, 0.00, 0.83}  -- Dark violet
                        elseif f116_arg1 == 13 then
                                f116_local3 = true
                                f116_local2 = {0.42, 0.56, 0.14}  -- Olive green
                        elseif f116_arg1 == 14 then
                                f116_local3 = true
                                f116_local2 = {0.96, 0.87, 0.70}  -- Wheat
                        elseif f116_arg1 == 15 then
                                f116_local3 = true
                                f116_local2 = {0.25, 0.41, 0.88}  -- Royal blue
                        end

                        if f116_local3 == false then
                                -- Default to blue for players above 15
                                f116_local2 = {0.49, 0.81, 0.93}
                        end

                        return f116_local2[1], f116_local2[2], f116_local2[3]
                  end
            end

            return CoD.HUDUtility.GetFriendlyOrEnemyColorByTeamId( f116_arg0, Engine[@"getteamid"]( f116_arg0, f116_arg1 ) )
      end

      CoD.HUDUtility.GetPlayerHealthBarColorByClientNum = function ( f117_arg0, f117_arg1 )
            if IsZombies() then
                  local f117_local0 = Enum[@"colorvisiondeficiencies"][@"cvd_off"]
                  local f117_local1 = Engine[@"getplayercommongamerprofile"]( f117_arg0 )
                  if f117_local1 ~= nil and f117_local1[@"colorblindmode"] ~= nil then
                        f117_local0 = f117_local1[@"colorblindmode"]:get()
                  end
                  if f117_local0 == Enum[@"colorvisiondeficiencies"][@"cvd_off"] then
                        local f116_local2 = nil

                        local f116_local3 = false

                        if f117_arg1 == 0 then
                                f116_local3 = true
                                f116_local2 = {1.00, 1.00, 1.00}  -- White
                        elseif f117_arg1 == 1 then
                                f116_local3 = true
                                f116_local2 = {0.49, 0.81, 0.93}  -- Light blue
                        elseif f117_arg1 == 2 then
                                f116_local3 = true
                                f116_local2 = {0.96, 0.79, 0.31}  -- Yellow/gold
                        elseif f117_arg1 == 3 then
                                f116_local3 = true
                                f116_local2 = {0.51, 0.93, 0.53}  -- Light green
                        elseif f117_arg1 == 4 then
                                f116_local3 = true
                                f116_local2 = {0.93, 0.51, 0.93}  -- Pink/purple
                        elseif f117_arg1 == 5 then
                                f116_local3 = true
                                f116_local2 = {1.00, 0.50, 0.31}  -- Orange
                        elseif f117_arg1 == 6 then
                                f116_local3 = true
                                f116_local2 = {0.54, 0.17, 0.89}  -- Purple
                        elseif f117_arg1 == 7 then
                                f116_local3 = true
                                f116_local2 = {0.94, 0.50, 0.50}  -- Salmon pink
                        elseif f117_arg1 == 8 then
                                f116_local3 = true
                                f116_local2 = {0.27, 0.51, 0.71}  -- Steel blue
                        elseif f117_arg1 == 9 then
                                f116_local3 = true 
                                f116_local2 = {0.85, 0.44, 0.84}  -- Orchid
                        elseif f117_arg1 == 10 then
                                f116_local3 = true
                                f116_local2 = {0.68, 0.85, 0.90}  -- Light cyan
                        elseif f117_arg1 == 11 then
                                f116_local3 = true
                                f116_local2 = {0.80, 0.52, 0.25}  -- Peru brown
                        elseif f117_arg1 == 12 then
                                f116_local3 = true
                                f116_local2 = {0.58, 0.00, 0.83}  -- Dark violet
                        elseif f117_arg1 == 13 then
                                f116_local3 = true
                                f116_local2 = {0.42, 0.56, 0.14}  -- Olive green
                        elseif f117_arg1 == 14 then
                                f116_local3 = true
                                f116_local2 = {0.96, 0.87, 0.70}  -- Wheat
                        elseif f117_arg1 == 15 then
                                f116_local3 = true
                                f116_local2 = {0.25, 0.41, 0.88}  -- Royal blue
                        end

                        if f116_local3 == false then
                                -- Default to blue for players above 15
                                f116_local2 = {0.49, 0.81, 0.93}
                        end

                        return f116_local2[1], f116_local2[2], f116_local2[3]
                  end
            end
            return CoD.HUDUtility.GetFriendlyOrEnemyHealthBarColorByTeamId( f117_arg0, Engine[@"getteamid"]( f117_arg0, f117_arg1 ) )
      end
      
      function ZombieClientScoreboardColor( f154_arg0 )
            local f154_local2_table = nil
            local f154_local3_valid = false

            if f154_arg0 == 0 then
                  f154_local3_valid = true
                  f154_local2_table = {1.00, 1.00, 1.00}  -- White
            elseif f154_arg0 == 1 then
                  f154_local3_valid = true
                  f154_local2_table = {0.49, 0.81, 0.93}  -- Light blue
            elseif f154_arg0 == 2 then
                  f154_local3_valid = true
                  f154_local2_table = {0.96, 0.79, 0.31}  -- Yellow/gold
            elseif f154_arg0 == 3 then
                  f154_local3_valid = true
                  f154_local2_table = {0.51, 0.93, 0.53}  -- Light green
            elseif f154_arg0 == 4 then
                  f154_local3_valid = true
                  f154_local2_table = {0.93, 0.51, 0.93}  -- Pink/purple
            elseif f154_arg0 == 5 then
                  f154_local3_valid = true
                  f154_local2_table = {1.00, 0.50, 0.31}  -- Orange
            elseif f154_arg0 == 6 then
                  f154_local3_valid = true
                  f154_local2_table = {0.54, 0.17, 0.89}  -- Purple
            elseif f154_arg0 == 7 then
                  f154_local3_valid = true
                  f154_local2_table = {0.94, 0.50, 0.50}  -- Salmon pink
            elseif f154_arg0 == 8 then
                  f154_local3_valid = true
                  f154_local2_table = {0.27, 0.51, 0.71}  -- Steel blue
            elseif f154_arg0 == 9 then
                  f154_local3_valid = true 
                  f154_local2_table = {0.85, 0.44, 0.84}  -- Orchid
            elseif f154_arg0 == 10 then
                  f154_local3_valid = true
                  f154_local2_table = {0.68, 0.85, 0.90}  -- Light cyan
            elseif f154_arg0 == 11 then
                  f154_local3_valid = true
                  f154_local2_table = {0.80, 0.52, 0.25}  -- Peru brown
            elseif f154_arg0 == 12 then
                  f154_local3_valid = true
                  f154_local2_table = {0.58, 0.00, 0.83}  -- Dark violet
            elseif f154_arg0 == 13 then
                  f154_local3_valid = true
                  f154_local2_table = {0.42, 0.56, 0.14}  -- Olive green
            elseif f154_arg0 == 14 then
                  f154_local3_valid = true
                  f154_local2_table = {0.96, 0.87, 0.70}  -- Wheat
            elseif f154_arg0 == 15 then
                  f154_local3_valid = true
                  f154_local2_table = {0.25, 0.41, 0.88}  -- Royal blue
            end

            if f154_local3_valid == false then
                  -- Default to blue for players above 15
                  f154_local2_table = {0.49, 0.81, 0.93}
            end

            if f154_local2_table then
                  return f154_local2_table[1], f154_local2_table[2], f154_local2_table[3]
            end
            
            f154_local2_table = {1.00, 1.00, 1.00}  -- White
            
            return f154_local2_table[1], f154_local2_table[2], f154_local2_table[3]
      end

      function ZombieClientScoreboardGlowColor( f155_arg0 )
            local f155_local0, f155_local1, f155_local2 = ZombieClientScoreboardColor( f155_arg0 )
            return f155_local0 * 0.75, f155_local1 * 0.75, f155_local2 * 0.75
      end

      CoD.Rush_Gameover_Score_Entry_CUSTOM = InheritFrom( LUI.UIElement )
      CoD.Rush_Gameover_Score_Entry_CUSTOM.__defaultWidth = 1000
      CoD.Rush_Gameover_Score_Entry_CUSTOM.__defaultHeight = 88
      CoD.Rush_Gameover_Score_Entry_CUSTOM.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.Rush_Gameover_Score_Entry_CUSTOM )
            self.id = "Rush_Gameover_Score_Entry_CUSTOM"
            self.soundSet = "none"
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            local Image = LUI.UIImage.new( 0, 0, 900, 941, 0, 0, 24, 65 )
            Image:setRGB( 0, 0, 0 )
            Image:setZRot( 45 )
            self:addElement( Image )
            self.Image = Image
            
            local blackBg = LUI.UIImage.new( 0, 0, 309.5, 920.5, 0, 0, 15.5, 73.5 )
            blackBg:setRGB( ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b )
            self:addElement( blackBg )
            self.blackBg = blackBg
            
            local teamPlayercard = LUI.UIImage.new( 0, 0, 198, 426, 0, 0, 0, 88 )
            teamPlayercard:setImage( RegisterImage( @"hash_357737C6CB8A7315" ) )
            self:addElement( teamPlayercard )
            self.teamPlayercard = teamPlayercard
            
            local teamPlayercardGold = LUI.UIImage.new( 0, 0, 201, 426, 0, 0, 2, 84 )
            teamPlayercardGold:setAlpha( 0 )
            teamPlayercardGold:setZRot( 180 )
            teamPlayercardGold:setImage( RegisterImage( @"hash_20F9B1B03667EE62" ) )
            self:addElement( teamPlayercardGold )
            self.teamPlayercardGold = teamPlayercardGold
            
            local ZombiesPortrait = CoD.ZombiesPortrait.new( f1_arg0, f1_arg1, 0, 0, 201, 281, 0, 0, 3, 83 )
            ZombiesPortrait:setRFTMaterial( LUI.UIImage.GetCachedMaterial( @"hash_2D79DB5C45AD6024" ) )
            ZombiesPortrait:setShaderVector( 0, 34, 6, 0, 0 )
            ZombiesPortrait:setShaderVector( 1, 80, 80, 0, 0 )
            ZombiesPortrait:setShaderVector( 2, 0, 0.05, 0, 0 )
            ZombiesPortrait.Portrait:setShaderVector( 0, 0.4, 0, 0, 0 )
            ZombiesPortrait:linkToElementModel( self, "scoreboard.characterIndex", true, function ( model )
                  local f7_local0 = model:get()
                  if f7_local0 ~= nil then
                        ZombiesPortrait.Portrait:setImage( RegisterImage( GetPositionDraftIconByIndex( f7_local0 ) ) )
                  end
            end )
            self:addElement( ZombiesPortrait )
            self.ZombiesPortrait = ZombiesPortrait
            
            local GamerTagShadow = LUI.UIText.new( 0, 0, 54, 191, 0, 0, 53.5, 74.5 )
            GamerTagShadow:setRGB( ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b )
            GamerTagShadow:setTTF( "notosans_regular" )
            GamerTagShadow:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            GamerTagShadow:setAlignment( Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"] )
            GamerTagShadow:linkToElementModel( self, "scoreboard.playerName", true, function ( model )
                  local f3_local0 = model:get()
                  if f3_local0 ~= nil then
                        GamerTagShadow:setText( CoD.SocialUtility.CleanGamerTag( f3_local0 ) )
                  end
            end )
            self:addElement( GamerTagShadow )
            self.GamerTagShadow = GamerTagShadow
            
            local GamerTag = LUI.UIText.new( 0, 0, 54, 191, 0, 0, 53.5, 74.5 )
            GamerTag:setTTF( "notosans_regular" )
            GamerTag:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            GamerTag:setAlignment( Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"] )
            GamerTag:linkToElementModel( self, "clientNum", true, function ( model )
                  local f4_local0 = model:get()
                  if f4_local0 ~= nil then
                        GamerTag:setRGB( ZombieClientScoreboardColor( f4_local0 ) )
                  end
            end )
            GamerTag:linkToElementModel( self, "scoreboard.playerName", true, function ( model )
                  local f5_local0 = model:get()
                  if f5_local0 ~= nil then
                        GamerTag:setText( CoD.SocialUtility.CleanGamerTag( f5_local0 ) )
                  end
            end )
            self:addElement( GamerTag )
            self.GamerTag = GamerTag
            
            local Col1 = LUI.UIText.new( 0, 0, 287, 423, 0, 0, 27, 71 )
            Col1:setTTF( "skorzhen" )
            Col1:setLetterSpacing( 0.5 )
            Col1:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            Col1:setAlignment( Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"] )
            Col1:linkToElementModel( self, "clientNum", true, function ( model )
                  local f6_local0 = model:get()
                  if f6_local0 ~= nil then
                        Col1:setRGB( ZombieClientScoreboardColor( f6_local0 ) )
                  end
            end )
            Col1:linkToElementModel( self, "scoreboard.col1", true, function ( model )
                  local f7_local0 = model:get()
                  if f7_local0 ~= nil then
                        Col1:setText( CoD.TextUtility.FormatNumberWithDelimiters( f7_local0 ) )
                  end
            end )
            LUI.OverrideFunction_CallOriginalFirst( Col1, "setText", function ( element, controller )
                  ScaleWidgetToLabel( self, element, 0 )
            end )
            self:addElement( Col1 )
            self.Col1 = Col1
            
            local Col2 = LUI.UIText.new( 0, 0, 440, 521, 0, 0, 33.5, 58.5 )
            Col2:setTTF( "skorzhen" )
            Col2:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            Col2:linkToElementModel( self, "clientNum", true, function ( model )
                  local f9_local0 = model:get()
                  if f9_local0 ~= nil then
                        Col2:setRGB( ZombieClientScoreboardColor( f9_local0 ) )
                  end
            end )
            Col2:linkToElementModel( self, "scoreboard.col2", true, function ( model )
                  local f10_local0 = model:get()
                  if f10_local0 ~= nil then
                        Col2:setText( f10_local0 )
                  end
            end )
            self:addElement( Col2 )
            self.Col2 = Col2
            
            local Col3 = LUI.UIText.new( 0, 0, 542, 667, 0, 0, 33.5, 58.5 )
            Col3:setTTF( "skorzhen" )
            Col3:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            Col3:linkToElementModel( self, "clientNum", true, function ( model )
                  local f11_local0 = model:get()
                  if f11_local0 ~= nil then
                        Col3:setRGB( ZombieClientScoreboardColor( f11_local0 ) )
                  end
            end )
            Col3:linkToElementModel( self, "scoreboard.col3", true, function ( model )
                  local f12_local0 = model:get()
                  if f12_local0 ~= nil then
                        Col3:setText( f12_local0 )
                  end
            end )
            self:addElement( Col3 )
            self.Col3 = Col3
            
            local Col4 = LUI.UIText.new( 0, 0, 684, 809, 0, 0, 33.5, 58.5 )
            Col4:setTTF( "skorzhen" )
            Col4:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            Col4:linkToElementModel( self, "clientNum", true, function ( model )
                  local f13_local0 = model:get()
                  if f13_local0 ~= nil then
                        Col4:setRGB( ZombieClientScoreboardColor( f13_local0 ) )
                  end
            end )
            Col4:linkToElementModel( self, "scoreboard.footer1", true, function ( model )
                  local f14_local0 = model:get()
                  if f14_local0 ~= nil then
                        Col4:setText( CoD.ZombieUtility.GetZombieScoreboardColumnRushMultiplierTreatment( f1_arg1, f14_local0 ) )
                  end
            end )
            self:addElement( Col4 )
            self.Col4 = Col4
            
            local PositionShadow = LUI.UIText.new( 0, 0, 57, 178, 0, 0, 20.5, 59.5 )
            PositionShadow:setRGB( ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b )
            PositionShadow:setAlpha( 0.5 )
            PositionShadow:setTTF( "default" )
            PositionShadow:setLetterSpacing( 2 )
            PositionShadow:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            PositionShadow:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
            --PositionShadow:linkToElementModel( self, "position", true, function ( model )
            --      local f17_local0 = model:get()
            --      if f17_local0 ~= nil then

            --      end
            --end )
            self:addElement( PositionShadow )
            self.PositionShadow = PositionShadow
            
            local Position = LUI.UIText.new( 0, 0, 54, 175, 0, 0, 16.5, 55.5 )
            Position:setTTF( "default" )
            Position:setLetterSpacing( 2 )
            Position:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            Position:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
            --Position:linkToElementModel( self, "position", true, function ( model )
            --      local f18_local0 = model:get()
            --      if f18_local0 ~= nil then
                        
            --      end
            --end )
            self:addElement( Position )
            self.Position = Position

            local Col5 = LUI.UIText.new( 0, 0, 822, 947, 0, 0, 33.5, 58.5 )
            Col5:setTTF( "skorzhen" )
            Col5:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            Col5:linkToElementModel( self, "clientNum", true, function ( model )
                  local f15_local0 = model:get()
                  if f15_local0 ~= nil then
                        Col5:setRGB( ZombieClientScoreboardColor( f15_local0 ) )
                  
                        if ScoreboardListPos[f15_local0] == nil then
                              ScoreBoardPos = ScoreBoardPos + 1
                              ScoreboardListPos[f15_local0] = ScoreBoardPos
                        end

                        self.PositionShadow:setText( CoD.ZombieUtility.GetStringPositionForIndex( ScoreboardListPos[f15_local0] ) )
                        self.Position:setText( CoD.ZombieUtility.GetStringPositionForIndex( ScoreboardListPos[f15_local0] ) )
                  end
            end )
            Col5:linkToElementModel( self, "scoreboard.footer2", true, function ( model )
                  local f16_local0 = model:get()
                  if f16_local0 ~= nil then
                        Col5:setText( f16_local0 )
                  end
            end )
            self:addElement( Col5 )
            self.Col5 = Col5
            
            local FrameEnd = LUI.UIImage.new( 0, 0, 863.5, 969.5, 0.5, 0.5, -46.5, 46.5 )
            FrameEnd:setImage( RegisterImage( @"uie_zm_hud_scoreboard_frame_end" ) )
            self:addElement( FrameEnd )
            self.FrameEnd = FrameEnd
            
            self:mergeStateConditions( {
                  {
                        stateName = "IsSelf",
                        condition = function ( menu, element, event )
                              return CoD.ZombieUtility.IsClientnumFromElementEqualToOurs( f1_arg1, element )
                        end
                  }
            } )
            self:linkToElementModel( self, "clientNum", true, function ( model )
                  f1_arg0:updateElementState( self, {
                        name = "model_validation",
                        menu = f1_arg0,
                        controller = f1_arg1,
                        modelValue = model:get(),
                        modelName = "clientNum"
                  } )
            end )
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end

            CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenuScoreboard( self, f1_arg1, f1_arg0 )
            
            return self
      end

      CoD.Rush_Gameover_Score_Entry_CUSTOM.__resetProperties = function ( f21_arg0 )
            f21_arg0.teamPlayercardGold:completeAnimation()
            f21_arg0.Col1:completeAnimation()
            f21_arg0.teamPlayercard:completeAnimation()
            f21_arg0.blackBg:completeAnimation()
            f21_arg0.teamPlayercardGold:setLeftRight( 0, 0, 201, 426 )
            f21_arg0.teamPlayercardGold:setTopBottom( 0, 0, 2, 84 )
            f21_arg0.teamPlayercardGold:setAlpha( 0 )
            f21_arg0.Col1:setLeftRight( 0, 0, 287, 423 )
            f21_arg0.Col1:setTopBottom( 0, 0, 27, 71 )
            f21_arg0.Col1:setAlignment( Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"] )
            f21_arg0.teamPlayercard:setAlpha( 1 )
            f21_arg0.blackBg:setLeftRight( 0, 0, 309.5, 920.5 )
            f21_arg0.blackBg:setRGB( ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b )
      end

      CoD.Rush_Gameover_Score_Entry_CUSTOM.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f22_arg0, f22_arg1 )
                        f22_arg0:__resetProperties()
                        f22_arg0:setupElementClipCounter( 2 )
                        f22_arg0.teamPlayercardGold:completeAnimation()
                        f22_arg0.teamPlayercardGold:setLeftRight( 0, 0, 201, 431 )
                        f22_arg0.teamPlayercardGold:setTopBottom( 0, 0, 1, 86 )
                        f22_arg0.teamPlayercardGold:setAlpha( 0 )
                        f22_arg0.clipFinished( f22_arg0.teamPlayercardGold )
                        f22_arg0.Col1:completeAnimation()
                        f22_arg0.Col1:setLeftRight( 0, 0, 287, 418 )
                        f22_arg0.Col1:setTopBottom( 0, 0, 23.5, 67.5 )
                        f22_arg0.clipFinished( f22_arg0.Col1 )
                  end,
                  Focus = function ( f35_arg0, f35_arg1 )
                        
                  end,
                  GainFocus = function ( f36_arg0, f36_arg1 )
                        
                  end,
                  LoseFocus = function ( f38_arg0, f38_arg1 )
                        
                  end
            },
            IsSelf = {
                  DefaultClip = function ( f23_arg0, f23_arg1 )
                        f23_arg0:__resetProperties()
                        f23_arg0:setupElementClipCounter( 4 )
                        f23_arg0.blackBg:completeAnimation()
                        f23_arg0.blackBg:setLeftRight( 0, 0, 281.5, 920.5 )
                        f23_arg0.blackBg:setRGB( 0, 0, 0 )
                        f23_arg0.clipFinished( f23_arg0.blackBg )
                        f23_arg0.teamPlayercard:completeAnimation()
                        f23_arg0.teamPlayercard:setAlpha( 0 )
                        f23_arg0.clipFinished( f23_arg0.teamPlayercard )
                        f23_arg0.teamPlayercardGold:completeAnimation()
                        f23_arg0.teamPlayercardGold:setLeftRight( 0, 0, 201, 426 )
                        f23_arg0.teamPlayercardGold:setTopBottom( 0, 0, 2, 84 )
                        f23_arg0.teamPlayercardGold:setAlpha( 1 )
                        f23_arg0.clipFinished( f23_arg0.teamPlayercardGold )
                        f23_arg0.Col1:completeAnimation()
                        f23_arg0.Col1:setLeftRight( 0, 0, 290, 426 )
                        f23_arg0.Col1:setTopBottom( 0, 0, 29.5, 73.5 )
                        f23_arg0.clipFinished( f23_arg0.Col1 )
                  end,
                  Focus = function ( f35_arg0, f35_arg1 )
                        
                  end,
                  GainFocus = function ( f36_arg0, f36_arg1 )
                        
                  end,
                  LoseFocus = function ( f38_arg0, f38_arg1 )
                        
                  end
            }
      }

      CoD.Rush_Gameover_Score_Entry_CUSTOM.__onClose = function ( f24_arg0 )
            f24_arg0.ZombiesPortrait:close()
            f24_arg0.GamerTagShadow:close()
            f24_arg0.GamerTag:close()
            f24_arg0.Col1:close()
            f24_arg0.Col2:close()
            f24_arg0.Col3:close()
            f24_arg0.Col4:close()
            f24_arg0.Col5:close()
            f24_arg0.PositionShadow:close()
            f24_arg0.Position:close()
      end

      CoD.Rush_Gameover_Scoreboard = InheritFrom( LUI.UIElement )
      CoD.Rush_Gameover_Scoreboard.__defaultWidth = 1000
      CoD.Rush_Gameover_Scoreboard.__defaultHeight = 379
      CoD.Rush_Gameover_Scoreboard.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            ScoreBoardPos = 0
            ScoreboardListPos = {}

            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            self:setClass( CoD.Rush_Gameover_Scoreboard )
            self.id = "Rush_Gameover_Scoreboard"
            self.soundSet = "default"
            self.anyChildUsesUpdateState = true
            
            local RushScoreboard = LUI.UIList.new( f1_arg0, f1_arg1, 7, 0, nil, false, false, false, false )
            RushScoreboard:setLeftRight( 0, 0, 0, 1000 )
            RushScoreboard:setTopBottom( 0, 0, 27, 379 )
            RushScoreboard:setWidgetType( CoD.Rush_Gameover_Score_Entry_CUSTOM )
            RushScoreboard:setVerticalCount( 7 )
            RushScoreboard:setVerticalCounter( CoD.verticalCounter )
            RushScoreboard:setSpacing( 0 )
            RushScoreboard:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            RushScoreboard:setDataSource( "Clients" )

            RushScoreboard:registerEventHandler( "list_item_gain_focus", function ( element, event )
                  local f2_local0 = nil
                  CoD.ScoreboardUtility.SetCurrentFocusedClient( element, f1_arg1 )
                  return f2_local0
            end )

            RushScoreboard:registerEventHandler( "gain_focus", function ( element, event )
                  local f3_local0 = nil
                  if element.gainFocus then
                        f3_local0 = element:gainFocus( event )
                  elseif element.super.gainFocus then
                        f3_local0 = element.super:gainFocus( event )
                  end
                  CoD.ScoreboardUtility.SetSavedActiveItemToLocalPlayer( element, f1_arg1 )
                  CoD.Menu.UpdateButtonShownState( element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"] )
                  return f3_local0
            end )

            self.__on_onStartMenuOpened_Scoreboard = function ( f6_arg0, f6_arg1 )
                  CoD.GridAndListUtility.SortListByControllerModelKeys( f6_arg1, RushScoreboard, "scoreboardInfo.sortKey0", "scoreboardInfo.sortKey1", "scoreboardInfo.sortKey2" )
            end
            
            LUI.OverrideFunction_CallOriginalFirst( f1_arg0, "onStartMenuOpened", self.__on_onStartMenuOpened_Scoreboard )

            self:addElement( RushScoreboard )
            self.RushScoreboard = RushScoreboard

            if f1_arg0.RestartLevelPrompt ~= nil then
                  f1_arg0.RestartLevelPrompt:setLeftRight(0.50, 0.50, -350.00, 350.00)
                  f1_arg0.RestartLevelPrompt:setTopBottom(0.50, 0.50, -330.00, -230.00)
            end
            
            self:subscribeToGlobalModel( f1_arg1, "PerController", "Clients.clientCount", function ( model )
                  local f8_local0 = self
                  UpdateDataSource( self, self.RushScoreboard, f1_arg1 )
            end )

            CoD.GridAndListUtility.SortListByControllerModelKeys( f1_arg1, RushScoreboard, "scoreboardInfo.sortKey0", "scoreboardInfo.sortKey1", "scoreboardInfo.sortKey2" )
            
            local Col1Label = LUI.UIText.new( 0, 0, 277.5, 402.5, 0, 0, 7, 28 )
            Col1Label:setRGB( 0, 0, 0 )
            Col1Label:setAlpha( 0.5 )
            Col1Label:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"menu/new" ) )
            Col1Label:setTTF( "skorzhen" )
            Col1Label:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            Col1Label:setAlignment( Enum[@"luialignment"][@"lui_alignment_middle"] )
            self:addElement( Col1Label )
            self.Col1Label = Col1Label
            
            local Col1LabelShadow = LUI.UIText.new( 0, 0, 274.5, 399.5, 0, 0, 4, 25 )
            Col1LabelShadow:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"menu/new" ) )
            Col1LabelShadow:setTTF( "skorzhen" )
            Col1LabelShadow:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            Col1LabelShadow:setAlignment( Enum[@"luialignment"][@"lui_alignment_middle"] )
            self:addElement( Col1LabelShadow )
            self.Col1LabelShadow = Col1LabelShadow
            
            local Col2Label = LUI.UIText.new( 0, 0, 419.5, 544.5, 0, 0, 8, 29 )
            Col2Label:setRGB( 0, 0, 0 )
            Col2Label:setAlpha( 0.5 )
            Col2Label:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"menu/new" ) )
            Col2Label:setTTF( "skorzhen" )
            Col2Label:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            Col2Label:setAlignment( Enum[@"luialignment"][@"lui_alignment_bottom"] )
            self:addElement( Col2Label )
            self.Col2Label = Col2Label
            
            local Col2LabelShadow = LUI.UIText.new( 0, 0, 419.5, 544.5, 0, 0, 3, 24 )
            Col2LabelShadow:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"menu/new" ) )
            Col2LabelShadow:setTTF( "skorzhen" )
            Col2LabelShadow:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            Col2LabelShadow:setAlignment( Enum[@"luialignment"][@"lui_alignment_middle"] )
            self:addElement( Col2LabelShadow )
            self.Col2LabelShadow = Col2LabelShadow
            
            local Col3Label = LUI.UIText.new( 0, 0, 544.5, 669.5, 0, 0, 7, 28 )
            Col3Label:setRGB( 0, 0, 0 )
            Col3Label:setAlpha( 0.5 )
            Col3Label:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"menu/new" ) )
            Col3Label:setTTF( "skorzhen" )
            Col3Label:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            Col3Label:setAlignment( Enum[@"luialignment"][@"lui_alignment_bottom"] )
            self:addElement( Col3Label )
            self.Col3Label = Col3Label
            
            local Col3LabelShadow = LUI.UIText.new( 0, 0, 544.5, 669.5, 0, 0, 4, 25 )
            Col3LabelShadow:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"menu/new" ) )
            Col3LabelShadow:setTTF( "skorzhen" )
            Col3LabelShadow:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            Col3LabelShadow:setAlignment( Enum[@"luialignment"][@"lui_alignment_middle"] )
            self:addElement( Col3LabelShadow )
            self.Col3LabelShadow = Col3LabelShadow
            
            local Col4Label = LUI.UIText.new( 0, 0, 684.5, 809.5, 0, 0, 7, 28 )
            Col4Label:setRGB( 0, 0, 0 )
            Col4Label:setAlpha( 0.5 )
            Col4Label:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"menu/new" ) )
            Col4Label:setTTF( "skorzhen" )
            Col4Label:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            Col4Label:setAlignment( Enum[@"luialignment"][@"lui_alignment_bottom"] )
            self:addElement( Col4Label )
            self.Col4Label = Col4Label
            
            local Col4LabelShadow = LUI.UIText.new( 0, 0, 683.5, 808.5, 0, 0, 4, 25 )
            Col4LabelShadow:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"menu/new" ) )
            Col4LabelShadow:setTTF( "skorzhen" )
            Col4LabelShadow:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            Col4LabelShadow:setAlignment( Enum[@"luialignment"][@"lui_alignment_middle"] )
            self:addElement( Col4LabelShadow )
            self.Col4LabelShadow = Col4LabelShadow
            
            local Col5Label = LUI.UIText.new( 0, 0, 835.5, 960.5, 0, 0, 7, 28 )
            Col5Label:setRGB( 0, 0, 0 )
            Col5Label:setAlpha( 0.5 )
            Col5Label:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"menu/new" ) )
            Col5Label:setTTF( "skorzhen" )
            Col5Label:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            Col5Label:setAlignment( Enum[@"luialignment"][@"lui_alignment_middle"] )
            self:addElement( Col5Label )
            self.Col5Label = Col5Label
            
            local Col5LabelShadow = LUI.UIText.new( 0, 0, 836.5, 961.5, 0, 0, 4, 25 )
            Col5LabelShadow:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"menu/new" ) )
            Col5LabelShadow:setTTF( "skorzhen" )
            Col5LabelShadow:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            Col5LabelShadow:setAlignment( Enum[@"luialignment"][@"lui_alignment_middle"] )
            self:addElement( Col5LabelShadow )
            self.Col5LabelShadow = Col5LabelShadow
            
            RushScoreboard.id = "RushScoreboard"
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            local f1_local12 = self
            CoD.ScoreboardUtility.SetRowHeader( f1_arg1, self.Col1Label, 0 )
            CoD.ScoreboardUtility.SetRowHeader( f1_arg1, self.Col1LabelShadow, 0 )
            CoD.ScoreboardUtility.SetRowHeader( f1_arg1, self.Col2Label, 1 )
            CoD.ScoreboardUtility.SetRowHeader( f1_arg1, self.Col2LabelShadow, 1 )
            CoD.ScoreboardUtility.SetRowHeader( f1_arg1, self.Col3Label, 2 )
            CoD.ScoreboardUtility.SetRowHeader( f1_arg1, self.Col3LabelShadow, 2 )
            CoD.ScoreboardUtility.SetRowHeader( f1_arg1, self.Col4Label, 3 )
            CoD.ScoreboardUtility.SetRowHeader( f1_arg1, self.Col4LabelShadow, 3 )
            CoD.ScoreboardUtility.SetRowHeader( f1_arg1, self.Col5Label, 4 )
            CoD.ScoreboardUtility.SetRowHeader( f1_arg1, self.Col5LabelShadow, 4 )

            local f1_local4 = RushScoreboard
            SetElementProperty( f1_local4, "friendlyTeam", true )
            CoD.GridAndListUtility.AddListUpDownNavigation( f1_arg0, f1_local4, f1_arg1 )
            --CoD.FreeCursorUtility.SetListFocusIgnoresFreeCursor( f1_local4, f1_arg1 )

            CoD.EnhModPrintInfo("rush gameover scoreboard loaded")

            return self
      end

      CoD.Rush_Gameover_Scoreboard.__onClose = function ( f2_arg0 )
            f2_arg0.RushScoreboard:close()
            f2_arg0.Col1Label:close()
            f2_arg0.Col1LabelShadow:close()
            f2_arg0.Col2Label:close()
            f2_arg0.Col2LabelShadow:close()
            f2_arg0.Col3Label:close()
            f2_arg0.Col3LabelShadow:close()
            f2_arg0.Col4Label:close()
            f2_arg0.Col4LabelShadow:close()
            f2_arg0.Col5Label:close()
            f2_arg0.Col5LabelShadow:close()
      end

      CoD.ScoreboardZM = InheritFrom( LUI.UIElement )
      CoD.ScoreboardZM.__defaultWidth = 888
      CoD.ScoreboardZM.__defaultHeight = 400
      CoD.ScoreboardZM.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
            CoD.BaseUtility.CreateControllerModel( f1_arg1, "Clients.clientChangedTeam" )
            CoD.BaseUtility.CreateControllerModel( f1_arg1, "Clients.clientCount" )
            CoD.ScoreboardUtility.InitScoreboardSortKey( f1_arg1 )
            self:setClass( CoD.ScoreboardZM )
            self.id = "ScoreboardZM"
            self.soundSet = "default"
            self.onlyChildrenFocusable = true
            self.anyChildUsesUpdateState = true
            f1_arg0:addElementToPendingUpdateStateList( self )
            
            local Scoreboard = LUI.UIList.new( f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false )
            Scoreboard:setLeftRight( 0.5, 0.5, -444, 444 )
            Scoreboard:setTopBottom( 0, 0, 81, 413 )
            Scoreboard:setWidgetType( CoD.ScoreboardRowZM )
            Scoreboard:setVerticalCount( 7 )
            Scoreboard:setVerticalCounter( CoD.verticalCounter )
            Scoreboard:setSpacing( 20 )
            Scoreboard:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            Scoreboard:setDataSource( "Clients" )
            Scoreboard:registerEventHandler( "list_item_gain_focus", function ( element, event )
                  local f2_local0 = nil
                  CoD.ScoreboardUtility.SetCurrentFocusedClient( element, f1_arg1 )
                  return f2_local0
            end )
            Scoreboard:registerEventHandler( "gain_focus", function ( element, event )
                  local f3_local0 = nil
                  if element.gainFocus then
                        f3_local0 = element:gainFocus( event )
                  elseif element.super.gainFocus then
                        f3_local0 = element.super:gainFocus( event )
                  end
                  CoD.ScoreboardUtility.SetSavedActiveItemToLocalPlayer( element, f1_arg1 )
                  CoD.Menu.UpdateButtonShownState( element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"] )
                  return f3_local0
            end )
            f1_arg0:AddButtonCallbackFunction( Scoreboard, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function ( element, menu, controller, model )
                  CoD.ScoreboardUtility.ToggleClientMute( element, controller )
                  return true
            end, function ( element, menu, controller )
                  CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil )
                  return false
            end, false )
            self.__on_onStartMenuOpened_Scoreboard = function ( f6_arg0, f6_arg1 )
                  CoD.GridAndListUtility.SortListByControllerModelKeys( f6_arg1, Scoreboard, "scoreboardInfo.sortKey0", "scoreboardInfo.sortKey1", "scoreboardInfo.sortKey2" )
            end
            
            LUI.OverrideFunction_CallOriginalFirst( f1_arg0, "onStartMenuOpened", self.__on_onStartMenuOpened_Scoreboard )
            self:addElement( Scoreboard )
            self.Scoreboard = Scoreboard
            
            local ScoreboardColHeadersZM = CoD.ScoreboardColHeadersZM.new( f1_arg0, f1_arg1, 0.5, 0.5, -444, 444, 0, 0, 30, 60 )
            self:addElement( ScoreboardColHeadersZM )
            self.ScoreboardColHeadersZM = ScoreboardColHeadersZM
            
            local Map = LUI.UIText.new( 0.5, 0.5, -444, 445, 0, 0, -14, 26 )
            Map:setRGB( 0.58, 0.85, 1 )
            Map:setAlpha( 0.5 )
            Map:setText( CoD.MapUtility.GetInGameLocalizedMapName( @"mpui/seaside" ) )
            Map:setTTF( "skorzhen" )
            Map:setLetterSpacing( 4 )
            Map:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
            Map:setAlignment( Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"] )
            self:addElement( Map )
            self.Map = Map
            
            self:mergeStateConditions( {
                  {
                        stateName = "InFrontend",
                        condition = function ( menu, element, event )
                              return InFrontend()
                        end
                  }
            } )
            self:subscribeToGlobalModel( f1_arg1, "PerController", "Clients.clientCount", function ( model )
                  local f8_local0 = self
                  UpdateDataSource( self, self.Scoreboard, f1_arg1 )
            end )
            Scoreboard.id = "Scoreboard"
            self.__on_close_removeOverrides = function ()
                  LUI.OverrideFunction_Remove( f1_arg0, "onStartMenuOpened", self.__on_onStartMenuOpened_Scoreboard )
            end
            
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg1, f1_arg0 )
            end
            
            local f1_local4 = self
            f1_local4 = Scoreboard
            SetElementProperty( f1_local4, "friendlyTeam", true )
            CoD.GridAndListUtility.AddListUpDownNavigation( f1_arg0, f1_local4, f1_arg1 )
            CoD.FreeCursorUtility.SetListFocusIgnoresFreeCursor( f1_local4, f1_arg1 )
            CoD.GridAndListUtility.SortListByControllerModelKeys( f1_arg1, f1_local4, "scoreboardInfo.sortKey0", "scoreboardInfo.sortKey1", "scoreboardInfo.sortKey2" )
            return self
      end

      CoD.ScoreboardZM.__resetProperties = function ( f10_arg0 )
            f10_arg0.Map:completeAnimation()
            f10_arg0.Scoreboard:completeAnimation()
            f10_arg0.Map:setAlpha( 0.5 )
            f10_arg0.Scoreboard:setLeftRight( 0.5, 0.5, -444, 444 )
      end

      CoD.ScoreboardZM.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f11_arg0, f11_arg1 )
                        f11_arg0:__resetProperties()
                        f11_arg0:setupElementClipCounter( 0 )
                  end
            },
            InFrontend = {
                  DefaultClip = function ( f12_arg0, f12_arg1 )
                        f12_arg0:__resetProperties()
                        f12_arg0:setupElementClipCounter( 2 )
                        f12_arg0.Scoreboard:completeAnimation()
                        f12_arg0.Scoreboard:setLeftRight( 0.5, 0.5, -444, 444 )
                        f12_arg0.clipFinished( f12_arg0.Scoreboard )
                        f12_arg0.Map:completeAnimation()
                        f12_arg0.Map:setAlpha( 0 )
                        f12_arg0.clipFinished( f12_arg0.Map )
                  end
            }
      }

      CoD.ScoreboardZM.__onClose = function ( f13_arg0 )
            f13_arg0.__on_close_removeOverrides()
            f13_arg0.Scoreboard:close()
            f13_arg0.ScoreboardColHeadersZM:close()
      end
end