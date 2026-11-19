-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:00:41Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local useForwardRef = require(FoundationParent.ReactUtils).useForwardRef
local StyleRule = require(Foundation.StyleSheet.StyleRule)
local useStyleSheet = require(Foundation.Providers.Style.StyleSheetContext).useStyleSheet
local _Breakpoint = require(Foundation.Enums.Breakpoint)
local _BreakpointShortName = require(Foundation.Enums.BreakpointShortName)
local useResponsive = require(Foundation.Providers.Responsive.useResponsive)

return React.memo(React.forwardRef(function(tbl1, arg1) -- name: GridDebugStyleSheet
    local var1 = useResponsive()
    local var2 = useStyleSheet()
    local styleSheet, var4 = React.useState(nil)
    local ref = useForwardRef(arg1, var4)

    local breakpoint = var1.config.breakpoint
    local grid = var1.config.grid

    local var6 = breakpoint.order[#breakpoint.order]
    local var7 = tbl1.breakpoint or var6

    local var8 = React.useMemo(function()
        local var8 = breakpoint.shortNames[var7]
        local column = grid.columns[var7]
        local result = ({})

        for i = 0, column do
            local selector = if var8 then `.{var8}-col-{i}` else `.col-{i}`
            local str2 = `DebugColColor${i}`
            result[str2] = React.createElement(StyleRule, {
                Selector = selector,
                properties = {
                    BackgroundColor3 = Color3.fromRGB(
                        math.floor(i / math.max(1, column) * 255),
                        math.floor((1 - i / math.max(1, column)) * 255),
                        math.floor(i % 3 / 2 * 255)
                    )
                }
            })
        end

        return result
    end, { var7, breakpoint, grid })

    React.useLayoutEffect(function()
        if styleSheet then
            styleSheet:SetDerives({ var2 })
        end
    end, { styleSheet, var2 })

    return React.createElement(React.Fragment, nil, {
        GridDebugStyleSheet = React.createElement("StyleSheet", { ref = ref }, var8),
        GridDebugStyleLink = React.createElement("StyleLink", { StyleSheet = styleSheet })
    })
end))
