-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _Breakpoint = require(Foundation.Enums.Breakpoint)
local Flags = require(Foundation.Utility.Flags)
local ViewportBreakpointContext = require(Foundation.Providers.Overlay.ViewportBreakpointContext)
local useBreakpoint = require(Foundation.Providers.Responsive.Hooks.useBreakpoint)
local useResponsive = require(Foundation.Providers.Responsive.useResponsive)
local useScreen = require(Foundation.Providers.Overlay.useScreen)

local function useViewportBreakpoint()
    local var1 = useScreen()

    if not Flags.FoundationSharedViewportBreakpoint then
        return (useBreakpoint(var1))
    end

    local var2 = React.useContext(ViewportBreakpointContext)
    local breakpoint = useResponsive().config.breakpoint
    local var3 = var2 and var2.screen == var1 and var2.breakpointConfig == breakpoint and var2 or nil
    local register = if var3 then var3.register else nil

    React.useLayoutEffect(function()
        if register then
            return (register())
        end

        return nil
    end, { register })

    local var4 = useBreakpoint

    if var3 then
        var1 = nil
    end

    local var5 = var4(var1)

    return if var3 then var3.breakpoint else var5
end

return useViewportBreakpoint
