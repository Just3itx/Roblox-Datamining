-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local React = require(GameTileParent.React)
local UIBlox = require(GameTileParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local useLocalization = require(GameTileParent.Localization).Hooks.useLocalization
local UserLib = require(GameTileParent.UserLib)
local Constants = UserLib.Utils.Constants
local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions

local function func1(arg1)
    return React.createElement(React.Fragment, nil, {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
        Border = React.createElement("UIStroke", {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = arg1.Theme.BackgroundUIDefault.Color,
            Transparency = arg1.Theme.BackgroundUIDefault.Transparency,
            Thickness = 2
        })
    })
end

local function func2(friends, arg1)
    local tbl1 = ({})

    if not friends then
        return nil, nil
    end

    local num1 = 0

    for _, friend in pairs(friends) do
        num1 += 1
        local str1 = tostring(friend)

        if not (num1 <= 3) then
            continue
        end
        local image = getRbxthumbWithTypeSizeAndOptions(str1, Constants.RbxthumbTypes.AvatarHeadShot, 100)

        local str2 = "mini_avatar_" .. str1
        tbl1[str2] = React.createElement(ImageSetLabel, {
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, num1 * 16 / 2, 0.5, 0),
            Size = UDim2.fromOffset(16, 16),
            BackgroundTransparency = 0,
            Image = image,
            BackgroundColor3 = Color3.fromRGB(209, 209, 209),
            ZIndex = 4 - num1
        }, { func1(arg1) })
    end

    tbl1.online_indicator = React.createElement("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.fromOffset(14, 14),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.fromRGB(0, 180, 109),
        ZIndex = 4
    }, {
        func1(arg1),
        InExperienceCounter = React.createElement(StyledTextLabel, {
            colorStyle = arg1.Theme.TextEmphasis,
            fontStyle = arg1.Font.Footer,
            textXAlignment = Enum.TextXAlignment.Center,
            size = UDim2.fromScale(1, 1),
            lineHeight = 1,
            text = tostring(num1),
            textTruncate = Enum.TextTruncate.None,
            richText = false
        })
    })

    return React.createElement("Frame", {
        Size = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        BackgroundTransparency = 1
    }, tbl1), num1
end

return function(tbl1)
    local var1 = useStyle()
    local font = var1.Font
    local activeFriends, var3 = func2(tbl1.friends, var1)
    local var4 = useLocalization({ friendsText = "CommonUI.Features.Label.Friends" })

    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }, {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 6)
        }),
        PresenceList = React.createElement("Frame", {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(0, math.min(3, var3 or 0) * 16 / 2 + 16, 0, 22),
            LayoutOrder = 1
        }, { ActiveFriends = activeFriends }),
        FriendsLabel = React.createElement(StyledTextLabel, {
            colorStyle = var1.Theme.TextMuted,
            fontStyle = font.CaptionHeader,
            textXAlignment = Enum.TextXAlignment.Left,
            size = UDim2.new(1, -40, 0, font.BaseSize * font.CaptionHeader.RelativeSize),
            lineHeight = 1,
            text = var4.friendsText,
            textTruncate = Enum.TextTruncate.AtEnd,
            richText = false,
            layoutOrder = 2
        })
    })
end
