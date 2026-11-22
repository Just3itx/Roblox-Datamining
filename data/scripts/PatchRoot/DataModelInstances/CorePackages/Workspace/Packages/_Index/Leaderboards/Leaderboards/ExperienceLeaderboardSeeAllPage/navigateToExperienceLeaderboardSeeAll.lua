-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Leaderboards = script:FindFirstAncestor("Leaderboards")
local LeaderboardsParent = Leaderboards.Parent

local AppPage = require(LeaderboardsParent.RobloxAppEnums).AppPage
local SduiLoadTimer = require(LeaderboardsParent.SduiSharedUtilities).SduiLoadTimer

local fetchExperienceLeaderboardSeeAllPageIfNeeded = require(Leaderboards.ExperienceLeaderboardSeeAllPage.fetchExperienceLeaderboardSeeAllPageIfNeeded)

local function navigateToExperienceLeaderboardSeeAll(arg1, universeId: string, initialTab: string?)
    local pageTimer = SduiLoadTimer.createLoadTimer(AppPage.ExperienceLeaderboardSeeAll)
    pageTimer.start("navigate")

    local url = fetchExperienceLeaderboardSeeAllPageIfNeeded(universeId, initialTab, pageTimer)

    arg1.navigate(
        AppPage.ExperienceLeaderboardSeeAll,
        { universeId = universeId, initialTab = initialTab, pageTimer = pageTimer, url = url }
    )
end

return navigateToExperienceLeaderboardSeeAll
