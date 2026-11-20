-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Breakpoint = require(Foundation.Enums.Breakpoint)
local constants = require(Foundation.Components.HeaderBar.constants)
local useTokens = require(Foundation.Providers.Style.useTokens)
local useViewportBreakpoint = require(Foundation.Providers.Responsive.Hooks.useViewportBreakpoint)

local function useHeaderBarHeight()
    local var1 = useTokens()
    local var2 = useViewportBreakpoint()

    return var1.Size[`Size_{constants.SIZE_BY_BREAKPOINT[var2]}`]
end

return useHeaderBarHeight
