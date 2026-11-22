-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:41:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialBlockingModal = script:FindFirstAncestor("SocialBlockingModal")
local SocialBlockingModalParent = SocialBlockingModal.Parent

local React = require(SocialBlockingModalParent.React)
local ReactRoblox = require(SocialBlockingModalParent.ReactRoblox)
local Foundation = require(SocialBlockingModalParent.Foundation)
local View = Foundation.View
local useOverlay = Foundation.Hooks.useOverlay
local useTokens = Foundation.Hooks.useTokens
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local RobloxAppHooks = require(SocialBlockingModalParent.RobloxAppHooks)
local useScreenSize = RobloxAppHooks.useScreenSize
local useLocalUserId = RobloxAppHooks.useLocalUserId

local useLocalization = require(SocialBlockingModalParent.Localization).Hooks.useLocalization
local useNavigation = require(SocialBlockingModalParent.Navigation).useNavigation
local useDispatch = require(SocialBlockingModalParent.RoactUtils).Hooks.RoactRodux.useDispatch
local NavigateDown = require(SocialBlockingModalParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(SocialBlockingModalParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(SocialBlockingModalParent.RobloxAppNavigation).NavigationCommands else nil
local AppPage = require(SocialBlockingModalParent.RobloxAppEnums).AppPage
local Url = require(SocialBlockingModalParent.Http).Url

local UIBlox = require(SocialBlockingModalParent.UIBlox)
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local useLayerCollector = UIBlox.Core.Layout.LayerCollector.useLayerCollector

local UserProfiles = require(SocialBlockingModalParent.UserProfiles)
local AbuseVector = require(SocialBlockingModalParent.GenericAbuseReporting.AbuseVector)
local OpenDynamicAbuseReport = require(SocialBlockingModalParent.GenericAbuseReporting.OpenDynamicAbuseReport)

local CloseCentralOverlay = require(SocialBlockingModalParent.CentralOverlay).Thunks.CloseCentralOverlay

local myUserBlockingNetworking = require(SocialBlockingModal.Networking.myUserBlockingNetworking)
local useShowToastOnError = require(script.Parent.useShowToastOnError)

local Analytics = require(script.Parent.Parent.Analytics)
local useSocialBlockingModalAnalytics = Analytics.useSocialBlockingModalAnalytics
local EventNames = Analytics.EventNames

local FocusNavigationUtils = require(SocialBlockingModalParent.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local FFlagEnableAbuseReportRevampFlow = require(SocialBlockingModalParent.SharedFlags).FFlagEnableAbuseReportRevampFlow
local FFlagDisableBlockAndReport = require(SocialBlockingModalParent.SharedFlags).FFlagDisableBlockAndReport
local FFlagEnableMomentsCommentBlocking = require(SocialBlockingModalParent.SharedFlags).FFlagEnableMomentsCommentBlocking
local FFlagMomentsBlockingModalInOverlay = require(SocialBlockingModalParent.SharedFlags).FFlagMomentsBlockingModalInOverlay

local function BlockingModal()
    local var1 = useNavigation()

    local param = var1.getParam("navProps")
    local userId = param.userId
    local onBlockSuccess = param.onBlockSuccess
    local openReportUser = param.openReportUser
    local disableReportOption = if FFlagDisableBlockAndReport then param.disableReportOption else nil
    local currentUserId = useLocalUserId()
    local var3 = useDispatch()
    local var4 = useScreenSize()

    local var5 = useLayerCollector()
    if not var4 and var5 and var5.absoluteSize then
        var4 = var5.absoluteSize
    end

    local var6 = React.useCallback(function()
        var1.pop()
    end, { var1 })

    local fireAnalyticsEvent = useSocialBlockingModalAnalytics({ userId = userId }).fireAnalyticsEvent

    React.useEffect(function()
        fireAnalyticsEvent(EventNames.SocialBlockingModalSeen)
    end, { userId })

    local var7 = useShowToastOnError()

    local var8 = React.useCallback(function()
        if FFlagEnableMomentsCommentBlocking and param.onBlockConfirmed then
            param.onBlockConfirmed()
        end
        var3(myUserBlockingNetworking.BlockUserById.API({ userId = userId, currentUserId = currentUserId })):andThen(function()
            if onBlockSuccess then
                onBlockSuccess()
            end
        end):catch(
            function(arg1)
                var7(arg1)
                if FFlagEnableMomentsCommentBlocking and param.onBlockFailed then
                    param.onBlockFailed()
                end
            end
        )
        var6()
    end, {
        onBlockSuccess,
        param,
        var6,
        userId,
        currentUserId,
        var3,
        var7
    })
    local onActivated = React.useCallback(function()
        fireAnalyticsEvent(EventNames.SocialBlockingModalBlockPressed)
        var8()
    end, { var8, userId, fireAnalyticsEvent })

    local var2 = React.useCallback(function()
        fireAnalyticsEvent(EventNames.SocialBlockingModalBlockAndReportPressed)
        var8()

        if openReportUser then
            openReportUser()
            return
        end
        if FFlagEnableAbuseReportRevampFlow then
            var3(OpenDynamicAbuseReport({
                abuseVector = AbuseVector.UserProfile,
                targetId = userId,
                onClose = function()
                    var3(CloseCentralOverlay())
                end
            }))

            return
        end

        local tbl1 = {
            name = AppPage.GenericWebPage,
            detail = `{Url.BASE_URL}abusereport/userprofile?id={userId}`,
            extraProps = { title = "" }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        var3(NavigateDown(tbl1))
    end, {
        var8,
        var3,
        userId,
        fireAnalyticsEvent,
        openReportUser
    })

    local var9 = React.useCallback(function()
        fireAnalyticsEvent(EventNames.SocialBlockingModalCancelPressed)
        var6()
    end, { var6, fireAnalyticsEvent })

    local var12 = UserProfiles.Hooks.useUserProfilesFetch(
        {
            userIds = { userId },
            query = UserProfiles.Queries.userProfilesCombinedNameByUserIds
        }
    )
    local displayName = if var12.data then UserProfiles.Selectors.getCombinedNameFromId(var12.data, userId) else nil
    local var13 = useLocalization({
        title = { "Feature.BlockingModal.Heading.BlockUser", DisplayName = displayName },
        bodyText = "Feature.BlockingModal.Message.BlockConfirmation.FriendsRename",
        cancelBtnText = "Feature.BlockingModal.Action.Cancel",
        blockBtnText = "Feature.BlockingModal.Action.Block",
        blockAndReportBtnText = "Feature.BlockingModal.Action.BlockAndReport"
    })

    local buttons = React.useMemo(function()
        local result = {}
        table.insert(result, { buttonType = ButtonType.Secondary, props = { text = var13.cancelBtnText, onActivated = var9 } })

        if not (FFlagDisableBlockAndReport and disableReportOption) then
            table.insert(
                result,
                {
                    buttonType = ButtonType.Alert,
                    props = {
                        text = var13.blockAndReportBtnText,
                        onActivated = var2
                    }
                }
            )
        end
        table.insert(
            result,
            {
                buttonType = ButtonType.Alert,
                props = {
                    text = var13.blockBtnText,
                    onActivated = onActivated
                }
            }
        )
        return result
    end, {
        var13,
        var9,
        var2,
        disableReportOption,
        onActivated
    })

    local blockingModalScreen = React.createElement(InteractiveAlert, {
        screenSize = var4,
        title = var13.title,
        bodyText = var13.bodyText,
        richText = true,
        isRoactGamepadEnabled = false,
        buttonStackInfo = {
            buttons = buttons or {}
        }
    })

    local blockingModal = React.createElement(
        FocusRoot,
        {
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
            isIsolated = true,
            isAutoFocusRoot = true
        },
        { BlockingModalScreen = blockingModalScreen }
    )

    if FFlagMomentsBlockingModalInOverlay and param.presentInOverlay then
        local var15 = useOverlay()

        local var16 = useTokens()
        if var15 ~= nil then
            return ReactRoblox.createPortal(
                React.createElement(View, {
                    tag = "size-full",
                    ZIndex = 300,
                    backgroundStyle = var16.Color.Common.Backdrop,
                    stateLayer = {
                        affordance = StateLayerAffordance.None
                    },
                    onActivated = function() end
                }, { BlockingModal = blockingModal }),
                var15
            )
        end
    end

    return blockingModal
end

return BlockingModal
