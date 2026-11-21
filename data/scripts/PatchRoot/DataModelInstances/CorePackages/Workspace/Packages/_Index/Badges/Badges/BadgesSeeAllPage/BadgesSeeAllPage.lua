-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Badges = script:FindFirstAncestor("Badges")
local BadgesParent = Badges.Parent

local _Navigation = require(BadgesParent.Navigation)
local React = require(BadgesParent.React)
local SduiSharedUtilities = require(BadgesParent.SduiSharedUtilities)
local useLocalization = require(BadgesParent.Localization).Hooks.useLocalization

local SduiLoadTimer = SduiSharedUtilities.SduiLoadTimer
local SduiPageEntryPoint = SduiSharedUtilities.SduiPageEntryPoint
local CompositionTags = require(BadgesParent.AppComposition).CompositionTags
local FFlagSplitPaneBadgesSeeAllSupportRegion = require(BadgesParent.SharedFlags).FFlagSplitPaneBadgesSeeAllSupportRegion
local PaneHostContext = if FFlagSplitPaneBadgesSeeAllSupportRegion then require(BadgesParent.SplitPane).PaneHostContext else nil
local fetchBadgesSeeAllPageIfNeeded = require(Badges.BadgesSeeAllPage.fetchBadgesSeeAllPageIfNeeded)
local getBadgesSeeAllPageKey = require(Badges.BadgesSeeAllPage.getBadgesSeeAllPageKey)

local function getFromPropsOrNavigationParams(tbl1, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return tbl1[str1] or tbl1.navigation and tbl1.navigation.getParam(str1)
end

return React.memo(function(tbl1) -- name: BadgesSeeAllPage
    local fromPropsOrNavigationParams = getFromPropsOrNavigationParams(tbl1, "universeId")
    local configKey = getBadgesSeeAllPageKey(fromPropsOrNavigationParams)
    local var1 = useLocalization({ pageTitle = "CommonUI.Features.Label.Badges" })
    local var2 = if FFlagSplitPaneBadgesSeeAllSupportRegion then React.useContext(PaneHostContext) else nil

    local pageTimer = React.useMemo(function()
        return getFromPropsOrNavigationParams(tbl1, "pageTimer") or SduiLoadTimer.createLoadTimer("BadgesSeeAll")
    end, { configKey })

    React.useEffect(function()
        if fromPropsOrNavigationParams then
            fetchBadgesSeeAllPageIfNeeded(fromPropsOrNavigationParams, pageTimer)
        end
    end, { fromPropsOrNavigationParams, pageTimer })

    local refresh = React.useCallback(function()
        if fromPropsOrNavigationParams then
            local loadTimer = SduiLoadTimer.createLoadTimer("BadgesSeeAll")
            loadTimer.start("refresh")
            fetchBadgesSeeAllPageIfNeeded(fromPropsOrNavigationParams, loadTimer, true)
        end
    end, { fromPropsOrNavigationParams })

    if fromPropsOrNavigationParams == nil then
        return nil
    end

    return React.createElement(SduiPageEntryPoint, {
        appPage = "BadgesSeeAll",
        configKey = configKey,
        pageTimer = pageTimer,
        includeNavigationHeaderBar = true,
        navButtonType = if FFlagSplitPaneBadgesSeeAllSupportRegion and var2 ~= nil then if var2.isHostCloseVisible then "none" else nil else nil,
        pageTitle = var1.pageTitle,
        refresh = refresh,
        contentTag = CompositionTags.ContentRegion.Body
    })
end)
