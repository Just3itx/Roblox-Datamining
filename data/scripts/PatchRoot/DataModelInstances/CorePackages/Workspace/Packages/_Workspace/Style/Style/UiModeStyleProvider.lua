-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Style = script:FindFirstAncestor("Style")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local StyleParent = Style.Parent
local Cryo = require(StyleParent.Cryo)
local React = require(StyleParent.React)
local SignalsReact = require(StyleParent.SignalsReact)
local useDeviceType = require(StyleParent.RobloxAppHooks).useDeviceType
local AppearanceContext = require(script.Parent.AppearanceContext)
local SceneOverridesRegistry = require(script.Parent.SceneOverridesRegistry)
local AppStyleProvider = require(StyleParent.UIBlox).App.Style.AppStyleProvider
local Foundation = require(StyleParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local ThemeName = Foundation.Enums.ThemeName
local getUIScale = require(StyleParent.Display).GetDisplayStore(false).getUIScale

local engineFeature = game:DefineFastFlag("LuaAppEnableWindowsHandheldTokenScale", false) and game:GetEngineFeature("EnableDisplaySize")
local bool1 = game:DefineFastFlag("DebugLuaAppEnableTokenScale", false)

local bool2 = engineFeature or bool1
local FFlagAppNavBarPerItemThemeOverride = require(StyleParent.SharedFlags).FFlagAppNavBarPerItemThemeOverride
local UiModeBrandThemeContext = if FFlagAppNavBarPerItemThemeOverride then require(script.Parent.UiModeBrandThemeContext) else nil
local FFlagAppClassicThemeGreenButtonColors = require(script.Parent.FFlagAppClassicThemeGreenButtonColors)

local tbl1 = {
    ["Color.ActionEmphasis.Background.Color3"] = Color3.fromHex("#137F1F"),
    ["Color.ActionSoftEmphasis.Background.Color3"] = Color3.fromHex("#137F1F"),
    ["Color.ActionSoftEmphasis.Foreground.Color3"] = Color3.fromHex("#E2F8E3")
}

local tbl2 = {
    ["Color.ActionEmphasis.Background.Color3"] = Color3.fromHex("#12891D"),
    ["Color.ActionEmphasis.Foreground.Color3"] = Color3.fromHex("#FFFFFF"),
    ["Color.ActionSoftEmphasis.Background.Color3"] = Color3.fromHex("#12891D"),
    ["Color.ActionSoftEmphasis.Foreground.Color3"] = Color3.fromHex("#022708")
}

local tbl3 = {
    dark = ColorMode.Dark,
    light = ColorMode.Light
}

local function useTokenScale() -- Luacid: Inlined by compiler; 1 call site recovered
    return (SignalsReact.useSignalState(getUIScale))
end

local function UiModeStyleProvider(tbl4)
    local var1 = useDeviceType()

    local scale = if bool2 then useTokenScale() else nil

    local var3, var4 = React.useState({
        preferredTransparency = UserGameSettings.PreferredTransparency,
        reducedMotion = UserGameSettings.ReducedMotion,
        preferredTextSize = UserGameSettings.PreferredTextSize
    })

    React.useEffect(function()
        local function updateSettings()
            var4({
                preferredTransparency = UserGameSettings.PreferredTransparency,
                reducedMotion = UserGameSettings.ReducedMotion,
                preferredTextSize = UserGameSettings.PreferredTextSize
            })
        end
        local connection = UserGameSettings:GetPropertyChangedSignal("PreferredTransparency"):Connect(updateSettings)
        local connection2 = UserGameSettings:GetPropertyChangedSignal("ReducedMotion"):Connect(updateSettings)
        local connection3 = UserGameSettings:GetPropertyChangedSignal("PreferredTextSize"):Connect(updateSettings)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
            connection3:Disconnect()
        end
    end, {})

    local style = tbl4.style
    local var2 = React.useMemo(function()
        return Cryo.Dictionary.join(
            {
                deviceType = style.deviceType or var1
            },
            style,
            {
                settings = if bool2 then Cryo.Dictionary.join(var3, { scale = scale }) else var3
            }
        )
    end, {
        style,
        var1,
        var3,
        scale
    })
    local isActive = var2.foundationThemeName ~= nil
    local tokenOverrides = if FFlagAppClassicThemeGreenButtonColors and var2.foundationThemeName == ThemeName.Classic then if tbl3[var2.themeName:lower()] == ColorMode.Light then tbl2 else tbl1 else nil
    return React.createElement(
        FoundationProvider,
        {
            device = var2.deviceType,
            colorMode = tbl3[var2.themeName:lower()],
            themeName = var2.foundationThemeName,
            preferences = var2.settings,
            tokenOverrides = tokenOverrides
        },
        React.createElement(
            SceneOverridesRegistry,
            { isActive = isActive },
            React.createElement(AppStyleProvider, { style = var2 }, tbl4.children)
        )
    )
end

local function ThemeProvider(tbl4)
    local var1, setTheme = React.useState(tbl4.style.themeName)
    if FFlagAppNavBarPerItemThemeOverride and tbl4.syncThemeFromProps then
        var1 = tbl4.style.themeName
    end

    local var3 = table.clone(tbl4)

    var3.style = Cryo.Dictionary.join(
        var3.style,
        {
            themeName = var1,
            foundationThemeName = if tbl4.foundationThemeName then tbl4.foundationThemeName else Cryo.None
        }
    )
    local element = React.createElement(
        AppearanceContext.Provider,
        {
            value = { theme = var1, setTheme = setTheme }
        },
        React.createElement(UiModeStyleProvider, var3)
    )

    if not FFlagAppNavBarPerItemThemeOverride then
        return element
    end

    return React.createElement(
        UiModeBrandThemeContext.Provider,
        {
            value = {
                foundationThemeName = tbl4.foundationThemeName
            }
        },
        element
    )
end
return ThemeProvider
