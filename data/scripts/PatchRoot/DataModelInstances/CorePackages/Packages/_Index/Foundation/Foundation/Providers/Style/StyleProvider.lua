-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:01:01Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)

local ColorMode = require(Foundation.Enums.ColorMode)
local Device = require(Foundation.Enums.Device)
local StyleSheetContext = require(scriptParent.StyleSheetContext)
local TagsContext = require(scriptParent.TagsContext)
local TextSizeOffsetContext = require(scriptParent.TextSizeOffsetContext)
local ThemeName = require(Foundation.Enums.ThemeName)
local Tokens = require(scriptParent.Tokens)
local TokensContext = require(scriptParent.TokensContext)
local VariantsContext = require(scriptParent.VariantsContext)
local getTextSizeOffset = require(Foundation.Utility.getTextSizeOffset)
local usePreferences = require(Foundation.Providers.Preferences.usePreferences)
local withDefaults = require(Foundation.Utility.withDefaults)

local getTokens = Tokens.getTokens

local useRegistryStyleSheet = require(scriptParent.useRegistryStyleSheet)

local tbl1 = {
    themeName = ThemeName.Default,
    colorMode = ColorMode.Dark,
    device = Device.Desktop,
    scale = 1
}

local function StyleProvider(tbl2)
    local var1 = withDefaults(
        {
            themeName = tbl2.themeName,
            colorMode = tbl2.colorMode or tbl2.theme,
            device = tbl2.device,
            scale = tbl2.scale
        },
        tbl1
    )
    local value = VariantsContext.useVariantsState()

    local var2 = React.useMemo(function()
        return getTokens(var1.colorMode, var1.device, var1.scale, tbl2.tokenOverrides, var1.themeName)
    end, {
        var1.colorMode,
        var1.device,
        var1.scale,
        tbl2.tokenOverrides,
        var1.themeName
    })

    local preferredTextSize = usePreferences().preferredTextSize

    local var3 = React.useMemo(function()
        return getTextSizeOffset() or 0
    end, { preferredTextSize })

    local var5, var4 = useRegistryStyleSheet(var1.themeName, var1.colorMode, var1.device, var1.scale, tbl2.tokenOverrides)

    return React.createElement(TokensContext.Provider, { value = var2 }, {
        TextSizeOffsetContext = React.createElement(TextSizeOffsetContext.Provider, { value = var3 }, {
            VariantsContext = React.createElement(VariantsContext.Provider, { value = value }, {
                TagsContext = React.createElement(
                    TagsContext.Provider,
                    { value = var4 },
                    React.createElement(StyleSheetContext.Provider, { value = var5 }, tbl2.children)
                ),
                StyleSheet = React.createElement("StyleLink", { StyleSheet = var5 })
            })
        })
    })
end

return StyleProvider
