-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:51:25Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Breakpoint = require(Foundation.Enums.Breakpoint)
local _ResponsiveContext = require(Foundation.Providers.Responsive.ResponsiveContext)
local _Types = require(Foundation.Components.Types)
local useBreakpoint = require(script.Parent.useBreakpoint)
local useResponsive = require(Foundation.Providers.Responsive.useResponsive)

local function useResponsiveValue(arg1, arg2)
    local var1 = useBreakpoint(arg1)
    return arg2[useResponsive().config.breakpoint.shortNames[var1]]
end

return useResponsiveValue
