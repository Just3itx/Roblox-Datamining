-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:01:01Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local HeaderBarContext = require(Foundation.Components.HeaderBar.HeaderBarContext)

local function useHeaderBarContext()
    return React.useContext(HeaderBarContext.Context)
end

return useHeaderBarContext
