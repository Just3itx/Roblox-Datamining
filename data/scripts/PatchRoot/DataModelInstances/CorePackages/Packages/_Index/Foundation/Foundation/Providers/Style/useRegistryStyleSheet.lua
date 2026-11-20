-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local _ColorMode = require(Foundation.Enums.ColorMode)
local _Device = require(Foundation.Enums.Device)
local React = require(FoundationParent.React)
local _ThemeName = require(Foundation.Enums.ThemeName)
local _Tokens = require(Foundation.Providers.Style.Tokens)

local StyleSheetRegistry = require(Foundation.StyleSheet.StyleSheetRegistry)

local function useRegistryStyleSheet(num1: number, num2: number, num3: number, num4: number, num5: number)
    local var1 = React.useRef({})

    local current = React.useMemo(function()
        return StyleSheetRegistry.resolveStyleSheet(num2, num3, num4, num5, num1)
    end, {
        num1,
        num2,
        num3,
        num4,
        num5
    })

    local var3 = React.useRef(current)
    var3.current = current

    local var4 = React.useCallback(function(arg1)
        for _, value in arg1 do
            var1.current[value] = true
        end
        StyleSheetRegistry.addStyleTags(var3.current, arg1)
    end, {})

    React.useLayoutEffect(function()
        local tbl1 = {}
        for value in var1.current do
            table.insert(tbl1, value)
        end
        StyleSheetRegistry.addStyleTags(current, tbl1)

        StyleSheetRegistry.acquireStyleSheet(current)
        return function()
            StyleSheetRegistry.releaseStyleSheet(current)
        end
    end, { current })

    return current, var4
end

return useRegistryStyleSheet
