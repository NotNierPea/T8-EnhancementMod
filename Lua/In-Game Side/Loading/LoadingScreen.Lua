--[[
      .\hksc.exe '.\Scripts\LoadingScreen.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\LoadingScreen.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

-- animated loading
CoD.AnimatedLoadingEnh = InheritFrom( LUI.UIElement )
CoD.AnimatedLoadingEnh.__defaultWidth = 1920
CoD.AnimatedLoadingEnh.__defaultHeight = 1080
CoD.AnimatedLoadingEnh.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.AnimatedLoadingEnh )
	self.id = "AnimatedLoadingEnh"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true

	-------------------------

	local LoadingText = LUI.UIText.new(0, 0, -200, 300, 0, 0, -100, 50)
      --LoadingText:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_90D57B1E92D39D7" ) )
      LoadingText:setShaderVector( 0, 0.5, 0, 0, 0 )
	LoadingText:setShaderVector( 1, 0, 0, 0, 0 )
	LoadingText:setShaderVector( 2, 0, 0, 0, 1 )
	LoadingText:setLetterSpacing( 3 )
      LoadingText:setTTF( "shield_mom" )
      LoadingText:setText("Loading...")
      LoadingText:setRGB(0, 1, 1)
      self:addElement( LoadingText )
      self.LoadingText = LoadingText

      -- animation
      local isFadingOut = true
      local dotState = 0
      local maxDots = 3

      self:addElement(LUI.UITimer.newElementTimer(800, false, function()
            if isFadingOut == true then
                  LoadingText:beginAnimation("fadeout", 700)
                  LoadingText:setAlpha(0)
            else
                  LoadingText:beginAnimation("fadein", 700)
                  LoadingText:setAlpha(1)
            end

            isFadingOut = not isFadingOut

            -- Animate the dots
            dotState = (dotState + 1) % (maxDots + 1)  -- 0 to 3
            local dots = string.rep(".", dotState)
            LoadingText:setText("Loading" .. dots)

            --CoD.EnhModPrintInfo("played anim for loading text")
      end))

	-------------------------

	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end

	return self
end

CoD.AnimatedLoadingEnh.__onClose = function ( f9_arg0 )
	--f9_arg0.LANServerBrowserDetails:close()
	f9_arg0.LoadingText:close()
end

CoD.AnimationLoadingEnh = InheritFrom( LUI.UIElement )
CoD.AnimationLoadingEnh.__defaultWidth = 1920
CoD.AnimationLoadingEnh.__defaultHeight = 1080
CoD.AnimationLoadingEnh.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.AnimationLoadingEnh )
	self.id = "AnimationLoadingEnh"
	self.soundSet = "ChooseDecal"
	
      local screenW, screenH = 1920, 1080
	local iconSize = 108
	local numIcons = 2 -- logos

	self.bouncingImages = {}

	local function createBouncingImage(index)
		local image = LUI.UIImage.new(0, 0, 0, iconSize, 0, 0, 0, iconSize)
		image:setImage(RegisterImage(@"loading_enh"))
		image:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook"))
		image:setShaderVector(0, 28, 0, 0, 0)
		image:setShaderVector(1, 22, 0, 0, 0)

		self:addElement(image)

		-- position and velocity
		local x = math.random(0, screenW - iconSize)
		local y = math.random(0, screenH - iconSize)
		local vx = math.random(4, 6)
		local vy = math.random(4, 6)

		table.insert(self.bouncingImages, {
			element = image,
			x = x,
			y = y,
			vx = vx,
			vy = vy
		})
	end

	-- all icons
	for i = 1, numIcons do
		createBouncingImage(i)
	end

	-- update all images
	self:addElement(LUI.UITimer.newElementTimer(16, false, function()
		for _, img in ipairs(self.bouncingImages) do
			img.x = img.x + img.vx
			img.y = img.y + img.vy

			-- Bounce X
			if img.x <= 0 or img.x >= (screenW - iconSize) then
				img.vx = -img.vx
				img.x = math.max(0, math.min(img.x, screenW - iconSize))
			end

			-- Bounce Y
			if img.y <= 0 or img.y >= (screenH - iconSize) then
				img.vy = -img.vy
				img.y = math.max(0, math.min(img.y, screenH - iconSize))
			end

			img.element:setLeftRight(0, 0, img.x, img.x + iconSize)
			img.element:setTopBottom(0, 0, img.y, img.y + iconSize)

			local angle = math.deg(math.atan2(img.vy, img.vx))
			img.element:setZRot(angle)
		end
	end))
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.AnimationLoadingEnh.__onClose = function ( f9_arg0 )
	for _, img in ipairs(f9_arg0.bouncingImages) do
		img.element:close()
	end
end

-- black screen, post one
if Engine[@"getdvarint"]("shield_enh_LoadingCustomScreen") == 1 then
      CoD.initial_black = InheritFrom( CoD.Menu )
      LUI.createMenu.initial_black = function ( f1_arg0, f1_arg1 )
            local self = CoD.Menu.NewForUIEditor( "initial_black", f1_arg0 )
            local f1_local1 = self
            SetProperty( self, "disableBlur", true )
            SetProperty( self, "disableInputLock", true )
            self:setClass( CoD.initial_black )
            self.soundSet = "none"
            self:setOwner( f1_arg0 )
            self:setLeftRight( 0, 1, 0, 0 )
            self:setTopBottom( 0, 1, 0, 0 )
            self:playSound( "menu_open", f1_arg0 )
            self.ignoreCursor = true
            self.anyChildUsesUpdateState = true
            f1_local1:addElementToPendingUpdateStateList( self )
            
            local Fullscreen = LUI.UIImage.new( 0, 1, 0, 0, 0, 1, 0, 0 )
            Fullscreen:setImage( RegisterImage( @"uie_default_black_0" ) )
            self:addElement( Fullscreen )
            self.Fullscreen = Fullscreen

            -- in a cod is better, so it doesnt mis align with settext
            local LoadingText = CoD.AnimatedLoadingEnh.new( f1_local1, f1_arg0, 0.5, 0.5, 0, 0, 0.5, 0.5, 0, 0 )
            LoadingText:setScale( 0.5, 0.5 )
            self:addElement( LoadingText )
            self.LoadingText = LoadingText
            
            local AnimationLoading20 = CoD.AnimationLoadingEnh.new( f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0 )
            --AnimationLoading20:setScale( 0.5, 0.5 )
            self:addElement( AnimationLoading20 )
            self.AnimationLoading20 = AnimationLoading20

            local Team1PlayerList = LUI.UIList.new( f1_local1, f1_arg0, 8, 0, nil, false, false, false, false )
            Team1PlayerList:setLeftRight( 0.5, 0.5, -864, -534 )
            Team1PlayerList:setTopBottom( 0, 0, 54, 186 )
            Team1PlayerList:setWidgetType( CoD.LoadingScreenTalkerWidgetCPZM )
            Team1PlayerList:setVerticalCount( 4 )
            Team1PlayerList:setSpacing( 8 )
            Team1PlayerList:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
            Team1PlayerList:setDataSource( "LoadingScreenPlayerListTeam1" )
            self:addElement( Team1PlayerList )
            self.Team1PlayerList = Team1PlayerList
            
            Team1PlayerList.id = "Team1PlayerList"
            self:processEvent( {
                  name = "menu_loaded",
                  controller = f1_arg0
            } )
            LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
            
            if PostLoadFunc then
                  PostLoadFunc( self, f1_arg0 )
            end

            CoD.EnhModPrintInfo("Black Screen Post Init")
            
            return self
      end

      CoD.initial_black.__resetProperties = function ( f2_arg0 )
            f2_arg0.AnimationLoading20:completeAnimation()
            f2_arg0.Fullscreen:completeAnimation()
            f2_arg0.Team1PlayerList:completeAnimation()
            f2_arg0.AnimationLoading20:setAlpha( 1 )
            --f2_arg0.AnimationLoading20:setScale( 0.5, 0.5 )
            f2_arg0.Fullscreen:setAlpha( 1 )
            f2_arg0.Team1PlayerList:setAlpha( 1 )
      end

      CoD.initial_black.__clipsPerState = {
            DefaultState = {
                  DefaultClip = function ( f3_arg0, f3_arg1 )
                        f3_arg0:__resetProperties()
                        f3_arg0:setupElementClipCounter( 3 )
                        local f3_local0 = function ( f4_arg0 )
                              local f4_local0 = function ( f5_arg0 )
                                    f5_arg0:beginAnimation( 1010 )
                                    f5_arg0:setAlpha( 0 )
                                    f5_arg0:registerEventHandler( "transition_complete_keyframe", f3_arg0.clipFinished )
                              end
                              
                              f3_arg0.Fullscreen:beginAnimation( 29000 )
                              f3_arg0.Fullscreen:registerEventHandler( "interrupted_keyframe", f3_arg0.clipInterrupted )
                              f3_arg0.Fullscreen:registerEventHandler( "transition_complete_keyframe", f4_local0 )
                        end
                        
                        f3_arg0.Fullscreen:completeAnimation()
                        f3_arg0.Fullscreen:setAlpha( 1 )
                        f3_local0( f3_arg0.Fullscreen )
                        local f3_local1 = function ( f6_arg0 )
                              local f6_local0 = function ( f7_arg0 )
                                    local f7_local0 = function ( f8_arg0 )
                                          f8_arg0:beginAnimation( 1010 )
                                          f8_arg0:setAlpha( 0 )
                                          f8_arg0:registerEventHandler( "transition_complete_keyframe", f3_arg0.clipFinished )
                                    end
                                    
                                    f7_arg0:beginAnimation( 18490 )
                                    f7_arg0:setScale( 0.5, 0.5 )
                                    f7_arg0:registerEventHandler( "transition_complete_keyframe", f7_local0 )
                              end
                              
                              f3_arg0.AnimationLoading20:beginAnimation( 10510 )
                              f3_arg0.AnimationLoading20:setAlpha( 1 )
                              --f3_arg0.AnimationLoading20:setScale( 0.6, 0.6 )
                              f3_arg0.AnimationLoading20:registerEventHandler( "interrupted_keyframe", f3_arg0.clipInterrupted )
                              f3_arg0.AnimationLoading20:registerEventHandler( "transition_complete_keyframe", f6_local0 )
                        end
                        
                        f3_arg0.AnimationLoading20:completeAnimation()
                        f3_arg0.AnimationLoading20:setAlpha( 0 )
                        --f3_arg0.AnimationLoading20:setScale( 0.5, 0.5 )
                        f3_local1( f3_arg0.AnimationLoading20 )
                        local f3_local2 = function ( f9_arg0 )
                              local f9_local0 = function ( f10_arg0 )
                                    f10_arg0:beginAnimation( 1010 )
                                    f10_arg0:setAlpha( 0 )
                                    f10_arg0:registerEventHandler( "transition_complete_keyframe", f3_arg0.clipFinished )
                              end
                              
                              f3_arg0.Team1PlayerList:beginAnimation( 29000 )
                              f3_arg0.Team1PlayerList:registerEventHandler( "interrupted_keyframe", f3_arg0.clipInterrupted )
                              f3_arg0.Team1PlayerList:registerEventHandler( "transition_complete_keyframe", f9_local0 )
                        end
                        
                        f3_arg0.Team1PlayerList:completeAnimation()
                        f3_arg0.Team1PlayerList:setAlpha( 1 )
                        f3_local2( f3_arg0.Team1PlayerList )
                  end
            }
      }

      CoD.initial_black.__onClose = function ( f11_arg0 )
            f11_arg0.AnimationLoading20:close()
            f11_arg0.Fullscreen:close()
            f11_arg0.Team1PlayerList:close()
            f11_arg0.LoadingText:close()
      end
end