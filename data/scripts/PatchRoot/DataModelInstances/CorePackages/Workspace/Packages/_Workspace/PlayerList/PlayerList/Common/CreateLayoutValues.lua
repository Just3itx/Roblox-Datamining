-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local memoize = require(scriptParentParentParent.AppCommonLib).memoize
local Images = require(scriptParentParentParent.UIBlox).App.ImageSet.Images
local Foundation = require(scriptParentParentParent.Foundation)

local FFlagPlayerListFoundationSubscriptionIcon = require(scriptParentParent.Flags.FFlagPlayerListFoundationSubscriptionIcon)

return (memoize(function(isTenFoot, arg1)
    local tbl1 = { IsTenFoot = isTenFoot }

    if isTenFoot then
        tbl1.ContainerPosition = UDim2.new(0.5, 0, 0.5, 0)
        tbl1.ContainerSize = UDim2.new(0, 350, 0, 720)
        tbl1.AnchorPoint = Vector2.new(0.5, 0.5)

        tbl1.PlayerDropDownSizeX = 0

        tbl1.PlayerScrollListPosition = UDim2.new(0, 0, 0, 105)
        tbl1.PlayerScrollListSize = UDim2.new(1, 19, 1, 0)
        tbl1.PlayerScrollListInnerFramePosition = UDim2.new(0, 0, 0, 0)
        tbl1.PlayerScrollListInnerFrameSize = UDim2.new(1, 0, 1, 0)

        tbl1.EntrySizeX = 350
        tbl1.PlayerEntrySizeY = 100
        tbl1.EntryPadding = 5
        tbl1.TeamEntrySizeY = 32
        tbl1.StatEntrySizeX = 250
        tbl1.EntryXOffset = -20

        tbl1.BackgroundStyle = {
            Default = {
                Color = Color3.fromRGB(60, 60, 60),
                Transparency = 0.25
            },
            Hovered = {
                Color = Color3.fromRGB(50, 181, 255),
                Transparency = 0.25
            },
            HoveredTitle = {
                Color = Color3.fromRGB(50, 181, 255),
                Transparency = 0
            },
            Title = {
                Color = Color3.fromRGB(25, 25, 25),
                Transparency = 0
            },
            Selected = nil
        }

        tbl1.TeamEntryBackgroundTransparency = 0.25

        tbl1.DefaultTextStyle = {
            Color = Color3.fromRGB(255, 255, 243),
            Transparency = 0,
            StrokeTransparency = 0.75,
            StrokeColor = Color3.fromRGB(34, 34, 34)
        }
        tbl1.HoveredTextStyle = {
            Color = Color3.fromRGB(19, 19, 19),
            Transparency = 0,
            StrokeTransparency = 0.75,
            StrokeColor = Color3.fromRGB(34, 34, 34)
        }

        tbl1.PlayerIconSize = UDim2.new(0, 64, 0, 64)
        tbl1.InitalPlayerEntryPadding = 18
        tbl1.PlayerEntryPadding = 8
        tbl1.PlayerEntryNamePadding = 8
        tbl1.TeamEntryTextPadding = 5
        tbl1.StatTextPadding = 0

        tbl1.PlayerNameSize = UDim2.new(1, -88, 1, 0)
        tbl1.PlayerNameTextSize = 32
        tbl1.StatTextSize = 32

        tbl1.ScrollImageColor = Color3.fromRGB(31, 31, 31)
        tbl1.ScrollImageTransparency = 0.5
    else
        tbl1.ContainerPadding = 4
        tbl1.ContainerPosition = UDim2.new(1, -4, 0, 4)
        tbl1.ContainerSize = UDim2.new(0, 0, 0.5, 0)
        tbl1.ExtraContainerPadding = 16
        tbl1.AnchorPoint = Vector2.new(1, 0)

        tbl1.PlayerDropDownSizeX = 300
        tbl1.PlayerDropDownOffset = 4

        tbl1.PlayerScrollListPosition = UDim2.new(0, 0, 0, 0)
        tbl1.PlayerScrollListSize = UDim2.new(1, -1, 1, 0)

        tbl1.EntryBaseSizeX = 150
        tbl1.EntrySizeIncreasePerStat = 11
        tbl1.PlayerEntrySizeY = 40
        tbl1.EntryPadding = 0
        tbl1.TeamEntrySizeY = 24
        tbl1.StatEntrySizeX = 66
        tbl1.TitleBarSizeY = 20
        tbl1.EntryXOffset = 0

        tbl1.TeamEntryBackgroundTransparency = 0.5
        tbl1.IconButtonBackgroundTransparency = 0.3
        tbl1.DropDownHeaderBackgroundTransparency = 0.1
        tbl1.OverrideBackgroundTransparency = 0.3
        tbl1.FadedBackgroundTransparency = 0.65
        tbl1.FadedBackgroundScaleDelta = 0.05

        tbl1.PlayerIconSize = UDim2.new(0, 16, 0, 16)
        tbl1.InitalPlayerEntryPadding = 12
        tbl1.PlayerEntryPadding = 12
        tbl1.PlayerEntryNamePadding = 4
        tbl1.TeamEntryTextPadding = 15
        tbl1.StatTextPadding = 4

        tbl1.PlayerNameSize = UDim2.new(1, -34, 1, 0)
        tbl1.PlayerNameTextSize = 14
        tbl1.StatTextSize = 14

        tbl1.ScrollImageColor = Color3.fromRGB(216, 216, 216)
        tbl1.ScrollImageTransparency = 0.5
        tbl1.ScrollBarOffset = 4
        tbl1.ScrollBarSize = 8
    end

    tbl1.TopBarOffset = arg1.TopBarHeight

    tbl1.PlayerDropDownSizeXMobile = 327
    tbl1.ScrollBarSizeMobile = 2
    tbl1.PlayerNameSizeXMobile = 194
    tbl1.PlayerIconSizeMobile = UDim2.fromOffset(20, 20)
    tbl1.PlayerNameTextSizeMobile = 16
    tbl1.StatTextSizeMobile = 16
    tbl1.PlayerNamePaddingXMobile = 14
    tbl1.TeamEntryTextPadding = 15
    tbl1.TeamEntryTextPaddingMobile = 14
    tbl1.RowHoverColor = Color3.fromRGB(0, 0, 0)
    tbl1.RowDefaultColor = Color3.fromRGB(84, 84, 84)

    tbl1.MaxLeaderstats = 4
    tbl1.MaxLeaderstatsSmallScreen = 1

    tbl1.PlayerEntryFont = Enum.Font.SourceSans
    tbl1.TitlePlayerEntryFont = Enum.Font.SourceSansBold
    tbl1.TeamEntryFont = Enum.Font.SourceSans

    tbl1.StatFont = Enum.Font.SourceSans
    tbl1.TitleStatFont = Enum.Font.SourceSansBold
    tbl1.TeamStatFont = Enum.Font.SourceSansBold
    tbl1.StatNameFont = Enum.Font.SourceSans

    tbl1.PlayerIconBackgroundSize = UDim2.new(0, 66, 0, 66)
    tbl1.PlayerBackgroundImage = "rbxasset://textures/ui/PlayerList/CharacterImageBackground.png"

    tbl1.RobloxIconImage = "rbxasset://textures/ui/Shell/Icons/RobloxIcon24.png"
    tbl1.IconSelectedColor = Color3.fromRGB(19, 19, 19)
    tbl1.IconUnSelectedColor = Color3.fromRGB(255, 255, 255)

    tbl1.SelectedEntryColor = Color3.fromRGB(0, 255, 255)

    tbl1.ShadowImage = "rbxasset://textures/ui/PlayerList/TileShadowMissingTop.png"
    tbl1.ShadowSize = 5
    tbl1.ShadowSliceRect = Rect.new(6, 6, 9, 9)

    tbl1.DefaultThumbnail = "rbxasset://textures/ui/Shell/Icons/DefaultProfileIcon.png"

    tbl1.BlockedIcon = Images["icons/status/unavailable_small"]

    tbl1.FriendIcons = {
        [Enum.FriendStatus.Friend] = Images["icons/status/player/friend"],
        [Enum.FriendStatus.FriendRequestReceived] = Images["icons/status/player/pending"]
    }

    tbl1.FollowingIcon = Images["icons/status/player/following"]
    tbl1.PlaceOwnerIcon = Images["icons/status/player/developer"]

    tbl1.MembershipIcons = {
        [Enum.MembershipType.Premium] = Images["icons/status/premium_small"]
    }

    if FFlagPlayerListFoundationSubscriptionIcon then
        tbl1.SubscriptionIcon = {
            isFoundationIcon = true,
            name = Foundation.Enums.IconName.RobloxPlus
        }
    else
        tbl1.SubscriptionIcon = Images["icons/menu/gem_small"]
    end

    tbl1.CustomPlayerIcons = {
        [7210880] = "rbxassetid://134032333",
        [13268404] = "rbxassetid://113059239",
        [261] = "rbxassetid://105897927"
    }

    tbl1.NeutralTeamColor = BrickColor.new("White")
    tbl1.NeutralTeamName = "Neutral"

    tbl1.DropDownButtonSizeY = 56
    tbl1.DropDownButtonPadding = 0
    tbl1.DropDownPadding = 10
    tbl1.DropDownRightOptionSize = 55
    tbl1.DropDownIconSize = 36
    tbl1.DropDownHeaderSizeY = 80
    tbl1.DropDownHeaderBackgroundSize = 65
    tbl1.DropDownScreenSidePadding = 4

    return tbl1
end))
