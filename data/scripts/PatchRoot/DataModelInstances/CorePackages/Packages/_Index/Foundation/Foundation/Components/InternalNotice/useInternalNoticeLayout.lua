-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Breakpoint = require(Foundation.Enums.Breakpoint)
local BreakpointConfig = require(Foundation.Utility.Responsive.BreakpointConfig)
local _Types = require(Foundation.Components.Types)
local useAbsoluteSize = require(Foundation.Utility.useAbsoluteSize)

local width = BreakpointConfig.widths[Breakpoint.XSmall]

local function useInternalNoticeLayout(func1: ((...any) -> (...any))?)
    local var1, onNoticeAbsoluteSizeChanged = useAbsoluteSize(func1)

    local var3, var4 = React.useState(0)
    local var5 = React.useCallback(function(arg1)
        var4(arg1.AbsoluteSize.X)
    end, {})

    local x, var6 = React.useState(0)
    local onStackedColumnAbsoluteSizeChanged = React.useCallback(function(arg1)
        var6(arg1.AbsoluteSize.X)
    end, {})

    local bool1 = var1.X > 0 and var1.X <= width
    local var8 = var1.X * 0.30000000000000004
    local bool2 = var8 > 0 and var8 < var3
    local isStacked = bool1 or bool2

    if isStacked then
        var5 = nil
    end
    return {
        isStacked = isStacked,
        onNoticeAbsoluteSizeChanged = onNoticeAbsoluteSizeChanged,
        onStackedColumnAbsoluteSizeChanged = onStackedColumnAbsoluteSizeChanged,
        measureInlineLink = var5,
        stackedLinkConstraint = isStacked and x > 0 and {
            MaxSize = Vector2.new(x, math.huge)
        } or nil
    }
end

return useInternalNoticeLayout
