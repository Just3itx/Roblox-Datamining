-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local _ToastNotificationsProtocol = require(scriptParentParent.ToastNotificationsProtocol)

return {
    ChannelListEnum = {
        App = "toast-in-app-notifications",
        Experience = "toast-in-experience-notifications",
        Dual = "toast-in-app-and-experience-notifications",
        Desktop = "toast-in-app-and-experience-desktop-notifications"
    },
    ActionTypeEnum = {
        Report = "reportNotification",
        Deeplink = "deeplink",
        NotificationApi = "notificationAPI",
        Dismiss = "dismiss",
        Reload = "reload",
        None = "none",
        VoltronBroadcast = "voltronBroadcast",
        UpdateState = "updateState",
        ClientTrigger = "clientTrigger"
    },
    SENDERButtonStyleEnum = {
        Primary = "Primary",
        Secondary = "Secondary",
        Alert = "Alert",
        Growth = "Growth"
    },
    SENDERThumbnailTypeEnum = {
        User = "userThumbnail",
        Game = "gameThumbnail",
        Group = "groupThumbnail",
        Asset = "assetThumbnail",
        Bundle = "bundleThumbnail",
        Icon = "icon",
        GamePass = "gamePassThumbnail",
        AvatarImageUrl = "avatarImageUrlThumbnail"
    },
    ToastNotificationActionsEnum = {
        ModalCancel = "modalCancel",
        ModalConfirm = "modalConfirm",
        Dismissed = "dismissed",
        Display = "displayed",
        Hover = "hoverOver",
        Ignored = "ignored",
        Update = "update",
        DeeplinkFailed = "deeplinkFailed"
    },
    RenderLocationEnum = { UniversalApp = "universalApp", CoreScript = "coreScript" },
    DeviceOrientationEnum = { Portrait = "Portrait", Landscape = "Landscape", Unknown = "Unknown" },
    VisualItemTypeEnum = {
        Button = "button",
        TextBody = "textBody",
        Thumbnail = "thumbnail",
        MetaAction = "metaAction"
    },
    NotificationTypeEnum = { CallReceived = "CallReceived" }
}
