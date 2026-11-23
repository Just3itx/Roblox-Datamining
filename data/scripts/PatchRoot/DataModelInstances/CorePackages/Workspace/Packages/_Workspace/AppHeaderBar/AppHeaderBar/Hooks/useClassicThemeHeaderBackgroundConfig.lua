-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)
local Style = require(scriptParentParentParent.Style)

local UiModeBrandThemeContext = Style.UiModeBrandThemeContext

local _AppHeaderBarClassicThemeBackground = require(script.Parent.Parent.Components.AppHeaderBarClassicThemeBackground)

local FFlagAppNavBarPerItemThemeOverride = require(scriptParentParentParent.SharedFlags).FFlagAppNavBarPerItemThemeOverride

local tbl1 = {
    Classic_light = {
        centerImage = "rbxasset://textures/ui/LuaApp/graphic/starburst_center_classic_light.png",
        gradientColor = Color3.fromHex("#CDECFF")
    },
    Classic_dark = {
        centerImage = "rbxasset://textures/ui/LuaApp/graphic/starburst_center_classic_dark.png",
        gradientColor = Color3.fromHex("#042349")
    }
}

local function useClassicThemeHeaderBackgroundConfig()
    if not FFlagAppNavBarPerItemThemeOverride then
        return nil
    end

    local var1 = React.useContext(Style.AppearanceContext).theme:lower()

    local foundationThemeName = React.useContext(UiModeBrandThemeContext).foundationThemeName

    return tbl1[`{foundationThemeName}_{var1}`]
end

return useClassicThemeHeaderBackgroundConfig
