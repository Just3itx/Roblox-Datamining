-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local _LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)

return {
    Access = {
        Actionable = "Actionable",
        Denied = "Denied",
        Granted = "Granted",
        Pending = "Pending"
    },
    EventStatus = {
        Active = "active",
        Cancelled = "cancelled",
        Moderated = "moderated",
        Unpublished = "unpublished"
    },
    HostType = { Group = "group", User = "user" },
    MediaAssetType = {
        GamePreviewVideo = "GamePreviewVideo",
        Image = "Image",
        Video = "Video",
        YouTubeVideo = "YouTubeVideo"
    },
    PresenceType = {
        InGame = "InGame",
        InStudio = "InStudio",
        Offline = "Offline",
        Online = "Online"
    },
    RecourseActions = {
        AddedEmail = "AddedEmail",
        Email = "Email",
        GovernmentId = "GovernmentId",
        Phone = "Phone",
        ParentConsent = "ParentConsent",
        ParentLink = "ParentLink",
        Subscription = "Subscription"
    },
    RsvpStatus = {
        Going = "going",
        MaybeGoing = "maybeGoing",
        None = "none",
        NotGoing = "notGoing"
    },
    ShareLinkType = {
        ExperienceDetails = "ExperienceDetails",
        ExperienceInvite = "ExperienceInvite",
        FriendInvite = "FriendInvite",
        Home = "Home",
        NotificationExperienceInvite = "NotificationExperienceInvite",
        PrivateServer = "PrivateServer",
        Profile = "Profile",
        ScreenshotInvite = "ScreenshotInvite",
        Server = "Server"
    },
    VPCRequestTypes = {
        ChargebackReenableAccount = "ChargebackReenableAccount",
        SavePaymentMethods = "SavePaymentMethods",
        UpdateUserSetting = "UpdateUserSetting",
        UpdateBirthdate = "UpdateBirthdate",
        LinkToChild = "LinkToChild",
        ManageFriend = "ManageFriend",
        ManageExperience = "ManageExperience",
        LiftPunishment = "LiftPunishment",
        AddTrustedConnection = "AddTrustedConnection",
        SendTransfer = "SendTransfer",
        ReceiveTransfer = "ReceiveTransfer",
        Unknown = "Unknown"
    }
}
