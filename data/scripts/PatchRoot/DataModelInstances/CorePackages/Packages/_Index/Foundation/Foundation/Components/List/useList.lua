-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:20:55Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local ListContext = require(script.Parent.ListContext)

return function()
    return React.useContext(ListContext)
end
