-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local AppShortcutBar = script:FindFirstAncestor("AppShortcutBar")
local AppShortcutBarParent = AppShortcutBar.Parent
local React = require(AppShortcutBarParent.React)
local Cryo = require(AppShortcutBarParent.Cryo)
local FocusNavigationEventNameEnum = require(AppShortcutBarParent.FocusNavigationUtils).FocusNavigationEventNameEnum
local ReactFocusNavigation = require(AppShortcutBarParent.ReactFocusNavigation)
local _AppShortcutBar = require(AppShortcutBar.Components.AppShortcutBar)
local LocalizationRoactContext = require(AppShortcutBarParent.Localization).LocalizationRoactContext
local Responsive = require(AppShortcutBarParent.Responsive)

local useHeldProgressByEvent = require(AppShortcutBar.Hooks.AppShortcutBarContext).useHeldProgressByEvent
local useSelector = require(AppShortcutBarParent.RoactUtils).Hooks.RoactRodux.useSelector
local useLastInputMethod = require(AppShortcutBarParent.FocusNavigationUtils).useLastInputMethod
local useDesignTokens = require(AppShortcutBarParent.Style).useDesignTokens
local useAppPolicy = require(AppShortcutBarParent.UniversalAppPolicy).useAppPolicy
local useSignalState = require(AppShortcutBarParent.SignalsReact).useSignalState
local useIsTvRemoteDevice = require(AppShortcutBarParent.RoactUtils).Hooks.useIsTvRemoteDevice
local useIsRealGamepadConnected = require(AppShortcutBarParent.RoactUtils).Hooks.useIsRealGamepadConnected
local useExternalEvent = require(AppShortcutBarParent.RoactUtils).Hooks.useExternalEvent
local Display = require(AppShortcutBarParent.Display)

local bool1 = game:DefineFastFlag("NoShortcutBarWithTvRemote", false)
local FFlagStickyShortcutBarTvRemoteWithGamepad = require(AppShortcutBar.Flags).FFlagStickyShortcutBarTvRemoteWithGamepad
local FFlagShortcutBarPlatformGamepadIcons = require(AppShortcutBar.Flags).FFlagShortcutBarPlatformGamepadIcons

local SharedFlags = require(AppShortcutBarParent.SharedFlags)

local FFlagAXMigrateEquipSlotsInputBindingsToRoactGamepad = SharedFlags.FFlagAXMigrateEquipSlotsInputBindingsToRoactGamepad
local FFlagAXMigrateEmoteMenuFromRoactGamepad = SharedFlags.FFlagAXMigrateEmoteMenuFromRoactGamepad

local FFlagAXMigrateAdjustAccessoryViewToFocusNavigation = SharedFlags.FFlagAXMigrateAdjustAccessoryViewToFocusNavigation

local FFlagAXMigrateManageOutfitPageInputBindingsToFocusNavigation = SharedFlags.FFlagAXMigrateManageOutfitPageInputBindingsToFocusNavigation
local FFlagLuaAppResponsiveEnginePreferredInput = SharedFlags.FFlagLuaAppResponsiveEnginePreferredInput
local FFlagLuaAppMediaGalleryGamepadSupport = SharedFlags.FFlagLuaAppMediaGalleryGamepadSupport
local FFlagEnableStickyShortcutBarOnAllPlatforms = SharedFlags.FFlagEnableStickyShortcutBarOnAllPlatforms
local FFlagEnableSplitPane = SharedFlags.FFlagEnableSplitPane

local tbl1 = {
    [Enum.KeyCode.Thumbstick1] = {
        vertical = "rbxasset://textures/ui/Controls/DesignSystem/Thumbstick1Vertical.png",
        horizontal = "rbxasset://textures/ui/Controls/DesignSystem/Thumbstick1Horizontal.png"
    },
    [Enum.KeyCode.Thumbstick2] = {
        vertical = "rbxasset://textures/ui/Controls/DesignSystem/Thumbstick2Vertical.png",
        horizontal = "rbxasset://textures/ui/Controls/DesignSystem/Thumbstick2Horizontal.png"
    }
}

local tbl2 = {
    Enum.KeyCode.ButtonA,
    Enum.KeyCode.ButtonX,
    Enum.KeyCode.ButtonY,
    Enum.KeyCode.ButtonL3,
    Enum.KeyCode.ButtonR3,
    Enum.KeyCode.Thumbstick1,
    Enum.KeyCode.Thumbstick2,
    Enum.KeyCode.ButtonStart,
    Enum.KeyCode.Slash,
    Enum.KeyCode.Escape,
    Enum.KeyCode.LeftBracket,
    Enum.KeyCode.PageUp,
    Enum.KeyCode.RightBracket,
    Enum.KeyCode.PageDown
}

local tbl3 = {
    FocusNavigationEventNameEnum.HoldToAcceptTrustedFriendRequest,
    FocusNavigationEventNameEnum.HoldToAcceptFriendRequest,
    FocusNavigationEventNameEnum.HoldToAddFriend,
    FocusNavigationEventNameEnum.HoldToJoinEvent,
    FocusNavigationEventNameEnum.HoldToUnfollowEvent,
    FocusNavigationEventNameEnum.HoldToNotifyMe,
    FocusNavigationEventNameEnum.HoldToPlay,
    FocusNavigationEventNameEnum.HoldToJoinFriend,
    FocusNavigationEventNameEnum.Play,
    FocusNavigationEventNameEnum.Search,
    FocusNavigationEventNameEnum.SeeAll,
    FocusNavigationEventNameEnum.DisplayStatsAndInfo,
    FocusNavigationEventNameEnum.AcceptFriendRequest,
    FocusNavigationEventNameEnum.AddFriend,
    FocusNavigationEventNameEnum.IgnoreTrustedFriendRequest,
    FocusNavigationEventNameEnum.IgnoreFriendRequest,
    FocusNavigationEventNameEnum.ViewProfile,
    FocusNavigationEventNameEnum.OpenQuickMenu,
    FocusNavigationEventNameEnum.NavigateBack,
    FocusNavigationEventNameEnum.ScrollUp,
    FocusNavigationEventNameEnum.ScrollDown
}

table.insert(tbl3, FocusNavigationEventNameEnum.Confirm)
table.insert(tbl3, FocusNavigationEventNameEnum.SelectItem)
table.insert(tbl3, FocusNavigationEventNameEnum.OpenItemDetailsPage)
table.insert(tbl3, FocusNavigationEventNameEnum.ToggleTryOnManager)

if FFlagEnableSplitPane then
    table.insert(tbl3, FocusNavigationEventNameEnum.CollapseAvatar)
    table.insert(tbl3, FocusNavigationEventNameEnum.ExpandAvatar)
end

local tbl4 = {
    [Enum.KeyCode.ButtonA] = true,
    [Enum.KeyCode.ButtonB] = true,
    [Enum.KeyCode.ButtonX] = true,
    [Enum.KeyCode.ButtonY] = true,
    [Enum.KeyCode.ButtonL1] = true,
    [Enum.KeyCode.ButtonL2] = true,
    [Enum.KeyCode.ButtonL3] = true,
    [Enum.KeyCode.ButtonR1] = true,
    [Enum.KeyCode.ButtonR2] = true,
    [Enum.KeyCode.ButtonR3] = true,
    [Enum.KeyCode.ButtonSelect] = true,
    [Enum.KeyCode.ButtonStart] = true,
    [Enum.KeyCode.DPadDown] = true,
    [Enum.KeyCode.DPadLeft] = true,
    [Enum.KeyCode.DPadRight] = true,
    [Enum.KeyCode.DPadUp] = true,
    [Enum.KeyCode.Thumbstick1] = true,
    [Enum.KeyCode.Thumbstick2] = true
}

local tbl5 = {
    [Enum.KeyCode.ButtonB] = true,
    [Enum.KeyCode.ButtonL1] = true,
    [Enum.KeyCode.ButtonR1] = true
}

local tbl6 = {
    [Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/DesignSystem/ButtonA.png",
    [Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/DesignSystem/ButtonB.png",
    [Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/DesignSystem/ButtonY.png",
    [Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/DesignSystem/ButtonX.png",
    [Enum.KeyCode.ButtonL3] = "rbxasset://textures/ui/Controls/DesignSystem/ButtonL3.png",
    [Enum.KeyCode.ButtonR3] = "rbxasset://textures/ui/Controls/DesignSystem/ButtonR3.png",
    [Enum.KeyCode.Thumbstick1] = "rbxasset://textures/ui/Controls/DesignSystem/Thumbstick1Directional.png",
    [Enum.KeyCode.Thumbstick2] = "rbxasset://textures/ui/Controls/DesignSystem/Thumbstick2Directional.png",
    [Enum.KeyCode.ButtonStart] = "rbxasset://textures/ui/Controls/DesignSystem/ButtonStart.png"
}

local tbl7 = {
    [Enum.KeyCode.ButtonA] = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonA)
}

local tbl8 = {
    [Enum.KeyCode.ButtonY] = {
        [FocusNavigationEventNameEnum.Search] = tbl6[Enum.KeyCode.ButtonY],
        [FocusNavigationEventNameEnum.DisplayStatsAndInfo] = tbl6[Enum.KeyCode.ButtonY],
        [FocusNavigationEventNameEnum.OpenLayeredClothingSortResetPrompt] = tbl6[Enum.KeyCode.ButtonY],
        [FocusNavigationEventNameEnum.OpenLayeredMakeupSortResetPrompt] = tbl6[Enum.KeyCode.ButtonY],
        [FocusNavigationEventNameEnum.SortAndFiltersReset] = tbl6[Enum.KeyCode.ButtonY],
        [FocusNavigationEventNameEnum.WearAfterPurchase] = tbl6[Enum.KeyCode.ButtonY],
        [FocusNavigationEventNameEnum.FormPeekViewReset] = tbl6[Enum.KeyCode.ButtonY],
        [FocusNavigationEventNameEnum.AdjustAccessoryViewReset] = if FFlagAXMigrateAdjustAccessoryViewToFocusNavigation then tbl6[Enum.KeyCode.ButtonY] else nil,
        [FocusNavigationEventNameEnum.ManageOutfitsRename] = if FFlagAXMigrateManageOutfitPageInputBindingsToFocusNavigation then tbl6[Enum.KeyCode.ButtonY] else nil,
        [FocusNavigationEventNameEnum.OpenItemDetailsPeekView] = tbl6[Enum.KeyCode.ButtonY],
        [FocusNavigationEventNameEnum.CloseItemDetailsPeekView] = tbl6[Enum.KeyCode.ButtonY],
        [FocusNavigationEventNameEnum.ToggleTryOn] = tbl6[Enum.KeyCode.ButtonY],
        [FocusNavigationEventNameEnum.ToggleTryOnManager] = tbl6[Enum.KeyCode.ButtonY],
        [FocusNavigationEventNameEnum.RemoveClothingTile] = tbl6[Enum.KeyCode.ButtonY]
    },
    [Enum.KeyCode.ButtonX] = {
        [FocusNavigationEventNameEnum.Play] = tbl6[Enum.KeyCode.ButtonX],
        [FocusNavigationEventNameEnum.SeeAll] = tbl6[Enum.KeyCode.ButtonX],
        [FocusNavigationEventNameEnum.AcceptFriendRequest] = tbl6[Enum.KeyCode.ButtonX],
        [FocusNavigationEventNameEnum.AddFriend] = tbl6[Enum.KeyCode.ButtonX],
        [FocusNavigationEventNameEnum.OpenBuyCatalogItemPrompt] = tbl6[Enum.KeyCode.ButtonX],
        [FocusNavigationEventNameEnum.OpenItemDetailsPage] = if FFlagAXMigrateEmoteMenuFromRoactGamepad then tbl6[Enum.KeyCode.ButtonX] else nil,
        [FocusNavigationEventNameEnum.SortAndFiltersApply] = tbl6[Enum.KeyCode.ButtonX],
        [FocusNavigationEventNameEnum.SaveAsCharacter] = tbl6[Enum.KeyCode.ButtonX],
        [FocusNavigationEventNameEnum.FormPeekViewApply] = tbl6[Enum.KeyCode.ButtonX],
        [FocusNavigationEventNameEnum.ManageOutfitsDelete] = if FFlagAXMigrateManageOutfitPageInputBindingsToFocusNavigation then tbl6[Enum.KeyCode.ButtonX] else nil,
        [FocusNavigationEventNameEnum.OpenItemDetailsPrompt] = tbl6[Enum.KeyCode.ButtonX],
        [FocusNavigationEventNameEnum.UpdateOutfit] = tbl6[Enum.KeyCode.ButtonX],
        [FocusNavigationEventNameEnum.IgnoreTrustedFriendRequest] = tbl6[Enum.KeyCode.ButtonX],
        [FocusNavigationEventNameEnum.IgnoreFriendRequest] = tbl6[Enum.KeyCode.ButtonX],
        [FocusNavigationEventNameEnum.ViewProfile] = tbl6[Enum.KeyCode.ButtonX]
    },
    [Enum.KeyCode.ButtonA] = {
        [FocusNavigationEventNameEnum.PlayVideo] = if FFlagLuaAppMediaGalleryGamepadSupport then tbl6[Enum.KeyCode.ButtonA] else nil,
        [FocusNavigationEventNameEnum.PauseVideo] = if FFlagLuaAppMediaGalleryGamepadSupport then tbl6[Enum.KeyCode.ButtonA] else nil,
        [FocusNavigationEventNameEnum.HoldToAcceptTrustedFriendRequest] = tbl6[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.HoldToAcceptFriendRequest] = tbl6[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.HoldToAddFriend] = tbl6[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.HoldToJoinEvent] = tbl6[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.HoldToUnfollowEvent] = tbl6[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.HoldToNotifyMe] = tbl6[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.HoldToPlay] = tbl6[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.HoldToJoinFriend] = tbl6[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.SelectItem] = tbl6[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.SlotEmote] = tbl6[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.UnslotEmote] = tbl6[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.EquipSlotsSelectSlot] = if FFlagAXMigrateEquipSlotsInputBindingsToRoactGamepad then tbl6[Enum.KeyCode.ButtonA] else nil,
        [FocusNavigationEventNameEnum.Confirm] = tbl6[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.SelectOutfit] = if FFlagAXMigrateManageOutfitPageInputBindingsToFocusNavigation then tbl6[Enum.KeyCode.ButtonA] else nil,
        [FocusNavigationEventNameEnum.UnselectOutfit] = if FFlagAXMigrateManageOutfitPageInputBindingsToFocusNavigation then tbl6[Enum.KeyCode.ButtonA] else nil,
        [FocusNavigationEventNameEnum.SelectClothingTile] = tbl6[Enum.KeyCode.ButtonA]
    },
    [Enum.KeyCode.ButtonB] = {
        [FocusNavigationEventNameEnum.CancelAndReset] = tbl6[Enum.KeyCode.ButtonB]
    },
    [Enum.KeyCode.ButtonR3] = {
        [FocusNavigationEventNameEnum.ExitAvatarFullView] = tbl6[Enum.KeyCode.ButtonR3],
        [FocusNavigationEventNameEnum.Fullscreen] = tbl6[Enum.KeyCode.ButtonR3],
        [FocusNavigationEventNameEnum.ExitFullscreen] = tbl6[Enum.KeyCode.ButtonR3],
        [FocusNavigationEventNameEnum.CollapseAvatar] = if FFlagEnableSplitPane then tbl6[Enum.KeyCode.ButtonR3] else nil,
        [FocusNavigationEventNameEnum.ExpandAvatar] = if FFlagEnableSplitPane then tbl6[Enum.KeyCode.ButtonR3] else nil
    },
    [Enum.KeyCode.ButtonL3] = {
        [FocusNavigationEventNameEnum.OpenCatalogContextMenu] = tbl6[Enum.KeyCode.ButtonL3],
        [FocusNavigationEventNameEnum.OpenItemDetailsPage] = tbl6[Enum.KeyCode.ButtonL3],
        [FocusNavigationEventNameEnum.ManageOutfitsToggleMultiSelect] = if FFlagAXMigrateManageOutfitPageInputBindingsToFocusNavigation then tbl6[Enum.KeyCode.ButtonL3] else nil,
        [FocusNavigationEventNameEnum.ManageOutfitsCancelMultiSelect] = if FFlagAXMigrateManageOutfitPageInputBindingsToFocusNavigation then tbl6[Enum.KeyCode.ButtonL3] else nil,
        [FocusNavigationEventNameEnum.OpenEditorDetailsPage] = tbl6[Enum.KeyCode.ButtonL3],
        [FocusNavigationEventNameEnum.Mute] = tbl6[Enum.KeyCode.ButtonL3],
        [FocusNavigationEventNameEnum.Unmute] = tbl6[Enum.KeyCode.ButtonL3]
    },
    [Enum.KeyCode.ButtonStart] = {
        [FocusNavigationEventNameEnum.OpenQuickMenu] = tbl6[Enum.KeyCode.ButtonStart]
    },
    [Enum.KeyCode.Thumbstick1] = {
        [FocusNavigationEventNameEnum.PanAvatar] = tbl6[Enum.KeyCode.Thumbstick1],
        [FocusNavigationEventNameEnum.MoveClothingTile] = tbl6[Enum.KeyCode.Thumbstick1]
    },
    [Enum.KeyCode.Thumbstick2] = {
        [FocusNavigationEventNameEnum.RotateAndZoomAvatar] = tbl6[Enum.KeyCode.Thumbstick2]
    }
}

local tbl9 = {
    [Enum.KeyCode.ButtonA] = {
        [FocusNavigationEventNameEnum.HoldToAcceptTrustedFriendRequest] = tbl7[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.HoldToAcceptFriendRequest] = tbl7[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.HoldToAddFriend] = tbl7[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.HoldToJoinEvent] = tbl7[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.HoldToUnfollowEvent] = tbl7[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.HoldToNotifyMe] = tbl7[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.HoldToPlay] = tbl7[Enum.KeyCode.ButtonA],
        [FocusNavigationEventNameEnum.HoldToJoinFriend] = tbl7[Enum.KeyCode.ButtonA]
    }
}

local tbl10 = {
    [FocusNavigationEventNameEnum.Fullscreen] = "Feature.ExperienceDetails.Action.FullScreen",
    [FocusNavigationEventNameEnum.ExitFullscreen] = "Feature.ExperienceDetails.Action.ExitFullScreen",
    [FocusNavigationEventNameEnum.Mute] = "Feature.ExperienceDetails.Action.Mute",
    [FocusNavigationEventNameEnum.Unmute] = "Feature.ExperienceDetails.Action.Unmute",
    [FocusNavigationEventNameEnum.PlayVideo] = if FFlagLuaAppMediaGalleryGamepadSupport then "Feature.GameDetails.Action.PlayVideo" else nil,
    [FocusNavigationEventNameEnum.PauseVideo] = if FFlagLuaAppMediaGalleryGamepadSupport then "Feature.GameDetails.Action.PauseVideo" else nil,
    [FocusNavigationEventNameEnum.Search] = "CommonUI.Features.Label.ControllerBar.Search",
    [FocusNavigationEventNameEnum.SeeAll] = "Feature.Home.ActionSeeAll",
    [FocusNavigationEventNameEnum.Play] = "Common.VisitGame.Label.Play",
    [FocusNavigationEventNameEnum.DisplayStatsAndInfo] = "Feature.GameDetails.Label.LearnMore",
    [FocusNavigationEventNameEnum.HoldToPlay] = "CommonUI.Features.Label.ControllerBar.ToPlaySuffix",
    [FocusNavigationEventNameEnum.HoldToJoinFriend] = "Feature.Profile.Action.JoinGame",
    [FocusNavigationEventNameEnum.IgnoreTrustedFriendRequest] = "Feature.AddFriends.Action.IgnoreTrustedFriendRequest",
    [FocusNavigationEventNameEnum.IgnoreFriendRequest] = "Feature.AddFriends.Action.IgnoreFriendRequest",
    [FocusNavigationEventNameEnum.AcceptFriendRequest] = "CommonUI.Features.Label.AcceptFriend",
    [FocusNavigationEventNameEnum.AddFriend] = "CommonUI.Features.Label.AddFriend",
    [FocusNavigationEventNameEnum.HoldToAddFriend] = "CommonUI.Features.Label.AddFriend",
    [FocusNavigationEventNameEnum.HoldToAcceptFriendRequest] = "CommonUI.Features.Label.AcceptFriend",
    [FocusNavigationEventNameEnum.HoldToAcceptTrustedFriendRequest] = "Feature.Friends.TrustedFriend.AcceptTrustedRequest",
    [FocusNavigationEventNameEnum.HoldToJoinEvent] = "Feature.VirtualEvents.JoinEvent",
    [FocusNavigationEventNameEnum.HoldToUnfollowEvent] = "Feature.VirtualEvents.UnfollowEvent",
    [FocusNavigationEventNameEnum.HoldToNotifyMe] = "Feature.VirtualEvents.NotifyMe",
    [FocusNavigationEventNameEnum.OpenQuickMenu] = "Feature.Catalog.Heading.QuickMenu",
    [FocusNavigationEventNameEnum.ScrollUp] = "Feature.Accessibility.Action.ScrollUp",
    [FocusNavigationEventNameEnum.ScrollDown] = "Feature.Accessibility.Action.ScrollDown",
    [FocusNavigationEventNameEnum.NavigateBack] = "CommonUI.Controls.Action.Back",
    [FocusNavigationEventNameEnum.OpenBuyCatalogItemPrompt] = "Feature.Catalog.Action.Buy",
    [FocusNavigationEventNameEnum.OpenCatalogContextMenu] = "Feature.Catalog.Action.ItemOptions",
    [FocusNavigationEventNameEnum.OpenItemDetailsPage] = "Feature.Catalog.Action.OpenDetails",
    [FocusNavigationEventNameEnum.SelectItem] = "Feature.Avatar.Action.Select",
    [FocusNavigationEventNameEnum.EquipSlotsSelectSlot] = if FFlagAXMigrateEquipSlotsInputBindingsToRoactGamepad then "Feature.Avatar.Action.SelectSlot" else nil,
    [FocusNavigationEventNameEnum.SlotEmote] = "Feature.Avatar.Action.SlotEmote",
    [FocusNavigationEventNameEnum.UnslotEmote] = "Feature.Avatar.Action.UnslotEmote",
    [FocusNavigationEventNameEnum.OpenEditorDetailsPage] = "Feature.Catalog.Action.OpenDetails",
    [FocusNavigationEventNameEnum.PanAvatar] = "Feature.Avatar.Action.Pan",
    [FocusNavigationEventNameEnum.RotateAndZoomAvatar] = "Feature.Avatar.Action.Rotate",
    [FocusNavigationEventNameEnum.ExitAvatarFullView] = "Feature.Avatar.Action.DefaultView",
    [FocusNavigationEventNameEnum.OpenLayeredClothingSortResetPrompt] = "CommonUI.Messages.Action.Reset",
    [FocusNavigationEventNameEnum.OpenLayeredMakeupSortResetPrompt] = "CommonUI.Messages.Action.Reset",
    [FocusNavigationEventNameEnum.SortAndFiltersApply] = "CommonUI.Messages.Action.Apply",
    [FocusNavigationEventNameEnum.SortAndFiltersReset] = "CommonUI.Messages.Action.Reset",
    [FocusNavigationEventNameEnum.SaveAsCharacter] = "Feature.Avatar.Heading.SaveCostume",
    [FocusNavigationEventNameEnum.WearAfterPurchase] = "Feature.Avatar.Heading.WearConfirmation",
    [FocusNavigationEventNameEnum.Confirm] = "CommonUI.Controls.Action.Confirm",
    [FocusNavigationEventNameEnum.FormPeekViewApply] = "CommonUI.Messages.Action.Apply",
    [FocusNavigationEventNameEnum.FormPeekViewReset] = "CommonUI.Messages.Action.Reset",
    [FocusNavigationEventNameEnum.AdjustAccessoryViewReset] = if FFlagAXMigrateAdjustAccessoryViewToFocusNavigation then "CommonUI.Messages.Action.Reset" else nil,
    [FocusNavigationEventNameEnum.ManageOutfitsToggleMultiSelect] = if FFlagAXMigrateManageOutfitPageInputBindingsToFocusNavigation then "Feature.Avatar.Action.SelectMultipleItems" else nil,
    [FocusNavigationEventNameEnum.ManageOutfitsCancelMultiSelect] = if FFlagAXMigrateManageOutfitPageInputBindingsToFocusNavigation then "Feature.Avatar.Action.CancelSelection" else nil,
    [FocusNavigationEventNameEnum.ManageOutfitsDelete] = if FFlagAXMigrateManageOutfitPageInputBindingsToFocusNavigation then "Feature.Avatar.Action.Delete" else nil,
    [FocusNavigationEventNameEnum.ManageOutfitsRename] = if FFlagAXMigrateManageOutfitPageInputBindingsToFocusNavigation then "Feature.Avatar.Action.Rename" else nil,
    [FocusNavigationEventNameEnum.SelectOutfit] = if FFlagAXMigrateManageOutfitPageInputBindingsToFocusNavigation then "Feature.Avatar.Action.Select" else nil,
    [FocusNavigationEventNameEnum.UnselectOutfit] = if FFlagAXMigrateManageOutfitPageInputBindingsToFocusNavigation then "Feature.Avatar.Action.Unselect" else nil,
    [FocusNavigationEventNameEnum.OpenItemDetailsPeekView] = "Feature.Catalog.Action.OpenDetails",
    [FocusNavigationEventNameEnum.CloseItemDetailsPeekView] = "Feature.Catalog.Action.CloseDetails",
    [FocusNavigationEventNameEnum.OpenItemDetailsPrompt] = "Feature.Catalog.Action.Buy",
    [FocusNavigationEventNameEnum.ToggleTryOn] = "Feature.Catalog.Label.TryOns",
    [FocusNavigationEventNameEnum.UpdateOutfit] = "Feature.Avatar.Action.Update",
    [FocusNavigationEventNameEnum.ToggleTryOnManager] = "Feature.Catalog.Label.TryOns",
    [FocusNavigationEventNameEnum.SelectClothingTile] = "Feature.Avatar.Action.Select",
    [FocusNavigationEventNameEnum.MoveClothingTile] = "Feature.Avatar.Title.Move",
    [FocusNavigationEventNameEnum.RemoveClothingTile] = "Feature.Catalog.Action.Remove",
    [FocusNavigationEventNameEnum.CancelAndReset] = "Feature.Catalog.Action.Cancel",
    [FocusNavigationEventNameEnum.ViewProfile] = "Feature.Profile.Action.ViewProfile",
    [FocusNavigationEventNameEnum.CollapseAvatar] = if FFlagEnableSplitPane then "Feature.SplitPane.Label.CollapseAvatar" else nil,
    [FocusNavigationEventNameEnum.ExpandAvatar] = if FFlagEnableSplitPane then "Feature.SplitPane.Label.ExpandAvatar" else nil
}

local tbl11 = {
    [FocusNavigationEventNameEnum.HoldToPlay] = "Common.VisitGame.Label.Play",
    [FocusNavigationEventNameEnum.HoldToJoinFriend] = "Feature.Profile.Action.JoinGame"
}

local tbl12 = {
    [FocusNavigationEventNameEnum.HoldToPlay] = "CommonUI.Features.Label.ControllerBar.HoldPrefix"
}

local tbl13 = {
    [FocusNavigationEventNameEnum.HoldToAcceptTrustedFriendRequest] = true,
    [FocusNavigationEventNameEnum.HoldToAcceptFriendRequest] = true,
    [FocusNavigationEventNameEnum.HoldToAddFriend] = true,
    [FocusNavigationEventNameEnum.HoldToJoinEvent] = true,
    [FocusNavigationEventNameEnum.HoldToUnfollowEvent] = true,
    [FocusNavigationEventNameEnum.HoldToNotifyMe] = true,
    [FocusNavigationEventNameEnum.HoldToPlay] = true,
    [FocusNavigationEventNameEnum.HoldToJoinFriend] = true
}

local function applyPlatformGamepadIcon(tbl14, arg1, tbl15) -- Luacid: Inlined by compiler; 3 call sites recovered
    local icon = tbl15[arg1]
    if icon then
        tbl14.icon = icon
        tbl14.isPlatformIcon = true
    end
end

local function getLegacyInputBindings(keyCode: Enum.KeyCode, arg1, arg2, tbl14)
    if not arg1.axes then
        if not arg1.key then
            return {}
        end

        local tbl15 = {
            icon = tbl6[keyCode],
            text = arg2:Format(arg1.key)
        }
        if FFlagShortcutBarPlatformGamepadIcons and tbl14 then
            applyPlatformGamepadIcon(tbl15, keyCode, tbl14)
        end

        return { tbl15 }
    end

    local vertical = arg1.axes.vertical
    local horizontal = arg1.axes.horizontal
    local var1 = tbl1[keyCode]

    local legacyInputBindings = {}
    if vertical then
        table.insert(legacyInputBindings, { icon = var1.vertical, text = arg2:Format(vertical.key) })
    end
    if horizontal then
        table.insert(legacyInputBindings, { icon = var1.horizontal, text = arg2:Format(horizontal.key) })
    end
    return legacyInputBindings
end

local function selectRoactGamepadBindings(arg1)
    return if arg1.GamepadBottomBar then arg1.GamepadBottomBar.boundInputs else nil
end

local function getPlatformGamepadImages()
    local platformGamepadImages = ({})
    for value in tbl6 do
        if value == Enum.KeyCode.Thumbstick1 or value == Enum.KeyCode.Thumbstick2 then
            continue
        end

        local contentId = UserInputService:GetImageForKeyCode(value)
        if contentId ~= "" then
            platformGamepadImages[value] = contentId
        end
    end
    return platformGamepadImages
end

local function usePlatformGamepadImages()
    local var1, var2 = React.useState(getPlatformGamepadImages)

    local var3 = React.useCallback(function()
        var2((getPlatformGamepadImages()))
    end, {})

    useExternalEvent(UserInputService.GamepadConnected, var3)
    useExternalEvent(UserInputService.GamepadDisconnected, var3)

    return var1
end

local function getGamepadItems(arg1, arg2, arg3, arg4, arg5, tbl14)
    local gamepadItems = {}
    for _, keyCode in tbl2 do
        if not tbl4[keyCode] or arg4 and tbl5[keyCode] then
            continue
        end

        local var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, tbl15, var15

        if arg4 then
            if not tbl5[keyCode] then
                local var16 = arg4[keyCode]
                if var16 then
                    for _, value in (getLegacyInputBindings(keyCode, var16, arg3, tbl14)) do
                        table.insert(gamepadItems, value)
                    end
                end

                var1 = arg1[keyCode]
                if var1 then
                    var2 = tbl8[keyCode]
                    if arg5 then
                        var3 = tbl9[keyCode]
                    else
                        var3 = nil
                    end

                    if arg5 and var2 then
                        var4 = var2[var1]
                    else
                        var4 = nil
                    end

                    if arg5 and var3 then
                        var5 = var3[var1]
                    else
                        var5 = nil
                    end
                    if arg5 then
                        var6 = var5 or var4
                    elseif var2 then
                        var6 = var2[var1]
                    else
                        var6 = nil
                    end

                    if arg5 then
                        var7 = tbl11[var1]
                    else
                        var7 = nil
                    end
                    var8 = tbl10[var1]
                    if arg5 then
                        var9 = var7 or var8
                    else
                        var9 = tbl10[var1]
                    end

                    if var9 then
                        var10 = arg3:Format(var9)
                    else
                        var10 = nil
                    end

                    var11 = tbl12[var1]
                    if var11 then
                        var12 = arg3:Format(var11)
                    else
                        var12 = nil
                    end

                    var13 = arg2[var1]
                    var14 = tbl13[var1]
                    if var6 and var10 then
                        tbl15 = {
                            icon = var6,
                            text = var10,
                            actionText = 0,
                            progress = 0,
                            hasProgress = 0,
                            inputKeyCode = 0,
                            eventName = 0
                        }

                        if arg5 then
                            var12 = nil
                        end

                        tbl15.actionText = var12
                        tbl15.progress = var13
                        tbl15.hasProgress = var14
                        if arg5 then
                            var15 = keyCode
                        else
                            var15 = nil
                        end

                        tbl15.inputKeyCode = var15
                        if not arg5 then
                            var1 = nil
                        end

                        tbl15.eventName = var1

                        if FFlagShortcutBarPlatformGamepadIcons and tbl14 then
                            applyPlatformGamepadIcon(tbl15, keyCode, tbl14)
                        end

                        table.insert(gamepadItems, tbl15)
                    end
                end
            end
        else
            var1 = arg1[keyCode]
            if var1 then
                var2 = tbl8[keyCode]
                if arg5 then
                    var3 = tbl9[keyCode]
                else
                    var3 = nil
                end

                if arg5 and var2 then
                    var4 = var2[var1]
                else
                    var4 = nil
                end

                if arg5 and var3 then
                    var5 = var3[var1]
                else
                    var5 = nil
                end
                if arg5 then
                    var6 = var5 or var4
                elseif var2 then
                    var6 = var2[var1]
                else
                    var6 = nil
                end

                if arg5 then
                    var7 = tbl11[var1]
                else
                    var7 = nil
                end
                var8 = tbl10[var1]
                if arg5 then
                    var9 = var7 or var8
                else
                    var9 = tbl10[var1]
                end

                if var9 then
                    var10 = arg3:Format(var9)
                else
                    var10 = nil
                end

                var11 = tbl12[var1]
                if var11 then
                    var12 = arg3:Format(var11)
                else
                    var12 = nil
                end

                var13 = arg2[var1]
                var14 = tbl13[var1]
                if var6 and var10 then
                    tbl15 = {
                        icon = var6,
                        text = var10,
                        actionText = 0,
                        progress = 0,
                        hasProgress = 0,
                        inputKeyCode = 0,
                        eventName = 0
                    }

                    if arg5 then
                        var12 = nil
                    end

                    tbl15.actionText = var12
                    tbl15.progress = var13
                    tbl15.hasProgress = var14
                    if arg5 then
                        var15 = keyCode
                    else
                        var15 = nil
                    end

                    tbl15.inputKeyCode = var15
                    if not arg5 then
                        var1 = nil
                    end

                    tbl15.eventName = var1

                    if FFlagShortcutBarPlatformGamepadIcons and tbl14 then
                        applyPlatformGamepadIcon(tbl15, keyCode, tbl14)
                    end

                    table.insert(gamepadItems, tbl15)
                end
            end
        end
    end
    if arg5 then
        local eventName = arg1[Enum.KeyCode.ButtonB]
        if eventName == FocusNavigationEventNameEnum.NavigateBack then
            local tbl15 = {
                icon = tbl6[Enum.KeyCode.ButtonB],
                text = arg3:Format(tbl10[eventName]),
                inputKeyCode = Enum.KeyCode.ButtonB,
                eventName = eventName
            }
            if FFlagShortcutBarPlatformGamepadIcons and tbl14 then
                applyPlatformGamepadIcon(tbl15, Enum.KeyCode.ButtonB, tbl14)
            end
            table.insert(gamepadItems, tbl15)
        end
    end

    return gamepadItems
end

local function getKeyboardItems(arg1, arg2, arg3, arg4)
    local keyboardItems = {}
    local tbl14 = ({})

    for value, value2 in arg1 do
        if tbl4[value] then
            continue
        end

        if typeof(tbl14[value2]) == "table" then
            table.insert(tbl14[value2], value)
        else
            tbl14[value2] = { value }
        end
    end

    for _, value in tbl3 do
        local icon = tbl14[value]
        if not icon then
            continue
        end

        local var2 = tbl10[value]
        local text = if var2 then arg3:Format(var2) else nil
        local var4 = tbl12[value]
        local var5 = if var4 then arg3:Format(var4) else nil
        local progress = arg2[value]
        local hasProgress = tbl13[value]
        if not text then
            continue
        end

        local tbl15 = {
            icon = icon,
            text = text,
            actionText = 0,
            progress = 0,
            hasProgress = 0,
            inputKeyCode = 0,
            eventName = 0
        }

        if arg4 then
            var5 = nil
        end

        tbl15.actionText = var5
        tbl15.progress = progress
        tbl15.hasProgress = hasProgress
        tbl15.inputKeyCode = if arg4 then icon[1] else nil
        if not arg4 then
            value = nil
        end

        tbl15.eventName = value
        table.insert(keyboardItems, tbl15)
    end

    return keyboardItems
end

local function useShortcutBarFrameProps()
    local var1 = useDesignTokens()

    local var2 = useSignalState(Display.GetDisplayStore().getDeviceSafePadding)

    return {
        Position = UDim2.new(0.5, 0, 1, if var1 then -var1.Size.Size_200 + var2.bottom else 0),
        AnchorPoint = Vector2.new(0.5, 1)
    }
end

local function useShortcutBarItems()
    local var1 = ReactFocusNavigation.useActiveEventMap()
    local var2 = React.useContext(LocalizationRoactContext)
    local var3 = useHeldProgressByEvent()
    local var4 = useLastInputMethod()
    local var5 = if FFlagLuaAppResponsiveEnginePreferredInput then Responsive.usePreferredInput() else nil
    local var6 = if bool1 then useIsTvRemoteDevice() else nil
    local var7 = if FFlagStickyShortcutBarTvRemoteWithGamepad then useIsRealGamepadConnected() else false
    local var8 = if FFlagShortcutBarPlatformGamepadIcons then usePlatformGamepadImages() else nil
    local var9 = useSelector(selectRoactGamepadBindings)

    local var10 = useAppPolicy(function(arg1)
        return arg1.getStickyShortcutBarEnabled()
    end) or FFlagEnableStickyShortcutBarOnAllPlatforms

    if FFlagShortcutBarPlatformGamepadIcons and not var10 then
        var8 = nil
    end

    if not (if FFlagLuaAppResponsiveEnginePreferredInput then var5 == Responsive.Input.Directional else var4 == "Gamepad") then
        return (getKeyboardItems(var1, var3, var2, var10))
    end

    if var6 and not var7 then
        return {}
    end
    return (getGamepadItems(var1, var3, var2, var9, var10, var8))
end

function useAppShortcutBarProps()
    local tbl14 = useShortcutBarFrameProps()
    local items = useShortcutBarItems()

    return Cryo.Dictionary.union(tbl14, { items = items })
end

return useAppShortcutBarProps
