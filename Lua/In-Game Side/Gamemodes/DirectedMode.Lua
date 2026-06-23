--[[
      .\hksc.exe '.\Scripts\DirectedMode.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\DirectedMode.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

-- main objectives, round cap is in the round container widget.
CoD.DirectedModeObjective = InheritFrom( LUI.UIElement )
CoD.DirectedModeObjective.__defaultWidth = 1920
CoD.DirectedModeObjective.__defaultHeight = 1080
CoD.DirectedModeObjective.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
      local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.DirectedModeObjective )
	self.id = "DirectedModeObjective"
	self.soundSet = "FriendsMenu"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )

      -------------------------------------

      local Objectives_Table = {}
      if CoD.BO4GetMap() == "IX" then
            Objectives_Table = {
                  [0] = {Title = "", Desc = ""},
                  
                  -- PAP
                  [1] = {Title = "Pack-a-Punch", Desc = "Locate the four Encounters and get the Heads. (%d/4)"},
                  [2] = {Title = "Pack-a-Punch", Desc = "Place the four Heads in the Pack-a-Punch machine to turn it on."},

                  -- WONDER WEAPON
                  [3] = {Title = "Wonder Weapon", Desc = "Shoot the Cauldron that is marked with a weapon."},
                  [4] = {Title = "Wonder Weapon", Desc = "Pick up the Marked Stone Head."},
                  [5] = {Title = "Acid Trap", Desc = "Build the Acid Trap by Collecting Parts and Completing Three Challenges, Start a challenge by knifing any of the Marked Flags (%d/3)"},
                  [6] = {Title = "Acid Trap", Desc = "Build the Acid Trap in either of the four marked locations on the map."},
                  [7] = {Title = "Acid Trap", Desc = "Place the head in the trap and activate the trap to melt it."},
                  [8] = {Title = "Acid Trap", Desc = "Pick up the Scorpion Key."},
                  [9] = {Title = "Golden Vase", Desc = "Maintain a positive crowd affinity for about two rounds to earn the Golden Vase."},
                  [10] = {Title = "Golden Vase", Desc = "Pick up the Golden Vase"},
                  [11] = {Title = "Wonder Weapon", Desc = "Go to the marked Tree location and knife the tree to place the Scorpion Key and interact to place the Golden Vase."},
                  [12] = {Title = "Wonder Weapon", Desc = "Wait a Round to pick up the Golden Vase."},
                  [13] = {Title = "Wonder Weapon", Desc = "Go to the Mystery Box location and poison the box to get the Wonder Weapon."},

                  -- SHIELD PARTS
                  [14] = {Title = "Shield", Desc = "Locate and collect all the marked shield parts to build the shield. (%d/3)"},

                  -- MAIN QUEST
                  -- DANU TOWER
                  [15] = {Title = "Skull Head", Desc = "Locate the marked Skull Head, and use the specialist (or melee it) while looking at it, then pick it up."},
                  [16] = {Title = "Grinder", Desc = "Locate the marked Grinder, Place the Skull inside it."},
                  [17] = {Title = "Grinder", Desc = "Use the Wonder Weapon to full charge shoot it three times, then pick up the remainings of the Skull. (%d/3)"},

                  [18] = {Title = "Dung", Desc = "Maintain a negative crowd affinity to collect the Dung. (Tip: use the fire traps to lose crowd affinity faster)"},
                  [19] = {Title = "Dung", Desc = "Collect the Dung."},

                  [21] = {Title = "Wood", Desc = "Wait for a Gladiator to spawn."},
                  [22] = {Title = "Wood", Desc = "Make the Gladiator throw his axe on either marked towers to get the Wood."},
                  [23] = {Title = "Wood", Desc = "Pick up the fallen Wood."}, 
                  [24] = {Title = "Wood", Desc = "Place the Wood in marked location."}, 
                  [25] = {Title = "Wood", Desc = "Wait a round to get the Wood."},
                  [26] = {Title = "Wood", Desc = "Pick up the marked Wood."},

                  [20] = {Title = "Dung", Desc = "Place the Dung in the marked location."},
                  [27] = {Title = "Dung", Desc = "Wait a full round to get the Dung."},
                  [28] = {Title = "Dung", Desc = "Pick up the marked Dung."},

                  [29] = {Title = "Fertilizer", Desc = "Place the Fertilizer in the marked location."},
                  [30] = {Title = "Fertilizer", Desc = "Wait full 3 rounds (%d/3)."},
                  [31] = {Title = "Fertilizer", Desc = "Get Fire Bomb (AAT) on your Weapon then shoot a Zombie near it to activate Fire Bomb on the Fertilizer."},
                  
                  [32] = {Title = "Starting Danu's Challenge", Desc = "Stand near the Fertilizer area for 13+ seconds to start Danu's Challenge. (%d/13)"},   
                  [33] = {Title = "Danu's Challenge", Desc = "Destroy and damage the three marked Blight Blisters (%d/3)"}, 
                  
                  -- RA TOWER
                  [34] = {Title = "Bull Heads", Desc = "Locate and shoot the marked Bull Heads with your Shield, and kill its Gladiator. (%d/4)"},

                  [35] = {Title = "Starting RA's Challenge", Desc = "Go to the marked location and interact with the Piller to start RA's Challenge."},
                  [36] = {Title = "RA's Challenge", Desc = "Kill the Special Zombies in the order shown by the Piller, or The Marked Special Zombies. (%d/4)"},
                  [37] = {Title = "RA's Challenge Failed", Desc = "You have failed RA's Challenge, wait a full round to begin again."},

                  -- ZEUS's TOWER
                  [38] = {Title = "The Storm", Desc = "Interact with the marked small Piller."},
                  [39] = {Title = "The Storm", Desc = "Shoot the Screws with your Shield. (%d/4)"},

                  [40] = {Title = "The Storm", Desc = "Kill Specials or Zombies inside the Electric Marked Circles with Kilowatt Activation. (%d/4)"},

                  [41] = {Title = "Starting Zeus's Challenge", Desc = "Interact with any of the marked Blue Balls."},
                  [42] = {Title = "Zeus's Challenge", Desc = "Survive the challenge against the enemies. (%d remaining)"},

                  -- ODIN's TOWER
                  [43] = {Title = "Light Symbols", Desc = "Shoot each of the 3 grouped marked Light Symbols with the Wonder Weapon (aligned shot)."},
                  [44] = {Title = "Starting Odin's Challenge", Desc = "Stand on the marked pressure plate for about 6 seconds to start Odin's Challenge. (%d/6)"},
                  [45] = {Title = "Odin's Challenge", Desc = "Survive the challenge against the enemies. (%d remaining)"},
                  [46] = {Title = "Odin's Challenge", Desc = "Pick up the marked Key."},

                  -- BOSS FIGHT
                  [47] = {Title = "The Most Venerated Warrior", Desc = "Get ready for the final boss fight, when you are, Go to the marked Portal and Interact with it."},
                  [48] = {Title = "The Most Venerated Warrior", Desc = "Survive the lockdown."},
                  [49] = {Title = "The Most Venerated Warrior", Desc = "Defeat The Most Venerated Opponent."}, -- elephant boss fight
                  
                  -- NOTIFY
                  [999] = {Title = "Directed Mode Completed!", Desc = "Congratulations on completing Directed Mode!"},
            }
      end

      if CoD.BO4GetMap() == "Voyage" then
            Objectives_Table = {
                  [0] = {Title = "", Desc = ""},

                  -- POWER
                  [1] = {Title = "Power", Desc = "Turn on the Power by interacting with the marked The Sentinel Artifact."},

                  -- PAP
                  [2] = {Title = "Pack-a-Punch", Desc = "Interact with the four marked PAPs. (%d/4)"},

                  -- SHIELD PARTS
                  [3] = {Title = "Shield", Desc = "Locate and collect all the marked shield parts to build the shield. (%d/3)"},

                  -- WONDER WEAPON
                  [4] = {Title = "Wonder Weapon", Desc = "Kill the marked Stoker with a normal weapon to get his key."},
                  [5] = {Title = "Wonder Weapon", Desc = "Locate the marked Box, and use the key on it."},
                  [6] = {Title = "Wonder Weapon", Desc = "Charge the first marked Box with Zombie Souls. (%d/10)"},
                  [7] = {Title = "Wonder Weapon", Desc = "Charge the second marked Box with Zombie Souls. (%d/20)"},
                  [8] = {Title = "Wonder Weapon", Desc = "Charge the final marked Box with Zombie Souls. (%d/30)"},

                  [9] = {Title = "Wonder Weapon", Desc = "Go to the marked location to get the Wonder Weapon."},

                  -- KIT PARTS
                  [10] = {Title = "Upgrade Station", Desc = "Locate and collect all the marked Parts to build the Wonder Weapon's Upgrade Station. (%d/3)"},
                  
                  -- MAIN QUEST
                  -- CLOCKS
                  [11] = {Title = "The Clocks", Desc = "Locate all the marked Turnable Dials and interact with them to set the correct time. (%d/8)"},

                  -- OUTLETS
                  [12] = {Title = "The Outlets", Desc = "Locate the marked outlet and kill the zombie catalyst corresponding to the outlet."},
                  [13] = {Title = "The Outlets", Desc = "Hold interact to enter the marked Portal."},
                  [14] = {Title = "Lockdown", Desc = "Survive the lockdown against the zombies."},
                  [15] = {Title = "Lockdown", Desc = "Pick up the marked Sentinel Artifact."},
                  
                  -- PIPES
                  [16] = {Title = "Pipes", Desc = "Shoot with the marked pipes with the Poison Kraken. (%d/9)"},
                  [17] = {Title = "Pipes", Desc = "Kill a Poison Zombie with the Wonder Weapon to get the Poison Kraken."},
                  [18] = {Title = "Pipes", Desc = "Use the Upgrade Station to get the Poison Kraken."},
                  [19] = {Title = "Sentinel Artifact", Desc = "Wait for Pack-a-Punch to move to the Engine Room."},
                  [20] = {Title = "Sentinel Artifact", Desc = "Upgrade the Sentinel Artifact using the marked Pack-a-Punch."},
                  
                  -- PLANETS
                  [21] = {Title = "The Planets", Desc = "Interact with each of the marked Planets Symbols. (%d/9)"},
                  [22] = {Title = "The Planets", Desc = "Interact with marked Valve to drain the water in Cargo Hold."},
                  [23] = {Title = "The Planets", Desc = "Interact with the marked Solar System Model in Cargo Hold."},
                  [24] = {Title = "The Planets", Desc = "Shoot the Planets in the order that Solar System Model indicates (or marked planets in-order). (%d/9)"},
                  [25] = {Title = "The Orb", Desc = "Get the marked orb that the Planet dropped. (%d/9)"},
                  
                  [26] = {Title = "The Planets", Desc = "You failed the Planets Challenge, wait for the next round to try again."},
                  
                  -- ICEBERG
                  [31] = {Title = "Ice Blocks Challenge", Desc = "Interact with the Orb again to start The Ice Blocks Challenge."},
                  [27] = {Title = "Ice Blocks Challenge", Desc = "Choose a Path and Destroy Ice Blocks with Powerful Weapons on your way to the Marked Poop Deck. (Time Remaining: %d seconds)"},
                  [28] = {Title = "Ice Blocks Challenge Failed", Desc = "You failed the Ice Blocks Challenge, wait for the next round to try again."},

                  -- BOSS INTRO
                  [29] = {Title = "Forget What You Know", Desc = "Get ready for the final boss fight, when you are, Go to the Marked Portal and Interact with it."},
                  [30] = {Title = "Forget What You Know", Desc = "Interact with the Marked Tree."},
                  [31] = {Title = "Forget What You Know", Desc = "..."},

                  -- BOSS FIGHT
                  [32] = {Title = "Eye of Malice and Despair", Desc = "Defeat The Eye of Malice and Despair."},

                  -- NOTIFY
                  [999] = {Title = "Directed Mode Completed!", Desc = "Congratulations on completing Directed Mode!"},
            }
      end

      if CoD.BO4GetMap() == "Blood" then
            Objectives_Table = {
                  [0] = {Title = "", Desc = ""},

                  -- POWER/DOORS
                  [1] = {Title = "Power", Desc = "Turn on the first Power by interacting with the marked The Power Switch."},
                  [2] = {Title = "Catwalk", Desc = "Interact with the marked Gate to get to the second Power Switch."},
                  [3] = {Title = "Catwalk", Desc = "Survive the Catwalk."},
                  [4] = {Title = "Power", Desc = "Turn on the second Power by interacting with the marked The Power Switch."},

                  -- SHIELD PARTS
                  [5] = {Title = "Shield", Desc = "Locate the marked Brutus and kill him to get the Key."},
                  [6] = {Title = "Shield", Desc = "Locate and collect all the marked shield parts to build the shield. (%d/3)"},
                  [7] = {Title = "Shield", Desc = "Build the Shield in any of the three marked crafting tables."},

                  -- PAP
                  [8] = {Title = "Pack-a-Punch", Desc = "Drain enough souls with your Shield and blast the marked Voltage Meater."},

                  -- HELL RETRIEVER
                  [9] = {Title = "Hell Retriever", Desc = "Feed the three marked Dogs with Zombies."},
                  [10] = {Title = "Hell Retriever", Desc = "Pick up the marked Hell Retriever using the Fast Travel."},

                  -- SPOON
                  [11] = {Title = "Spoon", Desc = "Locate the three marked numbers on the wall and use your Shield to see them, then input them on the marked Panel."},
                  [12] = {Title = "Spoon", Desc = "Drain enough souls with your Shield and blast the marked Voltage Meater."},
                  [13] = {Title = "Spoon", Desc = "Throw the Hell Retriever at the marked target."},
                  [14] = {Title = "Spoon", Desc = "Pick up the marked Spoon."},

                  -- WONDER WEAPON
                  [15] = {Title = "Wonder Weapon", Desc = "Collect the marked Skulls with your Hell Retriever. (%d/5)"},
                  [16] = {Title = "Wonder Weapon", Desc = "Go in the Warden's Office to get the Wonder Weapon."},
                  [17] = {Title = "Wonder Weapon Upgrade", Desc = "Place your Blundergat in the marked location."},
                  [18] = {Title = "Wonder Weapon Upgrade", Desc = "Kill zombies and collect their orbs. (%d/15)"},
                  [19] = {Title = "Wonder Weapon Upgrade", Desc = "Pick up the marked Blundergat."},
                  [20] = {Title = "Wonder Weapon Upgrade", Desc = "Run back to New Industries while keeping your Blundergat on the blue fire and interacting with the marked Barrels. (%d remaining)"},
                  [21] = {Title = "Wonder Weapon Upgrade", Desc = "Pick up the Magmagat."},
                  [32] = {Title = "Wonder Weapon Upgrade", Desc = "Your Blundergat ran out of blue fire!"},
                        
                  -- MAIN QUEST
                  -- WALL STEP
                  [22] = {Title = "Secret Room", Desc = "Knife the marked Wall with your Spoon."},
                  [23] = {Title = "Secret Room", Desc = "Make Brutus do the Slam Attack near the marked Damaged Wall."},
                  [24] = {Title = "Secret Room", Desc = "Pick up the marked Orb and interact with the marked Power Switch."},
                  
                  -- BIRD
                  [25] = {Title = "Kronorium", Desc = "Place the orb in the marked Map."},
                  [26] = {Title = "Kronorium", Desc = "Interact with the Kronorium Book."},

                  [27] = {Title = "The Bird", Desc = "Find the Bird in the marked area and use your Shield to see him and blast him. (%d/3)"},
                  [28] = {Title = "The Bird", Desc = "Get the dropped Zombie Blood Power-up, and use it to see the bird, then use the Hell Retriever to get the Kronorium Book."},
                  [29] = {Title = "The Bird", Desc = "End the current round."},   
                  [30] = {Title = "The Bird", Desc = "Pick up the marked Kronorium Book."},
                  [31] = {Title = "The Bird", Desc = "You blasted/looked at the bird for too long, wait for current round to end."},
                  [33] = {Title = "The Bird", Desc = "Place the book at the marked location."},

                  -- CHALLENGES
                  -- STARTING
                  [34] = {Title = "The Challenges", Desc = "Start a challenge by interacting with the marked Book."},
                  [35] = {Title = "The Challenges", Desc = "Use the Shield to see the given code, and input it on the marked Panel."},
                  [36] = {Title = "The Challenge", Desc = "Blast the marked Orb using your Shield to start the Challenge."},
                  [37] = {Title = "The Challenge", Desc = "You took too long to blast the marked Orb, wait for a new round to start over."},
                  [41] = {Title = "The Challenge", Desc = "You failed the Challenge, wait for a new round to start again."},
                  [42] = {Title = "The Challenge", Desc = "Pick up the marked Red Orb."},

                  -- NEW INDUSTRIES CHALLENGE
                  [38] = {Title = "New Industries Challenge", Desc = "Kill a zombie near the marked Area."},
                  [39] = {Title = "New Industries Challenge", Desc = "Blast the marked Ghost for him to show up, then keep draining him with your Shield. (%d/%d)"},
                  [40] = {Title = "New Industries Challenge", Desc = "Kill the Ghost using the Marked New Industries Trap."},

                  -- SHOWERS CHALLENGE
                  [43] = {Title = "Showers Challenge", Desc = "Interact with the Ghost."},
                  [44] = {Title = "Showers Challenge", Desc = "Go inside the marked blue circle and kill zombies while being inside it. (%d/%d)"},

                  -- CELLBLOCK CHALLENGE
                  [45] = {Title = "Cellblock Challenge", Desc = "Kill a zombie near the marked Area."},
                  [46] = {Title = "Cellblock Challenge", Desc = "Blast the hidden Ghost with your Shield."},
                  [47] = {Title = "Cellblock Challenge", Desc = "Protect the marked Ghost from the Zombies. (%d health remaining)"},

                  -- DOCKS CHALLENGE
                  [48] = {Title = "Docks Challenge", Desc = "Input the given code in the marked Panel. (dash is hold, dot is tap!)"},
                  [49] = {Title = "Docks Challenge", Desc = "Kill a zombie near the marked Area."},   
                  [50] = {Title = "Docks Challenge", Desc = "Blast the hidden Ghost with your Shield and interact with him."},  
                  [51] = {Title = "Docks Challenge", Desc = "Charge the marked Ghost with Zombie kills near him, take him to the marked Docks area. (%d remaining)"},   

                  -- POWER CHALLENGE
                  [52] = {Title = "Power Plant Challenge", Desc = "Interact with the marked Generator to start The Simon Says Challenge."},
                  [53] = {Title = "Power Plant Challenge", Desc = "Interact with each marked Panels in-order."},
                  [54] = {Title = "Power Plant Challenge", Desc = "Pick up the marked Punch Card."},
                  [55] = {Title = "Power Plant Challenge", Desc = "Place the Punch Card in the marked Slot."},
                  [56] = {Title = "Power Plant Challenge", Desc = "Blast the Ghost when he is about to approach the marked Switches."},

                  -- PRE-BOSS
                  [57] = {Title = "The Summoning Key", Desc = "Interact to place all the collected orbs in the marked Map."},
                  [58] = {Title = "The Summoning Key", Desc = "Place the Summoning Key in the marked Skull Body."},

                  -- PRE-BRUTUS
                  [59] = {Title = "Locked out", Desc = "Survive..."},
                  [60] = {Title = "Locked out", Desc = "Interact with the marked Bag to retrieve your weapons."},
                  [61] = {Title = "Locked out", Desc = "Follow the Bird and Survive."},
                  [62] = {Title = "Locked out", Desc = "Pick up the marked Orb."},
                  [63] = {Title = "Locked out", Desc = "Place the last Orb in the marked Map."},
                  
                  -- BOSS FIGHT
                  [64] = {Title = "Final Showdown", Desc = "Get ready for the final boss fight, when you are, hold interact with the Marked Door."},
                  [65] = {Title = "Final Showdown", Desc = "Defeat Brutus."},

                  -- NOTIFY
                  [999] = {Title = "Directed Mode Completed!", Desc = "Congratulations on completing Directed Mode!"},
            }
      end

      local ObjectiveBackground = LUI.UIImage.new(0.00, 0.00, -10.00, 400.00, 0.00, 0.00, -100.00, 20.00)
      ObjectiveBackground:setRGB(1, 1, 1)
      ObjectiveBackground:setAlpha(0)
      ObjectiveBackground:setImage(RegisterImage(@"score_bg"))
      self:addElement(ObjectiveBackground)
      self.ObjectiveBackground = ObjectiveBackground

      local ObjectiveIcon = LUI.UIImage.new(0.00, 0.00, -10.00, 45.00, 0.00, 0.00, -100.00, -50.00)
      ObjectiveIcon:setRGB(1, 1, 1)
      ObjectiveIcon:setAlpha(0)
      ObjectiveIcon:setImage(RegisterImage(@"directed_image"))
      self:addElement(ObjectiveIcon)
      self.ObjectiveIcon = ObjectiveIcon

      local ObjectiveText = LUI.UIText.new( 0.00, 0.00, 48.00, 378.00, 0.00, 0.00, -90.00, -60.00 )
      ObjectiveText:setRGB( 1, 0.35, 0.35 )
      ObjectiveText:setTTF( "skorzhen" )
      ObjectiveText:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	ObjectiveText:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
      self:addElement( ObjectiveText )
      self.ObjectiveText = ObjectiveText

      local ObjectiveText_Desc = LUI.UIText.new( 0.00, 0.00, 3.00, 380.00, 0.00, 0.00, -45.00, -25.00 )
      ObjectiveText_Desc:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	ObjectiveText_Desc:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
      ObjectiveText_Desc:setRGB( 1, 0.75, 0.35 )
      ObjectiveText_Desc:setTTF( "skorzhen" )
      self:addElement( ObjectiveText_Desc )
      self.ObjectiveText_Desc = ObjectiveText_Desc

      self.IsShowingDirectedObjective = false
      self:subscribeToGlobalModel(controller, "PerController", "scriptNotify", function ( model )
            if CoD.ModelUtility.IsParamModelEqualToHashString( model, @"enhancement_directed_objective" ) then
                  local scriptData = CoD.GetScriptNotifyData(model)
                  local ObjectiveID = scriptData[1]

                  if ObjectiveID == 1000 then
                        if CoD.ZmNotifBGBContainerFactory ~= nil then
                              CoD.ZmNotifBGBContainerFactory:appendNotification( {
                                    clip = "TextandImageBGB",
                                    title = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/directed_mode_ingame" ),
                                    description = Engine[@"hash_4F9F1239CFD921FE"]( @"shield/directed_mode_desc_ingame" ),
                                    bgbImage = RegisterImage(@"directed_image")
                              } )
                        end

                        self.ObjectiveText:setAlpha(1)
                        self.ObjectiveBackground:setAlpha(1)
                        self.ObjectiveIcon:setAlpha(1)
                        self.ObjectiveText_Desc:setAlpha(1)
                        self.ObjectiveText:setText("Directed Mode")
                        self.ObjectiveText_Desc:setText("Complete the objectives shown on the screen to progress through the main quest.")
                        self.IsShowingDirectedObjective = true
                        return
                  end

                  if ObjectiveID == 1001 then
                        self.ObjectiveText:setAlpha(0)
                        self.ObjectiveBackground:setAlpha(0)
                        self.ObjectiveIcon:setAlpha(0)
                        self.ObjectiveText_Desc:setAlpha(0)
                        self.IsShowingDirectedObjective = false
                        return
                  end

                  local titleText = Objectives_Table[ObjectiveID].Title or ""
                  local descText = Objectives_Table[ObjectiveID].Desc or ""
                  
                  -- Replace %d with scriptData[2] if it exists
                  if string.find(descText, "%%d") then
                        descText = string.format(descText, scriptData[2] or 0, scriptData[3] or 0)
                        --CoD.EnhModPrintInfo("Updated Directed Objective Description: " .. (scriptData[2] or 0))
                  end

                  self.ObjectiveText:setText(titleText)
                  self.ObjectiveText_Desc:setText(descText)
            end
      end)

      -------------------------------------

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

CoD.DirectedModeObjective.__resetProperties = function ( f16_arg0 )

      if f16_arg0.IsShowingDirectedObjective == false then
            f16_arg0.ObjectiveText:setAlpha(0)
            f16_arg0.ObjectiveText_Desc:setAlpha(0)
            f16_arg0.ObjectiveBackground:setAlpha(0)
            f16_arg0.ObjectiveIcon:setAlpha(0)
      else
            f16_arg0.ObjectiveText:setAlpha(1)
            f16_arg0.ObjectiveText_Desc:setAlpha(1)
            f16_arg0.ObjectiveBackground:setAlpha(1)
            f16_arg0.ObjectiveIcon:setAlpha(1)
      end
end

CoD.DirectedModeObjective.__clipsPerState = {

	DefaultState = {
		DefaultClip = function ( f17_arg0, f17_arg1 )
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter( 0 )
		end,

            Hidden = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			
                  f18_arg0.ObjectiveText:setAlpha(0)
                  f18_arg0.ObjectiveText_Desc:setAlpha(0)
                  f18_arg0.ObjectiveBackground:setAlpha(0)
                  f18_arg0.ObjectiveIcon:setAlpha(0)
		end
	},

	Hidden = {
		DefaultClip = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			
                  f18_arg0.ObjectiveText:setAlpha(0)
                  f18_arg0.ObjectiveText_Desc:setAlpha(0)
                  f18_arg0.ObjectiveBackground:setAlpha(0)
                  f18_arg0.ObjectiveIcon:setAlpha(0)
		end
	}

}

CoD.DirectedModeObjective.__onClose = function ( f19_arg0 )
	f19_arg0.ObjectiveBackground:close()
      f19_arg0.ObjectiveIcon:close()
      f19_arg0.ObjectiveText:close()
      f19_arg0.ObjectiveText_Desc:close()
end