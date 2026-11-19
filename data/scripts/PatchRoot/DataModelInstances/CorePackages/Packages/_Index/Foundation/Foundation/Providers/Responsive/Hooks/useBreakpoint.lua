-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:51:24Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)
local usePrevious = require(FoundationParent.ReactUtils).usePrevious
local Instance = require(Foundation.Utility.Wrappers).Instance

local _Breakpoint = require(Foundation.Enums.Breakpoint)
local Constants = require(Foundation.Constants)
local _ResponsiveContext = require(Foundation.Providers.Responsive.ResponsiveContext)
local useResponsive = require(Foundation.Providers.Responsive.useResponsive)
local withDefaults = require(Foundation.Utility.withDefaults)

local function calculateBreakpointFromWidth(breakpoint, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = breakpoint.order[#breakpoint.order]

    for _, value in breakpoint.order do
        if num1 <= breakpoint.widths[value] then
            return value
        end
    end

    return var1
end

local function getBreakpointIndex(breakpoint, arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    return Dash.findIndex(breakpoint.order, function(arg2): boolean
        return arg2 == arg1
    end)
end

local function shouldChangeBreakpoint(breakpoint, num1: number, breakpointFromWidth, arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not arg1
        or not (breakpointFromWidth == arg1)
            and (if getBreakpointIndex(breakpoint, arg1) < getBreakpointIndex(breakpoint, breakpointFromWidth) then breakpoint.widths[arg1] + 5 < num1 else num1 < breakpoint.widths[breakpointFromWidth] - 5)
end

local function useBreakpoint(arg1, tbl1)
    local var1 = withDefaults(tbl1 or {}, { throttleTime = Constants.DEFAULT_DELAY_TIME })

    local breakpoint = useResponsive().config.breakpoint

    local var2, var3 = React.useState(Vector2.zero)
    local breakpointFromWidth = calculateBreakpointFromWidth(breakpoint, var2.X)

    local var4, var5 = React.useState(breakpointFromWidth)
    local var6 = usePrevious(var4)

    local var7 = React.useMemo(function()
        return Dash.throttle(var3, var1.throttleTime, { leading = true, trailing = true })
    end, { var1.throttleTime })

    React.useEffect(function()
        local connection = nil

        if arg1 then
            connection = Instance.GetPropertyChangedSignal(arg1, "AbsoluteSize"):Connect(function()
                var7(arg1.AbsoluteSize)
            end)
            var3(arg1.AbsoluteSize)
        end

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { arg1 })

    React.useEffect(function()
        if shouldChangeBreakpoint(breakpoint, var2.X, breakpointFromWidth, var6) then
            var5(breakpointFromWidth)
        end
    end, {
        breakpoint,
        var2.X,
        breakpointFromWidth,
        var6
    })
    return var4, var2
end

return useBreakpoint
