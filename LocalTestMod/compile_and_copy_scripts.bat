@echo off
setlocal
cd /d "%~dp0"

"C:\Users\Cesar\Documents\Bo4Project\tools\t7custom\DebugCompiler.exe" --compile

if not exist "compiled.gscc" (
    echo ERROR: compiled.gscc not found!
    exit /b 1
)

set MOD=C:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementLocalTestModT8
if not exist "%MOD%" mkdir "%MOD%"

copy /Y "compiled.gscc" "%MOD%\compiled.gscc"
if exist "hashes.txt" copy /Y "hashes.txt" "%MOD%\hashes.txt"
copy /Y "ShieldConfig\project-bo4\mods\EnhancementLocalTestModT8\metadata.json" "%MOD%\metadata.json"

del /Q "compiledclient.omap" 2>nul
del /Q "compiled.omap" 2>nul
del /Q "compiled.cscc" 2>nul
del /Q "compiled.gscc" 2>nul
del /Q "hashes.txt" 2>nul

echo Done: EnhancementLocalTestModT8 installed.
endlocal
