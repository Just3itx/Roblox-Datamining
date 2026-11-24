-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent
return require(GroupsParent.React).createContext({
    navigateTo = {
        previousView = nil,
        webView = function() end,
        groupDetails = function() end,
        seeAllGroups = function() end,
        createGroup = function() end
    },
    userId = "",
    groupId = nil,
    groupOverviewPaneSource = nil
})
