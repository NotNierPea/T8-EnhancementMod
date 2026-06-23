--[[
      .\hksc.exe '.\Scripts\StartingMovie.Lua' -o 'c:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua\StartingMovie.luac'
]]

------------------------

if CoD.isFrontend or CoD.isMultiplayer or CoD.isWarzone then
	return
end

CoD.InitEnhLuaFile()

------------------------

-- stop movie
if Engine[@"getdvarint"]("shield_enh_MovieDisable") == 1 then
	CoD.HUDUtility.IsMovieShowing = function ( f129_arg0 )
		CoD.EnhModPrintInfo("Called", "IsMovieShowing")
		return false
	end

      CoD.HUDUtility.InitLoadingImageOrMovie = function ( f131_arg0, f131_arg1 )
            local f131_local0 = Engine[@"getcurrentmap"]()
            Engine[@"setdvar"]( "ui_useloadingmovie", 0 )

            local f131_local1 = MapNameToMapLoadingImage( f131_arg1, f131_local0 )

            f131_arg0:setImage( RegisterImage( f131_local1 ) )
            f131_arg0:setRGB( 1, 1, 1 )
      end

      CoD.HUDUtility.StartPlay = function ( f133_arg0, f133_arg1 )
            CoD.EnhModPrintInfo("Called", "StartPlay")
            Engine[@"stop3dcinematic"]()
            Engine[@"setloadingmovieskippedstate"]( true )
      end

      CoD.HUDUtility.InitLoadingMovie = function ( f130_arg0 ) -- main problem, doesn't get override for some reason
            CoD.EnhModPrintInfo("Called", "InitLoadingMovie")
            return 
      end

      Engine[@"stop3dcinematic"]() -- fuck you starting cutscene
      Engine[@"setloadingmovieskippedstate"]( true )
end