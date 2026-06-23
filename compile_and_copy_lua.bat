@echo off
set HKSC=.\hksc.exe
set FRONTEND=.\Lua\Frontend Side
set INGAME=.\Lua\In-Game Side
REM mods only
set OUT=C:\Program Files (x86)\Call of Duty Black Ops 4\project-bo4\mods\EnhancementModT8\Lua

echo [Frontend]
for /r "%FRONTEND%" %%F in (*.Lua) do (
    echo Compiling %%~nxF...
    "%HKSC%" "%%F" -o "%OUT%\Frontend\%%~nF.luac"
    if errorlevel 1 (
        echo [FAIL] %%~nxF
        exit /b 1
    )
)

echo.
echo [In-Game]
for /r "%INGAME%" %%F in (*.Lua) do (
    echo Compiling %%~nxF...
    "%HKSC%" "%%F" -o "%OUT%\Game\%%~nF.luac"
    if errorlevel 1 (
        echo [FAIL] %%~nxF
        exit /b 1
    )
)

echo.
echo All files compiled successfully.