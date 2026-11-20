-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local _RbxDesignFoundations = require(FoundationParent.RbxDesignFoundations)

local ColorMode = require(Foundation.Enums.ColorMode)
local DeprecatedTokenUtilities = require(script.DeprecatedTokenUtilities)
local Device = require(Foundation.Enums.Device)
local Flags = require(Foundation.Utility.Flags)
local ThemeName = require(Foundation.Enums.ThemeName)
local TokenProcessingUtilities = require(script.TokenProcessingUtilities)
local _Types = require(Foundation.Components.Types)
local themeGenerators = require(script.themeGenerators)

local function getPlatformScale(console, num1: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if Flags.FoundationDisableTokenScaling then
        return 1
    end

    num1 = math.clamp(if num1 == nil then 1 else num1, 0, math.huge)

    return (if console == Device.Console then 1.5 else 1) * num1
end

local function applyTokenOverrides<T>(arg1: T, tbl1): T
    for value, value2 in tbl1 do
        local var1 = TokenProcessingUtilities.resolveTokenOverride(arg1, value, value2)
        if var1 ~= nil then
            TokenProcessingUtilities.setTokenValue(arg1, value, var1)
        end
    end

    return arg1
end

local function buildTokens(generator: (...any) -> (...any), platformScale: number, tbl1)
    local var1 = generator(platformScale)

    local tbl2 = {
        Color = var1.Color,
        Config = var1.Config,
        DarkMode = var1.DarkMode,
        Ease = var1.Ease,
        LightMode = var1.LightMode,
        Inverse = var1.Inverse,
        Size = var1.Size,
        Padding = var1.Padding,
        Margin = var1.Margin,
        Gap = var1.Gap,
        Gutter = var1.Gutter,
        Radius = var1.Radius,
        Stroke = var1.Stroke,
        LineHeight = var1.LineHeight,
        FontSize = var1.FontSize,
        FontWeight = var1.FontWeight,
        Time = var1.Time,
        Typography = var1.Typography
    }

    if tbl1 then
        applyTokenOverrides(tbl2, tbl1)
    end

    if Flags.FoundationRemoveDeprecatedSemanticTokens then
        tbl2.Semantic = nil
    else
        tbl2.Semantic = DeprecatedTokenUtilities.getDeprecatedSemanticTokens(tbl2, platformScale)
    end

    return tbl2
end

local Dark = ColorMode.Dark
local platformScale = getPlatformScale(Device.Desktop or Device.Desktop, nil)

return {
    getTokens = function(arg1, arg2, num1: number?, tbl1, arg3)
        local platformScale2 = getPlatformScale(arg2 or Device.Desktop, num1)

        local generator = themeGenerators.getGenerator(arg3 or ThemeName.Default, arg1)

        return (buildTokens(generator, platformScale2, tbl1))
    end,
    defaultTokens = buildTokens(themeGenerators.getGenerator(ThemeName.Default, Dark), platformScale, nil)
}
