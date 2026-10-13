@echo off
setlocal

REM Run compiler (serious's compiler)
"C:\Users\Cesar\Documents\Bo4Project\tools\t7custom\DebugCompiler.exe" --compile

REM Check compiled output exists
if not exist "compiled.gsic" (
    echo ERROR: compiled.gsic not found!
    exit /b 1
)

REM gsic file
set DEST="C:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Scripts\Enhancement.gsic"

REM
copy /Y "compiled.gsic" %DEST%

REM csic file
set DEST="C:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Scripts\Enhancement.csic"

REM
copy /Y "compiled.csic" %DEST%

REM hashes.txt generated
set DEST="C:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Data\EnhancementHashes.txt"

REM
copy /Y "hashes.txt" %DEST%

set GAME=C:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4
if not exist "%GAME%\mods\EnhancementModT8\bo3port" mkdir "%GAME%\mods\EnhancementModT8\bo3port"
if not exist "%GAME%\zone" mkdir "%GAME%\zone"
if not exist "%GAME%\zone_mods\EnhancementModT8_FF" mkdir "%GAME%\zone_mods\EnhancementModT8_FF"
copy /Y "ShieldConfig\project-bo4\mods\EnhancementModT8\bo3port\*" "%GAME%\mods\EnhancementModT8\bo3port\" >nul
copy /Y "ShieldConfig\project-bo4\zone\bo3port.ff" "%GAME%\zone\bo3port.ff" >nul
copy /Y "ShieldConfig\project-bo4\zone\bo3port10.ff" "%GAME%\zone\bo3port10.ff" >nul
copy /Y "ShieldConfig\project-bo4\fastfile\EnhancementModT8_FF\config.json" "%GAME%\zone_mods\EnhancementModT8_FF\config.json" >nul

REM Delete intermediate files
del /Q "compiledclient.omap" 2>nul
del /Q "compiled.omap" 2>nul
del /Q "compiled.cscc" 2>nul
del /Q "compiled.gsic" 2>nul
del /Q "compiled.csic" 2>nul
del /Q "hashes.txt" 2>nul

echo Done: Enhancement.gsic, Enhancement.csic, and EnhancementHashes.txt updated and temp files cleaned.
endlocal
