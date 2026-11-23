-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearchParent = script:FindFirstAncestor("UserSearch").Parent
local React = require(UserSearchParent.React)

local UIBlox = require(UserSearchParent.UIBlox)
local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local useStyle = UIBlox.Core.Style.useStyle

local _useSearchTileButtons = require(script.Parent.Parent.UserSearchTile.useSearchTileButtons)

return function(tbl1)
    local var1 = useStyle()
    local searchTileButtonProps = tbl1.searchTileButtonProps
    local imageColor3 = searchTileButtonProps.imageColor or var1.Theme.SystemPrimaryContent.Color
    local backgroundColor3 = searchTileButtonProps.backgroundColor or var1.Theme.SystemPrimaryDefault.Color

    local createElement = React.createElement
    local var4 = ImageSetButton
    local tbl2 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = backgroundColor3,
        BackgroundTransparency = if searchTileButtonProps.isDisabled then var1.Theme.Overlay.Transparency else var1.Theme.SystemPrimaryDefault.Transparency,
        [React.Event.Activated] = searchTileButtonProps.onActivated
    }
    local tbl3 = {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
        Layout = React.createElement(
            "UIListLayout",
            {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }
        ),
        Icon = React.createElement(ImageSetLabel, {
            Size = UDim2.new(0, var1.Tokens.Size.Size_350, 0, var1.Tokens.Size.Size_350),
            BackgroundTransparency = 1,
            Image = searchTileButtonProps.icon,
            ImageColor3 = imageColor3,
            ImageTransparency = if searchTileButtonProps.isDisabled then var1.Theme.Overlay.Transparency else var1.Theme.SystemPrimaryContent.Transparency
        })
    }
    return createElement(var4, tbl2, tbl3)
end
