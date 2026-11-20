-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local InputGroupContext = require(script.Parent.InputGroupContext)

local function useInputGroup()
    return React.useContext(InputGroupContext)
end

return useInputGroup
