-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:00:36Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local _Breakpoint = require(Foundation.Enums.Breakpoint)
local _BreakpointShortName = require(Foundation.Enums.BreakpointShortName)
local React = require(FoundationParent.React)
local _ResponsiveContext = require(Foundation.Providers.Responsive.ResponsiveContext)
local StyleRule = require(Foundation.StyleSheet.StyleRule)

local function createGridStyleRule(num1: number, arg1)
    local str1 = if arg1 then `.{arg1}-col-{num1}` else `.col-{num1}`
    return React.createElement(StyleRule, {
        Selector = `{str1} ::UISizeConstraint`,
        properties = {
            MinSize = `$ColMin{num1}`,
            MaxSize = `$ColMax{num1}`
        }
    })
end

local function createGridStyleRules(arg1)
    local breakpoint = arg1.breakpoint
    local grid = arg1.grid
    local var1 = breakpoint.order[#breakpoint.order]

    local rulesByBreakpoint = ({})

    local baseRules = ({})

    for i = 0, grid.columns[var1] do
        baseRules[`Col{i}`] = createGridStyleRule(i)

        if i ~= 0 then
            continue
        end

        baseRules.ColVisible0 = React.createElement(StyleRule, { Selector = ".col-0", properties = { Visible = false } })
    end

    for _, value in breakpoint.order do
        local var2 = breakpoint.shortNames[value]

        local tbl3 = ({})

        for i = 0, grid.columns[value] do
            tbl3[`{value}Col{i}`] = createGridStyleRule(i, var2)

            if i ~= 0 then
                continue
            end

            local str1 = `{value}ColVisible0`
            tbl3[str1] = React.createElement(StyleRule, { Selector = `.{var2}-col-0`, properties = { Visible = false } })
        end

        rulesByBreakpoint[value] = tbl3
    end

    return { baseRules = baseRules, rulesByBreakpoint = rulesByBreakpoint }
end

return createGridStyleRules
