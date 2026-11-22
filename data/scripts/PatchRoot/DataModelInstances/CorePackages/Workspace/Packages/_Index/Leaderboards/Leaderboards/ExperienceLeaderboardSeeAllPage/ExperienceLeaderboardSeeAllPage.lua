-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Leaderboards = script:FindFirstAncestor("Leaderboards")
local LeaderboardsParent = Leaderboards.Parent

local _Navigation = require(LeaderboardsParent.Navigation)
local React = require(LeaderboardsParent.React)
local SduiSharedUtilities = require(LeaderboardsParent.SduiSharedUtilities)
local useLocalization = require(LeaderboardsParent.Localization).Hooks.useLocalization

local SduiLoadTimer = SduiSharedUtilities.SduiLoadTimer
local SduiPageEntryPoint = SduiSharedUtilities.SduiPageEntryPoint
local usePageScopeRef = SduiSharedUtilities.usePageScopeRef
local CompositionTags = require(LeaderboardsParent.AppComposition).CompositionTags

local fetchExperienceLeaderboardSeeAllPageIfNeeded = require(Leaderboards.ExperienceLeaderboardSeeAllPage.fetchExperienceLeaderboardSeeAllPageIfNeeded)

local getExperienceLeaderboardSeeAllPageKey = require(Leaderboards.ExperienceLeaderboardSeeAllPage.getExperienceLeaderboardSeeAllPageKey)

local function getFromPropsOrNavigationParams(tbl1, str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    return tbl1[str1] or tbl1.navigation and tbl1.navigation.getParam(str1)
end

return React.memo(function(tbl1) -- name: ExperienceLeaderboardSeeAllPage
    local fromPropsOrNavigationParams = getFromPropsOrNavigationParams(tbl1, "universeId")
    local fromPropsOrNavigationParams2 = getFromPropsOrNavigationParams(tbl1, "initialTab")
    local configKey = getExperienceLeaderboardSeeAllPageKey(fromPropsOrNavigationParams)
    usePageScopeRef(configKey)
    local var1 = useLocalization({ pageTitle = "Feature.Leaderboards.Heading.Leaderboard" })

    local pageTimer = React.useMemo(function()
        return getFromPropsOrNavigationParams(tbl1, "pageTimer") or SduiLoadTimer.createLoadTimer("ExperienceLeaderboardSeeAll")
    end, { configKey })

    React.useEffect(function()
        if fromPropsOrNavigationParams then
            fetchExperienceLeaderboardSeeAllPageIfNeeded(fromPropsOrNavigationParams, fromPropsOrNavigationParams2, pageTimer)
        end
    end, { fromPropsOrNavigationParams, fromPropsOrNavigationParams2, pageTimer })

    local refresh = React.useCallback(function()
        if fromPropsOrNavigationParams then
            local loadTimer = SduiLoadTimer.createLoadTimer("ExperienceLeaderboardSeeAll")
            loadTimer.start("refresh")
            fetchExperienceLeaderboardSeeAllPageIfNeeded(fromPropsOrNavigationParams, fromPropsOrNavigationParams2, loadTimer, true)
        end
    end, { fromPropsOrNavigationParams, fromPropsOrNavigationParams2 })

    if fromPropsOrNavigationParams == nil then
        return nil
    end

    return React.createElement(SduiPageEntryPoint, {
        appPage = "ExperienceLeaderboardSeeAll",
        configKey = configKey,
        pageTimer = pageTimer,
        includeNavigationHeaderBar = true,
        pageTitle = var1.pageTitle,
        refresh = refresh,
        layoutTag = CompositionTags.Layout.Detail,
        contentTag = CompositionTags.ContentRegion.Body
    })
end)
