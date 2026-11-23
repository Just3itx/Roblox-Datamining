-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _AppLifecycleObserverService = game:GetService("AppLifecycleObserverService")
local Players = game:GetService("Players")

local FFlagBuildExperienceMyCreationsCreateGameButton = require(BuildExperience.Flags.FFlagBuildExperienceMyCreationsCreateGameButton)
local FFlagBuildExperienceMyCreationsLongPressMenu = require(BuildExperience.Flags.FFlagBuildExperienceMyCreationsLongPressMenu)
local FFlagBuildWithGroups = require(BuildExperience.Flags.FFlagBuildWithGroups)
local FFlagBuildExperienceEventContextTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceEventContextTelemetry)

local Foundation = require(BuildExperienceParent.Foundation)
local Localization = require(BuildExperienceParent.Localization)
local LuaSocialLibrariesDeps = require(BuildExperienceParent.LuaSocialLibrariesDeps)
local React = require(BuildExperienceParent.React)
local useLocalization = Localization.Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local _CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local _UniverseConfiguration = require(BuildExperienceParent.DataHydration.UniverseConfiguration)
local _UniverseSearch = require(BuildExperienceParent.DataHydration.UniverseSearch)

local Button = Foundation.Button
local List = Foundation.List
local View = Foundation.View
local RefreshScrollingFrame = LuaSocialLibrariesDeps.SocialLibraries.config({}).Components.RefreshScrollingFrame

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local ListItemInputType = Foundation.Enums.ListItemInputType

local testId = if FFlagBuildExperienceMyCreationsLongPressMenu then "MyCreationsTab.NewGameRow" else nil

local BuildEmptyState = require(BuildExperience.Components.BuildEmptyState.BuildEmptyState)
local SearchEmptyState = require(BuildExperience.Components.SearchEmptyState.SearchEmptyState)

local chatConstants = require(script.Parent.Parent.Parent.Chat.chatConstants)
local _chatTypes = require(script.Parent.Parent.Parent.Chat.chatTypes)

local GetMyCreationsFilterStore = require(script.Parent.Parent.Parent.Stores.GetMyCreationsFilterStore)
local GetSearchQueryStore = require(script.Parent.Parent.Parent.Stores.GetSearchQueryStore)
local _createSearchQueryStore = require(script.Parent.Parent.Parent.Stores.GetSearchQueryStore.createSearchQueryStore)
local useScrollPerformanceTracker = require(script.Parent.Parent.Parent.Telemetry.useScrollPerformanceTracker)
local ExperienceResultsList = require(script.Parent.ExperienceResultsList)
local ExperienceResultsLoadingSkeleton = require(script.Parent.ExperienceResultsLoadingSkeleton)
local MyCreationsFilterContainer = require(BuildExperience.Components.MyCreationsFilter.MyCreationsFilterContainer)
local useMyCreationsResults = require(script.Parent.useMyCreationsResults)

local function MyCreationsTab(tbl1)
    local var2 = useLocalization({
        building = LocalizationStrings.MY_CREATIONS_BUILDING,
        buildWithAI = LocalizationStrings.MY_CREATIONS_BUILD_WITH_AI,
        createNewGame = if FFlagBuildExperienceMyCreationsCreateGameButton then LocalizationStrings.MY_CREATIONS_CREATE_NEW_GAME else nil,
        inputNeeded = LocalizationStrings.MY_CREATIONS_INPUT_NEEDED,
        loadError = LocalizationStrings.MY_CREATIONS_LOAD_ERROR,
        newGame = LocalizationStrings.MY_CREATIONS_NEW_GAME,
        noGames = LocalizationStrings.MY_CREATIONS_NO_GAMES,
        private = LocalizationStrings.MY_CREATIONS_PRIVATE,
        public = LocalizationStrings.MY_CREATIONS_PUBLIC,
        publiclyUnavailable = LocalizationStrings.MY_CREATIONS_PUBLICLY_UNAVAILABLE,
        ready = LocalizationStrings.MY_CREATIONS_READY,
        restricted = LocalizationStrings.MY_CREATIONS_RESTRICTED
    })
    local buildWithAi = var2.buildWithAI
    local createNewGame = var2.createNewGame
    local loadError = var2.loadError
    local newGame = var2.newGame
    local noGames = var2.noGames
    local searchQueryStore = tbl1.searchQueryStore or GetSearchQueryStore()
    local isFocused = tbl1.isFocused ~= false
    local ref = React.useRef(nil)
    local var4 = React.useRef(false)
    useScrollPerformanceTracker("LuaApp_Build_Home_Scroll", ref)

    local var5 = searchQueryStore.useShowEmptyState()
    local var6 = if FFlagBuildWithGroups or FFlagBuildExperienceMyCreationsCreateGameButton then searchQueryStore.useIsSearchActive() else false
    local var7 = searchQueryStore.useDraftQuery()
    local filterStore = if FFlagBuildWithGroups then tbl1.filterStore or GetMyCreationsFilterStore() else nil
    local var9 = if FFlagBuildWithGroups then filterStore.useFilter() else nil
    local var10 = useMyCreationsResults
    local tbl2 = {
        creatorAgentChatStore = tbl1.creatorAgentChatStore,
        creatorGroupsStore = tbl1.creatorGroupsStore,
        configurationStore = tbl1.configurationStore,
        searchStore = tbl1.searchStore,
        searchQueryStore = searchQueryStore,
        appLifecycleObserverService = tbl1.appLifecycleObserverService,
        isFocused = isFocused,
        pollingIntervalSeconds = tbl1.pollingIntervalSeconds,
        userId = tbl1.userId,
        filter = 0
    }
    if var6 then
        var9 = nil
    end

    tbl2.filter = var9
    local var11 = var10(tbl2)

    local displayedItems = var11.displayedItems
    local items = var11.items
    local hasPendingSummary = var11.hasPendingSummary
    local listStatus = var11.listStatus
    local hasDisplayedResult = var11.hasDisplayedResult
    local failedLoadMore = var11.failedLoadMore
    local retryLoadMore = var11.retryLoadMore
    local refresh = var11.refresh
    local loadMoreIfNeeded = var11.loadMoreIfNeeded

    local onActivated = React.useCallback(function(arg1)
        var4.current = true
        tbl1.onOpenChat(
            {
                experienceName = chatConstants.BUILD_CHAT_PAGE_TITLE,
                isNewGameTarget = true,
                creatorName = if Players.LocalPlayer then Players.LocalPlayer.Name else nil
            },
            FFlagBuildExperienceEventContextTelemetry and (if arg1 == "auto_new_game" then "auto_new_game" else "new_game") or nil
        )
    end, { tbl1.onOpenChat })
    local hasCompletedFocusedRefresh = var11.hasCompletedFocusedRefresh

    if hasCompletedFocusedRefresh then
        if var11.sessionListStatus == "Ready" and var11.sessionCount == 0 then
            hasCompletedFocusedRefresh = var7 == ""
        else
            hasCompletedFocusedRefresh = false
        end
    end
    React.useEffect(function()
        if tbl1.autoOpenNewGame ~= false and isFocused and hasCompletedFocusedRefresh and not var4.current then
            onActivated(if FFlagBuildExperienceEventContextTelemetry then "auto_new_game" else nil)
        end
    end, {
        hasCompletedFocusedRefresh,
        onActivated,
        isFocused,
        tbl1.autoOpenNewGame
    })

    local none = if FFlagBuildExperienceMyCreationsLongPressMenu and tbl1.onOpenConfigurationPage ~= nil then ListItemInputType.None else nil

    local createFooter = React.useCallback(function()
        if not var11.isLoadingMore then
            return nil
        end
        return React.createElement(ExperienceResultsLoadingSkeleton, { LayoutOrder = 1, index = 1, testIdPrefix = "MyCreationsTab" })
    end, { var11.isLoadingMore })

    local leadingItems = if FFlagBuildExperienceMyCreationsCreateGameButton then nil else React.useMemo(function()
        return {
            CreateRow = React.createElement(List.Item, {
                LayoutOrder = 1,
                leading = IconName.PlusLarge,
                title = newGame,
                description = buildWithAi,
                testId = testId,
                onActivated = onActivated,
                input = none
            })
        }
    end, {
        buildWithAi,
        onActivated,
        newGame,
        none
    })

    local tbl3

    if var5 then
        tbl3 = {
            SearchEmptyState = React.createElement(SearchEmptyState, { testId = "MyCreationsTab.SearchEmptyState" })
        }
    elseif hasDisplayedResult and not hasPendingSummary and #displayedItems == 0 then
        tbl3 = { EmptyContent = 0 }
        local createElement = React.createElement
        local var15 = View
        local tbl4 = { tag = "col size-full" }

        local tbl5 = { CreateList = 0, EmptyState = 0 }
        local element

        if FFlagBuildExperienceMyCreationsCreateGameButton then
            element = nil
        else
            element = React.createElement(List.Root, {
                LayoutOrder = 1,
                hasDivider = false,
                isContained = { isContained = false, hasMargin = false },
                size = InputSize.Large
            }, {
                CreateRow = React.createElement(List.Item, {
                    LayoutOrder = 1,
                    leading = IconName.PlusLarge,
                    title = newGame,
                    description = buildWithAi,
                    testId = testId,
                    onActivated = onActivated,
                    input = none
                })
            })
        end

        tbl5.CreateList = element

        local createElement2 = React.createElement
        local var16 = View
        local tbl6 = {
            LayoutOrder = 2,
            tag = "col align-x-center align-y-center fill size-full-0 padding-large",
            testId = "MyCreationsTab.Empty"
        }

        local tbl7 = { Content = 0 }
        local createElement3 = React.createElement
        local var17 = BuildEmptyState
        local tbl8 = { message = 0 }
        if not FFlagBuildWithGroups then
            noGames = nil
        end

        tbl8.message = noGames
        tbl7.Content = createElement3(var17, tbl8)
        tbl5.EmptyState = createElement2(var16, tbl6, tbl7)
        tbl3.EmptyContent = createElement(var15, tbl4, tbl5)
    else
        tbl3 = {
            ExperienceList = React.createElement(ExperienceResultsList, {
                items = items,
                hasDisplayedItems = #displayedItems > 0,
                hasDisplayedResult = hasDisplayedResult,
                hasPendingSummary = hasPendingSummary,
                listStatus = listStatus,
                failedLoadMore = failedLoadMore,
                retryLoadMore = retryLoadMore,
                loadError = loadError,
                onOpenChat = tbl1.onOpenChat,
                onOpenConfigurationPage = tbl1.onOpenConfigurationPage,
                leadingItems = leadingItems,
                firstResultLayoutOrder = 2,
                testIdPrefix = "MyCreationsTab"
            })
        }
    end

    local contentBody = React.createElement(
        View,
        {
            tag = "composition-content-body col size-full-0 auto-y",
            testId = "MyCreationsTab.ContentBody"
        },
        tbl3
    )

    local results = React.createElement(RefreshScrollingFrame, {
        refresh = refresh,
        ref = ref,
        onCanvasPositionChangedCallback = loadMoreIfNeeded,
        onCanvasSizeChangedCallback = loadMoreIfNeeded,
        createFooter = createFooter,
        usesBuilderIcon = true,
        scrollingElementProps = {
            LayoutOrder = if FFlagBuildExperienceMyCreationsCreateGameButton or FFlagBuildWithGroups then 1 else tbl1.LayoutOrder,
            ZIndex = 1,
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            ScrollBarThickness = 0,
            CanvasSize = UDim2.new(1, 0, 1, 1),
            AutomaticCanvasSize = Enum.AutomaticSize.XY,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            [React.Tag] = "fill"
        }
    }, {
        ContentLayout = React.createElement(View, {
            tag = { ["composition-layout-detail"] = true, ["size-full-0 auto-y"] = true },
            testId = "MyCreationsTab.ContentLayout"
        }, { ContentBody = contentBody })
    })
    local element3 = if FFlagBuildWithGroups then React.createElement(
        MyCreationsFilterContainer,
        {
            LayoutOrder = 0,
            filterStore = filterStore,
            creatorGroupsStore = tbl1.creatorGroupsStore
        }
    ) else nil

    if not FFlagBuildExperienceMyCreationsCreateGameButton then
        if element3 == nil then
            return results
        end
        local createElement = React.createElement
        local var15 = View
        local tbl4 = {
            LayoutOrder = tbl1.LayoutOrder,
            tag = "col fill size-full"
        }
        local tbl5 = { Filter = 0, Results = 0 }
        if var6 then
            element3 = nil
        end

        tbl5.Filter = element3
        tbl5.Results = results
        return createElement(var15, tbl4, tbl5)
    end

    local createGameBody = React.createElement(
        View,
        { tag = "composition-content-body col size-full-0 auto-y padding-y-medium" },
        {
            CreateGameButton = React.createElement(Button, {
                text = createNewGame,
                onActivated = onActivated,
                variant = ButtonVariant.Emphasis,
                size = InputSize.Medium,
                width = UDim.new(1, 0),
                testId = "MyCreationsTab.CreateGameButton"
            })
        }
    )

    local createElement = React.createElement
    local var15 = View
    local tbl4 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "col fill size-full"
    }
    local tbl5 = { Filter = 0, Results = 0, CreateGameFooter = 0 }
    if var6 then
        element3 = nil
    end

    tbl5.Filter = element3
    tbl5.Results = results
    tbl5.CreateGameFooter = if var6 then nil else React.createElement(View, {
        LayoutOrder = 2,
        tag = { ["composition-layout-detail"] = true, ["size-full-0 auto-y"] = true },
        testId = "MyCreationsTab.CreateGameLayout"
    }, { CreateGameBody = createGameBody })
    return createElement(var15, tbl4, tbl5)
end

return MyCreationsTab
