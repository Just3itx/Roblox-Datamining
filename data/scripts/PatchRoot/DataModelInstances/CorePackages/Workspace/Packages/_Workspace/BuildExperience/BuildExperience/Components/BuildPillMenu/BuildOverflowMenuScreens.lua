-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _DataHydration = require(BuildExperienceParent.DataHydration)
local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local SharedFlags = require(BuildExperienceParent.SharedFlags)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local FFlagBuildExperienceAnalytics = SharedFlags.FFlagBuildExperienceAnalytics

local FullscreenPageWithSafeArea = require(BuildExperienceParent.AppBlox).FullscreenPageWithSafeArea
local View = Foundation.View

local AudienceConfigurationContent = require(BuildExperience.Components.GameConfigurations.AudienceConfigurationContent.AudienceConfigurationContent)
local PrivateInvitesPickerContainer = require(BuildExperience.Components.PrivateInvitesPicker.PrivateInvitesPickerContainer)
local PrivateInvitesPickerHost = require(BuildExperience.Components.PrivateInvitesPicker.PrivateInvitesPickerHost)

local PrivateInvitesManagementContainer = require(BuildExperience.Components.GameConfigurations.PrivateInvitesManagement.PrivateInvitesManagementContainer)
local BuildOverflowMenuPage = require(script.Parent.BuildOverflowMenuPage)
local OverflowMenuPageShell = require(script.Parent.OverflowMenuPageShell)
local TitleDescriptionPage = require(BuildExperience.Components.TitleDescriptionPage.TitleDescriptionPage)
local MediaSelectionPage = require(BuildExperience.Components.MediaSelectionPage.MediaSelectionPage)
local MonetizationPageContainer = require(BuildExperience.Components.MonetizationPage.MonetizationPageContainer)
local FFlagBuildPublishNavigationSheet = require(BuildExperience.Flags.FFlagBuildPublishNavigationSheet)
local FFlagBuildExperiencePageImpressions = require(BuildExperience.Flags.FFlagBuildExperiencePageImpressions)
local useBuildPageImpression = require(BuildExperience.Telemetry.useBuildPageImpression)
local BuildNavigationParams = require(BuildExperience.utils.BuildNavigationParams)
local GameInfoUtils = require(BuildExperience.utils.GameInfoUtils)
local _createBuildOverflowMenuStore = require(BuildExperience.Stores.GetBuildOverflowMenuStore.createBuildOverflowMenuStore)
local useBuildPageLayout = require(BuildExperience.utils.useBuildPageLayout)
local useOnScreenKeyboardVisible = require(BuildExperience.utils.useOnScreenKeyboardVisible)

local useTokens = Foundation.Hooks.useTokens
local FFlagBuildExperienceMonetizationNativeUI = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationNativeUI)
local FFlagBuildExperienceEventContextTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceEventContextTelemetry)
local FFlagBuildExperienceChatOpenId = require(BuildExperience.Flags.FFlagBuildExperienceChatOpenId)

local Screens = {
    BuildPublish = "BuildPublish",
    BuildSettings = "BuildSettings",
    BuildAudience = "BuildAudience",
    BuildPrivateInvitesPicker = "BuildPrivateInvitesPicker",
    BuildPlaytestInviteManagement = "BuildPlaytestInviteManagement",
    BuildTitleDescription = "BuildTitleDescription",
    BuildVersionTitleDescription = "BuildVersionTitleDescription",
    BuildMediaSelection = "BuildMediaSelection",
    BuildMonetization = "BuildMonetization",
    BuildStats = "BuildStats"
}

local SCREEN_BY_PAGE = {
    publish = Screens.BuildPublish,
    settings = Screens.BuildSettings
}
if FFlagBuildExperienceMonetizationNativeUI then
    SCREEN_BY_PAGE.monetization = Screens.BuildMonetization
end
if FFlagBuildExperienceAnalytics then
    SCREEN_BY_PAGE.stats = Screens.BuildStats
end

local function normalizeTarget(arg1): {chatOpenId: number, experienceName: any, gameIcon: any, isNewGameTarget: any, placeId: any, sessionId: any, universeId: any}?
    if arg1 == nil then
        return nil
    end

    return {
        universeId = arg1.universeId,
        placeId = arg1.placeId,
        sessionId = arg1.sessionId,
        experienceName = arg1.experienceName,
        gameIcon = arg1.gameIcon,
        isNewGameTarget = arg1.isNewGameTarget,
        chatOpenId = if FFlagBuildExperienceChatOpenId then arg1.chatOpenId else nil
    }
end

local function getTargetWithGameInfo(arg1, arg2, creatorName: string): {creatorName: number, description: number, experienceName: number, gameIcon: number, isCreatorVerified: number, isNewGameTarget: number, placeId: number, sessionId: number, universeId: any}?
    if arg1 == nil then
        return arg1
    end

    local var1 = if GameInfoUtils.isGameInfoReady(arg2) then arg2 else nil
    local creator = if var1 then var1.creator else nil
    local experienceName = GameInfoUtils.getGameInfoName(arg2)
    local tbl3 = {
        universeId = arg1.universeId,
        placeId = 0,
        sessionId = 0,
        experienceName = 0,
        description = 0,
        creatorName = 0,
        gameIcon = 0,
        isCreatorVerified = 0,
        isNewGameTarget = 0
    }
    local placeId = arg1.placeId

    if not placeId then
        if var1 then
            placeId = tonumber(var1.rootPlaceId)
        else
            placeId = nil
        end
    end

    tbl3.placeId = placeId
    tbl3.sessionId = arg1.sessionId
    tbl3.experienceName = experienceName
    tbl3.description = if var1 then var1.description or "" else creatorName
    if creator and creator.name ~= "" then
        creatorName = creator.name
    end

    tbl3.creatorName = creatorName
    tbl3.gameIcon = arg1.gameIcon
    tbl3.isCreatorVerified = if creator then creator.hasVerifiedBadge == true else false
    tbl3.isNewGameTarget = arg1.isNewGameTarget
    return tbl3
end

local function BuildFullscreenPage(tbl3)
    local var1 = useBuildPageLayout()

    return React.createElement(FullscreenPageWithSafeArea, {
        BackgroundColor3 = var1.tokens.Color.Surface.Surface_0.Color3,
        BackgroundTransparency = var1.tokens.Color.Surface.Surface_0.Transparency,
        includeBottomBar = var1.shouldIncludeBottomBar and tbl3.hideBottomBar ~= true,
        includeStatusBar = true
    }, {
        Page = tbl3.pageContent
    })
end

local function BuildSheetPage(tbl3)
    local var1 = useTokens()

    return React.createElement(View, {
        BackgroundColor3 = var1.Color.Surface.Surface_0.Color3,
        BackgroundTransparency = var1.Color.Surface.Surface_0.Transparency,
        tag = "size-full"
    }, {
        Page = tbl3.pageContent
    })
end

local function ConfigurationScreen(tbl3, page: string, testId: string)
    local loading = useLocalization({ loading = LocalizationStrings.BUILD_MENU_LOADING }).loading
    local navigation = tbl3.navigation
    local var1 = tbl3.screenProps or {}
    local var2 = normalizeTarget(BuildNavigationParams.getTarget(navigation) or var1.target)
    if FFlagBuildExperiencePageImpressions then
        useBuildPageImpression(page, var2)
    end
    local var3 = GameInfoUtils.useGameInfo(if var2 then var2.universeId else nil)
    local target = getTargetWithGameInfo(var2, var3, loading)
    local var4, var5 = React.useState(false)
    local var6, var7 = React.useState(false)
    if FFlagBuildExperiencePageImpressions then
        local var8 = useBuildPageImpression
        local str1 = "version-history"
        local bool1 = var6 and not (target == nil) and target.placeId ~= nil
        var8(str1, target, bool1)
    end

    local onClose = React.useCallback(function()
        if var1.onClose then
            var1.onClose()
            return
        end
        navigation.goBack()
    end, { navigation, var1.onClose })
    local onOpenAudiencePage = React.useCallback(function()
        if var1.onOpenAudiencePage then
            var1.onOpenAudiencePage()
            return
        end
        navigation.navigate(Screens.BuildAudience, { target = target })
    end, { navigation, var1.onOpenAudiencePage, target })
    local onOpenTitleDescriptionPage = React.useCallback(function()
        if not GameInfoUtils.isTitleDescriptionReady(var3) then
            return
        end

        if var1.onOpenTitleDescriptionPage then
            var1.onOpenTitleDescriptionPage()
        else
            navigation.navigate(Screens.BuildTitleDescription, { target = target })
        end
    end, {
        var3,
        navigation,
        var1.onOpenTitleDescriptionPage,
        target
    })

    local onOpenMediaSelectionPage = React.useCallback(function()
        if var1.onOpenMediaSelectionPage then
            var1.onOpenMediaSelectionPage()
            return
        end
        navigation.navigate(Screens.BuildMediaSelection, { target = target })
    end, { navigation, var1.onOpenMediaSelectionPage, target })
    local onOpenVersionTitleDescriptionPage = React.useCallback(function()
        if target == nil or target.placeId == nil then
            return
        end

        if var1.onOpenVersionTitleDescriptionPage then
            var1.onOpenVersionTitleDescriptionPage()
        else
            navigation.navigate(Screens.BuildVersionTitleDescription, { target = target })
        end
    end, { navigation, var1.onOpenVersionTitleDescriptionPage, target })
    local onOpenVersionHistory = React.useCallback(function()
        if target == nil or target.placeId == nil then
            return
        end

        if var1.onOpenVersionHistory then
            var1.onOpenVersionHistory()
        else
            var7(true)
        end
    end, { var1.onOpenVersionHistory, target })

    local var14 = if FFlagBuildExperienceMonetizationNativeUI then React.useCallback(function()
        navigation.navigate(Screens.BuildMonetization, { target = target })
    end, { navigation, target }) else nil

    local var8 = React.useCallback(function()
        var7(false)
    end, {})
    local onAgentRollbackStarted = React.useCallback(function()
        var7(false)
        onClose()
    end, { onClose })
    local var17 = React.useCallback(function()
        var5(true)
    end, {})
    local var9 = React.useCallback(function()
        var5(false)
    end, {})
    local var19 = React.useCallback(function()
        navigation.navigate(Screens.BuildPlaytestInviteManagement, { target = target })
    end, { navigation, target })

    local onInvitesSent = React.useCallback(function()
        var5(false)
        var19()
    end, { var19 })

    local bool1 = page == "settings"
    local var21

    if target == nil then
        var21 = nil
    else
        local createElement = React.createElement
        local var22 = BuildOverflowMenuPage
        local tbl4 = {
            page = page,
            target = target,
            testId = testId,
            onClose = onClose,
            onOpenAudiencePage = onOpenAudiencePage,
            onOpenTitleDescriptionPage = onOpenTitleDescriptionPage,
            onOpenMediaSelectionPage = onOpenMediaSelectionPage,
            onOpenMonetizationPage = 0,
            onOpenVersionTitleDescriptionPage = 0,
            onOpenVersionHistory = 0,
            onOpenPlaytestPicker = 0,
            onOpenPlaytestManagement = 0,
            showPreviewButton = 0
        }

        if not (FFlagBuildExperienceMonetizationNativeUI and bool1) then
            var14 = nil
        end

        tbl4.onOpenMonetizationPage = var14

        tbl4.onOpenVersionTitleDescriptionPage = onOpenVersionTitleDescriptionPage
        tbl4.onOpenVersionHistory = onOpenVersionHistory
        if not bool1 then
            var17 = nil
        end

        tbl4.onOpenPlaytestPicker = var17
        tbl4.onOpenPlaytestManagement = if bool1 then var19 else nil
        tbl4.showPreviewButton = var1.showPreviewButton
        var21 = createElement(var22, tbl4)
    end

    local element = if var1.onClose then React.createElement(BuildSheetPage, { pageContent = var21 }) else React.createElement(BuildFullscreenPage, { pageContent = var21 })
    return React.createElement(React.Fragment, nil, {
        Page = element,
        Picker = if var4 and target ~= nil then React.createElement(
            PrivateInvitesPickerHost,
            {
                universeId = target.universeId,
                onClose = var9,
                onInvitesSent = onInvitesSent
            }
        ) else nil,
        VersionHistory = if var6 and target ~= nil and target.placeId ~= nil then React.createElement(
            require(BuildExperience.Components.VersionHistory.VersionHistoryContainer),
            {
                universeId = target.universeId,
                placeId = target.placeId,
                isOpen = true,
                onClose = var8,
                onAgentRollbackStarted = onAgentRollbackStarted,
                testId = "build-publish-version-history"
            }
        ) else nil
    })
end

local function resolveSubPageDismiss(navigation, func1: ((...any) -> (...any))?) -- Luacid: Inlined by compiler; 4 call sites recovered
    return if FFlagBuildPublishNavigationSheet and func1 ~= nil and BuildNavigationParams.getShouldDismissOnBack(navigation) then func1 else navigation.goBack
end

local function BuildTitleDescriptionContent(tbl3)
    local loading = useLocalization({ loading = LocalizationStrings.BUILD_MENU_LOADING }).loading
    local var1 = GameInfoUtils.useGameInfo(tbl3.target.universeId)

    if not GameInfoUtils.isTitleDescriptionReady(var1) then
        return nil
    end

    local targetWithGameInfo = getTargetWithGameInfo(tbl3.target, var1, loading)

    if targetWithGameInfo == nil then
        return nil
    end

    return React.createElement(TitleDescriptionPage, {
        universeId = targetWithGameInfo.universeId,
        titleText = targetWithGameInfo.experienceName or loading,
        descriptionText = targetWithGameInfo.description or "",
        onBack = tbl3.onBack,
        testId = tbl3.testId
    })
end

return {
    Screens = Screens,
    SCREEN_BY_PAGE = SCREEN_BY_PAGE,
    BuildPublishScreen = function(tbl3)
        return ConfigurationScreen(tbl3, "publish", "BuildPage.publish.Page")
    end,
    BuildSettingsScreen = function(tbl3)
        return ConfigurationScreen(tbl3, "settings", "BuildPage.settings.Page")
    end,
    BuildMonetizationScreen = function(tbl3)
        local navigation = tbl3.navigation
        local var1 = tbl3.screenProps or {}
        local var2 = normalizeTarget(BuildNavigationParams.getTarget(navigation) or var1.target)
        if FFlagBuildExperiencePageImpressions then
            useBuildPageImpression("monetization", var2)
        end

        local onClose = var1.onClose

        if not FFlagBuildPublishNavigationSheet or onClose == nil or not BuildNavigationParams.getShouldDismissOnBack(navigation) then
            onClose = resolveSubPageDismiss(navigation, nil)
        end

        local onComposerActivated = if FFlagBuildExperienceMonetizationNativeUI and var1.onClose == nil then tbl3.onComposerActivated or onClose else var1.onClose or onClose
        local pageContent = React.createElement(MonetizationPageContainer, {
            onClose = onClose,
            onComposerActivated = onComposerActivated,
            placeId = if var2 == nil then nil else var2.placeId,
            sessionId = if var2 == nil then nil else var2.sessionId,
            universeId = if var2 == nil then nil else var2.universeId
        })

        if var1.onClose then
            return (React.createElement(BuildSheetPage, { pageContent = pageContent }))
        end
        return (React.createElement(BuildFullscreenPage, { pageContent = pageContent }))
    end,
    BuildStatsScreen = function(tbl3)
        local stats = useLocalization({ stats = LocalizationStrings.BUILD_MENU_STATS }).stats
        local navigation = tbl3.navigation
        local var1 = tbl3.screenProps or {}
        local target = normalizeTarget(BuildNavigationParams.getTarget(navigation) or var1.target)
        if FFlagBuildExperiencePageImpressions then
            useBuildPageImpression("stats", target)
        end

        local onClose = React.useCallback(function()
            if var1.onClose then
                var1.onClose()
                return
            end
            navigation.goBack()
        end, { navigation, var1.onClose })

        local onOpenChat = React.useCallback(function(initialPrompt: string)
            if var1.onOpenChat ~= nil then
                var1.onOpenChat(initialPrompt)
                return
            end
            navigation.navigate(BuildNavigationParams.BUILD_CHAT_SCREEN, { target = target, initialPrompt = initialPrompt })
        end, { navigation, var1.onOpenChat, target })

        local analyticsOverview = require(BuildExperience.Components.Analytics.Overview.AnalyticsOverview)
        local var5

        if target == nil then
            var5 = nil
        else
            local createElement = React.createElement
            local var6 = OverflowMenuPageShell
            local tbl4 = {
                title = stats,
                testId = "BuildPage.stats.Page",
                onClose = onClose,
                scrollPerformanceIntervalName = "LuaApp_Build_Stats_Scroll",
                content = React.createElement(analyticsOverview, {
                    universeId = target.universeId,
                    placeId = if FFlagBuildExperienceEventContextTelemetry then target.placeId else nil,
                    conversationId = if FFlagBuildExperienceEventContextTelemetry then target.sessionId else nil,
                    onOpenChat = onOpenChat
                })
            }
            var5 = createElement(var6, tbl4)
        end

        if var1.onClose then
            return React.createElement(BuildSheetPage, { pageContent = var5 })
        end

        return React.createElement(BuildFullscreenPage, { pageContent = var5 })
    end,
    BuildAudienceScreen = function(tbl3)
        local var1 = useLocalization({ audience = LocalizationStrings.BUILD_MENU_AUDIENCE })

        local navigation = tbl3.navigation
        local var2 = tbl3.screenProps or {}
        local var3 = normalizeTarget(BuildNavigationParams.getTarget(navigation) or var2.target)
        if FFlagBuildExperiencePageImpressions then
            useBuildPageImpression("audience", var3)
        end

        local onClose = React.useCallback(function()
            navigation.goBack()
        end, { navigation })

        local pageContent = if var3 == nil then nil else React.createElement(OverflowMenuPageShell, {
            title = var1.audience,
            testId = "BuildPage.audience.Page",
            onClose = onClose,
            scrollPerformanceIntervalName = "LuaApp_Build_Audience_Scroll",
            content = React.createElement(AudienceConfigurationContent, { universeId = var3.universeId })
        })

        if var2.onClose then
            return React.createElement(BuildSheetPage, { pageContent = pageContent })
        end

        return React.createElement(BuildFullscreenPage, { pageContent = pageContent })
    end,
    BuildPrivateInvitesPickerScreen = function(tbl3)
        local navigation = tbl3.navigation
        local var1 = tbl3.screenProps or {}
        local var2 = normalizeTarget(BuildNavigationParams.getTarget(navigation) or var1.target)

        local var3 = React.useCallback(function()
            if var1.onClose then
                var1.onClose()
                return
            end
            navigation.goBack()
        end, { navigation, var1.onClose })

        if var2 == nil then
            return nil
        end

        return React.createElement(
            PrivateInvitesPickerContainer,
            {
                universeId = var2.universeId,
                onClose = var3,
                onInvitesSent = var3
            }
        )
    end,
    BuildPlaytestInviteManagementScreen = function(tbl3)
        local pageTitle = useLocalization({ pageTitle = LocalizationStrings.PRIVATE_INVITES_PAGE_TITLE }).pageTitle
        local navigation = tbl3.navigation
        local var1 = tbl3.screenProps or {}
        local var2 = normalizeTarget(BuildNavigationParams.getTarget(navigation) or var1.target)
        local var3, var4 = React.useState(false)

        local onClose = React.useCallback(function()
            navigation.goBack()
        end, { navigation })
        local onOpenInvitePicker = React.useCallback(function()
            var4(true)
        end, {})
        local var7 = React.useCallback(function()
            var4(false)
        end, {})

        local pageContent = if var2 == nil then nil else React.createElement(OverflowMenuPageShell, {
            title = pageTitle,
            testId = "BuildPage.playtestInviteManagement.Page",
            onClose = onClose,
            content = React.createElement(
                PrivateInvitesManagementContainer,
                {
                    universeId = var2.universeId,
                    onOpenInvitePicker = onOpenInvitePicker
                }
            )
        })
        local page = if var1.onClose then React.createElement(BuildSheetPage, { pageContent = pageContent }) else React.createElement(BuildFullscreenPage, { pageContent = pageContent })
        return React.createElement(React.Fragment, nil, {
            Page = page,
            Picker = if var3 and var2 ~= nil then React.createElement(PrivateInvitesPickerHost, { universeId = var2.universeId, onClose = var7, onInvitesSent = var7 }) else nil
        })
    end,
    BuildTitleDescriptionScreen = function(tbl3)
        local navigation = tbl3.navigation
        local var1 = tbl3.screenProps or {}
        local target = normalizeTarget(BuildNavigationParams.getTarget(navigation) or var1.target)
        if FFlagBuildExperiencePageImpressions then
            useBuildPageImpression("title-description", target)
        end
        local hideBottomBar = useOnScreenKeyboardVisible()
        local var4

        if target == nil then
            var4 = nil
        else
            local createElement = React.createElement
            local func1 = BuildTitleDescriptionContent
            local tbl4 = { target = target, onBack = 0, testId = "BuildPage.titleDescription.Page" }
            local onClose = var1.onClose

            if not FFlagBuildPublishNavigationSheet or onClose == nil or not BuildNavigationParams.getShouldDismissOnBack(navigation) then
                onClose = resolveSubPageDismiss(navigation, nil)
            end

            tbl4.onBack = onClose
            var4 = createElement(func1, tbl4)
        end

        if var1.onClose then
            return React.createElement(BuildSheetPage, { pageContent = var4 })
        end

        return React.createElement(BuildFullscreenPage, { hideBottomBar = hideBottomBar, pageContent = var4 })
    end,
    BuildVersionTitleDescriptionScreen = function(tbl3)
        local navigation = tbl3.navigation
        local var1 = tbl3.screenProps or {}
        local var2 = normalizeTarget(BuildNavigationParams.getTarget(navigation) or var1.target)
        if FFlagBuildExperiencePageImpressions then
            useBuildPageImpression("version-title-description", var2)
        end
        local hideBottomBar = useOnScreenKeyboardVisible()
        local var4

        if var2 == nil or var2.placeId == nil then
            var4 = nil
        else
            local createElement = React.createElement
            local versionTitleDescriptionPageContainer = require(BuildExperience.Components.VersionTitleDescriptionPage.VersionTitleDescriptionPageContainer)
            local tbl4 = {
                placeId = var2.placeId,
                onBack = 0,
                testId = "BuildPage.versionTitleDescription.Page"
            }
            local onClose = var1.onClose

            if not FFlagBuildPublishNavigationSheet or onClose == nil or not BuildNavigationParams.getShouldDismissOnBack(navigation) then
                onClose = resolveSubPageDismiss(navigation, nil)
            end

            tbl4.onBack = onClose
            var4 = createElement(versionTitleDescriptionPageContainer, tbl4)
        end

        if var1.onClose then
            return React.createElement(BuildSheetPage, { pageContent = var4 })
        end

        return React.createElement(BuildFullscreenPage, { hideBottomBar = hideBottomBar, pageContent = var4 })
    end,
    BuildMediaSelectionScreen = function(tbl3)
        local navigation = tbl3.navigation
        local var1 = tbl3.screenProps or {}
        local target = BuildNavigationParams.getTarget(navigation)
        if FFlagBuildExperiencePageImpressions then
            useBuildPageImpression("media-selection", target)
        end

        local onClose = var1.onClose

        if not FFlagBuildPublishNavigationSheet or onClose == nil or not BuildNavigationParams.getShouldDismissOnBack(navigation) then
            onClose = resolveSubPageDismiss(navigation, nil)
        end

        local pageContent = if target == nil or target.universeId == nil then nil else React.createElement(MediaSelectionPage, { onClose = onClose, universeId = target.universeId })

        if var1.onClose then
            return React.createElement(BuildSheetPage, { pageContent = pageContent })
        end

        return React.createElement(BuildFullscreenPage, { pageContent = pageContent })
    end
}
