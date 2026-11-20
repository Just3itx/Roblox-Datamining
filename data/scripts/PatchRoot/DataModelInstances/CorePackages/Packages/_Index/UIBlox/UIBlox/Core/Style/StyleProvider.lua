-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:21:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local Style = scriptParentParentParent.App.Style
local Roact = require(scriptParentParentParent.Parent.Roact)
local t = require(scriptParentParentParent.Parent.t)
local validateStyle = require(Style.Validator.validateStyle)
local StyleContext = require(scriptParent.StyleContext)
local getTextSizeOffset = require(scriptParentParentParent.Utility.getTextSizeOffset)

local _StyleTypes = require(Style.StyleTypes)
local Themes = require(Style.Themes)
local Constants = require(Style.Constants)
local getFontFromName = require(Style.Fonts.getFontFromName)
local Tokens = require(Style.Tokens)

local getTokens = Tokens.getTokens
local getFoundationTokens = Tokens.getFoundationTokens
local Mappers = Tokens.Mappers

local scriptParentParentParentParent = scriptParentParentParent.Parent
local Object = require(scriptParentParentParentParent.LuauPolyfill).Object
local var1 = require(scriptParentParentParentParent.UIBlox.Core.Utility.GetEngineFeatureSafe)("EnablePreferredTextSizeSetting")

local var2 = Roact.Component:extend("StyleProvider")

var2.validateProps = t.strictInterface(
    {
        style = t.optional(validateStyle),
        derivedValues = t.optional(t.table),
        [Roact.Children] = t.table
    }
)

local tbl1 = {
    Theme = Themes.DarkTheme,
    Settings = {
        PreferredTransparency = 1,
        ReducedMotion = false,
        PreferredTextSize = if var1 then Enum.PreferredTextSize.Medium else nil,
        Scale = 1
    }
}

local tbl2 = { textSizeOffset = 0 }

function var2.init(arg1)
    arg1:setState({ style = arg1.props.style, derivedValues = arg1.props.derivedValues })
end

function var2.updateTextSizeOffset(arg1, arg2)
    local var3, textSizeOffset = getTextSizeOffset(arg2)
    if not var3 then
        return
    end

    arg1:setState({ derivedValues = { textSizeOffset = textSizeOffset } })
end

function var2.didUpdate(arg1, _, arg2)
    if arg2.style and arg2.style.Settings.PreferredTextSize ~= arg1.state.style.Settings.PreferredTextSize then
        arg1:updateTextSizeOffset(arg1.state.style.Font.Body.Font)
    end
end

function var2.render(arg1)
    local style = Object.assign({}, tbl1, arg1.state.style)
    local derivedValues = Object.assign({}, tbl2, arg1.state.derivedValues)

    if style.Tokens == nil then
        local var5 = if style.Theme == Themes.LightTheme then Constants.ThemeName.Light else Constants.ThemeName.Dark
        local defaultDeviceType = Constants.DefaultDeviceType
        local scale = style.Settings.Scale

        local tokens = getTokens(defaultDeviceType, var5, scale)
        local foundationTokens = getFoundationTokens(defaultDeviceType, var5, scale)
        local var6 = Mappers.mapColorTokensToFoundation(tokens, foundationTokens)
        style.Theme = Mappers.mapThemeToFoundation(style.Theme, foundationTokens)
        style.Tokens = Mappers.addFoundationFlatKeys(var6, foundationTokens)
    end

    if style.Font == nil then
        style.Font = getFontFromName(Constants.FontName.Gotham, style.Tokens)
    end

    return Roact.createElement(StyleContext.Provider, {
        value = {
            style = style,
            update = function(_, style2)
                if arg1.mounted then
                    arg1:setState({ style = style2 })
                end
            end,
            derivedValues = derivedValues
        }
    }, Roact.oneChild(arg1.props[Roact.Children]))
end

function var2.didMount(arg1)
    arg1.mounted = true
end

function var2.willUnmount(arg1)
    arg1.mounted = false
end

return var2
