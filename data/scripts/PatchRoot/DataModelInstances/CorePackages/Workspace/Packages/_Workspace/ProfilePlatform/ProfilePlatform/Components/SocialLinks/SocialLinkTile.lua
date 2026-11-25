-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent
local React = require(ProfilePlatformParent.React)
local UIBlox = require(ProfilePlatformParent.UIBlox)

local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local useStyle = UIBlox.Core.Style.useStyle

local Medium = IconSize.Medium

return function(tbl1)
    local var1 = useStyle()
    local tileSize = tbl1.tileSize or 80

    return React.createElement("Frame", {
        LayoutOrder = tbl1.layoutOrder,
        Size = UDim2.new(0, tileSize, 0, tileSize + 24),
        BackgroundTransparency = 1,
        Name = "SocialLinkTile_" .. tbl1.name
    }, {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 8)
        }),
        TextLabel = React.createElement("TextLabel", {
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, 24),
            BackgroundTransparency = 1,
            Text = tbl1.name,
            TextColor3 = var1.Theme.TextDefault.Color,
            TextSize = 14,
            Font = Enum.Font.GothamMedium,
            TextWrapped = true,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextXAlignment = Enum.TextXAlignment.Center,
            Name = "NameLabel"
        }),
        IconBackground = React.createElement("Frame", {
            LayoutOrder = 1,
            Size = UDim2.fromOffset(84, 84),
            BackgroundTransparency = 0.9,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            BorderSizePixel = 0,
            Name = "IconBackground"
        }, {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
            IconButton = React.createElement(IconButton, {
                icon = tbl1.icon,
                size = UDim2.fromOffset(84, 84),
                iconColor3 = var1.Theme.IconEmphasis.Color,
                iconSize = Medium,
                onActivated = tbl1.onActivated,
                backgroundTransparency = 1
            })
        })
    })
end
