-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsMenu = script:FindFirstAncestor("FriendsMenu")
local FriendsMenuParent = FriendsMenu.Parent
local Context = FriendsMenu.Context

local getStandardSizeAvatarHeadShotRbxthumb = require(FriendsMenuParent.UserLib).Utils.getStandardSizeAvatarHeadShotRbxthumb
local FFlagFriendsMenuUseProfileFrameThumbnail = require(FriendsMenu.Flags.FFlagFriendsMenuUseProfileFrameThumbnail)

local React = require(FriendsMenuParent.React)
local UIBlox = require(FriendsMenuParent.UIBlox)
local normalizeFontFace = require(FriendsMenuParent.Foundation).Utility.normalizeFontFace

local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Interactable = UIBlox.Core.Control.Interactable
local useStyle = UIBlox.Core.Style.useStyle

local _friendsMenuModalType = require(FriendsMenu.friendsMenuModalType)
local Constants = require(FriendsMenu.Constants)
local SelectedUsersContext = require(Context.SelectedUsersContext)

local uDim = UDim.new(1, 0)

return (React.forwardRef(function(arg1, ref)
    local var1 = React.useContext(SelectedUsersContext)

    local var2 = useStyle()
    local theme = var2.Theme
    local font = var2.Font

    local image = getStandardSizeAvatarHeadShotRbxthumb(arg1.userId, FFlagFriendsMenuUseProfileFrameThumbnail)

    local var3 = React.useCallback(function()
        if arg1.onRemoved then
            arg1.onRemoved()
        end
        var1.removeFriend(arg1.userId, arg1.displayName)
    end, { arg1.userId, var1.removeFriend, arg1.onRemoved })

    local createElement = React.createElement
    local var4 = Interactable
    local tbl1 = {
        Size = UDim2.new(0, Constants.FRIEND_MENU_CARD_SIZE, 0, Constants.FRIEND_MENU_CARD_SIZE),
        BackgroundTransparency = 1,
        LayoutOrder = arg1.layoutOrder
    }
    local activated = React.Event.Activated

    if arg1.unremovable then
        var3 = nil
    end

    tbl1[activated] = var3
    tbl1.ref = ref
    local tbl2 = { AvatarContainer = 0, DisplayName = 0 }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.fromOffset(60, 60),
        BackgroundTransparency = 1
    }
    local tbl4 = {
        UICorner = React.createElement("UICorner", { CornerRadius = uDim }),
        Avatar = React.createElement(
            ImageSetLabel,
            {
                Size = UDim2.fromOffset(60, 60),
                BackgroundColor3 = theme.UIDefault.Color,
                Image = image,
                ZIndex = 1
            },
            {
                UICorner = React.createElement("UICorner", { CornerRadius = uDim })
            }
        ),
        CloseButton = 0
    }
    local element

    if arg1.unremovable then
        element = nil
    else
        element = React.createElement(ImageSetLabel, {
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.fromScale(1, 0),
            Size = UDim2.fromOffset(16, 16),
            BackgroundTransparency = theme.SystemPrimaryDefault.Transparency,
            BackgroundColor3 = theme.SystemPrimaryDefault.Color,
            Image = Images["icons/navigation/close_small"],
            ImageColor3 = theme.SystemPrimaryContent.Color,
            ZIndex = 2
        }, {
            UICorner = React.createElement("UICorner", { CornerRadius = uDim })
        })
    end

    tbl4.CloseButton = element
    tbl2.AvatarContainer = createElement2(str1, tbl3, tbl4)

    tbl2.DisplayName = React.createElement("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 1),
        AutomaticSize = Enum.AutomaticSize.Y,
        Position = UDim2.fromScale(0.5, 1),
        Size = UDim2.fromOffset(Constants.FRIEND_MENU_CARD_SIZE, 0),
        BackgroundTransparency = 1,
        FontFace = normalizeFontFace(var2.Tokens.Typography.CaptionSmall.Font),
        Text = arg1.displayName,
        TextColor3 = theme.TextDefault.Color,
        TextSize = font.BaseSize * font.Footer.RelativeSize,
        TextTransparency = theme.TextDefault.Transparency,
        TextTruncate = Enum.TextTruncate.AtEnd
    })
    return createElement(var4, tbl1, tbl2)
end))
