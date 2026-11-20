-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local ListContext = require(script.Parent.ListContext)

return function()
    return React.useContext(ListContext)
end
