-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)

local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize

local function SectionTitle(tbl1)
    return React.createElement(View, {
        tag = "col size-full-0 auto-y",
        LayoutOrder = tbl1.LayoutOrder
    }, {
        TitleRow = React.createElement(
            View,
            {
                tag = "row align-y-center size-full-0 auto-y",
                onActivated = tbl1.onActivated,
                LayoutOrder = 1
            },
            {
                Title = React.createElement(
                    FoundationText,
                    {
                        tag = "auto-xy text-heading-small content-emphasis",
                        Text = tbl1.title,
                        LayoutOrder = 1
                    }
                ),
                Chevron = React.createElement(Icon, { name = IconName.ChevronLargeRight, size = IconSize.Small, LayoutOrder = 2 })
            }
        )
    })
end

return SectionTitle
