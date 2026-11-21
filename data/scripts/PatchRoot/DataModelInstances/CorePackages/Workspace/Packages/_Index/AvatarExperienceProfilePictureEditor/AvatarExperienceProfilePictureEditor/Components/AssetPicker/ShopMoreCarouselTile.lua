-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)

local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize

local function ShopMoreCarouselTile(tbl1)
    local onActivated = React.useCallback(function()
        tbl1.onActivated()
    end, { tbl1.onActivated })

    return React.createElement(View, {
        tag = "col align-x-left gap-small auto-y",
        Size = UDim2.fromOffset(tbl1.tileSize, 0),
        LayoutOrder = tbl1.layoutOrder,
        onActivated = onActivated
    }, {
        Thumbnail = React.createElement(
            View,
            {
                tag = "align-x-center align-y-center radius-medium bg-surface-100",
                Size = UDim2.fromOffset(tbl1.tileSize, tbl1.tileSize),
                LayoutOrder = 1
            },
            {
                Icon = React.createElement(Icon, { name = IconName.ShoppingCart, size = IconSize.XXLarge })
            }
        ),
        Label = React.createElement(FoundationText, {
            tag = "size-full-0 auto-y text-body-small text-align-x-left text-truncate-end content-emphasis",
            Text = tbl1.label,
            LayoutOrder = 2
        })
    })
end

return ShopMoreCarouselTile
