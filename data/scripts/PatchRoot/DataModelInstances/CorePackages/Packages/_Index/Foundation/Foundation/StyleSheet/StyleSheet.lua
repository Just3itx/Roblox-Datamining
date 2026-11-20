-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)
local _Tokens = require(Foundation.Providers.Style.Tokens)
local _Types = require(scriptParent.Rules.Types)
local createStyleSheetRules = require(scriptParent.createStyleSheetRules)
local getOverrideAttributes = require(scriptParent.getOverrideAttributes)
local useGeneratedRules = require(Foundation.Utility.useGeneratedRules)

local _ColorMode = require(Foundation.Enums.ColorMode)
local _Device = require(Foundation.Enums.Device)
local _ThemeName = require(Foundation.Enums.ThemeName)

return React.memo(function(tbl1) -- name: StyleSheet
    local styleSheet, ref = React.useState(nil)
    local var3 = React.useRef({})

    React.useLayoutEffect(function()
        if tbl1.setStyleSheetRef and tbl1.setStyleSheetRef.current then
            tbl1.setStyleSheetRef.current(styleSheet)
        end
    end, { styleSheet })

    local var4 = useGeneratedRules(tbl1.themeName, tbl1.colorMode, tbl1.device)

    local var5 = React.useMemo(function()
        return getOverrideAttributes(tbl1.themeName, tbl1.colorMode, tbl1.device, tbl1.tokenOverrides)
    end, {
        tbl1.themeName,
        tbl1.colorMode,
        tbl1.device,
        tbl1.tokenOverrides
    })

    local var6 = React.useMemo(function()
        if styleSheet then
            return createStyleSheetRules(var4, tbl1.tags, styleSheet, var3.current, tbl1.scale, var5)
        end

        return nil
    end, {
        styleSheet,
        var4,
        tbl1.tags,
        tbl1.scale,
        var5
    })
    return React.createElement(React.Fragment, nil, {
        FoundationStyleSheet = React.createElement("StyleSheet", { ref = ref }, var6),
        FoundationStyleLink = React.createElement("StyleLink", { StyleSheet = styleSheet })
    })
end)
