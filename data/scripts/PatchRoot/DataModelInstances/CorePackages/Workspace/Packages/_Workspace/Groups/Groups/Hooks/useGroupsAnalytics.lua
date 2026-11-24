-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent
local React = require(GroupsParent.React)
local GroupsAnalyticsContext = require(Groups.Analytics.GroupsAnalyticsContext)

local function useGroupsAnalytics()
    return React.useContext(GroupsAnalyticsContext)
end

return useGroupsAnalytics
