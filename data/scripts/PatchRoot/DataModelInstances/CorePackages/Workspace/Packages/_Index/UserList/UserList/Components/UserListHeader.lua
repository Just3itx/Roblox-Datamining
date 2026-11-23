-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserListParent = script:FindFirstAncestor("UserList").Parent

local React = require(UserListParent.React)
local Foundation = require(UserListParent.Foundation)

local Enums = Foundation.Enums
local Icon = Foundation.Icon
local View = Foundation.View
local FoundationText = Foundation.Text
local IconButton = Foundation.IconButton
local IconName = Enums.IconName
local IconSize = Enums.IconSize
local IconVariant = Enums.IconVariant

local function UserListHeader(tbl1)
    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        tag = "size-full-0 auto-y col gap-xxsmall align-x-left",
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl3 = { HeaderRow = 0, Subtitle = 0 }
    local createElement2 = React.createElement
    local var2 = View
    local tbl4 = {
        tag = "size-full-0 auto-y row align-y-center flex-x-between padding-right-xsmall",
        LayoutOrder = 1
    }

    local tbl5 = {
        TitleRow = React.createElement(View, {
            tag = "auto-xy row align-y-center gap-xxsmall",
            onActivated = if tbl1.onTitleActivated then tbl1.onTitleActivated else nil,
            LayoutOrder = 1
        }, {
            Title = tbl1.title
                and React.createElement(FoundationText, {
                    tag = "text-title-large auto-xy text-align-x-left content-emphasis",
                    Text = tbl1.title,
                    stateLayer = {
                        affordance = Enums.StateLayerAffordance.None
                    },
                    LayoutOrder = 1
                }),
            Chevron = tbl1.hasChevron
                and React.createElement(
                    Icon,
                    {
                        name = IconName.ChevronLargeRight,
                        size = IconSize.Small,
                        variant = IconVariant.Filled,
                        LayoutOrder = 2
                    }
                )
        }),
        TrailingIcon = tbl1.trailingIcon
            and tbl1.onTrailingIconActivated
            and React.createElement(IconButton, {
                icon = tbl1.trailingIcon,
                size = IconSize.Small,
                onActivated = tbl1.onTrailingIconActivated,
                LayoutOrder = 2,
                ref = tbl1.trailingIconRef
            })
    }
    tbl3.HeaderRow = createElement2(var2, tbl4, tbl5)

    tbl3.Subtitle = tbl1.subtitle
        and React.createElement(
            FoundationText,
            {
                tag = "text-body-medium auto-xy text-align-x-left content-default text-wrap",
                Text = tbl1.subtitle,
                LayoutOrder = 2
            }
        )
    return createElement(var1, tbl2, tbl3)
end

return UserListHeader
