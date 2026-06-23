--[[
      .\hksc.exe '.\Lua\Frontend Side\Achievements.lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\Achievements.luac'
]]

------------------------

if not CoD.isFrontend then
	return
end

CoD.InitEnhLuaFile()

------------------------

-- achievements
local ShieldAchievements = {
	{
		id = "enh_achv_all_hardcore",
		name = @"shield/enh_achv_all_hardcore",
		desc = @"shield/enh_achv_all_hardcore_desc",
		image = @"loot_ui_icon_stickers_vampire_hunter_01",
		score = 250
	},
	{
		id = "enh_achv_hardcore",
		name = @"shield/enh_achv_hardcore",
		desc = @"shield/enh_achv_hardcore_desc", 
		image = @"loot_ui_icon_stickers_random_22_large",
		score = 75
	},
	{
		id = "enh_achv_hardcore_eleph",
		name = @"shield/enh_achv_hardcore_eleph",
		desc = @"shield/enh_achv_hardcore_eleph_desc",
		image = @"loot_ui_icon_stickers_random_29_large",
		score = 110
	},
	{
		id = "enh_achv_hardcore_ae",
		name = @"shield/enh_achv_hardcore_ae", 
		desc = @"shield/enh_achv_hardcore_ae_desc",
		image = @"loot_ui_icon_stickers_cute_monsters_2_large",
		score = 90
	},
	{
		id = "enh_achv_hardcore_eye",
		name = @"shield/enh_achv_hardcore_eye",
		desc = @"shield/enh_achv_hardcore_eye_desc",
		image = @"loot_ui_icon_stickers_graffitiparts_1",
		score = 125
	},
	{
		id = "enh_achv_hardcore_blood",
		name = @"shield/enh_achv_hardcore_blood",
		desc = @"shield/enh_achv_hardcore_blood_desc",
		image = @"loot_ui_icon_stickers_random_16_large",
		score = 105
	},
	{
		id = "enh_achv_hardcore_tag",
		name = @"shield/enh_achv_hardcore_tag",
		desc = @"shield/enh_achv_hardcore_tag_desc",
		image = @"loot_ui_icon_stickers_graffitiparts_6",
		score = 100
	},
	{
		id = "enh_achv_hardcore_ao",
		name = @"shield/enh_achv_hardcore_ao",
		desc = @"shield/enh_achv_hardcore_ao_desc",
		image = @"loot_ui_icon_stickers_misc_9",
		score = 100
	},
	{
		id = "enh_achv_hardcore_dotn",
		name = @"shield/enh_achv_hardcore_dotn",
		desc = @"shield/enh_achv_hardcore_dotn_desc",
		image = @"loot_ui_icon_stickers_zm_wolf_moon",
		score = 110
	},
	{
		id = "enh_achv_classic_ee",
		name = @"shield/enh_achv_classic_ee",
		desc = @"shield/enh_achv_classic_ee_desc",
		image = @"loot_ui_icon_stickers_misty_01",
		score = 50
	},
	{
		id = "enh_achv_cranked_ee",
		name = @"shield/enh_achv_cranked_ee",
		desc = @"shield/enh_achv_cranked_ee_desc",
		image = @"ui_icon_weapon_charms_pizza",
		score = 65
	},
	{
		id = "enh_achv_classic_round50",
		name = @"shield/enh_achv_classic_round50",
		desc = @"shield/enh_achv_classic_round50_desc",
		image = @"loot_ui_icon_stickers_survival_tools_06",
		score = 35
	},
	{
		id = "enh_achv_classic_round100",
		name = @"shield/enh_achv_classic_round100",
		desc = @"shield/enh_achv_classic_round100_desc",
		image = @"loot_ui_icon_stickers_survival_tools_01",
		score = 70
	},
	{
		id = "enh_achv_many_players",
		name = @"shield/enh_achv_many_players",
		desc = @"shield/enh_achv_many_players_desc",
		image = @"loot_ui_icon_stickers_zsquad_01",
		score = 35
	}
}

Engine[@"exec"](Engine[@"getprimarycontroller"](), 'readjson enh_achv_hardcore "" var1 uint64_t 0 false players/vars.json')
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'readjson enh_achv_hardcore_eleph "" var2 uint64_t 0 false players/vars.json')
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'readjson enh_achv_hardcore_ae "" var3 uint64_t 0 false players/vars.json')
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'readjson enh_achv_hardcore_eye "" var4 uint64_t 0 false players/vars.json')
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'readjson enh_achv_hardcore_blood "" var11 uint64_t 0 false players/vars.json')
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'readjson enh_achv_hardcore_tag "" var12 uint64_t 0 false players/vars.json')
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'readjson enh_achv_hardcore_ao "" var13 uint64_t 0 false players/vars.json')
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'readjson enh_achv_hardcore_dotn "" var14 uint64_t 0 false players/vars.json')
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'readjson enh_achv_classic_ee "" var5 uint64_t 0 false players/vars.json')
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'readjson enh_achv_all_hardcore "" var6 uint64_t 0 false players/vars.json')
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'readjson enh_achv_cranked_ee "" var7 uint64_t 0 false players/vars.json')
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'readjson enh_achv_classic_round50 "" var8 uint64_t 0 false players/vars.json')
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'readjson enh_achv_classic_round100 "" var9 uint64_t 0 false players/vars.json')
Engine[@"exec"](Engine[@"getprimarycontroller"](), 'readjson enh_achv_many_players "" var10 uint64_t 0 false players/vars.json')

------------------------

local function CreateShieldAchv(Name, Desc, Image, IsCompleted, score)
	local AchvsModels = {}

	local AchvsList = {
		name = Name,
		desc = Desc, 
		image = Image,
		score = score or 100,
		maxValue = 1
	}

	AchvsList.progressBarRatio = IsCompleted
	AchvsList.currentValue = IsCompleted
	AchvsList.isCompleted = IsCompleted

	AchvsModels.models = AchvsList

	return AchvsModels
end

local function CalculateAchievementsScore()
	local total = 0
	local completed = 0

	-- Calculate total and completed achievements
	for _, achievement in ipairs(ShieldAchievements) do
		total = total + achievement.score
		if Engine[@"getdvarint"](achievement.id) == 1 then
			completed = completed + achievement.score
		end
	end

	return completed, total
end

------------------------

DataSources.PCAchievement_Shield_Enh = DataSourceHelpers.ListSetup( "PC.Achievement.AchievementList", function ( f7_arg0 )
	CoD.EnhModPrintInfo("PC.Achievement.AchievementList", "PCAchievement_Shield_Enh, Call Shield One's!!")

	local Achvs = {}

	for _, achievement in ipairs(ShieldAchievements) do
		local isCompleted = Engine[@"getdvarint"](achievement.id) == 1
		table.insert(Achvs, CreateShieldAchv(achievement.name, achievement.desc, achievement.image, isCompleted, achievement.score))
	end

	return Achvs
end )

------------------------

-- Mods Background Style
CoD.CommonCenteredPopupAchievements = InheritFrom( LUI.UIElement )
CoD.CommonCenteredPopupAchievements.__defaultWidth = 1920
CoD.CommonCenteredPopupAchievements.__defaultHeight = 1080
CoD.CommonCenteredPopupAchievements.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.CommonCenteredPopupAchievements )
	self.id = "CommonCenteredPopupAchievements"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	
	local BlackfadeBlurB = LUI.UIImage.new( 0, 1, -5, 5, 0, 1, -5, 5 )
	BlackfadeBlurB:setRGB( 0, 0, 0 )
	BlackfadeBlurB:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_E2354BE557C4C7A" ) )
	BlackfadeBlurB:setShaderVector( 0, 0, 0, 0, 0 )
	self:addElement( BlackfadeBlurB )
	self.BlackfadeBlurB = BlackfadeBlurB
	
	local BlackfadeBlurF = LUI.UIImage.new( 0, 1, -5, 5, 0, 1, -5, 5 )
	BlackfadeBlurF:setRGB( 0, 0, 0 )
	BlackfadeBlurF:setAlpha( 0.6 )
	self:addElement( BlackfadeBlurF )
	self.BlackfadeBlurF = BlackfadeBlurF
	
	local CenterBackground = LUI.UIImage.new( 0.5, 0.5, -348 - 500, 348 + 500, 0.5, 0.5, -500, 500 )
	CenterBackground:setRGB( 0.09, 0.09, 0.09 )
	CenterBackground:setAlpha( 0.9 )
	self:addElement( CenterBackground )
	self.CenterBackground = CenterBackground
	
	local CenterTiledBacking = LUI.UIImage.new( 0.5, 0.5, -348 - 500, 348 + 500, 0.5, 0.5, -500, 500 )
	CenterTiledBacking:setAlpha( 0.25 )
	CenterTiledBacking:setImage( RegisterImage( @"hash_634839E8065B1E53" ) )
	CenterTiledBacking:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_16CBE95C250C6D15" ) )
	CenterTiledBacking:setShaderVector( 0, 0, 0, 0, 0 )
	CenterTiledBacking:setupNineSliceShader( 196, 88 )
	self:addElement( CenterTiledBacking )
	self.CenterTiledBacking = CenterTiledBacking
	
	local buttons = CoD.fe_LeftContainer_NOTLobby.new( f1_arg0, f1_arg1, 0.5, 0.5, -312, 336, 0.5, 0.5, 439, 487 )
	--self:addElement( buttons )
	self.buttons = buttons
	
	local featureOverlayButtonMouseOnly = nil
	
	featureOverlayButtonMouseOnly = CoD.featureOverlay_Button.new( f1_arg0, f1_arg1, 0.5, 0.5, -333 + 950, -147 + 950, 0.5, 0.5, 424, 484 )
	featureOverlayButtonMouseOnly.ButtonContainer.Title:setText( Engine[@"hash_4F9F1239CFD921FE"]( @"hash_778D439E1B360368" ) )
	featureOverlayButtonMouseOnly:registerEventHandler( "gain_focus", function ( element, event )
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus( event )
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus( event )
		end
		CoD.Menu.UpdateButtonShownState( element, f1_arg0, f1_arg1, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"] )
		return f2_local0
	end )
	f1_arg0:AddButtonCallbackFunction( featureOverlayButtonMouseOnly, f1_arg1, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function ( element, menu, controller, model )
		GoBack( self, controller )
		return true
	end, function ( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], @"hash_0", nil, "ui_confirm" )
		return false
	end, false )
	self:addElement( featureOverlayButtonMouseOnly )
	self.featureOverlayButtonMouseOnly = featureOverlayButtonMouseOnly
	
	local LayoutBottomBar = LUI.UIImage.new( 0.5, 0.5, -349.5 - 500, 349.5 + 500, 0.5, 0.5, 473, 501 )
	LayoutBottomBar:setZRot( 180 )
	LayoutBottomBar:setImage( RegisterImage( @"hash_87C348C36FF085C" ) )
	self:addElement( LayoutBottomBar )
	self.LayoutBottomBar = LayoutBottomBar
	
	local LayoutTopBar = LUI.UIImage.new( 0.5, 0.5, -349.5 - 500, 349.5 + 500, 0.5, 0.5, -500.5, -472.5 )
	LayoutTopBar:setImage( RegisterImage( @"hash_87C348C36FF085C" ) )
	self:addElement( LayoutTopBar )
	self.LayoutTopBar = LayoutTopBar
	
	local LayoutTopBarStripes = LUI.UIImage.new( 0.5, 0.5, -348 - 500, 348 + 500, 0.5, 0.5, -500.5, -484.5 )
	LayoutTopBarStripes:setImage( RegisterImage( @"hash_6A0F654633E4C64E" ) )
	self:addElement( LayoutTopBarStripes )
	self.LayoutTopBarStripes = LayoutTopBarStripes
	
	local TitleBackgroundBar = LUI.UIImage.new( 0.5, 0.5, -336.5, 336.5, 0.5, 0.5, -472, -444 )
	TitleBackgroundBar:setRGB( 0.25, 0.24, 0.22 )
	TitleBackgroundBar:setAlpha( 0.88 )
	self:addElement( TitleBackgroundBar )
	self.TitleBackgroundBar = TitleBackgroundBar
	
	local TitleTiledBacking = LUI.UIImage.new( 0.5, 0.5, -336.5, 336.5, 0.5, 0.5, -472, -444 )
	TitleTiledBacking:setAlpha( 0.5 )
	TitleTiledBacking:setImage( RegisterImage( @"hash_634839E8065B1E53" ) )
	TitleTiledBacking:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_16CBE95C250C6D15" ) )
	TitleTiledBacking:setShaderVector( 0, 0, 0, 0, 0 )
	TitleTiledBacking:setupNineSliceShader( 196, 88 )
	self:addElement( TitleTiledBacking )
	self.TitleTiledBacking = TitleTiledBacking
	
	local TitleText = LUI.UIText.new( 0.5, 0.5, -279.5, 279.5, 0.5, 0.5, -469, -445 )
	TitleText:setRGB( ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b )
	TitleText:setAlpha( 0.6 )
	TitleText:setText( "" )
	TitleText:setTTF( "ttmussels_regular" )
	TitleText:setLetterSpacing( 4 )
	TitleText:setAlignment( Enum[@"hash_67A5123B654282D2"][@"hash_1FEEB12BCB0D7041"] )
	TitleText:setAlignment( Enum[@"hash_67A5123B654282D2"][@"hash_3F41D595A2B0EDF3"] )
	self:addElement( TitleText )
	self.TitleText = TitleText
	
	local TitleLayoutElementL = LUI.UIImage.new( 0.5, 0.5, -331, -315, 0.5, 0.5, -465, -449 )
	TitleLayoutElementL:setRGB( ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b )
	TitleLayoutElementL:setZRot( 90 )
	TitleLayoutElementL:setImage( RegisterImage( @"hash_634B575F15CDD376" ) )
	TitleLayoutElementL:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_F755127C95CF5B6" ) )
	TitleLayoutElementL:setShaderVector( 0, 3, 0, 0, 0 )
	self:addElement( TitleLayoutElementL )
	self.TitleLayoutElementL = TitleLayoutElementL
	
	local TitleLayoutElementR = LUI.UIImage.new( 0.5, 0.5, 313, 329, 0.5, 0.5, -464, -448 )
	TitleLayoutElementR:setRGB( ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b )
	TitleLayoutElementR:setImage( RegisterImage( @"hash_634B575F15CDD376" ) )
	TitleLayoutElementR:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_F755127C95CF5B6" ) )
	TitleLayoutElementR:setShaderVector( 0, 3, 0, 0, 0 )
	self:addElement( TitleLayoutElementR )
	self.TitleLayoutElementR = TitleLayoutElementR
	
	local HeaderBackground = LUI.UIImage.new( 0.5, 0.5, -336.5 - 500, 336.5 + 500, 0.5, 0.5, -423, -231 )
	HeaderBackground:setRGB( 0.23, 0.23, 0.23 )
	HeaderBackground:setAlpha( 0.25 )
	self:addElement( HeaderBackground )
	self.HeaderBackground = HeaderBackground
	
	local HeaderTopBar = LUI.UIImage.new( 0.5, 0.5, -5, -1, 0.5, 0.5, -767, -90 )
	HeaderTopBar:setAlpha( 0.09 )
	HeaderTopBar:setZRot( 90 )
	HeaderTopBar:setImage( RegisterImage( @"hash_C49B0C8991A541F" ) )
	HeaderTopBar:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_67C9C02F608D0A75" ) )
	HeaderTopBar:setShaderVector( 0, 0, 0, 0, 0 )
	HeaderTopBar:setupNineSliceShader( 4, 8 )
	self:addElement( HeaderTopBar )
	self.HeaderTopBar = HeaderTopBar
	
	local HeaderBottomBar = LUI.UIImage.new( 0.5, 0.5, -5, -1, 0.5, 0.5, -566, 111 )
	HeaderBottomBar:setAlpha( 0.09 )
	HeaderBottomBar:setZRot( 90 )
	HeaderBottomBar:setImage( RegisterImage( @"hash_C49B0C8991A541F" ) )
	HeaderBottomBar:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_67C9C02F608D0A75" ) )
	HeaderBottomBar:setShaderVector( 0, 0, 0, 0, 0 )
	HeaderBottomBar:setupNineSliceShader( 4, 8 )
	self:addElement( HeaderBottomBar )
	self.HeaderBottomBar = HeaderBottomBar
	
	local BTNQuit = nil
	
	BTNQuit = CoD.PC_SmallCloseButton.new( f1_arg0, f1_arg1, 0.5, 0.5, 302, 336, 0.5, 0.5, -475, -441 )
	BTNQuit:setScale( 0.8, 0.8 )
	BTNQuit:registerEventHandler( "gain_focus", function ( element, event )
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus( event )
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus( event )
		end
		CoD.Menu.UpdateButtonShownState( element, f1_arg0, f1_arg1, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"] )
		return f5_local0
	end )
	f1_arg0:AddButtonCallbackFunction( BTNQuit, f1_arg1, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], "ui_confirm", function ( element, menu, controller, model )
		GoBack( self, controller )
		return true
	end, function ( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum[@"hash_3DD78803F918E9D"][@"hash_3755DA1E2E7C263F"], @"hash_0", nil, "ui_confirm" )
		return false
	end, false )
	self:addElement( BTNQuit )
	self.BTNQuit = BTNQuit
	
	--if CoD.isPC then
		buttons.id = "buttons"
	--end
	--if CoD.isPC then
		featureOverlayButtonMouseOnly.id = "featureOverlayButtonMouseOnly"
	--end
	--if CoD.isPC then
		BTNQuit.id = "BTNQuit"
	--end
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.CommonCenteredPopupAchievements.__onClose = function ( f8_arg0 )
	f8_arg0.buttons:close()
	f8_arg0.featureOverlayButtonMouseOnly:close()
	f8_arg0.BTNQuit:close()
end

CoD.PC_Achievements_TotalPoints_CircularProgress_Enh = InheritFrom( LUI.UIElement )
CoD.PC_Achievements_TotalPoints_CircularProgress_Enh.__defaultWidth = 28
CoD.PC_Achievements_TotalPoints_CircularProgress_Enh.__defaultHeight = 28
CoD.PC_Achievements_TotalPoints_CircularProgress_Enh.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.PC_Achievements_TotalPoints_CircularProgress_Enh )
	self.id = "PC_Achievements_TotalPoints_CircularProgress_Enh"
	self.soundSet = "default"
	
	local TotalProgressRing = LUI.UIImage.new( 0.5, 0.5, -14, 14, 0.5, 0.5, -14, 14 )
	TotalProgressRing:setRGB( 0.71, 0.71, 0 )
	TotalProgressRing:setImage( RegisterImage( @"uie_ui_icon_controller_radial_fill_hud" ) )
	TotalProgressRing:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_clock_normal" ) )
	TotalProgressRing:setShaderVector( 1, 0.5, 0, 0, 0 )
	TotalProgressRing:setShaderVector( 2, 0.5, 0, 0, 0 )
	TotalProgressRing:setShaderVector( 3, 0, 1, 0, 0 )
	TotalProgressRing:setShaderVector( 4, 0, 0, 0, 0 )
	TotalProgressRing:subscribeToGlobalModel( f1_arg1, "PCTotalAchievementsScore", "progress", function ( model )
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			local currentScore, totalScore = CalculateAchievementsScore()

			local calc_score = currentScore / totalScore

			TotalProgressRing:setShaderVector( 0, calc_score, 0, 0, 0)
		end
	end )
	self:addElement( TotalProgressRing )
	self.TotalProgressRing = TotalProgressRing
	
	local TotalProgressRingBG = LUI.UIImage.new( 0.5, 0.5, -14, 14, 0.5, 0.5, -14, 14 )
	TotalProgressRingBG:setAlpha( 0.03 )
	TotalProgressRingBG:setImage( RegisterImage( @"uie_ui_icon_controller_radial_fill_hud" ) )
	self:addElement( TotalProgressRingBG )
	self.TotalProgressRingBG = TotalProgressRingBG
	
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.PC_Achievements_TotalPoints_CircularProgress_Enh.__onClose = function ( f3_arg0 )
	f3_arg0.TotalProgressRing:close()
end

CoD.PC_Achievements_TotalPoints_Enh = InheritFrom( LUI.UIElement )
CoD.PC_Achievements_TotalPoints_Enh.__defaultWidth = 339
CoD.PC_Achievements_TotalPoints_Enh.__defaultHeight = 29
CoD.PC_Achievements_TotalPoints_Enh.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIHorizontalList.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 7, false )
	self:setAlignment( LUI.Alignment.Right )
	self:setClass( CoD.PC_Achievements_TotalPoints_Enh )
	self.id = "PC_Achievements_TotalPoints_Enh"
	self.soundSet = "default"
	
	local TotalPoints = LUI.UIText.new( 0.5, 0.5, 9.5, 169.5, 0.5, 0.5, -7, 12 )
	TotalPoints:setRGB( 0.8, 0.8, 0.8 )
	TotalPoints:setAlpha( 0.35 )
	TotalPoints:setText( LocalizeToUpperString( @"hash_10A3BAB954D979BB" ) )
	TotalPoints:setTTF( "ttmussels_regular" )
	TotalPoints:setLetterSpacing( 6 )
	TotalPoints:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	self:addElement( TotalPoints )
	self.TotalPoints = TotalPoints
	
	local Spacer2 = CoD.VerticalListSpacer.new( f1_arg0, f1_arg1, 0, 0, 167, 172, 0.5, 0.5, -14.5, 14.5 )
	self:addElement( Spacer2 )
	self.Spacer2 = Spacer2
	
	local CurrentProgressValue = LUI.UIText.new( 0.5, 0.5, -59.5, -9.5, 0.5, 0.5, -11, 13 )
	CurrentProgressValue:setRGB( 0.71, 0.68, 0.65 )
	CurrentProgressValue:setTTF( "ttmussels_demibold" )
	CurrentProgressValue:setLetterSpacing( 3 )
	CurrentProgressValue:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	CurrentProgressValue:subscribeToGlobalModel( f1_arg1, "PCTotalAchievementsScore", "score", function ( model )
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			local currentScore, _ = CalculateAchievementsScore()

			CurrentProgressValue:setText( currentScore )
		end
	end )
	self:addElement( CurrentProgressValue )
	self.CurrentProgressValue = CurrentProgressValue
	
	local Slash = LUI.UIText.new( 0.5, 0.5, -76.5, -66.5, 0.5, 0.5, -12, 13 )
	Slash:setRGB( 0.69, 0.67, 0.62 )
	Slash:setText( CoD.BaseUtility.AlreadyLocalized( "/" ) )
	Slash:setTTF( "ttmussels_regular" )
	Slash:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	self:addElement( Slash )
	self.Slash = Slash
	
	local TotalProgressValue = LUI.UIText.new( 0.5, 0.5, -133.5, -83.5, 0.5, 0.5, -11, 14 )
	TotalProgressValue:setRGB( 0.69, 0.67, 0.62 )
	TotalProgressValue:setTTF( "ttmussels_regular" )
	TotalProgressValue:setLetterSpacing( 2 )
	TotalProgressValue:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	TotalProgressValue:subscribeToGlobalModel( f1_arg1, "PCTotalAchievementsScore", "maxScore", function ( model )
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			local _, totalScore = CalculateAchievementsScore()
			TotalProgressValue:setText( totalScore )
		end
	end )
	self:addElement( TotalProgressValue )
	self.TotalProgressValue = TotalProgressValue
	
	local Spacer = CoD.VerticalListSpacer.new( f1_arg0, f1_arg1, 0, 0, 24, 29, 0.5, 0.5, -14.5, 14.5 )
	self:addElement( Spacer )
	self.Spacer = Spacer
	
	local CircularProgress = CoD.PC_Achievements_TotalPoints_CircularProgress_Enh.new( f1_arg0, f1_arg1, 0, 0, -11, 17, 0.5, 0.5, -14, 14 )
	self:addElement( CircularProgress )
	self.CircularProgress = CircularProgress
	
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end

CoD.PC_Achievements_TotalPoints_Enh.__onClose = function ( f4_arg0 )
	f4_arg0.Spacer2:close()
	f4_arg0.CurrentProgressValue:close()
	f4_arg0.TotalProgressValue:close()
	f4_arg0.Spacer:close()
	f4_arg0.CircularProgress:close()
end

CoD.PC_Achievements_Shield_Enh = InheritFrom( LUI.UIElement )
CoD.PC_Achievements_Shield_Enh.__defaultWidth = 1920
CoD.PC_Achievements_Shield_Enh.__defaultHeight = 780
CoD.PC_Achievements_Shield_Enh.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.PC_Achievements_Shield_Enh )
	self.id = "PC_Achievements_Shield_Enh"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local Backer = LUI.UIImage.new( 0, 1, 0, 0, 0, 1, 0, 0 )
	Backer:setRGB( 0.67, 0.67, 0.67 )
	Backer:setAlpha( 0.02 )
	--self:addElement( Backer )
	self.Backer = Backer
	
	local Border = LUI.UIImage.new( 0, 1, -72, 72, 0.5, 0.5, -360, 360 )
	Border:setRGB( 0.8, 0.76, 0.7 )
	Border:setAlpha( 0.03 )
	Border:setImage( RegisterImage( @"hash_6F1E3082B39E99BB" ) )
	Border:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_744484DDFAF5C093" ) )
	Border:setShaderVector( 0, 0, 0, 0, 0 )
	Border:setupNineSliceShader( 6, 6 )
	--self:addElement( Border )
	self.Border = Border
	
	local AchievementList = CoD.PC_VScrollList.new( f1_arg0, f1_arg1, 0.5, 0.5, -862, 158, 0.5, 0.5, -360, 460 )
	AchievementList:mergeStateConditions( {
		{
			stateName = "ClipToList",
			condition = function ( menu, element, event )
				return AlwaysTrue()
			end
		}
	} )
	AchievementList.ScrollView.View:setWidgetType( CoD.PC_Achievement )
	AchievementList.ScrollView.View:setVerticalCount( 102 )
	AchievementList.ScrollView.View:setSpacing( -12 )
	AchievementList.ScrollView.View:setDataSource( "PCAchievement_Shield_Enh" )
	LUI.OverrideFunction_CallOriginalFirst( AchievementList, "setModel", function ( element, controller )
		CoD.PCAchievementsUtility.PrepareAchievementProgressBar( f1_arg1, controller, self.DetailView )
	end )
	self:addElement( AchievementList )
	self.AchievementList = AchievementList
	
	local DetailView = CoD.PC_AchievementDetailView.new( f1_arg0, f1_arg1, 0.5, 0.5, 217, 705, 0.5, 0.5, -316.5, 316.5 )
	DetailView:mergeStateConditions( {
		{
			stateName = "Completed",
			condition = function ( menu, element, event )
				return CoD.PCAchievementsUtility.IsAchievementCompleted( self.AchievementList, f1_arg1 )
			end
		}
	} )
	DetailView:linkToElementModel( DetailView, "refreshWidget", true, function ( model )
		f1_arg0:updateElementState( DetailView, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget"
		} )
	end )
	DetailView:appendEventHandler( "<datasourceChange>PCAchievement_Shield", function ( f6_arg0, f6_arg1 )
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState( DetailView, f6_arg1 )
	end )
	self:addElement( DetailView )
	self.DetailView = DetailView
	
	local TotalPoints = CoD.PC_Achievements_TotalPoints_Enh.new( f1_arg0, f1_arg1, 0.5, 0.5, 365 - 50, 704 - 50, 0, 0, 790, 819 )
	self:addElement( TotalPoints )
	self.TotalPoints = TotalPoints
	
	DetailView:linkToElementModel( AchievementList.ScrollView.View, nil, false, function ( model )
		DetailView:setModel( model, f1_arg1 )
	end )
	DetailView:linkToElementModel( AchievementList.ScrollView.View, "progressBarRatio", true, function ( model )
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			DetailView.ProgressBar.ProgressBarFiller:setShaderVector( 0, CoD.GetVectorComponentFromString( f8_local0, 1 ), CoD.GetVectorComponentFromString( f8_local0, 2 ), CoD.GetVectorComponentFromString( f8_local0, 3 ), CoD.GetVectorComponentFromString( f8_local0, 4 ) )
		end
	end )
	DetailView:linkToElementModel( AchievementList.ScrollView.View, "currentValue", true, function ( model )
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			DetailView.CurrentProgressValue:setText( f9_local0 )
		end
	end )
	DetailView:linkToElementModel( AchievementList.ScrollView.View, "maxValue", true, function ( model )
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			DetailView.TotalProgressValue:setText( f10_local0 )
		end
	end )
	DetailView:linkToElementModel( AchievementList.ScrollView.View, "image", true, function ( model )
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			DetailView.AchievementIcon:setImage( RegisterImage( f11_local0 ) )
		end
	end )
	DetailView:linkToElementModel( AchievementList.ScrollView.View, "name", true, function ( model )
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			DetailView.Description.Name:setText( LocalizeToUpperString( f12_local0 ) )
		end
	end )
	DetailView:linkToElementModel( AchievementList.ScrollView.View, "desc", true, function ( model )
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			DetailView.Description.Description:setText( Engine[@"hash_4F9F1239CFD921FE"]( f13_local0 ) )
		end
	end )
	DetailView:linkToElementModel( AchievementList.ScrollView.View, "score", true, function ( model )
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			DetailView.Points.ScoreValue:setText( f14_local0 )
		end
	end )
	AchievementList.id = "AchievementList"
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end

	self.__defaultFocus = AchievementList.ScrollView.View
	
	local f1_local6 = self
	SizeToWidthOfScreen( Backer, f1_arg1 )
	SizeToWidthOfScreen( Border, f1_arg1 )
	CoD.PCWidgetUtility.SetMouseWheelScrollUnit( AchievementList, 75 )
	return self
end

CoD.PC_Achievements_Shield_Enh.__resetProperties = function ( f15_arg0 )
	f15_arg0.AchievementList:completeAnimation()
	f15_arg0.DetailView:completeAnimation()
	f15_arg0.TotalPoints:completeAnimation()
	f15_arg0.AchievementList:setAlpha( 1 )
	f15_arg0.DetailView:setAlpha( 1 )
	f15_arg0.TotalPoints:setAlpha( 1 )
end

CoD.PC_Achievements_Shield_Enh.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f16_arg0, f16_arg1 )
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter( 3 )
			local f16_local0 = function ( f17_arg0 )
				local f17_local0 = function ( f18_arg0 )
					f18_arg0:beginAnimation( 150, Enum[@"hash_1F50FFF429AB1890"][@"hash_15193EA7825DC097"] )
					f18_arg0:setAlpha( 1 )
					f18_arg0:registerEventHandler( "transition_complete_keyframe", f16_arg0.clipFinished )
				end
				
				f16_arg0.AchievementList:beginAnimation( 50 )
				f16_arg0.AchievementList:registerEventHandler( "interrupted_keyframe", f16_arg0.clipInterrupted )
				f16_arg0.AchievementList:registerEventHandler( "transition_complete_keyframe", f17_local0 )
			end
			
			f16_arg0.AchievementList:completeAnimation()
			f16_arg0.AchievementList:setAlpha( 0 )
			f16_local0( f16_arg0.AchievementList )
			local f16_local1 = function ( f19_arg0 )
				local f19_local0 = function ( f20_arg0 )
					f20_arg0:beginAnimation( 149, Enum[@"hash_1F50FFF429AB1890"][@"hash_15193EA7825DC097"] )
					f20_arg0:setAlpha( 1 )
					f20_arg0:registerEventHandler( "transition_complete_keyframe", f16_arg0.clipFinished )
				end
				
				f16_arg0.DetailView:beginAnimation( 300 )
				f16_arg0.DetailView:registerEventHandler( "interrupted_keyframe", f16_arg0.clipInterrupted )
				f16_arg0.DetailView:registerEventHandler( "transition_complete_keyframe", f19_local0 )
			end
			
			f16_arg0.DetailView:completeAnimation()
			f16_arg0.DetailView:setAlpha( 0 )
			f16_local1( f16_arg0.DetailView )
			local f16_local2 = function ( f21_arg0 )
				local f21_local0 = function ( f22_arg0 )
					f22_arg0:beginAnimation( 139, Enum[@"hash_1F50FFF429AB1890"][@"hash_15193EA7825DC097"] )
					f22_arg0:setAlpha( 1 )
					f22_arg0:registerEventHandler( "transition_complete_keyframe", f16_arg0.clipFinished )
				end
				
				f16_arg0.TotalPoints:beginAnimation( 500 )
				f16_arg0.TotalPoints:registerEventHandler( "interrupted_keyframe", f16_arg0.clipInterrupted )
				f16_arg0.TotalPoints:registerEventHandler( "transition_complete_keyframe", f21_local0 )
			end
			
			f16_arg0.TotalPoints:completeAnimation()
			f16_arg0.TotalPoints:setAlpha( 0 )
			f16_local2( f16_arg0.TotalPoints )
		end
	}
}

CoD.PC_Achievements_Shield_Enh.__onClose = function ( f23_arg0 )
	f23_arg0.DetailView:close()
	f23_arg0.Backer:close()
	f23_arg0.Border:close()
	f23_arg0.AchievementList:close()
	f23_arg0.TotalPoints:close()
end

CoD.Shield_Enh_AchievementsMenu = InheritFrom( CoD.Menu )
LUI.createMenu.Shield_Enh_AchievementsMenu = function ( f1_arg0, f1_arg1 )
	local self = CoD.Menu.NewForUIEditor( "Shield_Enh_AchievementsMenu", f1_arg0 )
	local f1_local1 = self
	self:setClass( CoD.Shield_Enh_AchievementsMenu )
	self.soundSet = "none"
	self:setOwner( f1_arg0 )
	self:setLeftRight( 0, 1, 0, 0 )
	self:setTopBottom( 0, 1, 0, 0 )
	self:playSound( "menu_open", f1_arg0 )
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList( self )
	
	local CommomCenteredPopup = CoD.CommonCenteredPopupAchievements.new( f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0 )
	CommomCenteredPopup.TitleText:setText("Achievements Menu")
	CommomCenteredPopup.HeaderBackground:setAlpha( 0 )
	CommomCenteredPopup.HeaderTopBar:setAlpha( 0 )
	CommomCenteredPopup.HeaderBottomBar:setAlpha( 0 )
	self:addElement( CommomCenteredPopup )
	self.CommomCenteredPopup = CommomCenteredPopup

	local PC_Achievements_Shield_Enh = CoD.PC_Achievements_Shield_Enh.new( f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0 )
	self:addElement( PC_Achievements_Shield_Enh )
	self.PC_Achievements_Shield_Enh = PC_Achievements_Shield_Enh

	self:appendEventHandler( "input_source_changed", function ( f9_arg0, f9_arg1 )
		f9_arg1.menu = f9_arg1.menu or f1_local1
		f1_local1:updateElementState( self, f9_arg1 )
	end )
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"]( f1_arg0 )
	f1_local7( f1_local6, f1_local8.LastInput, function ( f10_arg0 )
		f1_local1:updateElementState( self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "LastInput"
		} )
	end, false )
	f1_local1:AddButtonCallbackFunction( self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function ( element, menu, controller, model )
		GoBack( self, controller )
		ClearMenuSavedState( menu )
		ForceNotifyGlobalModel( controller, "GametypeSettings.Update" )
		return true
	end, function ( element, menu, controller )
		CoD.Menu.SetButtonLabel( menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil )
		return true
	end, false )
	CommomCenteredPopup.buttons:setModel( self.buttonModel, f1_arg0 )
	if CoD.isPC then
		CommomCenteredPopup.id = "CommomCenteredPopup"
	end
	self:processEvent( {
		name = "menu_loaded",
		controller = f1_arg0
	} )

	if CoD.isPC and (IsKeyboard( f1_arg0 ) or self.ignoreCursor) then
		self:restoreState( f1_arg0 )
	end
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg0 )
	end
	
	f1_local7 = self
	--MenuHidesFreeCursor( f1_local1, f1_arg0 )

	self.__defaultFocus = CommomCenteredPopup.featureOverlayButtonMouseOnly
	return self
end

CoD.Shield_Enh_AchievementsMenu.__resetProperties = function ( f13_arg0 )

end

CoD.Shield_Enh_AchievementsMenu.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f14_arg0, f14_arg1 )
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter( 0 )
		end
	},
}

CoD.Shield_Enh_AchievementsMenu.__onClose = function ( f16_arg0 )
	f16_arg0.CommomCenteredPopup:close()
	f16_arg0.PC_Achievements_Shield_Enh:close()
end
