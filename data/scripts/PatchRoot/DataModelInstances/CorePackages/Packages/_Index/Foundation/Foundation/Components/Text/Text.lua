-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local Interactable = require(Foundation.Components.Interactable)

local GuiObjectChildren = require(Foundation.Utility.GuiObjectChildren)
local _Types = require(Foundation.Components.Types)
local indexBindable = require(Foundation.Utility.indexBindable)
local normalizeFontFace = require(Foundation.Utility.normalizeFontFace)
local useDefaultTags = require(Foundation.Utility.useDefaultTags)
local withDefaults = require(Foundation.Utility.withDefaults)
local withGuiObjectProps = require(Foundation.Utility.withGuiObjectProps)

local useStyleTags = require(Foundation.Providers.Style.useStyleTags)

local FontScales = require(script.Parent.FontScales)

local tbl1 = {
    AutoLocalize = false,
    AutoButtonColor = false,
    BorderSizePixel = 0,
    isDisabled = false
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Text
    local var1 = withDefaults(arg1, tbl1)

    local bool1 = var1.onStateChanged ~= nil or var1.onActivated ~= nil or var1.onSecondaryActivated ~= nil

    local str1 = if var1.backgroundStyle == nil then "gui-object-defaults text-defaults text-size-defaults text-color-defaults" else "gui-object-defaults text-defaults text-size-defaults text-color-defaults x-default-transparency"
    if var1.fontStyle and var1.fontStyle.FontSize then
        str1 ..= " x-default-text-size"
    end

    local var2 = useDefaultTags(var1.tag, str1)
    local var3 = useStyleTags(var2)

    local fontFace = React.useMemo(function()
        local font = if var1.fontStyle == nil then nil else var1.fontStyle.Font
        return normalizeFontFace(font)
    end, { var1.fontStyle })

    local y = React.useMemo(function()
        if var1.fontStyle == nil or var1.fontStyle.LineHeight == nil or var1.fontStyle.FontSize == nil or fontFace == nil then
            return 0
        end

        local family = if ReactIs.isBinding(fontFace) then fontFace:getValue().Family else fontFace.Family
        local var5 = FontScales[family]

        if var5 == nil then
            return 0
        end

        return (var1.fontStyle.FontSize / var5 * (var1.fontStyle.LineHeight * var5) - var1.fontStyle.FontSize) / 2
    end, { fontFace, var1.fontStyle })

    if var1.padding == nil and y ~= 0 then
        var1.padding = Vector2.new(0, y)
    end

    local component = if bool1 then "TextButton" else "TextLabel"

    local var5 = withGuiObjectProps
    local tbl2 = {
        AutoButtonColor = if component == "TextButton" then var1.AutoButtonColor else nil,
        FontFace = fontFace,
        LineHeight = if var1.fontStyle == nil then nil else var1.fontStyle.LineHeight,
        OpenTypeFeatures = var1.OpenTypeFeatures,
        RichText = var1.RichText,
        Text = var1.Text,
        TextColor3 = if var1.textStyle then indexBindable(var1.textStyle, "Color3") else nil,
        TextTransparency = if var1.textStyle then indexBindable(var1.textStyle, "Transparency") else nil,
        TextDirection = var1.TextDirection,
        TextScaled = var1.TextScaled,
        TextSize = if var1.fontStyle == nil then nil else var1.fontStyle.FontSize,
        TextTruncate = var1.TextTruncate,
        TextWrapped = var1.TextWrapped,
        TextXAlignment = var1.TextXAlignment,
        TextYAlignment = var1.TextYAlignment,
        ref = ref,
        [React.Tag] = var3
    }
    local var6 = var5(var1, tbl2)
    local var7

    if bool1 then
        var7 = Interactable
        var6.component = component
        var6.onActivated = var1.onActivated
        var6.onSecondaryActivated = var1.onSecondaryActivated
        var6.onStateChanged = var1.onStateChanged
        var6.stateLayer = var1.stateLayer
        var6.isDisabled = var1.isDisabled
        var6.cursor = var1.cursor
    else
        var7 = component
    end

    return React.createElement(var7, var6, GuiObjectChildren(var1))
end))
