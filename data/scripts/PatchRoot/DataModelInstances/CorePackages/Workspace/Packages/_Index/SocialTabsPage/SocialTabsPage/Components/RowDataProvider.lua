-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local React = require(SocialTabsPageParent.React)
local useJoinUserInExperience = require(SocialTabsPageParent.SocialExperienceJoin).useJoinUserInExperience

local DataHydration = require(SocialTabsPageParent.DataHydration)

local useCTAForRow = require(SocialTabsPage.Hooks.useCTAForRow)
local _Types = require(SocialTabsPage.Common.Types)

local useGetPresenceByUserId = require(SocialTabsPageParent.FriendsCommon).Hooks.useGetPresenceByUserId

local tbl1 = {
    userPresenceType = DataHydration.Presence.PresenceEnums.PresenceType.Offline,
    lastLocation = ""
}

return React.memo(function(tbl2) -- name: RowDataProvider
    local presence = useGetPresenceByUserId(tbl2.entity.id) or tbl1

    local userPresenceType = presence.userPresenceType

    local var2 = useJoinUserInExperience(tbl2.entity.id, { presence = presence })

    local primaryCta = useCTAForRow(tbl2.ctaResult, tbl2.actionHandlers, tbl2.entity.id, var2)

    return tbl2.createRow({ presence = userPresenceType, primaryCta = primaryCta })
end)
