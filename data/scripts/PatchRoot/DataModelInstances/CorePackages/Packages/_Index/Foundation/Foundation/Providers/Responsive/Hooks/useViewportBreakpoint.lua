-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:51:27Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Breakpoint = require(Foundation.Enums.Breakpoint)
local useBreakpoint = require(Foundation.Providers.Responsive.Hooks.useBreakpoint)
local useScreen = require(Foundation.Providers.Overlay.useScreen)

local function useViewportBreakpoint()
    local var1 = useScreen()
    return (useBreakpoint(var1))
end

return useViewportBreakpoint
