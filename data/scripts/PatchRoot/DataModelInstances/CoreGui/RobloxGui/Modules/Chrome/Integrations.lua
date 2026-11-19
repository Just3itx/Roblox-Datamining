-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled
local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagEnableInExperienceAvatarSwitcher = SharedFlags.FFlagEnableInExperienceAvatarSwitcher
local FFlagAddInviteFriendsIntegration = SharedFlags.FFlagAddInviteFriendsIntegration
local FFlagAppNavMyStatsTab = SharedFlags.FFlagAppNavMyStatsTab
local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)
local FFlagEnableInExperienceShop = SharedFlags.FFlagEnableInExperienceShop
local FFlagEnableOffersPrefetch = SharedFlags.FFlagEnableOffersPrefetch
local FFlagIntegrateTraversalHistoryInSideSheet = SharedFlags.FFlagIntegrateTraversalHistoryInSideSheet
local FFlagRemoveFriendsChatUnibarEntrypoints = SharedFlags.FFlagRemoveFriendsChatUnibarEntrypoints
local FFlagExpChatCanShowFriendsTab = SharedFlags.FFlagExpChatCanShowFriendsTab
local FFlagShowSwitchServerButton = SharedFlags.FFlagShowSwitchServerButton
local isPioneerLaunch = require(CorePackages.Workspace.Packages.PioneerUtils).isPioneerLaunch
local FFlagEnableSideSheetRobuxWidget = require(script.Parent.Flags.FFlagEnableSideSheetRobuxWidget)
local bool1 = game:DefineFastFlag("SideSheetCloseOtherWindows", false)

local FFlagAddTraversalHistory = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon).Traversal.Flags.FFlagAddTraversalHistory

if bool1 then
    require(script.closeShopAndAvatarSwitcherOnSideSheet)()
end

return {
    OverflowMenu = require(script.OverflowMenu),
    AssistantBuild = if FFlagAppNavMyStatsTab then require(script.AssistantBuild) else nil,
    Chat = require(script.ExpChat.ChatChromeIntegration),
    ConnectDropdown = if FFlagRemoveFriendsChatUnibarEntrypoints and FFlagExpChatCanShowFriendsTab then nil else require(script.Connect.ConnectIconDropdown),
    TrustAndSafety = require(script.TrustAndSafety),
    DummyWindow = require(script.DummyWindow),
    DummyWindow2 = require(script.DummyWindow2),
    ToggleMic = require(script.ToggleMic),
    JoinVoice = require(script.JoinVoice),
    SelfieView = require(script.SelfieView),
    CapturesEntrypoint = require(script.Captures.CapturesEntrypoint),
    AvatarSwitcherEntryPoint = if FFlagEnableInExperienceAvatarSwitcher then require(script.AvatarSwitcher.AvatarSwitcherEntrypoint) else nil,
    MusicEntrypoint = require(script.MusicUtility.MusicEntrypoint),
    PartyEntrypoint = require(script.Party.PartyEntrypoint),
    PartyMic = require(script.Party.PartyMic),
    VRToggleButton = if isInExperienceUIVREnabled and isSpatial() then require(script.VRToggleButton) else nil,
    VRSafeBubble = if isInExperienceUIVREnabled and isSpatial() then require(script.VRSafeBubble) else nil,
    People = require(script.Pages.People),
    InviteFriends = if FFlagAddInviteFriendsIntegration then require(script.Pages.InviteFriends) else nil,
    Settings = require(script.Pages.Settings),
    Gallery = require(script.Pages.Gallery),
    Help = require(script.Pages.Help),
    TraversalHistory = if FFlagAddTraversalHistory and FFlagIntegrateTraversalHistoryInSideSheet then require(script.Pages.TraversalHistory) else nil,
    LeaveConfirmation = if isSideSheetEnabled then require(script.Pages.LeaveConfirmation) else nil,
    RespawnConfirmation = if isSideSheetEnabled then require(script.Pages.RespawnConfirmation) else nil,
    RobuxWidget = if FFlagEnableSideSheetRobuxWidget and isSideSheetEnabled then require(script.RobuxWidget) else nil,
    ShopEntrypoint = if FFlagEnableInExperienceShop then require(script.InExperienceShop.ShopEntrypoint) else nil,
    InitOffersPrefetch = if FFlagEnableOffersPrefetch then require(script.InExperienceOffers.initOffersPrefetch) else nil,
    SwitchServer = if isSideSheetEnabled and (isPioneerLaunch() or FFlagShowSwitchServerButton) then require(script.SwitchServer) else nil,
    AccountUpsell = if isPioneerLaunch() then require(script.AccountUpsell) else nil
}
