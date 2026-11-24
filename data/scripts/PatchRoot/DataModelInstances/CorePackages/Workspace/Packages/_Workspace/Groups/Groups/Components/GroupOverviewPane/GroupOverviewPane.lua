-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent

local AppPage = require(GroupsParent.RobloxAppEnums).AppPage
local CompositionTags = require(GroupsParent.AppComposition).CompositionTags
local Foundation = require(GroupsParent.Foundation)
local Navigation = require(GroupsParent.Navigation)
local React = require(GroupsParent.React)
local SduiSharedUtilities = require(GroupsParent.SduiSharedUtilities)

local FFlagGroupSduiPublishContainerWidth = require(GroupsParent.SharedFlags).FFlagGroupSduiPublishContainerWidth

local useGroupsWrapperContext = require(Groups.Contexts.useGroupsWrapperContext)
local getGroupOverviewPaneConfig = require(Groups.Common.getGroupOverviewPaneConfig)
local fetchGroupOverviewPane = require(Groups.Common.fetchGroupOverviewPane)

local View = Foundation.View
local SduiPageEntryPoint = SduiSharedUtilities.SduiPageEntryPoint
local SduiPageNavigationHeader = SduiSharedUtilities.SduiPageNavigationHeader
local SduiPageAnalytics = SduiSharedUtilities.SduiPageAnalytics
local SduiSurfaceLoadTimeTracker = SduiSharedUtilities.SduiSurfaceLoadTimeTracker
local UiStatus = SduiSharedUtilities.UiStatus
local useComponentConfig = SduiSharedUtilities.useComponentConfig
local usePageScopeRef = SduiSharedUtilities.usePageScopeRef
local usePublishContainerWidth = SduiSharedUtilities.usePublishContainerWidth
local useUiStatus = SduiSharedUtilities.useUiStatus

local function createPageTimer(config, page: string)
    local loadTimerWithSurfaceLoadTime = SduiSurfaceLoadTimeTracker.createLoadTimerWithSurfaceLoadTime(
        config.configKey,
        {
            eventName = "GroupOverviewPane_SurfaceLoadTime",
            metadata = { page = page }
        },
        function(arg1)
            local var1 = table.clone(arg1)
            var1.pageKey = config.surfaceKey
            SduiPageAnalytics.sendLoadTimerEvent(var1)
        end
    )

    loadTimerWithSurfaceLoadTime.start(page)
    return loadTimerWithSurfaceLoadTime
end

local function useFinishPageTimerWhenEmpty(configKey: string, bool1: boolean)
    local var1 = useUiStatus(configKey)
    local bool2 = useComponentConfig(configKey, nil) ~= nil
    local bool3 = var1 == UiStatus.Resolved and not bool2

    React.useEffect(function()
        if bool3 then
            bool1.logComponentReady()
        end
    end, { bool1, bool3 })
end

local function ContainerWidthFrame(tbl1)
    local ref = usePublishContainerWidth(tbl1.configKey)
    return React.createElement(
        "Frame",
        {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ref = ref
        },
        tbl1.children
    )
end

local function GroupOverviewPaneContent(tbl1)
    local config = tbl1.config
    local routeName = Navigation.useRouteName()
    usePageScopeRef(config.configKey)
    local var2 = React.useMemo(function()
        return (createPageTimer(config, "mount"))
    end, { config })

    local var3, var4 = React.useState(nil)
    local pageTimer = var3 or var2

    React.useEffect(function()
        fetchGroupOverviewPane(config, var2)
    end, { config, var2 })

    local refresh = React.useCallback(function()
        local pageTimer = createPageTimer(config, "refresh")
        var4(pageTimer)
        fetchGroupOverviewPane(config, pageTimer, true)
    end, { config })

    useFinishPageTimerWhenEmpty(config.configKey, pageTimer)

    local additionalAnalyticsData = React.useMemo(function()
        return {
            source = tbl1.source
        }
    end, { tbl1.source })

    local page = React.createElement(SduiPageEntryPoint, {
        appPage = AppPage.Groups,
        routeName = routeName,
        configKey = config.configKey,
        pageTimer = pageTimer,
        includeNavigationHeaderBar = tbl1.includeNavigationHeaderBar,
        onCloseActivated = tbl1.onCloseActivated,
        refresh = refresh,
        disableRootPadding = true,
        additionalAnalyticsData = additionalAnalyticsData
    })
    if not FFlagGroupSduiPublishContainerWidth then
        return page
    end

    return React.createElement(ContainerWidthFrame, { configKey = config.configKey }, { Page = page })
end

local function GroupOverviewPaneEmpty(tbl1)
    return React.createElement(View, { testId = "GroupOverviewPane.Empty", tag = "col size-full" }, {
        Header = if tbl1.onBackActivated then React.createElement(SduiPageNavigationHeader, {
            contentTag = CompositionTags.ContentRegion.Header,
            layoutOrder = 1,
            navButtonType = "back",
            closeCallback = tbl1.onBackActivated
        }) else nil
    })
end

return React.memo(function(tbl1) -- name: GroupOverviewPane
    local navigation = tbl1.navigation
    local var1 = if tbl1.groupId ~= nil then tbl1.groupId elseif navigation then navigation.getParam("groupId", nil) else nil
    local source = if tbl1.source ~= nil then tbl1.source elseif navigation then navigation.getParam("source", nil) else nil
    local goBack = if navigation then navigation.goBack else nil
    local var3 = useGroupsWrapperContext()
    local config = React.useMemo(function()
        return getGroupOverviewPaneConfig(var3.userId, var1)
    end, { var3.userId, var1 })

    return React.createElement(View, {
        testId = "GroupOverviewPane",
        tag = "size-full clip bg-surface-0"
    }, {
        Content = if config then React.createElement(GroupOverviewPaneContent, {
            key = config.configKey,
            config = config,
            includeNavigationHeaderBar = navigation ~= nil,
            onCloseActivated = goBack,
            source = source
        }) else React.createElement(GroupOverviewPaneEmpty, { onBackActivated = goBack })
    })
end)
