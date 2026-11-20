-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:00:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local getTextSizeOffset = require(scriptParentParentParent.Utility.getTextSizeOffset)

local scriptParentParentParentParent = scriptParentParentParent.Parent
local Cryo = require(scriptParentParentParentParent.Cryo)
local React = require(scriptParentParentParentParent.React)
local Roact = require(scriptParentParentParentParent.Roact)

local Foundation = require(scriptParentParentParentParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider

local useTokens = Foundation.Hooks.useTokens
local Object = require(scriptParentParentParentParent.LuauPolyfill).Object

local getThemeFromName = require(scriptParent.Themes.getThemeFromName)
local getFontFromName = require(scriptParent.Fonts.getFontFromName)
local Constants = require(scriptParent.Constants)
local _StyleTypes = require(script.Parent.StyleTypes)
local Tokens = require(script.Parent.Tokens)
local StyleContext = require(scriptParentParentParent.Core.Style.StyleContext)
local Logger = require(scriptParentParentParent.Logger)

local getTokens = Tokens.getTokens
local getFoundationTokens = Tokens.getFoundationTokens
local Mappers = Tokens.Mappers
local foundationSurfaceTokensDiffer = require(script.Parent.foundationSurfaceTokensDiffer)

local tbl1 = {
    dark = Foundation.Enums.Theme.Dark,
    light = Foundation.Enums.Theme.Light
}

local tbl2 = {
    themeName = Constants.DefaultThemeName,
    fontName = Constants.DefaultFontName,
    deviceType = Constants.DefaultDeviceType,
    settings = Constants.DefaultSettings
}

local function AppStyleProvider(tbl3)
    local var1 = Object.assign({}, tbl2, tbl3.style)
    local var2, var3 = React.useState(var1.themeName)
    local scale = var1.settings and var1.settings.scale
    local tokens = getTokens(var1.deviceType, var2, scale)
    local textSizeOffset, var5 = React.useState(0)
    local themeFromName = getThemeFromName(var2)
    local var6 = useTokens()
    local bool1 = var6.Config ~= nil

    local foundationTokens = getFoundationTokens(var1.deviceType, var2)
    local var7 = if bool1 then Cryo.Dictionary.join(foundationTokens, var6) else foundationTokens
    local var8 = Mappers.mapColorTokensToFoundation(tokens, var7)

    local theme = Mappers.mapThemeToFoundation(themeFromName, if bool1 then var6 else foundationTokens)

    local var4 = Mappers.addFoundationFlatKeys(var8, if bool1 then var6 else foundationTokens)

    local style = {
        Font = getFontFromName(var1.fontName, var4),
        Theme = theme,
        Tokens = var4,
        Settings = var1.settings
            and {
                PreferredTransparency = var1.settings.preferredTransparency,
                ReducedMotion = var1.settings.reducedMotion,
                PreferredTextSize = var1.settings.preferredTextSize,
                Scale = var1.settings.scale
            }
            or Constants.DefaultSettings
    }

    local var11 = React.useRef(false)
    React.useEffect(function()
        var11.current = true
        var3(var1.themeName)
        return function()
            var11.current = false
        end
    end, { var11, var1.themeName, var3 })

    React.useEffect(function()
        local var12, var13 = getTextSizeOffset(var4.Typography.BodyLarge.Font)
        if var12 then
            var5(var13)
        end
    end, { var1.settings.preferredTextSize })

    local updateTheme = React.useCallback(function(_, arg1)
        if var11.current then
            var3(arg1)
        end
    end, { var11, var3 })

    local themeName = React.useMemo(function()
        if var2:lower() == Constants.ThemeName.Dark:lower() then
            return Constants.ThemeName.Dark
        end

        if var2:lower() == Constants.ThemeName.Light:lower() then
            return Constants.ThemeName.Light
        end

        return Constants.DefaultThemeName
    end, { var2 })

    local element = React.createElement(StyleContext.Provider, {
        value = {
            style = style,
            updateTheme = updateTheme,
            derivedValues = { textSizeOffset = textSizeOffset },
            styleMetadata = {
                ThemeName = themeName,
                HasSurfaceOverrides = if bool1 then foundationSurfaceTokensDiffer(foundationTokens, var6) else false
            }
        }
    }, Roact.oneChild(tbl3.children))

    if bool1 then
        return element
    end

    if _G.ENVIRONMENT ~= "PRODUCTION" and (_G.ENVIRONMENT == "DEVELOPMENT" or _G.__DEV__) then
        local scriptParentParentParent2 = script.Parent.Parent.Parent
        local var14 = scriptParentParentParent2:FindFirstAncestor("Packages") or scriptParentParentParent2:FindFirstAncestor("CorePackages")

        if not (var14
            and var14:FindFirstChild("Dev")
            and var14.Dev:FindFirstChild("JestGlobals")
            and pcall(require, var14.Dev.JestGlobals)) then
            Logger:warning(
                debug.traceback(
                    "FoundationProvider not found. Please ensure that the FoundationProvider is present in the component tree."
                )
            )
        end
    end

    return React.createElement(
        FoundationProvider,
        {
            theme = tbl1[var2:lower()],
            device = var1.deviceType,
            preferences = var1.settings
        },
        element
    )
end

return AppStyleProvider
