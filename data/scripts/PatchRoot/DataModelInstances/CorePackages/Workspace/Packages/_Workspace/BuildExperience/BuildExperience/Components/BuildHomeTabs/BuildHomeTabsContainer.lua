-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local FFlagBuildExperienceFoundationTabs = require(BuildExperience.Flags.FFlagBuildExperienceFoundationTabs)
local FFlagBuildExperienceHomeTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceHomeTelemetry)

local BuildHomeTabsView = require(script.Parent.BuildHomeTabsView)
local _createSearchQueryStore = require(BuildExperience.Stores.GetSearchQueryStore.createSearchQueryStore)
local GamesFilter = require(BuildExperience.Stores.GetMyCreationsFilterStore.GamesFilter)
local GetPreviewsFilterStore = require(BuildExperience.Stores.GetPreviewsFilterStore)
local MyCreationsFilterContainer = require(BuildExperience.Components.MyCreationsFilter.MyCreationsFilterContainer)
local PreviewsTabView = require(BuildExperience.Components.PreviewsTab.PreviewsTabView)
local useBuildHomeTabsFillBehavior = require(script.Parent.useBuildHomeTabsFillBehavior)
local useBuildHomeTabsViewModel = require(script.Parent.useBuildHomeTabsViewModel)
local usePreviewResults = require(BuildExperience.Components.PreviewsTab.usePreviewResults)
local usePreviewsTabViewModel = require(BuildExperience.Components.PreviewsTab.usePreviewsTabViewModel)

local options = { GamesFilter.All, GamesFilter.GroupGames, GamesFilter.SharedGames }
local defaultFilter = {
    games = GamesFilter.SharedGames
}
local function BuildHomeTabsContainer(tbl3)
    local creatorGroupsStore = tbl3.creatorGroupsStore
    local previewsFilterStore = tbl3.previewsFilterStore or GetPreviewsFilterStore()

    local filter = previewsFilterStore.useFilter()

    local results = usePreviewResults(
        {
            searchStore = tbl3.searchStore,
            creatorGroupsStore = creatorGroupsStore,
            filter = filter,
            isFocused = tbl3.isFocused
        }
    )
    local var3 = useBuildHomeTabsViewModel({
        tabStore = tbl3.tabStore,
        searchQueryStore = tbl3.searchQueryStore,
        isFocused = if FFlagBuildExperienceHomeTelemetry then tbl3.isFocused else nil
    })
    local tabsFillBehavior = if FFlagBuildExperienceFoundationTabs then useBuildHomeTabsFillBehavior() else nil
    local var5 = usePreviewsTabViewModel({ results = results })

    return React.createElement(BuildHomeTabsView, {
        LayoutOrder = tbl3.LayoutOrder,
        showTabs = var3.showTabs,
        activeTab = var3.activeTab,
        tabs = var3.tabs,
        onTabActivated = var3.onTabActivated,
        pageOffset = var3.pageOffset,
        tabOrder = var3.tabOrder,
        tabsFillBehavior = tabsFillBehavior,
        gamesContent = tbl3.gamesContent,
        previewsContent = React.createElement(PreviewsTabView, {
            rows = var5.rows,
            listStatus = var5.listStatus,
            loadError = var5.loadError,
            isLoadingMore = var5.isLoadingMore,
            failedLoadMore = var5.failedLoadMore,
            refresh = var5.refresh,
            loadMoreIfNeeded = var5.loadMoreIfNeeded,
            retryLoadMore = var5.retryLoadMore,
            emptyText = var5.emptyText,
            filterHeader = React.createElement(MyCreationsFilterContainer, {
                LayoutOrder = 0,
                filterStore = previewsFilterStore,
                creatorGroupsStore = creatorGroupsStore,
                groups = results.previewGroups,
                defaultFilter = defaultFilter,
                options = options,
                testId = "PreviewsFilterView"
            })
        })
    })
end

return BuildHomeTabsContainer
