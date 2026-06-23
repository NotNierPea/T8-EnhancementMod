--[[
      .\hksc.exe '.\Scripts\WeaponSelectionStyle.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\WeaponSelectionStyle.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

-- for start menu's
CoD.Shield_WeaponIndexStyleMain = InheritFrom( LUI.UIElement )
CoD.Shield_WeaponIndexStyleMain.__defaultWidth = 240
CoD.Shield_WeaponIndexStyleMain.__defaultHeight = 63
CoD.Shield_WeaponIndexStyleMain.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.Shield_WeaponIndexStyleMain )
	self.id = "Shield_WeaponIndexStyleMain"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local NoiseTiledBacking = CoD.Shield_WeaponsStyle.new( f1_arg0, f1_arg1, 0.50, 0.50, -110.00, 110.00, 0.50, 0.50, -80.00, 50.00 )
	NoiseTiledBacking:mergeStateConditions( {
		{
			stateName = "Locked",
			condition = function ( menu, element, event )
				return CoD.BaseUtility.IsSelfInState( self, "Locked" )
			end
		},
		{
			stateName = "Classified",
			condition = function ( menu, element, event )
				return CoD.BaseUtility.IsSelfInState( self, "Classified" )
			end
		},
		{
			stateName = "ClassifiedShowProgress",
			condition = function ( menu, element, event )
				return CoD.BaseUtility.IsSelfInState( self, "ClassifiedShowProgress" )
			end
		}
	} )
	NoiseTiledBacking:linkToElementModel( self, nil, false, function ( model )
		NoiseTiledBacking:setModel( model, f1_arg1 )
	end )
	NoiseTiledBacking:linkToElementModel( self, "title", true, function ( model )
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			NoiseTiledBacking.Label:setText( f6_local0 )
		end
	end )

    NoiseTiledBacking.FocusGlow:setAlpha(0)
    NoiseTiledBacking.FocusGlow:setRGB(0, 0, 0)

    NoiseTiledBacking.Label:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
	NoiseTiledBacking.Label:setAlignment( Enum[@"luialignment"][@"lui_alignment_middle"] )

    NoiseTiledBacking.Label:setLeftRight(0.00, 0.00, 37.50, 178.50)
    NoiseTiledBacking.Label:setTopBottom(0.00, 0.00, 86.25, 106.25)

	-- get the site for click datasource
	NoiseTiledBacking:linkToElementModel( self, "link", true, function ( model )
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			self.site = f6_local0
		end
	end )

	self:addElement( NoiseTiledBacking )
	self.NoiseTiledBacking = NoiseTiledBacking
	
	self:mergeStateConditions( {
		{
			stateName = "Locked",
			condition = function ( menu, element, event )
				return CoD.ModelUtility.IsSelfModelValueTrue( element, f1_arg1, "isLocked" )
			end
		},
		{
			stateName = "Classified",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "ClassifiedShowProgress",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		}
	} )
	self:linkToElementModel( self, "isLocked", true, function ( model )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLocked"
		} )
	end )
	LUI.OverrideFunction_CallOriginalFirst( self, "setState", function ( element, controller, f11_arg2, f11_arg3, f11_arg4 )
		UpdateElementState( self, "NoiseTiledBacking", controller )
	end )
	NoiseTiledBacking.id = "NoiseTiledBacking"
	self.__defaultFocus = NoiseTiledBacking
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.Shield_WeaponIndexStyleMain.__resetProperties = function ( f12_arg0 )
	f12_arg0.NoiseTiledBacking:completeAnimation()
	f12_arg0.NoiseTiledBacking:setScale( 1, 1 )
end

CoD.Shield_WeaponIndexStyleMain.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f13_arg0, f13_arg1 )
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter( 0 )
		end,
		ChildFocus = function ( f14_arg0, f14_arg1 )
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter( 1 )
			f14_arg0.NoiseTiledBacking:completeAnimation()
			f14_arg0.NoiseTiledBacking:setScale( 1.05, 1.05 )
			f14_arg0.clipFinished( f14_arg0.NoiseTiledBacking )
		end,
		GainChildFocus = function ( f15_arg0, f15_arg1 )
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter( 1 )
			local f15_local0 = function ( f16_arg0 )
				f15_arg0.NoiseTiledBacking:beginAnimation( 200 )
				f15_arg0.NoiseTiledBacking:setScale( 1.05, 1.05 )
				f15_arg0.NoiseTiledBacking:registerEventHandler( "interrupted_keyframe", f15_arg0.clipInterrupted )
				f15_arg0.NoiseTiledBacking:registerEventHandler( "transition_complete_keyframe", f15_arg0.clipFinished )
			end
			
			f15_arg0.NoiseTiledBacking:completeAnimation()
			f15_arg0.NoiseTiledBacking:setScale( 1, 1 )
			f15_local0( f15_arg0.NoiseTiledBacking )
		end,
		LoseChildFocus = function ( f17_arg0, f17_arg1 )
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter( 1 )
			local f17_local0 = function ( f18_arg0 )
				f17_arg0.NoiseTiledBacking:beginAnimation( 200 )
				f17_arg0.NoiseTiledBacking:setScale( 1, 1 )
				f17_arg0.NoiseTiledBacking:registerEventHandler( "interrupted_keyframe", f17_arg0.clipInterrupted )
				f17_arg0.NoiseTiledBacking:registerEventHandler( "transition_complete_keyframe", f17_arg0.clipFinished )
			end
			
			f17_arg0.NoiseTiledBacking:completeAnimation()
			f17_arg0.NoiseTiledBacking:setScale( 1.05, 1.05 )
			f17_local0( f17_arg0.NoiseTiledBacking )
		end
	},
	Locked = {
		DefaultClip = function ( f19_arg0, f19_arg1 )
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter( 0 )
		end
	},
	Classified = {
		DefaultClip = function ( f20_arg0, f20_arg1 )
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter( 0 )
		end
	},
	ClassifiedShowProgress = {
		DefaultClip = function ( f21_arg0, f21_arg1 )
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter( 0 )
		end
	}
}

CoD.Shield_WeaponIndexStyleMain.__onClose = function ( f22_arg0 )
	f22_arg0.NoiseTiledBacking:close()
end

-- start menu's and box patch too
CoD.SpecialWeaponSelection_Enh_Container = InheritFrom( LUI.UIElement )
CoD.SpecialWeaponSelection_Enh_Container.__defaultWidth = 850
CoD.SpecialWeaponSelection_Enh_Container.__defaultHeight = 95
CoD.SpecialWeaponSelection_Enh_Container.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.SpecialWeaponSelection_Enh_Container )
	self.id = "SpecialWeaponSelection_Enh_Container"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local BG = LUI.UIImage.new( 0, 1, 0, 0, 0, 1, 0, 0 )
	BG:setRGB( 0.09, 0.09, 0.09 )
	self:addElement( BG )
	self.BG = BG
	
	local Tick = LUI.UIImage.new( 0, 0, -6, 0, 0, 1, 0, 0 )
	Tick:setRGB( 0.96, 0.94, 0.78 )
	Tick:setAlpha( 0 )
	Tick:setMaterial( LUI.UIImage.GetCachedMaterial( @"ui_add" ) )
	self:addElement( Tick )
	self.Tick = Tick
	
	local FocusGlow = LUI.UIImage.new( -0.01, 1.01, -134, 134, 0.99, 0.01, -120, 120 )
	FocusGlow:setAlpha( 0 )
	FocusGlow:setImage( RegisterImage( @"uie_ui_menu_common_focus_glow_large" ) )
	FocusGlow:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_6DAB59B2CAE01851" ) )
	FocusGlow:setShaderVector( 0, 0, 0, 0.25, 0.25 )
	FocusGlow:setShaderVector( 1, 1.2, 0, 0, 0 )
	FocusGlow:setupNineSliceShader( 300, 500 )
	--self:addElement( FocusGlow )
	self.FocusGlow = FocusGlow
	
	local PointsInnerGlowBG = LUI.UIImage.new( 1, 1, -69, -11, 0, 1, 11, -11 )
	PointsInnerGlowBG:setAlpha( 0.01 )
	PointsInnerGlowBG:setImage( RegisterImage( @"uie_innerglow" ) )
	--self:addElement( PointsInnerGlowBG )
	self.PointsInnerGlowBG = PointsInnerGlowBG
	
	local PointsBorder = LUI.UIImage.new( 1, 1, -69, -11, 0, 1, 11, -11 )
	PointsBorder:setRGB( 0.38, 0.38, 0.38 )
	PointsBorder:setAlpha( 0.25 )
	PointsBorder:setImage( RegisterImage( @"uie_highlight_border_line" ) )
	PointsBorder:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_nineslice_normal" ) )
	PointsBorder:setShaderVector( 0, 0, 0, 0, 0 )
	PointsBorder:setupNineSliceShader( 6, 6 )
	--self:addElement( PointsBorder )
	self.PointsBorder = PointsBorder
	
	local ProgressBarBGBlur = LUI.UIImage.new( 0, 1, 110, -80, 0, 1, 11, -11 )
	ProgressBarBGBlur:setRGB( 0.08, 0.08, 0.08 )
	ProgressBarBGBlur:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_E2354BE557C4C7A" ) )
	ProgressBarBGBlur:setShaderVector( 0, 0, 0, 0, 0 )
	--self:addElement( ProgressBarBGBlur )
	self.ProgressBarBGBlur = ProgressBarBGBlur
	
	local ProgressBarBacking = LUI.UIImage.new( 0, 1, 110, -80, 0, 1, 11, -11 )
	ProgressBarBacking:setRGB( 0.21, 0.21, 0.21 )
	ProgressBarBacking:setAlpha( 0.85 )
	--self:addElement( ProgressBarBacking )
	self.ProgressBarBacking = ProgressBarBacking
	
	local ProgressBarFiller = LUI.UIImage.new( 0, 1, 110, -80, 0, 1, 11, -11 )
	ProgressBarFiller:setRGB( 0.43, 0.41, 0.39 )
	ProgressBarFiller:setAlpha( 0.8 )
	ProgressBarFiller:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_wipe_normal" ) )
	ProgressBarFiller:setShaderVector( 1, 0, 0, 0, 0 )
	ProgressBarFiller:setShaderVector( 2, 1, 0, 0, 0 )
	ProgressBarFiller:setShaderVector( 3, 0, 0, 0, 0 )
	ProgressBarFiller:setShaderVector( 4, 1, 0.03, 1, 0 )
	--self:addElement( ProgressBarFiller )
	self.ProgressBarFiller = ProgressBarFiller
	
	local ProgressBarBorder = LUI.UIImage.new( 0, 1, 110, -80, 0, 1, 11, -11 )
	ProgressBarBorder:setRGB( 0.19, 0.19, 0.19 )
	ProgressBarBorder:setImage( RegisterImage( @"uie_highlight_border_line" ) )
	ProgressBarBorder:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_nineslice_normal" ) )
	ProgressBarBorder:setShaderVector( 0, 0, 0, 0, 0 )
	ProgressBarBorder:setupNineSliceShader( 6, 6 )
	--self:addElement( ProgressBarBorder )
	self.ProgressBarBorder = ProgressBarBorder
	
	local Texture = LUI.UIImage.new( 0, 1, 1, -1, 0, 1, 0, 0 )
	Texture:setAlpha( 0.75 )
	Texture:setImage( RegisterImage( @"uie_ui_menu_specialist_hub_repeat_bg" ) )
	Texture:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_16CBE95C250C6D15" ) )
	Texture:setShaderVector( 0, 0, 0, 0, 0 )
	Texture:setupNineSliceShader( 196, 88 )
	self:addElement( Texture )
	self.Texture = Texture
	
	local CompletedTick = CoD.PC_Achievement_CompletedTick.new( f1_arg0, f1_arg1, 1.00, 1.00, -22.00, 0.00, 0.00, 1.00, 0, -1 )
	CompletedTick:setAlpha( 0 )
	CompletedTick.BG:setRGB( 0.86, 0.74, 0.25 )
	CompletedTick.TabBackingGlow:setScale( 2, 7.5 )
	CompletedTick.TabBacking:setAlpha( 0.15 )
	self:addElement( CompletedTick )
	self.CompletedTick = CompletedTick
	
	local Border = LUI.UIImage.new( 0, 1, 0, 0, 0, 1, 0, 0 )
	Border:setRGB( 0.8, 0.76, 0.7 )
	Border:setAlpha( 0.06 )
	Border:setImage( RegisterImage( @"uie_highlight_border_line" ) )
	Border:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_nineslice_normal" ) )
	Border:setShaderVector( 0, 0, 0, 0, 0 )
	Border:setupNineSliceShader( 6, 6 )
	self:addElement( Border )
	self.Border = Border
	
	local Dots = LUI.UIImage.new( 0, 1, 0, 0, 0, 1, 0, 0 )
	Dots:setRGB( 0.92, 0.92, 0.92 )
	Dots:setAlpha( 0.3 )
	Dots:setImage( RegisterImage( @"uie_highlight_border_dot" ) )
	Dots:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_nineslice_normal" ) )
	Dots:setShaderVector( 0, 0, 0, 0, 0 )
	Dots:setupNineSliceShader( 6, 6 )
	self:addElement( Dots )
	self.Dots = Dots
	
	local AchievementIcon = LUI.UIFixedAspectRatioImage.new( 0, 0, 0, 110, 0.5, 0.5, -45, 45 )
	AchievementIcon:setRGB( 0.32, 0.32, 0.32 )
	AchievementIcon:setAlpha( 0.8 )
	AchievementIcon:setImage( RegisterImage( @"t7_icon_achievement_safehouse_01" ) )
	self:addElement( AchievementIcon )
	self.AchievementIcon = AchievementIcon
	
	local Lock = LUI.UIFixedAspectRatioImage.new( 0, 0, 40, 70, 0.5, 0.5, -15, 15 )
	Lock:setImage( RegisterImage( @"uie_icon_locks_lock_01" ) )
	--self:addElement( Lock )
	self.Lock = Lock
	
	local Name = LUI.UIText.new( 0, 0, 123, 623, 0.5, 0.5, -10.5, 10.5 )
	Name:setRGB( 0.7, 0.67, 0.62 )
	Name:setTTF( "ttmussels_demibold" )
	Name:setLetterSpacing( 2 )
	Name:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	Name:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
	LUI.OverrideFunction_CallOriginalFirst( Name, "setModel", function ( element, controller )
		CoD.PCAchievementsUtility.PrepareAchievementProgressBar( f1_arg1, controller, self )
	end )
	self:addElement( Name )
	self.Name = Name
	
	local ScoreValue = LUI.UIText.new( 1, 1, -80, 0, 0.5, 0.5, -16.5, 16.5 )
	ScoreValue:setRGB( 0.33, 0.33, 0.32 )
	ScoreValue:setTTF( "ttmussels_regular" )
	ScoreValue:setLetterSpacing( 3 )
	ScoreValue:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
	ScoreValue:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
	--self:addElement( ScoreValue )
	self.ScoreValue = ScoreValue
	
	local Add = LUI.UIImage.new( 0, 1, 0, 0, 0, 1, 0, 0 )
	Add:setRGB( 0.96, 0.94, 0.78 )
	Add:setAlpha( 0 )
	Add:setMaterial( LUI.UIImage.GetCachedMaterial( @"ui_add" ) )
	self:addElement( Add )
	self.Add = Add
	
	local FrameSelected = LUI.UIImage.new( 0, 1, -3, 3, 0, 1, -3, 3 )
	FrameSelected:setRGB( 0.96, 0.94, 0.78 )
	FrameSelected:setAlpha( 0 )
	FrameSelected:setImage( RegisterImage( @"uie_ui_menu_store_focus_frame" ) )
	FrameSelected:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_nineslice_add" ) )
	FrameSelected:setShaderVector( 0, 0, 0, 0, 0 )
	FrameSelected:setupNineSliceShader( 8, 8 )
	self:addElement( FrameSelected )
	self.FrameSelected = FrameSelected
	
	local FrameSelectedCorner = LUI.UIImage.new( 0, 1, -10, 10, 0, 1, -10, 10 )
	FrameSelectedCorner:setAlpha( 0 )
	FrameSelectedCorner:setImage( RegisterImage( @"uie_ui_menu_store_focus_pips" ) )
	FrameSelectedCorner:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_nineslice_add" ) )
	FrameSelectedCorner:setShaderVector( 0, 0, 0, 0, 0 )
	FrameSelectedCorner:setupNineSliceShader( 44, 44 )
	self:addElement( FrameSelectedCorner )
	self.FrameSelectedCorner = FrameSelectedCorner
	
	local Lines = CoD.DirectorSelectButtonLines.new( f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 1, -1 )
	Lines:setRGB( 0.64, 0.71, 0.78 )
	self:addElement( Lines )
	self.Lines = Lines
	
	self.ProgressBarFiller:linkToElementModel( self, "progressBarRatio", true, function ( model )
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ProgressBarFiller:setShaderVector( 0, CoD.GetVectorComponentFromString( f3_local0, 1 ), CoD.GetVectorComponentFromString( f3_local0, 2 ), CoD.GetVectorComponentFromString( f3_local0, 3 ), CoD.GetVectorComponentFromString( f3_local0, 4 ) )
		end
	end )
	self.Name:linkToElementModel( self, "name", true, function ( model )
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Name:setText( LocalizeToUpperString( f4_local0 ) )
		end
	end )
	self.ScoreValue:linkToElementModel( self, "score", true, function ( model )
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ScoreValue:setText( f5_local0 )
		end
	end )
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.SpecialWeaponSelection_Enh_Container.__resetProperties = function ( f6_arg0 )
	f6_arg0.ProgressBarBacking:completeAnimation()
	f6_arg0.ProgressBarFiller:completeAnimation()
	f6_arg0.FrameSelectedCorner:completeAnimation()
	f6_arg0.FrameSelected:completeAnimation()
	f6_arg0.Add:completeAnimation()
	f6_arg0.Lines:completeAnimation()
	f6_arg0.FocusGlow:completeAnimation()
	f6_arg0.Tick:completeAnimation()
	f6_arg0.AchievementIcon:completeAnimation()
	f6_arg0.ScoreValue:completeAnimation()
	f6_arg0.PointsInnerGlowBG:completeAnimation()
	f6_arg0.PointsBorder:completeAnimation()
	f6_arg0.CompletedTick:completeAnimation()
	f6_arg0.Lock:completeAnimation()
	f6_arg0.ProgressBarBacking:setRGB( 0.21, 0.21, 0.21 )
	f6_arg0.ProgressBarFiller:setRGB( 0.43, 0.41, 0.39 )
	f6_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -10, 10 )
	f6_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -10, 10 )
	f6_arg0.FrameSelectedCorner:setAlpha( 0 )
	f6_arg0.FrameSelectedCorner:setScale( 1, 1 )
	f6_arg0.FrameSelected:setRGB( 0.96, 0.94, 0.78 )
	f6_arg0.FrameSelected:setAlpha( 0 )
	f6_arg0.Add:setAlpha( 0 )
	f6_arg0.Lines:setRGB( 0.64, 0.71, 0.78 )
	f6_arg0.Lines:setAlpha( 1 )
	f6_arg0.FocusGlow:setAlpha( 0 )
	f6_arg0.Tick:setAlpha( 0 )
	f6_arg0.AchievementIcon:setRGB( 0.32, 0.32, 0.32 )
	f6_arg0.AchievementIcon:setAlpha( 0.8 )
	f6_arg0.ScoreValue:setRGB( 0.33, 0.33, 0.32 )
	f6_arg0.PointsInnerGlowBG:setAlpha( 0.01 )
	f6_arg0.PointsBorder:setAlpha( 0.25 )
	--f6_arg0.CompletedTick:setAlpha( 1 )
	f6_arg0.Lock:setAlpha( 1 )
end

CoD.SpecialWeaponSelection_Enh_Container.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f7_arg0, f7_arg1 )
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter( 0 )
		end,
		Focus = function ( f8_arg0, f8_arg1 )
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter( 7 )
			f8_arg0.FocusGlow:completeAnimation()
			f8_arg0.FocusGlow:setAlpha( 0.6 )
			f8_arg0.clipFinished( f8_arg0.FocusGlow )
			f8_arg0.ProgressBarBacking:completeAnimation()
			f8_arg0.ProgressBarBacking:setRGB( 0.3, 0.3, 0.3 )
			f8_arg0.clipFinished( f8_arg0.ProgressBarBacking )
			f8_arg0.ProgressBarFiller:completeAnimation()
			f8_arg0.ProgressBarFiller:setRGB( 0.41, 0.41, 0.41 )
			f8_arg0.clipFinished( f8_arg0.ProgressBarFiller )
			f8_arg0.Add:completeAnimation()
			f8_arg0.Add:setAlpha( 0.02 )
			f8_arg0.clipFinished( f8_arg0.Add )
			f8_arg0.FrameSelected:completeAnimation()
			f8_arg0.FrameSelected:setAlpha( 1 )
			f8_arg0.clipFinished( f8_arg0.FrameSelected )
			f8_arg0.FrameSelectedCorner:completeAnimation()
			f8_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -10, 10 )
			f8_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -10, 10 )
			f8_arg0.FrameSelectedCorner:setAlpha( 0.4 )
			f8_arg0.clipFinished( f8_arg0.FrameSelectedCorner )
			f8_arg0.Lines:completeAnimation()
			f8_arg0.Lines:setAlpha( 0 )
			f8_arg0.clipFinished( f8_arg0.Lines )
		end,
		Active = function ( f9_arg0, f9_arg1 )
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter( 4 )
			f9_arg0.Tick:completeAnimation()
			f9_arg0.Tick:setAlpha( 0.4 )
			f9_arg0.clipFinished( f9_arg0.Tick )
			f9_arg0.FocusGlow:completeAnimation()
			f9_arg0.FocusGlow:setAlpha( 0.3 )
			f9_arg0.clipFinished( f9_arg0.FocusGlow )
			f9_arg0.FrameSelected:completeAnimation()
			f9_arg0.FrameSelected:setAlpha( 0.25 )
			f9_arg0.clipFinished( f9_arg0.FrameSelected )
			f9_arg0.Lines:completeAnimation()
			f9_arg0.Lines:setRGB( 0.96, 0.79, 0.49 )
			f9_arg0.clipFinished( f9_arg0.Lines )
		end,
		GainFocus = function ( f10_arg0, f10_arg1 )
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter( 7 )
			local f10_local0 = function ( f11_arg0 )
				f10_arg0.FocusGlow:beginAnimation( 200 )
				f10_arg0.FocusGlow:setAlpha( 0.6 )
				f10_arg0.FocusGlow:registerEventHandler( "interrupted_keyframe", f10_arg0.clipInterrupted )
				f10_arg0.FocusGlow:registerEventHandler( "transition_complete_keyframe", f10_arg0.clipFinished )
			end
			
			f10_arg0.FocusGlow:completeAnimation()
			f10_arg0.FocusGlow:setAlpha( 0 )
			f10_local0( f10_arg0.FocusGlow )
			local f10_local1 = function ( f12_arg0 )
				f10_arg0.ProgressBarBacking:beginAnimation( 200 )
				f10_arg0.ProgressBarBacking:setRGB( 0.3, 0.3, 0.3 )
				f10_arg0.ProgressBarBacking:registerEventHandler( "interrupted_keyframe", f10_arg0.clipInterrupted )
				f10_arg0.ProgressBarBacking:registerEventHandler( "transition_complete_keyframe", f10_arg0.clipFinished )
			end
			
			f10_arg0.ProgressBarBacking:completeAnimation()
			f10_arg0.ProgressBarBacking:setRGB( 0.17, 0.17, 0.17 )
			f10_local1( f10_arg0.ProgressBarBacking )
			local f10_local2 = function ( f13_arg0 )
				f10_arg0.ProgressBarFiller:beginAnimation( 200 )
				f10_arg0.ProgressBarFiller:setRGB( 0.41, 0.41, 0.41 )
				f10_arg0.ProgressBarFiller:registerEventHandler( "interrupted_keyframe", f10_arg0.clipInterrupted )
				f10_arg0.ProgressBarFiller:registerEventHandler( "transition_complete_keyframe", f10_arg0.clipFinished )
			end
			
			f10_arg0.ProgressBarFiller:completeAnimation()
			f10_arg0.ProgressBarFiller:setRGB( 0.33, 0.32, 0.31 )
			f10_local2( f10_arg0.ProgressBarFiller )
			local f10_local3 = function ( f14_arg0 )
				f10_arg0.Add:beginAnimation( 200 )
				f10_arg0.Add:setAlpha( 0.02 )
				f10_arg0.Add:registerEventHandler( "interrupted_keyframe", f10_arg0.clipInterrupted )
				f10_arg0.Add:registerEventHandler( "transition_complete_keyframe", f10_arg0.clipFinished )
			end
			
			f10_arg0.Add:completeAnimation()
			f10_arg0.Add:setAlpha( 0 )
			f10_local3( f10_arg0.Add )
			local f10_local4 = function ( f15_arg0 )
				f10_arg0.FrameSelected:beginAnimation( 200 )
				f10_arg0.FrameSelected:setAlpha( 1 )
				f10_arg0.FrameSelected:registerEventHandler( "interrupted_keyframe", f10_arg0.clipInterrupted )
				f10_arg0.FrameSelected:registerEventHandler( "transition_complete_keyframe", f10_arg0.clipFinished )
			end
			
			f10_arg0.FrameSelected:completeAnimation()
			f10_arg0.FrameSelected:setAlpha( 0 )
			f10_local4( f10_arg0.FrameSelected )
			local f10_local5 = function ( f16_arg0 )
				local f16_local0 = function ( f17_arg0 )
					f17_arg0:beginAnimation( 50 )
					f17_arg0:setLeftRight( 0, 1, -10, 10 )
					f17_arg0:setTopBottom( 0, 1, -10, 10 )
					f17_arg0:setAlpha( 0.4 )
					f17_arg0:registerEventHandler( "transition_complete_keyframe", f10_arg0.clipFinished )
				end
				
				f10_arg0.FrameSelectedCorner:beginAnimation( 100 )
				f10_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -8, 8 )
				f10_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -8, 8 )
				f10_arg0.FrameSelectedCorner:setAlpha( 0.27 )
				f10_arg0.FrameSelectedCorner:registerEventHandler( "interrupted_keyframe", f10_arg0.clipInterrupted )
				f10_arg0.FrameSelectedCorner:registerEventHandler( "transition_complete_keyframe", f16_local0 )
			end
			
			f10_arg0.FrameSelectedCorner:completeAnimation()
			f10_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -40, 40 )
			f10_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -40, 40 )
			f10_arg0.FrameSelectedCorner:setAlpha( 0 )
			f10_local5( f10_arg0.FrameSelectedCorner )
			local f10_local6 = function ( f18_arg0 )
				f10_arg0.Lines:beginAnimation( 200 )
				f10_arg0.Lines:setAlpha( 0 )
				f10_arg0.Lines:registerEventHandler( "interrupted_keyframe", f10_arg0.clipInterrupted )
				f10_arg0.Lines:registerEventHandler( "transition_complete_keyframe", f10_arg0.clipFinished )
			end
			
			f10_arg0.Lines:completeAnimation()
			f10_arg0.Lines:setAlpha( 1 )
			f10_local6( f10_arg0.Lines )
		end,
		LoseFocus = function ( f19_arg0, f19_arg1 )
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter( 7 )
			local f19_local0 = function ( f20_arg0 )
				f19_arg0.FocusGlow:beginAnimation( 200 )
				f19_arg0.FocusGlow:setAlpha( 0 )
				f19_arg0.FocusGlow:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
				f19_arg0.FocusGlow:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
			end
			
			f19_arg0.FocusGlow:completeAnimation()
			f19_arg0.FocusGlow:setAlpha( 0.6 )
			f19_local0( f19_arg0.FocusGlow )
			local f19_local1 = function ( f21_arg0 )
				f19_arg0.ProgressBarBacking:beginAnimation( 200 )
				f19_arg0.ProgressBarBacking:setRGB( 0.17, 0.17, 0.17 )
				f19_arg0.ProgressBarBacking:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
				f19_arg0.ProgressBarBacking:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
			end
			
			f19_arg0.ProgressBarBacking:completeAnimation()
			f19_arg0.ProgressBarBacking:setRGB( 0.3, 0.3, 0.3 )
			f19_local1( f19_arg0.ProgressBarBacking )
			local f19_local2 = function ( f22_arg0 )
				f19_arg0.ProgressBarFiller:beginAnimation( 200 )
				f19_arg0.ProgressBarFiller:setRGB( 0.33, 0.32, 0.31 )
				f19_arg0.ProgressBarFiller:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
				f19_arg0.ProgressBarFiller:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
			end
			
			f19_arg0.ProgressBarFiller:completeAnimation()
			f19_arg0.ProgressBarFiller:setRGB( 0.41, 0.41, 0.41 )
			f19_local2( f19_arg0.ProgressBarFiller )
			local f19_local3 = function ( f23_arg0 )
				f19_arg0.Add:beginAnimation( 200 )
				f19_arg0.Add:setAlpha( 0 )
				f19_arg0.Add:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
				f19_arg0.Add:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
			end
			
			f19_arg0.Add:completeAnimation()
			f19_arg0.Add:setAlpha( 0.02 )
			f19_local3( f19_arg0.Add )
			local f19_local4 = function ( f24_arg0 )
				f19_arg0.FrameSelected:beginAnimation( 200 )
				f19_arg0.FrameSelected:setAlpha( 0 )
				f19_arg0.FrameSelected:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
				f19_arg0.FrameSelected:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
			end
			
			f19_arg0.FrameSelected:completeAnimation()
			f19_arg0.FrameSelected:setAlpha( 1 )
			f19_local4( f19_arg0.FrameSelected )
			local f19_local5 = function ( f25_arg0 )
				f19_arg0.FrameSelectedCorner:beginAnimation( 200 )
				f19_arg0.FrameSelectedCorner:setAlpha( 0 )
				f19_arg0.FrameSelectedCorner:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
				f19_arg0.FrameSelectedCorner:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
			end
			
			f19_arg0.FrameSelectedCorner:completeAnimation()
			f19_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -10, 10 )
			f19_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -10, 10 )
			f19_arg0.FrameSelectedCorner:setAlpha( 0.4 )
			f19_local5( f19_arg0.FrameSelectedCorner )
			local f19_local6 = function ( f26_arg0 )
				f19_arg0.Lines:beginAnimation( 200 )
				f19_arg0.Lines:setAlpha( 1 )
				f19_arg0.Lines:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
				f19_arg0.Lines:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
			end
			
			f19_arg0.Lines:completeAnimation()
			f19_arg0.Lines:setAlpha( 0 )
			f19_local6( f19_arg0.Lines )
		end,
		ActiveAndFocus = function ( f27_arg0, f27_arg1 )
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter( 8 )
			f27_arg0.Tick:completeAnimation()
			f27_arg0.Tick:setAlpha( 0.4 )
			f27_arg0.clipFinished( f27_arg0.Tick )
			f27_arg0.FocusGlow:completeAnimation()
			f27_arg0.FocusGlow:setAlpha( 0.6 )
			f27_arg0.clipFinished( f27_arg0.FocusGlow )
			f27_arg0.ProgressBarBacking:completeAnimation()
			f27_arg0.ProgressBarBacking:setRGB( 0.3, 0.3, 0.3 )
			f27_arg0.clipFinished( f27_arg0.ProgressBarBacking )
			f27_arg0.ProgressBarFiller:completeAnimation()
			f27_arg0.ProgressBarFiller:setRGB( 0.41, 0.41, 0.41 )
			f27_arg0.clipFinished( f27_arg0.ProgressBarFiller )
			f27_arg0.Add:completeAnimation()
			f27_arg0.Add:setAlpha( 0.02 )
			f27_arg0.clipFinished( f27_arg0.Add )
			f27_arg0.FrameSelected:completeAnimation()
			f27_arg0.FrameSelected:setAlpha( 1 )
			f27_arg0.clipFinished( f27_arg0.FrameSelected )
			f27_arg0.FrameSelectedCorner:completeAnimation()
			f27_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -10, 10 )
			f27_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -10, 10 )
			f27_arg0.FrameSelectedCorner:setAlpha( 0.4 )
			f27_arg0.clipFinished( f27_arg0.FrameSelectedCorner )
			f27_arg0.Lines:completeAnimation()
			f27_arg0.Lines:setAlpha( 0 )
			f27_arg0.clipFinished( f27_arg0.Lines )
		end,
		GainActiveAndFocus = function ( f28_arg0, f28_arg1 )
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter( 8 )
			f28_arg0.Tick:completeAnimation()
			f28_arg0.Tick:setAlpha( 0.4 )
			f28_arg0.clipFinished( f28_arg0.Tick )
			local f28_local0 = function ( f29_arg0 )
				f28_arg0.FocusGlow:beginAnimation( 200 )
				f28_arg0.FocusGlow:setAlpha( 0.6 )
				f28_arg0.FocusGlow:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
				f28_arg0.FocusGlow:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
			end
			
			f28_arg0.FocusGlow:completeAnimation()
			f28_arg0.FocusGlow:setAlpha( 0.3 )
			f28_local0( f28_arg0.FocusGlow )
			local f28_local1 = function ( f30_arg0 )
				f28_arg0.ProgressBarBacking:beginAnimation( 200 )
				f28_arg0.ProgressBarBacking:setRGB( 0.3, 0.3, 0.3 )
				f28_arg0.ProgressBarBacking:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
				f28_arg0.ProgressBarBacking:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
			end
			
			f28_arg0.ProgressBarBacking:completeAnimation()
			f28_arg0.ProgressBarBacking:setRGB( 0.17, 0.17, 0.17 )
			f28_local1( f28_arg0.ProgressBarBacking )
			local f28_local2 = function ( f31_arg0 )
				f28_arg0.ProgressBarFiller:beginAnimation( 200 )
				f28_arg0.ProgressBarFiller:setRGB( 0.41, 0.41, 0.41 )
				f28_arg0.ProgressBarFiller:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
				f28_arg0.ProgressBarFiller:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
			end
			
			f28_arg0.ProgressBarFiller:completeAnimation()
			f28_arg0.ProgressBarFiller:setRGB( 0.33, 0.32, 0.31 )
			f28_local2( f28_arg0.ProgressBarFiller )
			local f28_local3 = function ( f32_arg0 )
				f28_arg0.Add:beginAnimation( 200 )
				f28_arg0.Add:setAlpha( 0.02 )
				f28_arg0.Add:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
				f28_arg0.Add:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
			end
			
			f28_arg0.Add:completeAnimation()
			f28_arg0.Add:setAlpha( 0 )
			f28_local3( f28_arg0.Add )
			local f28_local4 = function ( f33_arg0 )
				f28_arg0.FrameSelected:beginAnimation( 200 )
				f28_arg0.FrameSelected:setAlpha( 1 )
				f28_arg0.FrameSelected:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
				f28_arg0.FrameSelected:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
			end
			
			f28_arg0.FrameSelected:completeAnimation()
			f28_arg0.FrameSelected:setAlpha( 0.25 )
			f28_local4( f28_arg0.FrameSelected )
			local f28_local5 = function ( f34_arg0 )
				local f34_local0 = function ( f35_arg0 )
					f35_arg0:beginAnimation( 50 )
					f35_arg0:setLeftRight( 0, 1, -10, 10 )
					f35_arg0:setTopBottom( 0, 1, -10, 10 )
					f35_arg0:setAlpha( 0.4 )
					f35_arg0:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
				end
				
				f28_arg0.FrameSelectedCorner:beginAnimation( 100 )
				f28_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -8, 8 )
				f28_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -8, 8 )
				f28_arg0.FrameSelectedCorner:setAlpha( 0.27 )
				f28_arg0.FrameSelectedCorner:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
				f28_arg0.FrameSelectedCorner:registerEventHandler( "transition_complete_keyframe", f34_local0 )
			end
			
			f28_arg0.FrameSelectedCorner:completeAnimation()
			f28_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -40, 40 )
			f28_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -40, 40 )
			f28_arg0.FrameSelectedCorner:setAlpha( 0 )
			f28_local5( f28_arg0.FrameSelectedCorner )
			local f28_local6 = function ( f36_arg0 )
				f28_arg0.Lines:beginAnimation( 200 )
				f28_arg0.Lines:setAlpha( 0 )
				f28_arg0.Lines:registerEventHandler( "interrupted_keyframe", f28_arg0.clipInterrupted )
				f28_arg0.Lines:registerEventHandler( "transition_complete_keyframe", f28_arg0.clipFinished )
			end
			
			f28_arg0.Lines:completeAnimation()
			f28_arg0.Lines:setRGB( 0.96, 0.79, 0.49 )
			f28_arg0.Lines:setAlpha( 1 )
			f28_local6( f28_arg0.Lines )
		end,
		LoseActiveAndFocus = function ( f37_arg0, f37_arg1 )
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter( 8 )
			f37_arg0.Tick:completeAnimation()
			f37_arg0.Tick:setAlpha( 0.4 )
			f37_arg0.clipFinished( f37_arg0.Tick )
			local f37_local0 = function ( f38_arg0 )
				f37_arg0.FocusGlow:beginAnimation( 200 )
				f37_arg0.FocusGlow:setAlpha( 0.3 )
				f37_arg0.FocusGlow:registerEventHandler( "interrupted_keyframe", f37_arg0.clipInterrupted )
				f37_arg0.FocusGlow:registerEventHandler( "transition_complete_keyframe", f37_arg0.clipFinished )
			end
			
			f37_arg0.FocusGlow:completeAnimation()
			f37_arg0.FocusGlow:setAlpha( 0.6 )
			f37_local0( f37_arg0.FocusGlow )
			local f37_local1 = function ( f39_arg0 )
				f37_arg0.ProgressBarBacking:beginAnimation( 200 )
				f37_arg0.ProgressBarBacking:setRGB( 0.17, 0.17, 0.17 )
				f37_arg0.ProgressBarBacking:registerEventHandler( "interrupted_keyframe", f37_arg0.clipInterrupted )
				f37_arg0.ProgressBarBacking:registerEventHandler( "transition_complete_keyframe", f37_arg0.clipFinished )
			end
			
			f37_arg0.ProgressBarBacking:completeAnimation()
			f37_arg0.ProgressBarBacking:setRGB( 0.3, 0.3, 0.3 )
			f37_local1( f37_arg0.ProgressBarBacking )
			local f37_local2 = function ( f40_arg0 )
				f37_arg0.ProgressBarFiller:beginAnimation( 200 )
				f37_arg0.ProgressBarFiller:setRGB( 0.33, 0.32, 0.31 )
				f37_arg0.ProgressBarFiller:registerEventHandler( "interrupted_keyframe", f37_arg0.clipInterrupted )
				f37_arg0.ProgressBarFiller:registerEventHandler( "transition_complete_keyframe", f37_arg0.clipFinished )
			end
			
			f37_arg0.ProgressBarFiller:completeAnimation()
			f37_arg0.ProgressBarFiller:setRGB( 0.41, 0.41, 0.41 )
			f37_local2( f37_arg0.ProgressBarFiller )
			local f37_local3 = function ( f41_arg0 )
				f37_arg0.Add:beginAnimation( 200 )
				f37_arg0.Add:setAlpha( 0 )
				f37_arg0.Add:registerEventHandler( "interrupted_keyframe", f37_arg0.clipInterrupted )
				f37_arg0.Add:registerEventHandler( "transition_complete_keyframe", f37_arg0.clipFinished )
			end
			
			f37_arg0.Add:completeAnimation()
			f37_arg0.Add:setAlpha( 0.02 )
			f37_local3( f37_arg0.Add )
			local f37_local4 = function ( f42_arg0 )
				f37_arg0.FrameSelected:beginAnimation( 200 )
				f37_arg0.FrameSelected:setAlpha( 0.25 )
				f37_arg0.FrameSelected:registerEventHandler( "interrupted_keyframe", f37_arg0.clipInterrupted )
				f37_arg0.FrameSelected:registerEventHandler( "transition_complete_keyframe", f37_arg0.clipFinished )
			end
			
			f37_arg0.FrameSelected:completeAnimation()
			f37_arg0.FrameSelected:setAlpha( 1 )
			f37_local4( f37_arg0.FrameSelected )
			local f37_local5 = function ( f43_arg0 )
				f37_arg0.FrameSelectedCorner:beginAnimation( 200 )
				f37_arg0.FrameSelectedCorner:setAlpha( 0 )
				f37_arg0.FrameSelectedCorner:registerEventHandler( "interrupted_keyframe", f37_arg0.clipInterrupted )
				f37_arg0.FrameSelectedCorner:registerEventHandler( "transition_complete_keyframe", f37_arg0.clipFinished )
			end
			
			f37_arg0.FrameSelectedCorner:completeAnimation()
			f37_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -10, 10 )
			f37_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -10, 10 )
			f37_arg0.FrameSelectedCorner:setAlpha( 0.4 )
			f37_local5( f37_arg0.FrameSelectedCorner )
			local f37_local6 = function ( f44_arg0 )
				f37_arg0.Lines:beginAnimation( 200 )
				f37_arg0.Lines:setAlpha( 1 )
				f37_arg0.Lines:registerEventHandler( "interrupted_keyframe", f37_arg0.clipInterrupted )
				f37_arg0.Lines:registerEventHandler( "transition_complete_keyframe", f37_arg0.clipFinished )
			end
			
			f37_arg0.Lines:completeAnimation()
			f37_arg0.Lines:setRGB( 0.96, 0.79, 0.49 )
			f37_arg0.Lines:setAlpha( 0 )
			f37_local6( f37_arg0.Lines )
		end,
		FocusToActiveAndFocus = function ( f45_arg0, f45_arg1 )
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter( 8 )
			local f45_local0 = function ( f46_arg0 )
				f45_arg0.Tick:beginAnimation( 200 )
				f45_arg0.Tick:setAlpha( 0.4 )
				f45_arg0.Tick:registerEventHandler( "interrupted_keyframe", f45_arg0.clipInterrupted )
				f45_arg0.Tick:registerEventHandler( "transition_complete_keyframe", f45_arg0.clipFinished )
			end
			
			f45_arg0.Tick:completeAnimation()
			f45_arg0.Tick:setAlpha( 0 )
			f45_local0( f45_arg0.Tick )
			f45_arg0.FocusGlow:completeAnimation()
			f45_arg0.FocusGlow:setAlpha( 0.6 )
			f45_arg0.clipFinished( f45_arg0.FocusGlow )
			f45_arg0.ProgressBarBacking:completeAnimation()
			f45_arg0.ProgressBarBacking:setRGB( 0.3, 0.3, 0.3 )
			f45_arg0.clipFinished( f45_arg0.ProgressBarBacking )
			f45_arg0.ProgressBarFiller:completeAnimation()
			f45_arg0.ProgressBarFiller:setRGB( 0.41, 0.41, 0.41 )
			f45_arg0.clipFinished( f45_arg0.ProgressBarFiller )
			f45_arg0.Add:completeAnimation()
			f45_arg0.Add:setAlpha( 0.02 )
			f45_arg0.clipFinished( f45_arg0.Add )
			f45_arg0.FrameSelected:completeAnimation()
			f45_arg0.FrameSelected:setAlpha( 1 )
			f45_arg0.clipFinished( f45_arg0.FrameSelected )
			f45_arg0.FrameSelectedCorner:completeAnimation()
			f45_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -10, 10 )
			f45_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -10, 10 )
			f45_arg0.FrameSelectedCorner:setAlpha( 0.4 )
			f45_arg0.clipFinished( f45_arg0.FrameSelectedCorner )
			f45_arg0.Lines:completeAnimation()
			f45_arg0.Lines:setAlpha( 0 )
			f45_arg0.clipFinished( f45_arg0.Lines )
		end,
		LoseActive = function ( f47_arg0, f47_arg1 )
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter( 4 )
			local f47_local0 = function ( f48_arg0 )
				f47_arg0.Tick:beginAnimation( 100 )
				f47_arg0.Tick:setAlpha( 0 )
				f47_arg0.Tick:registerEventHandler( "interrupted_keyframe", f47_arg0.clipInterrupted )
				f47_arg0.Tick:registerEventHandler( "transition_complete_keyframe", f47_arg0.clipFinished )
			end
			
			f47_arg0.Tick:completeAnimation()
			f47_arg0.Tick:setAlpha( 0.4 )
			f47_local0( f47_arg0.Tick )
			local f47_local1 = function ( f49_arg0 )
				f47_arg0.FocusGlow:beginAnimation( 100 )
				f47_arg0.FocusGlow:setAlpha( 0 )
				f47_arg0.FocusGlow:registerEventHandler( "interrupted_keyframe", f47_arg0.clipInterrupted )
				f47_arg0.FocusGlow:registerEventHandler( "transition_complete_keyframe", f47_arg0.clipFinished )
			end
			
			f47_arg0.FocusGlow:completeAnimation()
			f47_arg0.FocusGlow:setAlpha( 0.3 )
			f47_local1( f47_arg0.FocusGlow )
			local f47_local2 = function ( f50_arg0 )
				f47_arg0.FrameSelected:beginAnimation( 100 )
				f47_arg0.FrameSelected:setAlpha( 0 )
				f47_arg0.FrameSelected:registerEventHandler( "interrupted_keyframe", f47_arg0.clipInterrupted )
				f47_arg0.FrameSelected:registerEventHandler( "transition_complete_keyframe", f47_arg0.clipFinished )
			end
			
			f47_arg0.FrameSelected:completeAnimation()
			f47_arg0.FrameSelected:setAlpha( 0.25 )
			f47_local2( f47_arg0.FrameSelected )
			local f47_local3 = function ( f51_arg0 )
				f47_arg0.Lines:beginAnimation( 100 )
				f47_arg0.Lines:setRGB( 0.64, 0.71, 0.78 )
				f47_arg0.Lines:registerEventHandler( "interrupted_keyframe", f47_arg0.clipInterrupted )
				f47_arg0.Lines:registerEventHandler( "transition_complete_keyframe", f47_arg0.clipFinished )
			end
			
			f47_arg0.Lines:completeAnimation()
			f47_arg0.Lines:setRGB( 0.96, 0.79, 0.49 )
			f47_local3( f47_arg0.Lines )
		end
	},
	Completed = {
		DefaultClip = function ( f52_arg0, f52_arg1 )
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter( 6 )
			f52_arg0.PointsInnerGlowBG:completeAnimation()
			f52_arg0.PointsInnerGlowBG:setAlpha( 0.05 )
			f52_arg0.clipFinished( f52_arg0.PointsInnerGlowBG )
			f52_arg0.PointsBorder:completeAnimation()
			f52_arg0.PointsBorder:setAlpha( 0.85 )
			f52_arg0.clipFinished( f52_arg0.PointsBorder )
			--f52_arg0.CompletedTick:completeAnimation()
			--f52_arg0.CompletedTick:setAlpha( 1 )
			--f52_arg0.clipFinished( f52_arg0.CompletedTick )
			f52_arg0.AchievementIcon:completeAnimation()
			f52_arg0.AchievementIcon:setRGB( 1, 1, 1 )
			f52_arg0.AchievementIcon:setAlpha( 1 )
			f52_arg0.clipFinished( f52_arg0.AchievementIcon )
			f52_arg0.Lock:completeAnimation()
			f52_arg0.Lock:setAlpha( 0 )
			f52_arg0.clipFinished( f52_arg0.Lock )
			f52_arg0.ScoreValue:completeAnimation()
			f52_arg0.ScoreValue:setRGB( 0.88, 0.86, 0.81 )
			f52_arg0.clipFinished( f52_arg0.ScoreValue )
		end,
		Focus = function ( f53_arg0, f53_arg1 )
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter( 13 )
			f53_arg0.FocusGlow:completeAnimation()
			f53_arg0.FocusGlow:setAlpha( 0.6 )
			f53_arg0.clipFinished( f53_arg0.FocusGlow )
			f53_arg0.PointsInnerGlowBG:completeAnimation()
			f53_arg0.PointsInnerGlowBG:setAlpha( 0.05 )
			f53_arg0.clipFinished( f53_arg0.PointsInnerGlowBG )
			f53_arg0.PointsBorder:completeAnimation()
			f53_arg0.PointsBorder:setAlpha( 0.85 )
			f53_arg0.clipFinished( f53_arg0.PointsBorder )
			f53_arg0.ProgressBarBacking:completeAnimation()
			f53_arg0.ProgressBarBacking:setRGB( 0.3, 0.3, 0.3 )
			f53_arg0.clipFinished( f53_arg0.ProgressBarBacking )
			f53_arg0.ProgressBarFiller:completeAnimation()
			f53_arg0.ProgressBarFiller:setRGB( 0.41, 0.41, 0.41 )
			f53_arg0.clipFinished( f53_arg0.ProgressBarFiller )
			--f53_arg0.CompletedTick:completeAnimation()
			--f53_arg0.CompletedTick:setAlpha( 1 )
			--f53_arg0.clipFinished( f53_arg0.CompletedTick )
			f53_arg0.AchievementIcon:completeAnimation()
			f53_arg0.AchievementIcon:setRGB( 1, 1, 1 )
			f53_arg0.AchievementIcon:setAlpha( 1 )
			f53_arg0.clipFinished( f53_arg0.AchievementIcon )
			f53_arg0.Lock:completeAnimation()
			f53_arg0.Lock:setAlpha( 0 )
			f53_arg0.clipFinished( f53_arg0.Lock )
			f53_arg0.ScoreValue:completeAnimation()
			f53_arg0.ScoreValue:setRGB( 0.88, 0.86, 0.81 )
			f53_arg0.clipFinished( f53_arg0.ScoreValue )
			f53_arg0.Add:completeAnimation()
			f53_arg0.Add:setAlpha( 0.02 )
			f53_arg0.clipFinished( f53_arg0.Add )
			f53_arg0.FrameSelected:completeAnimation()
			f53_arg0.FrameSelected:setRGB( 0.96, 0.94, 0.78 )
			f53_arg0.FrameSelected:setAlpha( 1 )
			f53_arg0.clipFinished( f53_arg0.FrameSelected )
			f53_arg0.FrameSelectedCorner:completeAnimation()
			f53_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -10, 10 )
			f53_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -10, 10 )
			f53_arg0.FrameSelectedCorner:setAlpha( 0.4 )
			f53_arg0.FrameSelectedCorner:setScale( 1, 1 )
			f53_arg0.clipFinished( f53_arg0.FrameSelectedCorner )
			f53_arg0.Lines:completeAnimation()
			f53_arg0.Lines:setAlpha( 0 )
			f53_arg0.clipFinished( f53_arg0.Lines )
		end,
		Active = function ( f54_arg0, f54_arg1 )
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter( 10 )
			f54_arg0.Tick:completeAnimation()
			f54_arg0.Tick:setAlpha( 0.4 )
			f54_arg0.clipFinished( f54_arg0.Tick )
			f54_arg0.FocusGlow:completeAnimation()
			f54_arg0.FocusGlow:setAlpha( 0.3 )
			f54_arg0.clipFinished( f54_arg0.FocusGlow )
			f54_arg0.PointsInnerGlowBG:completeAnimation()
			f54_arg0.PointsInnerGlowBG:setAlpha( 0.05 )
			f54_arg0.clipFinished( f54_arg0.PointsInnerGlowBG )
			f54_arg0.PointsBorder:completeAnimation()
			f54_arg0.PointsBorder:setAlpha( 0.85 )
			f54_arg0.clipFinished( f54_arg0.PointsBorder )
			--f54_arg0.CompletedTick:completeAnimation()
			--f54_arg0.CompletedTick:setAlpha( 1 )
			--f54_arg0.clipFinished( f54_arg0.CompletedTick )
			f54_arg0.AchievementIcon:completeAnimation()
			f54_arg0.AchievementIcon:setRGB( 1, 1, 1 )
			f54_arg0.AchievementIcon:setAlpha( 1 )
			f54_arg0.clipFinished( f54_arg0.AchievementIcon )
			f54_arg0.Lock:completeAnimation()
			f54_arg0.Lock:setAlpha( 0 )
			f54_arg0.clipFinished( f54_arg0.Lock )
			f54_arg0.ScoreValue:completeAnimation()
			f54_arg0.ScoreValue:setRGB( 0.88, 0.86, 0.81 )
			f54_arg0.clipFinished( f54_arg0.ScoreValue )
			f54_arg0.FrameSelected:completeAnimation()
			f54_arg0.FrameSelected:setAlpha( 0.25 )
			f54_arg0.clipFinished( f54_arg0.FrameSelected )
			f54_arg0.Lines:completeAnimation()
			f54_arg0.Lines:setRGB( 0.96, 0.79, 0.49 )
			f54_arg0.clipFinished( f54_arg0.Lines )
		end,
		GainFocus = function ( f55_arg0, f55_arg1 )
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter( 13 )
			local f55_local0 = function ( f56_arg0 )
				f55_arg0.FocusGlow:beginAnimation( 200 )
				f55_arg0.FocusGlow:setAlpha( 0.6 )
				f55_arg0.FocusGlow:registerEventHandler( "interrupted_keyframe", f55_arg0.clipInterrupted )
				f55_arg0.FocusGlow:registerEventHandler( "transition_complete_keyframe", f55_arg0.clipFinished )
			end
			
			f55_arg0.FocusGlow:completeAnimation()
			f55_arg0.FocusGlow:setAlpha( 0 )
			f55_local0( f55_arg0.FocusGlow )
			f55_arg0.PointsInnerGlowBG:completeAnimation()
			f55_arg0.PointsInnerGlowBG:setAlpha( 0.05 )
			f55_arg0.clipFinished( f55_arg0.PointsInnerGlowBG )
			f55_arg0.PointsBorder:completeAnimation()
			f55_arg0.PointsBorder:setAlpha( 0.85 )
			f55_arg0.clipFinished( f55_arg0.PointsBorder )
			local f55_local1 = function ( f57_arg0 )
				f55_arg0.ProgressBarBacking:beginAnimation( 200 )
				f55_arg0.ProgressBarBacking:setRGB( 0.3, 0.3, 0.3 )
				f55_arg0.ProgressBarBacking:registerEventHandler( "interrupted_keyframe", f55_arg0.clipInterrupted )
				f55_arg0.ProgressBarBacking:registerEventHandler( "transition_complete_keyframe", f55_arg0.clipFinished )
			end
			
			f55_arg0.ProgressBarBacking:completeAnimation()
			f55_arg0.ProgressBarBacking:setRGB( 0.17, 0.17, 0.17 )
			f55_local1( f55_arg0.ProgressBarBacking )
			local f55_local2 = function ( f58_arg0 )
				f55_arg0.ProgressBarFiller:beginAnimation( 200 )
				f55_arg0.ProgressBarFiller:setRGB( 0.41, 0.41, 0.41 )
				f55_arg0.ProgressBarFiller:registerEventHandler( "interrupted_keyframe", f55_arg0.clipInterrupted )
				f55_arg0.ProgressBarFiller:registerEventHandler( "transition_complete_keyframe", f55_arg0.clipFinished )
			end
			
			f55_arg0.ProgressBarFiller:completeAnimation()
			f55_arg0.ProgressBarFiller:setRGB( 0.33, 0.32, 0.31 )
			f55_local2( f55_arg0.ProgressBarFiller )
			--f55_arg0.CompletedTick:completeAnimation()
			--f55_arg0.CompletedTick:setAlpha( 1 )
			--f55_arg0.clipFinished( f55_arg0.CompletedTick )
			f55_arg0.AchievementIcon:completeAnimation()
			f55_arg0.AchievementIcon:setRGB( 1, 1, 1 )
			f55_arg0.AchievementIcon:setAlpha( 1 )
			f55_arg0.clipFinished( f55_arg0.AchievementIcon )
			f55_arg0.Lock:completeAnimation()
			f55_arg0.Lock:setAlpha( 0 )
			f55_arg0.clipFinished( f55_arg0.Lock )
			f55_arg0.ScoreValue:completeAnimation()
			f55_arg0.ScoreValue:setRGB( 0.88, 0.86, 0.81 )
			f55_arg0.clipFinished( f55_arg0.ScoreValue )
			local f55_local3 = function ( f59_arg0 )
				f55_arg0.Add:beginAnimation( 200 )
				f55_arg0.Add:setAlpha( 0.02 )
				f55_arg0.Add:registerEventHandler( "interrupted_keyframe", f55_arg0.clipInterrupted )
				f55_arg0.Add:registerEventHandler( "transition_complete_keyframe", f55_arg0.clipFinished )
			end
			
			f55_arg0.Add:completeAnimation()
			f55_arg0.Add:setAlpha( 0 )
			f55_local3( f55_arg0.Add )
			local f55_local4 = function ( f60_arg0 )
				f55_arg0.FrameSelected:beginAnimation( 200 )
				f55_arg0.FrameSelected:setAlpha( 1 )
				f55_arg0.FrameSelected:registerEventHandler( "interrupted_keyframe", f55_arg0.clipInterrupted )
				f55_arg0.FrameSelected:registerEventHandler( "transition_complete_keyframe", f55_arg0.clipFinished )
			end
			
			f55_arg0.FrameSelected:completeAnimation()
			f55_arg0.FrameSelected:setAlpha( 0 )
			f55_local4( f55_arg0.FrameSelected )
			local f55_local5 = function ( f61_arg0 )
				local f61_local0 = function ( f62_arg0 )
					f62_arg0:beginAnimation( 50 )
					f62_arg0:setLeftRight( 0, 1, -10, 10 )
					f62_arg0:setTopBottom( 0, 1, -10, 10 )
					f62_arg0:setAlpha( 0.4 )
					f62_arg0:registerEventHandler( "transition_complete_keyframe", f55_arg0.clipFinished )
				end
				
				f55_arg0.FrameSelectedCorner:beginAnimation( 100 )
				f55_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -8, 8 )
				f55_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -8, 8 )
				f55_arg0.FrameSelectedCorner:setAlpha( 0.27 )
				f55_arg0.FrameSelectedCorner:registerEventHandler( "interrupted_keyframe", f55_arg0.clipInterrupted )
				f55_arg0.FrameSelectedCorner:registerEventHandler( "transition_complete_keyframe", f61_local0 )
			end
			
			f55_arg0.FrameSelectedCorner:completeAnimation()
			f55_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -40, 40 )
			f55_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -40, 40 )
			f55_arg0.FrameSelectedCorner:setAlpha( 0 )
			f55_local5( f55_arg0.FrameSelectedCorner )
			local f55_local6 = function ( f63_arg0 )
				f55_arg0.Lines:beginAnimation( 200 )
				f55_arg0.Lines:setAlpha( 0 )
				f55_arg0.Lines:registerEventHandler( "interrupted_keyframe", f55_arg0.clipInterrupted )
				f55_arg0.Lines:registerEventHandler( "transition_complete_keyframe", f55_arg0.clipFinished )
			end
			
			f55_arg0.Lines:completeAnimation()
			f55_arg0.Lines:setAlpha( 1 )
			f55_local6( f55_arg0.Lines )
		end,
		LoseFocus = function ( f64_arg0, f64_arg1 )
			f64_arg0:__resetProperties()
			f64_arg0:setupElementClipCounter( 13 )
			local f64_local0 = function ( f65_arg0 )
				f64_arg0.FocusGlow:beginAnimation( 200 )
				f64_arg0.FocusGlow:setAlpha( 0 )
				f64_arg0.FocusGlow:registerEventHandler( "interrupted_keyframe", f64_arg0.clipInterrupted )
				f64_arg0.FocusGlow:registerEventHandler( "transition_complete_keyframe", f64_arg0.clipFinished )
			end
			
			f64_arg0.FocusGlow:completeAnimation()
			f64_arg0.FocusGlow:setAlpha( 0.6 )
			f64_local0( f64_arg0.FocusGlow )
			f64_arg0.PointsInnerGlowBG:completeAnimation()
			f64_arg0.PointsInnerGlowBG:setAlpha( 0.05 )
			f64_arg0.clipFinished( f64_arg0.PointsInnerGlowBG )
			f64_arg0.PointsBorder:completeAnimation()
			f64_arg0.PointsBorder:setAlpha( 0.85 )
			f64_arg0.clipFinished( f64_arg0.PointsBorder )
			local f64_local1 = function ( f66_arg0 )
				f64_arg0.ProgressBarBacking:beginAnimation( 200 )
				f64_arg0.ProgressBarBacking:setRGB( 0.17, 0.17, 0.17 )
				f64_arg0.ProgressBarBacking:registerEventHandler( "interrupted_keyframe", f64_arg0.clipInterrupted )
				f64_arg0.ProgressBarBacking:registerEventHandler( "transition_complete_keyframe", f64_arg0.clipFinished )
			end
			
			f64_arg0.ProgressBarBacking:completeAnimation()
			f64_arg0.ProgressBarBacking:setRGB( 0.3, 0.3, 0.3 )
			f64_local1( f64_arg0.ProgressBarBacking )
			local f64_local2 = function ( f67_arg0 )
				f64_arg0.ProgressBarFiller:beginAnimation( 200 )
				f64_arg0.ProgressBarFiller:setRGB( 0.33, 0.32, 0.31 )
				f64_arg0.ProgressBarFiller:registerEventHandler( "interrupted_keyframe", f64_arg0.clipInterrupted )
				f64_arg0.ProgressBarFiller:registerEventHandler( "transition_complete_keyframe", f64_arg0.clipFinished )
			end
			
			f64_arg0.ProgressBarFiller:completeAnimation()
			f64_arg0.ProgressBarFiller:setRGB( 0.41, 0.41, 0.41 )
			f64_local2( f64_arg0.ProgressBarFiller )
			--f64_arg0.CompletedTick:completeAnimation()
			--f64_arg0.CompletedTick:setAlpha( 1 )
			--f64_arg0.clipFinished( f64_arg0.CompletedTick )
			f64_arg0.AchievementIcon:completeAnimation()
			f64_arg0.AchievementIcon:setRGB( 1, 1, 1 )
			f64_arg0.AchievementIcon:setAlpha( 1 )
			f64_arg0.clipFinished( f64_arg0.AchievementIcon )
			f64_arg0.Lock:completeAnimation()
			f64_arg0.Lock:setAlpha( 0 )
			f64_arg0.clipFinished( f64_arg0.Lock )
			f64_arg0.ScoreValue:completeAnimation()
			f64_arg0.ScoreValue:setRGB( 0.88, 0.86, 0.81 )
			f64_arg0.clipFinished( f64_arg0.ScoreValue )
			local f64_local3 = function ( f68_arg0 )
				f64_arg0.Add:beginAnimation( 200 )
				f64_arg0.Add:setAlpha( 0 )
				f64_arg0.Add:registerEventHandler( "interrupted_keyframe", f64_arg0.clipInterrupted )
				f64_arg0.Add:registerEventHandler( "transition_complete_keyframe", f64_arg0.clipFinished )
			end
			
			f64_arg0.Add:completeAnimation()
			f64_arg0.Add:setAlpha( 0.02 )
			f64_local3( f64_arg0.Add )
			local f64_local4 = function ( f69_arg0 )
				f64_arg0.FrameSelected:beginAnimation( 200 )
				f64_arg0.FrameSelected:setAlpha( 0 )
				f64_arg0.FrameSelected:registerEventHandler( "interrupted_keyframe", f64_arg0.clipInterrupted )
				f64_arg0.FrameSelected:registerEventHandler( "transition_complete_keyframe", f64_arg0.clipFinished )
			end
			
			f64_arg0.FrameSelected:completeAnimation()
			f64_arg0.FrameSelected:setAlpha( 1 )
			f64_local4( f64_arg0.FrameSelected )
			local f64_local5 = function ( f70_arg0 )
				f64_arg0.FrameSelectedCorner:beginAnimation( 200 )
				f64_arg0.FrameSelectedCorner:setAlpha( 0 )
				f64_arg0.FrameSelectedCorner:registerEventHandler( "interrupted_keyframe", f64_arg0.clipInterrupted )
				f64_arg0.FrameSelectedCorner:registerEventHandler( "transition_complete_keyframe", f64_arg0.clipFinished )
			end
			
			f64_arg0.FrameSelectedCorner:completeAnimation()
			f64_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -10, 10 )
			f64_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -10, 10 )
			f64_arg0.FrameSelectedCorner:setAlpha( 0.4 )
			f64_local5( f64_arg0.FrameSelectedCorner )
			local f64_local6 = function ( f71_arg0 )
				f64_arg0.Lines:beginAnimation( 200 )
				f64_arg0.Lines:setAlpha( 1 )
				f64_arg0.Lines:registerEventHandler( "interrupted_keyframe", f64_arg0.clipInterrupted )
				f64_arg0.Lines:registerEventHandler( "transition_complete_keyframe", f64_arg0.clipFinished )
			end
			
			f64_arg0.Lines:completeAnimation()
			f64_arg0.Lines:setAlpha( 0 )
			f64_local6( f64_arg0.Lines )
		end,
		ActiveAndFocus = function ( f72_arg0, f72_arg1 )
			f72_arg0:__resetProperties()
			f72_arg0:setupElementClipCounter( 14 )
			f72_arg0.Tick:completeAnimation()
			f72_arg0.Tick:setAlpha( 0.4 )
			f72_arg0.clipFinished( f72_arg0.Tick )
			f72_arg0.FocusGlow:completeAnimation()
			f72_arg0.FocusGlow:setAlpha( 0.6 )
			f72_arg0.clipFinished( f72_arg0.FocusGlow )
			f72_arg0.PointsInnerGlowBG:completeAnimation()
			f72_arg0.PointsInnerGlowBG:setAlpha( 0.05 )
			f72_arg0.clipFinished( f72_arg0.PointsInnerGlowBG )
			f72_arg0.PointsBorder:completeAnimation()
			f72_arg0.PointsBorder:setAlpha( 0.85 )
			f72_arg0.clipFinished( f72_arg0.PointsBorder )
			f72_arg0.ProgressBarBacking:completeAnimation()
			f72_arg0.ProgressBarBacking:setRGB( 0.3, 0.3, 0.3 )
			f72_arg0.clipFinished( f72_arg0.ProgressBarBacking )
			f72_arg0.ProgressBarFiller:completeAnimation()
			f72_arg0.ProgressBarFiller:setRGB( 0.41, 0.41, 0.41 )
			f72_arg0.clipFinished( f72_arg0.ProgressBarFiller )
			--f72_arg0.CompletedTick:completeAnimation()
			--f72_arg0.CompletedTick:setAlpha( 1 )
			--f72_arg0.clipFinished( f72_arg0.CompletedTick )
			f72_arg0.AchievementIcon:completeAnimation()
			f72_arg0.AchievementIcon:setRGB( 1, 1, 1 )
			f72_arg0.AchievementIcon:setAlpha( 1 )
			f72_arg0.clipFinished( f72_arg0.AchievementIcon )
			f72_arg0.Lock:completeAnimation()
			f72_arg0.Lock:setAlpha( 0 )
			f72_arg0.clipFinished( f72_arg0.Lock )
			f72_arg0.ScoreValue:completeAnimation()
			f72_arg0.ScoreValue:setRGB( 0.88, 0.86, 0.81 )
			f72_arg0.clipFinished( f72_arg0.ScoreValue )
			f72_arg0.Add:completeAnimation()
			f72_arg0.Add:setAlpha( 0.02 )
			f72_arg0.clipFinished( f72_arg0.Add )
			f72_arg0.FrameSelected:completeAnimation()
			f72_arg0.FrameSelected:setAlpha( 1 )
			f72_arg0.clipFinished( f72_arg0.FrameSelected )
			f72_arg0.FrameSelectedCorner:completeAnimation()
			f72_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -10, 10 )
			f72_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -10, 10 )
			f72_arg0.FrameSelectedCorner:setAlpha( 0.4 )
			f72_arg0.clipFinished( f72_arg0.FrameSelectedCorner )
			f72_arg0.Lines:completeAnimation()
			f72_arg0.Lines:setAlpha( 0 )
			f72_arg0.clipFinished( f72_arg0.Lines )
		end,
		GainActiveAndFocus = function ( f73_arg0, f73_arg1 )
			f73_arg0:__resetProperties()
			f73_arg0:setupElementClipCounter( 14 )
			f73_arg0.Tick:completeAnimation()
			f73_arg0.Tick:setAlpha( 0.4 )
			f73_arg0.clipFinished( f73_arg0.Tick )
			local f73_local0 = function ( f74_arg0 )
				f73_arg0.FocusGlow:beginAnimation( 200 )
				f73_arg0.FocusGlow:setAlpha( 0.6 )
				f73_arg0.FocusGlow:registerEventHandler( "interrupted_keyframe", f73_arg0.clipInterrupted )
				f73_arg0.FocusGlow:registerEventHandler( "transition_complete_keyframe", f73_arg0.clipFinished )
			end
			
			f73_arg0.FocusGlow:completeAnimation()
			f73_arg0.FocusGlow:setAlpha( 0.3 )
			f73_local0( f73_arg0.FocusGlow )
			f73_arg0.PointsInnerGlowBG:completeAnimation()
			f73_arg0.PointsInnerGlowBG:setAlpha( 0.05 )
			f73_arg0.clipFinished( f73_arg0.PointsInnerGlowBG )
			f73_arg0.PointsBorder:completeAnimation()
			f73_arg0.PointsBorder:setAlpha( 0.85 )
			f73_arg0.clipFinished( f73_arg0.PointsBorder )
			local f73_local1 = function ( f75_arg0 )
				f73_arg0.ProgressBarBacking:beginAnimation( 200 )
				f73_arg0.ProgressBarBacking:setRGB( 0.3, 0.3, 0.3 )
				f73_arg0.ProgressBarBacking:registerEventHandler( "interrupted_keyframe", f73_arg0.clipInterrupted )
				f73_arg0.ProgressBarBacking:registerEventHandler( "transition_complete_keyframe", f73_arg0.clipFinished )
			end
			
			f73_arg0.ProgressBarBacking:completeAnimation()
			f73_arg0.ProgressBarBacking:setRGB( 0.17, 0.17, 0.17 )
			f73_local1( f73_arg0.ProgressBarBacking )
			local f73_local2 = function ( f76_arg0 )
				f73_arg0.ProgressBarFiller:beginAnimation( 200 )
				f73_arg0.ProgressBarFiller:setRGB( 0.41, 0.41, 0.41 )
				f73_arg0.ProgressBarFiller:registerEventHandler( "interrupted_keyframe", f73_arg0.clipInterrupted )
				f73_arg0.ProgressBarFiller:registerEventHandler( "transition_complete_keyframe", f73_arg0.clipFinished )
			end
			
			f73_arg0.ProgressBarFiller:completeAnimation()
			f73_arg0.ProgressBarFiller:setRGB( 0.33, 0.32, 0.31 )
			f73_local2( f73_arg0.ProgressBarFiller )
			--f73_arg0.CompletedTick:completeAnimation()
			--f73_arg0.CompletedTick:setAlpha( 1 )
			--f73_arg0.clipFinished( f73_arg0.CompletedTick )
			f73_arg0.AchievementIcon:completeAnimation()
			f73_arg0.AchievementIcon:setRGB( 1, 1, 1 )
			f73_arg0.AchievementIcon:setAlpha( 1 )
			f73_arg0.clipFinished( f73_arg0.AchievementIcon )
			f73_arg0.Lock:completeAnimation()
			f73_arg0.Lock:setAlpha( 0 )
			f73_arg0.clipFinished( f73_arg0.Lock )
			f73_arg0.ScoreValue:completeAnimation()
			f73_arg0.ScoreValue:setRGB( 0.88, 0.86, 0.81 )
			f73_arg0.clipFinished( f73_arg0.ScoreValue )
			local f73_local3 = function ( f77_arg0 )
				f73_arg0.Add:beginAnimation( 200 )
				f73_arg0.Add:setAlpha( 0.02 )
				f73_arg0.Add:registerEventHandler( "interrupted_keyframe", f73_arg0.clipInterrupted )
				f73_arg0.Add:registerEventHandler( "transition_complete_keyframe", f73_arg0.clipFinished )
			end
			
			f73_arg0.Add:completeAnimation()
			f73_arg0.Add:setAlpha( 0 )
			f73_local3( f73_arg0.Add )
			local f73_local4 = function ( f78_arg0 )
				f73_arg0.FrameSelected:beginAnimation( 200 )
				f73_arg0.FrameSelected:setAlpha( 1 )
				f73_arg0.FrameSelected:registerEventHandler( "interrupted_keyframe", f73_arg0.clipInterrupted )
				f73_arg0.FrameSelected:registerEventHandler( "transition_complete_keyframe", f73_arg0.clipFinished )
			end
			
			f73_arg0.FrameSelected:completeAnimation()
			f73_arg0.FrameSelected:setAlpha( 0.25 )
			f73_local4( f73_arg0.FrameSelected )
			local f73_local5 = function ( f79_arg0 )
				local f79_local0 = function ( f80_arg0 )
					f80_arg0:beginAnimation( 50 )
					f80_arg0:setLeftRight( 0, 1, -10, 10 )
					f80_arg0:setTopBottom( 0, 1, -10, 10 )
					f80_arg0:setAlpha( 0.4 )
					f80_arg0:registerEventHandler( "transition_complete_keyframe", f73_arg0.clipFinished )
				end
				
				f73_arg0.FrameSelectedCorner:beginAnimation( 100 )
				f73_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -8, 8 )
				f73_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -8, 8 )
				f73_arg0.FrameSelectedCorner:setAlpha( 0.27 )
				f73_arg0.FrameSelectedCorner:registerEventHandler( "interrupted_keyframe", f73_arg0.clipInterrupted )
				f73_arg0.FrameSelectedCorner:registerEventHandler( "transition_complete_keyframe", f79_local0 )
			end
			
			f73_arg0.FrameSelectedCorner:completeAnimation()
			f73_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -40, 40 )
			f73_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -40, 40 )
			f73_arg0.FrameSelectedCorner:setAlpha( 0 )
			f73_local5( f73_arg0.FrameSelectedCorner )
			local f73_local6 = function ( f81_arg0 )
				f73_arg0.Lines:beginAnimation( 200 )
				f73_arg0.Lines:setAlpha( 0 )
				f73_arg0.Lines:registerEventHandler( "interrupted_keyframe", f73_arg0.clipInterrupted )
				f73_arg0.Lines:registerEventHandler( "transition_complete_keyframe", f73_arg0.clipFinished )
			end
			
			f73_arg0.Lines:completeAnimation()
			f73_arg0.Lines:setRGB( 0.96, 0.79, 0.49 )
			f73_arg0.Lines:setAlpha( 1 )
			f73_local6( f73_arg0.Lines )
		end,
		LoseActiveAndFocus = function ( f82_arg0, f82_arg1 )
			f82_arg0:__resetProperties()
			f82_arg0:setupElementClipCounter( 14 )
			f82_arg0.Tick:completeAnimation()
			f82_arg0.Tick:setAlpha( 0.4 )
			f82_arg0.clipFinished( f82_arg0.Tick )
			local f82_local0 = function ( f83_arg0 )
				f82_arg0.FocusGlow:beginAnimation( 200 )
				f82_arg0.FocusGlow:setAlpha( 0.3 )
				f82_arg0.FocusGlow:registerEventHandler( "interrupted_keyframe", f82_arg0.clipInterrupted )
				f82_arg0.FocusGlow:registerEventHandler( "transition_complete_keyframe", f82_arg0.clipFinished )
			end
			
			f82_arg0.FocusGlow:completeAnimation()
			f82_arg0.FocusGlow:setAlpha( 0.6 )
			f82_local0( f82_arg0.FocusGlow )
			f82_arg0.PointsInnerGlowBG:completeAnimation()
			f82_arg0.PointsInnerGlowBG:setAlpha( 0.05 )
			f82_arg0.clipFinished( f82_arg0.PointsInnerGlowBG )
			f82_arg0.PointsBorder:completeAnimation()
			f82_arg0.PointsBorder:setAlpha( 0.85 )
			f82_arg0.clipFinished( f82_arg0.PointsBorder )
			local f82_local1 = function ( f84_arg0 )
				f82_arg0.ProgressBarBacking:beginAnimation( 200 )
				f82_arg0.ProgressBarBacking:setRGB( 0.17, 0.17, 0.17 )
				f82_arg0.ProgressBarBacking:registerEventHandler( "interrupted_keyframe", f82_arg0.clipInterrupted )
				f82_arg0.ProgressBarBacking:registerEventHandler( "transition_complete_keyframe", f82_arg0.clipFinished )
			end
			
			f82_arg0.ProgressBarBacking:completeAnimation()
			f82_arg0.ProgressBarBacking:setRGB( 0.3, 0.3, 0.3 )
			f82_local1( f82_arg0.ProgressBarBacking )
			local f82_local2 = function ( f85_arg0 )
				f82_arg0.ProgressBarFiller:beginAnimation( 200 )
				f82_arg0.ProgressBarFiller:setRGB( 0.33, 0.32, 0.31 )
				f82_arg0.ProgressBarFiller:registerEventHandler( "interrupted_keyframe", f82_arg0.clipInterrupted )
				f82_arg0.ProgressBarFiller:registerEventHandler( "transition_complete_keyframe", f82_arg0.clipFinished )
			end
			
			f82_arg0.ProgressBarFiller:completeAnimation()
			f82_arg0.ProgressBarFiller:setRGB( 0.41, 0.41, 0.41 )
			f82_local2( f82_arg0.ProgressBarFiller )
			--f82_arg0.CompletedTick:completeAnimation()
			--f82_arg0.CompletedTick:setAlpha( 1 )
			--f82_arg0.clipFinished( f82_arg0.CompletedTick )
			f82_arg0.AchievementIcon:completeAnimation()
			f82_arg0.AchievementIcon:setRGB( 1, 1, 1 )
			f82_arg0.AchievementIcon:setAlpha( 1 )
			f82_arg0.clipFinished( f82_arg0.AchievementIcon )
			f82_arg0.Lock:completeAnimation()
			f82_arg0.Lock:setAlpha( 0 )
			f82_arg0.clipFinished( f82_arg0.Lock )
			f82_arg0.ScoreValue:completeAnimation()
			f82_arg0.ScoreValue:setRGB( 0.88, 0.86, 0.81 )
			f82_arg0.clipFinished( f82_arg0.ScoreValue )
			local f82_local3 = function ( f86_arg0 )
				f82_arg0.Add:beginAnimation( 200 )
				f82_arg0.Add:setAlpha( 0 )
				f82_arg0.Add:registerEventHandler( "interrupted_keyframe", f82_arg0.clipInterrupted )
				f82_arg0.Add:registerEventHandler( "transition_complete_keyframe", f82_arg0.clipFinished )
			end
			
			f82_arg0.Add:completeAnimation()
			f82_arg0.Add:setAlpha( 0.02 )
			f82_local3( f82_arg0.Add )
			local f82_local4 = function ( f87_arg0 )
				f82_arg0.FrameSelected:beginAnimation( 200 )
				f82_arg0.FrameSelected:setAlpha( 0.25 )
				f82_arg0.FrameSelected:registerEventHandler( "interrupted_keyframe", f82_arg0.clipInterrupted )
				f82_arg0.FrameSelected:registerEventHandler( "transition_complete_keyframe", f82_arg0.clipFinished )
			end
			
			f82_arg0.FrameSelected:completeAnimation()
			f82_arg0.FrameSelected:setAlpha( 1 )
			f82_local4( f82_arg0.FrameSelected )
			local f82_local5 = function ( f88_arg0 )
				f82_arg0.FrameSelectedCorner:beginAnimation( 200 )
				f82_arg0.FrameSelectedCorner:setAlpha( 0 )
				f82_arg0.FrameSelectedCorner:registerEventHandler( "interrupted_keyframe", f82_arg0.clipInterrupted )
				f82_arg0.FrameSelectedCorner:registerEventHandler( "transition_complete_keyframe", f82_arg0.clipFinished )
			end
			
			f82_arg0.FrameSelectedCorner:completeAnimation()
			f82_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -10, 10 )
			f82_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -10, 10 )
			f82_arg0.FrameSelectedCorner:setAlpha( 0.4 )
			f82_local5( f82_arg0.FrameSelectedCorner )
			local f82_local6 = function ( f89_arg0 )
				f82_arg0.Lines:beginAnimation( 200 )
				f82_arg0.Lines:setAlpha( 1 )
				f82_arg0.Lines:registerEventHandler( "interrupted_keyframe", f82_arg0.clipInterrupted )
				f82_arg0.Lines:registerEventHandler( "transition_complete_keyframe", f82_arg0.clipFinished )
			end
			
			f82_arg0.Lines:completeAnimation()
			f82_arg0.Lines:setRGB( 0.96, 0.79, 0.49 )
			f82_arg0.Lines:setAlpha( 0 )
			f82_local6( f82_arg0.Lines )
		end,
		FocusToActiveAndFocus = function ( f90_arg0, f90_arg1 )
			f90_arg0:__resetProperties()
			f90_arg0:setupElementClipCounter( 14 )
			local f90_local0 = function ( f91_arg0 )
				f90_arg0.Tick:beginAnimation( 200 )
				f90_arg0.Tick:setAlpha( 0.4 )
				f90_arg0.Tick:registerEventHandler( "interrupted_keyframe", f90_arg0.clipInterrupted )
				f90_arg0.Tick:registerEventHandler( "transition_complete_keyframe", f90_arg0.clipFinished )
			end
			
			f90_arg0.Tick:completeAnimation()
			f90_arg0.Tick:setAlpha( 0 )
			f90_local0( f90_arg0.Tick )
			f90_arg0.FocusGlow:completeAnimation()
			f90_arg0.FocusGlow:setAlpha( 0.6 )
			f90_arg0.clipFinished( f90_arg0.FocusGlow )
			f90_arg0.PointsInnerGlowBG:completeAnimation()
			f90_arg0.PointsInnerGlowBG:setAlpha( 0.05 )
			f90_arg0.clipFinished( f90_arg0.PointsInnerGlowBG )
			f90_arg0.PointsBorder:completeAnimation()
			f90_arg0.PointsBorder:setAlpha( 0.85 )
			f90_arg0.clipFinished( f90_arg0.PointsBorder )
			f90_arg0.ProgressBarBacking:completeAnimation()
			f90_arg0.ProgressBarBacking:setRGB( 0.3, 0.3, 0.3 )
			f90_arg0.clipFinished( f90_arg0.ProgressBarBacking )
			f90_arg0.ProgressBarFiller:completeAnimation()
			f90_arg0.ProgressBarFiller:setRGB( 0.41, 0.41, 0.41 )
			f90_arg0.clipFinished( f90_arg0.ProgressBarFiller )
			--f90_arg0.CompletedTick:completeAnimation()
			--f90_arg0.CompletedTick:setAlpha( 1 )
			--f90_arg0.clipFinished( f90_arg0.CompletedTick )
			f90_arg0.AchievementIcon:completeAnimation()
			f90_arg0.AchievementIcon:setRGB( 1, 1, 1 )
			f90_arg0.AchievementIcon:setAlpha( 1 )
			f90_arg0.clipFinished( f90_arg0.AchievementIcon )
			f90_arg0.Lock:completeAnimation()
			f90_arg0.Lock:setAlpha( 0 )
			f90_arg0.clipFinished( f90_arg0.Lock )
			f90_arg0.ScoreValue:completeAnimation()
			f90_arg0.ScoreValue:setRGB( 0.88, 0.86, 0.81 )
			f90_arg0.clipFinished( f90_arg0.ScoreValue )
			f90_arg0.Add:completeAnimation()
			f90_arg0.Add:setAlpha( 0.02 )
			f90_arg0.clipFinished( f90_arg0.Add )
			f90_arg0.FrameSelected:completeAnimation()
			f90_arg0.FrameSelected:setAlpha( 1 )
			f90_arg0.clipFinished( f90_arg0.FrameSelected )
			f90_arg0.FrameSelectedCorner:completeAnimation()
			f90_arg0.FrameSelectedCorner:setLeftRight( 0, 1, -10, 10 )
			f90_arg0.FrameSelectedCorner:setTopBottom( 0, 1, -10, 10 )
			f90_arg0.FrameSelectedCorner:setAlpha( 0.4 )
			f90_arg0.FrameSelectedCorner:setScale( 1, 1 )
			f90_arg0.clipFinished( f90_arg0.FrameSelectedCorner )
			f90_arg0.Lines:completeAnimation()
			f90_arg0.Lines:setAlpha( 0 )
			f90_arg0.clipFinished( f90_arg0.Lines )
		end,
		LoseActive = function ( f92_arg0, f92_arg1 )
			f92_arg0:__resetProperties()
			f92_arg0:setupElementClipCounter( 10 )
			local f92_local0 = function ( f93_arg0 )
				f92_arg0.Tick:beginAnimation( 100 )
				f92_arg0.Tick:setAlpha( 0 )
				f92_arg0.Tick:registerEventHandler( "interrupted_keyframe", f92_arg0.clipInterrupted )
				f92_arg0.Tick:registerEventHandler( "transition_complete_keyframe", f92_arg0.clipFinished )
			end
			
			f92_arg0.Tick:completeAnimation()
			f92_arg0.Tick:setAlpha( 0.4 )
			f92_local0( f92_arg0.Tick )
			local f92_local1 = function ( f94_arg0 )
				f92_arg0.FocusGlow:beginAnimation( 100 )
				f92_arg0.FocusGlow:setAlpha( 0 )
				f92_arg0.FocusGlow:registerEventHandler( "interrupted_keyframe", f92_arg0.clipInterrupted )
				f92_arg0.FocusGlow:registerEventHandler( "transition_complete_keyframe", f92_arg0.clipFinished )
			end
			
			f92_arg0.FocusGlow:completeAnimation()
			f92_arg0.FocusGlow:setAlpha( 0.3 )
			f92_local1( f92_arg0.FocusGlow )
			f92_arg0.PointsInnerGlowBG:completeAnimation()
			f92_arg0.PointsInnerGlowBG:setAlpha( 0.05 )
			f92_arg0.clipFinished( f92_arg0.PointsInnerGlowBG )
			f92_arg0.PointsBorder:completeAnimation()
			f92_arg0.PointsBorder:setAlpha( 0.85 )
			f92_arg0.clipFinished( f92_arg0.PointsBorder )
			--f92_arg0.CompletedTick:completeAnimation()
			--f92_arg0.CompletedTick:setAlpha( 1 )
			--f92_arg0.clipFinished( f92_arg0.CompletedTick )
			f92_arg0.AchievementIcon:completeAnimation()
			f92_arg0.AchievementIcon:setRGB( 1, 1, 1 )
			f92_arg0.AchievementIcon:setAlpha( 1 )
			f92_arg0.clipFinished( f92_arg0.AchievementIcon )
			f92_arg0.Lock:completeAnimation()
			f92_arg0.Lock:setAlpha( 0 )
			f92_arg0.clipFinished( f92_arg0.Lock )
			f92_arg0.ScoreValue:completeAnimation()
			f92_arg0.ScoreValue:setRGB( 0.88, 0.86, 0.81 )
			f92_arg0.clipFinished( f92_arg0.ScoreValue )
			local f92_local2 = function ( f95_arg0 )
				f92_arg0.FrameSelected:beginAnimation( 100 )
				f92_arg0.FrameSelected:setAlpha( 0 )
				f92_arg0.FrameSelected:registerEventHandler( "interrupted_keyframe", f92_arg0.clipInterrupted )
				f92_arg0.FrameSelected:registerEventHandler( "transition_complete_keyframe", f92_arg0.clipFinished )
			end
			
			f92_arg0.FrameSelected:completeAnimation()
			f92_arg0.FrameSelected:setAlpha( 0.25 )
			f92_local2( f92_arg0.FrameSelected )
			local f92_local3 = function ( f96_arg0 )
				f92_arg0.Lines:beginAnimation( 100 )
				f92_arg0.Lines:setRGB( 0.64, 0.71, 0.78 )
				f92_arg0.Lines:registerEventHandler( "interrupted_keyframe", f92_arg0.clipInterrupted )
				f92_arg0.Lines:registerEventHandler( "transition_complete_keyframe", f92_arg0.clipFinished )
			end
			
			f92_arg0.Lines:completeAnimation()
			f92_arg0.Lines:setRGB( 0.96, 0.79, 0.49 )
			f92_local3( f92_arg0.Lines )
		end
	}
}

CoD.SpecialWeaponSelection_Enh_Container.__onClose = function ( f97_arg0 )
	f97_arg0.ProgressBarFiller:close()
	f97_arg0.CompletedTick:close()
	f97_arg0.Name:close()
	f97_arg0.ScoreValue:close()
	f97_arg0.Lines:close()
end

CoD.SpecialWeaponSelection_Enh = InheritFrom( LUI.UIElement )
CoD.SpecialWeaponSelection_Enh.__defaultWidth = 960
CoD.SpecialWeaponSelection_Enh.__defaultHeight = 120
CoD.SpecialWeaponSelection_Enh.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.SpecialWeaponSelection_Enh )
	self.id = "SpecialWeaponSelection_Enh"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local Achievement = CoD.SpecialWeaponSelection_Enh_Container.new( f1_arg0, f1_arg1, 1, 1, -750, -100, 0.5, 0.5, -43.5, 43.5 )
	Achievement:mergeStateConditions( {
		{
			stateName = "Completed",
			condition = function ( menu, element, event )
				return AlwaysTrue()
			end
		}
	} )
	Achievement:linkToElementModel( Achievement, "refreshWidget", true, function ( model )
		f1_arg0:updateElementState( Achievement, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget"
		} )
	end )
	Achievement:appendEventHandler( "<datasourceChange>PCAchievement", function ( f4_arg0, f4_arg1 )
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState( Achievement, f4_arg1 )
	end )
	self:addElement( Achievement )
	self.Achievement = Achievement
	
	self.Achievement:linkToElementModel( self, "progressBarRatio", true, function ( model )
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Achievement.ProgressBarFiller:setShaderVector( 0, CoD.GetVectorComponentFromString( f5_local0, 1 ), CoD.GetVectorComponentFromString( f5_local0, 2 ), CoD.GetVectorComponentFromString( f5_local0, 3 ), CoD.GetVectorComponentFromString( f5_local0, 4 ) )
		end
	end )
      self.Achievement:linkToElementModel( self, "active", true, function ( model )
		local f5_local0 = model:get()
		if f5_local0 ~= nil and f5_local0 == true then
			Achievement.CompletedTick:setAlpha( 1 )
		end
	end )
	self.Achievement:linkToElementModel( self, "image", true, function ( model )
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
                  if type(f6_local0) == "userdata" then
			      Achievement.AchievementIcon:setImage( CoD.BaseUtility.AlreadyRegistered( f6_local0 ) )
                  else
                        Achievement.AchievementIcon:setImage( RegisterImage( f6_local0 ) )
                  end
		end
	end )
	self.Achievement:linkToElementModel( self, "name", true, function ( model )
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Achievement.Name:setText( LocalizeToUpperString( f7_local0 ) )
		end
	end )
	self.Achievement:linkToElementModel( self, "score", true, function ( model )
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			--Achievement.ScoreValue:setText( f8_local0 )
		end
	end )
      self.Achievement:linkToElementModel( self, "is_small", true, function ( model )
		local f8_local0 = model:get()
		if f8_local0 ~= nil and f8_local0 == true then
                  Achievement.AchievementIcon:setScale( 0.87, 0.87 )
            else
                  Achievement.AchievementIcon:setScale( 1, 1 )
		end
	end )
	Achievement.id = "Achievement"
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.SpecialWeaponSelection_Enh.__resetProperties = function ( f9_arg0 )
	f9_arg0.Achievement:completeAnimation()
	f9_arg0.Achievement:setAlpha( 1 )
	f9_arg0.Achievement:setScale( 1, 1 )
end

CoD.SpecialWeaponSelection_Enh.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f10_arg0, f10_arg1 )
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter( 0 )
		end,
		ChildFocus = function ( f11_arg0, f11_arg1 )
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter( 1 )
			f11_arg0.Achievement:completeAnimation()
			f11_arg0.Achievement:setScale( 1.02, 1.02 )
			f11_arg0.clipFinished( f11_arg0.Achievement )
		end,
		GainChildFocus = function ( f12_arg0, f12_arg1 )
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter( 1 )
			local f12_local0 = function ( f13_arg0 )
				f12_arg0.Achievement:beginAnimation( 200 )
				f12_arg0.Achievement:setScale( 1.02, 1.02 )
				f12_arg0.Achievement:registerEventHandler( "interrupted_keyframe", f12_arg0.clipInterrupted )
				f12_arg0.Achievement:registerEventHandler( "transition_complete_keyframe", f12_arg0.clipFinished )
			end
			
			f12_arg0.Achievement:completeAnimation()
			f12_arg0.Achievement:setScale( 1, 1 )
			f12_local0( f12_arg0.Achievement )
		end,
		LoseChildFocus = function ( f14_arg0, f14_arg1 )
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter( 1 )
			local f14_local0 = function ( f15_arg0 )
				f14_arg0.Achievement:beginAnimation( 200 )
				f14_arg0.Achievement:setScale( 1, 1 )
				f14_arg0.Achievement:registerEventHandler( "interrupted_keyframe", f14_arg0.clipInterrupted )
				f14_arg0.Achievement:registerEventHandler( "transition_complete_keyframe", f14_arg0.clipFinished )
			end
			
			f14_arg0.Achievement:completeAnimation()
			f14_arg0.Achievement:setScale( 1.02, 1.02 )
			f14_local0( f14_arg0.Achievement )
		end,
		Active = function ( f16_arg0, f16_arg1 )
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter( 1 )
			f16_arg0.Achievement:completeAnimation()
			f16_arg0.Achievement:setAlpha( 1 )
			f16_arg0.clipFinished( f16_arg0.Achievement )
		end,
		ActiveAndChildFocus = function ( f17_arg0, f17_arg1 )
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter( 1 )
			f17_arg0.Achievement:completeAnimation()
			f17_arg0.Achievement:setScale( 1.02, 1.02 )
			f17_arg0.clipFinished( f17_arg0.Achievement )
		end,
		GainActiveAndChildFocus = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			local f18_local0 = function ( f19_arg0 )
				f18_arg0.Achievement:beginAnimation( 200 )
				f18_arg0.Achievement:setScale( 1.02, 1.02 )
				f18_arg0.Achievement:registerEventHandler( "interrupted_keyframe", f18_arg0.clipInterrupted )
				f18_arg0.Achievement:registerEventHandler( "transition_complete_keyframe", f18_arg0.clipFinished )
			end
			
			f18_arg0.Achievement:completeAnimation()
			f18_arg0.Achievement:setScale( 1, 1 )
			f18_local0( f18_arg0.Achievement )
		end,
		LoseActiveAndChildFocus = function ( f20_arg0, f20_arg1 )
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter( 1 )
			local f20_local0 = function ( f21_arg0 )
				f20_arg0.Achievement:beginAnimation( 200 )
				f20_arg0.Achievement:setScale( 1, 1 )
				f20_arg0.Achievement:registerEventHandler( "interrupted_keyframe", f20_arg0.clipInterrupted )
				f20_arg0.Achievement:registerEventHandler( "transition_complete_keyframe", f20_arg0.clipFinished )
			end
			
			f20_arg0.Achievement:completeAnimation()
			f20_arg0.Achievement:setScale( 1.02, 1.02 )
			f20_local0( f20_arg0.Achievement )
		end,
		ChildFocusToActiveAndChildFocus = function ( f22_arg0, f22_arg1 )
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter( 1 )
			f22_arg0.Achievement:completeAnimation()
			f22_arg0.Achievement:setScale( 1.02, 1.02 )
			f22_arg0.clipFinished( f22_arg0.Achievement )
		end
	}
}

CoD.SpecialWeaponSelection_Enh.__onClose = function ( f23_arg0 )
	f23_arg0.Achievement:close()
end

CoD.SpecialWeaponSelectionBoxPatch_Enh = InheritFrom( LUI.UIElement )
CoD.SpecialWeaponSelectionBoxPatch_Enh.__defaultWidth = 960
CoD.SpecialWeaponSelectionBoxPatch_Enh.__defaultHeight = 120
CoD.SpecialWeaponSelectionBoxPatch_Enh.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.SpecialWeaponSelectionBoxPatch_Enh )
	self.id = "SpecialWeaponSelectionBoxPatch_Enh"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local Achievement = CoD.SpecialWeaponSelection_Enh_Container.new( f1_arg0, f1_arg1, 1, 1, -750, -100, 0.5, 0.5, -43.5, 43.5 )
	Achievement:mergeStateConditions( {
		{
			stateName = "Completed",
			condition = function ( menu, element, event )
				return AlwaysTrue()
			end
		}
	} )
	Achievement:linkToElementModel( Achievement, "refreshWidget", true, function ( model )
		f1_arg0:updateElementState( Achievement, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget"
		} )
	end )
	Achievement:appendEventHandler( "<datasourceChange>PCAchievement", function ( f4_arg0, f4_arg1 )
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState( Achievement, f4_arg1 )
	end )
	self:addElement( Achievement )
	self.Achievement = Achievement
	
	self.Achievement:linkToElementModel( self, "progressBarRatio", true, function ( model )
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Achievement.ProgressBarFiller:setShaderVector( 0, CoD.GetVectorComponentFromString( f5_local0, 1 ), CoD.GetVectorComponentFromString( f5_local0, 2 ), CoD.GetVectorComponentFromString( f5_local0, 3 ), CoD.GetVectorComponentFromString( f5_local0, 4 ) )
		end
	end )
      self.Achievement:linkToElementModel( self, "active", true, function ( model )
		local f5_local0 = model:get()
		if f5_local0 ~= nil and f5_local0 == true then
			Achievement.CompletedTick:setAlpha( 1 )
		end
	end )
	self.Achievement:linkToElementModel( self, "image", true, function ( model )
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
                  if type(f6_local0) == "userdata" then
			      Achievement.AchievementIcon:setImage( CoD.BaseUtility.AlreadyRegistered( f6_local0 ) )
                  else
                        Achievement.AchievementIcon:setImage( RegisterImage( f6_local0 ) )
                  end

                  Achievement.AchievementIcon:setLeftRight(0, 0, 80, 190)
		end
	end )
	self.Achievement:linkToElementModel( self, "name", true, function ( model )
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Achievement.Name:setText( LocalizeToUpperString( f7_local0 ) )
                  Achievement.Name:setLeftRight(0, 0, 293, 923)
		end
	end )
	self.Achievement:linkToElementModel( self, "score", true, function ( model )
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			--Achievement.ScoreValue:setText( f8_local0 )
		end
	end )
      self.Achievement:linkToElementModel( self, "is_small", true, function ( model )
		local f8_local0 = model:get()
		if f8_local0 ~= nil and f8_local0 == true then
                  Achievement.AchievementIcon:setScale( 0.87, 0.87 )
            else
                  Achievement.AchievementIcon:setScale( 1, 1 )
		end
	end )
	Achievement.id = "Achievement"
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.SpecialWeaponSelectionBoxPatch_Enh.__resetProperties = function ( f9_arg0 )
	f9_arg0.Achievement:completeAnimation()
	f9_arg0.Achievement:setAlpha( 1 )
	f9_arg0.Achievement:setScale( 1, 1 )
end

CoD.SpecialWeaponSelectionBoxPatch_Enh.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f10_arg0, f10_arg1 )
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter( 0 )
		end,
		ChildFocus = function ( f11_arg0, f11_arg1 )
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter( 1 )
			f11_arg0.Achievement:completeAnimation()
			f11_arg0.Achievement:setScale( 1.02, 1.02 )
			f11_arg0.clipFinished( f11_arg0.Achievement )
		end,
		GainChildFocus = function ( f12_arg0, f12_arg1 )
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter( 1 )
			local f12_local0 = function ( f13_arg0 )
				f12_arg0.Achievement:beginAnimation( 200 )
				f12_arg0.Achievement:setScale( 1.02, 1.02 )
				f12_arg0.Achievement:registerEventHandler( "interrupted_keyframe", f12_arg0.clipInterrupted )
				f12_arg0.Achievement:registerEventHandler( "transition_complete_keyframe", f12_arg0.clipFinished )
			end
			
			f12_arg0.Achievement:completeAnimation()
			f12_arg0.Achievement:setScale( 1, 1 )
			f12_local0( f12_arg0.Achievement )
		end,
		LoseChildFocus = function ( f14_arg0, f14_arg1 )
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter( 1 )
			local f14_local0 = function ( f15_arg0 )
				f14_arg0.Achievement:beginAnimation( 200 )
				f14_arg0.Achievement:setScale( 1, 1 )
				f14_arg0.Achievement:registerEventHandler( "interrupted_keyframe", f14_arg0.clipInterrupted )
				f14_arg0.Achievement:registerEventHandler( "transition_complete_keyframe", f14_arg0.clipFinished )
			end
			
			f14_arg0.Achievement:completeAnimation()
			f14_arg0.Achievement:setScale( 1.02, 1.02 )
			f14_local0( f14_arg0.Achievement )
		end,
		Active = function ( f16_arg0, f16_arg1 )
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter( 1 )
			f16_arg0.Achievement:completeAnimation()
			f16_arg0.Achievement:setAlpha( 1 )
			f16_arg0.clipFinished( f16_arg0.Achievement )
		end,
		ActiveAndChildFocus = function ( f17_arg0, f17_arg1 )
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter( 1 )
			f17_arg0.Achievement:completeAnimation()
			f17_arg0.Achievement:setScale( 1.02, 1.02 )
			f17_arg0.clipFinished( f17_arg0.Achievement )
		end,
		GainActiveAndChildFocus = function ( f18_arg0, f18_arg1 )
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter( 1 )
			local f18_local0 = function ( f19_arg0 )
				f18_arg0.Achievement:beginAnimation( 200 )
				f18_arg0.Achievement:setScale( 1.02, 1.02 )
				f18_arg0.Achievement:registerEventHandler( "interrupted_keyframe", f18_arg0.clipInterrupted )
				f18_arg0.Achievement:registerEventHandler( "transition_complete_keyframe", f18_arg0.clipFinished )
			end
			
			f18_arg0.Achievement:completeAnimation()
			f18_arg0.Achievement:setScale( 1, 1 )
			f18_local0( f18_arg0.Achievement )
		end,
		LoseActiveAndChildFocus = function ( f20_arg0, f20_arg1 )
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter( 1 )
			local f20_local0 = function ( f21_arg0 )
				f20_arg0.Achievement:beginAnimation( 200 )
				f20_arg0.Achievement:setScale( 1, 1 )
				f20_arg0.Achievement:registerEventHandler( "interrupted_keyframe", f20_arg0.clipInterrupted )
				f20_arg0.Achievement:registerEventHandler( "transition_complete_keyframe", f20_arg0.clipFinished )
			end
			
			f20_arg0.Achievement:completeAnimation()
			f20_arg0.Achievement:setScale( 1.02, 1.02 )
			f20_local0( f20_arg0.Achievement )
		end,
		ChildFocusToActiveAndChildFocus = function ( f22_arg0, f22_arg1 )
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter( 1 )
			f22_arg0.Achievement:completeAnimation()
			f22_arg0.Achievement:setScale( 1.02, 1.02 )
			f22_arg0.clipFinished( f22_arg0.Achievement )
		end
	}
}

CoD.SpecialWeaponSelectionBoxPatch_Enh.__onClose = function ( f23_arg0 )
	f23_arg0.Achievement:close()
end

-- for boss practice's
CoD.Shield_WeaponsStyleMain = InheritFrom( LUI.UIElement )
CoD.Shield_WeaponsStyleMain.__defaultWidth = 360
CoD.Shield_WeaponsStyleMain.__defaultHeight = 126
CoD.Shield_WeaponsStyleMain.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.Shield_WeaponsStyleMain )
	self.id = "Shield_WeaponsStyleMain"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local NoiseTiledBacking = CoD.Shield_WeaponsStyle.new( f1_arg0, f1_arg1, 0.5, 0.5, -180, 180, 0.5, 0.5, -63, 63 )
	NoiseTiledBacking:mergeStateConditions( {
		{
			stateName = "Locked",
			condition = function ( menu, element, event )
				return CoD.BaseUtility.IsSelfInState( self, "Locked" )
			end
		},
		{
			stateName = "Classified",
			condition = function ( menu, element, event )
				return CoD.BaseUtility.IsSelfInState( self, "Classified" )
			end
		},
		{
			stateName = "ClassifiedShowProgress",
			condition = function ( menu, element, event )
				return CoD.BaseUtility.IsSelfInState( self, "ClassifiedShowProgress" )
			end
		}
	} )
	NoiseTiledBacking:linkToElementModel( self, nil, false, function ( model )
		NoiseTiledBacking:setModel( model, f1_arg1 )
	end )
	NoiseTiledBacking:linkToElementModel( self, "title", true, function ( model )
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			NoiseTiledBacking.Label:setText( f6_local0 )
		end
	end )

	-- get the site for click datasource
	NoiseTiledBacking:linkToElementModel( self, "link", true, function ( model )
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			self.site = f6_local0
		end
	end )

	self:addElement( NoiseTiledBacking )
	self.NoiseTiledBacking = NoiseTiledBacking
	
	self:mergeStateConditions( {
		{
			stateName = "Locked",
			condition = function ( menu, element, event )
				return CoD.ModelUtility.IsSelfModelValueTrue( element, f1_arg1, "isLocked" )
			end
		},
		{
			stateName = "Classified",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "ClassifiedShowProgress",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		}
	} )
	self:linkToElementModel( self, "isLocked", true, function ( model )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLocked"
		} )
	end )
	LUI.OverrideFunction_CallOriginalFirst( self, "setState", function ( element, controller, f11_arg2, f11_arg3, f11_arg4 )
		UpdateElementState( self, "NoiseTiledBacking", controller )
	end )
	NoiseTiledBacking.id = "NoiseTiledBacking"
	self.__defaultFocus = NoiseTiledBacking
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.Shield_WeaponsStyleMain.__resetProperties = function ( f12_arg0 )
	f12_arg0.NoiseTiledBacking:completeAnimation()
	f12_arg0.NoiseTiledBacking:setScale( 1, 1 )
end

CoD.Shield_WeaponsStyleMain.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f13_arg0, f13_arg1 )
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter( 0 )
		end,
		ChildFocus = function ( f14_arg0, f14_arg1 )
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter( 1 )
			f14_arg0.NoiseTiledBacking:completeAnimation()
			f14_arg0.NoiseTiledBacking:setScale( 1.05, 1.05 )
			f14_arg0.clipFinished( f14_arg0.NoiseTiledBacking )
		end,
		GainChildFocus = function ( f15_arg0, f15_arg1 )
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter( 1 )
			local f15_local0 = function ( f16_arg0 )
				f15_arg0.NoiseTiledBacking:beginAnimation( 200 )
				f15_arg0.NoiseTiledBacking:setScale( 1.05, 1.05 )
				f15_arg0.NoiseTiledBacking:registerEventHandler( "interrupted_keyframe", f15_arg0.clipInterrupted )
				f15_arg0.NoiseTiledBacking:registerEventHandler( "transition_complete_keyframe", f15_arg0.clipFinished )
			end
			
			f15_arg0.NoiseTiledBacking:completeAnimation()
			f15_arg0.NoiseTiledBacking:setScale( 1, 1 )
			f15_local0( f15_arg0.NoiseTiledBacking )
		end,
		LoseChildFocus = function ( f17_arg0, f17_arg1 )
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter( 1 )
			local f17_local0 = function ( f18_arg0 )
				f17_arg0.NoiseTiledBacking:beginAnimation( 200 )
				f17_arg0.NoiseTiledBacking:setScale( 1, 1 )
				f17_arg0.NoiseTiledBacking:registerEventHandler( "interrupted_keyframe", f17_arg0.clipInterrupted )
				f17_arg0.NoiseTiledBacking:registerEventHandler( "transition_complete_keyframe", f17_arg0.clipFinished )
			end
			
			f17_arg0.NoiseTiledBacking:completeAnimation()
			f17_arg0.NoiseTiledBacking:setScale( 1.05, 1.05 )
			f17_local0( f17_arg0.NoiseTiledBacking )
		end
	},
	Locked = {
		DefaultClip = function ( f19_arg0, f19_arg1 )
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter( 0 )
		end
	},
	Classified = {
		DefaultClip = function ( f20_arg0, f20_arg1 )
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter( 0 )
		end
	},
	ClassifiedShowProgress = {
		DefaultClip = function ( f21_arg0, f21_arg1 )
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter( 0 )
		end
	}
}

CoD.Shield_WeaponsStyleMain.__onClose = function ( f22_arg0 )
	f22_arg0.NoiseTiledBacking:close()
end

CoD.Shield_WeaponsStyle = InheritFrom( LUI.UIElement )
CoD.Shield_WeaponsStyle.__defaultWidth = 360
CoD.Shield_WeaponsStyle.__defaultHeight = 126
CoD.Shield_WeaponsStyle.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.Shield_WeaponsStyle )
	self.id = "Shield_WeaponsStyle"
	self.soundSet = "FrontendMain"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )

      --CoD.EnhModPrintInfo("test 1")
	
	local NoiseTiledBacking = LUI.UIImage.new( 0, 1, 0, 0, 0, 1, 0, 0 )
	NoiseTiledBacking:setAlpha( 0.8 )
	NoiseTiledBacking:setImage( RegisterImage( @"uie_ui_menu_specialist_hub_repeat_bg" ) )
	NoiseTiledBacking:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_16CBE95C250C6D15" ) )
	NoiseTiledBacking:setShaderVector( 0, 0, 0, 0, 0 )
	NoiseTiledBacking:setupNineSliceShader( 196, 88 )
	self:addElement( NoiseTiledBacking )
	self.NoiseTiledBacking = NoiseTiledBacking
	
	local FocusGlow = LUI.UIImage.new( -0.09, 1.1, -110, 110, 0.5, 0.5, -99, 99 )
	FocusGlow:setAlpha( 0 )
	FocusGlow:setImage( RegisterImage( @"uie_ui_menu_common_focus_glow_large" ) )
	FocusGlow:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_6DAB59B2CAE01851" ) )
	FocusGlow:setShaderVector( 0, 0, 0, 0.25, 0.25 )
	FocusGlow:setShaderVector( 1, 1.2, 0, 0, 0 )
	FocusGlow:setupNineSliceShader( 300, 300 )
	self:addElement( FocusGlow )
	self.FocusGlow = FocusGlow
	
	local FrameBorder = LUI.UIImage.new( 0, 1, -1, 1, 0, 1, -1, 1 )
	FrameBorder:setAlpha( 0.15 )
	FrameBorder:setImage( RegisterImage( @"uie_ui_menu_store_common_frame" ) )
	FrameBorder:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_nineslice_add" ) )
	FrameBorder:setShaderVector( 0, 0, 0, 0, 0 )
	FrameBorder:setupNineSliceShader( 12, 12 )
	self:addElement( FrameBorder )
	self.FrameBorder = FrameBorder
	
	local FocusBorder = LUI.UIImage.new( 0, 1, -4, 4, 0, 1, -4, 4 )
	FocusBorder:setRGB( 0.96, 0.94, 0.78 )
	FocusBorder:setAlpha( 0 )
	FocusBorder:setImage( RegisterImage( @"uie_ui_menu_store_focus_frame" ) )
	FocusBorder:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_nineslice_add" ) )
	FocusBorder:setShaderVector( 0, 0, 0, 0, 0 )
	FocusBorder:setupNineSliceShader( 10, 10 )
	self:addElement( FocusBorder )
	self.FocusBorder = FocusBorder
	
	local SelectorOverlay = LUI.UIImage.new( 0, 1, 0, 0, 0, 1, 0, 0 )
	SelectorOverlay:setAlpha( 0.01 )
	self:addElement( SelectorOverlay )
	self.SelectorOverlay = SelectorOverlay
	
	local FocusBrackets = CoD.CommonFocusBrackets.new( f1_arg0, f1_arg1, 0, 1, -10, 10, 0, 1, -10, 10 )
	self:addElement( FocusBrackets )
	self.FocusBrackets = FocusBrackets

      --CoD.EnhModPrintInfo("test 1.5")
	
	local CardIcon = LUI.UIImage.new( 0, 1, 1, -1, 0, 0.71, 2, -2 )
	CardIcon:linkToElementModel( self, "icon", true, function ( model )
		local f2_local0 = model:get()
            local use_small_icon = CoD.ModelUtility.GetSelfModelPathValue(self, "small_icon")

		if f2_local0 ~= nil then
                  --CoD.EnhModPrintInfo("setting image for weapon", f2_local0)
			CardIcon:setImage( RegisterImage( f2_local0 ) )
		end

            if use_small_icon ~= nil and use_small_icon == true then
                  CardIcon:setLeftRight(0.35, 0.65, 1, -1)
                  --CoD.EnhModPrintInfo("using small icon")
            else
                  CardIcon:setLeftRight(0, 1, 1, -1)
                  --CoD.EnhModPrintInfo("using default icon")
            end
	end )
	self:addElement( CardIcon )
	self.CardIcon = CardIcon
	
	local CardIconLockOverlay = LUI.UIImage.new( 0, 1, 1, -1, 0, 0.71, 2, -2 )
	CardIconLockOverlay:setRGB( 0, 0, 0 )
	CardIconLockOverlay:setAlpha( 0 )
	self:addElement( CardIconLockOverlay )
	self.CardIconLockOverlay = CardIconLockOverlay
	
	local DarkOpsClassifiedIcon = LUI.UIImage.new( 0, 1, 1, -1, -0, 0.71, 2, -2 )
	DarkOpsClassifiedIcon:setAlpha( 0 )
	--DarkOpsClassifiedIcon:setImage( RegisterImage( @"uie_t7_icons_challenges_classified_placeholder" ) )
	self:addElement( DarkOpsClassifiedIcon )
	self.DarkOpsClassifiedIcon = DarkOpsClassifiedIcon
	
	local Lines = CoD.DirectorSelectButtonLines.new( f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 1, -1 )
	Lines:setRGB( 0.64, 0.71, 0.78 )
	self:addElement( Lines )
	self.Lines = Lines
	
	local Label = LUI.UIText.new( 0.5, 0.5, -175, 175, 0, 0, 93, 113 )
	Label:setAlpha( 0.85 )
	Label:setTTF( "ttmussels_regular" )
	Label:setLetterSpacing( 2 )
	Label:setAlignment( Enum[@"luialignment"][@"lui_alignment_center"] )
	Label:setAlignment( Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"] )
	Label:linkToElementModel( self, "title", true, function ( model )
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Label:setText( f3_local0 )
		end
	end )
	self:addElement( Label )
	self.Label = Label

      --CoD.EnhModPrintInfo("test 2")
	
	local lockedIcon = CoD.cac_lock.new( f1_arg0, f1_arg1, 0.5, 0.5, -18, 18, 0, 0, 27, 63 )
	self:addElement( lockedIcon )
	self.lockedIcon = lockedIcon
	
	local TrialWidget = CoD.TrialWidget.new( f1_arg0, f1_arg1, 0, 0, 5, 30, 0, 0, 5, 30 )
	TrialWidget:setAlpha( 0 )
	self:addElement( TrialWidget )
	self.TrialWidget = TrialWidget
	
	local ProgressBarBacking = LUI.UIImage.new( 0, 0, 5, 355, 0, 0, 115, 121 )
	ProgressBarBacking:setRGB( ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b )
	ProgressBarBacking:setAlpha( 0 )
	self:addElement( ProgressBarBacking )
	self.ProgressBarBacking = ProgressBarBacking
	
	local ProgressBorder = CoD.StartMenuOptionsMainFrame.new( f1_arg0, f1_arg1, 0.5, 0.5, -175, 175, 0, 0, 115, 121 )
	ProgressBorder:setAlpha( 0 )
	self:addElement( ProgressBorder )
	self.ProgressBorder = ProgressBorder
	
	local ProgressBar = LUI.UIImage.new( 0, 0, 5, 355, 0, 0, 115, 121 )
	ProgressBar:setRGB( 1, 0.35, 0 )
	ProgressBar:setAlpha( 0 )
	ProgressBar:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_wipe" ) )
	ProgressBar:setShaderVector( 1, 0, 0, 0, 0 )
	ProgressBar:setShaderVector( 2, 1, 0, 0, 0 )
	ProgressBar:setShaderVector( 3, 0, 0, 0, 0 )
	ProgressBar:setShaderVector( 4, 0, 0, 0, 0 )
	ProgressBar:linkToElementModel( self, "statPercent", true, function ( model )
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ProgressBar:setShaderVector( 0, CoD.GetVectorComponentFromString( f4_local0, 1 ), CoD.GetVectorComponentFromString( f4_local0, 2 ), CoD.GetVectorComponentFromString( f4_local0, 3 ), CoD.GetVectorComponentFromString( f4_local0, 4 ) )
		end
	end )
	self:addElement( ProgressBar )
	self.ProgressBar = ProgressBar
	
	self:mergeStateConditions( {
		{
			stateName = "Locked",
			condition = function ( menu, element, event )
				return CoD.ModelUtility.IsSelfModelValueTrue( element, f1_arg1, "isLocked" )
			end
		},
		{
			stateName = "Classified",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		},
		{
			stateName = "ClassifiedShowProgress",
			condition = function ( menu, element, event )
				return AlwaysFalse()
			end
		}
	} )
	self:linkToElementModel( self, "isLocked", true, function ( model )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLocked"
		} )
	end )
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end

      --CoD.EnhModPrintInfo("test 3")
	
	return self
end

CoD.Shield_WeaponsStyle.__resetProperties = function ( f9_arg0 )
	f9_arg0.lockedIcon:completeAnimation()
	f9_arg0.ProgressBar:completeAnimation()
	f9_arg0.FocusBrackets:completeAnimation()
	f9_arg0.ProgressBorder:completeAnimation()
	f9_arg0.TrialWidget:completeAnimation()
	f9_arg0.SelectorOverlay:completeAnimation()
	f9_arg0.FocusBorder:completeAnimation()
	f9_arg0.Lines:completeAnimation()
	f9_arg0.FocusGlow:completeAnimation()
	f9_arg0.Label:completeAnimation()
	f9_arg0.CardIcon:completeAnimation()
	f9_arg0.ProgressBarBacking:completeAnimation()
	f9_arg0.CardIconLockOverlay:completeAnimation()
	f9_arg0.DarkOpsClassifiedIcon:completeAnimation()
	f9_arg0.lockedIcon:setAlpha( 1 )
	f9_arg0.ProgressBar:setAlpha( 0 )
	f9_arg0.FocusBrackets:setLeftRight( 0, 1, -10, 10 )
	f9_arg0.FocusBrackets:setTopBottom( 0, 1, -10, 10 )
	f9_arg0.FocusBrackets:setAlpha( 1 )
	f9_arg0.FocusBrackets:setScale( 1, 1 )
	f9_arg0.ProgressBorder:setAlpha( 0 )
	f9_arg0.TrialWidget:setAlpha( 0 )
	f9_arg0.SelectorOverlay:setAlpha( 0.01 )
	f9_arg0.FocusBorder:setRGB( 0.96, 0.94, 0.78 )
	f9_arg0.FocusBorder:setAlpha( 0 )
	f9_arg0.Lines:setAlpha( 1 )
	f9_arg0.FocusGlow:setAlpha( 0 )
	f9_arg0.Label:setRGB( 1, 1, 1 )
	f9_arg0.CardIcon:setAlpha( 1 )
	f9_arg0.ProgressBarBacking:setAlpha( 0 )
	f9_arg0.CardIconLockOverlay:setAlpha( 0 )
	f9_arg0.DarkOpsClassifiedIcon:setAlpha( 0 )
end

CoD.Shield_WeaponsStyle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f10_arg0, f10_arg1 )
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter( 5 )
			f10_arg0.FocusBrackets:completeAnimation()
			f10_arg0.FocusBrackets:setAlpha( 0 )
			f10_arg0.clipFinished( f10_arg0.FocusBrackets )
			f10_arg0.lockedIcon:completeAnimation()
			f10_arg0.lockedIcon:setAlpha( 0 )
			f10_arg0.clipFinished( f10_arg0.lockedIcon )
			f10_arg0.TrialWidget:completeAnimation()
			f10_arg0.TrialWidget:setAlpha( 1 )
			f10_arg0.clipFinished( f10_arg0.TrialWidget )
			f10_arg0.ProgressBorder:completeAnimation()
			f10_arg0.ProgressBorder:setAlpha( 0 )
			f10_arg0.clipFinished( f10_arg0.ProgressBorder )
			f10_arg0.ProgressBar:completeAnimation()
			f10_arg0.ProgressBar:setAlpha( 0 )
			f10_arg0.clipFinished( f10_arg0.ProgressBar )
		end,
		Focus = function ( f11_arg0, f11_arg1 )
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter( 8 )
			f11_arg0.FocusGlow:completeAnimation()
			f11_arg0.FocusGlow:setAlpha( 0.6 )
			f11_arg0.clipFinished( f11_arg0.FocusGlow )
			f11_arg0.FocusBorder:completeAnimation()
			f11_arg0.FocusBorder:setAlpha( 1 )
			f11_arg0.clipFinished( f11_arg0.FocusBorder )
			f11_arg0.SelectorOverlay:completeAnimation()
			f11_arg0.SelectorOverlay:setAlpha( 0.04 )
			f11_arg0.clipFinished( f11_arg0.SelectorOverlay )
			f11_arg0.Lines:completeAnimation()
			f11_arg0.Lines:setAlpha( 0 )
			f11_arg0.clipFinished( f11_arg0.Lines )
			f11_arg0.Label:completeAnimation()
			f11_arg0.Label:setRGB( 0.96, 0.94, 0.78 )
			f11_arg0.clipFinished( f11_arg0.Label )
			f11_arg0.lockedIcon:completeAnimation()
			f11_arg0.lockedIcon:setAlpha( 0 )
			f11_arg0.clipFinished( f11_arg0.lockedIcon )
			f11_arg0.TrialWidget:completeAnimation()
			f11_arg0.TrialWidget:setAlpha( 1 )
			f11_arg0.clipFinished( f11_arg0.TrialWidget )
			f11_arg0.ProgressBar:completeAnimation()
			f11_arg0.ProgressBar:setAlpha( 0 )
			f11_arg0.clipFinished( f11_arg0.ProgressBar )
		end,
		GainFocus = function ( f12_arg0, f12_arg1 )
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter( 10 )
			local f12_local0 = function ( f13_arg0 )
				f12_arg0.FocusGlow:beginAnimation( 200 )
				f12_arg0.FocusGlow:setAlpha( 0.6 )
				f12_arg0.FocusGlow:registerEventHandler( "interrupted_keyframe", f12_arg0.clipInterrupted )
				f12_arg0.FocusGlow:registerEventHandler( "transition_complete_keyframe", f12_arg0.clipFinished )
			end
			
			f12_arg0.FocusGlow:completeAnimation()
			f12_arg0.FocusGlow:setAlpha( 0 )
			f12_local0( f12_arg0.FocusGlow )
			local f12_local1 = function ( f14_arg0 )
				f12_arg0.FocusBorder:beginAnimation( 200 )
				f12_arg0.FocusBorder:setAlpha( 1 )
				f12_arg0.FocusBorder:registerEventHandler( "interrupted_keyframe", f12_arg0.clipInterrupted )
				f12_arg0.FocusBorder:registerEventHandler( "transition_complete_keyframe", f12_arg0.clipFinished )
			end
			
			f12_arg0.FocusBorder:completeAnimation()
			f12_arg0.FocusBorder:setAlpha( 0 )
			f12_local1( f12_arg0.FocusBorder )
			local f12_local2 = function ( f15_arg0 )
				f12_arg0.SelectorOverlay:beginAnimation( 200 )
				f12_arg0.SelectorOverlay:setAlpha( 0.04 )
				f12_arg0.SelectorOverlay:registerEventHandler( "interrupted_keyframe", f12_arg0.clipInterrupted )
				f12_arg0.SelectorOverlay:registerEventHandler( "transition_complete_keyframe", f12_arg0.clipFinished )
			end
			
			f12_arg0.SelectorOverlay:completeAnimation()
			f12_arg0.SelectorOverlay:setAlpha( 0.01 )
			f12_local2( f12_arg0.SelectorOverlay )
			local f12_local3 = function ( f16_arg0 )
				local f16_local0 = function ( f17_arg0 )
					f17_arg0:beginAnimation( 50 )
					f17_arg0:setLeftRight( 0, 1, -10, 10 )
					f17_arg0:setTopBottom( 0, 1, -10, 10 )
					f17_arg0:setAlpha( 1 )
					f17_arg0:registerEventHandler( "transition_complete_keyframe", f12_arg0.clipFinished )
				end
				
				f12_arg0.FocusBrackets:beginAnimation( 100 )
				f12_arg0.FocusBrackets:setLeftRight( 0, 1, -8, 8 )
				f12_arg0.FocusBrackets:setTopBottom( 0, 1, -8, 8 )
				f12_arg0.FocusBrackets:setAlpha( 0.67 )
				f12_arg0.FocusBrackets:registerEventHandler( "interrupted_keyframe", f12_arg0.clipInterrupted )
				f12_arg0.FocusBrackets:registerEventHandler( "transition_complete_keyframe", f16_local0 )
			end
			
			f12_arg0.FocusBrackets:completeAnimation()
			f12_arg0.FocusBrackets:setLeftRight( 0, 1, -40, 40 )
			f12_arg0.FocusBrackets:setTopBottom( 0, 1, -40, 40 )
			f12_arg0.FocusBrackets:setAlpha( 0 )
			f12_local3( f12_arg0.FocusBrackets )
			local f12_local4 = function ( f18_arg0 )
				f12_arg0.Lines:beginAnimation( 200 )
				f12_arg0.Lines:setAlpha( 0 )
				f12_arg0.Lines:registerEventHandler( "interrupted_keyframe", f12_arg0.clipInterrupted )
				f12_arg0.Lines:registerEventHandler( "transition_complete_keyframe", f12_arg0.clipFinished )
			end
			
			f12_arg0.Lines:completeAnimation()
			f12_arg0.Lines:setAlpha( 1 )
			f12_local4( f12_arg0.Lines )
			f12_arg0.Label:completeAnimation()
			f12_arg0.Label:setRGB( 0.96, 0.94, 0.78 )
			f12_arg0.clipFinished( f12_arg0.Label )
			f12_arg0.lockedIcon:completeAnimation()
			f12_arg0.lockedIcon:setAlpha( 0 )
			f12_arg0.clipFinished( f12_arg0.lockedIcon )
			f12_arg0.TrialWidget:completeAnimation()
			f12_arg0.TrialWidget:setAlpha( 1 )
			f12_arg0.clipFinished( f12_arg0.TrialWidget )
			f12_arg0.ProgressBorder:completeAnimation()
			f12_arg0.ProgressBorder:setAlpha( 0 )
			f12_arg0.clipFinished( f12_arg0.ProgressBorder )
			f12_arg0.ProgressBar:completeAnimation()
			f12_arg0.ProgressBar:setAlpha( 0 )
			f12_arg0.clipFinished( f12_arg0.ProgressBar )
		end,
		LoseFocus = function ( f19_arg0, f19_arg1 )
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter( 9 )
			local f19_local0 = function ( f20_arg0 )
				f19_arg0.FocusGlow:beginAnimation( 200 )
				f19_arg0.FocusGlow:setAlpha( 0 )
				f19_arg0.FocusGlow:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
				f19_arg0.FocusGlow:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
			end
			
			f19_arg0.FocusGlow:completeAnimation()
			f19_arg0.FocusGlow:setAlpha( 0.6 )
			f19_local0( f19_arg0.FocusGlow )
			local f19_local1 = function ( f21_arg0 )
				f19_arg0.FocusBorder:beginAnimation( 200 )
				f19_arg0.FocusBorder:setAlpha( 0 )
				f19_arg0.FocusBorder:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
				f19_arg0.FocusBorder:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
			end
			
			f19_arg0.FocusBorder:completeAnimation()
			f19_arg0.FocusBorder:setAlpha( 1 )
			f19_local1( f19_arg0.FocusBorder )
			local f19_local2 = function ( f22_arg0 )
				f19_arg0.SelectorOverlay:beginAnimation( 200 )
				f19_arg0.SelectorOverlay:setAlpha( 0.01 )
				f19_arg0.SelectorOverlay:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
				f19_arg0.SelectorOverlay:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
			end
			
			f19_arg0.SelectorOverlay:completeAnimation()
			f19_arg0.SelectorOverlay:setAlpha( 0.04 )
			f19_local2( f19_arg0.SelectorOverlay )
			local f19_local3 = function ( f23_arg0 )
				f19_arg0.FocusBrackets:beginAnimation( 60 )
				f19_arg0.FocusBrackets:setAlpha( 0 )
				f19_arg0.FocusBrackets:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
				f19_arg0.FocusBrackets:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
			end
			
			f19_arg0.FocusBrackets:completeAnimation()
			f19_arg0.FocusBrackets:setAlpha( 1 )
			f19_local3( f19_arg0.FocusBrackets )
			local f19_local4 = function ( f24_arg0 )
				f19_arg0.Lines:beginAnimation( 200 )
				f19_arg0.Lines:setAlpha( 1 )
				f19_arg0.Lines:registerEventHandler( "interrupted_keyframe", f19_arg0.clipInterrupted )
				f19_arg0.Lines:registerEventHandler( "transition_complete_keyframe", f19_arg0.clipFinished )
			end
			
			f19_arg0.Lines:completeAnimation()
			f19_arg0.Lines:setAlpha( 0 )
			f19_local4( f19_arg0.Lines )
			f19_arg0.lockedIcon:completeAnimation()
			f19_arg0.lockedIcon:setAlpha( 0 )
			f19_arg0.clipFinished( f19_arg0.lockedIcon )
			f19_arg0.TrialWidget:completeAnimation()
			f19_arg0.TrialWidget:setAlpha( 1 )
			f19_arg0.clipFinished( f19_arg0.TrialWidget )
			f19_arg0.ProgressBorder:completeAnimation()
			f19_arg0.ProgressBorder:setAlpha( 0 )
			f19_arg0.clipFinished( f19_arg0.ProgressBorder )
			f19_arg0.ProgressBar:completeAnimation()
			f19_arg0.ProgressBar:setAlpha( 0 )
			f19_arg0.clipFinished( f19_arg0.ProgressBar )
		end
	},
	Locked = {
		DefaultClip = function ( f25_arg0, f25_arg1 )
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter( 7 )
			f25_arg0.FocusBrackets:completeAnimation()
			f25_arg0.FocusBrackets:setAlpha( 0 )
			f25_arg0.clipFinished( f25_arg0.FocusBrackets )
			f25_arg0.CardIcon:completeAnimation()
			f25_arg0.CardIcon:setAlpha( 1 )
			f25_arg0.clipFinished( f25_arg0.CardIcon )
			f25_arg0.CardIconLockOverlay:completeAnimation()
			f25_arg0.CardIconLockOverlay:setAlpha( 0.98 )
			f25_arg0.clipFinished( f25_arg0.CardIconLockOverlay )
			f25_arg0.Lines:completeAnimation()
			f25_arg0.Lines:setAlpha( 0.5 )
			f25_arg0.clipFinished( f25_arg0.Lines )
			f25_arg0.ProgressBarBacking:completeAnimation()
			f25_arg0.ProgressBarBacking:setAlpha( 0.02 )
			f25_arg0.clipFinished( f25_arg0.ProgressBarBacking )
			f25_arg0.ProgressBorder:completeAnimation()
			f25_arg0.ProgressBorder:setAlpha( 0.02 )
			f25_arg0.clipFinished( f25_arg0.ProgressBorder )
			f25_arg0.ProgressBar:completeAnimation()
			f25_arg0.ProgressBar:setAlpha( 1 )
			f25_arg0.clipFinished( f25_arg0.ProgressBar )
		end,
		Focus = function ( f26_arg0, f26_arg1 )
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter( 11 )
			f26_arg0.FocusGlow:completeAnimation()
			f26_arg0.FocusGlow:setAlpha( 0 )
			f26_arg0.clipFinished( f26_arg0.FocusGlow )
			f26_arg0.FocusBorder:completeAnimation()
			f26_arg0.FocusBorder:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
			f26_arg0.FocusBorder:setAlpha( 0.25 )
			f26_arg0.clipFinished( f26_arg0.FocusBorder )
			f26_arg0.SelectorOverlay:completeAnimation()
			f26_arg0.SelectorOverlay:setAlpha( 0.04 )
			f26_arg0.clipFinished( f26_arg0.SelectorOverlay )
			f26_arg0.FocusBrackets:completeAnimation()
			f26_arg0.FocusBrackets:setAlpha( 1 )
			f26_arg0.FocusBrackets:setScale( 1, 1 )
			f26_arg0.clipFinished( f26_arg0.FocusBrackets )
			f26_arg0.CardIconLockOverlay:completeAnimation()
			f26_arg0.CardIconLockOverlay:setAlpha( 0.98 )
			f26_arg0.clipFinished( f26_arg0.CardIconLockOverlay )
			f26_arg0.Lines:completeAnimation()
			f26_arg0.Lines:setAlpha( 0 )
			f26_arg0.clipFinished( f26_arg0.Lines )
			f26_arg0.Label:completeAnimation()
			f26_arg0.Label:setRGB( 0.96, 0.94, 0.78 )
			f26_arg0.clipFinished( f26_arg0.Label )
			f26_arg0.lockedIcon:completeAnimation()
			f26_arg0.lockedIcon:setAlpha( 0.8 )
			f26_arg0.clipFinished( f26_arg0.lockedIcon )
			f26_arg0.ProgressBarBacking:completeAnimation()
			f26_arg0.ProgressBarBacking:setAlpha( 0.02 )
			f26_arg0.clipFinished( f26_arg0.ProgressBarBacking )
			f26_arg0.ProgressBorder:completeAnimation()
			f26_arg0.ProgressBorder:setAlpha( 0.05 )
			f26_arg0.clipFinished( f26_arg0.ProgressBorder )
			f26_arg0.ProgressBar:completeAnimation()
			f26_arg0.ProgressBar:setAlpha( 1 )
			f26_arg0.clipFinished( f26_arg0.ProgressBar )
		end,
		GainFocus = function ( f27_arg0, f27_arg1 )
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter( 10 )
			local f27_local0 = function ( f28_arg0 )
				f27_arg0.FocusBorder:beginAnimation( 200 )
				f27_arg0.FocusBorder:setAlpha( 0.25 )
				f27_arg0.FocusBorder:registerEventHandler( "interrupted_keyframe", f27_arg0.clipInterrupted )
				f27_arg0.FocusBorder:registerEventHandler( "transition_complete_keyframe", f27_arg0.clipFinished )
			end
			
			f27_arg0.FocusBorder:completeAnimation()
			f27_arg0.FocusBorder:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
			f27_arg0.FocusBorder:setAlpha( 0 )
			f27_local0( f27_arg0.FocusBorder )
			local f27_local1 = function ( f29_arg0 )
				f27_arg0.SelectorOverlay:beginAnimation( 200 )
				f27_arg0.SelectorOverlay:setAlpha( 0.04 )
				f27_arg0.SelectorOverlay:registerEventHandler( "interrupted_keyframe", f27_arg0.clipInterrupted )
				f27_arg0.SelectorOverlay:registerEventHandler( "transition_complete_keyframe", f27_arg0.clipFinished )
			end
			
			f27_arg0.SelectorOverlay:completeAnimation()
			f27_arg0.SelectorOverlay:setAlpha( 0.01 )
			f27_local1( f27_arg0.SelectorOverlay )
			local f27_local2 = function ( f30_arg0 )
				local f30_local0 = function ( f31_arg0 )
					f31_arg0:beginAnimation( 50 )
					f31_arg0:setLeftRight( 0, 1, -10, 10 )
					f31_arg0:setTopBottom( 0, 1, -10, 10 )
					f31_arg0:setAlpha( 1 )
					f31_arg0:registerEventHandler( "transition_complete_keyframe", f27_arg0.clipFinished )
				end
				
				f27_arg0.FocusBrackets:beginAnimation( 100 )
				f27_arg0.FocusBrackets:setLeftRight( 0, 1, -8, 8 )
				f27_arg0.FocusBrackets:setTopBottom( 0, 1, -8, 8 )
				f27_arg0.FocusBrackets:setAlpha( 0.67 )
				f27_arg0.FocusBrackets:registerEventHandler( "interrupted_keyframe", f27_arg0.clipInterrupted )
				f27_arg0.FocusBrackets:registerEventHandler( "transition_complete_keyframe", f30_local0 )
			end
			
			f27_arg0.FocusBrackets:completeAnimation()
			f27_arg0.FocusBrackets:setLeftRight( 0, 1, -40, 40 )
			f27_arg0.FocusBrackets:setTopBottom( 0, 1, -40, 40 )
			f27_arg0.FocusBrackets:setAlpha( 0 )
			f27_local2( f27_arg0.FocusBrackets )
			f27_arg0.CardIconLockOverlay:completeAnimation()
			f27_arg0.CardIconLockOverlay:setAlpha( 0.98 )
			f27_arg0.clipFinished( f27_arg0.CardIconLockOverlay )
			f27_arg0.Lines:completeAnimation()
			f27_arg0.Lines:setAlpha( 0.5 )
			f27_arg0.clipFinished( f27_arg0.Lines )
			f27_arg0.Label:completeAnimation()
			f27_arg0.Label:setRGB( 0.96, 0.94, 0.78 )
			f27_arg0.clipFinished( f27_arg0.Label )
			local f27_local3 = function ( f32_arg0 )
				f27_arg0.lockedIcon:beginAnimation( 200 )
				f27_arg0.lockedIcon:setAlpha( 0.8 )
				f27_arg0.lockedIcon:registerEventHandler( "interrupted_keyframe", f27_arg0.clipInterrupted )
				f27_arg0.lockedIcon:registerEventHandler( "transition_complete_keyframe", f27_arg0.clipFinished )
			end
			
			f27_arg0.lockedIcon:completeAnimation()
			f27_arg0.lockedIcon:setAlpha( 1 )
			f27_local3( f27_arg0.lockedIcon )
			f27_arg0.ProgressBarBacking:completeAnimation()
			f27_arg0.ProgressBarBacking:setAlpha( 0.02 )
			f27_arg0.clipFinished( f27_arg0.ProgressBarBacking )
			f27_arg0.ProgressBorder:completeAnimation()
			f27_arg0.ProgressBorder:setAlpha( 0.05 )
			f27_arg0.clipFinished( f27_arg0.ProgressBorder )
			f27_arg0.ProgressBar:completeAnimation()
			f27_arg0.ProgressBar:setAlpha( 1 )
			f27_arg0.clipFinished( f27_arg0.ProgressBar )
		end,
		LoseFocus = function ( f33_arg0, f33_arg1 )
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter( 9 )
			local f33_local0 = function ( f34_arg0 )
				f33_arg0.FocusBorder:beginAnimation( 150 )
				f33_arg0.FocusBorder:setAlpha( 0 )
				f33_arg0.FocusBorder:registerEventHandler( "interrupted_keyframe", f33_arg0.clipInterrupted )
				f33_arg0.FocusBorder:registerEventHandler( "transition_complete_keyframe", f33_arg0.clipFinished )
			end
			
			f33_arg0.FocusBorder:completeAnimation()
			f33_arg0.FocusBorder:setRGB( ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b )
			f33_arg0.FocusBorder:setAlpha( 0.5 )
			f33_local0( f33_arg0.FocusBorder )
			local f33_local1 = function ( f35_arg0 )
				f33_arg0.SelectorOverlay:beginAnimation( 150 )
				f33_arg0.SelectorOverlay:setAlpha( 0.01 )
				f33_arg0.SelectorOverlay:registerEventHandler( "interrupted_keyframe", f33_arg0.clipInterrupted )
				f33_arg0.SelectorOverlay:registerEventHandler( "transition_complete_keyframe", f33_arg0.clipFinished )
			end
			
			f33_arg0.SelectorOverlay:completeAnimation()
			f33_arg0.SelectorOverlay:setAlpha( 0.04 )
			f33_local1( f33_arg0.SelectorOverlay )
			local f33_local2 = function ( f36_arg0 )
				f33_arg0.FocusBrackets:beginAnimation( 60 )
				f33_arg0.FocusBrackets:setAlpha( 0 )
				f33_arg0.FocusBrackets:registerEventHandler( "interrupted_keyframe", f33_arg0.clipInterrupted )
				f33_arg0.FocusBrackets:registerEventHandler( "transition_complete_keyframe", f33_arg0.clipFinished )
			end
			
			f33_arg0.FocusBrackets:completeAnimation()
			f33_arg0.FocusBrackets:setAlpha( 1 )
			f33_local2( f33_arg0.FocusBrackets )
			f33_arg0.CardIconLockOverlay:completeAnimation()
			f33_arg0.CardIconLockOverlay:setAlpha( 0.98 )
			f33_arg0.clipFinished( f33_arg0.CardIconLockOverlay )
			local f33_local3 = function ( f37_arg0 )
				f33_arg0.Lines:beginAnimation( 150 )
				f33_arg0.Lines:setAlpha( 1 )
				f33_arg0.Lines:registerEventHandler( "interrupted_keyframe", f33_arg0.clipInterrupted )
				f33_arg0.Lines:registerEventHandler( "transition_complete_keyframe", f33_arg0.clipFinished )
			end
			
			f33_arg0.Lines:completeAnimation()
			f33_arg0.Lines:setAlpha( 0 )
			f33_local3( f33_arg0.Lines )
			local f33_local4 = function ( f38_arg0 )
				f33_arg0.lockedIcon:beginAnimation( 150 )
				f33_arg0.lockedIcon:setAlpha( 1 )
				f33_arg0.lockedIcon:registerEventHandler( "interrupted_keyframe", f33_arg0.clipInterrupted )
				f33_arg0.lockedIcon:registerEventHandler( "transition_complete_keyframe", f33_arg0.clipFinished )
			end
			
			f33_arg0.lockedIcon:completeAnimation()
			f33_arg0.lockedIcon:setAlpha( 0.8 )
			f33_local4( f33_arg0.lockedIcon )
			f33_arg0.ProgressBarBacking:completeAnimation()
			f33_arg0.ProgressBarBacking:setAlpha( 0.02 )
			f33_arg0.clipFinished( f33_arg0.ProgressBarBacking )
			f33_arg0.ProgressBorder:completeAnimation()
			f33_arg0.ProgressBorder:setAlpha( 0.05 )
			f33_arg0.clipFinished( f33_arg0.ProgressBorder )
			f33_arg0.ProgressBar:completeAnimation()
			f33_arg0.ProgressBar:setAlpha( 1 )
			f33_arg0.clipFinished( f33_arg0.ProgressBar )
		end
	},
	Classified = {
		DefaultClip = function ( f39_arg0, f39_arg1 )
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter( 7 )
			f39_arg0.FocusBrackets:completeAnimation()
			f39_arg0.FocusBrackets:setAlpha( 0 )
			f39_arg0.clipFinished( f39_arg0.FocusBrackets )
			f39_arg0.CardIcon:completeAnimation()
			f39_arg0.CardIcon:setAlpha( 0 )
			f39_arg0.clipFinished( f39_arg0.CardIcon )
			f39_arg0.DarkOpsClassifiedIcon:completeAnimation()
			f39_arg0.DarkOpsClassifiedIcon:setAlpha( 1 )
			f39_arg0.clipFinished( f39_arg0.DarkOpsClassifiedIcon )
			f39_arg0.lockedIcon:completeAnimation()
			f39_arg0.lockedIcon:setAlpha( 0 )
			f39_arg0.clipFinished( f39_arg0.lockedIcon )
			f39_arg0.ProgressBarBacking:completeAnimation()
			f39_arg0.ProgressBarBacking:setAlpha( 0.1 )
			f39_arg0.clipFinished( f39_arg0.ProgressBarBacking )
			f39_arg0.ProgressBorder:completeAnimation()
			f39_arg0.ProgressBorder:setAlpha( 0.02 )
			f39_arg0.clipFinished( f39_arg0.ProgressBorder )
			f39_arg0.ProgressBar:completeAnimation()
			f39_arg0.ProgressBar:setAlpha( 0 )
			f39_arg0.clipFinished( f39_arg0.ProgressBar )
		end,
		Focus = function ( f40_arg0, f40_arg1 )
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter( 7 )
			f40_arg0.FocusGlow:completeAnimation()
			f40_arg0.FocusGlow:setAlpha( 0.6 )
			f40_arg0.clipFinished( f40_arg0.FocusGlow )
			f40_arg0.FocusBorder:completeAnimation()
			f40_arg0.FocusBorder:setRGB( 0.96, 0.94, 0.78 )
			f40_arg0.FocusBorder:setAlpha( 1 )
			f40_arg0.clipFinished( f40_arg0.FocusBorder )
			f40_arg0.SelectorOverlay:completeAnimation()
			f40_arg0.SelectorOverlay:setAlpha( 0.04 )
			f40_arg0.clipFinished( f40_arg0.SelectorOverlay )
			f40_arg0.CardIcon:completeAnimation()
			f40_arg0.CardIcon:setAlpha( 0 )
			f40_arg0.clipFinished( f40_arg0.CardIcon )
			f40_arg0.DarkOpsClassifiedIcon:completeAnimation()
			f40_arg0.DarkOpsClassifiedIcon:setAlpha( 1 )
			f40_arg0.clipFinished( f40_arg0.DarkOpsClassifiedIcon )
			f40_arg0.Label:completeAnimation()
			f40_arg0.Label:setRGB( 0.96, 0.94, 0.78 )
			f40_arg0.clipFinished( f40_arg0.Label )
			f40_arg0.lockedIcon:completeAnimation()
			f40_arg0.lockedIcon:setAlpha( 0 )
			f40_arg0.clipFinished( f40_arg0.lockedIcon )
		end,
		GainFocus = function ( f41_arg0, f41_arg1 )
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter( 8 )
			local f41_local0 = function ( f42_arg0 )
				f41_arg0.FocusGlow:beginAnimation( 200 )
				f41_arg0.FocusGlow:setAlpha( 0.6 )
				f41_arg0.FocusGlow:registerEventHandler( "interrupted_keyframe", f41_arg0.clipInterrupted )
				f41_arg0.FocusGlow:registerEventHandler( "transition_complete_keyframe", f41_arg0.clipFinished )
			end
			
			f41_arg0.FocusGlow:completeAnimation()
			f41_arg0.FocusGlow:setAlpha( 0 )
			f41_local0( f41_arg0.FocusGlow )
			local f41_local1 = function ( f43_arg0 )
				f41_arg0.FocusBorder:beginAnimation( 200 )
				f41_arg0.FocusBorder:setAlpha( 1 )
				f41_arg0.FocusBorder:registerEventHandler( "interrupted_keyframe", f41_arg0.clipInterrupted )
				f41_arg0.FocusBorder:registerEventHandler( "transition_complete_keyframe", f41_arg0.clipFinished )
			end
			
			f41_arg0.FocusBorder:completeAnimation()
			f41_arg0.FocusBorder:setAlpha( 0 )
			f41_local1( f41_arg0.FocusBorder )
			local f41_local2 = function ( f44_arg0 )
				f41_arg0.SelectorOverlay:beginAnimation( 200 )
				f41_arg0.SelectorOverlay:setAlpha( 0.04 )
				f41_arg0.SelectorOverlay:registerEventHandler( "interrupted_keyframe", f41_arg0.clipInterrupted )
				f41_arg0.SelectorOverlay:registerEventHandler( "transition_complete_keyframe", f41_arg0.clipFinished )
			end
			
			f41_arg0.SelectorOverlay:completeAnimation()
			f41_arg0.SelectorOverlay:setAlpha( 0.01 )
			f41_local2( f41_arg0.SelectorOverlay )
			local f41_local3 = function ( f45_arg0 )
				local f45_local0 = function ( f46_arg0 )
					f46_arg0:beginAnimation( 50 )
					f46_arg0:setLeftRight( 0, 1, -10, 10 )
					f46_arg0:setTopBottom( 0, 1, -10, 10 )
					f46_arg0:setAlpha( 1 )
					f46_arg0:registerEventHandler( "transition_complete_keyframe", f41_arg0.clipFinished )
				end
				
				f41_arg0.FocusBrackets:beginAnimation( 100 )
				f41_arg0.FocusBrackets:setLeftRight( 0, 1, -8, 8 )
				f41_arg0.FocusBrackets:setTopBottom( 0, 1, -8, 8 )
				f41_arg0.FocusBrackets:setAlpha( 0.67 )
				f41_arg0.FocusBrackets:registerEventHandler( "interrupted_keyframe", f41_arg0.clipInterrupted )
				f41_arg0.FocusBrackets:registerEventHandler( "transition_complete_keyframe", f45_local0 )
			end
			
			f41_arg0.FocusBrackets:completeAnimation()
			f41_arg0.FocusBrackets:setLeftRight( 0, 1, -40, 40 )
			f41_arg0.FocusBrackets:setTopBottom( 0, 1, -40, 40 )
			f41_arg0.FocusBrackets:setAlpha( 0 )
			f41_local3( f41_arg0.FocusBrackets )
			f41_arg0.CardIcon:completeAnimation()
			f41_arg0.CardIcon:setAlpha( 0 )
			f41_arg0.clipFinished( f41_arg0.CardIcon )
			f41_arg0.DarkOpsClassifiedIcon:completeAnimation()
			f41_arg0.DarkOpsClassifiedIcon:setAlpha( 1 )
			f41_arg0.clipFinished( f41_arg0.DarkOpsClassifiedIcon )
			f41_arg0.Label:completeAnimation()
			f41_arg0.Label:setRGB( 0.96, 0.94, 0.78 )
			f41_arg0.clipFinished( f41_arg0.Label )
			f41_arg0.lockedIcon:completeAnimation()
			f41_arg0.lockedIcon:setAlpha( 0 )
			f41_arg0.clipFinished( f41_arg0.lockedIcon )
		end,
		LoseFocus = function ( f47_arg0, f47_arg1 )
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter( 7 )
			local f47_local0 = function ( f48_arg0 )
				f47_arg0.FocusGlow:beginAnimation( 200 )
				f47_arg0.FocusGlow:setAlpha( 0 )
				f47_arg0.FocusGlow:registerEventHandler( "interrupted_keyframe", f47_arg0.clipInterrupted )
				f47_arg0.FocusGlow:registerEventHandler( "transition_complete_keyframe", f47_arg0.clipFinished )
			end
			
			f47_arg0.FocusGlow:completeAnimation()
			f47_arg0.FocusGlow:setAlpha( 0.6 )
			f47_local0( f47_arg0.FocusGlow )
			local f47_local1 = function ( f49_arg0 )
				f47_arg0.FocusBorder:beginAnimation( 200 )
				f47_arg0.FocusBorder:setAlpha( 0 )
				f47_arg0.FocusBorder:registerEventHandler( "interrupted_keyframe", f47_arg0.clipInterrupted )
				f47_arg0.FocusBorder:registerEventHandler( "transition_complete_keyframe", f47_arg0.clipFinished )
			end
			
			f47_arg0.FocusBorder:completeAnimation()
			f47_arg0.FocusBorder:setAlpha( 1 )
			f47_local1( f47_arg0.FocusBorder )
			local f47_local2 = function ( f50_arg0 )
				f47_arg0.SelectorOverlay:beginAnimation( 200 )
				f47_arg0.SelectorOverlay:setAlpha( 0.01 )
				f47_arg0.SelectorOverlay:registerEventHandler( "interrupted_keyframe", f47_arg0.clipInterrupted )
				f47_arg0.SelectorOverlay:registerEventHandler( "transition_complete_keyframe", f47_arg0.clipFinished )
			end
			
			f47_arg0.SelectorOverlay:completeAnimation()
			f47_arg0.SelectorOverlay:setAlpha( 0.04 )
			f47_local2( f47_arg0.SelectorOverlay )
			local f47_local3 = function ( f51_arg0 )
				f47_arg0.FocusBrackets:beginAnimation( 60 )
				f47_arg0.FocusBrackets:setAlpha( 0 )
				f47_arg0.FocusBrackets:registerEventHandler( "interrupted_keyframe", f47_arg0.clipInterrupted )
				f47_arg0.FocusBrackets:registerEventHandler( "transition_complete_keyframe", f47_arg0.clipFinished )
			end
			
			f47_arg0.FocusBrackets:completeAnimation()
			f47_arg0.FocusBrackets:setAlpha( 1 )
			f47_local3( f47_arg0.FocusBrackets )
			f47_arg0.CardIcon:completeAnimation()
			f47_arg0.CardIcon:setAlpha( 0 )
			f47_arg0.clipFinished( f47_arg0.CardIcon )
			f47_arg0.DarkOpsClassifiedIcon:completeAnimation()
			f47_arg0.DarkOpsClassifiedIcon:setAlpha( 1 )
			f47_arg0.clipFinished( f47_arg0.DarkOpsClassifiedIcon )
			f47_arg0.lockedIcon:completeAnimation()
			f47_arg0.lockedIcon:setAlpha( 0 )
			f47_arg0.clipFinished( f47_arg0.lockedIcon )
		end
	},
	ClassifiedShowProgress = {
		DefaultClip = function ( f52_arg0, f52_arg1 )
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter( 7 )
			f52_arg0.FocusBrackets:completeAnimation()
			f52_arg0.FocusBrackets:setAlpha( 0 )
			f52_arg0.clipFinished( f52_arg0.FocusBrackets )
			f52_arg0.CardIcon:completeAnimation()
			f52_arg0.CardIcon:setAlpha( 0 )
			f52_arg0.clipFinished( f52_arg0.CardIcon )
			f52_arg0.DarkOpsClassifiedIcon:completeAnimation()
			f52_arg0.DarkOpsClassifiedIcon:setAlpha( 1 )
			f52_arg0.clipFinished( f52_arg0.DarkOpsClassifiedIcon )
			f52_arg0.lockedIcon:completeAnimation()
			f52_arg0.lockedIcon:setAlpha( 0 )
			f52_arg0.clipFinished( f52_arg0.lockedIcon )
			f52_arg0.ProgressBarBacking:completeAnimation()
			f52_arg0.ProgressBarBacking:setAlpha( 0.1 )
			f52_arg0.clipFinished( f52_arg0.ProgressBarBacking )
			f52_arg0.ProgressBorder:completeAnimation()
			f52_arg0.ProgressBorder:setAlpha( 0.02 )
			f52_arg0.clipFinished( f52_arg0.ProgressBorder )
			f52_arg0.ProgressBar:completeAnimation()
			f52_arg0.ProgressBar:setAlpha( 1 )
			f52_arg0.clipFinished( f52_arg0.ProgressBar )
		end,
		Focus = function ( f53_arg0, f53_arg1 )
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter( 8 )
			f53_arg0.FocusGlow:completeAnimation()
			f53_arg0.FocusGlow:setAlpha( 0.6 )
			f53_arg0.clipFinished( f53_arg0.FocusGlow )
			f53_arg0.FocusBorder:completeAnimation()
			f53_arg0.FocusBorder:setAlpha( 1 )
			f53_arg0.clipFinished( f53_arg0.FocusBorder )
			f53_arg0.SelectorOverlay:completeAnimation()
			f53_arg0.SelectorOverlay:setAlpha( 0.04 )
			f53_arg0.clipFinished( f53_arg0.SelectorOverlay )
			f53_arg0.CardIcon:completeAnimation()
			f53_arg0.CardIcon:setAlpha( 0 )
			f53_arg0.clipFinished( f53_arg0.CardIcon )
			f53_arg0.DarkOpsClassifiedIcon:completeAnimation()
			f53_arg0.DarkOpsClassifiedIcon:setAlpha( 1 )
			f53_arg0.clipFinished( f53_arg0.DarkOpsClassifiedIcon )
			f53_arg0.Label:completeAnimation()
			f53_arg0.Label:setRGB( 0.96, 0.94, 0.78 )
			f53_arg0.clipFinished( f53_arg0.Label )
			f53_arg0.lockedIcon:completeAnimation()
			f53_arg0.lockedIcon:setAlpha( 0 )
			f53_arg0.clipFinished( f53_arg0.lockedIcon )
			f53_arg0.ProgressBar:completeAnimation()
			f53_arg0.ProgressBar:setAlpha( 1 )
			f53_arg0.clipFinished( f53_arg0.ProgressBar )
		end,
		GainFocus = function ( f54_arg0, f54_arg1 )
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter( 9 )
			local f54_local0 = function ( f55_arg0 )
				f54_arg0.FocusGlow:beginAnimation( 200 )
				f54_arg0.FocusGlow:setAlpha( 0.6 )
				f54_arg0.FocusGlow:registerEventHandler( "interrupted_keyframe", f54_arg0.clipInterrupted )
				f54_arg0.FocusGlow:registerEventHandler( "transition_complete_keyframe", f54_arg0.clipFinished )
			end
			
			f54_arg0.FocusGlow:completeAnimation()
			f54_arg0.FocusGlow:setAlpha( 0 )
			f54_local0( f54_arg0.FocusGlow )
			local f54_local1 = function ( f56_arg0 )
				f54_arg0.FocusBorder:beginAnimation( 200 )
				f54_arg0.FocusBorder:setAlpha( 1 )
				f54_arg0.FocusBorder:registerEventHandler( "interrupted_keyframe", f54_arg0.clipInterrupted )
				f54_arg0.FocusBorder:registerEventHandler( "transition_complete_keyframe", f54_arg0.clipFinished )
			end
			
			f54_arg0.FocusBorder:completeAnimation()
			f54_arg0.FocusBorder:setAlpha( 0 )
			f54_local1( f54_arg0.FocusBorder )
			local f54_local2 = function ( f57_arg0 )
				f54_arg0.SelectorOverlay:beginAnimation( 200 )
				f54_arg0.SelectorOverlay:setAlpha( 0.04 )
				f54_arg0.SelectorOverlay:registerEventHandler( "interrupted_keyframe", f54_arg0.clipInterrupted )
				f54_arg0.SelectorOverlay:registerEventHandler( "transition_complete_keyframe", f54_arg0.clipFinished )
			end
			
			f54_arg0.SelectorOverlay:completeAnimation()
			f54_arg0.SelectorOverlay:setAlpha( 0.01 )
			f54_local2( f54_arg0.SelectorOverlay )
			local f54_local3 = function ( f58_arg0 )
				local f58_local0 = function ( f59_arg0 )
					f59_arg0:beginAnimation( 50 )
					f59_arg0:setLeftRight( 0, 1, -10, 10 )
					f59_arg0:setTopBottom( 0, 1, -10, 10 )
					f59_arg0:setAlpha( 1 )
					f59_arg0:registerEventHandler( "transition_complete_keyframe", f54_arg0.clipFinished )
				end
				
				f54_arg0.FocusBrackets:beginAnimation( 100 )
				f54_arg0.FocusBrackets:setLeftRight( 0, 1, -8, 8 )
				f54_arg0.FocusBrackets:setTopBottom( 0, 1, -8, 8 )
				f54_arg0.FocusBrackets:setAlpha( 0.67 )
				f54_arg0.FocusBrackets:registerEventHandler( "interrupted_keyframe", f54_arg0.clipInterrupted )
				f54_arg0.FocusBrackets:registerEventHandler( "transition_complete_keyframe", f58_local0 )
			end
			
			f54_arg0.FocusBrackets:completeAnimation()
			f54_arg0.FocusBrackets:setLeftRight( 0, 1, -40, 40 )
			f54_arg0.FocusBrackets:setTopBottom( 0, 1, -40, 40 )
			f54_arg0.FocusBrackets:setAlpha( 0 )
			f54_local3( f54_arg0.FocusBrackets )
			f54_arg0.CardIcon:completeAnimation()
			f54_arg0.CardIcon:setAlpha( 0 )
			f54_arg0.clipFinished( f54_arg0.CardIcon )
			f54_arg0.DarkOpsClassifiedIcon:completeAnimation()
			f54_arg0.DarkOpsClassifiedIcon:setAlpha( 1 )
			f54_arg0.clipFinished( f54_arg0.DarkOpsClassifiedIcon )
			f54_arg0.Label:completeAnimation()
			f54_arg0.Label:setRGB( 0.96, 0.94, 0.78 )
			f54_arg0.clipFinished( f54_arg0.Label )
			f54_arg0.lockedIcon:completeAnimation()
			f54_arg0.lockedIcon:setAlpha( 0 )
			f54_arg0.clipFinished( f54_arg0.lockedIcon )
			f54_arg0.ProgressBar:completeAnimation()
			f54_arg0.ProgressBar:setAlpha( 1 )
			f54_arg0.clipFinished( f54_arg0.ProgressBar )
		end,
		LoseFocus = function ( f60_arg0, f60_arg1 )
			f60_arg0:__resetProperties()
			f60_arg0:setupElementClipCounter( 8 )
			local f60_local0 = function ( f61_arg0 )
				f60_arg0.FocusGlow:beginAnimation( 200 )
				f60_arg0.FocusGlow:setAlpha( 0 )
				f60_arg0.FocusGlow:registerEventHandler( "interrupted_keyframe", f60_arg0.clipInterrupted )
				f60_arg0.FocusGlow:registerEventHandler( "transition_complete_keyframe", f60_arg0.clipFinished )
			end
			
			f60_arg0.FocusGlow:completeAnimation()
			f60_arg0.FocusGlow:setAlpha( 0.6 )
			f60_local0( f60_arg0.FocusGlow )
			local f60_local1 = function ( f62_arg0 )
				f60_arg0.FocusBorder:beginAnimation( 200 )
				f60_arg0.FocusBorder:setAlpha( 0 )
				f60_arg0.FocusBorder:registerEventHandler( "interrupted_keyframe", f60_arg0.clipInterrupted )
				f60_arg0.FocusBorder:registerEventHandler( "transition_complete_keyframe", f60_arg0.clipFinished )
			end
			
			f60_arg0.FocusBorder:completeAnimation()
			f60_arg0.FocusBorder:setAlpha( 1 )
			f60_local1( f60_arg0.FocusBorder )
			local f60_local2 = function ( f63_arg0 )
				f60_arg0.SelectorOverlay:beginAnimation( 200 )
				f60_arg0.SelectorOverlay:setAlpha( 0.01 )
				f60_arg0.SelectorOverlay:registerEventHandler( "interrupted_keyframe", f60_arg0.clipInterrupted )
				f60_arg0.SelectorOverlay:registerEventHandler( "transition_complete_keyframe", f60_arg0.clipFinished )
			end
			
			f60_arg0.SelectorOverlay:completeAnimation()
			f60_arg0.SelectorOverlay:setAlpha( 0.04 )
			f60_local2( f60_arg0.SelectorOverlay )
			local f60_local3 = function ( f64_arg0 )
				f60_arg0.FocusBrackets:beginAnimation( 60 )
				f60_arg0.FocusBrackets:setAlpha( 0 )
				f60_arg0.FocusBrackets:registerEventHandler( "interrupted_keyframe", f60_arg0.clipInterrupted )
				f60_arg0.FocusBrackets:registerEventHandler( "transition_complete_keyframe", f60_arg0.clipFinished )
			end
			
			f60_arg0.FocusBrackets:completeAnimation()
			f60_arg0.FocusBrackets:setAlpha( 1 )
			f60_local3( f60_arg0.FocusBrackets )
			f60_arg0.CardIcon:completeAnimation()
			f60_arg0.CardIcon:setAlpha( 0 )
			f60_arg0.clipFinished( f60_arg0.CardIcon )
			f60_arg0.DarkOpsClassifiedIcon:completeAnimation()
			f60_arg0.DarkOpsClassifiedIcon:setAlpha( 1 )
			f60_arg0.clipFinished( f60_arg0.DarkOpsClassifiedIcon )
			f60_arg0.lockedIcon:completeAnimation()
			f60_arg0.lockedIcon:setAlpha( 0 )
			f60_arg0.clipFinished( f60_arg0.lockedIcon )
			f60_arg0.ProgressBar:completeAnimation()
			f60_arg0.ProgressBar:setAlpha( 1 )
			f60_arg0.clipFinished( f60_arg0.ProgressBar )
		end
	}
}

CoD.Shield_WeaponsStyle.__onClose = function ( f65_arg0 )
	f65_arg0.FocusBrackets:close()
	f65_arg0.CardIcon:close()
	f65_arg0.Lines:close()
	f65_arg0.Label:close()
	f65_arg0.lockedIcon:close()
	f65_arg0.TrialWidget:close()
	f65_arg0.ProgressBorder:close()
	f65_arg0.ProgressBar:close()
end