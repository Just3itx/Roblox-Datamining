-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)

local BreakpointConfig = require(Foundation.Utility.Responsive.BreakpointConfig)
local GridConfig = require(Foundation.Utility.Responsive.GridConfig)
local ResponsiveContext = require(scriptParent.ResponsiveContext)

local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    config = { breakpoint = BreakpointConfig, grid = GridConfig }
}

local function ResponsiveProvider(tbl2)
    local value = React.useMemo(function()
        return {
            config = withDefaults(tbl2.config or {}, tbl1.config)
        }
    end, { tbl2.config })

    return React.createElement(ResponsiveContext.Provider, { value = value }, tbl2.children)
end

return ResponsiveProvider
