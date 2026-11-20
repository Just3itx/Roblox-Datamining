-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _Breakpoint = require(Foundation.Enums.Breakpoint)
local _ViewportBreakpointContext = require(script.Parent.ViewportBreakpointContext)
local useBreakpoint = require(Foundation.Providers.Responsive.Hooks.useBreakpoint)
local useResponsive = require(Foundation.Providers.Responsive.useResponsive)

local function useSharedViewportBreakpoint(screen)
    local var1, var2 = React.useState(false)
    local var3 = React.useRef(0)
    local breakpoint = useResponsive().config.breakpoint
    local var4 = useBreakpoint(if var1 then screen else nil)

    local register = React.useCallback(function()
        local var5 = var3
        var5.current += 1
        var2(true)

        return function()
            local var6 = var3
            var6.current -= 1
            if var3.current == 0 then
                var2(false)
            end
        end
    end, {})

    return React.useMemo(function()
        return {
            screen = screen,
            breakpointConfig = breakpoint,
            breakpoint = var4,
            register = register
        }
    end, {
        screen,
        breakpoint,
        var4,
        register
    })
end
return useSharedViewportBreakpoint
