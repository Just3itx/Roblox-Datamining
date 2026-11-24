-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent

local SignalsReact = require(GroupsParent.SignalsReact)
local CommunityListRouting = require(Groups.CommunityListRouting)

local function useIsCompactTouch()
    return SignalsReact.useSignalState(CommunityListRouting.getIsCompactTouch)
end

return useIsCompactTouch
