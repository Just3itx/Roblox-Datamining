-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local ReactOtter = require(MomentsParent.ReactOtter)
local _ReactFocusNavigation = require(MomentsParent.ReactFocusNavigation)
local SignalsReact = require(MomentsParent.SignalsReact)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local Localization = require(MomentsParent.Localization)
local FocusNavigationUtils = require(MomentsParent.FocusNavigationUtils)
local InputHandlers = require(MomentsParent.InputHandlers)
local SharedFlags = require(MomentsParent.SharedFlags)
local FFlagSocialFollowAttribution = SharedFlags.FFlagSocialFollowAttribution
local FollowAttribution = if FFlagSocialFollowAttribution then require(MomentsParent.SocialCommon.FollowAttribution) else nil
local Analytics = MomentsCommon.Analytics
local fireAnalyticsEvent = Analytics.fireAnalyticsEvent
local EventNames = Analytics.EventNames
local useLocalization = Localization.Hooks.useLocalization

local makeFeedActionFields = require(Moments.Analytics.makeFeedActionFields)

local Foundation = require(MomentsParent.Foundation)

local Dialog = Foundation.Dialog
local Loading = Foundation.Loading
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconSize = Foundation.Enums.IconSize
local Radius = Foundation.Enums.Radius
local ThumbnailType = Foundation.Enums.ThumbnailType
local ThumbnailSize = Foundation.Enums.ThumbnailSize
local ControlState = Foundation.Enums.ControlState
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local getRbxThumb = Foundation.Utility.getRbxThumb
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local useTokens = Foundation.Hooks.useTokens

local useUsername = require(Moments.Hooks.useUsername)
local useCreatorVerified = require(Moments.Hooks.useCreatorVerified)
local FFlagMomentsCreatorFollow = SharedFlags.FFlagMomentsCreatorFollow
local FFlagMomentsFlushDwellBeforeNavigation = require(Moments.Flags.FFlagMomentsFlushDwellBeforeNavigation)
local NavigationDestinationType = require(Moments.Enums.NavigationDestinationType)
local FFlagMomentsNavigationEvent = require(Moments.Flags.FFlagMomentsNavigationEvent)
local SignalActionType = require(Moments.Enums.SignalActionType)

local Following = require(MomentsParent.DataHydration.Following)
local FollowingStore = Following.FollowingStore
local FollowingUpdateErrorTypeEnum = Following.FollowingUpdateErrorTypeEnum
local ImageWithSkeleton = require(Moments.Components.ImageWithSkeleton)
local FeedContext = require(Moments.Components.Feed.FeedContext)
local GetToastStore = require(Moments.Stores.GetToastStore)
local useMomentsHost = require(Moments.MomentsHostContext).useMomentsHost
local MomentContext = require(script.Parent.Parent.Parent.MomentContext)
local _createMomentStore = require(script.Parent.Parent.Parent.createMomentStore)
local getColorStyleWithTransparency = require(Moments.Utils.getColorStyleWithTransparency)
local getLocalUserId = require(Moments.Utils.getLocalUserId)

local vector2 = Vector2.new(120, 16)
local tbl1 = {
    Color3 = Color3.new(1, 1, 1),
    Transparency = 0
}

local str1 = utf8.char(57344)

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local tbl3 = {
    cancel = "Feature.Groups.Action.Cancel",
    follow = "Feature.Groups.Action.Follow",
    followed = "Feature.Friends.Label.Followed",
    following = "Feature.Friends.Label.Following",
    somethingIsWrong = "Feature.Toast.NetworkingError.SomethingIsWrong",
    unfollow = "Feature.Groups.Action.Unfollow",
    unfollowed = "Feature.Friends.Label.Unfollowed",
    userNotPassedCaptchaError = "Feature.Friends.Error.UserNotPassedCaptcha"
}

local function showFollowToast(title: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    GetToastStore(false).triggerToast({ title = title, text = "" })
end

local var1 = nil
local function getCreatorFollowLogger() -- Luacid: Inlined by compiler; 15 call sites recovered
    if var1 == nil then
        var1 = require(MomentsParent.Loggers).Logger:new("Moments.CreatorFollow")
    end
    return var1
end

local function createLoggedChallengeNetwork(creatorId: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local middleware = require(MomentsParent.GenericChallenges).Middleware
    return middleware.createChallengeNetwork(function(arg1)
        getCreatorFollowLogger():debug("captcha required creatorId={}", creatorId)
        local var2 = middleware.InterceptChallenge(arg1)
        getCreatorFollowLogger():debug("captcha opened creatorId={}", creatorId)
        return var2:andThen(function<T>(arg2: T): T
            getCreatorFollowLogger():debug("captcha completed creatorId={}", creatorId)
            return arg2
        end, function(arg2)
            getCreatorFollowLogger():warning("captcha failed creatorId={} error={}", creatorId, tostring(arg2))
            error(arg2)
        end)
    end)
end

local function UnfollowConfirmationDialog(tbl4)
    local var2 = useLocalization({ title = { "Feature.Moments.Title.UnfollowConfirmationDialog", username = tbl4.creatorUsername } })

    local onCancel = tbl4.onCancel
    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    onCancel()
                    arg1:cancel()
                end)
            }
        }
    end, { onCancel })
    local ref = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isAutoFocusRoot = true,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })

    return React.createElement(Dialog.Root, {
        ref = ref,
        disablePortal = false,
        size = Foundation.Enums.DialogSize.Medium,
        hasBackdrop = true,
        testId = "moments-creator-unfollow-dialog"
    }, {
        DialogTitle = React.createElement(Dialog.Title, { text = var2.title, LayoutOrder = 1 }),
        DialogActions = React.createElement(Dialog.Actions, {
            LayoutOrder = 2,
            actions = {
                {
                    text = tbl4.unfollowText,
                    variant = ButtonVariant.Alert,
                    onActivated = tbl4.onConfirm,
                    testId = "moments-creator-unfollow-confirm"
                },
                {
                    text = tbl4.cancelText,
                    variant = ButtonVariant.Standard,
                    onActivated = tbl4.onCancel,
                    testId = "moments-creator-unfollow-cancel"
                }
            }
        })
    })
end

return React.memo(function(tbl4) -- name: CreatorAttribution
    local var2 = useTokens()
    local var3 = MomentContext.useMoment()

    local data = var3.store.getData(false)

    local var4 = nil
    local var5 = nil
    local var6 = nil
    local var7 = nil
    local var8 = nil
    local var9 = nil
    local var10 = nil
    local var11 = nil
    local var12 = nil
    local var13 = nil
    if FFlagMomentsCreatorFollow then
        var4 = useLocalization(tbl3)

        local var14 = React.useMemo(function()
            return FollowingStore.get().GetIsFollowing(tostring(data.creatorId))
        end, { data.creatorId })

        var5 = SignalsReact.useSignalState(var14.data) == true

        var6 = SignalsReact.useSignalState(var14.status) == "NotReady"
        local var15
        var7, var15 = React.useState(false)
        var10 = var15
        local var16
        var9, var16 = React.useState(nil)
        var11 = var16
        local var17
        var8, var17 = React.useState(false)
        var12 = var17

        var13 = React.useRef(false)
    end

    local var14, var15 = React.useState(false)
    local var16, var17 = ReactOtter.useAnimatedBinding(0)

    React.useEffect(function()
        var17(
            ReactOtter.ease(
                if var14 then 0.6 else 0,
                {
                    duration = if var14 then 0.05 else 0.03,
                    easingStyle = Enum.EasingStyle.Quad
                }
            )
        )
    end, { var14 })

    local animationRatio = var3.animationRatio
    local var18 = React.joinBindings({ animationRatio, var16 }):map(function(tbl5): number
        return 1 - (1 - tbl5[1]) * (1 - tbl5[2])
    end)

    local var19 = useUsername(data.creatorId)

    local var20 = useCreatorVerified(data.creatorId)

    local openProfile = useMomentsHost().openProfile
    local var21 = if FFlagMomentsCreatorFollow or FFlagMomentsFlushDwellBeforeNavigation then FeedContext.useFeedOptional() else nil

    local var22 = React.useCallback(function()
        if openProfile == nil then
            return
        end

        local feedActionFields = makeFeedActionFields(data.momentId, data.feedItemId, data.feedSessionId)
        if feedActionFields ~= nil then
            fireAnalyticsEvent(EventNames.ProfileCreatorInfoTapped, feedActionFields)
        end
        if FFlagMomentsFlushDwellBeforeNavigation and var21 ~= nil then
            var21.flushView(if FFlagMomentsNavigationEvent then NavigationDestinationType.CreatorProfile else nil)
        end

        openProfile(data.creatorId)
    end, FFlagMomentsFlushDwellBeforeNavigation
        and {
            openProfile,
            var21,
            data.creatorId,
            data.momentId,
            data.feedItemId,
            data.feedSessionId
        }
        or {
            openProfile,
            data.creatorId,
            data.momentId,
            data.feedItemId,
            data.feedSessionId
        })

    local size800 = var2.Size.Size_800
    local var23 = if var19 and var20 then `{var19} {str1}` else var19

    local var24 = if FFlagMomentsCreatorFollow then React.useCallback(function(bool1: boolean)
        if var13.current then
            return
        end

        local var24 = var4
        var13.current = true
        var11(bool1)
        var10(true)
        getCreatorFollowLogger():debug("request started creatorId={}", data.creatorId)

        local success, result = pcall(function()
            local loggedChallengeNetwork = createLoggedChallengeNetwork(data.creatorId)
            getCreatorFollowLogger():debug("challenge network ready creatorId={}", data.creatorId)
            local var25 = FollowingStore.get()
            local var26 = if bool1 then var25.Follow(tostring(data.creatorId), loggedChallengeNetwork) else var25.Unfollow(tostring(data.creatorId), loggedChallengeNetwork)
            getCreatorFollowLogger():debug("request dispatched creatorId={}", data.creatorId)
            return var26
        end)
        if not success then
            var13.current = false
            var11(nil)
            var10(false)
            getCreatorFollowLogger():warning("request setup failed creatorId={} error={}", data.creatorId, tostring(result))

            showFollowToast(var24.somethingIsWrong)
            return
        end

        return result:andThen(function()
            var13.current = false
            var11(nil)
            var10(false)
            if FFlagSocialFollowAttribution and bool1 then
                FollowAttribution.reportFollowSuccess(
                    {
                        surface = FollowAttribution.Surface.Moments,
                        source = FollowAttribution.Source.MomentsFeed
                    }
                )
            end

            local feedItemId = data.feedItemId
            if var21 ~= nil and feedItemId ~= nil and feedItemId ~= "" then
                local success2, result2 = pcall(function()
                    var21.logAction(
                        if bool1 then SignalActionType.AddFollow else SignalActionType.RemoveFollow,
                        {
                            itemId = feedItemId,
                            tracingId = data.feedSessionId
                        },
                        {}
                    )
                end)
                if not success2 then
                    getCreatorFollowLogger():warning("preference signal failed creatorId={} error={}", data.creatorId, tostring(result2))
                end
            end

            getCreatorFollowLogger():debug("request succeeded creatorId={}", data.creatorId)
            local var25 = if bool1 then var24.followed else var24.unfollowed
            showFollowToast(var25)
        end, function(arg1)
            var13.current = false
            var11(nil)
            var10(false)
            local var25 = if type(arg1) == "table" and arg1.errorType ~= nil then tostring(arg1.errorType) else "Unknown"
            local var26 = if type(arg1) == "table" and arg1.responseCode ~= nil then tostring(arg1.responseCode) else "Unknown"
            getCreatorFollowLogger():warning(
                "request failed creatorId={} errorType={} responseCode={}",
                data.creatorId,
                var25,
                var26
            )
            local var27 = if var25 == FollowingUpdateErrorTypeEnum.Captcha then var24.userNotPassedCaptchaError else var24.somethingIsWrong
            showFollowToast(var27)
        end)
    end, {
        data.creatorId,
        data.feedItemId,
        data.feedSessionId,
        var21,
        var4
    }) else nil

    local onActivated = if FFlagMomentsCreatorFollow then React.useCallback(function()
        if not var5 then
            return var24(true)
        end

        var12(true)
    end, { var5, var24 }) else nil

    local onConfirm = if FFlagMomentsCreatorFollow then React.useCallback(function()
        var12(false)
        return var24(false)
    end, { var24 }) else nil

    local var27 = if FFlagMomentsCreatorFollow then if var9 == nil then var5 else not var9 else nil
    local isDisabled = if FFlagMomentsCreatorFollow then var6 or var7 else nil
    local createElement = React.createElement
    local var29 = View
    local tbl5 = {
        LayoutOrder = tbl4.LayoutOrder,
        testId = if FFlagMomentsFlushDwellBeforeNavigation then "--moments-creator-attribution" else nil,
        tag = "row align-x-left align-y-center gap-small auto-xy",
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        onActivated = 0,
        onStateChanged = 0
    }

    if openProfile == nil then
        var22 = nil
    end

    tbl5.onActivated = var22
    function tbl5.onStateChanged(arg1)
        var15(arg1 == ControlState.Pressed or arg1 == ControlState.SelectedPressed)
    end
    local tbl6 = {
        Avatar = React.createElement(ImageWithSkeleton, {
            LayoutOrder = 1,
            Image = getRbxThumb(ThumbnailType.AvatarHeadShot, data.creatorId, ThumbnailSize.Medium),
            Size = UDim2.fromOffset(size800, size800),
            radius = Radius.Circle,
            backgroundStyle = var18:map(function(num1: number)
                return getColorStyleWithTransparency(var2.Color.Shift.Shift_300, num1)
            end),
            imageStyle = var18:map(function(num1: number)
                return getColorStyleWithTransparency(tbl1, num1)
            end)
        }),
        Username = if var23 then React.createElement(FoundationText, {
            LayoutOrder = 2,
            tag = "auto-xy text-title-large text-align-x-left text-align-y-center text-truncate-end content-emphasis",
            Text = var23,
            textStyle = var18:map(function(num1: number)
                return getColorStyleWithTransparency(var2.Color.Content.Emphasis, num1)
            end)
        }) else React.createElement(
            Skeleton,
            {
                LayoutOrder = 2,
                radius = Radius.Medium,
                Size = UDim2.fromOffset(vector2.X, vector2.Y)
            }
        ),
        FollowAction = 0,
        UnfollowDialog = 0
    }

    local var30

    if FFlagMomentsCreatorFollow and data.creatorId ~= getLocalUserId() then
        local createElement2 = React.createElement
        local var31 = View

        local tbl7 = {
            LayoutOrder = 3,
            tag = "row align-x-center align-y-center size-0-600 auto-x padding-x-small radius-small",
            backgroundStyle = var18:map(function(num1: number)
                return getColorStyleWithTransparency(var2.Color.ActionStandard.Background, num1)
            end),
            isDisabled = isDisabled,
            onActivated = onActivated,
            stroke = {
                Color = var2.Color.Content.Emphasis.Color3,
                Transparency = var18:map(function(num1: number)
                    return getColorStyleWithTransparency(var2.Color.Content.Emphasis, num1).Transparency or 0
                end),
                Thickness = if isDisabled then 0 else var2.Stroke.Standard,
                BorderStrokePosition = Enum.BorderStrokePosition.Inner
            },
            testId = "moments-creator-follow-button"
        }

        local tbl8 = {
            Label = React.createElement(FoundationText, {
                Text = if var27 then var4.following else var4.follow,
                tag = "auto-xy text-label-small content-system-contrast",
                testId = "moments-creator-follow-button--text",
                textStyle = var18:map(function(num1: number)
                    return getColorStyleWithTransparency(var2.Color.System.Contrast, if isDisabled then 1 else num1)
                end)
            }, {
                Loading = if isDisabled then React.createElement(
                    Loading,
                    {
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        size = IconSize.XSmall
                    }
                ) else nil
            })
        }

        var30 = createElement2(var31, tbl7, tbl8)
    else
        var30 = nil
    end

    tbl6.FollowAction = var30
    local var31

    if FFlagMomentsCreatorFollow and var8 then
        local createElement2 = React.createElement
        local func1 = UnfollowConfirmationDialog
        local tbl7 = {
            cancelText = var4.cancel,
            creatorUsername = 0,
            onCancel = 0,
            onConfirm = 0,
            unfollowText = 0
        }
        var19 = var19 or tostring(data.creatorId)
        tbl7.creatorUsername = var19
        function tbl7.onCancel()
            var12(false)
        end
        tbl7.onConfirm = onConfirm
        tbl7.unfollowText = var4.unfollow
        var31 = createElement2(func1, tbl7)
    else
        var31 = nil
    end

    tbl6.UnfollowDialog = var31
    return createElement(var29, tbl5, tbl6)
end)
