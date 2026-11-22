-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IXPService = game:GetService("IXPService")
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent

local Cryo = require(ProfileQRCodeParent.Cryo)
local React = require(ProfileQRCodeParent.React)
local RoactAppExperiment = require(ProfileQRCodeParent.RoactAppExperiment)
local Localization = require(ProfileQRCodeParent.Localization)
local UIBlox = require(ProfileQRCodeParent.UIBlox)
local Toast = UIBlox.App.Dialog.Toast

local EventNames = require(ProfileQRCode.Analytics.EventNames)
local ProfileQRCodeTopBar = require(ProfileQRCode.Components.ProfileQRCodeTopBar)
local QRCodeFriendRequestNotification = require(ProfileQRCode.Components.QRCodeFriendRequestNotification)
local FriendAcceptedSnackbar = require(ProfileQRCode.Components.FriendAcceptedSnackbar)
local TextKeys = require(ProfileQRCode.Common.TextKeys)
local useAcceptFriendUrl = require(ProfileQRCode.Networking.useAcceptFriendUrl)
local useAnalytics = require(ProfileQRCode.Analytics.useAnalytics)
local useGetUsersInfoUrl = require(ProfileQRCode.Networking.useGetUsersInfoUrl)
local useLocalization = Localization.Hooks.useLocalization
local useLocalUserId = require(ProfileQRCodeParent.RobloxAppHooks).useLocalUserId
local FriendsNetworking = require(ProfileQRCodeParent.FriendsNetworking)
local Images = UIBlox.App.ImageSet.Images

local SignalREvents = require(ProfileQRCode.Common.SignalREvents)

local getFStringProfileQRCodeFriendRequestAlertsExperimentKey = require(ProfileQRCode.Flags.getFStringProfileQRCodeFriendRequestAlertsExperimentKey)

local getFStringProfileQRCodeFriendRequestAlertsLayer = require(ProfileQRCode.Flags.getFStringProfileQRCodeFriendRequestAlertsLayer)
local FFlagQRCodeFriendRequestNotificationV2 = require(ProfileQRCode.Flags.FFlagQRCodeFriendRequestNotificationV2)

local FFlagQRCodeHideBannerForTrustedFriendRequest = require(ProfileQRCode.Flags.FFlagQRCodeHideBannerForTrustedFriendRequest)

local iconsActionsFriendsFriendAdd = Images["icons/actions/friends/friendAdd"]

return (RoactAppExperiment.connectUserLayer({ getFStringProfileQRCodeFriendRequestAlertsLayer() }, function(arg1, _)
    return {
        profileQRCodeFriendRequestAlertsEnabled = (arg1[getFStringProfileQRCodeFriendRequestAlertsLayer()] or {})[getFStringProfileQRCodeFriendRequestAlertsExperimentKey()]
    }
end, false)(function(tbl1)
    local var1 = useLocalization({ friendAdded = TextKeys.FriendAdded })

    local var2 = useAnalytics()
    local profileQrCodeFriendRequestAlertsEnabled = tbl1.profileQRCodeFriendRequestAlertsEnabled

    local robloxEventReceiver = tbl1.robloxEventReceiver
    local var3, var4 = React.useState(false)

    local var5 = nil
    local var6 = nil
    local var7 = nil
    local var8 = nil
    local var9 = nil
    local var10 = nil
    local var11

    if FFlagQRCodeFriendRequestNotificationV2 then
        local var12
        var5, var12 = React.useState("")
        var6 = var12
        local var13
        var7, var13 = React.useState(false)
        var8 = var13
        local var14
        var9, var14 = React.useState(false)
        var10 = var14
        var11 = React.useCallback(function()
            var10(false)
            var8(false)
        end, {})
    else
        var11 = nil
    end

    local var12, var13 = React.useReducer(function(arg1, arg2)
        if arg2.type == "addItemToQueue" then
            IXPService:LogUserLayerExposure(getFStringProfileQRCodeFriendRequestAlertsLayer())

            return Cryo.List.join(arg1, { arg2.newUserId })
        elseif arg2.type == "removeItemFromQueue" then
            return Cryo.List.removeIndex(arg1, 1)
        else
            return arg1
        end
    end, {})

    local var14 = useLocalUserId()
    local var15 = useGetUsersInfoUrl()
    local var16 = useAcceptFriendUrl()

    local var17 = nil
    var17 = FFlagQRCodeFriendRequestNotificationV2 and function(arg1): string
        local str1 = tostring(arg1.UserId1)
        if str1 == var14 then
            str1 = tostring(arg1.UserId2)
        end
        return str1
    end or var17

    local function friendshipNotificationReceived(arg1)
        if FFlagQRCodeHideBannerForTrustedFriendRequest
            and arg1.Type == SignalREvents.FriendshipRequested
            and arg1.EventArgs.TrustedFriendSource == "QrCrossAge"
        then
            return
        end

        if arg1.Type == SignalREvents.FriendshipRequested
            and arg1.EventArgs.SourceType == FriendsNetworking.Enums.FriendshipOriginSourceType.QrCode.rawValue()
        then
            local str1 = tostring(arg1.EventArgs.UserId1)
            if str1 == var14 then
                str1 = tostring(arg1.EventArgs.UserId2)
            end

            var15(str1):andThen(function()
                var13({ type = "addItemToQueue", newUserId = str1 })
            end)
        elseif arg1.Type == SignalREvents.FriendshipCreated and FFlagQRCodeFriendRequestNotificationV2 then
            local var18 = var17(arg1.EventArgs)

            var15(var18):andThen(function()
                var6(var18)
                var10(true)
                var8(arg1.EventArgs.IsTrustedFriend)
            end)
        end
    end

    React.useEffect(function()
        robloxEventReceiver:observeEvent(SignalREvents.FriendshipNotifications, function(arg1)
            friendshipNotificationReceived(arg1)
        end)
    end, { robloxEventReceiver })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = if FFlagQRCodeFriendRequestNotificationV2 then UDim2.new(1, 0, 1, 0) else UDim2.new(1, 0, 0, 56),
        BackgroundTransparency = 1,
        ZIndex = 3,
        LayoutOrder = 1
    }

    local tbl3 = {
        TopBarWrapper = React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                ZIndex = 3
            },
            {
                Layout = if FFlagQRCodeFriendRequestNotificationV2 then nil else React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Top,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }),
                TopBar = React.createElement(ProfileQRCodeTopBar, {
                    appStorageService = tbl1.appStorageService,
                    layoutOrder = 1,
                    onClose = tbl1.onClose,
                    openQrCodeScanner = tbl1.openQrCodeScanner
                })
            }
        ),
        FriendAcceptToastFrame = if profileQrCodeFriendRequestAlertsEnabled and var3 and not FFlagQRCodeFriendRequestNotificationV2 then React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                ZIndex = 100
            },
            {
                FriendAcceptToast = React.createElement(Toast, {
                    toastContent = {
                        toastTitle = var1.friendAdded,
                        iconImage = iconsActionsFriendsFriendAdd,
                        onDismissed = function()
                            var4(false)
                        end
                    },
                    duration = 3,
                    show = true
                })
            }
        ) else nil,
        FriendsInviteFrame = 0,
        FriendAcceptedSnackbar = 0
    }

    local var18

    if profileQrCodeFriendRequestAlertsEnabled and #var12 > 0 and not var3 then
        local createElement2 = React.createElement
        local tbl4 = {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, 24),
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 100
        }
        local tbl5 = {
            Padding = React.createElement("UIPadding", { PaddingRight = UDim.new(0, 28), PaddingLeft = UDim.new(0, 28) }),
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            FriendsInvite = React.createElement(QRCodeFriendRequestNotification, {
                notificationQueueSize = #var12,
                onAccept = function(arg1)
                    var16(var14, arg1):andThen(function()
                        var13({ type = "removeItemFromQueue", newUserId = "0" })
                        if not FFlagQRCodeFriendRequestNotificationV2 then
                            var4(true)
                        end
                    end):catch(function() end)
                    var2.fireEvent(EventNames.QRPageFriendRequestBannerAccepted, { qrCodeBannerQueueSize = #var12 })
                end,
                onClose = function()
                    var13({ type = "removeItemFromQueue", newUserId = "0" })
                    var2.fireEvent(EventNames.QRPageFriendRequestBannerDismissed, { qrCodeBannerQueueSize = #var12 })
                end,
                userId = tostring(var12[1])
            })
        }

        var18 = createElement2("Frame", tbl4, tbl5)
    else
        var18 = nil
    end

    tbl3.FriendsInviteFrame = var18

    tbl3.FriendAcceptedSnackbar = if var9 and FFlagQRCodeFriendRequestNotificationV2 then React.createElement(
        FriendAcceptedSnackbar,
        { acceptedFriendUserId = var5, newFriendIsTrusted = var7, onDismissed = var11 }
    ) else nil
    return createElement(str1, tbl2, tbl3)
end))
