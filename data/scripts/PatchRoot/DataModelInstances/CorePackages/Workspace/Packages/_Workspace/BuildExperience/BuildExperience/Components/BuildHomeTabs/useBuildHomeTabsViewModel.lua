-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _Foundation = require(BuildExperienceParent.Foundation)
local Localization = require(BuildExperienceParent.Localization)
local React = require(BuildExperienceParent.React)

local createBuildHomeTabStore = require(BuildExperience.Stores.GetBuildHomeTabStore.createBuildHomeTabStore)
local GetBuildHomeTabStore = require(BuildExperience.Stores.GetBuildHomeTabStore)
local GetSearchQueryStore = require(BuildExperience.Stores.GetSearchQueryStore)
local _createSearchQueryStore = require(BuildExperience.Stores.GetSearchQueryStore.createSearchQueryStore)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local useBuildHomeTabsPageLayout = require(script.Parent.useBuildHomeTabsPageLayout)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local FFlagBuildExperienceHomeTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceHomeTelemetry)

local BUILD_HOME_TAB = createBuildHomeTabStore.BUILD_HOME_TAB
local useLocalization = Localization.Hooks.useLocalization

local function useBuildHomeTabsViewModel(tbl1)
    local var1 = tbl1.tabStore or GetBuildHomeTabStore()
    local var2 = var1.useTab()
    local var3 = (tbl1.searchQueryStore or GetSearchQueryStore()).useIsSearchActive()

    local var4 = useLocalization(
        {
            games = LocalizationStrings.BUILD_HOME_TAB_GAMES,
            previews = LocalizationStrings.BUILD_HOME_TAB_PREVIEWS
        }
    )
    local tabs = React.useMemo(function()
        return {
            {
                id = BUILD_HOME_TAB.Games,
                text = var4.games
            },
            {
                id = BUILD_HOME_TAB.Previews,
                text = var4.previews
            }
        }
    end, { var4.games, var4.previews })

    local onTabActivated = React.useCallback(function(arg1)
        if arg1 ~= BUILD_HOME_TAB.Games and arg1 ~= BUILD_HOME_TAB.Previews then
            return
        end
        if FFlagBuildExperienceHomeTelemetry then
            sendBuildExperienceEvent("TAB_CLICK", {}, { tab = tostring(arg1), context = "build_home" })
        end

        var1.setTab(arg1)
    end, { var1 })

    local showTabs = not var3
    if not showTabs then
        var2 = BUILD_HOME_TAB.Games
    end

    local var7 = useBuildHomeTabsPageLayout({ tabs = tabs, activeTab = var2, showTabs = showTabs })

    if FFlagBuildExperienceHomeTelemetry then
        local bool2 = showTabs and tbl1.isFocused ~= false
        React.useEffect(function()
            if not bool2 then
                return
            end
            sendBuildExperienceEvent("TAB_IMPRESSION", {}, { tab = var2, context = "build_home" })
        end, { var2, bool2 })
    end

    return {
        showTabs = showTabs,
        activeTab = var2,
        tabs = tabs,
        onTabActivated = onTabActivated,
        pageOffset = var7.pageOffset,
        tabOrder = var7.tabOrder
    }
end

return useBuildHomeTabsViewModel
