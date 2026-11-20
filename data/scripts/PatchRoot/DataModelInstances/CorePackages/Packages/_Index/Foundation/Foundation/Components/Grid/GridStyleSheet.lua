-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local useStyleSheet = require(Foundation.Providers.Style.StyleSheetContext).useStyleSheet
local _Breakpoint = require(Foundation.Enums.Breakpoint)
local createGridStyleRules = require(script.Parent.createGridStyleRules)
local getGridMetrics = require(Foundation.Utility.getGridMetrics)
local useResponsive = require(Foundation.Providers.Responsive.useResponsive)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = { containerWidth = 0 }

return React.memo(function(tbl2) -- name: GridStyleSheet
    local var1 = withDefaults(tbl2, tbl1)
    local ref = React.useRef(nil)
    local var3 = useResponsive()
    local var4 = useStyleSheet()
    local breakpoint = var3.config.breakpoint
    local grid = var3.config.grid

    local var5 = breakpoint.order[#breakpoint.order]
    local column = grid.columns[var5]
    local var6 = var1.breakpoint or var5

    local num1 = math.max(1, var1.containerWidth)

    local var7 = React.useMemo(function()
        return createGridStyleRules(var3.config)
    end, { var3.config })

    local var8 = React.useMemo(function()
        return Dash.join(var7.baseRules, var7.rulesByBreakpoint[var6])
    end, { var7, var6 })

    React.useLayoutEffect(function()
        if not ref.current then
            return
        end

        local column2 = grid.columns[var6]

        for i = 0, column do
            local num2 = math.min(i, column2)
            local gridMetrics = getGridMetrics(var3.config, var6, num1, num2)
            local vector2 = Vector2.new(gridMetrics.cellWidth, 0)
            local vector2_2 = Vector2.new(gridMetrics.cellWidth, math.huge)

            ref.current:SetAttribute("Col" .. i, gridMetrics.cellSize)
            ref.current:SetAttribute("ColMin" .. i, vector2)
            ref.current:SetAttribute("ColMax" .. i, vector2_2)
        end
    end, { var3.config, num1, var6 })

    React.useLayoutEffect(function()
        if ref.current then
            ref.current:SetDerives({ var4 })
        end
    end, { var4 })

    return React.createElement(React.Fragment, nil, {
        GridStyleSheet = React.createElement("StyleSheet", { ref = ref }, var8),
        GridStyleLink = React.createElement("StyleLink", { StyleSheet = ref.current })
    })
end)
