-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppPage = require(AppChatParent.RobloxAppEnums).AppPage
local Constants = require(AppChat.Constants)
local EnumScreens = require(AppChat.EnumScreens)
local ChatTopBarBase = require(script.Parent.ChatTopBarBase)
local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)
local SearchTopBar = require(AppChat.Components.ChatLanding.SearchTopBar)
local ChatLandingSearchRow = require(script.Parent.ChatLandingSearchRow)
local SnoozeToastNotificationsButton = require(AppChat.Components.ChatLanding.SnoozeToastNotificationsButton)
local useChatLandingVisibility = require(AppChat.Hooks.useChatLandingVisibility)

local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local UIBlox = require(AppChatParent.UIBlox)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local useSignalState = require(AppChatParent.SignalsReact).useSignalState

local useTelemetry = require(AppChat.Telemetry.useTelemetry)
local ChatLandingTelemetryLayer = require(AppChat.Telemetry.Layers.ChatLandingTelemetryLayer)
local ChatLandingTelemetryEvents = require(AppChat.Components.ChatLanding.ChatLandingTelemetryEvents)
local StreamNotificationsBellIcon = require(AppChatParent.StreamNotifications).StreamNotificationsBellIcon

local IconButton = UIBlox.App.Button.IconButton
local Images = UIBlox.App.ImageSet.Images
local DomLocators = require(AppChat.Utils.DomLocators)

local SharedFlags = require(AppChatParent.SharedFlags)
local GetFFlagIsSquadEnabled = SharedFlags.GetFFlagIsSquadEnabled
local FFlagAppChatFoundationSearchInput = require(AppChat.Flags.FFlagAppChatFoundationSearchInput)
local FFlagAppChatWideAlwaysVisibleSearchBox = require(AppChat.Flags.FFlagAppChatWideAlwaysVisibleSearchBox)
local FFlagEnableHeaderBarButtonsUpdate = SharedFlags.FFlagEnableHeaderBarButtonsUpdate
local FFlagStreamNotificationBellEntryPoint = SharedFlags.FFlagStreamNotificationBellEntryPoint
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)
local FFlagAppChatLandingNotifBtnTelemetry = require(AppChat.Flags.FFlagAppChatLandingNotifBtnTelemetry)
local FlyoutLeftHeader = require(AppChatParent.FlyoutSidePanel).Components.FlyoutLeftHeader
local FlyoutSidePanelIXP = require(AppChatParent.SharedExperimentDefinition).FlyoutSidePanelIXP

local function SearchTopBarWrapper()
    local topBarStore = GetTopBarStore(false)
    local setScreenTopBar = topBarStore.setScreenTopBar
    local var1 = topBarStore.getScreenTopBar(EnumScreens.ChatLanding)(false)

    local var2 = useLocalization({ searchPlaceholderText = "Feature.Chat.Label.SearchWord", cancelText = "Feature.Chat.Action.Cancel" })

    local onSelectCallback = React.useCallback(function()
        local closeInputBar = var1.closeInputBar
        if closeInputBar then
            closeInputBar()
        end
    end, { var1.closeInputBar })

    local resetOnMount = React.useCallback(function()
        setScreenTopBar(EnumScreens.ChatLanding, { shouldAutoFocusCenter = false })
    end, { setScreenTopBar })

    local cancelCallback = React.useCallback(function()
        setScreenTopBar(EnumScreens.ChatLanding, { shouldRenderCenter = false, filterText = "" })
    end, { setScreenTopBar })

    local textChangedCallback = React.useCallback(function(filterText)
        setScreenTopBar(EnumScreens.ChatLanding, { filterText = filterText })
    end, { setScreenTopBar })

    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }, {
        filterBox = React.createElement(SearchTopBar, {
            initialInputText = var1.filterText,
            cancelText = var2.cancelText,
            searchPlaceholderText = var2.searchPlaceholderText,
            captureFocusOnMount = var1.shouldAutoFocusCenter,
            onSelectCallback = onSelectCallback,
            resetOnMount = resetOnMount,
            cancelCallback = cancelCallback,
            textChangedCallback = textChangedCallback
        })
    })
end

local function func1()
    return React.createElement(SearchTopBarWrapper)
end

local function ChatLandingTopBar(tbl1)
    local screenName = tbl1.screenName
    local navigation = tbl1.navigation
    local screenProps = navigation.getScreenProps("isInExperience", false)
    local screenProps2 = navigation.getScreenProps("wideMode", false)
    local iconButtonWidth = Constants:GetIconButtonWidth(screenProps2)

    local topBarStore = GetTopBarStore(false)
    local setScreenTopBar = topBarStore.setScreenTopBar
    local screenTopBar = topBarStore.getScreenTopBar(screenName)
    local var1 = useSignalState(screenTopBar)

    local var2 = useChatLandingVisibility()
    local var3 = useTelemetry(ChatLandingTelemetryLayer.Context)

    local shouldRenderCenter = var1.shouldRenderCenter
    local rightHidden = var1.rightHidden
    local var4 = var1.headerText or { raw = "", shouldLocalize = false }

    local var5 = useLocalization({ headerText = if var4.shouldLocalize then var4.raw or nil else nil })

    local titleText = var4.shouldLocalize and var5.headerText or var4.raw or ""

    local var7 = React.useCallback(function()
        return React.createElement(ChatLandingSearchRow, { exitVariant = if screenProps2 then "Cancel" else "Chevron" })
    end, { screenProps2 })

    if shouldRenderCenter then
        if not FFlagAppChatFoundationSearchInput then
            var7 = func1
        end
    else
        var7 = nil
    end

    local onActivated = React.useCallback(function()
        setScreenTopBar(
            EnumScreens.ChatLanding,
            { shouldRenderCenter = true, shouldAutoFocusCenter = true, isSecondary = true }
        )

        var3.emit(ChatLandingTelemetryEvents.ChatLandingSearchBtnClicked, {})
    end, { var3, setScreenTopBar })

    local var6 = React.useCallback(function()
        navigation.navigate(EnumScreens.CreateNewChat)
        var3.emit(ChatLandingTelemetryEvents.ChatLandingComposeBtnClicked, {})
    end, { var3, navigation })

    local var10 = React.useCallback(function()
        var3.emit(ChatLandingTelemetryEvents.ChatLandingNotifBtnClicked, {})
    end, { var3 })

    local var11 = React.useCallback(function()
        return React.createElement(FlyoutLeftHeader, {
            titleText = titleText,
            isFlyoutEntrypointEnabled = FlyoutSidePanelIXP.isFlyoutSidePanelEnabled(),
            isAlternateEntryPointEnabled = FlyoutSidePanelIXP.isAlternateEntryPointEnabled()
        })
    end, { titleText })

    local topBarShowSearch = var2.topBarShowSearch

    if FFlagAppChatWideAlwaysVisibleSearchBox and screenProps2 then
        topBarShowSearch = false
    end
    local topBarShowCreateChatGroup = var2.topBarShowCreateChatGroup
    local topBarShowNotifications = var2.topBarShowNotifications
    local topBarShowSnoozeNotifications = var2.topBarShowSnoozeNotifications
    local notificationCount = var2.notificationCount

    local useCallback = React.useCallback
    local function func2()
        if rightHidden then
            return nil
        end

        if FFlagEnableHeaderBarButtonsUpdate then
            local createElement = React.createElement
            local view = Foundation.View
            local tbl2 = { tag = "row align-x-right align-y-center gap-xsmall auto-xy" }

            local tbl3 = {
                filter = if topBarShowSearch then React.createElement(Foundation.IconButton, {
                    size = Foundation.Enums.InputSize.Medium,
                    isCircular = true,
                    icon = Foundation.Enums.IconName.MagnifyingGlass,
                    testId = if FFlagDebugAppChatEnableDomLocators then DomLocators.chatLandingTopBarIconButton("search") else nil,
                    LayoutOrder = 1,
                    onActivated = onActivated
                }) else nil,
                createNewChat = if topBarShowCreateChatGroup then React.createElement(Foundation.IconButton, {
                    size = Foundation.Enums.InputSize.Medium,
                    isCircular = true,
                    icon = Foundation.Enums.IconName.PencilSquare,
                    testId = if FFlagDebugAppChatEnableDomLocators then DomLocators.chatLandingTopBarIconButton("createChat") else nil,
                    LayoutOrder = 2,
                    onActivated = var6
                }) else nil,
                notifications = if topBarShowNotifications then React.createElement(StreamNotificationsBellIcon, {
                    notificationCount = notificationCount,
                    layoutOrder = 3,
                    entryPoint = if FFlagStreamNotificationBellEntryPoint then AppPage.Chat else nil,
                    onActivated = if FFlagAppChatLandingNotifBtnTelemetry then var10 else nil,
                    testId = if FFlagDebugAppChatEnableDomLocators then DomLocators.chatLandingTopBarIconButton("notifications") else nil
                }) else nil,
                snoozeChatNotifications = if topBarShowSnoozeNotifications then React.createElement(SnoozeToastNotificationsButton, { layoutOrder = 4, size = UDim2.new(0, iconButtonWidth, 1, 0) }) else nil
            }
            return createElement(view, tbl2, tbl3)
        end

        local createElement = React.createElement
        local fragment = React.Fragment
        local var12 = nil
        local tbl2 = {
            filter = 0,
            createNewChat = 0,
            notifications = 0,
            snoozeChatNotifications = 0
        }
        local var13 = topBarShowSearch

        if var13 then
            if FFlagDebugAppChatEnableDomLocators then
                var13 = React.createElement(Foundation.IconButton, {
                    size = Foundation.Enums.InputSize.Medium,
                    isCircular = true,
                    icon = Foundation.Enums.IconName.MagnifyingGlass,
                    testId = DomLocators.chatLandingTopBarIconButton("search"),
                    LayoutOrder = 1,
                    onActivated = onActivated
                })
            else
                var13 = React.createElement(IconButton, {
                    size = UDim2.new(0, iconButtonWidth, 1, 0),
                    icon = Images["icons/common/search"],
                    layoutOrder = 1,
                    onActivated = onActivated
                })
            end
        end

        tbl2.filter = var13

        local var14 = topBarShowCreateChatGroup

        if var14 then
            if FFlagDebugAppChatEnableDomLocators then
                var14 = React.createElement(Foundation.IconButton, {
                    size = Foundation.Enums.InputSize.Medium,
                    isCircular = true,
                    icon = Foundation.Enums.IconName.PlusLarge,
                    testId = DomLocators.chatLandingTopBarIconButton("createChat"),
                    LayoutOrder = 2,
                    onActivated = var6
                })
            else
                var14 = React.createElement(IconButton, {
                    size = UDim2.new(0, iconButtonWidth, 1, 0),
                    icon = if GetFFlagIsSquadEnabled() then Images["icons/common/plus"] else Images["icons/actions/compose"],
                    layoutOrder = 2,
                    onActivated = var6
                })
            end
        end

        tbl2.createNewChat = var14

        local var15 = topBarShowNotifications

        if var15 then
            if FFlagDebugAppChatEnableDomLocators then
                local createElement2 = React.createElement
                local view = Foundation.View
                local tbl3 = {
                    Size = UDim2.new(0, iconButtonWidth, 0, iconButtonWidth),
                    tag = "row align-x-center align-y-center radius-circle",
                    testId = DomLocators.chatLandingTopBarIconButton("notifications")
                }
                local tbl4 = {
                    BellIcon = React.createElement(StreamNotificationsBellIcon, {
                        notificationCount = notificationCount,
                        compactWidth = not screenProps2,
                        entryPoint = if FFlagStreamNotificationBellEntryPoint then AppPage.Chat else nil,
                        onActivated = if FFlagAppChatLandingNotifBtnTelemetry then var10 else nil
                    })
                }
                var15 = createElement2(view, tbl3, tbl4)
            else
                var15 = React.createElement(StreamNotificationsBellIcon, {
                    notificationCount = notificationCount,
                    compactWidth = not screenProps2,
                    layoutOrder = 3,
                    entryPoint = if FFlagStreamNotificationBellEntryPoint then AppPage.Chat else nil,
                    onActivated = if FFlagAppChatLandingNotifBtnTelemetry then var10 else nil
                })
            end
        end

        tbl2.notifications = var15

        tbl2.snoozeChatNotifications = if topBarShowSnoozeNotifications then React.createElement(SnoozeToastNotificationsButton, { layoutOrder = 4, size = UDim2.new(0, iconButtonWidth, 1, 0) }) else nil
        return createElement(fragment, var12, tbl2)
    end

    local var12 = if FFlagAppChatLandingNotifBtnTelemetry then var10 else false
    local var13 = useCallback(func2, {
        iconButtonWidth,
        notificationCount,
        var6,
        onActivated,
        var12,
        rightHidden,
        topBarShowCreateChatGroup,
        topBarShowNotifications,
        topBarShowSearch,
        topBarShowSnoozeNotifications,
        screenProps2
    })

    local hideTitle = FlyoutSidePanelIXP.isFlyoutSidePanelEnabled() and not screenProps

    local createElement = React.createElement
    local var15 = ChatTopBarBase
    local tbl2 = {
        screenName = screenName,
        navigation = navigation,
        renderRight = 0,
        renderCenter = 0,
        renderLeft = 0,
        hideTitle = 0
    }

    if shouldRenderCenter then
        var13 = nil
    end

    tbl2.renderRight = var13
    tbl2.renderCenter = var7
    if not hideTitle then
        var11 = nil
    end

    tbl2.renderLeft = var11
    tbl2.hideTitle = hideTitle
    return createElement(var15, tbl2)
end

return ChatLandingTopBar
