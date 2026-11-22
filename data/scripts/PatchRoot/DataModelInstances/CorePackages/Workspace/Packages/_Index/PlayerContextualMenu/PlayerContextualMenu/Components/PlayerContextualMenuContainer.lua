-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local PlayerContextualMenu = script:FindFirstAncestor("PlayerContextualMenu")
local PlayerContextualMenuParent = PlayerContextualMenu.Parent
local Cryo = require(PlayerContextualMenuParent.Cryo)
local React = require(PlayerContextualMenuParent.React)
local UserProfiles = require(PlayerContextualMenuParent.UserProfiles)
local Url = require(PlayerContextualMenuParent.Http).Url
local RoactRodux = require(PlayerContextualMenuParent.RoactUtils).Hooks.RoactRodux
local RobloxAppHooks = require(PlayerContextualMenuParent.RobloxAppHooks)
local AppPage = require(PlayerContextualMenuParent.RobloxAppEnums).AppPage
local useLocalization = require(PlayerContextualMenuParent.Localization).Hooks.useLocalization
local ToastRodux = require(PlayerContextualMenuParent.ToastRodux)
local DiscoveryAnalytics = require(PlayerContextualMenuParent.DiscoveryAnalytics)
local Navigation = require(PlayerContextualMenuParent.Navigation)
local getCurrentRouteState = Navigation.getCurrentRouteState
local ExperienceService = require(PlayerContextualMenuParent.ExperienceService).ExperienceService
local AppSessionService = require(PlayerContextualMenuParent.RoactServiceTags).AppSessionService
local RobloxAppSessionization = require(PlayerContextualMenuParent.RobloxAppSessionization)
local Dash = require(PlayerContextualMenuParent.Dash)
local SetGamePlaySession = RobloxAppSessionization.SetGamePlaySession
local SessionType = RobloxAppSessionization.SessionType

local var1 = require(PlayerContextualMenuParent.Loggers).Logger:new(script.Name)

local getFFlagAppChatPCMFixBlocking = require(PlayerContextualMenuParent.SharedFlags).getFFlagAppChatPCMFixBlocking

local RecommendationContextType = require(PlayerContextualMenuParent.FriendsRodux).config({ keyPath = "PlayerContextualMenu.Friends" }).Enums.RecommendationContextType

local useRecommendationContextualInfoDisplay = require(PlayerContextualMenuParent.SocialCommon).Hooks.useRecommendationContextualInfoDisplay

local _Types = require(script.Parent.Types)
local getPresenceIcon = require(script.Parent.getPresenceIcon)
local getPresenceText = require(script.Parent.getPresenceText)

local UIBlox = require(PlayerContextualMenuParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local useDesignTokens = require(PlayerContextualMenuParent.Style).useDesignTokens

local Analytics = require(PlayerContextualMenu.Analytics)
local setupFireEvent = Analytics.setupFireEvent
local EventNames = Analytics.EventNames
local AnalyticsService = Analytics.AnalyticsService

local Friends = require(PlayerContextualMenu.Http.Friends)
local Blocking = require(PlayerContextualMenu.Http.Blocking)
local PlayerContextualMenuComponent = require(PlayerContextualMenu.Components.PlayerContextualMenuComponent)
local useHttpRequest = require(script.Parent.HttpRequest.useHttpRequest)
local _Enums = require(PlayerContextualMenuParent.FriendsNetworking).Enums

local var2 = require(PlayerContextualMenuParent.DataHydration).Friends.FriendsStore.get()

local FFlagUserProfileConsoleUseNewReportFlow = require(PlayerContextualMenu.Flags.FFlagUserProfileConsoleUseNewReportFlow)
local CloseCentralOverlay = nil
local AbuseVector = nil
local OpenDynamicAbuseReport = nil
if FFlagUserProfileConsoleUseNewReportFlow then
    CloseCentralOverlay = require(PlayerContextualMenuParent.CentralOverlay).Thunks.CloseCentralOverlay
    AbuseVector = require(PlayerContextualMenuParent.GenericAbuseReporting.AbuseVector)
    OpenDynamicAbuseReport = require(PlayerContextualMenuParent.GenericAbuseReporting.OpenDynamicAbuseReport)
end

local str1 = game:DefineFastString("PlayerContextualMenuVendorImagePath", "rbxasset://textures/ui/Shell/Icons/PlatformLogo.png")

local FFlagUserBlockingApiPlayerContextMenuEnabled = require(PlayerContextualMenu.Flags.FFlagUserBlockingApiPlayerContextMenuEnabled)
local FFlagSkipBlockModal = require(PlayerContextualMenuParent.SharedFlags).FFlagSkipBlockModal

local FFlagMigrateFriendshipStatusesRemainingActions = require(PlayerContextualMenuParent.SharedFlags).FFlagMigrateFriendshipStatusesRemainingActions
local PlatformFriendsService = if game:GetEngineFeature("PlatformFriendsService") and game:GetEngineFeature("PlatformFriendsProfile") then game:GetService("PlatformFriendsService") else nil

local function NO_OPT_CALLBACK() end

local function launchGameWithAnalytics(callback, pageName: string, subjectUserId: string, subjectPresence, arg1)
    SetGamePlaySession(arg1, SessionType.StructuralIdentifier.GamePlayFromFriendsList, true)

    callback(EventNames.JoinExperience, { profileUserId = subjectUserId })

    local joinAttemptId = HttpService:GenerateGUID(false)

    DiscoveryAnalytics.Events.gamePlayIntent(
        AnalyticsService.EventStream,
        DiscoveryAnalytics.Constants.Context.PlayerContextualMenu,
        {
            friendId = subjectUserId,
            pageName = pageName,
            placeId = if subjectPresence then subjectPresence.locationPlaceId else nil,
            rootPlaceId = if subjectPresence then subjectPresence.locationRootPlaceId else nil,
            joinAttemptId = joinAttemptId
        }
    )

    ExperienceService:LaunchExperience({ userId = subjectUserId, joinAttemptId = joinAttemptId }, "PlayerContextualMenu")
end

local tbl1 = {
    enableExperienceCTAs = true,
    width = UDim.new(0, 400)
}

local tbl2 = {
    AcceptConnection = "Feature.Friends.Action.AcceptFriend",
    AddConnection = "Feature.Profile.Label.AddFriend",
    IgnoreConnectionRequest = "Feature.AddFriends.Action.IgnoreFriendRequest",
    RemoveConnection = "Feature.Friends.Action.Unfriend",
    Block = "Feature.Friends.Action.Block",
    Unblock = "Feature.Friends.Action.Unblock",
    Chat = "CommonUI.Features.Label.Chat",
    Join = "Feature.Chat.Drawer.Join",
    PendingRequest = "Feature.Friends.Action.PendingRequest",
    Report = "Feature.Catalog.Action.Report",
    ViewDetails = "Feature.Profile.Label.ViewDetails",
    ViewPlatformProfile = "Feature.Friends.Action.ViewPlatformProfile",
    ConnectionAdded = "Feature.Friends.Action.FriendAdded",
    ConnectionRequestSent = "Feature.Friends.Action.FriendRequestSent",
    ConnectionRemoved = "Feature.Friends.Action.FriendRemoved",
    FriendRequestIgnored = "Feature.AddFriends.Action.RequestIgnored",
    SomethingIsWrong = "Feature.Toast.NetworkingError.SomethingIsWrong",
    UserBlocked = "Feature.Profile.Action.UserBlocked"
}

local function PlayerContextualMenuContainer(arg1)
    local var3 = Cryo.Dictionary.union(tbl1, arg1)
    local var4 = RoactRodux.useDispatch()
    local var5 = RobloxAppHooks.useLocalUserId()
    local var6 = Navigation.useNavigation()
    local var7 = RobloxAppHooks.useRoactService(AppSessionService)

    local var8 = useLocalization(tbl2)

    local tbl3 = {
        toastMessage = var8.SomethingIsWrong,
        isLocalized = true,
        toastType = ToastRodux.Enums.ToastType.NetworkingError
    }

    local var9 = React.useMemo(function()
        return setupFireEvent({ analytics = AnalyticsService, infoForAllEvents = { uid = var5 } })
    end, { var5 })

    local var10 = useHttpRequest()
    local var11, var12 = React.useState({ status = "NotStarted", isPlayable = false })

    React.useEffect(function()
        if not var3.subjectPresence or not var3.subjectPresence.locationUniverseId then
            return
        end

        var12({ status = "Fetching", isPlayable = false })

        var10(
            Url.GAME_URL .. "v1/games/multiget-playability-status?universeIds=" .. var3.subjectPresence.locationUniverseId,
            "GET"
        ):andThen(
            function(arg2)
                if arg2.responseBody and arg2.responseBody[1] then
                    var12({ status = "Finished", isPlayable = arg2.responseBody[1].isPlayable })
                end
            end
        ):catch(
            function(_)
                var12({ status = "Failed", isPlayable = false })
            end
        )
    end, { tostring(var3.subjectPresence) })

    local var13 = nil

    if getFFlagAppChatPCMFixBlocking() then
        var13 = RoactRodux.useSelector(function(arg2): boolean
            return (if FFlagUserBlockingApiPlayerContextMenuEnabled then arg2.PlayerContextualMenu.UserBlocking.isBlockedByMe else arg2.PlayerContextualMenu.IsBlockedByMe)[var3.subjectUserId] == nil
        end)

        React.useEffect(function()
            if not var13 then
                return
            end

            var4(Blocking.IsBlockedById.API({ userId = var3.subjectUserId })):andThen(function() end):catch(function()
                var1:warning("Failed to check if subject user is blocked")
            end)
        end, { var13, var4, var3.subjectUserId })
    end

    local var14 = useDesignTokens(function(arg2)
        return {
            iconEmphasis = arg2.Color.Content.Emphasis,
            onlinePresence = arg2.Color.System.Success,
            joinEventButtonHeight = arg2.Size.Size_1200
        }
    end)

    local var15 = UserProfiles.Hooks.useUserProfilesFetch(
        {
            userIds = { var3.subjectUserId },
            query = UserProfiles.Queries.userProfilesDisplayUserPlatformNamesByUserIds
        }
    )
    local str2 = ""
    local str3 = ""
    local str4 = ""
    local str5 = ""

    if var15.data then
        str2 = UserProfiles.Selectors.getUsernameFromId(var15.data, var3.subjectUserId)
        str3 = UserProfiles.Selectors.getDisplayNameFromId(var15.data, var3.subjectUserId)
        str4 = UserProfiles.Selectors.getPlatformNameFromId(var15.data, var3.subjectUserId)
        if PlatformFriendsService then
            str5 = UserProfiles.Selectors.getPlatformProfileIdFromId(var15.data, var3.subjectUserId)
        end
    end

    local bool1 = if str4 then str4 ~= "" else false

    if var3.recommendationContext == RecommendationContextType.Contacts then
        str3 = var3.contactName or ""
    end

    local var16, var17 = getPresenceIcon(var3.subjectPresence, var14)
    if var3.robloxFriendshipStatus ~= Enum.FriendStatus.Friend then
        var16 = nil
        var17 = nil
    end

    local presenceText = if var3.robloxFriendshipStatus == Enum.FriendStatus.Friend then getPresenceText(var3.subjectPresence) else nil

    if var3.recommendationContext then
        local var18 = useRecommendationContextualInfoDisplay(
            {
                contextType = var3.recommendationContext,
                mutualFriendsCount = var3.mutualFriendsCount
            }
        )
        presenceText = var18.text
        var16 = var18.icon
    end

    local onActivated = React.useCallback(function()
        var9(EventNames.ViewExperienceDetails, { profileUserId = var3.subjectUserId })

        var4(var3.closeCentralOverlayThunk())

        if not var3.subjectPresence or not var3.subjectPresence.locationUniverseId then
            return
        end

        local str6 = tostring(var3.subjectPresence.locationUniverseId)

        if var7 then
            SetGamePlaySession(var7, SessionType.StructuralIdentifier.GameDetailSource, false)
        end
        DiscoveryAnalytics.Events.gameDetailReferral(
            AnalyticsService.EventStream,
            DiscoveryAnalytics.Constants.Context.PlayerContextualMenu,
            {
                pg = getCurrentRouteState(var6).routeName,
                universeId = str6,
                pid = var3.subjectPresence.locationPlaceId,
                friendId = var3.subjectUserId
            }
        )

        var6.navigate(AppPage.ExperienceDetail, { detail = str6 })
    end, {
        var9,
        var3.subjectUserId,
        var3.closeCentralOverlayThunk,
        var3.subjectPresence,
        var6,
        var7
    })

    local useMemo = React.useMemo
    local function func1()
        if not var3.enableExperienceCTAs then
            return function()
                return React.createElement("Folder")
            end
        end

        return if (if var3.subjectPresence then var3.subjectPresence.status == "InGame" else false) and not var11.isPlayable then function()
            return React.createElement(Button, {
                buttonType = ButtonType.PrimarySystem,
                onActivated = onActivated,
                isLoading = false,
                size = UDim2.new(1, 0, 0, var14.joinEventButtonHeight),
                text = var8.ViewDetails,
                layoutOrder = 100
            })
        end else nil
    end

    local subjectPresence = var3.subjectPresence
    local renderJoinEventButton = useMemo(func1, { var11, tostring(subjectPresence), var3.enableExperienceCTAs })
    local join = if var3.robloxFriendshipStatus == Enum.FriendStatus.Friend
        and var3.subjectPresence
        and var3.subjectPresence.status == "InGame" then var8.Join else nil

    local joinEventOnActivated = React.useCallback(function()
        launchGameWithAnalytics(var9, getCurrentRouteState(var6).routeName, var3.subjectUserId, var3.subjectPresence, var7)
    end, {
        var9,
        var6,
        var3.subjectUserId,
        var3.subjectPresence,
        var7
    })
    local var18 = React.useCallback(function()
        var9(EventNames.ReportPlayer, { profileUserId = var3.subjectUserId })

        if var3.onReportActivated then
            var3.onReportActivated()
            return
        end
        var4(var3.closeCentralOverlayThunk())
        if FFlagUserProfileConsoleUseNewReportFlow then
            var4(
                OpenDynamicAbuseReport({
                    abuseVector = AbuseVector.UserProfile,
                    targetId = var3.subjectUserId,
                    onClose = function()
                        var4(CloseCentralOverlay())
                    end
                })
            )

            return
        end

        var6.navigate(
            AppPage.ReportScreen,
            {
                reportData = {
                    assetId = var3.subjectUserId,
                    reportAbuseVector = "user",
                    context = "profile",
                    platform = "console"
                }
            }
        )
    end, {
        var4,
        var6,
        var3.subjectUserId,
        var3.closeCentralOverlayThunk,
        var3.onReportActivated
    })

    local var19 = if PlatformFriendsService then React.useCallback(function()
        var9(EventNames.ViewPlatformProfile, { profileUserId = var3.subjectUserId })
        PlatformFriendsService:ShowProfile(str5)
    end, {
        str5,
        var4,
        var6,
        var3.subjectUserId,
        var3.closeCentralOverlayThunk
    }) else nil

    local useCallback = React.useCallback

    local function func2()
        var9(EventNames.BlockPlayer, { profileUserId = var3.subjectUserId })

        if FFlagSkipBlockModal and var3.skipBlockModal then
            var4(Blocking.BlockUserById.API({ userId = var3.subjectUserId, currentUserId = var5 })):andThen(function()
                var4(
                    ToastRodux.Actions.SetCurrentToastMessage(
                        {
                            toastMessage = var8.UserBlocked,
                            isLocalized = true,
                            toastType = ToastRodux.Enums.ToastType.SuccessConfirmation
                        }
                    )
                )
                var4(var3.closeCentralOverlayThunk())
            end):catch(function(_)
                var4(ToastRodux.Actions.SetCurrentToastMessage(tbl3))
            end)

            return
        end

        if var3.onBlockActivated then
            var3.onBlockActivated()
            return
        end
        var4(var3.closeCentralOverlayThunk())
        var6.push(AppPage.BlockingModal, {
            navProps = {
                userId = var3.subjectUserId,
                onBlockSuccess = function()
                    var4(
                        ToastRodux.Actions.SetCurrentToastMessage(
                            {
                                toastMessage = var8.UserBlocked,
                                isLocalized = true,
                                toastType = ToastRodux.Enums.ToastType.SuccessConfirmation
                            }
                        )
                    )
                end
            }
        })
    end

    local closeCentralOverlayThunk = var3.closeCentralOverlayThunk
    local subjectUserId = var3.subjectUserId
    local onBlockActivated = var3.onBlockActivated
    local skipBlockModal = if FFlagSkipBlockModal then var3.skipBlockModal else nil
    local var20 = useCallback(func2, { var8, var5, var4, closeCentralOverlayThunk, subjectUserId, onBlockActivated, skipBlockModal })

    local var21 = React.useCallback(function()
        var4(Blocking.UnblockUserById.API({ userId = var3.subjectUserId, currentUserId = var5 })):andThen(function()
            var4(var3.closeCentralOverlayThunk())
        end):catch(function(_)
            var4(ToastRodux.Actions.SetCurrentToastMessage(tbl3))
        end)
    end, {
        var5,
        var4,
        var3.closeCentralOverlayThunk,
        var3.subjectUserId
    })
    local var22 = React.useCallback(function()
        var9(EventNames.Unfriend, { profileUserId = var3.subjectUserId })
        local var25 = if FFlagMigrateFriendshipStatusesRemainingActions then var2.Unfriend(var3.subjectUserId) else var4(Friends.UnfriendTargetUserId.API({ targetUserId = var3.subjectUserId, currentUserId = var5 }))

        var25:andThen(function()
            var4(
                ToastRodux.Actions.SetCurrentToastMessage({
                    toastMessage = var8.ConnectionRemoved,
                    isLocalized = true,
                    toastType = ToastRodux.Enums.ToastType.SuccessConfirmation
                })
            )
            var4(var3.closeCentralOverlayThunk())
        end):catch(function()
            var4(ToastRodux.Actions.SetCurrentToastMessage(tbl3))
        end)
    end, {
        var8,
        var5,
        var4,
        var3.subjectUserId,
        var3.closeCentralOverlayThunk
    })
    local var23 = React.useCallback(function()
        var9(EventNames.RequestFriendship, { profileUserId = var3.subjectUserId })
        local contactId = var3.contactId
        local var26 = var3.recommendationContext == RecommendationContextType.Contacts and contactId
        local var27

        if FFlagMigrateFriendshipStatusesRemainingActions then
            if var26 then
                var27 = var2.RequestFriendship(contactId, var3.friendshipOriginSourceType, { isContact = true })
            else
                var27 = var2.RequestFriendship(var3.subjectUserId, var3.friendshipOriginSourceType)
            end
        else
            var27 = var4(
                if var26 then Friends.RequestFriendshipFromContactId.API({ contactId = contactId, currentUserId = var5 }) else Friends.RequestFriendshipFromUserId.API(
                    {
                        targetUserId = var3.subjectUserId,
                        currentUserId = var5,
                        friendshipOriginSourceType = var3.friendshipOriginSourceType
                    }
                )
            )
        end

        var27:andThen(function()
            var4(
                ToastRodux.Actions.SetCurrentToastMessage({
                    toastMessage = var8.ConnectionRequestSent,
                    isLocalized = true,
                    toastType = ToastRodux.Enums.ToastType.SuccessConfirmation
                })
            )
            var4(var3.closeCentralOverlayThunk())
        end):catch(function()
            var4(ToastRodux.Actions.SetCurrentToastMessage(tbl3))
        end)
    end, {
        var8,
        var5,
        var4,
        var3.closeCentralOverlayThunk,
        var3.subjectUserId,
        var3.recommendationContext,
        var3.contactId,
        var3.friendshipOriginSourceType
    })

    local var24 = React.useCallback(function()
        var9(EventNames.AcceptFriendRequest, { profileUserId = var3.subjectUserId })
        local var27 = if FFlagMigrateFriendshipStatusesRemainingActions then var2.AcceptFriendRequest(var3.subjectUserId) else var4(Friends.AcceptFriendRequestFromUserId.API({ targetUserId = var3.subjectUserId, currentUserId = var5 }))

        var27:andThen(function()
            var4(
                ToastRodux.Actions.SetCurrentToastMessage(
                    {
                        toastMessage = var8.ConnectionAdded,
                        isLocalized = true,
                        toastType = ToastRodux.Enums.ToastType.SuccessConfirmation
                    }
                )
            )
            var4(var3.closeCentralOverlayThunk())
        end):catch(function()
            var4(ToastRodux.Actions.SetCurrentToastMessage(tbl3))
        end)
    end, {
        var8,
        var5,
        var4,
        var3.closeCentralOverlayThunk,
        var3.subjectUserId
    })
    local var25 = React.useCallback(function()
        var9(EventNames.IgnoreFriendRequest, { profileUserId = var3.subjectUserId })
        local var28 = if FFlagMigrateFriendshipStatusesRemainingActions then var2.DeclineFriendRequest(var3.subjectUserId) else var4(Friends.DeclineFriendRequestFromUserId.API({ targetUserId = var3.subjectUserId, currentUserId = var5 }))

        var28:andThen(function()
            var4(
                ToastRodux.Actions.SetCurrentToastMessage({
                    toastMessage = var8.FriendRequestIgnored,
                    isLocalized = true,
                    toastType = ToastRodux.Enums.ToastType.SuccessConfirmation
                })
            )
            var4(var3.closeCentralOverlayThunk())
        end):catch(function()
            var4(ToastRodux.Actions.SetCurrentToastMessage(tbl3))
        end)
    end, {
        var8,
        var5,
        var4,
        var3.closeCentralOverlayThunk,
        var3.subjectUserId
    })
    local var29 = RoactRodux.useSelector(function(arg2)
        return (if FFlagUserBlockingApiPlayerContextMenuEnabled then arg2.PlayerContextualMenu.UserBlocking.isBlockedByMe else arg2.PlayerContextualMenu.IsBlockedByMe)[var3.subjectUserId]
            or false
    end)

    local buttonProps = React.useMemo(function()
        local tbl4 = {
            icon = Images["icons/actions/feedback"],
            text = var8.Report,
            onActivated = var18
        }

        local tbl5 = {
            icon = str1,
            text = var8.ViewPlatformProfile,
            onActivated = var19
        }

        local tbl6 = {
            icon = Images["icons/actions/block"],
            text = var8.Block,
            onActivated = var20,
            disabled = var13
        }

        local tbl7 = {
            icon = Images["icons/actions/block"],
            text = var8.Unblock,
            onActivated = var21
        }

        local tbl8 = {
            icon = Images["icons/actions/friends/friendRemove"],
            text = var8.RemoveConnection,
            onActivated = var22
        }

        local tbl9 = {
            icon = Images["icons/actions/friends/friendAdd"],
            text = var8.AddConnection,
            onActivated = var23
        }

        local tbl10 = {
            icon = Images["icons/actions/friends/friendpending"],
            text = var8.PendingRequest,
            onActivated = NO_OPT_CALLBACK
        }

        local tbl11 = {
            icon = Images["icons/actions/friends/friendpending"],
            text = var8.AcceptConnection,
            onActivated = var24
        }

        local tbl12 = {
            icon = Images["icons/actions/reject"],
            text = var8.IgnoreConnectionRequest,
            onActivated = var25
        }

        local function makeCtas()
            local var30 = if var29 then tbl7 else tbl6
            local tbl13

            if var3.robloxFriendshipStatus == Enum.FriendStatus.Friend then
                tbl13 = { nil, nil, nil }
                local tbl14 = tbl4
                if not getFFlagAppChatPCMFixBlocking() then
                    var30 = tbl6
                end

                tbl13[1], tbl13[2], tbl13[3] = tbl14, var30, tbl8
            elseif var3.robloxFriendshipStatus == Enum.FriendStatus.NotFriend then
                tbl13 = var3.contactId and { tbl9 } or { tbl9, tbl4, var30 }
            else
                tbl13 = var3.robloxFriendshipStatus == Enum.FriendStatus.FriendRequestSent and { tbl10, tbl4, var30 }
                    or var3.robloxFriendshipStatus == Enum.FriendStatus.FriendRequestReceived and {
                        tbl11,
                        tbl12,
                        tbl4,
                        var30
                    }
                    or { tbl4, var30 }
            end

            if var3.additionalButtons then
                tbl13 = Cryo.List.join(tbl13, var3.additionalButtons)
            end

            return tbl13
        end

        if PlatformFriendsService and PlatformFriendsService:IsProfileEnabled() and str5 and str5 ~= "" then
            return Dash.append({ tbl5 }, (makeCtas()))
        end

        return (makeCtas())
    end, Cryo.Dictionary.union(
        PlatformFriendsService and {
            var3.robloxFriendshipStatus,
            var29,
            str5,
            var3.contactId,
            var3.additionalButtons
        }
            or {
                var3.robloxFriendshipStatus,
                var29,
                var3.contactId,
                var3.additionalButtons
            },
        getFFlagAppChatPCMFixBlocking() and { var13 } or {}
    ))

    return React.createElement(PlayerContextualMenuComponent, {
        headerProps = React.useMemo(function()
            return {
                displayNameItem = {
                    labelText = str3,
                    icon = nil,
                    isLoading = var15.loading
                },
                userNameItem = var3.recommendationContext ~= RecommendationContextType.Contacts
                    and {
                        labelText = "@" .. str2,
                        icon = nil,
                        isLoading = var15.loading
                    }
                    or nil,
                vendorNameItem = str4 ~= ""
                    and {
                        labelText = str4 or "",
                        icon = bool1 and {
                            Image = str1,
                            ImageRectOffset = Vector2.zero,
                            ImageRectSize = Vector2.zero
                        } or nil,
                        isLoading = var15.loading
                    }
                    or nil,
                contextText = presenceText,
                contextIcon = var16,
                contextIconColor = if var17 then var17.Color3 else nil,
                contextIconTransparency = if var17 then var17.Transparency else nil,
                joinEventText = join,
                joinEventOnActivated = joinEventOnActivated,
                renderJoinEventButton = renderJoinEventButton
            }
        end, {
            var15,
            str3,
            str2,
            str4,
            bool1,
            var16,
            presenceText,
            var17,
            renderJoinEventButton,
            join,
            joinEventOnActivated,
            var3.recommendationContext
        }),
        buttonProps = buttonProps,
        width = var3.width
    })
end

return PlayerContextualMenuContainer
