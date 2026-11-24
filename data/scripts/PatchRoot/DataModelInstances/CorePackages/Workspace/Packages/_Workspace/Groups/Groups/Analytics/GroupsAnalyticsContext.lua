-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:31:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent
local React = require(GroupsParent.React)
local _EventNames = require(script.Parent.EventNames)

return React.createContext({
    fireAnalyticsEvent = function() end
})
