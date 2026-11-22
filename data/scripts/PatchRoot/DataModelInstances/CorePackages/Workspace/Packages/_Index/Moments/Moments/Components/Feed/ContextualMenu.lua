-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Players = game:GetService("Players")

local BuilderIcons = require(MomentsParent.BuilderIcons)
local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local React = require(MomentsParent.React)
local SharedFlags = require(MomentsParent.SharedFlags)
local SignalsReact = require(MomentsParent.SignalsReact)
local Speaker = BuilderIcons.Icon.Speaker
local SpeakerSlash = BuilderIcons.Icon.SpeakerSlash
local ThreeDotsVertical = BuilderIcons.Icon.ThreeDotsVertical

local IconButton = Foundation.IconButton
local Menu = Foundation.Menu
local View = Foundation.View

local useLocalization = Localization.Hooks.useLocalization
local useToggleState = MomentsCommon.Hooks.useToggleState

local checkDebugAccess = require(Moments.Utils.checkDebugAccess)
local getPostFeedItemId = require(Moments.Utils.getPostFeedItemId)
local fireAnalyticsEvent = MomentsCommon.Analytics.fireAnalyticsEvent
local reportMomentsEngagement = MomentsCommon.Analytics.reportMomentsEngagement
local EventNames = MomentsCommon.Analytics.EventNames
local RecommendationSource = MomentsCommon.Analytics.RecommendationSource
local reportModalCovering = MomentsCommon.Media.reportModalCovering
local accountSettingsCovering = require(Moments.Components.Feed.accountSettingsCovering)
local GetMomentsCapabilities = MomentsCommon.Stores.GetMomentsCapabilities
local makeFeedActionFields = require(Moments.Analytics.makeFeedActionFields)
local makeRecommendationAttribution = require(Moments.Analytics.makeRecommendationAttribution)
local _RecommendationContentType = require(Moments.Analytics.RecommendationContentType)
local reportMoment = require(Moments.Moderation.reportMoment)
local useFeed = require(Moments.Components.Feed.FeedContext).useFeed

local useMomentsSession = require(Moments.Stores.GetMomentsStore.MomentsSessionContext).useMomentsSession
local GetMomentsPreferencesStore = require(Moments.Stores.GetMomentsPreferencesStore)
local GetModeratedItemsStore = require(Moments.Stores.GetModeratedItemsStore)
local GetToastStore = require(Moments.Stores.GetToastStore)

local SignalActionType = require(Moments.Enums.SignalActionType)
local FFlagMomentsOptimisticProfilePending = SharedFlags.FFlagMomentsOptimisticProfilePending
local FFlagMomentsServeEDPVideos = SharedFlags.FFlagMomentsServeEDPVideos
local bool1 = game:DefineFastFlag("MomentsUseSmallOverflowMenu", false)
local bool2 = game:DefineFastFlag("MomentsReportButtonAnalytics", false)

local FFlagMomentsPersonalizedRecommendationsEntryPoint = require(Moments.Flags.FFlagMomentsPersonalizedRecommendationsEntryPoint)
local FFlagMomentsCreatorAnalytics = require(Moments.Flags.FFlagMomentsCreatorAnalytics)
local FFlagMomentsRecommendationContentType = require(Moments.Flags.FFlagMomentsRecommendationContentType)
local getPostInsightsPageStore = require(Moments.Components.PostInsights.getPostInsightsPageStore)
local postInsightsStrings = require(Moments.Components.PostInsights.postInsightsStrings)
local PostInsightsCoachmark = require(Moments.Components.PostInsights.PostInsightsCoachmark)
local dismissPostInsightsCoachmark = require(Moments.Components.PostInsights.dismissPostInsightsCoachmark)
local FFlagMomentsOverflowButtonAnalytics = require(Moments.Flags.FFlagMomentsOverflowButtonAnalytics)
local GetFFlagMomentsCoachmarkPersistence = MomentsCommon.Flags.GetFFlagMomentsCoachmarkPersistence
local _createMomentStore = require(Moments.Components.Feed.Items.Moment.createMomentStore)
local ReportMomentDialog = require(Moments.Components.Feed.ReportMomentDialog)
local IpReportConfirmationDialog = require(Moments.Components.Feed.IpReportConfirmationDialog)

local useMomentsHost = require(Moments.MomentsHostContext).useMomentsHost

local LocalPlayer = Players.LocalPlayer

local function isOwnMoment(moment): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return moment.creatorId == (if LocalPlayer then LocalPlayer.UserId else nil)
end

local tbl1 = {
    showDetails = "Feature.Moments.Action.ShowDetails",
    hideDetails = "Feature.Moments.Action.Hide",
    expand = "Feature.Moments.Action.Expand",
    minimize = "Feature.Moments.Action.Minimize",
    report = "Feature.Moments.Action.Report",
    delete = "Feature.Moments.Action.Delete",
    reportSubmittedTitle = "Feature.Moments.Label.ReportSubmittedTitle",
    reportSubmittedBody = "Feature.Moments.Label.ReportSubmittedBody"
}

local var1 = table.freeze({ label = "Feature.AccountSettings.Heading.Tab.PersonalizedRecommendations" })

return function(tbl2)
    local var2 = useLocalization(tbl1)
    local analytics = if FFlagMomentsCreatorAnalytics then useLocalization(postInsightsStrings.MENU_KEYS).analytics else ""

    local label = if FFlagMomentsPersonalizedRecommendationsEntryPoint then useLocalization(var1).label else ""

    local var3 = useFeed()
    local var4 = if FFlagMomentsPersonalizedRecommendationsEntryPoint then SignalsReact.useSignalState(GetMomentsCapabilities(false).getCanShowPersonalizedRecommendationsEntryPoint) else false
    local var5 = FFlagMomentsServeEDPVideos and tbl2.moment.entityType == "edpVideo"

    local openMomentsFeedReport = useMomentsHost().openMomentsFeedReport
    local var6 = useToggleState()
    local isOpen, var8 = React.useState(false)
    local var9 = nil
    local var10 = nil
    local var11 = nil
    local var12, var13

    if FFlagMomentsServeEDPVideos then
        local var14
        var9, var14 = React.useState(false)
        var10 = var14

        local var15 = React.useRef(nil)

        var11 = React.useCallback(function(current: (...any) -> (...any))
            var15.current = current
            var10(true)
        end, {})

        local var16 = React.useCallback(function()
            var15.current = nil
            var10(false)
        end, {})

        var12 = React.useCallback(function()
            local current = var15.current
            var16()
            if current then
                current()
            end
        end, { var16 })

        var13 = var16
    else
        var13 = nil
        var12 = nil
    end

    local var14, var15 = React.useState(false)
    local reportCode, var17 = React.useState("------")

    local onActivated = React.useCallback(function()
        if var6.enabled then
            var6.disable()
            return
        end
        var6.enable()

        if not FFlagMomentsOverflowButtonAnalytics then
            return
        end

        local recommendationMetadata = tbl2.moment.recommendationMetadata
        local feedActionFields = makeFeedActionFields(
            tbl2.moment.momentId,
            if recommendationMetadata == nil then nil else recommendationMetadata.feedItemId,
            if recommendationMetadata == nil then nil else recommendationMetadata.tracingId,
            "overflow"
        )
        if feedActionFields ~= nil then
            feedActionFields.isOwnMoment = tostring((isOwnMoment(tbl2.moment)))
            fireAnalyticsEvent(EventNames.FeedOverflowButtonPressed, feedActionFields)
        end
    end, {
        var6.enabled,
        var6.enable,
        var6.disable,
        if FFlagMomentsOverflowButtonAnalytics then tbl2.moment else false
    })

    local var19 = useMomentsSession()
    local momentsPreferencesStore = GetMomentsPreferencesStore(false)
    local moderatedItemsStore = GetModeratedItemsStore(false)
    local toastStore = GetToastStore(false)

    local var20 = SignalsReact.useSignalState(var19.getHideDetails)
    local var21 = SignalsReact.useSignalState(momentsPreferencesStore.getMinimized)

    local var7 = React.useCallback(function()
        var6.disable()
        var19.toggleFeedDetailVisibility()
        fireAnalyticsEvent(EventNames.FeedHideDetailsButtonPressed, { momentId = tbl2.moment.momentId })
    end, { tbl2.moment, var6.disable, var19.toggleFeedDetailVisibility })

    local var16 = React.useCallback(function()
        var6.disable()
        momentsPreferencesStore.toggleFeedScaleType()
        fireAnalyticsEvent(EventNames.FeedMinimizeButtonPressed, { momentId = tbl2.moment.momentId })
    end, { tbl2.moment, var6.disable, momentsPreferencesStore.toggleFeedScaleType })

    local var18 = React.useCallback(function()
        if checkDebugAccess() then
            momentsPreferencesStore.toggleFeedDebugMode()
        end
        var6.disable()
    end, { var6.disable, momentsPreferencesStore.toggleFeedDebugMode })

    local onSubmitReport = React.useCallback(function(str1: string?, bool3: boolean?, bool4: boolean?)
        if not tbl2.moment then
            return nil
        end

        local success, result, result2

        if bool4 then
            success = true
            result = true
            result2 = nil
        else
            success, result, result2 = pcall(function()
                return reportMoment(tbl2.moment.recommendationMetadata.feedItemId, str1):await()
            end)
        end

        local recommendationMetadata = tbl2.moment.recommendationMetadata
        local recommendationAttribution = makeRecommendationAttribution(
            recommendationMetadata,
            nil,
            if FFlagMomentsRecommendationContentType then tbl2.contentType else nil
        )

        if recommendationAttribution then
            local success2, result3 = pcall(function()
                var3.logAction(SignalActionType.Report, recommendationAttribution, {})
            end)
            if not success2 then
                warn("Failed to log action event", result3)
            end
        end

        local feedActionFields = makeFeedActionFields(
            tbl2.moment.momentId,
            recommendationMetadata and recommendationMetadata.feedItemId,
            recommendationMetadata and recommendationMetadata.tracingId,
            "report"
        )
        if feedActionFields then
            fireAnalyticsEvent(EventNames.FeedAbuseReported, feedActionFields)
        end

        if not bool3 then
            moderatedItemsStore.markReported(tbl2.moment.momentId)
            var3.removeCurrentItem()

            toastStore.triggerToast({ title = var2.reportSubmittedTitle, text = var2.reportSubmittedBody })
        end

        return if success and result and type(result2) == "table" then result2.reportCode else nil
    end, {
        tbl2.moment,
        var3.logAction,
        var3.removeCurrentItem,
        moderatedItemsStore.markReported,
        toastStore.triggerToast,
        var2
    })

    local useCallback = React.useCallback
    local function func1()
        var6.disable()
        if bool2 then
            reportMomentsEngagement("report_click")
        end
        local postFeedItemId = getPostFeedItemId(tbl2.moment)
        if FFlagMomentsServeEDPVideos and var5 then
            postFeedItemId = tbl2.moment.recommendationMetadata.feedItemId
        end
        if not postFeedItemId or not openMomentsFeedReport then
            if not (FFlagMomentsServeEDPVideos and var5) then
                var8(true)
            end

            return
        end

        reportModalCovering.setCovering(true)
        local var26 = openMomentsFeedReport
        local tbl3 = {
            feedItemId = postFeedItemId,
            momentId = tbl2.moment.momentId,
            universeId = if FFlagMomentsServeEDPVideos then tbl2.moment.metadata.universeId or 0 else nil,
            onSubmit = 0,
            onClose = 0,
            onIpReportCode = 0,
            isEdpVideo = 0,
            onEdpVideoIpReport = 0
        }

        function tbl3.onSubmit()
            onSubmitReport(nil, false, true)
        end
        function tbl3.onClose()
            reportModalCovering.setCovering(false)
        end

        function tbl3.onIpReportCode(arg1)
            onSubmitReport(nil, true, true)
            var17(arg1 and arg1 ~= "" and arg1 or "------")
            var15(true)
        end
        tbl3.isEdpVideo = if FFlagMomentsServeEDPVideos then var5 else nil
        tbl3.onEdpVideoIpReport = if FFlagMomentsServeEDPVideos then var11 else nil
        var26(tbl3)
    end

    local disable = var6.disable
    local var26 = if FFlagMomentsServeEDPVideos then var11 else nil
    local moment = tbl2.moment
    local var27 = if FFlagMomentsServeEDPVideos then var5 else false
    local var22 = useCallback(func1, { disable, onSubmitReport, openMomentsFeedReport, var26, moment, var27 })

    local onClose = React.useCallback(function()
        var8(false)
    end, {})

    local var23 = React.useCallback(function()
        if var15 then
            var15(false)
        end
    end, {})

    local var24 = React.useCallback(function()
        var6.disable()

        var19.requestDeletion(
            tbl2.moment.momentId,
            tbl2.moment.recommendationMetadata and tbl2.moment.recommendationMetadata.feedItemId,
            if tbl2.moment.recommendationMetadata then tbl2.moment.recommendationMetadata.tracingId else nil
        )
    end, { tbl2.moment, var6.disable, var19.requestDeletion })

    local var25 = if FFlagMomentsCreatorAnalytics then React.useCallback(function()
        var6.disable()

        local recommendationMetadata = tbl2.moment.recommendationMetadata
        local feedActionFields = makeFeedActionFields(
            tbl2.moment.momentId,
            if recommendationMetadata == nil then nil else recommendationMetadata.feedItemId,
            if recommendationMetadata == nil then nil else recommendationMetadata.tracingId,
            "analytics"
        )
        if feedActionFields ~= nil then
            fireAnalyticsEvent(EventNames.FeedAnalyticsButtonPressed, feedActionFields)
        end
        if GetFFlagMomentsCoachmarkPersistence() then
            dismissPostInsightsCoachmark()
        end
        if tbl2.momentStore ~= nil then
            getPostInsightsPageStore(false).open({ moment = tbl2.moment, momentStore = tbl2.momentStore })
        end
    end, { tbl2.moment, tbl2.momentStore or false, var6.disable }) else nil

    local var33 = if FFlagMomentsPersonalizedRecommendationsEntryPoint then React.useCallback(function()
        var6.disable()
        local recommendationMetadata = tbl2.moment.recommendationMetadata
        local feedActionFields = makeFeedActionFields(
            tbl2.moment.momentId,
            if recommendationMetadata == nil then nil else recommendationMetadata.feedItemId,
            if recommendationMetadata == nil then nil else recommendationMetadata.tracingId,
            "personalized_recommendations"
        )
        if feedActionFields ~= nil then
            fireAnalyticsEvent(EventNames.FeedPersonalizedRecommendationsButtonPressed, feedActionFields)
        end

        local accountSettingsEntryPoints = require(MomentsParent.AccountSettingsEntryPoints)
        accountSettingsEntryPoints.openAccountSettings(accountSettingsEntryPoints.Page.PersonalizedRecommendations, {
            surfaceKey = "Client_Moments_Feed",
            onClosed = function()
                accountSettingsCovering.setCovering(false)
            end
        })

        accountSettingsCovering.setCovering(true)
    end, { tbl2.moment, var6.disable }) else nil

    local var34 = React.useCallback(function()
        if tbl2.isDisabled then
            return
        end
        tbl2.playbackVolume.toggle()
    end, { tbl2.isDisabled, tbl2.playbackVolume })

    local var35 = React.useCallback(function()
        if tbl2.isDisabled then
            return
        end
        fireAnalyticsEvent(
            if tbl2.playbackVolume.isMuted then EventNames.FeedUnmuteButtonPressed else EventNames.FeedMuteButtonPressed,
            {
                momentId = tbl2.moment.momentId
            }
        )
        tbl2.playbackVolume.toggle()
    end, { tbl2.isDisabled, tbl2.playbackVolume, tbl2.moment })

    if tbl2.isFeedMuteButtonAnalyticsEnabled then
        var34 = var35
    end

    local var36 = FFlagMomentsPersonalizedRecommendationsEntryPoint
        and var4
        and var3.recommendationSource == RecommendationSource.Trending

    local useMemo = React.useMemo
    local function func2()
        local items = {
            {
                id = "details",
                icon = if var20 then "icons/actions/viewOn" else "icons/actions/viewOff",
                text = if var20 then var2.showDetails else var2.hideDetails,
                onActivated = var7
            },
            {
                id = "minimize",
                icon = if var21 then "icons/actions/previewExpand" else "icons/actions/previewShrink",
                text = if var21 then var2.expand else var2.minimize,
                onActivated = var16
            }
        }
        local bool3 = not (tbl2.moment.recommendationMetadata == nil or tbl2.moment.recommendationMetadata.feedItemId == nil)
            and tbl2.moment.recommendationMetadata.feedItemId ~= ""

        if FFlagMomentsServeEDPVideos and var5
            or tbl2.moment.creatorId ~= (if LocalPlayer then LocalPlayer.UserId else nil) and bool3
        then
            table.insert(
                items,
                {
                    id = "reportAbuse",
                    icon = Foundation.Enums.IconName.Flag,
                    text = var2.report,
                    onActivated = var22
                }
            )
        elseif bool3 and (not FFlagMomentsOptimisticProfilePending or tbl2.moment.status ~= "Pending") then
            table.insert(items, { id = "delete", icon = "icons/actions/delete", text = var2.delete, onActivated = var24 })
        end

        if FFlagMomentsCreatorAnalytics
            and tbl2.momentStore ~= nil
            and isOwnMoment(tbl2.moment)
            and var3.recommendationSource == RecommendationSource.Profile
        then
            table.insert(
                items,
                {
                    id = "postInsights",
                    icon = Foundation.Enums.IconName.ChartThreeVerticalBars,
                    text = analytics,
                    onActivated = var25
                }
            )
        end
        if checkDebugAccess() then
            table.insert(items, { id = "debug", icon = "icons/logo/block", text = "Toggle Debug Mode", onActivated = var18 })
        end

        local var28 = var33

        if not var36 or var28 == nil then
            return items
        end

        return {
            { items = items },
            {
                items = {{
                    id = "personalizedRecommendations",
                    icon = Foundation.Enums.IconName.Gear,
                    text = label,
                    onActivated = var28
                }}
            }
        }
    end

    local moment2 = tbl2.moment
    local var37 = if FFlagMomentsServeEDPVideos then var5 else false
    local momentStore = if FFlagMomentsCreatorAnalytics then tbl2.momentStore or false else false
    local var38 = if FFlagMomentsCreatorAnalytics then var25 or false else false
    local var39 = if FFlagMomentsCreatorAnalytics then analytics else false
    local items = useMemo(func2, {
        moment2,
        var20,
        var21,
        var2,
        var18,
        var7,
        var16,
        var22,
        var24,
        var37,
        momentStore,
        var38,
        var39,
        var36,
        var33 or false,
        label
    })

    local element = React.createElement(Menu, {
        align = Foundation.Enums.PopoverAlign.End,
        isOpen = var6.enabled,
        items = items,
        onPressedOutside = var6.disable,
        side = Foundation.Enums.PopoverSide.Left,
        size = if bool1 then Foundation.Enums.InputSize.Small else nil
    }, {
        ContextualMenuButton = React.createElement(IconButton, {
            icon = ThreeDotsVertical,
            isDisabled = tbl2.isDisabled,
            onActivated = onActivated,
            size = Foundation.Enums.InputSize.Large,
            testId = "FeedContextualMenuButton"
        })
    })

    if FFlagMomentsCreatorAnalytics and GetFFlagMomentsCoachmarkPersistence() and tbl2.momentStore ~= nil then
        local creatorId = tbl2.moment.creatorId
        local userId = if LocalPlayer then LocalPlayer.UserId else nil

        if creatorId == userId then
            element = React.createElement(
                PostInsightsCoachmark,
                {
                    moment = tbl2.moment,
                    momentStore = tbl2.momentStore,
                    isDisabled = tbl2.isDisabled,
                    isMenuOpen = var6.enabled
                },
                element
            )
        end
    end
    local reportDialog = React.createElement(ReportMomentDialog, { isOpen = isOpen, onClose = onClose, onSubmitReport = onSubmitReport })
    local ipConfirmationDialog = if var14 then React.createElement(IpReportConfirmationDialog, { reportCode = reportCode, onClose = var23 }) else nil
    local element4 = if FFlagMomentsServeEDPVideos and var9 then React.createElement(require(Moments.Components.Feed.EdpVideoIpReportDialog), { onCancel = var13, onContinue = var12 }) else nil

    if not tbl2.isFeedMuteEnabled then
        local createElement = React.createElement
        local var41 = View
        local tbl3 = {
            LayoutOrder = tbl2.layoutOrder,
            tag = "col align-x-center auto-xy"
        }
        local tbl4 = {
            ContextMenuPopover = element,
            ReportDialog = reportDialog,
            IpConfirmationDialog = ipConfirmationDialog,
            EdpVideoIpReportDialog = 0
        }

        if not FFlagMomentsServeEDPVideos then
            element4 = nil
        end

        tbl4.EdpVideoIpReportDialog = element4
        return createElement(var41, tbl3, tbl4)
    end

    local createElement = React.createElement
    local var41 = View
    local tbl3 = {
        LayoutOrder = tbl2.layoutOrder,
        tag = "col align-x-right auto-xy"
    }
    local tbl4 = {
        MuteAndMenuRow = 0,
        ReportDialog = 0,
        IpConfirmationDialog = 0,
        EdpVideoIpReportDialog = 0
    }
    local createElement2 = React.createElement
    local var42 = View
    local tbl5 = { LayoutOrder = 1, tag = "row align-x-right align-y-center gap-xsmall auto-xy" }

    local tbl6 = {
        FeedMuteButton = React.createElement(IconButton, {
            icon = if tbl2.playbackVolume.isMuted then SpeakerSlash else Speaker,
            isDisabled = tbl2.isDisabled,
            onActivated = var34,
            size = Foundation.Enums.InputSize.Medium,
            testId = "FeedMuteButton"
        }),
        ContextMenuPopover = element
    }
    tbl4.MuteAndMenuRow = createElement2(var42, tbl5, tbl6)

    tbl4.ReportDialog = reportDialog
    tbl4.IpConfirmationDialog = ipConfirmationDialog
    if not FFlagMomentsServeEDPVideos then
        element4 = nil
    end

    tbl4.EdpVideoIpReportDialog = element4
    return createElement(var41, tbl3, tbl4)
end
