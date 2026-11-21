-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceStoreServerDrivenUi = script:FindFirstAncestor("ExperienceStoreServerDrivenUi")
local ExperienceStoreServerDrivenUiParent = ExperienceStoreServerDrivenUi.Parent

local _Navigation = require(ExperienceStoreServerDrivenUiParent.Navigation)
local React = require(ExperienceStoreServerDrivenUiParent.React)
local SduiSharedUtilities = require(ExperienceStoreServerDrivenUiParent.SduiSharedUtilities)
local useLocalization = require(ExperienceStoreServerDrivenUiParent.Localization).Hooks.useLocalization

local SduiLoadTimer = SduiSharedUtilities.SduiLoadTimer
local SduiPageEntryPoint = SduiSharedUtilities.SduiPageEntryPoint
local getSduiClientPageScope = SduiSharedUtilities.getSduiClientPageScope
local FFlagSduiErrorPaths = require(ExperienceStoreServerDrivenUiParent.SharedFlags).FFlagSduiErrorPaths
local CompositionTags = require(ExperienceStoreServerDrivenUiParent.AppComposition).CompositionTags

local FFlagSplitPaneDevStoreSeeAllSupportRegion = require(ExperienceStoreServerDrivenUiParent.SharedFlags).FFlagSplitPaneDevStoreSeeAllSupportRegion
local PaneHostContext = if FFlagSplitPaneDevStoreSeeAllSupportRegion then require(ExperienceStoreServerDrivenUiParent.SplitPane).PaneHostContext else nil
local fetchDevStoreSeeAllPageIfNeeded = require(ExperienceStoreServerDrivenUi.Api.fetchDevStoreSeeAllPageIfNeeded)
local getDevStoreSeeAllPageKey = require(ExperienceStoreServerDrivenUi.Utils.getDevStoreSeeAllPageKey)

local function getFromPropsOrNavigationParams(tbl1, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return tbl1[str1] or tbl1.navigation and tbl1.navigation.getParam(str1)
end

return React.memo(function(tbl1) -- name: DevStoreSeeAllPage
    local fromPropsOrNavigationParams = getFromPropsOrNavigationParams(tbl1, "universeId")
    local configKey = getDevStoreSeeAllPageKey(fromPropsOrNavigationParams)
    local var1 = useLocalization({ pageTitle = "Feature.GameDetails.Label.Store" })
    local var2 = if FFlagSplitPaneDevStoreSeeAllSupportRegion then React.useContext(PaneHostContext) else nil
    local fromPropsOrNavigationParams2 = getFromPropsOrNavigationParams(tbl1, "pageTimer")

    local pageTimer = React.useMemo(function()
        return fromPropsOrNavigationParams2 or SduiLoadTimer.createLoadTimer("DevStoreSeeAll")
    end, { configKey, fromPropsOrNavigationParams2 })

    if FFlagSduiErrorPaths then
        React.useMemo(function()
            if not fromPropsOrNavigationParams then
                return nil
            end

            local sduiClientPageScope = getSduiClientPageScope(configKey)
            sduiClientPageScope.set("devStoreSectionsFired", {})
            return sduiClientPageScope
        end, { configKey, pageTimer, fromPropsOrNavigationParams })
    end

    React.useEffect(function()
        if fromPropsOrNavigationParams then
            fetchDevStoreSeeAllPageIfNeeded(fromPropsOrNavigationParams, pageTimer)
        end
    end, { fromPropsOrNavigationParams, pageTimer })

    local refresh = React.useCallback(function()
        if fromPropsOrNavigationParams then
            local loadTimer = SduiLoadTimer.createLoadTimer("DevStoreSeeAll")
            loadTimer.start("refresh")
            fetchDevStoreSeeAllPageIfNeeded(fromPropsOrNavigationParams, loadTimer, true)
        end
    end, { fromPropsOrNavigationParams })

    if fromPropsOrNavigationParams == nil then
        return nil
    end

    return React.createElement(SduiPageEntryPoint, {
        appPage = "DevStoreSeeAll",
        configKey = configKey,
        pageTimer = pageTimer,
        includeNavigationHeaderBar = true,
        navButtonType = if FFlagSplitPaneDevStoreSeeAllSupportRegion and var2 ~= nil then if var2.isHostCloseVisible then "none" else nil else nil,
        pageTitle = var1.pageTitle,
        refresh = refresh,
        contentTag = CompositionTags.ContentRegion.Body,
        layoutTag = CompositionTags.Layout.Detail
    })
end)
