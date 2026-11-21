-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Badges = script:FindFirstAncestor("Badges")
local BadgesParent = Badges.Parent

local AppPage = require(BadgesParent.RobloxAppEnums).AppPage
local SduiLoadTimer = require(BadgesParent.SduiSharedUtilities).SduiLoadTimer
local fetchBadgesSeeAllPageIfNeeded = require(Badges.BadgesSeeAllPage.fetchBadgesSeeAllPageIfNeeded)

local function navigateToBadgesSeeAll(arg1, universeId: string)
    local pageTimer = SduiLoadTimer.createLoadTimer(AppPage.BadgesSeeAll)
    pageTimer.start("navigate")

    local url = fetchBadgesSeeAllPageIfNeeded(universeId, pageTimer)

    arg1.navigate(AppPage.BadgesSeeAll, { universeId = universeId, pageTimer = pageTimer, url = url })
end

return navigateToBadgesSeeAll
