-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local FFlagBuildExperienceModelPicker = require(BuildExperience.Flags.FFlagBuildExperienceModelPicker)
local prepareBuildModelSelectionTarget = require(BuildExperience.Chat.prepareBuildModelSelectionTarget)
local GetBuildModelSelectionStore = require(BuildExperience.Stores.GetBuildModelSelectionStore)

local Foundation = require(BuildExperienceParent.Foundation)
local Navigation = require(BuildExperienceParent.Navigation)
local React = require(BuildExperienceParent.React)
local RoactNavigation = require(BuildExperienceParent.RoactNavigation)
local SharedFlags = require(BuildExperienceParent.SharedFlags)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local FullscreenPageWithSafeArea = require(BuildExperienceParent.AppBlox).FullscreenPageWithSafeArea
local Loading = Foundation.Loading
local OverlayProvider = Foundation.OverlayProvider
local View = Foundation.View
local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local useNavigationFocus = Navigation.useNavigationFocus

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local LocalUserIdStore = require(BuildExperienceParent.LocalUserIdStore).LocalUserIdStore
local BuildPageHeader = require(script.Parent.Components.BuildPageHeader.BuildPageHeader)
local BuildChatPage = require(script.Parent.Components.BuildChatPage.BuildChatPage)
local ChatSheet = require(script.Parent.Components.ChatSheet.ChatSheet)
local FFlagBuildExperienceLibrary = SharedFlags.FFlagBuildExperienceLibrary
local openLibrary = require(script.Parent.utils.openLibrary)
local SearchPageContainer = require(script.Parent.Components.SearchPage.SearchPageContainer)
local SearchEmptyState = require(script.Parent.Components.SearchEmptyState.SearchEmptyState)
local SubagentStatus = require(script.Parent.Components.SubagentStatus)
local MyCreationsTab = require(script.Parent.Components.MyCreationsTab.MyCreationsTab)
local ExperienceResultsList = require(script.Parent.Components.MyCreationsTab.ExperienceResultsList)

local ExperienceResultsLoadingSkeleton = require(script.Parent.Components.MyCreationsTab.ExperienceResultsLoadingSkeleton)
local useMyCreationsResults = require(script.Parent.Components.MyCreationsTab.useMyCreationsResults)
local BuildOverflowMenuScreens = require(script.Parent.Components.BuildPillMenu.BuildOverflowMenuScreens)
local FFlagBuildExperienceMonetizationNativeUI = require(script.Parent.Flags.FFlagBuildExperienceMonetizationNativeUI)
local OverflowMenuPageShell = require(script.Parent.Components.BuildPillMenu.OverflowMenuPageShell)
local PrivateInvitesPickerHost = require(script.Parent.Components.PrivateInvitesPicker.PrivateInvitesPickerHost)
local CreatorCreditPageContainer = require(script.Parent.Components.CreatorCreditSheet.CreatorCreditPageContainer)

local CreatorCreditBalanceChipContainer = require(script.Parent.Components.CreatorCreditSheet.CreatorCreditBalanceChip.CreatorCreditBalanceChipContainer)
local AdsStatsView = require(script.Parent.Components.Ads.AdsStatsView)
local useAdsStatsPageViewModel = require(script.Parent.Components.Ads.useAdsStatsPageViewModel)
local AdsManagerMenuButton = require(script.Parent.Components.Ads.AdsManagerMenuButton)
local AdCampaignCreatedToast = require(script.Parent.Components.Ads.AdCampaignCreatedToast)

local _chatTypes = require(script.Parent.Chat.chatTypes)
local useSessionSummary = require(script.Parent.Chat.useSessionSummary)
local useScrollPerformanceTracker = require(script.Parent.Telemetry.useScrollPerformanceTracker)

local snapPoints = { 0.5, 1 }
local FFlagBuildAdUpsell = require(script.Parent.Flags.FFlagBuildAdUpsell)
local FFlagEnableBuildAdPromotion = require(script.Parent.Flags.FFlagEnableBuildAdPromotion)

local _createBuildOverflowMenuStore = require(script.Parent.Stores.GetBuildOverflowMenuStore.createBuildOverflowMenuStore)
local GetBuildExperienceRefreshStore = require(script.Parent.Stores.GetBuildExperienceRefreshStore)
local GetSearchQueryStore = require(script.Parent.Stores.GetSearchQueryStore)
local _createSearchQueryStore = require(script.Parent.Stores.GetSearchQueryStore.createSearchQueryStore)
local BuildNavigationParams = require(script.Parent.utils.BuildNavigationParams)
local resumeBuildChat = require(script.Parent.utils.resumeBuildChat)
local useBuildPageLayout = require(script.Parent.utils.useBuildPageLayout)
local useManageBuildNavBarVisibility = require(script.Parent.utils.useManageBuildNavBarVisibility)
local useOnScreenKeyboardVisible = require(script.Parent.utils.useOnScreenKeyboardVisible)
local FFlagBuildPublishNavigationSheet = require(script.Parent.Flags.FFlagBuildPublishNavigationSheet)
local FFlagBuildExperiencePrivateInvites = require(script.Parent.Flags.FFlagBuildExperiencePrivateInvites)
local FFlagBuildExperienceEventContextTelemetry = require(script.Parent.Flags.FFlagBuildExperienceEventContextTelemetry)

local FFlagBuildExperienceMyCreationsLongPressMenu = require(script.Parent.Flags.FFlagBuildExperienceMyCreationsLongPressMenu)
local FFlagBuildExperiencePreviewsTab = require(script.Parent.Flags.FFlagBuildExperiencePreviewsTab)
local FFlagAppThemeHalloween2026BuildBackground = require(script.Parent.Flags.FFlagAppThemeHalloween2026BuildBackground)
local useThemeBackground = require(BuildExperienceParent.ThemeBackground).useThemeBackground
local FFlagBuildWithGroups = require(script.Parent.Flags.FFlagBuildWithGroups)
local BuildHomeTabsContainer = if FFlagBuildExperiencePreviewsTab then require(script.Parent.Components.BuildHomeTabs.BuildHomeTabsContainer) else nil
local FFlagEnableBuildTabOverride = SharedFlags.FFlagEnableBuildTabOverride
local FFlagBuildExperienceHomeTelemetry = require(script.Parent.Flags.FFlagBuildExperienceHomeTelemetry)
local FFlagBuildExperienceAnalytics = SharedFlags.FFlagBuildExperienceAnalytics
local FFlagBuildExperienceHideNavBarOnSubPages = SharedFlags.FFlagBuildExperienceHideNavBarOnSubPages
local FFlagBuildExperienceChatOpenTelemetry = require(script.Parent.Flags.FFlagBuildExperienceChatOpenTelemetry)
local FFlagBuildExperienceChatOpenId = require(script.Parent.Flags.FFlagBuildExperienceChatOpenId)
local FFlagBuildExperiencePageImpressions = require(script.Parent.Flags.FFlagBuildExperiencePageImpressions)
local useBuildPageImpression = require(BuildExperience.Telemetry.useBuildPageImpression)
local GetAdsCampaignDeepLinkStore = require(BuildExperience.Stores.GetAdsCampaignDeepLinkStore)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local var1 = FFlagBuildAdUpsell or FFlagBuildExperienceMonetizationNativeUI
local bool1 = not FFlagEnableBuildTabOverride
local BuildEligibilityDialog = require(script.Parent.Components.BuildEligibilityDialog)
local useBuildPageEligibility = require(script.Parent.useBuildPageEligibility)
local PublishSheetController = if FFlagBuildPublishNavigationSheet then require(script.Parent.Components.PublishSheet.PublishSheetController) else nil
local useTTINavigationTracking = require(BuildExperienceParent.TTINavigationTracking).useTTINavigationTracking

local tbl2 = {
    BuildHome = "BuildHome",
    BuildChat = BuildNavigationParams.BUILD_CHAT_SCREEN,
    BuildSearch = "BuildSearch",
    BuildAgents = "BuildAgents",
    BuildAgentDetails = "BuildAgentDetails",
    BuildCreatorCredit = "BuildCreatorCredit",
    BuildGetUsers = "BuildGetUsers"
}

local function shouldShowSearchEmptyState(query: string, tbl3) -- Luacid: Inlined by compiler; 2 call sites recovered
    return query == "" or query ~= tbl3.query or tbl3.isSettledNoResults
end

local function findGroup(arg1, name: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil or name == nil then
        return nil
    end

    for _, group in arg1.groups do
        if group.name == name then
            return group
        end
    end

    return nil
end

local function useLiveSubagentTaskState(navigation)
    local target = BuildNavigationParams.getTarget(navigation)
    assert(target ~= nil, "Agent pages require a build target")
    local creatorAgentChatStore = CreatorAgentChat.getCreatorAgentChatStore()
    local var2 = if FFlagBuildExperienceModelPicker then SignalsReact.useSignalState(LocalUserIdStore.getCurrentUserId) else nil

    local var3 = React.useMemo(function()
        return creatorAgentChatStore.getSessionForProject(target.universeId, target.placeId, target.sessionId)
    end, {
        creatorAgentChatStore,
        target.universeId,
        target.placeId,
        target.sessionId,
        var2
    })

    return useSessionSummary(var3).subagentTaskState or BuildNavigationParams.getSubagentTaskState(navigation)
end

local function useOpenBuildChat(navigation, str1: string?)
    local useCallback = React.useCallback

    local function func1(arg1, str2: string?)
        if FFlagBuildExperienceModelPicker then
            arg1 = prepareBuildModelSelectionTarget(arg1)
        end
        if FFlagBuildExperienceChatOpenId then
            arg1 = table.clone(arg1)
            arg1.chatOpenId = game:GetService("HttpService"):GenerateGUID(false)
        end
        if FFlagBuildExperienceChatOpenTelemetry then
            sendBuildExperienceEvent("CHAT_OPEN", {
                universeId = arg1.universeId,
                placeId = arg1.placeId,
                conversationId = if FFlagBuildExperienceEventContextTelemetry then arg1.sessionId else nil,
                chatOpenId = arg1.chatOpenId
            }, {
                isNewGame = tostring(arg1.isNewGameTarget == true),
                context = if FFlagBuildExperienceEventContextTelemetry then str2 or str1 else nil
            })
        end
        navigation.navigate(tbl2.BuildChat, { target = arg1 })
    end

    local var2 = if FFlagBuildExperienceEventContextTelemetry then str1 else nil
    return useCallback(func1, { navigation, var2 })
end

local function useHomeConfigurationPages(navigation)
    local publishSheetTarget, var3 = React.useState(nil)
    local isPublishSheetOpen, var5 = React.useState(false)
    local onClosePublishSheet = React.useCallback(function()
        var5(false)
    end, {})
    local navigateToPublishSubPage = React.useCallback(function(str1: string, target)
        navigation.navigate(str1, { target = target })
    end, { navigation })
    return {
        onOpenConfigurationPage = React.useCallback(function(arg1, target)
            if FFlagBuildPublishNavigationSheet and arg1 == "publish" then
                var3(target)
                var5(true)
                return
            end
            local var8 = BuildOverflowMenuScreens.SCREEN_BY_PAGE[arg1]
            if var8 == nil then
                return
            end
            navigation.navigate(var8, { target = target })
        end, { navigation }),
        publishSheetTarget = publishSheetTarget,
        isPublishSheetOpen = isPublishSheetOpen,
        onClosePublishSheet = onClosePublishSheet,
        navigateToPublishSubPage = navigateToPublishSubPage
    }
end

local function BuildMonetizationScreen(tbl3)
    local navigation = tbl3.navigation
    local target = BuildNavigationParams.getTarget(navigation)
    local var2, var3 = React.useState(false)
    local bool2 = target ~= nil
    local onComposerActivated = React.useCallback(function()
        if bool2 then
            var3(true)
        end
    end, { bool2 })
    local onClose = React.useCallback(function()
        var3(false)
    end, {})

    React.useEffect(function()
        if var2 then
            local var6 = navigation.addListener(RoactNavigation.Events.WillBlur, onClose)
            return function()
                var6.remove()
            end
        end
    end, { var2, navigation, onClose })

    return React.createElement(React.Fragment, nil, {
        Page = React.createElement(
            BuildOverflowMenuScreens.BuildMonetizationScreen,
            { navigation = navigation, onComposerActivated = onComposerActivated }
        ),
        Chat = if var2 and target ~= nil then React.createElement(ChatSheet, {
            autoFocusComposer = true,
            defaultSnapPointIndex = 1,
            isOpen = true,
            onClose = onClose,
            placeId = target.placeId,
            sessionId = target.sessionId,
            snapPoints = snapPoints,
            universeId = target.universeId
        }) else nil
    })
end

local function BuildSearchResults(tbl3)
    local var2 = tbl3.searchQueryStore.useDraftQuery()
    local current = tbl3.closingSnapshot.current
    local results = if current ~= nil then current.results else tbl3.results

    if if current ~= nil then current.showEmptyState else shouldShowSearchEmptyState(var2, results) then
        return React.createElement(SearchEmptyState, { testId = "SearchPage.EmptyState" })
    end

    return React.createElement(ExperienceResultsList, {
        items = results.items,
        hasDisplayedItems = #results.displayedItems > 0,
        hasDisplayedResult = results.hasDisplayedResult,
        hasPendingSummary = results.hasPendingSummary,
        listStatus = results.listStatus,
        failedLoadMore = results.failedLoadMore,
        retryLoadMore = results.retryLoadMore,
        loadError = results.loadError,
        onOpenChat = tbl3.onOpenChat,
        testIdPrefix = "SearchPage"
    })
end

local function BuildSearchScreen(tbl3)
    local var2 = tbl3.screenProps or {}
    local navigation = tbl3.navigation
    local var3 = useBuildPageLayout()
    local var4 = useNavigationFocus()
    local var5 = useOnScreenKeyboardVisible()
    local searchQueryStore = navigation.getParam("searchQueryStore") or var2.searchQueryStore or GetSearchQueryStore()
    local var7 = SignalsReact.useSignalBinding(searchQueryStore.getDraftQuery)
    local var8 = useLocalization({ searchbarPlaceholder = "Feature.Build.Label.SearchGames" })

    local onOpenChat = useOpenBuildChat(navigation, if FFlagBuildExperienceEventContextTelemetry then "search_results" else nil)
    local results = useMyCreationsResults({
        creatorAgentChatStore = var2.creatorAgentChatStore,
        configurationStore = var2.configurationStore,
        searchStore = var2.searchStore,
        searchQueryStore = searchQueryStore,
        isFocused = var4
    })
    local closingSnapshot = React.useRef(nil)
    local current = closingSnapshot.current
    local query = var7:map(function(str1: string)
        local current2 = closingSnapshot.current
        return if current2 == nil then str1 else current2.query
    end)

    local var13 = if current == nil then results else current.results
    local ref = React.useRef(nil)
    useScrollPerformanceTracker("LuaApp_Build_Search_Scroll", ref)
    local createFooter = React.useCallback(function()
        if not var13.isLoadingMore then
            return nil
        end

        return React.createElement(ExperienceResultsLoadingSkeleton, { LayoutOrder = 1, index = 1, testIdPrefix = "SearchPage" })
    end, { var13.isLoadingMore })
    local onBack = React.useCallback(function()
        local draftQuery = searchQueryStore.getDraftQuery()
        closingSnapshot.current = {
            query = draftQuery,
            results = results,
            showEmptyState = shouldShowSearchEmptyState(draftQuery, results)
        }
        searchQueryStore.endSearch()
        navigation.goBack()
    end, {
        closingSnapshot,
        navigation,
        results,
        searchQueryStore
    })
    React.useEffect(function()
        searchQueryStore.beginSearch()
        return searchQueryStore.endSearch
    end, { searchQueryStore })

    return React.createElement(FullscreenPageWithSafeArea, {
        BackgroundColor3 = var3.tokens.Color.Surface.Surface_0.Color3,
        BackgroundTransparency = var3.tokens.Color.Surface.Surface_0.Transparency,
        includeBottomBar = var3.shouldIncludeBottomBar and not var5,
        includeStatusBar = true
    }, {
        Page = React.createElement(SearchPageContainer, {
            ref = ref,
            createFooter = createFooter,
            onBack = onBack,
            onCanvasPositionChangedCallback = var13.loadMoreIfNeeded,
            onCanvasSizeChangedCallback = var13.loadMoreIfNeeded,
            refresh = var13.refresh,
            searchBarProps = {
                clear = searchQueryStore.clear,
                onFocusGained = searchQueryStore.beginSearch,
                placeholder = var8.searchbarPlaceholder,
                query = query,
                setQuery = searchQueryStore.setQuery,
                shouldFocus = var4
            },
            showEmptyState = false
        }, {
            ExperienceResults = React.createElement(
                BuildSearchResults,
                {
                    closingSnapshot = closingSnapshot,
                    onOpenChat = onOpenChat,
                    results = results,
                    searchQueryStore = searchQueryStore
                }
            )
        })
    })
end

local function BuildGetUsersScreen(arg1)
    local navigation = arg1.navigation
    local var2 = useBuildPageLayout()
    local target = BuildNavigationParams.getTarget(navigation)
    local universeId = if target == nil then nil else target.universeId

    if FFlagBuildExperiencePageImpressions then
        useBuildPageImpression("get-users", target)
    end

    local pageTitle = useLocalization({ pageTitle = LocalizationStrings.ADS_STATS_PAGE_TITLE }).pageTitle

    local onClose = React.useCallback(function()
        navigation.goBack()
    end, { navigation })

    local var4 = useAdsStatsPageViewModel(universeId)
    local content = React.createElement(AdsStatsView, var4)
    local gui, ref = React.useState(nil)

    local disableScrolling = not (var4.isLoading or var4.isFailed or var4.hasCampaigns)
    local var7

    if var4.isLoading or var4.isFailed then
        var7 = nil
    else
        local createElement = React.createElement
        local var8 = View
        local tbl3 = { tag = "col size-full-0 auto-y", testId = "BuildPage.GetUsers.Footer" }

        local tbl4 = {
            ToastAnchor = React.createElement(
                View,
                {
                    LayoutOrder = 1,
                    ref = ref,
                    tag = "size-full-0",
                    testId = "BuildPage.GetUsers.ToastAnchor"
                }
            ),
            Actions = 0
        }

        local createElement2 = React.createElement
        local var9 = View
        local tbl5 = {
            LayoutOrder = 2,
            tag = "row size-full-0 auto-y padding-y-medium",
            testId = "BuildPage.GetUsers.Actions"
        }

        local tbl6 = {
            Create = React.createElement(Button, {
                text = var4.createButtonText,
                icon = if var4.createButtonIsExternal then IconName.ArrowUpRightFromSquare else nil,
                size = InputSize.Large,
                variant = ButtonVariant.Emphasis,
                fillBehavior = FillBehavior.Fill,
                width = UDim.new(1, 0),
                isLoading = var4.isPromotionCreatePending,
                onActivated = var4.onCreatePrimary,
                testId = "BuildPage.GetUsers.Create"
            })
        }
        tbl4.Actions = createElement2(var9, tbl5, tbl6)
        var7 = createElement(var8, tbl3, tbl4)
    end

    return React.createElement(FullscreenPageWithSafeArea, {
        BackgroundColor3 = var2.tokens.Color.Surface.Surface_0.Color3,
        BackgroundTransparency = var2.tokens.Color.Surface.Surface_0.Transparency,
        includeBottomBar = var2.shouldIncludeBottomBar,
        includeStatusBar = true
    }, {
        Page = React.createElement(OverflowMenuPageShell, {
            title = pageTitle,
            onClose = onClose,
            content = content,
            footer = var7,
            disableScrolling = disableScrolling,
            headerTrailing = React.createElement(AdsManagerMenuButton, { universeId = universeId, testId = "BuildPage.GetUsersPage.AdsManagerMenu" }),
            scrollPerformanceIntervalName = "LuaApp_Build_GetUsers_Scroll",
            testId = "BuildPage.GetUsersPage"
        }),
        SuccessToast = if var4.showCreateSuccessToast and gui ~= nil then React.createElement(OverlayProvider, {
            gui = gui
        }, {
            Toast = React.createElement(AdCampaignCreatedToast, {
                onClose = var4.onDismissCreateSuccessToast,
                testId = "BuildPage.GetUsers.SuccessToast",
                title = var4.createSuccessToastText
            })
        }) else nil
    })
end

local tbl3 = {
    [tbl2.BuildHome] = {
        screen = function(tbl3) -- name: BuildHomeScreen
            local var2 = tbl3.screenProps or {}
            local navigation = tbl3.navigation
            local var3 = useBuildPageLayout()
            local isFocused = useNavigationFocus()
            local tokens = var3.tokens
            local fallbackExperienceName = useLocalization({ fallbackExperienceName = LocalizationStrings.BUILD_ASSISTANT_FALLBACK_NAME }).fallbackExperienceName

            local onOpenChat = useOpenBuildChat(navigation, if FFlagBuildExperienceEventContextTelemetry then "my_creations" else nil)
            local var6 = if FFlagBuildExperienceMyCreationsLongPressMenu then useHomeConfigurationPages(navigation) else nil
            local publishSheetTarget = if var6 == nil then nil else var6.publishSheetTarget
            local bool2 = if FFlagAppThemeHalloween2026BuildBackground then useThemeBackground() ~= nil else false
            local useEffect = React.useEffect
            local function func1()
                if FFlagBuildAdUpsell then
                    local adsCampaignDeepLinkStore = GetAdsCampaignDeepLinkStore(false)
                    if var2.resumeRequestId then
                        local universeId = if var2.adsCampaignIntent then var2.universeId else nil

                        if adsCampaignDeepLinkStore.begin(var2.resumeRequestId, universeId) and universeId ~= nil then
                            sendBuildExperienceEvent(
                                "AD_CAMPAIGN_DEEP_LINK_RECEIVED",
                                {
                                    universeId = var2.universeId
                                },
                                {
                                    requestId = var2.resumeRequestId
                                }
                            )
                        end
                    else
                        local request = adsCampaignDeepLinkStore.getRequest(false)
                        if request ~= nil then
                            adsCampaignDeepLinkStore.finish(request.id)
                        end
                    end
                end
                return resumeBuildChat({
                    universeId = var2.universeId,
                    sessionId = var2.sessionId,
                    creatorAgentChatStore = var2.creatorAgentChatStore,
                    configurationStore = var2.configurationStore,
                    fallbackExperienceName = fallbackExperienceName,
                    onOpenChat = FFlagBuildExperienceEventContextTelemetry and function(arg1)
                        onOpenChat(arg1, "deep_link")
                    end or onOpenChat
                })
            end

            local universeId = var2.universeId
            local sessionId = var2.sessionId
            local resumeRequestId = var2.resumeRequestId
            local adsCampaignIntent = if FFlagBuildAdUpsell then var2.adsCampaignIntent else nil
            useEffect(func1, {
                onOpenChat,
                universeId,
                sessionId,
                resumeRequestId,
                adsCampaignIntent,
                var2.creatorAgentChatStore,
                var2.configurationStore,
                fallbackExperienceName
            })

            local searchQueryStore = var2.searchQueryStore or GetSearchQueryStore()

            local onOpenSearch = React.useCallback(function()
                local var4 = searchQueryStore
                if FFlagBuildExperienceHomeTelemetry then
                    sendBuildExperienceEvent("SEARCH_OPEN", {}, { context = "home_header" })
                end

                var4.beginSearch()
                navigation.navigate(tbl2.BuildSearch, { searchQueryStore = var4 })
            end, { navigation, searchQueryStore })

            local element = React.createElement(MyCreationsTab, {
                LayoutOrder = 3,
                creatorAgentChatStore = var2.creatorAgentChatStore,
                configurationStore = var2.configurationStore,
                searchStore = var2.searchStore,
                searchQueryStore = var2.searchQueryStore,
                isFocused = isFocused,
                autoOpenNewGame = var2.universeId == nil and var2.sessionId == nil,
                onOpenChat = onOpenChat,
                onOpenConfigurationPage = if var6 == nil then nil else var6.onOpenConfigurationPage
            })

            local createElement = React.createElement
            local var8 = FullscreenPageWithSafeArea
            local tbl4 = {
                BackgroundColor3 = tokens.Color.Surface.Surface_0.Color3,
                BackgroundTransparency = if bool2 then 1 else tokens.Color.Surface.Surface_0.Transparency,
                includeBottomBar = var3.shouldIncludeBottomBar,
                includeStatusBar = true
            }
            local tbl5 = { Page = 0, PublishSheet = 0 }
            local createElement2 = React.createElement
            local var9 = View
            local tbl6 = {
                tag = FFlagAppThemeHalloween2026BuildBackground and {
                    ["col align-x-center size-full"] = true,
                    ["bg-surface-0"] = not bool2
                }
                    or "col align-x-center size-full bg-surface-0"
            }

            local tbl7 = {
                Header = React.createElement(
                    BuildPageHeader,
                    {
                        LayoutOrder = 1,
                        height = var3.topBarHeight,
                        searchQueryStore = searchQueryStore,
                        onOpenSearch = onOpenSearch
                    }
                ),
                Content = 0
            }
            local createElement3 = React.createElement
            local var10 = View
            local tbl8 = {
                LayoutOrder = 2,
                ZIndex = 4,
                tag = "col align-x-center fill gap-small size-full-0"
            }

            local tbl9 = { SearchBarContainer = nil, MyCreations = 0 }

            if FFlagBuildExperiencePreviewsTab then
                element = React.createElement(BuildHomeTabsContainer, {
                    LayoutOrder = 3,
                    gamesContent = element,
                    isFocused = isFocused,
                    searchStore = var2.searchStore,
                    searchQueryStore = searchQueryStore
                })
            end

            tbl9.MyCreations = element
            tbl7.Content = createElement3(var10, tbl8, tbl9)
            tbl5.Page = createElement2(var9, tbl6, tbl7)

            tbl5.PublishSheet = if FFlagBuildPublishNavigationSheet and var6 ~= nil and publishSheetTarget ~= nil and publishSheetTarget.universeId ~= nil then React.createElement(
                PublishSheetController,
                {
                    isOpen = var6.isPublishSheetOpen,
                    target = publishSheetTarget,
                    onClose = var6.onClosePublishSheet,
                    navigateToSubPage = var6.navigateToPublishSubPage
                }
            ) else nil
            return createElement(var8, tbl4, tbl5)
        end
    }
}

local tbl4 = {
    [tbl2.BuildChat] = {
        screen = function(tbl4) -- name: BuildChatScreen
            local navigation = tbl4.navigation
            local target = BuildNavigationParams.getTarget(navigation)
            local initialPrompt = if FFlagBuildExperienceAnalytics then BuildNavigationParams.getInitialPrompt(navigation) else nil
            local buildExperienceRefreshStore = GetBuildExperienceRefreshStore()
            local var2 = useBuildPageLayout()

            local var3 = not var1 or useNavigationFocus()
            local var4 = useOnScreenKeyboardVisible()
            local var5, var6 = React.useState(false)
            local isOpen, var8 = React.useState(false)

            if FFlagBuildExperienceModelPicker then
                local var9 = SignalsReact.useSignalState(LocalUserIdStore.getCurrentUserId)

                React.useLayoutEffect(function()
                    if target == nil or not ((tonumber(var9) or 0) > 0) then
                        return
                    end

                    local var7 = prepareBuildModelSelectionTarget(target)
                    if var7 ~= target then
                        navigation.setParams({ target = var7 })
                    end
                end, { var9, target, navigation })

                local modelSelectionDraftId = if target == nil then nil else target.modelSelectionDraftId

                React.useEffect(function()
                    return function()
                        if modelSelectionDraftId ~= nil then
                            GetBuildModelSelectionStore(false).discardDraft(modelSelectionDraftId)
                        end
                    end
                end, { modelSelectionDraftId })
            end

            local onClose = React.useCallback(function()
                if FFlagBuildWithGroups and target ~= nil and target.isNewGameTarget == true and target.universeId ~= nil then
                    require(script.Parent.Stores.GetMyCreationsFilterStore)().setFilter({ games = "MyGames" })
                    if FFlagBuildExperiencePreviewsTab then
                        require(script.Parent.Stores.GetBuildHomeTabStore)().setTab("Games")
                    end
                end

                navigation.goBack()
            end, { navigation, target })

            local var7 = React.useCallback(function()
                var8(false)
            end, {})

            local onOpenConfigurationPage = React.useCallback(function(arg1)
                if FFlagBuildPublishNavigationSheet and arg1 == "publish" then
                    var8(true)
                    return
                end
                local var11 = BuildOverflowMenuScreens.SCREEN_BY_PAGE[arg1]
                if var11 == nil then
                    return
                end
                navigation.navigate(var11, { target = target })
            end, { navigation, target })

            local onOpenInvitePicker = React.useCallback(function()
                var6(true)
            end, {})
            local var9 = React.useCallback(function()
                var6(false)
            end, {})

            local onOpenInviteManagement = React.useCallback(function()
                navigation.navigate(BuildOverflowMenuScreens.Screens.BuildPlaytestInviteManagement, { target = target })
            end, { navigation, target })

            local onOpenLibrary = if FFlagBuildExperienceLibrary then React.useCallback(function(str1: string?)
                local placeId = if target == nil then nil else target.placeId

                if placeId ~= nil then
                    openLibrary(placeId, str1)
                end
            end, { target }) else nil

            local onInvitesSent = React.useCallback(function()
                var6(false)
                if FFlagBuildExperiencePrivateInvites then
                    onOpenInviteManagement()
                end
            end, { onOpenInviteManagement })
            local onOpenAgentsPage = React.useCallback(function()
                navigation.navigate(tbl2.BuildAgents, { target = target })
            end, { navigation, target })
            local onOpenCreatorCreditPage = React.useCallback(function()
                navigation.navigate(tbl2.BuildCreatorCredit, { target = target })
            end, { navigation, target })

            local navigateToSubPage = React.useCallback(function(str1: string, target2)
                navigation.navigate(str1, { target = target2 })
            end, { navigation })

            local onOpenGetUsersPage = if FFlagEnableBuildAdPromotion then React.useCallback(function()
                navigation.navigate(tbl2.BuildGetUsers, { target = target })
            end, { navigation, target }) else nil

            local onNavigateToResolvedTarget = React.useCallback(function(target2)
                navigation.setParams({ target = target2 })

                buildExperienceRefreshStore.bumpRefreshTick()
            end, { navigation, buildExperienceRefreshStore })

            local var22

            if target == nil then
                var22 = nil
            else
                local createElement = React.createElement
                local var23 = BuildChatPage
                local tbl5 = {
                    target = target,
                    onOpenLibrary = onOpenLibrary,
                    initialPrompt = initialPrompt,
                    onClose = onClose,
                    onOpenAgentsPage = onOpenAgentsPage,
                    onOpenCreatorCreditPage = onOpenCreatorCreditPage,
                    onOpenGetUsersPage = onOpenGetUsersPage,
                    onOpenConfigurationPage = onOpenConfigurationPage,
                    onOpenInvitePicker = onOpenInvitePicker,
                    onOpenInviteManagement = onOpenInviteManagement,
                    onNavigateToResolvedTarget = onNavigateToResolvedTarget,
                    isFocused = 0
                }

                if not var1 then
                    var3 = nil
                end

                tbl5.isFocused = var3
                var22 = createElement(var23, tbl5)
            end

            local universeId = if target == nil then nil else target.universeId
            return React.createElement(React.Fragment, nil, {
                Page = React.createElement(FullscreenPageWithSafeArea, {
                    BackgroundColor3 = var2.tokens.Color.Surface.Surface_0.Color3,
                    BackgroundTransparency = var2.tokens.Color.Surface.Surface_0.Transparency,
                    includeBottomBar = var2.shouldIncludeBottomBar and not var4,
                    includeStatusBar = true
                }, { Page = var22 }),
                Picker = if var5 and universeId ~= nil then React.createElement(
                    PrivateInvitesPickerHost,
                    { universeId = universeId, onClose = var9, onInvitesSent = onInvitesSent }
                ) else nil,
                PublishSheet = if FFlagBuildPublishNavigationSheet and target ~= nil and target.universeId ~= nil then React.createElement(
                    PublishSheetController,
                    {
                        isOpen = isOpen,
                        target = target,
                        onClose = var7,
                        navigateToSubPage = navigateToSubPage
                    }
                ) else nil
            })
        end
    }
}

local tbl5 = {
    [BuildOverflowMenuScreens.Screens.BuildPublish] = {
        screen = BuildOverflowMenuScreens.BuildPublishScreen
    }
}
local tbl6 = {
    [BuildOverflowMenuScreens.Screens.BuildSettings] = {
        screen = BuildOverflowMenuScreens.BuildSettingsScreen
    }
}
local tbl7 = {
    [BuildOverflowMenuScreens.Screens.BuildAudience] = {
        screen = BuildOverflowMenuScreens.BuildAudienceScreen
    }
}
local tbl8 = {
    [BuildOverflowMenuScreens.Screens.BuildPlaytestInviteManagement] = {
        screen = BuildOverflowMenuScreens.BuildPlaytestInviteManagementScreen
    }
}
local tbl9 = {
    [BuildOverflowMenuScreens.Screens.BuildTitleDescription] = {
        screen = BuildOverflowMenuScreens.BuildTitleDescriptionScreen
    }
}
local tbl10 = {
    [BuildOverflowMenuScreens.Screens.BuildVersionTitleDescription] = {
        screen = BuildOverflowMenuScreens.BuildVersionTitleDescriptionScreen
    }
}
local tbl11 = {
    [BuildOverflowMenuScreens.Screens.BuildMediaSelection] = {
        screen = BuildOverflowMenuScreens.BuildMediaSelectionScreen
    }
}

local tbl12 = {
    [tbl2.BuildAgents] = {
        screen = function(tbl12) -- name: BuildAgentsScreen
            local navigation = tbl12.navigation
            local var2 = useBuildPageLayout()
            local var3 = useLiveSubagentTaskState(navigation)
            local agents = useLocalization({ agents = LocalizationStrings.SUBAGENT_STATUS_AGENTS }).agents

            local onClose = React.useCallback(function()
                navigation.goBack()
            end, { navigation })
            local onAgentActivated = React.useCallback(function(arg1)
                navigation.navigate(
                    tbl2.BuildAgentDetails,
                    {
                        target = BuildNavigationParams.getTarget(navigation),
                        subagentTaskGroupName = arg1.name
                    }
                )
            end, { navigation })

            local content = React.createElement(
                SubagentStatus.AgentsList,
                {
                    groups = var3 == nil and {} or var3.groups,
                    onAgentActivated = onAgentActivated,
                    testId = "BuildPage.AgentsList"
                }
            )

            return React.createElement(FullscreenPageWithSafeArea, {
                BackgroundColor3 = var2.tokens.Color.Surface.Surface_0.Color3,
                BackgroundTransparency = var2.tokens.Color.Surface.Surface_0.Transparency,
                includeBottomBar = var2.shouldIncludeBottomBar,
                includeStatusBar = true
            }, {
                Page = React.createElement(OverflowMenuPageShell, {
                    title = agents,
                    onClose = onClose,
                    content = content,
                    scrollPerformanceIntervalName = "LuaApp_Build_Agents_Scroll",
                    testId = "BuildPage.AgentsPage"
                })
            })
        end
    }
}

local tbl13 = {
    [tbl2.BuildAgentDetails] = {
        screen = function(tbl13) -- name: BuildAgentDetailsScreen
            local navigation = tbl13.navigation
            local var2 = useBuildPageLayout()
            local var3 = useLiveSubagentTaskState(navigation)
            local title = BuildNavigationParams.getSubagentTaskGroupName(navigation)
            local group = findGroup(var3, title)
            local agents = useLocalization({ agents = LocalizationStrings.SUBAGENT_STATUS_AGENTS }).agents

            local onClose = React.useCallback(function()
                navigation.goBack()
            end, { navigation })

            local content = if group ~= nil then React.createElement(SubagentStatus.AgentDetailsList, { group = group, testId = "BuildPage.AgentDetailsList" }) else React.createElement(View, { tag = "size-full" })
            return React.createElement(FullscreenPageWithSafeArea, {
                BackgroundColor3 = var2.tokens.Color.Surface.Surface_0.Color3,
                BackgroundTransparency = var2.tokens.Color.Surface.Surface_0.Transparency,
                includeBottomBar = var2.shouldIncludeBottomBar,
                includeStatusBar = true
            }, {
                Page = React.createElement(OverflowMenuPageShell, {
                    title = title or agents,
                    onClose = onClose,
                    content = content,
                    scrollPerformanceIntervalName = "LuaApp_Build_AgentDetails_Scroll",
                    testId = "BuildPage.AgentDetailsPage"
                })
            })
        end
    }
}

local tbl14 = {
    [tbl2.BuildCreatorCredit] = {
        screen = function(tbl14) -- name: BuildCreatorCreditScreen
            local navigation = tbl14.navigation
            if FFlagBuildExperiencePageImpressions then
                useBuildPageImpression("creator-credit-ai-usage", BuildNavigationParams.getTarget(navigation))
            end
            local var2 = useBuildPageLayout()
            local pageTitle = useLocalization({ pageTitle = LocalizationStrings.CREATOR_CREDIT_PAGE_TITLE }).pageTitle

            local onClose = React.useCallback(function()
                navigation.goBack()
            end, { navigation })

            local content = React.createElement(CreatorCreditPageContainer, nil)

            return React.createElement(FullscreenPageWithSafeArea, {
                BackgroundColor3 = var2.tokens.Color.Surface.Surface_0.Color3,
                BackgroundTransparency = var2.tokens.Color.Surface.Surface_0.Transparency,
                includeBottomBar = var2.shouldIncludeBottomBar,
                includeStatusBar = true
            }, {
                Page = React.createElement(OverflowMenuPageShell, {
                    title = pageTitle,
                    onClose = onClose,
                    content = content,
                    headerTrailing = React.createElement(CreatorCreditBalanceChipContainer),
                    scrollPerformanceIntervalName = "LuaApp_Build_CreatorCredit_Scroll",
                    testId = "BuildPage.CreatorCreditPage"
                })
            })
        end
    }
}

local tbl15 = {
    tbl3,
    tbl4,
    tbl5,
    tbl6,
    tbl7,
    tbl8,
    tbl9,
    tbl10,
    tbl11,
    tbl12,
    tbl13,
    tbl14
}

if FFlagBuildExperienceMonetizationNativeUI then
    table.insert(tbl15, { [BuildOverflowMenuScreens.Screens.BuildMonetization] = { screen = BuildMonetizationScreen } })
end

if FFlagBuildExperienceAnalytics then
    table.insert(
        tbl15,
        {
            [BuildOverflowMenuScreens.Screens.BuildStats] = {
                screen = BuildOverflowMenuScreens.BuildStatsScreen
            }
        }
    )
end
if FFlagEnableBuildAdPromotion then
    table.insert(tbl15, { [tbl2.BuildGetUsers] = { screen = BuildGetUsersScreen } })
end

table.insert(tbl15, { [tbl2.BuildSearch] = { screen = BuildSearchScreen } })

local robloxStackNavigator = RoactNavigation.createRobloxStackNavigator(tbl15, { initialRouteName = tbl2.BuildHome })

local function BuildPage(tbl16)
    useTTINavigationTracking("NavigateTo_" .. tbl16.navigation.state.routeName)

    local screenProps = tbl16.navigation.getParam("extraProps", {})
    local var2 = useBuildPageEligibility.useBuildPageEligibility(bool1)
    if FFlagBuildExperienceHideNavBarOnSubPages then
        useManageBuildNavBarVisibility(tbl16.navigation, tbl2.BuildHome)
    end
    if var2.canEnterBuild then
        return React.createElement(robloxStackNavigator, { navigation = tbl16.navigation, screenProps = screenProps })
    elseif var2.status == useBuildPageEligibility.Status.Ineligible then
        return React.createElement(
            BuildEligibilityDialog,
            {
                variant = useBuildPageEligibility.Status.Ineligible,
                onDismiss = var2.onDialogDismiss
            }
        )
    elseif var2.status == useBuildPageEligibility.Status.Error then
        return React.createElement(
            BuildEligibilityDialog,
            {
                variant = useBuildPageEligibility.Status.Error,
                onDismiss = var2.onDialogDismiss
            }
        )
    elseif var2.status == useBuildPageEligibility.Status.Refreshing then
        return React.createElement(
            View,
            {
                tag = "col align-x-center align-y-center size-full",
                testId = "BuildPage.EligibilityLoading"
            },
            {
                Spinner = React.createElement(Loading, { size = IconSize.Large })
            }
        )
    end

    return React.createElement(View, { tag = "size-full", testId = "BuildPage.EligibilityPrompting" })
end

local var2 = React.Component:extend("BuildPageScreen")

function var2.render(arg1)
    return React.createElement(BuildPage, arg1.props)
end

var2.router = robloxStackNavigator.router

return var2
