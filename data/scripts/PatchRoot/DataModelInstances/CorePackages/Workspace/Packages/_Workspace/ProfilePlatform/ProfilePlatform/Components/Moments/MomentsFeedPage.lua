-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)
local Navigation = require(ProfilePlatformParent.Navigation)
local RobloxAppHooks = require(ProfilePlatformParent.RobloxAppHooks)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local MomentsCommon = require(ProfilePlatformParent.MomentsCommon)
local Moments = require(ProfilePlatformParent.Moments)
local GenericAbuseReporting = require(ProfilePlatformParent.GenericAbuseReporting)
local CentralOverlay = require(ProfilePlatformParent.CentralOverlay)
local OpenGameDetails = require(ProfilePlatformParent.GameDetail).OpenGameDetails
local useOpenBlockingModal = require(ProfilePlatformParent.MomentsCommon.useOpenBlockingModal)

local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local FFlagMomentsOptimisticProfilePending = SharedFlags.FFlagMomentsOptimisticProfilePending
local FFlagEnableArgusImmersiveNav = SharedFlags.FFlagEnableArgusImmersiveNav
local FFlagEnableMomentsCommentReporting = SharedFlags.FFlagEnableMomentsCommentReporting
local FFlagEnableMomentsCommentBlocking = SharedFlags.FFlagEnableMomentsCommentBlocking
local FFlagAbuseReportSubmissionTargetV4 = SharedFlags.FFlagAbuseReportSubmissionTargetV4
local FFlagMomentsServeEDPVideos = SharedFlags.FFlagMomentsServeEDPVideos
local FFlagAbuseReportAttributes = SharedFlags.FFlagAbuseReportAttributes
local FFlagProfileRenderAvatarMoments = SharedFlags.FFlagProfileRenderAvatarMoments
local FFlagProfileMomentsFeedAboveSplitPane = SharedFlags.FFlagProfileMomentsFeedAboveSplitPane
local SplitPaneStore = if FFlagProfileMomentsFeedAboveSplitPane then require(ProfilePlatformParent.SplitPane).SplitPaneStore else nil
local useSignalState = require(ProfilePlatformParent.SignalsReact).useSignalState

local View = Foundation.View
local IconButton = Foundation.IconButton
local ButtonSize = Foundation.Enums.ButtonSize
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode

local useScreenSize = RobloxAppHooks.useScreenSize
local useStatusBarHeight = RobloxAppHooks.useStatusBarHeight
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local AbuseVector = GenericAbuseReporting.Enums.AbuseVector
local OpenDynamicAbuseReport = GenericAbuseReporting.Thunks.OpenDynamicAbuseReport
local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay
local fireAnalyticsEvent = MomentsCommon.Analytics.fireAnalyticsEvent
local EventNames = MomentsCommon.Analytics.EventNames

local useNavigation = Navigation.useNavigation
local Feed = Moments.Feed
local reportEdpVideo = Moments.reportEdpVideo

local MomentsImmersivePresentation = Moments.MomentsImmersivePresentation
local ImmersiveFeedKind = Moments.Constants.ImmersiveFeedKind

local CreateUserMomentsFeedSource = require(ProfilePlatformParent.Moments.CreateUserMomentsFeedSource)

local reportMoment = Moments.reportMoment

return if FFlagEnableArgusImmersiveNav then function() -- name: MomentsFeedPageImmersive
    local var1 = useNavigation()
    local param = var1.getParam("extraProps")

    local targetUserId = if param and param.targetUserId then param.targetUserId else 0
    local initialIndex = if param and param.initialIndex then param.initialIndex else 1
    local initialMomentId = if FFlagMomentsOptimisticProfilePending and param ~= nil then param.initialMomentId else nil

    local onBack = React.useCallback(function()
        fireAnalyticsEvent(EventNames.ProfileClosePressed, { userId = tostring(targetUserId) })

        var1.goBack()
    end, { var1.goBack, targetUserId })

    local var5 = useDispatch()
    local useCallback = React.useCallback

    local function func1(tbl1)
        if not (FFlagMomentsServeEDPVideos and tbl1.isEdpVideo) then
            local bool1 = false
            local function submitMomentsIp(_)
                bool1 = true

                local function showConfirmation(str1: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
                    tbl1.onClose()
                    var5(CloseCentralOverlay())
                    if tbl1.onIpReportCode then
                        tbl1.onIpReportCode(str1)
                    end
                end
                return reportMoment(tbl1.feedItemId, "IntellectualProperty"):andThen(function(arg1)
                    showConfirmation(arg1.reportCode)
                    return arg1
                end, function()
                    showConfirmation(nil)
                end)
            end

            var5(
                OpenDynamicAbuseReport({
                    abuseVector = AbuseVector.MomentsFeed,
                    targetId = tbl1.feedItemId,
                    onSubmit = function()
                        if bool1 then
                            return
                        end
                        tbl1.onSubmit()
                    end,
                    onClose = function()
                        tbl1.onClose()
                        var5(CloseCentralOverlay())
                    end,
                    onCustomSubmit = not FFlagAbuseReportSubmissionTargetV4 and function(arg1)
                        if arg1.endpoint ~= "moments-ip" then
                            return nil
                        end
                        return submitMomentsIp(arg1)
                    end or nil,
                    clientActionHandlers = FFlagAbuseReportSubmissionTargetV4 and {
                        ["moments-ip"] = submitMomentsIp
                    } or nil
                })
            )

            return
        end

        local bool1 = false
        local function openEdpVideoIpReportDialog(_)
            bool1 = true
            tbl1.onClose()
            var5(CloseCentralOverlay())
            if tbl1.onEdpVideoIpReport then
                tbl1.onEdpVideoIpReport(function()
                    var5(OpenGameDetails(tbl1.universeId, var1, { mountAsFullView = true, showBackButton = true }))
                end)
            end

            return {}
        end
        local var6 = var5
        local var7 = OpenDynamicAbuseReport
        local tbl2 = {
            abuseVector = AbuseVector.MomentsFeed,
            targetId = if FFlagAbuseReportAttributes then nil else tbl1.feedItemId,
            attributes = FFlagAbuseReportAttributes and {
                targetId = tbl1.feedItemId,
                isEdpVideo = true
            } or nil,
            analyticsTargetId = if FFlagAbuseReportAttributes then tbl1.feedItemId else nil,
            onSubmit = 0,
            onClose = 0,
            clientActionHandlers = 0
        }

        function tbl2.onSubmit()
            if bool1 then
                return
            end
            tbl1.onSubmit()
        end
        function tbl2.onClose()
            tbl1.onClose()
            var5(CloseCentralOverlay())
        end
        tbl2.clientActionHandlers = {
            ["moments-edp-video"] = reportEdpVideo,
            ["moments-edp-video-ip"] = openEdpVideoIpReportDialog
        }
        var6(var7(tbl2))
    end

    local var6 = if FFlagMomentsServeEDPVideos then var1 else false
    local openMomentsFeedReport = useCallback(func1, { var5, var6 })

    local openMomentCommentReport = if FFlagEnableMomentsCommentReporting then React.useCallback(function(tbl1)
        local attributes = {
            targetId = tbl1.commentId,
            channelId = tbl1.channelId,
            reportedUserId = tbl1.reportedUserId
        }
        var5(
            OpenDynamicAbuseReport({
                abuseVector = AbuseVector.MomentComment,
                attributes = attributes,
                analyticsTargetId = tbl1.commentId,
                onClose = function()
                    var5(CloseCentralOverlay())
                end
            })
        )
    end, { var5 }) else nil

    local openBlockUser = if FFlagEnableMomentsCommentBlocking then useOpenBlockingModal(var1) else nil
    local var10 = useScreenSize()
    local var11 = if FFlagProfileMomentsFeedAboveSplitPane then useSignalState(SplitPaneStore.getStore().getIsSplitPaneActive) else false
    return React.createElement(View, {
        Size = if var11 then UDim2.fromScale(1, 1) else UDim2.fromOffset(var10.X, var10.Y),
        backgroundStyle = FFlagProfileRenderAvatarMoments and { Transparency = 1 } or nil,
        tag = {
            ["bg-surface-0"] = not FFlagProfileRenderAvatarMoments
        }
    }, {
        Presentation = React.createElement(MomentsImmersivePresentation, {
            feedKind = ImmersiveFeedKind.User,
            targetUserId = targetUserId,
            initialIndex = initialIndex,
            initialMomentId = initialMomentId,
            onBack = onBack,
            sessionSource = "profile",
            openMomentsFeedReport = openMomentsFeedReport,
            openMomentCommentReport = openMomentCommentReport,
            openBlockUser = openBlockUser
        })
    })
end else function() -- name: MomentsFeedPageLegacy
    local var1 = useNavigation()
    local param = var1.getParam("extraProps")

    local var2 = if param and param.targetUserId then param.targetUserId else 0
    local initialIndex = if param and param.initialIndex then param.initialIndex else 1
    local initialMomentId = if FFlagMomentsOptimisticProfilePending and param ~= nil then param.initialMomentId else nil

    local source = React.useMemo(function()
        return CreateUserMomentsFeedSource(var2, { initialIndex = initialIndex, initialMomentId = initialMomentId })
    end, { var2, initialIndex, initialMomentId })

    local onActivated = React.useCallback(function()
        fireAnalyticsEvent(EventNames.ProfileClosePressed, { userId = tostring(var2) })

        var1.goBack()
    end, { var1.goBack, var2 })

    local var6 = useScreenSize()
    local var7 = useSelector(function(arg1)
        return arg1.GlobalGuiInset
    end)

    local var8 = useStatusBarHeight()

    return React.createElement(View, {
        Size = UDim2.fromOffset(var6.X, var6.Y),
        padding = {
            top = UDim.new(0, var7.top + var8),
            bottom = UDim.new(0, var7.bottom),
            left = UDim.new(0, var7.left),
            right = UDim.new(0, var7.right)
        },
        backgroundStyle = FFlagProfileRenderAvatarMoments and { Transparency = 1 } or nil,
        tag = {
            ["bg-surface-0"] = not FFlagProfileRenderAvatarMoments
        }
    }, {
        OnVideoUI = React.createElement(FoundationProvider, {
            colorMode = ColorMode.Dark
        }, {
            Feed = React.createElement(Feed, { source = source, active = true, playbackActive = true, initialIndex = initialIndex }),
            CloseButtonContainer = React.createElement(
                View,
                { tag = "position-top-left anchor-top-left auto-xy padding-large", ZIndex = 100000 },
                {
                    CloseButton = React.createElement(
                        IconButton,
                        {
                            icon = "icons/navigation/close",
                            size = ButtonSize.Medium,
                            onActivated = onActivated
                        }
                    )
                }
            )
        })
    })
end
