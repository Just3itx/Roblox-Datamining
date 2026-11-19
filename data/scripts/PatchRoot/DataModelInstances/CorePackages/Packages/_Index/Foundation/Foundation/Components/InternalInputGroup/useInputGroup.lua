-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:10:59Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local InputGroupContext = require(script.Parent.InputGroupContext)

local function useInputGroup()
    return React.useContext(InputGroupContext)
end

return useInputGroup
