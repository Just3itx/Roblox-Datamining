-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserRelationshipModalsParent = script:FindFirstAncestor("UserRelationshipModals").Parent

local React = require(UserRelationshipModalsParent.React)

local AnalyticsSetup = require(script.Parent.AnalyticsSetup)

local _RelationshipTypes = require(script.Parent.RelationshipTypes)

local function useUserRelationshipModalAnalytics(relationshipType: number, num2: number, targetUserId: number)
    return (React.useMemo(function()
        return AnalyticsSetup({ infoForAllEvents = { relationshipType = relationshipType, targetUserId = targetUserId } })
    end, { relationshipType, num2, targetUserId }))
end

return useUserRelationshipModalAnalytics
