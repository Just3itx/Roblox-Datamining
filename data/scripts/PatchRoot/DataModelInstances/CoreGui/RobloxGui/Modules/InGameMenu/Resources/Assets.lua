-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CorePackages = game:GetService("CorePackages")

local UIBlox = require(CorePackages.Packages.InGameMenuDependencies).UIBlox

local Images = require(script.Parent.Images)

local Images2 = UIBlox.App.ImageSet.Images

local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation

local bool1 = game:DefineFastFlag("FixInGameMenuMoreButtonIcon", false)

return {
    Images = {
        RobloxLogo = Images["LuaApp/graphic/ic_logo"],
        CloseButton = "rbxasset://textures/ui/TopBar/close.png",
        RespawnIcon = Images["InGameMenu/Icons/RespawnIcon"],
        ReportIcon = if FFlagCoreUiMigrateUIBloxToFoundation then "icons/actions/feedback" else Images["LuaApp/icons/GameDetails/feedback"],
        CloseModal = if FFlagCoreUiMigrateUIBloxToFoundation then "icons/navigation/close" else Images["LuaApp/icons/navigation/close"],
        NavigateBack = if FFlagCoreUiMigrateUIBloxToFoundation then "icons/navigation/pushBack" else Images["LuaApp/icons/navigation/pushBack"],
        NavigateForward = Images["LuaApp/icons/navigation/pushRight"],
        SendInvite = Images["LuaApp/icons/GameDetails/invite"],
        InviteSuccess = Images["LuaApp/icons/status_progress"],
        InviteMenu = Images["InGameMenu/Icons/MenuFriends"],
        InviteFail = Images["LuaApp/graphic/ic_alert"],
        ControlsMenu = Images["InGameMenu/Icons/MenuControls"],
        Gamepad = "rbxasset://textures/ui/InGameMenu/GenericController.png",
        GamepadXbox = "rbxasset://textures/ui/InGameMenu/XboxController.png",
        GamepadQuest = "rbxassetid://13262267483",
        KeyBorder = Images["InGameMenu/Icons/KeyBorder"],
        Mouse1Press = Images["InGameMenu/Graphic/ClickLeft"],
        Mouse2Press = Images["InGameMenu/Graphic/ClickRight"],
        MouseWheelScroll = Images["InGameMenu/Graphic/WheelScroll"],
        UpArrow = Images["InGameMenu/Icons/ArrowUp"],
        DownArrow = Images["InGameMenu/Icons/ArrowDown"],
        LeftArrow = Images["InGameMenu/Icons/ArrowLeft"],
        RightArrow = Images["InGameMenu/Icons/ArrowRight"],
        ScrollTop = "rbxasset://textures/ui/InGameMenu/ScrollTop.png",
        ScrollMid = "rbxasset://textures/ui/InGameMenu/ScrollMiddle.png",
        ScrollBottom = "rbxasset://textures/ui/InGameMenu/ScrollBottom.png",
        RadialGlow = "rbxasset://textures/ui/InGameMenu/BackgroundGlow.png",
        PlayersMenu = Images["InGameMenu/Icons/MenuPlayers"],
        AddFriend = Images["LuaApp/graphic/actions_friends_addfriend"],
        CancelFriendRequest = Images["InGameMenu/Icons/CancelFriendRequest"],
        UnFriend = Images["InGameMenu/Icons/UnFriend"],
        Friends = Images["InGameMenu/Icons/Friends"],
        MoreActions = if bool1 then Images2["icons/common/more"] else Images["LuaApp/icons/GameDetails/more"],
        ViewAvatar = Images["InGameMenu/Icons/ViewAvatar"],
        RoundedRectImageKey = "component_assets/circle_17",
        RoundedRect = {
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(8, 8, 9, 9),
            Image = Images2["component_assets/circle_17"]
        },
        RoundedRectBorder = {
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(8, 8, 9, 9),
            Image = Images2["component_assets/circle_17_stroke_1"]
        },
        WhiteSquare = {
            ScaleType = Enum.ScaleType.Stretch,
            SliceCenter = Rect.new(0, 0, 0, 0),
            Image = "rbxasset://textures/ui/InGameMenu/WhiteSquare.png"
        },
        Circle = if FFlagCoreUiMigrateUIBloxToFoundation then "component_assets/circle_29" else Images2["component_assets/circle_29"],
        CircleCutout = "rbxasset://textures/ui/InGameMenu/CircleCutout.png",
        QuarterCircle = "rbxasset://textures/ui/InGameMenu/QuarterCircle.png",
        ExpandArrow = Images["InGameMenu/Icons/ExpandArrow"],
        SelectedCheck = Images["InGameMenu/Icons/SelectedCheck"],
        SuccessTick = Images["LuaApp/icons/status_progress"],
        RetryIcon = Images["LuaApp/icons/common_refresh"],
        ClearIcon = Images["InGameMenu/Icons/Clear"],
        SearchIcon = Images["LuaApp/icons/ic-search-new"],
        GameSettings = Images["InGameMenu/Icons/GameSettings"],
        Shadow = {
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(12, 12, 40, 40),
            Size = 8,
            Image = Images["InGameMenu/9Slice/DropShadow"]
        },
        ToggleOutline = {
            Image = Images["InGameMenu/9Slice/ToggleOutline"],
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(18, 18, 18, 18)
        },
        ToggleFill = {
            Image = Images["InGameMenu/9Slice/ToggleFill"],
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(18, 18, 18, 18)
        },
        ToggleKnob = Images["InGameMenu/Graphic/SliderButton"],
        SliderHover = Images["InGameMenu/Graphic/sliderHover"],
        SliderCircle = {
            Image = Images["InGameMenu/9Slice/sliderCircle"],
            SliceCenter = Rect.new(8, 8, 9, 9),
            ScaleType = Enum.ScaleType.Slice
        },
        SliderButton = Images["InGameMenu/Graphic/SliderButton"],
        PlaceholderGameIcon = if FFlagCoreUiMigrateUIBloxToFoundation then "icons/imageUnavailable" else Images2["icons/imageUnavailable"]
    }
}
