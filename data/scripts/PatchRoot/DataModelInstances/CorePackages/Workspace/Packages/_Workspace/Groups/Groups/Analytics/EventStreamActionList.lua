-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local _SocialLuaAnalytics = require(GroupsParent.SocialLuaAnalytics)

local EventNames = require(script.Parent.EventNames)

return {
    [EventNames.GroupsListCreateGroupClicked] = {
        context = "myGroups",
        eventType = "groupPageClickEvent",
        additionalInfo = { clickTargetType = "createGroup" }
    },
    [EventNames.GroupsListPageExposure] = {
        context = "myGroups",
        eventType = "groupPageExposureEvent",
        additionalInfo = { exposureType = "myGroups" }
    }
}
