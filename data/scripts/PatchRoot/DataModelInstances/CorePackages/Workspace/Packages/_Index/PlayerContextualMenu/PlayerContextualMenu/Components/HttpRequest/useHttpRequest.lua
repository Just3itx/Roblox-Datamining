-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayerContextualMenuParent = script:FindFirstAncestor("PlayerContextualMenu").Parent
local React = require(PlayerContextualMenuParent.React)

local HttpRequestContext = require(script.Parent.HttpRequestContext)

return function()
    return React.useContext(HttpRequestContext)
end
