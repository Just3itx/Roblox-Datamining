-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent
local GroupsWrapperContext = require(script.Parent.GroupsWrapperContext)
local React = require(GroupsParent.React)

return function()
    return React.useContext(GroupsWrapperContext)
end
